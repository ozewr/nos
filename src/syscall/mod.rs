use crate::batch::run_next_app;

use self::fs::{sys_write, sys_exit};

mod fs;

const SYSCALL_WRITE: usize = 64;
const SYSCALL_EXIT: usize = 93;

pub fn syscall(syscall_id :usize ,arg:[usize;3]) -> isize {
    match syscall_id {
        SYSCALL_WRITE => {
            sys_write(arg[0], arg[1] as *const u8, arg[2])
        }
        SYSCALL_EXIT => {
            sys_exit(arg[0] as i32)
        }
        _ => {
            panic!("not souppeted syscall");
            //run_next_app()
        }
    }
}