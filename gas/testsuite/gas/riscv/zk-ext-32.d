#as: -march=rv32i -mcsr-check -I$srcdir/$subdir
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+aac58533[ 	]+aes32dsi[ 	]+a0,a1,a2,0x2
[ 	]+[0-9a-f]+:[ 	]+aec58533[ 	]+aes32dsmi[ 	]+a0,a1,a2,0x2
[ 	]+[0-9a-f]+:[ 	]+a2c58533[ 	]+aes32esi[ 	]+a0,a1,a2,0x2
[ 	]+[0-9a-f]+:[ 	]+a6c58533[ 	]+aes32esmi[ 	]+a0,a1,a2,0x2
[ 	]+[0-9a-f]+:[ 	]+10259513[ 	]+sha256sig0[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+10359513[ 	]+sha256sig1[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+10059513[ 	]+sha256sum0[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+10159513[ 	]+sha256sum1[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+5cc58533[ 	]+sha512sig0h[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+54c58533[ 	]+sha512sig0l[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+5ec58533[ 	]+sha512sig1h[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+56c58533[ 	]+sha512sig1l[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+50c58533[ 	]+sha512sum0r[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+52c58533[ 	]+sha512sum1r[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+b0c58533[ 	]+sm4ed[ 	]+a0,a1,a2,0x2
[ 	]+[0-9a-f]+:[ 	]+b4c58533[ 	]+sm4ks[ 	]+a0,a1,a2,0x2
[ 	]+[0-9a-f]+:[ 	]+10859513[ 	]+sm3p0[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+10959513[ 	]+sm3p1[ 	]+a0,a1
[ 	]+[0-9a-f]+:[ 	]+01502573[ 	]+csrr[ 	]+a0,seed
