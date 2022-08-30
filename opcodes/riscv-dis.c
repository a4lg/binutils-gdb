/* RISC-V disassembler
   Copyright (C) 2011-2022 Free Software Foundation, Inc.

   Contributed by Andrew Waterman (andrew@sifive.com).
   Based on MIPS target.

   This file is part of the GNU opcodes library.

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   It is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
   License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING3. If not,
   see <http://www.gnu.org/licenses/>.  */

#include "sysdep.h"
#include "disassemble.h"
#include "libiberty.h"
#include "opcode/riscv.h"
#include "opintl.h"
#include "elf-bfd.h"
#include "elf/riscv.h"
#include "elfxx-riscv.h"

#include <stdint.h>
#include <ctype.h>

/* Default architecture string (if not available).  */
static const char *const initial_default_arch = "rv64gc";

/* Default architecture string
   (as specified by the ELF attributes or `initial_default_arch').  */
static const char *default_arch = NULL;

/* If set, a custom architecture string is specified.  */
static bool is_custom_arch = false;

/* If set, the last architecture used by the disassembler is custom.  */
static bool prev_is_custom_arch = false;

/* Current XLEN for the disassembler.  */
static unsigned xlen = 0;

/* XLEN as inferred by the machine architecture.  */
static unsigned xlen_by_mach = 0;

/* XLEN as inferred by the architecture string.  */
static unsigned xlen_by_arch = 0;

/* XLEN as inferred by ELF header.  */
static unsigned xlen_by_elf = 0;

/* Default ISA specification version (constant as of now).  */
static enum riscv_spec_class default_isa_spec = ISA_SPEC_CLASS_DRAFT - 1;

/* Default privileged specification
   (as specified by the ELF attributes or the `priv-spec' option).  */
static enum riscv_spec_class default_priv_spec = PRIV_SPEC_CLASS_DRAFT - 1;

/* Current privileged specification version.  */
static enum riscv_spec_class priv_spec = PRIV_SPEC_CLASS_DRAFT - 1;

/* If set, a custom privileged specification is specified.  */
static bool is_custom_priv_spec = false;

/* Reset when reinitializing the CSR hash table is required.  */
static bool is_init_csr = false;


static riscv_subset_list_t riscv_subsets;
static riscv_parse_subset_t riscv_rps_dis =
{
  &riscv_subsets,	/* subset_list.  */
  opcodes_error_handler,/* error_handler.  */
  &xlen,		/* xlen.  */
  &default_isa_spec,	/* isa_spec.  */
  false,		/* check_unknown_prefixed_ext.  */
};

struct riscv_private_data
{
  bfd_vma gp;
  bfd_vma print_addr;
  bfd_vma hi_addr[OP_MASK_RD + 1];
  bool to_print_addr;
  bool has_gp;
};

/* Used for mapping symbols.  */
static int last_map_symbol = -1;
static bfd_vma last_stop_offset = 0;

/* Register names as used by the disassembler.  */
static const char * const *riscv_gpr_names;
static const char * const *riscv_fpr_names;

/* If set, disassemble as most general instruction.  */
static bool no_aliases = false;

/* If set, disassemble with numeric register names.  */
static bool is_numeric = false;

/* Instruction support cache.  */
static signed char riscv_insn_support_cache[NUM_INSN_CLASSES];


/* Initialize private data of the disassemble_info.  */

static void
init_riscv_dis_private_data (struct disassemble_info *info)
{
  struct riscv_private_data *pd;

  pd = info->private_data = xcalloc (1, sizeof (struct riscv_private_data));
  pd->gp = 0;
  pd->print_addr = 0;
  for (int i = 0; i < (int)ARRAY_SIZE (pd->hi_addr); i++)
    pd->hi_addr[i] = -1;
  pd->to_print_addr = false;
  pd->has_gp = false;

  for (int i = 0; i < info->symtab_size; i++)
    if (strcmp (bfd_asymbol_name (info->symtab[i]), RISCV_GP_SYMBOL) == 0)
      {
	pd->gp = bfd_asymbol_value (info->symtab[i]);
	pd->has_gp = true;
      }
}

/* Initialization (for arch and options).  */

static void update_riscv_dis_xlen (struct disassemble_info *info);
static void build_riscv_opcodes_hash_table (void);

static bool is_arch_changed = false;

static void
init_riscv_dis_state_for_arch (void)
{
  is_arch_changed = true;
  /* Clear instruction support cache.  */
  for (size_t i = 0; i < NUM_INSN_CLASSES; i++)
    riscv_insn_support_cache[i] = 0;
}

static void
init_riscv_dis_state_for_arch_and_options (void)
{
  static bool init = false;
  static enum riscv_spec_class prev_priv_spec;
  if (!init)
    {
      build_riscv_opcodes_hash_table ();
      init = true;
      /* Save initial options.  */
      prev_priv_spec = priv_spec;
    }
  /* If the architecture string is changed, update XLEN.  */
  if (is_arch_changed)
    update_riscv_dis_xlen (NULL);
  /* Set GPR register names to disassemble.  */
  riscv_gpr_names = is_numeric ? riscv_gpr_names_numeric : riscv_gpr_names_abi;
  /* Set FPR register names to disassemble.  */
  riscv_fpr_names
      = !riscv_subset_supports (&riscv_rps_dis, "zfinx")
	    ? (is_numeric ? riscv_fpr_names_numeric : riscv_fpr_names_abi)
	    : riscv_gpr_names;
  /* Reset CSR hash table if either the architecture or the privileged
     specification version is changed.  */
  if (prev_priv_spec != priv_spec)
    is_init_csr = false;
  /* Save previous options and mark them "unchanged".  */
  prev_priv_spec = priv_spec;
  is_arch_changed = false;
}

/* Update current architecture string
   and reinitialize the disassembler state.  */

static void
update_riscv_dis_current_arch (const char *arch)
{
  xlen = 0;
  riscv_release_subset_list (&riscv_subsets);
  riscv_parse_subset (&riscv_rps_dis, arch);
  xlen_by_arch = (arch == initial_default_arch) ? 0 : xlen;
  prev_is_custom_arch = is_custom_arch;
  init_riscv_dis_state_for_arch ();
  /* xlen is readjusted by the next call to
     init_riscv_dis_state_for_arch_and_options.  */
}

