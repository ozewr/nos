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

## day5

实现了虚拟化

src
├── batch.rs  
├── console.rs  
├── cpu.rs  
├── entry.s  
├── kalloc.rs                        (new file)  
├── lang_items.rs                        
├── link_app.s  
├── linker.ld  
├── main.rs  
├── memlayout.rs                (new file )  
├── page_alloc.rs                   (new file)  
├── riscv.rs  
├── sbi.rs  
├── sync  
│   ├── mod.rs  
│   ├── spin.rs  
│   └── up.rs  
├── syscall  
│   ├── fs.rs  
│   └── mod.rs  
├── thread.rs                      
├── trap  
│   ├── context.rs  
│   ├── mod.rs  
│   └── trap.s  
├── utils.rs  
└── vm.rs                            (new file)   

主要添加的文件 ：

kalloc.rs内核的堆内存分配，用的是别人的包 在 *Cargo.toml* 中引用

buddy_system_allocator = "0.6"

具体使用方法可以看教程 

[Rust 中的动态内存分配 - rCore-Tutorial-Book-v3 3.6.0-alpha.1 文档](http://rcore-os.cn/rCore-Tutorial-Book-v3/chapter4/1rust-dynamic-allocation.html)

接下来是虚拟化的主要的两个文件

page_alloc.rs和vm.rs

page_alloc.rs 中定义了如何分配一个页。

vm.rs 中是映射函数。

### page_alloc.rs

如果是按照c语言，可以创建一个free链表，然后将所有内存按页大小分配到这个链表里面。但是由于rust的特性无法直接把一个数当成地址访问，所以需要折中一下，并且可以利用rust的gc机制让内存管理变得更简单。

我的做法是 在StackFrame结构体里面将内核结束后的地址和物理地址允许的最高地址记录下来，然后当我们需要一个页的时候得到一个地址，然后再利用core::slice里面的函数将其变化为一个可以访问的地址。

里面还有一个free栈，当一个地址被释放后，直接进入free栈，（不直接减去current的原因是可能不是顺序的）。然后申请的时候先看free里面有没有被释放的页，如果有那么先使用这里的。（并没有实现如页耗尽的处理方法，我直接panic退出）。

我分配一个页的时候没有直接分配一个地址，而是将这个地址和一个结构体  AllocerGuard绑定，这样当分配一个页时，是分配一个AllocerFuard结构体，当AllocerFuard生命周期耗尽的时候，在drop函数里面可以将这个页放入free栈。这样就不用手动free了。

然后再把FarmeAllocer用自旋锁封装一下，以避免出现争用和实现内部可变性（实际上也是rust语法必须的：要么只有多个不可变引用，要么只有一个可变引用）。这里也可以不用自旋锁封装，也可以用sync的UPsafeCell封装，效果应该是一样的。

这样分配一个页的功能就实现好了，具体的流程是

```rust
//FARME_ALLOC分配器调用自己的分配函数，然后
//此分配函数调用分配器里面的真正分配器StackFrame分配一个页
//然后传入AllocerGuard，让他创建一个结构体。
FARME_AllOC.page_alloc()->FARME_ALLOC.allocer.alloc()->AllocerGuard::new()
```

### vm.rs

然后关注 vm.rs

前面的那么多结构体，我是跟着教程抄的，实际上我真正用只用到了PhyPageNum。

所以那么多可以直接不关注，直接看最重要的两个结构体。

PhyPageNum：

这个PhyPageNum结构体只封装了一个usize, 实际上我觉得直接用usize也行，没有面向对象的思想的话，可能会麻烦点。看起来也会麻烦点，感觉这里用这个结构体相当于typedef一样。这个结构体是页号的意思，将剩下的内存按页管理，每一个页的起始地址就是这个PhyPageNum里面的usize。(也可以说是PhyPageNum)

PageTable：

这个就是页表结构体，里面封装了一个PhyPageNum和一个AllocerGuard的页表栈，PhyPageNum是根页表所在的位置，而页表栈是为了也分配器分配的页不被回收掉（因为rust的gc机制，所以需要保存）

#### PhyPageNum

里面封装了三个重要的函数

第一个：get_pte_array():这个函数是将一个usize的地址转化成一个PhyPageNum数组。这样这个地址就可以当成一个页表来访问。相当于c语言里面的(pte*)ptr。这个pte参照xv6里面的pte。

第二个：get_bytes_array():这个是得将一个uszie的地址转化成一个u8的数组，其实就是得到这个页，相当于c语言里面的 (char*) ptr。

第三个：get_mut():这个函数是得到一个不指定类型的裸指针，可以在外面指定它的类型。我还暂时没用到

（这三个函数是抄的）

 [管理 SV39 多级页表 - rCore-Tutorial-Book-v3 3.6.0-alpha.1 文档](http://rcore-os.cn/rCore-Tutorial-Book-v3/chapter4/4sv39-implementation-2.html)在这个文档的“内核中访问物理页帧的方法”里面。

#### PageTable

页结构体里面封装了映射方法。

最重要的函数有两个 一个是mappages()一个是walk()。

先说walk函数

walk函数返回一个PhyPageNum数组，这个数组可以理解成一个页表，他的目的是找到这个虚拟地址的最底层页表，然后返回上一层页表。（实际上在循环中已经找到了这个最底层页表，但是由于rust的限制，我无法返回这个页表的准确地址，只能返回一个数组，然后在mappages中重新再找到这个页表，不过可能是我当时没尝试对，但是现在能跑，写的我脑壳痛，先这样吧，到时候再来改（大概率不会改？？）。）

在这个函数里面，首先将传入的PhyPageNum转化成一个页表，然后在循环中依次访问每一级页表。最后得到最底层的页表。

注意在这里通过FRAME_AllPC分配得到的页需要保存起来，不然这个函数结束就释放掉了。

而之间的一些位操作是为了转换实际的物理地址和页表项。（对了，在一个页被申请的时候，内部的数据已经被清0了，在AllocerGuard::new()里面实现的。）而temp_store 和page_arry这两个都是为了绕过生命周期的限制。

然后是mappages函数

在walk函数里面找到上一层的页表之后，在map中再找到实际的最底层页表，然后，在这个页表的对应的地址写上实际的物理地址（要经过转换 pa2pte）为了方便，虚拟地址是和实际地址一一对应的。这样硬件通过页表访问的时候就能访问到这个物理地址了。

最后需要把根页表填进satp寄存器，在kvminithart()函数里面，注意不能直接填写，要符合SV_39的格式，as_satp()函数里面我重新改变了下格式。

这样在main函数里面调用这个函数就可以了。

### 缺点

虽然能跑，但是也有很多缺点，由于最开始是跟着教程做，所以有一些代码是冗余的。而且pagetable结构体也不是一个静态的，所以每个线程初始化的时候都需要重新初始化，又浪费空间又麻烦。然后呢由于堆空间是直接在内核里面的，我有点不好映射堆的空间，导致我必须将内核空间全部映射成可读可写。还有肯定还有我没发现的缺点。而且我并没有实现如果在分页页的时候，页已经被分配完了的情况。

## day 6

接下来首先完成时钟中断的配置（1天），然后写文件系统（3天），然后写进程（3天），然后完成进程的多任务（3天）。
预计5月20号初步完成。

## day 7
明天开始先把文件系统实现了。


