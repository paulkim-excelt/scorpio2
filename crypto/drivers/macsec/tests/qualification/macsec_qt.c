/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
#include "ee.h"
#include <bcm_utils.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <bcm_time.h>
#include <shell.h>
#include <osil/bcm_osil.h>

#include "macsec_test.h"

#define GetModuleLogLevel()     ULOG_LVL_ERROR

#define CALL(func)                                                              \
        retVal = func;                                                          \
        if (BCM_ERR_OK != retVal) {                                             \
            MACSEC_QtResult = retVal;                                             \
            MACSEC_QtErrCnt++;                                                    \
            goto err_exit;                                                      \
        }                                                                       \

#define EXECUTE_TEST(case, func, expecRet)                                      \
        BCM_SetTestCase(case);                                                  \
        retVal = func;                                                          \
        if (expecRet == retVal) {                                               \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("TIM_QT: Err case: %x, retVal: %x at: %d\n",               \
                                            case, retVal, __LINE__);            \
            MACSEC_QtErrCnt++;                                                    \
        }                                                                       \

#define REPORT_RESULT(case, condition)                                          \
        BCM_SetTestCase(case);                                                  \
        if (condition) {                                                        \
            BCM_SetTestResult(BCM_ERR_OK);                                      \
        } else {                                                                \
            BCM_SetTestResult(BCM_ERR_UNKNOWN);                                 \
            ULOG_ERR("TIM_QT: Err case: %x, at line : %d\n", case, __LINE__);   \
            MACSEC_QtErrCnt++;                                                    \
        }                                                                       \

#define MACSEC_IT1               (0UL)
#define MACSEC_IT2               (2UL)
#define MACSEC_IT3               (3UL)

#define MACSEC_DEF_CIPHER       (MACSEC_CIPHERID_GCM_AES_128)

static int32_t MACSEC_QtState = BCM_AT_NOT_STARTED;
static uint32_t MACSEC_QtIdx = 0UL;
static int32_t MACSEC_QtResult;
static uint32_t MACSEC_QtErrCnt;

#define MACSEC_PORT_ID      (3UL)

#define MACSEC_AN0             (0U)
#define MACSEC_AN1             (1U)
#define MACSEC_AN2             (2U)
#define MACSEC_AN3             (3U)

static const uint8_t MACSEC_QtMacDA0[6U] = {0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA};
static const uint8_t MACSEC_QtMacSA0[6U] = {0xF6, 0xE5, 0xBB, 0xD2, 0x72, 0x77};

static const uint8_t MACSEC_QtMacDA1[6U] = {0xE2, 0x01, 0x06, 0xD7, 0xCD, 0x0D};
static const uint8_t MACSEC_QtMacSA1[6U] = {0xF0, 0x76, 0x1E, 0x8D, 0xCD, 0x3D};

static const MACSEC_SCIType MACSEC_QtSCI0  = {
    .macAddr = {0x7c, 0xFD, 0xE9, 0xF9, 0xE3, 0x37},
    .portNum = 0x24C6UL,
};

static const MACSEC_SCIType MACSEC_QtSCI1  = {
    .macAddr = {0x7c, 0xFD, 0xE9, 0xF9, 0xE3, 0x37},
    .portNum = 0x5E81UL,
};

static const MACSEC_KeyType MACSEC_AES128Keys[] = {
    {
        .sak = {
            0x07, 0x1B, 0x11, 0x3B, 0x0C, 0xA7, 0x43, 0xFE,
            0xCC, 0xCF, 0x3D, 0x05, 0x1F, 0x73, 0x73, 0x82
        },
        .keyId = {
            0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9,
            0xa, 0xb, 0xc, 0xd, 0xe, 0xf, 0x10
        },
        /* will be use only with xpn 128 cipher */
        .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2, 0x1C, 0x66, 0xFA, 0x6D},
    },
    {
        .sak = {
            0xAD, 0x7A, 0x2B, 0xD0, 0x3E, 0xAC, 0x83, 0x5A,
            0x6F, 0x62, 0x0F, 0xDC, 0xB5, 0x06, 0xB3, 0x45,
        },
        .keyId = {
            0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
            0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e,
            0x1f, 0x20
        },
        /* will be use only with xpn 128 cipher */
        .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2,
                0x1C, 0x66, 0xFA, 0x6D},
    },
    {
        .sak = {0x01, 0x3F, 0xE0, 0x0B, 0x5F, 0x11, 0xBE, 0x7F,
                0x86, 0x6D, 0x0C, 0xBB, 0xC5, 0x5A, 0x7A, 0x90},
        .keyId = {
            0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
            0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
            0x2f, 0x30
        },
        /* will be use only with xpn 128 cipher */
        .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2,
                0x1C, 0x66, 0xFA, 0x6D},
    },
    {
        .sak = {0x88, 0xEE, 0x08, 0x7F, 0xD9, 0x5D, 0xA9, 0xFB,
                0xF6, 0x72, 0x5A, 0xA9, 0xD7, 0x57, 0xB0, 0xCD},
        .keyId = {
            0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
            0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e,
            0x3f, 0x40
        },
        /* will be use only with xpn 128 cipher */
        .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2, 0x1C, 0x66, 0xFA, 0x6D},
    }
};
static const MACSEC_KeyType MACSEC_AES128Key0 = {
    .sak = {
        0x07, 0x1B, 0x11, 0x3B, 0x0C, 0xA7, 0x43, 0xFE,
        0xCC, 0xCF, 0x3D, 0x05, 0x1F, 0x73, 0x73, 0x82
    },
    .keyId = {
        0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
        0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf, 0x10
    },
    /* will be use only with xpn 128 cipher */
    .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2,
             0x1C, 0x66, 0xFA, 0x6D},
};

