target:
	# fcvt instructions (float-float; FP16 operand can be odd)
	fcvt.h.d	a0, a3
	fcvt.h.d	a1, a3
	fcvt.h.d	a0, a3, rne
	fcvt.h.d	a1, a3, rne
	fcvt.d.h	a3, a0
	fcvt.d.h	a3, a1
