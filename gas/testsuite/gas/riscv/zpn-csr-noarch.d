#as: -march=rv32i_zicsr -mcsr-check
#source: zpn-csr.s
#objdump: -d -M no-aliases
#warning_output: zpn-csr-noarch.l

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00902573[ 	]+csrrs[ 	]+a0,vxsat,zero
[ 	]+[0-9a-f]+:[ 	]+0090f073[ 	]+csrrci[ 	]+zero,vxsat,1
