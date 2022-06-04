#as: -march=rv64imfd_zbb
#source: dis-arch-override.s
#objdump: -d -M arch=rv32im_zfinx_zbkb

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00c5f053[ 	]+fadd.s[ 	]+zero,a1,a2
[ 	]+[0-9a-f]+:[ 	]+02c5f053[ 	]+\.4byte[ 	]+0x2c5f053
[ 	]+[0-9a-f]+:[ 	]+30102573[ 	]+csrr[ 	]+a0,misa
[ 	]+[0-9a-f]+:[ 	]+0805c53b[ 	]+packw[ 	]+a0,a1,zero
