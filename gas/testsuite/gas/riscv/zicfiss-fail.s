# Tested with RV32
target:
	# sspush / sspopchk / sslw: only x1 or x5 are allowed.
	sspush		x0
	sspush		x2
	sspush		x31
	sspopchk	x0
	sspopchk	x2
	sspopchk	x31
	sslw		x0
	sslw		x2
	sslw		x31

	# ssld: only available on RV64.
	ssld		x1
	ssld		x5

	# c.sspush x1 / c.sspopchk x5: all other GPRs are not allowed.
	c.sspush	x5
	c.sspopchk	x1
	c.sspush	x0
	c.sspush	x2
	c.sspush	x31
	c.sspopchk	x0
	c.sspopchk	x2
	c.sspopchk	x31

	# ssrdp: rd must not be x0.
	ssrdp		x0
