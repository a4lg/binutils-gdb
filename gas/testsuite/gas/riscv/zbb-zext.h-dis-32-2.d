#as: -march=rv32i_zbb_zbkb
#source: zbb-zext.h-dis.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0805c533[ 	]+pack[ 	]+a0,a1,zero
