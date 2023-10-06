#as: -march=rv64i_zicsr -mcsr-check
#source: csr-complex.s
#warning_output: csr-complex-1.l
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+35002573[ 	]+csrr[ 	]+a0,miselect
