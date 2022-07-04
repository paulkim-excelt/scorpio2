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

#include "ee.h"
#include <string.h>
#include <mcu.h>
#include <ulog.h>
#include <bcm_err.h>
#include <bcm_test.h>
#include <bcm_utils.h>
#include <bcm_time.h>
#include <shell.h>
#include <bcm_osil.h>
#include <mdio.h>
#include <svc.h>

#define GetModuleLogLevel()         (ULOG_LVL_ERROR)
#define MDIOTEST_MDIO_HWID          (1U)
#define MDIO_TX_IT1                 (1UL)
#define MDIO_CNTLRIOCMD_MDIO_INIT                 (0UL)   /**< @brief MDIO IO command - MDIO Init */
#define MDIO_CNTLRIOCMD_DEINIT                    (1UL)   /**< @brief MDIO IO command - MDIO DeInit */
#define MDIO_CNTLRIOCMD_MDIO_READ                 (2UL)   /**< @brief MDIO IO command - MDIO Read */
#define MDIO_CNTLRIOCMD_MDIO_WRITE                (3UL)   /**< @brief MDIO IO command - MDIO Write */


typedef struct sMDIO_IOType {
    int32_t retVal;                           /**< @brief Error value as set by #SVC_TestSvcHandler */
    ETHER_MDIOHwIDType mdioHwID;                   /**< @brief MDIO hardware ID */
    ETHER_MDIOPktType *mdioPkt;                    /**< @brief MDIO packet */
    MDIO_JobIDType mdioJobId;                 /**< @brief MDIO Job ID */
    const MDIO_CfgType *mdioCfg;              /**< @brief MDIO Configuration array */
    uint32_t  mdioCfgCnt;                     /**< @brief Number of items in MDIO Config array */
} MDIO_IOType;

static MDIO_JobIDType MdioTest_JobID;
static ETHER_MDIOPktType MdioTest_Pkt;
static volatile int32_t MDIO_Status = BCM_AT_NOT_STARTED;
extern int32_t MDIO_GetMdioConfig(const MDIO_CfgType **aCfg, uint32_t *aCount);

void SVC_TestSvcHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO)
{
    int32_t retVal;
    MDIO_IOType *io;
    io = (MDIO_IOType *)aSysIO;
    switch(aCmd) {
        case MDIO_CNTLRIOCMD_MDIO_INIT :
            if ((NULL != io->mdioCfg) && (0UL != io->mdioCfgCnt)) {
                for (uint32_t i = 0; i < io->mdioCfgCnt; i++) {
                    MDIO_Init(i, &io->mdioCfg[i]);
                }
            }
            break;
        case MDIO_CNTLRIOCMD_DEINIT :
            if ((NULL != io->mdioCfg) && (0UL != io->mdioCfgCnt)) {
                for (uint32_t i = 0; i < io->mdioCfgCnt; i++) {
                    MDIO_DeInit(i);
                }
            }
            break;
        case MDIO_CNTLRIOCMD_MDIO_READ :
            retVal = MDIO_Read(io->mdioHwID, io->mdioPkt, &io->mdioJobId);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("MDIO_Read retVal:%d\n", retVal);
            }
            break;
        case MDIO_CNTLRIOCMD_MDIO_WRITE :
            retVal = MDIO_Write(io->mdioHwID, io->mdioPkt, &io->mdioJobId);
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("MDIO_Write retVal:%d\n", retVal);
            }
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            if (BCM_ERR_OK != retVal) {
                ULOG_ERR("SVC_TestSvcHandler retVal:%d\n", retVal);
            }
            break;
    }
}

static int32_t MdioTest_Read(ETHER_MDIOHwIDType aID, ETHER_MDIOPktType *aPkt)
{
    MDIO_IOType mdioIO;
    int32_t retVal;

    mdioIO.retVal = BCM_ERR_UNKNOWN;
    mdioIO.mdioHwID = aID;
    mdioIO.mdioPkt = aPkt;

    retVal = SVC_RunTestSvc(MDIO_CNTLRIOCMD_MDIO_READ, (uint8_t *)&mdioIO);
    if (BCM_ERR_OK == retVal) {
        MdioTest_JobID = mdioIO.mdioJobId;
    }
    return retVal;
}

static int32_t MdioTest_Write(ETHER_MDIOHwIDType aID, ETHER_MDIOPktType *aPkt)
{
    MDIO_IOType mdioIO;
    int32_t retVal;

    mdioIO.retVal = BCM_ERR_UNKNOWN;
    mdioIO.mdioHwID = aID;
    mdioIO.mdioPkt = aPkt;

    retVal = SVC_RunTestSvc(MDIO_CNTLRIOCMD_MDIO_WRITE, (uint8_t *)&mdioIO);
    if (BCM_ERR_OK == retVal) {
        MdioTest_JobID = mdioIO.mdioJobId;
    }
    return retVal;
}

