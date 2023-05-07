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
    arch::asm, usize, cell::UnsafeCell,
};
use alloc::boxed::Box;
use ::riscv::asm;
use vm::PageTable;
use crate::{
    riscv::{r_tp, intr_get, intr_on},
    sbi::shutdown,
    thread::thread_start, utils::print_info, page_alloc::{FRAME_ALLOC, AllocerGuard}, 
    vm::PhyPageNum,
    sync::spin::Spin,
    vm::PGTBIT, trap::ktrap,
};

global_asm!(include_str!("entry.s"));
global_asm!(include_str!("link_app.s"));

#[no_mangle]
pub fn rust_main() -> ! {
    utils::clear_bss();
    thread_start();
    intr_on();
    let cpuid :usize =r_tp();
    let mut pagetable :PageTable;
    if cpuid == 0 {
        println!("hart {} is botting",cpuid);
        trap::ktrap_init();//trap init
        ktrap::timerinit();
        //unsafe{asm!("ebreak");}
        if (intr_get() != false){
            info!("enable")
        }
        kalloc::init_heap();//kernel heap init
        
        //page alloc init and kvm install
        page_alloc::FRAME_ALLOC.allocer_init();
        pagetable = PageTable::new();
        vm::kvmmake(&mut pagetable);
        PGTBIT.set_bit(pagetable.as_satp());
        pgtbl_install(cpuid);
        if (intr_get() != false){
            print!("enable")
        }
        
    }else {
        println!("hart {} is botting",cpuid);
        trap::ktrap_init();
        pgtbl_install(cpuid);
    }
    intr_on();
    loop {}
}

fn pgtbl_install(cpuid :usize){
    loop {
        match PGTBIT.get_bit() {
            Some(i) => {
                vm::kvminithart(i);
                break;
            }
            None =>continue,
        }
    }
    println!("---hart {} pgtbl install ok---",cpuid);
}


