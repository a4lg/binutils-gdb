#as: -march=rv32i_zqinx
#objdump: -dr -Mnumeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+06c47253[ 	]+fadd.q[ 	]+x4,x8,x12
[ 	]+[0-9a-f]+:[ 	]+06d4f2d3[ 	]+fadd.q[ 	]+invalid5,invalid9,invalid13
[ 	]+[0-9a-f]+:[ 	]+06e57353[ 	]+fadd.q[ 	]+invalid6,invalid10,invalid14
