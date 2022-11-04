.include "testutils.inc"

target:
	nop
	# Architecture block: change disabled when NOARCH is defined.
	SET_ARCH_START	+c
	nop
	c.nop
	SET_ARCH_END
