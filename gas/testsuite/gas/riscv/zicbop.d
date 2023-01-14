#as: -march=rv32i -I$srcdir/$subdir
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0000e013[ 	]+prefetch\.i[ 	]+0\(ra\)
[ 	]+[0-9a-f]+:[ 	]+0200e013[ 	]+prefetch\.i[ 	]+32\(ra\)
[ 	]+[0-9a-f]+:[ 	]+00186013[ 	]+prefetch\.r[ 	]+0\(a6\)
[ 	]+[0-9a-f]+:[ 	]+80186013[ 	]+prefetch\.r[ 	]+-2048\(a6\)
[ 	]+[0-9a-f]+:[ 	]+003fe013[ 	]+prefetch\.w[ 	]+0\(t6\)
[ 	]+[0-9a-f]+:[ 	]+7e3fe013[ 	]+prefetch\.w[ 	]+2016\(t6\)
