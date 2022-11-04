#as: -march=rv32i -I$srcdir/$subdir
#source: nop.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00000013[ 	]+addi[ 	]+zero,zero,0
[ 	]+[0-9a-f]+:[ 	]+0001[ 	]+c\.addi[ 	]+zero,0
[ 	]+[0-9a-f]+:[ 	]+0001[ 	]+c\.addi[ 	]+zero,0
