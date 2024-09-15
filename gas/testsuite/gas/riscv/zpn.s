target:
	# Section 3.1.1.
	add16		a0, a1, a2
	radd16		a0, a1, a2
	uradd16		a0, a1, a2
	kadd16		a0, a1, a2
	ukadd16		a0, a1, a2
	sub16		a0, a1, a2
	rsub16		a0, a1, a2
	ursub16		a0, a1, a2
	ksub16		a0, a1, a2
	uksub16		a0, a1, a2
	cras16		a0, a1, a2
	rcras16		a0, a1, a2
	urcras16	a0, a1, a2
	kcras16		a0, a1, a2
	ukcras16	a0, a1, a2
	crsa16		a0, a1, a2
	rcrsa16		a0, a1, a2
	urcrsa16	a0, a1, a2
	kcrsa16		a0, a1, a2
	ukcrsa16	a0, a1, a2
	stas16		a0, a1, a2
	rstas16		a0, a1, a2
	urstas16	a0, a1, a2
	kstas16		a0, a1, a2
	ukstas16	a0, a1, a2
	stsa16		a0, a1, a2
	rstsa16		a0, a1, a2
	urstsa16	a0, a1, a2
	kstsa16		a0, a1, a2
	ukstsa16	a0, a1, a2
	# Section 3.1.2.
	add8		a0, a1, a2
	radd8		a0, a1, a2
	uradd8		a0, a1, a2
	kadd8		a0, a1, a2
	ukadd8		a0, a1, a2
	sub8		a0, a1, a2
	rsub8		a0, a1, a2
	ursub8		a0, a1, a2
	ksub8		a0, a1, a2
	uksub8		a0, a1, a2
	# Section 3.1.3.
	sra16		a0, a1, a2
	srai16		a0, a1, 15
	sra16.u		a0, a1, a2
	srai16.u	a0, a1, 15
	srl16		a0, a1, a2
	srli16		a0, a1, 15
	srl16.u		a0, a1, a2
	srli16.u	a0, a1, 15
	sll16		a0, a1, a2
	slli16		a0, a1, 15
	ksll16		a0, a1, a2
	kslli16		a0, a1, 15
	kslra16		a0, a1, a2
	kslra16.u	a0, a1, a2
	# Section 3.1.4.
	sra8		a0, a1, a2
	srai8		a0, a1, 7
	sra8.u		a0, a1, a2
	srai8.u		a0, a1, 7
	srl8		a0, a1, a2
	srli8		a0, a1, 7
	srl8.u		a0, a1, a2
	srli8.u		a0, a1, 7
	sll8		a0, a1, a2
	slli8		a0, a1, 7
	ksll8		a0, a1, a2
	kslli8		a0, a1, 7
	kslra8		a0, a1, a2
	kslra8.u	a0, a1, a2
	# Section 3.1.5.
	cmpeq16		a0, a1, a2
	scmplt16	a0, a1, a2
	scmple16	a0, a1, a2
	ucmplt16	a0, a1, a2
	ucmple16	a0, a1, a2
	# Section 3.1.6.
	cmpeq8		a0, a1, a2
	scmplt8		a0, a1, a2
	scmple8		a0, a1, a2
	ucmplt8		a0, a1, a2
	ucmple8		a0, a1, a2
	# Section 3.1.7.
	# smul16	# Zpsfoperand
	# smulx16	# Zpsfoperand
	# umul16	# Zpsfoperand
	# umulx16	# Zpsfoperand
	khm16		a0, a1, a2
	khmx16		a0, a1, a2
	# Section 3.1.8.
	# smul8		# Zpsfoperand
	# smulx8	# Zpsfoperand
	# umul8		# Zpsfoperand
	# umulx8	# Zpsfoperand
	khm8		a0, a1, a2
	khmx8		a0, a1, a2
	# Section 3.1.9.
	smin16		a0, a1, a2
	umin16		a0, a1, a2
	smax16		a0, a1, a2
	umax16		a0, a1, a2
	sclip16		a0, a1, 15
	uclip16		a0, a1, 15
	kabs16		a0, a1
	clrs16		a0, a1
	clz16		a0, a1
	swap16		a0, a1		# Alias
	# Section 3.1.10.
	smin8		a0, a1, a2
	umin8		a0, a1, a2
	smax8		a0, a1, a2
	umax8		a0, a1, a2
	kabs8		a0, a1
	sclip8		a0, a1, 7
	uclip8		a0, a1, 7
	clrs8		a0, a1
	clz8		a0, a1
	# swap8		# Zbpbo
	# Section 3.1.11.
	sunpkd810	a0, a1
	sunpkd820	a0, a1
	sunpkd830	a0, a1
	sunpkd831	a0, a1
	sunpkd832	a0, a1
	zunpkd810	a0, a1
	zunpkd820	a0, a1
	zunpkd830	a0, a1
	zunpkd831	a0, a1
	zunpkd832	a0, a1
	# Section 3.2.1.
