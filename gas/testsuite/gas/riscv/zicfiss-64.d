#as: -march=rv64ic_zicfiss
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+81c040f3[ 	]+ssld[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+81c042f3[ 	]+ssld[ 	]+t0