/* Update default architecture string.
   Return true if a default arch string change is detected or previous
   architecture string is custom one.  */

static bool
update_riscv_dis_default_arch (const char* arch)
{
  /* Do nothing if default arch string is unchanged.
     Return true if previous architecture string is custom one.  */
  if (arch == initial_default_arch)
    {
      if (default_arch == initial_default_arch)
	return prev_is_custom_arch;
    }
  else if (default_arch != NULL && strcmp (default_arch, arch) == 0)
    return prev_is_custom_arch;
  /* Save new default arch string
     (either initial_default_arch or a copy of the arch string).  */
  if (default_arch != initial_default_arch)
    free ((void *)default_arch);
  default_arch = (arch != initial_default_arch) ? xstrdup (arch) : arch;
  return true;
}

/* Guess and update current XLEN.  */

static void
update_riscv_dis_xlen (struct disassemble_info *info)
{
  /* Set XLEN with following precedence rules:
     1. BFD machine architecture set by either:
       a. -m riscv:rv[32|64] option (GDB: set arch riscv:rv[32|64])
       b. ELF class in actual ELF header (only on RISC-V ELF)
       This is only effective if XLEN-specific BFD machine architecture is
       chosen.  If XLEN-neutral (like riscv), BFD machine architecture is
       ignored on XLEN selection.
     2. Non-default RISC-V architecture string set by either:
       a. -M arch=... option (GDB: set disassembler-options arch=...) or
       b. The ELF attributes.
     3. ELF class in dummy ELF header.  */
  if (xlen_by_mach != 0)
    xlen = xlen_by_mach;
  else if (xlen_by_arch != 0)
    xlen = xlen_by_arch;
  else if (xlen_by_elf != 0)
    xlen = xlen_by_elf;
  else if (info != NULL && info->section != NULL)
    {
      Elf_Internal_Ehdr *ehdr = elf_elfheader (info->section->owner);
      xlen = xlen_by_elf = ehdr->e_ident[EI_CLASS] == ELFCLASS64 ? 64 : 32;
    }
}

/* Set default RISC-V disassembler options.  */

static void
set_default_riscv_dis_options (void)
{
  no_aliases = false;
  is_numeric = false;
  is_custom_priv_spec = false;
  is_custom_arch = false;
}

/* Parse RISC-V disassembler option (without arguments).  */

static bool
parse_riscv_dis_option_without_args (const char *option)
{
  if (strcmp (option, "no-aliases") == 0)
    no_aliases = true;
  else if (strcmp (option, "numeric") == 0)
    is_numeric = true;
  else
    return false;
  return true;
}

/* Parse RISC-V disassembler option (possibly with arguments).  */

static void
parse_riscv_dis_option (const char *option)
{
  char *equal, *value;

  if (parse_riscv_dis_option_without_args (option))
    return;

  equal = strchr (option, '=');
  if (equal == NULL)
    {
      /* The option without '=' should be defined above.  */
      opcodes_error_handler (_("unrecognized disassembler option: %s"), option);
      return;
    }
  if (equal == option
      || *(equal + 1) == '\0')
    {
      /* Invalid options with '=', no option name before '=',
       and no value after '='.  */
      opcodes_error_handler (_("unrecognized disassembler option with '=': %s"),
                            option);
      return;
    }

  *equal = '\0';
  value = equal + 1;
  if (strcmp (option, "priv-spec") == 0)
    {
      enum riscv_spec_class priv_spec_new = PRIV_SPEC_CLASS_NONE;
      RISCV_GET_PRIV_SPEC_CLASS (value, priv_spec_new);
      if (priv_spec_new == PRIV_SPEC_CLASS_NONE)
	{
	  opcodes_error_handler (_ ("unknown privileged spec set by %s=%s."
				    "not overriding"),
				 option, value);
	}
      else
	{
	  is_custom_priv_spec = true;
	  priv_spec = priv_spec_new;
	}
    }
  else if (strcmp (option, "arch") == 0)
    {
      is_custom_arch = true;
      update_riscv_dis_current_arch (value);
    }
  else
    {
      /* xgettext:c-format */
      opcodes_error_handler (_("unrecognized disassembler option: %s"), option);
    }
}

/* Parse RISC-V disassembler options.  */

static void
parse_riscv_dis_options (const char *opts_in)
{
  char *opts = xstrdup (opts_in), *opt = opts, *opt_end = opts;

  for ( ; opt_end != NULL; opt = opt_end + 1)
    {
      if ((opt_end = strchr (opt, ',')) != NULL)
	*opt_end = 0;
      parse_riscv_dis_option (opt);
    }

  free (opts);
}

/* Print one argument from an array.  */

static void
arg_print (struct disassemble_info *info, unsigned long val,
	   const char* const* array, size_t size)
{
  const char *s = val >= size || array[val] == NULL ? "unknown" : array[val];
  (*info->fprintf_styled_func) (info->stream, dis_style_text, "%s", s);
}

/* If we need to print an address, set its value and state.  */

static void
maybe_print_address (struct riscv_private_data *pd, int base_reg, int offset,
		     bool is_addiw)
{
  if (pd->hi_addr[base_reg] != (bfd_vma)-1)
    {
      pd->print_addr = (base_reg != 0 ? pd->hi_addr[base_reg] : 0) + offset;
      pd->hi_addr[base_reg] = -1;
    }
  else if (base_reg == X_GP && pd->has_gp)
    pd->print_addr = pd->gp + offset;
  else if (base_reg == X_TP || base_reg == 0)
    pd->print_addr = offset;
  else
    return;  /* Don't print the address.  */
  pd->to_print_addr = true;

  /* On ADDIW, sign-extend a 32-bit value to a 64-bit value.  */
  if (is_addiw)
    pd->print_addr = (bfd_vma)(int32_t) pd->print_addr;

  /* Fit into a 32-bit value on RV32.  */
  if (xlen == 32)
    pd->print_addr = (bfd_vma)(uint32_t)pd->print_addr;
}

/* Print insn arguments for 32/64-bit code.  */

