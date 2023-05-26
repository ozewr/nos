use easy_fs::BlockDevice;
use virtio_drivers::{VirtIOBlk,VirtIOHeader,Hal};
const VIRTIO0:usize = 0x1000_1000;
use crate::{sync::spin::Spin, page_alloc::{FRAME_ALLOC, AllocerGuard}, vm::{PhyAddr, PageTable, PGTBIT}, memlayout::PAGE_SIZE_BITS, riscv::PGSZ, println, info};
use alloc::vec::Vec;
use lazy_static::*;

lazy_static! {
    pub static ref QUEUE_FRAMES: Spin<Vec<AllocerGuard>> = unsafe { Spin::new(Vec::new(),"viro_queue") };
}

// const QUEUE_FRM_STORE: QueueFrames = QueueFrames::new();


pub type BlockDeviceImpl = VirtIOBlock;

// pub struct QueueFrames{
//     stack:Spin<Vec<AllocerGuard>>
// }
pub struct VirtioHal;
pub struct VirtIOBlock(Spin<VirtIOBlk<'static,VirtioHal>>);

impl BlockDevice for  VirtIOBlock {
    fn read_block(&self,block_id:usize,buf:&mut [u8]) {
        unsafe {
            self.0
                .lock()
                .read_block(block_id, buf)
                .expect("Error when reading VirtIOblk");
        }
    }
    fn write_block(&self,block_id:usize,buf:&[u8]) {
        unsafe{
            self.0
                .lock()
                .write_block(block_id, buf)
                .expect("Error when write VirtIOBlk");
        }
    }
}

impl VirtIOBlock {
    pub fn new() ->Self {
        unsafe{
            Self(
                Spin::new(VirtIOBlk::<VirtioHal>
                    ::new(&mut*(VIRTIO0 as *mut VirtIOHeader)).unwrap(), 
                            "VirIoBlk"))
        }
    }
}


// impl QueueFrames {
//     pub const fn new() -> Self{
//         Self { stack: Spin::new(Vec::new(),"vir_blk_lock") }
//     }
// }
impl Hal for VirtioHal {

    fn dma_alloc(pages: usize) -> virtio_drivers::PhysAddr {
        let mut addr_base:usize = 0;
        for i in 0..pages {
            let gurd:AllocerGuard;
            gurd = FRAME_ALLOC.page_alloc();
            if i == 0 {
                addr_base = gurd.pages.0;
            }
            unsafe {
                //info!("gurd {:#x}",gurd.pages.0);
                QUEUE_FRAMES.lock().push(gurd);
            }          
        }
        addr_base
    }
    fn dma_dealloc(paddr: virtio_drivers::PhysAddr, pages: usize) -> i32 {
        let mut pa = paddr;
        for _  in 0..pages {
            FRAME_ALLOC.page_dealloc(pa.into());
            pa += PGSZ
        }
        0
    }
    fn phys_to_virt(paddr: virtio_drivers::PhysAddr) -> virtio_drivers::VirtAddr {
        paddr
    }

    fn virt_to_phys(vaddr: virtio_drivers::VirtAddr) -> virtio_drivers::PhysAddr {
        let mut pagetable = PageTable::create(PGTBIT.root_addr());
        //println!("runhere ");
        if let Some(pa) = pagetable.walk_addr(vaddr){
            println!("runhere ");
            vaddr
        }else {
            panic!("this addr is not map or can't use")   
        } 
    }
}