#as: -march=rv64i_zbb
#source: zbb-zext.h-dis.s
#objdump: -d -M arch=rv64i_zbkb

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0805c53b[ 	]+packw[ 	]+a0,a1,zero
