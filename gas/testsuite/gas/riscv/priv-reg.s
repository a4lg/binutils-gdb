	.macro csr val
	csrr a0,\val
	.endm
	.include "priv-reg-access-all.s"