static void
print_insn_args (const char *oparg, insn_t l, bfd_vma pc, disassemble_info *info)
{
  struct riscv_private_data *pd = info->private_data;
  int rs1 = (l >> OP_SH_RS1) & OP_MASK_RS1;
  int rd = (l >> OP_SH_RD) & OP_MASK_RD;
  fprintf_styled_ftype print = info->fprintf_styled_func;
  const char *opargStart;

  if (*oparg != '\0')
    print (info->stream, dis_style_text, "\t");

  for (; *oparg != '\0'; oparg++)
    {
      opargStart = oparg;
      switch (*oparg)
	{
	case 'C': /* RVC */
	  switch (*++oparg)
	    {
	    case 's': /* RS1 x8-x15.  */
	    case 'w': /* RS1 x8-x15.  */
	      print (info->stream, dis_style_register, "%s",
		     riscv_gpr_names[EXTRACT_OPERAND (CRS1S, l) + 8]);
	      break;
	    case 't': /* RS2 x8-x15.  */
	    case 'x': /* RS2 x8-x15.  */
	      print (info->stream, dis_style_register, "%s",
		     riscv_gpr_names[EXTRACT_OPERAND (CRS2S, l) + 8]);
	      break;
	    case 'U': /* RS1, constrained to equal RD.  */
	      print (info->stream, dis_style_register,
		     "%s", riscv_gpr_names[rd]);
	      break;
	    case 'c': /* RS1, constrained to equal sp.  */
	      print (info->stream, dis_style_register, "%s",
		     riscv_gpr_names[X_SP]);
	      break;
	    case 'V': /* RS2 */
	      print (info->stream, dis_style_register, "%s",
		     riscv_gpr_names[EXTRACT_OPERAND (CRS2, l)]);
	      break;
	    case 'o':
	    case 'j':
	      if (((l & MASK_C_ADDI) == MATCH_C_ADDI) && rd != 0)
		maybe_print_address (pd, rd, EXTRACT_CITYPE_IMM (l), false);
	      if (xlen > 32
		  && ((l & MASK_C_ADDIW) == MATCH_C_ADDIW) && rd != 0)
		maybe_print_address (pd, rd, EXTRACT_CITYPE_IMM (l), true);
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_CITYPE_IMM (l));
	      break;
	    case 'k':
	      print (info->stream, dis_style_address_offset, "%d",
		     (int)EXTRACT_CLTYPE_LW_IMM (l));
	      break;
	    case 'l':
	      print (info->stream, dis_style_address_offset, "%d",
		     (int)EXTRACT_CLTYPE_LD_IMM (l));
	      break;
	    case 'm':
	      print (info->stream, dis_style_address_offset, "%d",
		     (int)EXTRACT_CITYPE_LWSP_IMM (l));
	      break;
	    case 'n':
	      print (info->stream, dis_style_address_offset, "%d",
		     (int)EXTRACT_CITYPE_LDSP_IMM (l));
	      break;
	    case 'K':
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_CIWTYPE_ADDI4SPN_IMM (l));
	      break;
	    case 'L':
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_CITYPE_ADDI16SP_IMM (l));
	      break;
	    case 'M':
	      print (info->stream, dis_style_address_offset, "%d",
		     (int)EXTRACT_CSSTYPE_SWSP_IMM (l));
	      break;
	    case 'N':
	      print (info->stream, dis_style_address_offset, "%d",
		     (int)EXTRACT_CSSTYPE_SDSP_IMM (l));
	      break;
	    case 'p':
	      info->target = EXTRACT_CBTYPE_IMM (l) + pc;
	      (*info->print_address_func) (info->target, info);
	      break;
	    case 'a':
	      info->target = EXTRACT_CJTYPE_IMM (l) + pc;
	      (*info->print_address_func) (info->target, info);
	      break;
	    case 'u':
	      print (info->stream, dis_style_immediate, "0x%x",
		     (int)(EXTRACT_CITYPE_IMM (l) & (RISCV_BIGIMM_REACH-1)));
	      break;
	    case '>':
	      print (info->stream, dis_style_immediate, "0x%x",
		     (int)EXTRACT_CITYPE_IMM (l) & 0x3f);
	      break;
	    case '<':
	      print (info->stream, dis_style_immediate, "0x%x",
		     (int)EXTRACT_CITYPE_IMM (l) & 0x1f);
	      break;
	    case 'T': /* Floating-point RS2.  */
	      print (info->stream, dis_style_register, "%s",
		     riscv_fpr_names[EXTRACT_OPERAND (CRS2, l)]);
	      break;
	    case 'D': /* Floating-point RS2 x8-x15.  */
	      print (info->stream, dis_style_register, "%s",
		     riscv_fpr_names[EXTRACT_OPERAND (CRS2S, l) + 8]);
	      break;
	    }
	  break;

	case 'V': /* RVV */
	  switch (*++oparg)
	    {
	    case 'd':
	    case 'f':
	      print (info->stream, dis_style_register, "%s",
		     riscv_vecr_names_numeric[EXTRACT_OPERAND (VD, l)]);
	      break;
	    case 'e':
	      if (!EXTRACT_OPERAND (VWD, l))
		print (info->stream, dis_style_register, "%s",
		       riscv_gpr_names[0]);
	      else
		print (info->stream, dis_style_register, "%s",
		       riscv_vecr_names_numeric[EXTRACT_OPERAND (VD, l)]);
	      break;
	    case 's':
	      print (info->stream, dis_style_register, "%s",
		     riscv_vecr_names_numeric[EXTRACT_OPERAND (VS1, l)]);
	      break;
	    case 't':
	    case 'u': /* VS1 == VS2 already verified at this point.  */
	    case 'v': /* VD == VS1 == VS2 already verified at this point.  */
	      print (info->stream, dis_style_register, "%s",
		     riscv_vecr_names_numeric[EXTRACT_OPERAND (VS2, l)]);
	      break;
	    case '0':
	      print (info->stream, dis_style_register, "%s",
		     riscv_vecr_names_numeric[0]);
	      break;
	    case 'b':
	    case 'c':
	      {
		int imm = (*oparg == 'b') ? EXTRACT_RVV_VB_IMM (l)
					  : EXTRACT_RVV_VC_IMM (l);
		unsigned int imm_vlmul = EXTRACT_OPERAND (VLMUL, imm);
		unsigned int imm_vsew = EXTRACT_OPERAND (VSEW, imm);
		unsigned int imm_vta = EXTRACT_OPERAND (VTA, imm);
		unsigned int imm_vma = EXTRACT_OPERAND (VMA, imm);
		unsigned int imm_vtype_res = (imm >> 8);

		if (imm_vsew < ARRAY_SIZE (riscv_vsew)
		    && imm_vlmul < ARRAY_SIZE (riscv_vlmul)
		    && imm_vta < ARRAY_SIZE (riscv_vta)
		    && imm_vma < ARRAY_SIZE (riscv_vma)
		    && !imm_vtype_res
		    && riscv_vsew[imm_vsew] != NULL
		    && riscv_vlmul[imm_vlmul] != NULL)
		  print (info->stream, dis_style_text, "%s,%s,%s,%s",
			 riscv_vsew[imm_vsew],
			 riscv_vlmul[imm_vlmul], riscv_vta[imm_vta],
			 riscv_vma[imm_vma]);
		else
		  print (info->stream, dis_style_immediate, "%d", imm);
	      }
	      break;
	    case 'i':
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_RVV_VI_IMM (l));
	      break;
	    case 'j':
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_RVV_VI_UIMM (l));
	      break;
	    case 'k':
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_RVV_OFFSET (l));
	      break;
	    case 'm':
	      if (! EXTRACT_OPERAND (VMASK, l))
		print (info->stream, dis_style_register, ",%s",
		       riscv_vecm_names_numeric[0]);
	      break;
	    }
	  break;

	case ',':
	case '(':
	case ')':
	case '[':
	case ']':
	  print (info->stream, dis_style_text, "%c", *oparg);
	  break;

	case '0':
	  /* Only print constant 0 if it is the last argument.  */
	  if (!oparg[1])
	    print (info->stream, dis_style_immediate, "0");
	  break;

	case 'b':
	case 's':
	  if ((l & MASK_JALR) == MATCH_JALR)
	    maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), false);
	  print (info->stream, dis_style_register, "%s", riscv_gpr_names[rs1]);
	  break;

	case 't':
	  print (info->stream, dis_style_register, "%s",
		 riscv_gpr_names[EXTRACT_OPERAND (RS2, l)]);
	  break;

	case 'u':
	  print (info->stream, dis_style_immediate, "0x%x",
		 (unsigned)EXTRACT_UTYPE_IMM (l) >> RISCV_IMM_BITS);
	  break;

	case 'm':
	  arg_print (info, EXTRACT_OPERAND (RM, l),
		     riscv_rm, ARRAY_SIZE (riscv_rm));
	  break;

	case 'P':
	  arg_print (info, EXTRACT_OPERAND (PRED, l),
		     riscv_pred_succ, ARRAY_SIZE (riscv_pred_succ));
	  break;

	case 'Q':
	  arg_print (info, EXTRACT_OPERAND (SUCC, l),
		     riscv_pred_succ, ARRAY_SIZE (riscv_pred_succ));
	  break;

	case 'o':
	  maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), false);
	  /* Fall through.  */
	case 'j':
	  if (((l & MASK_ADDI) == MATCH_ADDI && rs1 != 0)
	      || (l & MASK_JALR) == MATCH_JALR)
	    maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), false);
	  if (xlen > 32
	      && ((l & MASK_ADDIW) == MATCH_ADDIW) && rs1 != 0)
	    maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), true);
	  print (info->stream, dis_style_immediate, "%d",
		 (int)EXTRACT_ITYPE_IMM (l));
	  break;

	case 'q':
	  maybe_print_address (pd, rs1, EXTRACT_STYPE_IMM (l), false);
	  print (info->stream, dis_style_address_offset, "%d",
		 (int)EXTRACT_STYPE_IMM (l));
	  break;

	case 'f':
	  print (info->stream, dis_style_address_offset, "%d",
		 (int)EXTRACT_STYPE_IMM (l));
	  break;

	case 'a':
	  info->target = EXTRACT_JTYPE_IMM (l) + pc;
	  (*info->print_address_func) (info->target, info);
	  break;

	case 'p':
	  info->target = EXTRACT_BTYPE_IMM (l) + pc;
	  (*info->print_address_func) (info->target, info);
	  break;

	case 'd':
	  if ((l & MASK_AUIPC) == MATCH_AUIPC)
	    pd->hi_addr[rd] = pc + EXTRACT_UTYPE_IMM (l);
	  else if ((l & MASK_LUI) == MATCH_LUI)
	    pd->hi_addr[rd] = EXTRACT_UTYPE_IMM (l);
	  else if ((l & MASK_C_LUI) == MATCH_C_LUI)
	    pd->hi_addr[rd] = EXTRACT_CITYPE_LUI_IMM (l);
	  print (info->stream, dis_style_register, "%s", riscv_gpr_names[rd]);
	  break;

	case 'y':
	  print (info->stream, dis_style_text, "0x%x",
		 (int)EXTRACT_OPERAND (BS, l));
	  break;

	case 'z':
	  print (info->stream, dis_style_register, "%s", riscv_gpr_names[0]);
	  break;

	case '>':
	  print (info->stream, dis_style_immediate, "0x%x",
		 (int)EXTRACT_OPERAND (SHAMT, l));
	  break;

	case '<':
	  print (info->stream, dis_style_immediate, "0x%x",
		 (int)EXTRACT_OPERAND (SHAMTW, l));
	  break;

	case 'S':
	case 'U':
	  print (info->stream, dis_style_register, "%s", riscv_fpr_names[rs1]);
	  break;

	case 'T':
	  print (info->stream, dis_style_register, "%s",
		 riscv_fpr_names[EXTRACT_OPERAND (RS2, l)]);
	  break;

	case 'D':
	  print (info->stream, dis_style_register, "%s", riscv_fpr_names[rd]);
	  break;

	case 'R':
	  print (info->stream, dis_style_register, "%s",
		 riscv_fpr_names[EXTRACT_OPERAND (RS3, l)]);
	  break;

	case 'E':
	  {
	    static const char *riscv_csr_hash[4096]; /* Total 2^12 CSRs.  */
	    unsigned int csr = EXTRACT_OPERAND (CSR, l);

	    if (!is_init_csr)
	      {
		unsigned int i;
		for (i = 0; i < 4096; i++)
		  riscv_csr_hash[i] = NULL;

#define DECLARE_CSR(name, num, class, define_version, abort_version)	\
		if (riscv_csr_hash[num] == NULL 			\
		    && ((define_version == PRIV_SPEC_CLASS_NONE 	\
			 && abort_version == PRIV_SPEC_CLASS_NONE)	\
			|| (priv_spec >= define_version 	\
			    && priv_spec < abort_version)))	\
		  riscv_csr_hash[num] = #name;
#define DECLARE_CSR_ALIAS(name, num, class, define_version, abort_version) \
		DECLARE_CSR (name, num, class, define_version, abort_version)
#include "opcode/riscv-opc.h"
#undef DECLARE_CSR
		is_init_csr = true;
	      }

	    if (riscv_csr_hash[csr] != NULL)
	      print (info->stream, dis_style_text, "%s", riscv_csr_hash[csr]);
	    else
	      print (info->stream, dis_style_text, "0x%x", csr);
	    break;
	  }

	case 'Y':
	  print (info->stream, dis_style_text, "0x%x",
		 (int) EXTRACT_OPERAND (RNUM, l));
	  break;

	case 'Z':
	  print (info->stream, dis_style_text, "%d", rs1);
	  break;

	default:
	  /* xgettext:c-format */
	  print (info->stream, dis_style_text,
		 _("# internal error, undefined modifier (%c)"),
		 *opargStart);
	  return;
	}
    }
}

