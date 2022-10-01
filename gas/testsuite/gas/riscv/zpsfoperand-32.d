#as: -march=rv32i_zpsfoperand -defsym rv32=1
#source: zpsfoperand.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+a0f68577[ 	]+smul16[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a2f68577[ 	]+smulx16[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b0f68577[ 	]+umul16[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b2f68577[ 	]+umulx16[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a8f68577[ 	]+smul8[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+aaf68577[ 	]+smulx8[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b8f68577[ 	]+umul8[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+baf68577[ 	]+umulx8[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+5ef61577[ 	]+smal[ 	]+a0,a2,a5
[ 	]+[0-9a-f]+:[ 	]+c0e61577[ 	]+add64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+80e61577[ 	]+radd64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+a0e61577[ 	]+uradd64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+90e61577[ 	]+kadd64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+b0e61577[ 	]+ukadd64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+c2e61577[ 	]+sub64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+82e61577[ 	]+rsub64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+a2e61577[ 	]+ursub64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+92e61577[ 	]+ksub64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+b2e61577[ 	]+uksub64[ 	]+a0,a2,a4
[ 	]+[0-9a-f]+:[ 	]+84f69577[ 	]+smar64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+86f69577[ 	]+smsr64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a4f69577[ 	]+umar64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a6f69577[ 	]+umsr64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+94f69577[ 	]+kmar64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+96f69577[ 	]+kmsr64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b4f69577[ 	]+ukmar64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b6f69577[ 	]+ukmsr64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+88f69577[ 	]+smalbb[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+98f69577[ 	]+smalbt[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a8f69577[ 	]+smaltt[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+8cf69577[ 	]+smalda[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+9cf69577[ 	]+smalxda[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+8af69577[ 	]+smalds[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+9af69577[ 	]+smaldrs[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+aaf69577[ 	]+smalxds[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+acf69577[ 	]+smslda[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+bcf69577[ 	]+smslxda[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+f0f69577[ 	]+mulr64[ 	]+a0,a3,a5
[ 	]+[0-9a-f]+:[ 	]+e0f69577[ 	]+mulsr64[ 	]+a0,a3,a5
