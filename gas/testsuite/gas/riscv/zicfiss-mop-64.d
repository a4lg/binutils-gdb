#as: -march=rv64ic_zicfiss
#source: zicfiss-mop.s
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+81c040f3[ 	]+ssld[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+81c042f3[ 	]+ssld[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+81c0c073[ 	]+sspopchk[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+81c2c073[ 	]+sspopchk[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+81d04ff3[ 	]+ssrdp[ 	]+t6
[ 	]+[0-9a-f]+:[ 	]+82104073[ 	]+sspush[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+82504073[ 	]+sspush[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+6081[ 	]+sspush[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+6181[ 	]+ssincp
[ 	]+[0-9a-f]+:[ 	]+6281[ 	]+sspopchk[ 	]+t0
