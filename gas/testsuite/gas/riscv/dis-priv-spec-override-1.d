#as: -march=rv64i_zicsr -mpriv-spec=1.11
#source: dis-priv-spec-override.s
#objdump: -d -M priv-spec=1.12

.*:[ 	]+file format .*

Disassembly of section .text:

0+000 <target>:
[ 	]+[0-9a-f]+:[ 	]+3d002573[ 	]+csrr[ 	]+a0,pmpaddr32
