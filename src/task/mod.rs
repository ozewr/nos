use core::f32::consts::E;

use riscv::addr::{VirtAddr, page};

use crate::{vm::{PageTable, VirPageNum, VirAddr}, memlayout::{TRAMPOLINE, PTE_R, PTE_X, PTE_U, PTE_W, TRAPFRAME}, riscv::PGSZ, cpu::CPUS};
use crate::FRAME_ALLOC;
pub mod task;
pub mod manager;
pub mod switch;

#[no_mangle]
pub fn scheduler(){
    let c = unsafe { CPUS.my_cpu() };

}

pub fn run_next(){
    let task = CPUS.my_proc();
}

pub fn parse_elf(elf_data:&[u8]) -> PageTable{

    let mut pagetable = PageTable::new();
    let elf = xmas_elf::ElfFile::new(elf_data).unwrap();
    let elf_header = elf.header;
    let magic = elf.header.pt1.magic;
    assert_eq!(magic,[0x7f,0x45,0x4c,0x46],"not elf!!");
    let ph_count = elf_header.pt2.ph_count();
    let mut max_end_vpn :usize;
    for i in 0..ph_count{
        let ph = elf.program_header(i).unwrap();
        if ph.get_type().unwrap() == xmas_elf::program::Type::Load{
            let start_va = ph.virtual_addr() as usize;
            //let end_va = (ph.virtual_addr() + ph.mem_size()) as usize;
            let mem_sz = ph.mem_size() as usize; 
            let mut map_perm = PTE_U;
            let ph_flags = ph.flags();
            if ph_flags.is_read() {
                map_perm |= PTE_R;
            }
            if ph_flags.is_execute(){
                map_perm |= PTE_X
            }
            if ph_flags.is_write() {
                map_perm |= PTE_W
            }
            let start_va = ((start_va) / PGSZ) * PGSZ;
            //let end_va= ((end_va+PGSZ-1) / PGSZ) *PGSZ;
            map_data(&mut pagetable, start_va,mem_sz , map_perm); 
        }
    }
    pagetable
    //pagetable
}

pub fn map_data(pagetable:&mut PageTable,va:usize,sz:usize,prem:usize) -> &mut PageTable{
    let mut va = va;
    //align up to PGSZ
    let end = (((va+sz) + PGSZ -1 ) / PGSZ) * PGSZ;
    loop {
        if va >= end {
            break;
        }else {
            let gurd = FRAME_ALLOC.page_alloc();
            let pa = gurd.pages.0;
            pagetable.save_page(gurd);
            //map data
            pagetable.mappages(
                va.into(), 
                pa.into(), 
                sz, 
                prem
            );
            va += PGSZ;
        }
    }
    pagetable
}