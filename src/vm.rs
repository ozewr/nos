use::alloc::vec::Vec;
use riscv::register::stvec;
use riscv::register::satp;
use crate::riscv::sfence_vma;
use crate::{sync::spin::Spin, memlayout::{PA_WIDTH_SV39,VA_WIDTH_SV39, PPN_SV39, VPN_SV39, PTE_V, PHYSTOP, MAXVA, PTE_A, KERNBASE, PTE_R, PTE_X, PTE_W}, page_alloc::{AllocerGuard, FRAME_ALLOC}, println};
use core::{sync::atomic::{AtomicUsize,AtomicPtr}, usize};
use crate::riscv::PGSZ;
use crate::kalloc::HEAP_SPACE;
use crate::debug;

pub static PGTBIT:PageTableBit = PageTableBit{
    pagetable:Spin::new(None, "pagetable_bit")
};

#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct  PhyAddr(pub usize);
#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct VirAddr(pub usize);
#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct PhyPageNum(pub usize);
#[derive(Clone,Copy,Ord,PartialEq, PartialOrd,Eq)]
pub struct  VirPageNum(pub usize);

// #[derive(Copy, Clone)]
// #[repr(C)]
// pub struct PageTableEntry(pub PhyPageNum);

pub struct PageTable{
    root:PhyPageNum,
    pagetable:Vec<AllocerGuard>,
}


impl From<usize> for PhyAddr{
    fn from(value: usize) -> Self {
            Self(value&((1<<PA_WIDTH_SV39)-1))}
}

impl From<usize> for PhyPageNum {
    fn from(value: usize) -> Self {
        Self(value &((1<<PPN_SV39)-1))}
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
    pub fn round_down(&self) -> VirPageNum{VirPageNum((self.0 & !(PGSZ - 1)))}
    pub fn round_up(&self) -> VirPageNum{VirPageNum((self.0+PGSZ-1) & !(PGSZ -1))}
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



impl PhyPageNum {

    pub fn get_pte_array(&self) -> &'static mut [PhyPageNum] {
        let pa :usize = self.clone().into();
        let pa :PhyAddr= pa.into();
        unsafe{
            core::slice::from_raw_parts_mut(
                pa.0 as *mut PhyPageNum,
                512)
        }
    }

    pub fn get_bytes_array(&self) -> &'static mut [u8]{
        let pa :usize = self.clone().into();
        let pa :PhyAddr= pa.into();
        unsafe{
            core::slice::from_raw_parts_mut(pa.0 as *mut u8, PGSZ)
        }
    }

    pub fn get_mut<T>(&self) -> &'static mut T{
        let pa :usize = self.clone().into();
        let pa :PhyAddr= pa.into();
        unsafe{
            println!("get_mut:{:#x}",pa.0);  
            (pa.0 as *mut T).as_mut().unwrap()
        }
    }

    pub fn is_v(&self) -> bool {
        self.0 & PTE_V != 0
    } 

}

impl PageTable{
    pub fn new() -> Self{
        let pte: AllocerGuard = FRAME_ALLOC.page_alloc();
        let page = pte.pages;
        let mut v = Vec::new();
        v.push(pte);
        Self { 
            root: page,
            pagetable: v,
        }
    }

    pub fn mappages(&mut self,va:VirAddr,pa:PhyAddr,size:usize,perm : usize) -> bool{
        if (size == 0){
            panic!("map error size = 0")
        }
        let mut a: VirPageNum = va.round_down();
        let mut last:VirAddr = (va.0+size).into();
        let mut last: VirPageNum = last.round_down();

        let mut a :usize = a.into();
        let mut last:usize = last.into();

        let mut pa :usize = pa.0;
        loop{
            let mut pgtbl_arry:&mut [PhyPageNum] = self.root.get_pte_array();
            let mut pagetable:&mut [PhyPageNum] = self.walk(a, true,pgtbl_arry).unwrap();
            let idx = (a >> (12+0)) & 0x1ff;
            let pte: PhyPageNum = pagetable[idx];
            
            if (pte).is_v(){
                panic!("mappages: remap")
            }
            let pte_temp:PhyPageNum = PhyPageNum((((pa >>12 ) <<10) | perm | PTE_V)); //pa2pte
            pagetable[idx] = pte_temp;
            if a == last{
                break;
            }
            a += PGSZ;
            pa+= PGSZ;
        }
        true
    }