static const MACSEC_KeyType MACSEC_AES128Key1 = {
    .sak = {
        0xAD, 0x7A, 0x2B, 0xD0, 0x3E, 0xAC, 0x83, 0x5A,
        0x6F, 0x62, 0x0F, 0xDC, 0xB5, 0x06, 0xB3, 0x45,
    },
    .keyId = {
        0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
        0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e,
        0x1f, 0x20
    },
    /* will be use only with xpn 128 cipher */
    .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2,
             0x1C, 0x66, 0xFA, 0x6D},
};

static const MACSEC_KeyType MACSEC_AES128Key2 = {
    .sak = {0x01, 0x3F, 0xE0, 0x0B, 0x5F, 0x11, 0xBE, 0x7F,
            0x86, 0x6D, 0x0C, 0xBB, 0xC5, 0x5A, 0x7A, 0x90},
    .keyId = {
        0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
        0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
        0x2f, 0x30
    },
    /* will be use only with xpn 128 cipher */
    .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2,
             0x1C, 0x66, 0xFA, 0x6D},
};

static const MACSEC_KeyType MACSEC_AES128Key3 = {
    .sak = {0x88, 0xEE, 0x08, 0x7F, 0xD9, 0x5D, 0xA9, 0xFB,
            0xF6, 0x72, 0x5A, 0xA9, 0xD7, 0x57, 0xB0, 0xCD},
    .keyId = {
        0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
        0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e,
        0x3f, 0x40
    },
    /* will be use only with xpn 128 cipher */
    .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2, 0x1C, 0x66, 0xFA, 0x6D},
};

static const MACSEC_KeyType MACSEC_QtKeyAES256 = {
    .sak = {0x83, 0xC0, 0x93, 0xB5, 0x8D, 0xE7, 0xFF, 0xE1,
            0xC0, 0xDA, 0x92, 0x6A, 0xC4, 0x3F, 0xB3, 0x60,
            0x9A, 0xC1, 0xC8, 0x0F, 0xEE, 0x1B, 0x62, 0x44,
            0x97, 0xEF, 0x94, 0x2E, 0x2F, 0x79, 0xA8, 0x23},
    /* will be use only with xpn 256 cipher */
    .salt = {0xE6, 0x30, 0xE8, 0x1A, 0x48, 0xDE, 0x86, 0xA2,
             0x1C, 0x66, 0xFA, 0x6D},
};

static const uint8_t MACSEC_QtSSCI[4UL] = {0x7A, 0x30, 0xC1, 0x18};

static const uint8_t MACSEC_QtTestData[] = {
    0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA,
    0xF6, 0xE5, 0xBB, 0xD2, 0x72, 0x77,
    0x08, 0x00, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14,
    0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C,
    0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x23, 0x24,
    0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C,
    0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33, 0x34,
    0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x00,
    0x06,
};

#define MACSEC_QT_CP_RULES      (2UL)

static const MACSEC_RuleOpt0Type MACSEC_QtCPTbl[ ] = {
    /* MAC DA match only */
    {
        .macDAStart = {0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA},
        .macDAEnd = {0},
        .ethType = 0x0,
        .ruleMatch = MACSEC_RULEMATCH_DA_ONLY,
        .dir = MACSEC_RULE_DIR_EGRESS,
    },
    /* ethtype match only */
    {
        .macDAStart = {0x0},
        .macDAEnd = {0},
        .ethType = 0x88F8,
        .ruleMatch = MACSEC_RULEMATCH_ETHTYPE_ONLY,
        .dir = MACSEC_RULE_DIR_EGRESS,
    },
    /* MAC DA and ethtype match both */
    {
        .macDAStart = {0xE2, 0x01, 0x06, 0xD7, 0xCD, 0x0D},
        .macDAEnd = {0},
        .ethType = 0x88F9,
        .ruleMatch = MACSEC_RULEMATCH_DA_ETHTYPE,
        .dir = MACSEC_RULE_DIR_EGRESS,
    },
    /* MAC DA range */
    {
        .macDAStart = {0x00U, 0x01U, 0x02U, 0x03U, 0x04U, 0x05U},
        .macDAEnd = {0x0U, 0x0AU, 0x02U, 0x03U, 0x04U, 0x05U},
        .ethType = 0x00U,
        .ruleMatch = MACSEC_RULEMATCH_DA_RANGE_ONLY,
        .dir = MACSEC_RULE_DIR_EGRESS,
    },
    /* MAC DA range */
    {
        .macDAStart = {0x0U, 0x0AU, 0x03U, 0x04U, 0x05U, 0x06U},
        .macDAEnd = {0x0U, 0x0CU, 0x03U, 0x04U, 0x05U, 0x06U},
        .ethType = 0x88F9U,
        .ruleMatch = MACSEC_RULEMATCH_DA_RANGE_ETHTYPE,
        .dir = MACSEC_RULE_DIR_EGRESS,
    },
#if 0
    /* vlan tagged packet */
    {
        .macDAStart = {0U},
        .macDAEnd = {0U},
        .ethType = 0x0U,
        .qTagTCI = 0x2U, /* PCP = 0, DEI = 0, VLAN ID = 2 */
        .ruleMask = MACSEC_CPRULEMATCH_QTAG_TCI,
        .dir = MACSEC_RULE_DIR_BOTH,
    },
#endif
};

#define MACSEC_QT_MAX_RXSC_PER_SECY     (3UL)

