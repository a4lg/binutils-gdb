target:
	cbo.clean	1(x1)
	cbo.clean	x30
	cbo.flush	(0+1)(x1)
	cbo.flush	x30
	cbo.inval	3*2+5(x1)
	cbo.inval	x30
	cbo.zero	x1
	cbo.zero	1(x30)
	cbo.zero	3+5(x1)
	cbo.zero	(2*4)(x30)
