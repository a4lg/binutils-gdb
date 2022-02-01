#as: -march=rv64ima_zqinx
#source: zqinx-64-regpair-dis.s
#objdump: -dr -Mnumeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+06627153[ 	]+fadd.q[ 	]+x2,x4,x6
[ 	]+[0-9a-f]+:[ 	]+0672f1d3[ 	]+\.4byte[ 	]+0x672f1d3
