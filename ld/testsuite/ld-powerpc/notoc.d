#source: notoc.s
#as: -a64
#ld: --no-plt-localentry --no-power10-stubs -T ext.lnk
#objdump: -d
#target: powerpc64*-*-*

.*

Disassembly of section \.text:

.* <.*\.long_branch\.f1>:
.*:	(18 00 41 f8|f8 41 00 18) 	std     r2,24\(r1\)
.*:	(7c 00 00 48|48 00 00 7c) 	b       .* <f1>

.* <.*\.long_branch\.g1>:
.*:	(18 00 41 f8|f8 41 00 18) 	std     r2,24\(r1\)
.*:	(8c 00 00 48|48 00 00 8c) 	b       .* <g1>
#...
.* <.*\.plt_branch\.ext>:
.*:	(a6 02 88 7d|7d 88 02 a6) 	mflr    r12
.*:	(05 00 9f 42|42 9f 00 05) 	bcl     .*
.*:	(a6 02 68 7d|7d 68 02 a6) 	mflr    r11
.*:	(a6 03 88 7d|7d 88 03 a6) 	mtlr    r12
.*:	(ff 7f 80 3d|3d 80 7f ff) 	lis     r12,32767
.*:	(ff ff 8c 61|61 8c ff ff) 	ori     r12,r12,65535
.*:	(c6 07 9c 79|79 9c 07 c6) 	sldi    r28,r12,32
.*:	(ff ef 8c 65|65 8c ef ff) 	oris    r12,r12,61439
.*:	(18 ff 8c 61|61 8c ff 18) 	ori     r12,r12,65304
.*:	(14 62 8b 7d|7d 8b 62 14) 	add     r12,r11,r12
.*:	(a6 03 89 7d|7d 89 03 a6) 	mtctr   r12
.*:	(20 04 80 4e|4e 80 04 20) 	bctr

.* <.*\.long_branch\.f2>:
.*:	(a6 02 88 7d|7d 88 02 a6) 	mflr    r12
.*:	(05 00 9f 42|42 9f 00 05) 	bcl     .*
.*:	(a6 02 68 7d|7d 68 02 a6) 	mflr    r11
.*:	(a6 03 88 7d|7d 88 03 a6) 	mtlr    r12
.*:	(54 00 8b 39|39 8b 00 54) 	addi    r12,r11,84
.*:	(.. .. 00 48|48 00 .. ..) 	b       .* <f2>

.* <.*\.long_branch\.g2>:
.*:	(a6 02 88 7d|7d 88 02 a6) 	mflr    r12
.*:	(05 00 9f 42|42 9f 00 05) 	bcl     .*
.*:	(a6 02 68 7d|7d 68 02 a6) 	mflr    r11
.*:	(a6 03 88 7d|7d 88 03 a6) 	mtlr    r12
.*:	(70 00 8b 39|39 8b 00 70) 	addi    r12,r11,112
.*:	(.. .. 00 48|48 00 .. ..) 	b       .* <g2>
#...
.* <f1>:
.*:	(01 00 00 48|48 00 00 01) 	bl      .* <f1>
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.f2>
.*:	(.. .. 00 48|48 00 .. ..) 	bl      .* <g1>
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.g2>
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.plt_branch\.ext>
.*:	(20 00 80 4e|4e 80 00 20) 	blr

.* <g1>:
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.f2>
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <f1>
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.g2>
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <g1>
.*:	(20 00 80 4e|4e 80 00 20) 	blr

.* <f2>:
.*:	(01 10 40 3c|3c 40 10 01) 	lis     r2,4097
.*:	(00 80 42 38|38 42 80 00) 	addi    r2,r2,-32768
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.f1>
.*:	(18 00 41 e8|e8 41 00 18) 	ld      r2,24\(r1\)
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <f2\+0x8>
.*:	(00 00 00 60|60 00 00 00) 	nop
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.g1>
.*:	(18 00 41 e8|e8 41 00 18) 	ld      r2,24\(r1\)
.*:	(.. .. 00 48|48 00 .. ..) 	bl      .* <g2\+0x8>
.*:	(00 00 00 60|60 00 00 00) 	nop
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.plt_branch\.ext>
.*:	(00 00 00 60|60 00 00 00) 	nop
.*:	(20 00 80 4e|4e 80 00 20) 	blr

.* <g2>:
.*:	(01 10 40 3c|3c 40 10 01) 	lis     r2,4097
.*:	(00 80 42 38|38 42 80 00) 	addi    r2,r2,-32768
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <f2\+0x8>
.*:	(00 00 00 60|60 00 00 00) 	nop
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.f1>
.*:	(18 00 41 e8|e8 41 00 18) 	ld      r2,24\(r1\)
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <g2\+0x8>
.*:	(00 00 00 60|60 00 00 00) 	nop
.*:	(.. .. ff 4b|4b ff .. ..) 	bl      .* <.*\.long_branch\.g1>
.*:	(18 00 41 e8|e8 41 00 18) 	ld      r2,24\(r1\)
.*:	(20 00 80 4e|4e 80 00 20) 	blr

.* <_start>:
.*:	(00 00 00 48|48 00 00 00) 	b       .* <_start>

Disassembly of section \.text\.ext:

8000000000000000 <ext>:
8000000000000000:	(01 10 40 3c|3c 40 10 01) 	lis     r2,4097
8000000000000004:	(00 80 42 38|38 42 80 00) 	addi    r2,r2,-32768
8000000000000008:	(00 00 00 60|60 00 00 00) 	nop
800000000000000c:	(20 00 80 4e|4e 80 00 20) 	blr
