use core::u8;
use easy_fs::Inode;
use easy_fs::EasyFileSystem;
use crate::info;
use crate::riscv::PGSZ;
use crate::riscv::intr_on;
use crate::sync::spin::Spin;
use crate::vm::PhyPageNum;
use alloc::sync::Arc;
use crate::filesystem::File;
use lazy_static::*;
use super::BLOCK_DEVICE;
use alloc::vec::Vec;
pub const READONLY: usize = 0;
pub const WRITEONLY: usize = 1<<0;
pub const RDWR: usize = 1<<1;
pub const CREATE: usize = 1<<9;
pub const TRUNC:usize = 1<<10; 

fn judg_read (perm:usize) -> bool{
    perm & READONLY == 1 
}

fn judg_trunc (perm:usize) -> bool{
    perm & TRUNC == 1 
}


fn judg_write (perm:usize) -> bool{
    perm & WRITEONLY == 1 
}

fn judg_rw (perm:usize) -> bool{
    perm & RDWR == 1 
}

fn judg_create (perm:usize) -> bool{
    perm & CREATE == 1 
}



lazy_static!{
    pub static ref ROOT_INODE:Arc<Inode> = {
        let efs = EasyFileSystem::open(BLOCK_DEVICE.clone());
        Arc::new(EasyFileSystem::root_inode(&efs))
    };
}


pub struct OSinode{
    readable:bool,
    writable:bool,
    pub rl_inode:Spin<RLinode>,
}
pub struct RLinode {
    offset:usize,
    pub inode:Arc<Inode>
}

impl OSinode {
    pub fn new(readable:bool,writable:bool,inode:Arc<Inode>) -> Self{
        Self { 
            readable, 
            writable, 
            rl_inode: unsafe {
                Spin::new(RLinode {offset:0, inode},"inode")
            } 
        }
    }

    pub fn read_all(&self) -> Vec<u8> {
        let mut rl_inode = unsafe {self.rl_inode.lock()};
        let mut buf = [0u8;512];
        let mut v :Vec<u8> = Vec::new();
        let len = rl_inode.inode.read_at(rl_inode.offset, &mut buf);
        loop {
            unsafe {
            let len = rl_inode.inode.read_at(rl_inode.offset, &mut buf);
            if len == 0{
                info!("len:{}",rl_inode.offset);
                break;
            }
            rl_inode.offset += len;
            v.extend_from_slice(&buf[..len]);
            }
        }
        v
    }

}

impl File for OSinode {
    fn readable(&self) -> bool{
        self.readable
    }
    fn writable(&self) -> bool{
        self.writable
    }
    fn read(&self ,buf:&mut [u8]) -> usize{
        let mut rl_inode = unsafe {self.rl_inode.lock()};
        let read_size = unsafe {
            rl_inode.inode.read_at(rl_inode.offset, buf)
        };
        read_size
    }
    fn write(&self ,buf:&[u8]) -> usize {
        let mut rl_inode = unsafe {
            self.rl_inode.lock()
        };
        let write_size = unsafe {
            rl_inode.inode.write_at(rl_inode.offset, buf)
        };
        write_size
    }
}

pub fn open_file(name:&str,flags:usize) -> Option<Arc<OSinode>>{
    if judg_create(flags) {
        if let Some(inode) = ROOT_INODE.find(name){
            inode.clear();
                Some(
                    Arc::new(OSinode::new(
                        judg_read(flags),
                        judg_write(flags),
                        inode,
                    ))
                )
        }else {
            ROOT_INODE.create(name)
                    .map(|inode|{
                        Arc::new(OSinode::new(
                            judg_read(flags), 
                            judg_write(flags), 
                            inode
                        ))
                    })
        }
    }else {
        ROOT_INODE.find(name)
            .map(|inode|{
                if judg_trunc(flags){
                    inode.clear();
                }
                Arc::new(OSinode::new(
                    judg_read(flags),
                    judg_write(flags),
                    inode
                ))
            })
    }
}