TASK(TaskMdioTest)
{
    int32_t retVal;
    uint16_t val;

    MdioTest_Pkt.slaveAddr = 0x1U;
    MdioTest_Pkt.deviceType = 0x1;
    MdioTest_Pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    MdioTest_Pkt.regAddr = 0x0834;
    MdioTest_Pkt.regData = 0xFFFF;

    /* Initialize MDIO driver */
    MDIO_CfgType mdioCfg[5UL];
    MDIO_IOType mdioIO;
    mdioIO.retVal = BCM_ERR_UNKNOWN;
    mdioIO.mdioHwID = MDIOTEST_MDIO_HWID;
    mdioIO.mdioCfg = NULL;
    mdioIO.mdioCfgCnt = 0UL;
    retVal = MDIO_GetMdioConfig(&mdioIO.mdioCfg, &mdioIO.mdioCfgCnt);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("MDIO_GetMdioConfig retVal:%d\n", retVal);
        goto err;
    }
    BCM_MemCpy(mdioCfg, mdioIO.mdioCfg, sizeof(MDIO_CfgType)*mdioIO.mdioCfgCnt);
    for (uint32_t i = 0; i < mdioIO.mdioCfgCnt; i++) {
        mdioCfg[i].isSync = TRUE;
    }
    mdioIO.mdioCfg = mdioCfg;
    SVC_RunTestSvc(MDIO_CNTLRIOCMD_MDIO_INIT, (uint8_t *)&mdioIO);
    retVal = MdioTest_Read(MDIOTEST_MDIO_HWID, &MdioTest_Pkt);
    if ((BCM_ERR_OK != retVal) || (0xFFFF == MdioTest_Pkt.regData)){
        ULOG_ERR("MDIO_Read retVal:%d\n", retVal);
        goto err;
    }

    val = MdioTest_Pkt.regData;
    ULOG_ERR("MDIO_Read successful, addr:0x%x val:0x%x\n", MdioTest_Pkt.regAddr, val);

    val ^= (1 << 14);
    MdioTest_Pkt.regData = val;
    ULOG_ERR("Trying to change it to 0x%x\n", val);

    retVal = MdioTest_Write(MDIOTEST_MDIO_HWID, &MdioTest_Pkt);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("MDIO_Write retVal:%d\n", retVal);
        goto err;
    }

    MdioTest_Pkt.regData = 0xFFFF;
    retVal = MdioTest_Read(MDIOTEST_MDIO_HWID, &MdioTest_Pkt);
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("MDIO_Read retVal:%d\n", retVal);
        goto err;
    }
    if (val != MdioTest_Pkt.regData) {
        ULOG_ERR("Data mismatch, read:0x%x expected0x%x", MdioTest_Pkt.regData, val);
        retVal = BCM_ERR_DATA_INTEG;
        goto err;
    } else {
        ULOG_ERR("Success: Read data matches written data!\n");
    }

    /* Deinitialize Mdio driver */
    SVC_RunTestSvc(MDIO_CNTLRIOCMD_DEINIT, (uint8_t *)&mdioIO);

err:
    MDIO_Status = retVal;
    retVal = BCM_TerminateTask();
    if (BCM_ERR_OK != retVal) {
        ULOG_ERR("%s Failed to terminate the task, err:%d", __func__, retVal);
    }
}

int32_t EthIT1_GetResult(void)
{
    return MDIO_Status;
}


int32_t BCM_ExecuteAT(uint32_t aIndex)
{
    int32_t ret;
    StatusType retOS = E_OK;
    TaskStateType taskState = SUSPENDED;

    switch(aIndex)
    {
    case MDIO_TX_IT1:
        retOS = GetTaskState(TaskMdioTest, &taskState);
        if (E_OK == retOS) {
            if (SUSPENDED == taskState) {
                if (BCM_AT_EXECUTING != MDIO_Status) {
                    MDIO_Status = BCM_AT_EXECUTING;
                    ret = BCM_ActivateTask(TaskMdioTest);
                    if (BCM_ERR_OK != ret) {
                        MDIO_Status = BCM_AT_NOT_STARTED;
                        ULOG_ERR("Task activation failed, error: %d\n",
                                ret);
                    }
                }
                ret = BCM_ERR_OK;
            } else {
                MDIO_Status = BCM_AT_EXECUTING;
                ULOG_ERR("Test is already running\n");
                ret = BCM_ERR_OK;
            }
        } else {
            ULOG_ERR("Get Task state failed, error: %d\n",BCM_ERR_UNKNOWN);
            ret = BCM_ERR_UNKNOWN;
        }
        break;
    default:
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}

int32_t BCM_GetResultAT(uint32_t aIndex)
{
    int32_t ret;

    switch(aIndex)
    {
    case MDIO_TX_IT1:
        ret = EthIT1_GetResult();
        break;
    default:
        ret = BCM_AT_NOT_AVAILABLE;
    }

    return ret;
}
