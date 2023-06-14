use crate::memlayout::{KERNBASE, PHYSTOP};
use crate::riscv::PGSZ;
use crate::sync::spin::Spin;
use crate::vm::PhyPageNum;
use crate::{info, print, println};
use alloc::vec::Vec;
use lazy_static::lazy_static;
use riscv::addr::page;

pub static FRAME_ALLOC: FarmeAllocer = FarmeAllocer::new();
pub static PAGE_COUNTS: PageCounts = PageCounts::new();

pub struct PageCounts {
    counts: Spin<[u8; (PHYSTOP - KERNBASE) / PGSZ]>,
}

impl PageCounts {
    pub const fn new() -> Self {
        Self {
            counts: Spin::new([0u8; (PHYSTOP - KERNBASE) / PGSZ], "PAGE_COUNTS"),
        }
    }
    pub fn addcount(&self, page: usize) {
        if(page<KERNBASE||page>PHYSTOP){
            info!("add page {:#x}",page);
            panic!("add page wrong");
        }
        unsafe {
            let idx = (page - KERNBASE) / PGSZ;
            //info!("add {}/{}",idx,PHYSTOP-KERNBASE);
            self.counts.lock()[idx] += 1;
        }
    }
    pub fn subcount(&self, page: usize) {
        if(page<KERNBASE||page>PHYSTOP){
            info!("sub page {:#x}",page);
            panic!("sub page wrong");
        }
        unsafe {
            let idx = (page - KERNBASE) / PGSZ;
            //info!("sub {}/{}",idx,PHYSTOP-KERNBASE);
            self.counts.lock()[idx] -= 1;
        }
    }
    pub fn getcount(&self, page: usize) -> u8 {
        if(page<KERNBASE||page>PHYSTOP){
            info!("get page {:#x}",page);
            panic!("get page wrong");
        }
        unsafe {
            let idx = (page - KERNBASE) / PGSZ;
            let count = self.counts.lock()[idx];
            count
        }
    }
}

pub struct FarmeAllocer {
    allocer: Spin<StackFrame>,
}

pub struct AllocerGuard {
    pub pages: PhyPageNum,
}

impl From<AllocerGuard> for usize {
    fn from(value: AllocerGuard) -> Self {
        value.pages.0
    }
}

impl AllocerGuard {
    fn new() -> Self {
        Self { pages: 0.into() }
    }
    fn page_mut(&mut self, pages: AllocerGuard) {
        *self = pages
    }
}

pub struct StackFrame {
    current: usize,
    end: usize,
    free: Vec<usize>,
}

impl StackFrame {
    pub const fn new() -> Self {
        Self {
            current: 0,
            end: 0,
            free: Vec::new(),
        }
    }
    pub fn init(&mut self, s: PhyPageNum, e: PhyPageNum) {
        self.current = s.into();
        self.current = (self.current + PGSZ - 1) / PGSZ * PGSZ;
        self.end = e.into();
        //Fix(01):algin to 4096
    }

    pub fn alloc(&mut self) -> PhyPageNum {
        if self.current >= self.end {
            panic!("no pages")
        }
        let pages: Option<usize> = self.free.pop();
        match pages {
            None => {
                let ret = self.current;
                self.current += PGSZ;
                //info!("{:#x} count({})++",ret,PAGE_COUNTS.getcount(ret));
                PAGE_COUNTS.addcount(ret);
                ret.into()
            }
            _ => {
                //info!("{:#x} count({})++",pages.unwrap(),PAGE_COUNTS.getcount(pages.unwrap()));
                PAGE_COUNTS.addcount(pages.unwrap());
                pages.unwrap().into()
            }
        }
    }

    pub fn dealloc(&mut self, page: PhyPageNum) {
        let page: usize = page.into();
        if page >= self.current {
            for i in self.free.iter() {
                if *i == page {
                    panic!("pages:{:#x} has not alloced", page);
                }
            }
        }

        if (PAGE_COUNTS.getcount(page) == 1) {
            info!("{:#x} count({})--",page,PAGE_COUNTS.getcount(page));
            PAGE_COUNTS.subcount(page);
            self.free.push(page);
        }
        else{
            info!("{:#x} count({})--",page,PAGE_COUNTS.getcount(page));
            PAGE_COUNTS.subcount(page);
        }
    }
}

impl FarmeAllocer {
    pub const fn new() -> Self {
        Self {
            allocer: Spin::new(StackFrame::new(), "PgAllocer"),
        }
    }

    pub fn page_alloc(&self) -> AllocerGuard {
        unsafe {
            //clear
            let page = self.allocer.lock().alloc();
            let byte_arry = page.get_bytes_array();
            for i in byte_arry {
                *i = 0;
            }
            AllocerGuard { pages: page }
        }
    }

    pub fn page_dealloc(&self, page: PhyPageNum) {
        unsafe {
            self.allocer.lock().dealloc(page);
        }
    }

    pub fn allocer_init(&self) {
        extern "C" {
            fn ekernel();
        }
        unsafe {
            self.allocer
                .lock()
                .init((ekernel as usize).into(), (PHYSTOP - 50 * PGSZ).into())
        }
    }
}

pub struct UserBuffer {
    pub buffers: Vec<&'static mut [u8]>,
}

impl UserBuffer {
    pub fn new(buffers: Vec<&'static mut [u8]>) -> Self {
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
    fn drop(&mut self) {
        unsafe {
            FRAME_ALLOC.page_dealloc(self.pages);
        }
    }
}
