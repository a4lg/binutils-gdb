#as:
#source: mapping-07.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <.text>:
[ 	]+0:[ 	]+00c58533[ 	]+add[ 	]+a0,a1,a2
[ 	]+4:[ 	]+00c58533[ 	]+add[ 	]+a0,a1,a2
[ 	]+8:[ 	]+00c58533[ 	]+add[ 	]+a0,a1,a2
#...
Disassembly of section .text2:

0+000 <.text2>:
[ 	]+0:[ 	]+40c58533[ 	]+sub[ 	]+a0,a1,a2
[ 	]+4:[ 	]+40c58533[ 	]+sub[ 	]+a0,a1,a2
[ 	]+8:[ 	]+40c58533[ 	]+sub[ 	]+a0,a1,a2
#...
