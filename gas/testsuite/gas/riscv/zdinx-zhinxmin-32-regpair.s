target:
	# fcvt instructions (float-float; FP32 operand can be odd)
	fcvt.h.d	a0, a2
	fcvt.h.d	a1, a2
	fcvt.h.d	a0, a2, rne
	fcvt.h.d	a1, a2, rne
	fcvt.d.h	a2, a0
	fcvt.d.h	a2, a1
