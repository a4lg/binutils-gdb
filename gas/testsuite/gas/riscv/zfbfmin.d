#as: -march=rv32i_zfbfmin
#objdump: -d

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+4485f553[ 	]+fcvt\.bf16\.s[ 	]+fa0,fa1
[ 	]+[0-9a-f]+:[ 	]+44859553[ 	]+fcvt\.bf16\.s[ 	]+fa0,fa1,rtz
[ 	]+[0-9a-f]+:[ 	]+40658553[ 	]+fcvt\.s\.bf16[ 	]+fa0,fa1
[ 	]+[0-9a-f]+:[ 	]+00059507[ 	]+flh[ 	]+fa0,0\(a1\)
[ 	]+[0-9a-f]+:[ 	]+00a59027[ 	]+fsh[ 	]+fa0,0\(a1\)
[ 	]+[0-9a-f]+:[ 	]+e4058553[ 	]+fmv\.x\.h[ 	]+a0,fa1
[ 	]+[0-9a-f]+:[ 	]+f4058553[ 	]+fmv\.h\.x[ 	]+fa0,a1
