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

#include <string.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <compiler.h>
#include <osil/pchdrv_osil.h>

/*
   This file defines example functions used as patch routine.
   These are compiled as part of test elf and the binary is extracted
   to form the patch image
*/

COMP_ALIGN(8)
void PCHT_PatchRoutine0(uint32_t param1, uint32_t param2, uint32_t param3, uint32_t param4)
{
    uint32_t volatile *ptr = (uint32_t *)param1;
    uint32_t i;
    ptr[0] = 0x11111111UL;
    ptr[1] = param2;
    ptr[2] = param3;
    ptr[3] = param4;
    ptr[4] = 0;
    for (i = 0; i < 4; i++) {
        if (i != 0U) {
            ptr[4] += ptr[i];
        }
    }
}

COMP_ALIGN(8)
void PCHT_PatchRoutine1(uint32_t param1, uint32_t param2, uint32_t param3, uint32_t param4)
{
    uint32_t volatile *ptr = (uint32_t *)param1;
    uint32_t i;
    ptr[0] = 0x22222222UL;
    ptr[1] = param2;
    ptr[2] = param3;
    ptr[3] = param4;
    ptr[4] = 0xFFFFFFFFUL;
    for (i = 0; i < 4; i++) {
        if (i != 0U) {
            ptr[4] ^= ptr[i];
        }
    }
}

COMP_ALIGN(8)
void PCHT_PatchRoutine2(uint32_t param1, uint32_t param2, uint32_t param3, uint32_t param4)
{
    uint32_t volatile *ptr = (uint32_t *)param1;
    uint32_t volatile i;
    ptr[0] = 0x33333333UL;
    ptr[1] = param2;
    ptr[2] = param3;
    ptr[3] = param4;
    ptr[4] = 0UL;
    for (i = 0; i < 4; i++) {
        if (i != 0U) {
            ptr[4] |= ptr[i];
        }
    }
}

COMP_SECTION(".version.pchdrv_test")
const PATCH_PatchFuncType PCHT_PatchRoutineArr[] = {
    PCHT_PatchRoutine0,
    PCHT_PatchRoutine1,
    PCHT_PatchRoutine2,
};