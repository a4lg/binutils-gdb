#as: -march=rv32i -defsym XLEN=32
#source: dis-addr-topaddr-zero.s
#objdump: -d

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+fff00283[ 	]+lb[   	]+t0,-1\(zero\) # ffffffff <addr_top>
