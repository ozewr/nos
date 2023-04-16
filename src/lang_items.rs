use core::{panic::{PanicInfo}};

use crate::{println, sbi::shutdown};

#[panic_handler]

fn panic(_info: &PanicInfo) -> !{
    if let Some(location) = _info.location(){
        println!(
            "panic at {}:{} {}",
            location.file(),
            location.line(),
            _info.message().unwrap()
        );
    }else{
        println!("panic:{}",_info.message().unwrap());
    }
    shutdown();
}