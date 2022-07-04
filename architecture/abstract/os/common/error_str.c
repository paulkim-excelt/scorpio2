/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_abstract_error_impl Component Error Strings Design
    @ingroup grp_abstract

    @addtogroup grp_abstract_error_impl
    @{

    @file error_str.c
    @brief This File Design the component's error strings

    @version 0.1 Initial version
*/
#include <string.h>
#include <bcm_comp.h>

/**
    @name Error Strings Design IDs
    @{
    @brief Design IDs for component error string
*/
#define BRCM_SWDSGN_BCM_SUB_COMP_MAX_MACRO             (0xA101U)  /**< @brief #BCM_SUB_COMP_MAX         */
#define BRCM_SWDSGN_BCM_GET_SUB_COMP_ID_MACRO          (0xA102U)  /**< @brief #BCM_GET_SUB_COMP_ID      */
#define BRCM_SWDSGN_BCM_IMGL_GROUP_STR_GLOBAL          (0xA103U)  /**< @brief #BCM_IMGLGroupStr         */
#define BRCM_SWDSGN_BCM_SYS_GROUP_STR_GLOBAL           (0xA104U)  /**< @brief #BCM_SYSGroupStr          */
#define BRCM_SWDSGN_BCM_IO_GROUP_STR_GLOBAL            (0xA105U)  /**< @brief #BCM_IOGroupStr           */
#define BRCM_SWDSGN_BCM_NVM_GROUP_STR_GLOBAL           (0xA106U)  /**< @brief #BCM_NVMGroupStr          */
#define BRCM_SWDSGN_BCM_CRYPTO_GROUP_STR_GLOBAL        (0xA107U)  /**< @brief #BCM_CRYPTOGroupStr       */
#define BRCM_SWDSGN_BCM_ETHSRV_GROUP_STR_GLOBAL        (0xA108U)  /**< @brief #BCM_ETHSRVGroupStr       */
#define BRCM_SWDSGN_BCM_CONSOLE_GROUP_STR_GLOBAL       (0xA109U)  /**< @brief #BCM_CONSOLEGroupStr      */
#define BRCM_SWDSGN_BCM_APP_GROUP_STR_GLOBAL           (0xA10AU)  /**< @brief #BCM_APPGroupStr          */
#define BRCM_SWDSGN_BCM_AVCE_GROUP_STR_GLOBAL          (0xA10BU)  /**< @brief #BCM_AVCEGroupStr         */
#define BRCM_SWDSGN_BCM_AVCD_GROUP_STR_GLOBAL          (0xA10CU)  /**< @brief #BCM_AVCDGroupStr         */
#define BRCM_SWDSGN_BCM_CAMERA_GROUP_STR_GLOBAL        (0xA10DU)  /**< @brief #BCM_CAMERAGroupStr       */
#define BRCM_SWDSGN_BCM_OPENVX_GROUP_STR_GLOBAL        (0xA10EU)  /**< @brief #BCM_OPENVXGroupStr       */
#define BRCM_SWDSGN_BCM_LDC_GROUP_STR_GLOBAL           (0xA10FU)  /**< @brief #BCM_LDCGroupStr          */
#define BRCM_SWDSGN_BCM_DISPLAY_GROUP_STR_GLOBAL       (0xA110U)  /**< @brief #BCM_DISPLAYGroupStr      */
#define BRCM_SWDSGN_BCM_GRAPHICS_GROUP_STR_GLOBAL      (0xA111U)  /**< @brief #BCM_GRAPHICSGroupStr     */
#define BRCM_SWDSGN_BCM_STITCH_GROUP_STR_GLOBAL        (0xA112U)  /**< @brief #BCM_STITCHGroupStr       */
#define BRCM_SWDSGN_BCM_AUDIO_GROUP_STR_GLOBAL         (0xA113U)  /**< @brief #BCM_AUDIOGroupStr        */
#define BRCM_SWDSGN_BCM_CONVERT_COMP_TO_STR_PROC       (0xA114U)  /**< @brief #BCM_ConvertCompToStr     */
/** @} */

/**
    @brief Maximum Number Of Subcomponents

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_SUB_COMP_MAX    (0xFFU)

/**
    @brief Get the Sub Compinent ID

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_GET_SUB_COMP_ID(x)    ((x) & 0xFFU)

/**
    @brief IMGL Group Subcomponent's String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_IMGLGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_MOD_ID)] = (const uint8_t*)"MODULE  ",   /**< @brief Module         */
    [BCM_GET_SUB_COMP_ID(BCM_MSG_ID)] = (const uint8_t*)"MSGQ    ",   /**< @brief MsgQ (IPC)     */
    [BCM_GET_SUB_COMP_ID(BCM_UTL_ID)] = (const uint8_t*)"UTILS   ",   /**< @brief UTILS          */
    [BCM_GET_SUB_COMP_ID(BCM_OSI_ID)] = (const uint8_t*)"OSI     ",   /**< @brief OSI            */
    [BCM_GET_SUB_COMP_ID(BCM_DCA_ID)] = (const uint8_t*)"DCACHE  ",   /**< @brief DCache         */
};

