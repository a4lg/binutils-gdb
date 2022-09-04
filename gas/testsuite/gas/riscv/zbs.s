target:
	bclri	a0, a1, 0
	bclri	a0, a1, 31
	bseti	a0, a1, 0
	bseti	a0, a1, 31
	binvi	a0, a1, 0
	binvi	a0, a1, 31
	bexti	a0, a1, 0
	bexti	a0, a1, 31
	bclr	a0, a1, a2
	bset	a0, a1, a2
	binv	a0, a1, a2
	bext	a0, a1, a2

	# Aliases
	bclr	a0, a1, 31
	bset	a0, a1, 31
	binv	a0, a1, 31
	bext	a0, a1, 31

.ifdef rv64
	bclri	a0, a1, 63
	bseti	a0, a1, 63
	binvi	a0, a1, 63
	bexti	a0, a1, 63

	# Aliases
	bclr	a0, a1, 63
	bset	a0, a1, 63
	binv	a0, a1, 63
	bext	a0, a1, 63
.endif
