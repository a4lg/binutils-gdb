#as: -march=rv64i -I$srcdir/$subdir -defsym XLEN=64 -defsym NOARCH=1
#source: m-ext.s
#objdump: -d
#error_output: m-ext-64-noarch.l
