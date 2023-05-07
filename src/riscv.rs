use riscv::register::sstatus;
use core::{arch::asm, usize, };

pub const PGSZ:usize = 4096;

pub const SIE_SEIE:usize = 1<<9;//exrernal
pub const SIE_STIE:usize = 1<<5;//timer
pub const SIE_SSIE:usize = 1<<1;//software

#[inline]
pub fn intr_get() -> bool {
    sstatus::read().sie()
}

#[inline]
pub fn intr_off() {
    unsafe {
        sstatus::clear_sie();
    }
}

#[inline]
pub fn intr_on() {
    unsafe {
        sstatus::set_sie();
    }
}
#[inline]
pub fn r_tp() -> usize{
    unsafe{
        let id;
        asm!("mv {0}, tp", out(reg) id);
        id
    }
}

#[inline]
pub fn sfence_vma(){
    unsafe {asm!("sfence.vma zero,zero");}
}
#[inline]
pub fn w_sie(x:usize){
    unsafe {
        asm!(
            "csrw sie ,{0}",
            in(reg) x
        );
    }
}
