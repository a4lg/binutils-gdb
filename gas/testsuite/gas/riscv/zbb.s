target:
	clz	a0, a0
	ctz	a0, a0
	cpop	a0, a0
	min	a0, a1, a2
	minu	a0, a1, a2
	max	a0, a1, a2
	maxu	a0, a1, a2
	sext.b	a0, a0
	sext.h	a0, a0
	zext.h	a0, a0
	andn	a0, a1, a2
	orn	a0, a1, a2
	xnor	a0, a1, a2
	rol	a0, a1, a2
	ror	a0, a1, a2
	rori	a0, a1, 2
	rev8	a0, a0
	orc.b	a0, a0

.ifdef rv64
	clzw	a0, a0
	ctzw	a0, a0
	cpopw	a0, a0
	rolw	a0, a1, a2
	rorw	a0, a1, a2
	roriw	a0, a1, 2
.endif

	# Aliases
	ror	a0, a1, 2
.ifdef rv64
	rorw	a0, a1, 2
.endif
