#![no_std]
#![no_main]

#[macro_use]
extern crate user_lib;

use user_lib::{exec, fork};

#[no_mangle]
fn main() -> i32 {
    println!("init run!!!");
    for i in 0..2 {
        let fork_ret = fork();
        if fork_ret == 0 {
            println!("child{}",i);
            exec("hello_world\0");
            loop{}
        }
        else {
            println!("parent !!!");
            //loop {}
            continue;
        }
    }
    0
}
