target:
	# fcvt instructions (float-float; FP32 operand can be odd)
	fcvt.h.q	x12, x14
	fcvt.h.q	x13, x14
	fcvt.h.q	x12, x14, rne
	fcvt.h.q	x13, x14, rne
	fcvt.q.h	x14, x12
	fcvt.q.h	x14, x13
