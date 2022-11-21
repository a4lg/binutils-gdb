#as: -march=rv32i_zisslpcfi
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+81c0c073[ 	]+sspush[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+81c2c073[ 	]+sspush[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+81c040f3[ 	]+sspop[ 	]+ra
[ 	]+[0-9a-f]+:[ 	]+81c042f3[ 	]+sspop[ 	]+t0
[ 	]+[0-9a-f]+:[ 	]+81d04573[ 	]+ssprr[ 	]+a0
[ 	]+[0-9a-f]+:[ 	]+82d645f3[ 	]+ssamoswap[ 	]+a1,a2,a3
[ 	]+[0-9a-f]+:[ 	]+820542f3[ 	]+ssamoswap[ 	]+t0,a0,zero
[ 	]+[0-9a-f]+:[ 	]+82f04773[ 	]+ssamoswap[ 	]+a4,zero,a5
[ 	]+[0-9a-f]+:[ 	]+8a12c073[ 	]+sschkra[ 	]+t0,ra
[ 	]+[0-9a-f]+:[ 	]+8a12c073[ 	]+sschkra[ 	]+t0,ra
[ 	]+[0-9a-f]+:[ 	]+82004073[ 	]+lpsll[ 	]+0x0
[ 	]+[0-9a-f]+:[ 	]+82ffc073[ 	]+lpsll[ 	]+0x1ff
[ 	]+[0-9a-f]+:[ 	]+83004073[ 	]+lpcll[ 	]+0x0
[ 	]+[0-9a-f]+:[ 	]+83ffc073[ 	]+lpcll[ 	]+0x1ff
[ 	]+[0-9a-f]+:[ 	]+86004073[ 	]+lpsml[ 	]+0x0
[ 	]+[0-9a-f]+:[ 	]+867fc073[ 	]+lpsml[ 	]+0xff
[ 	]+[0-9a-f]+:[ 	]+86804073[ 	]+lpcml[ 	]+0x0
[ 	]+[0-9a-f]+:[ 	]+86ffc073[ 	]+lpcml[ 	]+0xff
[ 	]+[0-9a-f]+:[ 	]+87004073[ 	]+lpsul[ 	]+0x0
[ 	]+[0-9a-f]+:[ 	]+877fc073[ 	]+lpsul[ 	]+0xff
[ 	]+[0-9a-f]+:[ 	]+87804073[ 	]+lpcul[ 	]+0x0
[ 	]+[0-9a-f]+:[ 	]+87ffc073[ 	]+lpcul[ 	]+0xff
