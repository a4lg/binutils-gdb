.include "testutils.inc"

target:
	SET_ARCH_START	+zba
	sh1add		a0, a1, a2
	sh2add		a0, a1, a2
	sh3add		a0, a1, a2
.if	XLEN_GE_64
	sh1add.uw	a0, a1, a2
	sh2add.uw	a0, a1, a2
	sh3add.uw	a0, a1, a2
	add.uw		a0, a1, a2
	slli.uw		a0, a1, 2
	zext.w		a0, a1		# Alias (has RVI macro)
.endif
	SET_ARCH_END

	SET_ARCH_START	+zbb
	clz		a0, a1
	ctz		a0, a1
	cpop		a0, a1
	min		a0, a1, a2
	minu		a0, a1, a2
	max		a0, a1, a2
	maxu		a0, a1, a2
	sext.b		a0, a1		# Has RVI macro
	sext.h		a0, a1		# Has RVI macro
	zext.h		a0, a1		# Has RVI macro
	andn		a0, a1, a2
	orn		a0, a1, a2
	xnor		a0, a1, a2
	rol		a0, a1, a2
	ror		a0, a1, a2
	rori		a0, a1, 2
	rev8		a0, a1
	orc.b		a0, a1
.if	XLEN_GE_64
	clzw		a0, a1
	ctzw		a0, a1
	cpopw		a0, a1
	rolw		a0, a1, a2
	rorw		a0, a1, a2
	roriw		a0, a1, 2
.endif
	ror		a0, a1, 2	# Alias
.if	XLEN_GE_64
	rorw		a0, a1, 2	# Alias
.endif
	SET_ARCH_END

	SET_ARCH_START	+zbc
	clmul		a0, a1, a2
	clmulh		a0, a1, a2
	clmulr		a0, a1, a2
	SET_ARCH_END

	SET_ARCH_START	+zbs
	bclri		a0, a1, 0
	bclri		a0, a1, 31
	bseti		a0, a1, 0
	bseti		a0, a1, 31
	binvi		a0, a1, 0
	binvi		a0, a1, 31
	bexti		a0, a1, 0
	bexti		a0, a1, 31
	bclr		a0, a1, a2
	bset		a0, a1, a2
	binv		a0, a1, a2
	bext		a0, a1, a2
	bclr		a0, a1, 31	# Alias
	bset		a0, a1, 31	# Alias
	binv		a0, a1, 31	# Alias
	bext		a0, a1, 31	# Alias
.if	XLEN_GE_64
	bclri		a0, a1, 63
	bseti		a0, a1, 63
	binvi		a0, a1, 63
	bexti		a0, a1, 63
	bclr		a0, a1, 63	# Alias
	bset		a0, a1, 63	# Alias
	binv		a0, a1, 63	# Alias
	bext		a0, a1, 63	# Alias
.endif
	SET_ARCH_END
