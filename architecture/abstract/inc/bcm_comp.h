/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_abstract_comp Components
    @ingroup grp_abstract

    @addtogroup grp_abstract_comp
    @{

    All software components [includes drivers, middleware and applications] are
    implemented in two layers namely Core Logic and Integration Layer.

    @image html arch_generic_component.jpg "Component" width="50%"

    Core logic layer is designed in a way that it is easily ported across
    platforms and operating systems. This layer contains all HW specific logic,
    Software Intellectual Property and any other algorithm/logic independent of
    Operating System. This layer of software is reusable across platforms.
    In brief, this layer performs “what to do” for the functionality.

    @code{.unparsed}
    void ProcessInterrupt(ComponentState *ptr) {
        Reads device registers and acknowledge interrupt
        update any state related parameters in Component State
    }
    void InitComponentState(ComponentState* ptr) {
        Initialize ComponentState
    }
    void ProcessComponentStateChange(ComponentState *ptr) {
        Acknowledge state change (protect from Interrupts)
        Process state change
    }
    @endcode

    Integration layer contains a thin layer of software which integrates the
    core logic into the system as a component. Any information related to tasks
    and signaling shall be contained in this layer. In brief, this layer defines
    “when to do” for the functionality. Typically, Integration layer shall not
    exceed 30% of the component [when measured in terms of code size for Core
    logic and Integration].

    @code{.unparsed}
    ISR2(DeviceISR) {
        OSEK ISR integration API
        ProcessInterrupt();
        BCM_SetEvent(HandleStateChange, ISR_EVENT);
    }
    Task(HandleStateChange) {
        OSEK Task creation API
        BCM_GetEvent(&mask);
        if (mask & ISR_EVENT) {
            ProcessComponentStateChange();
        }
    }
    @endcode

    No function (including thread functions) by design has any infinite loops
    [all loops have exit points]. All necessary polling loops have a maximum
    loop count [Any hardware/event polling has an upper loop count based on
    which the component reports a timeout error].

    Architecture defines 16-bit component IDs (for error reporting and 32-bit
    magic IDs). It also defines SVC numbers for drivers and other miscellaneous
    software components.

    Architecture limits critical resource access to privileged software only.
    All hardware register accesses are allowed only by privileged software.
    Architecture also provides memory protection at task level (and hence, to a
    component level, to be implemented). Inter Task communication requires
    privileged software permissions as the source component/requestor component
    might not have permission to access the destination component/service provider
    component.

    Architecture defines SVC interface layer and System SVC handler to provide
    privileged access to different software components and Inter Task
    communication (and Inter component communication).

    Switching to Privileged mode is performed using SVC instruction in ARM
    Processor. Each SVC request is mapped to a unique 7-bit number
    (lower 7-bits of 8-bit number used for request and top 1-bit is always set).
    SVC interface layer provides functions for different SVC requests. Details
    explained in table below.Components can use these identifiers to report errors.

    @file bcm_comp.h
    @brief BCM Component Identifiers
    This header file contains the component identifiers
    @version 1.0 Initial Version
*/


#ifndef BCM_COMP_H
#define BCM_COMP_H

#include <stdint.h>
#include <stddef.h>
/**
    @name BCM Component API IDs
    @{
    @brief API IDs for BCM Component APIs
*/
#define BRCM_SWARCH_BCM_TYPE                     (0x8101U)    /**< @brief #BCM_CompIDType       */
#define BRCM_SWARCH_BCM_GROUPID_TYPE             (0x8102U)    /**< @brief #BCM_GroupIDType      */
#define BRCM_SWARCH_BCM_CMD_ASYNC_SHIFT_MACRO    (0x8103U)    /**< @brief #BCM_CMD_ASYNC_SHIFT  */
#define BRCM_SWARCH_BCM_CMD_ASYNC_MASK_MACRO     (0x8104U)    /**< @brief #BCM_CMD_ASYNC_MASK   */
#define BRCM_SWARCH_BCM_ASYNCID_MACRO            (0x8105U)    /**< @brief #BCM_ASYNCID          */
#define BRCM_SWARCH_BCM_CMDID_MACRO              (0x8106U)    /**< @brief #BCM_CMDID            */
#define BRCM_SWARCH_BCM_GET_GROUPID_MACRO        (0x8107U)    /**< @brief #BCM_GET_GROUPID      */
#define BRCM_SWARCH_BCM_GET_COMP_MACRO           (0x8108U)    /**< @brief #BCM_GET_COMP         */
#define BRCM_SWARCH_BCM_GET_CMDID_MACRO          (0x8109U)    /**< @brief #BCM_GET_CMDID        */
#define BRCM_SWARCH_BCM_CMD_TYPE                 (0x810AU)    /**< @brief #BCM_CmdType          */
#define BRCM_SWARCH_BCM_HANDLE_TYPE              (0x810BU)    /**< @brief #BCM_HandleType       */
#define BRCM_SWARCH_BCM_STATE_TYPE               (0x810CU)    /**< @brief #BCM_StateType        */
#define BRCM_SWARCH_BCM_STATE_SUB_STATE_TYPE     (0x810DU)    /**< @brief #BCM_SubStateType     */
#define BRCM_SWARCH_BCM_STATE_MACRO              (0x810EU)    /**< @brief #BCM_STATE_MASK       */
#define BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC (0x810FU)    /**< @brief #BCM_ConvertCompToStr */
#define BRCM_SWARCH_BCM_BOOT_MODE_TYPE           (0x8110U)    /**< @brief #BCM_BootModeType     */
#define BRCM_SWARCH_BCM_CURRENT_BOOT_MODE_GLOBAL (0x8111U)    /**< @brief #BCM_CurrentBootMode  */
/** @} */

/**
    @name BCM Handle Type
    @{
    @brief Physical memory address to the Header structures containing client information

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint64_t BCM_HandleType;   /**< @brief Physical memory address to the Header structures
                                               containing client information for message queue client */
/** @} */

/**
    @name Group IDs
    @{
    @brief 6-bit group IDs

    @limitation Do not change the group ID of the IMGL group. This is being
    shared with BOOTROM

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint8_t BCM_GroupIDType;
#define BCM_GROUPID_IMGL        (0x00U) /**< @brief Image Loader group  */
#define BCM_GROUPID_SYS         (0x01U) /**< @brief System group        */
#define BCM_GROUPID_IO          (0x02U) /**< @brief System group        */
#define BCM_GROUPID_NVM         (0x03U) /**< @brief NVM group           */
#define BCM_GROUPID_CRYPTO      (0x04U) /**< @brief Crypto Group        */
#define BCM_GROUPID_ETHSRV      (0x05U) /**< @brief Communications group*/
#define BCM_GROUPID_CONSOLE     (0x08U) /**< @brief Console Group       */
#define BCM_GROUPID_APP         (0x09U) /**< @brief Application Group   */

#define BCM_GROUPID_AVCE        (0x20U) /**< @brief AVCE Group          */
#define BCM_GROUPID_AVCD        (0x21U) /**< @brief AVCD Group          */
#define BCM_GROUPID_CAMERA      (0x22U) /**< @brief Camera Group        */
#define BCM_GROUPID_OPENVX      (0x23U) /**< @brief OPENVX Group        */
#define BCM_GROUPID_LDC         (0x24U) /**< @brief LDC Group           */
#define BCM_GROUPID_DISPLAY     (0x25U) /**< @brief Display Group       */
#define BCM_GROUPID_GRAPHICS    (0x26U) /**< @brief Graphics Group      */
#define BCM_GROUPID_STITCH      (0x27U) /**< @brief Stitch Group        */
#define BCM_GROUPID_AUDIO       (0x28U) /**< @brief Audio Group         */
#define BCM_GROUPID_MJPEG       (0x29U) /**< @brief MJPEG Group         */
#define BCM_GROUPID_VPPE        (0x30U) /**< @brief Video pre processor */
#define BCM_GROUPID_TEST        (0x3EU) /**< @brief Test Group          */
#define BCM_GROUPID_INVALID     (0xFFU) /**< @brief Invalid group       */
/** @} */

/**
    @name Component IDs
    @{
    @brief 16-bit component IDs for all the components in the system

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint16_t BCM_CompIDType;   /**< @brief 16-bit Unique Component ID for
                                    error reporting       */
/* BCM_GROUPID_IMGL */
#define BCM_RSV_ID (0x0000U)   /**< @brief Reserved       */
#define BCM_MOD_ID (0x0001U)   /**< @brief Module         */
#define BCM_MSG_ID (0x0002U)   /**< @brief MsgQ (IPC)     */
#define BCM_UTL_ID (0x0003U)   /**< @brief UTILS          */
#define BCM_OSI_ID (0x0004U)   /**< @brief OSI            */
#define BCM_DCA_ID (0x0005U)   /**< @brief DCache         */
#define BCM_INT_ID (0x00FFU)   /**< @brief Interrupt patch */

/* BCM_GROUPID_SYS */
#define BCM_MCU_ID (0x0100U)   /**< @brief MCU            */
#define BCM_WDG_ID (0x0101U)   /**< @brief Watchdog       */
#define BCM_DDR_ID (0x0102U)   /**< @brief DDR            */
#define BCM_VTM_ID (0x0103U)   /**< @brief VTMON          */
#define BCM_SPT_ID (0x0104U)   /**< @brief SP804          */
#define BCM_AVT_ID (0x0105U)   /**< @brief AVT            */
#define BCM_IPC_ID (0x0106U)   /**< @brief IPC            */
#define BCM_TMD_ID (0x0120U)   /**< @brief Time module    */
#define BCM_IMG_ID (0x0121U)   /**< @brief IMGL           */
#define BCM_RPC_ID (0x0122U)   /**< @brief RPC            */
#define BCM_DMN_ID (0x0123U)   /**< @brief Device monitor */
#define BCM_PPR_ID (0x0130U)   /**< @brief PixelProcessor */
#define BCM_SYS_ID (0x0140U)   /**< @brief SYS            */
#define BCM_CTL_ID (0x0141U)   /**< @brief BL Control     */
#define BCM_ROM_ID (0x0142U)   /**< @brief ROM            */

/* BCM_GROUPID_IO */
#define BCM_BCP_ID (0x0200U)   /**< @brief Board phrpls   */
#define BCM_GIO_ID (0x0201U)   /**< @brief GPIO           */
#define BCM_PMX_ID (0x0202U)   /**< @brief PinMux         */
#define BCM_SEI_ID (0x0203U)   /**< @brief SIO Serial IO  */
#define BCM_IIC_ID (0x0204U)   /**< @brief IIC            */
#define BCM_SPI_ID (0x0205U)   /**< @brief SPI            */
#define BCM_SIO_ID (0x0206U)   /**< @brief SDIO           */
#define BCM_PWM_ID (0x0207U)   /**< @brief PWM            */
#define BCM_ADC_ID (0x0208U)   /**< @brief ADC            */
#define BCM_DMA_ID (0x0209U)   /**< @brief DMA330         */
#define BCM_CAN_ID (0x020AU)   /**< @brief CAN            */
#define BCM_LIN_ID (0x020BU)   /**< @brief LIN            */
#define BCM_CCT_ID (0x020CU)   /**< @brief CCT            */
#define BCM_IOM_ID (0x0220U)   /**< @brief IOM            */
#define BCM_IOS_ID (0x0240U)   /**< @brief IOS            */

/* BCM_GROUPID_NVM */
#define BCM_QSP_ID (0x0300U)   /**< @brief QSPI           */
#define BCM_OTP_ID (0x0301U)   /**< @brief OTP            */
#define BCM_PCH_ID (0x0302U)   /**< @brief PATCH          */
#define BCM_OTM_ID (0x0320U)   /**< @brief OTPM           */
#define BCM_FLM_ID (0x0321U)   /**< @brief Flash Manager  */
#define BCM_PTM_ID (0x0322U)   /**< @brief PTM            */
#define BCM_NVM_ID (0x0340U)   /**< @brief NVM            */

/* BCM_GROUPID_CRYPTO */
#define BCM_SHP_ID (0x0400U)   /**< @brief Secure heap            */
#define BCM_SPM_ID (0x0401U)   /**< @brief SPUM                   */
#define BCM_PKA_ID (0x0402U)   /**< @brief PKA                    */
#define BCM_RND_ID (0x0403U)   /**< @brief RAND                   */
#define BCM_MSC_ID (0x0404U)   /**< @brief MACSEC                 */
#define BCM_CVM_ID (0x0420U)   /**< @brief Crypto verify module   */
#define BCM_CSY_ID (0x0421U)   /**< @brief Crypto SecY module     */
#define BCM_CRS_ID (0x0440U)   /**< @brief Crypto Service         */

/* BCM_GROUPID_ETHSRV */
#define BCM_XVR_ID (0x0500U)   /**< @brief XVR                    */
#define BCM_AMC_ID (0x0501U)   /**< @brief AMAC                   */
#define BCM_UNI_ID (0x0502U)   /**< @brief UNIMAC                 */
#define BCM_MIO_ID (0x0503U)   /**< @brief MDIO                   */
#define BCM_ETH_ID (0x0504U)   /**< @brief ETH                    */
#define BCM_SWT_ID (0x0505U)   /**< @brief SWITCH                 */
#define BCM_CFP_ID (0x0506U)   /**< @brief CFP                    */
#define BCM_FAC_ID (0x0507U)   /**< @brief Flow Accelerator       */
#define BCM_VLN_ID (0x0508U)   /**< @brief Switch VLAN module     */
#define BCM_ARL_ID (0x0509U)   /**< @brief Switch ARL module      */
#define BCM_EXT_ID (0x050AU)   /**< @brief Switch Ext Module      */
#define BCM_CRE_ID (0x050BU)   /**< @brief Switch Core Module     */
#define BCM_DBG_ID (0x050CU)   /**< @brief Switch Debug module    */

#define BCM_NIF_ID (0x0520U)   /**< @brief NIF                    */
#define BCM_NET_ID (0x0521U)   /**< @brief Internet Stack         */
#define BCM_TCT_ID (0x0522U)   /**< @brief TC10                   */
#define BCM_ETT_ID (0x0523U)   /**< @brief ETH Time               */
#define BCM_ETS_ID (0x0524U)   /**< @brief ETS Component          */

#define BCM_COM_ID (0x0540U)   /**< @brief COM                    */

#define BCM_ETL_ID (0x0551U)   /**< @brief ETS Library            */
#define BCM_TFT_ID (0x0552U)   /**< @brief TFTP                   */
#define BCM_RTL_ID (0x0553U)   /**< @brief RTP Library            */
#define BCM_RTS_ID (0x0554U)   /**< @brief RTP Sender Component   */
#define BCM_RTR_ID (0x0555U)   /**< @brief RTP Receiver Component */
#define BCM_RFS_ID (0x0556U)   /**< @brief RFS                    */
#define BCM_MTL_ID (0x0557U)   /**< @brief MPEG2TS Library        */

#define BCM_AVL_ID (0x0560U)   /**< @brief AVB Library            */
#define BCM_AVB_ID (0x0561U)   /**< @brief AVB Component          */

#define BCM_WLC_ID (0x0570U)   /**< @brief Wireless LAN           */

/* BCM_GROUPID_CONSOLE */
#define BCM_SHL_ID (0x0800U)   /**< @brief UART Console           */
#define BCM_URT_ID (0x0801U)   /**< @brief UART->CONSOLE          */

/* BCM_GROUPID_APP */
#define BCM_MSF_ID (0x0900U)   /**< @brief Media System & Framework */

/* BCM_GROUPID_AVCE */
#define BCM_AVE_ID (0x2000U)   /**< @brief AVC Encoder Component   */
#define BCM_VEN_ID (0x2001U)   /**< @brief Video Encoder Component */

/* BCM_GROUPID_AVCD */
#define BCM_AVD_ID (0x2100U)   /**< @brief AVC Decoder Component   */
#define BCM_VDE_ID (0x2101U)   /**< @brief Video Decoder Component */

/* BCM_GROUPID_CAMERA */
#define BCM_CAM_ID (0x2200U)   /**< @brief Camera                  */
#define BCM_CFW_ID (0x2201U)   /**< @brief Camera Fmwk             */
#define BCM_CTN_ID (0x2202U)   /**< @brief Camera Tuners           */
#define BCM_CSN_ID (0x2203U)   /**< @brief Camera Sensor           */
#define BCM_UCM_ID (0x2204U)   /**< @brief UNICAM                  */
#define BCM_ISP_ID (0x2205U)   /**< @brief ISP                     */

/* BCM_GROUPID_OPENVX */
#define BCM_VXS_ID (0x2300U)   /**< @brief Openvx Server           */
#define BCM_OPF_ID (0x2301U)   /**< @brief Opticalflow Component   */

/* BCM_GROUPID_LDC */
#define BCM_LDC_ID (0x2400U)   /**< @brief LDC Component           */

/* BCM_GROUPID_DISPLAY */
#define BCM_PV0_ID (0x2500U)   /**< @brief PixelValve                */
#define BCM_CMP_ID (0x2501U)   /**< @brief Compositor                */
#define BCM_BTV_ID (0x2502U)   /**< @brief BT656 Controller          */
#define BCM_DSI_ID (0x2503U)   /**< @brief DSI Controller            */
#define BCM_AFE_ID (0x2504U)   /**< @brief AFE Controller            */
#define BCM_MWB_ID (0x2505U)   /**< @brief Memory Writeback          */
#define BCM_DMS_ID (0x2506U)   /**< @brief MISC Controller           */
#define BCM_VGC_ID (0x2507U)   /**< @brief Video & Graphics Composer */
#define BCM_DIS_ID (0x2508U)   /**< @brief Display Service           */
#define BCM_VRC_ID (0x2509U)   /**< @brief Video Renderer Component  */
#define BCM_MFD_ID (0x250AU)   /**< @brief MPEGFeeder                */

/* BCM_GROUPID_GRAPHICS */
#define BCM_GFD_ID (0x2600U)   /**< @brief GraphicsFeeder              */
#define BCM_GRC_ID (0x2601U)   /**< @brief Graphics Renderer Component */

/* BCM_GROUPID_STITCH */
#define BCM_STC_ID (0x2700U)   /**< @brief Stitch Component         */

/* BCM_GROUPID_AUDIO */
#define BCM_APY_ID (0x2800U)   /**< @brief Audio play component     */
#define BCM_ARC_ID (0x2801U)   /**< @brief Audio record component   */
#define BCM_IIS_ID (0x2802U)   /**< @brief I2S                      */

/* BCM_GROUPID_MJPEG */
#define BCM_JPG_ID (0x2900U)   /**< @brief JPG Encoder Component   */

/* BCM_GROUPID_VPPE */
#define BCM_VPE_ID (0x3000U)   /**< @brief VPPE Component          */

/** @} */

/**
    @name Module State
    @{
    @brief Module State

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint32_t BCM_StateType;    /**< @brief Subsystem states        */
#define BCM_STATE_UNINIT  (0UL)   /**< @brief Uninitialized state     */
#define BCM_STATE_INIT    (1UL)   /**< @brief Initialized state       */
#define BCM_STATE_READY   (2UL)   /**< @brief Ready state             */
#define BCM_STATE_RUN     (3UL)   /**< @brief Configured state        */
#define BCM_STATE_ERROR   (4UL)   /**< @brief Error state             */
/** @} */

/**
    @name Module Substate
    @{
    @brief Module Substate

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint32_t BCM_SubStateType;                    /**< @brief Subsystem states */
#define BCM_STATE_SUB_STATE_RESET      (0x00000000UL) /**< @brief Substate reset */
#define BCM_STATE_SUB_STATE_STAGE0     (0x00000001UL) /**< @brief Substate 0 */
#define BCM_STATE_SUB_STATE_STAGE1     (0x00000002UL) /**< @brief Substate 1 */
#define BCM_STATE_SUB_STATE_STAGE2     (0x00000003UL) /**< @brief Substate 2 */
#define BCM_STATE_SUB_STATE_STAGE3     (0x00000004UL) /**< @brief Substate 3 */
#define BCM_STATE_SUB_STATE_STAGE4     (0x00000005UL) /**< @brief Substate 4 */
#define BCM_STATE_SUB_STATE_STAGE5     (0x00000006UL) /**< @brief Substate 5 */
#define BCM_STATE_SUB_STATE_STAGE6     (0x00000007UL) /**< @brief Substate 6 */
#define BCM_STATE_SUB_STATE_STAGE7     (0x00000008UL) /**< @brief Substate 7 */
#define BCM_STATE_SUB_STATE_STAGE8     (0x00000009UL) /**< @brief Substate 8 */
#define BCM_STATE_SUB_STATE_DONE       (0x000000FFUL) /**< @brief Substate done */
/** @} */

/**
    @name Boot Mode
    @{
    @brief Boot Mode

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint32_t BCM_BootModeType;
#define BCM_BOOT_MODE_BROM      (0x42524F4DUL) /* 'B' 'R' 'O' 'M' */
#define BCM_BOOT_MODE_BL        (0x424C4452UL) /* 'B' 'L' 'D' 'R' */
#define BCM_BOOT_MODE_FW        (0x464D5752UL) /* 'F' 'M' 'W' 'R' */
#define BCM_BOOT_MODE_DEFAULT   (0x44464C54UL) /* 'D' 'F' 'L' 'T' */
/** @} */

/**
    @name Subsystem State
    @{
    @brief States for sub system

    @note This will be deprecated soon

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_STATE_MASK                 (0xFF000000UL)
#define BCM_STATE_SHIFT                (24UL)
#define BCM_STATE_COMPONENT_MASK       (0x00FFFF00UL)
#define BCM_STATE_COMPONENT_SHIFT      (8UL)
#define BCM_STATE_SUB_STATE_MASK       (0x000000FFUL)
#define BCM_STATE_COMPONENT_NONE       (0x0000U)
#define BCM_STATE_COMPONENT_DONE       (0xFFFFU)
#define BCM_STATE_CREATE_STATE(aState, aComp, aSubState) ((((aState) << BCM_STATE_SHIFT) & BCM_STATE_MASK) | (((aComp) << BCM_STATE_COMPONENT_SHIFT)  & BCM_STATE_COMPONENT_MASK) | ((aSubState) & BCM_STATE_SUB_STATE_MASK))
#define BCM_STATE_GET_STATE(aState)                      (((aState) & BCM_STATE_MASK) >> BCM_STATE_SHIFT)
#define BCM_STATE_GET_COMPONENT(aState)                  (((aState) & BCM_STATE_COMPONENT_MASK) >> BCM_STATE_COMPONENT_SHIFT)
#define BCM_STATE_GET_SUBSTATE(aState)                   ((aState) & BCM_STATE_SUB_STATE_MASK)
#define BCM_STATE_UPDATE_SUBSTATE(aState, aSubState)     (((aState) & (~BCM_STATE_SUB_STATE_MASK)) | ((aSubState) & (BCM_STATE_SUB_STATE_MASK)))
#define BCM_STATE_UPDATE_COMPONENT(aState, aComp)     (((aState) & ~(BCM_STATE_SUB_STATE_MASK|BCM_STATE_COMPONENT_MASK)) | (((aComp) << BCM_STATE_COMPONENT_SHIFT)  & BCM_STATE_COMPONENT_MASK) | (BCM_STATE_SUB_STATE_RESET))
/** @} */

/**
    @brief System Command ID macros

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint32_t BCM_CmdType;
#define BCM_CMD_ID_SHIFT        (0UL)                           /**< @brief Command ID shift value  */
#define BCM_CMD_ID_MASK         (0xFFUL << BCM_CMD_ID_SHIFT)    /**< @brief Command ID shift mask   */
#define BCM_CMD_COMP_SHIFT      (8UL)                           /**< @brief Component ID shift value*/
#define BCM_CMD_COMP_MASK       (0xFFFFUL << BCM_CMD_COMP_SHIFT)/**< @brief Component ID shift mask */
#define BCM_CMD_GROUP_SHIFT     (24UL)                          /**< @brief Group ID shift value    */
#define BCM_CMD_GROUP_MASK      (0x3FUL << BCM_CMD_GROUP_SHIFT) /**< @brief Group ID shift mask     */
#define BCM_CMD_RESPONSE_SHIFT  (30UL)                          /**< @brief Resp bit Shift value    */
#define BCM_CMD_RESPONSE_MASK   (1UL << BCM_CMD_RESPONSE_SHIFT) /**< @brief Async bit Shift mask    */
#define BCM_CMD_ASYNC_SHIFT     (31UL)                          /**< @brief Async bit Shift value   */
#define BCM_CMD_ASYNC_MASK      (1UL << BCM_CMD_ASYNC_SHIFT)    /**< @brief Async bit Shift mask    */
#define BCM_CMD_MAGIC_CMD       (0xa5a5a5a5UL)                  /**< @brief Command magic           */
#define BCM_CMD_MAGIC_RESP      (0x5a5a5a5aUL)                  /**< @brief Response magic          */

/**
    @brief Macro to compose the command ID for a async notification

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_ASYNCID(aGrp, aComp, aId) ((BCM_CMD_ASYNC_MASK)                          \
                            | (((aGrp) << BCM_CMD_GROUP_SHIFT) & BCM_CMD_GROUP_MASK) \
                            | (((aComp) << BCM_CMD_COMP_SHIFT) & BCM_CMD_COMP_MASK)  \
                            | (((aId) << BCM_CMD_ID_SHIFT) & BCM_CMD_ID_MASK))

/**
    @brief Macro to compose the entire command ID

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_CMDID(aGrp, aComp, aId)((((uint32_t)(aGrp) << BCM_CMD_GROUP_SHIFT) & BCM_CMD_GROUP_MASK)  \
                                |  (((uint32_t)(aComp) << BCM_CMD_COMP_SHIFT) & BCM_CMD_COMP_MASK)     \
                                |  (((uint32_t)(aId) << BCM_CMD_ID_SHIFT) & BCM_CMD_ID_MASK))

/**
    @brief Macro to get the group ID for the command

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_GET_GROUPID(aCmd) (((aCmd) & BCM_CMD_GROUP_MASK)  >> BCM_CMD_GROUP_SHIFT)

/**
    @brief Macro to get the component for the command

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_GET_COMP(aCmd) (((aCmd) & BCM_CMD_COMP_MASK) >> BCM_CMD_COMP_SHIFT)

/**
    @brief Macro to get the command type

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_GET_CMDID(aCmd) (((aCmd) & BCM_CMD_ID_MASK)  >> BCM_CMD_ID_SHIFT)

/** @brief Convert the Component ID to String

    This API is called to convert the #BCM_CompIDType to a String
    Fill the aStr if it is not NULL, Otherwise do nothing

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCompID     16-bit component ID
    @param[out]     aStr        Converted component's String
                                of 12 Char Length

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_COMPONENT

    @limitations The Maximum String Length Should be 12 characters
*/
extern void BCM_ConvertCompToStr (BCM_CompIDType aCompID, char *aStr);

/**
    @brief Current Boot Mode

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
extern const BCM_BootModeType BCM_CurrentBootMode;
#endif /* BCM_COMP_H */
/** @} */
