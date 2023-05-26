use core::task;

use crate::{cpu::CPUS, filesystem::{inode::{open_file, READONLY}, File}, trap::usertarpret, info};




pub fn sys_yield() -> isize{
    todo!()
}

pub fn sys_exit() ->! {
    todo!()
}

pub fn sys_exec(path :*const u8) -> isize {
    let task = CPUS.my_proc().unwrap();
    let path = task.inner_mut().pagetable().translated_str(path);
    if let Some(app_inode) = open_file(path.as_str(), READONLY){
        //info!("run here");
        //unsafe {info!("id {}",app_inode.rl_inode.lock().inode.block_id)}
        let all_data = app_inode.read_all();
        // info!("run here");
        task.exec(all_data.as_slice());
        usertarpret();
        0
    }else {
        panic!("run here")
        //-1
    }
}
pub fn sys_init() -> isize{
    let task = unsafe {CPUS.my_cpu().task.as_mut().unwrap()};
    let path = "init";
    if let Some(app_inode) = open_file(path, READONLY){
        let all_data = app_inode.read_all();
        task.exec(all_data.as_slice());
        usertarpret();
        0
    }else {
        -1
    }
}
