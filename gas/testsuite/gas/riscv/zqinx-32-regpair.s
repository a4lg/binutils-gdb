target:
	fadd.q	x4, x8, x12
	fsub.q	x4, x8, x12
	fmul.q	x4, x8, x12
	fdiv.q	x4, x8, x12
	fsqrt.q	x4, x8
	fmin.q	x4, x8, x12
	fmax.q	x4, x8, x12
	fmadd.q	x4, x8, x12, x16
	fnmadd.q	x4, x8, x12, x16
	fmsub.q	x4, x8, x12, x16
	fnmsub.q	x4, x8, x12, x16
	fsgnj.q	x4, x8, x12
	fsgnjn.q	x4, x8, x12
	fsgnjx.q	x4, x8, x12
	fmv.q	x4, x8
	fneg.q	x4, x8
	fabs.q	x4, x8
	# Compare instructions: destination is a GPR
	feq.q	x4, x8, x12
	feq.q	x5, x8, x12
	feq.q	x6, x8, x12
	flt.q	x4, x8, x12
	flt.q	x5, x8, x12
	flt.q	x6, x8, x12
	fle.q	x4, x8, x12
	fle.q	x5, x8, x12
	fle.q	x6, x8, x12
	fgt.q	x4, x8, x12
	fgt.q	x5, x8, x12
	fgt.q	x6, x8, x12
	fge.q	x4, x8, x12
	fge.q	x5, x8, x12
	fge.q	x6, x8, x12
	# fclass instruction: destination is a GPR
	fclass.q	x4, x8
	fclass.q	x5, x8
	fclass.q	x6, x8
	# fcvt instructions (float-int or int-float;
	#                    integer operand register can be any)
	fcvt.w.q	x4, x8
	fcvt.w.q	x5, x8
	fcvt.w.q	x6, x8
	fcvt.wu.q	x4, x8
	fcvt.wu.q	x5, x8
	fcvt.wu.q	x6, x8
	fcvt.q.w	x8, x4
	fcvt.q.w	x8, x5
	fcvt.q.w	x8, x6
	fcvt.q.wu	x8, x4
	fcvt.q.wu	x8, x5
	fcvt.q.wu	x8, x6
	# fcvt instructions (float-float; FP32 operand can be any,
	#                    FP64 operand can be (x%4)==2)
	fcvt.s.q	x4, x8
	fcvt.s.q	x5, x8
	fcvt.s.q	x6, x8
	fcvt.d.q	x4, x8
	fcvt.d.q	x6, x8
	fcvt.q.s	x8, x4
	fcvt.q.s	x8, x5
	fcvt.q.s	x8, x6
	fcvt.q.d	x8, x4
	fcvt.q.d	x8, x6