typedef struct sMACSEC_QtSecY {
    MACSEC_SecYCfgType      cfg;
    MACSEC_RuleOpt1Type     rule;
    MACSEC_RuleHdlType      ruleHandle;
    MACSEC_RuleHdlType      ruleHandle1;
    MACSEC_SecYHdlType      secYHandle;
    MACSEC_SCIType          txSCI;
    uint32_t                txSSCI;
    MACSEC_SCIType          rxSCI[MACSEC_QT_MAX_RXSC_PER_SECY];
    uint32_t                rxSSCI[MACSEC_QT_MAX_RXSC_PER_SECY];
    MACSEC_SAHdlType        txSA[MACSEC_AN_MAX + 1UL];
    MACSEC_SAHdlType        rxSA[MACSEC_AN_MASK + 1UL];
    MACSEC_CipherIdType     cipher;
} MACSEC_QtSecY;

const MACSEC_RuleOpt1Type SecYLookupRule = {
    .macDA = {0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA},
    .macSA = {0xF6, 0xE5, 0xBB, 0xD2, 0x72, 0x77},
    .macSecTagged = FALSE,
    .frameData = {0UL},
    .vlanTagged = FALSE,
    .matchMacDAMask = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF},
    .matchMacSAMask = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF},
    .matchFrameDataMask = {0UL},
    .dir = MACSEC_RULE_DIR_INGRESS,
};


int32_t MACSEC_QtCPRules(MACSEC_HwIDType aID)
{
    int32_t retVal;
    MACSEC_RuleOpt1Type ruleOpt1;
    MACSEC_RuleHdlType handles[10UL];
    uint32_t i = 0UL;
    uint32_t j;

    MACSEC_CfgType  config = {
        .speed = MACSEC_MACSPEED_1000MBPS,
        .checkKaY = FALSE,
        .enableQtagParse = FALSE,
    };
    uint8_t macDA[] = {0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA};
    uint8_t macSA[] = {0xF6, 0xE5, 0xBB, 0xD2, 0x72, 0x77};
    uint8_t data[] = {0x08, 0x00, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14};

    CALL(MACSEC_Init(aID, &config));

    /* Match MAC DA only */
    BCM_MemSet(&ruleOpt1, 0x0U, sizeof(ruleOpt1));
    BCM_MemCpy(ruleOpt1.macDA, macDA, 6UL);
    BCM_MemSet(ruleOpt1.matchMacDAMask, 0xFFU, 6UL);
    ruleOpt1.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddCPRuleOpt1(aID, &ruleOpt1, &handles[i++]));

    macDA[5] += 1UL;
    macSA[5] += 1UL;
    /* Match SA only */
    BCM_MemSet(&ruleOpt1, 0x0U, sizeof(ruleOpt1));
    BCM_MemCpy(ruleOpt1.macSA, macSA, 6UL);
    BCM_MemSet(ruleOpt1.matchMacSAMask, 0xFFU, 6UL);
    ruleOpt1.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddCPRuleOpt1(aID, &ruleOpt1, &handles[i++]));

    macDA[5] += 1UL;
    macSA[5] += 1UL;
    /* Match DA + SA */
    BCM_MemSet(&ruleOpt1, 0x0U, sizeof(ruleOpt1));
    BCM_MemCpy(ruleOpt1.macDA, macDA, 6UL);
    BCM_MemCpy(ruleOpt1.macSA, &macSA, 6UL);
    BCM_MemSet(ruleOpt1.matchMacDAMask, 0xFFU, 6UL);
    BCM_MemSet(ruleOpt1.matchMacSAMask, 0xFFU, 6UL);
    ruleOpt1.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddCPRuleOpt1(aID, &ruleOpt1, &handles[i++]));

    macDA[5] += 1UL;
    macSA[5] += 1UL;
    /* match EthType only */
    ruleOpt1.frameData[0] = data[0] | data[1] << 8;
    ruleOpt1.matchFrameDataMask[0] = 0xFFFF;
    ruleOpt1.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddCPRuleOpt1(aID, &ruleOpt1, &handles[i++]));

    macDA[5] += 1UL;
    macSA[5] += 1UL;
    data[0] += 1U;
    /* match DA + EthType only */
    BCM_MemSet(&ruleOpt1, 0x0U, sizeof(ruleOpt1));
    BCM_MemCpy(ruleOpt1.macDA, macDA, 6UL);
    BCM_MemSet(ruleOpt1.matchMacDAMask, 0xFFU, 6UL);
    ruleOpt1.frameData[0] = data[0] | data[1] << 8;
    ruleOpt1.matchFrameDataMask[0] = 0xFFFF;
    ruleOpt1.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddCPRuleOpt1(aID, &ruleOpt1, &handles[i++]));

    macDA[5] += 1UL;
    macSA[5] += 1UL;
    data[0] += 1U;
    /* match SA + data only */
    BCM_MemSet(&ruleOpt1, 0x0U, sizeof(ruleOpt1));
    BCM_MemCpy(ruleOpt1.macSA, macSA, 6UL);
    BCM_MemSet(ruleOpt1.matchMacSAMask, 0xFFU, 6UL);
    ruleOpt1.frameData[0] = data[0] | data[1] << 8 | data[2] << 16 | data[3] << 24;
    ruleOpt1.frameData[1] = data[4] | data[5] << 8 | data[6] << 16 | data[7] << 24;
    ruleOpt1.matchFrameDataMask[0] = 0xFFFFFFFF;
    ruleOpt1.matchFrameDataMask[1] = 0xFFFFFFFF;
    ruleOpt1.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddCPRuleOpt1(aID, &ruleOpt1, &handles[i++]));

    for (j = 0; j < i; j++) {
        CALL(MACSEC_RemoveCPRule(aID, handles[j]));
    }

    for (i = 0UL; i < BCM_ARRAY_LEN(MACSEC_QtCPTbl); i++) {
        CALL(MACSEC_AddCPRuleOpt0(aID, &MACSEC_QtCPTbl[i], &handles[i]));
    }

    for (i = 0UL; i < BCM_ARRAY_LEN(MACSEC_QtCPTbl); i++) {
        CALL(MACSEC_RemoveCPRule(aID, handles[i]));
    }

    CALL(MACSEC_DeInit(aID));
