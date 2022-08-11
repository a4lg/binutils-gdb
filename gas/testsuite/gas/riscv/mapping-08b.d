#as: -march=rv32i
#source: mapping-08.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text1:

0+000 <.text1>:
[ 	]+0:[ 	]+00b50533[ 	]+add[ 	]+a0,a0,a1
[ 	]+4:[ 	]+00b50533[ 	]+add[ 	]+a0,a0,a1
[ 	]+8:[ 	]+952e[ 	]+add[ 	]+a0,a0,a1
[ 	]+a:[ 	]+00b50533[ 	]+add[ 	]+a0,a0,a1
#...
Disassembly of section .text2:

0+000 <.text2>:
[ 	]+0:[ 	]+8d0d[ 	]+sub[ 	]+a0,a0,a1
[ 	]+2:[ 	]+8d0d[ 	]+sub[ 	]+a0,a0,a1
[ 	]+4:[ 	]+40b50533[ 	]+sub[ 	]+a0,a0,a1
[ 	]+8:[ 	]+40b50533[ 	]+sub[ 	]+a0,a0,a1
#...
