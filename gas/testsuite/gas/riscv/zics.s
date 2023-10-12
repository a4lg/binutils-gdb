target:
	## Additional conditional branches
	beqi	a0, 15, target
	beqi	a0, -16, .
	bnei	a0, 15, target
	bnei	a0, -16, .

	## Pair moves
	mvp0	a0,  a1,  t0, t1
	mvp0	x10, x11, t0, t1
	mvp2	a2,  a3,  t0, t1
	mvp2	x12, x13, t0, t1
