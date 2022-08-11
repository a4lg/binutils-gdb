	.section	.text1,  "ax", @progbits
	# (text1:0x0) Arch: default
	add	a0, a0, a1
	.option	push
	.option	arch, +c

	.section	.text2, "ax", @progbits
	# (text2:0x0) Arch: +c
	sub	a0, a0, a1
	.option	pop

	.section	.text1,  "ax", @progbits
	# (text1:0x4) Arch: default (no change)
	add	a0, a0, a1
	.option	push
	.option	arch, +c
	# (text1:0x8) Arch: +c
	add	a0, a0, a1

	.section	.text2, "ax", @progbits
	# (text2:0x2) Arch: +c (no change)
	sub	a0, a0, a1
	.option	arch, -c
	# (text2:0x4) Arch: +c-c (not default)
	sub	a0, a0, a1

	.section	.text1,  "ax", @progbits
	# (text1:0xa) Arch: +c-c (not default, changed from +c)
	add	a0, a0, a1
	.option	pop

	.section	.text2, "ax", @progbits
	# (text2:0x8) Arch: Default (changed from +c-c)
	sub	a0, a0, a1
