target:
	# "zext.h" is a part of the 'Zbb' extension but also a subset of:
	# -   "pack"  (RV32_Zbkb)
	# -   "packw" (RV64_Zbkb)
	# Test 1: RV(32|64)I_Zbb_Zbkb (with aliases)
	# Test 2: RV(32|64)I_Zbb_Zbkb (without aliases)
	# Test 3: RV(32|64)I_Zbb      (without aliases)
	# Test 4: RV(32|64)I_Zbb      (with aliases; force RV(32|64)I_Zbkb)
	zext.h	a0, a1
