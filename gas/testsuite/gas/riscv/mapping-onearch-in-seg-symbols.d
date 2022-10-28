#as: -misa-spec=20191213 -march=rv32i2p1 -march-attr
#source: mapping-onearch-in-seg.s
#objdump: --syms --special-syms

.*file format.*riscv.*

SYMBOL TABLE:
0+00 l    d  .text	0+00 .text
0+00 l    d  .data	0+00 .data
0+00 l    d  .bss	0+00 .bss
0+00 l    d  .text.1.1	0+00 .text.1.1
0+00 l       .text.1.1	0+00 fadd_1
0+00 l       .text.1.1	0+00 \$xrv32i2p1_f2p2_zicsr2p0
0+00 l    d  .text.1.2	0+00 .text.1.2
0+00 l       .text.1.2	0+00 fadd_2
0+00 l       .text.1.2	0+00 \$xrv32i2p1_f2p2_d2p2_zicsr2p0
0+00 l    d  .text.1.3	0+00 .text.1.3
0+00 l       .text.1.3	0+00 fadd_3
0+00 l       .text.1.3	0+00 \$xrv32i2p1_f2p2_d2p2_q2p2_zicsr2p0
0+00 l    d  .text.2	0+00 .text.2
0+00 l       .text.2	0+00 add_1
0+00 l       .text.2	0+00 \$x
0+00 l    d  .riscv.attributes	0+00 .riscv.attributes