/* Build a hash table for the disassembler to shorten the search time.
   We sort riscv_opcodes entry pointers for further performance.
   Hash index is computed by masking the instruction with...
   - 0x03 (OP_MASK_OP2) for real 16-bit instructions
   - 0x7f (OP_MASK_OP)  for all other instructions.  */

#define OP_HASH_LEN (OP_MASK_OP + 1)
#define OP_HASH_IDX(i)                                                        \
  ((i) & (((i & OP_MASK_OP2) != OP_MASK_OP2) ? OP_MASK_OP2 : OP_MASK_OP))
static const struct riscv_opcode **riscv_hash[OP_HASH_LEN + 1];
static const struct riscv_opcode **riscv_opcodes_sorted;

/* Whether the fallback should be used.  */
static bool is_riscv_hash_fallback = false;

/* Compare two riscv_opcode* objects to sort by hash index.  */

static int
compare_opcodes (const void *ap, const void *bp)
{
  const struct riscv_opcode *a = *(const struct riscv_opcode **) ap;
  const struct riscv_opcode *b = *(const struct riscv_opcode **) bp;
  int ai = (int) OP_HASH_IDX (a->match);
  int bi = (int) OP_HASH_IDX (b->match);
  if (ai != bi)
    return ai - bi;
  /* Stable sort (on riscv_opcodes entry order) is required.  */
  if (a < b)
    return -1;
  if (a > b)
    return +1;
  return 0;
}

