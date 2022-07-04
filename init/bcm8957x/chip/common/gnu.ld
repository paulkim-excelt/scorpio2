GROUP(libc.a libg.a libnosys.a libm.a)

/* Specify the memory areas */
MEMORY
{
  ITCM (xw)     : ORIGIN = 0x00020000, LENGTH = 384K
  DTCM (rw)     : ORIGIN = 0x20000000, LENGTH = 496K
  IPC (rw)      : ORIGIN = 0x2007C000, LENGTH = 16K
  SCRATCHMEM (xrw)  : ORIGIN = 0x64000000, LENGTH = 40K
}

/* NOTE: Any changes made here must be reflected in the MPU table as well */
main_stack_size = 0x1000;
BCM_init_thread_stack_size = 0x100;
irq_stack_size = 0x800;

text0_region_header = ORIGIN(ITCM);
text0_region_start = text0_region_header + 0x200;
text0_region_size = 0x0003FE00;       /* 256 KB */

privileged_region_start = text0_region_start + text0_region_size;
privileged_region_size = 0x00020000;    /* 128 KB */

imgl_region_start = ORIGIN(DTCM);
imgl_region_size = 0x8000;

text1_region_header = imgl_region_start + imgl_region_size;
text1_region_start = text1_region_header + 0x200;
text1_region_size = 0x00026E00;       /* 156 KB */

cfg_region_start = text1_region_start + text1_region_size;
cfg_region_size = 0x1000;    /*     4 KB    */

data_region_start = cfg_region_start + cfg_region_size;
data_region_size = 0x0000C000;          /* 48KB */

ipc_mem_start = ORIGIN(IPC);
ipc_region_size = LENGTH(IPC);

/* Define output sections */
SECTIONS
{
   .text1_hdr (text1_region_header) (NOLOAD):
   {
        __text1_header__ = .;
        . += 512;
        __text1_header_end__ = .;
   } > DTCM

   .text1 (text1_region_start):
    {
        __text1_start__ = .;
        *(.text.ETHSWT_*)
        *(.rodata*)
        *(.ethernet.rx0desctbl)
        . = ALIGN(4);
        __version_data_start__ = .;
        KEEP(*(.version*))
        __version_data_end__ = .;
        KEEP(*(.vcast.ro*))
        *(.patch*)
        . = ALIGN(64);
        __text1_end__ = .;
        __data_content_start__ = .;
        size_check = (__text1_end__  <= text1_region_size);
        ASSERT(size_check, "***LINKER ERROR: Code + RO Section overflows the limit.");
    } > DTCM

    .cfg (cfg_region_start) (NOLOAD):
     {
        . = ALIGN(1024);
        __xcvr_cfg_header__ = .;
        . += 512;
         __xcvr_cfg_start__ = .;
         *(.xcvr.cfg.*)
         __xcvr_cfg_end__ = .;
         size_check = (__xcvr_cfg_end__  <= cfg_region_size);
         ASSERT(size_check, "***LINKER ERROR: Config Section overflows the limit.");
     } > DTCM
}

SECTIONS{
    .text0_hdr (text0_region_header) (NOLOAD):
    {
        __text0_header__ = .;
        . += 512;
        __text0_header_end__ = .;
    } > ITCM

    .text0 (text0_region_start):
    {
        __text0_start__ = .;
        KEEP(*(.reset_func*))
        . = ALIGN(1024);
        *(.vector_tbl*)
        *(.text*)
        . = ALIGN(64);
        __text0_end__ = .;
        size_check = (__text0_end__  <= text0_region_size);
        ASSERT(size_check, "***LINKER ERROR: Code Section overflows the limit.");
    } > ITCM
}

SECTIONS
{
    .bss.privileged (privileged_region_start) (NOLOAD):
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
        *(.secureheap*)
        *(.spumdma*)
        *(.rbg200*)
        . = ALIGN(4);
        __privileged_bss_end__ = .;
        size_check = (__privileged_bss_end__ <= privileged_region_size);
        ASSERT(size_check, "***LINKER ERROR: .data.privileged section overflows the limit.");
    } > ITCM
}

SECTIONS
{
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

    .data BLOCK(data_region_start):
    {
        __data_start__ = .;
        *(vtable)
        *(.data*)
        . = ALIGN(64);
        __data_end__ = .;
        size_check = (__data_end__ <= data_region_size) ;
        ASSERT(size_check , "***LINKER ERROR: Data Section overflows the limit.");
    } > DTCM

    .bss (NOLOAD):
    {
        . = ALIGN(4);
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        *(*bcm.test*)
        __test_q_start__ = .;
        *(.testq*)
        *(.vcast.coverage.data*)
        __test_q_end__ = .;
        __bss_end__ = .;
    } > DTCM
}

SECTIONS
{
    .ipc (ipc_mem_start) (NOLOAD):
    {
        __ipc_start__ = .;
        *(.ipc*)
        __ipc_end__ = .;
        size_check = (__ipc_end__ <= ipc_region_size) ;
        ASSERT(size_check , "***LINKER ERROR: IPC Section overflows the limit.");
    } > IPC
}

SECTIONS
{
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
        *(.ethernet.rx0desctbl)
        *(.ethernet.rx0pktbuff)
        __eth_rw_end__ = .;
    } > SCRATCHMEM
}
