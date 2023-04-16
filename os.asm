
target/riscv64gc-unknown-none-elf/debug/os:	file format elf64-littleriscv

Disassembly of section .text:

0000000080200000 <stext>:
80200000: 33 02 a5 00  	add	tp, a0, a0

0000000080200004 <.Lpcrel_hi0>:
80200004: 17 51 00 00  	auipc	sp, 5
80200008: 13 01 c1 ff  	addi	sp, sp, -4
8020000c: 89 62        	lui	t0, 2
8020000e: 05 05        	addi	a0, a0, 1
80200010: 33 05 55 02  	mul	a0, a0, t0
80200014: 2a 91        	add	sp, sp, a0
80200016: 97 10 00 00  	auipc	ra, 1
8020001a: e7 80 a0 da  	jalr	-598(ra)

000000008020001e <rust_begin_unwind>:
; fn panic(_info: &PanicInfo) -> !{
8020001e: 69 71        	addi	sp, sp, -304
80200020: 06 f6        	sd	ra, 296(sp)
80200022: 22 f2        	sd	s0, 288(sp)
80200024: 00 1a        	addi	s0, sp, 304
80200026: 23 34 a4 f0  	sd	a0, -248(s0)
8020002a: 23 30 a4 fe  	sd	a0, -32(s0)
;     if let Some(location) = _info.location(){
8020002e: 97 20 00 00  	auipc	ra, 2
80200032: e7 80 00 77  	jalr	1904(ra)
80200036: 23 38 a4 f0  	sd	a0, -240(s0)
8020003a: 03 35 04 f1  	ld	a0, -240(s0)
8020003e: 79 cd        	beqz	a0, 0x8020011c <.Lpcrel_hi1+0x2e>
80200040: 09 a0        	j	0x80200042 <rust_begin_unwind+0x24>
80200042: 03 35 04 f1  	ld	a0, -240(s0)
80200046: 23 3c a4 ec  	sd	a0, -296(s0)
8020004a: 23 34 a4 fe  	sd	a0, -24(s0)
;             location.file(),
8020004e: 97 00 00 00  	auipc	ra, 0
80200052: e7 80 c0 24  	jalr	588(ra)
80200056: 23 30 b4 f8  	sd	a1, -128(s0)
8020005a: 23 3c a4 f6  	sd	a0, -136(s0)
8020005e: 13 05 84 f7  	addi	a0, s0, -136
;         println!(
80200062: 97 00 00 00  	auipc	ra, 0
80200066: e7 80 80 6b  	jalr	1720(ra)
8020006a: 2a 86        	mv	a2, a0
8020006c: 03 35 84 ed  	ld	a0, -296(s0)
80200070: 23 30 c4 ee  	sd	a2, -288(s0)
;             location.line(),
80200074: 23 34 b4 ee  	sd	a1, -280(s0)
80200078: 97 00 00 00  	auipc	ra, 0
8020007c: e7 80 c0 23  	jalr	572(ra)
80200080: 23 26 a4 f8  	sw	a0, -116(s0)
80200084: 13 05 c4 f8  	addi	a0, s0, -116
;         println!(
80200088: 97 00 00 00  	auipc	ra, 0
8020008c: e7 80 00 66  	jalr	1632(ra)
80200090: 2a 86        	mv	a2, a0
80200092: 03 35 84 f0  	ld	a0, -248(s0)
80200096: 23 38 c4 ee  	sd	a2, -272(s0)
;             _info.message().unwrap()
8020009a: 23 3c b4 ee  	sd	a1, -264(s0)
8020009e: 97 20 00 00  	auipc	ra, 2
802000a2: e7 80 c0 6f  	jalr	1788(ra)

00000000802000a6 <.Lpcrel_hi0>:
802000a6: 97 35 00 00  	auipc	a1, 3
802000aa: 93 85 25 00  	addi	a1, a1, 2
802000ae: 97 00 00 00  	auipc	ra, 0
802000b2: e7 80 00 14  	jalr	320(ra)
802000b6: 23 38 a4 f8  	sd	a0, -112(s0)
802000ba: 13 05 04 f9  	addi	a0, s0, -112
;         println!(
802000be: 97 00 00 00  	auipc	ra, 0
802000c2: e7 80 e0 68  	jalr	1678(ra)
802000c6: 83 37 04 ee  	ld	a5, -288(s0)
802000ca: 03 37 84 ee  	ld	a4, -280(s0)
802000ce: 83 36 04 ef  	ld	a3, -272(s0)
802000d2: 03 36 84 ef  	ld	a2, -264(s0)
802000d6: 23 34 f4 f4  	sd	a5, -184(s0)
802000da: 23 38 e4 f4  	sd	a4, -176(s0)
802000de: 23 3c d4 f4  	sd	a3, -168(s0)
802000e2: 23 30 c4 f6  	sd	a2, -160(s0)
802000e6: 23 34 a4 f6  	sd	a0, -152(s0)
802000ea: 23 38 b4 f6  	sd	a1, -144(s0)

00000000802000ee <.Lpcrel_hi1>:
802000ee: 17 35 00 00  	auipc	a0, 3
802000f2: 93 05 a5 f7  	addi	a1, a0, -134
802000f6: 13 05 84 f1  	addi	a0, s0, -232
802000fa: 23 30 a4 f0  	sd	a0, -256(s0)
802000fe: 11 46        	li	a2, 4
80200100: 93 06 84 f4  	addi	a3, s0, -184
80200104: 0d 47        	li	a4, 3
80200106: 97 10 00 00  	auipc	ra, 1
8020010a: e7 80 80 9c  	jalr	-1592(ra)
8020010e: 03 35 04 f0  	ld	a0, -256(s0)
80200112: 97 10 00 00  	auipc	ra, 1
80200116: e7 80 e0 4f  	jalr	1278(ra)
8020011a: 95 a0        	j	0x8020017e <.Lpcrel_hi3+0x2e>
;         println!("panic:{}",_info.message().unwrap());
8020011c: 03 35 84 f0  	ld	a0, -248(s0)
80200120: 97 20 00 00  	auipc	ra, 2
80200124: e7 80 a0 67  	jalr	1658(ra)

0000000080200128 <.Lpcrel_hi2>:
80200128: 97 35 00 00  	auipc	a1, 3
8020012c: 93 85 85 f1  	addi	a1, a1, -232
80200130: 97 00 00 00  	auipc	ra, 0
80200134: e7 80 e0 0b  	jalr	190(ra)
80200138: 23 3c a4 fc  	sd	a0, -40(s0)
8020013c: 13 05 84 fd  	addi	a0, s0, -40
80200140: 97 00 00 00  	auipc	ra, 0
80200144: e7 80 c0 60  	jalr	1548(ra)
80200148: 23 34 a4 fc  	sd	a0, -56(s0)
8020014c: 23 38 b4 fc  	sd	a1, -48(s0)

0000000080200150 <.Lpcrel_hi3>:
80200150: 17 35 00 00  	auipc	a0, 3
80200154: 93 05 85 eb  	addi	a1, a0, -328
80200158: 13 05 84 f9  	addi	a0, s0, -104
8020015c: 23 38 a4 ec  	sd	a0, -304(s0)
80200160: 09 46        	li	a2, 2
80200162: 93 06 84 fc  	addi	a3, s0, -56
80200166: 05 47        	li	a4, 1
80200168: 97 10 00 00  	auipc	ra, 1
8020016c: e7 80 60 96  	jalr	-1690(ra)
80200170: 03 35 04 ed  	ld	a0, -304(s0)
80200174: 97 10 00 00  	auipc	ra, 1
80200178: e7 80 c0 49  	jalr	1180(ra)
8020017c: 09 a0        	j	0x8020017e <.Lpcrel_hi3+0x2e>
;     shutdown();
8020017e: 97 00 00 00  	auipc	ra, 0
80200182: e7 80 20 35  	jalr	850(ra)
80200186: 00 00        	unimp	

0000000080200188 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE>:
;     pub const fn map<U, F>(self, f: F) -> Option<U>
80200188: 79 71        	addi	sp, sp, -48
8020018a: 06 f4        	sd	ra, 40(sp)
8020018c: 22 f0        	sd	s0, 32(sp)
8020018e: 00 18        	addi	s0, sp, 48
80200190: 23 28 a4 fc  	sw	a0, -48(s0)
80200194: 23 2a b4 fc  	sw	a1, -44(s0)
80200198: 05 45        	li	a0, 1
;         match self {
8020019a: a3 03 a4 fe  	sb	a0, -25(s0)
8020019e: 03 25 04 fd  	lw	a0, -48(s0)
802001a2: 19 e5        	bnez	a0, 0x802001b0 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x28>
802001a4: 09 a0        	j	0x802001a6 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x1e>
802001a6: 37 05 11 00  	lui	a0, 272
;             None => None,
802001aa: 23 2e a4 fc  	sw	a0, -36(s0)
802001ae: 25 a0        	j	0x802001d6 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x4e>
;             Some(x) => Some(f(x)),
802001b0: 03 25 44 fd  	lw	a0, -44(s0)
802001b4: 23 26 a4 fe  	sw	a0, -20(s0)
802001b8: 81 45        	li	a1, 0
802001ba: a3 03 b4 fe  	sb	a1, -25(s0)
802001be: 23 20 a4 fe  	sw	a0, -32(s0)
802001c2: 03 25 04 fe  	lw	a0, -32(s0)
802001c6: 97 00 00 00  	auipc	ra, 0
802001ca: e7 80 00 38  	jalr	896(ra)
802001ce: 7d 99        	andi	a0, a0, -1
802001d0: 23 2e a4 fc  	sw	a0, -36(s0)
802001d4: 09 a0        	j	0x802001d6 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x4e>
;     }
802001d6: 03 45 74 fe  	lbu	a0, -25(s0)
802001da: 05 89        	andi	a0, a0, 1
802001dc: 01 e9        	bnez	a0, 0x802001ec <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x64>
802001de: 09 a0        	j	0x802001e0 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x58>
802001e0: 03 25 c4 fd  	lw	a0, -36(s0)
802001e4: a2 70        	ld	ra, 40(sp)
802001e6: 02 74        	ld	s0, 32(sp)
802001e8: 45 61        	addi	sp, sp, 48
802001ea: 82 80        	ret
802001ec: d5 bf        	j	0x802001e0 <_ZN4core6option15Option$LT$T$GT$3map17h378299d0aca07a8dE+0x58>

00000000802001ee <_ZN4core6option15Option$LT$T$GT$6unwrap17hda1b80d1e70b3a34E>:
;     pub const fn unwrap(self) -> T {
802001ee: 79 71        	addi	sp, sp, -48
802001f0: 06 f4        	sd	ra, 40(sp)
802001f2: 22 f0        	sd	s0, 32(sp)
802001f4: 00 18        	addi	s0, sp, 48
802001f6: 23 3c b4 fc  	sd	a1, -40(s0)
802001fa: 23 30 a4 fe  	sd	a0, -32(s0)
;         match self {
802001fe: 03 35 04 fe  	ld	a0, -32(s0)
80200202: 19 ed        	bnez	a0, 0x80200220 <.Lpcrel_hi0+0x16>
80200204: 09 a0        	j	0x80200206 <_ZN4core6option15Option$LT$T$GT$6unwrap17hda1b80d1e70b3a34E+0x18>
;             None => panic("called `Option::unwrap()` on a `None` value"),
80200206: 03 36 84 fd  	ld	a2, -40(s0)

000000008020020a <.Lpcrel_hi0>:
8020020a: 17 35 00 00  	auipc	a0, 3
8020020e: 13 05 65 eb  	addi	a0, a0, -330
80200212: 93 05 b0 02  	li	a1, 43
80200216: 97 20 00 00  	auipc	ra, 2
8020021a: e7 80 80 31  	jalr	792(ra)
8020021e: 00 00        	unimp	
;             Some(val) => val,
80200220: 03 35 04 fe  	ld	a0, -32(s0)
80200224: 23 34 a4 fe  	sd	a0, -24(s0)
;     }
80200228: a2 70        	ld	ra, 40(sp)
8020022a: 02 74        	ld	s0, 32(sp)
8020022c: 45 61        	addi	sp, sp, 48
8020022e: 82 80        	ret

0000000080200230 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h6c69a8b4ff223eeaE>:
;     pub fn unwrap(self) -> T
80200230: 79 71        	addi	sp, sp, -48
80200232: 06 f4        	sd	ra, 40(sp)
80200234: 22 f0        	sd	s0, 32(sp)
80200236: 00 18        	addi	s0, sp, 48
80200238: 23 38 b4 fc  	sd	a1, -48(s0)
8020023c: a3 0f a4 fc  	sb	a0, -33(s0)
;         match self {
80200240: 03 45 f4 fd  	lbu	a0, -33(s0)
80200244: 05 89        	andi	a0, a0, 1
80200246: 11 e5        	bnez	a0, 0x80200252 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h6c69a8b4ff223eeaE+0x22>
80200248: 09 a0        	j	0x8020024a <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h6c69a8b4ff223eeaE+0x1a>
;     }
8020024a: a2 70        	ld	ra, 40(sp)
8020024c: 02 74        	ld	s0, 32(sp)
8020024e: 45 61        	addi	sp, sp, 48
80200250: 82 80        	ret
;             Err(e) => unwrap_failed("called `Result::unwrap()` on an `Err` value", &e),
80200252: 03 37 04 fd  	ld	a4, -48(s0)

0000000080200256 <.Lpcrel_hi0>:
80200256: 17 35 00 00  	auipc	a0, 3
8020025a: 13 05 55 e9  	addi	a0, a0, -363

000000008020025e <.Lpcrel_hi1>:
8020025e: 97 35 00 00  	auipc	a1, 3
80200262: 93 86 a5 eb  	addi	a3, a1, -326
80200266: 93 05 b0 02  	li	a1, 43
8020026a: 13 06 04 fe  	addi	a2, s0, -32
8020026e: 97 20 00 00  	auipc	ra, 2
80200272: e7 80 40 53  	jalr	1332(ra)
80200276: 00 00        	unimp	

0000000080200278 <_ZN49_$LT$usize$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h8aaba2f397fd7c9eE>:
;         unsafe fn forward_unchecked(start: Self, n: usize) -> Self {
80200278: 79 71        	addi	sp, sp, -48
8020027a: 06 f4        	sd	ra, 40(sp)
8020027c: 22 f0        	sd	s0, 32(sp)
8020027e: 00 18        	addi	s0, sp, 48
80200280: 23 3c a4 fc  	sd	a0, -40(s0)
80200284: 23 30 b4 fe  	sd	a1, -32(s0)
;             unsafe { intrinsics::unchecked_add(self, rhs) }
80200288: 2e 95        	add	a0, a0, a1
8020028a: 23 34 a4 fe  	sd	a0, -24(s0)
8020028e: 03 35 84 fe  	ld	a0, -24(s0)
;         }
80200292: a2 70        	ld	ra, 40(sp)
80200294: 02 74        	ld	s0, 32(sp)
80200296: 45 61        	addi	sp, sp, 48
80200298: 82 80        	ret

000000008020029a <_ZN4core5panic8location8Location4file17h355f1040b2d9c511E>:
;     pub const fn file(&self) -> &str {
8020029a: 01 11        	addi	sp, sp, -32
8020029c: 06 ec        	sd	ra, 24(sp)
8020029e: 22 e8        	sd	s0, 16(sp)
802002a0: 00 10        	addi	s0, sp, 32
802002a2: aa 85        	mv	a1, a0
802002a4: 23 34 b4 fe  	sd	a1, -24(s0)
;         self.file
802002a8: 88 61        	ld	a0, 0(a1)
802002aa: 8c 65        	ld	a1, 8(a1)
;     }
802002ac: e2 60        	ld	ra, 24(sp)
802002ae: 42 64        	ld	s0, 16(sp)
802002b0: 05 61        	addi	sp, sp, 32
802002b2: 82 80        	ret

00000000802002b4 <_ZN4core5panic8location8Location4line17hb141609839b9d3e0E>:
;     pub const fn line(&self) -> u32 {
802002b4: 01 11        	addi	sp, sp, -32
802002b6: 06 ec        	sd	ra, 24(sp)
802002b8: 22 e8        	sd	s0, 16(sp)
802002ba: 00 10        	addi	s0, sp, 32
802002bc: 23 34 a4 fe  	sd	a0, -24(s0)
;     }
802002c0: 08 49        	lw	a0, 16(a0)
802002c2: e2 60        	ld	ra, 24(sp)
802002c4: 42 64        	ld	s0, 16(sp)
802002c6: 05 61        	addi	sp, sp, 32
802002c8: 82 80        	ret

00000000802002ca <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h5eea7b0bd5f3fbf5E>:
;     pub(super) fn new(slice: &'a [T]) -> Self {
802002ca: 55 71        	addi	sp, sp, -208
802002cc: 86 e5        	sd	ra, 200(sp)
802002ce: a2 e1        	sd	s0, 192(sp)
802002d0: 80 09        	addi	s0, sp, 208
802002d2: 23 3c b4 f2  	sd	a1, -200(s0)
802002d6: 23 30 a4 f4  	sd	a0, -192(s0)
802002da: 23 34 a4 f8  	sd	a0, -120(s0)
802002de: 23 38 b4 f8  	sd	a1, -112(s0)
;         self as *const [T] as *const T
802002e2: 23 3c a4 f8  	sd	a0, -104(s0)
;         unsafe { const_eval_select((self as *const u8,), const_impl, runtime_impl) }
802002e6: 23 38 a4 f6  	sd	a0, -144(s0)
802002ea: 03 35 04 f7  	ld	a0, -144(s0)
802002ee: 23 30 a4 fa  	sd	a0, -96(s0)
802002f2: 01 45        	li	a0, 0
;                 if T::IS_ZST { ptr.wrapping_byte_add(slice.len()) } else { ptr.add(slice.len()) };
802002f4: 11 ed        	bnez	a0, 0x80200310 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h5eea7b0bd5f3fbf5E+0x46>
802002f6: 09 a0        	j	0x802002f8 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h5eea7b0bd5f3fbf5E+0x2e>
802002f8: 03 35 04 f4  	ld	a0, -192(s0)
802002fc: 83 35 84 f3  	ld	a1, -200(s0)
80200300: 23 3c b4 fc  	sd	a1, -40(s0)
;         unsafe { self.offset(count as isize) }
80200304: 23 30 b4 fe  	sd	a1, -32(s0)
;         unsafe { intrinsics::offset(self, count) }
80200308: 2e 95        	add	a0, a0, a1
8020030a: 23 30 a4 f6  	sd	a0, -160(s0)
;                 if T::IS_ZST { ptr.wrapping_byte_add(slice.len()) } else { ptr.add(slice.len()) };
8020030e: 3d a8        	j	0x8020034c <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h5eea7b0bd5f3fbf5E+0x82>
80200310: 03 35 04 f4  	ld	a0, -192(s0)
80200314: 83 35 84 f3  	ld	a1, -200(s0)
80200318: 23 34 b4 fa  	sd	a1, -88(s0)
;         self as _
8020031c: 23 38 a4 fa  	sd	a0, -80(s0)
;         self.wrapping_offset(count as isize)
80200320: 23 3c b4 fa  	sd	a1, -72(s0)
;         unsafe { intrinsics::arith_offset(self, count) }
80200324: 2e 95        	add	a0, a0, a1
80200326: 23 30 a4 fc  	sd	a0, -64(s0)
8020032a: 03 35 04 fc  	ld	a0, -64(s0)
8020032e: 23 34 a4 fc  	sd	a0, -56(s0)
;         from_raw_parts::<U>(self as *const (), metadata(meta))
80200332: 23 38 a4 fc  	sd	a0, -48(s0)
;     unsafe { PtrRepr { components: PtrComponents { data_address, metadata } }.const_ptr }
80200336: 23 30 a4 f8  	sd	a0, -128(s0)
8020033a: 03 35 04 f8  	ld	a0, -128(s0)
8020033e: 23 3c a4 f6  	sd	a0, -136(s0)
80200342: 03 35 84 f7  	ld	a0, -136(s0)
80200346: 23 30 a4 f6  	sd	a0, -160(s0)
;                 if T::IS_ZST { ptr.wrapping_byte_add(slice.len()) } else { ptr.add(slice.len()) };
8020034a: 09 a0        	j	0x8020034c <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h5eea7b0bd5f3fbf5E+0x82>
;             Self { ptr: NonNull::new_unchecked(ptr as *mut T), end, _marker: PhantomData }
8020034c: 03 35 04 f4  	ld	a0, -192(s0)
80200350: 23 34 a4 fe  	sd	a0, -24(s0)
;             NonNull { pointer: ptr as _ }
80200354: 23 34 a4 f6  	sd	a0, -152(s0)
;             Self { ptr: NonNull::new_unchecked(ptr as *mut T), end, _marker: PhantomData }
80200358: 03 35 04 f6  	ld	a0, -160(s0)
8020035c: 83 35 84 f6  	ld	a1, -152(s0)
80200360: 23 3c b4 f4  	sd	a1, -168(s0)
80200364: 23 38 a4 f4  	sd	a0, -176(s0)
;     }
80200368: 03 35 04 f5  	ld	a0, -176(s0)
8020036c: 83 35 84 f5  	ld	a1, -168(s0)
80200370: ae 60        	ld	ra, 200(sp)
80200372: 0e 64        	ld	s0, 192(sp)
80200374: 69 61        	addi	sp, sp, 208
80200376: 82 80        	ret

0000000080200378 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE>:
;             fn next(&mut self) -> Option<$elem> {
80200378: 11 71        	addi	sp, sp, -256
8020037a: 86 fd        	sd	ra, 248(sp)
8020037c: a2 f9        	sd	s0, 240(sp)
8020037e: 00 02        	addi	s0, sp, 256
80200380: 23 30 a4 f0  	sd	a0, -256(s0)
80200384: 23 34 a4 f4  	sd	a0, -184(s0)
;                     assume(!self.ptr.as_ptr().is_null());
80200388: 08 65        	ld	a0, 8(a0)
8020038a: 23 38 a4 f4  	sd	a0, -176(s0)
;         self.pointer as *mut T
8020038e: 23 3c a4 f4  	sd	a0, -168(s0)
;         unsafe { const_eval_select((self as *mut u8,), const_impl, runtime_impl) }
80200392: 23 30 a4 f2  	sd	a0, -224(s0)
80200396: 03 35 04 f2  	ld	a0, -224(s0)
8020039a: 23 30 a4 f6  	sd	a0, -160(s0)
8020039e: 05 45        	li	a0, 1
;                     if !<T>::IS_ZST {
802003a0: 19 e9        	bnez	a0, 0x802003b6 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x3e>
802003a2: 09 a0        	j	0x802003a4 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x2c>
;                     if is_empty!(self) {
802003a4: 83 35 04 f0  	ld	a1, -256(s0)
802003a8: 88 65        	ld	a0, 8(a1)
802003aa: 23 3c a4 f6  	sd	a0, -136(s0)
802003ae: 8c 61        	ld	a1, 0(a1)
802003b0: 63 02 b5 02  	beq	a0, a1, 0x802003d4 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x5c>
802003b4: 29 a8        	j	0x802003ce <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x56>
;                         assume(!self.end.is_null());
802003b6: 03 35 04 f0  	ld	a0, -256(s0)
802003ba: 08 61        	ld	a0, 0(a0)
802003bc: 23 34 a4 f6  	sd	a0, -152(s0)
;         unsafe { const_eval_select((self as *const u8,), const_impl, runtime_impl) }
802003c0: 23 34 a4 f2  	sd	a0, -216(s0)
802003c4: 03 35 84 f2  	ld	a0, -216(s0)
802003c8: 23 38 a4 f6  	sd	a0, -144(s0)
;                     if !<T>::IS_ZST {
802003cc: e1 bf        	j	0x802003a4 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x2c>
802003ce: 01 45        	li	a0, 0
;                 if mem::size_of::<T>() == 0 {
802003d0: 01 ed        	bnez	a0, 0x802003e8 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x70>
802003d2: a9 a8        	j	0x8020042c <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0xb4>
802003d4: 01 45        	li	a0, 0
;                         None
802003d6: 23 38 a4 f0  	sd	a0, -240(s0)
;                     if is_empty!(self) {
802003da: 09 a0        	j	0x802003dc <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x64>
;             }
802003dc: 03 35 04 f1  	ld	a0, -240(s0)
802003e0: ee 70        	ld	ra, 248(sp)
802003e2: 4e 74        	ld	s0, 240(sp)
802003e4: 11 61        	addi	sp, sp, 256
802003e6: 82 80        	ret
;                 $self.end = $self.end.wrapping_byte_sub($n);
802003e8: 03 35 04 f0  	ld	a0, -256(s0)
802003ec: 0c 61        	ld	a1, 0(a0)
802003ee: 23 3c b4 fa  	sd	a1, -72(s0)
;         self as _
802003f2: 23 30 b4 fc  	sd	a1, -64(s0)
802003f6: 7d 56        	li	a2, -1
;             intrinsics::wrapping_sub(self, rhs)
802003f8: 23 34 c4 fc  	sd	a2, -56(s0)
;         unsafe { intrinsics::arith_offset(self, count) }
802003fc: fd 15        	addi	a1, a1, -1
802003fe: 23 38 b4 fc  	sd	a1, -48(s0)
80200402: 83 35 04 fd  	ld	a1, -48(s0)
80200406: 23 3c b4 fc  	sd	a1, -40(s0)
;         from_raw_parts::<U>(self as *const (), metadata(meta))
8020040a: 23 30 b4 fe  	sd	a1, -32(s0)
;     unsafe { PtrRepr { components: PtrComponents { data_address, metadata } }.const_ptr }
8020040e: 23 30 b4 f4  	sd	a1, -192(s0)
80200412: 83 35 04 f4  	ld	a1, -192(s0)
80200416: 23 3c b4 f2  	sd	a1, -200(s0)
8020041a: 83 35 84 f3  	ld	a1, -200(s0)
;                 $self.end = $self.end.wrapping_byte_sub($n);
8020041e: 0c e1        	sd	a1, 0(a0)
;                     self.ptr.as_ptr()
80200420: 08 65        	ld	a0, 8(a0)
80200422: 23 34 a4 fe  	sd	a0, -24(s0)
80200426: 23 3c a4 f0  	sd	a0, -232(s0)
;                 if mem::size_of::<T>() == 0 {
8020042a: 3d a8        	j	0x80200468 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0xf0>
;                     let old = self.ptr.as_ptr();
8020042c: 03 36 04 f0  	ld	a2, -256(s0)
80200430: 08 66        	ld	a0, 8(a2)
80200432: 23 30 a4 f8  	sd	a0, -128(s0)
;         self.pointer as *mut T
80200436: 23 34 a4 f8  	sd	a0, -120(s0)
;                     self.ptr = unsafe { NonNull::new_unchecked(self.ptr.as_ptr().add(offset)) };
8020043a: 0c 66        	ld	a1, 8(a2)
8020043c: 23 38 b4 f8  	sd	a1, -112(s0)
;         self.pointer as *mut T
80200440: 23 3c b4 f8  	sd	a1, -104(s0)
80200444: 85 46        	li	a3, 1
;         unsafe { self.offset(count as isize) }
80200446: 23 30 d4 fa  	sd	a3, -96(s0)
;         unsafe { intrinsics::offset(self, count) as *mut T }
8020044a: 85 05        	addi	a1, a1, 1
8020044c: 23 34 b4 fa  	sd	a1, -88(s0)
80200450: 83 35 84 fa  	ld	a1, -88(s0)
80200454: 23 38 b4 fa  	sd	a1, -80(s0)
;             NonNull { pointer: ptr as _ }
80200458: 23 38 b4 f2  	sd	a1, -208(s0)
;                     self.ptr = unsafe { NonNull::new_unchecked(self.ptr.as_ptr().add(offset)) };
8020045c: 83 35 04 f3  	ld	a1, -208(s0)
80200460: 0c e6        	sd	a1, 8(a2)
;                     old
80200462: 23 3c a4 f0  	sd	a0, -232(s0)
;                 if mem::size_of::<T>() == 0 {
80200466: 09 a0        	j	0x80200468 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0xf0>
;                         Some(next_unchecked!(self))
80200468: 03 35 84 f1  	ld	a0, -232(s0)
8020046c: 23 38 a4 f0  	sd	a0, -240(s0)
;                     if is_empty!(self) {
80200470: b5 b7        	j	0x802003dc <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h6666968fd701d1aaE+0x64>

0000000080200472 <_ZN2os9clear_bss28_$u7b$$u7b$closure$u7d$$u7d$17h2867df6c00c6d83bE>:
;         sbss as usize..ebss as usize).for_each(|a|{
80200472: 79 71        	addi	sp, sp, -48
80200474: 06 f4        	sd	ra, 40(sp)
80200476: 22 f0        	sd	s0, 32(sp)
80200478: 00 18        	addi	s0, sp, 48
8020047a: 23 38 a4 fc  	sd	a0, -48(s0)
8020047e: 23 3c b4 fc  	sd	a1, -40(s0)
80200482: 23 30 b4 fe  	sd	a1, -32(s0)
80200486: 01 45        	li	a0, 0
80200488: a3 07 a4 fe  	sb	a0, -17(s0)
;         intrinsics::volatile_store(dst, src);
8020048c: 23 80 a5 00  	sb	a0, 0(a1)
;         }
80200490: a2 70        	ld	ra, 40(sp)
80200492: 02 74        	ld	s0, 32(sp)
80200494: 45 61        	addi	sp, sp, 48
80200496: 82 80        	ret

0000000080200498 <_ZN2os3sbi15consele_putchar17h516a9367931f4ed6E>:
; pub fn consele_putchar(c:usize){
80200498: 5d 71        	addi	sp, sp, -80
8020049a: 86 e4        	sd	ra, 72(sp)
8020049c: a2 e0        	sd	s0, 64(sp)
8020049e: 80 08        	addi	s0, sp, 80
802004a0: 23 3c a4 fa  	sd	a0, -72(s0)
802004a4: 85 48        	li	a7, 1
802004a6: 23 34 14 fd  	sd	a7, -56(s0)
802004aa: 23 38 a4 fc  	sd	a0, -48(s0)
802004ae: 81 46        	li	a3, 0
802004b0: 23 3c d4 fc  	sd	a3, -40(s0)
802004b4: 23 30 d4 fe  	sd	a3, -32(s0)
802004b8: 23 34 d4 fe  	sd	a3, -24(s0)
;         asm!(
802004bc: b6 85        	mv	a1, a3
802004be: 36 86        	mv	a2, a3
802004c0: 73 00 00 00  	ecall	
802004c4: 23 30 a4 fc  	sd	a0, -64(s0)
; }
802004c8: a6 60        	ld	ra, 72(sp)
802004ca: 06 64        	ld	s0, 64(sp)
802004cc: 61 61        	addi	sp, sp, 80
802004ce: 82 80        	ret

00000000802004d0 <_ZN2os3sbi8shutdown17hc3b3a1948ce37c5cE>:
; pub fn shutdown() -> ! {
802004d0: 19 71        	addi	sp, sp, -128
802004d2: 86 fc        	sd	ra, 120(sp)
802004d4: a2 f8        	sd	s0, 112(sp)
802004d6: 00 01        	addi	s0, sp, 128
802004d8: a1 48        	li	a7, 8
802004da: 23 34 14 fd  	sd	a7, -56(s0)
802004de: 81 46        	li	a3, 0
802004e0: 23 38 d4 fc  	sd	a3, -48(s0)
802004e4: 23 3c d4 fc  	sd	a3, -40(s0)
802004e8: 23 30 d4 fe  	sd	a3, -32(s0)
802004ec: 23 34 d4 fe  	sd	a3, -24(s0)
;         asm!(
802004f0: 36 85        	mv	a0, a3
802004f2: b6 85        	mv	a1, a3
802004f4: 36 86        	mv	a2, a3
802004f6: 73 00 00 00  	ecall	
802004fa: 23 30 a4 fc  	sd	a0, -64(s0)

00000000802004fe <.Lpcrel_hi0>:
;     panic!("It should shutdown!");
802004fe: 17 35 00 00  	auipc	a0, 3
80200502: 93 05 25 c5  	addi	a1, a0, -942
80200506: 13 05 04 f9  	addi	a0, s0, -112
8020050a: 23 34 a4 f8  	sd	a0, -120(s0)
8020050e: 05 46        	li	a2, 1
80200510: 97 00 00 00  	auipc	ra, 0
80200514: e7 80 c0 67  	jalr	1660(ra)
80200518: 03 35 84 f8  	ld	a0, -120(s0)

000000008020051c <.Lpcrel_hi1>:
8020051c: 97 35 00 00  	auipc	a1, 3
80200520: 93 85 45 c5  	addi	a1, a1, -940
80200524: 97 20 00 00  	auipc	ra, 2
80200528: e7 80 e0 fd  	jalr	-34(ra)
8020052c: 00 00        	unimp	

000000008020052e <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hb29cf97bae76f659E>:
;     fn into_iter(self) -> I {
8020052e: 01 11        	addi	sp, sp, -32
80200530: 06 ec        	sd	ra, 24(sp)
80200532: 22 e8        	sd	s0, 16(sp)
80200534: 00 10        	addi	s0, sp, 32
80200536: 23 30 a4 fe  	sd	a0, -32(s0)
8020053a: 23 34 b4 fe  	sd	a1, -24(s0)
;     }
8020053e: e2 60        	ld	ra, 24(sp)
80200540: 42 64        	ld	s0, 16(sp)
80200542: 05 61        	addi	sp, sp, 32
80200544: 82 80        	ret

0000000080200546 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next28_$u7b$$u7b$closure$u7d$$u7d$17h53640d1fc4302fd8E>:
;         unsafe { next_code_point(&mut self.iter).map(|ch| char::from_u32_unchecked(ch)) }
80200546: 01 11        	addi	sp, sp, -32
80200548: 06 ec        	sd	ra, 24(sp)
8020054a: 22 e8        	sd	s0, 16(sp)
8020054c: 00 10        	addi	s0, sp, 32
8020054e: 23 24 a4 fe  	sw	a0, -24(s0)
;     if cfg!(debug_assertions) { char::from_u32(i).unwrap() } else { unsafe { transmute(i) } }
80200552: 23 26 a4 fe  	sw	a0, -20(s0)
;         unsafe { next_code_point(&mut self.iter).map(|ch| char::from_u32_unchecked(ch)) }
80200556: e2 60        	ld	ra, 24(sp)
80200558: 42 64        	ld	s0, 16(sp)
8020055a: 05 61        	addi	sp, sp, 32
8020055c: 82 80        	ret

000000008020055e <_ZN4core3fmt5Write10write_char17hc45d2a9ddf1c4e84E>:
;     fn write_char(&mut self, c: char) -> Result {
8020055e: 1d 71        	addi	sp, sp, -96
80200560: 86 ec        	sd	ra, 88(sp)
80200562: a2 e8        	sd	s0, 80(sp)
80200564: 80 10        	addi	s0, sp, 96
80200566: 23 30 b4 fa  	sd	a1, -96(s0)
8020056a: aa 85        	mv	a1, a0
8020056c: 03 35 04 fa  	ld	a0, -96(s0)
80200570: 23 34 b4 fa  	sd	a1, -88(s0)
80200574: 23 30 b4 fc  	sd	a1, -64(s0)
80200578: 23 26 a4 fc  	sw	a0, -52(s0)
8020057c: 81 45        	li	a1, 0
;         self.write_str(c.encode_utf8(&mut [0; 4]))
8020057e: 23 2e b4 fa  	sw	a1, -68(s0)
80200582: 93 05 c4 fb  	addi	a1, s0, -68
80200586: 23 38 b4 fc  	sd	a1, -48(s0)
8020058a: 11 46        	li	a2, 4
8020058c: 23 3c c4 fc  	sd	a2, -40(s0)
;         unsafe { from_utf8_unchecked_mut(encode_utf8_raw(self as u32, dst)) }
80200590: 97 00 00 00  	auipc	ra, 0
80200594: e7 80 00 22  	jalr	544(ra)
80200598: 2a 86        	mv	a2, a0
8020059a: 03 35 84 fa  	ld	a0, -88(s0)
8020059e: 23 38 c4 fa  	sd	a2, -80(s0)
802005a2: 2e 86        	mv	a2, a1
802005a4: 83 35 04 fb  	ld	a1, -80(s0)
802005a8: 23 30 b4 fe  	sd	a1, -32(s0)
802005ac: 23 34 c4 fe  	sd	a2, -24(s0)
;         self.write_str(c.encode_utf8(&mut [0; 4]))
802005b0: 97 10 00 00  	auipc	ra, 1
802005b4: e7 80 a0 fd  	jalr	-38(ra)
;     }
802005b8: e6 60        	ld	ra, 88(sp)
802005ba: 46 64        	ld	s0, 80(sp)
802005bc: 25 61        	addi	sp, sp, 96
802005be: 82 80        	ret

00000000802005c0 <_ZN4core3fmt5Write9write_fmt17hdcfb1fc703e00a40E>:
;     fn write_fmt(mut self: &mut Self, args: Arguments<'_>) -> Result {
802005c0: 5d 71        	addi	sp, sp, -80
802005c2: 86 e4        	sd	ra, 72(sp)
802005c4: a2 e0        	sd	s0, 64(sp)
802005c6: 80 08        	addi	s0, sp, 80
802005c8: 23 3c a4 fa  	sd	a0, -72(s0)
;         write(&mut self, args)
802005cc: 88 75        	ld	a0, 40(a1)
802005ce: 23 34 a4 fe  	sd	a0, -24(s0)
802005d2: 88 71        	ld	a0, 32(a1)
802005d4: 23 30 a4 fe  	sd	a0, -32(s0)
802005d8: 88 6d        	ld	a0, 24(a1)
802005da: 23 3c a4 fc  	sd	a0, -40(s0)
802005de: 88 69        	ld	a0, 16(a1)
802005e0: 23 38 a4 fc  	sd	a0, -48(s0)
802005e4: 88 65        	ld	a0, 8(a1)
802005e6: 23 34 a4 fc  	sd	a0, -56(s0)
802005ea: 88 61        	ld	a0, 0(a1)
802005ec: 23 30 a4 fc  	sd	a0, -64(s0)

00000000802005f0 <.Lpcrel_hi0>:
802005f0: 17 35 00 00  	auipc	a0, 3
802005f4: 93 05 85 b9  	addi	a1, a0, -1128
802005f8: 13 05 84 fb  	addi	a0, s0, -72
802005fc: 13 06 04 fc  	addi	a2, s0, -64
;         write(&mut self, args)
80200600: 97 10 00 00  	auipc	ra, 1
80200604: e7 80 80 70  	jalr	1800(ra)
;     }
80200608: a6 60        	ld	ra, 72(sp)
8020060a: 06 64        	ld	s0, 64(sp)
8020060c: 61 61        	addi	sp, sp, 80
8020060e: 82 80        	ret

0000000080200610 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h4a64dbc2745e000eE>:
;     fn write_char(&mut self, c: char) -> Result {
80200610: 01 11        	addi	sp, sp, -32
80200612: 06 ec        	sd	ra, 24(sp)
80200614: 22 e8        	sd	s0, 16(sp)
80200616: 00 10        	addi	s0, sp, 32
80200618: 23 30 a4 fe  	sd	a0, -32(s0)
8020061c: 23 26 b4 fe  	sw	a1, -20(s0)
;         (**self).write_char(c)
80200620: 08 61        	ld	a0, 0(a0)
80200622: 97 00 00 00  	auipc	ra, 0
80200626: e7 80 c0 f3  	jalr	-196(ra)
;     }
8020062a: e2 60        	ld	ra, 24(sp)
8020062c: 42 64        	ld	s0, 16(sp)
8020062e: 05 61        	addi	sp, sp, 32
80200630: 82 80        	ret

0000000080200632 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h4292cf9374bd70d8E>:
;     fn write_fmt(&mut self, args: Arguments<'_>) -> Result {
80200632: 5d 71        	addi	sp, sp, -80
80200634: 86 e4        	sd	ra, 72(sp)
80200636: a2 e0        	sd	s0, 64(sp)
80200638: 80 08        	addi	s0, sp, 80
8020063a: 23 3c a4 fa  	sd	a0, -72(s0)
;         (**self).write_fmt(args)
8020063e: 08 61        	ld	a0, 0(a0)
80200640: 90 75        	ld	a2, 40(a1)
80200642: 23 34 c4 fe  	sd	a2, -24(s0)
80200646: 90 71        	ld	a2, 32(a1)
80200648: 23 30 c4 fe  	sd	a2, -32(s0)
8020064c: 90 6d        	ld	a2, 24(a1)
8020064e: 23 3c c4 fc  	sd	a2, -40(s0)
80200652: 90 69        	ld	a2, 16(a1)
80200654: 23 38 c4 fc  	sd	a2, -48(s0)
80200658: 90 65        	ld	a2, 8(a1)
8020065a: 23 34 c4 fc  	sd	a2, -56(s0)
8020065e: 8c 61        	ld	a1, 0(a1)
80200660: 23 30 b4 fc  	sd	a1, -64(s0)
80200664: 93 05 04 fc  	addi	a1, s0, -64
80200668: 97 00 00 00  	auipc	ra, 0
8020066c: e7 80 80 f5  	jalr	-168(ra)
;     }
80200670: a6 60        	ld	ra, 72(sp)
80200672: 06 64        	ld	s0, 64(sp)
80200674: 61 61        	addi	sp, sp, 80
80200676: 82 80        	ret

0000000080200678 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hfe582dcdb2ec931fE>:
;     fn write_str(&mut self, s: &str) -> Result {
80200678: 79 71        	addi	sp, sp, -48
8020067a: 06 f4        	sd	ra, 40(sp)
8020067c: 22 f0        	sd	s0, 32(sp)
8020067e: 00 18        	addi	s0, sp, 48
80200680: 23 3c a4 fc  	sd	a0, -40(s0)
80200684: 23 30 b4 fe  	sd	a1, -32(s0)
80200688: 23 34 c4 fe  	sd	a2, -24(s0)
;         (**self).write_str(s)
8020068c: 08 61        	ld	a0, 0(a0)
8020068e: 97 10 00 00  	auipc	ra, 1
80200692: e7 80 c0 ef  	jalr	-260(ra)
;     }
80200696: a2 70        	ld	ra, 40(sp)
80200698: 02 74        	ld	s0, 32(sp)
8020069a: 45 61        	addi	sp, sp, 48
8020069c: 82 80        	ret

000000008020069e <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hb5c2fccf694e71eaE>:
;             fn fmt(&self, f: &mut Formatter<'_>) -> Result { $tr::fmt(&**self, f) }
8020069e: 01 11        	addi	sp, sp, -32
802006a0: 06 ec        	sd	ra, 24(sp)
802006a2: 22 e8        	sd	s0, 16(sp)
802006a4: 00 10        	addi	s0, sp, 32
802006a6: 2e 86        	mv	a2, a1
802006a8: aa 85        	mv	a1, a0
802006aa: 23 30 b4 fe  	sd	a1, -32(s0)
802006ae: 23 34 c4 fe  	sd	a2, -24(s0)
802006b2: 88 61        	ld	a0, 0(a1)
802006b4: 8c 65        	ld	a1, 8(a1)
802006b6: 97 20 00 00  	auipc	ra, 2
802006ba: e7 80 60 c8  	jalr	-890(ra)
802006be: e2 60        	ld	ra, 24(sp)
802006c0: 42 64        	ld	s0, 16(sp)
802006c2: 05 61        	addi	sp, sp, 32
802006c4: 82 80        	ret

00000000802006c6 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hdeef30486826053fE>:
802006c6: 01 11        	addi	sp, sp, -32
802006c8: 06 ec        	sd	ra, 24(sp)
802006ca: 22 e8        	sd	s0, 16(sp)
802006cc: 00 10        	addi	s0, sp, 32
802006ce: 23 30 a4 fe  	sd	a0, -32(s0)
802006d2: 23 34 b4 fe  	sd	a1, -24(s0)
802006d6: 08 61        	ld	a0, 0(a0)
802006d8: 97 10 00 00  	auipc	ra, 1
802006dc: e7 80 e0 61  	jalr	1566(ra)
802006e0: e2 60        	ld	ra, 24(sp)
802006e2: 42 64        	ld	s0, 16(sp)
802006e4: 05 61        	addi	sp, sp, 32
802006e6: 82 80        	ret

00000000802006e8 <_ZN4core3fmt10ArgumentV111new_display17h16736f44927f138dE>:
;         pub fn $f<'b, T: $t>(x: &'b T) -> ArgumentV1<'_> {
802006e8: 79 71        	addi	sp, sp, -48
802006ea: 06 f4        	sd	ra, 40(sp)
802006ec: 22 f0        	sd	s0, 32(sp)
802006ee: 00 18        	addi	s0, sp, 48
802006f0: aa 85        	mv	a1, a0
802006f2: 23 30 b4 fe  	sd	a1, -32(s0)

00000000802006f6 <.Lpcrel_hi0>:
;             Self::new(x, $t::fmt)
802006f6: 17 25 00 00  	auipc	a0, 2
802006fa: 13 05 45 fa  	addi	a0, a0, -92
802006fe: 23 34 a4 fe  	sd	a0, -24(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
80200702: 23 38 b4 fc  	sd	a1, -48(s0)
80200706: 23 3c a4 fc  	sd	a0, -40(s0)
;         }
8020070a: 03 35 04 fd  	ld	a0, -48(s0)
8020070e: 83 35 84 fd  	ld	a1, -40(s0)
80200712: a2 70        	ld	ra, 40(sp)
80200714: 02 74        	ld	s0, 32(sp)
80200716: 45 61        	addi	sp, sp, 48
80200718: 82 80        	ret

000000008020071a <_ZN4core3fmt10ArgumentV111new_display17h79ca121be1fc7ac0E>:
;         pub fn $f<'b, T: $t>(x: &'b T) -> ArgumentV1<'_> {
8020071a: 79 71        	addi	sp, sp, -48
8020071c: 06 f4        	sd	ra, 40(sp)
8020071e: 22 f0        	sd	s0, 32(sp)
80200720: 00 18        	addi	s0, sp, 48
80200722: aa 85        	mv	a1, a0
80200724: 23 30 b4 fe  	sd	a1, -32(s0)

0000000080200728 <.Lpcrel_hi1>:
;             Self::new(x, $t::fmt)
80200728: 17 05 00 00  	auipc	a0, 0
8020072c: 13 05 65 f7  	addi	a0, a0, -138
80200730: 23 34 a4 fe  	sd	a0, -24(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
80200734: 23 38 b4 fc  	sd	a1, -48(s0)
80200738: 23 3c a4 fc  	sd	a0, -40(s0)
;         }
8020073c: 03 35 04 fd  	ld	a0, -48(s0)
80200740: 83 35 84 fd  	ld	a1, -40(s0)
80200744: a2 70        	ld	ra, 40(sp)
80200746: 02 74        	ld	s0, 32(sp)
80200748: 45 61        	addi	sp, sp, 48
8020074a: 82 80        	ret

000000008020074c <_ZN4core3fmt10ArgumentV111new_display17hb2a183738e2afb93E>:
;         pub fn $f<'b, T: $t>(x: &'b T) -> ArgumentV1<'_> {
8020074c: 79 71        	addi	sp, sp, -48
8020074e: 06 f4        	sd	ra, 40(sp)
80200750: 22 f0        	sd	s0, 32(sp)
80200752: 00 18        	addi	s0, sp, 48
80200754: aa 85        	mv	a1, a0
80200756: 23 30 b4 fe  	sd	a1, -32(s0)

000000008020075a <.Lpcrel_hi2>:
;             Self::new(x, $t::fmt)
8020075a: 17 05 00 00  	auipc	a0, 0
8020075e: 13 05 c5 f6  	addi	a0, a0, -148
80200762: 23 34 a4 fe  	sd	a0, -24(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
80200766: 23 38 b4 fc  	sd	a1, -48(s0)
8020076a: 23 3c a4 fc  	sd	a0, -40(s0)
;         }
8020076e: 03 35 04 fd  	ld	a0, -48(s0)
80200772: 83 35 84 fd  	ld	a1, -40(s0)
80200776: a2 70        	ld	ra, 40(sp)
80200778: 02 74        	ld	s0, 32(sp)
8020077a: 45 61        	addi	sp, sp, 48
8020077c: 82 80        	ret

000000008020077e <_ZN4core3fmt10ArgumentV113new_lower_hex17h25e9e211fea52f2dE>:
;         pub fn $f<'b, T: $t>(x: &'b T) -> ArgumentV1<'_> {
8020077e: 79 71        	addi	sp, sp, -48
80200780: 06 f4        	sd	ra, 40(sp)
80200782: 22 f0        	sd	s0, 32(sp)
80200784: 00 18        	addi	s0, sp, 48
80200786: aa 85        	mv	a1, a0
80200788: 23 30 b4 fe  	sd	a1, -32(s0)

000000008020078c <.Lpcrel_hi3>:
;             Self::new(x, $t::fmt)
8020078c: 17 15 00 00  	auipc	a0, 1
80200790: 13 05 a5 4e  	addi	a0, a0, 1258
80200794: 23 34 a4 fe  	sd	a0, -24(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
80200798: 23 38 b4 fc  	sd	a1, -48(s0)
8020079c: 23 3c a4 fc  	sd	a0, -40(s0)
;         }
802007a0: 03 35 04 fd  	ld	a0, -48(s0)
802007a4: 83 35 84 fd  	ld	a1, -40(s0)
802007a8: a2 70        	ld	ra, 40(sp)
802007aa: 02 74        	ld	s0, 32(sp)
802007ac: 45 61        	addi	sp, sp, 48
802007ae: 82 80        	ret

00000000802007b0 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E>:
; pub fn encode_utf8_raw(code: u32, dst: &mut [u8]) -> &mut [u8] {
802007b0: 25 71        	addi	sp, sp, -416
802007b2: 06 ef        	sd	ra, 408(sp)
802007b4: 22 eb        	sd	s0, 400(sp)
802007b6: 00 13        	addi	s0, sp, 416
802007b8: 23 38 c4 e6  	sd	a2, -400(s0)
802007bc: 23 3c b4 e6  	sd	a1, -392(s0)
802007c0: 23 26 a4 e8  	sw	a0, -372(s0)
802007c4: 23 30 b4 f6  	sd	a1, -160(s0)
802007c8: 23 34 c4 f6  	sd	a2, -152(s0)
;     if code < MAX_ONE_B {
802007cc: 03 25 c4 e8  	lw	a0, -372(s0)
802007d0: 93 05 00 08  	li	a1, 128
802007d4: 63 68 b5 00  	bltu	a0, a1, 0x802007e4 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x34>
802007d8: 09 a0        	j	0x802007da <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x2a>
;     } else if code < MAX_TWO_B {
802007da: 03 65 c4 e8  	lwu	a0, -372(s0)
802007de: 2d 81        	srli	a0, a0, 11
802007e0: 25 c1        	beqz	a0, 0x80200840 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x90>
802007e2: 99 a8        	j	0x80200838 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x88>
802007e4: 05 45        	li	a0, 1
;         1
802007e6: 23 38 a4 e8  	sd	a0, -368(s0)
;     if code < MAX_ONE_B {
802007ea: 09 a0        	j	0x802007ec <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x3c>
;     match (len, &mut dst[..]) {
802007ec: 03 35 04 e7  	ld	a0, -400(s0)
802007f0: 83 35 84 e7  	ld	a1, -392(s0)
802007f4: 03 36 04 e9  	ld	a2, -368(s0)
802007f8: 23 3c c4 e8  	sd	a2, -360(s0)
802007fc: 23 30 b4 ea  	sd	a1, -352(s0)
80200800: 23 34 a4 ea  	sd	a0, -344(s0)
80200804: 03 35 84 e9  	ld	a0, -360(s0)
80200808: 23 34 a4 e6  	sd	a0, -408(s0)
8020080c: 85 45        	li	a1, 1
8020080e: 63 04 b5 10  	beq	a0, a1, 0x80200916 <.Lpcrel_hi3+0x12>
80200812: 09 a0        	j	0x80200814 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x64>
80200814: 03 35 84 e6  	ld	a0, -408(s0)
80200818: 89 45        	li	a1, 2
;     match (len, &mut dst[..]) {
8020081a: 63 03 b5 10  	beq	a0, a1, 0x80200920 <.Lpcrel_hi3+0x1c>
8020081e: 09 a0        	j	0x80200820 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x70>
80200820: 03 35 84 e6  	ld	a0, -408(s0)
80200824: 8d 45        	li	a1, 3
;     match (len, &mut dst[..]) {
80200826: 63 03 b5 10  	beq	a0, a1, 0x8020092c <.Lpcrel_hi3+0x28>
8020082a: 09 a0        	j	0x8020082c <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x7c>
8020082c: 03 35 84 e6  	ld	a0, -408(s0)
80200830: 91 45        	li	a1, 4
;     match (len, &mut dst[..]) {
80200832: 63 03 b5 10  	beq	a0, a1, 0x80200938 <.Lpcrel_hi3+0x34>
80200836: 1d a0        	j	0x8020085c <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xac>
;     } else if code < MAX_THREE_B {
80200838: 03 55 e4 e8  	lhu	a0, -370(s0)
8020083c: 19 c9        	beqz	a0, 0x80200852 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xa2>
8020083e: 31 a0        	j	0x8020084a <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x9a>
80200840: 09 45        	li	a0, 2
;         2
80200842: 23 38 a4 e8  	sd	a0, -368(s0)
;     } else if code < MAX_TWO_B {
80200846: 09 a0        	j	0x80200848 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x98>
;     if code < MAX_ONE_B {
80200848: 55 b7        	j	0x802007ec <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x3c>
8020084a: 11 45        	li	a0, 4
;         4
8020084c: 23 38 a4 e8  	sd	a0, -368(s0)
;     } else if code < MAX_THREE_B {
80200850: 29 a0        	j	0x8020085a <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xaa>
80200852: 0d 45        	li	a0, 3
;         3
80200854: 23 38 a4 e8  	sd	a0, -368(s0)
;     } else if code < MAX_THREE_B {
80200858: 09 a0        	j	0x8020085a <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xaa>
;     } else if code < MAX_TWO_B {
8020085a: fd b7        	j	0x80200848 <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0x98>
8020085c: 83 35 04 e7  	ld	a1, -400(s0)
80200860: 13 06 04 e9  	addi	a2, s0, -368
;         _ => panic!(
80200864: 23 30 c4 fc  	sd	a2, -64(s0)

0000000080200868 <.Lpcrel_hi0>:
;             Self::new(x, $t::fmt)
80200868: 17 25 00 00  	auipc	a0, 2
8020086c: 13 05 25 e4  	addi	a0, a0, -446
80200870: 23 34 a4 fc  	sd	a0, -56(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
80200874: 23 38 c4 f0  	sd	a2, -240(s0)
80200878: 23 3c a4 f0  	sd	a0, -232(s0)
8020087c: 93 06 c4 e8  	addi	a3, s0, -372
;         _ => panic!(
80200880: 23 38 d4 fc  	sd	a3, -48(s0)

0000000080200884 <.Lpcrel_hi1>:
;             Self::new(x, $t::fmt)
80200884: 17 16 00 00  	auipc	a2, 1
80200888: 13 06 66 37  	addi	a2, a2, 886
8020088c: 23 3c c4 fc  	sd	a2, -40(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
80200890: 23 30 d4 f2  	sd	a3, -224(s0)
80200894: 23 34 c4 f2  	sd	a2, -216(s0)
;             dst.len(),
80200898: 23 30 b4 f4  	sd	a1, -192(s0)
8020089c: 93 05 04 f4  	addi	a1, s0, -192
;         _ => panic!(
802008a0: 23 30 b4 fe  	sd	a1, -32(s0)
;             Self::new(x, $t::fmt)
802008a4: 23 34 a4 fe  	sd	a0, -24(s0)
;         unsafe { ArgumentV1 { formatter: mem::transmute(f), value: mem::transmute(x) } }
802008a8: 23 38 b4 f2  	sd	a1, -208(s0)
802008ac: 23 3c a4 f2  	sd	a0, -200(s0)
;         _ => panic!(
802008b0: 83 35 04 f1  	ld	a1, -240(s0)
802008b4: 03 35 84 f1  	ld	a0, -232(s0)
802008b8: 23 30 b4 ee  	sd	a1, -288(s0)
802008bc: 23 34 a4 ee  	sd	a0, -280(s0)
802008c0: 83 35 04 f2  	ld	a1, -224(s0)
802008c4: 03 35 84 f2  	ld	a0, -216(s0)
802008c8: 23 38 b4 ee  	sd	a1, -272(s0)
802008cc: 23 3c a4 ee  	sd	a0, -264(s0)
802008d0: 83 35 04 f3  	ld	a1, -208(s0)
802008d4: 03 35 84 f3  	ld	a0, -200(s0)
802008d8: 23 30 b4 f0  	sd	a1, -256(s0)
802008dc: 23 34 a4 f0  	sd	a0, -248(s0)

00000000802008e0 <.Lpcrel_hi2>:
802008e0: 17 35 00 00  	auipc	a0, 3
802008e4: 93 05 85 9a  	addi	a1, a0, -1624
802008e8: 13 05 04 eb  	addi	a0, s0, -336
802008ec: 23 30 a4 e6  	sd	a0, -416(s0)
802008f0: 93 06 04 ee  	addi	a3, s0, -288
802008f4: 0d 47        	li	a4, 3
802008f6: 3a 86        	mv	a2, a4
802008f8: 97 00 00 00  	auipc	ra, 0
802008fc: e7 80 60 1d  	jalr	470(ra)
80200900: 03 35 04 e6  	ld	a0, -416(s0)

0000000080200904 <.Lpcrel_hi3>:
80200904: 97 35 00 00  	auipc	a1, 3
80200908: 93 85 45 9b  	addi	a1, a1, -1612
8020090c: 97 20 00 00  	auipc	ra, 2
80200910: e7 80 60 bf  	jalr	-1034(ra)
80200914: 00 00        	unimp	
;         (1, [a, ..]) => {
80200916: 03 35 84 ea  	ld	a0, -344(s0)
8020091a: 63 1f 05 14  	bnez	a0, 0x80200a78 <.Lpcrel_hi4+0xa0>
8020091e: 3d bf        	j	0x8020085c <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xac>
;         (2, [a, b, ..]) => {
80200920: 83 35 84 ea  	ld	a1, -344(s0)
80200924: 05 45        	li	a0, 1
80200926: 63 6e b5 10  	bltu	a0, a1, 0x80200a42 <.Lpcrel_hi4+0x6a>
8020092a: 0d bf        	j	0x8020085c <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xac>
;         (3, [a, b, c, ..]) => {
8020092c: 83 35 84 ea  	ld	a1, -344(s0)
80200930: 09 45        	li	a0, 2
80200932: 63 6f b5 0a  	bltu	a0, a1, 0x802009f0 <.Lpcrel_hi4+0x18>
80200936: 1d b7        	j	0x8020085c <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xac>
;         (4, [a, b, c, d, ..]) => {
80200938: 03 35 84 ea  	ld	a0, -344(s0)
8020093c: 91 45        	li	a1, 4
8020093e: e3 6f b5 f0  	bltu	a0, a1, 0x8020085c <_ZN4core4char7methods15encode_utf8_raw17he0ab96c6fea550e7E+0xac>
80200942: 09 a0        	j	0x80200944 <.Lpcrel_hi3+0x40>
80200944: 03 37 04 ea  	ld	a4, -352(s0)
80200948: 23 38 e4 f6  	sd	a4, -144(s0)
8020094c: 83 36 04 ea  	ld	a3, -352(s0)
80200950: 13 85 16 00  	addi	a0, a3, 1
80200954: 23 3c a4 f6  	sd	a0, -136(s0)
80200958: 03 36 04 ea  	ld	a2, -352(s0)
8020095c: 13 05 26 00  	addi	a0, a2, 2
80200960: 23 30 a4 f8  	sd	a0, -128(s0)
80200964: 83 35 04 ea  	ld	a1, -352(s0)
80200968: 13 85 35 00  	addi	a0, a1, 3
8020096c: 23 34 a4 f8  	sd	a0, -120(s0)
;             *a = (code >> 18 & 0x07) as u8 | TAG_FOUR_B;
80200970: 03 25 c4 e8  	lw	a0, -372(s0)
80200974: 2e 15        	slli	a0, a0, 43
80200976: 75 91        	srli	a0, a0, 61
80200978: 13 05 05 0f  	addi	a0, a0, 240
8020097c: 23 00 a7 00  	sb	a0, 0(a4)
;             *b = (code >> 12 & 0x3F) as u8 | TAG_CONT;
80200980: 03 25 c4 e8  	lw	a0, -372(s0)
80200984: 3a 15        	slli	a0, a0, 46
80200986: 69 91        	srli	a0, a0, 58
80200988: 13 05 05 08  	addi	a0, a0, 128
8020098c: a3 80 a6 00  	sb	a0, 1(a3)
;             *c = (code >> 6 & 0x3F) as u8 | TAG_CONT;
80200990: 03 25 c4 e8  	lw	a0, -372(s0)
80200994: 52 15        	slli	a0, a0, 52
80200996: 69 91        	srli	a0, a0, 58
80200998: 13 05 05 08  	addi	a0, a0, 128
8020099c: 23 01 a6 00  	sb	a0, 2(a2)
;             *d = (code & 0x3F) as u8 | TAG_CONT;
802009a0: 03 45 c4 e8  	lbu	a0, -372(s0)
802009a4: 13 75 f5 03  	andi	a0, a0, 63
802009a8: 13 05 05 08  	addi	a0, a0, 128
802009ac: a3 81 a5 00  	sb	a0, 3(a1)
;         }
802009b0: 09 a0        	j	0x802009b2 <.Lpcrel_hi3+0xae>
;     &mut dst[..len]
802009b2: 83 36 04 e7  	ld	a3, -400(s0)
802009b6: 03 36 84 e7  	ld	a2, -392(s0)
802009ba: 03 35 04 e9  	ld	a0, -368(s0)
802009be: 23 34 a4 f4  	sd	a0, -184(s0)
;         (0..self.end).index_mut(slice)
802009c2: 03 35 84 f4  	ld	a0, -184(s0)
802009c6: 81 45        	li	a1, 0
802009c8: 23 38 b4 f4  	sd	a1, -176(s0)
802009cc: 23 3c a4 f4  	sd	a0, -168(s0)
802009d0: 03 35 04 f5  	ld	a0, -176(s0)
802009d4: 83 35 84 f5  	ld	a1, -168(s0)

00000000802009d8 <.Lpcrel_hi4>:
802009d8: 17 37 00 00  	auipc	a4, 3
802009dc: 13 07 87 85  	addi	a4, a4, -1960
802009e0: 97 10 00 00  	auipc	ra, 1
802009e4: e7 80 e0 f7  	jalr	-130(ra)
; }
802009e8: fa 60        	ld	ra, 408(sp)
802009ea: 5a 64        	ld	s0, 400(sp)
802009ec: 1d 61        	addi	sp, sp, 416
802009ee: 82 80        	ret
;         (3, [a, b, c, ..]) => {
802009f0: 83 36 04 ea  	ld	a3, -352(s0)
802009f4: 23 38 d4 f8  	sd	a3, -112(s0)
802009f8: 03 36 04 ea  	ld	a2, -352(s0)
802009fc: 13 05 16 00  	addi	a0, a2, 1
80200a00: 23 3c a4 f8  	sd	a0, -104(s0)
80200a04: 83 35 04 ea  	ld	a1, -352(s0)
80200a08: 13 85 25 00  	addi	a0, a1, 2
80200a0c: 23 30 a4 fa  	sd	a0, -96(s0)
;             *a = (code >> 12 & 0x0F) as u8 | TAG_THREE_B;
80200a10: 03 25 c4 e8  	lw	a0, -372(s0)
80200a14: 42 15        	slli	a0, a0, 48
80200a16: 71 91        	srli	a0, a0, 60
80200a18: 13 05 05 0e  	addi	a0, a0, 224
80200a1c: 23 80 a6 00  	sb	a0, 0(a3)
;             *b = (code >> 6 & 0x3F) as u8 | TAG_CONT;
80200a20: 03 25 c4 e8  	lw	a0, -372(s0)
80200a24: 52 15        	slli	a0, a0, 52
80200a26: 69 91        	srli	a0, a0, 58
80200a28: 13 05 05 08  	addi	a0, a0, 128
80200a2c: a3 00 a6 00  	sb	a0, 1(a2)
;             *c = (code & 0x3F) as u8 | TAG_CONT;
80200a30: 03 45 c4 e8  	lbu	a0, -372(s0)
80200a34: 13 75 f5 03  	andi	a0, a0, 63
80200a38: 13 05 05 08  	addi	a0, a0, 128
80200a3c: 23 81 a5 00  	sb	a0, 2(a1)
;         }
80200a40: 8d bf        	j	0x802009b2 <.Lpcrel_hi3+0xae>
;         (2, [a, b, ..]) => {
80200a42: 03 36 04 ea  	ld	a2, -352(s0)
80200a46: 23 34 c4 fa  	sd	a2, -88(s0)
80200a4a: 83 35 04 ea  	ld	a1, -352(s0)
80200a4e: 13 85 15 00  	addi	a0, a1, 1
80200a52: 23 38 a4 fa  	sd	a0, -80(s0)
;             *a = (code >> 6 & 0x1F) as u8 | TAG_TWO_B;
80200a56: 03 25 c4 e8  	lw	a0, -372(s0)
80200a5a: 56 15        	slli	a0, a0, 53
80200a5c: 6d 91        	srli	a0, a0, 59
80200a5e: 13 05 05 0c  	addi	a0, a0, 192
80200a62: 23 00 a6 00  	sb	a0, 0(a2)
;             *b = (code & 0x3F) as u8 | TAG_CONT;
80200a66: 03 45 c4 e8  	lbu	a0, -372(s0)
80200a6a: 13 75 f5 03  	andi	a0, a0, 63
80200a6e: 13 05 05 08  	addi	a0, a0, 128
80200a72: a3 80 a5 00  	sb	a0, 1(a1)
;         }
80200a76: 35 bf        	j	0x802009b2 <.Lpcrel_hi3+0xae>
;         (1, [a, ..]) => {
80200a78: 83 35 04 ea  	ld	a1, -352(s0)
80200a7c: 23 3c b4 fa  	sd	a1, -72(s0)
;             *a = code as u8;
80200a80: 03 05 c4 e8  	lb	a0, -372(s0)
80200a84: 23 80 a5 00  	sb	a0, 0(a1)
;         }
80200a88: 2d b7        	j	0x802009b2 <.Lpcrel_hi3+0xae>

0000000080200a8a <_ZN4core3fmt9Arguments16new_v1_formatted17h543f182fedce3571E>:
;     pub fn new_v1_formatted(
80200a8a: 1d 71        	addi	sp, sp, -96
80200a8c: 86 ec        	sd	ra, 88(sp)
80200a8e: a2 e8        	sd	s0, 80(sp)
80200a90: 80 10        	addi	s0, sp, 96
80200a92: 23 3c b4 fa  	sd	a1, -72(s0)
80200a96: 23 30 c4 fc  	sd	a2, -64(s0)
80200a9a: 23 34 d4 fc  	sd	a3, -56(s0)
80200a9e: 23 38 e4 fc  	sd	a4, -48(s0)
80200aa2: 23 3c f4 fc  	sd	a5, -40(s0)
80200aa6: 23 30 04 ff  	sd	a6, -32(s0)
;         Arguments { pieces, fmt: Some(fmt), args }
80200aaa: 23 34 f4 fa  	sd	a5, -88(s0)
80200aae: 23 38 04 fb  	sd	a6, -80(s0)
80200ab2: 0c e9        	sd	a1, 16(a0)
80200ab4: 10 ed        	sd	a2, 24(a0)
80200ab6: 03 36 84 fa  	ld	a2, -88(s0)
80200aba: 83 35 04 fb  	ld	a1, -80(s0)
80200abe: 10 e1        	sd	a2, 0(a0)
80200ac0: 0c e5        	sd	a1, 8(a0)
80200ac2: 14 f1        	sd	a3, 32(a0)
80200ac4: 18 f5        	sd	a4, 40(a0)
;     }
80200ac6: e6 60        	ld	ra, 88(sp)
80200ac8: 46 64        	ld	s0, 80(sp)
80200aca: 25 61        	addi	sp, sp, 96
80200acc: 82 80        	ret

0000000080200ace <_ZN4core3fmt9Arguments6new_v117h0dfeeed5f9b4fcfbE>:
;     pub fn new_v1(pieces: &'a [&'static str], args: &'a [ArgumentV1<'a>]) -> Arguments<'a> {
80200ace: 71 71        	addi	sp, sp, -176
80200ad0: 06 f5        	sd	ra, 168(sp)
80200ad2: 22 f1        	sd	s0, 160(sp)
80200ad4: 00 19        	addi	s0, sp, 176
80200ad6: 23 30 e4 f6  	sd	a4, -160(s0)
80200ada: 23 34 d4 f6  	sd	a3, -152(s0)
80200ade: 23 38 c4 f6  	sd	a2, -144(s0)
80200ae2: 23 3c b4 f6  	sd	a1, -136(s0)
80200ae6: 23 30 a4 f8  	sd	a0, -128(s0)
80200aea: 23 38 b4 fc  	sd	a1, -48(s0)
80200aee: 23 3c c4 fc  	sd	a2, -40(s0)
80200af2: 23 30 d4 fe  	sd	a3, -32(s0)
80200af6: 23 34 e4 fe  	sd	a4, -24(s0)
;         if pieces.len() < args.len() || pieces.len() > args.len() + 1 {
80200afa: 63 6d e6 00  	bltu	a2, a4, 0x80200b14 <_ZN4core3fmt9Arguments6new_v117h0dfeeed5f9b4fcfbE+0x46>
80200afe: 09 a0        	j	0x80200b00 <_ZN4core3fmt9Arguments6new_v117h0dfeeed5f9b4fcfbE+0x32>
80200b00: 83 35 04 f7  	ld	a1, -144(s0)
80200b04: 03 35 04 f6  	ld	a0, -160(s0)
80200b08: 05 05        	addi	a0, a0, 1
80200b0a: 33 35 b5 00  	sltu	a0, a0, a1
80200b0e: a3 07 a4 f8  	sb	a0, -113(s0)
80200b12: 29 a0        	j	0x80200b1c <_ZN4core3fmt9Arguments6new_v117h0dfeeed5f9b4fcfbE+0x4e>
80200b14: 05 45        	li	a0, 1
;         if pieces.len() < args.len() || pieces.len() > args.len() + 1 {
80200b16: a3 07 a4 f8  	sb	a0, -113(s0)
80200b1a: 09 a0        	j	0x80200b1c <_ZN4core3fmt9Arguments6new_v117h0dfeeed5f9b4fcfbE+0x4e>
80200b1c: 03 45 f4 f8  	lbu	a0, -113(s0)
80200b20: 05 89        	andi	a0, a0, 1
80200b22: 0d ed        	bnez	a0, 0x80200b5c <.Lpcrel_hi0>
80200b24: 09 a0        	j	0x80200b26 <_ZN4core3fmt9Arguments6new_v117h0dfeeed5f9b4fcfbE+0x58>
80200b26: 03 35 04 f6  	ld	a0, -160(s0)
80200b2a: 83 35 04 f8  	ld	a1, -128(s0)
80200b2e: 03 36 84 f6  	ld	a2, -152(s0)
80200b32: 83 36 04 f7  	ld	a3, -144(s0)
80200b36: 03 37 84 f7  	ld	a4, -136(s0)
80200b3a: 81 47        	li	a5, 0
;         Arguments { pieces, fmt: None, args }
80200b3c: 23 30 f4 fc  	sd	a5, -64(s0)
80200b40: 98 e9        	sd	a4, 16(a1)
80200b42: 94 ed        	sd	a3, 24(a1)
80200b44: 03 37 04 fc  	ld	a4, -64(s0)
80200b48: 83 36 84 fc  	ld	a3, -56(s0)
80200b4c: 98 e1        	sd	a4, 0(a1)
80200b4e: 94 e5        	sd	a3, 8(a1)
80200b50: 90 f1        	sd	a2, 32(a1)
80200b52: 88 f5        	sd	a0, 40(a1)
;     }
80200b54: aa 70        	ld	ra, 168(sp)
80200b56: 0a 74        	ld	s0, 160(sp)
80200b58: 4d 61        	addi	sp, sp, 176
80200b5a: 82 80        	ret

0000000080200b5c <.Lpcrel_hi0>:
;             panic!("invalid args");
80200b5c: 17 25 00 00  	auipc	a0, 2
80200b60: 93 05 45 78  	addi	a1, a0, 1924
80200b64: 13 05 04 f9  	addi	a0, s0, -112
80200b68: 23 3c a4 f4  	sd	a0, -168(s0)
80200b6c: 05 46        	li	a2, 1
80200b6e: 97 00 00 00  	auipc	ra, 0
80200b72: e7 80 e0 01  	jalr	30(ra)
80200b76: 03 35 84 f5  	ld	a0, -168(s0)

0000000080200b7a <.Lpcrel_hi1>:
80200b7a: 97 25 00 00  	auipc	a1, 2
80200b7e: 93 85 65 7e  	addi	a1, a1, 2022
80200b82: 97 20 00 00  	auipc	ra, 2
80200b86: e7 80 00 98  	jalr	-1664(ra)
80200b8a: 00 00        	unimp	

0000000080200b8c <_ZN4core3fmt9Arguments9new_const17ha9c0a59a09d262b0E>:
;     pub const fn new_const(pieces: &'a [&'static str]) -> Self {
80200b8c: 19 71        	addi	sp, sp, -128
80200b8e: 86 fc        	sd	ra, 120(sp)
80200b90: a2 f8        	sd	s0, 112(sp)
80200b92: 00 01        	addi	s0, sp, 128
80200b94: 23 34 c4 f8  	sd	a2, -120(s0)
80200b98: 23 38 b4 f8  	sd	a1, -112(s0)
80200b9c: 23 3c a4 f8  	sd	a0, -104(s0)
80200ba0: 23 30 b4 fe  	sd	a1, -32(s0)
80200ba4: 23 34 c4 fe  	sd	a2, -24(s0)
80200ba8: 05 45        	li	a0, 1
;         if pieces.len() > 1 {
80200baa: 63 6e c5 02  	bltu	a0, a2, 0x80200be6 <.Lpcrel_hi3>
80200bae: 09 a0        	j	0x80200bb0 <_ZN4core3fmt9Arguments9new_const17ha9c0a59a09d262b0E+0x24>
80200bb0: 83 35 84 f9  	ld	a1, -104(s0)
80200bb4: 03 36 84 f8  	ld	a2, -120(s0)
80200bb8: 83 36 04 f9  	ld	a3, -112(s0)
80200bbc: 01 45        	li	a0, 0
;         Arguments { pieces, fmt: None, args: &[] }
80200bbe: 23 38 a4 fc  	sd	a0, -48(s0)
80200bc2: 94 e9        	sd	a3, 16(a1)
80200bc4: 90 ed        	sd	a2, 24(a1)
80200bc6: 83 36 04 fd  	ld	a3, -48(s0)
80200bca: 03 36 84 fd  	ld	a2, -40(s0)
80200bce: 94 e1        	sd	a3, 0(a1)
80200bd0: 90 e5        	sd	a2, 8(a1)

0000000080200bd2 <.Lpcrel_hi2>:
80200bd2: 17 26 00 00  	auipc	a2, 2
80200bd6: 13 06 e6 7b  	addi	a2, a2, 1982
80200bda: 90 f1        	sd	a2, 32(a1)
80200bdc: 88 f5        	sd	a0, 40(a1)
;     }
80200bde: e6 70        	ld	ra, 120(sp)
80200be0: 46 74        	ld	s0, 112(sp)
80200be2: 09 61        	addi	sp, sp, 128
80200be4: 82 80        	ret

0000000080200be6 <.Lpcrel_hi3>:
;             panic!("invalid args");
80200be6: 17 25 00 00  	auipc	a0, 2
80200bea: 93 05 a5 6f  	addi	a1, a0, 1786
80200bee: 13 05 04 fa  	addi	a0, s0, -96
80200bf2: 23 30 a4 f8  	sd	a0, -128(s0)
80200bf6: 05 46        	li	a2, 1
80200bf8: 97 00 00 00  	auipc	ra, 0
80200bfc: e7 80 40 f9  	jalr	-108(ra)
80200c00: 03 35 04 f8  	ld	a0, -128(s0)

0000000080200c04 <.Lpcrel_hi4>:
80200c04: 97 25 00 00  	auipc	a1, 2
80200c08: 93 85 45 77  	addi	a1, a1, 1908
80200c0c: 97 20 00 00  	auipc	ra, 2
80200c10: e7 80 60 8f  	jalr	-1802(ra)
80200c14: 00 00        	unimp	

0000000080200c16 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE>:
; pub unsafe fn next_code_point<'a, I: Iterator<Item = &'a u8>>(bytes: &mut I) -> Option<u32> {
80200c16: 15 71        	addi	sp, sp, -224
80200c18: 86 ed        	sd	ra, 216(sp)
80200c1a: a2 e9        	sd	s0, 208(sp)
80200c1c: 80 11        	addi	s0, sp, 224
80200c1e: 23 34 a4 f4  	sd	a0, -184(s0)
80200c22: 23 3c a4 f8  	sd	a0, -104(s0)
;     let x = *bytes.next()?;
80200c26: 97 f0 ff ff  	auipc	ra, 1048575
80200c2a: e7 80 20 75  	jalr	1874(ra)
80200c2e: 23 38 a4 f6  	sd	a0, -144(s0)
;         match self {
80200c32: 03 35 04 f7  	ld	a0, -144(s0)
80200c36: 11 e5        	bnez	a0, 0x80200c42 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x2c>
80200c38: 09 a0        	j	0x80200c3a <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x24>
80200c3a: 01 45        	li	a0, 0
;             None => ControlFlow::Break(None),
80200c3c: 23 34 a4 f6  	sd	a0, -152(s0)
80200c40: 01 a8        	j	0x80200c50 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x3a>
;             Some(v) => ControlFlow::Continue(v),
80200c42: 03 35 04 f7  	ld	a0, -144(s0)
80200c46: 23 30 a4 fa  	sd	a0, -96(s0)
80200c4a: 23 34 a4 f6  	sd	a0, -152(s0)
;     }
80200c4e: 09 a0        	j	0x80200c50 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x3a>
;     let x = *bytes.next()?;
80200c50: 03 35 84 f6  	ld	a0, -152(s0)
80200c54: 0d c1        	beqz	a0, 0x80200c76 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x60>
80200c56: 09 a0        	j	0x80200c58 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x42>
80200c58: 03 35 84 f6  	ld	a0, -152(s0)
80200c5c: 23 34 a4 fa  	sd	a0, -88(s0)
80200c60: 03 05 05 00  	lb	a0, 0(a0)
80200c64: 93 75 f5 0f  	andi	a1, a0, 255
80200c68: 23 30 b4 f4  	sd	a1, -192(s0)
80200c6c: a3 09 a4 fa  	sb	a0, -77(s0)
;     if x < 128 {
80200c70: 63 52 05 04  	bgez	a0, 0x80200cb4 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x9e>
80200c74: 29 a8        	j	0x80200c8e <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x78>
80200c76: 01 45        	li	a0, 0
;             None => None,
80200c78: 23 20 a4 f6  	sw	a0, -160(s0)
; #![no_std]
80200c7c: 09 a0        	j	0x80200c7e <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x68>
; }
80200c7e: 03 25 04 f6  	lw	a0, -160(s0)
80200c82: 83 25 44 f6  	lw	a1, -156(s0)
80200c86: ee 60        	ld	ra, 216(sp)
80200c88: 4e 64        	ld	s0, 208(sp)
80200c8a: 2d 61        	addi	sp, sp, 224
80200c8c: 82 80        	ret
;     (byte & (0x7F >> width)) as u32
80200c8e: 03 35 84 f4  	ld	a0, -184(s0)
80200c92: 83 35 04 f4  	ld	a1, -192(s0)
80200c96: fd 89        	andi	a1, a1, 31
80200c98: 23 3c b4 f2  	sd	a1, -200(s0)
80200c9c: 23 2a b4 fa  	sw	a1, -76(s0)
;     let y = unsafe { *bytes.next().unwrap_unchecked() };
80200ca0: 97 f0 ff ff  	auipc	ra, 1048575
80200ca4: e7 80 80 6d  	jalr	1752(ra)
80200ca8: 23 3c a4 f6  	sd	a0, -136(s0)
;         match self {
80200cac: 03 35 84 f7  	ld	a0, -136(s0)
80200cb0: 01 ed        	bnez	a0, 0x80200cc8 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xb2>
80200cb2: b9 a0        	j	0x80200d00 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xea>
;         return Some(x as u32);
80200cb4: 03 35 04 f4  	ld	a0, -192(s0)
80200cb8: 13 75 f5 0f  	andi	a0, a0, 255
80200cbc: 23 22 a4 f6  	sw	a0, -156(s0)
80200cc0: 05 45        	li	a0, 1
80200cc2: 23 20 a4 f6  	sw	a0, -160(s0)
; #![no_std]
80200cc6: 65 bf        	j	0x80200c7e <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x68>
;             Some(val) => val,
80200cc8: 03 35 04 f4  	ld	a0, -192(s0)
80200ccc: 83 35 84 f3  	ld	a1, -200(s0)
80200cd0: 03 36 84 f7  	ld	a2, -136(s0)
80200cd4: 23 3c c4 fa  	sd	a2, -72(s0)
;     let y = unsafe { *bytes.next().unwrap_unchecked() };
80200cd8: 03 46 06 00  	lbu	a2, 0(a2)
80200cdc: 23 38 c4 f2  	sd	a2, -208(s0)
80200ce0: a3 03 c4 fc  	sb	a2, -57(s0)
;     (ch << 6) | (byte & CONT_MASK) as u32
80200ce4: 9b 95 65 00  	slliw	a1, a1, 6
80200ce8: 13 76 f6 03  	andi	a2, a2, 63
80200cec: d1 8d        	or	a1, a1, a2
80200cee: 23 22 b4 f8  	sw	a1, -124(s0)
;     if x >= 0xE0 {
80200cf2: 93 75 f5 0f  	andi	a1, a0, 255
80200cf6: 13 05 f0 0d  	li	a0, 223
80200cfa: 63 6c b5 00  	bltu	a0, a1, 0x80200d12 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xfc>
80200cfe: 11 a0        	j	0x80200d02 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xec>
;     let x = *bytes.next()?;
80200d00: 00 00        	unimp	
;     Some(ch)
80200d02: 03 25 44 f8  	lw	a0, -124(s0)
80200d06: 23 22 a4 f6  	sw	a0, -156(s0)
80200d0a: 05 45        	li	a0, 1
80200d0c: 23 20 a4 f6  	sw	a0, -160(s0)
; }
80200d10: bd b7        	j	0x80200c7e <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x68>
;         let z = unsafe { *bytes.next().unwrap_unchecked() };
80200d12: 03 35 84 f4  	ld	a0, -184(s0)
80200d16: 97 f0 ff ff  	auipc	ra, 1048575
80200d1a: e7 80 20 66  	jalr	1634(ra)
80200d1e: 23 34 a4 f8  	sd	a0, -120(s0)
;         match self {
80200d22: 03 35 84 f8  	ld	a0, -120(s0)
80200d26: 69 dd        	beqz	a0, 0x80200d00 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xea>
80200d28: 09 a0        	j	0x80200d2a <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x114>
;             Some(val) => val,
80200d2a: 03 35 04 f4  	ld	a0, -192(s0)
80200d2e: 83 35 84 f3  	ld	a1, -200(s0)
80200d32: 03 36 04 f3  	ld	a2, -208(s0)
80200d36: 83 36 84 f8  	ld	a3, -120(s0)
80200d3a: 23 34 d4 fc  	sd	a3, -56(s0)
;         let z = unsafe { *bytes.next().unwrap_unchecked() };
80200d3e: 83 c6 06 00  	lbu	a3, 0(a3)
80200d42: a3 0b d4 fc  	sb	a3, -41(s0)
;         let y_z = utf8_acc_cont_byte((y & CONT_MASK) as u32, z);
80200d46: 13 76 f6 03  	andi	a2, a2, 63
80200d4a: 23 2c c4 fc  	sw	a2, -40(s0)
;     (ch << 6) | (byte & CONT_MASK) as u32
80200d4e: 1a 06        	slli	a2, a2, 6
80200d50: 93 f6 f6 03  	andi	a3, a3, 63
80200d54: 55 8e        	or	a2, a2, a3
80200d56: 23 34 c4 f2  	sd	a2, -216(s0)
80200d5a: 23 2e c4 fc  	sw	a2, -36(s0)
;         ch = init << 12 | y_z;
80200d5e: 9b 95 c5 00  	slliw	a1, a1, 12
80200d62: d1 8d        	or	a1, a1, a2
80200d64: 23 22 b4 f8  	sw	a1, -124(s0)
;         if x >= 0xF0 {
80200d68: 93 75 f5 0f  	andi	a1, a0, 255
80200d6c: 13 05 f0 0e  	li	a0, 239
80200d70: 63 64 b5 00  	bltu	a0, a1, 0x80200d78 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x162>
80200d74: 09 a0        	j	0x80200d76 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x160>
;     if x >= 0xE0 {
80200d76: 71 b7        	j	0x80200d02 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xec>
;             let w = unsafe { *bytes.next().unwrap_unchecked() };
80200d78: 03 35 84 f4  	ld	a0, -184(s0)
80200d7c: 97 f0 ff ff  	auipc	ra, 1048575
80200d80: e7 80 c0 5f  	jalr	1532(ra)
80200d84: 23 38 a4 f8  	sd	a0, -112(s0)
;         match self {
80200d88: 03 35 04 f9  	ld	a0, -112(s0)
80200d8c: 35 d9        	beqz	a0, 0x80200d00 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0xea>
80200d8e: 09 a0        	j	0x80200d90 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x17a>
;             Some(val) => val,
80200d90: 83 35 84 f2  	ld	a1, -216(s0)
80200d94: 03 35 84 f3  	ld	a0, -200(s0)
80200d98: 03 36 04 f9  	ld	a2, -112(s0)
80200d9c: 23 30 c4 fe  	sd	a2, -32(s0)
;             let w = unsafe { *bytes.next().unwrap_unchecked() };
80200da0: 03 46 06 00  	lbu	a2, 0(a2)
80200da4: a3 07 c4 fe  	sb	a2, -17(s0)
;             ch = (init & 7) << 18 | utf8_acc_cont_byte(y_z, w);
80200da8: 1d 89        	andi	a0, a0, 7
80200daa: 1b 15 25 01  	slliw	a0, a0, 18
;     (ch << 6) | (byte & CONT_MASK) as u32
80200dae: 9b 95 65 00  	slliw	a1, a1, 6
80200db2: 13 76 f6 03  	andi	a2, a2, 63
80200db6: d1 8d        	or	a1, a1, a2
;             ch = (init & 7) << 18 | utf8_acc_cont_byte(y_z, w);
80200db8: 4d 8d        	or	a0, a0, a1
80200dba: 23 22 a4 f8  	sw	a0, -124(s0)
;         if x >= 0xF0 {
80200dbe: 65 bf        	j	0x80200d76 <_ZN4core3str11validations15next_code_point17h71627d5488b2929bE+0x160>

0000000080200dc0 <rust_main>:
; pub fn rust_main() -> ! {
80200dc0: 11 71        	addi	sp, sp, -256
;     clear_bss();
80200dc2: 86 fd        	sd	ra, 248(sp)
80200dc4: a2 f9        	sd	s0, 240(sp)
80200dc6: 00 02        	addi	s0, sp, 256
80200dc8: 97 00 00 00  	auipc	ra, 0
80200dcc: e7 80 c0 0b  	jalr	188(ra)

0000000080200dd0 <.Lpcrel_hi1>:
;     info!("hello world");
80200dd0: 17 25 00 00  	auipc	a0, 2
80200dd4: 93 05 05 5d  	addi	a1, a0, 1488
80200dd8: 23 34 b4 f0  	sd	a1, -248(s0)
80200ddc: 13 05 04 f3  	addi	a0, s0, -208
80200de0: 23 30 a4 f0  	sd	a0, -256(s0)
80200de4: 05 46        	li	a2, 1
80200de6: 23 30 c4 f2  	sd	a2, -224(s0)
80200dea: 97 00 00 00  	auipc	ra, 0
80200dee: e7 80 20 da  	jalr	-606(ra)
80200df2: 03 35 04 f0  	ld	a0, -256(s0)
80200df6: 97 10 00 00  	auipc	ra, 1
80200dfa: e7 80 e0 86  	jalr	-1938(ra)
80200dfe: 83 35 84 f0  	ld	a1, -248(s0)
80200e02: 03 36 04 f2  	ld	a2, -224(s0)
80200e06: 13 05 04 f6  	addi	a0, s0, -160
;     error!("hello world");
80200e0a: 23 38 a4 f0  	sd	a0, -240(s0)
80200e0e: 97 00 00 00  	auipc	ra, 0
80200e12: e7 80 e0 d7  	jalr	-642(ra)
80200e16: 03 35 04 f1  	ld	a0, -240(s0)
80200e1a: 97 10 00 00  	auipc	ra, 1
80200e1e: e7 80 60 a4  	jalr	-1466(ra)
80200e22: 03 36 04 f2  	ld	a2, -224(s0)

0000000080200e26 <.Lpcrel_hi2>:
;     debug!("hello world ");
80200e26: 17 25 00 00  	auipc	a0, 2
80200e2a: 93 05 a5 59  	addi	a1, a0, 1434
80200e2e: 13 05 04 f9  	addi	a0, s0, -112
80200e32: 23 3c a4 f0  	sd	a0, -232(s0)
80200e36: 97 00 00 00  	auipc	ra, 0
80200e3a: e7 80 60 d5  	jalr	-682(ra)
80200e3e: 03 35 84 f1  	ld	a0, -232(s0)
80200e42: 97 10 00 00  	auipc	ra, 1
80200e46: e7 80 00 92  	jalr	-1760(ra)
;     print_info();
80200e4a: 97 00 00 00  	auipc	ra, 0
80200e4e: e7 80 20 07  	jalr	114(ra)
80200e52: 03 36 04 f2  	ld	a2, -224(s0)

0000000080200e56 <.Lpcrel_hi3>:
;     panic!("shutdown");
80200e56: 17 25 00 00  	auipc	a0, 2
80200e5a: 93 05 25 59  	addi	a1, a0, 1426
80200e5e: 13 05 04 fc  	addi	a0, s0, -64
80200e62: 23 34 a4 f2  	sd	a0, -216(s0)
80200e66: 97 00 00 00  	auipc	ra, 0
80200e6a: e7 80 60 d2  	jalr	-730(ra)
80200e6e: 03 35 84 f2  	ld	a0, -216(s0)

0000000080200e72 <.Lpcrel_hi4>:
80200e72: 97 25 00 00  	auipc	a1, 2
80200e76: 93 85 65 59  	addi	a1, a1, 1430
80200e7a: 97 10 00 00  	auipc	ra, 1
80200e7e: e7 80 80 68  	jalr	1672(ra)
80200e82: 00 00        	unimp	

0000000080200e84 <_ZN2os9clear_bss17h887bd92503bff9baE>:
; fn clear_bss(){
80200e84: 01 11        	addi	sp, sp, -32
;     (
80200e86: 06 ec        	sd	ra, 24(sp)
80200e88: 22 e8        	sd	s0, 16(sp)
80200e8a: 00 10        	addi	s0, sp, 32

0000000080200e8c <.Lpcrel_hi5>:
80200e8c: 17 a5 00 00  	auipc	a0, 10
80200e90: 13 05 45 17  	addi	a0, a0, 372
80200e94: 23 30 a4 fe  	sd	a0, -32(s0)

0000000080200e98 <.Lpcrel_hi6>:
80200e98: 17 a5 00 00  	auipc	a0, 10
80200e9c: 13 05 85 16  	addi	a0, a0, 360
80200ea0: 23 34 a4 fe  	sd	a0, -24(s0)
80200ea4: 03 35 04 fe  	ld	a0, -32(s0)
80200ea8: 83 35 84 fe  	ld	a1, -24(s0)
80200eac: 97 10 00 00  	auipc	ra, 1
80200eb0: e7 80 e0 bf  	jalr	-1026(ra)
; }
80200eb4: e2 60        	ld	ra, 24(sp)
80200eb6: 42 64        	ld	s0, 16(sp)
80200eb8: 05 61        	addi	sp, sp, 32
80200eba: 82 80        	ret

0000000080200ebc <_ZN2os10print_info17h466967e286a88a8bE>:
; fn print_info(){
80200ebc: 13 01 01 85  	addi	sp, sp, -1968
;     info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
80200ec0: 23 34 11 7a  	sd	ra, 1960(sp)
80200ec4: 23 30 81 7a  	sd	s0, 1952(sp)
80200ec8: 13 04 01 7b  	addi	s0, sp, 1968

0000000080200ecc <.Lpcrel_hi7>:
80200ecc: 17 f5 ff ff  	auipc	a0, 1048575
80200ed0: 13 05 45 13  	addi	a0, a0, 308
80200ed4: 23 3c a4 90  	sd	a0, -1768(s0)
80200ed8: 13 05 84 91  	addi	a0, s0, -1768
80200edc: 97 00 00 00  	auipc	ra, 0
80200ee0: e7 80 20 8a  	jalr	-1886(ra)
80200ee4: 23 38 a4 84  	sd	a0, -1968(s0)
80200ee8: 23 3c b4 84  	sd	a1, -1960(s0)

0000000080200eec <.Lpcrel_hi8>:
80200eec: 17 25 00 00  	auipc	a0, 2
80200ef0: 13 05 45 11  	addi	a0, a0, 276
80200ef4: 23 30 a4 92  	sd	a0, -1760(s0)
80200ef8: 13 05 04 92  	addi	a0, s0, -1760
80200efc: 97 00 00 00  	auipc	ra, 0
80200f00: e7 80 20 88  	jalr	-1918(ra)
80200f04: 83 36 04 85  	ld	a3, -1968(s0)
80200f08: 03 36 84 85  	ld	a2, -1960(s0)
80200f0c: 23 3c d4 8e  	sd	a3, -1800(s0)
80200f10: 23 30 c4 90  	sd	a2, -1792(s0)
80200f14: 23 34 a4 90  	sd	a0, -1784(s0)
80200f18: 23 38 b4 90  	sd	a1, -1776(s0)
80200f1c: 0d 46        	li	a2, 3
80200f1e: 23 30 c4 8a  	sd	a2, -1888(s0)
80200f22: a3 0b c4 9c  	sb	a2, -1577(s0)
80200f26: 09 48        	li	a6, 2
80200f28: 23 34 04 8b  	sd	a6, -1880(s0)
80200f2c: 23 3c 04 9d  	sd	a6, -1576(s0)
80200f30: 23 34 04 9f  	sd	a6, -1560(s0)
80200f34: 83 02 74 9d  	lb	t0, -1577(s0)
80200f38: 83 37 84 9d  	ld	a5, -1576(s0)
80200f3c: 03 37 04 9e  	ld	a4, -1568(s0)
80200f40: 83 36 84 9e  	ld	a3, -1560(s0)
80200f44: 83 35 04 9f  	ld	a1, -1552(s0)
80200f48: 01 45        	li	a0, 0
80200f4a: 23 3c a4 8a  	sd	a0, -1864(s0)
80200f4e: 23 38 a4 fa  	sd	a0, -80(s0)
80200f52: 13 03 00 02  	li	t1, 32
80200f56: 23 38 64 88  	sd	t1, -1904(s0)
80200f5a: 23 2e 64 fa  	sw	t1, -68(s0)
80200f5e: a3 01 54 fc  	sb	t0, -61(s0)
80200f62: 91 48        	li	a7, 4
80200f64: 23 3c 14 89  	sd	a7, -1896(s0)
80200f68: 23 22 14 fd  	sw	a7, -60(s0)
80200f6c: 23 34 f4 fc  	sd	a5, -56(s0)
80200f70: 23 38 e4 fc  	sd	a4, -48(s0)
80200f74: 23 3c d4 fc  	sd	a3, -40(s0)
80200f78: 23 30 b4 fe  	sd	a1, -32(s0)
;         Self { position, format: FormatSpec { fill, align, flags, precision, width } }
80200f7c: 23 22 64 fa  	sw	t1, -92(s0)
80200f80: 23 04 54 fa  	sb	t0, -88(s0)
80200f84: 23 20 14 fb  	sw	a7, -96(s0)
80200f88: 23 30 f4 f8  	sd	a5, -128(s0)
80200f8c: 23 34 e4 f8  	sd	a4, -120(s0)
80200f90: 23 38 d4 f8  	sd	a3, -112(s0)
80200f94: 23 3c b4 f8  	sd	a1, -104(s0)
80200f98: 23 34 a4 9c  	sd	a0, -1592(s0)
80200f9c: 03 35 84 fa  	ld	a0, -88(s0)
80200fa0: 23 30 a4 9c  	sd	a0, -1600(s0)
80200fa4: 03 35 04 fa  	ld	a0, -96(s0)
80200fa8: 23 3c a4 9a  	sd	a0, -1608(s0)
80200fac: 03 35 84 f9  	ld	a0, -104(s0)
80200fb0: 23 38 a4 9a  	sd	a0, -1616(s0)
80200fb4: 03 35 04 f9  	ld	a0, -112(s0)
80200fb8: 23 34 a4 9a  	sd	a0, -1624(s0)
80200fbc: 03 35 84 f8  	ld	a0, -120(s0)
80200fc0: 23 30 a4 9a  	sd	a0, -1632(s0)
80200fc4: 03 35 04 f8  	ld	a0, -128(s0)
80200fc8: 23 3c a4 98  	sd	a0, -1640(s0)
;     info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
80200fcc: a3 0b c4 a2  	sb	a2, -1481(s0)
80200fd0: 23 3c 04 a3  	sd	a6, -1480(s0)
80200fd4: 23 34 04 a5  	sd	a6, -1464(s0)
80200fd8: 83 02 74 a3  	lb	t0, -1481(s0)
80200fdc: 83 37 84 a3  	ld	a5, -1480(s0)
80200fe0: 03 37 04 a4  	ld	a4, -1472(s0)
80200fe4: 83 36 84 a4  	ld	a3, -1464(s0)
80200fe8: 83 35 04 a5  	ld	a1, -1456(s0)
80200fec: 05 45        	li	a0, 1
80200fee: 23 38 a4 8a  	sd	a0, -1872(s0)
80200ff2: 23 34 a4 f4  	sd	a0, -184(s0)
80200ff6: 23 2a 64 f4  	sw	t1, -172(s0)
80200ffa: a3 0d 54 f4  	sb	t0, -165(s0)
80200ffe: 23 2e 14 f5  	sw	a7, -164(s0)
80201002: 23 30 f4 f6  	sd	a5, -160(s0)
80201006: 23 34 e4 f6  	sd	a4, -152(s0)
8020100a: 23 38 d4 f6  	sd	a3, -144(s0)
8020100e: 23 3c b4 f6  	sd	a1, -136(s0)
;         Self { position, format: FormatSpec { fill, align, flags, precision, width } }
80201012: 23 2e 64 f2  	sw	t1, -196(s0)
80201016: 23 00 54 f4  	sb	t0, -192(s0)
8020101a: 23 2c 14 f3  	sw	a7, -200(s0)
8020101e: 23 3c f4 f0  	sd	a5, -232(s0)
80201022: 23 30 e4 f2  	sd	a4, -224(s0)
80201026: 23 34 d4 f2  	sd	a3, -216(s0)
8020102a: 23 38 b4 f2  	sd	a1, -208(s0)
8020102e: 23 34 a4 a2  	sd	a0, -1496(s0)
80201032: 03 35 04 f4  	ld	a0, -192(s0)
80201036: 23 30 a4 a2  	sd	a0, -1504(s0)
8020103a: 03 35 84 f3  	ld	a0, -200(s0)
8020103e: 23 3c a4 a0  	sd	a0, -1512(s0)
80201042: 03 35 04 f3  	ld	a0, -208(s0)
80201046: 23 38 a4 a0  	sd	a0, -1520(s0)
8020104a: 03 35 84 f2  	ld	a0, -216(s0)
8020104e: 23 34 a4 a0  	sd	a0, -1528(s0)
80201052: 03 35 04 f2  	ld	a0, -224(s0)
80201056: 23 30 a4 a0  	sd	a0, -1536(s0)
8020105a: 03 35 84 f1  	ld	a0, -232(s0)
8020105e: 23 3c a4 9e  	sd	a0, -1544(s0)
;     info!(".text [{:#x}, {:#x})", stext as usize, etext as usize);
80201062: 03 35 84 9c  	ld	a0, -1592(s0)
80201066: 23 3c a4 94  	sd	a0, -1704(s0)
8020106a: 03 35 04 9c  	ld	a0, -1600(s0)
8020106e: 23 38 a4 94  	sd	a0, -1712(s0)
80201072: 03 35 84 9b  	ld	a0, -1608(s0)
80201076: 23 34 a4 94  	sd	a0, -1720(s0)
8020107a: 03 35 04 9b  	ld	a0, -1616(s0)
8020107e: 23 30 a4 94  	sd	a0, -1728(s0)
80201082: 03 35 84 9a  	ld	a0, -1624(s0)
80201086: 23 3c a4 92  	sd	a0, -1736(s0)
8020108a: 03 35 04 9a  	ld	a0, -1632(s0)
8020108e: 23 38 a4 92  	sd	a0, -1744(s0)
80201092: 03 35 84 99  	ld	a0, -1640(s0)
80201096: 23 34 a4 92  	sd	a0, -1752(s0)
8020109a: 03 35 84 a2  	ld	a0, -1496(s0)
8020109e: 23 38 a4 98  	sd	a0, -1648(s0)
802010a2: 03 35 04 a2  	ld	a0, -1504(s0)
802010a6: 23 34 a4 98  	sd	a0, -1656(s0)
802010aa: 03 35 84 a1  	ld	a0, -1512(s0)
802010ae: 23 30 a4 98  	sd	a0, -1664(s0)
802010b2: 03 35 04 a1  	ld	a0, -1520(s0)
802010b6: 23 3c a4 96  	sd	a0, -1672(s0)
802010ba: 03 35 84 a0  	ld	a0, -1528(s0)
802010be: 23 38 a4 96  	sd	a0, -1680(s0)
802010c2: 03 35 04 a0  	ld	a0, -1536(s0)
802010c6: 23 34 a4 96  	sd	a0, -1688(s0)
802010ca: 03 35 84 9f  	ld	a0, -1544(s0)
802010ce: 23 30 a4 96  	sd	a0, -1696(s0)

00000000802010d2 <.Lpcrel_hi9>:
802010d2: 17 25 00 00  	auipc	a0, 2
802010d6: 93 05 e5 35  	addi	a1, a0, 862
802010da: 13 05 84 8c  	addi	a0, s0, -1848
802010de: 23 30 a4 86  	sd	a0, -1952(s0)
802010e2: 93 06 84 8f  	addi	a3, s0, -1800
802010e6: 93 07 84 92  	addi	a5, s0, -1752
802010ea: 42 87        	mv	a4, a6
802010ec: 97 00 00 00  	auipc	ra, 0
802010f0: e7 80 e0 99  	jalr	-1634(ra)
802010f4: 03 35 04 86  	ld	a0, -1952(s0)
802010f8: 97 00 00 00  	auipc	ra, 0
802010fc: e7 80 c0 56  	jalr	1388(ra)

0000000080201100 <.Lpcrel_hi10>:
;     debug!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
80201100: 17 25 00 00  	auipc	a0, 2
80201104: 13 05 05 f0  	addi	a0, a0, -256
80201108: 23 34 a4 aa  	sd	a0, -1368(s0)
8020110c: 13 05 84 aa  	addi	a0, s0, -1368
80201110: 97 f0 ff ff  	auipc	ra, 1048575
80201114: e7 80 e0 66  	jalr	1646(ra)
80201118: 23 34 a4 86  	sd	a0, -1944(s0)
8020111c: 23 38 b4 86  	sd	a1, -1936(s0)

0000000080201120 <.Lpcrel_hi11>:
80201120: 17 35 00 00  	auipc	a0, 3
80201124: 13 05 05 ee  	addi	a0, a0, -288
80201128: 23 38 a4 aa  	sd	a0, -1360(s0)
8020112c: 13 05 04 ab  	addi	a0, s0, -1360
80201130: 97 f0 ff ff  	auipc	ra, 1048575
80201134: e7 80 e0 64  	jalr	1614(ra)
80201138: 83 32 84 86  	ld	t0, -1944(s0)
8020113c: 83 37 04 87  	ld	a5, -1936(s0)
80201140: 03 33 04 89  	ld	t1, -1904(s0)
80201144: 83 38 84 89  	ld	a7, -1896(s0)
80201148: 03 36 04 8a  	ld	a2, -1888(s0)
8020114c: 03 38 84 8a  	ld	a6, -1880(s0)
80201150: 2a 87        	mv	a4, a0
80201152: 03 35 04 8b  	ld	a0, -1872(s0)
80201156: ae 86        	mv	a3, a1
80201158: 83 35 84 8b  	ld	a1, -1864(s0)
8020115c: 23 34 54 a8  	sd	t0, -1400(s0)
80201160: 23 38 f4 a8  	sd	a5, -1392(s0)
80201164: 23 3c e4 a8  	sd	a4, -1384(s0)
80201168: 23 30 d4 aa  	sd	a3, -1376(s0)
8020116c: a3 03 c4 b6  	sb	a2, -1177(s0)
80201170: 23 34 04 b7  	sd	a6, -1176(s0)
80201174: 23 3c 04 b7  	sd	a6, -1160(s0)
80201178: 83 03 74 b6  	lb	t2, -1177(s0)
8020117c: 83 32 84 b6  	ld	t0, -1176(s0)
80201180: 83 37 04 b7  	ld	a5, -1168(s0)
80201184: 03 37 84 b7  	ld	a4, -1160(s0)
80201188: 83 36 04 b8  	ld	a3, -1152(s0)
8020118c: 23 30 b4 ee  	sd	a1, -288(s0)
80201190: 23 26 64 ee  	sw	t1, -276(s0)
80201194: a3 09 74 ee  	sb	t2, -269(s0)
80201198: 23 2a 14 ef  	sw	a7, -268(s0)
8020119c: 23 3c 54 ee  	sd	t0, -264(s0)
802011a0: 23 30 f4 f0  	sd	a5, -256(s0)
802011a4: 23 34 e4 f0  	sd	a4, -248(s0)
802011a8: 23 38 d4 f0  	sd	a3, -240(s0)
;         Self { position, format: FormatSpec { fill, align, flags, precision, width } }
802011ac: 23 2a 64 ec  	sw	t1, -300(s0)
802011b0: 23 0c 74 ec  	sb	t2, -296(s0)
802011b4: 23 28 14 ed  	sw	a7, -304(s0)
802011b8: 23 38 54 ea  	sd	t0, -336(s0)
802011bc: 23 3c f4 ea  	sd	a5, -328(s0)
802011c0: 23 30 e4 ec  	sd	a4, -320(s0)
802011c4: 23 34 d4 ec  	sd	a3, -312(s0)
802011c8: 23 3c b4 b4  	sd	a1, -1192(s0)
802011cc: 83 35 84 ed  	ld	a1, -296(s0)
802011d0: 23 38 b4 b4  	sd	a1, -1200(s0)
802011d4: 83 35 04 ed  	ld	a1, -304(s0)
802011d8: 23 34 b4 b4  	sd	a1, -1208(s0)
802011dc: 83 35 84 ec  	ld	a1, -312(s0)
802011e0: 23 30 b4 b4  	sd	a1, -1216(s0)
802011e4: 83 35 04 ec  	ld	a1, -320(s0)
802011e8: 23 3c b4 b2  	sd	a1, -1224(s0)
802011ec: 83 35 84 eb  	ld	a1, -328(s0)
802011f0: 23 38 b4 b2  	sd	a1, -1232(s0)
802011f4: 83 35 04 eb  	ld	a1, -336(s0)
802011f8: 23 34 b4 b2  	sd	a1, -1240(s0)
;     debug!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
802011fc: a3 03 c4 bc  	sb	a2, -1081(s0)
80201200: 23 34 04 bd  	sd	a6, -1080(s0)
80201204: 23 3c 04 bd  	sd	a6, -1064(s0)
80201208: 83 02 74 bc  	lb	t0, -1081(s0)
8020120c: 83 37 84 bc  	ld	a5, -1080(s0)
80201210: 03 37 04 bd  	ld	a4, -1072(s0)
80201214: 83 36 84 bd  	ld	a3, -1064(s0)
80201218: 83 35 04 be  	ld	a1, -1056(s0)
8020121c: 23 3c a4 e6  	sd	a0, -392(s0)
80201220: 23 22 64 e8  	sw	t1, -380(s0)
80201224: a3 05 54 e8  	sb	t0, -373(s0)
80201228: 23 26 14 e9  	sw	a7, -372(s0)
8020122c: 23 38 f4 e8  	sd	a5, -368(s0)
80201230: 23 3c e4 e8  	sd	a4, -360(s0)
80201234: 23 30 d4 ea  	sd	a3, -352(s0)
80201238: 23 34 b4 ea  	sd	a1, -344(s0)
;         Self { position, format: FormatSpec { fill, align, flags, precision, width } }
8020123c: 23 26 64 e6  	sw	t1, -404(s0)
80201240: 23 08 54 e6  	sb	t0, -400(s0)
80201244: 23 24 14 e7  	sw	a7, -408(s0)
80201248: 23 34 f4 e4  	sd	a5, -440(s0)
8020124c: 23 38 e4 e4  	sd	a4, -432(s0)
80201250: 23 3c d4 e4  	sd	a3, -424(s0)
80201254: 23 30 b4 e6  	sd	a1, -416(s0)
80201258: 23 3c a4 ba  	sd	a0, -1096(s0)
8020125c: 03 35 04 e7  	ld	a0, -400(s0)
80201260: 23 38 a4 ba  	sd	a0, -1104(s0)
80201264: 03 35 84 e6  	ld	a0, -408(s0)
80201268: 23 34 a4 ba  	sd	a0, -1112(s0)
8020126c: 03 35 04 e6  	ld	a0, -416(s0)
80201270: 23 30 a4 ba  	sd	a0, -1120(s0)
80201274: 03 35 84 e5  	ld	a0, -424(s0)
80201278: 23 3c a4 b8  	sd	a0, -1128(s0)
8020127c: 03 35 04 e5  	ld	a0, -432(s0)
80201280: 23 38 a4 b8  	sd	a0, -1136(s0)
80201284: 03 35 84 e4  	ld	a0, -440(s0)
80201288: 23 34 a4 b8  	sd	a0, -1144(s0)
;     debug!(".rodata [{:#x}, {:#x})", srodata as usize, erodata as usize);
8020128c: 03 35 84 b5  	ld	a0, -1192(s0)
80201290: 23 34 a4 ae  	sd	a0, -1304(s0)
80201294: 03 35 04 b5  	ld	a0, -1200(s0)
80201298: 23 30 a4 ae  	sd	a0, -1312(s0)
8020129c: 03 35 84 b4  	ld	a0, -1208(s0)
802012a0: 23 3c a4 ac  	sd	a0, -1320(s0)
802012a4: 03 35 04 b4  	ld	a0, -1216(s0)
802012a8: 23 38 a4 ac  	sd	a0, -1328(s0)
802012ac: 03 35 84 b3  	ld	a0, -1224(s0)
802012b0: 23 34 a4 ac  	sd	a0, -1336(s0)
802012b4: 03 35 04 b3  	ld	a0, -1232(s0)
802012b8: 23 30 a4 ac  	sd	a0, -1344(s0)
802012bc: 03 35 84 b2  	ld	a0, -1240(s0)
802012c0: 23 3c a4 aa  	sd	a0, -1352(s0)
802012c4: 03 35 84 bb  	ld	a0, -1096(s0)
802012c8: 23 30 a4 b2  	sd	a0, -1248(s0)
802012cc: 03 35 04 bb  	ld	a0, -1104(s0)
802012d0: 23 3c a4 b0  	sd	a0, -1256(s0)
802012d4: 03 35 84 ba  	ld	a0, -1112(s0)
802012d8: 23 38 a4 b0  	sd	a0, -1264(s0)
802012dc: 03 35 04 ba  	ld	a0, -1120(s0)
802012e0: 23 34 a4 b0  	sd	a0, -1272(s0)
802012e4: 03 35 84 b9  	ld	a0, -1128(s0)
802012e8: 23 30 a4 b0  	sd	a0, -1280(s0)
802012ec: 03 35 04 b9  	ld	a0, -1136(s0)
802012f0: 23 3c a4 ae  	sd	a0, -1288(s0)
802012f4: 03 35 84 b8  	ld	a0, -1144(s0)
802012f8: 23 38 a4 ae  	sd	a0, -1296(s0)

00000000802012fc <.Lpcrel_hi12>:
802012fc: 17 25 00 00  	auipc	a0, 2
80201300: 93 05 45 17  	addi	a1, a0, 372
80201304: 13 05 84 a5  	addi	a0, s0, -1448
80201308: 23 3c a4 86  	sd	a0, -1928(s0)
8020130c: 93 06 84 a8  	addi	a3, s0, -1400
80201310: 93 07 84 ab  	addi	a5, s0, -1352
80201314: 42 87        	mv	a4, a6
80201316: 97 f0 ff ff  	auipc	ra, 1048575
8020131a: e7 80 40 77  	jalr	1908(ra)
8020131e: 03 35 84 87  	ld	a0, -1928(s0)
80201322: 97 00 00 00  	auipc	ra, 0
80201326: e7 80 00 44  	jalr	1088(ra)

000000008020132a <.Lpcrel_hi13>:
;     error!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
8020132a: 17 35 00 00  	auipc	a0, 3
8020132e: 13 05 65 cd  	addi	a0, a0, -810
80201332: 23 3c a4 c2  	sd	a0, -968(s0)
80201336: 13 05 84 c3  	addi	a0, s0, -968
8020133a: 97 f0 ff ff  	auipc	ra, 1048575
8020133e: e7 80 40 44  	jalr	1092(ra)
80201342: 23 30 a4 88  	sd	a0, -1920(s0)
80201346: 23 34 b4 88  	sd	a1, -1912(s0)

000000008020134a <.Lpcrel_hi14>:
8020134a: 17 45 00 00  	auipc	a0, 4
8020134e: 13 05 65 cb  	addi	a0, a0, -842
80201352: 23 30 a4 c4  	sd	a0, -960(s0)
80201356: 13 05 04 c4  	addi	a0, s0, -960
8020135a: 97 f0 ff ff  	auipc	ra, 1048575
8020135e: e7 80 40 42  	jalr	1060(ra)
80201362: 83 32 04 88  	ld	t0, -1920(s0)
80201366: 83 37 84 88  	ld	a5, -1912(s0)
8020136a: 03 33 04 89  	ld	t1, -1904(s0)
8020136e: 83 38 84 89  	ld	a7, -1896(s0)
80201372: 03 36 04 8a  	ld	a2, -1888(s0)
80201376: 03 38 84 8a  	ld	a6, -1880(s0)
8020137a: 2a 87        	mv	a4, a0
8020137c: 03 35 04 8b  	ld	a0, -1872(s0)
80201380: ae 86        	mv	a3, a1
80201382: 83 35 84 8b  	ld	a1, -1864(s0)
80201386: 23 3c 54 c0  	sd	t0, -1000(s0)
8020138a: 23 30 f4 c2  	sd	a5, -992(s0)
8020138e: 23 34 e4 c2  	sd	a4, -984(s0)
80201392: 23 38 d4 c2  	sd	a3, -976(s0)
80201396: a3 0b c4 ce  	sb	a2, -777(s0)
8020139a: 23 3c 04 cf  	sd	a6, -776(s0)
8020139e: 23 34 04 d1  	sd	a6, -760(s0)
802013a2: 83 03 74 cf  	lb	t2, -777(s0)
802013a6: 83 32 84 cf  	ld	t0, -776(s0)
802013aa: 83 37 04 d0  	ld	a5, -768(s0)
802013ae: 03 37 84 d0  	ld	a4, -760(s0)
802013b2: 83 36 04 d1  	ld	a3, -752(s0)
802013b6: 23 38 b4 e0  	sd	a1, -496(s0)
802013ba: 23 2e 64 e0  	sw	t1, -484(s0)
802013be: a3 01 74 e2  	sb	t2, -477(s0)
802013c2: 23 22 14 e3  	sw	a7, -476(s0)
802013c6: 23 34 54 e2  	sd	t0, -472(s0)
802013ca: 23 38 f4 e2  	sd	a5, -464(s0)
802013ce: 23 3c e4 e2  	sd	a4, -456(s0)
802013d2: 23 30 d4 e4  	sd	a3, -448(s0)
;         Self { position, format: FormatSpec { fill, align, flags, precision, width } }
802013d6: 23 22 64 e0  	sw	t1, -508(s0)
802013da: 23 04 74 e0  	sb	t2, -504(s0)
802013de: 23 20 14 e1  	sw	a7, -512(s0)
802013e2: 23 30 54 de  	sd	t0, -544(s0)
802013e6: 23 34 f4 de  	sd	a5, -536(s0)
802013ea: 23 38 e4 de  	sd	a4, -528(s0)
802013ee: 23 3c d4 de  	sd	a3, -520(s0)
802013f2: 23 34 b4 ce  	sd	a1, -792(s0)
802013f6: 83 35 84 e0  	ld	a1, -504(s0)
802013fa: 23 30 b4 ce  	sd	a1, -800(s0)
802013fe: 83 35 04 e0  	ld	a1, -512(s0)
80201402: 23 3c b4 cc  	sd	a1, -808(s0)
80201406: 83 35 84 df  	ld	a1, -520(s0)
8020140a: 23 38 b4 cc  	sd	a1, -816(s0)
8020140e: 83 35 04 df  	ld	a1, -528(s0)
80201412: 23 34 b4 cc  	sd	a1, -824(s0)
80201416: 83 35 84 de  	ld	a1, -536(s0)
8020141a: 23 30 b4 cc  	sd	a1, -832(s0)
8020141e: 83 35 04 de  	ld	a1, -544(s0)
80201422: 23 3c b4 ca  	sd	a1, -840(s0)
;     error!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
80201426: a3 0b c4 d4  	sb	a2, -681(s0)
8020142a: 23 3c 04 d5  	sd	a6, -680(s0)
8020142e: 23 34 04 d7  	sd	a6, -664(s0)
80201432: 83 02 74 d5  	lb	t0, -681(s0)
80201436: 83 37 84 d5  	ld	a5, -680(s0)
8020143a: 03 37 04 d6  	ld	a4, -672(s0)
8020143e: 83 36 84 d6  	ld	a3, -664(s0)
80201442: 83 35 04 d7  	ld	a1, -656(s0)
80201446: 23 34 a4 da  	sd	a0, -600(s0)
8020144a: 23 2a 64 da  	sw	t1, -588(s0)
8020144e: a3 0d 54 da  	sb	t0, -581(s0)
80201452: 23 2e 14 db  	sw	a7, -580(s0)
80201456: 23 30 f4 dc  	sd	a5, -576(s0)
8020145a: 23 34 e4 dc  	sd	a4, -568(s0)
8020145e: 23 38 d4 dc  	sd	a3, -560(s0)
80201462: 23 3c b4 dc  	sd	a1, -552(s0)
;         Self { position, format: FormatSpec { fill, align, flags, precision, width } }
80201466: 23 2e 64 d8  	sw	t1, -612(s0)
8020146a: 23 00 54 da  	sb	t0, -608(s0)
8020146e: 23 2c 14 d9  	sw	a7, -616(s0)
80201472: 23 3c f4 d6  	sd	a5, -648(s0)
80201476: 23 30 e4 d8  	sd	a4, -640(s0)
8020147a: 23 34 d4 d8  	sd	a3, -632(s0)
8020147e: 23 38 b4 d8  	sd	a1, -624(s0)
80201482: 23 34 a4 d4  	sd	a0, -696(s0)
80201486: 03 35 04 da  	ld	a0, -608(s0)
8020148a: 23 30 a4 d4  	sd	a0, -704(s0)
8020148e: 03 35 84 d9  	ld	a0, -616(s0)
80201492: 23 3c a4 d2  	sd	a0, -712(s0)
80201496: 03 35 04 d9  	ld	a0, -624(s0)
8020149a: 23 38 a4 d2  	sd	a0, -720(s0)
8020149e: 03 35 84 d8  	ld	a0, -632(s0)
802014a2: 23 34 a4 d2  	sd	a0, -728(s0)
802014a6: 03 35 04 d8  	ld	a0, -640(s0)
802014aa: 23 30 a4 d2  	sd	a0, -736(s0)
802014ae: 03 35 84 d7  	ld	a0, -648(s0)
802014b2: 23 3c a4 d0  	sd	a0, -744(s0)
;     error!(".data [{:#x}, {:#x})", sdata as usize, edata as usize);
802014b6: 03 35 84 ce  	ld	a0, -792(s0)
802014ba: 23 3c a4 c6  	sd	a0, -904(s0)
802014be: 03 35 04 ce  	ld	a0, -800(s0)
802014c2: 23 38 a4 c6  	sd	a0, -912(s0)
802014c6: 03 35 84 cd  	ld	a0, -808(s0)
802014ca: 23 34 a4 c6  	sd	a0, -920(s0)
802014ce: 03 35 04 cd  	ld	a0, -816(s0)
802014d2: 23 30 a4 c6  	sd	a0, -928(s0)
802014d6: 03 35 84 cc  	ld	a0, -824(s0)
802014da: 23 3c a4 c4  	sd	a0, -936(s0)
802014de: 03 35 04 cc  	ld	a0, -832(s0)
802014e2: 23 38 a4 c4  	sd	a0, -944(s0)
802014e6: 03 35 84 cb  	ld	a0, -840(s0)
802014ea: 23 34 a4 c4  	sd	a0, -952(s0)
802014ee: 03 35 84 d4  	ld	a0, -696(s0)
802014f2: 23 38 a4 ca  	sd	a0, -848(s0)
802014f6: 03 35 04 d4  	ld	a0, -704(s0)
802014fa: 23 34 a4 ca  	sd	a0, -856(s0)
802014fe: 03 35 84 d3  	ld	a0, -712(s0)
80201502: 23 30 a4 ca  	sd	a0, -864(s0)
80201506: 03 35 04 d3  	ld	a0, -720(s0)
8020150a: 23 3c a4 c8  	sd	a0, -872(s0)
8020150e: 03 35 84 d2  	ld	a0, -728(s0)
80201512: 23 38 a4 c8  	sd	a0, -880(s0)
80201516: 03 35 04 d2  	ld	a0, -736(s0)
8020151a: 23 34 a4 c8  	sd	a0, -888(s0)
8020151e: 03 35 84 d1  	ld	a0, -744(s0)
80201522: 23 30 a4 c8  	sd	a0, -896(s0)

0000000080201526 <.Lpcrel_hi15>:
80201526: 17 25 00 00  	auipc	a0, 2
8020152a: 93 05 25 f8  	addi	a1, a0, -126
8020152e: 13 05 84 be  	addi	a0, s0, -1048
80201532: 23 30 a4 8c  	sd	a0, -1856(s0)
80201536: 93 06 84 c1  	addi	a3, s0, -1000
8020153a: 93 07 84 c4  	addi	a5, s0, -952
8020153e: 42 87        	mv	a4, a6
80201540: 97 f0 ff ff  	auipc	ra, 1048575
80201544: e7 80 a0 54  	jalr	1354(ra)
80201548: 03 35 04 8c  	ld	a0, -1856(s0)
8020154c: 97 00 00 00  	auipc	ra, 0
80201550: e7 80 40 31  	jalr	788(ra)
; }
80201554: 83 30 81 7a  	ld	ra, 1960(sp)
80201558: 03 34 01 7a  	ld	s0, 1952(sp)
8020155c: 13 01 01 7b  	addi	sp, sp, 1968
80201560: 82 80        	ret

0000000080201562 <_ZN4core4iter6traits8iterator8Iterator8for_each4call28_$u7b$$u7b$closure$u7d$$u7d$17hc7851d40adc9562cE>:
;             move |(), item| f(item)
80201562: 79 71        	addi	sp, sp, -48
80201564: 06 f4        	sd	ra, 40(sp)
80201566: 22 f0        	sd	s0, 32(sp)
80201568: 00 18        	addi	s0, sp, 48
8020156a: 23 3c a4 fc  	sd	a0, -40(s0)
8020156e: 23 34 b4 fe  	sd	a1, -24(s0)
80201572: 23 38 b4 fc  	sd	a1, -48(s0)
80201576: 83 35 04 fd  	ld	a1, -48(s0)
8020157a: 97 f0 ff ff  	auipc	ra, 1048575
8020157e: e7 80 80 ef  	jalr	-264(ra)
80201582: a2 70        	ld	ra, 40(sp)
80201584: 02 74        	ld	s0, 32(sp)
80201586: 45 61        	addi	sp, sp, 48
80201588: 82 80        	ret

000000008020158a <_ZN54_$LT$os..console..Ptcr$u20$as$u20$core..fmt..Write$GT$9write_str17hbe5634e587f5b1baE>:
;     fn write_str(&mut self,s:&str) -> fmt::Result{
8020158a: 1d 71        	addi	sp, sp, -96
8020158c: 86 ec        	sd	ra, 88(sp)
8020158e: a2 e8        	sd	s0, 80(sp)
80201590: 80 10        	addi	s0, sp, 96
80201592: 23 30 c4 fa  	sd	a2, -96(s0)
80201596: 2e 86        	mv	a2, a1
80201598: 83 35 04 fa  	ld	a1, -96(s0)
8020159c: 23 34 c4 fa  	sd	a2, -88(s0)
802015a0: 2a 86        	mv	a2, a0
802015a2: 03 35 84 fa  	ld	a0, -88(s0)
802015a6: 23 38 c4 fc  	sd	a2, -48(s0)
802015aa: 23 3c a4 fc  	sd	a0, -40(s0)
802015ae: 23 30 b4 fe  	sd	a1, -32(s0)
;         for c in s.chars(){
802015b2: 97 00 00 00  	auipc	ra, 0
802015b6: e7 80 00 5a  	jalr	1440(ra)
802015ba: 97 f0 ff ff  	auipc	ra, 1048575
802015be: e7 80 40 f7  	jalr	-140(ra)
802015c2: 23 3c a4 fa  	sd	a0, -72(s0)
802015c6: 23 30 b4 fc  	sd	a1, -64(s0)
802015ca: 09 a0        	j	0x802015cc <_ZN54_$LT$os..console..Ptcr$u20$as$u20$core..fmt..Write$GT$9write_str17hbe5634e587f5b1baE+0x42>
802015cc: 13 05 84 fb  	addi	a0, s0, -72
;         for c in s.chars(){
802015d0: 97 00 00 00  	auipc	ra, 0
802015d4: e7 80 a0 5d  	jalr	1498(ra)
802015d8: 7d 99        	andi	a0, a0, -1
802015da: 23 26 a4 fc  	sw	a0, -52(s0)
802015de: 03 25 c4 fc  	lw	a0, -52(s0)
802015e2: b7 05 11 00  	lui	a1, 272
802015e6: 63 1c b5 00  	bne	a0, a1, 0x802015fe <_ZN54_$LT$os..console..Ptcr$u20$as$u20$core..fmt..Write$GT$9write_str17hbe5634e587f5b1baE+0x74>
802015ea: 09 a0        	j	0x802015ec <_ZN54_$LT$os..console..Ptcr$u20$as$u20$core..fmt..Write$GT$9write_str17hbe5634e587f5b1baE+0x62>
802015ec: 01 45        	li	a0, 0
;         Ok(())
802015ee: a3 0b a4 fa  	sb	a0, -73(s0)
;     }
802015f2: 03 45 74 fb  	lbu	a0, -73(s0)
802015f6: e6 60        	ld	ra, 88(sp)
802015f8: 46 64        	ld	s0, 80(sp)
802015fa: 25 61        	addi	sp, sp, 96
802015fc: 82 80        	ret
;         for c in s.chars(){
802015fe: 03 65 c4 fc  	lwu	a0, -52(s0)
80201602: 23 26 a4 fe  	sw	a0, -20(s0)
;             consele_putchar(c as usize);
80201606: 97 f0 ff ff  	auipc	ra, 1048575
8020160a: e7 80 20 e9  	jalr	-366(ra)
8020160e: 7d bf        	j	0x802015cc <_ZN54_$LT$os..console..Ptcr$u20$as$u20$core..fmt..Write$GT$9write_str17hbe5634e587f5b1baE+0x42>

0000000080201610 <_ZN2os7console5print17h5b8fcc706c7209c0E>:
; pub fn print(args: fmt::Arguments) {
80201610: 5d 71        	addi	sp, sp, -80
;     Ptcr.write_fmt(args).unwrap();
80201612: 86 e4        	sd	ra, 72(sp)
80201614: a2 e0        	sd	s0, 64(sp)
80201616: 80 08        	addi	s0, sp, 80
80201618: 0c 75        	ld	a1, 40(a0)
8020161a: 23 34 b4 fe  	sd	a1, -24(s0)
8020161e: 0c 71        	ld	a1, 32(a0)
80201620: 23 30 b4 fe  	sd	a1, -32(s0)
80201624: 0c 6d        	ld	a1, 24(a0)
80201626: 23 3c b4 fc  	sd	a1, -40(s0)
8020162a: 0c 69        	ld	a1, 16(a0)
8020162c: 23 38 b4 fc  	sd	a1, -48(s0)
80201630: 0c 65        	ld	a1, 8(a0)
80201632: 23 34 b4 fc  	sd	a1, -56(s0)
80201636: 08 61        	ld	a0, 0(a0)
80201638: 23 30 a4 fc  	sd	a0, -64(s0)
8020163c: 13 05 84 fb  	addi	a0, s0, -72
80201640: 93 05 04 fc  	addi	a1, s0, -64
80201644: 97 f0 ff ff  	auipc	ra, 1048575
80201648: e7 80 c0 f7  	jalr	-132(ra)

000000008020164c <.Lpcrel_hi0>:
8020164c: 97 25 00 00  	auipc	a1, 2
80201650: 93 85 c5 e9  	addi	a1, a1, -356
80201654: 97 f0 ff ff  	auipc	ra, 1048575
80201658: e7 80 c0 bd  	jalr	-1060(ra)
; }
8020165c: a6 60        	ld	ra, 72(sp)
8020165e: 06 64        	ld	s0, 64(sp)
80201660: 61 61        	addi	sp, sp, 80
80201662: 82 80        	ret

0000000080201664 <_ZN2os7console4info17h50809f727cefec65E>:
; pub fn info(args:fmt::Arguments){
80201664: 29 71        	addi	sp, sp, -320
80201666: 06 fe        	sd	ra, 312(sp)
80201668: 22 fa        	sd	s0, 304(sp)
8020166a: 80 02        	addi	s0, sp, 320
8020166c: 23 3c a4 ec  	sd	a0, -296(s0)

0000000080201670 <.Lpcrel_hi1>:
;     print!("\x1b[34m");
80201670: 17 25 00 00  	auipc	a0, 2
80201674: 93 05 85 e9  	addi	a1, a0, -360
80201678: 13 05 84 ef  	addi	a0, s0, -264
8020167c: 23 34 a4 ec  	sd	a0, -312(s0)
80201680: 05 46        	li	a2, 1
80201682: 23 34 c4 ee  	sd	a2, -280(s0)
80201686: 97 f0 ff ff  	auipc	ra, 1048575
8020168a: e7 80 60 50  	jalr	1286(ra)
8020168e: 03 35 84 ec  	ld	a0, -312(s0)
80201692: 97 00 00 00  	auipc	ra, 0
80201696: e7 80 e0 f7  	jalr	-130(ra)
8020169a: 03 36 84 ee  	ld	a2, -280(s0)

000000008020169e <.Lpcrel_hi2>:
;     print!("[INFO]:");
8020169e: 17 25 00 00  	auipc	a0, 2
802016a2: 93 05 25 e8  	addi	a1, a0, -382
802016a6: 13 05 84 f2  	addi	a0, s0, -216
802016aa: 23 38 a4 ec  	sd	a0, -304(s0)
802016ae: 97 f0 ff ff  	auipc	ra, 1048575
802016b2: e7 80 e0 4d  	jalr	1246(ra)
802016b6: 03 35 04 ed  	ld	a0, -304(s0)
802016ba: 97 00 00 00  	auipc	ra, 0
802016be: e7 80 60 f5  	jalr	-170(ra)
802016c2: 03 35 84 ed  	ld	a0, -296(s0)
;     Ptcr.write_fmt(args).unwrap();
802016c6: 0c 75        	ld	a1, 40(a0)
802016c8: 23 34 b4 fe  	sd	a1, -24(s0)
802016cc: 0c 71        	ld	a1, 32(a0)
802016ce: 23 30 b4 fe  	sd	a1, -32(s0)
802016d2: 0c 6d        	ld	a1, 24(a0)
802016d4: 23 3c b4 fc  	sd	a1, -40(s0)
802016d8: 0c 69        	ld	a1, 16(a0)
802016da: 23 38 b4 fc  	sd	a1, -48(s0)
802016de: 0c 65        	ld	a1, 8(a0)
802016e0: 23 34 b4 fc  	sd	a1, -56(s0)
802016e4: 08 61        	ld	a0, 0(a0)
802016e6: 23 30 a4 fc  	sd	a0, -64(s0)
802016ea: 13 05 84 f5  	addi	a0, s0, -168
802016ee: 93 05 04 fc  	addi	a1, s0, -64
802016f2: 97 f0 ff ff  	auipc	ra, 1048575
802016f6: e7 80 e0 ec  	jalr	-306(ra)

00000000802016fa <.Lpcrel_hi3>:
802016fa: 97 25 00 00  	auipc	a1, 2
802016fe: 93 85 65 e3  	addi	a1, a1, -458
80201702: 97 f0 ff ff  	auipc	ra, 1048575
80201706: e7 80 e0 b2  	jalr	-1234(ra)
8020170a: 03 36 84 ee  	ld	a2, -280(s0)

000000008020170e <.Lpcrel_hi4>:
;     print!("\x1b[0m");
8020170e: 17 25 00 00  	auipc	a0, 2
80201712: 93 05 25 e4  	addi	a1, a0, -446
80201716: 13 05 04 f6  	addi	a0, s0, -160
8020171a: 23 30 a4 ee  	sd	a0, -288(s0)
8020171e: 97 f0 ff ff  	auipc	ra, 1048575
80201722: e7 80 e0 46  	jalr	1134(ra)
80201726: 03 35 04 ee  	ld	a0, -288(s0)
8020172a: 97 00 00 00  	auipc	ra, 0
8020172e: e7 80 60 ee  	jalr	-282(ra)
80201732: 03 36 84 ee  	ld	a2, -280(s0)

0000000080201736 <.Lpcrel_hi5>:
;     print!("\n")
80201736: 17 25 00 00  	auipc	a0, 2
8020173a: 93 05 25 e3  	addi	a1, a0, -462
8020173e: 13 05 04 f9  	addi	a0, s0, -112
80201742: 23 38 a4 ee  	sd	a0, -272(s0)
80201746: 97 f0 ff ff  	auipc	ra, 1048575
8020174a: e7 80 60 44  	jalr	1094(ra)
8020174e: 03 35 04 ef  	ld	a0, -272(s0)
80201752: 97 00 00 00  	auipc	ra, 0
80201756: e7 80 e0 eb  	jalr	-322(ra)
; }
8020175a: f2 70        	ld	ra, 312(sp)
8020175c: 52 74        	ld	s0, 304(sp)
8020175e: 31 61        	addi	sp, sp, 320
80201760: 82 80        	ret

0000000080201762 <_ZN2os7console5debug17hc0992cf4d3b3567eE>:
; pub fn debug(args:fmt::Arguments){
80201762: 29 71        	addi	sp, sp, -320
80201764: 06 fe        	sd	ra, 312(sp)
80201766: 22 fa        	sd	s0, 304(sp)
80201768: 80 02        	addi	s0, sp, 320
8020176a: 23 3c a4 ec  	sd	a0, -296(s0)

000000008020176e <.Lpcrel_hi6>:
;     print!("\x1b[32m");
8020176e: 17 25 00 00  	auipc	a0, 2
80201772: 93 05 25 e1  	addi	a1, a0, -494
80201776: 13 05 84 ef  	addi	a0, s0, -264
8020177a: 23 34 a4 ec  	sd	a0, -312(s0)
8020177e: 05 46        	li	a2, 1
80201780: 23 34 c4 ee  	sd	a2, -280(s0)
80201784: 97 f0 ff ff  	auipc	ra, 1048575
80201788: e7 80 80 40  	jalr	1032(ra)
8020178c: 03 35 84 ec  	ld	a0, -312(s0)
80201790: 97 00 00 00  	auipc	ra, 0
80201794: e7 80 00 e8  	jalr	-384(ra)
80201798: 03 36 84 ee  	ld	a2, -280(s0)

000000008020179c <.Lpcrel_hi7>:
;     print!("[DEBUG]:");
8020179c: 17 25 00 00  	auipc	a0, 2
802017a0: 93 05 45 df  	addi	a1, a0, -524
802017a4: 13 05 84 f2  	addi	a0, s0, -216
802017a8: 23 38 a4 ec  	sd	a0, -304(s0)
802017ac: 97 f0 ff ff  	auipc	ra, 1048575
802017b0: e7 80 00 3e  	jalr	992(ra)
802017b4: 03 35 04 ed  	ld	a0, -304(s0)
802017b8: 97 00 00 00  	auipc	ra, 0
802017bc: e7 80 80 e5  	jalr	-424(ra)
802017c0: 03 35 84 ed  	ld	a0, -296(s0)
;     Ptcr.write_fmt(args).unwrap();
802017c4: 0c 75        	ld	a1, 40(a0)
802017c6: 23 34 b4 fe  	sd	a1, -24(s0)
802017ca: 0c 71        	ld	a1, 32(a0)
802017cc: 23 30 b4 fe  	sd	a1, -32(s0)
802017d0: 0c 6d        	ld	a1, 24(a0)
802017d2: 23 3c b4 fc  	sd	a1, -40(s0)
802017d6: 0c 69        	ld	a1, 16(a0)
802017d8: 23 38 b4 fc  	sd	a1, -48(s0)
802017dc: 0c 65        	ld	a1, 8(a0)
802017de: 23 34 b4 fc  	sd	a1, -56(s0)
802017e2: 08 61        	ld	a0, 0(a0)
802017e4: 23 30 a4 fc  	sd	a0, -64(s0)
802017e8: 13 05 84 f5  	addi	a0, s0, -168
802017ec: 93 05 04 fc  	addi	a1, s0, -64
802017f0: 97 f0 ff ff  	auipc	ra, 1048575
802017f4: e7 80 00 dd  	jalr	-560(ra)

00000000802017f8 <.Lpcrel_hi8>:
802017f8: 97 25 00 00  	auipc	a1, 2
802017fc: 93 85 85 da  	addi	a1, a1, -600
80201800: 97 f0 ff ff  	auipc	ra, 1048575
80201804: e7 80 00 a3  	jalr	-1488(ra)
80201808: 03 36 84 ee  	ld	a2, -280(s0)

000000008020180c <.Lpcrel_hi9>:
;     print!("\x1b[0m");
8020180c: 17 25 00 00  	auipc	a0, 2
80201810: 93 05 45 d4  	addi	a1, a0, -700
80201814: 13 05 04 f6  	addi	a0, s0, -160
80201818: 23 30 a4 ee  	sd	a0, -288(s0)
8020181c: 97 f0 ff ff  	auipc	ra, 1048575
80201820: e7 80 00 37  	jalr	880(ra)
80201824: 03 35 04 ee  	ld	a0, -288(s0)
80201828: 97 00 00 00  	auipc	ra, 0
8020182c: e7 80 80 de  	jalr	-536(ra)
80201830: 03 36 84 ee  	ld	a2, -280(s0)

0000000080201834 <.Lpcrel_hi10>:
;     print!("\n")
80201834: 17 25 00 00  	auipc	a0, 2
80201838: 93 05 45 d3  	addi	a1, a0, -716
8020183c: 13 05 04 f9  	addi	a0, s0, -112
80201840: 23 38 a4 ee  	sd	a0, -272(s0)
80201844: 97 f0 ff ff  	auipc	ra, 1048575
80201848: e7 80 80 34  	jalr	840(ra)
8020184c: 03 35 04 ef  	ld	a0, -272(s0)
80201850: 97 00 00 00  	auipc	ra, 0
80201854: e7 80 00 dc  	jalr	-576(ra)
; }
80201858: f2 70        	ld	ra, 312(sp)
8020185a: 52 74        	ld	s0, 304(sp)
8020185c: 31 61        	addi	sp, sp, 320
8020185e: 82 80        	ret

0000000080201860 <_ZN2os7console5error17h3fa3ced0021e61feE>:
; pub fn error(args:fmt::Arguments){
80201860: 29 71        	addi	sp, sp, -320
80201862: 06 fe        	sd	ra, 312(sp)
80201864: 22 fa        	sd	s0, 304(sp)
80201866: 80 02        	addi	s0, sp, 320
80201868: 23 3c a4 ec  	sd	a0, -296(s0)

000000008020186c <.Lpcrel_hi11>:
;     print!("\x1b[31m");
8020186c: 17 25 00 00  	auipc	a0, 2
80201870: 93 05 45 d5  	addi	a1, a0, -684
80201874: 13 05 84 ef  	addi	a0, s0, -264
80201878: 23 34 a4 ec  	sd	a0, -312(s0)
8020187c: 05 46        	li	a2, 1
8020187e: 23 34 c4 ee  	sd	a2, -280(s0)
80201882: 97 f0 ff ff  	auipc	ra, 1048575
80201886: e7 80 a0 30  	jalr	778(ra)
8020188a: 03 35 84 ec  	ld	a0, -312(s0)
8020188e: 97 00 00 00  	auipc	ra, 0
80201892: e7 80 20 d8  	jalr	-638(ra)
80201896: 03 36 84 ee  	ld	a2, -280(s0)

000000008020189a <.Lpcrel_hi12>:
;     print!("[ERROR]:");
8020189a: 17 25 00 00  	auipc	a0, 2
8020189e: 93 05 65 d3  	addi	a1, a0, -714
802018a2: 13 05 84 f2  	addi	a0, s0, -216
802018a6: 23 38 a4 ec  	sd	a0, -304(s0)
802018aa: 97 f0 ff ff  	auipc	ra, 1048575
802018ae: e7 80 20 2e  	jalr	738(ra)
802018b2: 03 35 04 ed  	ld	a0, -304(s0)
802018b6: 97 00 00 00  	auipc	ra, 0
802018ba: e7 80 a0 d5  	jalr	-678(ra)
802018be: 03 35 84 ed  	ld	a0, -296(s0)
;     Ptcr.write_fmt(args).unwrap();
802018c2: 0c 75        	ld	a1, 40(a0)
802018c4: 23 34 b4 fe  	sd	a1, -24(s0)
802018c8: 0c 71        	ld	a1, 32(a0)
802018ca: 23 30 b4 fe  	sd	a1, -32(s0)
802018ce: 0c 6d        	ld	a1, 24(a0)
802018d0: 23 3c b4 fc  	sd	a1, -40(s0)
802018d4: 0c 69        	ld	a1, 16(a0)
802018d6: 23 38 b4 fc  	sd	a1, -48(s0)
802018da: 0c 65        	ld	a1, 8(a0)
802018dc: 23 34 b4 fc  	sd	a1, -56(s0)
802018e0: 08 61        	ld	a0, 0(a0)
802018e2: 23 30 a4 fc  	sd	a0, -64(s0)
802018e6: 13 05 84 f5  	addi	a0, s0, -168
802018ea: 93 05 04 fc  	addi	a1, s0, -64
802018ee: 97 f0 ff ff  	auipc	ra, 1048575
802018f2: e7 80 20 cd  	jalr	-814(ra)

00000000802018f6 <.Lpcrel_hi13>:
802018f6: 97 25 00 00  	auipc	a1, 2
802018fa: 93 85 a5 ce  	addi	a1, a1, -790
802018fe: 97 f0 ff ff  	auipc	ra, 1048575
80201902: e7 80 20 93  	jalr	-1742(ra)
80201906: 03 36 84 ee  	ld	a2, -280(s0)

000000008020190a <.Lpcrel_hi14>:
;     print!("\x1b[0m");
8020190a: 17 25 00 00  	auipc	a0, 2
8020190e: 93 05 65 c4  	addi	a1, a0, -954
80201912: 13 05 04 f6  	addi	a0, s0, -160
80201916: 23 30 a4 ee  	sd	a0, -288(s0)
8020191a: 97 f0 ff ff  	auipc	ra, 1048575
8020191e: e7 80 20 27  	jalr	626(ra)
80201922: 03 35 04 ee  	ld	a0, -288(s0)
80201926: 97 00 00 00  	auipc	ra, 0
8020192a: e7 80 a0 ce  	jalr	-790(ra)
8020192e: 03 36 84 ee  	ld	a2, -280(s0)

0000000080201932 <.Lpcrel_hi15>:
;     print!("\n")
80201932: 17 25 00 00  	auipc	a0, 2
80201936: 93 05 65 c3  	addi	a1, a0, -970
8020193a: 13 05 04 f9  	addi	a0, s0, -112
8020193e: 23 38 a4 ee  	sd	a0, -272(s0)
80201942: 97 f0 ff ff  	auipc	ra, 1048575
80201946: e7 80 a0 24  	jalr	586(ra)
8020194a: 03 35 04 ef  	ld	a0, -272(s0)
8020194e: 97 00 00 00  	auipc	ra, 0
80201952: e7 80 20 cc  	jalr	-830(ra)
; }
80201956: f2 70        	ld	ra, 312(sp)
80201958: 52 74        	ld	s0, 304(sp)
8020195a: 31 61        	addi	sp, sp, 320
8020195c: 82 80        	ret

000000008020195e <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h74155cf4bec81cd5E>:
;     fn index_mut(self, slice: &mut [T]) -> &mut [T] {
8020195e: 55 71        	addi	sp, sp, -208
80201960: 86 e5        	sd	ra, 200(sp)
80201962: a2 e1        	sd	s0, 192(sp)
80201964: 80 09        	addi	s0, sp, 208
80201966: 23 38 e4 f2  	sd	a4, -208(s0)
8020196a: 23 3c d4 f2  	sd	a3, -200(s0)
8020196e: 23 30 c4 f4  	sd	a2, -192(s0)
80201972: 23 34 b4 f4  	sd	a1, -184(s0)
80201976: 23 38 a4 f4  	sd	a0, -176(s0)
8020197a: 23 3c a4 f6  	sd	a0, -136(s0)
8020197e: 23 30 b4 f8  	sd	a1, -128(s0)
80201982: 23 34 c4 f8  	sd	a2, -120(s0)
80201986: 23 38 d4 f8  	sd	a3, -112(s0)
;         if self.start > self.end {
8020198a: 63 ea a5 00  	bltu	a1, a0, 0x8020199e <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h74155cf4bec81cd5E+0x40>
8020198e: 09 a0        	j	0x80201990 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h74155cf4bec81cd5E+0x32>
;         } else if self.end > slice.len() {
80201990: 03 35 84 f3  	ld	a0, -200(s0)
80201994: 83 35 84 f4  	ld	a1, -184(s0)
80201998: 63 66 b5 08  	bltu	a0, a1, 0x80201a24 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h74155cf4bec81cd5E+0xc6>
8020199c: 21 a8        	j	0x802019b4 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h74155cf4bec81cd5E+0x56>
;             slice_index_order_fail(self.start, self.end);
8020199e: 03 36 04 f3  	ld	a2, -208(s0)
802019a2: 83 35 84 f4  	ld	a1, -184(s0)
802019a6: 03 35 04 f5  	ld	a0, -176(s0)
802019aa: 97 10 00 00  	auipc	ra, 1
802019ae: e7 80 e0 d9  	jalr	-610(ra)
802019b2: 00 00        	unimp	
;         unsafe { &mut *self.get_unchecked_mut(slice) }
802019b4: 83 35 04 f4  	ld	a1, -192(s0)
802019b8: 03 36 04 f5  	ld	a2, -176(s0)
802019bc: 03 35 84 f4  	ld	a0, -184(s0)
802019c0: 83 36 84 f3  	ld	a3, -200(s0)
802019c4: 23 3c b4 f8  	sd	a1, -104(s0)
802019c8: 23 30 d4 fa  	sd	a3, -96(s0)
;             let new_len = unchecked_sub(self.end, self.start);
802019cc: 11 8d        	sub	a0, a0, a2
802019ce: 23 34 a4 fa  	sd	a0, -88(s0)
802019d2: 03 35 84 fa  	ld	a0, -88(s0)
802019d6: 23 38 a4 fa  	sd	a0, -80(s0)
;         self as *mut T
802019da: 23 3c b4 fa  	sd	a1, -72(s0)
;             ptr::slice_from_raw_parts_mut(slice.as_mut_ptr().add(self.start), new_len)
802019de: 23 30 c4 fc  	sd	a2, -64(s0)
;         unsafe { self.offset(count as isize) }
802019e2: 23 34 c4 fc  	sd	a2, -56(s0)
;         unsafe { intrinsics::offset(self, count) as *mut T }
802019e6: b2 95        	add	a1, a1, a2
802019e8: 23 38 b4 fc  	sd	a1, -48(s0)
802019ec: 83 35 04 fd  	ld	a1, -48(s0)
802019f0: 23 3c b4 fc  	sd	a1, -40(s0)
;             ptr::slice_from_raw_parts_mut(slice.as_mut_ptr().add(self.start), new_len)
802019f4: 23 30 a4 fe  	sd	a0, -32(s0)
;         self as _
802019f8: 23 34 b4 fe  	sd	a1, -24(s0)
;     unsafe { PtrRepr { components: PtrComponents { data_address, metadata } }.mut_ptr }
802019fc: 23 34 b4 f6  	sd	a1, -152(s0)
80201a00: 23 38 a4 f6  	sd	a0, -144(s0)
80201a04: 83 35 84 f6  	ld	a1, -152(s0)
80201a08: 03 35 04 f7  	ld	a0, -144(s0)
80201a0c: 23 3c b4 f4  	sd	a1, -168(s0)
80201a10: 23 30 a4 f6  	sd	a0, -160(s0)
80201a14: 03 35 84 f5  	ld	a0, -168(s0)
80201a18: 83 35 04 f6  	ld	a1, -160(s0)
;     }
80201a1c: ae 60        	ld	ra, 200(sp)
80201a1e: 0e 64        	ld	s0, 192(sp)
80201a20: 69 61        	addi	sp, sp, 208
80201a22: 82 80        	ret
;             slice_end_index_len_fail(self.end, slice.len());
80201a24: 03 36 04 f3  	ld	a2, -208(s0)
80201a28: 83 35 84 f3  	ld	a1, -200(s0)
80201a2c: 03 35 84 f4  	ld	a0, -184(s0)
80201a30: 97 10 00 00  	auipc	ra, 1
80201a34: e7 80 00 cd  	jalr	-816(ra)
80201a38: 00 00        	unimp	

0000000080201a3a <_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h42054084e601f3a7E>:
;     fn next(&mut self) -> Option<A> {
80201a3a: 01 11        	addi	sp, sp, -32
80201a3c: 06 ec        	sd	ra, 24(sp)
80201a3e: 22 e8        	sd	s0, 16(sp)
80201a40: 00 10        	addi	s0, sp, 32
80201a42: 23 34 a4 fe  	sd	a0, -24(s0)
;         self.spec_next()
80201a46: 97 00 00 00  	auipc	ra, 0
80201a4a: e7 80 40 08  	jalr	132(ra)
;     }
80201a4e: e2 60        	ld	ra, 24(sp)
80201a50: 42 64        	ld	s0, 16(sp)
80201a52: 05 61        	addi	sp, sp, 32
80201a54: 82 80        	ret

0000000080201a56 <_ZN4core4iter6traits8iterator8Iterator4fold17hb47752ca847d2654E>:
;     fn fold<B, F>(mut self, init: B, mut f: F) -> B
80201a56: 1d 71        	addi	sp, sp, -96
80201a58: 86 ec        	sd	ra, 88(sp)
80201a5a: a2 e8        	sd	s0, 80(sp)
80201a5c: 80 10        	addi	s0, sp, 96
80201a5e: 23 34 a4 fa  	sd	a0, -88(s0)
80201a62: 23 38 b4 fa  	sd	a1, -80(s0)
;         while let Some(x) = self.next() {
80201a66: 09 a0        	j	0x80201a68 <_ZN4core4iter6traits8iterator8Iterator4fold17hb47752ca847d2654E+0x12>
80201a68: 13 05 84 fa  	addi	a0, s0, -88
;         while let Some(x) = self.next() {
80201a6c: 97 00 00 00  	auipc	ra, 0
80201a70: e7 80 e0 fc  	jalr	-50(ra)
80201a74: 23 34 b4 fc  	sd	a1, -56(s0)
80201a78: 23 30 a4 fc  	sd	a0, -64(s0)
80201a7c: 03 35 04 fc  	ld	a0, -64(s0)
80201a80: 0d c1        	beqz	a0, 0x80201aa2 <_ZN4core4iter6traits8iterator8Iterator4fold17hb47752ca847d2654E+0x4c>
80201a82: 09 a0        	j	0x80201a84 <_ZN4core4iter6traits8iterator8Iterator4fold17hb47752ca847d2654E+0x2e>
80201a84: 03 35 84 fc  	ld	a0, -56(s0)
80201a88: 23 34 a4 fe  	sd	a0, -24(s0)
;             accum = f(accum, x);
80201a8c: 23 38 a4 fc  	sd	a0, -48(s0)
80201a90: 83 35 04 fd  	ld	a1, -48(s0)
80201a94: 13 05 84 fb  	addi	a0, s0, -72
80201a98: 97 00 00 00  	auipc	ra, 0
80201a9c: e7 80 a0 ac  	jalr	-1334(ra)
;         while let Some(x) = self.next() {
80201aa0: e1 b7        	j	0x80201a68 <_ZN4core4iter6traits8iterator8Iterator4fold17hb47752ca847d2654E+0x12>
;     }
80201aa2: e6 60        	ld	ra, 88(sp)
80201aa4: 46 64        	ld	s0, 80(sp)
80201aa6: 25 61        	addi	sp, sp, 96
80201aa8: 82 80        	ret

0000000080201aaa <_ZN4core4iter6traits8iterator8Iterator8for_each17ha8d14448ed70c09fE>:
;     fn for_each<F>(self, f: F)
80201aaa: 79 71        	addi	sp, sp, -48
80201aac: 06 f4        	sd	ra, 40(sp)
80201aae: 22 f0        	sd	s0, 32(sp)
80201ab0: 00 18        	addi	s0, sp, 48
80201ab2: 23 3c a4 fc  	sd	a0, -40(s0)
80201ab6: 23 30 b4 fe  	sd	a1, -32(s0)
;         self.fold((), call(f));
80201aba: 97 00 00 00  	auipc	ra, 0
80201abe: e7 80 c0 f9  	jalr	-100(ra)
;     }
80201ac2: a2 70        	ld	ra, 40(sp)
80201ac4: 02 74        	ld	s0, 32(sp)
80201ac6: 45 61        	addi	sp, sp, 48
80201ac8: 82 80        	ret

0000000080201aca <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h9c244b12888f9910E>:
;     fn spec_next(&mut self) -> Option<T> {
80201aca: 19 71        	addi	sp, sp, -128
80201acc: 86 fc        	sd	ra, 120(sp)
80201ace: a2 f8        	sd	s0, 112(sp)
80201ad0: 00 01        	addi	s0, sp, 128
80201ad2: 23 38 a4 f8  	sd	a0, -112(s0)
80201ad6: 23 38 a4 fa  	sd	a0, -80(s0)
;         if self.start < self.end {
80201ada: 93 05 85 00  	addi	a1, a0, 8
80201ade: 97 00 00 00  	auipc	ra, 0
80201ae2: e7 80 c0 0a  	jalr	172(ra)
80201ae6: 11 e5        	bnez	a0, 0x80201af2 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h9c244b12888f9910E+0x28>
80201ae8: 09 a0        	j	0x80201aea <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h9c244b12888f9910E+0x20>
80201aea: 01 45        	li	a0, 0
;             None
80201aec: 23 3c a4 f8  	sd	a0, -104(s0)
;         if self.start < self.end {
80201af0: 89 a8        	j	0x80201b42 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h9c244b12888f9910E+0x78>
80201af2: 03 35 04 f9  	ld	a0, -112(s0)
80201af6: 23 34 a4 fe  	sd	a0, -24(s0)
;                         *self
80201afa: 08 61        	ld	a0, 0(a0)
80201afc: 85 45        	li	a1, 1
;             let n = unsafe { Step::forward_unchecked(self.start.clone(), 1) };
80201afe: 23 34 b4 f8  	sd	a1, -120(s0)
80201b02: 97 e0 ff ff  	auipc	ra, 1048574
80201b06: e7 80 60 77  	jalr	1910(ra)
80201b0a: 83 36 04 f9  	ld	a3, -112(s0)
80201b0e: 2a 86        	mv	a2, a0
80201b10: 03 35 84 f8  	ld	a0, -120(s0)
80201b14: 23 3c c4 fa  	sd	a2, -72(s0)
;             Some(mem::replace(&mut self.start, n))
80201b18: 23 30 d4 fc  	sd	a3, -64(s0)
80201b1c: 23 34 c4 fc  	sd	a2, -56(s0)
;         let result = ptr::read(dest);
80201b20: 23 38 d4 fc  	sd	a3, -48(s0)
;             crate::intrinsics::read_via_copy(src)
80201b24: 8c 62        	ld	a1, 0(a3)
80201b26: 23 3c b4 fc  	sd	a1, -40(s0)
;         ptr::write(dest, src);
80201b2a: 23 30 d4 fe  	sd	a3, -32(s0)
80201b2e: 23 34 c4 fa  	sd	a2, -88(s0)
;         copy_nonoverlapping(&src as *const T, dst, 1);
80201b32: 03 36 84 fa  	ld	a2, -88(s0)
80201b36: 90 e2        	sd	a2, 0(a3)
;             Some(mem::replace(&mut self.start, n))
80201b38: 23 30 b4 fa  	sd	a1, -96(s0)
80201b3c: 23 3c a4 f8  	sd	a0, -104(s0)
;         if self.start < self.end {
80201b40: 09 a0        	j	0x80201b42 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h9c244b12888f9910E+0x78>
;     }
80201b42: 03 35 84 f9  	ld	a0, -104(s0)
80201b46: 83 35 04 fa  	ld	a1, -96(s0)
80201b4a: e6 70        	ld	ra, 120(sp)
80201b4c: 46 74        	ld	s0, 112(sp)
80201b4e: 09 61        	addi	sp, sp, 128
80201b50: 82 80        	ret

0000000080201b52 <_ZN4core3str21_$LT$impl$u20$str$GT$5chars17hf4b09867dd1ced63E>:
;     pub fn chars(&self) -> Chars<'_> {
80201b52: 39 71        	addi	sp, sp, -64
80201b54: 06 fc        	sd	ra, 56(sp)
80201b56: 22 f8        	sd	s0, 48(sp)
80201b58: 80 00        	addi	s0, sp, 64
80201b5a: 23 38 a4 fc  	sd	a0, -48(s0)
80201b5e: 23 3c b4 fc  	sd	a1, -40(s0)
;         unsafe { mem::transmute(self) }
80201b62: 23 30 a4 fe  	sd	a0, -32(s0)
80201b66: 23 34 b4 fe  	sd	a1, -24(s0)
;         Iter::new(self)
80201b6a: 97 e0 ff ff  	auipc	ra, 1048574
80201b6e: e7 80 00 76  	jalr	1888(ra)
;         Chars { iter: self.as_bytes().iter() }
80201b72: 23 30 a4 fc  	sd	a0, -64(s0)
80201b76: 23 34 b4 fc  	sd	a1, -56(s0)
;     }
80201b7a: 03 35 04 fc  	ld	a0, -64(s0)
80201b7e: 83 35 84 fc  	ld	a1, -56(s0)
80201b82: e2 70        	ld	ra, 56(sp)
80201b84: 42 74        	ld	s0, 48(sp)
80201b86: 21 61        	addi	sp, sp, 64
80201b88: 82 80        	ret

0000000080201b8a <_ZN4core3cmp5impls57_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$usize$GT$2lt17hfbd1fb24efe8ae12E>:
;                 fn lt(&self, other: &$t) -> bool { (*self) < (*other) }
80201b8a: 01 11        	addi	sp, sp, -32
80201b8c: 06 ec        	sd	ra, 24(sp)
80201b8e: 22 e8        	sd	s0, 16(sp)
80201b90: 00 10        	addi	s0, sp, 32
80201b92: 23 30 a4 fe  	sd	a0, -32(s0)
80201b96: 23 34 b4 fe  	sd	a1, -24(s0)
80201b9a: 08 61        	ld	a0, 0(a0)
80201b9c: 8c 61        	ld	a1, 0(a1)
80201b9e: 33 35 b5 00  	sltu	a0, a0, a1
80201ba2: e2 60        	ld	ra, 24(sp)
80201ba4: 42 64        	ld	s0, 16(sp)
80201ba6: 05 61        	addi	sp, sp, 32
80201ba8: 82 80        	ret

0000000080201baa <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hcc6193282a2aa8a2E>:
;     fn next(&mut self) -> Option<char> {
80201baa: 01 11        	addi	sp, sp, -32
80201bac: 06 ec        	sd	ra, 24(sp)
80201bae: 22 e8        	sd	s0, 16(sp)
80201bb0: 00 10        	addi	s0, sp, 32
80201bb2: 23 34 a4 fe  	sd	a0, -24(s0)
;         unsafe { next_code_point(&mut self.iter).map(|ch| char::from_u32_unchecked(ch)) }
80201bb6: 97 f0 ff ff  	auipc	ra, 1048575
80201bba: e7 80 00 06  	jalr	96(ra)
80201bbe: 97 e0 ff ff  	auipc	ra, 1048574
80201bc2: e7 80 a0 5c  	jalr	1482(ra)
80201bc6: 02 15        	slli	a0, a0, 32
80201bc8: 01 91        	srli	a0, a0, 32
;     }
80201bca: e2 60        	ld	ra, 24(sp)
80201bcc: 42 64        	ld	s0, 16(sp)
80201bce: 05 61        	addi	sp, sp, 32
80201bd0: 82 80        	ret

0000000080201bd2 <_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17hcd017e56943388c4E>:
; pub unsafe fn drop_in_place<T: ?Sized>(to_drop: *mut T) {
80201bd2: 01 11        	addi	sp, sp, -32
80201bd4: 06 ec        	sd	ra, 24(sp)
80201bd6: 22 e8        	sd	s0, 16(sp)
80201bd8: 00 10        	addi	s0, sp, 32
80201bda: 23 34 a4 fe  	sd	a0, -24(s0)
80201bde: e2 60        	ld	ra, 24(sp)
80201be0: 42 64        	ld	s0, 16(sp)
80201be2: 05 61        	addi	sp, sp, 32
80201be4: 82 80        	ret

0000000080201be6 <_ZN4core3ptr50drop_in_place$LT$$RF$mut$u20$os..console..Ptcr$GT$17h6e8bb85a9639f732E>:
80201be6: 01 11        	addi	sp, sp, -32
80201be8: 06 ec        	sd	ra, 24(sp)
80201bea: 22 e8        	sd	s0, 16(sp)
80201bec: 00 10        	addi	s0, sp, 32
80201bee: 23 34 a4 fe  	sd	a0, -24(s0)
80201bf2: e2 60        	ld	ra, 24(sp)
80201bf4: 42 64        	ld	s0, 16(sp)
80201bf6: 05 61        	addi	sp, sp, 32
80201bf8: 82 80        	ret

0000000080201bfa <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h327b89b3d7bce01aE>:
80201bfa: 75 71        	addi	sp, sp, -144
80201bfc: 06 e5        	sd	ra, 136(sp)
80201bfe: 2e 88        	mv	a6, a1
80201c00: 81 47        	li	a5, 0
80201c02: 14 41        	lw	a3, 0(a0)
80201c04: 30 01        	addi	a2, sp, 136
80201c06: a9 48        	li	a7, 10
80201c08: bd 42        	li	t0, 15
80201c0a: 21 a8        	j	0x80201c22 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h327b89b3d7bce01aE+0x28>
80201c0c: 13 07 f6 ff  	addi	a4, a2, -1
80201c10: 9b 56 45 00  	srliw	a3, a0, 4
80201c14: 9a 95        	add	a1, a1, t1
80201c16: a3 0f b6 fe  	sb	a1, -1(a2)
80201c1a: 85 07        	addi	a5, a5, 1
80201c1c: 3a 86        	mv	a2, a4
80201c1e: 63 fc a2 00  	bgeu	t0, a0, 0x80201c36 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h327b89b3d7bce01aE+0x3c>
80201c22: 36 85        	mv	a0, a3
80201c24: 93 f5 f6 00  	andi	a1, a3, 15
80201c28: 13 03 00 03  	li	t1, 48
80201c2c: e3 e0 15 ff  	bltu	a1, a7, 0x80201c0c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h327b89b3d7bce01aE+0x12>
80201c30: 13 03 70 03  	li	t1, 55
80201c34: e1 bf        	j	0x80201c0c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h327b89b3d7bce01aE+0x12>
80201c36: 13 05 00 08  	li	a0, 128
80201c3a: 1d 8d        	sub	a0, a0, a5
80201c3c: 93 05 10 08  	li	a1, 129
80201c40: 63 70 b5 02  	bgeu	a0, a1, 0x80201c60 <.Lpcrel_hi58>

0000000080201c44 <.Lpcrel_hi59>:
80201c44: 17 25 00 00  	auipc	a0, 2
80201c48: 13 06 c5 a3  	addi	a2, a0, -1476
80201c4c: 85 45        	li	a1, 1
80201c4e: 89 46        	li	a3, 2
80201c50: 42 85        	mv	a0, a6
80201c52: 97 00 00 00  	auipc	ra, 0
80201c56: e7 80 40 23  	jalr	564(ra)
80201c5a: aa 60        	ld	ra, 136(sp)
80201c5c: 49 61        	addi	sp, sp, 144
80201c5e: 82 80        	ret

0000000080201c60 <.Lpcrel_hi58>:
80201c60: 97 25 00 00  	auipc	a1, 2
80201c64: 13 86 85 a0  	addi	a2, a1, -1528
80201c68: 93 05 00 08  	li	a1, 128
80201c6c: 97 10 00 00  	auipc	ra, 1
80201c70: e7 80 c0 a4  	jalr	-1460(ra)
80201c74: 00 00        	unimp	

0000000080201c76 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h185c89c2eb528209E>:
80201c76: 75 71        	addi	sp, sp, -144
80201c78: 06 e5        	sd	ra, 136(sp)
80201c7a: 2e 88        	mv	a6, a1
80201c7c: 81 47        	li	a5, 0
80201c7e: 14 61        	ld	a3, 0(a0)
80201c80: 30 01        	addi	a2, sp, 136
80201c82: a9 48        	li	a7, 10
80201c84: bd 42        	li	t0, 15
80201c86: 21 a8        	j	0x80201c9e <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h185c89c2eb528209E+0x28>
80201c88: 13 07 f6 ff  	addi	a4, a2, -1
80201c8c: 93 56 45 00  	srli	a3, a0, 4
80201c90: 9a 95        	add	a1, a1, t1
80201c92: a3 0f b6 fe  	sb	a1, -1(a2)
80201c96: 85 07        	addi	a5, a5, 1
80201c98: 3a 86        	mv	a2, a4
80201c9a: 63 fc a2 00  	bgeu	t0, a0, 0x80201cb2 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h185c89c2eb528209E+0x3c>
80201c9e: 36 85        	mv	a0, a3
80201ca0: 93 f5 f6 00  	andi	a1, a3, 15
80201ca4: 13 03 00 03  	li	t1, 48
80201ca8: e3 e0 15 ff  	bltu	a1, a7, 0x80201c88 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h185c89c2eb528209E+0x12>
80201cac: 13 03 70 05  	li	t1, 87
80201cb0: e1 bf        	j	0x80201c88 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h185c89c2eb528209E+0x12>
80201cb2: 13 05 00 08  	li	a0, 128
80201cb6: 1d 8d        	sub	a0, a0, a5
80201cb8: 93 05 10 08  	li	a1, 129
80201cbc: 63 70 b5 02  	bgeu	a0, a1, 0x80201cdc <.Lpcrel_hi64>

0000000080201cc0 <.Lpcrel_hi65>:
80201cc0: 17 25 00 00  	auipc	a0, 2
80201cc4: 13 06 05 9c  	addi	a2, a0, -1600
80201cc8: 85 45        	li	a1, 1
80201cca: 89 46        	li	a3, 2
80201ccc: 42 85        	mv	a0, a6
80201cce: 97 00 00 00  	auipc	ra, 0
80201cd2: e7 80 80 1b  	jalr	440(ra)
80201cd6: aa 60        	ld	ra, 136(sp)
80201cd8: 49 61        	addi	sp, sp, 144
80201cda: 82 80        	ret

0000000080201cdc <.Lpcrel_hi64>:
80201cdc: 97 25 00 00  	auipc	a1, 2
80201ce0: 13 86 c5 98  	addi	a2, a1, -1652
80201ce4: 93 05 00 08  	li	a1, 128
80201ce8: 97 10 00 00  	auipc	ra, 1
80201cec: e7 80 00 9d  	jalr	-1584(ra)
80201cf0: 00 00        	unimp	

0000000080201cf2 <_ZN4core3ops8function6FnOnce9call_once17hbb48a84af851a07fE.llvm.7536791019867514407>:
80201cf2: 08 61        	ld	a0, 0(a0)
80201cf4: 01 a0        	j	0x80201cf4 <_ZN4core3ops8function6FnOnce9call_once17hbb48a84af851a07fE.llvm.7536791019867514407+0x2>

0000000080201cf6 <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h100b3d938d3ebba8E>:
80201cf6: 90 61        	ld	a2, 0(a1)
80201cf8: 8c 65        	ld	a1, 8(a1)
80201cfa: aa 86        	mv	a3, a0
80201cfc: 32 85        	mv	a0, a2
80201cfe: 36 86        	mv	a2, a3
80201d00: 17 03 00 00  	auipc	t1, 0
80201d04: 67 00 83 00  	jr	8(t1)

0000000080201d08 <_ZN4core3fmt5write17h3da4952df2f9c5bdE>:
80201d08: 19 71        	addi	sp, sp, -128
80201d0a: 86 fc        	sd	ra, 120(sp)
80201d0c: a2 f8        	sd	s0, 112(sp)
80201d0e: a6 f4        	sd	s1, 104(sp)
80201d10: ca f0        	sd	s2, 96(sp)
80201d12: ce ec        	sd	s3, 88(sp)
80201d14: d2 e8        	sd	s4, 80(sp)
80201d16: d6 e4        	sd	s5, 72(sp)
80201d18: da e0        	sd	s6, 64(sp)
80201d1a: b2 89        	mv	s3, a2
80201d1c: 05 46        	li	a2, 1
80201d1e: 16 16        	slli	a2, a2, 37
80201d20: 32 f8        	sd	a2, 48(sp)
80201d22: 0d 46        	li	a2, 3
80201d24: 23 0c c1 02  	sb	a2, 56(sp)
80201d28: 03 b4 09 00  	ld	s0, 0(s3)
80201d2c: 02 e8        	sd	zero, 16(sp)
80201d2e: 02 f0        	sd	zero, 32(sp)
80201d30: 2a e0        	sd	a0, 0(sp)
80201d32: 2e e4        	sd	a1, 8(sp)
80201d34: 61 c0        	beqz	s0, 0x80201df4 <.Lpcrel_hi2+0x98>
80201d36: 03 b5 89 00  	ld	a0, 8(s3)
80201d3a: 63 07 05 10  	beqz	a0, 0x80201e48 <.Lpcrel_hi2+0xec>
80201d3e: 83 b4 09 01  	ld	s1, 16(s3)
80201d42: 93 05 f5 ff  	addi	a1, a0, -1
80201d46: 8e 05        	slli	a1, a1, 3
80201d48: 8d 81        	srli	a1, a1, 3
80201d4a: 13 89 15 00  	addi	s2, a1, 1
80201d4e: a1 04        	addi	s1, s1, 8
80201d50: 93 05 80 03  	li	a1, 56
80201d54: 33 0a b5 02  	mul	s4, a0, a1
80201d58: 61 04        	addi	s0, s0, 24
80201d5a: 85 4a        	li	s5, 1

0000000080201d5c <.Lpcrel_hi2>:
80201d5c: 17 05 00 00  	auipc	a0, 0
80201d60: 13 0b 65 f9  	addi	s6, a0, -106
80201d64: 90 60        	ld	a2, 0(s1)
80201d66: 01 ca        	beqz	a2, 0x80201d76 <.Lpcrel_hi2+0x1a>
80201d68: a2 66        	ld	a3, 8(sp)
80201d6a: 02 65        	ld	a0, 0(sp)
80201d6c: 83 b5 84 ff  	ld	a1, -8(s1)
80201d70: 94 6e        	ld	a3, 24(a3)
80201d72: 82 96        	jalr	a3
80201d74: 65 ed        	bnez	a0, 0x80201e6c <.Lpcrel_hi2+0x110>
80201d76: 48 44        	lw	a0, 12(s0)
80201d78: 2a da        	sw	a0, 52(sp)
80201d7a: 03 05 04 01  	lb	a0, 16(s0)
80201d7e: 23 0c a1 02  	sb	a0, 56(sp)
80201d82: 0c 44        	lw	a1, 8(s0)
80201d84: 03 b5 09 02  	ld	a0, 32(s3)
80201d88: 2e d8        	sw	a1, 48(sp)
80201d8a: 03 36 84 ff  	ld	a2, -8(s0)
80201d8e: 0c 60        	ld	a1, 0(s0)
80201d90: 01 ce        	beqz	a2, 0x80201da8 <.Lpcrel_hi2+0x4c>
80201d92: 63 17 56 01  	bne	a2, s5, 0x80201da0 <.Lpcrel_hi2+0x44>
80201d96: 92 05        	slli	a1, a1, 4
80201d98: aa 95        	add	a1, a1, a0
80201d9a: 90 65        	ld	a2, 8(a1)
80201d9c: 63 04 66 01  	beq	a2, s6, 0x80201da4 <.Lpcrel_hi2+0x48>
80201da0: 01 46        	li	a2, 0
80201da2: 21 a0        	j	0x80201daa <.Lpcrel_hi2+0x4e>
80201da4: 8c 61        	ld	a1, 0(a1)
80201da6: 8c 61        	ld	a1, 0(a1)
80201da8: 05 46        	li	a2, 1
80201daa: 32 e8        	sd	a2, 16(sp)
80201dac: 2e ec        	sd	a1, 24(sp)
80201dae: 03 36 84 fe  	ld	a2, -24(s0)
80201db2: 83 35 04 ff  	ld	a1, -16(s0)
80201db6: 01 ce        	beqz	a2, 0x80201dce <.Lpcrel_hi2+0x72>
80201db8: 63 17 56 01  	bne	a2, s5, 0x80201dc6 <.Lpcrel_hi2+0x6a>
80201dbc: 92 05        	slli	a1, a1, 4
80201dbe: aa 95        	add	a1, a1, a0
80201dc0: 90 65        	ld	a2, 8(a1)
80201dc2: 63 04 66 01  	beq	a2, s6, 0x80201dca <.Lpcrel_hi2+0x6e>
80201dc6: 01 46        	li	a2, 0
80201dc8: 21 a0        	j	0x80201dd0 <.Lpcrel_hi2+0x74>
80201dca: 8c 61        	ld	a1, 0(a1)
80201dcc: 8c 61        	ld	a1, 0(a1)
80201dce: 05 46        	li	a2, 1
80201dd0: 32 f0        	sd	a2, 32(sp)
80201dd2: 2e f4        	sd	a1, 40(sp)
80201dd4: 0c 6c        	ld	a1, 24(s0)
80201dd6: 92 05        	slli	a1, a1, 4
80201dd8: 2e 95        	add	a0, a0, a1
80201dda: 10 65        	ld	a2, 8(a0)
80201ddc: 08 61        	ld	a0, 0(a0)
80201dde: 8a 85        	mv	a1, sp
80201de0: 02 96        	jalr	a2
80201de2: 49 e5        	bnez	a0, 0x80201e6c <.Lpcrel_hi2+0x110>
80201de4: c1 04        	addi	s1, s1, 16
80201de6: 13 0a 8a fc  	addi	s4, s4, -56
80201dea: 13 04 84 03  	addi	s0, s0, 56
80201dee: e3 1b 0a f6  	bnez	s4, 0x80201d64 <.Lpcrel_hi2+0x8>
80201df2: b1 a0        	j	0x80201e3e <.Lpcrel_hi2+0xe2>
80201df4: 03 ba 89 02  	ld	s4, 40(s3)
80201df8: 63 08 0a 04  	beqz	s4, 0x80201e48 <.Lpcrel_hi2+0xec>
80201dfc: 83 b4 09 02  	ld	s1, 32(s3)
80201e00: 03 b4 09 01  	ld	s0, 16(s3)
80201e04: 13 05 fa ff  	addi	a0, s4, -1
80201e08: 12 05        	slli	a0, a0, 4
80201e0a: 11 81        	srli	a0, a0, 4
80201e0c: 13 09 15 00  	addi	s2, a0, 1
80201e10: 21 04        	addi	s0, s0, 8
80201e12: a1 04        	addi	s1, s1, 8
80201e14: 12 0a        	slli	s4, s4, 4
80201e16: 10 60        	ld	a2, 0(s0)
80201e18: 01 ca        	beqz	a2, 0x80201e28 <.Lpcrel_hi2+0xcc>
80201e1a: a2 66        	ld	a3, 8(sp)
80201e1c: 02 65        	ld	a0, 0(sp)
80201e1e: 83 35 84 ff  	ld	a1, -8(s0)
80201e22: 94 6e        	ld	a3, 24(a3)
80201e24: 82 96        	jalr	a3
80201e26: 39 e1        	bnez	a0, 0x80201e6c <.Lpcrel_hi2+0x110>
80201e28: 90 60        	ld	a2, 0(s1)
80201e2a: 03 b5 84 ff  	ld	a0, -8(s1)
80201e2e: 8a 85        	mv	a1, sp
80201e30: 02 96        	jalr	a2
80201e32: 0d ed        	bnez	a0, 0x80201e6c <.Lpcrel_hi2+0x110>
80201e34: 41 04        	addi	s0, s0, 16
80201e36: 41 1a        	addi	s4, s4, -16
80201e38: c1 04        	addi	s1, s1, 16
80201e3a: e3 1e 0a fc  	bnez	s4, 0x80201e16 <.Lpcrel_hi2+0xba>
80201e3e: 03 b5 89 01  	ld	a0, 24(s3)
80201e42: 63 68 a9 00  	bltu	s2, a0, 0x80201e52 <.Lpcrel_hi2+0xf6>
80201e46: 2d a0        	j	0x80201e70 <.Lpcrel_hi2+0x114>
80201e48: 01 49        	li	s2, 0
80201e4a: 03 b5 89 01  	ld	a0, 24(s3)
80201e4e: 63 71 a9 02  	bgeu	s2, a0, 0x80201e70 <.Lpcrel_hi2+0x114>
80201e52: 03 b5 09 01  	ld	a0, 16(s3)
80201e56: 12 09        	slli	s2, s2, 4
80201e58: 2a 99        	add	s2, s2, a0
80201e5a: a2 66        	ld	a3, 8(sp)
80201e5c: 02 65        	ld	a0, 0(sp)
80201e5e: 83 35 09 00  	ld	a1, 0(s2)
80201e62: 03 36 89 00  	ld	a2, 8(s2)
80201e66: 94 6e        	ld	a3, 24(a3)
80201e68: 82 96        	jalr	a3
80201e6a: 19 c1        	beqz	a0, 0x80201e70 <.Lpcrel_hi2+0x114>
80201e6c: 05 45        	li	a0, 1
80201e6e: 11 a0        	j	0x80201e72 <.Lpcrel_hi2+0x116>
80201e70: 01 45        	li	a0, 0
80201e72: e6 70        	ld	ra, 120(sp)
80201e74: 46 74        	ld	s0, 112(sp)
80201e76: a6 74        	ld	s1, 104(sp)
80201e78: 06 79        	ld	s2, 96(sp)
80201e7a: e6 69        	ld	s3, 88(sp)
80201e7c: 46 6a        	ld	s4, 80(sp)
80201e7e: a6 6a        	ld	s5, 72(sp)
80201e80: 06 6b        	ld	s6, 64(sp)
80201e82: 09 61        	addi	sp, sp, 128
80201e84: 82 80        	ret

0000000080201e86 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E>:
80201e86: 59 71        	addi	sp, sp, -112
80201e88: 86 f4        	sd	ra, 104(sp)
80201e8a: a2 f0        	sd	s0, 96(sp)
80201e8c: a6 ec        	sd	s1, 88(sp)
80201e8e: ca e8        	sd	s2, 80(sp)
80201e90: ce e4        	sd	s3, 72(sp)
80201e92: d2 e0        	sd	s4, 64(sp)
80201e94: 56 fc        	sd	s5, 56(sp)
80201e96: 5a f8        	sd	s6, 48(sp)
80201e98: 5e f4        	sd	s7, 40(sp)
80201e9a: 62 f0        	sd	s8, 32(sp)
80201e9c: 66 ec        	sd	s9, 24(sp)
80201e9e: 6a e8        	sd	s10, 16(sp)
80201ea0: 6e e4        	sd	s11, 8(sp)
80201ea2: be 89        	mv	s3, a5
80201ea4: 3a 89        	mv	s2, a4
80201ea6: 36 8b        	mv	s6, a3
80201ea8: 32 8a        	mv	s4, a2
80201eaa: 2a 8c        	mv	s8, a0
80201eac: b9 c1        	beqz	a1, 0x80201ef2 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x6c>
80201eae: 03 64 0c 03  	lwu	s0, 48(s8)
80201eb2: 93 7c 14 00  	andi	s9, s0, 1
80201eb6: b7 0a 11 00  	lui	s5, 272
80201eba: 63 84 0c 00  	beqz	s9, 0x80201ec2 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x3c>
80201ebe: 93 0a b0 02  	li	s5, 43
80201ec2: ce 9c        	add	s9, s9, s3
80201ec4: 13 75 44 00  	andi	a0, s0, 4
80201ec8: 15 cd        	beqz	a0, 0x80201f04 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x7e>
80201eca: 13 05 00 02  	li	a0, 32
80201ece: 63 70 ab 04  	bgeu	s6, a0, 0x80201f0e <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x88>
80201ed2: 01 45        	li	a0, 0
80201ed4: 63 03 0b 04  	beqz	s6, 0x80201f1a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x94>
80201ed8: da 85        	mv	a1, s6
80201eda: 52 86        	mv	a2, s4
80201edc: 83 06 06 00  	lb	a3, 0(a2)
80201ee0: 05 06        	addi	a2, a2, 1
80201ee2: 93 a6 06 fc  	slti	a3, a3, -64
80201ee6: 93 c6 16 00  	xori	a3, a3, 1
80201eea: fd 15        	addi	a1, a1, -1
80201eec: 36 95        	add	a0, a0, a3
80201eee: fd f5        	bnez	a1, 0x80201edc <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x56>
80201ef0: 2d a0        	j	0x80201f1a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x94>
80201ef2: 03 24 0c 03  	lw	s0, 48(s8)
80201ef6: 93 8c 19 00  	addi	s9, s3, 1
80201efa: 93 0a d0 02  	li	s5, 45
80201efe: 13 75 44 00  	andi	a0, s0, 4
80201f02: 61 f5        	bnez	a0, 0x80201eca <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x44>
80201f04: 01 4a        	li	s4, 0
80201f06: 03 35 0c 01  	ld	a0, 16(s8)
80201f0a: 01 ed        	bnez	a0, 0x80201f22 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x9c>
80201f0c: 3d a8        	j	0x80201f4a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xc4>
80201f0e: 52 85        	mv	a0, s4
80201f10: da 85        	mv	a1, s6
80201f12: 97 00 00 00  	auipc	ra, 0
80201f16: e7 80 40 46  	jalr	1124(ra)
80201f1a: aa 9c        	add	s9, s9, a0
80201f1c: 03 35 0c 01  	ld	a0, 16(s8)
80201f20: 0d c5        	beqz	a0, 0x80201f4a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xc4>
80201f22: 03 3d 8c 01  	ld	s10, 24(s8)
80201f26: 63 f2 ac 03  	bgeu	s9, s10, 0x80201f4a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xc4>
80201f2a: 21 88        	andi	s0, s0, 8
80201f2c: 49 e0        	bnez	s0, 0x80201fae <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x128>
80201f2e: 83 45 8c 03  	lbu	a1, 56(s8)
80201f32: 0d 45        	li	a0, 3
80201f34: 63 93 a5 00  	bne	a1, a0, 0x80201f3a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xb4>
80201f38: 85 45        	li	a1, 1
80201f3a: 33 05 9d 41  	sub	a0, s10, s9
80201f3e: dd cd        	beqz	a1, 0x80201ffc <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x176>
80201f40: 05 46        	li	a2, 1
80201f42: 63 90 c5 0c  	bne	a1, a2, 0x80202002 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x17c>
80201f46: 01 4d        	li	s10, 0
80201f48: d1 a0        	j	0x8020200c <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x186>
80201f4a: 03 34 0c 00  	ld	s0, 0(s8)
80201f4e: 83 34 8c 00  	ld	s1, 8(s8)
80201f52: 22 85        	mv	a0, s0
80201f54: a6 85        	mv	a1, s1
80201f56: 56 86        	mv	a2, s5
80201f58: d2 86        	mv	a3, s4
80201f5a: 5a 87        	mv	a4, s6
80201f5c: 97 00 00 00  	auipc	ra, 0
80201f60: e7 80 40 14  	jalr	324(ra)
80201f64: 85 4b        	li	s7, 1
80201f66: 0d c1        	beqz	a0, 0x80201f88 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x102>
80201f68: 5e 85        	mv	a0, s7
80201f6a: a6 70        	ld	ra, 104(sp)
80201f6c: 06 74        	ld	s0, 96(sp)
80201f6e: e6 64        	ld	s1, 88(sp)
80201f70: 46 69        	ld	s2, 80(sp)
80201f72: a6 69        	ld	s3, 72(sp)
80201f74: 06 6a        	ld	s4, 64(sp)
80201f76: e2 7a        	ld	s5, 56(sp)
80201f78: 42 7b        	ld	s6, 48(sp)
80201f7a: a2 7b        	ld	s7, 40(sp)
80201f7c: 02 7c        	ld	s8, 32(sp)
80201f7e: e2 6c        	ld	s9, 24(sp)
80201f80: 42 6d        	ld	s10, 16(sp)
80201f82: a2 6d        	ld	s11, 8(sp)
80201f84: 65 61        	addi	sp, sp, 112
80201f86: 82 80        	ret
80201f88: 9c 6c        	ld	a5, 24(s1)
80201f8a: 22 85        	mv	a0, s0
80201f8c: ca 85        	mv	a1, s2
80201f8e: 4e 86        	mv	a2, s3
80201f90: a6 70        	ld	ra, 104(sp)
80201f92: 06 74        	ld	s0, 96(sp)
80201f94: e6 64        	ld	s1, 88(sp)
80201f96: 46 69        	ld	s2, 80(sp)
80201f98: a6 69        	ld	s3, 72(sp)
80201f9a: 06 6a        	ld	s4, 64(sp)
80201f9c: e2 7a        	ld	s5, 56(sp)
80201f9e: 42 7b        	ld	s6, 48(sp)
80201fa0: a2 7b        	ld	s7, 40(sp)
80201fa2: 02 7c        	ld	s8, 32(sp)
80201fa4: e2 6c        	ld	s9, 24(sp)
80201fa6: 42 6d        	ld	s10, 16(sp)
80201fa8: a2 6d        	ld	s11, 8(sp)
80201faa: 65 61        	addi	sp, sp, 112
80201fac: 82 87        	jr	a5
80201fae: 03 24 4c 03  	lw	s0, 52(s8)
80201fb2: 13 05 00 03  	li	a0, 48
80201fb6: 83 45 8c 03  	lbu	a1, 56(s8)
80201fba: 2e e0        	sd	a1, 0(sp)
80201fbc: 83 3d 0c 00  	ld	s11, 0(s8)
80201fc0: 83 34 8c 00  	ld	s1, 8(s8)
80201fc4: 23 2a ac 02  	sw	a0, 52(s8)
80201fc8: 85 4b        	li	s7, 1
80201fca: 23 0c 7c 03  	sb	s7, 56(s8)
80201fce: 6e 85        	mv	a0, s11
80201fd0: a6 85        	mv	a1, s1
80201fd2: 56 86        	mv	a2, s5
80201fd4: d2 86        	mv	a3, s4
80201fd6: 5a 87        	mv	a4, s6
80201fd8: 97 00 00 00  	auipc	ra, 0
80201fdc: e7 80 80 0c  	jalr	200(ra)
80201fe0: 41 f5        	bnez	a0, 0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
80201fe2: 22 8a        	mv	s4, s0
80201fe4: 33 04 9d 41  	sub	s0, s10, s9
80201fe8: 05 04        	addi	s0, s0, 1
80201fea: 7d 14        	addi	s0, s0, -1
80201fec: 41 c8        	beqz	s0, 0x8020207c <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x1f6>
80201fee: 90 70        	ld	a2, 32(s1)
80201ff0: 93 05 00 03  	li	a1, 48
80201ff4: 6e 85        	mv	a0, s11
80201ff6: 02 96        	jalr	a2
80201ff8: 6d d9        	beqz	a0, 0x80201fea <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x164>
80201ffa: bd b7        	j	0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
80201ffc: 2a 8d        	mv	s10, a0
80201ffe: 2e 85        	mv	a0, a1
80202000: 31 a0        	j	0x8020200c <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x186>
80202002: 93 05 15 00  	addi	a1, a0, 1
80202006: 05 81        	srli	a0, a0, 1
80202008: 13 dd 15 00  	srli	s10, a1, 1
8020200c: 83 3c 0c 00  	ld	s9, 0(s8)
80202010: 83 3d 8c 00  	ld	s11, 8(s8)
80202014: 83 24 4c 03  	lw	s1, 52(s8)
80202018: 13 04 15 00  	addi	s0, a0, 1
8020201c: 7d 14        	addi	s0, s0, -1
8020201e: 09 c8        	beqz	s0, 0x80202030 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x1aa>
80202020: 03 b6 0d 02  	ld	a2, 32(s11)
80202024: 66 85        	mv	a0, s9
80202026: a6 85        	mv	a1, s1
80202028: 02 96        	jalr	a2
8020202a: 6d d9        	beqz	a0, 0x8020201c <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x196>
8020202c: 85 4b        	li	s7, 1
8020202e: 2d bf        	j	0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
80202030: 37 05 11 00  	lui	a0, 272
80202034: 85 4b        	li	s7, 1
80202036: e3 89 a4 f2  	beq	s1, a0, 0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
8020203a: 66 85        	mv	a0, s9
8020203c: ee 85        	mv	a1, s11
8020203e: 56 86        	mv	a2, s5
80202040: d2 86        	mv	a3, s4
80202042: 5a 87        	mv	a4, s6
80202044: 97 00 00 00  	auipc	ra, 0
80202048: e7 80 c0 05  	jalr	92(ra)
8020204c: 11 fd        	bnez	a0, 0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
8020204e: 83 b6 8d 01  	ld	a3, 24(s11)
80202052: 66 85        	mv	a0, s9
80202054: ca 85        	mv	a1, s2
80202056: 4e 86        	mv	a2, s3
80202058: 82 96        	jalr	a3
8020205a: 19 f5        	bnez	a0, 0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
8020205c: b3 09 a0 41  	neg	s3, s10
80202060: 7d 5a        	li	s4, -1
80202062: 7d 59        	li	s2, -1
80202064: 33 85 29 01  	add	a0, s3, s2
80202068: 63 08 45 03  	beq	a0, s4, 0x80202098 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x212>
8020206c: 03 b6 0d 02  	ld	a2, 32(s11)
80202070: 66 85        	mv	a0, s9
80202072: a6 85        	mv	a1, s1
80202074: 02 96        	jalr	a2
80202076: 05 09        	addi	s2, s2, 1
80202078: 75 d5        	beqz	a0, 0x80202064 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x1de>
8020207a: 05 a0        	j	0x8020209a <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0x214>
8020207c: 94 6c        	ld	a3, 24(s1)
8020207e: 6e 85        	mv	a0, s11
80202080: ca 85        	mv	a1, s2
80202082: 4e 86        	mv	a2, s3
80202084: 82 96        	jalr	a3
80202086: e3 11 05 ee  	bnez	a0, 0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
8020208a: 81 4b        	li	s7, 0
8020208c: 23 2a 4c 03  	sw	s4, 52(s8)
80202090: 02 65        	ld	a0, 0(sp)
80202092: 23 0c ac 02  	sb	a0, 56(s8)
80202096: c9 bd        	j	0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>
80202098: 6a 89        	mv	s2, s10
8020209a: b3 3b a9 01  	sltu	s7, s2, s10
8020209e: e9 b5        	j	0x80201f68 <_ZN4core3fmt9Formatter12pad_integral17hd52bd9a854105408E+0xe2>

00000000802020a0 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h12658b0659eb46dcE>:
802020a0: 79 71        	addi	sp, sp, -48
802020a2: 06 f4        	sd	ra, 40(sp)
802020a4: 22 f0        	sd	s0, 32(sp)
802020a6: 26 ec        	sd	s1, 24(sp)
802020a8: 4a e8        	sd	s2, 16(sp)
802020aa: 4e e4        	sd	s3, 8(sp)
802020ac: 9b 07 06 00  	sext.w	a5, a2
802020b0: 37 08 11 00  	lui	a6, 272
802020b4: 3a 89        	mv	s2, a4
802020b6: b6 84        	mv	s1, a3
802020b8: 2e 84        	mv	s0, a1
802020ba: aa 89        	mv	s3, a0
802020bc: 63 89 07 01  	beq	a5, a6, 0x802020ce <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h12658b0659eb46dcE+0x2e>
802020c0: 14 70        	ld	a3, 32(s0)
802020c2: 4e 85        	mv	a0, s3
802020c4: b2 85        	mv	a1, a2
802020c6: 82 96        	jalr	a3
802020c8: aa 85        	mv	a1, a0
802020ca: 05 45        	li	a0, 1
802020cc: 91 ed        	bnez	a1, 0x802020e8 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h12658b0659eb46dcE+0x48>
802020ce: 81 cc        	beqz	s1, 0x802020e6 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h12658b0659eb46dcE+0x46>
802020d0: 1c 6c        	ld	a5, 24(s0)
802020d2: 4e 85        	mv	a0, s3
802020d4: a6 85        	mv	a1, s1
802020d6: 4a 86        	mv	a2, s2
802020d8: a2 70        	ld	ra, 40(sp)
802020da: 02 74        	ld	s0, 32(sp)
802020dc: e2 64        	ld	s1, 24(sp)
802020de: 42 69        	ld	s2, 16(sp)
802020e0: a2 69        	ld	s3, 8(sp)
802020e2: 45 61        	addi	sp, sp, 48
802020e4: 82 87        	jr	a5
802020e6: 01 45        	li	a0, 0
802020e8: a2 70        	ld	ra, 40(sp)
802020ea: 02 74        	ld	s0, 32(sp)
802020ec: e2 64        	ld	s1, 24(sp)
802020ee: 42 69        	ld	s2, 16(sp)
802020f0: a2 69        	ld	s3, 8(sp)
802020f2: 45 61        	addi	sp, sp, 48
802020f4: 82 80        	ret

00000000802020f6 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE>:
802020f6: 5d 71        	addi	sp, sp, -80
802020f8: 86 e4        	sd	ra, 72(sp)
802020fa: a2 e0        	sd	s0, 64(sp)
802020fc: 26 fc        	sd	s1, 56(sp)
802020fe: 4a f8        	sd	s2, 48(sp)
80202100: 4e f4        	sd	s3, 40(sp)
80202102: 52 f0        	sd	s4, 32(sp)
80202104: 56 ec        	sd	s5, 24(sp)
80202106: 5a e8        	sd	s6, 16(sp)
80202108: 5e e4        	sd	s7, 8(sp)
8020210a: 2a 8a        	mv	s4, a0
8020210c: 83 32 05 01  	ld	t0, 16(a0)
80202110: 08 71        	ld	a0, 32(a0)
80202112: b3 e6 a2 00  	or	a3, t0, a0
80202116: b2 89        	mv	s3, a2
80202118: 2e 89        	mv	s2, a1
8020211a: 63 8a 06 16  	beqz	a3, 0x8020228e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x198>
8020211e: 63 07 05 10  	beqz	a0, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
80202122: 03 37 8a 02  	ld	a4, 40(s4)
80202126: 01 45        	li	a0, 0
80202128: b3 06 39 01  	add	a3, s2, s3
8020212c: 05 07        	addi	a4, a4, 1
8020212e: 37 03 11 00  	lui	t1, 272
80202132: 93 08 f0 0d  	li	a7, 223
80202136: 13 08 00 0f  	li	a6, 240
8020213a: 4a 86        	mv	a2, s2
8020213c: 01 a8        	j	0x8020214c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x56>
8020213e: 93 05 16 00  	addi	a1, a2, 1
80202142: 11 8d        	sub	a0, a0, a2
80202144: 2e 95        	add	a0, a0, a1
80202146: 2e 86        	mv	a2, a1
80202148: 63 02 64 0e  	beq	s0, t1, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
8020214c: 7d 17        	addi	a4, a4, -1
8020214e: 25 c7        	beqz	a4, 0x802021b6 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0xc0>
80202150: 63 0e d6 0c  	beq	a2, a3, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
80202154: 83 05 06 00  	lb	a1, 0(a2)
80202158: 13 f4 f5 0f  	andi	s0, a1, 255
8020215c: e3 d1 05 fe  	bgez	a1, 0x8020213e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x48>
80202160: 83 45 16 00  	lbu	a1, 1(a2)
80202164: 93 74 f4 01  	andi	s1, s0, 31
80202168: 93 f7 f5 03  	andi	a5, a1, 63
8020216c: 63 f9 88 02  	bgeu	a7, s0, 0x8020219e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0xa8>
80202170: 83 45 26 00  	lbu	a1, 2(a2)
80202174: 9a 07        	slli	a5, a5, 6
80202176: 93 f5 f5 03  	andi	a1, a1, 63
8020217a: cd 8f        	or	a5, a5, a1
8020217c: 63 67 04 03  	bltu	s0, a6, 0x802021aa <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0xb4>
80202180: 83 45 36 00  	lbu	a1, 3(a2)
80202184: f6 14        	slli	s1, s1, 61
80202186: ad 90        	srli	s1, s1, 43
80202188: 9a 07        	slli	a5, a5, 6
8020218a: 93 f5 f5 03  	andi	a1, a1, 63
8020218e: dd 8d        	or	a1, a1, a5
80202190: 33 e4 95 00  	or	s0, a1, s1
80202194: 63 0c 64 08  	beq	s0, t1, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
80202198: 93 05 46 00  	addi	a1, a2, 4
8020219c: 5d b7        	j	0x80202142 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x4c>
8020219e: 93 05 26 00  	addi	a1, a2, 2
802021a2: 13 94 64 00  	slli	s0, s1, 6
802021a6: 5d 8c        	or	s0, s0, a5
802021a8: 69 bf        	j	0x80202142 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x4c>
802021aa: 93 05 36 00  	addi	a1, a2, 3
802021ae: 13 94 c4 00  	slli	s0, s1, 12
802021b2: 5d 8c        	or	s0, s0, a5
802021b4: 79 b7        	j	0x80202142 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x4c>
802021b6: 63 0b d6 06  	beq	a2, a3, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
802021ba: 83 05 06 00  	lb	a1, 0(a2)
802021be: 63 d3 05 04  	bgez	a1, 0x80202204 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x10e>
802021c2: 93 f5 f5 0f  	andi	a1, a1, 255
802021c6: 93 06 00 0e  	li	a3, 224
802021ca: 63 ed d5 02  	bltu	a1, a3, 0x80202204 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x10e>
802021ce: 93 06 00 0f  	li	a3, 240
802021d2: 63 e9 d5 02  	bltu	a1, a3, 0x80202204 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x10e>
802021d6: 83 46 16 00  	lbu	a3, 1(a2)
802021da: 03 47 26 00  	lbu	a4, 2(a2)
802021de: 93 f6 f6 03  	andi	a3, a3, 63
802021e2: 13 77 f7 03  	andi	a4, a4, 63
802021e6: 03 46 36 00  	lbu	a2, 3(a2)
802021ea: f6 15        	slli	a1, a1, 61
802021ec: ad 91        	srli	a1, a1, 43
802021ee: b2 06        	slli	a3, a3, 12
802021f0: 1a 07        	slli	a4, a4, 6
802021f2: d9 8e        	or	a3, a3, a4
802021f4: 13 76 f6 03  	andi	a2, a2, 63
802021f8: 55 8e        	or	a2, a2, a3
802021fa: d1 8d        	or	a1, a1, a2
802021fc: 37 06 11 00  	lui	a2, 272
80202200: 63 86 c5 02  	beq	a1, a2, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
80202204: 05 c1        	beqz	a0, 0x80202224 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x12e>
80202206: 63 7d 35 01  	bgeu	a0, s3, 0x80202220 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x12a>
8020220a: b3 05 a9 00  	add	a1, s2, a0
8020220e: 83 85 05 00  	lb	a1, 0(a1)
80202212: 13 06 00 fc  	li	a2, -64
80202216: 63 d7 c5 00  	bge	a1, a2, 0x80202224 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x12e>
8020221a: 81 45        	li	a1, 0
8020221c: 91 e5        	bnez	a1, 0x80202228 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x132>
8020221e: 39 a0        	j	0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
80202220: e3 1d 35 ff  	bne	a0, s3, 0x8020221a <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x124>
80202224: ca 85        	mv	a1, s2
80202226: 99 c1        	beqz	a1, 0x8020222c <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x136>
80202228: aa 89        	mv	s3, a0
8020222a: 2e 89        	mv	s2, a1
8020222c: 63 81 02 06  	beqz	t0, 0x8020228e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x198>
80202230: 03 34 8a 01  	ld	s0, 24(s4)
80202234: 13 05 00 02  	li	a0, 32
80202238: 63 f3 a9 04  	bgeu	s3, a0, 0x8020227e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x188>
8020223c: 01 45        	li	a0, 0
8020223e: 63 8e 09 00  	beqz	s3, 0x8020225a <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x164>
80202242: ce 85        	mv	a1, s3
80202244: 4a 86        	mv	a2, s2
80202246: 83 06 06 00  	lb	a3, 0(a2)
8020224a: 05 06        	addi	a2, a2, 1
8020224c: 93 a6 06 fc  	slti	a3, a3, -64
80202250: 93 c6 16 00  	xori	a3, a3, 1
80202254: fd 15        	addi	a1, a1, -1
80202256: 36 95        	add	a0, a0, a3
80202258: fd f5        	bnez	a1, 0x80202246 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x150>
8020225a: 63 7a 85 02  	bgeu	a0, s0, 0x8020228e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x198>
8020225e: 83 45 8a 03  	lbu	a1, 56(s4)
80202262: 13 86 d5 ff  	addi	a2, a1, -3
80202266: 13 36 16 00  	seqz	a2, a2
8020226a: 7d 16        	addi	a2, a2, -1
8020226c: f1 8d        	and	a1, a1, a2
8020226e: 33 05 a4 40  	sub	a0, s0, a0
80202272: a1 c1        	beqz	a1, 0x802022b2 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x1bc>
80202274: 05 46        	li	a2, 1
80202276: 63 91 c5 04  	bne	a1, a2, 0x802022b8 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x1c2>
8020227a: 81 4a        	li	s5, 0
8020227c: 99 a0        	j	0x802022c2 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x1cc>
8020227e: 4a 85        	mv	a0, s2
80202280: ce 85        	mv	a1, s3
80202282: 97 00 00 00  	auipc	ra, 0
80202286: e7 80 40 0f  	jalr	244(ra)
8020228a: e3 6a 85 fc  	bltu	a0, s0, 0x8020225e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x168>
8020228e: 83 35 8a 00  	ld	a1, 8(s4)
80202292: 03 35 0a 00  	ld	a0, 0(s4)
80202296: 9c 6d        	ld	a5, 24(a1)
80202298: ca 85        	mv	a1, s2
8020229a: 4e 86        	mv	a2, s3
8020229c: a6 60        	ld	ra, 72(sp)
8020229e: 06 64        	ld	s0, 64(sp)
802022a0: e2 74        	ld	s1, 56(sp)
802022a2: 42 79        	ld	s2, 48(sp)
802022a4: a2 79        	ld	s3, 40(sp)
802022a6: 02 7a        	ld	s4, 32(sp)
802022a8: e2 6a        	ld	s5, 24(sp)
802022aa: 42 6b        	ld	s6, 16(sp)
802022ac: a2 6b        	ld	s7, 8(sp)
802022ae: 61 61        	addi	sp, sp, 80
802022b0: 82 87        	jr	a5
802022b2: aa 8a        	mv	s5, a0
802022b4: 2e 85        	mv	a0, a1
802022b6: 31 a0        	j	0x802022c2 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x1cc>
802022b8: 93 05 15 00  	addi	a1, a0, 1
802022bc: 05 81        	srli	a0, a0, 1
802022be: 93 da 15 00  	srli	s5, a1, 1
802022c2: 03 3b 0a 00  	ld	s6, 0(s4)
802022c6: 83 3b 8a 00  	ld	s7, 8(s4)
802022ca: 83 24 4a 03  	lw	s1, 52(s4)
802022ce: 13 04 15 00  	addi	s0, a0, 1
802022d2: 7d 14        	addi	s0, s0, -1
802022d4: 09 c8        	beqz	s0, 0x802022e6 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x1f0>
802022d6: 03 b6 0b 02  	ld	a2, 32(s7)
802022da: 5a 85        	mv	a0, s6
802022dc: a6 85        	mv	a1, s1
802022de: 02 96        	jalr	a2
802022e0: 6d d9        	beqz	a0, 0x802022d2 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x1dc>
802022e2: 05 4a        	li	s4, 1
802022e4: 81 a0        	j	0x80202324 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x22e>
802022e6: 37 05 11 00  	lui	a0, 272
802022ea: 05 4a        	li	s4, 1
802022ec: 63 8c a4 02  	beq	s1, a0, 0x80202324 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x22e>
802022f0: 83 b6 8b 01  	ld	a3, 24(s7)
802022f4: 5a 85        	mv	a0, s6
802022f6: ca 85        	mv	a1, s2
802022f8: 4e 86        	mv	a2, s3
802022fa: 82 96        	jalr	a3
802022fc: 05 e5        	bnez	a0, 0x80202324 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x22e>
802022fe: 33 09 50 41  	neg	s2, s5
80202302: fd 59        	li	s3, -1
80202304: 7d 54        	li	s0, -1
80202306: 33 05 89 00  	add	a0, s2, s0
8020230a: 63 0a 35 01  	beq	a0, s3, 0x8020231e <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x228>
8020230e: 03 b6 0b 02  	ld	a2, 32(s7)
80202312: 5a 85        	mv	a0, s6
80202314: a6 85        	mv	a1, s1
80202316: 02 96        	jalr	a2
80202318: 05 04        	addi	s0, s0, 1
8020231a: 75 d5        	beqz	a0, 0x80202306 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x210>
8020231c: 11 a0        	j	0x80202320 <_ZN4core3fmt9Formatter3pad17h3137c80ca8a5344fE+0x22a>
8020231e: 56 84        	mv	s0, s5
80202320: 33 3a 54 01  	sltu	s4, s0, s5
80202324: 52 85        	mv	a0, s4
80202326: a6 60        	ld	ra, 72(sp)
80202328: 06 64        	ld	s0, 64(sp)
8020232a: e2 74        	ld	s1, 56(sp)
8020232c: 42 79        	ld	s2, 48(sp)
8020232e: a2 79        	ld	s3, 40(sp)
80202330: 02 7a        	ld	s4, 32(sp)
80202332: e2 6a        	ld	s5, 24(sp)
80202334: 42 6b        	ld	s6, 16(sp)
80202336: a2 6b        	ld	s7, 8(sp)
80202338: 61 61        	addi	sp, sp, 80
8020233a: 82 80        	ret

000000008020233c <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h9004743024a635dfE>:
8020233c: ae 86        	mv	a3, a1
8020233e: aa 85        	mv	a1, a0
80202340: 32 85        	mv	a0, a2
80202342: 36 86        	mv	a2, a3
80202344: 17 03 00 00  	auipc	t1, 0
80202348: 67 00 23 db  	jr	-590(t1)

000000008020234c <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h71820f2759697d4dE>:
8020234c: 90 65        	ld	a2, 8(a1)
8020234e: 88 61        	ld	a0, 0(a1)
80202350: 1c 6e        	ld	a5, 24(a2)

0000000080202352 <.Lpcrel_hi55>:
80202352: 97 15 00 00  	auipc	a1, 1
80202356: 93 85 85 3f  	addi	a1, a1, 1016
8020235a: 15 46        	li	a2, 5
8020235c: 82 87        	jr	a5

000000008020235e <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7d8787450a6f5c8fE>:
8020235e: 10 65        	ld	a2, 8(a0)
80202360: 08 61        	ld	a0, 0(a0)
80202362: 1c 6e        	ld	a5, 24(a2)
80202364: 82 87        	jr	a5

0000000080202366 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h9f13b29b4b9a75e6E>:
80202366: 14 61        	ld	a3, 0(a0)
80202368: 10 65        	ld	a2, 8(a0)
8020236a: 2e 85        	mv	a0, a1
8020236c: b6 85        	mv	a1, a3
8020236e: 17 03 00 00  	auipc	t1, 0
80202372: 67 00 83 d8  	jr	-632(t1)

0000000080202376 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE>:
80202376: 2a 86        	mv	a2, a0
80202378: 93 06 75 00  	addi	a3, a0, 7
8020237c: e1 9a        	andi	a3, a3, -8
8020237e: b3 82 a6 40  	sub	t0, a3, a0
80202382: 63 ec 55 00  	bltu	a1, t0, 0x8020239a <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x24>
80202386: 33 88 55 40  	sub	a6, a1, t0
8020238a: 13 35 88 00  	sltiu	a0, a6, 8
8020238e: 93 b7 92 00  	sltiu	a5, t0, 9
80202392: 93 c7 17 00  	xori	a5, a5, 1
80202396: 5d 8d        	or	a0, a0, a5
80202398: 11 cd        	beqz	a0, 0x802023b4 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x3e>
8020239a: 01 45        	li	a0, 0
8020239c: 99 c9        	beqz	a1, 0x802023b2 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x3c>
8020239e: 83 06 06 00  	lb	a3, 0(a2)
802023a2: 05 06        	addi	a2, a2, 1
802023a4: 93 a6 06 fc  	slti	a3, a3, -64
802023a8: 93 c6 16 00  	xori	a3, a3, 1
802023ac: fd 15        	addi	a1, a1, -1
802023ae: 36 95        	add	a0, a0, a3
802023b0: fd f5        	bnez	a1, 0x8020239e <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x28>
802023b2: 82 80        	ret
802023b4: 93 75 78 00  	andi	a1, a6, 7
802023b8: 81 47        	li	a5, 0
802023ba: 63 8f c6 00  	beq	a3, a2, 0x802023d8 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x62>
802023be: b3 06 d6 40  	sub	a3, a2, a3
802023c2: 32 85        	mv	a0, a2
802023c4: 03 07 05 00  	lb	a4, 0(a0)
802023c8: 05 05        	addi	a0, a0, 1
802023ca: 13 27 07 fc  	slti	a4, a4, -64
802023ce: 13 47 17 00  	xori	a4, a4, 1
802023d2: 85 06        	addi	a3, a3, 1
802023d4: ba 97        	add	a5, a5, a4
802023d6: fd f6        	bnez	a3, 0x802023c4 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x4e>
802023d8: b2 92        	add	t0, t0, a2
802023da: 01 46        	li	a2, 0
802023dc: 91 cd        	beqz	a1, 0x802023f8 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x82>
802023de: 93 76 88 ff  	andi	a3, a6, -8
802023e2: 96 96        	add	a3, a3, t0
802023e4: 03 85 06 00  	lb	a0, 0(a3)
802023e8: 85 06        	addi	a3, a3, 1
802023ea: 13 25 05 fc  	slti	a0, a0, -64
802023ee: 13 45 15 00  	xori	a0, a0, 1
802023f2: fd 15        	addi	a1, a1, -1
802023f4: 2a 96        	add	a2, a2, a0
802023f6: fd f5        	bnez	a1, 0x802023e4 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x6e>
802023f8: 13 57 38 00  	srli	a4, a6, 3

00000000802023fc <.Lpcrel_hi67>:
802023fc: 17 25 00 00  	auipc	a0, 2
80202400: 83 3e c5 c1  	ld	t4, -996(a0)

0000000080202404 <.Lpcrel_hi68>:
80202404: 17 25 00 00  	auipc	a0, 2
80202408: 83 38 c5 c1  	ld	a7, -996(a0)
8020240c: 37 15 00 10  	lui	a0, 65537
80202410: 12 05        	slli	a0, a0, 4
80202412: 05 05        	addi	a0, a0, 1
80202414: 42 05        	slli	a0, a0, 16
80202416: 13 08 15 00  	addi	a6, a0, 1
8020241a: 33 05 f6 00  	add	a0, a2, a5
8020241e: 25 a0        	j	0x80202446 <.Lpcrel_hi68+0x42>
80202420: 13 97 33 00  	slli	a4, t2, 3
80202424: ba 92        	add	t0, t0, a4
80202426: 33 07 73 40  	sub	a4, t1, t2
8020242a: 93 f3 33 00  	andi	t2, t2, 3
8020242e: b3 f7 15 01  	and	a5, a1, a7
80202432: a1 81        	srli	a1, a1, 8
80202434: b3 f5 15 01  	and	a1, a1, a7
80202438: be 95        	add	a1, a1, a5
8020243a: b3 85 05 03  	mul	a1, a1, a6
8020243e: c1 91        	srli	a1, a1, 48
80202440: 2e 95        	add	a0, a0, a1
80202442: 63 9d 03 06  	bnez	t2, 0x802024bc <.Lpcrel_hi68+0xb8>
80202446: 35 d7        	beqz	a4, 0x802023b2 <_ZN4core3str5count14do_count_chars17h229587cb09bdc9ebE+0x3c>
80202448: 3a 83        	mv	t1, a4
8020244a: 93 05 00 0c  	li	a1, 192
8020244e: ba 83        	mv	t2, a4
80202450: 63 64 b7 00  	bltu	a4, a1, 0x80202458 <.Lpcrel_hi68+0x54>
80202454: 93 03 00 0c  	li	t2, 192
80202458: 93 f5 c3 0f  	andi	a1, t2, 252
8020245c: 13 96 35 00  	slli	a2, a1, 3
80202460: 33 8e c2 00  	add	t3, t0, a2
80202464: d5 dd        	beqz	a1, 0x80202420 <.Lpcrel_hi68+0x1c>
80202466: 81 45        	li	a1, 0
80202468: 16 87        	mv	a4, t0
8020246a: 1c 63        	ld	a5, 0(a4)
8020246c: 13 c6 f7 ff  	not	a2, a5
80202470: 1d 82        	srli	a2, a2, 7
80202472: 99 83        	srli	a5, a5, 6
80202474: 14 67        	ld	a3, 8(a4)
80202476: 5d 8e        	or	a2, a2, a5
80202478: 33 76 d6 01  	and	a2, a2, t4
8020247c: b2 95        	add	a1, a1, a2
8020247e: 13 c6 f6 ff  	not	a2, a3
80202482: 1d 82        	srli	a2, a2, 7
80202484: 1c 6b        	ld	a5, 16(a4)
80202486: 99 82        	srli	a3, a3, 6
80202488: 55 8e        	or	a2, a2, a3
8020248a: 33 76 d6 01  	and	a2, a2, t4
8020248e: 93 c6 f7 ff  	not	a3, a5
80202492: 9d 82        	srli	a3, a3, 7
80202494: 99 83        	srli	a5, a5, 6
80202496: dd 8e        	or	a3, a3, a5
80202498: 1c 6f        	ld	a5, 24(a4)
8020249a: b3 f6 d6 01  	and	a3, a3, t4
8020249e: 36 96        	add	a2, a2, a3
802024a0: b2 95        	add	a1, a1, a2
802024a2: 13 c6 f7 ff  	not	a2, a5
802024a6: 1d 82        	srli	a2, a2, 7
802024a8: 99 83        	srli	a5, a5, 6
802024aa: 5d 8e        	or	a2, a2, a5
802024ac: 33 76 d6 01  	and	a2, a2, t4
802024b0: 13 07 07 02  	addi	a4, a4, 32
802024b4: b2 95        	add	a1, a1, a2
802024b6: e3 1a c7 fb  	bne	a4, t3, 0x8020246a <.Lpcrel_hi68+0x66>
802024ba: 9d b7        	j	0x80202420 <.Lpcrel_hi68+0x1c>
802024bc: 93 05 00 0c  	li	a1, 192
802024c0: 63 64 b3 00  	bltu	t1, a1, 0x802024c8 <.Lpcrel_hi68+0xc4>
802024c4: 13 03 00 0c  	li	t1, 192
802024c8: 81 45        	li	a1, 0
802024ca: 13 77 33 00  	andi	a4, t1, 3
802024ce: 0e 07        	slli	a4, a4, 3
802024d0: 03 36 0e 00  	ld	a2, 0(t3)
802024d4: 21 0e        	addi	t3, t3, 8
802024d6: 93 46 f6 ff  	not	a3, a2
802024da: 9d 82        	srli	a3, a3, 7
802024dc: 19 82        	srli	a2, a2, 6
802024de: 55 8e        	or	a2, a2, a3
802024e0: 33 76 d6 01  	and	a2, a2, t4
802024e4: 61 17        	addi	a4, a4, -8
802024e6: b2 95        	add	a1, a1, a2
802024e8: 65 f7        	bnez	a4, 0x802024d0 <.Lpcrel_hi68+0xcc>
802024ea: 33 f6 15 01  	and	a2, a1, a7
802024ee: a1 81        	srli	a1, a1, 8
802024f0: b3 f5 15 01  	and	a1, a1, a7
802024f4: b2 95        	add	a1, a1, a2
802024f6: b3 85 05 03  	mul	a1, a1, a6
802024fa: c1 91        	srli	a1, a1, 48
802024fc: 2e 95        	add	a0, a0, a1
802024fe: 82 80        	ret

0000000080202500 <_ZN4core3ptr24drop_in_place$LT$i16$GT$17h7fb6220ebe559870E>:
80202500: 82 80        	ret

0000000080202502 <_ZN4core9panicking9panic_fmt17hcd61ef2f316f049fE>:
80202502: 79 71        	addi	sp, sp, -48

0000000080202504 <.Lpcrel_hi54>:
80202504: 17 16 00 00  	auipc	a2, 1
80202508: 13 06 c6 24  	addi	a2, a2, 588
8020250c: 32 e4        	sd	a2, 8(sp)

000000008020250e <.Lpcrel_hi55>:
8020250e: 17 16 00 00  	auipc	a2, 1
80202512: 13 06 26 24  	addi	a2, a2, 578
80202516: 32 e8        	sd	a2, 16(sp)
80202518: 2a ec        	sd	a0, 24(sp)
8020251a: 2e f0        	sd	a1, 32(sp)
8020251c: 05 45        	li	a0, 1
8020251e: 23 04 a1 02  	sb	a0, 40(sp)
80202522: 28 00        	addi	a0, sp, 8
80202524: 97 e0 ff ff  	auipc	ra, 1048574
80202528: e7 80 a0 af  	jalr	-1286(ra)
8020252c: 00 00        	unimp	

000000008020252e <_ZN4core9panicking5panic17hc478c8891ce16bc7E>:
8020252e: 39 71        	addi	sp, sp, -64
80202530: 2a f8        	sd	a0, 48(sp)
80202532: 2e fc        	sd	a1, 56(sp)
80202534: 08 18        	addi	a0, sp, 48
80202536: 2a e8        	sd	a0, 16(sp)
80202538: 05 45        	li	a0, 1
8020253a: 2a ec        	sd	a0, 24(sp)
8020253c: 02 e0        	sd	zero, 0(sp)

000000008020253e <.Lpcrel_hi58>:
8020253e: 17 15 00 00  	auipc	a0, 1
80202542: 13 05 25 21  	addi	a0, a0, 530
80202546: 2a f0        	sd	a0, 32(sp)
80202548: 02 f4        	sd	zero, 40(sp)
8020254a: 0a 85        	mv	a0, sp
8020254c: b2 85        	mv	a1, a2
8020254e: 97 00 00 00  	auipc	ra, 0
80202552: e7 80 40 fb  	jalr	-76(ra)
80202556: 00 00        	unimp	

0000000080202558 <_ZN4core3fmt3num3imp7fmt_u6417h3c65ff274501e9b5E.llvm.9772457815964904260>:
80202558: 79 71        	addi	sp, sp, -48
8020255a: 06 f4        	sd	ra, 40(sp)
8020255c: 32 88        	mv	a6, a2
8020255e: 93 56 45 00  	srli	a3, a0, 4
80202562: 13 0f 70 02  	li	t5, 39
80202566: 93 07 10 27  	li	a5, 625

000000008020256a <.Lpcrel_hi111>:
8020256a: 17 17 00 00  	auipc	a4, 1
8020256e: 93 0e 87 11  	addi	t4, a4, 280
80202572: 63 e3 f6 08  	bltu	a3, a5, 0x802025f8 <.Lpcrel_hi112+0x7a>
80202576: 13 0f 70 02  	li	t5, 39
8020257a: 93 07 61 02  	addi	a5, sp, 38

000000008020257e <.Lpcrel_hi112>:
8020257e: 97 26 00 00  	auipc	a3, 2
80202582: 83 b8 26 ae  	ld	a7, -1310(a3)
80202586: 89 66        	lui	a3, 2
80202588: 9b 82 06 71  	addiw	t0, a3, 1808
8020258c: 85 66        	lui	a3, 1
8020258e: 9b 83 b6 47  	addiw	t2, a3, 1147
80202592: 13 03 40 06  	li	t1, 100
80202596: b7 e6 f5 05  	lui	a3, 24414
8020259a: 1b 8e f6 0f  	addiw	t3, a3, 255
8020259e: aa 8f        	mv	t6, a0
802025a0: 33 35 15 03  	mulhu	a0, a0, a7
802025a4: 2d 81        	srli	a0, a0, 11
802025a6: 3b 07 55 02  	mulw	a4, a0, t0
802025aa: bb 86 ef 40  	subw	a3, t6, a4
802025ae: 13 97 06 03  	slli	a4, a3, 48
802025b2: 49 93        	srli	a4, a4, 50
802025b4: 33 07 77 02  	mul	a4, a4, t2
802025b8: 13 56 17 01  	srli	a2, a4, 17
802025bc: 41 83        	srli	a4, a4, 16
802025be: 13 77 e7 7f  	andi	a4, a4, 2046
802025c2: 3b 06 66 02  	mulw	a2, a2, t1
802025c6: 91 9e        	subw	a3, a3, a2
802025c8: 76 97        	add	a4, a4, t4
802025ca: 03 46 17 00  	lbu	a2, 1(a4)
802025ce: c6 16        	slli	a3, a3, 49
802025d0: c1 92        	srli	a3, a3, 48
802025d2: 03 47 07 00  	lbu	a4, 0(a4)
802025d6: a3 8f c7 fe  	sb	a2, -1(a5)
802025da: f6 96        	add	a3, a3, t4
802025dc: 03 c6 16 00  	lbu	a2, 1(a3)
802025e0: 83 c6 06 00  	lbu	a3, 0(a3)
802025e4: 71 1f        	addi	t5, t5, -4
802025e6: 23 8f e7 fe  	sb	a4, -2(a5)
802025ea: a3 80 c7 00  	sb	a2, 1(a5)
802025ee: 23 80 d7 00  	sb	a3, 0(a5)
802025f2: f1 17        	addi	a5, a5, -4
802025f4: e3 65 fe fb  	bltu	t3, t6, 0x8020259e <.Lpcrel_hi112+0x20>
802025f8: 93 06 30 06  	li	a3, 99
802025fc: 63 f0 a6 04  	bgeu	a3, a0, 0x8020263c <.Lpcrel_hi112+0xbe>
80202600: 13 16 05 03  	slli	a2, a0, 48
80202604: 49 92        	srli	a2, a2, 50
80202606: 85 66        	lui	a3, 1
80202608: 9b 86 b6 47  	addiw	a3, a3, 1147
8020260c: 33 06 d6 02  	mul	a2, a2, a3
80202610: 45 82        	srli	a2, a2, 17
80202612: 93 06 40 06  	li	a3, 100
80202616: bb 06 d6 02  	mulw	a3, a2, a3
8020261a: 15 9d        	subw	a0, a0, a3
8020261c: 46 15        	slli	a0, a0, 49
8020261e: 41 91        	srli	a0, a0, 48
80202620: 79 1f        	addi	t5, t5, -2
80202622: 76 95        	add	a0, a0, t4
80202624: 83 46 15 00  	lbu	a3, 1(a0)
80202628: 03 45 05 00  	lbu	a0, 0(a0)
8020262c: 13 07 11 00  	addi	a4, sp, 1
80202630: 7a 97        	add	a4, a4, t5
80202632: a3 00 d7 00  	sb	a3, 1(a4)
80202636: 23 00 a7 00  	sb	a0, 0(a4)
8020263a: 32 85        	mv	a0, a2
8020263c: 29 46        	li	a2, 10
8020263e: 63 7c c5 00  	bgeu	a0, a2, 0x80202656 <.Lpcrel_hi112+0xd8>
80202642: 13 06 ff ff  	addi	a2, t5, -1
80202646: 93 06 11 00  	addi	a3, sp, 1
8020264a: b2 96        	add	a3, a3, a2
8020264c: 1b 05 05 03  	addiw	a0, a0, 48
80202650: 23 80 a6 00  	sb	a0, 0(a3)
80202654: 05 a0        	j	0x80202674 <.Lpcrel_hi112+0xf6>
80202656: 06 05        	slli	a0, a0, 1
80202658: 13 06 ef ff  	addi	a2, t5, -2
8020265c: 76 95        	add	a0, a0, t4
8020265e: 83 46 15 00  	lbu	a3, 1(a0)
80202662: 03 45 05 00  	lbu	a0, 0(a0)
80202666: 13 07 11 00  	addi	a4, sp, 1
8020266a: 32 97        	add	a4, a4, a2
8020266c: a3 00 d7 00  	sb	a3, 1(a4)
80202670: 23 00 a7 00  	sb	a0, 0(a4)
80202674: 13 07 11 00  	addi	a4, sp, 1
80202678: 32 97        	add	a4, a4, a2
8020267a: 93 07 70 02  	li	a5, 39
8020267e: 91 8f        	sub	a5, a5, a2

0000000080202680 <.Lpcrel_hi113>:
80202680: 17 15 00 00  	auipc	a0, 1
80202684: 13 06 05 0f  	addi	a2, a0, 240
80202688: 42 85        	mv	a0, a6
8020268a: 81 46        	li	a3, 0
8020268c: 97 f0 ff ff  	auipc	ra, 1048575
80202690: e7 80 a0 7f  	jalr	2042(ra)
80202694: a2 70        	ld	ra, 40(sp)
80202696: 45 61        	addi	sp, sp, 48
80202698: 82 80        	ret

000000008020269a <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h304e6ff3608263d0E>:
8020269a: 03 65 05 00  	lwu	a0, 0(a0)
8020269e: 2e 86        	mv	a2, a1
802026a0: 85 45        	li	a1, 1
802026a2: 17 03 00 00  	auipc	t1, 0
802026a6: 67 00 63 eb  	jr	-330(t1)

00000000802026aa <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hacc2b83df35dadf6E>:
802026aa: 08 61        	ld	a0, 0(a0)
802026ac: 2e 86        	mv	a2, a1
802026ae: 85 45        	li	a1, 1
802026b0: 17 03 00 00  	auipc	t1, 0
802026b4: 67 00 83 ea  	jr	-344(t1)

00000000802026b8 <_ZN4core5slice5index26slice_start_index_len_fail17h703196df11f62172E>:
802026b8: 97 00 00 00  	auipc	ra, 0
802026bc: e7 80 a0 00  	jalr	10(ra)
802026c0: 00 00        	unimp	

00000000802026c2 <_ZN4core5slice5index29slice_start_index_len_fail_rt17h3c55ceb17a6bb735E>:
802026c2: 1d 71        	addi	sp, sp, -96
802026c4: 2a e0        	sd	a0, 0(sp)
802026c6: 2e e4        	sd	a1, 8(sp)
802026c8: 0a 85        	mv	a0, sp
802026ca: aa e0        	sd	a0, 64(sp)

00000000802026cc <.Lpcrel_hi37>:
802026cc: 17 05 00 00  	auipc	a0, 0
802026d0: 13 05 e5 fd  	addi	a0, a0, -34
802026d4: aa e4        	sd	a0, 72(sp)
802026d6: 2c 00        	addi	a1, sp, 8
802026d8: ae e8        	sd	a1, 80(sp)
802026da: aa ec        	sd	a0, 88(sp)

00000000802026dc <.Lpcrel_hi38>:
802026dc: 17 15 00 00  	auipc	a0, 1
802026e0: 13 05 c5 0c  	addi	a0, a0, 204
802026e4: 2a f0        	sd	a0, 32(sp)
802026e6: 09 45        	li	a0, 2
802026e8: 2a f4        	sd	a0, 40(sp)
802026ea: 02 e8        	sd	zero, 16(sp)
802026ec: 8c 00        	addi	a1, sp, 64
802026ee: 2e f8        	sd	a1, 48(sp)
802026f0: 2a fc        	sd	a0, 56(sp)
802026f2: 08 08        	addi	a0, sp, 16
802026f4: b2 85        	mv	a1, a2
802026f6: 97 00 00 00  	auipc	ra, 0
802026fa: e7 80 c0 e0  	jalr	-500(ra)
802026fe: 00 00        	unimp	

0000000080202700 <_ZN4core5slice5index24slice_end_index_len_fail17h4264373323b63fe1E>:
80202700: 97 00 00 00  	auipc	ra, 0
80202704: e7 80 a0 00  	jalr	10(ra)
80202708: 00 00        	unimp	

000000008020270a <_ZN4core5slice5index27slice_end_index_len_fail_rt17h8cf9dc1e3edc60e0E>:
8020270a: 1d 71        	addi	sp, sp, -96
8020270c: 2a e0        	sd	a0, 0(sp)
8020270e: 2e e4        	sd	a1, 8(sp)
80202710: 0a 85        	mv	a0, sp
80202712: aa e0        	sd	a0, 64(sp)

0000000080202714 <.Lpcrel_hi39>:
80202714: 17 05 00 00  	auipc	a0, 0
80202718: 13 05 65 f9  	addi	a0, a0, -106
8020271c: aa e4        	sd	a0, 72(sp)
8020271e: 2c 00        	addi	a1, sp, 8
80202720: ae e8        	sd	a1, 80(sp)
80202722: aa ec        	sd	a0, 88(sp)

0000000080202724 <.Lpcrel_hi40>:
80202724: 17 15 00 00  	auipc	a0, 1
80202728: 13 05 45 0b  	addi	a0, a0, 180
8020272c: 2a f0        	sd	a0, 32(sp)
8020272e: 09 45        	li	a0, 2
80202730: 2a f4        	sd	a0, 40(sp)
80202732: 02 e8        	sd	zero, 16(sp)
80202734: 8c 00        	addi	a1, sp, 64
80202736: 2e f8        	sd	a1, 48(sp)
80202738: 2a fc        	sd	a0, 56(sp)
8020273a: 08 08        	addi	a0, sp, 16
8020273c: b2 85        	mv	a1, a2
8020273e: 97 00 00 00  	auipc	ra, 0
80202742: e7 80 40 dc  	jalr	-572(ra)
80202746: 00 00        	unimp	

0000000080202748 <_ZN4core5slice5index22slice_index_order_fail17h4fd9f4354e6ea156E>:
80202748: 97 00 00 00  	auipc	ra, 0
8020274c: e7 80 a0 00  	jalr	10(ra)
80202750: 00 00        	unimp	

0000000080202752 <_ZN4core5slice5index25slice_index_order_fail_rt17h4ff9f1c55e7e69d6E>:
80202752: 1d 71        	addi	sp, sp, -96
80202754: 2a e0        	sd	a0, 0(sp)
80202756: 2e e4        	sd	a1, 8(sp)
80202758: 0a 85        	mv	a0, sp
8020275a: aa e0        	sd	a0, 64(sp)

000000008020275c <.Lpcrel_hi41>:
8020275c: 17 05 00 00  	auipc	a0, 0
80202760: 13 05 e5 f4  	addi	a0, a0, -178
80202764: aa e4        	sd	a0, 72(sp)
80202766: 2c 00        	addi	a1, sp, 8
80202768: ae e8        	sd	a1, 80(sp)
8020276a: aa ec        	sd	a0, 88(sp)

000000008020276c <.Lpcrel_hi42>:
8020276c: 17 15 00 00  	auipc	a0, 1
80202770: 13 05 45 0b  	addi	a0, a0, 180
80202774: 2a f0        	sd	a0, 32(sp)
80202776: 09 45        	li	a0, 2
80202778: 2a f4        	sd	a0, 40(sp)
8020277a: 02 e8        	sd	zero, 16(sp)
8020277c: 8c 00        	addi	a1, sp, 64
8020277e: 2e f8        	sd	a1, 48(sp)
80202780: 2a fc        	sd	a0, 56(sp)
80202782: 08 08        	addi	a0, sp, 16
80202784: b2 85        	mv	a1, a2
80202786: 97 00 00 00  	auipc	ra, 0
8020278a: e7 80 c0 d7  	jalr	-644(ra)
8020278e: 00 00        	unimp	

0000000080202790 <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h81117ebd8ec71482E>:
80202790: 17 25 00 00  	auipc	a0, 2
80202794: 03 35 05 90  	ld	a0, -1792(a0)
80202798: 82 80        	ret

000000008020279a <_ZN4core5panic10panic_info9PanicInfo7message17h112811ab923be2adE>:
8020279a: 08 69        	ld	a0, 16(a0)
8020279c: 82 80        	ret

000000008020279e <_ZN4core5panic10panic_info9PanicInfo8location17h1f2eae772c8f0dabE>:
8020279e: 08 6d        	ld	a0, 24(a0)
802027a0: 82 80        	ret

00000000802027a2 <_ZN4core6result13unwrap_failed17hebffbbf3544100c8E>:
802027a2: 59 71        	addi	sp, sp, -112
802027a4: 2a e0        	sd	a0, 0(sp)
802027a6: 2e e4        	sd	a1, 8(sp)
802027a8: 32 e8        	sd	a2, 16(sp)
802027aa: 36 ec        	sd	a3, 24(sp)
802027ac: 0a 85        	mv	a0, sp
802027ae: aa e8        	sd	a0, 80(sp)

00000000802027b0 <.Lpcrel_hi20>:
802027b0: 17 05 00 00  	auipc	a0, 0
802027b4: 13 05 65 bb  	addi	a0, a0, -1098
802027b8: aa ec        	sd	a0, 88(sp)
802027ba: 08 08        	addi	a0, sp, 16
802027bc: aa f0        	sd	a0, 96(sp)

00000000802027be <.Lpcrel_hi21>:
802027be: 17 05 00 00  	auipc	a0, 0
802027c2: 13 05 05 ba  	addi	a0, a0, -1120
802027c6: aa f4        	sd	a0, 104(sp)

00000000802027c8 <.Lpcrel_hi22>:
802027c8: 17 15 00 00  	auipc	a0, 1
802027cc: 13 05 05 08  	addi	a0, a0, 128
802027d0: 2a f8        	sd	a0, 48(sp)
802027d2: 09 45        	li	a0, 2
802027d4: 2a fc        	sd	a0, 56(sp)
802027d6: 02 f0        	sd	zero, 32(sp)
802027d8: 8c 08        	addi	a1, sp, 80
802027da: ae e0        	sd	a1, 64(sp)
802027dc: aa e4        	sd	a0, 72(sp)
802027de: 08 10        	addi	a0, sp, 32
802027e0: ba 85        	mv	a1, a4
802027e2: 97 00 00 00  	auipc	ra, 0
802027e6: e7 80 00 d2  	jalr	-736(ra)
802027ea: 00 00        	unimp	
