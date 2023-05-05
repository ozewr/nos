use alloc::vec::Vec;
use riscv::addr::page;
use crate::memlayout::PHYSTOP;
use crate::{print, println};
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
        self.end = e.into();
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
            AllocerGuard {
                pages: self.allocer.lock().alloc(), 
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
            PHYSTOP.into(),
            )
        }
    }
}


impl Drop for AllocerGuard {
    fn drop(&mut self){
       unsafe{
        //println!("free:{:#x}",self.pages.0);
        FRAME_ALLOC.page_dealloc(self.pages);
        //println!("free:{:#x}",self.pages.0)
       }
    }
}