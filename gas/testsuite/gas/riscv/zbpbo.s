target:
	pack	a0, a1, a2
	packu	a0, a1, a2
	max	a0, a1, a2
	min	a0, a1, a2
	rev8.h	a0, a1
	cmix	a0, a2, a1, a3
	rev	a0, a1
.ifdef rv32
	clz	a0, a1
	fsr	a0, a1, a3, a2
	fsri	a0, a1, a3, 0
	fsri	a0, a1, a3, 63
.endif
.ifdef rv64
	fsrw	a0, a1, a3, a2
.endif

	# Aliases
	bpick	a0, a1, a3, a2
	swap8	a0, a1
.ifdef rv32
	wexti	a0, a2, 0
	wexti	a0, a2, 31
	fsri	a0, a2, a3, 0x3f	# Non-alias
.endif
