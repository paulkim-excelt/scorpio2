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
#include <otpm_test.h>
#include <osil/otp_module_osil.h>
#include <otp_module.h>
#include <bcm_utils.h>
#include <crc.h>
#ifdef __BCM8958X__
#include <8958x/otpm_test_data.h>
#else
#include <8957x/otpm_test_data.h>
#endif

#ifdef OTPM_ALT_MEM_ROWS_COUNT
void OTPM_SetAltMemHdr(OTPM_AltMemHdrType *const aAltMemHdr)
{
#ifdef __BCM8958X__
    /*Nothing to do*/
#else
    BCM_MemCpy((void *)aAltMemHdr, OTPM_AltMem, sizeof(OTPM_AltMemHdrType));
#endif
}
#endif

#ifdef OTPM_M7_TEST_SVC_HANDLER
const uint32_t *OTPM_test_data[] = {
    OTPM_test_seq_0,
    OTPM_test_seq_1,
    OTPM_test_seq_2,
};

#ifdef OTPM_ALT_MEM_ROWS_COUNT
static uint32_t OTPM_test_data_size = sizeof(OTPM_test_seq_0);
static uint32_t OTPM_test_data_count = BCM_ARRAY_LEN(OTPM_test_data);
#endif

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
#ifdef OTPM_ALT_MEM_ROWS_COUNT
    uint32_t clearMagic = 0UL;
    if (aCmd == 0x1001UL) {
        aCmd = 0x1UL;
        clearMagic = 0x1UL;
    }
    if (aCmd < OTPM_test_data_count) {
        uint32_t otp_size;


        CORTEX_MX_MPUDisable();
        OTPM_AltMemHdrType * const otpAltMemHdr = (void *)OTPM_AltMem;
        otpAltMemHdr->magic = 0x4f545041UL;
        if (aCmd != 1U) {
            otp_size = (OTPM_ROW_COUNT * 4) - sizeof(OTPM_AltMemHdrType);
            otpAltMemHdr->crc = BCM_CRC32((uint8_t*)OTPM_test_data[aCmd] + sizeof(OTPM_AltMemHdrType), otp_size, OTPM_CRC32_POLY);
        }
        if (clearMagic == 0x1UL) {
            otpAltMemHdr->magic = 0x0UL;
        }
        otpAltMemHdr->reserved[0] = 0U;
        otpAltMemHdr->reserved[1] = 0U;
        BCM_MemCpy((uint8_t *)OTPM_AltMem + sizeof(OTPM_AltMemHdrType), (uint8_t*)OTPM_test_data[aCmd] + sizeof(OTPM_AltMemHdrType), OTPM_test_data_size - sizeof(OTPM_AltMemHdrType));
        CORTEX_MX_MPUEnable();
    }
#endif
}
#endif


int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            if (aIndex < 0x0010) {
                retVal = OTPM_ExecuteQt(aIndex);
            } else {
                retVal = OTPM_ExecuteSecQt(aIndex);
            }
            break;
#if defined (OTPM_M7_COVERAGE_TEST)
        case BCM_TEST_SEQ_TYPE_PRB:
            retVal = OTPM_ExecuteCt(aIndex);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t retVal = BCM_AT_NOT_AVAILABLE;
    uint32_t testType;

    testType = ((aIndex & BCM_TEST_SEQ_TYPE_MASK) >> (BCM_TEST_SEQ_TYPE_SHIFT));

    switch (testType) {
        case BCM_TEST_SEQ_TYPE_QT:
            if (aIndex < 0x0010) {
                retVal = OTPM_GetStatusQt(aIndex);
            } else {
                retVal = OTPM_GetStatusSecQt(aIndex);
            }
            break;
#if defined (OTPM_M7_COVERAGE_TEST)
        case BCM_TEST_SEQ_TYPE_PRB:
            retVal = OTPM_GetStatusCt(aIndex);
            break;
#endif
        default:
            retVal = BCM_AT_NOT_AVAILABLE;
            break;
    }

    return retVal;
}
