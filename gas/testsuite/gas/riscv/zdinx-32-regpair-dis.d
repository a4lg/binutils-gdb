#as: -march=rv32i_zdinx
#objdump: -dr -Mnumeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+02627153[ 	]+fadd.d[ 	]+x2,x4,x6
[ 	]+[0-9a-f]+:[ 	]+0272f1d3[ 	]+fadd.d[ 	]+invalid3,invalid5,invalid7