    pub fn walk(&mut self,va:usize,alloc:bool,mut pgtbl_arry:&'static mut [PhyPageNum]) -> Option<&'static mut [PhyPageNum]> {
        let mut pte_save: &Vec<AllocerGuard> = &self.pagetable;
        
        if(va >= MAXVA){
            panic!("va to big");
        }
        let mut pagetable: &mut [PhyPageNum] = self.root.get_pte_array();
        
        let mut temp_store :Option<PhyPageNum> = None;
        for level in (1..3).rev(){
                let idx  = (va >>(12+9*level)) & 0x1ff;
                let mut pte: PhyPageNum = pagetable[idx];
                if unsafe{(pte).is_v()} {
                    unsafe{
                        pagetable = PhyPageNum( ((pte.0 >> 10) <<12) ).get_pte_array();//pte2pa
                        temp_store = Some(PhyPageNum((pte.0 >> 10) << 12));
                    }
                }else {
                    if !alloc {
                        return None;
                    }else {
                        let frame: AllocerGuard = FRAME_ALLOC.page_alloc();
                        let page: PhyPageNum = frame.pages;
                        let pte_temp: PhyPageNum= PhyPageNum((((page.0) >> 12)<< 10 ) | PTE_V);//pa2pte
                        pagetable[idx] = pte_temp;
                        temp_store = Some(page);
                        pagetable = page.get_pte_array();
                        self.pagetable.push(frame);      
                    }
                }
                //pgtbl_arry = pagetable;
        }
        pgtbl_arry = temp_store.unwrap().get_pte_array();
        Some(pgtbl_arry)
    } 

    pub fn kvmmap(&mut self,va:VirAddr,pa:PhyAddr,size:usize,perm : usize){
        if (!self.mappages(va, pa, size, perm)){
            panic!("kvmmap")
        }
    }

    pub fn as_satp(&mut self) -> usize{
        let addr:usize = self.root.0;
        let mut bits:usize = 0;
        let sv_39:usize =8;
        bits = ( sv_39 << 60) | (addr >> 12);
        bits
    }
}

pub fn kvmmake(pagetable:&mut PageTable) ->&mut PageTable{
    extern "C"{
        fn stext();
        fn etext();
        fn srodata();
        fn erodata();
        fn sdata();
        fn edata();
        fn ekernel();
        fn skernel();
    }
    pagetable.mappages(
        KERNBASE.into(),
        KERNBASE.into(),
        (etext as usize) - KERNBASE,
        PTE_R|PTE_X|PTE_W
    );
    // etext remap so +PGSZ
    pagetable.mappages(
        ((etext as usize)+PGSZ).into(),
        ((etext as usize)+PGSZ).into(),
        PHYSTOP-(etext as usize), 
        PTE_R|PTE_X|PTE_W
    );
    pagetable
}

pub fn kvminithart(pagetable:usize){
    unsafe{
        riscv::register::satp::write(pagetable);
        sfence_vma();
    }
}


pub struct PageTableBit{
    pagetable:Spin<Option<usize>>,
}

impl PageTableBit {
    pub fn set_bit(&self,pagetable_bit:usize) {
        unsafe {
            let temp: &mut Option<usize> = self.pagetable
                            .lock()
                            .spin()
                            .get_mut();
            *temp = (Some(pagetable_bit))
        };
    }
    pub fn get_bit(&self) -> Option<usize>{
        let pagetable_bit :Option<usize>;
        unsafe {pagetable_bit = *(self.pagetable.lock().spin().get_mut());}
        pagetable_bit    
    }
}
