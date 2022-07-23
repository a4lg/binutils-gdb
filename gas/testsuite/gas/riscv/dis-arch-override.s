# Assembler configuration:
#    -march=rv64imfd_zbb
# Disassembler configurations:
#    Test 1: -d
#    Test 2: -d -M arch=rv32im_zfinx_zbkb
#    Test 3: -d -m riscv -M arch=rv32im_zfinx_zbkb,numeric

target:
	# Assembler               : fadd.s (F)
	# Disassembler (test 2/3) : fadd.s (Zfinx)
	# Test that all three operands point to GPRs.
	fadd.s	ft0, fa1, fa2

	# Assembler               : fadd.d (D)
	# Disassembler (test 2/3) : (invalid)
	# On disassembler option on test 2, Zdinx is not present.  So,
	# it should be disassembled as an invalid instruction.
	fadd.d	ft0, fa1, fa2

	# Assembler               : csrr (Zicsr)
	# Disassembler (test 2/3) : csrr (Zicsr)
	# When assembling, Zicsr is implied by F.  When disassembling,
	# Zicsr is implied by Zfinx.  On both cases, csrr should be
	# disassembled as csrr.
	csrr	a0, misa

	# Assembler               : zext.h (Zbb)
	# Disassembler (test 2)   : packw  (Zbkb)
	# Disassembler (test 3)   : (invalid)
	# Since zext.h specialized instruction does not exist in Zbkb
	# and we disassemble the output with Zbkb, this instruction
	# should be disassembled as a packw instruction (on RV64).
	#
	# We specify arch=rv32im_zfinx_zbkb on disassembling on test
	# 2 and 3.  But, XLEN part of the ISA string is effective
	# only if XLEN-neutral machine is specified by `-m riscv' option
	# (because we are disassembling 64-bit RISC-V ELF file, BFD
	# architecture is set to `riscv:rv64' unless `-m' option
	# is specified).
	#
	# As a result, test 3 (with `-m riscv' option) disassembles with
	# RV32 but test 2 (without it) does with RV64.
	# It changes the result of disassembling since packw instruction
	# is invalid on RV32.
	zext.h	a0, a1
