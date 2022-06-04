#as: -march=rv64imfd_zbb
#source: dis-arch-override.s
#objdump: -d -m riscv -M arch=rv32im_zfinx_zbkb,numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00c5f053[ 	]+fadd.s[ 	]+x0,x11,x12
[ 	]+[0-9a-f]+:[ 	]+02c5f053[ 	]+\.4byte[ 	]+0x2c5f053
[ 	]+[0-9a-f]+:[ 	]+30102573[ 	]+csrr[ 	]+x10,misa
[ 	]+[0-9a-f]+:[ 	]+0805c53b[ 	]+\.4byte[ 	]+0x805c53b
