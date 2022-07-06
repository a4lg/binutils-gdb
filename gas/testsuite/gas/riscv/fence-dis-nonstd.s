target:
	fence
	fence.tso
	# Standard encodings of fence and fence.tso
	.insn i	MISC_MEM, 0,  x0,  x0,  0x0ff
	.insn i	MISC_MEM, 0,  x0,  x0,  0x833-0x1000
	# Standard encoding of pause
	.insn i MISC_MEM, 0,  x0,  x0,  0x010
	# Non-standard encodings (regular, either RD or RS1 are non-zero)
	# Ignore unused bit fields.
	.insn i	MISC_MEM, 0, x31,  x0,  0x0cf
	.insn i	MISC_MEM, 0,  x0, x31,  0x0fc
	# Non-standard encodings (TSO, either RD or RS1 are non-zero)
	# Ignore unused bit fields for fence.tso.
	.insn i	MISC_MEM, 0, x31,  x0,  0x833-0x1000
	.insn i	MISC_MEM, 0,  x0, x31,  0x833-0x1000
	# Non-standard encoding (TSO, pred and succ are not defined)
	# Since fm+pred+succ is not defined, fallback to regular fence.
	.insn i	MISC_MEM, 0,  x0,  x0,  0x8ff-0x1000
	# Non-standard encoding (fm is reserved)
	# Fallback to regular fence.
	.insn i	MISC_MEM, 0,  x0,  x0,  0x133
