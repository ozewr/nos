#![allow(unused)]
use crate::{sbi::consele_putchar,};
use core::{fmt::{self,Write, Arguments},};


struct Ptcr;

impl Write for Ptcr {
    fn write_str(&mut self,s:&str) -> fmt::Result{
        for c in s.chars(){
            consele_putchar(c as usize);
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {
    Ptcr.write_fmt(args).unwrap();
}

#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?));
    }
}
pub fn info(args:fmt::Arguments){
    
    print!("\x1b[34m");
    print!("[INFO]:");
    Ptcr.write_fmt(args).unwrap();
    print!("\x1b[0m");
    print!("\n")
}

pub fn debug(args:fmt::Arguments){
    print!("\x1b[32m");
    print!("[DEBUG]:");
    Ptcr.write_fmt(args).unwrap();
    print!("\x1b[0m");
    print!("\n")
}

pub fn error(args:fmt::Arguments){
    print!("\x1b[31m");
    print!("[ERROR]:");
    Ptcr.write_fmt(args).unwrap();
    print!("\x1b[0m");
    print!("\n")
}

#[macro_export]
macro_rules! info {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::info(format_args!($fmt $(, $($arg)+)?));
    }
}
#[macro_export]
macro_rules! error {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::error(format_args!($fmt $(, $($arg)+)?));
    }
}
#[macro_export]
macro_rules! debug {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::debug(format_args!($fmt $(, $($arg)+)?));
    }
}

