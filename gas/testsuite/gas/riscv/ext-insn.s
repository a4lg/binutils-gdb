.include "testutils.inc"

.macro	INSN_SEQ
	zext.b	a0, a0		# andi (I)
	zext.h	a0, a0		# Zbb (RV32!=RV64) / shifts (I/C)
	sext.b	a0, a0		# Zbb / shifts (I/C)
	sext.h	a0, a0		# Zbb / shifts (I/C)
	zext.b	a1, a2		# andi (I)
	zext.h	a1, a2		# Zbb (RV32!=RV64) / shifts (I/C)
	sext.b	a1, a2		# Zbb / shifts (I/C)
	sext.h	a1, a2		# Zbb / shifts (I/C)
.if	XLEN_GE_64
	zext.w	a0, a0		# add.uw (RV64_Zba) / shifts (I/C)
	sext.w	a0, a0		# addiw (I) / c.addiw (C)
	zext.w	a1, a2		# add.uw (RV64_Zba) / shifts (I/C)
	sext.w	a1, a2		# addiw (I/C)
.endif
.endm

target:
	INSN_SEQ
	.option	arch, +c
	INSN_SEQ
