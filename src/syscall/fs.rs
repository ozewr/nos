use core::{slice,str, task};

use crate::{print, cpu::CPUS, filesystem::inode::{open_file, READONLY, self}, riscv::PGSZ, println, info, task::exit};


const FD_STDOUT :usize = 1 ;
pub fn sys_write(fd:usize,buf: *const u8,len:usize) -> isize {
    match fd {
        FD_STDOUT => {
            let proc = CPUS.my_proc().unwrap();
            let va = buf as usize;
            let offset = va % PGSZ;
            let pa_base  = proc.inner_mut().pagetable().walk_addr(va).unwrap();
            let pa = pa_base+offset;
            let slice = unsafe{
                core::slice::from_raw_parts(pa as *const _,len)
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

// pub fn sys_exit(xstate:i32) -> isize{
//     //print!("exit with code {}",xstate);
//     exit(xstate);
//     panic!()
// }

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