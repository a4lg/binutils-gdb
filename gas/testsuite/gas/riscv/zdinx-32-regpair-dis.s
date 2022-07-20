target:
	# fadd.d x2, x4, x6
	.insn r	OP_FP, 0x7, 0x01, x2, x4, x6
	# fadd.d x3, x5, x7 (invalid)
	.insn r	OP_FP, 0x7, 0x01, x3, x5, x7
