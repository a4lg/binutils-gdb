target:
	# Shadow stack instructions
	sspush		x1
	sspush		x5
	sspop		x1
	sspop		x5
	ssprr		a0
	ssamoswap	a1, a2, a3
	ssamoswap	t0, a0, x0
	ssamoswap	a4, x0, a5
	sschkra		x5, x1
	sschkra		t0, ra
	# Landing pad instructions
	lpsll	0x000
	lpsll	0x1ff
	lpcll	0x000
	lpcll	0x1ff
	lpsml	0x00
	lpsml	0xff
	lpcml	0x00
	lpcml	0xff
	lpsul	0x00
	lpsul	0xff
	lpcul	0x00
	lpcul	0xff
