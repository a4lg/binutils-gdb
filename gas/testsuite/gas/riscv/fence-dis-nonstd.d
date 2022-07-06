#as: -march=rv32i
#source: fence-dis-nonstd.s
#objdump: -dr

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+0ff0000f[ 	]+fence
[ 	]+[0-9a-f]+:[ 	]+8330000f[ 	]+fence\.tso
[ 	]+[0-9a-f]+:[ 	]+0ff0000f[ 	]+fence
[ 	]+[0-9a-f]+:[ 	]+8330000f[ 	]+fence\.tso
[ 	]+[0-9a-f]+:[ 	]+0100000f[ 	]+fence[ 	]+w,none
[ 	]+[0-9a-f]+:[ 	]+0cf00f8f[ 	]+fence[ 	]+io,iorw
[ 	]+[0-9a-f]+:[ 	]+0fcf800f[ 	]+fence[ 	]+iorw,io
[ 	]+[0-9a-f]+:[ 	]+83300f8f[ 	]+fence\.tso
[ 	]+[0-9a-f]+:[ 	]+833f800f[ 	]+fence\.tso
[ 	]+[0-9a-f]+:[ 	]+8ff0000f[ 	]+fence[ 	]+iorw,iorw
[ 	]+[0-9a-f]+:[ 	]+1330000f[ 	]+fence[ 	]+rw,rw
