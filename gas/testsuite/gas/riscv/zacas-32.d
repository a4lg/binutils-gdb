#as: -march=rv32i_zacas
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+28f6a5af[ 	]+amocas\.w[ 		]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2cf6a5af[ 	]+amocas\.w\.aq[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2af6a5af[ 	]+amocas\.w\.rl[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ef6a5af[ 	]+amocas\.w\.aqrl[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+28e6b52f[ 	]+amocas\.d[ 		]+a0,a4,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ce6b52f[ 	]+amocas\.d\.aq[ 	]+a0,a4,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ae6b52f[ 	]+amocas\.d\.rl[ 	]+a0,a4,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ee6b52f[ 	]+amocas\.d\.aqrl[ 	]+a0,a4,\(a3\)
