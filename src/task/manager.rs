use core::{u8, usize};
use core::ptr;
use alloc::boxed::Box;
use alloc::sync::Arc;
use alloc::vec::Vec;
use alloc::collections::VecDeque;
use crate::cpu::CPUS;
use crate::memlayout::{TRAMPOLINE, KERNEL_STACK_SIZE};
use crate::trap::usertarpret;
use crate::{sync::spin::Spin, vm::{PageTable, PhyPageNum}, riscv::PGSZ, memlayout::{PTE_R, PTE_W, PTE_X, PTE_U}};
use super::task::{TaskControlBlock, TrapFrame,INITCODE};
const MAX_TASKS :usize = 16;
use crate::kstack;
use crate::FRAME_ALLOC;
use lazy_static::*;
pub struct TaskManager{
    pub task_store:VecDeque<Arc<TaskControlBlock>>,
    pub pids:Vec<usize>,
    pub zombie_store:VecDeque<Arc<TaskControlBlock>>,
}

lazy_static!{
    pub static ref TASKMANGER:Spin<TaskManager> = Spin::new(TaskManager::new(),"task_manger");
}

impl TaskManager {
    pub fn new() -> Self{
        let mut pids  :Vec<usize> = Vec::new();
        for idx in (0..MAX_TASKS).rev() {
            pids.push(idx);
        } 
        Self { 
            task_store:VecDeque::new(), 
            pids,
            zombie_store:VecDeque::new(), 
        }
    }

    pub fn add_task(&mut self , tcb :Arc<TaskControlBlock>){
        unsafe {self.task_store.push_back(tcb)};
    }
    
    pub fn pop_front(&mut self) -> Option<Arc<TaskControlBlock>>{
        self.task_store.pop_front()
    }

    pub fn kill(&self,pid:usize){
        todo!() // realase mem of stack  
    }

    pub fn free_pid(&self,pid :usize){
        todo!()//   check and pop pid 
    }

    pub fn free_task(&mut self , tcb:Arc<TaskControlBlock>){
        self.zombie_store.push_back(tcb);
    }
    
    pub fn alloc_pid(&mut self) -> Option<usize> {
        unsafe {
            if let Some(pid) = self.pids.pop(){
                Some(pid)
            }else {
                None
            }
        }
    }
    pub fn deadlloc_pid(&mut self,pid:usize){
        
        unsafe{
            self.pids.push(pid);
        }
    }
}

pub fn init_zero_task(){
    let mut task = crate_init("initcode").unwrap();
    let trapframe = task.get_trapframe();
    trapframe.epc = 0;
    trapframe.sp = PGSZ;
    task.set_kstack();
    unsafe { TASKMANGER.lock().task_store.push_back(Arc::new(task)) };
}

pub fn crate_init(name:&str) -> Option<TaskControlBlock>{
    let init_task = TaskControlBlock::new("initcode");
    let pid = unsafe { TASKMANGER.lock().alloc_pid().unwrap() };
    if pid !=0 {
        panic!("not init")
    }
    init_task.set_pid(pid);
    init_task.inner_mut().context.ra = usertarpret as usize;
    init_task.inner_mut().context.sp = kstack!(0) + PGSZ;
    //set pagetable
    let pgtbl_ptr = set_init_pagetable(INITCODE, PGSZ);
    init_task.set_pagetable(pgtbl_ptr);
    let gurd = FRAME_ALLOC.page_alloc();
    init_task.new_set_trapframe(gurd);
    init_task.map_trap();
    Some(init_task)
}

pub fn set_init_pagetable(src:[u8;52],sz:usize) -> Box<PageTable>{
    let mut pagetable = PageTable::new();
    //init.set_pagetable(pagetable_ptr);
    if sz >PGSZ {
        panic!("initcode map more than PGSZ")
    }
    let gurd = FRAME_ALLOC.page_alloc();
    let pa = gurd.pages;
    pagetable.save_page(gurd);

    pagetable.mappages(
        0.into(), 
        (pa.0).into() , 
        PGSZ, 
        PTE_R|PTE_W|PTE_X|PTE_U
    );
    unsafe {ptr::copy_nonoverlapping(src.as_ptr(), pa.get_mut(), src.len());}
    Box::new(pagetable)
}

pub fn init(){
    init_zero_task();
}

pub fn runner(){
    unsafe {
        CPUS.my_cpu().task = TASKMANGER.lock().pop_front()
    }
    usertarpret()
}