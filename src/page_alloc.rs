use alloc::vec::Vec;
use riscv::addr::page;
use crate::memlayout::PHYSTOP;
use crate::{print, println, info};
use crate::riscv::PGSZ;
use crate::sync::spin::Spin;
use crate::vm::PhyPageNum;
pub static FRAME_ALLOC:FarmeAllocer = FarmeAllocer::new();
pub struct FarmeAllocer{
    allocer:Spin<StackFrame>
}

pub struct AllocerGuard{
    pub pages:PhyPageNum
}

impl From <AllocerGuard> for usize {
    fn from(value: AllocerGuard) -> Self {
        value.pages.0
    }
}

impl AllocerGuard {
    fn new() -> Self{
        Self { pages: 0.into() }
    }
    fn page_mut(&mut self,pages:AllocerGuard){
        *self = pages
    }
}

pub struct StackFrame{
    current:usize,
    end:usize,
    free:Vec<usize>,
}

impl StackFrame {
    pub const fn new()-> Self{
        Self { 
            current: 0 ,
            end: 0, 
            free: Vec::new(), 
        }
    }
    pub fn init(&mut self,s:PhyPageNum,e:PhyPageNum) {
        self.current = s.into();
        self.current = (self.current+PGSZ-1)/PGSZ * PGSZ;
        self.end = e.into();
        //Fix(01):algin to 4096
    }

    pub fn alloc(&mut self) -> PhyPageNum {
        if self.current >= self.end{
            panic!("no pages")
        }
        let pages:Option<usize> = self.free.pop();
        match pages {
            None => {
                let ret = self.current;
                self.current+= PGSZ;
                ret.into()
            },
            _ => pages.unwrap().into(),
        }
    }
    pub fn dealloc(&mut self,page:PhyPageNum){
        let page:usize = page.into();
        if page >= self.current{
            for i in self.free.iter(){
                if *i == page{
                    panic!("pages:{:#x} has not alloced",page);
                }
            }
        }
        self.free.push(page);
    }  
}

impl FarmeAllocer {
    pub const fn new() -> Self{
        Self { allocer: Spin::new(StackFrame::new(),"PgAllocer") }
    }
    pub fn page_alloc(&self) -> AllocerGuard{
        unsafe{
            //clear
            let page = self.allocer.lock().alloc();
            let byte_arry = page.get_bytes_array();
            for i in byte_arry{
                *i = 0 ;
            }
            AllocerGuard {
                pages: page, 
            }
        }
    }
    pub fn page_dealloc(&self,page:PhyPageNum){
        unsafe{
            self.allocer.lock().dealloc(page);
        }
    }

    pub fn allocer_init(&self) {
        extern "C"{
            fn ekernel();
        }
        unsafe{self.allocer.lock().init(
            (ekernel as usize).into(),
            (PHYSTOP - 50*PGSZ).into(),
            )
        }
    }
}

pub struct UserBuffer {
    pub buffers:Vec<&'static mut [u8]>
}

impl UserBuffer {
    pub fn new(buffers:Vec<&'static mut [u8]>) -> Self {
        Self { buffers }
    }
    pub fn len(&self) -> usize {
        let mut total: usize = 0;
        for b in self.buffers.iter() {
            total += b.len();
        }
        total
    }
}

impl IntoIterator for UserBuffer {
    type Item = *mut u8;
    type IntoIter = UserBufferIterator;
    fn into_iter(self) -> Self::IntoIter {
        UserBufferIterator {
            buffers: self.buffers,
            current_buffer: 0,
            current_idx: 0,
        }
    }
}
pub struct UserBufferIterator {
    buffers: Vec<&'static mut [u8]>,
    current_buffer: usize,
    current_idx: usize,
}

impl Iterator for UserBufferIterator {
    type Item = *mut u8;
    fn next(&mut self) -> Option<Self::Item> {
        if self.current_buffer >= self.buffers.len() {
            None
        } else {
            let r = &mut self.buffers[self.current_buffer][self.current_idx] as *mut _;
            if self.current_idx + 1 == self.buffers[self.current_buffer].len() {
                self.current_idx = 0;
                self.current_buffer += 1;
            } else {
                self.current_idx += 1;
            }
            Some(r)
        }
    }
}

impl Drop for AllocerGuard {
    fn drop(&mut self){
       unsafe{
        FRAME_ALLOC.page_dealloc(self.pages);
       }
    }
}

