#as: -march=rv64i_zqinx
#objdump: -dr -Mnumeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+06627153[ 	]+fadd.q[ 	]+x2,x4,x6
[ 	]+[0-9a-f]+:[ 	]+0672f1d3[ 	]+fadd.q[ 	]+invalid3,invalid5,invalid7
