#as: -march=rv32ic_zicfilp
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+12345017[ 	]+lpad[ 	]+0x12345
[ 	]+[0-9a-f]+:[ 	]+12345017[ 	]+lpad[ 	]+0x12345
[ 	]+[0-9a-f]+:[ 	]+0001[ 	]+nop
[ 	]+[0-9a-f]+:[ 	]+f0123017[ 	]+lpad[ 	]+0xf0123
[ 	]+[0-9a-f]+:[ 	]+f0123017[ 	]+lpad[ 	]+0xf0123
