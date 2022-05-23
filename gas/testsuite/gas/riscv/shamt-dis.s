target:
	# slli a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 1, a0, a1, 0x000 | 31
	.insn i	OP_IMM, 1, a0, a1, 0x000 | 32
	# srli a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 5, a0, a1, 0x000 | 31
	.insn i	OP_IMM, 5, a0, a1, 0x000 | 32
	# srai a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 5, a0, a1, 0x400 | 31
	.insn i	OP_IMM, 5, a0, a1, 0x400 | 32

	# RVC
	# c.slli a0,SHAMT [31/32]
	.insn ci	2, 0, a0, 31
	.insn ci	2, 0, a0, 32 - 0x40
	# Although c.sr[la]i are CB-format instructions,
	# encode them as CI-type for immediate consistency.
	# c.srli a0,SHAMT [31/32]
	.insn ci	1, 4, x2, 31
	.insn ci	1, 4, x2, 32 - 0x40
	# c.srai a0,SHAMT [31/32]
	.insn ci	1, 4, x10, 31
	.insn ci	1, 4, x10, 32 - 0x40

	# Zbb extension (or Zbkb)
	# rori a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 5, a0, a1, 0x600 | 31
	.insn i	OP_IMM, 5, a0, a1, 0x600 | 32

	# Zba extension
	# slli.uw a0,a1,SHAMT [31/32] (invalid on RV32)
	.insn i	OP_IMM_32, 1, a0, a1, 0x080 | 31
	.insn i	OP_IMM_32, 1, a0, a1, 0x080 | 32

	# Zbs extension
	# bclri a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 1, a0, a1, 0x480 | 31
	.insn i	OP_IMM, 1, a0, a1, 0x480 | 32
	# bseti a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 1, a0, a1, 0x280 | 31
	.insn i	OP_IMM, 1, a0, a1, 0x280 | 32
	# binvi a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 1, a0, a1, 0x680 | 31
	.insn i	OP_IMM, 1, a0, a1, 0x680 | 32
	# bexti a0,a1,SHAMT [31/32]
	.insn i	OP_IMM, 5, a0, a1, 0x480 | 31
	.insn i	OP_IMM, 5, a0, a1, 0x480 | 32
