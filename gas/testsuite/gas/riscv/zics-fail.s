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


	## Pair load/stores

	# Invalid on loads: rs1 == rs2
	lbp	a0, a0, (sp)
	lbp	a0, a0, (+sp)
	lbp	a0, a0, (sp+)
	lbup	a0, a0, (sp)
	lbup	a0, a0, (+sp)
	lbup	a0, a0, (sp+)
	lhp	a0, a0, (sp)
	lhp	a0, a0, (+sp)
	lhp	a0, a0, (sp+)
	lhup	a0, a0, (sp)
	lhup	a0, a0, (+sp)
	lhup	a0, a0, (sp+)
	lwp	a0, a0, (sp)
	lwp	a0, a0, (+sp)
	lwp	a0, a0, (sp+)

	# Invalid on loads with SP update: rs1 == sp
	lbp	sp, a0, (+sp)
	lbp	sp, a0, (sp+)
	lbup	sp, a0, (+sp)
	lbup	sp, a0, (sp+)
	lhp	sp, a0, (+sp)
	lhp	sp, a0, (sp+)
	lhup	sp, a0, (+sp)
	lhup	sp, a0, (sp+)
	lwp	sp, a0, (+sp)
	lwp	sp, a0, (sp+)

	# Invalid on loads with SP update: rs2 == sp
	lbp	a0, sp, (+sp)
	lbp	a0, sp, (sp+)
	lbup	a0, sp, (+sp)
	lbup	a0, sp, (sp+)
	lhp	a0, sp, (+sp)
	lhp	a0, sp, (sp+)
	lhup	a0, sp, (+sp)
	lhup	a0, sp, (sp+)
	lwp	a0, sp, (+sp)
	lwp	a0, sp, (sp+)

	# Out of range
	lbp	a0, a1, 16(sp)
	lbp	a0, a1, 16(+sp)
	lbp	a0, a1, 16(sp+)
	lbp	a0, a1, -17(sp)
	lbp	a0, a1, -17(+sp)
	lbp	a0, a1, -17(sp+)
	lbup	a0, a1, 16(sp)
	lbup	a0, a1, 16(+sp)
	lbup	a0, a1, 16(sp+)
	lbup	a0, a1, -17(sp)
	lbup	a0, a1, -17(+sp)
	lbup	a0, a1, -17(sp+)
	lhp	a0, a1, 32(sp)
	lhp	a0, a1, 32(+sp)
	lhp	a0, a1, 32(sp+)
	lhp	a0, a1, -34(sp)
	lhp	a0, a1, -34(+sp)
	lhp	a0, a1, -34(sp+)
	lhup	a0, a1, 32(sp)
	lhup	a0, a1, 32(+sp)
	lhup	a0, a1, 32(sp+)
	lhup	a0, a1, -34(sp)
	lhup	a0, a1, -34(+sp)
	lhup	a0, a1, -34(sp+)
	lwp	a0, a1, 64(sp)
	lwp	a0, a1, 64(+sp)
	lwp	a0, a1, 64(sp+)
	lwp	a0, a1, -68(sp)
	lwp	a0, a1, -68(+sp)
	lwp	a0, a1, -68(sp+)
	sbp	a0, a1, 16(sp)
	sbp	a0, a1, 16(+sp)
	sbp	a0, a1, 16(sp+)
	sbp	a0, a1, -17(sp)
	sbp	a0, a1, -17(+sp)
	sbp	a0, a1, -17(sp+)
	shp	a0, a1, 32(sp)
	shp	a0, a1, 32(+sp)
	shp	a0, a1, 32(sp+)
	shp	a0, a1, -34(sp)
	shp	a0, a1, -34(+sp)
	shp	a0, a1, -34(sp+)
	swp	a0, a1, 64(sp)
	swp	a0, a1, 64(+sp)
	swp	a0, a1, 64(sp+)
	swp	a0, a1, -68(sp)
	swp	a0, a1, -68(+sp)
	swp	a0, a1, -68(sp+)

	# Unaligned
	lhp	a0, a1, 1(sp)
	lhp	a0, a1, 1(+sp)
	lhp	a0, a1, 1(sp+)
	lhp	a0, a1, -1(sp)
	lhp	a0, a1, -1(+sp)
	lhp	a0, a1, -1(sp+)
	lhup	a0, a1, 1(sp)
	lhup	a0, a1, 1(+sp)
	lhup	a0, a1, 1(sp+)
	lhup	a0, a1, -1(sp)
	lhup	a0, a1, -1(+sp)
	lhup	a0, a1, -1(sp+)
	lwp	a0, a1, 2(sp)
	lwp	a0, a1, 2(+sp)
	lwp	a0, a1, 2(sp+)
	lwp	a0, a1, -2(sp)
	lwp	a0, a1, -2(+sp)
	lwp	a0, a1, -2(sp+)
	shp	a0, a1, 1(sp)
	shp	a0, a1, 1(+sp)
	shp	a0, a1, 1(sp+)
	shp	a0, a1, -1(sp)
	shp	a0, a1, -1(+sp)
	shp	a0, a1, -1(sp+)
	swp	a0, a1, 2(sp)
	swp	a0, a1, 2(+sp)
	swp	a0, a1, 2(sp+)
	swp	a0, a1, -2(sp)
	swp	a0, a1, -2(+sp)
	swp	a0, a1, -2(sp+)
