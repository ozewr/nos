#![allow(unused)]
use core::cell::UnsafeCell;
use core::{str,ptr};
use core::{
    sync::atomic::{ Ordering},
};
use core::sync::atomic::{self, AtomicPtr};
use crate::info;
use crate::riscv::{intr_get, intr_off, intr_on};
use crate::cpu::{IntrLock, CPUS, Cpu};
use core::ops::{Deref, DerefMut, Drop};


pub struct Spin <T>{
    locked:AtomicPtr<Cpu>, // locked
    pub data:UnsafeCell<T>, //actul data 
    name:&'static str,
}

//
pub struct SpinGuard<'a ,T: 'a>{
    spin:&'a Spin<T>,
    _intr_lock:IntrLock<'a>,
}

impl<T> Spin<T> {
    pub const fn new(value: T , name: &'static str) -> Self {
        Spin{
            locked:AtomicPtr::new(ptr::null_mut()),
            data:UnsafeCell::new(value),
            name,
        }
    }

    pub fn holding(&self) -> bool {
        unsafe {self.locked.load(atomic::Ordering::Relaxed) == CPUS.my_cpu()}
    }
    pub unsafe fn lock(&self)->SpinGuard<'_ ,T>{
        intr_off();
        // if self.name == "initcode"{
        //     info!("spin 41 lock");
        // }
        let _intr_lock = CPUS.intr_lock();
        //intr_on();
        assert!(!self.holding(), "acquire {}", self.name);
        loop {
            if !self.locked.compare_exchange(ptr::null_mut(), 
                CPUS.my_cpu(),
                atomic::Ordering::Acquire,
                atomic::Ordering::Relaxed
            ).is_err()
            {
                break SpinGuard{
                    spin:self,
                    _intr_lock,
                };
            }
            core::hint::spin_loop()
        }

    }

    pub fn unlock(guard: SpinGuard<'_, T>) -> &'_ Spin<T> {
        guard.spin()
    }

    pub unsafe fn get_mut(&self) -> &mut T {
        &mut *self.data.get()
    }
}

unsafe impl<T> Sync for Spin<T>{}
unsafe impl<T> Send for Spin<T>{}

impl<'a, T: 'a> SpinGuard<'a, T> {
    // Returns a reference to the original 'Mutex' object.
    pub fn spin(&self) -> &'a Spin<T> {
        self.spin
    }

    pub fn holding(&self) -> bool {
        assert!(!intr_get(), "interrupts enabled");
        self.spin.holding() 
    }
}

impl<'a, T: 'a> Drop for SpinGuard<'a, T> {
    fn drop(&mut self) {
        assert!(self.holding(), "release {}", self.spin.name);
        // if self.spin.name == "initcode"{
        //     info!("spin 88 unlock");
        // }
        self.spin.locked.store(ptr::null_mut(),Ordering::Release);
    }
}

impl<'a, T: 'a> Deref for SpinGuard<'a, T> {
    type Target = T;
    fn deref(&self) -> &Self::Target {
        unsafe { &*self.spin.data.get() }
    }
}

impl<'a, T: 'a> DerefMut for SpinGuard<'a, T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        unsafe { &mut *self.spin.data.get() }
    }
}

