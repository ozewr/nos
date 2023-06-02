#![allow(unused)]
use core::arch::asm;
use core::{option, task};
use core::{cell::UnsafeCell, ops::Drop};
use crate::sync::UPSafeCell;
use crate::sync::spin::SpinGuard;
use crate::task::{switch, __switch};
use crate::{array, info, println};
use crate::riscv::{intr_get, intr_off, intr_on};
pub const NCPU:usize = 3;
use crate::task::task::{TaskControlBlock, TcbOut};
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

pub struct Cpu{
    pub noff:UnsafeCell<usize>,
    pub intena:bool,
    //pub task_lock:Option<SpinGuard<'static,TcbOut>>,
    pub task : Option<Arc<TaskControlBlock>>,
    pub context: Context,
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
            //task_lock:None,
            task:None,
            context:Context::new(),
        }
    }

    // unsafe fn get_task(&mut self) -> Option<Arc<TaskControlBlock>>{
    //     let task = self.task;
    //     self.task = None;
    //     task
    // }

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
    pub unsafe fn sched<'a>(&mut self, ctx :*mut Context){
        let ina = self.intena;
        __switch(ctx, &self.context);
        self.intena = ina;
    }
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

    pub fn take_task(&self) -> Option<Arc<TaskControlBlock>>{
        let _intr_lock = self.intr_lock();
        let c = unsafe { self.my_cpu() };
        c.task.take()
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