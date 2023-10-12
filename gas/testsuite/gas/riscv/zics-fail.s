target:
	## Additional conditional branches

	# Out of range
	beqi	a0, 16, target
	beqi	a0, -17, target
	bnei	a0, 16, target
	bnei	a0, -17, target


	## Pair moves

	# Invalid first and second operands
	mvp0	gp, a1, t0, t1
	mvp0	a0, gp, t0, t1
	mvp2	gp, a3, t0, t1
	mvp2	a2, gp, t0, t1

	# Invalid rs2 values
	# (TODO: undefined but not illegal? then we may accept those)
	mvp0	a0, a1, t0, a0
	mvp0	a0, a1, t0, x10
	mvp2	a2, a3, t0, a2
	mvp2	a2, a3, t0, x12


	## Register-immediate addressing (with pre/post update)

	# Invalid loads on pre update and post update: rd == rs1
	# Note that L_INSN a0, (+a0) is omitted because
	# it will cause an accidental success (load from *symbol* a0).
	# L_INSN a0, (a0+) causes bad expression errors.
	lb	a0, (a0+)
	lb	a0, 15(+a0)
	lb	a0, 15(a0+)
	lbu	a0, (a0+)
	lbu	a0, 15(+a0)
	lbu	a0, 15(a0+)
	lh	a0, (a0+)
	lh	a0, 30(+a0)
	lh	a0, 30(a0+)
	lhu	a0, (a0+)
	lhu	a0, 30(+a0)
	lhu	a0, 30(a0+)
	lw	a0, (a0+)
	lw	a0, 60(+a0)
	lw	a0, 60(a0+)

	# Out of range
	lb	a0, 16(+a1)
	lb	a0, 16(a1+)
	lb	a0, -17(+a1)
	lb	a0, -17(a1+)
	lbu	a0, 16(+a1)
	lbu	a0, 16(a1+)
	lbu	a0, -17(+a1)
	lbu	a0, -17(a1+)
	lh	a0, 32(+a1)
	lh	a0, 32(a1+)
	lh	a0, -34(+a1)
	lh	a0, -34(a1+)
	lhu	a0, 32(+a1)
	lhu	a0, 32(a1+)
	lhu	a0, -34(+a1)
	lhu	a0, -34(a1+)
	lw	a0, 64(+a1)
	lw	a0, 64(a1+)
	lw	a0, -68(+a1)
	lw	a0, -68(a1+)
	sb	a0, 16(+a1)
	sb	a0, 16(a1+)
	sb	a0, -17(+a1)
	sb	a0, -17(a1+)
	sh	a0, 32(+a1)
	sh	a0, 32(a1+)
	sh	a0, -34(+a1)
	sh	a0, -34(a1+)
	sw	a0, 64(+a1)
	sw	a0, 64(a1+)
	sw	a0, -68(+a1)
	sw	a0, -68(a1+)

	# Unaligned
	lh	a0, 1(+a1)
	lh	a0, 1(a1+)
	lh	a0, -1(+a1)
	lh	a0, -1(a1+)
	lhu	a0, 1(+a1)
	lhu	a0, 1(a1+)
	lhu	a0, -1(+a1)
	lhu	a0, -1(a1+)
	lw	a0, 2(+a1)
	lw	a0, 2(a1+)
	lw	a0, -2(+a1)
	lw	a0, -2(a1+)
	sh	a0, 1(+a1)
	sh	a0, 1(a1+)
	sh	a0, -1(+a1)
	sh	a0, -1(a1+)
	sw	a0, 2(+a1)
	sw	a0, 2(a1+)
	sw	a0, -2(+a1)
	sw	a0, -2(a1+)


	## Register-register addressing (with optional pre/post update)

	# Invalid on pre update and post update: rd == rs1
	lb	a0, a2(+a0)
	lb	a0, a2(a0+)
	lbu	a0, a2(+a0)
	lbu	a0, a2(a0+)
	lh	a0, a2(+a0)
	lh	a0, a2(a0+)
	lhu	a0, a2(+a0)
	lhu	a0, a2(a0+)
	lw	a0, a2(+a0)
	lw	a0, a2(a0+)
	lh	a0, [a2](+a0)
	lh	a0, [a2](a0+)
	lhu	a0, [a2](+a0)
	lhu	a0, [a2](a0+)
	lw	a0, [a2](+a0)
	lw	a0, [a2](a0+)
