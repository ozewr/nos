use crate::cpu::{Cpus, CPUS};
use crate::filesystem::block_device_test;
use crate::memlayout::{KERNEL_STACK_SIZE, TRAMPOLINE};
use crate::riscv::{intr_off, intr_on, r_tp, PGSZ};
use crate::syscall::syscall;
use crate::task::task::{TaskControlBlock, TrapFrame};
use crate::vm::PhyPageNum;
use core::{arch::global_asm, str};
use riscv::interrupt;
use riscv::register::scause::{Exception, Interrupt};
use riscv::register::{mtvec::TrapMode, scause::Trap};
use riscv::register::{scause, sepc, sscratch, sstatus, stval, stvec};

// #define SSTATUS_SPP (1L << 8)  // Previous mode, 1=Supervisor, 0=User
use crate::PGTBIT;
use crate::{info, kstack, println, syscall};
pub const SSTATUS_SPP: usize = 1 << 8; // Previous mode, 1=Supervisor, 0=User
pub const SSTATUS_SPIE: usize = 1 << 5; // Supervisor Previous Interrupt Enable
                                        // #define SSTATUS_SPIE (1L << 5) // Supervisor Previous Interrupt Enable
use self::ktrap::time_intr;
pub mod ktrap;
global_asm!(include_str!("kernelvec.s"));
global_asm!(include_str!("trampoline.s"));

pub fn ktrap_init() {
    extern "C" {
        fn kernelvec();
    }
    intr_on();
    unsafe {
        stvec::write(kernelvec as usize, TrapMode::Direct);
    }
    //ktrap::timerinit();
    println!("Set kernel trap ok");
}

#[no_mangle]
pub extern "C" fn usertarpret() {
    extern "C" {
        fn uservec();
        fn trampoline();
        fn userret();
    }
    intr_off();

    unsafe {
        stvec::write(
            TRAMPOLINE + (uservec as usize - trampoline as usize),
            stvec::TrapMode::Direct,
        );
    }
    let task = CPUS.my_proc().unwrap();
    let pid = task.pid();
    let trap_frame = task.get_trapframe();

    trap_frame.kernel_satp = riscv::register::satp::read().bits();
    trap_frame.kernel_sp = kstack!(pid) + KERNEL_STACK_SIZE;
    trap_frame.kernel_trap = usertrap as usize;
    trap_frame.kernel_hartid = r_tp();
    unsafe {
        sstatus::set_spp(sstatus::SPP::User);
        sstatus::set_spie();
    }

    sepc::write(trap_frame.epc);
    //let addr = unsafe { trap_frame as *const _ as usize };
    let satp = task.pagetable_root().as_satp();
    //println!("satp{:#x}",satp);
    let fn_0: usize = TRAMPOLINE + (userret as usize - trampoline as usize);
    unsafe {
        let fn_0: extern "C" fn(usize) -> ! = core::mem::transmute(fn_0);
        fn_0(satp)
    }
}
use crate::cow::copy_on_write;

#[no_mangle]
pub fn usertrap() {
    //panic!("init run here!!!");
    extern "C" {
        fn kernelvec();
    }
    if (sstatus::read().bits() & SSTATUS_SPP) != 0 {
        panic!("not from user");
    }

    unsafe {
        stvec::write(kernelvec as usize, TrapMode::Direct);
    }
    let task = CPUS.my_proc().unwrap();
    let trapframe = task.get_trapframe();
    trapframe.epc = sepc::read();
    match scause::read().cause() {
        Trap::Exception(scause::Exception::UserEnvCall) => {
            trapframe.epc = sepc::read();
            trapframe.epc += 4;
            let ret = syscall(trapframe.a7, [trapframe.a0, trapframe.a1, trapframe.a2]);
            trapframe.a0 = ret as usize;
        }
        Trap::Exception(scause::Exception::StorePageFault) => {
            panic!("store pagefault");
        }
        Trap::Exception(scause::Exception::LoadPageFault) => {
            let va = stval::read();
            copy_on_write(va, task);
            usertarpret();
        }
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            ktrap::time_intr();
            usertarpret();
        }
        _ => {
            println!(
                "not write trap{:?} {:#x}",
                scause::read().cause(),
                stval::read()
            );
            panic!("not write");
        }
    }
    usertarpret()
}
#[no_mangle]
pub fn kernel_trap() -> () {
    intr_off();
    let sepc = sepc::read();
    let sstatus = sstatus::read();
    let scause = scause::read();
    let sscratch = sscratch::read();
    let stcval = stval::read();
    
    let s = sstatus.spp();
    println!("{:?}",s);
    
    match scause.cause() {
        Trap::Exception(Exception::Breakpoint) => {
            ktrap::break_intr();
        }
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            ktrap::time_intr();
        }
        _ => {
            let pid = CPUS.my_proc().unwrap().pid();
            println!(
                "not write trap{:?} {:#x} pid is {}",
                scause.cause(),
                stcval,
                pid
            );
            panic!("error here")
        }
    }
}
