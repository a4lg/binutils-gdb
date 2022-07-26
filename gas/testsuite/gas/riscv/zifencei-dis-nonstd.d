#as: -march=rv32i_zifencei
#source: zifencei-dis-nonstd.s
#objdump: -dr

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0000100f[ 	]+fence\.i
[ 	]+[0-9a-f]+:[ 	]+0000100f[ 	]+fence\.i
[ 	]+[0-9a-f]+:[ 	]+00001f8f[ 	]+fence\.i
[ 	]+[0-9a-f]+:[ 	]+000f900f[ 	]+fence\.i
[ 	]+[0-9a-f]+:[ 	]+fff0100f[ 	]+fence\.i
