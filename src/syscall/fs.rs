use core::{slice,str, task};

use crate::{print, cpu::CPUS, filesystem::inode::{open_file, READONLY, self}};


const FD_STDOUT :usize = 1 ;
pub fn sys_write(fd:usize,buf: *const u8,len:usize) -> isize {
    match fd {
        FD_STDOUT => {
            let slice = unsafe{
                core::slice::from_raw_parts(buf,len)
            };
            let str = core::str::from_utf8(slice).unwrap();
            print!("{}",str);
            len as isize
        }
        _ => {
            panic!("not suppered fd");
        }
    }
}

pub fn sys_exit(xstate:i32) -> isize{
    print!("exit with code {}",xstate);
    panic!()
}

pub fn sys_open(path :*const u8,flags:usize) -> isize {
    let task = unsafe {CPUS.my_cpu().task.as_mut().unwrap()};

    let path = task.inner_mut().pagetable().translated_str(path);
    if let Some(app_inode) = open_file(path.as_str(),READONLY){
        let fd = task.alloc_fd();
        task.inner_mut().files[fd] = Some(app_inode);
        fd as isize
    }else {
        -1
    }
}

pub fn sys_close(fd:usize) -> isize {
    
    let task = unsafe {
        CPUS.my_cpu().task.as_mut().unwrap()
    };
    if fd >= task.inner_mut().files.len() {
        return -1;
    }
    if task.inner_mut().files[fd].is_none(){
    return -1;
    }
    task.inner_mut().files[fd].take();
    0
}