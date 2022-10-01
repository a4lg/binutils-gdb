target:
	# Use odd registers to make sure that those instructions are valid on
	# RV64_Zpsfoperand but not on RV32_Zpsfoperand.
	smul16		s1, a3, a5
	smulx16		s1, a3, a5
	umul16		s1, a3, a5
	umulx16		s1, a3, a5
	smul8		s1, a3, a5
	smulx8		s1, a3, a5
	umul8		s1, a3, a5
	umulx8		s1, a3, a5
	smal		s1, a2, a5
	smal		a0, a1, a5
.ifdef rv32
	add64		s1, a2, a4
	add64		a0, a1, a4
	add64		a0, a2, a3
.endif
	radd64		s1, a2, a4
	radd64		a0, a1, a4
	radd64		a0, a2, a3
	uradd64		s1, a2, a4
	uradd64		a0, a1, a4
	uradd64		a0, a2, a3
	kadd64		s1, a2, a4
	kadd64		a0, a1, a4
	kadd64		a0, a2, a3
	ukadd64		s1, a2, a4
	ukadd64		a0, a1, a4
	ukadd64		a0, a2, a3
.ifdef rv32
	sub64		s1, a2, a4
	sub64		a0, a1, a4
	sub64		a0, a2, a3
.endif
	rsub64		s1, a2, a4
	rsub64		a0, a1, a4
	rsub64		a0, a2, a3
	ursub64		s1, a2, a4
	ursub64		a0, a1, a4
	ursub64		a0, a2, a3
	ksub64		s1, a2, a4
	ksub64		a0, a1, a4
	ksub64		a0, a2, a3
	uksub64		s1, a2, a4
	uksub64		a0, a1, a4
	uksub64		a0, a2, a3
	smar64		s1, a3, a5
	smsr64		s1, a3, a5
	umar64		s1, a3, a5
	umsr64		s1, a3, a5
	kmar64		s1, a3, a5
	kmsr64		s1, a3, a5
	ukmar64		s1, a3, a5
	ukmsr64		s1, a3, a5
	smalbb		s1, a3, a5
	smalbt		s1, a3, a5
	smaltt		s1, a3, a5
	smalda		s1, a3, a5
	smalxda		s1, a3, a5
	smalds		s1, a3, a5
	smaldrs		s1, a3, a5
	smalxds		s1, a3, a5
	smslda		s1, a3, a5
	smslxda		s1, a3, a5
	mulr64		s1, a3, a5
	mulsr64		s1, a3, a5
.ifdef rv64
	wexti		a1, a3, 31
.endif
