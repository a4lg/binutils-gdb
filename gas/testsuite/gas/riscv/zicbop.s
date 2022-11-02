.include "testutils.inc"

target:
	SET_ARCH_START	+zicbop
	prefetch.i	(x1)
	prefetch.i	0x20(x1)
	prefetch.r	(x16)
	prefetch.r	-2048(x16)
	prefetch.w	(x31)
	prefetch.w	+0x7e0(x31)
	SET_ARCH_END
