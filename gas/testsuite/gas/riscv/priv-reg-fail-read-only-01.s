	.macro csr val
	csrw \val, a1
	.endm
	.include "priv-reg-access-all.s"
