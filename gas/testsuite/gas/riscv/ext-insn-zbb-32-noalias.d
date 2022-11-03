#as: -march=rv32i_zbb -I$srcdir/$subdir -defsym XLEN=32
#source: ext-insn.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0ff57513[ 	]+andi[ 	]+a0,a0,255
[ 	]+[0-9a-f]+:[ 	]+08054533[ 	]+zext\.h[ 	]+a0,a0
[ 	]+[0-9a-f]+:[ 	]+60451513[ 	]+sext\.b[ 	]+a0,a0
[ 	]+[0-9a-f]+:[ 	]+60551513[ 	]+sext\.h[ 	]+a0,a0
[ 	]+[0-9a-f]+:[ 	]+0ff67593[ 	]+andi[ 	]+a1,a2,255
[ 	]+[0-9a-f]+:[ 	]+080645b3[ 	]+zext\.h[ 	]+a1,a2
[ 	]+[0-9a-f]+:[ 	]+60461593[ 	]+sext\.b[ 	]+a1,a2
[ 	]+[0-9a-f]+:[ 	]+60561593[ 	]+sext\.h[ 	]+a1,a2
[ 	]+[0-9a-f]+:[ 	]+0ff57513[ 	]+andi[ 	]+a0,a0,255
[ 	]+[0-9a-f]+:[ 	]+08054533[ 	]+zext\.h[ 	]+a0,a0
[ 	]+[0-9a-f]+:[ 	]+60451513[ 	]+sext\.b[ 	]+a0,a0
[ 	]+[0-9a-f]+:[ 	]+60551513[ 	]+sext\.h[ 	]+a0,a0
[ 	]+[0-9a-f]+:[ 	]+0ff67593[ 	]+andi[ 	]+a1,a2,255
[ 	]+[0-9a-f]+:[ 	]+080645b3[ 	]+zext\.h[ 	]+a1,a2
[ 	]+[0-9a-f]+:[ 	]+60461593[ 	]+sext\.b[ 	]+a1,a2
[ 	]+[0-9a-f]+:[ 	]+60561593[ 	]+sext\.h[ 	]+a1,a2
#...
