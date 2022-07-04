/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_secureheap_il
    @{

    @file secure_heap_osil_erika.c
    @brief Secure heap driver integration
    This source file contains the integration of secure heap driver to system
    @version 0.10 Initial version
*/

#include <stdint.h>
#include <stddef.h>

#include "osil/secure_heap_osil.h"

/**
    @name Secure heap driver interface IDs
    @{
    @brief Interface IDs for the secure heap driver
*/
#define BRCM_SWDSGN_SECHEAP_SYSCMDREQ_PROC    (0xB101U)    /**< @brief #SECHEAP_SysCmdReq */
/** @} */

/**
    @trace #BRCM_SWARCH_SECHEAP_SYSCMD_REQ_PROC
    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
int32_t SECHEAP_SysCmdReq(SECHEAP_CmdType aCmd, SECHEAP_IOType *const aIO)
{
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if (aIO != NULL) {
#ifndef SECHEAP_ALLOW_MEMCMP_CMD
        if (SECHEAP_CMD_MEMCMP != aCmd) {
#endif
            SECHEAP_SysCmdHandler(SVC_MAGIC_SHP_ID, aCmd, (uint8_t*)aIO);
            ret = aIO->retVal;

#ifndef SECHEAP_ALLOW_MEMCMP_CMD
        } else {
            ret = BCM_ERR_UNKNOWN;
        }
#endif
    }
    return ret;
}

/** @} */
