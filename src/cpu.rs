
#![allow(unused)]
use core::arch::asm;
use core::{cell::UnsafeCell, ops::Drop};
use crate::{array, info};
use crate::riscv::{intr_get, intr_off, intr_on};
pub const NCPU:usize = 3;

pub static CPUS :Cpus = Cpus::new();
pub struct Cpu{
    pub noff:UnsafeCell<usize>,
    pub intena:bool,
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