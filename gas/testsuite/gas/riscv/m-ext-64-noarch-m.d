#as: -march=rv64i_zmmul -I$srcdir/$subdir -defsym XLEN=64 -defsym NOARCH_ARCH=1
#source: m-ext.s
#objdump: -d
#error_output: m-ext-64-noarch-m.l
