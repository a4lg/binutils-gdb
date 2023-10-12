	# WARNING: This is a tentative test case.
target:
	# Aligned instructions
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11011 << 15) # ld,  imm12==1
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11110 << 15) # lwu, imm12==1

	# Make it unaligned for lwu
	c.nop
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11110 << 15) # lwu, imm12==1

	# Test various alignments on ld
	c.nop
	c.nop
	c.nop
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11011 << 15) # ld,  imm12==1
	c.nop
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11011 << 15) # ld,  imm12==1
	c.nop
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11011 << 15) # ld,  imm12==1
	c.nop
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11011 << 15) # ld,  imm12==1
