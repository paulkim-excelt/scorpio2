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

/**
    @defgroup grp_bcm8957x_rom_qt Qualification Tests
    @ingroup grp_bcm8957x_rom

    @addtogroup grp_bcm8957x_rom_qt
    @{

    @file bcm8957x_rom_qt.h
    @brief BCM8957x BootROM Qualification Test
    This file contains test cases and test sequences for the
    BCM8957x BootROM component

    Below tables lists all the constants referenced in the
	BCM8957x BootROM Test Cases.

    | ID Name                            | BCM8957x B0 ROM simulated in A0 | Value in BCM8957x B0            |
    |------------------------------------|---------------------------------|---------------------------------|
    | ROM_PROG_REGISTER                  | 0x4A800FFE                      | 0x4A800FFE                      |
    | ROM_ADDRESS_RANGE                  | 0x8200-0x40000                  | 0x200-0x20000                   |
    | ROM_DOWNLOAD_AREA                  | 0x60000-0x80000                 | 0x60000-0x80000                 |
    | ROM_BYPASS_ADDRES                  | 0x8064                          | 0x64                            |
    | ROM_OTP_BYPASS                     | Row-12 Bit-0                    | Row-12 Bit-0                    |
    | ROM_NMI_FAULT_ADDR                 | CORTEX_MX_NMI_FAULT (map file)  | CORTEX_MX_NMI_FAULT (map file)  |
    | ROM_HARD_FAULT_ADDR                | CORTEX_MX_HARD_FAULT (map file) | CORTEX_MX_HARD_FAULT (map file) |
    | ROM_MPU_FAULT_ADDR                 | CORTEX_MX_MPU_FAULT (map file)  | CORTEX_MX_MPU_FAULT (map file)  |
    | ROM_TEST_BL_FLASH                  | 0x80FF                          | 0x80FF                          |
    | ROM_TEST_BL_IPC                    | 0x81FF                          | 0x81FF                          |
    | ROM_TEST_BL_TFTP                   | 0x82FF                          | 0x82FF                          |
    | ROM_TEST_BL_RDUMP                  | 0x83FF                          | 0x83FF                          |
    | ROM_TEST_BL_WDT                    | 0x84FF                          | 0x84FF                          |
    | ROM_TEST_BL_FULL                   | 0x85FF                          | 0x85FF                          |
    | ROM_TEST_BL_MCM                    | 0x86FF                          | 0x86FF                          |
    | ROM_IPC_STATUS_REG                 | 0x4A800330                      | 0x4A800330                      |
    | ROM_IPC_CTRL_REG                   | 0x4A800332                      | 0x4A800332                      |
    | ROM_IPC_DL_ADDR                    | 0x2007C000                      | 0x2007C000                      |
    | ROM_TC10_DTCM_ADDR                 | 0x2003BC00                      | 0x2003BC00                      |
    | ROM_DTCM_ADDR_RANGE                | 0x20000000-0x2003BFFF           | 0x20000000-0x2003BFFF           |
    | DBG_LOG_ROM_BYPASS                 | 2                               | 2                               |
    | DBG_LOG_CHECK_PLL_STATUS           | 3                               | 3                               |
    | DBG_LOG_PLL_NOT_LOCKED_LOOP        | 4                               | 4                               |
    | DBG_LOG_SWITCH_CPU_CLK             | 5                               | 5                               |
    | DBG_LOG_TCM_INIT                   | 6                               | 6                               |
    | DBG_LogBuffer[] Address            | Refer to rom map file           | Refer to rom map file           |

    @version 0.1 Initial Version
*/

#ifndef BCM8957X_ROM_QT_H
#define BCM8957X_ROM_QT_H

