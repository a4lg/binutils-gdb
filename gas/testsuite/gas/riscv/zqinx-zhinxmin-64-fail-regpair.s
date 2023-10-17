target:
	# fcvt instructions (float-float; FP16 operand can be odd)
	fcvt.h.q	x16, x13
	fcvt.h.q	x17, x13
	fcvt.h.q	x16, x13, rne
	fcvt.h.q	x17, x13, rne
	fcvt.q.h	x13, x16
	fcvt.q.h	x13, x17
