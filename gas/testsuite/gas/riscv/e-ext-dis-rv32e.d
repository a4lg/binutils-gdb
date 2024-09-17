#as: -march=rv32e
#source: e-ext-dis.s
#objdump: -d -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00f78793[ 	]+add[ 	]+x15,x15,15
[ 	]+[0-9a-f]+:[ 	]+01ff8f93[ 	]+add[ 	]+invalid31,invalid31,31
