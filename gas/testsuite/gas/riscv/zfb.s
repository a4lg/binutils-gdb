target:
	# fmini/fmaxi (Zfb): same as fmin/fmax (F/D/Q) except bit 13 set
	fmin.s	ft1, ft2, ft3
	fmini.s	ft1, ft2, ft3
	fmin.d	ft1, ft2, ft3
	fmini.d	ft1, ft2, ft3
	fmin.q	ft1, ft2, ft3
	fmini.q	ft1, ft2, ft3
	fmax.s	ft1, ft2, ft3
	fmaxi.s	ft1, ft2, ft3
	fmax.d	ft1, ft2, ft3
	fmaxi.d	ft1, ft2, ft3
	fmax.q	ft1, ft2, ft3
	fmaxi.q	ft1, ft2, ft3
	# fltq/fleq (Zfb): same as flt/fle (F/D/Q) except bit 14 set
	flt.s	a0, ft1, ft2
	fltq.s	a0, ft1, ft2
	flt.d	a0, ft1, ft2
	fltq.d	a0, ft1, ft2
	flt.q	a0, ft1, ft2
	fltq.q	a0, ft1, ft2
	fle.s	a0, ft1, ft2
	fleq.s	a0, ft1, ft2
	fle.d	a0, ft1, ft2
	fleq.d	a0, ft1, ft2
	fle.q	a0, ft1, ft2
	fleq.q	a0, ft1, ft2
