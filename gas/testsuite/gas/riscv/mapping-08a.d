#as: -march=rv32i
#source: mapping-08.s
#objdump: --syms --special-syms

.*file format.*riscv.*

SYMBOL TABLE:
0+00 l    d  .text	0+00 .text
0+00 l    d  .data	0+00 .data
0+00 l    d  .bss	0+00 .bss
0+00 l    d  .text1	0+00 .text1
0+00 l       .text1	0+00 \$x
0+00 l    d  .text2	0+00 .text2
0+00 l       .text2	0+00 \$xrv32i2p1_c2p0
0+08 l       .text1	0+00 \$xrv32i2p1_c2p0
0+04 l       .text2	0+00 \$xrv32i2p1
0+0a l       .text1	0+00 \$xrv32i2p1
0+08 l       .text2	0+00 \$x
0+00 l    d  .riscv.attributes	0+00 .riscv.attributes
