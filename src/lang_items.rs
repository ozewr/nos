
use core::{panic::{PanicInfo}};

use crate::{println, sbi::shutdown, info};

#[panic_handler]

fn panic(_info: &PanicInfo) -> ! {
    if let Some(location) = _info.location(){
        println!(
            "panic at {}:{} {}",
            location.file(),
            location.line(),
            _info.message().unwrap()
        )
    }else{
        println!("panic:{}",_info.message().unwrap())
    }
    //shutdown();
    loop{};
}

#[alloc_error_handler]
pub fn handle_alloc_error(layout: core::alloc::Layout) -> ! {
    panic!("Heap allocation error, layout = {:?}", layout);
}

