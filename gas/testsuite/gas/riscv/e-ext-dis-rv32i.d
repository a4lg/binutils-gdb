#as: -march=rv32i
#source: e-ext-dis.s
#objdump: -dr -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00f78793[ 	]+addi[ 	]+x15,x15,15
[ 	]+[0-9a-f]+:[ 	]+01ff8f93[ 	]+addi[ 	]+x31,x31,31
