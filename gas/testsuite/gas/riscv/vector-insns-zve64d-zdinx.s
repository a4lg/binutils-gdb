	vfadd.vf v4, v8, a2
	vfadd.vf v4, v8, a2, v0.t
	vfsub.vf v4, v8, a2
	vfsub.vf v4, v8, a2, v0.t
	vfrsub.vf v4, v8, a2
	vfrsub.vf v4, v8, a2, v0.t

	vfwadd.vf v4, v8, a2
	vfwadd.vf v4, v8, a2, v0.t
	vfwsub.vf v4, v8, a2
	vfwsub.vf v4, v8, a2, v0.t
	vfwadd.wf v4, v8, a2
	vfwadd.wf v4, v8, a2, v0.t
	vfwsub.wf v4, v8, a2
	vfwsub.wf v4, v8, a2, v0.t

	vfmul.vf v4, v8, a2
	vfmul.vf v4, v8, a2, v0.t
	vfdiv.vf v4, v8, a2
	vfdiv.vf v4, v8, a2, v0.t
	vfrdiv.vf v4, v8, a2
	vfrdiv.vf v4, v8, a2, v0.t

	vfwmul.vf v4, v8, a2
	vfwmul.vf v4, v8, a2, v0.t

	vfmadd.vf v4, a2, v8
	vfnmadd.vf v4, a2, v8
	vfmsub.vf v4, a2, v8
	vfnmsub.vf v4, a2, v8
	vfmadd.vf v4, a2, v8, v0.t
	vfnmadd.vf v4, a2, v8, v0.t
	vfmsub.vf v4, a2, v8, v0.t
	vfnmsub.vf v4, a2, v8, v0.t
	vfmacc.vf v4, a2, v8
	vfnmacc.vf v4, a2, v8
	vfmsac.vf v4, a2, v8
	vfnmsac.vf v4, a2, v8
	vfmacc.vf v4, a2, v8, v0.t
	vfnmacc.vf v4, a2, v8, v0.t
	vfmsac.vf v4, a2, v8, v0.t
	vfnmsac.vf v4, a2, v8, v0.t

	vfwmacc.vf v4, a2, v8
	vfwnmacc.vf v4, a2, v8
	vfwmsac.vf v4, a2, v8
	vfwnmsac.vf v4, a2, v8
	vfwmacc.vf v4, a2, v8, v0.t
	vfwnmacc.vf v4, a2, v8, v0.t
	vfwmsac.vf v4, a2, v8, v0.t
	vfwnmsac.vf v4, a2, v8, v0.t

	vfmin.vf v4, v8, a2
	vfmax.vf v4, v8, a2
	vfmin.vf v4, v8, a2, v0.t
	vfmax.vf v4, v8, a2, v0.t

	vfsgnj.vf v4, v8, a2
	vfsgnjn.vf v4, v8, a2
	vfsgnjx.vf v4, v8, a2
	vfsgnj.vf v4, v8, a2, v0.t
	vfsgnjn.vf v4, v8, a2, v0.t
	vfsgnjx.vf v4, v8, a2, v0.t

	vmfeq.vf v4, v8, a2
	vmfne.vf v4, v8, a2
	vmflt.vf v4, v8, a2
	vmfle.vf v4, v8, a2
	vmfgt.vf v4, v8, a2
	vmfge.vf v4, v8, a2
	vmfeq.vf v4, v8, a2, v0.t
	vmfne.vf v4, v8, a2, v0.t
	vmflt.vf v4, v8, a2, v0.t
	vmfle.vf v4, v8, a2, v0.t
	vmfgt.vf v4, v8, a2, v0.t
	vmfge.vf v4, v8, a2, v0.t

	vfmerge.vfm v4, v8, a2, v0
	vfmv.v.f v4, a2

	vfmv.f.s a0, v8
	vfmv.s.f v4, a2

	vfslide1up.vf v4, v8, a2
	vfslide1down.vf v4, v8, a2
	vfslide1up.vf v4, v8, a2, v0.t
	vfslide1down.vf v4, v8, a2, v0.t
