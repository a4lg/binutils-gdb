# In following examples, we use the same architecture per section
# (do not change the architecture *during* a section).


	.section .text.1.1, "ax", %progbits
fadd_1:
	.option	push
	.option	arch, rv32i2p1_f2p2_zicsr2p0
	fadd.s	fa0, fa0, fa1			# rv32if_zicsr
	ret					# rv32if_zicsr
	.option pop
	# rv32i


	.section .text.1.2, "ax", %progbits
fadd_2:
	.option	arch, rv32i2p1_f2p2_d2p2_zicsr2p0
	fadd.d	fa0, fa0, fa1			# rv32ifd_zicsr
	.option	arch, rv32i2p1_f2p2_d2p2_zicsr2p0
	ret					# rv32ifd_zicsr
	# rv32ifd_zicsr


	.section .text.1.3, "ax", %progbits
fadd_3:
	.option	push
	.option	arch, +q
	fadd.q	fa0, fa0, fa1			# rv32ifdq_zicsr
	.option	pop
	.option	push
	.option	arch, rv32i2p1_f2p2_d2p2_q2p2_zicsr2p0
	ret					# rv32ifdq_zicsr
	.option	pop
	# rv32ifd_zicsr (written in .text.1.2)


	.option arch, rv32i2p1_zicsr2p0
	.section .text.2, "ax", %progbits
add_1:
	add a0, a0, a1				# rv32i_zicsr
	ret					# rv32i_zicsr

	# Final / default arch (to be written as an ELF attribute):
	# rv32i_zicsr (set just before .section .text.2)
