/* RISC-V disassembler
   Copyright (C) 2011-2023 Free Software Foundation, Inc.

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

/* Current XLEN for the disassembler.  */
static unsigned xlen = 0;

/* XLEN as inferred by the machine architecture.  */
static unsigned xlen_by_mach = 0;

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

/* RISC-V disassembler architecture context type.  */
typedef struct
{
  const char *arch_str;
  const char *default_arch;
  riscv_subset_list_t subsets;
  unsigned xlen;
  bool no_xlen_if_default;
} riscv_dis_arch_context_t;

/* Context: default (either initial_default_arch or ELF attribute).  */
static riscv_dis_arch_context_t dis_arch_context_default
    = { NULL, initial_default_arch, {}, 0, true };

/* Context: override (mapping symbols with ISA string). */
static riscv_dis_arch_context_t dis_arch_context_override
    = { NULL, NULL, {}, 0, false };

/* Pointer to the current disassembler architecture context.  */
static riscv_dis_arch_context_t *dis_arch_context_current
    = &dis_arch_context_default;

/* RISC-V ISA string parser structure (current).  */
static riscv_parse_subset_t riscv_rps_dis =
{
  &(dis_arch_context_default.subsets),	/* subset_list.  */
  opcodes_error_handler,		/* error_handler.  */
  &(dis_arch_context_default.xlen),	/* xlen.  */
  &default_isa_spec,			/* isa_spec.  */
  false,				/* check_unknown_prefixed_ext.  */
};

/* A RISC-V mapping symbol (parsed and expanded).  */
struct riscv_mapping_sym
{
  uintptr_t section;
  bfd_vma address;
  const char *arch;
  int index;
  enum riscv_seg_mstate mstate;
  bool with_arch;
};

/* Private data structure for the RISC-V disassembler.  */
struct riscv_private_data
{
  bfd_vma gp;
  bfd_vma print_addr;
  bfd_vma hi_addr[NGPR];
  bfd_vma expected_next_addr;
  void* last_section;
  struct riscv_mapping_sym *mapping_syms;
  struct riscv_mapping_sym *last_mapping_sym;
  struct riscv_mapping_sym *prev_last_mapping_sym;
  size_t mapping_syms_size;
  bool to_print_addr;
  bool has_gp;
  bool is_elf_with_mapsyms;
};

/* Register names as used by the disassembler.  */
static const char (*riscv_gpr_names)[NRC];
static const char (*riscv_fpr_names)[NRC];

/* If set, disassemble as most general instruction.  */
static bool no_aliases = false;

/* If set, disassemble with numeric register names.  */
static bool is_numeric = false;

/* Instruction support cache.  */
static signed char riscv_insn_support_cache[NUM_INSN_CLASSES];


/* Set current disassembler context (dis_arch_context_current).
   Return true if successfully updated.  */

static bool
set_riscv_current_dis_arch_context (riscv_dis_arch_context_t* context)
{
  if (context == dis_arch_context_current)
    return false;
  dis_arch_context_current = context;
  riscv_rps_dis.subset_list = &(context->subsets);
  riscv_rps_dis.xlen = &(context->xlen);
  return true;
}

/* Update riscv_dis_arch_context_t by an ISA string.
   Return true if the architecture is updated by arch.  */

static bool
set_riscv_dis_arch_context (riscv_dis_arch_context_t *context,
			    const char *arch)
{
  /* Check whether the architecture is changed and
     return false if the architecture will not be changed.  */
  if (context->arch_str)
    {
      if (context->default_arch && arch == context->default_arch)
	return false;
      if (strcmp (context->arch_str, arch) == 0)
	return false;
    }
  /* Update architecture string.  */
  if (context->arch_str != context->default_arch)
    free ((void *) context->arch_str);
  context->arch_str = (arch != context->default_arch)
			    ? xstrdup (arch)
			    : context->default_arch;
  /* Update other contents (subset list and XLEN).  */
  riscv_subset_list_t *prev_subsets = riscv_rps_dis.subset_list;
  unsigned *prev_xlen = riscv_rps_dis.xlen;
  riscv_rps_dis.subset_list = &(context->subsets);
  riscv_rps_dis.xlen = &(context->xlen);
  context->xlen = 0;
  riscv_release_subset_list (&context->subsets);
  /* ISA mapping string may be numbered, suffixed with '.n'. Do not
     consider this as part of the ISA string.  */
  char *suffix = strchr (context->arch_str, '.');
  if (suffix)
    *suffix = '\0';
  riscv_parse_subset (&riscv_rps_dis, context->arch_str);
  riscv_rps_dis.subset_list = prev_subsets;
  riscv_rps_dis.xlen = prev_xlen;
  /* Special handling on the default architecture.  */
  if (context->no_xlen_if_default && arch == context->default_arch)
    context->xlen = 0;
  return true;
}

