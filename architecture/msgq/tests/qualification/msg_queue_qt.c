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

#include <bcm_err.h>
#include <bcm_test.h>
#include "ee.h"

#include "msg_queue_qt.h"

extern void MsgQQT1_Start(void);
extern void MsgQQT2_Start(void);
extern void MsgQQT3_Start(void);
extern void MsgQQT4_Start(void);

extern int32_t MsgQQT1_GetResult(void);
extern int32_t MsgQQT2_GetResult(void);
extern int32_t MsgQQT3_GetResult(void);
extern int32_t MsgQQT4_GetResult(void);

int32_t MSGQ_ExecuteQt(uint32_t aIndex)
{
    int32_t ret = BCM_ERR_OK;
    switch(aIndex) {
#ifdef BRCM_SWQTSEQ_MSGQ_EN_NOTIF_1
        case BRCM_SWQTSEQ_MSGQ_EN_NOTIF_1:
            MsgQQT1_Start();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_2
        case BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_2:
            MsgQQT2_Start();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3
        case BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3:
            MsgQQT3_Start();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MSGQ_EN_NOTIF_4
        case BRCM_SWQTSEQ_MSGQ_EN_NOTIF_4:
            MsgQQT4_Start();
            break;
#endif
        default:
            ret = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return ret;
}

int32_t MSGQ_GetStatusQt(uint32_t aIndex)
{
    int32_t ret;

    switch(aIndex) {
#ifdef BRCM_SWQTSEQ_MSGQ_EN_NOTIF_1
        case BRCM_SWQTSEQ_MSGQ_EN_NOTIF_1:
            ret = MsgQQT1_GetResult();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_2
        case BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_2:
            ret = MsgQQT2_GetResult();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3
        case BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3:
            ret = MsgQQT3_GetResult();
            break;
#endif
#ifdef BRCM_SWQTSEQ_MSGQ_EN_NOTIF_4
        case BRCM_SWQTSEQ_MSGQ_EN_NOTIF_4:
            ret = MsgQQT4_GetResult();
            break;
#endif
        default:
            ret = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return ret;
}
