#as: -march=rv64i_zbs -defsym rv64=1
#source: zbs.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+48059513[ 	]+bclri[ 	]+a0,a1,0x0
[ 	]+[0-9a-f]+:[ 	]+49f59513[ 	]+bclri[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+28059513[ 	]+bseti[ 	]+a0,a1,0x0
[ 	]+[0-9a-f]+:[ 	]+29f59513[ 	]+bseti[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+68059513[ 	]+binvi[ 	]+a0,a1,0x0
[ 	]+[0-9a-f]+:[ 	]+69f59513[ 	]+binvi[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+4805d513[ 	]+bexti[ 	]+a0,a1,0x0
[ 	]+[0-9a-f]+:[ 	]+49f5d513[ 	]+bexti[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+48c59533[ 	]+bclr[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+28c59533[ 	]+bset[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+68c59533[ 	]+binv[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+48c5d533[ 	]+bext[ 	]+a0,a1,a2
[ 	]+[0-9a-f]+:[ 	]+49f59513[ 	]+bclri[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+29f59513[ 	]+bseti[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+69f59513[ 	]+binvi[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+49f5d513[ 	]+bexti[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+4bf59513[ 	]+bclri[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+2bf59513[ 	]+bseti[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+6bf59513[ 	]+binvi[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+4bf5d513[ 	]+bexti[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+4bf59513[ 	]+bclri[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+2bf59513[ 	]+bseti[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+6bf59513[ 	]+binvi[ 	]+a0,a1,0x3f
[ 	]+[0-9a-f]+:[ 	]+4bf5d513[ 	]+bexti[ 	]+a0,a1,0x3f