.ifdef rv32
	# pkbb16	# Zbpbo (Zpn-like alias)
.endif
.ifdef rv64
	pkbb16		a0, a1, a2
.endif
	pkbt16		a0, a1, a2
	pktb16		a0, a1, a2
.ifdef rv32
	# pktt16	# Zbpbo (Zpn-like alias)
.endif
.ifdef rv64
	pktt16		a0, a1, a2
.endif
	# Section 3.2.2.
	smmul		a0, a1, a2	# RV32: Zmmul (Zpn pseudoinstruction)
	smmul.u		a0, a1, a2
	kmmac		a0, a1, a2
	kmmac.u		a0, a1, a2
	kmmsb		a0, a1, a2
	kmmsb.u		a0, a1, a2
	kwmmul		a0, a1, a2
	kwmmul.u	a0, a1, a2
	# Section 3.2.3.
	smmwb		a0, a1, a2
	smmwb.u		a0, a1, a2
	smmwt		a0, a1, a2
	smmwt.u		a0, a1, a2
	kmmawb		a0, a1, a2
	kmmawb.u	a0, a1, a2
	kmmawt		a0, a1, a2
	kmmawt.u	a0, a1, a2
	kmmwb2		a0, a1, a2
	kmmwb2.u	a0, a1, a2
	kmmwt2		a0, a1, a2
	kmmwt2.u	a0, a1, a2
	kmmawb2		a0, a1, a2
	kmmawb2.u	a0, a1, a2
	kmmawt2		a0, a1, a2
	kmmawt2.u	a0, a1, a2
	# Section 3.2.4.
	smbb16		a0, a1, a2
	smbt16		a0, a1, a2
	smtt16		a0, a1, a2
	kmda		a0, a1, a2
	kmxda		a0, a1, a2
	smds		a0, a1, a2
	smdrs		a0, a1, a2
	smxds		a0, a1, a2
	kmabb		a0, a1, a2
	kmabt		a0, a1, a2
	kmatt		a0, a1, a2
	kmada		a0, a1, a2
	kmaxda		a0, a1, a2
	kmads		a0, a1, a2
	kmadrs		a0, a1, a2
	kmaxds		a0, a1, a2
	kmsda		a0, a1, a2
	kmsxda		a0, a1, a2
	# Section 3.2.5.
	# smal		# Zpsfoperand
	# Section 3.2.6.
	sclip32		a0, a1, 31
	uclip32		a0, a1, 31
	clrs32		a0, a1
.ifdef rv32
	# clz32		# Zbpbo (Zpn-like alias)
.endif
.ifdef rv64
	clz32		a0, a1
.endif
	pbsad		a0, a1, a2
	pbsada		a0, a1, a2
	# Section 3.2.7.
	smaqa		a0, a1, a2
	umaqa		a0, a1, a2
	smaqa.su	a0, a1, a2
	# Section 3.3.1.
.ifdef rv32
	# add64		# Zpsfoperand
.endif
	# radd64	# Zpsfoperand
	# uradd64	# Zpsfoperand
	# kadd64	# Zpsfoperand
	# ukadd64	# Zpsfoperand
.ifdef rv32
	# sub64		# Zpsfoperand
.endif
	# rsub64	# Zpsfoperand
	# ursub64	# Zpsfoperand
	# ksub64	# Zpsfoperand
	# uksub64	# Zpsfoperand
	# Section 3.3.2.
	# smar64	# Zpsfoperand
	# smsr64	# Zpsfoperand
	# umar64	# Zpsfoperand
	# umsr64	# Zpsfoperand
	# kmar64	# Zpsfoperand
	# kmsr64	# Zpsfoperand
	# ukmar64	# Zpsfoperand
	# ukmsr64	# Zpsfoperand
	# Section 3.3.3.
	# smalbb	# Zpsfoperand
	# smalbt	# Zpsfoperand
	# smaltt	# Zpsfoperand
	# smalda	# Zpsfoperand
	# smalxda	# Zpsfoperand
	# smalds	# Zpsfoperand
	# smaldrs	# Zpsfoperand
	# smalxds	# Zpsfoperand
	# smslda	# Zpsfoperand
	# smslxda	# Zpsfoperand
	# Section 3.4.1.
	kaddh		a0, a1, a2
	ksubh		a0, a1, a2
	khmbb		a0, a1, a2
	khmbt		a0, a1, a2
	khmtt		a0, a1, a2
	ukaddh		a0, a1, a2
	uksubh		a0, a1, a2
	# Section 3.4.2.
	kaddw		a0, a1, a2
	ukaddw		a0, a1, a2
	ksubw		a0, a1, a2
	uksubw		a0, a1, a2
	kdmbb		a0, a1, a2
	kdmbt		a0, a1, a2
	kdmtt		a0, a1, a2
	kslraw		a0, a1, a2
	kslraw.u	a0, a1, a2
	ksllw		a0, a1, a2
	kslliw		a0, a1, 31
	kdmabb		a0, a1, a2
	kdmabt		a0, a1, a2
	kdmatt		a0, a1, a2
	kabsw		a0, a1
	# Section 3.4.3.
	raddw		a0, a1, a2
	uraddw		a0, a1, a2
	rsubw		a0, a1, a2
	ursubw		a0, a1, a2
	# mulr64	# Zpsfoperand
	# mulsr64	# Zpsfoperand
	msubr32		a0, a1, a2
	# Section 3.4.4.
	rdov		a0		# Zicsr (Zpn pseudoinstruction)
	clrov				# Zicsr (Zpn pseudoinstruction)
	# Section 3.4.5.
	ave		a0, a1, a2
	sra.u		a0, a1, a2
