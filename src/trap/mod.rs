use core::{arch::global_asm,str};
use crate::riscv::{intr_on, intr_off};
use crate::syscall::syscall;
use riscv::register::{stvec,scause,stval, sepc, sstatus, sscratch};
use riscv::register::{mtvec::TrapMode, scause::Trap};
use riscv::register::scause::{Exception, Interrupt};

use crate::batch::run_next_app;
use crate::{println, syscall};

use self::context::TrapContext;
use self::ktrap::time_intr;
pub mod context;
pub mod ktrap;
global_asm!(include_str!("trap.s"));
global_asm!(include_str!("kernelvec.s"));

pub fn ktrap_init(){
    extern "C"{
        fn kernelvec();
    }
    intr_on();
    unsafe {stvec::write(kernelvec as usize, TrapMode::Direct);}
    //ktrap::timerinit();
    println!("Set kernel trap ok");
}

#[no_mangle]
pub fn trap_handler(ctx:&mut TrapContext) -> () {
    let scause = scause::read();
    let stcval = stval::read();
    match scause.cause(){
        Trap::Exception(scause::Exception::UserEnvCall) => {
            ctx.sepc += 4;
            ctx.reg[10] = syscall(ctx.reg[17],[ctx.reg[10],ctx.reg[11],ctx.reg[12]]) as usize;
        }
        Trap::Exception(scause::Exception::StoreFault) => {
            println!("sorefault");
        }
        Trap::Exception(scause::Exception::IllegalInstruction) => {
            println!("illegalinstruction");
        }
        _=>{
            println!("not write trap{:?} {:#x}",scause.cause(),stcval);
            run_next_app()
        }
    }
}

#[no_mangle]
pub fn kernel_trap() -> (){
    intr_off();
    let sepc = sepc::read();
    let sstatus = sstatus::read();
    let scause = scause::read();
    let sscratch = sscratch::read();
    let stcval = stval::read();
    match scause.cause() {
        Trap::Exception(Exception::Breakpoint) => {
            ktrap::break_intr();
        }
        Trap::Interrupt(Interrupt::SupervisorTimer) => {
            ktrap::time_intr();
        }
        _=>{
            println!("not write trap{:?} {:#x}",scause.cause(),stcval);
        }
    }
}


pub fn trap_init(){
    extern "C" {
        fn __alltraps();
    }
    unsafe {
        stvec::write(__alltraps as usize, TrapMode::Direct);
    }
}