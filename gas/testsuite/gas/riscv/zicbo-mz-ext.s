.include "testutils.inc"
target:
	SET_ARCH_START	+zicbom
	cbo.clean	(x1)
	cbo.clean	0(x30)
	cbo.flush	(x1)
	cbo.flush	(2-2)(x30)
	cbo.inval	(x1)
	cbo.inval	3*4-12(x30)
	SET_ARCH_END
	SET_ARCH_START	+zicboz
	cbo.zero	0(x1)
	cbo.zero	(x30)
	cbo.zero	2-2(x1)
	cbo.zero	(3*5-15)(x30)
	SET_ARCH_END