/* Build riscv_opcodes-based hash table.  */

static void
build_riscv_opcodes_hash_table (void)
{
  const struct riscv_opcode *op;
  const struct riscv_opcode **pop, **pop_end;
  size_t len = 0;

  /* Sort riscv_opcodes entry pointers (except macros).  */
  for (op = riscv_opcodes; op->name; op++)
    {
      if (op->pinfo == INSN_MACRO)
	continue;
      len++;
      if (is_riscv_hash_fallback)
	continue;
      if (OP_HASH_IDX (op->match) < OP_MASK_OP2
	      ? (op->mask & OP_MASK_OP2) != OP_MASK_OP2
	      : (op->mask & OP_MASK_OP)  != OP_MASK_OP)
	is_riscv_hash_fallback = true;
    }
  riscv_opcodes_sorted = xcalloc (len, sizeof (struct riscv_opcode *));
  pop_end = riscv_opcodes_sorted;
  for (op = riscv_opcodes; op->name; op++)
    if (op->pinfo != INSN_MACRO)
      *pop_end++ = op;
  if (!is_riscv_hash_fallback)
    qsort (riscv_opcodes_sorted, len, sizeof (struct riscv_opcode *),
	   compare_opcodes);

  /* Initialize faster hash table.  */
  pop = riscv_opcodes_sorted;
  for (unsigned i = 0; i < OP_HASH_LEN; i++)
    {
      riscv_hash[i] = pop;
      while (pop != pop_end && OP_HASH_IDX ((*pop)->match) == i)
	pop++;
    }
  riscv_hash[OP_HASH_LEN] = pop_end;
}

/* Print the RISC-V instruction at address MEMADDR in debugged memory,
   on using INFO.  Returns length of the instruction, in bytes.
   BIGENDIAN must be 1 if this is big-endian code, 0 if
   this is little-endian code.  */

