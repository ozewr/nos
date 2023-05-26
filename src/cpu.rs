#![allow(unused)]
use core::arch::asm;
use core::option;
use core::{cell::UnsafeCell, ops::Drop};
use crate::sync::UPSafeCell;
use crate::{array, info, println};
use crate::riscv::{intr_get, intr_off, intr_on};
pub const NCPU:usize = 3;
use crate::task::task::TaskControlBlock;
pub static CPUS :Cpus = Cpus::new();
use alloc::sync::Arc;
use alloc::boxed::Box;

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
pub struct Cpu{
    pub noff:UnsafeCell<usize>,
    pub intena:bool,
    pub task : Option<Arc<TaskControlBlock>>,
    pub context: Option<Context>,
}
pub struct  Cpus(
    [UnsafeCell<Cpu>; NCPU]
);
unsafe impl Sync for Cpus{}

pub struct  IntrLock<'a>{
    cpu:&'a Cpu,
}

impl Cpu {
    const fn new() -> Self{
        Self{
            noff:UnsafeCell::new(0),
            intena:false,
            task:None,
            context:None,
        }
    }

    unsafe fn locked(&mut self, old:bool) -> IntrLock {
        intr_off();
        if *self.noff.get() == 0{
            self.intena = old;
        }
        *self.noff.get() += 1;
        IntrLock { cpu: self }
    }

    unsafe fn unlock(&self) {
        //assert!(!intr_get(), "unlock - interruptible");
        let noff = self.noff.get();
        assert!(!intr_get(), "unlock - interruptible");
        assert!(*noff >= 1, "unlock");
        // if(*noff >=1){
        //     *noff -=1 ;
        // }else{
        //     if *noff ==0 && self.intena {
        //         intr_on()
        //     }
        // }
        *noff -= 1;
        if *noff == 0 && self.intena {
            intr_on()
        }

    }
    // pub fn task_ref(&self) -> Arc<TaskControlBlock>{
    //     self.task.unwrap().as_ref()
    // }
}


impl Cpus {
    const fn new() -> Self{
        Self(array![UnsafeCell::new(Cpu::new()); NCPU])
    }
    #[inline]
    pub unsafe fn cpu_id() -> usize {
        let id;
        asm!("mv {0}, tp", out(reg) id);
        id
    }
    pub unsafe fn my_cpu(&self) -> &mut Cpu{
        let id = Self::cpu_id();
        &mut *self.0[id].get()
    }

    pub fn my_proc(&self) -> Option<&Arc<TaskControlBlock>>{
        let _intr_lock = self.intr_lock();
        unsafe{
            let c = self.my_cpu();
            (*c).task.as_ref()
        }
    }
    pub fn intr_lock(&self) -> IntrLock {
        let old = intr_get();
        unsafe{
            self.my_cpu().locked(old)
        }
    }
}

impl<'a> Drop for IntrLock<'a> {
    fn drop(&mut self) {
        unsafe {
            self.cpu.unlock();
        }
    }
}