/**
    @brief ROM Binary verification.

           To verify that ROM binary loaded in simulation is matching the compiled binary

    @pre   ROM memory is empty

    @test  Load the released ROM hex file to ROM memory. Dump the ROM memory to a file in
           hex format and compare it with released binary file

    @post  Both bin files shall match

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BIN_MATCH                 (0x101UL)

/**
    @brief ROM Bypass Mode

           To verify that the ROM enters to bypass mode if bypass-mode OTP is set

    @pre
           - Load OTP with Bypass-mode bit set (ROM_OTP_BYPASS)
           - Load the ROM hex file and execute ROM

    @test  Wait for 500us and capture the ROM_PROG_REGISTER
           ROM_PROG_REGISTER

    @post
           - ROM_PROG_REGISTER value shall match DBG_LOG_ROM_BYPASS
           - ARM shall be looping at address ROM_BYPASS_ADDR

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BYPASS                    (0x102UL)

/**
    @brief ARM Exception table

           To verify that ARM goes into while(1) loop if exception occurs while executing
           ROM

    @pre   Load the corrupted ROM hex file (change the instruction from 0x68004845 -> 0xFFFFFFFF)

    @test
         - Load and Execute ROM
         - Wait for 500us and monitor the PC register.

    @post  ARM shall enter into hard fault and keep looping at address ROM_HARD_FAULT_ADDR

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_FAULT                     (0x103UL)

/**
    @brief RAM Dump mode

           To verify that the RAM dump mode is handled correctly in BootROM

    @pre
           - Load flash memory with test application that sets the ramdump flag and soft-
             reset
           - The test application should set some unused TCM address with known pattern

    @test
           - Load and execute ROM
           - Check the ROM_PROG_REGISTER
           - Check the TCM content for the known pattern (end of ROM_DTCM_ADDR_RANGE)

    @post
           - System should boot up and go through reset once
           - After reaching the test application for the second time the TCM content should
             be preserved
           - ROM_PROG_REGISTER shall have the value ROM_TEST_BL_RDUMP

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_RAM_DUMP                  (0x104UL)

/**
    @brief DTCM ECC Error trap

           To verify on DTCM ECC error triggers NMI and eventually resets the processor

    @pre   Flash should be empty, no TFTP or IPC server running

    @test
           - Load and execute ROM
           - Put a break point in BCM8957X_RomMain()
           - Clear bit 2 (NMI timeout reset) of 0x4A820042 register (set 0x11A)
           - Backdoor load the DTCM with some random pattern in first 10K of ROM_DTCM_ADDR_RANGE
           - Resume execution and wait for 1ms emulation time and monitor PC

    @post
           - The random pattern should assert double bit ECC error and the processor should
             enter NMI
           - PC should be pointing to ROM_NMI_FAULT_ADDR

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_DTCM_ERR                  (0x105UL)

/**
    @brief Non-secure boot from flash

           To verify non-secure boot from flash

    @pre
           - Load non-secure flash image to flash memory
           - Load OTP security secure bit set to 0

    @test
           - Load and Execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register
           - Check the content of DBG_LogBuffer[]
           - Execution time ~2ms

    @post
           - ROM loads the bootloader image from flash to TCM and jumps to the entry point.
           - The ROM_PROG_REGISTER shall capture ROM_TEST_BL_FLASH
           - ARM shall be looping at address ROM_DOWNLOAD_AREA
           - The DBG_LogBuffer[] shall have following values in given order (may have other values in between)
               - #DBG_LOG_CHECK_PLL_STATUS (only in simulation)
               - #DBG_LOG_SWITCH_CPU_CLK   (only in simulation)
               - #DBG_LOG_ENTRY_MAIN
               - #DBG_LOG_TIM_INIT
               - #DBG_LOG_OTP_INIT
               - #DBG_LOG_READ_IP_CONFIG
               - #DBG_LOG_READ_SWT_CONFIG
               - #DBG_LOG_READ_XCVR_CONFIG
               - #DBG_LOG_READ_TC10_CONFIG
               - #DBG_LOG_APPLY_XCVR_MIN_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_APPLY_XCVR_FULL_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_LOADER_VERIFY_SUCCESS
               - #DBG_LOG_OTP_DEINIT
               - #DBG_LOG_ENTER_DOWNLOADED_EXE

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT              (0x106UL)

/**
    @brief Non-secure boot from flash - CRC error

           To verify non-secure boot from flash fails in case of CRC error

    @pre
           - Load non-secure flash image to flash memory with some bytes in the bootloader
             inverted
           - Load OTP security secure bit set to 0

    @test
           - Load and Execute ROM
           - Monitor the PC register

    @post
           - ARM shall be looping at ROM location (ROM_ADDRESS_RANGE)
           - The DBG_LogBuffer[] shall have DBG_LOG_LOADER_IMG_NOT_FOUND

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_CRC_ERR      (0x107UL)

/**
    @brief Bootloader header error

           To verify that boot loading fails if the header is corrupted

    @pre
           - Load non-secure flash image to flash memory with some bytes in the image
             header inverted (0x1004)
           - Load OTP security secure bit set to 0

    @test
           - Load and Execute ROM
           - Monitor the PC register

    @post
           - ARM shall be looping at ROM location (ROM_ADDRESS_RANGE)
           - The DBG_LogBuffer[] shall have DBG_LOG_LOADER_DEINIT_SUCCESS

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_IMG_HDR_ERROR             (0x108UL)

/**
    @brief Bootloader with invalid entry point

           To verify that bootrom does not jump to invalid entry point

    @pre
           - Load non-secure flash image to flash memory with entry point set outside the
             download area. Entry point is located at 0x1020 of the flash hex file
           - Load OTP with secure bit set to 0

    @test
           - Load and Execute ROM
           - Monitor the PC register

    @post
           - ARM shall be looping at ROM location (ROM_ADDRESS_RANGE)
           - The DBG_LogBuffer[] shall have DBG_LOG_LOADER_DEINIT_SUCCESS

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BOOT_ENTRY_ADDR_ERROR     (0x109UL)

/**
    @brief Full size bootloader test

           To verify that loading of full size (128KB) bootloader

    @pre
           - Load full size flash image (128KB) to flash memory
           - Load OTP security secure bit set to 0

    @test
           - Load and Execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image from flash to TCM and jumps to the entry point.
           - The ROM_PROG_REGISTER shall have the value ROM_TEST_BL_FULL
           - ARM shall be looping in ROM_DOWNLOAD_AREA
           - The DBG_LogBuffer[] shall have following values in given order (may have other values in between)
               - #DBG_LOG_CHECK_PLL_STATUS (only in simulation)
               - #DBG_LOG_SWITCH_CPU_CLK   (only in simulation)
               - #DBG_LOG_ENTRY_MAIN
               - #DBG_LOG_TIM_INIT
               - #DBG_LOG_OTP_INIT
               - #DBG_LOG_READ_IP_CONFIG
               - #DBG_LOG_READ_SWT_CONFIG
               - #DBG_LOG_READ_XCVR_CONFIG
               - #DBG_LOG_READ_TC10_CONFIG
               - #DBG_LOG_APPLY_XCVR_MIN_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_APPLY_XCVR_FULL_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_OTP_DEINIT
               - #DBG_LOG_ENTER_DOWNLOADED_EXE

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_MAX_SIZE     (0x10AUL)

/**
    @brief Large size bootloader test

           To verify that loading bootloader larger than 128KB fails

    @pre
           - Load full size flash image (> 128KB) to flash memory
           - Load OTP security secure bit set to 0

    @test
           - Load and Execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ARM shall be looping at ROM location
           - The DBG_LogBuffer[] shall have DBG_LOG_LOADER_IMG_NOT_FOUND

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_SIZE_OV      (0x10BUL)

/**
    @brief Secure boot from flash (RSA-Signature)

           To verify secure boot authenticated by RSA-Signature

    @pre
           - Load flash image signed with RSA to flash memory
           - Load OTP with secure bit on and RSA key

    @test
           - Load and Execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor PC register
           - Check the content of DBG_LogBuffer[]
           - Execution time ~12ms

    @post
           - ROM loads the bootloader image from flash to TCM and jumps to the entry point.
           - The ROM_PROG_REGISTER shall have value ROM_TEST_BL_FLASH
           - ARM shall be looping at ROM_DOWNLOAD_AREA
           - The DBG_LogBuffer[] shall have following values in given order (may have other values in between)
               - #DBG_LOG_CHECK_PLL_STATUS (only in simulation)
               - #DBG_LOG_SWITCH_CPU_CLK   (only in simulation)
               - #DBG_LOG_ENTRY_MAIN
               - #DBG_LOG_TIM_INIT
               - #DBG_LOG_OTP_INIT
               - #DBG_LOG_READ_IP_CONFIG
               - #DBG_LOG_READ_SWT_CONFIG
               - #DBG_LOG_READ_XCVR_CONFIG
               - #DBG_LOG_READ_TC10_CONFIG
               - #DBG_LOG_APPLY_XCVR_MIN_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_APPLY_XCVR_FULL_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_READ_PKEY_CONFIG
               - #DBG_LOG_LOADER_VERIFY_SUCCESS
               - #DBG_LOG_OTP_DEINIT
               - #DBG_LOG_ENTER_DOWNLOADED_EXE

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_SEC_BOOT                  (0x10CUL)

/**
    @brief Secure boot from flash (RSA-Signature and encryption)

           To verify secure boot encrypted and authenticated by RSA-Signature

    @pre
           - Load encrypted flash image signed with RSA to flash memory
           - Load OTP with secure bit on and RSA key and AES key

    @test
           - Load and Execute ROM for 30ms emulation time
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor PC register
           - Check the content of DBG_LogBuffer[]

    @post
           - ROM loads the bootloader image from flash to TCM and jumps to the entry point.
           - The ROM_PROG_REGISTER shall have value ROM_TEST_BL_FLASH
           - ARM shall be looping at ROM_DOWNLOAD_AREA
           - The DBG_LogBuffer[] shall have following values in given order (may have other values in between)
               - #DBG_LOG_CHECK_PLL_STATUS (only in simulation)
               - #DBG_LOG_SWITCH_CPU_CLK   (only in simulation)
               - #DBG_LOG_ENTRY_MAIN
               - #DBG_LOG_TIM_INIT
               - #DBG_LOG_OTP_INIT
               - #DBG_LOG_READ_IP_CONFIG
               - #DBG_LOG_READ_SWT_CONFIG
               - #DBG_LOG_READ_XCVR_CONFIG
               - #DBG_LOG_READ_TC10_CONFIG
               - #DBG_LOG_APPLY_XCVR_MIN_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_APPLY_XCVR_FULL_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_READ_SKEY_CONFIG
               - #DBG_LOG_READ_PKEY_CONFIG
               - #DBG_LOG_LOADER_VERIFY_SUCCESS
               - #DBG_LOG_OTP_DEINIT
               - #DBG_LOG_ENTER_DOWNLOADED_EXE

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT              (0x10DUL)

/**
    @brief Secure boot from flash - authentication error

           To verify secure boot fails for signature authentication error

    @pre
           - Load encrypted flash image with corrupted RSA signature to flash memory
           - Load OTP with secure bit on and RSA key and AES key

    @test
           - Load and Execute ROM for 30ms emulation time
           - Monitor the PC register
           - Check the content of DBG_LogBuffer[]

    @post
           - ROM loads the bootloader image from flash to TCM and decrypt
           - ARM shall be looping at ROM_ADDRESS_RANGE
           - The DBG_LogBuffer[] shall have following values in given order (may have other values in between)
               - #DBG_LOG_CHECK_PLL_STATUS (only in simulation)
               - #DBG_LOG_SWITCH_CPU_CLK   (only in simulation)
               - #DBG_LOG_ENTRY_MAIN
               - #DBG_LOG_TIM_INIT
               - #DBG_LOG_OTP_INIT
               - #DBG_LOG_READ_IP_CONFIG
               - #DBG_LOG_READ_SWT_CONFIG
               - #DBG_LOG_READ_XCVR_CONFIG
               - #DBG_LOG_READ_TC10_CONFIG
               - #DBG_LOG_APPLY_XCVR_MIN_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_APPLY_XCVR_FULL_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_READ_SKEY_CONFIG
               - #DBG_LOG_READ_PKEY_CONFIG
               - #DBG_LOG_LOADER_VERIFY_FAILED

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT_ERR          (0x10EUL)

/**
    @brief Boot from PT Copy 2

           To verify that if PT header is corrupted, it boots from the valid copy

    @pre
           - Load non-secure bootloader flash image to the flash memory
           - Load OTP with secure bit off
           - Corrupt the magic number in PT copy 0 (0x0000)
           - Corrupt the EDC field in PT copy 1 (0x0108)

    @test
           - Load and Execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image from flash to TCM after decryption and jumps to
             the entry point.
           - ARM shall be looping at ROM_DOWNLOAD_AREA
           - The ROM_PROG_REGISTER shall have ROM_TEST_BL_FLASH value
           - The DBG_LogBuffer[] shall have following values in given order (may have other values in between)
               - #DBG_LOG_CHECK_PLL_STATUS (only in simulation)
               - #DBG_LOG_SWITCH_CPU_CLK   (only in simulation)
               - #DBG_LOG_ENTRY_MAIN
               - #DBG_LOG_TIM_INIT
               - #DBG_LOG_OTP_INIT
               - #DBG_LOG_READ_IP_CONFIG
               - #DBG_LOG_READ_SWT_CONFIG
               - #DBG_LOG_READ_XCVR_CONFIG
               - #DBG_LOG_READ_TC10_CONFIG
               - #DBG_LOG_APPLY_XCVR_MIN_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_APPLY_XCVR_FULL_CONFIG
               - #DBG_LOG_APPLY_TC10_FWD_COMPLETE
               - #DBG_LOG_LOADER_VERIFY_SUCCESS
               - #DBG_LOG_OTP_DEINIT
               - #DBG_LOG_ENTER_DOWNLOADED_EXE

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_PT_COPY                   (0x10FUL)

/**
    @brief PT Copy error

           To verify that if all the PT headers are corrupted, it does not boot

    @pre
           - Load non-secure bootloader flash image to the flash memory
           - Load OTP with secure bit off
           - Corrupt some bits in all 16 PT copies (0x0000 to 0x1000)

    @test
           - Load and Execute ROM
           - Monitor the PC register

    @post
           - ROM does not load any bootloader
           - ARM shall be looping in ROM_ADDRESS_RANGE

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_PT_COPY_ERR               (0x110UL)

/**
    @brief Non-secure boot over IPC

           To verify non-secure boot over IPC

    @pre
           - Flash shall not contain any valid image
           - Load OTP with secure bit off, Flash boot and IPC boot enabled
           - IPC server is running with bl image in the linux system connected to the PCIe
             port
               - Build the PCIe driver kernel module (sudo make -C /usr/src/linux-headers-`uname -r` M=`pwd` modules)
               - PCIe driver kernel module is installed (sudo insmod brcm-xgbe.ko)
               - Permission is given for the /dev/net/bcm (chmod 777 /dev/net/bcm)
               - run bcmutild that loads the test bootloader image

    @test
           - Load and execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image to TCM and jumps to the entry point
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_IPC
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_IPC_BL                    (0x111UL)

/**
    @brief Secure boot over IPC

           To verify secure boot over IPC

    @pre
           - Flash shall not contain any valid image
           - Load OTP with secure bit on and RSA key
           - Flash boot and IPC boot shall be enabled in OTP
           - IPC server is running with bl image in the linux system connected to the PCIe
             port
               - PCIe driver kernel module is installed (sudo insmod brcm-xgbe.ko)
               - Permission is given for the /dev/net/bcm (chmod 777 /dev/net/bcm)
               - run bcmutild that loads the signed bootloader image

    @test
           - Load and execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image to TCM and jumps to the entry point
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_IPC
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_IPC_SEC_BL                (0x112UL)

/**
    @brief Boot over TFTP with force download mode

           To verify that the download and execution of bootloader happens over TFTP
           when force download mode is set

    @pre
           - TFTP server is downloaded from http://tftpd32.jounin.net/tftpd32_download.html
             (tftpd64 - v4.64 released on 28-Feb-2019) and installed.
           - Refer to the QSG documentation for TFTPD64 configuration
           - One of the port is connected to a PC through network and TFTP server is
             running on the PC with (with valid bootloader image)
           - Flash contains valid non-secure flash image
           - Force download strap bit is set
           - OTP has TFTP and Flash Boot enabled
           - OTP contains the static IP configuration

    @test
           - Load and execute ROM
           - Compare the Bootloder binary with TCM memory dump (from bootloader start
             address)
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - TCM memory dump should match the bootloader
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_TFTP
           - ARM shall keep looping at ROM_DOWNLOAD_AREA
           - DBG_LogBuffer[] shall have values #DBG_LOG_SKIP_FLASH_LOADER and #DBG_LOG_TFTPLDR_FETCH_IMG_SUCCESS

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_FORCE_DL_TFTP             (0x113UL)

/**
    @brief TFTP Boot after timeout

           To verify TFTP boot happens after timeout retry

    @pre
           - One of the port is connected to a PC through network (TFTP server not running)
           - Flash memory is empty
           - Load OTP with IPC, TFTP and Flash Boot enabled

    @test
           - Load and execute ROM
           - Check the PC and ROM progress registers (ROM_PROG_REGISTER)
           - After 1.5 seconds (emulation time) start the TFTP server on the PC
           - Wait for 1 second (real time) and check the PC and progress register (ROM_PROG_REGISTER)

    @post
           - Initial ROM_PROG_REGISTER MSB shall have 0x00
           - PC will be in the ROM_ADDRESS_RANGE range
           - On second check, ROM_PROG_REGISTER shall have ROM_TEST_BL_TFTP
           - On second check, ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_TIMEOUT           (0x114UL)

/**
    @brief Secure Boot over TFTP

           To verify that the download and execution of secure bootloader happens over TFTP

    @pre
           - One of the port is connected to a PC through network and TFTP and DHCP server
             is running on the PC that contains the secure bootloader binary max size (128KB)
           - Flash memory is empty
           - Load OTP with TFTP and Flash Boot enabled
           - OTP does not contain any static IP configuration

    @test
           - Load and execute ROM
           - Compare the Bootloder binary with TCM memory dump (from bootloader start
             address)
           - Monitor the ROM_PROG_REGISTER

    @post
           - TCM memory dump should match the bootloader
           - ROM_PROG_REGISTER register shall have ROM_TEST_BL_FULL
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_TFTP_SEC_BL               (0x115UL)

/**
    @brief Secure Boot over TFTP large image

           To verify that the download fails for large image over TFTP

    @pre
           - One of the port is connected to a PC through network and TFTP & DHCP server is
             running on the PC that contains the secure bootloader binary size more than
             (128KB)
           - Flash memory is empty
           - Load OTP with TFTP and Flash Boot enabled

    @test
           - Load and execute ROM
           - After 10ms emulation time, monitor the ROM_PROG_REGISTER and PC

    @post
           - ARM shall keep looping at ROM_ADDRESS_RANGE
           - ROM_PROG_REGISTER MSB shall be 0

    @functional Yes

    @type  Negative

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_LARGE             (0x116UL)

/**
    @brief Boot mode select for Flash

           To verify that the correct bootmode selected for flash boot

    @pre
           - Flash memory contains valid non-secure bootloader image
           - One of the port is connected to a PC through network and TFTP server is
             running on the PC that contains the secure bootloader binary
           - Load OTP with TFTP and IPC boot disabled in Flash boot enabled

    @test
           - Load and execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image to TCM and jumps to the entry point
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_FLASH
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_FL              (0x117UL)

/**
    @brief Boot mode select for IPC on TFTP timeout

           To verify that the correct bootmode selected for IPC boot if TFTP timeout

    @pre
           - Load flash memory with valid non-secure bootloader image
           - Flash boot disabled and TFTP boot and IPC boot are enabled in OTP
           - No TFTP server running any any of the ports
           - IPC server is running with bl image in the linux system connected to the PCIe
             port
               - PCIe driver kernel module is installed (sudo insmod brcm-xgbe.ko)
               - Permission is given for the /dev/net/bcm (chmod 777 /dev/net/bcm)
               - run bcmutild that loads the test bootloader image

    @test
           - Load and execute ROM for 1sec emulation time
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image to TCM and jumps to the entry point
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_IPC
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP_IPC        (0x118UL)

/**
    @brief Boot mode select for IPC

           To verify that the correct bootmode selected for IPC boot

    @pre
           - Load flash memory with valid non-secure bootloader image
           - Flash boot and TFTP boot are disabled and IPC boot is enabled in OTP
           - TFTP server running on on the the port with valid bootloader image
           - IPC server is running with bl image in the linux system connected to the PCIe
             port
               - PCIe driver kernel module is installed (sudo insmod brcm-xgbe.ko)
               - Permission is given for the /dev/net/bcm (chmod 777 /dev/net/bcm)
               - run bcmutild that loads the test bootloader image

    @test
           - Load and execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image to TCM and jumps to the entry point
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_IPC
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_IPC             (0x119UL)

/**
    @brief Boot mode select for TFTP

           To verify that the correct bootmode selected for TFTP boot

    @pre
           - Load flash memory with valid non-secure bootloader image
           - Flash boot and IPC boot are disabled and TFTP boot is enabled in OTP
           - TFPT and DHCP server with valid bootloader image running on the system
             connected to one of the port
           - No static ip configuration present in the OTP

    @test
           - Load and execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM loads the bootloader image to TCM and jumps to the entry point
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_TFTP
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP            (0x11AUL)

/**
    @brief TC10 Wake forward using AXI

           To verify that the TC10 wake forward is handled correctly with AXI registers

    @pre   Load OTP with valid TC10 forward map with AXI register access

    @test
           - Load and execute ROM
           - Load the OTP memory with valid TC10 configuration
               - OTP BR1, BR2, BR3 and BR4 are participating in partial networking
               - Wake via pin forwards the wakeup to BR1 and BR3
               - BR1 wakeup forwards the wakeup to BR2 and BR3
               - BR2 wakeup forwards the wakeup to BR3 and BR4
               - BR3 wakeup forwards the wakeup to BR4 and BR1
               - BR4 wakeup forwards the wakeup to BR1 and BR2
           - Force BRPHYS_TC10_STATUS_REG[8] = 0b'1 (0x4A800346[8] = 1)
           - Force BR1 TC10_STATUS 0x490F01FC[5, 0] = 1, 0
           - Force BR2 TC10_STATUS 0x494F01FC[5, 0] = 1, 1
           - Force BR2 TC10_STATUS 0x498F01FC[5, 0] = 0, 0
           - Force BR4 TC10_STATUS 0x49CF01FC[5, 0] = 1, 0
           - Monitor the TC10_CONTROL registers for all the BR phys
           - Execution time ~850us

    @post  The TC10_CONTROL[3] should be asserted by the ROM based on the forward map
           - 0x08 is written to TC10_CONTROL registers of BR2, BR3 and BR4

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_TC10_AXI                  (0x11BUL)

/**
    @brief TC10 Wake forward MDIO

           To verify that the TC10 wake forward is handled correctly with MDIO registers

    @pre
           - OTP contains the TC10 forward map with MDIO & AXI register access
           - OTP contains one invalid TC10 AXI address (0)
           - One Denali phy is connected through the MDIO instance 1

    @test
           - Load and execute ROM
           - Load the OTP memory with valid TC10 configuration
               - BR1, BR2, BR3, BR4 and one Denali are participating in partial networking
               - Wake via pin forwards the wakeup to BR1
               - BR1 wakeup forwards the wakeup to Denali
               - BR2 wakeup forwards the wakeup to BR3 and BR4
               - BR3 wakeup forwards the wakeup to BR4 and BR1
               - BR4 wakeup forwards the wakeup to BR1 and BR2
               - Denali wakeup forwards the wakeup to BR2
           - Force BR1 TC10_STATUS 0x490F01FC[5, 0] = 1, 1
           - Force BR2 TC10_STATUS 0x494F01FC[5, 0] = 0, 0
           - Force BR2 TC10_STATUS 0x498F01FC[5, 0] = 0, 0
           - Force BR4 TC10_STATUS 0x49CF01FC[5, 0] = 0, 0
           - Force Denal TC10_STATUS     0xF1[5, 0] = 1, 1
           - Monitor the TC10_CONTROL registers for all the BR phys and denali
           - Execution time ~5.7

    @post  The TC10_CONTROL[3] should be asserted by the ROM based on the forward map
           - DBG_LOG_APPLY_TC10_FWD_COMPLETE in ROM_PROG_REGISTER
           - 0x08 is written to TC10_CONTROL registers of BR2 (0x494F01FE) and Denali (0xF0)

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_TC10_MDIO                 (0x11CUL)

/**
    @brief Communication in MCM for TC10

           To verify that TC10 forwarding happens over MCM link

    @pre
           - Flash content should be empty
           - OTP contains MCM configuration and stacking link configuration
           - OTP contains valid TC10 forward map (master port to slave port & slave port to
             master port)

    @test
           - Load and execute ROM on master and slave bcm8957x
           - Wait for 1ms for the test to complete
           - Check ROM_PROG_REGISTER on master and slave

    @post
           - ROM_PROG_REGISTER should be written with DBG_LOG_APPLY_TC10_SYNC_SUCCESS (0x65)
           two times on both master and slave
           - Verify forward map on non-simulation environments

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_MCM_COMM                  (0x11DUL)

/**
    @brief Master Flash boot in MCM configuration

           To verify that master flash boot works in MCM configuration

    @pre
           - flash contains the test bootlaoder
           - OTP contains MCM configuration and stacking link configuration

    @test
           - Load and execute ROM on master
           - Check the PC and ROM_PROG_REGISTER on master

    @post
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_FLASH
           - DBG_LogBuffer[] shall have #LOG_SWT_SET_UPLINK_PORT
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_MCM_BOOT                  (0x11EUL)

/**
    @brief MCM slave boot over TFTP configuration

           To verify that slave is able boot over tftp in MCM configuration

    @pre
           - Load the test application that has tftp server that sends a test
             bootloader to the slave
           - OTP contains MCM configuration and stacking link configuration

    @test
           - Load and execute ROM on slave bcm8957x
           - Load the tftp server application on the master
           - Check the ROM_PROG_REGISTER and PC in slave

    @post
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_FLASH in the slave
           - DBG_LogBuffer[] shall have #LOG_SWT_SET_UPLINK_PORT
           - ARM shall keep looping at ROM_DOWNLOAD_AREA in the slave

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_MCM_SLAVE_BOOT            (0x11FUL)

/**
    @brief Booting with empty OTP

           To verify that bootup sequence works when nothing is programmed in the OTP
           memory

    @pre
           - One of the port is connected to a PC through network and TFTP & DHCP server is
             running on the PC with valid bootloader image
           - Flash memory is empty (All ones)
           - OTP memory is empty (all zeros)

    @test
           - Load and execute ROM
           - Monitor the ROM progress register (ROM_PROG_REGISTER)
           - Monitor the PC register

    @post
           - ROM_PROG_REGISTER shall have ROM_TEST_BL_TFTP
           - ARM shall keep looping at ROM_DOWNLOAD_AREA

    @functional Yes

    @type  Positive

    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BRCM_SWQTST_BCM8957X_ROM_EMPTY_OTP                 (0x120UL)

/*******************************************************************************/

