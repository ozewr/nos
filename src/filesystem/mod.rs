pub mod fs;
pub mod inode;
pub mod stdio;
use core::f32::INFINITY;

use crate::{info, page_alloc::UserBuffer};
use alloc::sync::Arc;
use easy_fs::BlockDevice;
use fs::QUEUE_FRAMES;
use fs::*;
use lazy_static::*;
pub trait File: Send + Sync {
    fn readable(&self) -> bool;
    fn writable(&self) -> bool;

    fn read(&self, buf: UserBuffer) -> usize;
    fn write(&self, buf: UserBuffer) -> usize;
}

lazy_static! {
    pub static ref BLOCK_DEVICE: Arc<dyn BlockDevice> = Arc::new(BlockDeviceImpl::new());
}

#[allow(unused)]
pub fn block_device_test() {
    let block_device = BLOCK_DEVICE.clone();
    let mut write_buffer = [0u8; 512];
    let mut read_buffer = [0u8; 512];
    for i in 0..512 {
        for byte in write_buffer.iter_mut() {
            *byte = i as u8;
        }
        //block_device.write_block(i as usize, &mut write_buffer);
        block_device.read_block(i as usize, &mut read_buffer);
        assert_eq!(write_buffer, read_buffer);
    }
    info!("block device test passed!");
}
