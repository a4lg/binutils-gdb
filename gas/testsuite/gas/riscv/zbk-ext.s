.include "testutils.inc"

target:
	SET_ARCH_START	+zbkb
	ror	a0, a1, a2
	rol	a0, a1, a2
	rori	a0, a1, 2
.if	XLEN_GE_64
	rorw	a0, a1, a2
	rolw	a0, a1, a2
	roriw	a0, a1, 2
.endif
	andn	a0, a1, a2
	orn	a0, a1, a2
	xnor	a0, a1, a2
	pack	a0, a1, a2
	packh	a0, a1, a2
.if	XLEN_GE_64
	packw	a0, a1, a2
.endif
	brev8	a0, a1
	rev8	a0, a1
.if	XLEN_EQ_32
	zip	a0, a1
	unzip	a0, a1
.endif
	SET_ARCH_END

	SET_ARCH_START	+zbkc
	clmul	a0, a1, a2
	clmulh	a0, a1, a2
	SET_ARCH_END

	SET_ARCH_START	+zbkx
	xperm4	a0, a1, a2
	xperm8	a0, a1, a2
	SET_ARCH_END
