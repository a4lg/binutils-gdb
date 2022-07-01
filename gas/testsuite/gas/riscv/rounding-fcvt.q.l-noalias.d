#as: -march=rv64ifdq
#source: rounding-fcvt.q.l.s
#warning_output: rounding-fcvt.q.l.l
#objdump: -dr -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+d62280d3[ 	]+fcvt\.q\.l[ 	]+ft1,t0
[ 	]+[0-9a-f]+:[ 	]+d622f0d3[ 	]+fcvt\.q\.l[ 	]+ft1,t0,dyn
[ 	]+[0-9a-f]+:[ 	]+d63280d3[ 	]+fcvt\.q\.lu[ 	]+ft1,t0
[ 	]+[0-9a-f]+:[ 	]+d632f0d3[ 	]+fcvt\.q\.lu[ 	]+ft1,t0,dyn