static int
riscv_disassemble_insn (bfd_vma memaddr, insn_t word, disassemble_info *info)
{
  const struct riscv_opcode **pop, **pop_end;
  const struct riscv_opcode *op, *matched_op;
  struct riscv_private_data *pd = info->private_data;
  int insnlen;

  insnlen = riscv_insn_length (word);

  /* RISC-V instructions are always little-endian.  */
  info->endian_code = BFD_ENDIAN_LITTLE;

  info->bytes_per_chunk = insnlen % 4 == 0 ? 4 : 2;
  info->bytes_per_line = 8;
  /* We don't support constant pools, so this must be code.  */
  info->display_endian = info->endian_code;
  info->insn_info_valid = 1;
  info->branch_delay_insns = 0;
  info->data_size = 0;
  info->insn_type = dis_nonbranch;
  info->target = 0;
  info->target2 = 0;

  matched_op = NULL;
  if (!is_riscv_hash_fallback)
    {
      pop     = riscv_hash[OP_HASH_IDX (word)];
      pop_end = riscv_hash[OP_HASH_IDX (word) + 1];
    }
  else
    {
      pop     = riscv_hash[0];
      pop_end = riscv_hash[OP_HASH_LEN];
    }
  for (; pop != pop_end; pop++)
    {
      op = *pop;
      /* Does the opcode match?  */
      if (!(op->match_func) (op, word))
	continue;
      /* Is this a pseudo-instruction and may we print it as such?  */
      if (no_aliases && (op->pinfo & INSN_ALIAS))
	continue;
      /* Is this instruction restricted to a certain value of XLEN?  */
      if ((op->xlen_requirement != 0) && (op->xlen_requirement != xlen))
	continue;
      /* Is this instruction supported by the current architecture?  */
      if (riscv_insn_support_cache[op->insn_class] == 0)
	{
	  riscv_insn_support_cache[op->insn_class]
	      = riscv_multi_subset_supports (&riscv_rps_dis, op->insn_class)
		    ? +1
		    : -1;
	}
      if (riscv_insn_support_cache[op->insn_class] < 0)
	continue;

      matched_op = op;
      break;
    }

  if (matched_op != NULL)
    {
      /* There is a match.  */
      op = matched_op;

      (*info->fprintf_styled_func) (info->stream, dis_style_mnemonic,
				    "%s", op->name);
      print_insn_args (op->args, word, memaddr, info);

      /* Try to disassemble multi-instruction addressing sequences.  */
      if (pd->to_print_addr)
	{
	  info->target = pd->print_addr;
	  (*info->fprintf_styled_func) (info->stream, dis_style_comment_start,
					" # ");
	  (*info->print_address_func) (info->target, info);
	  pd->to_print_addr = false;
	}

      /* Finish filling out insn_info fields.  */
      switch (op->pinfo & INSN_TYPE)
	{
	case INSN_BRANCH:
	  info->insn_type = dis_branch;
	  break;
	case INSN_CONDBRANCH:
	  info->insn_type = dis_condbranch;
	  break;
	case INSN_JSR:
	  info->insn_type = dis_jsr;
	  break;
	case INSN_DREF:
	  info->insn_type = dis_dref;
	  break;
	default:
	  break;
	}

      if (op->pinfo & INSN_DATA_SIZE)
	{
	  int size = ((op->pinfo & INSN_DATA_SIZE) >> INSN_DATA_SIZE_SHIFT);
	  info->data_size = 1 << (size - 1);
	}

      return insnlen;
    }

  /* We did not find a match, so just print the instruction bits.  */
  info->insn_type = dis_noninsn;
  switch (insnlen)
    {
    case 2:
    case 4:
    case 8:
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".%dbyte\t", insnlen);
      (*info->fprintf_styled_func) (info->stream, dis_style_immediate,
				    "0x%llx", (unsigned long long) word);
      break;
    default:
      {
        int i;
	(*info->fprintf_styled_func)
	  (info->stream, dis_style_assembler_directive, ".byte\t");
        for (i = 0; i < insnlen; ++i)
          {
            if (i > 0)
	      (*info->fprintf_styled_func) (info->stream, dis_style_text,
					    ", ");
	    (*info->fprintf_styled_func) (info->stream, dis_style_immediate,
					  "0x%02x",
					  (unsigned int) (word & 0xff));
            word >>= 8;
          }
      }
      break;
    }
  return insnlen;
}

/* Return new mapping state if a given symbol name is of mapping symbols',
   MAP_NONE otherwise.  */

static enum riscv_seg_mstate
riscv_get_map_state_by_name (const char *name)
{
  if (startswith (name, "$x"))
    return MAP_INSN;
  else if (startswith (name, "$d"))
    return MAP_DATA;
  return MAP_NONE;
}

/* Return true if we find the suitable mapping symbol,
   and also update the STATE.  Otherwise, return false.  */

static bool
riscv_get_map_state (int n,
		     enum riscv_seg_mstate *state,
		     struct disassemble_info *info)
{
  const char *name;

  /* If the symbol is in a different section, ignore it.  */
  if (info->section != NULL
      && info->section != info->symtab[n]->section)
    return false;

  name = bfd_asymbol_name (info->symtab[n]);
  enum riscv_seg_mstate newstate = riscv_get_map_state_by_name (name);
  if (newstate == MAP_NONE)
    return false;
  *state = newstate;
  return true;
}

/* Check the sorted symbol table (sorted by the symbol value), find the
   suitable mapping symbols.  */

static enum riscv_seg_mstate
riscv_search_mapping_symbol (bfd_vma memaddr,
			     struct disassemble_info *info)
{
  enum riscv_seg_mstate mstate;
  bool from_last_map_symbol;
  bool found = false;
  int symbol = -1;
  int n;

  /* Decide whether to print the data or instruction by default, in case
     we can not find the corresponding mapping symbols.  */
  mstate = MAP_DATA;
  if ((info->section
       && info->section->flags & SEC_CODE)
      || !info->section)
    mstate = MAP_INSN;

  if (info->symtab_size == 0
      || bfd_asymbol_flavour (*info->symtab) != bfd_target_elf_flavour)
    return mstate;

  /* Reset the last_map_symbol if we start to dump a new section.  */
  if (memaddr <= 0)
    last_map_symbol = -1;

  /* If the last stop offset is different from the current one, then
     don't use the last_map_symbol to search.  We usually reset the
     info->stop_offset when handling a new section.  */
  from_last_map_symbol = (last_map_symbol >= 0
			  && info->stop_offset == last_stop_offset);

  /* Start scanning at the start of the function, or wherever
     we finished last time.  */
  n = info->symtab_pos + 1;
  if (from_last_map_symbol && n >= last_map_symbol)
    n = last_map_symbol;

  /* Find the suitable mapping symbol to dump.  */
  for (; n < info->symtab_size; n++)
    {
      bfd_vma addr = bfd_asymbol_value (info->symtab[n]);
      /* We have searched all possible symbols in the range.  */
      if (addr > memaddr)
	break;
      if (riscv_get_map_state (n, &mstate, info))
	{
	  symbol = n;
	  found = true;
	  /* Do not stop searching, in case there are some mapping
	     symbols have the same value, but have different names.
	     Use the last one.  */
	}
    }

  /* We can not find the suitable mapping symbol above.  Therefore, we
     look forwards and try to find it again, but don't go pass the start
     of the section.  Otherwise a data section without mapping symbols
     can pick up a text mapping symbol of a preceeding section.  */
  if (!found)
    {
      n = info->symtab_pos;
      if (from_last_map_symbol && n >= last_map_symbol)
	n = last_map_symbol;

      for (; n >= 0; n--)
	{
	  bfd_vma addr = bfd_asymbol_value (info->symtab[n]);
	  /* We have searched all possible symbols in the range.  */
	  if (addr < (info->section ? info->section->vma : 0))
	    break;
	  /* Stop searching once we find the closed mapping symbol.  */
	  if (riscv_get_map_state (n, &mstate, info))
	    {
	      symbol = n;
	      found = true;
	      break;
	    }
	}
    }

  /* Save the information for next use.  */
  last_map_symbol = symbol;
  last_stop_offset = info->stop_offset;

