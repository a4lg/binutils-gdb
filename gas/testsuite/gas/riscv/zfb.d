#as: -march=rv64iq_zfb
#source: zfb.s
#objdump: -dr

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+283100d3[ 	]+fmin\.s[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+283120d3[ 	]+fmini\.s[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2a3100d3[ 	]+fmin\.d[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2a3120d3[ 	]+fmini\.d[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2e3100d3[ 	]+fmin\.q[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2e3120d3[ 	]+fmini\.q[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+283110d3[ 	]+fmax\.s[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+283130d3[ 	]+fmaxi\.s[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2a3110d3[ 	]+fmax\.d[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2a3130d3[ 	]+fmaxi\.d[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2e3110d3[ 	]+fmax\.q[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+2e3130d3[ 	]+fmaxi\.q[ 	]+ft1,ft2,ft3
[ 	]+[0-9a-f]+:[ 	]+a0209553[ 	]+flt\.s[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a020d553[ 	]+fltq\.s[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a2209553[ 	]+flt\.d[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a220d553[ 	]+fltq\.d[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a6209553[ 	]+flt\.q[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a620d553[ 	]+fltq\.q[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a0208553[ 	]+fle\.s[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a020c553[ 	]+fleq\.s[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a2208553[ 	]+fle\.d[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a220c553[ 	]+fleq\.d[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a6208553[ 	]+fle\.q[ 	]+a0,ft1,ft2
[ 	]+[0-9a-f]+:[ 	]+a620c553[ 	]+fleq\.q[ 	]+a0,ft1,ft2
