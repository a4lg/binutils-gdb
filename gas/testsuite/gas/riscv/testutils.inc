# Set NOARCH symbols.
.ifndef	NOARCH
.set	NOARCH, 0
.endif
.ifndef	NOARCH_ARCH
.set	NOARCH_ARCH, 0
.endif
.ifndef	NOARCH_XLEN
.set	NOARCH_XLEN, 0
.endif
.if	NOARCH
.set	NOARCH_ARCH, 1
.set	NOARCH_XLEN, 1
.endif

# Update XLEN constraint symbols.
# For intentional error handling tests, .if SYM ... .endif block should be
# used to test those varibales.
.macro	UPDATE_XLEN
	.if	NOARCH_XLEN
		# When NOARCH_XLEN is set,
		# set those variables to "invalid" 1 to generate errors.
		.set	XLEN_EQ_32, 1
		.set	XLEN_EQ_64, 1
		.set	XLEN_GE_64, 1
	.else
		# Set symbol values depending on the XLEN.
		.ifdef	XLEN
			.ifeq	XLEN-32
			.set	XLEN_EQ_32, 1
			.else
			.set	XLEN_EQ_32, 0
			.endif
			.ifeq	XLEN-64
			.set	XLEN_EQ_64, 1
			.else
			.set	XLEN_EQ_64, 0
			.endif
			.ifge	XLEN-64
			.set	XLEN_GE_64, 1
			.else
			.set	XLEN_GE_64, 0
			.endif
		.else
			.set	XLEN_EQ_32, 0
			.set	XLEN_EQ_64, 0
			.set	XLEN_GE_64, 0
		.endif
	.endif
.endm
UPDATE_XLEN

# Set the base architecture.
.macro	SET_BASE_FORCE xlen, basearch=i
	.option	arch, rv\xlen\basearch
	.set	XLEN, \xlen
	UPDATE_XLEN
.endm

# Set the base architecture unless the symbol NOARCH_ARCH is set.
.macro	SET_BASE xlen, basearch=i
	.if	!NOARCH_ARCH
	SET_BASE_FORCE	\xlen, \basearch
	.endif
.endm

# Begin base architecture block.
.macro	SET_BASE_START_FORCE xlen, basearch=i
	.option		push
	SET_BASE_FORCE	\xlen, \basearch
.endm

# Begin base architecture block.
# Don't change the architecture if NOARCH_ARCH is set.
.macro	SET_BASE_START xlen, basearch=i
	.option		push
	SET_BASE	\xlen, \basearch
.endm

# End base architecture block.
.macro	SET_BASE_END
	.option	pop
.endm

# Set the architecture.
.macro	SET_ARCH_FORCE arch
	.option	arch, \arch
.endm

# Set the architecture unless the symbol NOARCH_ARCH is set.
.macro	SET_ARCH arch
	.ifeq	NOARCH_ARCH-0
	SET_ARCH_FORCE	\arch
	.endif
.endm

# Begin architecture block.
.macro	SET_ARCH_START_FORCE arch
	.option		push
	SET_ARCH_FORCE	\arch
.endm

# Begin architecture block.
# Don't change the architecture if NOARCH_ARCH is set.
.macro	SET_ARCH_START arch
	.option		push
	SET_ARCH	\arch
.endm

# End architecture block.
.macro	SET_ARCH_END
	.option	pop
.endm
