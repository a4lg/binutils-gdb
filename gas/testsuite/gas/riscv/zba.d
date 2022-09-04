#as: -march=rv32i_zba
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+20c5a533[ 	]+sh1add[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5c533[ 	]+sh2add[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5e533[ 	]+sh3add[ 	]+a0,a1,a2
