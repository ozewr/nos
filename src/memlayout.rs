use crate::{riscv::PGSZ};

pub const NPROC : usize = 32;

pub const KERNBASE: usize = 0x80200000;
pub const PHYSTOP: usize = KERNBASE + 128 * 1024 * 1024 - 0x00200000;

pub const MMIO :usize = 0x1000_1000;

pub const PAGE_SIZE_BITS:usize = 0x0c;
pub const PA_WIDTH_SV39:usize = 56;
pub const VA_WIDTH_SV39:usize = 39; 
pub const PPN_SV39:usize = PA_WIDTH_SV39 - PAGE_SIZE_BITS;
pub const VPN_SV39:usize = VA_WIDTH_SV39 - PAGE_SIZE_BITS;


pub const MAXVA:usize = (1 << (9 + 9 + 9 + 12 - 1));
pub const TRAMPOLINE:usize = MAXVA - PGSZ;
pub const TRAPFRAME:usize =  (TRAMPOLINE - PGSZ);

pub const USERSTACK:usize = TRAPFRAME - 3*PGSZ;
pub const USERSTACK_TOP :usize = USERSTACK +2*PGSZ;

pub const KERNEL_STACK_SIZE:usize = PGSZ*3;
pub const PTE_V:usize = 1<<0;
pub const PTE_R:usize = 1<<1;
pub const PTE_W:usize = 1<<2;
pub const PTE_X:usize = 1<<3;
pub const PTE_U:usize = 1<<4;
pub const PTE_G:usize = 1<<5;
pub const PTE_A:usize = 1<<6;
pub const PTE_D:usize = 1<<7;
pub const PTE_F:usize = 1<<9;

#[macro_export]
macro_rules! kstack {
    ($p:expr) => {
        (crate::memlayout::TRAPFRAME - (($p)+1)*((crate::memlayout::KERNEL_STACK_SIZE)/PGSZ + 1)*PGSZ)
    };
}
