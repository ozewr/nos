use crate::{filesystem::{inode::ROOT_INODE, fs::QUEUE_FRAMES}, info, page_alloc::FRAME_ALLOC, println};
//use crate::filesystem::
use self::{fs::{sys_write, sys_exit}, process::{sys_exec, sys_init}};
use crate::open_file;
use crate::READONLY;
//use crate::filesystem::
mod fs;
mod process;
const SYSCALL_WRITE: usize = 64;
const SYSCALL_EXIT: usize = 93;
const SYSCALL_EXEC: usize = 7;
const SYSCALL_INIT: usize = 0;
use crate::filesystem::BLOCK_DEVICE;
#[no_mangle]
pub fn syscall(syscall_id :usize ,arg:[usize;3]) -> isize {
    match syscall_id {
        SYSCALL_WRITE => {
            sys_write(arg[0], arg[1] as *const u8, arg[2])
        }
        SYSCALL_EXIT => {
            sys_exit(arg[0] as i32)
        }
        SYSCALL_EXEC => {
            for s in ROOT_INODE.ls(){
                println!("{}",s)
            }
            
            //panic!("here");
            let block_device = BLOCK_DEVICE.clone();
            //BLOCK_DEVICE
            let mut read_buffer = [0u8; 512];
            block_device.read_block(0, &mut read_buffer);
            info!("run here!!");
            sys_exec(arg[0] as *const u8)
        }

        SYSCALL_INIT => {
            sys_init()
        }
        _ => {
            panic!("not souppeted syscall");
            //run_next_app()
        }
    }
}