err_exit:
    return retVal;
}

static int32_t MACSEC_FlowTxRx(MACSEC_HwIDType aID, MACSEC_CipherIdType aCipher)
{
    int32_t retVal = BCM_ERR_OK;
    const MACSEC_KeyType *key = NULL;

    MACSEC_CfgType  config = {
        .speed = MACSEC_MACSPEED_1000MBPS,
        .checkKaY = FALSE,
        .enableQtagParse = FALSE,
    };
    MACSEC_QtSecY secy = {
        .cfg = {
            .includeSCI = TRUE,
            .preSecTagAuthLen = 12U,
            .preSecTagAuthStart = 0U,
            .secTagOffset = 12U,
            .xpnEnable = FALSE,
        },
    };
    MACSEC_ANType an = 0;

    switch (aCipher) {
        case MACSEC_CIPHERID_GCM_AES_128:
            key = &MACSEC_AES128Key0;
            break;
        case MACSEC_CIPHERID_GCM_AES_256:
            key = &MACSEC_QtKeyAES256;
            break;
        case MACSEC_CIPHERID_GCM_AES_XPN_128:
            BCM_MemCpy(&secy.txSSCI, MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            BCM_MemCpy(&secy.rxSSCI[0], MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            secy.cfg.xpnEnable = TRUE;
            key = &MACSEC_AES128Key0;
            break;
        case MACSEC_CIPHERID_GCM_AES_XPN_256:
            BCM_MemCpy(&secy.rxSSCI[0], MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            BCM_MemCpy(&secy.txSSCI, MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            secy.cfg.xpnEnable = TRUE;
            key = &MACSEC_QtKeyAES256;
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            goto err_exit;
    }

    CALL(MACSEC_Init(aID, &config));
    CALL(MACSEC_CreateSecY(aID, &secy.cfg, &secy.secYHandle));
    CALL(MACSEC_SetCipherSuite(secy.secYHandle, aCipher, MACSEC_CONF_OFFSET_0));

    BCM_MemCpy(&secy.txSCI, &MACSEC_QtSCI0 , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateTxSC(secy.secYHandle, &secy.txSCI));

    MACSEC_SCIType rxSCI = {
        .macAddr = {0x84, 0xC5, 0xD5, 0x13, 0xD2, 0xAA},
        .portNum = 10,
    };
    BCM_MemCpy(&secy.rxSCI[0U], &rxSCI , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateRxSC(secy.secYHandle, &secy.rxSCI[0UL]));

    /* encrypt/decrypt traffic flow with ethtype = 0x8100 */
    BCM_MemSet(&secy.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));
    //secy.rule.frameData[0] = MACSEC_QtTestData[12] | MACSEC_QtTestData[13] << 8;
    secy.rule.dir = MACSEC_RULE_DIR_EGRESS;
    CALL(MACSEC_AddSecYLookupRule(secy.secYHandle, &secy.rule, &secy.ruleHandle));

    BCM_MemSet(&secy.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));
    //BCM_MemCpy(secy.rule.macDA, MACSEC_QtTestData, 6UL);
    secy.rule.macSecTagged = TRUE;
    secy.rule.dir = MACSEC_RULE_DIR_INGRESS;
    CALL(MACSEC_AddSecYLookupRule(secy.secYHandle, &secy.rule, &secy.ruleHandle1));

    /* create tx/rx SA */
    if (TRUE == secy.cfg.xpnEnable) {
        CALL(MACSEC_CreateTxSA(secy.secYHandle, an, 0x0UL, &secy.txSCI, secy.txSSCI, TRUE,
                               key, &secy.txSA[an]));
        CALL(MACSEC_CreateRxSA(secy.secYHandle, an, 0x1UL, &secy.rxSCI[0],
                               secy.rxSSCI[0], key, &secy.rxSA[an]));
    } else {
        CALL(MACSEC_CreateTxSA(secy.secYHandle, an, 0x0UL, &secy.txSCI, 0UL, TRUE, key,
                               &secy.txSA[an]));
        CALL(MACSEC_CreateRxSA(secy.secYHandle, an, 0x1UL, &secy.rxSCI[0],
                               0UL, key, &secy.rxSA[an]));
    }
    /* enable tx/rx SA */
    uint64_t txPN, rxPN;
    CALL(MACSEC_SAEnable(secy.txSA[an]));
    CALL(MACSEC_SAEnable(secy.rxSA[an]));

    CALL(MACSEC_SAGetNextPN(secy.txSA[an], &txPN));
    CALL(MACSEC_SAGetNextPN(secy.rxSA[an], &rxPN));

    CALL(MACSEC_SADisable(secy.txSA[an]));
    CALL(MACSEC_SADisable(secy.rxSA[an]));

    CALL(MACSEC_DeleteSA(secy.txSA[an]));
    CALL(MACSEC_DeleteSA(secy.rxSA[an]));

    CALL(MACSEC_RemoveSecYLookupRule(secy.ruleHandle));
    CALL(MACSEC_RemoveSecYLookupRule(secy.ruleHandle1));

    CALL(MACSEC_DeleteTxSC(secy.secYHandle, &secy.txSCI));
    CALL(MACSEC_DeleteRxSC(secy.secYHandle, &secy.rxSCI[0]));

    CALL(MACSEC_DeleteSecY(secy.secYHandle));
    CALL(MACSEC_DeInit(aID));
err_exit:
    return retVal;
}

int32_t MACSEC_QtMultiVPort(MACSEC_HwIDType aID)
{
    int32_t retVal = BCM_ERR_OK;
    const MACSEC_KeyType *key = NULL;
    uint32_t i;

    MACSEC_CfgType  config = {
        .speed = MACSEC_MACSPEED_1000MBPS,
        .checkKaY = FALSE,
        .enableQtagParse = FALSE,
    };
    MACSEC_QtSecY secy0 = {
        .cfg = {
            .includeSCI = TRUE,
            .preSecTagAuthLen = 12U,
            .preSecTagAuthStart = 0U,
            .secTagOffset = 12U,
            .xpnEnable = FALSE,
        },
    };
    MACSEC_QtSecY secy1 = {
        .cfg = {
            .includeSCI = TRUE,
            .preSecTagAuthLen = 12U,
            .preSecTagAuthStart = 0U,
            .secTagOffset = 12U,
            .xpnEnable = FALSE,
        },
    };
    uint32_t nextPN = 0UL;

    BCM_MemSet(&secy0.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));

    /* Match macDa and ethtype */
    BCM_MemCpy(&secy0.rule.macDA, &MACSEC_QtTestData[0], 6UL);
    secy0.rule.frameData[0] = (MACSEC_QtTestData[12] | MACSEC_QtTestData[13] << 8 |
        MACSEC_QtTestData[14] << 16 | MACSEC_QtTestData[15] << 24);

    memset(&secy0.rule.matchMacDAMask, 0xFF, sizeof(secy0.rule.matchMacDAMask));
    secy0.rule.matchFrameDataMask[0] = 0xFFFFFFFF;
    secy0.rule.dir = MACSEC_RULE_DIR_EGRESS;

    BCM_MemSet(&secy1.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));
    BCM_MemCpy(&secy1.rule.macDA, MACSEC_QtMacDA1, sizeof(MACSEC_QtMacDA0));
    BCM_MemCpy(&secy1.rule.macSA, MACSEC_QtMacSA1, sizeof(MACSEC_QtMacDA0));

    /* match DA and SA both */
    memset(&secy1.rule.matchMacDAMask, 0xFF, sizeof(secy1.rule.matchMacDAMask));
    memset(&secy1.rule.matchMacSAMask, 0xFF, sizeof(secy1.rule.matchMacDAMask));
    secy1.rule.dir = MACSEC_RULE_DIR_EGRESS;

    CALL(MACSEC_Init(aID, &config));

    CALL(MACSEC_CreateSecY(aID, &secy0.cfg, &secy0.secYHandle));
    CALL(MACSEC_CreateSecY(aID, &secy1.cfg, &secy1.secYHandle));

    CALL(MACSEC_SetCipherSuite(secy0.secYHandle, MACSEC_CIPHERID_GCM_AES_128, MACSEC_CONF_OFFSET_0));
    CALL(MACSEC_SetCipherSuite(secy1.secYHandle, MACSEC_CIPHERID_GCM_AES_128, MACSEC_CONF_OFFSET_0));

    BCM_MemCpy(&secy0.txSCI, &MACSEC_QtSCI0 , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateTxSC(secy0.secYHandle, &secy0.txSCI));

    BCM_MemCpy(&secy1.txSCI, &MACSEC_QtSCI1 , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateTxSC(secy1.secYHandle, &secy1.txSCI));

    CALL(MACSEC_AddSecYLookupRule(secy0.secYHandle, &secy0.rule, &secy0.ruleHandle));
    CALL(MACSEC_AddSecYLookupRule(secy1.secYHandle, &secy1.rule, &secy1.ruleHandle));

    /* interate over all AN's */
    for (i = 0UL; i <= MACSEC_AN_MAX; i++) {
        key = &MACSEC_AES128Keys[i];
        CALL(MACSEC_CreateTxSA(secy0.secYHandle, i, nextPN, &secy0.txSCI, 0UL, TRUE, key,
                               &secy0.txSA[i]));

        CALL(MACSEC_CreateTxSA(secy1.secYHandle, i, nextPN, &secy1.txSCI, 0UL, TRUE, key,
                               &secy1.txSA[i]));

        CALL(MACSEC_SAEnable(secy0.txSA[i]));
        CALL(MACSEC_SAEnable(secy1.txSA[i]));
    }

    for (i = 0UL; i <= MACSEC_AN_MAX; i++) {
        CALL(MACSEC_SADisable(secy0.txSA[i]));
        CALL(MACSEC_SADisable(secy1.txSA[i]));

        CALL(MACSEC_DeleteSA(secy0.txSA[i]));
        CALL(MACSEC_DeleteSA(secy1.txSA[i]));
    }

    CALL(MACSEC_RemoveSecYLookupRule(secy0.ruleHandle));
    CALL(MACSEC_RemoveSecYLookupRule(secy1.ruleHandle));

    CALL(MACSEC_DeleteTxSC(secy0.secYHandle, &secy0.txSCI));
    CALL(MACSEC_DeleteTxSC(secy1.secYHandle, &secy1.txSCI));

    CALL(MACSEC_DeleteSecY(secy0.secYHandle));
    CALL(MACSEC_DeleteSecY(secy1.secYHandle));

    CALL(MACSEC_DeInit(aID));
err_exit:
    return retVal;
}

