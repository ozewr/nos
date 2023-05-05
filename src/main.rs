#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![allow(unused)]
#![feature(alloc_error_handler)]
extern crate alloc;

//mod 
mod sbi;        mod console;    mod lang_items;
mod sync;       mod cpu;        mod utils;
mod riscv;      mod thread;     mod trap;
mod syscall;    mod batch;      mod kalloc;
mod memlayout;  mod vm;         mod page_alloc;
use core::{
    arch::global_asm,
};
use alloc::boxed::Box;
use crate::{
    riscv::r_tp,
    sbi::shutdown,
    thread::thread_start, utils::print_info, page_alloc::{FRAME_ALLOC, AllocerGuard}, vm::PhyPageNum
};

global_asm!(include_str!("entry.s"));
global_asm!(include_str!("link_app.s"));

#[no_mangle]
pub fn rust_main() -> ! {
   loop{}
}