#as: -march=rv32i_zbb_zbkb
#source: zbb-zext.h-dis.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0805c533[ 	]+zext.h[ 	]+a0,a1
