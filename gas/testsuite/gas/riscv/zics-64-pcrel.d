#as: -march=rv64ic_zics
#objdump: -d

.*:[	 ]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+0:[ 	]+d800f503[	 ]+ld[	 ]+a0,8 <target\+0x8>
[ 	]+4:[ 	]+f000f503[	 ]+lwu[	 ]+a0,8 <target\+0x8>
[ 	]+4:[ 	]+0001[		 ]+nop
[ 	]+6:[ 	]+f000f503[	 ]+lwu[	 ]+a0,8 <target\+0x8>
[ 	]+a:[ 	]+0001[		 ]+nop
[ 	]+c:[ 	]+0001[		 ]+nop
[ 	]+e:[ 	]+0001[		 ]+nop
[ 	]+10:[ 	]+d800f503[	 ]+ld[	 ]+a0,18 <target\+0x18>
[ 	]+14:[ 	]+0001[		 ]+nop
[ 	]+16:[ 	]+d800f503[	 ]+ld[	 ]+a0,18 <target\+0x18>
[ 	]+1a:[ 	]+0001[		 ]+nop
[ 	]+1c:[ 	]+d800f503[	 ]+ld[	 ]+a0,20 <target\+0x20>
[ 	]+20:[ 	]+0001[		 ]+nop
[ 	]+22:[ 	]+d800f503[	 ]+ld[	 ]+a0,28 <target\+0x28>
