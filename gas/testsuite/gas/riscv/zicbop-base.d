#as: -march=rv32i -I$srcdir/$subdir
#source: zicbop.s
#objdump: -d -M arch=rv32i -M no-aliases -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0000e013[ 	]+ori[ 	]+x0,x1,0
[ 	]+[0-9a-f]+:[ 	]+0200e013[ 	]+ori[ 	]+x0,x1,32
[ 	]+[0-9a-f]+:[ 	]+00186013[ 	]+ori[ 	]+x0,x16,1
[ 	]+[0-9a-f]+:[ 	]+80186013[ 	]+ori[ 	]+x0,x16,-2047
[ 	]+[0-9a-f]+:[ 	]+003fe013[ 	]+ori[ 	]+x0,x31,3
[ 	]+[0-9a-f]+:[ 	]+7e3fe013[ 	]+ori[ 	]+x0,x31,2019
