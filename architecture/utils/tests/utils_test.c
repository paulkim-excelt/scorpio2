/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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

#include <stdint.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <shell.h>

#include <bcm_utils.h>

#define MEMTEST_QT          (1UL)
#ifdef ENABLE_UTILS_IT
#define MEMTEST_IT          (0x1001UL)
#define CRC_IT              (0x1002UL)   /**< @brief Used for CRC IT */
#define ERROR_IT            (0x1003UL)
#define SVC_IT              (0x1004UL)
#endif /* ENABLE_UTILS_IT */

int32_t MemtestQT_Start(void);
int32_t MemtestQT_GetResult(void);

extern void MEMTESTIT_Execute(void);
extern int32_t MEMTESTIT_GetResult(void);
extern void CRCIT_Execute(void);
extern int32_t CRCIT_GetResult(void);
extern void ERRORIT_Execute(void);
extern int32_t ERRORIT_GetResult(void);
extern void SVCIT_Execute(void);
extern int32_t SVCIT_GetResult(void);

int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret = BCM_ERR_OK;

    BCM_TestStart(BCM_UTL_ID);

    switch(aIndex)
    {
    case MEMTEST_QT:
        (void)MemtestQT_Start();
        break;
#ifdef ENABLE_UTILS_IT
    case MEMTEST_IT:
        MEMTESTIT_Execute();
        break;
    case CRC_IT:
        CRCIT_Execute();
        break;
    case ERROR_IT:
        ERRORIT_Execute();
        break;
    case SVC_IT:
        SVCIT_Execute();
        break;
#endif /* ENABLE_UTILS_IT */
    default:
        ret = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    switch(aIndex)
    {
    case MEMTEST_QT:
        ret = MemtestQT_GetResult();
        break;
#ifdef ENABLE_UTILS_IT
    case MEMTEST_IT:
        ret = MEMTESTIT_GetResult();
        break;
    case CRC_IT:
        ret = CRCIT_GetResult();
        break;
    case ERROR_IT:
        ret = ERRORIT_GetResult();
        break;
    case SVC_IT:
        ret = SVCIT_GetResult();
        break;
#endif /* ENABLE_UTILS_IT */
    default:
        ret = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return ret;
}

