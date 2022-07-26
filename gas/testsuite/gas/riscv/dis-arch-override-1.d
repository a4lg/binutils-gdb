#as: -march=rv64imfd_zbb
#source: dis-arch-override.s
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00c5f053[ 	]+fadd.s[ 	]+ft0,fa1,fa2
[ 	]+[0-9a-f]+:[ 	]+02c5f053[ 	]+fadd.d[ 	]+ft0,fa1,fa2
[ 	]+[0-9a-f]+:[ 	]+30102573[ 	]+csrr[ 	]+a0,misa
[ 	]+[0-9a-f]+:[ 	]+0805c53b[ 	]+zext.h[ 	]+a0,a1
