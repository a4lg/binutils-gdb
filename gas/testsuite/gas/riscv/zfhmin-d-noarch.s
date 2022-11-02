.include "testutils.inc"

target:
	# Case 1: No 'Zfhmin', 'D', 'Zhinxmin' or 'Zdinx'
	fcvt.d.h	fa0, fa1

	# Case 2: 'Zfhmin' but no 'D'
	SET_ARCH_START	+zfhmin
	fcvt.d.h	fa0, fa1
	SET_ARCH_END

	# Case 3: 'D' but no 'Zfhmin'
	SET_ARCH_START	+d
	fcvt.d.h	fa0, fa1
	SET_ARCH_END

	# Case 4: 'Zhinxmin' but no 'Zdinx'
	SET_ARCH_START	+zhinxmin
	fcvt.d.h	a0, a1
	SET_ARCH_END

	# Case 5: 'Zdinx' but no 'Zhinxmin'
	SET_ARCH_START	+zdinx
	fcvt.d.h	a0, a1
	SET_ARCH_END