/**
    @brief System Group Subcomponent's String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_SYSGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_MCU_ID)] = (const uint8_t*)"MCU     ",   /**< @brief MCU            */
    [BCM_GET_SUB_COMP_ID(BCM_WDG_ID)] = (const uint8_t*)"WATCHDOG",   /**< @brief Watchdog       */
    [BCM_GET_SUB_COMP_ID(BCM_DDR_ID)] = (const uint8_t*)"DDR     ",   /**< @brief DDR            */
    [BCM_GET_SUB_COMP_ID(BCM_VTM_ID)] = (const uint8_t*)"VTMON   ",   /**< @brief VTMON          */
    [BCM_GET_SUB_COMP_ID(BCM_SPT_ID)] = (const uint8_t*)"SP804   ",   /**< @brief SP804          */
    [BCM_GET_SUB_COMP_ID(BCM_AVT_ID)] = (const uint8_t*)"AVT     ",   /**< @brief AVT            */
    [BCM_GET_SUB_COMP_ID(BCM_IPC_ID)] = (const uint8_t*)"IPC     ",   /**< @brief IPC            */
    [BCM_GET_SUB_COMP_ID(BCM_TMD_ID)] = (const uint8_t*)"TIME    ",   /**< @brief Time module    */
    [BCM_GET_SUB_COMP_ID(BCM_IMG_ID)] = (const uint8_t*)"IMGL    ",   /**< @brief IMGL           */
    [BCM_GET_SUB_COMP_ID(BCM_RPC_ID)] = (const uint8_t*)"RPC     ",   /**< @brief RPC            */
    [BCM_GET_SUB_COMP_ID(BCM_PPR_ID)] = (const uint8_t*)"PIXEL PR",   /**< @brief PixelProcessor */
    [BCM_GET_SUB_COMP_ID(BCM_SYS_ID)] = (const uint8_t*)"SYS     ",   /**< @brief SYS            */
    [BCM_GET_SUB_COMP_ID(BCM_CTL_ID)] = (const uint8_t*)"BL CTRL ",   /**< @brief BL Control     */
    [BCM_GET_SUB_COMP_ID(BCM_ROM_ID)] = (const uint8_t*)"ROM     ",   /**< @brief ROM            */
};

/**
    @brief IO Group Subcomponent's String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_IOGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_BCP_ID)] = (const uint8_t*)"BOARDPHR",    /**< @brief Board phrpls   */
    [BCM_GET_SUB_COMP_ID(BCM_GIO_ID)] = (const uint8_t*)"GPIO    ",    /**< @brief GPIO           */
    [BCM_GET_SUB_COMP_ID(BCM_PMX_ID)] = (const uint8_t*)"PINMUX  ",    /**< @brief PinMux         */
    [BCM_GET_SUB_COMP_ID(BCM_SEI_ID)] = (const uint8_t*)"SERIALIO",    /**< @brief SIO Serial IO  */
    [BCM_GET_SUB_COMP_ID(BCM_IIC_ID)] = (const uint8_t*)"IIC     ",    /**< @brief IIC            */
    [BCM_GET_SUB_COMP_ID(BCM_SPI_ID)] = (const uint8_t*)"SPI     ",    /**< @brief SPI            */
    [BCM_GET_SUB_COMP_ID(BCM_SIO_ID)] = (const uint8_t*)"SDIO    ",    /**< @brief SDIO           */
    [BCM_GET_SUB_COMP_ID(BCM_PWM_ID)] = (const uint8_t*)"PWM     ",    /**< @brief PWM            */
    [BCM_GET_SUB_COMP_ID(BCM_ADC_ID)] = (const uint8_t*)"ADC     ",    /**< @brief ADC            */
    [BCM_GET_SUB_COMP_ID(BCM_DMA_ID)] = (const uint8_t*)"DMA330  ",    /**< @brief DMA330         */
    [BCM_GET_SUB_COMP_ID(BCM_CAN_ID)] = (const uint8_t*)"CAN     ",    /**< @brief CAN            */
    [BCM_GET_SUB_COMP_ID(BCM_LIN_ID)] = (const uint8_t*)"LIN     ",    /**< @brief LIN            */
    [BCM_GET_SUB_COMP_ID(BCM_CCT_ID)] = (const uint8_t*)"CCT     ",    /**< @brief CCT            */
};

