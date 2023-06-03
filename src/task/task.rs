#![allow(unused)]
use core::cell::{UnsafeCell, RefMut};
use core::future::Ready;
use core::ptr::replace;
use core::{usize, task, u8};

use alloc::boxed::Box;
use alloc::string::String;
use alloc::sync::{self, Weak};
use alloc::vec::{Vec, self};
use riscv::addr::Page;
use crate::memlayout::{PTE_U, PTE_R, PTE_X, TRAPFRAME, TRAMPOLINE, PTE_W, KERNEL_STACK_SIZE, USERSTACK_TOP, USERSTACK};
use crate::riscv::PGSZ;
use crate::sync::UPSafeCell;
use crate::sync::spin::{Spin, SpinGuard};
use crate::task::{map_user_stack, map_user_stack_fork};
use crate::trap::usertarpret;
use crate::{PageTable, info, print, println};
use crate::page_alloc::AllocerGuard;
use crate::vm::{PhyPageNum};
use crate::FRAME_ALLOC;
use lazy_static::*;
use crate::kstack;
use alloc::{sync::Arc};
use crate::filesystem::File;
use crate::cpu::{Context, CPUS};
use super::manager::TASKMANGER;
use super::parse_elf;
pub static INITCODE: [u8; 52] = [
    0x17, 0x05, 0x00, 0x00, 0x13, 0x05, 0x45, 0x02, 0x97, 0x05, 0x00, 0x00, 0x93, 0x85, 0x35, 0x02,
    0x93, 0x08, 0x70, 0x00, 0x73, 0x00, 0x00, 0x00, 0x93, 0x08, 0x20, 0x00, 0x73, 0x00, 0x00, 0x00,
    0xef, 0xf0, 0x9f, 0xff, 0x2f, 0x69, 0x6e, 0x69, 0x74, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00,
];
#[derive(Clone, Copy)]
#[derive(PartialEq, Eq)]
pub enum State {
    Run = 0,
    Ready,
    Sleep,
    Zombie,
}


#[derive(Clone, Copy, Default)] 
#[repr(C)]
pub struct TrapFrame {
    /*   0 */ pub kernel_satp: usize, // kernel page table
    /*   8 */ pub kernel_sp: usize, // top of process's kernel stack
    /*  16 */ pub kernel_trap: usize, // usertrap()
    /*  24 */ pub epc: usize, // saved user program counter
    /*  32 */ pub kernel_hartid: usize, // saved kernel tp
    /*  40 */ pub ra: usize,
    /*  48 */ pub sp: usize,
    /*  56 */ pub gp: usize,
    /*  64 */ pub tp: usize,
    /*  72 */ pub t0: usize,
    /*  80 */ pub t1: usize,
    /*  88 */ pub t2: usize,
    /*  96 */ pub s0: usize,
    /* 104 */ pub s1: usize,
    /* 112 */ pub a0: usize,
    /* 120 */ pub a1: usize,
    /* 128 */ pub a2: usize,
    /* 136 */ pub a3: usize,
    /* 144 */ pub a4: usize,
    /* 152 */ pub a5: usize,
    /* 160 */ pub a6: usize,
    /* 168 */ pub a7: usize,
    /* 176 */ pub s2: usize,
    /* 184 */ pub s3: usize,
    /* 192 */ pub s4: usize,
    /* 200 */ pub s5: usize,
    /* 208 */ pub s6: usize,
    /* 216 */ pub s7: usize,
    /* 224 */ pub s8: usize,
    /* 232 */ pub s9: usize,
    /* 240 */ pub s10: usize,
    /* 248 */ pub s11: usize,
    /* 256 */ pub t3: usize,
    /* 264 */ pub t4: usize,
    /* 272 */ pub t5: usize,
    /* 280 */ pub t6: usize,
}
pub struct TaskControlBlock{
    pub out_data: Spin<TcbOut>,
    pub inner: UPSafeCell<TcbInner>,
}

pub struct TcbOut{
    pub state: State,
    pub chan: usize,
    pub killed: usize,
    pub xstate: i32,
    pub pid: Option<usize>,
}
pub struct TcbInner{
    pub kstack: usize,
    pub name: String,
    pub pagetable: Option<Box<PageTable>>,
    pub trapframe: Option<&'static mut TrapFrame>,
    pub files:Vec<Option<Arc<dyn File + Send + Sync>>>,
    pub parent:Option<Weak<TaskControlBlock>>,
    pub children:Vec<Arc<TaskControlBlock>>,
    pub context: Context,
    pub parent_root:usize,
}
impl TcbInner {
    pub fn new() -> Self {
        Self{
            kstack: 0,
            name: String::new(),
            pagetable: None,
            trapframe: None,
            files: Vec::new(),
            parent: None,
            children: Vec::new(),
            context: Context::new(),
            parent_root: 0,
        }
    }
    pub fn set_pagetable(&mut self , pagetable_ptr:Box<PageTable> ){
        self.pagetable.replace(pagetable_ptr);
    }