/* Free memory allocated for riscv_dis_arch_context_t.  */

static void
free_riscv_dis_arch_context (riscv_dis_arch_context_t* context)
{
  riscv_release_subset_list (&context->subsets);
  if (context->default_arch != context->arch_str)
    free ((void *) context->arch_str);
  context->arch_str = NULL;
}


static void build_riscv_opcodes_hash_table (void);
static enum riscv_seg_mstate riscv_get_map_state_by_name (const char *name,
							  const char **arch);
static void
riscv_propagate_prev_arch_for_mapping_syms (struct disassemble_info *, bool);

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
     2. Non-default RISC-V architecture string set by either an ELF
	attribute or a mapping symbol with ISA string.
     3. ELF class in dummy ELF header.  */
  if (xlen_by_mach != 0)
    xlen = xlen_by_mach;
  else if (dis_arch_context_current->xlen != 0)
    xlen = dis_arch_context_current->xlen;
  else if (xlen_by_elf != 0)
    xlen = xlen_by_elf;
  else if (info != NULL && info->section != NULL)
    {
      Elf_Internal_Ehdr *ehdr = elf_elfheader (info->section->owner);
      xlen = xlen_by_elf = ehdr->e_ident[EI_CLASS] == ELFCLASS64 ? 64 : 32;
    }
}

/* Initialization (for arch).  */

static bool is_arch_changed = false;

static void
init_riscv_dis_state_for_arch (void)
{
  is_arch_changed = true;
  /* Clear instruction support cache.  */
  for (size_t i = 0; i < NUM_INSN_CLASSES; i++)
    riscv_insn_support_cache[i] = 0;
}

/* Initialization (for arch and options).  */

static void
init_riscv_dis_state_for_arch_and_options (void)
{
  static bool init = false;
  static enum riscv_spec_class prev_priv_spec;
  /* Set current privileged specification.  */
  if (!is_custom_priv_spec)
    priv_spec = default_priv_spec;
  /* First call to this function.  */
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
  pd->expected_next_addr = 0;
  pd->last_section = NULL;
  pd->mapping_syms = NULL;
  pd->last_mapping_sym = NULL;
  pd->prev_last_mapping_sym = NULL;
  pd->mapping_syms_size = 0;
  pd->to_print_addr = false;
  pd->has_gp = false;

  size_t n_mapping_syments = 0;

  for (int i = 0; i < info->symtab_size; i++)
    {
      if (strcmp (bfd_asymbol_name (info->symtab[i]), RISCV_GP_SYMBOL) == 0)
	{
	  pd->gp = bfd_asymbol_value (info->symtab[i]);
	  pd->has_gp = true;
	}
      if (riscv_get_map_state_by_name (bfd_asymbol_name (info->symtab[i]), NULL)
	  != MAP_NONE)
	n_mapping_syments++;
    }

  pd->is_elf_with_mapsyms
      = info->symtab_size != 0
	&& bfd_asymbol_flavour (*info->symtab) == bfd_target_elf_flavour
	&& n_mapping_syments;
  if (pd->is_elf_with_mapsyms)
    {
	/* Allocate mapping symbols (with head/tail sentinel entries).  */
	struct riscv_mapping_sym *msym = pd->mapping_syms
	    = xcalloc (n_mapping_syments + 2, sizeof (struct riscv_mapping_sym));
	/* Head sentinel entry.  */
	msym->index = -1;
	msym->mstate = MAP_NONE;
	msym++;
	/* Mapping symbols.  */
	for (int i = 0; i < info->symtab_size; i++)
	  {
	    const char* arch = NULL;
	    enum riscv_seg_mstate state = riscv_get_map_state_by_name (
		bfd_asymbol_name (info->symtab[i]), &arch);
	    if (state == MAP_NONE)
	      continue;
	    msym->section = (uintptr_t)info->symtab[i]->section;
	    msym->address = bfd_asymbol_value (info->symtab[i]);
	    msym->index = i;
	    msym->mstate = state;
	    msym->with_arch = (arch != NULL);
	    if (arch != NULL)
	      /* Assume symbol name is $x[ARCH].  */
	      msym->arch = bfd_asymbol_name (info->symtab[i]) + 2;
	    msym++;
	  }
	/* Tail sentinel entry.  */
	msym->index = -1;
	msym->mstate = MAP_NONE;

	pd->mapping_syms_size = n_mapping_syments;
	/* Mapping symbols are now ordered for section == NULL.
	   will be qsort-ed on the first non-NULL section.
	   Although following propagation is redundant on most cases,
	   this is required for functional correctness.  */
	riscv_propagate_prev_arch_for_mapping_syms (info, false);
    }
}

