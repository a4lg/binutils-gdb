#as: -march=rv32i -I$srcdir/$subdir -defsym XLEN=32 -defsym NOARCH=1
#source: ext-insn.s
#error_output: ext-insn-32-noarch.l
