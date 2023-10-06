#as: -march=rv64i_zicsr_smaia -mcsr-check
#source: csr-complex.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+35002573[ 	]+csrr[ 	]+a0,miselect
