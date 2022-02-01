#as: -march=rv32i_zdinx_zhinxmin
#objdump: -dr

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+44167553[ 	]+fcvt.h.d[ 	]+a0,a2
[ 	]+[0-9a-f]+:[ 	]+441675d3[ 	]+fcvt.h.d[ 	]+a1,a2
[ 	]+[0-9a-f]+:[ 	]+44160553[ 	]+fcvt.h.d[ 	]+a0,a2,rne
[ 	]+[0-9a-f]+:[ 	]+441605d3[ 	]+fcvt.h.d[ 	]+a1,a2,rne
[ 	]+[0-9a-f]+:[ 	]+42250653[ 	]+fcvt.d.h[ 	]+a2,a0
[ 	]+[0-9a-f]+:[ 	]+42258653[ 	]+fcvt.d.h[ 	]+a2,a1
