target:
	# fcvt instructions (float-float; FP32 operand can be odd)
	fcvt.h.q	x16, x12
	fcvt.h.q	x17, x12
	fcvt.h.q	x16, x12, rne
	fcvt.h.q	x17, x12, rne
	fcvt.q.h	x12, x16
	fcvt.q.h	x12, x17
