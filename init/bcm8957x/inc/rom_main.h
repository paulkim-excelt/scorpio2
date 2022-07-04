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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_bcm8957x_rom_ifc Interface
    @ingroup grp_bcm8957x_rom

    @addtogroup grp_bcm8957x_rom_ifc
    @{

    ROM has five stages, namely, early initialization, driver initialization/configuration,
    TC10/XCVR handling, loading executable, AND deinitialization.
    After deinitialization, execution is handed over to the loaded executable.

    @tagseq bcm8957x_rom_early_init_seq_diagram.svg "Early Initialization Sequence diagram"
    @startseq
    group {label = "startup"; color = "#EFFFFF";  Startup;};
    group {label = "ROM_Main"; color = "#FFEFFF"; ROM_Main;};
    group {label = "Drivers/Modules"; color = "#FFFFEF"; CORTEX_MX; MCU; ERROR};
    Startup =>  ROM_Main [label = "BCM8957X_RomEarlyInit", return = "return"]{
        ROM_Main => CORTEX_MX [label = "CORTEX_MX_MPUDisable"];
        ROM_Main => CORTEX_MX [label = "CORTEX_MX_MPUConfigure"];
        ROM_Main => CORTEX_MX [label = "CORTEX_MX_MPUEnable"];
        === Clear BSS ===
        ROM_Main => ERROR [label = "BCM_InitError"];
        ROM_Main => MCU [label = "MCU_Init"];
    };
    === Early Init Complete ===
    Startup ->  ROM_Main [label = "BCM8957X_RomMain", return = "return"];
    @endseq

    @tagseq bcm8957x_rom_driver_init_seq_diagram.svg "Driver Initialization Sequence diagram"
    @startseq
    group {label = "ROM_Main"; color = "#FFEFFF"; ROM_Main;};
    group {label = "Drivers/Modules"; color = "#FFFFEF"; Timer; UART; OTP; Ethernet; Switch; NIF; INET; SPUM; SECHEAP; XCVR};
    ROM_Main => Timer [label = "TIM_Init"];
    ROM_Main => UART [label = "UART_Init", rightnote = "UART and logging init"];
    ROM_Main => OTP [label = "OTP_Init"];
    ROM_Main => SECHEAP [label = "SECHEAP_Init"];
    ROM_Main => SPUM [label = "SPUM_Init"];
    ROM_Main => OTP [label = "OTP_ReadIPConfig"];
    ROM_Main => OTP [label = "OTP_ReadSwitchConfig"];
    ROM_Main => OTP [label = "OTP_ReadXCVRConfig"];
    ROM_Main => OTP [label = "OTP_ReadTC10Config"];
    ROM_Main => Ethernet [label = "ETHER_Init"];
    ROM_Main => Ethernet [label = "ETHER_SetMacAddr"];
    ROM_Main => Ethernet [label = "ETHER_SetMode"];
    ROM_Main => NIF [label = "NIF_Init"];
    ROM_Main => INET [label = "INET_Init"];
    ROM_Main => INET [label = "INET_UpdateInterface"];
    ROM_Main => INET [label = "INET_UpdateEndPoint"];
    ROM_Main => Switch [label = "ETHSWT_Init"];
    ROM_Main => Switch [label = "ETHSWT_SetPortRole"];
    ROM_Main => Switch [label = "ETHSWT_SetSwitchType"];
    ROM_Main => Switch [label = "ETHSWT_AddVLANPorts"];
    ROM_Main => Switch [label = "ETHSWT_MgmtInit"];
    ROM_Main => XCVR [label = "XCVR_Configure", rightnote = "Stacking Link and PCIe configuration"];
    @endseq

    @tagseq bcm8957x_rom_tc10_init_seq_diagram.svg "TC10/XCVR Handling Sequence diagram"
    @startseq
    group {label = "ROM_Main"; color = "#FFEFFF"; ROM_Main;};
    group {label = "TC10"; color = "#FFFFEF"; XCVR; TC10; RPC};
    ROM_Main => TC10 [label = "TC10_CollectForwardMap"];
    ROM_Main => RPC [label = "RPC_SendRecv", rightnote = "To get TC10 forward map from slave"];
    ROM_Main => TC10 [label = "TC10_ApplyForwardMap"];
    ROM_Main => RPC [label = "RPC_SendRecv", rightnote = "To apply TC10 forwarding on slave"];
    === XCVR Configuration Start ===
    ROM_Main => XCVR [label = "XCVR_Configure", rightnote = "Other Link configuration"];
    === XCVR Configuration End ===
    ROM_Main => TC10 [label = "TC10_CollectForwardMap", rightnote = "To get TC10 forward map from slave"];
    ROM_Main => RPC [label = "RPC_SendRecv"];
    ROM_Main => TC10 [label = "TC10_ApplyForwardMap", rightnote = "To apply TC10 forwarding on slave"];
    ROM_Main => RPC [label = "RPC_SendRecv"];
    @endseq

    @tagseq bcm8957x_rom_deinit_seq_diagram.svg "Deinitialization Sequence diagram"
    @startseq
    group {label = "ROM_Main"; color = "#FFEFFF"; ROM_Main;};
    group {label = "Drivers/Modules"; color = "#FFFFEF";  OTP; Ethernet; Switch; };
    ROM_Main => Switch [label = "ETHSWT_MgmtDeInit", rightnote = "Disable traffic onto port - 7"];
    ROM_Main => Ethernet [label = "ETHER_Deinit"];
    ROM_Main => OTP [label = "OTP_Deinit"];
    ROM_Main => UART [label = "UART_Deinit", rightnote = "UART and logging deinit"];
    @endseq

    @limitations LDocumented at @ref page_bcm8957x_rom

    @file rom_main.h
    @brief ROM interface

    @version 0.1 Initial Version
*/

#ifndef ROM_MAIN_H
#define ROM_MAIN_H

/**
    @name ROM Architecture IDs
    @{
    @brief Architecture IDs for ROM
*/
#define BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC    (0x8101U)    /**< @brief #BCM8957X_RomEarlyInit */
#define BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC          (0x8102U)    /**< @brief #BCM8957X_RomMain      */
/** @} */

/** @brief Early Initialization for ROM application

    Initaliazes MPU settings and MCU driver

    @behavior Sync, Non-reentrant

    @pre Processor is intialized and Stack is setup and exceptions are disabled

    @param[in]      void

    @return void

    @post MCU is initialized

    @trace #BRCM_SWREQ_BCM8957X_ROM

    @limitations TBD
*/
void BCM8957X_RomEarlyInit(void);

/** @brief ROM application main function

    -# Initializes relevant drivers, transceivers.
    -# Performs TC10 wake up forwarding.
    -# Loads Bootloader from various media using Loader
    -# Hands over execution context to loaded binary after deinitialization

    @behavior Sync, Non-reentrant

    @pre MCU and clocks are initialized

    @param[in]      void

    @return void

    @post This function never returns

    @trace #BRCM_SWREQ_BCM8957X_ROM

    @limitations TBD
*/
void BCM8957X_RomMain(void);

#endif /* ROM_MAIN_H */

/** @} */