int32_t MACSEC_QtTestRecv(MACSEC_HwIDType aID, MACSEC_CipherIdType aCipherID,
                                 MACSEC_ConfOffsetType aOffset)
{
    int32_t retVal = BCM_ERR_OK;
    MACSEC_CipherCapType cipherCap;
    const MACSEC_KeyType *key = NULL;

    MACSEC_CfgType  config = {
        .speed = MACSEC_MACSPEED_1000MBPS,
        .checkKaY = FALSE,
        .enableQtagParse = FALSE,
    };
    MACSEC_QtSecY secy = {
        .cfg = {
            .includeSCI = TRUE,
            .preSecTagAuthLen = 12U,
            .preSecTagAuthStart = 0U,
            .secTagOffset = 12U,
            .xpnEnable = FALSE,
        },
    };
    uint32_t an = 0;

    BCM_MemSet(&secy.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));
    BCM_MemCpy(&secy.rule.macDA, MACSEC_QtMacDA0, sizeof(MACSEC_QtMacDA0));
    BCM_MemCpy(&secy.rule.macSA, MACSEC_QtMacSA0, sizeof(MACSEC_QtMacDA0));

    /* match DA and SA both */
    //memset(&secy.rule.matchMacDAMask, 0xFF, sizeof(secy.rule.matchMacDAMask));
    //memset(&secy.rule.matchMacSAMask, 0xFF, sizeof(secy.rule.matchMacDAMask));
    secy.rule.macSecTagged = TRUE;
    secy.rule.dir = MACSEC_RULE_DIR_INGRESS;

    switch (aCipherID) {
        case MACSEC_CIPHERID_GCM_AES_128:
            key = &MACSEC_AES128Key0;
            break;
        case MACSEC_CIPHERID_GCM_AES_256:
            key = &MACSEC_QtKeyAES256;
            break;
        case MACSEC_CIPHERID_GCM_AES_XPN_128:
            BCM_MemCpy(&secy.rxSSCI[0], MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            secy.cfg.xpnEnable = TRUE;
            key = &MACSEC_AES128Key0;
            break;
        case MACSEC_CIPHERID_GCM_AES_XPN_256:
            secy.cfg.xpnEnable = TRUE;
            BCM_MemCpy(&secy.rxSSCI[0], MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            key = &MACSEC_QtKeyAES256;
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            goto err_exit;
    }

    CALL(MACSEC_Init(aID, &config));
    CALL(MACSEC_CreateSecY(aID, &secy.cfg, &secy.secYHandle));
    CALL(MACSEC_GetCipherCap(aID, aCipherID, &cipherCap));
    CALL(MACSEC_SetCipherSuite(secy.secYHandle, aCipherID, aOffset));

    BCM_MemCpy(&secy.rxSCI[0U], &MACSEC_QtSCI0 , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateRxSC(secy.secYHandle, &secy.rxSCI[0UL]));
    if (TRUE == secy.cfg.xpnEnable) {
        CALL(MACSEC_CreateRxSA(secy.secYHandle, an, 0x1UL, &secy.rxSCI[0],
                               secy.rxSSCI[0], key, &secy.rxSA[an]));
    } else {
        CALL(MACSEC_CreateRxSA(secy.secYHandle, an, 0x1UL, &secy.rxSCI[0],
                               0UL, key, &secy.rxSA[an]));
    }

    CALL(MACSEC_AddSecYLookupRule(secy.secYHandle, &secy.rule, &secy.ruleHandle));
    CALL(MACSEC_SAEnable(secy.rxSA[an]));

    CALL(MACSEC_SADisable(secy.rxSA[0]));
    CALL(MACSEC_DeleteSA(secy.rxSA[0]));

    CALL(MACSEC_RemoveSecYLookupRule(secy.ruleHandle));
    CALL(MACSEC_DeleteRxSC(secy.secYHandle, &secy.rxSCI[0]));
    CALL(MACSEC_DeleteSecY(secy.secYHandle));
    CALL(MACSEC_DeInit(aID));
err_exit:
    return retVal;
}

int32_t MACSEC_QtProtectFrame(MACSEC_HwIDType aID, MACSEC_CipherIdType aCipherID,
                                     uint32_t aConf, MACSEC_ANType aAN)
{
    int32_t retVal = BCM_ERR_OK;
    MACSEC_CipherCapType cipherCap;
    const MACSEC_KeyType *key = NULL;

    MACSEC_CfgType  config = {
        .speed = MACSEC_MACSPEED_1000MBPS,
        .checkKaY = FALSE,
        .enableQtagParse = FALSE,
    };
    MACSEC_QtSecY secy = {
        .cfg = {
            .includeSCI = TRUE,
            .preSecTagAuthLen = 12U,
            .preSecTagAuthStart = 0U,
            .secTagOffset = 12U,
            .xpnEnable = FALSE,
        },
    };

    BCM_MemSet(&secy.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));
    BCM_MemCpy(&secy.rule.macDA, MACSEC_QtMacDA0, sizeof(MACSEC_QtMacDA0));
    BCM_MemCpy(&secy.rule.macSA, MACSEC_QtMacSA0, sizeof(MACSEC_QtMacDA0));

    /* match DA and SA both */
    memset(&secy.rule.matchMacDAMask, 0xFF, sizeof(secy.rule.matchMacDAMask));
    memset(&secy.rule.matchMacSAMask, 0xFF, sizeof(secy.rule.matchMacDAMask));
    secy.rule.dir = MACSEC_RULE_DIR_EGRESS;

    switch (aCipherID) {
        case MACSEC_CIPHERID_GCM_AES_128:
            key = &MACSEC_AES128Key0;
            break;
        case MACSEC_CIPHERID_GCM_AES_256:
            key = &MACSEC_QtKeyAES256;
            break;
        case MACSEC_CIPHERID_GCM_AES_XPN_128:
            BCM_MemCpy(&secy.txSSCI, MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            secy.cfg.xpnEnable = TRUE;
            key = &MACSEC_AES128Key0;
            break;
        case MACSEC_CIPHERID_GCM_AES_XPN_256:
            secy.cfg.xpnEnable = TRUE;
            BCM_MemCpy(&secy.txSSCI, MACSEC_QtSSCI, sizeof(MACSEC_QtSSCI));
            key = &MACSEC_QtKeyAES256;
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            goto err_exit;
    }

    CALL(MACSEC_Init(aID, &config));
    CALL(MACSEC_CreateSecY(aID, &secy.cfg, &secy.secYHandle));
    CALL(MACSEC_GetCipherCap(aID, aCipherID, &cipherCap));
    CALL(MACSEC_SetCipherSuite(secy.secYHandle, aCipherID, MACSEC_CONF_OFFSET_0));

    BCM_MemCpy(&secy.txSCI, &MACSEC_QtSCI0 , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateTxSC(secy.secYHandle, &secy.txSCI));

    if (TRUE == secy.cfg.xpnEnable) {
        CALL(MACSEC_CreateTxSA(secy.secYHandle, aAN, 0x8932D611UL, &secy.txSCI, secy.txSSCI, aConf,
                               key, &secy.txSA[aAN]));
    } else {
        CALL(MACSEC_CreateTxSA(secy.secYHandle, aAN, 0x8932D611UL, &secy.txSCI, 0UL, aConf, key,
                               &secy.txSA[aAN]));
    }
    CALL(MACSEC_AddSecYLookupRule(secy.secYHandle, &secy.rule, &secy.ruleHandle));
    CALL(MACSEC_SAEnable(secy.txSA[aAN]));

    CALL(MACSEC_SADisable(secy.txSA[aAN]));
    CALL(MACSEC_DeleteSA(secy.txSA[aAN]));

    CALL(MACSEC_RemoveSecYLookupRule(secy.ruleHandle));
    CALL(MACSEC_DeleteTxSC(secy.secYHandle, &secy.txSCI));
    CALL(MACSEC_DeleteSecY(secy.secYHandle));
    CALL(MACSEC_DeInit(aID));

err_exit:
    return retVal;
}

int32_t MACSEC_TestSASwitch(MACSEC_HwIDType aID)
{
    int32_t retVal = BCM_ERR_OK;
    MACSEC_CipherCapType cipherCap;
    const MACSEC_KeyType *key;
    uint64_t nextPN = 0ULL;
    uint32_t i;

    MACSEC_CfgType  config = {
        .speed = MACSEC_MACSPEED_1000MBPS,
        .checkKaY = FALSE,
        .enableQtagParse = FALSE,
    };

    MACSEC_QtSecY secy = {
        .cfg = {
            .includeSCI = TRUE,
            .preSecTagAuthLen = 12U,
            .preSecTagAuthStart = 0U,
            .secTagOffset = 12U,
            .xpnEnable = FALSE,
        },
    };

    BCM_MemSet(&secy.rule, 0x0U, sizeof(MACSEC_RuleOpt1Type));
    BCM_MemCpy(&secy.rule.macDA, MACSEC_QtMacDA0, sizeof(MACSEC_QtMacDA0));
    BCM_MemCpy(&secy.rule.macSA, MACSEC_QtMacSA0, sizeof(MACSEC_QtMacDA0));

    /* match DA and SA both */
    memset(&secy.rule.matchMacDAMask, 0xFF, sizeof(secy.rule.matchMacDAMask));
    memset(&secy.rule.matchMacSAMask, 0xFF, sizeof(secy.rule.matchMacDAMask));
    secy.rule.dir = MACSEC_RULE_DIR_EGRESS;

    CALL(MACSEC_Init(aID, &config));
    CALL(MACSEC_CreateSecY(aID, &secy.cfg, &secy.secYHandle));
    CALL(MACSEC_GetCipherCap(aID, MACSEC_DEF_CIPHER, &cipherCap));
    CALL(MACSEC_SetCipherSuite(secy.secYHandle, MACSEC_DEF_CIPHER, MACSEC_CONF_OFFSET_0));

    BCM_MemCpy(&secy.txSCI, &MACSEC_QtSCI0 , sizeof(MACSEC_SCIType));
    CALL(MACSEC_CreateTxSC(secy.secYHandle, &secy.txSCI));

    CALL(MACSEC_AddSecYLookupRule(secy.secYHandle, &secy.rule, &secy.ruleHandle));

    /* interate over all AN's */
    for (i = 0UL; i <= MACSEC_AN_MAX; i++) {
        key = &MACSEC_AES128Keys[i];
        CALL(MACSEC_CreateTxSA(secy.secYHandle, i, nextPN, &secy.txSCI, 0UL, TRUE, key,
                               &secy.txSA[i]));
        CALL(MACSEC_SAEnable(secy.txSA[i]));
    }

    for (i = 0UL; i <= MACSEC_AN_MAX; i++) {
        CALL(MACSEC_SADisable(secy.txSA[i]));
        CALL(MACSEC_DeleteSA(secy.txSA[i]));
    }

    /* roll-back to AN 0 again */
    key = &MACSEC_AES128Keys[0];
    CALL(MACSEC_CreateTxSA(secy.secYHandle, 0, 0, &secy.txSCI, 0UL, TRUE, key,
                           &secy.txSA[0]));

    CALL(MACSEC_SAEnable(secy.txSA[0]));

    CALL(MACSEC_SADisable(secy.txSA[0]));
    CALL(MACSEC_DeleteSA(secy.txSA[0]));

    CALL(MACSEC_RemoveSecYLookupRule(secy.ruleHandle));
    CALL(MACSEC_DeleteTxSC(secy.secYHandle, &secy.txSCI));
    CALL(MACSEC_DeleteSecY(secy.secYHandle));
    CALL(MACSEC_DeInit(aID));
err_exit:
    return retVal;
}

static void MACSEC_TestIT1(void)
{
    int32_t retVal;

    /* control packet (bypass) + MACSec Flow */
    EXECUTE_TEST(MACSEC_IT2, MACSEC_QtCPRules(MACSEC_PORT_ID), BCM_ERR_OK);
    /* control packet (bypass) + MACSec Flow */
    EXECUTE_TEST(MACSEC_IT2, MACSEC_QtCPRules(MACSEC_PORT_ID), BCM_ERR_OK);

    /* integrity only test */
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtTestRecv(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_128,
                                               MACSEC_CONF_OFFSET_0), BCM_ERR_OK);

    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_128,
                                                   FALSE, MACSEC_AN3), BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_256,
                                                  FALSE, MACSEC_AN3), BCM_ERR_OK);

    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_XPN_128,
                                                  FALSE, MACSEC_AN3), BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_XPN_256,
                                                  FALSE, MACSEC_AN3), BCM_ERR_OK);
    /* integrity + confidentiality test */
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_128,
                                                   TRUE, MACSEC_AN3), BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_256,
                                                  TRUE, MACSEC_AN3), BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_XPN_128,
                                                  TRUE, MACSEC_AN3), BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtProtectFrame(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_XPN_256,
                                                  TRUE, MACSEC_AN3), BCM_ERR_OK);

    /* SA switching */
    EXECUTE_TEST(MACSEC_IT1, MACSEC_TestSASwitch(MACSEC_PORT_ID), BCM_ERR_OK);

    /* Multiple virtual ports (2 parallel SecY flows) */
    EXECUTE_TEST(MACSEC_IT1, MACSEC_QtMultiVPort(MACSEC_PORT_ID), BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_FlowTxRx(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_128),
                                             BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_FlowTxRx(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_256),
                                             BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_FlowTxRx(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_XPN_128),
                                             BCM_ERR_OK);
    EXECUTE_TEST(MACSEC_IT1, MACSEC_FlowTxRx(MACSEC_PORT_ID, MACSEC_CIPHERID_GCM_AES_XPN_256),
                                             BCM_ERR_OK);
}

