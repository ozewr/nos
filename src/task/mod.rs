use core::{f32::consts::E,};
use alloc::sync::Arc;
use riscv::addr::{VirtAddr, page};

use crate::{vm::{PageTable, VirPageNum, VirAddr, PhyPageNum}, memlayout::{TRAMPOLINE, PTE_R, PTE_X, PTE_U, PTE_W, TRAPFRAME, KERNEL_STACK_SIZE, USERSTACK, USERSTACK_TOP}, riscv::{PGSZ, intr_on}, cpu::CPUS, print, println, info, sbi::shutdown, sync::spin::Spin};
use crate::FRAME_ALLOC;
use crate::cpu::Context;
use self::{task::State, manager::TASKMANGER};
pub mod task;
pub mod manager;
pub mod switch;
use crate::global_asm;
global_asm!(include_str!("switch.s"));
extern "C" {
    pub fn __switch(current_task_cx_ptr: *mut Context, next_task_cx_ptr: *const Context);
}
#[no_mangle]
pub fn scheduler() -> ! {
    let cpu = unsafe { CPUS.my_cpu() };
    loop {
        intr_on();
        let mut lock_task_manger = unsafe { TASKMANGER.lock() };
        if let Some(task) = lock_task_manger.pop_front(){
            let mut old_task = cpu.task.take();
            match old_task{
                Some(_) => {
                    lock_task_manger.add_task(old_task.unwrap());
                }
                None => {}, //do noting 
            }
            let mut out_data = unsafe {task.out_data.lock()};
            let inner = task.inner_mut();
            out_data.state = State::Run;
            let next_context = &inner.context as *const Context;
            let dbug_context = inner.context.clone();
            //info!("devbug context {:#x}",dbug_context.sp);
            drop(out_data);
            drop(inner);
            cpu.task = Some(task);
            Spin::unlock(lock_task_manger);
            let proc = CPUS.my_proc().unwrap();
            unsafe { __switch(&mut cpu.context as *mut Context, next_context) };
            //run here if diffrent task
        }
    }
}


pub fn exit(exit_code:i32){
    let c = unsafe { CPUS.my_cpu() };
    let task = CPUS.take_task().unwrap();
    let pid = task.pid();
    if pid == 0 {
        println!("[kernel]:init exit with exit code {} ... ",exit_code);
        if exit_code != 0{
            shutdown();
        }
    }
    info!("exit id{}",task.pid());
    //unsafe { task.out_data.lock() }.state = State::Zombie;
    let mut out_data = unsafe { task.out_data.lock() };
    out_data.state = State::Zombie;
    out_data.xstate = exit_code;
    let mut inner = task.inner_mut();
    //let parent = inner.children;
    //not save childen
    let mut ctx = &mut inner.context as *mut Context;
    inner.children.clear();
    drop(inner);
    drop(out_data);
    unsafe { TASKMANGER.lock().free_task(task) }
    unsafe { c.sched(ctx) };
    panic!("this proc shuld be exit")
}
pub fn swtch_task(){
    let task = CPUS.my_proc().unwrap();
    let locked = unsafe { task.out_data.lock() };
    let mut inner = task.inner_mut();
    let context = &mut inner.context;
}

pub fn parse_elf(elf_data:&[u8]) -> (PageTable,usize){

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
           
            let start_va = start_va & !(PGSZ-1);
            map_data(&mut pagetable, start_va,mem_sz,map_perm);
            copy_data(&mut pagetable, start_va, &elf.input[ph.offset() as usize..(ph.offset()+ph.file_size()) as usize]);
        }
    }
    map_user_stack(&mut pagetable, USERSTACK, USERSTACK_TOP);
    (pagetable,elf_header.pt2.entry_point() as usize)
    //pagetable
}
pub fn copy_data(pagetable:&mut PageTable ,start_va:usize,data:&[u8]){
    let mut start = 0;
    let mut current_va = start_va;
    let len = data.len();
    loop {
        let src = &data[start..len.min(start+PGSZ)];
        let dst = &mut PhyPageNum(pagetable.walk_addr(current_va).unwrap()).get_bytes_array()[..src.len()];
        dst.copy_from_slice(src);
        start += PGSZ;
        if start >= len{
            break;
        }
        current_va += PGSZ;
    }
}

pub fn map_data(pagetable:&mut PageTable,va:usize,sz:usize,prem:usize){
    let mut va = va;
    let end = (((va+sz) + PGSZ -1 ) / PGSZ) * PGSZ;
    loop {
        if va >= end{
            break;
        }
        //info!("task mode 147 va{:#x}",va);
        let gurd = FRAME_ALLOC.page_alloc();
        let pa = gurd.pages.0;
        pagetable.save_page(gurd);
        pagetable.data.push(va);
        //map data
        pagetable.mappages(
            va.into(), 
            pa.into(), 
            PGSZ, 
            prem,
        );
        va += PGSZ;
    }
    //let a = pagetable.walk_addr(0x10000).unwrap();
    let size = pagetable.pagetable.len();
}

pub fn map_user_stack(pagetable:&mut PageTable,va:usize,top:usize){
    let mut va = va;
    //info!("runhere");
    loop {
        if va >= top {
            break;
        }
        let gurd = FRAME_ALLOC.page_alloc();
        let pa = gurd.pages.0;
        pagetable.save_page(gurd);
        //map data
        pagetable.mappages(
            va.into(), 
            pa.into(), 
            PGSZ, 
            PTE_U|PTE_W|PTE_R,
        );
        va += PGSZ;
    }
}
pub fn map_user_stack_fork(pagetable_old:&mut PageTable,pagetable_new:&mut PageTable,va:usize,top:usize){
    let mut va = va;
    //info!("runhere");
    loop {
        if va >= top {
            break;
        }
        let gurd = FRAME_ALLOC.page_alloc();
        let pa = gurd.pages.0;
        
        let old_src = PhyPageNum(pagetable_old.walk_addr(va).unwrap());
        let new_dst = PhyPageNum(pa);
        new_dst.get_bytes_array()
            .copy_from_slice(old_src.get_bytes_array());
        pagetable_new.save_page(gurd);
        //map data
        pagetable_new.mappages(
            va.into(), 
            pa.into(), 
            PGSZ, 
            PTE_U|PTE_W|PTE_R,
        );
        va += PGSZ;
    }
}



