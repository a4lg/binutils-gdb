#as: -march=rv32e
#source: e-ext-dis.s
#objdump: -dr -M numeric

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00f78793[ 	]+addi[ 	]+x15,x15,15
[ 	]+[0-9a-f]+:[ 	]+01ff8f93[ 	]+addi[ 	]+invalid31,invalid31,31
