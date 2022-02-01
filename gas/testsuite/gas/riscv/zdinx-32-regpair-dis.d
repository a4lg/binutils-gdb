#as: -march=rv32ima_zdinx
#source: zdinx-32-regpair-dis.s
#objdump: -dr -Mnumeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+02627153[ 	]+fadd.d[ 	]+x2,x4,x6
[ 	]+[0-9a-f]+:[ 	]+0272f1d3[ 	]+\.4byte[ 	]+0x272f1d3
