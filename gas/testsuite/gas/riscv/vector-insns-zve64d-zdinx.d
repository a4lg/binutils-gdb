#as: -march=rv32i_zfinx_zdinx_zve64d
#objdump: -dr

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <.text>:
[ 	]+[0-9a-f]+:[ 	]+02865257[ 	]+vfadd.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+00865257[ 	]+vfadd.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+0a865257[ 	]+vfsub.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+08865257[ 	]+vfsub.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+9e865257[ 	]+vfrsub.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+9c865257[ 	]+vfrsub.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+c2865257[ 	]+vfwadd.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+c0865257[ 	]+vfwadd.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+ca865257[ 	]+vfwsub.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+c8865257[ 	]+vfwsub.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+d2865257[ 	]+vfwadd.wf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+d0865257[ 	]+vfwadd.wf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+da865257[ 	]+vfwsub.wf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+d8865257[ 	]+vfwsub.wf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+92865257[ 	]+vfmul.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+90865257[ 	]+vfmul.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+82865257[ 	]+vfdiv.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+80865257[ 	]+vfdiv.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+86865257[ 	]+vfrdiv.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+84865257[ 	]+vfrdiv.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+e2865257[ 	]+vfwmul.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+e0865257[ 	]+vfwmul.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+a2865257[ 	]+vfmadd.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+a6865257[ 	]+vfnmadd.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+aa865257[ 	]+vfmsub.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+ae865257[ 	]+vfnmsub.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+a0865257[ 	]+vfmadd.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+a4865257[ 	]+vfnmadd.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+a8865257[ 	]+vfmsub.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+ac865257[ 	]+vfnmsub.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+b2865257[ 	]+vfmacc.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+b6865257[ 	]+vfnmacc.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+ba865257[ 	]+vfmsac.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+be865257[ 	]+vfnmsac.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+b0865257[ 	]+vfmacc.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+b4865257[ 	]+vfnmacc.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+b8865257[ 	]+vfmsac.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+bc865257[ 	]+vfnmsac.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+f2865257[ 	]+vfwmacc.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+f6865257[ 	]+vfwnmacc.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+fa865257[ 	]+vfwmsac.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+fe865257[ 	]+vfwnmsac.vf[ 	]+v4,a2,v8
[ 	]+[0-9a-f]+:[ 	]+f0865257[ 	]+vfwmacc.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+f4865257[ 	]+vfwnmacc.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+f8865257[ 	]+vfwmsac.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+fc865257[ 	]+vfwnmsac.vf[ 	]+v4,a2,v8,v0.t
[ 	]+[0-9a-f]+:[ 	]+12865257[ 	]+vfmin.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+1a865257[ 	]+vfmax.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+10865257[ 	]+vfmin.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+18865257[ 	]+vfmax.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+22865257[ 	]+vfsgnj.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+26865257[ 	]+vfsgnjn.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+2a865257[ 	]+vfsgnjx.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+20865257[ 	]+vfsgnj.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+24865257[ 	]+vfsgnjn.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+28865257[ 	]+vfsgnjx.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+62865257[ 	]+vmfeq.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+72865257[ 	]+vmfne.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+6e865257[ 	]+vmflt.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+66865257[ 	]+vmfle.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+76865257[ 	]+vmfgt.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+7e865257[ 	]+vmfge.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+60865257[ 	]+vmfeq.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+70865257[ 	]+vmfne.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+6c865257[ 	]+vmflt.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+64865257[ 	]+vmfle.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+74865257[ 	]+vmfgt.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+7c865257[ 	]+vmfge.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+5c865257[ 	]+vfmerge.vfm[ 	]+v4,v8,a2,v0
[ 	]+[0-9a-f]+:[ 	]+5e065257[ 	]+vfmv.v.f[ 	]+v4,a2
[ 	]+[0-9a-f]+:[ 	]+42801557[ 	]+vfmv.f.s[ 	]+a0,v8
[ 	]+[0-9a-f]+:[ 	]+42065257[ 	]+vfmv.s.f[ 	]+v4,a2
[ 	]+[0-9a-f]+:[ 	]+3a865257[ 	]+vfslide1up.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+3e865257[ 	]+vfslide1down.vf[ 	]+v4,v8,a2
[ 	]+[0-9a-f]+:[ 	]+38865257[ 	]+vfslide1up.vf[ 	]+v4,v8,a2,v0.t
[ 	]+[0-9a-f]+:[ 	]+3c865257[ 	]+vfslide1down.vf[ 	]+v4,v8,a2,v0.t
