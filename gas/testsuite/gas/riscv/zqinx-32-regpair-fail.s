target:
	fadd.q	x5, x8, x12
	fadd.q	x5, x8, x12, rne
	fadd.q	x6, x8, x12
	fadd.q	x6, x8, x12, rne
	fadd.q	x4, x5, x12
	fadd.q	x4, x5, x12, rne
	fadd.q	x4, x6, x12
	fadd.q	x4, x6, x12, rne
	fadd.q	x4, x8, x5
	fadd.q	x4, x8, x5, rne
	fadd.q	x4, x8, x6
	fadd.q	x4, x8, x6, rne
	fsub.q	x5, x8, x12
	fsub.q	x5, x8, x12, rne
	fsub.q	x6, x8, x12
	fsub.q	x6, x8, x12, rne
	fsub.q	x4, x5, x12
	fsub.q	x4, x5, x12, rne
	fsub.q	x4, x6, x12
	fsub.q	x4, x6, x12, rne
	fsub.q	x4, x8, x5
	fsub.q	x4, x8, x5, rne
	fsub.q	x4, x8, x6
	fsub.q	x4, x8, x6, rne
	fmul.q	x5, x8, x12
	fmul.q	x5, x8, x12, rne
	fmul.q	x6, x8, x12
	fmul.q	x6, x8, x12, rne
	fmul.q	x4, x5, x12
	fmul.q	x4, x5, x12, rne
	fmul.q	x4, x6, x12
	fmul.q	x4, x6, x12, rne
	fmul.q	x4, x8, x5
	fmul.q	x4, x8, x5, rne
	fmul.q	x4, x8, x6
	fmul.q	x4, x8, x6, rne
	fdiv.q	x5, x8, x12
	fdiv.q	x5, x8, x12, rne
	fdiv.q	x6, x8, x12
	fdiv.q	x6, x8, x12, rne
	fdiv.q	x4, x5, x12
	fdiv.q	x4, x5, x12, rne
	fdiv.q	x4, x6, x12
	fdiv.q	x4, x6, x12, rne
	fdiv.q	x4, x8, x5
	fdiv.q	x4, x8, x5, rne
	fdiv.q	x4, x8, x6
	fdiv.q	x4, x8, x6, rne
	fsqrt.q	x5, x8
	fsqrt.q	x5, x8, rne
	fsqrt.q	x6, x8
	fsqrt.q	x6, x8, rne
	fsqrt.q	x4, x5
	fsqrt.q	x4, x5, rne
	fsqrt.q	x4, x6
	fsqrt.q	x4, x6, rne
	fmin.q	x5, x8, x12
	fmin.q	x6, x8, x12
	fmin.q	x4, x5, x12
	fmin.q	x4, x6, x12
	fmin.q	x4, x8, x5
	fmin.q	x4, x8, x6
	fmax.q	x5, x8, x12
	fmax.q	x6, x8, x12
	fmax.q	x4, x5, x12
	fmax.q	x4, x6, x12
	fmax.q	x4, x8, x5
	fmax.q	x4, x8, x6
	fmadd.q	x5, x8, x12, x16
	fmadd.q	x5, x8, x12, x16, rne
	fmadd.q	x6, x8, x12, x16
	fmadd.q	x6, x8, x12, x16, rne
	fmadd.q	x4, x5, x12, x16
	fmadd.q	x4, x5, x12, x16, rne
	fmadd.q	x4, x6, x12, x16
	fmadd.q	x4, x6, x12, x16, rne
	fmadd.q	x4, x8, x5, x16
	fmadd.q	x4, x8, x5, x16, rne
	fmadd.q	x4, x8, x6, x16
	fmadd.q	x4, x8, x6, x16, rne
	fmadd.q	x4, x8, x12, x5
	fmadd.q	x4, x8, x12, x5, rne
	fmadd.q	x4, x8, x12, x6
	fmadd.q	x4, x8, x12, x6, rne
	fnmadd.q	x5, x8, x12, x16
	fnmadd.q	x5, x8, x12, x16, rne
	fnmadd.q	x6, x8, x12, x16
	fnmadd.q	x6, x8, x12, x16, rne
	fnmadd.q	x4, x5, x12, x16
	fnmadd.q	x4, x5, x12, x16, rne
	fnmadd.q	x4, x6, x12, x16
	fnmadd.q	x4, x6, x12, x16, rne
	fnmadd.q	x4, x8, x5, x16
	fnmadd.q	x4, x8, x5, x16, rne
	fnmadd.q	x4, x8, x6, x16
	fnmadd.q	x4, x8, x6, x16, rne
	fnmadd.q	x4, x8, x12, x5
	fnmadd.q	x4, x8, x12, x5, rne
	fnmadd.q	x4, x8, x12, x6
	fnmadd.q	x4, x8, x12, x6, rne
	fmsub.q	x5, x8, x12, x16
	fmsub.q	x5, x8, x12, x16, rne
	fmsub.q	x6, x8, x12, x16
	fmsub.q	x6, x8, x12, x16, rne
	fmsub.q	x4, x5, x12, x16
	fmsub.q	x4, x5, x12, x16, rne
	fmsub.q	x4, x6, x12, x16
	fmsub.q	x4, x6, x12, x16, rne
	fmsub.q	x4, x8, x5, x16
	fmsub.q	x4, x8, x5, x16, rne
	fmsub.q	x4, x8, x6, x16
	fmsub.q	x4, x8, x6, x16, rne
	fmsub.q	x4, x8, x12, x5
	fmsub.q	x4, x8, x12, x5, rne
	fmsub.q	x4, x8, x12, x6
	fmsub.q	x4, x8, x12, x6, rne
	fnmsub.q	x5, x8, x12, x16
	fnmsub.q	x5, x8, x12, x16, rne
	fnmsub.q	x6, x8, x12, x16
	fnmsub.q	x6, x8, x12, x16, rne
	fnmsub.q	x4, x5, x12, x16
	fnmsub.q	x4, x5, x12, x16, rne
	fnmsub.q	x4, x6, x12, x16
	fnmsub.q	x4, x6, x12, x16, rne
	fnmsub.q	x4, x8, x5, x16
	fnmsub.q	x4, x8, x5, x16, rne
	fnmsub.q	x4, x8, x6, x16
	fnmsub.q	x4, x8, x6, x16, rne
	fnmsub.q	x4, x8, x12, x5
	fnmsub.q	x4, x8, x12, x5, rne
	fnmsub.q	x4, x8, x12, x6
	fnmsub.q	x4, x8, x12, x6, rne
	fsgnj.q	x5, x8, x12
	fsgnj.q	x6, x8, x12
	fsgnj.q	x4, x5, x12
	fsgnj.q	x4, x6, x12
	fsgnj.q	x4, x8, x5
	fsgnj.q	x4, x8, x6
	fsgnjn.q	x5, x8, x12
	fsgnjn.q	x6, x8, x12
	fsgnjn.q	x4, x5, x12
	fsgnjn.q	x4, x6, x12
	fsgnjn.q	x4, x8, x5
	fsgnjn.q	x4, x8, x6
	fsgnjx.q	x5, x8, x12
	fsgnjx.q	x6, x8, x12
	fsgnjx.q	x4, x5, x12
	fsgnjx.q	x4, x6, x12
	fsgnjx.q	x4, x8, x5
	fsgnjx.q	x4, x8, x6
	fmv.q	x5, x8
	fmv.q	x6, x8
	fmv.q	x4, x5
	fmv.q	x4, x6
	fneg.q	x5, x8
	fneg.q	x6, x8
	fneg.q	x4, x5
	fneg.q	x4, x6
	fabs.q	x5, x8
	fabs.q	x6, x8
	fabs.q	x4, x5
	fabs.q	x4, x6
	# Compare instructions: destination is a GPR
	feq.q	x4, x5, x12
	feq.q	x4, x6, x12
	feq.q	x4, x8, x5
	feq.q	x4, x8, x6
	flt.q	x4, x5, x12
	flt.q	x4, x6, x12
	flt.q	x4, x8, x5
	flt.q	x4, x8, x6
	fle.q	x4, x5, x12
	fle.q	x4, x6, x12
	fle.q	x4, x8, x5
	fle.q	x4, x8, x6
	fgt.q	x4, x5, x12
	fgt.q	x4, x6, x12
	fgt.q	x4, x8, x5
	fgt.q	x4, x8, x6
	fge.q	x4, x5, x12
	fge.q	x4, x6, x12
	fge.q	x4, x8, x5
	fge.q	x4, x8, x6
	# fclass instruction: destination is a GPR
	fclass.q	x4, x5
	fclass.q	x4, x6
	# fcvt instructions (float-int or int-float;
	#                    integer operand register can be any)
	fcvt.w.q	x4, x5
	fcvt.w.q	x4, x5, rne
	fcvt.w.q	x4, x6
	fcvt.w.q	x4, x6, rne
	fcvt.wu.q	x4, x5
	fcvt.wu.q	x4, x5, rne
	fcvt.wu.q	x4, x6
	fcvt.wu.q	x4, x6, rne
	fcvt.q.w	x5, x4
	fcvt.q.w	x6, x4
	fcvt.q.wu	x5, x4
	fcvt.q.wu	x6, x4
	# fcvt instructions (float-float; FP32 operand can be any,
	#                    FP64 operand can be (x%4)==2)
	fcvt.s.q	x4, x5
	fcvt.s.q	x4, x5, rne
	fcvt.s.q	x4, x6
	fcvt.s.q	x4, x6, rne
	fcvt.d.q	x4, x5
	fcvt.d.q	x4, x5, rne
	fcvt.d.q	x4, x6
	fcvt.d.q	x4, x6, rne
	fcvt.d.q	x5, x8
	fcvt.d.q	x5, x8, rne
	fcvt.q.s	x5, x4
	fcvt.q.s	x6, x4
	fcvt.q.d	x5, x4
	fcvt.q.d	x6, x4
	fcvt.q.d	x8, x5
