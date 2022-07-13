#as: -march=rv64ic_zba_zbb_zbs
#source: shamt-dis.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+01f59513[ 	]+slli[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+02059513[ 	]+slli[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+01f5d513[ 	]+srli[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+0205d513[ 	]+srli[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+41f5d513[ 	]+srai[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+4205d513[ 	]+srai[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+057e[ 	]+c\.slli[ 	]+a0,0x1f
[ 	]+[0-9a-f]+:[ 	]+1502[ 	]+c\.slli[ 	]+a0,0x20
[ 	]+[0-9a-f]+:[ 	]+817d[ 	]+c\.srli[ 	]+a0,0x1f
[ 	]+[0-9a-f]+:[ 	]+9101[ 	]+c\.srli[ 	]+a0,0x20
[ 	]+[0-9a-f]+:[ 	]+857d[ 	]+c\.srai[ 	]+a0,0x1f
[ 	]+[0-9a-f]+:[ 	]+9501[ 	]+c\.srai[ 	]+a0,0x20
[ 	]+[0-9a-f]+:[ 	]+61f5d513[ 	]+rori[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+6205d513[ 	]+rori[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+09f5951b[ 	]+slli\.uw[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+0a05951b[ 	]+slli\.uw[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+49f59513[ 	]+bclri[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+4a059513[ 	]+bclri[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+29f59513[ 	]+bseti[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+2a059513[ 	]+bseti[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+69f59513[ 	]+binvi[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+6a059513[ 	]+binvi[ 	]+a0,a1,0x20
[ 	]+[0-9a-f]+:[ 	]+49f5d513[ 	]+bexti[ 	]+a0,a1,0x1f
[ 	]+[0-9a-f]+:[ 	]+4a05d513[ 	]+bexti[ 	]+a0,a1,0x20