/**
    @brief NVM Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_NVMGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_QSP_ID)] = (const uint8_t*)"QSPI    ",    /**< @brief QSPI           */
    [BCM_GET_SUB_COMP_ID(BCM_OTP_ID)] = (const uint8_t*)"OTP     ",    /**< @brief OTP            */
    [BCM_GET_SUB_COMP_ID(BCM_PCH_ID)] = (const uint8_t*)"PATCH   ",    /**< @brief PATCH          */
    [BCM_GET_SUB_COMP_ID(BCM_OTM_ID)] = (const uint8_t*)"OTPMOD  ",    /**< @brief OTPM           */
    [BCM_GET_SUB_COMP_ID(BCM_FLM_ID)] = (const uint8_t*)"FLASHMNG",    /**< @brief Flash Manager  */
    [BCM_GET_SUB_COMP_ID(BCM_PTM_ID)] = (const uint8_t*)"PTM     ",    /**< @brief PTM            */
    [BCM_GET_SUB_COMP_ID(BCM_NVM_ID)] = (const uint8_t*)"NVM     ",    /**< @brief NVM            */
};

/**
    @brief Crypto Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_CRYPTOGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_SHP_ID)] = (const uint8_t*)"SECUHEAP",    /**< @brief Secure heap            */
    [BCM_GET_SUB_COMP_ID(BCM_SPM_ID)] = (const uint8_t*)"SPUM    ",    /**< @brief SPUM                   */
    [BCM_GET_SUB_COMP_ID(BCM_PKA_ID)] = (const uint8_t*)"PKA     ",    /**< @brief PKA                    */
    [BCM_GET_SUB_COMP_ID(BCM_RND_ID)] = (const uint8_t*)"RAND    ",    /**< @brief RAND                   */
    [BCM_GET_SUB_COMP_ID(BCM_CVM_ID)] = (const uint8_t*)"CRYPTMOD",    /**< @brief Crypto verify module   */
    [BCM_GET_SUB_COMP_ID(BCM_CRS_ID)] = (const uint8_t*)"CRYPTSRV",    /**< @brief Crypto Service         */
};