/**
    @brief ROM Binary verification. sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BIN_MATCH
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_BIN_MATCH
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BIN_MATCH                (0x121UL)

/**
    @brief ROM Bypass Mode sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BYPASS
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium
    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_BYPASS
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BYPASS                   (0x122UL)

/**
    @brief ARM Exception table sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_FAULT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium
    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_FAULT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_FAULT                    (0x123UL)

/**
    @brief RAM Dump mode sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_RAM_DUMP
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_RAM_DUMP
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_RAM_DUMP                 (0x124UL)

/**
    @brief DTCM ECC Error trap sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_DTCM_ERR
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_DTCM_ERR
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_DTCM_ERR                 (0x125UL)

/**
    @brief Non-secure boot from flash sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium
    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_NON_SEC_BOOT             (0x126UL)

/**
    @brief Non-secure boot from flash - CRC error sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_CRC_ERR
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_CRC_ERR
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_NON_SEC_BOOT_CRC_ERR     (0x127UL)

/**
    @brief Bootloader header error sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_IMG_HDR_ERROR
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_IMG_HDR_ERROR
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_IMG_HDR_ERROR            (0x128UL)

/**
    @brief Bootloader with invalid entry point sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BOOT_ENTRY_ADDR_ERROR
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_BOOT_ENTRY_ADDR_ERROR
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BOOT_ENTRY_ADDR_ERROR    (0x129UL)

/**
    @brief Full size bootloader test sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_MAX_SIZE
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_MAX_SIZE
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_NON_SEC_BOOT_MAX_SIZE    (0x12AUL)

/**
    @brief Large size bootloader test sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_SIZE_OV
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_SIZE_OV
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_NON_SEC_BOOT_SIZE_OV     (0x12BUL)

/**
    @brief Secure boot from flash (RSA-Signature) sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_SEC_BOOT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium
    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_SEC_BOOT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_SEC_BOOT                 (0x12CUL)

/**
    @brief Secure boot from flash (RSA-Signature and encryption) sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_ENCRYPT_BOOT             (0x12DUL)

/**
    @brief Secure boot from flash - authentication error sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT_ERR
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT_ERR
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_ENCRYPT_BOOT_ERR         (0x12EUL)

/**
    @brief Boot from PT Copy 2 sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_PT_COPY
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_PT_COPY
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_PT_COPY                  (0x12FUL)

/**
    @brief PT Copy error sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_PT_COPY_ERR
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_PT_COPY_ERR
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_PT_COPY_ERR              (0x130UL)

/**
    @brief Non-secure boot over IPC sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_IPC_BL
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_IPC_BL
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_IPC_BL                   (0x131UL)

/**
    @brief Secure boot over IPC sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_IPC_SEC_BL
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_IPC_SEC_BL
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_IPC_SEC_BL               (0x132UL)

/**
    @brief Boot over TFTP sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_FORCE_DL_TFTP
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_TFTP_BL
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_FORCE_DL_TFTP            (0x133UL)

/**
    @brief TFTP Boot after timeout sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_TIMEOUT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_TIMEOUT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_TFTP_BL_TIMEOUT          (0x134UL)

/**
    @brief Secure Boot over TFTP sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_TFTP_SEC_BL
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_TFTP_SEC_BL
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_TFTP_SEC_BL              (0x135UL)

/**
    @brief Secure Boot over TFTP large image sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_LARGE
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_LARGE
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_TFTP_BL_LARGE            (0x136UL)

/**
    @brief Boot mode select for Flash sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_FL
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_FL
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BL_SELECT_FL             (0x137UL)

/**
    @brief Boot mode select for IPC on TFTP timeout sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP_IPC
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP_IPC
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BL_SELECT_TFTP_IPC       (0x138UL)

/**
    @brief Boot mode select for IPC sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_IPC
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_IPC
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BL_SELECT_IPC            (0x139UL)

/**
    @brief Boot mode select for TFTP sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_BL_SELECT_TFTP           (0x13AUL)

/**
    @brief TC10 Wake forward using AXI sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_TC10_AXI
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_TC10_AXI
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_TC10_AXI                 (0x13BUL)

/**
    @brief TC10 Wake forward MDIO sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_TC10_MDIO
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_TC10_MDIO
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_TC10_MDIO                (0x13CUL)

/**
    @brief TC10 Forwarding in MCM sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_MCM_COMM
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_sim

    @testproc BRCM_SWQTST_BCM8957X_ROM_MCM_COMM
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_MCM_COMM                 (0x13DUL)

/**
    @brief Flash boot in MCM configuration sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_MCM_BOOT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_MCM_BOOT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_MCM_BOOT                 (0x13EUL)

/**
    @brief slave boot in MCM configuration sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_MCM_SLAVE_BOOT
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm89571_evk

    @testproc BRCM_SWQTST_BCM8957X_ROM_MCM_SLAVE_BOOT
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_MCM_SLAVE_BOOT           (0x13FUL)

/**
    @brief Booting with empty OTP sequence

    @code{.c}
    Check expected result for #BRCM_SWQTST_BCM8957X_ROM_EMPTY_OTP
    @endcode

    @auto   Yes

    @type   Sanity

    @board  bcm8957x_b0_palladium

    @testproc BRCM_SWQTST_BCM8957X_ROM_EMPTY_OTP
*/
#define BRCM_SWQTSEQ_BCM8957X_ROM_EMPTY_OTP                (0x140UL)

#endif /* BCM8957X_ROM_QT_H */

/** @} */
