	# WARNING: This is a tentative test case.
target:
	# Aligned instructions
	.insn	u LOAD_FP, fa0, (0b101 << 0) | (1 << 3) | (0b11010 << 15) # flh, imm12==1
	.insn	u LOAD_FP, fa0, (0b110 << 0) | (1 << 3) | (0b11010 << 15) # flw, imm12==1
	.insn	u LOAD_FP, fa0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # fld, imm12==1
	c.nop
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1

	# Make it unaligned for flw
	c.nop
	.insn	u LOAD_FP, fa0, (0b101 << 0) | (1 << 3) | (0b11010 << 15) # flh, imm12==1
	.insn	u LOAD_FP, fa0, (0b110 << 0) | (1 << 3) | (0b11010 << 15) # flw, imm12==1

	# Test various alignments on fld
	c.nop
	.insn	u LOAD_FP, fa0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # fld, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # fld, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # fld, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b111 << 0) | (1 << 3) | (0b11010 << 15) # fld, imm12==1

	# Test various alignments on flq
	c.nop
	c.nop
	c.nop
	c.nop
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
	c.nop
	.insn	u LOAD_FP, fa0, (0b000 << 0) | (1 << 3) | (0b11010 << 15) # flq, imm12==1
