#as: -march=rv64i_zba -defsym rv64=1
#source: zba.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+20c5a533[ 	]+sh1add[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5c533[ 	]+sh2add[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5e533[ 	]+sh3add[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5a53b[ 	]+sh1add\.uw[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5c53b[ 	]+sh2add\.uw[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+20c5e53b[ 	]+sh3add\.uw[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+08c5853b[ 	]+add.uw[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+0825951b[ 	]+slli.uw[ 	]+a0,a1,0x2
[ 	]+[0-9a-f]+:[ 	]+0805853b[ 	]+zext.w[ 	]+a0,a1
