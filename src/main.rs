#![no_std]
#![no_main]
#![feature(panic_info_message)]
#![allow(unused)]
#![feature(alloc_error_handler)]
extern crate alloc;
extern crate xmas_elf;
//mod 
mod sbi;        mod console;    mod lang_items;
mod sync;       mod cpu;        mod utils;
mod riscv;      mod thread;     mod trap;
mod syscall;    mod kalloc;
mod memlayout;  mod vm;         mod page_alloc;
mod filesystem; mod config;     mod cow;
mod task;
use core::{
    arch::global_asm,
    arch::asm, usize, cell::UnsafeCell,
};
use alloc::boxed::Box;
use filesystem::BLOCK_DEVICE;
//use easy_fs::block_cache::{self, block_cache};
use ::riscv::asm;
use task::scheduler;
use trap::usertarpret;
use vm::PageTable;
use crate::{
    riscv::{r_tp, intr_get, intr_on},
    sbi::shutdown,
    thread::thread_start, utils::print_info, page_alloc::{FRAME_ALLOC, AllocerGuard, FarmeAllocer}, 
    vm::PhyPageNum,
    sync::spin::Spin,
    vm::PGTBIT, trap::ktrap, filesystem::{inode::ROOT_INODE, block_device_test, fs}, task::parse_elf,
};

global_asm!(include_str!("entry.s"));


#[no_mangle]
pub fn rust_main() -> ! {
    utils::clear_bss();
    thread_start();

    let cpuid :usize =r_tp();
    let mut pagetable :PageTable;
    if cpuid == 0 {
        print_info();
        println!("hart {} is botting",cpuid);
        trap::ktrap_init();//trap init
        ktrap::timerinit();
        
        kalloc::init_heap();//kernel heap init
        
        //page alloc init and kvm install
        page_alloc::FRAME_ALLOC.allocer_init();
        pagetable = PageTable::new();
        vm::kvmmake(&mut pagetable);
        PGTBIT.set_bit(pagetable.as_satp());
        PGTBIT.set_root(pagetable.root.0);
        pgtbl_install(cpuid);
        // task::manager::init();
        // task::runner::run_task();
        let last_page:usize = PGTBIT.root_addr();
        fs_ls();
        task::manager::init();
        //task::manager::runner();
    }else {
        println!("hart {} is botting",cpuid);
        trap::ktrap_init();
        pgtbl_install(cpuid);
    }
    scheduler();
    panic!("error can't run here");
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

use crate::filesystem::inode::open_file;
use crate::filesystem::inode::READONLY;
fn fs_ls(){
    for s in ROOT_INODE.ls(){
        println!("ls : {}",s);
    }
    let mut read_buffer = [0u8; 512];
    let block_device = BLOCK_DEVICE.clone();
}

