target:
	sh1add		a0, a1, a2
	sh2add		a0, a1, a2
	sh3add		a0, a1, a2
.ifdef rv64
	sh1add.uw	a0, a1, a2
	sh2add.uw	a0, a1, a2
	sh3add.uw	a0, a1, a2
	add.uw		a0, a1, a2
	slli.uw		a0, a1, 2

	# Aliases
	zext.w		a0, a1
.endif
