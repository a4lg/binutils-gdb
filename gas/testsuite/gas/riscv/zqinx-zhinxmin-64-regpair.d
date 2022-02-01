#as: -march=rv64i_zqinx_zhinxmin
#objdump: -dr -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+44377653[ 	]+fcvt.h.q[ 	]+x12,x14
[ 	]+[0-9a-f]+:[ 	]+443776d3[ 	]+fcvt.h.q[ 	]+x13,x14
[ 	]+[0-9a-f]+:[ 	]+44370653[ 	]+fcvt.h.q[ 	]+x12,x14,rne
[ 	]+[0-9a-f]+:[ 	]+443706d3[ 	]+fcvt.h.q[ 	]+x13,x14,rne
[ 	]+[0-9a-f]+:[ 	]+46260753[ 	]+fcvt.q.h[ 	]+x14,x12
[ 	]+[0-9a-f]+:[ 	]+46268753[ 	]+fcvt.q.h[ 	]+x14,x13
