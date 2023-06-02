use core::task;

use alloc::sync::Arc;
use riscv::register::time;

use crate::{cpu::CPUS, filesystem::{inode::{open_file, READONLY}, File}, trap::usertarpret, info, task::{manager::{TaskManager, TASKMANGER}, exit, scheduler}, print};
pub const CLOCK_FREQ: usize = 12500000;
const MSEC_PER_SEC: usize = 1000;


pub fn sys_yield() -> isize{
    let proc = CPUS.my_proc().unwrap();
    proc.yielding();
    0
}

pub fn sys_exit(exit_code:i32) -> ! {
    exit(exit_code);
    panic!()
}
pub fn sys_get_time() -> usize{
    time::read() / (CLOCK_FREQ /MSEC_PER_SEC)
}

pub fn get_pid() -> isize{
    CPUS.my_proc().unwrap().pid() as isize
}
pub fn sys_fork() -> isize{
    let current_task  = CPUS.my_proc().unwrap();
    let new_task = current_task.fork();
    let new_pid = new_task.pid();
    let new_trapframe = new_task.get_trapframe();
    new_trapframe.a0 = 0;
    unsafe { TASKMANGER.lock().add_task(new_task)};
    new_pid as isize 
}
pub fn sys_exec(path :*const u8) -> isize {
    let task = CPUS.my_proc().unwrap();
    let path = task.inner_mut().pagetable().translated_str(path);
    if let Some(app_inode) = open_file(path.as_str(), READONLY){
        let all_data = app_inode.read_all();
        task.exec(all_data.as_slice());
        0
    }else {
        panic!("run here")
        //-1
    }
}

pub fn sys_waitpid(pid:isize,exit_code_ptr:*mut i32) -> isize {
    let task = CPUS.my_proc().unwrap();
    let mut inner = task.inner_mut();
    if !inner
        .children
        .iter()
        .any(|p| pid == -1 || pid as usize == p.pid())
    {
        return -1;
    }
    let pair = inner.children.iter().enumerate().find(|(_,p)|{
        unsafe { p.out_data.lock() }.is_zombie() && (pid == -1 ||pid as usize == p.pid())
    });
    if let Some((idx,_)) = pair{
        let child = inner.children.remove(idx);
        assert_eq!(Arc::strong_count(&child),1);
        let found_pid = child.pid() as isize;
        let exit_code = unsafe { child.out_data.lock() }.xstate;
        *(inner.pagetable().tasnlate_refmut(exit_code_ptr)) = exit_code;
        found_pid
    }else {
        -2
    }


}