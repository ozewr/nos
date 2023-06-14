use crate::{sbi::sbi_console_get_char, cpu::CPUS, print, info};

use super::File;
pub struct Stdin;
pub struct Stdout;
impl File for Stdin {
    fn read(&self ,mut buf: crate::page_alloc::UserBuffer) -> usize {
        assert_eq!(buf.len(),1);
        let mut c:usize;
        loop {
            c = sbi_console_get_char();
            if c == 0xffffffffffffffff {
                let task = CPUS.my_proc().unwrap();
                task.yielding();
                continue;
            }else {
                break;
            }
        }
        let ch = c as u8;
        unsafe{
            buf.buffers[0].as_mut_ptr().write_volatile(ch);
            1
        }
    }
    fn write(&self ,buf:crate::page_alloc::UserBuffer) -> usize {
        panic!("can't write in Stdin");
    }
    fn readable(&self) -> bool {
        true
    }
    fn writable(&self) -> bool {
        true
    }
}

impl File for Stdout {
    fn readable(&self) -> bool {
        true
    }
    fn writable(&self) -> bool {
        true
    }
    fn read(&self ,buf: crate::page_alloc::UserBuffer) -> usize {
        panic!("stdout can't read");
    }
    fn write(&self ,buf:crate::page_alloc::UserBuffer) -> usize {
        for pbuffer in buf.buffers.iter(){
            let str = core::str::from_utf8(*pbuffer).unwrap();
            print!("{}",str);
        }
        buf.len()
    }
}