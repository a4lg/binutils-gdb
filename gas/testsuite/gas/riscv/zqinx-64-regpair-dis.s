target:
	# fadd.q x2, x4, x6
	.insn r	OP_FP, 0x7, 0x03, x2, x4, x6
	# fadd.q x3, x5, x7 (invalid)
	.insn r	OP_FP, 0x7, 0x03, x3, x5, x7
