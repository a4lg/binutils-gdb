#as: -march=rv32i_zicond
#source: zicond.s
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0ec5d533[ 	]+czero\.eqz[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+0ef776b3[ 	]+czero\.nez[ 	]+a3,a4,a5
