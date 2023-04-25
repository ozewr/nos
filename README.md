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
    entry.s:内核入口,主要工作是给每个线程分配一个2K大小的栈  

遇到的问题 
1.如果不用nightly版本，指定链接脚本的时候会出错。  
2.当构建release版本的时候会出error信息（没有M模块，但是实际上是有的），用debug版 本不会。release版本会对代码进行优化。在网上搜索后没有发现如何解决，可能是一个  bug。  
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



## day4

写了一个自选锁，目前支持多核运行。  
src  
├── console.rs          (new src)  
├── cpu.rs                 (new file)  
├── entry.s  
├── lang_items.rs  
├── linker.ld  
├── main.rs  
├── riscv.rs                (new file)  
├── sbi.rs  
├── sync  
│ ├── mod.rs  
│ └── spin.rs           (new file)  
├── thread.rs          (new file)  
└── utils.rs (new file)  
自旋锁的主要实现是在src/sync/spin里面。 当引入多核的时候，多线程并行运行，他们共享内存数据，如果不加以限制，会导致内存变得不可控。  
自旋锁的实现参照了xv6的代码，并且参照了vmm.dev [[https://vmm.dev/]](https://vmm.dev/%5D) 的博客。

自选锁是当线程没有获取到锁的时候，会在原地一直循环，直到获得锁。离得近的一次运用是在print函数里面。  
如果不对print加锁，那么输出是不可控的。  

一个简单的自选锁的例子是     

```rust
Spin<T>{
    locked:bool,
    data:UnsafeCell<T>,
}

SpinGuard<'a , T: 'a>{
    spin:&'a Spin<T>,
}
impl for Spin{
    pub fn lock(&self) ->{
        let lk = unsafe { &mut *self.locked.get() };
        loop{
            if !*lk {
                *lk = true;
                break SpinGuard {
                    mutex: self
                }
        }
    }
}
```

rust语法点：UnsafeCell,Cell,RefCell  
Cell:  
在rust的借用规则里面，只允许同时存在多个不可变借用，或者一个可变借用。  
但是我们有时候又需要在不同的地方写值，或者写一个不可变引用里面的值。  
这个时候rust的内部可变性就派上了用场。例如'Struct Test{num:Cell，data:i32}' 就算Test创建的是一个不可变引用，我们也可以改变内部的num字段（利用.set()）。 Cell需要copy特性来管理。  

RefCell:  
RefCell可以在没有实现copy trait的情况下使用。RefCell使用的时候，会让借用规则推迟到运行时再检查。也就是说这是一种绕过编译器的方法，我门需要保证写的代码在运行时，符合借用规则。

RefCell 简单总结  
与 Cell 用于可 Copy 的值不同，RefCell 用于引用  
RefCell 只是将借用规则从编译期推迟到程序运行期，并不能帮你绕过这个规则  
RefCell 适用于编译期误报或者一个引用被在多处代码使用、修改以至于难于管理借用关系时  
使用 RefCell 时，违背借用规则会导致运行期的 panic

UnSafeCell：  
UnSafeCell比较强大，它告诉编译器，即使存在不可变应用例如'Struct Test{num:UnsafeCell}' 就算Test创建的是一个不可变引用，也可以改变它。并且不需要copy特性。

在这里，我们直接使用了UnSafeCell(我认为RefCell也可以)。  
因为rust在创建静态变量的时候，是不允许创建带有mut关键字的。所以我们需要创建不可变的类型然后用rust的内部可变性来修改内部的值。

回到自旋锁，当我们获得锁后得到一个SpinFuard的结构体，可以通过它访问内部数据，并且，它只要存在锁就一直存在，当他被释放掉时，我们同时解开锁，这样就可以只考虑该在哪上锁而不用考虑在哪里解锁了。
但是if并不能保证我们能够原子的运行。 所以需要rust自带的原子的函数。这个函数在core::atomic里面。注意我们还要在这个函数内部设置指令的访问顺序。

稍作修改就变成了代码里面的样子。

保守的自旋锁：  
设想一个这样的情况。当一个线程获取锁，正在运行，此时另一个线程突然中断，打断此线程的运行，而这个线程，也需要这把锁，但是锁还没被释放。那么就会导致死锁的问题。所以我们直接简单的在自旋锁获取后，直接禁用中断，以防止这种情况的发生。当然还有其他的更好的办法，不过为了简单。  

一个好的做法是为每个cpu维持一个计数，然后在计数为0的时候开启中断，当计数不为0时关闭中断。一个好的方法是为cpu实现一个中断锁，当上锁的时候引用计数+1,当锁释放的时候，引用计数减1。我们在调用自旋锁之前，先要上中断锁。  