TASK(MACSECQT_Task)
{
    BCM_TestStart(BCM_MSC_ID);
    BCM_SetTestSeq(MACSEC_QtIdx);
    MACSEC_QtErrCnt = 0;

    MACSEC_QtResult = BCM_ERR_OK;

    if (MACSEC_IT1 == MACSEC_QtIdx) {
        MACSEC_TestIT1();
    } else if (MACSEC_IT2 == MACSEC_QtIdx) {
    } else if (MACSEC_IT3 == MACSEC_QtIdx) {
    } else {
        MACSEC_QtState = BCM_ERR_UNKNOWN;
    }

    (void)BCM_TerminateTask();
}

static int32_t MACSEC_ExecuteQtInternal(uint32_t aIndex)
{
    int32_t retVal = BCM_ERR_OK;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;
    TaskStateRefType taskStatePtr;
    taskStatePtr = &taskState;

    switch (aIndex) {
    case MACSEC_IT1:
    case MACSEC_IT2:
    case MACSEC_IT3:
        retOS = GetTaskState(MACSECQT_Task, taskStatePtr);
        if (BCM_ERR_OK == retOS) {
            if (SUSPENDED == taskState) {
                MACSEC_QtState = BCM_AT_EXECUTING;
                MACSEC_QtIdx = aIndex;
                retVal = BCM_ActivateTask(MACSECQT_Task);
                if (BCM_ERR_OK != retVal) {
                    retVal = BCM_AT_NOT_STARTED;
                    MACSEC_QtState = BCM_AT_NOT_STARTED;
                    ULOG_ERR("MACSECQT_Task activation failed, error: %d\n\r", retVal);
                }
            } else {
                retVal = BCM_AT_EXECUTING;
                ULOG_ERR("MACSECQT_Task is already running \n\r");
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            ULOG_ERR("GetTaskState MACSECQT_Task failed Error: %d\n\r", retOS);
        }
        break;
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return retVal;
}

int32_t MACSEC_ExecuteQt(uint32_t aTestIdx)
{
    return MACSEC_ExecuteQtInternal(aTestIdx);
}

static int32_t MACSEC_GetStatusQtInternal(uint32_t aIndex)
{
    int32_t retVal;

    switch (aIndex) {
    case MACSEC_IT1:
    case MACSEC_IT2:
    case MACSEC_IT3:
        if (aIndex == MACSEC_QtIdx) {
            retVal = MACSEC_QtState;
        } else {
            retVal = BCM_AT_NOT_AVAILABLE;
        }
        break;
    default:
        retVal = BCM_AT_NOT_AVAILABLE;
        break;
    }

    return retVal;
}

int32_t MACSEC_GetStatusQt(uint32_t aTestIdx)
{
    return MACSEC_GetStatusQtInternal(aTestIdx);
}
