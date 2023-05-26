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
use crate::memlayout::{PTE_U, PTE_R, PTE_X, TRAPFRAME, TRAMPOLINE, PTE_W};
use crate::riscv::PGSZ;
use crate::sync::UPSafeCell;
use crate::sync::spin::{Spin, SpinGuard};
use crate::{PageTable, info};
use crate::page_alloc::AllocerGuard;
use crate::vm::{PhyPageNum};
use crate::FRAME_ALLOC;
use lazy_static::*;
use crate::kstack;
use alloc::{sync::Arc};
use crate::filesystem::File;

use super::manager::TASKMANGER;
use super::parse_elf;
pub static INITCODE: [u8; 52] = [
    0x17, 0x05, 0x00, 0x00, 0x13, 0x05, 0x45, 0x02, 0x97, 0x05, 0x00, 0x00, 0x93, 0x85, 0x35, 0x02,
    0x93, 0x08, 0x70, 0x00, 0x73, 0x00, 0x00, 0x00, 0x93, 0x08, 0x20, 0x00, 0x73, 0x00, 0x00, 0x00,
    0xef, 0xf0, 0x9f, 0xff, 0x2f, 0x69, 0x6e, 0x69, 0x74, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00,
];
#[derive(Clone, Copy)]
pub enum State {
    Run = 0,
    Ready,
    Sleep,
    Zombie,
}

#[derive(Clone, Copy, Debug)]
#[repr(C)]
pub struct Context {
    pub ra: usize,
    pub sp: usize,

    // callee-saved
    pub s0: usize,
    pub s1: usize,
    pub s2: usize,
    pub s3: usize,
    pub s4: usize,
    pub s5: usize,
    pub s6: usize,
    pub s7: usize,
    pub s8: usize,
    pub s9: usize,
    pub s10: usize,
    pub s11: usize,
}

impl Context {
    pub const fn new() -> Self {
        Self {
            ra: 0,
            sp: 0,
            s0: 0,
            s1: 0,
            s2: 0,
            s3: 0,
            s4: 0,
            s5: 0,
            s6: 0,
            s7: 0,
            s8: 0,
            s9: 0,
            s10: 0,
            s11: 0,
        }
    }
    pub fn write_zero(&mut self) {
        self.ra = 0;
        self.sp = 0;
        self.s0 = 0;
        self.s1 = 0;
        self.s2 = 0;
        self.s3 = 0;
        self.s4 = 0;
        self.s5 = 0;
        self.s6 = 0;
        self.s7 = 0;
        self.s8 = 0;
        self.s9 = 0;
        self.s10 = 0;
        self.s11 = 0;
    }
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
              pub t2: usize,
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

impl TrapFrame {
    pub fn new() -> TrapFrame{
        Self {  
    /*   0 */ kernel_satp: 0, // kernel page table
    /*   8 */  kernel_sp: 0, // top of process's kernel stack
    /*  16 */  kernel_trap: 0, // usertrap()
    /*  24 */  epc: 0, // saved user program counter
    /*  32 */  kernel_hartid: 0, // saved kernel tp
    /*  40 */  ra: 0,
    /*  48 */  sp: 0,
    /*  56 */  gp: 0,
    /*  64 */  tp: 0,
    /*  72 */  t0: 0,
    /*  80 */  t1: 0,
    /*  88 */  t2: 0,
    /*  96 */  s0: 0,
    /* 104 */  s1: 0,
    /* 112 */  a0: 0,
    /* 120 */  a1: 0,
    /* 128 */  a2: 0,
    /* 136 */  a3: 0,
    /* 144 */  a4: 0,
    /* 152 */  a5: 0,
    /* 160 */  a6: 0,
    /* 168 */  a7: 0,
    /* 176 */  s2: 0,
    /* 184 */  s3: 0,
    /* 192 */  s4: 0,
    /* 200 */  s5: 0,
    /* 208 */  s6: 0,
    /* 216 */  s7: 0,
    /* 224 */  s8: 0,
    /* 264 */  t4: 0,
    /* 232 */  s9: 0,
    /* 280 */  t6: 0,
    /* 240 */  s10: 0,
    /* 248 */  s11: 0,
    /* 256 */  t3: 0,
    /* 272 */  t5: 0,
        }
    }
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
        //pagetable is same
        //let mut new_pagetable = PageTable::new();
        let mut new_pgtbl_ptr = Box::new(PageTable::new());
        new_pgtbl_ptr.root = self.pagetable_root();
        //pgtbl_ptr.root = 
        // same trapframe but kstack is not same
        let ppn = self.trapframe_usie();
        let new_trapframe:&mut TrapFrame = PhyPageNum(ppn).get_mut();
        //same name?
        let new_name = self.name();
        //state is runable 
        let new_state = State::Ready;
        //kstack is not same 
        let new_kstack = kstack!(new_pid);
        //same context 
        let new_context  = self.inner_mut().context.clone();
        //file is same ?
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
        let new_tcb = Arc::new(new_tcb);
        self.inner_mut().children.push(new_tcb.clone());
        new_tcb
    }

    pub fn exec(&self , elf_data:&[u8]){
        //find data and map
        let mut pagetable = parse_elf(elf_data);
        //map trap_frame 
        let gurd = FRAME_ALLOC.page_alloc();
        self.set_pagetable(Box::new(pagetable));
        self.new_set_trapframe(gurd);
        self.map_trap();
        //set this task to new task;
        //self.pagetable = pagetable;
        //set sepc
        self.set_epc(0x0);
        self.set_sp(PGSZ);
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
}


