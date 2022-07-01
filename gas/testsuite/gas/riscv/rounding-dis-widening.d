#as: -march=rv64ifd
#source: rounding-dis-widening.s
#objdump: -dr

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+420100d3[ 	]+fcvt\.d\.s[ 	]+ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+420170d3[ 	]+fcvt\.d\.s[ 	]+ft1,ft2
