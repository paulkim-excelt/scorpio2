/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

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
  ITCM (xw)         : ORIGIN = 0x00020000, LENGTH = 384K
  DTCM (xw)         : ORIGIN = 0x20000000, LENGTH = 240K
  IPC (rw)          : ORIGIN = 0x2007c000, LENGTH = 16K
  FLASH (r)     : ORIGIN = 0x60000000, LENGTH = 2M
  SCRATCHMEM (xrw)  : ORIGIN = 0x64000000, LENGTH = 40K
}

BCM_init_thread_stack_size = 0x100;
main_stack_size = 0x2000; /* 5KB */
bl_sz = 0x20000;/* code + RO (128KB) */

secure_heap_start = 0x20000000;
secure_heap_size = 0x4000;

imgl_region_start = secure_heap_start + secure_heap_size;
imgl_region_size = 0xC000;

privileged_region_start = imgl_region_start + imgl_region_size;
privileged_region_size = 0x8000;

data_region_start_addr = privileged_region_start + privileged_region_size;
data_region_size = 0x00008000; /* 32KB */

bss_region_start_addr = data_region_start_addr + data_region_size;

dwnld_area0_start = ORIGIN(ITCM) + LENGTH(ITCM) - bl_sz;

ipc_mem_start = ORIGIN(IPC);
ipc_size = LENGTH(IPC);

/* Define output sections */
SECTIONS
{
    . = ORIGIN(ITCM);
    .text :
    {
        __text_start__ = .;
        KEEP(*(.reset_func*))
        . = ALIGN(1024);
        KEEP(*(.vector_tbl*))
        *(.text*)
        *(.rodata*)
        *(.ethernet.rx0desctbl)
        . = ALIGN(4);
        __text_end__ = .;
    } > ITCM

    .download0 dwnld_area0_start (NOLOAD):
    {
        __download_area0_start__ = .;
        *(.imgl.memory.area0)
        __download_area0_end__ = .;
    } > ITCM

    . = ORIGIN(DTCM);
    .secureheap (secure_heap_start) (NOLOAD):
    {
        __secureheap_start__ = .;
        *(.secureheap*)
        *(.spumdma*)
        __secureheap_end__ = .;
        size_check = (__secureheap_end__ <= secure_heap_size) ;
        ASSERT(size_check , "***LINKER ERROR: Secure heap Section overflows the limit.");
    } > DTCM

    .imgl BLOCK(imgl_region_start) (NOLOAD):
    {
        __imgl_context_start__ = .;
        *(.imgl.context*)
        *(.imgl.auth_context*)
        *(.cpu.arm.CORTEXMXSysTickCount*)
        __imgl_context_end__ = .;
        size_check = (__imgl_context_end__ <= imgl_region_size) ;
        ASSERT(size_check , "***LINKER ERROR: IMGL Section overflows the limit.");
    } > DTCM

    .privileged privileged_region_start(NOLOAD):
    {
        __stack_start__ = .;
        . = ALIGN(8);
        . = . + main_stack_size;
        __main_stack__ = .;
        *(.stack.4k.*)
        *(.stack.2k.*)
        *(.stack.1k.*)
        *(.stack.512.*)
        *(.stack.256.*)
        . = . + BCM_init_thread_stack_size;
        BCM_init_thread_stack = .;
        __stack_end__ = .;
        . = ALIGN(4);
        __privileged_bss_start__ = .;
        __bss_os_start__ = .;
        *(.bss.os*)
        __bss_os_end__ = .;
        __drivers_bss_start__ = .;
        *(.bss.drivers*)
        __drivers_bss_end__ = .;
        . = ALIGN(4);
        __privileged_bss_end__ = .;
        size_check = (__privileged_bss_end__ <= privileged_region_size);
        ASSERT(size_check, "***LINKER ERROR: .data.privileged section overflows the limit.");
    } > DTCM

    .data data_region_start_addr(NOLOAD) :
    {
        __data_start__ = .;
        *(.data*)
        . = ALIGN(4);
        __data_end__ = .;
    } > DTCM

    .bss bss_region_start_addr(NOLOAD):
    {
        . = ALIGN(4);
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        *(.bss.err*)
        *(.imgl.auth_context*)
        . = ALIGN(4);
        __bss_end__ = .;
    } > DTCM

    .ipc BLOCK(ipc_mem_start) (NOLOAD):
    {
        *(.ipc*)
    } > IPC

    . = ORIGIN(FLASH);
    .flash (NOLOAD):
    {
        *(.imgl.mmap.addr0*)
    } > FLASH

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
