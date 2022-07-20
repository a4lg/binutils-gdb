#as: -march=rv32ima_zqinx
#source: zqinx-32-regpair-dis.s
#objdump: -dr -Mnumeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+06c47253[ 	]+fadd.q[ 	]+x4,x8,x12
[ 	]+[0-9a-f]+:[ 	]+06d4f2d3[ 	]+\.4byte[ 	]+0x6d4f2d3
[ 	]+[0-9a-f]+:[ 	]+06e57353[ 	]+\.4byte[ 	]+0x6e57353
