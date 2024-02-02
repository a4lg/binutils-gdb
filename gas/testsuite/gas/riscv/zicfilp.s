target:
	# lpad LPL == auipc x0, LPL
	lpad	0x12345
	auipc	zero, 0x12345

	# Break alignment:
	#
	# Unaligned lpad causes illegal-instruction exception
	# but must be disassembled (since alignment checking is a part of
	# the lpad instruction operations).
	c.nop

	lpad	0xf0123
	auipc	zero, 0xf0123
