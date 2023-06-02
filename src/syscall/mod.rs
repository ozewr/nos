use crate::{filesystem::{inode::ROOT_INODE, fs::QUEUE_FRAMES}, info, page_alloc::FRAME_ALLOC, println};
//use crate::filesystem::
use self::{fs::{sys_write, sys_open, sys_close}, process::{sys_exec, sys_fork, sys_exit}};
use crate::open_file;
use crate::READONLY;
//use crate::filesystem::
mod fs;
mod process;
const SYSCALL_INITCODE:usize = 7;
const SYSCALL_OPEN: usize = 56;
const SYSCALL_CLOSE: usize = 57;
const SYSCALL_READ: usize = 63;
const SYSCALL_WRITE: usize = 64;
const SYSCALL_EXIT: usize = 93;
const SYSCALL_YIELD: usize = 124;
const SYSCALL_GET_TIME: usize = 169;
const SYSCALL_GETPID: usize = 172;
const SYSCALL_FORK: usize = 220;
const SYSCALL_EXEC: usize = 221;
const SYSCALL_WAITPID: usize = 260;
use crate::filesystem::BLOCK_DEVICE;

#[no_mangle]
pub fn syscall(syscall_id :usize ,arg:[usize;3]) -> isize {
    match syscall_id {
        SYSCALL_OPEN => {
            sys_open(arg[0] as *const u8 , arg[1] as usize)
        }
        SYSCALL_CLOSE => {
            sys_close(arg[0])
        }
        SYSCALL_READ => {
            todo!()
        }
        SYSCALL_YIELD => {
            todo!()
        }
        SYSCALL_GET_TIME => {
            todo!()
        }
        SYSCALL_GETPID => {
            todo!()
        }
        SYSCALL_FORK => {
            sys_fork()
        }
        SYSCALL_WAITPID => {
            todo!()
        }
        SYSCALL_WRITE => {
            sys_write(arg[0], arg[1] as *const u8, arg[2])
        }
        SYSCALL_EXIT => {
            sys_exit(arg[0] as i32)
        }
        SYSCALL_EXEC => {
            sys_exec(arg[0] as *const u8)
        }
        SYSCALL_INITCODE => {
            sys_exec(arg[0] as *const u8)
        }
        _ => {
            println!("syscall id is{}",syscall_id);
            panic!("not souppeted syscall");
        }
    }
}