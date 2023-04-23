# 开发日记

## day1：系统的启动

开发环境配置
.cargo/config cargo编译器的配置,指定了编译器和链接脚本。  
bootloader用的opensbi 没有用此文件目录下的 rustsbi。  
.vscode里面是vscode插件的配置。  

src：
    linker.ld：链接脚本（初始栈是放在bss段）。
    sbi.rs : sbi模块，里面是opensbi的接口函数。
    lang_items.rs： panic函数。
    console.rs:格式化输出的函数。
    entry.s:内核入口,主要工作是给每个线程分配一个2K大小的栈。




遇到的问题 
1.如果不用nightly版本，指定链接脚本的时候会出错。
2.当构建release版本的时候会出error信息（没有M模块，但是实际上是有的），用debug版本不会。release版本会对代码进行优化。在网上搜索后没有发现如何解决，可能是一个bug。
3.在没有std库的帮助下没法使用字符串类型。

## day3:
src
├── batch.rs        (new)
├── console.rs      
├── entry.s 
├── lang_items.rs
├── link_app.s      (new)      
├── linker.ld
├── main.rs
├── riscv.rs
├── sbi.rs
├── sync            (new)
│   ├── mod.rs      (new)
│   └── up.rs       (new)
├── syscall         (new)
│   ├── fs.rs       (new)
│   └── mod.rs      (new)
├── thread.rs
└── trap
    ├── context.rs  (new)
    ├── mod.rs      (new)
    └── trap.s      (new)
