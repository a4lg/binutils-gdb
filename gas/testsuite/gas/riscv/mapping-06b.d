#as: -march=rv32if
#source: mapping-06.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <.text>:
[ 	]+0:[ 	]+00c5f553[ 	]+fadd\.s[ 	]+fa0,fa1,fa2
[ 	]+4:[ 	]+00c5f553[ 	]+fadd\.s[ 	]+a0,a1,a2
[ 	]+8:[ 	]+00c5f553[ 	]+fadd\.s[ 	]+fa0,fa1,fa2
#...
