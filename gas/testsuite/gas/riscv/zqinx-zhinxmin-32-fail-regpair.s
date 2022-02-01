target:
	# fcvt instructions (float-float; FP16 operand can be odd)
	fcvt.h.q	x16, x13
	fcvt.h.q	x17, x13
	fcvt.h.q	x18, x13
	fcvt.h.q	x16, x14
	fcvt.h.q	x17, x14
	fcvt.h.q	x18, x14
	fcvt.h.q	x16, x13, rne
	fcvt.h.q	x17, x13, rne
	fcvt.h.q	x18, x13, rne
	fcvt.h.q	x16, x14, rne
	fcvt.h.q	x17, x14, rne
	fcvt.h.q	x18, x14, rne
	fcvt.q.h	x13, x16
	fcvt.q.h	x13, x17
	fcvt.q.h	x13, x18
	fcvt.q.h	x14, x16
	fcvt.q.h	x14, x17
	fcvt.q.h	x14, x18
