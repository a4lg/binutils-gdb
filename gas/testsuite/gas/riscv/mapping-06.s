	.text
	# F
	fadd.s	f10, f11, f12
	.option	push
	.option	arch, -f
	.option	arch, +zfinx
	# Zfinx
	fadd.s	x10, x11, x12
	.option	pop
	# F (reverted to default)
	fadd.s	f10, f11, f12
