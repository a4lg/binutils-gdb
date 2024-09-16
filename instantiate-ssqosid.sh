#! /bin/bash
# SPDX-License-Identifier: CC0-1.0
# Author: Tsukasa OI <research_trasio@irq.a4lg.com>
# Year: 2023

check_csr_addr ()
{
	ADDR="$1"
	case "$ADDR" in
	0x* | 0X*)
		ADDR="${ADDR#??}"
		;;
	esac
	case "$ADDR" in
	[0-9a-fA-F])
		ADDR=00$ADDR
		;;
	[0-9a-fA-F][0-9a-fA-F])
		ADDR=0$ADDR
		;;
	[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])
		;;
	*)
		echo "ERROR: \`$1' is not a valid CSR address for \`$2'." 1>&2
		exit 1
		;;
	esac
	ADDR=$(echo $ADDR | tr A-F a-f)
	printf %s $ADDR
	return 0
}

canonicalize_hex ()
{
	ADDR=$1
	while :
	do
		case $ADDR in
		0)
			break
			;;
		0?*)
			ADDR=${ADDR#0}
			;;
		*)
			break
			;;
		esac
	done
	printf 0x%s $ADDR
}

dwarf_regnum ()
{
	echo -n $(($1 + 4096))
}

dwarf_offset ()
{
	echo -n $(($1 * 4))
}

test_path ()
{
	if test '!' -f "$1"
	then
		echo "ERROR: file \`$1' is not found." 1>&2
		exit 1
	fi
}

CSRS=(
	sqoscfg
)

if test $# -ne ${#CSRS[@]}
then
	ERRMSG="usage: $0"
	for CSR in ${CSRS[@]}
	do
		CSR_UPPER=$(echo $CSR | tr a-z A-Z)
		ERRMSG="$ERRMSG ADDR_${CSR_UPPER}"
	done
	echo "$ERRMSG" 1>&2
	exit 1
fi

PRIV_VERSIONS="1p9p1 1p10 1p11 1p12"

test_path include/opcode/riscv-opc.h
for V in $PRIV_VERSIONS
do
	test_path gas/testsuite/gas/riscv/csr-version-$V.d
done
test_path gas/testsuite/gas/riscv/csr-dw-regnums.s
test_path gas/testsuite/gas/riscv/csr-dw-regnums.d

do_csr_instantiation ()
{
	CSR="$1"
	CSR_UPPER=$(echo $CSR | tr a-z A-Z)
	ADDR=$(check_csr_addr "$2" $CSR)
	HEXC=$(canonicalize_hex $ADDR)
	DWREG=$(dwarf_regnum $HEXC)
	DWOFF=$(dwarf_offset $HEXC)
	ORIG_ADDR=$(grep "a0,${CSR}\$" gas/testsuite/gas/riscv/csr-version-1p12.d | head -n 1 | sed 's/.*+\([0-9a-f]\{3\}\)02573.*/\1/')
	sed -i "s/^#define CSR_${CSR_UPPER} .*/#define CSR_${CSR_UPPER} $HEXC/" include/opcode/riscv-opc.h
	for V in $PRIV_VERSIONS
	do
		sed -i "s/+${ORIG_ADDR}\\(02573\\|59073\\)/+${ADDR}\\1/" gas/testsuite/gas/riscv/csr-version-$V.d
	done
	sed -i "s/\\.cfi_offset ${CSR}, .*/.cfi_offset ${CSR}, ${DWOFF}/" gas/testsuite/gas/riscv/csr-dw-regnums.s
	sed -i "s/DW_CFA_offset_extended_sf: r[0-9]\\+ \\\\(${CSR}\\\\) at cfa\\\\+[0-9]\\+/DW_CFA_offset_extended_sf: r${DWREG} \\\\(${CSR}\\\\) at cfa\\\\+${DWOFF}/" gas/testsuite/gas/riscv/csr-dw-regnums.d
}

for CSR in ${CSRS[@]}
do
	do_csr_instantiation $CSR "$1"
	shift
done

if test -f "$0"
then
	rm -f "$0"
fi
exit 0
