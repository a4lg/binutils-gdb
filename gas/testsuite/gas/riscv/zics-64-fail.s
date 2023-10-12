target:
	## Register-immediate addressing (with pre/post update)

	# Invalid loads on pre update and post update: rd == rs1
	# Note that L_INSN a0, (+a0) is omitted because
	# it will cause an accidental success (load from *symbol* a0).
	# L_INSN a0, (a0+) causes bad expression errors.
	lwu	a0, (a0+)
	lwu	a0, 60(+a0)
	lwu	a0, 60(a0+)
	ld	a0, (a0+)
	ld	a0, 120(+a0)
	ld	a0, 120(a0+)

	# Out of range
	lwu	a0, 64(+a1)
	lwu	a0, 64(a1+)
	lwu	a0, -68(+a1)
	lwu	a0, -68(a1+)
	ld	a0, 128(+a1)
	ld	a0, 128(a1+)
	ld	a0, -136(+a1)
	ld	a0, -136(a1+)
	sd	a0, 128(+a1)
	sd	a0, 128(a1+)
	sd	a0, -136(+a1)
	sd	a0, -136(a1+)

	# Unaligned
	lwu	a0, 2(+a1)
	lwu	a0, 2(a1+)
	lwu	a0, -2(+a1)
	lwu	a0, -2(a1+)
	ld	a0, 4(+a1)
	ld	a0, 4(a1+)
	ld	a0, -4(+a1)
	ld	a0, -4(a1+)
	sd	a0, 4(+a1)
	sd	a0, 4(a1+)
	sd	a0, -4(+a1)
	sd	a0, -4(a1+)


	## Register-register addressing (with optional pre/post update)

	# Invalid on pre update and post update: rd == rs1
	lwu	a0, a2(+a0)
	lwu	a0, a2(a0+)
	ld	a0, a2(+a0)
	ld	a0, a2(a0+)
	lwu	a0, [a2](+a0)
	lwu	a0, [a2](a0+)
	ld	a0, [a2](+a0)
	ld	a0, [a2](a0+)
