#as: -march=rv32i_zics
#objdump: -d

.*:[	 ]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+00f52063[	 ]+beqi[	 ]+a0,15,0 <target>
[ 	]+[0-9a-f]+:[ 	]+01052063[	 ]+beqi[	 ]+a0,-16,4 <target\+0x4>
[ 	]+[0-9a-f]+:[ 	]+fef53ce3[	 ]+bnei[	 ]+a0,15,0 <target>
[ 	]+[0-9a-f]+:[ 	]+01053063[	 ]+bnei[	 ]+a0,-16,c <target\+0xc>
[ 	]+[0-9a-f]+:[ 	]+02628033[	 ]+mvp0[	 ]+a0,a1,t0,t1
[ 	]+[0-9a-f]+:[ 	]+02628033[	 ]+mvp0[	 ]+a0,a1,t0,t1
[ 	]+[0-9a-f]+:[ 	]+04628033[	 ]+mvp2[	 ]+a2,a3,t0,t1
[ 	]+[0-9a-f]+:[ 	]+04628033[	 ]+mvp2[	 ]+a2,a3,t0,t1
