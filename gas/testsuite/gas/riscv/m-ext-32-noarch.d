#as: -march=rv32i -I$srcdir/$subdir -defsym XLEN=32 -defsym NOARCH=1
#source: m-ext.s
#objdump: -d
#error_output: m-ext-32-noarch.l
