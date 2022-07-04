/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Limited and/or its
 licensors, and may only be used, duplicated, modified or distributed pursuant
 to the terms and conditions of a separate, written license agreement executed
 between you and Broadcom (an "Authorized License").

 Except as set forth in an Authorized License, Broadcom grants no license
 (express or implied), right to use, or waiver of any kind with respect to the
 Software, and Broadcom expressly reserves all rights in and to the Software
 and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
 LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
 IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.

  Except as expressly set forth in the Authorized License,
 1. This program, including its structure, sequence and organization,
    constitutes the valuable trade secrets of Broadcom, and you shall use all
    reasonable efforts to protect the confidentiality thereof, and to use this
    information only in connection with your use of Broadcom integrated
    circuit products.

 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

GROUP(libc.a libg.a libnosys.a libm.a)

MEMORY
{
  ITCM0 (xw)       : ORIGIN = 0x00020000, LENGTH = 256K
  ITCM1 (xw)       : ORIGIN = 0x00060000, LENGTH = 130K /* 128K + 2K for over-size test images */
  DTCM (xw)        : ORIGIN = 0x20000000, LENGTH = 240K
  IPC (rw)         : ORIGIN = 0x2003c000, LENGTH = 16K
  SCRATCHMEM (xrw) : ORIGIN = 0x64000000, LENGTH = 40K
}

main_stack_size = 0x2000; /* 5KB */
bl_sz = 0x20000;/* code + RO (128KB) */
ipc_mem_start = ORIGIN(IPC);
ipc_size = LENGTH(IPC);
security_size = 0x10000;
data_start_addr = ORIGIN(DTCM) + security_size;

/* Define output sections */
SECTIONS
{
    . = ORIGIN(ITCM0);
    .download (NOLOAD):
    {
        __download_area0_start__ = .;
        *(.download.area0*)
        __download_area0_end__ = .;
    } > ITCM0

    .text :
    {
        __text_start__ = .;
        . += 512;
        KEEP(*(.vector_tbl))
        *(.text*)
        *(.rodata*)
        *(.ethernet.rx0desctbl)
        . = ALIGN(4);
        __text_end__ = .;
    } > ITCM1

    . = ORIGIN(DTCM);

    .security (NOLOAD) :
    {
       __security_start__ = .;
       . = ALIGN(4);
       *(.secureheap*)
        *(.spumdma*)
       __security_end__ = .;
       size_check = (__security_end__ <= security_size) ;
        ASSERT(size_check , "***LINKER ERROR: Security Section overflows the limit.");
    } > DTCM

     .data data_start_addr (NOLOAD) :
    {
        __data_start__ = .;
        *(vtable)
        *(.data*)
        . = ALIGN(4);
        __data_end__ = .;
    } > DTCM

    .stack (NOLOAD):
    {
        __stack_start__ = .;
        . = ALIGN(8);
        . = . + main_stack_size;
        __main_stack__ = .;
        __stack_end__ = .;
    } > DTCM

    .bss (NOLOAD):
    {
        . = ALIGN(4);
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        *(.bss.drivers*)
        *(.bss.err*)
        . = ALIGN(4);
        __bss_end__ = .;
    } > DTCM

    .ipc BLOCK(ipc_mem_start) (NOLOAD):
    {
        BL_IPC_StartAddr = .;
        *(.ipc*)
        BL_IPC_EndAddr = BL_IPC_StartAddr + ipc_size;
    } > IPC

    . = ORIGIN(SCRATCHMEM);
    .eth_ro (NOLOAD):
    {
        __eth_ro_start__ = .;
        *(.ethernet.rx0copydesctbl)
        __eth_ro_end__ = .;
    } > SCRATCHMEM

    .eth_rw (NOLOAD):
    {
        __eth_rw_start__ = .;
        . = ALIGN(256);
        *(.ethernet.tx0desctbl)
        *(.ethernet.tx0pktbuff)
        *(.ethernet.tx1desctbl)
        *(.ethernet.tx1pktbuff)
        *(.ethernet.tx2desctbl)
        *(.ethernet.tx2pktbuff)
        *(.ethernet.tx3desctbl)
        *(.ethernet.tx3pktbuff)
        *(.ethernet.rx0pktbuff)
        __eth_rw_end__ = .;
    } > SCRATCHMEM
}