/* Compare two mapping symbols (sort by original index).  */

static int
compare_mapping_syms_without_section (const void *ap, const void *bp)
{
  const struct riscv_mapping_sym *a = ap;
  const struct riscv_mapping_sym *b = bp;
  return a->index - b->index;
}

/* Compare two mapping symbols (sort by section, address and
   original index for a stable sort).  */

static int
compare_mapping_syms_with_section (const void* ap, const void* bp)
{
  const struct riscv_mapping_sym *a = ap;
  const struct riscv_mapping_sym *b = bp;
  if (a->section < b->section)
    return -1;
  else if (a->section > b->section)
    return +1;
  else if (a->address < b->address)
    return -1;
  else if (a->address > b->address)
    return +1;
  return compare_mapping_syms_without_section (a, b);
}

/* Update "previous" architecture for sorted mapping symbol table.
   If is_per_section is true, section boundary is handled.  */

static void
riscv_propagate_prev_arch_for_mapping_syms (struct disassemble_info *info,
					    bool is_per_section)
{
  struct riscv_private_data *pd = info->private_data;
  struct riscv_mapping_sym *msym = pd->mapping_syms + 1;
  struct riscv_mapping_sym *mend = msym + pd->mapping_syms_size;
  const char *prev_arch = NULL;
  uintptr_t prev_section = 0;
  for (; msym != mend; msym++)
    {
      if (msym->mstate != MAP_INSN)
	continue;
      if (is_per_section && prev_section != msym->section)
	{
	  prev_section = msym->section;
	  /* Revert to default arch (NULL) if head of the section.  */
	  prev_arch = NULL;
	}
      if (msym->with_arch)
	prev_arch = msym->arch;
      else
	msym->arch = prev_arch;
    }
}

/* Initialize private data when the section to disassemble is changed.  */

static void
init_riscv_dis_private_data_for_section (struct disassemble_info *info)
{
  struct riscv_private_data *pd = info->private_data;

  if (pd->is_elf_with_mapsyms)
    {
      /* Clear the last mapping symbol because we start to
	 dump a new section.  */
      pd->last_mapping_sym = NULL;

      /* Sort the mapping symbols depending on the current section
	 (depending on whether the current section is NULL or not).  */
      if (pd->last_section == NULL && info->section != NULL)
	{
	  qsort (pd->mapping_syms + 1, pd->mapping_syms_size,
		 sizeof (struct riscv_mapping_sym),
		 compare_mapping_syms_with_section);
	  riscv_propagate_prev_arch_for_mapping_syms (info, true);
	}
      else if (pd->last_section != NULL && info->section == NULL)
	{
	  qsort (pd->mapping_syms + 1, pd->mapping_syms_size,
		 sizeof (struct riscv_mapping_sym),
		 compare_mapping_syms_without_section);
	  riscv_propagate_prev_arch_for_mapping_syms (info, false);
	}
    }

  pd->last_section = info->section;
}

/* Update architecture for disassembler with its context.
   Call initialization functions if either:
   -  the architecture for current context is changed or
   -  context is updated to a new one.  */

static void
update_riscv_dis_arch (riscv_dis_arch_context_t *context, const char *arch)
{
  if ((set_riscv_dis_arch_context (context, arch)
       && dis_arch_context_current == context)
      || set_riscv_current_dis_arch_context (context))
    {
      init_riscv_dis_state_for_arch ();
      init_riscv_dis_state_for_arch_and_options ();
    }
}


