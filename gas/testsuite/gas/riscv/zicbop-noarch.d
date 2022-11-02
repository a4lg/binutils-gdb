#as: -march=rv32i -I$srcdir/$subdir -defsym NOARCH=1
#source: zicbop.s
#objdump: -dr
#error_output: zicbop-noarch.l
