target:
	# Auto-compressed variants
	sspush		ra
	c.sspush	ra
	sspopchk	t0
	c.sspopchk	t0

	# All uncompressed forms (except XLEN-specific sslw/ssld)
	sspush		ra
	sspush		t0
	sspopchk	ra
	sspopchk	t0
	ssincp
	ssrdp		t0
	ssrdp		a0