  return mstate;
}

/* Decide which data size we should print.  */

static bfd_vma
riscv_data_length (bfd_vma memaddr,
		   disassemble_info *info)
{
  bfd_vma length;
  bool found = false;

  length = 4;
  if (info->symtab_size != 0
      && bfd_asymbol_flavour (*info->symtab) == bfd_target_elf_flavour
      && last_map_symbol >= 0)
    {
      int n;
      enum riscv_seg_mstate m = MAP_NONE;
      for (n = last_map_symbol + 1; n < info->symtab_size; n++)
	{
	  bfd_vma addr = bfd_asymbol_value (info->symtab[n]);
	  if (addr > memaddr
	      && riscv_get_map_state (n, &m, info))
	    {
	      if (addr - memaddr < length)
		length = addr - memaddr;
	      found = true;
	      break;
	    }
	}
    }
  if (!found)
    {
      /* Do not set the length which exceeds the section size.  */
      bfd_vma offset = info->section->vma + info->section->size;
      offset -= memaddr;
      length = (offset < length) ? offset : length;
    }
  length = length == 3 ? 2 : length;
  return length;
}

/* Dump the data contents.  */

static int
riscv_disassemble_data (bfd_vma memaddr ATTRIBUTE_UNUSED,
			insn_t data,
			disassemble_info *info)
{
  info->display_endian = info->endian;

  switch (info->bytes_per_chunk)
    {
    case 1:
      info->bytes_per_line = 6;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".byte\t");
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, "0x%02llx",
	 (unsigned long long) data);
      break;
    case 2:
      info->bytes_per_line = 8;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".short\t");
      (*info->fprintf_styled_func)
	(info->stream, dis_style_immediate, "0x%04llx",
	 (unsigned long long) data);
      break;
    case 4:
      info->bytes_per_line = 8;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".word\t");
      (*info->fprintf_styled_func)
	(info->stream, dis_style_immediate, "0x%08llx",
	 (unsigned long long) data);
      break;
    case 8:
      info->bytes_per_line = 8;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".dword\t");
      (*info->fprintf_styled_func)
	(info->stream, dis_style_immediate, "0x%016llx",
	 (unsigned long long) data);
      break;
    default:
      abort ();
    }
  return info->bytes_per_chunk;
}

int
print_insn_riscv (bfd_vma memaddr, struct disassemble_info *info)
{
  bfd_byte packet[8];
  insn_t insn = 0;
  bfd_vma dump_size;
  int status;
  enum riscv_seg_mstate mstate;
  int (*riscv_disassembler) (bfd_vma, insn_t, struct disassemble_info *);

  /* Initialize the private data.  */
  if (info->private_data == NULL)
    init_riscv_dis_private_data (info);

  /* Guess and update XLEN if we haven't determined it yet.  */
  if (xlen == 0)
    update_riscv_dis_xlen (info);

  mstate = riscv_search_mapping_symbol (memaddr, info);

  /* Set the size to dump.  */
  if (mstate == MAP_DATA
      && (info->flags & DISASSEMBLE_DATA) == 0)
    {
      dump_size = riscv_data_length (memaddr, info);
      info->bytes_per_chunk = dump_size;
      riscv_disassembler = riscv_disassemble_data;
    }
  else
    {
      /* Get the first 2-bytes to check the lenghth of instruction.  */
      status = (*info->read_memory_func) (memaddr, packet, 2, info);
      if (status != 0)
	{
	  (*info->memory_error_func) (status, memaddr, info);
	  return status;
	}
      insn = (insn_t) bfd_getl16 (packet);
      dump_size = riscv_insn_length (insn);
      riscv_disassembler = riscv_disassemble_insn;
    }

  /* Fetch the instruction to dump.  */
  status = (*info->read_memory_func) (memaddr, packet, dump_size, info);
  if (status != 0)
    {
      (*info->memory_error_func) (status, memaddr, info);
      return status;
    }
  insn = (insn_t) bfd_get_bits (packet, dump_size * 8, false);

  return (*riscv_disassembler) (memaddr, insn, info);
}

disassembler_ftype
riscv_get_disassembler (bfd *abfd)
{
  const char *default_arch_next = initial_default_arch;

  if (abfd && bfd_get_flavour (abfd) == bfd_target_elf_flavour)
    {
      const char *sec_name = get_elf_backend_data (abfd)->obj_attrs_section;
      if (bfd_get_section_by_name (abfd, sec_name) != NULL)
	{
	  obj_attribute *attr = elf_known_obj_attributes_proc (abfd);
	  unsigned int Tag_a = Tag_RISCV_priv_spec;
	  unsigned int Tag_b = Tag_RISCV_priv_spec_minor;
	  unsigned int Tag_c = Tag_RISCV_priv_spec_revision;
	  riscv_get_priv_spec_class_from_numbers (attr[Tag_a].i,
						  attr[Tag_b].i,
						  attr[Tag_c].i,
						  &default_priv_spec);
	  default_arch_next = attr[Tag_RISCV_arch].s;
	  /* For ELF files with (somehow) no architecture string
	     in the attributes, use the default value.  */
	  if (!default_arch_next)
	    default_arch_next = initial_default_arch;
	  /* By default, set to the newest privileged version.  */
	  if (default_priv_spec == PRIV_SPEC_CLASS_NONE)
	    default_priv_spec = PRIV_SPEC_CLASS_DRAFT - 1;
	}
    }

  if (!is_custom_arch && update_riscv_dis_default_arch (default_arch_next))
    update_riscv_dis_current_arch (default_arch_next);
  if (!is_custom_priv_spec)
    priv_spec = default_priv_spec;
  init_riscv_dis_state_for_arch_and_options ();
  return print_insn_riscv;
}

/* Initialize disassemble_info and parse options.  */

void
disassemble_init_riscv (struct disassemble_info *info)
{
  info->symbol_is_valid = riscv_symbol_is_valid;
  /* Clear previous XLEN and guess by mach.  */
  xlen = 0;
  xlen_by_mach = 0;
  xlen_by_arch = 0;
  xlen_by_elf = 0;
  if (info->mach == bfd_mach_riscv64)
    xlen_by_mach = 64;
  else if (info->mach == bfd_mach_riscv32)
    xlen_by_mach = 32;
  update_riscv_dis_xlen (info);
  /* Parse disassembler options.  */
  set_default_riscv_dis_options ();
  if (info->disassembler_options != NULL)
    parse_riscv_dis_options (info->disassembler_options);
  if (!is_custom_priv_spec)
    priv_spec = default_priv_spec;
  init_riscv_dis_state_for_arch_and_options ();
}

