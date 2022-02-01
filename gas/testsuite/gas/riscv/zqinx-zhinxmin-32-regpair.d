#as: -march=rv32i_zqinx_zhinxmin
#objdump: -dr -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+44367853[ 	]+fcvt.h.q[ 	]+x16,x12
[ 	]+[0-9a-f]+:[ 	]+443678d3[ 	]+fcvt.h.q[ 	]+x17,x12
[ 	]+[0-9a-f]+:[ 	]+44360853[ 	]+fcvt.h.q[ 	]+x16,x12,rne
[ 	]+[0-9a-f]+:[ 	]+443608d3[ 	]+fcvt.h.q[ 	]+x17,x12,rne
[ 	]+[0-9a-f]+:[ 	]+46280653[ 	]+fcvt.q.h[ 	]+x12,x16
[ 	]+[0-9a-f]+:[ 	]+46288653[ 	]+fcvt.q.h[ 	]+x12,x17
