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
    num:usize,
}

impl StackFrame {
    pub const fn new()-> Self{
        Self { 
            current: 0 ,
            end: 0, 
            free: Vec::new(),
            num:0, 
        }
    }
    pub fn init(&mut self,s:PhyPageNum,e:PhyPageNum) {
        self.current = s.into();
        self.end = e.into();
        // println!("curret:{:#x} end :{:#x}",self.current,self.end);
    }

    pub fn alloc(&mut self) -> PhyPageNum {
        let pages:Option<usize> = self.free.pop();
        match pages {
            None => {
                let ret: usize = self.current;
                if ret >= self.end{
                   println!(" count = {}",self.num);
                    panic!("nopages!")
                }
                self.current += PGSZ;
                self.num+=1;
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
        Self { 
            allocer: Spin::new(StackFrame::new(),
            "PgAllocer") 
        }
    }
    pub fn page_alloc(&self) -> AllocerGuard{
        unsafe{
            AllocerGuard::new(self.allocer.lock().alloc())
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

impl AllocerGuard {
    pub fn new(page:PhyPageNum) -> Self {
        let byte_arr = page.get_bytes_array();
        for i in byte_arr {
            *i = 0;
        }
        Self { 
            pages:page
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