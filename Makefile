K = target/riscv64gc-unknown-none-elf/debug

OBJDUMP = rust-objdump
OBJCOPY = rust-objcopy

QEMU = qemu-system-riscv64
QFLAGS = -nographic -m 128M -machine virt -smp 3
QFLAGS += -bios default

CFLAGS = --release
#bios/rustsbi-qemu.bin
all:
	@cargo xbuild 
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
	
.PHONY:qemu-gdb
qemu-gdb:all
	@echo "please link localhot::26000"
	@$(QEMU) $(QFLAGS) -kernel $K/os -S  -gdb tcp::26000
clean:
	rm $K/os.bin \
		$K/os \
		os.asm \
		os.sym \