/* Set default RISC-V disassembler options.  */

static void
set_default_riscv_dis_options (void)
{
  no_aliases = false;
  is_numeric = false;
  is_custom_priv_spec = false;
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
		     int wide)
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

  /* Sign-extend a 32-bit value to a 64-bit value.  */
  if (wide)
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
		maybe_print_address (pd, rd, EXTRACT_CITYPE_IMM (l), 0);
	      if (xlen > 32
		  && ((l & MASK_C_ADDIW) == MATCH_C_ADDIW) && rd != 0)
		maybe_print_address (pd, rd, EXTRACT_CITYPE_IMM (l), 1);
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
		     (unsigned)(EXTRACT_CITYPE_IMM (l) & (RISCV_BIGIMM_REACH-1)));
	      break;
	    case '>':
	      print (info->stream, dis_style_immediate, "0x%x",
		     (unsigned)EXTRACT_CITYPE_IMM (l) & 0x3f);
	      break;
	    case '<':
	      print (info->stream, dis_style_immediate, "0x%x",
		     (unsigned)EXTRACT_CITYPE_IMM (l) & 0x1f);
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
	    case 'l':
	      print (info->stream, dis_style_immediate, "%d",
		     (int)EXTRACT_RVV_VI_UIMM6 (l));
	      break;
	    case 'm':
	      if (!EXTRACT_OPERAND (VMASK, l))
		{
		  print (info->stream, dis_style_text, ",");
		  print (info->stream, dis_style_register, "%s",
			 riscv_vecm_names_numeric[0]);
		}
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

	case 's':
	  if ((l & MASK_JALR) == MATCH_JALR)
	    maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), 0);
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
	  maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), 0);
	  /* Fall through.  */
	case 'j':
	  if (((l & MASK_ADDI) == MATCH_ADDI && rs1 != 0)
	      || (l & MASK_JALR) == MATCH_JALR)
	    maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), 0);
	  if (xlen > 32
	      && ((l & MASK_ADDIW) == MATCH_ADDIW) && rs1 != 0)
	    maybe_print_address (pd, rs1, EXTRACT_ITYPE_IMM (l), 1);
	  print (info->stream, dis_style_immediate, "%d",
		 (int)EXTRACT_ITYPE_IMM (l));
	  break;

	case 'q':
	  maybe_print_address (pd, rs1, EXTRACT_STYPE_IMM (l), 0);
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
	  print (info->stream, dis_style_immediate, "0x%x",
		 EXTRACT_OPERAND (BS, l));
	  break;

	case 'z':
	  print (info->stream, dis_style_register, "%s", riscv_gpr_names[0]);
	  break;

	case '>':
	  print (info->stream, dis_style_immediate, "0x%x",
		 EXTRACT_OPERAND (SHAMT, l));
	  break;

	case '<':
	  print (info->stream, dis_style_immediate, "0x%x",
		 EXTRACT_OPERAND (SHAMTW, l));
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
	      print (info->stream, dis_style_register, "%s",
		     riscv_csr_hash[csr]);
	    else
	      print (info->stream, dis_style_immediate, "0x%x", csr);
	    break;
	  }

	case 'Y':
	  print (info->stream, dis_style_immediate, "0x%x",
		 EXTRACT_OPERAND (RNUM, l));
	  break;

	case 'Z':
	  print (info->stream, dis_style_immediate, "%d", rs1);
	  break;

	case 'W': /* Various operands for standard z extensions.  */
	  switch (*++oparg)
	    {
	    case 'i':
	      switch (*++oparg)
		{
		case 'f':
		  print (info->stream, dis_style_address_offset, "%d",
			 (int) EXTRACT_STYPE_IMM (l));
		  break;
		default:
		  goto undefined_modifier;
		}
	      break;
	    case 'f':
	      switch (*++oparg)
		{
		case 'v':
		  if (riscv_fli_symval[rs1])
		    print (info->stream, dis_style_text, "%s",
			   riscv_fli_symval[rs1]);
		  else
		    print (info->stream, dis_style_immediate, "%a",
			   riscv_fli_numval[rs1]);
		  break;
		default:
		  goto undefined_modifier;
		}
	      break;
	    case 'c': /* Zcb extension 16 bits length instruction fields. */
	      switch (*++oparg)
		{
		case 'b':
		  print (info->stream, dis_style_immediate, "%d",
			 (int)EXTRACT_ZCB_BYTE_UIMM (l));
		  break;
		case 'h':
		  print (info->stream, dis_style_immediate, "%d",
			 (int)EXTRACT_ZCB_HALFWORD_UIMM (l));
		  break;
		default:
		  goto undefined_modifier;
		}
	      break;
	    default:
	      goto undefined_modifier;
	    }
	  break;

	case 'X': /* Vendor-specific operands.  */
	  switch (*++oparg)
	    {
	    case 't': /* Vendor-specific (T-head) operands.  */
	      {
		size_t n;
		size_t s;
		bool sign;
		switch (*++oparg)
		  {
		  case 'l': /* Integer immediate, literal.  */
		    oparg++;
		    while (*oparg && *oparg != ',')
		      {
			print (info->stream, dis_style_immediate, "%c", *oparg);
			oparg++;
		      }
		    oparg--;
		    break;
		  case 's': /* Integer immediate, 'XsN@S' ... N-bit signed immediate at bit S.  */
		    sign = true;
		    goto print_imm;
		  case 'u': /* Integer immediate, 'XuN@S' ... N-bit unsigned immediate at bit S.  */
		    sign = false;
		    goto print_imm;
		  print_imm:
		    n = strtol (oparg + 1, (char **)&oparg, 10);
		    if (*oparg != '@')
		      goto undefined_modifier;
		    s = strtol (oparg + 1, (char **)&oparg, 10);
		    oparg--;

		    if (!sign)
		      print (info->stream, dis_style_immediate, "%lu",
			     (unsigned long)EXTRACT_U_IMM (n, s, l));
		    else
		      print (info->stream, dis_style_immediate, "%li",
			     (signed long)EXTRACT_S_IMM (n, s, l));
		    break;
		  default:
		    goto undefined_modifier;
		  }
	      }
	      break;
	    default:
	      goto undefined_modifier;
	    }
	  break;

	default:
	undefined_modifier:
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
riscv_disassemble_insn (bfd_vma memaddr,
			insn_t word,
			const bfd_byte *packet,
			disassemble_info *info)
{
  const struct riscv_opcode **pop, **pop_end;
  const struct riscv_opcode *op, *matched_op;
  struct riscv_private_data *pd = info->private_data;
  int insnlen, i;
  bool printed;

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

  /* We did not find a match, so just print the instruction bits in
     the shape of an assembler .insn directive.  */
  info->insn_type = dis_noninsn;
  (*info->fprintf_styled_func)
    (info->stream, dis_style_assembler_directive, ".insn");
  (*info->fprintf_styled_func) (info->stream, dis_style_text, "\t");
  (*info->fprintf_styled_func) (info->stream, dis_style_immediate,
				"%d", insnlen);
  (*info->fprintf_styled_func) (info->stream, dis_style_text, ", ");
  (*info->fprintf_styled_func) (info->stream, dis_style_immediate, "0x");
  for (i = insnlen, printed = false; i >= 2; )
    {
      i -= 2;
      word = bfd_get_bits (packet + i, 16, false);
      if (!word && !printed)
	continue;

      (*info->fprintf_styled_func) (info->stream, dis_style_immediate,
				    "%04x", (unsigned int) word);
      printed = true;
    }

  return insnlen;
}

