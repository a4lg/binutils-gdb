target:
	# rdov a0
	csrrs	a0, vxsat, zero
	# clrov
	csrrci	zero, vxsat, 1
