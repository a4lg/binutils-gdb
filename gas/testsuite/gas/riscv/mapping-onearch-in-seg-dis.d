#as: -misa-spec=20191213 -march=rv32i2p1 -march-attr
#source: mapping-onearch-in-seg.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text.1.1:

0+000 <fadd_1>:
[ 	]+[0-9a-f]+:[ 	]+00b57553[ 	]+fadd\.s[ 	]+fa0,fa0,fa1
[ 	]+[0-9a-f]+:[ 	]+00008067[ 	]+ret

Disassembly of section .text.1.2:

0+000 <fadd_2>:
[ 	]+[0-9a-f]+:[ 	]+02b57553[ 	]+fadd\.d[ 	]+fa0,fa0,fa1
[ 	]+[0-9a-f]+:[ 	]+00008067[ 	]+ret

Disassembly of section .text.1.3:

0+000 <fadd_3>:
[ 	]+[0-9a-f]+:[ 	]+06b57553[ 	]+fadd\.q[ 	]+fa0,fa0,fa1
[ 	]+[0-9a-f]+:[ 	]+00008067[ 	]+ret

Disassembly of section .text.2:

0+000 <add_1>:
[ 	]+[0-9a-f]+:[ 	]+00b50533[ 	]+add[ 	]+a0,a0,a1
[ 	]+[0-9a-f]+:[ 	]+00008067[ 	]+ret
