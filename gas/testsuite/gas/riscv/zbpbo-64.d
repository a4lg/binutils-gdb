#as: -march=rv64i_zbpbo -defsym rv64=1
#source: zbpbo.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+08c5c533[ 	]+pack[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+48c5c533[ 	]+packu[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+0ac5e533[ 	]+max[ 		]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+0ac5c533[ 	]+min[ 		]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+6885d513[ 	]+rev8\.h[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+6ec59533[ 	]+cmix[ 	]+a0,a2,a1,a3
[ 	]+[0-9a-f]+:[ 	]+6bf5d513[ 	]+rev[ 		]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+6cc5d53b[ 	]+fsrw[ 	]+a0,a1,a3,a2
[ 	]+[0-9a-f]+:[ 	]+6ec59533[ 	]+cmix[ 	]+a0,a2,a1,a3
[ 	]+[0-9a-f]+:[ 	]+6885d513[ 	]+rev8\.h[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+08b64533[ 	]+pack[ 	]+a0,a2,a1
[ 	]+[0-9a-f]+:[ 	]+48b64533[ 	]+packu[ 	]+a0,a2,a1
