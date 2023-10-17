#as: -march=rv64i_zacas
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+28f6a5af[ 	]+amocas\.w[ 		]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2cf6a5af[ 	]+amocas\.w\.aq[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2af6a5af[ 	]+amocas\.w\.rl[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ef6a5af[ 	]+amocas\.w\.aqrl[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+28f6b5af[ 	]+amocas\.d[ 		]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2cf6b5af[ 	]+amocas\.d\.aq[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2af6b5af[ 	]+amocas\.d\.rl[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ef6b5af[ 	]+amocas\.d\.aqrl[ 	]+a1,a5,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+28e6c52f[ 	]+amocas\.q[ 		]+a0,a4,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ce6c52f[ 	]+amocas\.q\.aq[ 	]+a0,a4,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ae6c52f[ 	]+amocas\.q\.rl[ 	]+a0,a4,\(a3\)
[ 	]+[0-9a-f]+:[ 	]+2ee6c52f[ 	]+amocas\.q\.aqrl[ 	]+a0,a4,\(a3\)
