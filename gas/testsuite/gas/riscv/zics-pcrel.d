#as: -march=rv32ic_zics
#objdump: -d

.*:[	 ]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+0:[ 	]+c800f503[	 ]+lh[	 ]+a0,2 <target\+0x2>
[ 	]+4:[ 	]+e800f503[	 ]+lhu[	 ]+a0,6 <target\+0x6>
[ 	]+8:[ 	]+d000f503[	 ]+lw[	 ]+a0,c <target\+0xc>
[ 	]+c:[ 	]+0001[		 ]+nop
[ 	]+e:[ 	]+c800f503[	 ]+lh[	 ]+a0,10 <target\+0x10>
[ 	]+12:[ 	]+e800f503[	 ]+lhu[	 ]+a0,14 <target\+0x14>
[ 	]+16:[ 	]+d000f503[	 ]+lw[	 ]+a0,18 <target\+0x18>
