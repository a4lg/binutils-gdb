target:
	# Zfbfmin only instructions
	fcvt.bf16.s	fa0, fa1
	fcvt.bf16.s	fa0, fa1, rtz
	fcvt.s.bf16	fa0, fa1
	# Instructions shared with Zfhmin
	flh		fa0, 0(a1)
	fsh		fa0, 0(a1)
	fmv.x.h		a0, fa1
	fmv.h.x		fa0, a1
