target:
	csrr	a0, vstart
	csrw	vstart, zero
	csrr	a0, vxsat
	csrwi	vxsat, 1
	csrr	a0, vxrm
	csrwi	vxrm, 3
	csrr	a0, vcsr
	csrwi	vcsr, 7
	csrr	a0, vl
	csrr	a0, vtype
	csrr	a0, vlenb