/* Return new mapping state if a given symbol name is of mapping symbols',
   MAP_NONE otherwise.  If arch is not NULL and name denotes a mapping symbol
   with ISA string, *arch is updated to the ISA string.  */

static enum riscv_seg_mstate
riscv_get_map_state_by_name (const char *name, const char** arch)
{
  if (startswith (name, "$x"))
    {
      if (arch && startswith (name + 2, "rv"))
	*arch = name + 2;
      return MAP_INSN;
    }
  else if (startswith (name, "$d"))
    return MAP_DATA;
  return MAP_NONE;
}

/* Search for the suitable mapping symbol and
   update the state data depending on the result.
   It assumes that ELF mapping symbol table is not empty.  */

static void
riscv_search_mapping_sym (bfd_vma memaddr,
			  enum riscv_seg_mstate *state,
			  struct disassemble_info *info)
{
  struct riscv_private_data *pd = info->private_data;
  struct riscv_mapping_sym *msym = pd->mapping_syms;
  uintptr_t cur_section = (uintptr_t) info->section;
  /* Do a binary search to find the last mapping symbol (which does not
     violate upper address and section boundaries) that may be suitable
     for a given section and address.
     This part is equivalent to std::partition_point(...)-1.  */
  size_t low = 1, len = pd->mapping_syms_size;
  while (len != 0)
    {
      size_t half = len / 2;
      size_t mid = low + half;
      bool is_mid_in_bound = cur_section
				 ? (msym[mid].section < cur_section
				    || (msym[mid].section == cur_section
					&& msym[mid].address <= memaddr))
				 : msym[mid].address <= memaddr;
      if (is_mid_in_bound)
	{
	  len -= half + 1;
	  low = mid + 1;
	}
      else
	len = half;
    }
  msym += low - 1;
  /* The result may however violate lower boundaries.
     Check if the result is actually suitable.  */
  if ((cur_section && cur_section != msym->section)
      || msym->mstate == MAP_NONE)
    {
      pd->last_mapping_sym = NULL;
      return;
    }
  /* Update the state and the last suitable mapping symbol.  */
  pd->last_mapping_sym = msym;
  *state = msym->mstate;
}

