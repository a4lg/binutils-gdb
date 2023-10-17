target:
	fadd.d	a1, a2, a4
	fadd.d	a1, a2, a4, rne
	fadd.d	a0, a1, a4
	fadd.d	a0, a1, a4, rne
	fadd.d	a0, a2, a1
	fadd.d	a0, a2, a1, rne
	fsub.d	a1, a2, a4
	fsub.d	a1, a2, a4, rne
	fsub.d	a0, a1, a4
	fsub.d	a0, a1, a4, rne
	fsub.d	a0, a2, a1
	fsub.d	a0, a2, a1, rne
	fmul.d	a1, a2, a4
	fmul.d	a1, a2, a4, rne
	fmul.d	a0, a1, a4
	fmul.d	a0, a1, a4, rne
	fmul.d	a0, a2, a1
	fmul.d	a0, a2, a1, rne
	fdiv.d	a1, a2, a4
	fdiv.d	a1, a2, a4, rne
	fdiv.d	a0, a1, a4
	fdiv.d	a0, a1, a4, rne
	fdiv.d	a0, a2, a1
	fdiv.d	a0, a2, a1, rne
	fsqrt.d	a1, a2
	fsqrt.d	a1, a2, rne
	fsqrt.d	a0, a1
	fsqrt.d	a0, a1, rne
	fmin.d	a1, a2, a4
	fmin.d	a0, a1, a4
	fmin.d	a0, a2, a1
	fmax.d	a1, a2, a4
	fmax.d	a0, a1, a4
	fmax.d	a0, a2, a1
	fmadd.d	a1, a2, a4, a6
	fmadd.d	a1, a2, a4, a6, rne
	fmadd.d	a0, a1, a4, a6
	fmadd.d	a0, a1, a4, a6, rne
	fmadd.d	a0, a2, a1, a6
	fmadd.d	a0, a2, a1, a6, rne
	fmadd.d	a0, a2, a4, a1
	fmadd.d	a0, a2, a4, a1, rne
	fnmadd.d	a1, a2, a4, a6
	fnmadd.d	a1, a2, a4, a6, rne
	fnmadd.d	a0, a1, a4, a6
	fnmadd.d	a0, a1, a4, a6, rne
	fnmadd.d	a0, a2, a1, a6
	fnmadd.d	a0, a2, a1, a6, rne
	fnmadd.d	a0, a2, a4, a1
	fnmadd.d	a0, a2, a4, a1, rne
	fmsub.d	a1, a2, a4, a6
	fmsub.d	a1, a2, a4, a6, rne
	fmsub.d	a0, a1, a4, a6
	fmsub.d	a0, a1, a4, a6, rne
	fmsub.d	a0, a2, a1, a6
	fmsub.d	a0, a2, a1, a6, rne
	fmsub.d	a0, a2, a4, a1
	fmsub.d	a0, a2, a4, a1, rne
	fnmsub.d	a1, a2, a4, a6
	fnmsub.d	a1, a2, a4, a6, rne
	fnmsub.d	a0, a1, a4, a6
	fnmsub.d	a0, a1, a4, a6, rne
	fnmsub.d	a0, a2, a1, a6
	fnmsub.d	a0, a2, a1, a6, rne
	fnmsub.d	a0, a2, a4, a1
	fnmsub.d	a0, a2, a4, a1, rne
	fsgnj.d	a1, a2, a4
	fsgnj.d	a0, a1, a4
	fsgnj.d	a0, a2, a1
	fsgnjn.d	a1, a2, a4
	fsgnjn.d	a0, a1, a4
	fsgnjn.d	a0, a2, a1
	fsgnjx.d	a1, a2, a4
	fsgnjx.d	a0, a1, a4
	fsgnjx.d	a0, a2, a1
	fmv.d	a1, a2
	fmv.d	a0, a1
	fneg.d	a1, a2
	fneg.d	a0, a1
	fabs.d	a1, a2
	fabs.d	a0, a1
	# Compare instructions: destination is a GPR
	feq.d	a0, a1, a4
	feq.d	a0, a2, a1
	flt.d	a0, a1, a4
	flt.d	a0, a2, a1
	fle.d	a0, a1, a4
	fle.d	a0, a2, a1
	fgt.d	a0, a1, a4
	fgt.d	a0, a2, a1
	fge.d	a0, a1, a4
	fge.d	a0, a2, a1
	# fclass instruction: destination is a GPR
	fclass.d	a0, a1
	# fcvt instructions (float-int or int-float;
	#                    integer operand register can be odd)
	fcvt.w.d	a0, a1
	fcvt.w.d	a0, a1, rne
	fcvt.w.d	a3, a1
	fcvt.w.d	a3, a1, rne
	fcvt.wu.d	a0, a1
	fcvt.wu.d	a0, a1, rne
	fcvt.wu.d	a3, a1
	fcvt.wu.d	a3, a1, rne
	fcvt.d.w	a1, a2
	fcvt.d.w	a1, a3
	fcvt.d.wu	a1, a2
	fcvt.d.wu	a1, a3
	# fcvt instructions (float-float; FP32 operand can be odd)
	fcvt.s.d	a0, a1
	fcvt.s.d	a0, a1, rne
	fcvt.s.d	a3, a1
	fcvt.s.d	a3, a1, rne
	fcvt.d.s	a1, a2
	fcvt.d.s	a1, a3
