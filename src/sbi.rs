#![allow(unused)]
use core::arch::asm;
use crate::{debug};
const SBI_SET_TIMER: usize = 0;
const SBI_CONSOLE_PUTCHAR: usize = 1;
const SBI_CONSOLE_GETCHAR: usize = 2;
const SBI_CLEAR_IPI: usize = 3;
const SBI_SEND_IPI: usize = 4;
const SBI_REMOTE_FENCE_I: usize = 5;
const SBI_REMOTE_SFENCE_VMA: usize = 6;
const SBI_REMOTE_SFENCE_VMA_ASID: usize = 7;
const SBI_SHUTDOWN: usize = 8;
const SBI_EXT_HSM :usize =0x48534D;


#[inline(always)]
fn sbi_call(sbi_type: usize, arg0: usize, arg1: usize, arg2: usize , arg3:usize) -> usize {
    let mut ret;
    unsafe {
        asm!(
            "ecall",
            inlateout("x10") arg0 => ret,
            in("x11") arg1,
            in("x12") arg2,
            in("x16") arg3,
            in("x17") sbi_type,
        );
    }
    ret
}

pub fn consele_putchar(c:usize){
    sbi_call(SBI_CONSOLE_PUTCHAR,c  ,0,0,0);
}
//system shutdown
pub fn shutdown() -> ! {
    sbi_call(SBI_SHUTDOWN, 0, 0, 0,0);
    panic!("It should shutdown!");
}
pub fn sbi_hsm_hart_start(hart_id:usize){
    let i= sbi_call(SBI_EXT_HSM, hart_id, 0x80200000, 64, 0x0);
    //debug!("sbi ret{}",i);
}