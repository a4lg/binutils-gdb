	# WARNING: This is a tentative test case.
target:
	# Aligned instructions
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11001 << 15) # lh,  imm12==1
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11101 << 15) # lhu, imm12==1
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # lw,  imm12==1

	# Make it unaligned for lw
	c.nop
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11001 << 15) # lh,  imm12==1
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11101 << 15) # lhu, imm12==1
	.insn	u LOAD, a0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # lw,  imm12==1