    pub fn pagetable(&mut self) -> &mut Box<PageTable>{
        if let Some(ptr) = &mut self.pagetable{
            ptr
        }else {
            panic!("no pagetbale")
        }
    }
    pub fn set_fork_tfm(&mut self,tfm:&'static mut TrapFrame){
        self.trapframe = Some(tfm);
    }

    pub fn pagetable_root(&mut self) -> PhyPageNum {
        self.pagetable().root
    }
    //mut use after set_pagetable;
    pub fn new_set_trapframe(&mut self,trapframe: AllocerGuard){
        let pa = trapframe.pages;
        self.pagetable().save_page(trapframe);
        let trapframe:&mut TrapFrame = pa.get_mut();
        self.trapframe = Some(trapframe)
    }

    pub fn trapframe_usize(&mut self) -> Option<usize> {
        
        let addr = unsafe {
            *self.trapframe.as_mut().unwrap() as *const _ as usize
        };
        Some(addr)
    }

    pub fn set_new_file(&mut self,files: Vec<Option<Arc<dyn File + Send + Sync>>>){
        for fd in files.iter() {
            if let Some(file) = fd {
                self.files.push(Some(file.clone()));
            }else {
                self.files.push(None);
            }
        }
    }

    pub fn name(&mut self) -> String{
        self.name.clone()
    }

    // mut use after set_trapframe
    pub fn map_trap(&mut self){
        extern "C"{
            fn trampoline();
        }
        self.pagetable().mappages(
            TRAMPOLINE.into(), 
            (trampoline as usize).into(), 
            PGSZ, 
            PTE_R|PTE_X
        );

        let pa = self.trapframe_usize().unwrap();
        self.pagetable().mappages(
            TRAPFRAME.into()
            , pa.into(), 
            PGSZ, 
            PTE_R|PTE_W|PTE_X
        );
    }   
}

impl TcbOut {
    pub fn new() -> Self{
        Self { 
            state: State::Ready, 
            chan: 0, 
            killed: 0, 
            xstate: 0, 
            pid: None 
        }
    }
    pub fn is_zombie(&self) -> bool{
        if self.state == State::Zombie {
            true
        }else {
            false
        }
    }
    pub fn state(&self) -> State {
        self.state
    }
    pub fn set_state(&mut self, state:State){
        self.state = state;
    }
    pub fn set_pid(&mut self,pid: usize){
        self.pid = Some(pid);
    }
    pub fn pid(&self) -> Option<usize> {
        if let Some(i) = self.pid{
            Some(i)
        }else {
            None
        }
    }
}


impl TaskControlBlock {
    pub fn new(name:&'static str) -> Self{    
        Self{
            inner: unsafe { UPSafeCell::new(TcbInner::new()) },
            out_data: Spin::new(TcbOut::new(),name),
        }
    }

    pub fn set_pid(&self,pid:usize){
        unsafe { self.out_data.lock().set_pid(pid) };
    }
    pub fn pid(&self) -> usize {
        unsafe { self.out_data.lock().pid().unwrap() }
    }

    pub fn set_kstack(&self){
        self.inner_mut().kstack = kstack!(self.pid());
    }   

