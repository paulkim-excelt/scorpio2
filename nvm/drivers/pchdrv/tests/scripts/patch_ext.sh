#!/bin/bash
################################################################################
#
# Copyright 2019-2021 Broadcom Limited.  All rights reserved.
#
# This program is the proprietary software of Broadcom Limited and/or its
# licensors, and may only be used, duplicated, modified or distributed pursuant
# to the terms and conditions of a separate, written license agreement executed
# between you and Broadcom (an "Authorized License").
#
# Except as set forth in an Authorized License, Broadcom grants no license
# (express or implied), right to use, or waiver of any kind with respect to the
# Software, and Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
# LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
# IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.
#
#  Except as expressly set forth in the Authorized License,
# 1. This program, including its structure, sequence and organization,
#    constitutes the valuable trade secrets of Broadcom, and you shall use all
#    reasonable efforts to protect the confidentiality thereof, and to use this
#    information only in connection with your use of Broadcom integrated
#    circuit products.
#
# 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
#    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
#    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
#    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
#    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
#    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
#    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
#    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
#    SOFTWARE.
#
# 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
#    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
#    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
#    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
#    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################

if ! [ -f "$1" ] ; then
	echo "-----------------------------------------------------------------"
	echo "This script extracts the patch routines from the given elf file"
	echo "Usage : $0 <elf-file> <patch function regex>"
	echo "-----------------------------------------------------------------"
	exit -1
fi

objdump_cmd="$TOOLCHAIN_PATH/bin/arm-none-eabi-objdump"

elf_file=$1
if [ "$2" == "" ] ; then
	patch_regex="PCHT_PatchRoutine[0-9]"
else
	patch_regex="$2"
fi

addrs=$($objdump_cmd -t $elf_file | grep $patch_regex)
array=($addrs)

conv_end () {
	hexval="${1}00000000"
	echo 0x${hexval:6:2}${hexval:4:2}${hexval:2:2}${hexval:0:2}
}

start_ix=0
while [ "${array[$start_ix]}" != "" ] ; do
	size_ix=$(($start_ix + 4))
	name_ix=$(($start_ix + 5))

	start_addr=$((0x${array[$start_ix]}))
	end_addr=$((0x${array[$size_ix]} + 0x${array[$start_ix]}))
	func_name=${array[$name_ix]}

	echo ----------------------------------------------------
	echo $func_name :
	cmd="$objdump_cmd -s $elf_file --start-address=$start_addr --stop-address=$end_addr"

	hex_start=0
	while IFS= read -r line
	do
	  if [ "$hex_start" == "1" ] ; then
	      address=($line)
          data=${line#$address}
          data=${data:0:42}
          data_arr=($data)
          out_line=
		  for i in 0 1 2 3 ; do
			  value=${data_arr[$i]}
			  if [ "$value" != "" ] ; then
				  out_line="${out_line}$(conv_end $value), "
			  fi
		  done
		  echo $out_line
	  elif [ "${line: -6}"  == ".text:" ] ; then
		  hex_start=1
	  fi
	done < <($cmd)

	start_ix=$(($start_ix + 6))
done
