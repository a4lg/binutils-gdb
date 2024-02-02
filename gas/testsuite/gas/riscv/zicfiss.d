#as: -march=rv32i_zicfiss
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+6081[ 	]+sspush[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+6081[ 	]+sspush[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+6281[ 	]+sspopchk[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+6281[ 	]+sspopchk[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+6081[ 	]+sspush[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+82504073[ 	]+sspush[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+81c0c073[ 	]+sspopchk[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+6281[ 	]+sspopchk[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+6181[ 	]+ssincp
[ 	]+[0-9a-f]+:[ 	]+81d042f3[ 	]+ssrdp[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+81d04573[ 	]+ssrdp[ 	]+a0
