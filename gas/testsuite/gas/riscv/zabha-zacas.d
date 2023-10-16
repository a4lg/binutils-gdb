#as: -march=rv32i_zabha_zacas
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+28c5852f[ 	]+amocas\.b[ 		]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+2cc5852f[ 	]+amocas\.b\.aq[ 	]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+2ac5852f[ 	]+amocas\.b\.rl[ 	]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+2ec5852f[ 	]+amocas\.b\.aqrl[ 	]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+28c5952f[ 	]+amocas\.h[ 		]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+2cc5952f[ 	]+amocas\.h\.aq[ 	]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+2ac5952f[ 	]+amocas\.h\.rl[ 	]+a0,a2,\(a1\)
[ 	]+[0-9a-f]+:[ 	]+2ec5952f[ 	]+amocas\.h\.aqrl[ 	]+a0,a2,\(a1\)
