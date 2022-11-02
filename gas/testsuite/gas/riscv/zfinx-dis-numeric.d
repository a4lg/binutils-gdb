#as: -march=rv32i_zfinx
#objdump: -d -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+a0c5a553[ 	]+feq\.s[ 	]+x10,x11,x12
