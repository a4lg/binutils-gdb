	.text
	# F
	fadd.s	f10, f11, f12
	.option	arch, -f
	.option	arch, +zfinx
	# Zfinx
	fadd.s	x10, x11, x12
	.option	arch, -zfinx
	.option	arch, +f
	# F (RV32IF -F +Zfinx -Zfinx +F)
	fadd.s	f10, f11, f12
