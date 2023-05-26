#![no_std]
#![no_main]


extern crate user_lib;
use user_lib::println;
/// 正确输出：
/// Hello world from user mode program!

#[no_mangle]
fn main() -> i32 {
    println!("Hello, world from user mode program!");
    0
}
