use::alloc::vec::Vec;
use riscv::register::stvec;
use crate::{sync::spin::Spin, memlayout::{PA_WIDTH_SV39,VA_WIDTH_SV39, PPN_SV39, VPN_SV39, PTE_V}};
use core::sync::atomic::{AtomicUsize,AtomicPtr};
use crate::riscv::PGSZ;

#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct  PhyAddr(pub usize);
#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct VirAddr(pub usize);
#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct PhyPageNum(pub usize);
#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct  VirPageNum(pub usize);


#[derive(Copy, Clone)]
#[repr(C)]
pub struct PageTableEntry {
    pub pte: usize,
}

impl From<usize> for PhyAddr{
    fn from(value: usize) -> Self {
            Self(value&((1<<PA_WIDTH_SV39)-1))}
}

impl From<usize> for PhyPageNum {
    fn from(value: usize) -> Self {
        Self(value&((1<<PPN_SV39)-1))}
}

impl From<PhyAddr> for usize {
    fn from(value: PhyAddr) -> Self {value.0}
}
impl From<PhyPageNum> for usize {
    fn from(value: PhyPageNum) -> Self {value.0}
}

impl From<usize> for VirAddr{
    fn from(value: usize) -> Self {
        Self(value&((1<<VA_WIDTH_SV39)-1))}
}

impl From<usize> for VirPageNum{
    fn from(value: usize) -> Self {
        Self(value&((1<<VPN_SV39)-1))}
}

impl From<VirAddr> for usize {
    fn from(value: VirAddr) -> Self {value.0}
}

impl From<VirPageNum> for usize {
    fn from(value: VirPageNum) -> Self {value.0}
}

impl PhyAddr {
    pub fn page_offset(&self)-> usize{
        self.0 & (0xfff)
    }
    pub fn round_down(&self) -> PhyPageNum{PhyPageNum((self.0/PGSZ))}
    pub fn round_up(&self) -> PhyPageNum{PhyPageNum((self.0+PGSZ-1)/PGSZ)}
}

impl VirAddr {
    pub fn page_offset(&self)-> usize{
        self.0 & (0xfff)
    }
    pub fn round_down(&self) -> VirPageNum{VirPageNum((self.0/PGSZ))}
    pub fn round_up(&self) -> VirPageNum{VirPageNum((self.0+PGSZ-1)/PGSZ)}
}

impl From<PhyAddr> for PhyPageNum {
    fn from(value: PhyAddr) -> Self {
        assert_eq!(value.page_offset(),0);
        value.round_down()
    }
}

impl From<VirAddr> for VirPageNum {
    fn from(value: VirAddr) -> Self {
        assert_eq!(value.page_offset(),0);
        value.round_down()
    }
}

impl PageTableEntry {
    pub fn new(ppn:PhyPageNum,flags:usize) -> Self{
        PageTableEntry{
            pte: ppn.0<<10 | flags
        }
    }
    pub fn get_ppn(&self)-> PhyPageNum {
      PhyPageNum( (self.pte >>10 & (1<<44 -1)) )
    }
    pub fn flags(&self) -> usize {
        self.pte & 0x3ff
    }
    pub fn to_pa(&self) -> PhyAddr {
        ((self.pte >> 10) >>12).into()
    }
    pub fn is_v(&self) -> bool {
        if (self.pte & PTE_V) != 0 {
            true
        }else {
            false
        } 
    }
}


impl PhyPageNum {

    pub fn get_pte_array(&self) -> &'static mut [PageTableEntry] {
        let pa :usize = self.clone().into();
        let pa :PhyAddr= pa.into();
        unsafe{
            core::slice::from_raw_parts_mut(
                pa.0 as *mut PageTableEntry, 
                512)
        }
    }
    
    pub fn get_bytes_array(&self) -> &'static mut [u8]{
        let pa :usize = self.clone().into();
        let pa :PhyAddr= pa.into();
        unsafe{
            core::slice::from_raw_parts_mut(pa.0 as *mut u8, 4096)
        }
    }
    pub fn get_mut<T>(&self) -> &'static mut T{
        let pa :usize = self.clone().into();
        let pa :PhyAddr= pa.into();
        unsafe{
            (pa.0 as *mut T).as_mut().unwrap()  
        }
    }
}

