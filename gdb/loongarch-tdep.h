/* Target-dependent header for the LoongArch architecture, for GDB.

   Copyright (C) 2022-2025 Free Software Foundation, Inc.

   This file is part of GDB.

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

#ifndef GDB_LOONGARCH_TDEP_H
#define GDB_LOONGARCH_TDEP_H

#include "gdbarch.h"
#include "arch/loongarch.h"
#include "regset.h"

#include "elf/loongarch.h"
#include "opcode/loongarch.h"

/* Register set definitions.  */
extern const struct regset loongarch_gregset;
extern const struct regset loongarch_fpregset;
extern const struct regset loongarch_lsxregset;
extern const struct regset loongarch_lasxregset;
extern const struct regset loongarch_lbtregset;

/* Target-dependent structure in gdbarch.  */
struct loongarch_gdbarch_tdep : gdbarch_tdep_base
{
  /* Features about the abi that impact how the gdbarch is configured.  */
  struct loongarch_gdbarch_features abi_features;

  /* Syscall record.  */
  int (*loongarch_syscall_record) (struct regcache *regcache,
				   unsigned long syscall_number) = nullptr;

  /* Return the expected next PC if FRAME is stopped at a syscall instruction.  */
  CORE_ADDR (*syscall_next_pc) (const frame_info_ptr &frame) = nullptr;
};

extern int loongarch_process_record (struct gdbarch *gdbarch,
				     struct regcache *regcache, CORE_ADDR addr);

#endif /* GDB_LOONGARCH_TDEP_H */
