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
