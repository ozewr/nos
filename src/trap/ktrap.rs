use core::{arch::global_asm,str};
use crate::cpu::CPUS;
use crate::riscv::{intr_on, intr_off, w_sie, SIE_STIE, intr_get};
use crate::sbi::set_timer;
use crate::syscall::syscall;
use crate::println;
use riscv::register::{stvec,scause,stval, sepc, sstatus, sscratch, time};
use riscv::register::{mtvec::TrapMode, scause::Trap};
use riscv::register::scause::Exception;
use riscv::register::sie;
use crate::sync::spin::Spin;

const TIMEBASE:usize = 100000 ;
static CLOCK_CNT :Clock = Clock{
    count:Spin::new(0,"clock")
};
//breakpoint
pub fn break_intr(){
    let sepc = sepc::read();
    let stcval = stval::read();
    println!("kernel trap :
        sepc = {:#x} scause.cause = breakpoint 
        stcval = {:#x}",sepc,stcval);
    sepc::write(sepc+2);
    return;
}


//clock

pub fn timerinit(){
    //w_sie(SIE_STIE);
    unsafe{sie::set_stimer();}
    CLOCK_CNT.restart_clk();
    clock_set_next_time();
}

pub fn time_intr(){
    //println!("run here");
    clock_set_next_time();
    CLOCK_CNT.clk_run();
    if CLOCK_CNT.get_cnt() == 5 {
        //println!("5 ticks");
        CLOCK_CNT.restart_clk();
        let proc = CPUS.my_proc().unwrap();
        proc.yielding();
    }
}

pub fn get_cycle() -> usize{
    time::read()
}

pub fn clock_set_next_time(){
    set_timer(get_cycle()+TIMEBASE);
}
pub struct Clock{
    count:Spin<usize>,
}

impl Clock {
    pub fn restart_clk(&self){
        unsafe {
            *(self.count.lock().spin().get_mut()) = 0; 
        }
    }

    pub fn clk_run(&self){
        unsafe {
            *(self.count.lock().spin().get_mut()) += 1; 
        }
    }
    pub fn get_cnt(&self) -> usize{
        unsafe {
            *(self.count.lock().spin().get_mut()) 
        }
    }
}