/**
    @brief ETHSRV Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_ETHSRVGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_XVR_ID)] = (const uint8_t*)"XCVR    ",    /**< @brief XVR                    */
    [BCM_GET_SUB_COMP_ID(BCM_AMC_ID)] = (const uint8_t*)"AMAC    ",    /**< @brief AMAC                   */
    [BCM_GET_SUB_COMP_ID(BCM_UNI_ID)] = (const uint8_t*)"UNIMAC  ",    /**< @brief UNIMAC                 */
    [BCM_GET_SUB_COMP_ID(BCM_MIO_ID)] = (const uint8_t*)"MDIO    ",    /**< @brief MDIO                   */
    [BCM_GET_SUB_COMP_ID(BCM_ETH_ID)] = (const uint8_t*)"ETH     ",    /**< @brief ETH                    */
    [BCM_GET_SUB_COMP_ID(BCM_SWT_ID)] = (const uint8_t*)"SWITCH  ",    /**< @brief SWITCH                 */
    [BCM_GET_SUB_COMP_ID(BCM_CFP_ID)] = (const uint8_t*)"CFP     ",    /**< @brief CFP                    */
    [BCM_GET_SUB_COMP_ID(BCM_FAC_ID)] = (const uint8_t*)"FLOWACCL",    /**< @brief Flow Accelerator       */
    [BCM_GET_SUB_COMP_ID(BCM_NIF_ID)] = (const uint8_t*)"NIF     ",    /**< @brief NIF                    */
    [BCM_GET_SUB_COMP_ID(BCM_NET_ID)] = (const uint8_t*)"INETSTAK",    /**< @brief Internet Stack         */
    [BCM_GET_SUB_COMP_ID(BCM_TCT_ID)] = (const uint8_t*)"TC10    ",    /**< @brief TC10                   */
    [BCM_GET_SUB_COMP_ID(BCM_ETT_ID)] = (const uint8_t*)"ETHTIME ",    /**< @brief ETH Time               */
    [BCM_GET_SUB_COMP_ID(BCM_ETS_ID)] = (const uint8_t*)"ETSCOMP ",    /**< @brief ETS Component          */
    [BCM_GET_SUB_COMP_ID(BCM_COM_ID)] = (const uint8_t*)"COMMS   ",    /**< @brief COM                    */
    [BCM_GET_SUB_COMP_ID(BCM_ETL_ID)] = (const uint8_t*)"ETSLIB  ",    /**< @brief ETS Library            */
    [BCM_GET_SUB_COMP_ID(BCM_TFT_ID)] = (const uint8_t*)"TFTP    ",    /**< @brief TFTP                   */
    [BCM_GET_SUB_COMP_ID(BCM_RTL_ID)] = (const uint8_t*)"RTPLIB  ",    /**< @brief RTP Library            */
    [BCM_GET_SUB_COMP_ID(BCM_RTS_ID)] = (const uint8_t*)"RTPSEND ",    /**< @brief RTP Sender Component   */
    [BCM_GET_SUB_COMP_ID(BCM_RTR_ID)] = (const uint8_t*)"RTPRECV ",    /**< @brief RTP Receiver Component */
    [BCM_GET_SUB_COMP_ID(BCM_RFS_ID)] = (const uint8_t*)"RFS     ",    /**< @brief RFS                    */
    [BCM_GET_SUB_COMP_ID(BCM_MTL_ID)] = (const uint8_t*)"MPEG2TS ",    /**< @brief MPEG2TS Library        */
    [BCM_GET_SUB_COMP_ID(BCM_AVL_ID)] = (const uint8_t*)"AVBLIB  ",    /**< @brief AVB Library            */
    [BCM_GET_SUB_COMP_ID(BCM_AVB_ID)] = (const uint8_t*)"AVBCMP  ",    /**< @brief AVB Component          */
    [BCM_GET_SUB_COMP_ID(BCM_WLC_ID)] = (const uint8_t*)"WLAN    ",    /**< @brief Wireless LAN           */
};

/**
    @brief Console Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_CONSOLEGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_SHL_ID)] = (const uint8_t*)"SHELL   ",    /**< @brief UART Console           */
    [BCM_GET_SUB_COMP_ID(BCM_URT_ID)] = (const uint8_t*)"UART    ",    /**< @brief UART->CONSOLE          */
};

/**
    @brief APP Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_APPGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_MSF_ID)] = (const uint8_t*)"MSFRMWRK",    /**< @brief Media System & Framework */
};

/**
    @brief AVCE Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_AVCEGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_AVE_ID)] = (const uint8_t*)"AVCENC  ",    /**< @brief AVC Encoder Component   */
    [BCM_GET_SUB_COMP_ID(BCM_VEN_ID)] = (const uint8_t*)"VIDENC  ",    /**< @brief Video Encoder Component */
};

/**
    @brief AVCD Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_AVCDGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_AVD_ID)] = (const uint8_t*)"AVCDEC  ",    /**< @brief AVC Decoder Component   */
    [BCM_GET_SUB_COMP_ID(BCM_VDE_ID)] = (const uint8_t*)"VIDDEC  ",    /**< @brief Video Decoder Component */
};

