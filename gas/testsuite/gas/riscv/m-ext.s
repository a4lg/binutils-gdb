.include "testutils.inc"

target:
	SET_ARCH_START	+zmmul
	mul	a0, a1, a2
	mulh	a0, a1, a2
	mulhsu	a0, a1, a2
	mulhu	a0, a1, a2
	SET_ARCH_START	+m
	div	a0, a1, a2
	divu	a0, a1, a2
	rem	a0, a1, a2
	remu	a0, a1, a2
	SET_ARCH_END
	SET_ARCH_END
.if	XLEN_GE_64
	SET_ARCH_START	+zmmul
	mulw	a0, a1, a2
	SET_ARCH_START	+m
	divw	a0, a1, a2
	divuw	a0, a1, a2
	remw	a0, a1, a2
	remuw	a0, a1, a2
	SET_ARCH_END
	SET_ARCH_END
.endif
