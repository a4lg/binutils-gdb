#as: -march=rv32i_zve32f -mcsr-check
#source: vector-csrs.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00802573[ 	]+csrr[ 	]+a0,vstart
[ 	]+[0-9a-f]+:[ 	]+00801073[ 	]+csrw[ 	]+vstart,zero
[ 	]+[0-9a-f]+:[ 	]+00902573[ 	]+csrr[ 	]+a0,vxsat
[ 	]+[0-9a-f]+:[ 	]+0090d073[ 	]+csrwi[ 	]+vxsat,1
[ 	]+[0-9a-f]+:[ 	]+00a02573[ 	]+csrr[ 	]+a0,vxrm
[ 	]+[0-9a-f]+:[ 	]+00a1d073[ 	]+csrwi[ 	]+vxrm,3
[ 	]+[0-9a-f]+:[ 	]+00f02573[ 	]+csrr[ 	]+a0,vcsr
[ 	]+[0-9a-f]+:[ 	]+00f3d073[ 	]+csrwi[ 	]+vcsr,7
[ 	]+[0-9a-f]+:[ 	]+c2002573[ 	]+csrr[ 	]+a0,vl
[ 	]+[0-9a-f]+:[ 	]+c2102573[ 	]+csrr[ 	]+a0,vtype
[ 	]+[0-9a-f]+:[ 	]+c2202573[ 	]+csrr[ 	]+a0,vlenb
