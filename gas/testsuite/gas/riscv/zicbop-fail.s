target:
	# prefetch.[irw]: Invalid prefetch offsets
	#     (either lower 5-bits are not zero or outside I-type offset)
	prefetch.i	2048(x1)
	prefetch.r	-0x820(x16)
	prefetch.w	+0xff(x31)
