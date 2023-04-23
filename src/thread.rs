#![allow(unused)]
use crate::{sbi::sbi_hsm_hart_start, riscv::r_tp,cpu::NCPU,debug};
#[no_mangle]
pub fn thread_start(){
    let tp = r_tp();
    let i:usize = 0;
    for i in i..NCPU {
        if i != tp {
            //debug!("i {}",i);
            sbi_hsm_hart_start(i);
        }
    }
}