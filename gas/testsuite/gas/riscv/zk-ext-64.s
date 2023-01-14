.include "testutils.inc"

target:
	SET_ARCH_START	+zknd
	aes64ds		a0, a1, a2
	aes64dsm	a0, a1, a2
	aes64im		a0, a1
	aes64ks1i	a0, a1, 4
	aes64ks2	a0, a1, a2
	SET_ARCH_END

	SET_ARCH_START	+zkne
	aes64es		a0, a1, a2
	aes64esm	a0, a1, a2
	aes64ks1i	a0, a1, 4
	aes64ks2	a0, a1, a2
	SET_ARCH_END

	SET_ARCH_START	+zknh
	sha256sig0	a0, a1
	sha256sig1	a0, a1
	sha256sum0	a0, a1
	sha256sum1	a0, a1
	sha512sig0	a0, a1
	sha512sig1	a0, a1
	sha512sum0	a0, a1
	sha512sum1	a0, a1
	SET_ARCH_END

	SET_ARCH_START	+zksed
	sm4ed		a0, a1, a2, 2
	sm4ks		a0, a1, a2, 2
	SET_ARCH_END

	SET_ARCH_START	+zksh
	sm3p0		a0, a1
	sm3p1		a0, a1
	SET_ARCH_END

	SET_ARCH_START_FORCE	+zicsr
	SET_ARCH_START		+zkr
	csrr		a0, seed
	SET_ARCH_END
	SET_ARCH_END
