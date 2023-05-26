#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;
use user_lib::exec;
#[no_mangle]
pub fn main() -> i32 {
    println!("init run!!");
    exec("hello_world");
    0
}