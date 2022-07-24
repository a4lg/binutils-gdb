/* Copyright 2022 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

	.attribute arch, "rv64i_zicsr"
	.option nopic
	.text

	.align	1
	.globl	test_func
	.type	test_func, @function
test_func:
	li	a0, 1
	csrr	a0, 0x3d0
	# hfence.gvma (an alias of hfence.gvma zero,zero)
	.insn	0x62000073
	ret
	.size	test_func, .-test_func
