target:
	## Additional conditional branches
	beqi	a0, 15, target
	beqi	a0, -16, .
	bnei	a0, 15, target
	bnei	a0, -16, .
