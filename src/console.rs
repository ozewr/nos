#![allow(unused)]
use core::panic;

use crate::{sbi::consele_putchar, cpu::CPUS,};
use core::{fmt::{self,Write, Arguments},};

use crate::sync::spin::Spin;
use core::sync::atomic::{AtomicBool, Ordering};

pub static  PTCR:Ptcr = Ptcr{
    writer: Spin::new(Writer, "Pctr"),
    locking : AtomicBool::new(true),
    panicked : AtomicBool::new(false),
};
struct Writer;
pub struct Ptcr{
    writer:Spin<Writer>,
    locking:AtomicBool,
    panicked:AtomicBool,
}

impl Ptcr {
    pub fn panicked(&self) -> &AtomicBool {
        &self.panicked
    }
}

impl Write for Writer {
    fn write_str(&mut self,s:&str) -> fmt::Result{
        for c in s.chars(){
            consele_putchar(c as usize);
            // ptuc_sync(c as usize);
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {
    //Writer.write_fmt(args).unwrap();
    use fmt::Write;
    if PTCR.locking.load(Ordering::Acquire){
        unsafe {PTCR.writer.lock().write_fmt(args).expect("print error");}
    }
    //else {
        //for panic??
    //}
}

#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?))
    }
}

#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
    }
}

#[macro_export]
macro_rules! info {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!("\x1b[34m[INFO]:",concat!($fmt,"\x1b[0m\n")) $(, $($arg)+)?))
    }
}

#[macro_export]
macro_rules! debug {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!("\x1b[32m[DEBUG]:",concat!($fmt,"\x1b[0m\n")) $(, $($arg)+)?))
    }
}

#[macro_export]
macro_rules! error {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!("\x1b[31m[DEBUG]:",concat!($fmt,"\x1b[0m\n")) $(, $($arg)+)?))
    }
}

// #[panic_handler]
// fn panic(info: &panic::PanicInfo<'_>) -> ! {
//     //PTCR.locking.store(false, Ordering::Relaxed);
//     crate::println!("{}", info);
//     //PTCR.panicked.store(true, Ordering::Release);
//     loop {}
// }
