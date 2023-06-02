K = target/riscv64gc-unknown-none-elf/debug
#FS_IMG := ../easy-fs-crate/target/fs.img
FS_IMG = ./user/target/riscv64gc-unknown-none-elf/release/fs.img
OBJDUMP = rust-objdump
OBJCOPY = rust-objcopy

QEMU = qemu-system-riscv64
QFLAGS = -nographic -m 128M -machine virt -smp 1
QFLAGS += -bios default
QFLAGS += -drive file=$(FS_IMG),if=none,format=raw,id=x0
QFLAGS += -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 

CFLAGS = --release 

all:
	@make -C user
	@echo "make user"
	@cargo xbuild --features debug
	@echo "building ..."
	@$(OBJDUMP) -S $K/os > os.asm
	@echo "make asm file ..."
	@$(OBJDUMP) -t $K/os | sed '1,/SYMBOL TABLE/d;s/ .* / /; /^$$/d' > os.sym
	@echo "make symbal file ..."
.PHONY:qemu
qemu:all
	@$(OBJCOPY) --strip-all $K/os -O binary $K/os.bin

	@echo "qemu start"
	@$(QEMU) $(QFLAGS) -kernel $K/os.bin

qemu-out:all
	@$(OBJCOPY) --strip-all $K/os -O binary $K/os.bin
	@echo "qemu start"
	@$(QEMU) $(QFLAGS) -kernel $K/os.bin > qemu_output.txt
output:
	python output.py
.PHONY:qemu-gdb add
qemu-gdb:all
	@echo "please link localhot::26000"
	@$(QEMU) $(QFLAGS) -kernel $K/os -S  -gdb tcp::26000
file : 
	./easy-fs-fuse -s ./user/src/bin/ -t ./user/target/riscv64gc-unknown-none-elf/release/
ufile :
	make clean -C user
	make -C user
	make file
add:
	cargo clean
	git add  src user Cargo.lock Cargo.toml Makefile README.md .cargo 
clean:
	cargo clean 
	make clean -C user 
	rm	os.asm \
		os.sym \
