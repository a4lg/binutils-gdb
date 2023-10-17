target:
	# amocas.d (RV32): rd (operand 1) and rs2 (operand 2) must be even.
	amocas.d	a1, a4, (a3)
	amocas.d	a0, a5, (a3)
	amocas.d.aq	a1, a4, (a3)
	amocas.d.aq	a0, a5, (a3)
	amocas.d.rl	a1, a4, (a3)
	amocas.d.rl	a0, a5, (a3)
	amocas.d.aqrl	a1, a4, (a3)
	amocas.d.aqrl	a0, a5, (a3)
