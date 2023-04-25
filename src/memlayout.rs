use crate::riscv::PGSZ;

pub const KERNBASE: usize = 0x80200000;
pub const PHYSTOP: usize = KERNBASE + 128 * 1024 * 1024 - 0x00200000;
pub const PAGE_SIZE_BITS:usize = 0x0c;
pub const PA_WIDTH_SV39:usize = 56;
pub const VA_WIDTH_SV39:usize = 39; 
pub const PPN_SV39:usize = PA_WIDTH_SV39 - PAGE_SIZE_BITS;
pub const VPN_SV39:usize = VA_WIDTH_SV39 - PAGE_SIZE_BITS;

pub const PTE_V:usize = 1<<0;
pub const PTE_R:usize = 1<<1;
pub const PTE_W:usize = 1<<2;
pub const PTE_X:usize = 1<<3;
pub const PTE_U:usize = 1<<4;
pub const PTE_G:usize = 1<<5;
pub const PTE_A:usize = 1<<6;
pub const PTE_D:usize = 1<<7;