/* Check the sorted mapping symbol table (or section flags if not available)
   and find the suitable mapping symbol.
   Update last mapping symbol-related data and return the new state.  */

static enum riscv_seg_mstate
riscv_search_mapping_symbol (bfd_vma memaddr,
			     struct disassemble_info *info)
{
  enum riscv_seg_mstate mstate;
  struct riscv_private_data *pd = info->private_data;

  /* Decide whether to print the data or instruction by default, in case
     we can not find the corresponding mapping symbols.  */
  mstate = MAP_INSN;
  if (info->section && (info->section->flags & SEC_CODE) == 0)
    mstate = MAP_DATA;

  if (!pd->is_elf_with_mapsyms)
    return mstate;

  if (pd->last_mapping_sym != NULL
      && memaddr != 0
      && memaddr == pd->expected_next_addr)
    {
      /* Reuse the last mapping symbol.  */
      mstate = pd->last_mapping_sym->mstate;
      /* Do a forward linear search to find the next mapping symbol.  */
      struct riscv_mapping_sym *msym = pd->last_mapping_sym + 1;
      while (true)
	{
	  /* Break if we reached to the end.  */
	  if (msym->mstate == MAP_NONE)
	    break;
	  /* For section symbols, only test symbols in the same section.  */
	  if (info->section && (uintptr_t)info->section != msym->section)
	    break;
	  /* Don't go beyond memaddr.  */
	  if (memaddr < msym->address)
	    break;
	  /* Update the state and go to the next symbol.  */
	  mstate = msym->mstate;
	  pd->last_mapping_sym = msym++;
	}
    }
  else
    {
      /* Can't reuse the mapping symbol.  Do a binary search.  */
      riscv_search_mapping_sym (memaddr, &mstate, info);
    }

  return mstate;
}

/* Decide which data size we should print.  */

