target:
	# fadd.q x4, x8, x12
	.insn r	OP_FP, 0x7, 0x03, x4,  x8, x12
	# fadd.q x5, x9, x13 (invalid)
	.insn r	OP_FP, 0x7, 0x03, x5,  x9, x13
	# fadd.q x6, x10, x14 (invalid)
	.insn r	OP_FP, 0x7, 0x03, x6, x10, x14
