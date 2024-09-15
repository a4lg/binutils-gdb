#as: -march=rv64i_zpsfoperand -defsym rv64=1
#source: zpsfoperand-64.s
#objdump: -d -M no-aliases

.*:[ 	]+file format .*


Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+a0f684f7[ 	]+smul16[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a2f684f7[ 	]+smulx16[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b0f684f7[ 	]+umul16[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b2f684f7[ 	]+umulx16[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a8f684f7[ 	]+smul8[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+aaf684f7[ 	]+smulx8[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b8f684f7[ 	]+umul8[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+baf684f7[ 	]+umulx8[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+5ef614f7[ 	]+smal[ 	]+s1,a2,a5
[ 	]+[0-9a-f]+:[ 	]+5ef59577[ 	]+smal[ 	]+a0,a1,a5
[ 	]+[0-9a-f]+:[ 	]+80e614f7[ 	]+radd64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+80e59577[ 	]+radd64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+80d61577[ 	]+radd64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+a0e614f7[ 	]+uradd64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+a0e59577[ 	]+uradd64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+a0d61577[ 	]+uradd64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+90e614f7[ 	]+kadd64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+90e59577[ 	]+kadd64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+90d61577[ 	]+kadd64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+b0e614f7[ 	]+ukadd64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+b0e59577[ 	]+ukadd64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+b0d61577[ 	]+ukadd64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+82e614f7[ 	]+rsub64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+82e59577[ 	]+rsub64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+82d61577[ 	]+rsub64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+a2e614f7[ 	]+ursub64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+a2e59577[ 	]+ursub64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+a2d61577[ 	]+ursub64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+92e614f7[ 	]+ksub64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+92e59577[ 	]+ksub64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+92d61577[ 	]+ksub64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+b2e614f7[ 	]+uksub64[ 	]+s1,a2,a4
[ 	]+[0-9a-f]+:[ 	]+b2e59577[ 	]+uksub64[ 	]+a0,a1,a4
[ 	]+[0-9a-f]+:[ 	]+b2d61577[ 	]+uksub64[ 	]+a0,a2,a3
[ 	]+[0-9a-f]+:[ 	]+84f694f7[ 	]+smar64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+86f694f7[ 	]+smsr64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a4f694f7[ 	]+umar64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a6f694f7[ 	]+umsr64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+94f694f7[ 	]+kmar64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+96f694f7[ 	]+kmsr64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b4f694f7[ 	]+ukmar64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+b6f694f7[ 	]+ukmsr64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+88f694f7[ 	]+smalbb[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+98f694f7[ 	]+smalbt[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+a8f694f7[ 	]+smaltt[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+8cf694f7[ 	]+smalda[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+9cf694f7[ 	]+smalxda[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+8af694f7[ 	]+smalds[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+9af694f7[ 	]+smaldrs[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+aaf694f7[ 	]+smalxds[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+acf694f7[ 	]+smslda[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+bcf694f7[ 	]+smslxda[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+f0f694f7[ 	]+mulr64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+e0f694f7[ 	]+mulsr64[ 	]+s1,a3,a5
[ 	]+[0-9a-f]+:[ 	]+dff685f7[ 	]+wexti[ 	]+a1,a3,0x1f
