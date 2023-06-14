use core::{slice,str, task};

use crate::{print, cpu::CPUS, filesystem::inode::{open_file, READONLY, self}, riscv::PGSZ, println, info, task::exit};
use crate::page_alloc::UserBuffer;
use crate::PageTable;

pub fn sys_write(fd:usize,buf: *const u8,len:usize) -> isize {
    //info!("run here");
    let proc = CPUS.my_proc().unwrap();
    let va = buf as usize;
    let offset = va % PGSZ;
    let pa_base  = proc.inner_mut().pagetable().walk_addr(va).unwrap();
    let pa = pa_base+offset;
    if fd > proc.inner_mut().files.len(){
        return -1;
    }
    let mut inner = proc.inner_mut();
    let root = inner.pagetable().root.0;
    if let Some(file) = &inner.files[fd]{
        if !file.writable(){
            return -1;
        }
        let mut pgtbl = PageTable::create(root);
        let file = file.clone();
        drop(inner);
        file.write(UserBuffer::new(pgtbl.translated_byte_buffer(buf, len))) as isize
    }else {
        -1
    }
}


pub fn sys_read(fd:usize,buf: *const u8,len :usize) -> isize {
    let proc = CPUS.my_proc().unwrap();
    let va = buf as usize;
    let offset = va % PGSZ;
    let pa_base  = proc.inner_mut().pagetable().walk_addr(va).unwrap();
    let pa = pa_base+offset;
    if fd > proc.inner_mut().files.len(){
        return -1;
    }
    let mut inner = proc.inner_mut();
    let root = inner.pagetable().root.0;
    if let Some(file) = &inner.files[fd]{
        if !file.readable(){
            return -1;
        }
        let mut pgtbl = PageTable::create(root);
        let file = file.clone();
        drop(inner);
        file.read(UserBuffer::new(pgtbl.translated_byte_buffer(buf, len))) as isize
    }else {
        -1
    }
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