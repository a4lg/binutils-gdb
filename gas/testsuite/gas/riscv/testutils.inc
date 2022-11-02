# Set the base architecture.
.macro	SET_BASE_FORCE	xlen, basearch=i
	.option	arch, rv\xlen\basearch
	.set	XLEN, \xlen
.endm

# Set the base architecture unless the symbol NOARCH is defined.
.macro	SET_BASE	xlen, basearch=i
	.ifndef	NOARCH
	SET_BASE_FORCE	\xlen, \basearch
	.endif
.endm

# Begin base architecture block.
.macro	SET_BASE_START_FORCE	xlen, basearch=i
	.option		push
	SET_BASE_FORCE	\xlen, \basearch
.endm

# Begin base architecture block.
# Don't change the architecture if NOARCH is defined.
.macro	SET_BASE_START	xlen, basearch=i
	.option		push
	SET_BASE	\xlen, \basearch
.endm

# End base architecture block.
.macro	SET_BASE_END
	.option	pop
.endm

# Set the architecture.
.macro	SET_ARCH_FORCE	arch
	.option	arch, \arch
.endm

# Set the architecture unless the symbol NOARCH is defined.
.macro	SET_ARCH	arch
	.ifndef	NOARCH
	SET_ARCH_FORCE	\arch
	.endif
.endm

# Begin architecture block.
.macro	SET_ARCH_START_FORCE arch
	.option		push
	SET_ARCH_FORCE	\arch
.endm

# Begin architecture block.
# Don't change the architecture if NOARCH is defined.
.macro	SET_ARCH_START arch
	.option		push
	SET_ARCH	\arch
.endm

# End architecture block.
.macro	SET_ARCH_END
	.option	pop
.endm