    pub fn inner_mut(&self) -> RefMut<'_,TcbInner>{
        self.inner.exclusive_access()
    }

    pub fn get_trapframe(&self) -> &mut TrapFrame{
        //let a = self.inner_mut().trapframe.as_mut().unwrap();
        let ppn  = unsafe {
            (*self.inner_mut().trapframe.as_mut().unwrap()) as *const _ as usize
        }; 
        PhyPageNum(ppn).get_mut()
    }

    pub fn set_pagetable(&self, pagetable_ptr:Box<PageTable>){
        self.inner_mut().set_pagetable(pagetable_ptr);
    }
    pub fn map_trap(&self){
        self.inner_mut().map_trap();
    }

    pub fn pagetable_root(&self) -> PhyPageNum {
        self.inner_mut().pagetable_root()
    }
    pub fn trapframe_usie(&self) -> usize{
        self.inner_mut().trapframe_usize().unwrap()
    }

    pub fn new_set_trapframe(&self,gurd:AllocerGuard){
        self.inner_mut().new_set_trapframe(gurd);
    }

    pub fn set_fork_tfm(&self,tfm:&'static mut TrapFrame ){
        self.inner_mut().set_fork_tfm(tfm);
    }
    pub fn name(&self) -> String {
        self.inner_mut().name()
    }
    pub fn set_state(&self,state:State){
        unsafe { self.out_data.lock().set_state(state) };
    }
    pub fn set_new_file(&self,files:Vec<Option<Arc<dyn File + Send + Sync>>>){
        self.inner_mut().set_new_file(files);
    }

    // pub fn pagetable_mut(&self) -> &mut Box<PageTable>{
    //     //self.inner_mut().pagetable()
    //     self.inner_mut().pagetable()
    // }
    pub fn fork_tcb(
        new_pgtbl_ptr:Box<PageTable>,
        new_pid: usize,
        new_trapframe: &'static mut TrapFrame,
        new_name: String,
        new_state: State,
        new_file: Vec<Option<Arc<dyn File + Send + Sync>>>,
        new_context:Context
    ) -> Self{
        let static_name = Box::leak(new_name.into_boxed_str());
        let new_tcb = Self::new(static_name);
        new_tcb.set_pagetable(new_pgtbl_ptr);
        new_tcb.set_pid(new_pid);
        new_tcb.set_kstack();
        new_tcb.set_fork_tfm(new_trapframe);
        new_tcb.set_state(new_state);
        new_tcb.set_new_file(new_file);
        new_tcb.inner_mut().context = new_context;
        new_tcb
    }

    pub fn fork(self: &Arc<TaskControlBlock>) -> Arc<TaskControlBlock>{
        let new_pid = unsafe {TASKMANGER.lock().alloc_pid().unwrap()};
        //pagetable is not same but pagetable's inner is same 
        let mut new_pgtbl_ptr = Box::new(fork_cow(self.inner_mut().pagetable()));
        //find new trapframe
        let new_trapframe:&mut TrapFrame = PhyPageNum(new_pgtbl_ptr.walk_addr(TRAPFRAME).unwrap()).get_mut();
        let new_name = self.name();
        //state is runable 
        let new_state = State::Ready;
        //kstack is not same 
        let new_kstack = kstack!(new_pid);
        //same context 
        let mut new_context  = self.inner_mut().context.clone();
        //FIX : new_context.ra = forkret();\n
        new_context.ra = usertarpret as usize;
        new_context.sp = kstack!(new_pid)+KERNEL_STACK_SIZE;
        //new_context.sp = kstack!(new_pid)+PGSZ; 
        //file is same 
        let mut new_files:Vec<Option<Arc<dyn File + Send + Sync>>> = Vec::new();
        for fd in self.inner_mut().files.iter(){
            if let Some(file) = fd {
                new_files.push(Some(file.clone()));
            }else {
                new_files.push(None);
            }
        }
        // chan,xstate,killed ,not fork
        let new_tcb = TaskControlBlock::fork_tcb(
            new_pgtbl_ptr, 
            new_pid, 
            new_trapframe, 
            new_name, 
            new_state, 
            new_files,
            new_context,
        );
        new_tcb.inner_mut().parent = Some(Arc::downgrade(self));
        new_tcb.inner_mut().parent_root= self.inner_mut().pagetable().root.0;
        let new_tcb = Arc::new(new_tcb);
        self.inner_mut().children.push(new_tcb.clone( ));
        new_tcb
    }


    pub fn exec(&self , elf_data:&[u8]){
        //find data and map
        let mut elf:(PageTable,usize) = parse_elf(elf_data);
        //map trap_frame 
        let gurd = FRAME_ALLOC.page_alloc();
        self.set_pagetable(Box::new(elf.0));
        self.new_set_trapframe(gurd);
        self.map_trap();
        //set this task to new task;
        self.set_epc(elf.1);
        self.set_sp(USERSTACK_TOP);
    }

    pub fn umap_task(){
        todo!()
    }
    //realy change trapframe?
    pub fn set_epc(&self,epc :usize){
        self.get_trapframe().epc = epc;
    }

    pub fn set_sp(&self,sp :usize){
        self.get_trapframe().sp = sp;
    }

    pub fn alloc_fd(&self) -> usize{
        unsafe{
        if let Some(fd) = (0..self.inner_mut().files.len()).find(|fd| self.inner_mut().files[*fd].is_none()){
            fd
        }else {
            self.inner_mut().files.push(None);
            self.inner_mut().files.len()-1
        }}
    }
    pub fn yielding(&self){
        let mut lock = unsafe { self.out_data.lock() };
        lock.state = State::Ready;
        let mut inner = self.inner_mut();
        let ctx = &mut inner.context as *mut Context;
        drop(lock);
        drop(inner);
        unsafe{
            CPUS.my_cpu().sched(ctx);
        }
    }
}

use crate::cow::{copy_pagetable,map_stack,map_trapframe,map_trampoline};

pub fn fork_cow(pagetable_old :&mut Box<PageTable>) -> PageTable{
    let mut pagetable_new = PageTable::new();
    copy_pagetable(&mut pagetable_new,pagetable_old);
    map_stack(&mut pagetable_new,pagetable_old);
    map_trapframe(&mut pagetable_new,pagetable_old);
    map_trampoline(&mut pagetable_new);

    pagetable_new
}
