target:
	fence.i
	# Standard encoding of fence.i
	.insn i	MISC_MEM, 1,  x0,  x0,  0
	# Following are non-standard encodings
	.insn i	MISC_MEM, 1, x31,  x0,  0
	.insn i	MISC_MEM, 1,  x0, x31,  0
	.insn i	MISC_MEM, 1,  x0,  x0, -1
