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
    @defgroup grp_ethswt_ext_common_ifc Switch EXT abstract Common
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethswt_ext_common_ifc
    @{

    @file ethswtm_ext_common.h

    @brief EXT common Interface
    This file contains the interfaces for the switch abstract for EXT

    @version 1.0 Initial version
*/

#ifndef ETHSWT_EXT_COMMON_H
#define ETHSWT_EXT_COMMON_H

#include <module_msg.h>
#include <ethernet_swt_ext.h>
#include <ethernet_swt_debug.h>
#include "ethswt_host_common.h"

/**
    @name EXT API IDs
    @{
    @brief API IDs for EXT
*/
#define BRCM_SWARCH_ETHSWT_SWTHELPERCTX_TYPE                     (0x8901U)    /**< @brief #ETHSWT_SWTHelperCtxType */
#define BRCM_SWARCH_ETHSWT_SWTDBGHELPERCTX_TYPE                  (0x8902U)    /**< @brief #ETHSWT_SWTDbgHelperCtxType */
#define BRCM_SWARCH_ETHSWT_SWTPORTINFOHELPERHDLR_PROC            (0x8903U)    /**< @brief #ETHSWT_SWTPortInfoHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTSETADMINMODEHELPERHDLR_PROC        (0x8904U)    /**< @brief #ETHSWT_SWTSetAdminModeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETADMINMODEHELPERHDLR_PROC        (0x8905U)    /**< @brief #ETHSWT_SWTGetAdminModeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETPORTSPEEDHELPERHDLR_PROC        (0x8906U)    /**< @brief #ETHSWT_SWTGetPortSpeedHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTSETMASTERSLAVEHELPERHDLR_PROC      (0x8907U)    /**< @brief #ETHSWT_SWTSetMasterSlaveHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETMASTERSLAVEHELPERHDLR_PROC      (0x8908U)    /**< @brief #ETHSWT_SWTGetMasterSlaveHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTSETPHYLBMODEHELPERHDLR_PROC        (0x8909U)    /**< @brief #ETHSWT_SWTSetPhyLbModeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETPHYLBMODEHELPERHDLR_PROC        (0x890AU)    /**< @brief #ETHSWT_SWTGetPhyLbModeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTSETJUMBOFRAMEHELPERHDLR_PROC       (0x890BU)    /**< @brief #ETHSWT_SWTSetJumboFrameHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETJUMBOFRAMEHELPERHDLR_PROC       (0x890CU)    /**< @brief #ETHSWT_SWTGetJumboFrameHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETTC10WAKEUPMODEHELPERHDLR_PROC   (0x890DU)    /**< @brief #ETHSWT_SWTGetTC10WakeUpModeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETTC10WAKEUPREASONHELPERHDLR_PROC (0x890EU)    /**< @brief #ETHSWT_SWTGetTC10WakeUpReasonHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETLINKSQIHELPERHDLR_PROC          (0x890FU)    /**< @brief #ETHSWT_SWTGetLinkSQIHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTGETLINKSQIPORTHELPERHDLR_PROC      (0x8910U)    /**< @brief #ETHSWT_SWTGetLinkSQIPortHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRSETAGETIMEHELPERHDLR_PROC     (0x8911U)    /**< @brief #ETHSWT_SWTCtrlrSetAgeTimeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRGETAGETIMEHELPERHDLR_PROC     (0x8912U)    /**< @brief #ETHSWT_SWTCtrlrGetAgeTimeHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRSETDUMPFWDHELPERHDLR_PROC     (0x8913U)    /**< @brief #ETHSWT_SWTCtrlrSetDumpFwdHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRGETDUMBFWDHELPERHDLR_PROC     (0x8914U)    /**< @brief #ETHSWT_SWTCtrlrGetDumbFwdHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRSETBRCMHDRHELPERHDLR_PROC     (0x8915U)    /**< @brief #ETHSWT_SWTCtrlrSetBRCMHdrHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRGETBRCMHDRHELPERHDLR_PROC     (0x8916U)    /**< @brief #ETHSWT_SWTCtrlrGetBRCMHdrHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRSETMGMTHELPERHDLR_PROC        (0x8917U)    /**< @brief #ETHSWT_SWTCtrlrSetMgmtHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRGETMGMTHELPERHDLR_PROC        (0x8918U)    /**< @brief #ETHSWT_SWTCtrlrGetMgmtHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTSETPVIDHELPERHDLR_PROC             (0x8919U)    /**< @brief #ETHSWT_SWTSetPvidHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRSETIFILTERHELPERHDLR_PROC     (0x891AU)    /**< @brief #ETHSWT_SWTCtrlrSetIfilterHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRGETIFILTERHELPERHDLR_PROC     (0x891BU)    /**< @brief #ETHSWT_SWTCtrlrGetIFilterHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRREADHELPERHDLR_PROC           (0x891CU)    /**< @brief #ETHSWT_SWTCtrlrReadHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTCTRLRWRITEHELPERHDLR_PROC          (0x891DU)    /**< @brief #ETHSWT_SWTCtrlrWriteHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTVLANGETHOPHELPERHDLR_PROC          (0x891EU)    /**< @brief #ETHSWT_SWTVlanGetHopHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTVLANSETHOPHELPERHDLR_PROC          (0x891FU)    /**< @brief #ETHSWT_SWTVlanSetHopHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLSETPORTLIMITHELPERHDLR_PROC     (0x8920U)    /**< @brief #ETHSWT_SWTArlSetPortLimitHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLGETPORTLIMITHELPERHDLR_PROC     (0x8921U)    /**< @brief #ETHSWT_SWTArlGetPortLimitHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLSETSTICKYHELPERHDLR_PROC        (0x8922U)    /**< @brief #ETHSWT_SWTArlSetStickyHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLGETSTICKYHELPERHDLR_PROC        (0x8923U)    /**< @brief #ETHSWT_SWTArlGetStickyHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLSETMVDETHELPERHDLR_PROC         (0x8924U)    /**< @brief #ETHSWT_SWTArlSetMvDetHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLGETMVDETHELPERHDLR_PROC         (0x8925U)    /**< @brief #ETHSWT_SWTArlGetMvDetHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLSETTOTALLIMITHELPERHDLR_PROC    (0x8926U)    /**< @brief #ETHSWT_SWTArlSetTotalLimitHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTARLGETTOTALLIMITHELPERHDLR_PROC    (0x8927U)    /**< @brief #ETHSWT_SWTArlGetTotalLimitHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTDBGCLEARPORTMIBSHELPERHDLR_PROC    (0x8928U)    /**< @brief #ETHSWT_SWTDbgClearPortMibsHelperHdlr */
#define BRCM_SWARCH_ETHSWT_SWTDBGGETPORTMIBSHELPERHDLR_PROC      (0x8929U)    /**< @brief #ETHSWT_SWTDbgGetPortMibsHelperHdlr */
/** @} */

/**
    @brief Switch Helper Module Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_SWTHelperCtxType {
    MODULE_MsgContextType     modCtx;   /**< @brief Helper interface Context     */
    ETHSWT_ExtHostContextType ctx;      /**< @brief Abstract interface Context   */
    uint32_t portIdx;                   /**< @brief To get Link Sqi of all ports */
    uint32_t vlanHoppingAction;         /**< @brief VLAN hopping Action          */
} ETHSWT_SWTHelperCtxType;

