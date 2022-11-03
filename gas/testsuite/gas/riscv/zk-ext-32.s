.include "testutils.inc"

target:
	SET_ARCH_START	+zknd
	aes32dsi	a0, a1, a2, 2
	aes32dsmi	a0, a1, a2, 2
	SET_ARCH_END

	SET_ARCH_START	+zkne
	aes32esi	a0, a1, a2, 2
	aes32esmi	a0, a1, a2, 2
	SET_ARCH_END

	SET_ARCH_START	+zknh
	sha256sig0	a0, a1
	sha256sig1	a0, a1
	sha256sum0	a0, a1
	sha256sum1	a0, a1
	sha512sig0h	a0, a1, a2
	sha512sig0l	a0, a1, a2
	sha512sig1h	a0, a1, a2
	sha512sig1l	a0, a1, a2
	sha512sum0r	a0, a1, a2
	sha512sum1r	a0, a1, a2
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
