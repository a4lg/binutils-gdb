target:
	# Empty rounding mode
	fadd.s fa1,fa1,fa1,
	fadd.d fa1,fa1,fa1,
	# Invalid rounding mode
	fadd.s fa1,fa1,fa1,unknown
	fadd.d fa1,fa1,fa1,unknown
