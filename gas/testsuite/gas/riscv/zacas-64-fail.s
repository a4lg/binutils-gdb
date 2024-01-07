target:
	# amocas.q (RV64): rd (operand 1) and rs2 (operand 2) must be even.
	amocas.q	a1, a4, (a3)
	amocas.q	a0, a5, (a3)
	amocas.q.aq	a1, a4, (a3)
	amocas.q.aq	a0, a5, (a3)
	amocas.q.rl	a1, a4, (a3)
	amocas.q.rl	a0, a5, (a3)
	amocas.q.aqrl	a1, a4, (a3)
	amocas.q.aqrl	a0, a5, (a3)
