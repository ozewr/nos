// Gets the bytes of the value.
//
// as_bytes() provides access to the bytes of the value as an immutable
// byte slice.
//
// # Safety:
// If the memory layout of T is fixed
pub unsafe fn as_bytes<T: ?Sized>(refs: &T) -> &[u8] {
    let len = core::mem::size_of_val(refs);
    core::slice::from_raw_parts(refs as *const T as *const u8, len)
}

// Gets the bytes of the value mutably.
//
// as_bytes_mut() provides access to the bytes of the value as a mutable
// byte slice.
//
// # Safety:
// If the memory layout of T is fixed
pub unsafe fn as_bytes_mut<T: ?Sized>(refs: &mut T) -> &mut [u8] {
    let len = core::mem::size_of_val(refs);
    core::slice::from_raw_parts_mut(refs as *mut T as *mut u8, len)
}

// Array Macro for const variables
pub use core::mem::{ManuallyDrop, MaybeUninit};

#[repr(C)]
pub union _transmuter<T, const N: usize> {
    pub arr_in: ManuallyDrop<[MaybeUninit<T>; N]>,
    pub arr_out: ManuallyDrop<[T; N]>,
}

#[macro_export]
macro_rules! array {
    [$e:expr; $count:expr] => {
        unsafe {
            use crate::utils::{ManuallyDrop, MaybeUninit, _transmuter};

            let mut arr_in: [MaybeUninit<_>; $count] = MaybeUninit::uninit().assume_init();
            let mut idx = 0;
            while idx < $count {
                arr_in[idx] = MaybeUninit::new($e);
                idx += 1;
            }
            ManuallyDrop::into_inner(_transmuter { arr_in: ManuallyDrop::new(arr_in) }.arr_out)
        }
    };
}

//some useful function
use crate::{info,debug,println,error, memlayout::{TRAMPOLINE, TRAPFRAME}};
pub fn clear_bss(){
    extern "C"{
        fn sbss();
        fn ebss();
    }
    (
        sbss as usize..ebss as usize).for_each(|a|{
            unsafe{
                (a as *mut u8).write_volatile(0)
            }
        }
    )
}


// #[macro_export]
// macro_rules! debug {
//     ($fmt: literal $(, $($arg: tt)+)?) => {
//         #[cfg(feature = "debug")]
//         $crate::console::print(format_args!(concat!("\x1b[34m[DEBUG]:",concat!($fmt,"\x1b[0m\n")) $(, $($arg)+)?))
//     }
// }


#[allow(unused)]
pub fn print_info(){
    extern "C"{
        fn stext();
        fn etext();
        fn srodata();
        fn erodata();
        fn sdata();
        fn edata();
        fn ekernel();
        fn skernel();
        fn trampoline();
        fn trapframe();
    }
    info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
    info!(".trampoline [{:#x})", TRAMPOLINE);
    info!(".tramframe [{:#x})", TRAPFRAME as usize);
    info!(".ekernel [{:#x}, {:#x})", skernel as usize, ekernel as usize);
    debug!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
    error!(".data [{:#x}, {:#x})", sdata as usize, edata as usize); 
}