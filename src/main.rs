#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![allow(unused)]


mod sbi;
mod console;
mod lang_items;
use core::{arch::global_asm,};

use crate::riscv::r_tp;
use crate::sbi::shutdown;
use crate::thread::thread_start;
mod sync;
mod cpu;
mod utils;
mod riscv;
mod thread;
mod trap;
mod syscall;
mod batch;
global_asm!(include_str!("entry.s"));
global_asm!(include_str!("link_app.s"));

#[no_mangle]
pub fn rust_main() -> ! {
    clear_bss();
    thread_start();
    let cpuid :usize =r_tp();
    if cpuid == 0 {
        println!("hart {} is botting",cpuid);
        print_info();
        //loop{}
        panic!("ok?");
        //shutdown();
    }else {
        println!("hrat {} is botting",cpuid);
        loop{};
    }
}


fn clear_bss(){
    extern "C"{
        fn sbss();
        fn ebss();
    }

    (
        sbss as usize..ebss as usize).for_each(|a|{
            unsafe{
                (a as *mut u8).write_volatile(0)
            }
        }
    )
}

#[allow(unused)]
fn print_info(){
    extern "C"{
        fn stext();
        fn etext();
        fn srodata();
        fn erodata();
        fn sdata();
        fn edata();
        fn sbss();
    }
   
    info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
    debug!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
    error!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);  
    info!(".sbss : {:#x}" ,sbss as usize);
}