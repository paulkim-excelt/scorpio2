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

/**
    @defgroup grp_ethsrv_swtfa_ifc Ethernet Service: Flow Accelerator Interface
    @ingroup grp_ethsrv_swt

    @addtogroup grp_ethsrv_swtfa_ifc
    @{

    @nfile ethswtm_fa.h

    @brief Communication Subsystem: Flow Accelerator Interface
    This file contains the interfaces for the Ethernet Service specific
    to flow accelerator

    @version 0.1 Initial version
*/

#ifndef ETHSWTM_FA_H
#define ETHSWTM_FA_H

#include <ethswt_common.h>
#include <ethernet_swt_fa.h>
#include <ethswt_fa.h>
#include <mcu_switch_ext.h>
#include <module.h>

/**
    @name Ethernet Service Flow Accelerator API IDs
    @{
    @brief API IDs for Flow Accelerator in Ethernet Service
*/
#define BRCM_SWARCH_ETHSWTM_FA_CFG_MAGIC_MACRO      (0x8201U)    /**< @brief #ETHSWTM_FA_CFG_MAGIC        */
#define BRCM_SWARCH_ETHSWTM_FACFG_TYPE              (0x8202U)    /**< @brief #ETHSWTM_FACfgType           */
#define BRCM_SWARCH_ETHSWTM_FAMODULE_GLOBAL         (0x8203U)    /**< @brief #ETHSWTM_FAModule            */
/** @} */

/**
    @brief Magic for FA configuration- 'F''L''A''C'

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/
#define ETHSWTM_FA_CFG_MAGIC      (0x464C4143UL)   /**< @brief MAGIC for FA configuration- 'F''L''A''C' */

/**
    @name ETHSWTM_FACfgType
    @{
    @brief Flow accelerator Configuration type

    @note  An all zero MAC address(0:0:0:0:0:0) will be replaced by device's MAC
           address during initialisation. However during rest of the execution,
           an all zero MAC address obtained through application/host will be
           considered as invalid.

    @trace #BRCM_SWREQ_ETHSWTM_FA
 */
typedef struct COMP_PACKED sETHSWTM_FACfgType {
    uint32_t magic;         /**< @brief Magic ID of FA */
    uint16_t flowCount;     /**< @brief Number of valid flows */
    ETHSWT_FACtfCfgType ctf;/**< @brief CTF configuration */
    ETHSWT_FAMacGroupType macGroup[2UL]; /**< @brief MAC Group Configuration */
    ETHSWT_FAFlowDataType flow[ETHSWTM_FA_STATIC_FLOWS_MAX]; /**< @brief flow configuration */
} ETHSWTM_FACfgType;
/** @} */

/**
    @brief Function pointer table for ETHSWTM FA module

    @trace #BRCM_SWREQ_ETHSWTM_FA
 */
extern const MODULE_Type ETHSWTM_FAModule;

/**
    @brief Compile type checks for the payload size

    @trace #BRCM_SWREQ_ETHSWTM_FA
*/

#endif /* ETHSWTM_FA_H */

/** @} */
