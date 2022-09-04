#as: -march=rv32i_zbc
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0ac59533[ 	]+clmul[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+0ac5b533[ 	]+clmulh[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+0ac5a533[ 	]+clmulr[ 	]+a0,a1,a2