static bfd_vma
riscv_data_length (bfd_vma memaddr,
		   disassemble_info *info)
{
  bfd_vma length;
  bool found = false;
  struct riscv_private_data *pd = info->private_data;

  length = 4;
  if (pd->last_mapping_sym != NULL)
    {
      /* Get the next mapping symbol and adjust the length.  */
      struct riscv_mapping_sym *msym = pd->last_mapping_sym + 1;
      if (msym->mstate != MAP_NONE
	  && (!info->section || (uintptr_t)info->section == msym->section))
	{
	  if (msym->address - memaddr < length)
	    length = msym->address - memaddr;
	  found = true;
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
			const bfd_byte *packet ATTRIBUTE_UNUSED,
			disassemble_info *info)
{
  info->display_endian = info->endian;

  switch (info->bytes_per_chunk)
    {
    case 1:
      info->bytes_per_line = 6;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".byte");
      (*info->fprintf_styled_func) (info->stream, dis_style_text, "\t");
      (*info->fprintf_styled_func) (info->stream, dis_style_immediate,
				    "0x%02x", (unsigned)data);
      break;
    case 2:
      info->bytes_per_line = 8;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".short");
      (*info->fprintf_styled_func) (info->stream, dis_style_text, "\t");
      (*info->fprintf_styled_func)
	(info->stream, dis_style_immediate, "0x%04x", (unsigned) data);
      break;
    case 4:
      info->bytes_per_line = 8;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".word");
      (*info->fprintf_styled_func) (info->stream, dis_style_text, "\t");
      (*info->fprintf_styled_func)
	(info->stream, dis_style_immediate, "0x%08lx",
	 (unsigned long) data);
      break;
    case 8:
      info->bytes_per_line = 8;
      (*info->fprintf_styled_func)
	(info->stream, dis_style_assembler_directive, ".dword");
      (*info->fprintf_styled_func) (info->stream, dis_style_text, "\t");
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
  bfd_byte packet[RISCV_MAX_INSN_LEN];
  insn_t insn = 0;
  bfd_vma dump_size;
  int status;
  enum riscv_seg_mstate mstate;
  int (*riscv_disassembler) (bfd_vma, insn_t, const bfd_byte *,
			     struct disassemble_info *);

  /* Initialize the private data.  */
  if (info->private_data == NULL)
    {
      init_riscv_dis_private_data (info);
      init_riscv_dis_private_data_for_section (info);
    }
  struct riscv_private_data *pd = info->private_data;
  if (info->section != pd->last_section)
    init_riscv_dis_private_data_for_section (info);

  /* Guess and update XLEN if we haven't determined it yet.  */
  if (xlen == 0)
    update_riscv_dis_xlen (info);

  /* Update default state (data or code) for the disassembler.  */
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
	  return -1;
	}
      insn = (insn_t) bfd_getl16 (packet);
      dump_size = riscv_insn_length (insn);
      riscv_disassembler = riscv_disassemble_insn;
      /* Update the architecture if the mapping symbol is updated.  */
      if (pd->last_mapping_sym != pd->prev_last_mapping_sym)
	{
	  /* mapping_syms is always available but last_mapping_sym may not.  */
	  const char *arch
	      = pd->last_mapping_sym ? pd->last_mapping_sym->arch : NULL;
	  if (arch)
	    {
	      /* Override the architecture.  */
	      update_riscv_dis_arch (&dis_arch_context_override, arch);
	    }
	  else if (set_riscv_current_dis_arch_context (
		       &dis_arch_context_default))
	    {
	      /* Revert to the default architecture and call init functions if:
		 - there's no ISA string in the mapping symbol entry and
		 - current disassembler context is changed to the default one.
		 This is a shortcut path to avoid full update_riscv_dis_arch.
	       */
	      init_riscv_dis_state_for_arch ();
	      init_riscv_dis_state_for_arch_and_options ();
	    }
	  pd->prev_last_mapping_sym = pd->last_mapping_sym;
	}
    }

  /* Fetch the instruction to dump.  */
  status = (*info->read_memory_func) (memaddr, packet, dump_size, info);
  if (status != 0)
    {
      (*info->memory_error_func) (status, memaddr, info);
      return -1;
    }
  insn = (insn_t) bfd_get_bits (packet, dump_size * 8, false);

  /* Print, save the next expected address and return current size.  */
  status = (*riscv_disassembler) (memaddr, insn, packet, info);
  pd->expected_next_addr = memaddr + status;
  return status;
}

disassembler_ftype
riscv_get_disassembler (bfd *abfd)
{
  const char *default_arch = initial_default_arch;

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
	  default_arch = attr[Tag_RISCV_arch].s;
	  /* For ELF files with (somehow) no architecture string
	     in the attributes, use the default value.  */
	  if (!default_arch)
	    default_arch = initial_default_arch;
	  /* By default, set to the newest privileged version.  */
	  if (default_priv_spec == PRIV_SPEC_CLASS_NONE)
	    default_priv_spec = PRIV_SPEC_CLASS_DRAFT - 1;
	}
    }

  update_riscv_dis_arch (&dis_arch_context_default, default_arch);
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
  init_riscv_dis_state_for_arch_and_options ();
}

/* Free disassemble_info and all disassembler-related info
   (e.g. heap-allocated information that depends on either disassemble_info
    or BFD).  */

void
disassemble_free_riscv (struct disassemble_info *info)
{
  free_riscv_dis_arch_context (&dis_arch_context_default);
  free_riscv_dis_arch_context (&dis_arch_context_override);
  struct riscv_private_data *pd = info->private_data;
  if (pd)
    free (pd->mapping_syms);
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
