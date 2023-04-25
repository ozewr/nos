use buddy_system_allocator::LockedHeap;
use crate::memlayout::PHYSTOP;

const HEAP_SIZE :usize =0x30_0000;
// use crate::config::KERNEL_HEAP_SIZE;
#[global_allocator]
static HEAP_ALLOCATOR: LockedHeap = LockedHeap::empty();

static mut HEAP_SPACE: [u8; HEAP_SIZE] = [0; HEAP_SIZE];
pub fn init_heap() {
    unsafe {
        HEAP_ALLOCATOR
            .lock()
            .init(HEAP_SPACE.as_ptr() as usize, HEAP_SIZE);
    }
}