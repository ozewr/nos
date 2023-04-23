use riscv::register::sstatus;
use core::arch::asm;
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