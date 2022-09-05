#as: -march=rv32i_zicsr_zkr -mcsr-check
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+01502573[ 	]+csrr[ 	]+a0,seed