/* Prevent use of the fake labels that are generated as part of the DWARF
   and for relaxable relocations in the assembler.  */

bool
riscv_symbol_is_valid (asymbol * sym,
                       struct disassemble_info * info ATTRIBUTE_UNUSED)
{
  const char * name;

  if (sym == NULL)
    return false;

  name = bfd_asymbol_name (sym);

  return (strcmp (name, RISCV_FAKE_LABEL_NAME) != 0
	  && !riscv_elf_is_mapping_symbols (name));
}


/* Indices into option argument vector for options accepting an argument.
   Use RISCV_OPTION_ARG_NONE for options accepting no argument.  */

typedef enum
{
  RISCV_OPTION_ARG_NONE = -1,
  RISCV_OPTION_ARG_ARCH,
  RISCV_OPTION_ARG_PRIV_SPEC,

  RISCV_OPTION_ARG_COUNT
} riscv_option_arg_t;

/* Valid RISCV disassembler options.  */

static struct
{
  const char *name;
  const char *description;
  riscv_option_arg_t arg;
} riscv_options[] =
{
  { "numeric",
    N_("Print numeric register names, rather than ABI names."),
    RISCV_OPTION_ARG_NONE },
  { "arch=",
    N_("Disassemble using specified ISA and extensions."),
    RISCV_OPTION_ARG_ARCH },
  { "no-aliases",
    N_("Disassemble only into canonical instructions."),
    RISCV_OPTION_ARG_NONE },
  { "priv-spec=",
    N_("Print the CSR according to the chosen privilege spec."),
    RISCV_OPTION_ARG_PRIV_SPEC }
};

/* Build the structure representing valid RISCV disassembler options.
   This is done dynamically for maintenance ease purpose; a static
   initializer would be unreadable.  */

const disasm_options_and_args_t *
disassembler_options_riscv (void)
{
  static disasm_options_and_args_t *opts_and_args;

  if (opts_and_args == NULL)
    {
      size_t num_options = ARRAY_SIZE (riscv_options);
      size_t num_args = RISCV_OPTION_ARG_COUNT;
      disasm_option_arg_t *args;
      disasm_options_t *opts;
      size_t i, priv_spec_count;

      args = XNEWVEC (disasm_option_arg_t, num_args + 1);

      args[RISCV_OPTION_ARG_ARCH].name = "ISA";
      args[RISCV_OPTION_ARG_ARCH].values = NULL;

      args[RISCV_OPTION_ARG_PRIV_SPEC].name = "SPEC";
      priv_spec_count = PRIV_SPEC_CLASS_DRAFT - PRIV_SPEC_CLASS_NONE - 1;
      args[RISCV_OPTION_ARG_PRIV_SPEC].values
        = XNEWVEC (const char *, priv_spec_count + 1);
      for (i = 0; i < priv_spec_count; i++)
	args[RISCV_OPTION_ARG_PRIV_SPEC].values[i]
          = riscv_priv_specs[i].name;
      /* The array we return must be NULL terminated.  */
      args[RISCV_OPTION_ARG_PRIV_SPEC].values[i] = NULL;

      /* The array we return must be NULL terminated.  */
      args[num_args].name = NULL;
      args[num_args].values = NULL;

      opts_and_args = XNEW (disasm_options_and_args_t);
      opts_and_args->args = args;

      opts = &opts_and_args->options;
      opts->name = XNEWVEC (const char *, num_options + 1);
      opts->description = XNEWVEC (const char *, num_options + 1);
      opts->arg = XNEWVEC (const disasm_option_arg_t *, num_options + 1);
      for (i = 0; i < num_options; i++)
	{
	  opts->name[i] = riscv_options[i].name;
	  opts->description[i] = _(riscv_options[i].description);
	  if (riscv_options[i].arg != RISCV_OPTION_ARG_NONE)
	    opts->arg[i] = &args[riscv_options[i].arg];
	  else
	    opts->arg[i] = NULL;
	}
      /* The array we return must be NULL terminated.  */
      opts->name[i] = NULL;
      opts->description[i] = NULL;
      opts->arg[i] = NULL;
    }

  return opts_and_args;
}

void
print_riscv_disassembler_options (FILE *stream)
{
  const disasm_options_and_args_t *opts_and_args;
  const disasm_option_arg_t *args;
  const disasm_options_t *opts;
  size_t max_len = 0;
  size_t i;
  size_t j;

  opts_and_args = disassembler_options_riscv ();
  opts = &opts_and_args->options;
  args = opts_and_args->args;

  fprintf (stream, _("\n\
The following RISC-V specific disassembler options are supported for use\n\
with the -M switch (multiple options should be separated by commas):\n"));
  fprintf (stream, "\n");

  /* Compute the length of the longest option name.  */
  for (i = 0; opts->name[i] != NULL; i++)
    {
      size_t len = strlen (opts->name[i]);

      if (opts->arg[i] != NULL)
	len += strlen (opts->arg[i]->name);
      if (max_len < len)
	max_len = len;
    }

  for (i = 0, max_len++; opts->name[i] != NULL; i++)
    {
      fprintf (stream, "  %s", opts->name[i]);
      if (opts->arg[i] != NULL)
	fprintf (stream, "%s", opts->arg[i]->name);
      if (opts->description[i] != NULL)
	{
	  size_t len = strlen (opts->name[i]);

	  if (opts->arg != NULL && opts->arg[i] != NULL)
	    len += strlen (opts->arg[i]->name);
	  fprintf (stream, "%*c %s", (int) (max_len - len), ' ',
                   opts->description[i]);
	}
      fprintf (stream, "\n");
    }

  for (i = 0; args[i].name != NULL; i++)
    {
      if (args[i].values == NULL)
	continue;
      fprintf (stream, _("\n\
  For the options above, the following values are supported for \"%s\":\n   "),
	       args[i].name);
      for (j = 0; args[i].values[j] != NULL; j++)
	fprintf (stream, " %s", args[i].values[j]);
      fprintf (stream, _("\n"));
    }

  fprintf (stream, _("\n"));
}
