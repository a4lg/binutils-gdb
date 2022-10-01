target:
	# Section 3.1.7.
	smul16		a0, a3, a5
	smulx16		a0, a3, a5
	umul16		a0, a3, a5
	umulx16		a0, a3, a5
	# Section 3.1.8.
	smul8		a0, a3, a5
	smulx8		a0, a3, a5
	umul8		a0, a3, a5
	umulx8		a0, a3, a5
	# Section 3.2.5.
	smal		a0, a2, a5
	# Section 3.3.1.
.ifdef rv32
	add64		a0, a2, a4
.endif
	radd64		a0, a2, a4
	uradd64		a0, a2, a4
	kadd64		a0, a2, a4
	ukadd64		a0, a2, a4
.ifdef rv32
	sub64		a0, a2, a4
.endif
	rsub64		a0, a2, a4
	ursub64		a0, a2, a4
	ksub64		a0, a2, a4
	uksub64		a0, a2, a4
	# Section 3.3.2.
	smar64		a0, a3, a5
	smsr64		a0, a3, a5
	umar64		a0, a3, a5
	umsr64		a0, a3, a5
	kmar64		a0, a3, a5
	kmsr64		a0, a3, a5
	ukmar64		a0, a3, a5
	ukmsr64		a0, a3, a5
	# Section 3.3.3.
	smalbb		a0, a3, a5
	smalbt		a0, a3, a5
	smaltt		a0, a3, a5
	smalda		a0, a3, a5
	smalxda		a0, a3, a5
	smalds		a0, a3, a5
	smaldrs		a0, a3, a5
	smalxds		a0, a3, a5
	smslda		a0, a3, a5
	smslxda		a0, a3, a5
	# Section 3.4.3.
	mulr64		a0, a3, a5
	mulsr64		a0, a3, a5
	# Section 3.4.5.
.ifdef rv64
	wexti		a1, a4, 31
.endif

.ifdef rv64
	# Aliases
	# Section 3.5. Table 31.
	smbb32		a1, a3, a5	# mulsr64
	# Section 3.5. Table 33.
	kmada32		a1, a3, a5	# kmar64
.endif
