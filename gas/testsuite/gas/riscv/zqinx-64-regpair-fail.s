target:
	fadd.q	a1, a2, a4
	fadd.q	a1, a2, a4, rne
	fadd.q	a0, a1, a4
	fadd.q	a0, a1, a4, rne
	fadd.q	a0, a2, a1
	fadd.q	a0, a2, a1, rne
	fsub.q	a1, a2, a4
	fsub.q	a1, a2, a4, rne
	fsub.q	a0, a1, a4
	fsub.q	a0, a1, a4, rne
	fsub.q	a0, a2, a1
	fsub.q	a0, a2, a1, rne
	fmul.q	a1, a2, a4
	fmul.q	a1, a2, a4, rne
	fmul.q	a0, a1, a4
	fmul.q	a0, a1, a4, rne
	fmul.q	a0, a2, a1
	fmul.q	a0, a2, a1, rne
	fdiv.q	a1, a2, a4
	fdiv.q	a1, a2, a4, rne
	fdiv.q	a0, a1, a4
	fdiv.q	a0, a1, a4, rne
	fdiv.q	a0, a2, a1
	fdiv.q	a0, a2, a1, rne
	fsqrt.q	a1, a2
	fsqrt.q	a1, a2, rne
	fsqrt.q	a0, a1
	fsqrt.q	a0, a1, rne
	fmin.q	a1, a2, a4
	fmin.q	a0, a1, a4
	fmin.q	a0, a2, a1
	fmax.q	a1, a2, a4
	fmax.q	a0, a1, a4
	fmax.q	a0, a2, a1
	fmadd.q	a1, a2, a4, a6
	fmadd.q	a1, a2, a4, a6, rne
	fmadd.q	a0, a1, a4, a6
	fmadd.q	a0, a1, a4, a6, rne
	fmadd.q	a0, a2, a1, a6
	fmadd.q	a0, a2, a1, a6, rne
	fmadd.q	a0, a2, a4, a1
	fmadd.q	a0, a2, a4, a1, rne
	fnmadd.q	a1, a2, a4, a6
	fnmadd.q	a1, a2, a4, a6, rne
	fnmadd.q	a0, a1, a4, a6
	fnmadd.q	a0, a1, a4, a6, rne
	fnmadd.q	a0, a2, a1, a6
	fnmadd.q	a0, a2, a1, a6, rne
	fnmadd.q	a0, a2, a4, a1
	fnmadd.q	a0, a2, a4, a1, rne
	fmsub.q	a1, a2, a4, a6
	fmsub.q	a1, a2, a4, a6, rne
	fmsub.q	a0, a1, a4, a6
	fmsub.q	a0, a1, a4, a6, rne
	fmsub.q	a0, a2, a1, a6
	fmsub.q	a0, a2, a1, a6, rne
	fmsub.q	a0, a2, a4, a1
	fmsub.q	a0, a2, a4, a1, rne
	fnmsub.q	a1, a2, a4, a6
	fnmsub.q	a1, a2, a4, a6, rne
	fnmsub.q	a0, a1, a4, a6
	fnmsub.q	a0, a1, a4, a6, rne
	fnmsub.q	a0, a2, a1, a6
	fnmsub.q	a0, a2, a1, a6, rne
	fnmsub.q	a0, a2, a4, a1
	fnmsub.q	a0, a2, a4, a1, rne
	fsgnj.q	a1, a2, a4
	fsgnj.q	a0, a1, a4
	fsgnj.q	a0, a2, a1
	fsgnjn.q	a1, a2, a4
	fsgnjn.q	a0, a1, a4
	fsgnjn.q	a0, a2, a1
	fsgnjx.q	a1, a2, a4
	fsgnjx.q	a0, a1, a4
	fsgnjx.q	a0, a2, a1
	fmv.q	a1, a2
	fmv.q	a0, a1
	fneg.q	a1, a2
	fneg.q	a0, a1
	fabs.q	a1, a2
	fabs.q	a0, a1
	# Compare instructions: destination is a GPR
	feq.q	a0, a1, a4
	feq.q	a0, a2, a1
	flt.q	a0, a1, a4
	flt.q	a0, a2, a1
	fle.q	a0, a1, a4
	fle.q	a0, a2, a1
	fgt.q	a0, a1, a4
	fgt.q	a0, a2, a1
	fge.q	a0, a1, a4
	fge.q	a0, a2, a1
	# fclass instruction: destination is a GPR
	fclass.q	a0, a1
	# fcvt instructions (float-int or int-float;
	#                    integer operand register can be odd)
	fcvt.w.q	a0, a1
	fcvt.w.q	a0, a1, rne
	fcvt.w.q	a3, a1
	fcvt.w.q	a3, a1, rne
	fcvt.wu.q	a0, a1
	fcvt.wu.q	a0, a1, rne
	fcvt.wu.q	a3, a1
	fcvt.wu.q	a3, a1, rne
	fcvt.l.q	a0, a1
	fcvt.l.q	a0, a1, rne
	fcvt.l.q	a3, a1
	fcvt.l.q	a3, a1, rne
	fcvt.lu.q	a0, a1
	fcvt.lu.q	a0, a1, rne
	fcvt.lu.q	a3, a1
	fcvt.lu.q	a3, a1, rne
	fcvt.q.w	a1, a2
	fcvt.q.w	a1, a3
	fcvt.q.wu	a1, a2
	fcvt.q.wu	a1, a3
	fcvt.q.l	a1, a2
	fcvt.q.l	a1, a2, rne
	fcvt.q.l	a1, a3
	fcvt.q.l	a1, a3, rne
	fcvt.q.lu	a1, a2
	fcvt.q.lu	a1, a2, rne
	fcvt.q.lu	a1, a3
	fcvt.q.lu	a1, a3, rne
	# fcvt instructions (float-float; FP32/FP64 operand can be odd)
	fcvt.s.q	a0, a1
	fcvt.s.q	a0, a1, rne
	fcvt.s.q	a3, a1
	fcvt.s.q	a3, a1, rne
	fcvt.d.q	a0, a1
	fcvt.d.q	a0, a1, rne
	fcvt.d.q	a3, a1
	fcvt.d.q	a3, a1, rne
	fcvt.q.s	a1, a2
	fcvt.q.s	a1, a3
	fcvt.q.d	a1, a2
	fcvt.q.d	a1, a3