/**
    @brief Camera Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_CAMERAGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_CAM_ID)] = (const uint8_t*)"CAMERA  ",    /**< @brief Camera                  */
    [BCM_GET_SUB_COMP_ID(BCM_CFW_ID)] = (const uint8_t*)"FRAMEWRK",    /**< @brief Camera Fmwk             */
    [BCM_GET_SUB_COMP_ID(BCM_CTN_ID)] = (const uint8_t*)"TUNERS  ",    /**< @brief Camera Tuners           */
    [BCM_GET_SUB_COMP_ID(BCM_CSN_ID)] = (const uint8_t*)"UNICAM  ",    /**< @brief Camera Sensor           */
    [BCM_GET_SUB_COMP_ID(BCM_UCM_ID)] = (const uint8_t*)"SENSOR  ",    /**< @brief UNICAM                  */
    [BCM_GET_SUB_COMP_ID(BCM_ISP_ID)] = (const uint8_t*)"ISP     ",    /**< @brief ISP                     */
};

/**
    @brief OPENVX Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_OPENVXGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_VXS_ID)] = (const uint8_t*)"OPENVX  ",    /**< @brief Openvx Server           */
    [BCM_GET_SUB_COMP_ID(BCM_OPF_ID)] = (const uint8_t*)"OPTFLOW ",    /**< @brief Opticalflow Component   */
};

/**
    @brief LDC Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_LDCGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_LDC_ID)] = (const uint8_t*)"LDCCOMP ",    /**< @brief LDC Component           */
};

/**
    @brief Display Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_DISPLAYGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_PV0_ID)] = (const uint8_t*)"PIXVALVE",    /**< @brief PixelValve                */
    [BCM_GET_SUB_COMP_ID(BCM_CMP_ID)] = (const uint8_t*)"COMPOSIT",    /**< @brief Compositor                */
    [BCM_GET_SUB_COMP_ID(BCM_BTV_ID)] = (const uint8_t*)"BT656CTR",    /**< @brief BT656 Controller          */
    [BCM_GET_SUB_COMP_ID(BCM_DSI_ID)] = (const uint8_t*)"DSICTLR ",    /**< @brief DSI Controller            */
    [BCM_GET_SUB_COMP_ID(BCM_AFE_ID)] = (const uint8_t*)"AFECTLR ",    /**< @brief AFE Controller            */
    [BCM_GET_SUB_COMP_ID(BCM_MWB_ID)] = (const uint8_t*)"MWB     ",    /**< @brief Memory Writeback          */
    [BCM_GET_SUB_COMP_ID(BCM_DMS_ID)] = (const uint8_t*)"MISCCTLR",    /**< @brief MISC Controller           */
    [BCM_GET_SUB_COMP_ID(BCM_VGC_ID)] = (const uint8_t*)"VGCOMPSR",    /**< @brief Video & Graphics Composer */
    [BCM_GET_SUB_COMP_ID(BCM_DIS_ID)] = (const uint8_t*)"SERVICE ",    /**< @brief Display Service           */
    [BCM_GET_SUB_COMP_ID(BCM_VRC_ID)] = (const uint8_t*)"VIDRENDR",    /**< @brief Video Renderer Component  */
    [BCM_GET_SUB_COMP_ID(BCM_MFD_ID)] = (const uint8_t*)"MPEGFEED",    /**< @brief MPEGFeeder                */
};

/**
    @brief Graphics Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_GRAPHICSGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_GFD_ID)] = (const uint8_t*)"FEEDER  ",    /**< @brief GraphicsFeeder              */
    [BCM_GET_SUB_COMP_ID(BCM_GRC_ID)] = (const uint8_t*)"RENDER  ",    /**< @brief Graphics Renderer Component */
};

/**
    @brief Stitch Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_STITCHGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_STC_ID)] = (const uint8_t*)"STITCH  ",    /**< @brief Stitch Component         */
};

/**
    @brief Audio Subcomponent's Group String
           The strings should be following #BCM_CompIDType

    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
static const uint8_t* const  BCM_AUDIOGroupStr[BCM_SUB_COMP_MAX] =
{
    [BCM_GET_SUB_COMP_ID(BCM_APY_ID)] = (const uint8_t*)"PLAY    ",    /**< @brief Audio play component     */
    [BCM_GET_SUB_COMP_ID(BCM_ARC_ID)] = (const uint8_t*)"RECORD  ",    /**< @brief Audio record component   */
    [BCM_GET_SUB_COMP_ID(BCM_IIS_ID)] = (const uint8_t*)"I2S     ",    /**< @brief I2S                      */
};