/**
    @brief Switch Debug Helper Context Type

    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_SWTDbgHelperCtxType {
    MODULE_MsgContextType       modCtx;   /**< @brief Helper interface Context     */
    ETHSWT_DebugHostContextType ctx;      /**< @brief Abstract interface Context   */
} ETHSWT_SWTDbgHelperCtxType;

/**
    @brief Switch Get Port Info handler

    This API process the switch get port info request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTPortInfoHelperHdlr(BCM_CmdType   *aMsg,
                                            uint8_t       *aBuff,
                                            uint32_t       aInputLen,
                                            uint32_t      *aOutLen,
                                            uint32_t       aMaxLength,
                                            int32_t        aResponse,
                                            ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Set Admin mode handler

    This API process the Switch Set Admin mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTSetAdminModeHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Admin mode handler

    This API process the Switch Get Admin mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetAdminModeHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Port Speed handler

    This API process the Switch Get Port Speed request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetPortSpeedHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Set Master Or Slave Mode handler

    This API process the Switch Set Master Or Slave Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTSetMasterSlaveHelperHdlr(BCM_CmdType   *aMsg,
                                                  uint8_t       *aBuff,
                                                  uint32_t       aInputLen,
                                                  uint32_t      *aOutLen,
                                                  uint32_t       aMaxLength,
                                                  int32_t        aResponse,
                                                  ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Master Or Slave Mode handler

    This API process the Switch Get Master Or Slave Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetMasterSlaveHelperHdlr(BCM_CmdType   *aMsg,
                                                  uint8_t       *aBuff,
                                                  uint32_t       aInputLen,
                                                  uint32_t      *aOutLen,
                                                  uint32_t       aMaxLength,
                                                  int32_t        aResponse,
                                                  ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Set Phy LoopBack Mode handler

    This API process the Switch Set Phy LoopBack Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTSetPhyLbModeHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Phy LoopBack Mode handler

    This API process the Switch Get Phy LoopBack Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetPhyLbModeHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Set Jumbo Frame handler

    This API process the Switch Set Jumbo Frame request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTSetJumboFrameHelperHdlr(BCM_CmdType   *aMsg,
                                                 uint8_t       *aBuff,
                                                 uint32_t       aInputLen,
                                                 uint32_t      *aOutLen,
                                                 uint32_t       aMaxLength,
                                                 int32_t        aResponse,
                                                 ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Jumbo Frame handler

    This API process the switch Get Jumbo Frame request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetJumboFrameHelperHdlr(BCM_CmdType   *aMsg,
                                                 uint8_t       *aBuff,
                                                 uint32_t       aInputLen,
                                                 uint32_t      *aOutLen,
                                                 uint32_t       aMaxLength,
                                                 int32_t        aResponse,
                                                 ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get TC10 WakeUp Mode handler

    This API process the Switch Get TC10 WakeUp Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetTC10WakeUpModeHelperHdlr(BCM_CmdType   *aMsg,
                                                     uint8_t       *aBuff,
                                                     uint32_t       aInputLen,
                                                     uint32_t      *aOutLen,
                                                     uint32_t       aMaxLength,
                                                     int32_t        aResponse,
                                                     ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get TC10 WakeUp Reason handler

    This API process the Switch Get TC10 WakeUp Reason request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetTC10WakeUpReasonHelperHdlr(BCM_CmdType   *aMsg,
                                                       uint8_t       *aBuff,
                                                       uint32_t       aInputLen,
                                                       uint32_t      *aOutLen,
                                                       uint32_t       aMaxLength,
                                                       int32_t        aResponse,
                                                       ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Link SQI handler

    This API process the Switch Get Link SQI request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetLinkSQIHelperHdlr(BCM_CmdType   *aMsg,
                                              uint8_t       *aBuff,
                                              uint32_t       aInputLen,
                                              uint32_t      *aOutLen,
                                              uint32_t       aMaxLength,
                                              int32_t        aResponse,
                                              ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Get Link SQI for Port handler

    This API process the Switch Get Link SQI request for single requested port
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTGetLinkSQIPortHelperHdlr(BCM_CmdType   *aMsg,
                                                  uint8_t       *aBuff,
                                                  uint32_t       aInputLen,
                                                  uint32_t      *aOutLen,
                                                  uint32_t       aMaxLength,
                                                  int32_t        aResponse,
                                                  ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Set Age Time handler

    This API process the Switch Controller Set Age Time request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrSetAgeTimeHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Get Age Time handler

    This API process the Switch Controller Get Age Time request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrGetAgeTimeHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller set Dumb Forward Mode handler

    This API process the switch set Dumb Forward Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrSetDumpFwdHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Get Dumb Forward Mode handler

    This API process the switch Get Dumb Forward Mode request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrGetDumbFwdHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller set Brcm Header handler

    This API process the switch Set Brcm Header request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrSetBRCMHdrHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Get Brcm Header handler

    This API process the switch Get Brcm Header request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrGetBRCMHdrHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Set Management handler

    This API process the switch Set Management request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrSetMgmtHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Get Management handler

    This API process the switch Get Management request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrGetMgmtHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Set PVID handler

    This API process the switch Set PVID request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTSetPvidHelperHdlr(BCM_CmdType   *aMsg,
                                           uint8_t       *aBuff,
                                           uint32_t       aInputLen,
                                           uint32_t      *aOutLen,
                                           uint32_t       aMaxLength,
                                           int32_t        aResponse,
                                           ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Set iFilter handler

    This API process the switch Set iFilter request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrSetIfilterHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Get iFilter handler

    This API process the switch Get iFilter request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrGetIFilterHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Register Read handler

    This API process the switch Register Read request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrReadHelperHdlr(BCM_CmdType   *aMsg,
                                             uint8_t       *aBuff,
                                             uint32_t       aInputLen,
                                             uint32_t      *aOutLen,
                                             uint32_t       aMaxLength,
                                             int32_t        aResponse,
                                             ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Register Write handler

    This API process the switch Register Write request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTCtrlrWriteHelperHdlr(BCM_CmdType   *aMsg,
                                              uint8_t       *aBuff,
                                              uint32_t       aInputLen,
                                              uint32_t      *aOutLen,
                                              uint32_t       aMaxLength,
                                              int32_t        aResponse,
                                              ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch VLAN Get Hop handler

    This API process the Switch VLAN Get Hop request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTVlanGetHopHelperHdlr(BCM_CmdType   *aMsg,
                                              uint8_t       *aBuff,
                                              uint32_t       aInputLen,
                                              uint32_t      *aOutLen,
                                              uint32_t       aMaxLength,
                                              int32_t        aResponse,
                                              ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch VLAN Set Hop handler

    This API process the Switch VLAN Set Hop request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTVlanSetHopHelperHdlr(BCM_CmdType   *aMsg,
                                              uint8_t       *aBuff,
                                              uint32_t       aInputLen,
                                              uint32_t      *aOutLen,
                                              uint32_t       aMaxLength,
                                              int32_t        aResponse,
                                              ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch ARL Port Limit Set Helper handler

    This API process the Switch ARL port Limit Set request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlSetPortLimitHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief ARL Switch Port Limit Get Helper handler

    This API process the Switch ARL port Limit Get request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlGetPortLimitHelperHdlr(BCM_CmdType   *aMsg,
                                                   uint8_t       *aBuff,
                                                   uint32_t       aInputLen,
                                                   uint32_t      *aOutLen,
                                                   uint32_t       aMaxLength,
                                                   int32_t        aResponse,
                                                   ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief SwitchARL Sticky Set Helper handler

    This API process the SwitchARL Sticky Set request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlSetStickyHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch ARL Get Sticky Helper handler

    This API process the Switch ARL Sticky Get request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlGetStickyHelperHdlr(BCM_CmdType   *aMsg,
                                                uint8_t       *aBuff,
                                                uint32_t       aInputLen,
                                                uint32_t      *aOutLen,
                                                uint32_t       aMaxLength,
                                                int32_t        aResponse,
                                                ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch ARL Move Detect Set Helper handler

    This API process the Switch ARL Move Detect Set request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlSetMvDetHelperHdlr(BCM_CmdType   *aMsg,
                                               uint8_t       *aBuff,
                                               uint32_t       aInputLen,
                                               uint32_t      *aOutLen,
                                               uint32_t       aMaxLength,
                                               int32_t        aResponse,
                                               ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch ARL Move Detect Get Helper handler

    This API process the Switch ARL Move Detect Get request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlGetMvDetHelperHdlr(BCM_CmdType   *aMsg,
                                               uint8_t       *aBuff,
                                               uint32_t       aInputLen,
                                               uint32_t      *aOutLen,
                                               uint32_t       aMaxLength,
                                               int32_t        aResponse,
                                               ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch ARL Total Limit Set Helper handler

    This API process the Switch ARL Set Time Limit request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlSetTotalLimitHelperHdlr(BCM_CmdType   *aMsg,
                                                    uint8_t       *aBuff,
                                                    uint32_t       aInputLen,
                                                    uint32_t      *aOutLen,
                                                    uint32_t       aMaxLength,
                                                    int32_t        aResponse,
                                                    ETHSWT_SWTHelperCtxType *aCtx);

/**
    @briefARL Total Limit Get Helper handler

    This API process the Switch ARL Get Time Limit request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTArlGetTotalLimitHelperHdlr(BCM_CmdType   *aMsg,
                                                    uint8_t       *aBuff,
                                                    uint32_t       aInputLen,
                                                    uint32_t      *aOutLen,
                                                    uint32_t       aMaxLength,
                                                    int32_t        aResponse,
                                                    ETHSWT_SWTHelperCtxType *aCtx);

/**
    @brief Switch Controller Clear Port mibs handler

    This API process the Switch Controller Clear Port mibs request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Debug Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTDbgClearPortMibsHelperHdlr(BCM_CmdType   *aMsg,
                                                    uint8_t       *aBuff,
                                                    uint32_t       aInputLen,
                                                    uint32_t      *aOutLen,
                                                    uint32_t       aMaxLength,
                                                    int32_t        aResponse,
                                                    ETHSWT_SWTDbgHelperCtxType *aCtx);

/**
    @brief Switch Controller Get Port mibs handler

    This API process the Switch Controller Get Port mibs request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                Switch Debug Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT
*/
extern int32_t ETHSWT_SWTDbgGetPortMibsHelperHdlr(BCM_CmdType   *aMsg,
                                                  uint8_t       *aBuff,
                                                  uint32_t       aInputLen,
                                                  uint32_t      *aOutLen,
                                                  uint32_t       aMaxLength,
                                                  int32_t        aResponse,
                                                  ETHSWT_SWTDbgHelperCtxType *aCtx);

#endif /* ETHSWT_EXT_COMMON_H */
/** @} */