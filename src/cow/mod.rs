use crate::info;
use crate::memlayout::*;
use crate::page_alloc::{AllocerGuard, PAGE_COUNTS};
use crate::riscv::PGSZ;
use crate::task::task::TaskControlBlock;
use crate::task::{map_user_stack, map_user_stack_fork};
use crate::vm::PageTable;
use crate::vm::PhyPageNum;
use crate::FRAME_ALLOC;
use ::alloc::vec::Vec;
use alloc::sync::Arc;

pub fn copy_pagetable(pgtbl_new: &mut PageTable, pgtbl_old: &mut PageTable) {
    let new_root = FRAME_ALLOC.page_alloc();

    pgtbl_new.root = new_root.pages;
    pgtbl_new.save_page(new_root);

    // just use parent's data
    let mut v: Vec<usize> = Vec::new();
    for i in pgtbl_old.data.iter() {
        let data_va = *i;
        v.push(data_va);
    }

    for va in v.iter() {
        let data_pa = pgtbl_old.walk_addr(*va).unwrap();
        pgtbl_new.pagetable.push(AllocerGuard {
            pages: PhyPageNum(data_pa),
        });
        PAGE_COUNTS.addcount(data_pa);
    }

    for i in v.iter() {
        let va = *i;
        let pa = pgtbl_old.walk_addr(va).unwrap();
        let mut flag = pgtbl_old.walk_perm(va).unwrap();
        flag = flag & (!PTE_W);
        flag = flag & (!PTE_R);
        pgtbl_new.mappages(va.into(), pa.into(), PGSZ, flag);
    }
}

pub fn map_trampoline(pgtbl_new: &mut PageTable) {
    extern "C" {
        fn trampoline();
    }

    pgtbl_new.mappages(
        TRAMPOLINE.into(),
        (trampoline as usize).into(),
        PGSZ,
        PTE_X | PTE_R,
    );
}

pub fn map_trapframe(pgtbl_new: &mut PageTable, pgtbl_old: &mut PageTable) {
    let old_trapframe = PhyPageNum(pgtbl_old.walk_addr(TRAPFRAME).unwrap());
    let gurd = FRAME_ALLOC.page_alloc();
    let new_trapframe = gurd.pages;
    pgtbl_new.save_page(gurd);
    new_trapframe
        .get_bytes_array()
        .copy_from_slice(old_trapframe.get_bytes_array());
    pgtbl_new.mappages(
        TRAPFRAME.into(),
        new_trapframe.0.into(),
        PGSZ,
        PTE_W | PTE_R | PTE_X,
    );
}

pub fn map_stack(pgtbl_new: &mut PageTable, pgtbl_old: &mut PageTable) {
    //map stacks
    map_user_stack_fork(pgtbl_old, pgtbl_new, USERSTACK, USERSTACK_TOP);
}

pub fn copy_on_write(va: usize, task: &Arc<TaskControlBlock>) {
    info!("[cow/mod.rs:79] copy on write.");
    let mut flag = task.inner_mut().pagetable().walk_perm(va).unwrap();
    let page = FRAME_ALLOC.page_alloc();
    let pa = PhyPageNum(page.pages.0);
    info!("[cow/mod.rs:83] dsc_pa {:#x}",pa.0);

    // copy from parent
    let mut parent_page = PageTable::create(task.inner_mut().parent_root);
    let src_pa = PhyPageNum(parent_page.walk_addr(va).unwrap());
    info!("[cow/mod.rs:88] src_pa {:#x}",src_pa.0);

    pa.get_bytes_array()
        .copy_from_slice(src_pa.get_bytes_array());

    task.inner_mut().pagetable().save_page(page);
    task.inner_mut().pagetable().umappage(va);
    task.inner_mut()
        .pagetable()
        .mappages(va.into(), pa.0.into(), PGSZ, flag | PTE_W | PTE_R);
    flag = task.inner_mut().pagetable().walk_perm(va).unwrap();
}