.ifdef rv32
	srai.u		a0, a1, 31
.endif
.ifdef rv64
	srai.u		a0, a1, 63
.endif
	# bitrev	# Abandoned encoding
	# bitrevi	# Abandoned encoding
	# wext		# Considered harmful to implement
.ifdef rv32
	# wexti		# Zbpbo
.endif
.ifdef rv64
	# wexti		# Zpsfoperand
.endif
	# cmix		# Zbpbo
.ifdef rv32
	insb		a0, a1, 3
.endif
.ifdef rv64
	insb		a0, a1, 7
.endif
	maddr32		a0, a1, a2
	msubr32		a0, a1, a2
	# max		# Zbpbo
	# min		# Zbpbo
	# Section 3.5. (RV64 only)
.ifdef rv64
	# Section 3.5. Table 27.
	add32		a0, a1, a2
	radd32		a0, a1, a2
	uradd32		a0, a1, a2
	kadd32		a0, a1, a2
	ukadd32		a0, a1, a2
	sub32		a0, a1, a2
	rsub32		a0, a1, a2
	ursub32		a0, a1, a2
	ksub32		a0, a1, a2
	uksub32		a0, a1, a2
	cras32		a0, a1, a2
	rcras32		a0, a1, a2
	urcras32	a0, a1, a2
	kcras32		a0, a1, a2
	ukcras32	a0, a1, a2
	crsa32		a0, a1, a2
	rcrsa32		a0, a1, a2
	urcrsa32	a0, a1, a2
	kcrsa32		a0, a1, a2
	ukcrsa32	a0, a1, a2
	stas32		a0, a1, a2
	rstas32		a0, a1, a2
	urstas32	a0, a1, a2
	kstas32		a0, a1, a2
	ukstas32	a0, a1, a2
	stsa32		a0, a1, a2
	rstsa32		a0, a1, a2
	urstsa32	a0, a1, a2
	kstsa32		a0, a1, a2
	ukstsa32	a0, a1, a2
	# Section 3.5. Table 28.
	sra32		a0, a1, a2
	srai32		a0, a1, 31
	sra32.u		a0, a1, a2
	srai32.u	a0, a1, 31
	srl32		a0, a1, a2
	srli32		a0, a1, 31
	srl32.u		a0, a1, a2
	srli32.u	a0, a1, 31
	sll32		a0, a1, a2
	slli32		a0, a1, 31
	ksll32		a0, a1, a2
	kslli32		a0, a1, 31
	kslra32		a0, a1, a2
	kslra32.u	a0, a1, a2
	# Section 3.5. Table 29.
	smin32		a0, a1, a2
	umin32		a0, a1, a2
	smax32		a0, a1, a2
	umax32		a0, a1, a2
	kabs32		a0, a1
	# Section 3.5. Table 30.
	khmbb16		a0, a1, a2
	khmbt16		a0, a1, a2
	khmtt16		a0, a1, a2
	kdmbb16		a0, a1, a2
	kdmbt16		a0, a1, a2
	kdmtt16		a0, a1, a2
	kdmabb16	a0, a1, a2
	kdmabt16	a0, a1, a2
	kdmatt16	a0, a1, a2
	# Section 3.5. Table 31.
	# smbb32	# Zpsfoperand (alias)
	smbt32		a0, a1, a2
	smtt32		a0, a1, a2
	# Section 3.5. Table 32.
	kmabb32		a0, a1, a2
	kmabt32		a0, a1, a2
	kmatt32		a0, a1, a2
	# Section 3.5. Table 33.
	kmda32		a0, a1, a2
	kmaxda32	a0, a1, a2
	# kmada32	# Zpsfoperand (alias)
	kmaxda32	a0, a1, a2
	kmads32		a0, a1, a2
	kmadrs32	a0, a1, a2
	kmaxds32	a0, a1, a2
	kmsda32		a0, a1, a2
	kmsxda32	a0, a1, a2
	smds32		a0, a1, a2
	smdrs32		a0, a1, a2
	smxds32		a0, a1, a2
	# Section 3.5. Table 34.
	sraiw.u		a0, a1, 31
	# Section 3.5. Table 35.
	# pkbb32	# Zbpbo (Zpn-like alias)
	pkbt32		a0, a1, a2
	pktb32		a0, a1, a2
	# pktt32	# Zbpbo (Zpn-like alias)
.endif
