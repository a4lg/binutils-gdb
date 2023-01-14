#as: -march=rv32i_zmmul -I$srcdir/$subdir -defsym XLEN=32 -defsym NOARCH_ARCH=1
#source: m-ext.s
#objdump: -d
#error_output: m-ext-32-noarch-m.l
