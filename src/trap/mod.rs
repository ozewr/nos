use core::{arch::global_asm,str};
use crate::syscall::syscall;
use riscv::register::{stvec,scause,stval};
use riscv::register::{mtvec::TrapMode, scause::Trap};

use crate::batch::run_next_app;
use crate::{println, syscall};

use self::context::TrapContext;
pub mod context;

global_asm!(include_str!("trap.s"));

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

pub fn trap_init(){
    extern "C" {
        fn __alltraps();
    }
    unsafe {
        stvec::write(__alltraps as usize, TrapMode::Direct);
    }
}