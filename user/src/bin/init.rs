#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{exec,fork};

#[no_mangle]
fn main() -> i32 {
    println!("init run!!!");
    let fork_ret = fork();
    if fork_ret == 0{
        exec("hello_world\0");
    }else{
        println!("parent !!!");
        loop{}
    }
    0
}
