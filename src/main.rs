#![no_std]
#![no_main]
#![feature(panic_info_message)]
mod sbi;
mod console;
mod lang_items;
use core::{arch::global_asm,};


global_asm!(include_str!("entry.s"));
#[no_mangle]
pub fn rust_main() -> ! {
    clear_bss();
    info!("hello world");
    error!("hello world");
    debug!("hello world ");
    print_info();
    panic!("shutdown");
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
fn print_info(){
    extern "C"{
        fn stext();
        fn etext();
        fn srodata();
        fn erodata();
        fn sdata();
        fn edata();
    }
   
    info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
    debug!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
    error!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
    
}