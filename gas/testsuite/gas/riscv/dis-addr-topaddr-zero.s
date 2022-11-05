.ifge	XLEN-64
.set	topbase, 0xffffffff00000000
.else
.set	topbase, 0
.endif

.set	addr_top, topbase + 0xffffffff	# -1

target:
	# Use address relative to zero
	lb	t0, -1(zero)
