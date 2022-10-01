target:
	fsri	a0, a1, a3, -1
	fsri	a0, a1, a3, 64	# imm6u (shamtd)
	wexti	a0, a2, -1
	wexti	a0, a2, 32	# imm5u
