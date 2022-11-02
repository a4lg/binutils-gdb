.include "testutils.inc"
target:
	# prefetch.i offset(rs1) == ori x0, rs1, offset+0
	# prefetch.r offset(rs1) == ori x0, rs1, offset+1
	# prefetch.w offset(rs1) == ori x0, rs1, offset+3
	# low 5-bits of "offset" must be zero.
	SET_ARCH_START	+zicbop
	prefetch.i	(x1)
	prefetch.i	0x20(x1)
	prefetch.r	(x16)
	prefetch.r	-2048(x16)
	prefetch.w	(x31)
	prefetch.w	+0x7e0(x31)
	SET_ARCH_END
