target:
	fcvt.d.s	ft1, ft2
	# Standard encoding:
	# - 2nd operand is the rounding mode (RNE [0b000] is preferred).
	# - 6th operand (additional function) is zero for FCVT.D.S.
	.insn r		OP_FP, 0x0, 0x21, ft1, ft2, f0
	# Non-standard encoding
	.insn r		OP_FP, 0x7, 0x21, ft1, ft2, f0
