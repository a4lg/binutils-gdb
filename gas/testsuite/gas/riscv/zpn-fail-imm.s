target:
	srai16		a0, a1, -1
	srai16		a0, a1, 16	# imm4u
	srai16.u	a0, a1, -1
	srai16.u	a0, a1, 16	# imm4u
	srli16		a0, a1, -1
	srli16		a0, a1, 16	# imm4u
	srli16.u	a0, a1, -1
	srli16.u	a0, a1, 16	# imm4u
	slli16		a0, a1, -1
	slli16		a0, a1, 16	# imm4u
	kslli16		a0, a1, -1
	kslli16		a0, a1, 16	# imm4u
	srai8		a0, a1, -1
	srai8		a0, a1, 8	# imm3u
	srai8.u		a0, a1, -1
	srai8.u		a0, a1, 8	# imm3u
	srli8		a0, a1, -1
	srli8		a0, a1, 8	# imm3u
	srli8.u		a0, a1, -1
	srli8.u		a0, a1, 8	# imm3u
	slli8		a0, a1, -1
	slli8		a0, a1, 8	# imm3u
	kslli8		a0, a1, -1
	kslli8		a0, a1, 8	# imm3u
	sclip16		a0, a1, -1
	sclip16		a0, a1, 16	# imm4u
	uclip16		a0, a1, -1
	uclip16		a0, a1, 16	# imm4u
	sclip8		a0, a1, -1
	sclip8		a0, a1, 8	# imm3u
	uclip8		a0, a1, -1
	uclip8		a0, a1, 8	# imm3u
	sclip32		a0, a1, -1
	sclip32		a0, a1, 32	# imm5u
	uclip32		a0, a1, -1
	uclip32		a0, a1, 32	# imm5u
	kslliw		a0, a1, -1
	kslliw		a0, a1, 32	# imm5u / shamtw
	srai.u		a0, a1, -1
.ifdef rv32
	srai.u		a0, a1, 32	# imm5u (RV32) / shamt(w)
.endif
.ifdef rv64
	srai.u		a0, a1, 64	# imm6u (RV64) / shamt(d)
.endif
	insb		a0, a1, -1
.ifdef rv32
	insb		a0, a1, 4	# imm2u (RV32)
.endif
.ifdef rv64
	insb		a0, a1, 8	# imm3u (RV64)
.endif
.ifdef rv64
	srai32		a0, a1, -1
	srai32		a0, a1, 32	# imm5u / shamtw
	srai32.u	a0, a1, -1
	srai32.u	a0, a1, 32	# imm5u / shamtw
	srli32		a0, a1, -1
	srli32		a0, a1, 32	# imm5u / shamtw
	srli32.u	a0, a1, -1
	srli32.u	a0, a1, 32	# imm5u / shamtw
	slli32		a0, a1, -1
	slli32		a0, a1, 32	# imm5u / shamtw
	kslli32		a0, a1, -1
	kslli32		a0, a1, 32	# imm5u / shamtw
	sraiw.u		a0, a1, -1
	sraiw.u		a0, a1, 32	# imm5u / shamtw
.endif
