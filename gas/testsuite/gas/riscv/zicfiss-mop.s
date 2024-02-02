target:
	# ssl[wd]  x1 == mop.r.0 x1, x0
	# ssl[wd]  x5 == mop.r.0 x5, x0
	# sspopchk x1 == mop.r.0 x0, x1
	# sspopchk x5 == mop.r.0 x0, x5
	mop.r.0		ra, zero
	mop.r.0		t0, zero
	mop.r.0		zero, ra
	mop.r.0		zero, t0

	# ssrdp    rd == mop.r.1 rd, x0 (rd != 0)
	mop.r.1		x31, zero

	# sspush   x1 == mop.rr.0 x0, x0, x1
	# sspush   x5 == mop.rr.0 x0, x0, x5
	mop.rr.0	zero, zero, ra
	mop.rr.0	zero, zero, t0

	# c.sspush   x1 == c.mop.0
	# c.ssincp      == c.mop.1
	# c.sspopchk x5 == c.mop.2
	c.mop.0
	c.mop.1
	c.mop.2
