#as: -march=rv32if
#source: mapping-06.s
#objdump: --syms --special-syms

.*file format.*riscv.*

SYMBOL TABLE:
0+00 l    d  .text	0+00 .text
0+00 l    d  .data	0+00 .data
0+00 l    d  .bss	0+00 .bss
0+00 l       .text	0+00 \$x
0+04 l       .text	0+00 \$xrv32i2p1_zicsr2p0_zfinx1p0
0+08 l       .text	0+00 \$x
0+00 l    d  .riscv.attributes	0+00 .riscv.attributes