/**
    @trace #BRCM_SWARCH_BCM_CONVERT_COMP_TO_STR_PROC
    @trace #BRCM_SWREQ_BCM_COMPONENT

    @code{.c}
    @endcode
*/
void BCM_ConvertCompToStr (BCM_CompIDType aCompID, char *aStr)
{
    uint8_t comp;
    uint8_t subComp;
    const uint8_t* subStr = NULL;

    if(NULL != aStr) {
        comp = (uint8_t)((aCompID & 0xFF00U) >> 8U);
        subComp = (uint8_t)(aCompID & 0xFFU);
        switch(comp) {
            case BCM_GROUPID_IMGL:
                (void)strcpy(aStr,"IMG:");
                if(NULL != BCM_IMGLGroupStr[subComp]) {
                    subStr = BCM_IMGLGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_SYS:
                (void)strcpy(aStr,"SYS:");
                if(NULL != BCM_SYSGroupStr[subComp]) {
                    subStr = BCM_SYSGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_IO:
                (void)strcpy(aStr,"IO :");
                if(NULL != BCM_IOGroupStr[subComp]) {
                    subStr = BCM_IOGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_NVM:
                (void)strcpy(aStr,"NVM:");
                if(NULL != BCM_NVMGroupStr[subComp]) {
                    subStr = BCM_NVMGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_CRYPTO:
                (void)strcpy(aStr,"CRP:");
                if(NULL != BCM_CRYPTOGroupStr[subComp]) {
                    subStr = BCM_CRYPTOGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_ETHSRV:
                (void)strcpy(aStr,"ETH:");
                if(NULL != BCM_ETHSRVGroupStr[subComp]) {
                    subStr = BCM_ETHSRVGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_CONSOLE:
                (void)strcpy(aStr,"CON:");
                if(NULL != BCM_CONSOLEGroupStr[subComp]) {
                    subStr = BCM_CONSOLEGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_APP:
                (void)strcpy(aStr,"APP:");
                if(NULL != BCM_APPGroupStr[subComp]) {
                    subStr = BCM_APPGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_AVCE:
                (void)strcpy(aStr,"AVE:");
                if(NULL != BCM_AVCEGroupStr[subComp]) {
                    subStr = BCM_AVCEGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_AVCD:
                (void)strcpy(aStr,"AVD:");
                if(NULL != BCM_AVCDGroupStr[subComp]) {
                    subStr = BCM_AVCDGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_CAMERA:
                (void)strcpy(aStr,"CAM:");
                if(NULL != BCM_CAMERAGroupStr[subComp]) {
                    subStr = BCM_CAMERAGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_OPENVX:
                (void)strcpy(aStr,"OVX:");
                if(NULL != BCM_OPENVXGroupStr[subComp]) {
                    subStr = BCM_OPENVXGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_LDC:
                (void)strcpy(aStr,"LDC:");
                if(NULL != BCM_LDCGroupStr[subComp]) {
                    subStr = BCM_LDCGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_DISPLAY:
                (void)strcpy(aStr,"DIS:");
                if(NULL != BCM_DISPLAYGroupStr[subComp]) {
                    subStr = BCM_DISPLAYGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_GRAPHICS:
                (void)strcpy(aStr,"GFX:");
                if(NULL != BCM_GRAPHICSGroupStr[subComp]) {
                    subStr = BCM_GRAPHICSGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_STITCH:
                (void)strcpy(aStr,"STH:");
                if(NULL != BCM_STITCHGroupStr[subComp]) {
                    subStr = BCM_STITCHGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_AUDIO:
                (void)strcpy(aStr,"AUD:");
                if(NULL != BCM_AUDIOGroupStr[subComp]) {
                    subStr = BCM_AUDIOGroupStr[subComp];
                }
                break;
            case BCM_GROUPID_TEST:
                (void)strcpy(aStr,"TST:TEST    ");
                break;
            case BCM_GROUPID_INVALID:
                (void)strcpy(aStr,"INV:INVALID ");
                break;
            default:
                break;
        }
        if(NULL != subStr) {
            (void)strcat(aStr,(const char*)subStr);
        }
    }
}
/** @} */
