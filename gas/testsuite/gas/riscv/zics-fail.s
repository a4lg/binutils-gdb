target:
	## Additional conditional branches

	# Out of range
	beqi	a0, 16, target
	beqi	a0, -17, target
	bnei	a0, 16, target
	bnei	a0, -17, target
