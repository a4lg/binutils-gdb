target:
	# Empty rounding mode
	fadd.s fa1,fa1,fa1,
	fadd.d fa1,fa1,fa1,
	# Invalid rounding mode
	fadd.s fa1,fa1,fa1,unknown
	fadd.d fa1,fa1,fa1,unknown

	# Rounding mode cannot be specified on widening conversion
	# unless we have supported in the past.
	fcvt.s.h	ft1,ft2,dyn
	fcvt.d.h	ft1,ft2,dyn
	fcvt.q.h	ft1,ft2,dyn
	fcvt.d.s	ft1,ft2,dyn
	fcvt.q.s	ft1,ft2,dyn
	fcvt.q.d	ft1,ft2,dyn
	fcvt.d.w	ft1,t0,dyn
	fcvt.d.wu	ft1,t0,dyn
	fcvt.q.w	ft1,t0,dyn
	fcvt.q.wu	ft1,t0,dyn

	# Different error message because of an invalid rounding mode
	fcvt.q.wu	ft1,t0,unknown
