target:
	# sspush / sspop / ssprr: using x0 is not allowed.
	sspush	x0
	sspop	x0
	ssprr	x0

	# ssamoswap: using x0 to destination is not allowed.
	ssamoswap	x0, t1, t2

	# sschkra: only "sschkra x5, x1 (or t0, ra)" is allowed.
	sschkra	x0, x0
	sschkra	x1, x5
	sschkra	x31, x31

	# lp*: lplr.LL is 9-bit width, lplr.{ML,UL} are 8-bit width.
	lpsll	-1
	lpsll	0x200
	lpcll	-1
	lpcll	0x200
	lpsml	-1
	lpsml	0x100
	lpcml	-1
	lpcml	0x100
	lpsul	-1
	lpsul	0x100
	lpcul	-1
	lpcul	0x100
