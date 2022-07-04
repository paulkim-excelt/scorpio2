/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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
    @defgroup grp_mdiodrv_impl MDIO Driver
    @ingroup grp_mdiodrv

    @addtogroup grp_mdiodrv_impl
    @{
    @file mdio.c
    @brief MDIO driver implementation.
    This source file implements mdio driver.

*/
#include <string.h>
#include <bcm_err.h>
#include <interrupt.h>
#include <bcm_utils.h>
#include <bcm_time.h>
#include <mcu.h>
#include <mcu_clk.h>
#include <mdio.h>
#include <mdio_osil.h>
#include <lw_queue.h>
#include <mdio_rdb.h>
#include <atomic.h>

/**
  @name Implementation IDs
  @{
  @brief MDIO internal functions IDs for error reporting
*/
#define BRCM_SWDSGN_MDIO_STATUS_TYPE               (0xB101U)    /**< @brief #MDIO_StateType         */
#define BRCM_SWDSGN_MDIO_JOB_TYPE                  (0xB102U)    /**< @brief #MDIO_JobType           */
#define BRCM_SWDSGN_MDIO_JOBSTATE_TYPE             (0xB103U)    /**< @brief #MDIO_JobStateType      */
#define BRCM_SWDSGN_MDIO_CLIENT_JOBID_TYPE         (0xB104U)    /**< @brief #MDIO_Client_JobIDType  */
#define BRCM_SWDSGN_MDIO_JOBINFO_TYPE              (0xB105U)    /**< @brief #MDIO_JobInfoType       */
#define BRCM_SWDSGN_MDIO_RWDEV_TYPE                (0xB106U)    /**< @brief #MDIO_RWDevType         */
#define BRCM_SWDSGN_MDIO_JOBHNDLRSTATE_TYPE        (0xB107U)    /**< @brief #MDIO_JobHndlrStateType */
#define BRCM_SWDSGN_MDIO_CURRJOBINFO_TYPE          (0xB108U)    /**< @brief #MDIO_CurrJobInfoType   */
#define BRCM_SWDSGN_MDIO_WRITESTATE_TYPE           (0xB109U)    /**< @brief #MDIO_WriteStateType    */
#define BRCM_SWDSGN_MDIO_READSTATE_TYPE            (0xB10AU)    /**< @brief #MDIO_ReadStateType     */
#define BRCM_SWDSGN_MDIO_TIMERCMD_GLOBAL           (0xB10BU)    /**< @brief #MDIO_TimerCmd          */
#define BRCM_SWDSGN_MDIO_TIMERSTATE_GLOBAL         (0xB10CU)    /**< @brief #MDIO_TimerState        */
#define BRCM_SWDSGN_MDIO_CURRJOBINFO_GLOBAL        (0xB10DU)    /**< @brief #MDIO_CurrJobInfo       */
#define BRCM_SWDSGN_MDIO_RWDEV_GLOBAL              (0xB10EU)    /**< @brief #MDIO_RWDev             */
#define BRCM_SWDSGN_MDIO_REGS_GLOBAL               (0xB10FU)    /**< @brief #MDIO_Regs              */
#define BRCM_SWDSGN_MDIO_DRVREPORTERROR_PROC       (0xB110U)    /**< @brief #MDIO_ReportError       */
#define BRCM_SWDSGN_MDIO_CHECKSTATUS_PROC          (0xB111U)    /**< @brief #MDIO_CheckStatus       */
#define BRCM_SWDSGN_MDIO_INIT_PROC                 (0xB112U)    /**< @brief #MDIO_Init              */
#define BRCM_SWDSGN_MDIO_DEINIT_PROC               (0xB113U)    /**< @brief #MDIO_DeInit            */
#define BRCM_SWDSGN_MDIO_WRITESTATEHANDLER_PROC    (0xB114U)    /**< @brief #MDIO_WriteStateHandler */
#define BRCM_SWDSGN_MDIO_READSTATEHANDLER_PROC     (0xB115U)    /**< @brief #MDIO_ReadStateHandler  */
#define BRCM_SWDSGN_MDIO_INTSTATEHANDLER_PROC      (0xB116U)    /**< @brief #MDIO_IntStateHandler   */
#define BRCM_SWDSGN_MDIO_GETJOBRESULT_PROC         (0xB117U)    /**< @brief #MDIO_GetJobResult      */
#define BRCM_SWDSGN_MDIO_WRITE_PROC                (0xB118U)    /**< @brief #MDIO_Write             */
#define BRCM_SWDSGN_MDIO_READ_PROC                 (0xB119U)    /**< @brief #MDIO_Read              */
#define BRCM_SWDSGN_MDIO_STATEHANDLER_PROC         (0xB11AU)    /**< @brief #MDIO_StateHandler      */
#define BRCM_SWDSGN_MDIO_GETCNTLRINFO_PROC         (0xB11BU)    /**< @brief #MDIO_GetInfo           */
#define BRCM_SWDSGN_MDIO_QUEUEJOB_PROC             (0xB11CU)    /**< @brief #MDIO_QueueJob          */
#define BRCM_SWDSGN_MDIO_CL22XFER_PROC             (0xB11DU)    /**< @brief #MDIO_CL22Xfer          */
#define BRCM_SWDSGN_MDIO_CL45XFER_PROC             (0xB11EU)    /**< @brief #MDIO_CL45Xfer          */
#define BRCM_SWDSGN_MDIO_GETJOBQFREELEN_PROC       (0xB11FU)    /**< @brief #MDIO_GetJobQFreeLen    */
/** @} */


/**
  @{
  @brief MDIO controller state type
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef uint32_t MDIO_StateType;
#define MDIO_STATUS_UNINIT      (0UL)   /**< @brief Controller un-initialised */
#define MDIO_STATUS_INIT        (1UL)   /**< @brief Controller initialised */
/** @} */

/**
  @{
  @brief MDIO job type
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef uint32_t MDIO_JobType;
#define MDIO_JOB_NONE              (0UL)   /**< @brief No job & value must be zero*/
#define MDIO_JOB_READ              (1UL)   /**< @brief Read job */
#define MDIO_JOB_WRITE             (2UL)   /**< @brief Write job */
/** @} */

/**
  @{
  @brief MDIO job state type
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef uint32_t MDIO_JobStateType;
#define MDIO_JOBSTATE_IDLE         (0UL)   /**< @brief No job & Value must be zero*/
#define MDIO_JOBSTATE_QUEUED       (1UL)   /**< @brief Job queued - job waiting
                                             in job processing queue */
#define MDIO_JOBSTATE_PROCESSING   (2UL)   /**< @brief Job processing
                                             in-progress - job currently in
                                             progress and job ID would be in
                                             the front of job queue */
#define MDIO_JOBSTATE_COMPLETE     (3UL)   /**< @brief Job complete - job
                                             completed and waiting for the
                                             query of job result by client */
/** @} */

/**
  @{
  @brief MDIO client job id to controller id shift macro
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_GETJOBRESULT_PROC
  @trace #BRCM_SWREQ_MDIO_OPERATIONS
 */
typedef uint32_t MDIO_Client_JobIDType;
#define MDIO_CLIENT_JOBID_CTRLID_SHIFT      (8UL)
#define MDIO_CLIENT_JOBID_CTRLID_MASK       (0x0F00UL)
#define MDIO_CLIENT_JOBID_DRVJOBID_SHIFT    (0UL)
#define MDIO_CLIENT_JOBID_DRVJOBID_MASK     (0xFUL)
/** @} */

/**
  @{
  @brief MDIO read-write device structure
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_GETJOBRESULT_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef struct sMDIO_JobInfoType {
    MDIO_JobStateType       state;   /**< @brief Slot state */
    MDIO_JobType            jobType; /**< @brief Job type */
    ETHER_MDIOPktType            pkt;     /**< @brief Packet */
} MDIO_JobInfoType;
#define MDIO_JOBINFO_Q_LEN  (LWQ_BUFFER_MAX_LENGTH)
#define MDIO_JOBINFO_INIT       \
{                               \
    .state = MDIO_JOBSTATE_IDLE,\
    .jobType = MDIO_JOB_NONE,   \
    .pkt = {0x0},               \
}
/** @} */

/**
  @brief MDIO read-write device structure
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef struct sMDIO_RWDevType {
    MDIO_StateType             state; /**< @brief Current controller state */
    MDIO_CtlrModeType          mode;  /**< @brief Controller mode - master/slave */
    MDIO_JobInfoType           jobInfo[MDIO_JOBINFO_Q_LEN];  /**< @brief Job info array */
    volatile uint32_t          allocStatus;  /**< @brief Job info array slot
                                             allocation status */
    LWQ_BufferType             jobProcQ;  /**< @brief Queue to hold job IDs of
                                              pending/in-progress jobs */
    MDIO_SyncModeType          isSync;  /**< @brief Mode of operation */
} MDIO_RWDevType;


/**
  @brief MDIO job handler state type
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef uint32_t MDIO_JobHndlrStateType;

/**
  @brief MDIO current job info type
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
typedef struct sMDIO_CurrJobInfoType {
    MDIO_JobType    jobType;
    MDIO_JobHndlrStateType  state;
} MDIO_CurrJobInfoType;

/**
  @{
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWREQ_MDIO_OPERATIONS
 */
typedef uint32_t MDIO_WriteStateType;
#define MDIO_WRITESTATE_NONE                           (0UL)
#define MDIO_WRITESTATE_CL22_XFER_REGVAL               (0x11UL)
#define MDIO_WRITESTATE_CL22_XFER_COMP_WAIT            (0x12UL)
#define MDIO_WRITESTATE_CL45_XFER_REGADDR              (0x13UL)
#define MDIO_WRITESTATE_CL45_XFER_REGADDR_COMP_WAIT    (0x14UL)
#define MDIO_WRITESTATE_CL45_XFER_REGVAL               (0x15UL)
#define MDIO_WRITESTATE_CL45_XFER_REGVAL_COMP_WAIT     (0x16UL)
/** @} */

/**
  @{
  @brief MDIO read state type
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWREQ_MDIO_OPERATIONS
 */
typedef uint32_t MDIO_ReadStateType;
#define MDIO_READSTATE_NONE                            (0UL)
#define MDIO_READSTATE_CL22_READ_REGVAL                (0x21UL)
#define MDIO_READSTATE_CL22_READ_REGVAL_WAIT_COMP      (0x22UL)
#define MDIO_READSTATE_CL45_XFER_REGADDR               (0x23UL)
#define MDIO_READSTATE_CL45_XFER_REGADDR_WAIT_COMP     (0x24UL)
#define MDIO_READSTATE_CL45_READ_REGVAL                (0x25UL)
#define MDIO_READSTATE_CL45_READ_REGVAL_WAIT_COMP      (0x26UL)
/** @} */

/**
  @brief MDIO timer action required
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
static MDIO_TimerCmdType MDIO_TimerCmd COMP_SECTION(".bss.drivers");

/**
  @brief MDIO timer state required
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
static uint32_t MDIO_TimerState COMP_SECTION(".bss.drivers");

/**
  @brief MDIO current job info
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
 */
static MDIO_CurrJobInfoType MDIO_CurrJobInfo[MDIO_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**
  @brief MDIO driver read-write device data
  @trace #BRCM_SWARCH_MDIO_INIT_PROC
  @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
  @trace #BRCM_SWARCH_MDIO_WRITE_PROC
  @trace #BRCM_SWARCH_MDIO_READ_PROC
  @trace #BRCM_SWREQ_MDIO_INIT
*/
static MDIO_RWDevType MDIO_RWDev[MDIO_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**
    @brief MDIO register structure global variable
    @trace #BRCM_SWARCH_MDIO_INIT_PROC
    @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWREQ_MDIO_INIT
 */
static MDIO_RDBType * const MDIO_Regs[MDIO_MAX_HW_ID] =
{
#if (MDIO_MAX_HW_ID == 0)
#error "MDIO_MAX_HW_ID == 0"
#endif
    (MDIO_RDBType *)MDIO_BASE0,
#if (MDIO_MAX_HW_ID > 1)
    (MDIO_RDBType *)MDIO_BASE1,
#endif
#if (MDIO_MAX_HW_ID > 2)
    (MDIO_RDBType *)MDIO_BASE2,
#endif
#if (MDIO_MAX_HW_ID > 3)
#error "MDIO_MAX_HW_ID > 3 is not supported by the driver"
#endif
};

/**
    @brief MDIO report error function

    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWARCH_MDIO_INIT_PROC
    @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
    @trace #BRCM_SWARCH_MDIO_STATEHANDLER_PROC
    @trace #BRCM_SWREQ_MDIO_INIT
 */
static void MDIO_ReportError(uint16_t aCompID, uint32_t aInstanceID,
        uint16_t aApiID, int32_t aErr, uint32_t aVal0, uint32_t aVal1,
        uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(aCompID, (uint8_t)aInstanceID, aApiID, aErr, 4UL, values);
}

/**
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWARCH_MDIO_INIT_PROC
    @trace #BRCM_SWREQ_MDIO_INIT
 */
static int32_t MDIO_CheckStatus(ETHER_MDIOHwIDType aID)
{
    int32_t retVal = BCM_ERR_OK;

    if (MDIO_MAX_HW_ID <= aID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    /* Check the controller state */
    if (MDIO_STATUS_UNINIT == MDIO_RWDev[aID].state) {
        retVal = BCM_ERR_UNINIT;
        goto err;
    }

err:
    return retVal;
}


/**
    @trace #BRCM_SWARCH_MDIO_INIT_PROC
    @trace #BRCM_SWREQ_MDIO_INIT
*/
void MDIO_Init(ETHER_MDIOHwIDType aID,
                const MDIO_CfgType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t regVal;
    uint32_t clkFreq;
    uint32_t clkDiv;
    uint32_t lineNo = __LINE__;

    if ((MDIO_MAX_HW_ID <= aID) || (NULL == aConfig)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        lineNo = __LINE__;
        goto err;
    }

    /* Check the controller state */
    if (MDIO_STATUS_UNINIT != MDIO_RWDev[aID].state) {
        retVal = BCM_ERR_INVAL_STATE;
        lineNo = __LINE__;
        goto err;
    }

    MDIO_RWDev[aID].allocStatus = 0xFFFFUL;
    MDIO_RWDev[aID].jobProcQ = LWQ_BUFFER_INIT_VALUE;
    /* Query MDIO controller clock from MCU */
    clkFreq = MCU_GetClkFreq(MCU_CLK_CFG_ID_MDIO);
    if (0UL == clkFreq) {
        retVal = BCM_ERR_NOSUPPORT;
        lineNo = __LINE__;
        goto err;
    }

    /* Enable 32bit preamble of 1's, as per CL-22 and CL45 protocol */
    regVal = MDIO_CTRL_PRE_MASK;
    if (MDIO_CTRLMODE_MASTER == aConfig->mode) {
        /* On-chip MDIO controller as MDIO bus master */
        regVal |= MDIO_CTRL_EXT_MASK;
    } else {
        /* On-chip MDIO IP acts as slave on MDIO bus, on-chip integrated
         * PHYs could be accessed by external MDIO controller */
        regVal &= ~MDIO_CTRL_EXT_MASK;
        regVal |= MDIO_CTRL_BYP_MASK;
    }
    MDIO_RWDev[aID].mode = aConfig->mode;
    MDIO_RWDev[aID].isSync = aConfig->isSync;

    clkDiv = clkFreq/aConfig->speed;
    if (0UL == (clkDiv & (~MDIO_CTRL_MDCDIV_MASK))) {
        MDIO_Regs[aID]->ctrl = regVal | clkDiv;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
        lineNo = __LINE__;
    }

    if (BCM_ERR_OK == retVal) {
        BCM_MemSet(&MDIO_CurrJobInfo, (uint8_t)0x0U, sizeof(MDIO_CurrJobInfoType));
        MDIO_TimerState = 0x0UL;
        MDIO_TimerCmd = MDIO_TIMERCMD_NONE;
        MDIO_RWDev[aID].state = MDIO_STATUS_INIT;
    }


err:
    if ((BCM_ERR_OK != retVal) && (BCM_ERR_INVAL_STATE != retVal)) {
        MDIO_ReportError(BCM_MIO_ID, aID, BRCM_SWARCH_MDIO_INIT_PROC,
                retVal, 0UL, 0UL, 0UL, lineNo);
    }
    return;
}

/**
    @trace #BRCM_SWARCH_MDIO_DEINIT_PROC
    @trace #BRCM_SWREQ_MDIO_INIT
*/
void MDIO_DeInit(ETHER_MDIOHwIDType aID)
{
    int32_t retVal = BCM_ERR_OK;

    retVal = MDIO_CheckStatus(aID);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_UNINIT != retVal) {
            MDIO_ReportError(BCM_MIO_ID, aID, BRCM_SWARCH_MDIO_DEINIT_PROC,
                    retVal, 0UL, 0UL, 0UL, 0UL);
        }
        goto err;
    }

    MDIO_Regs[aID]->ctrl = 0UL;
    MDIO_TimerCmd = MDIO_TIMERCMD_NONE;
    MDIO_TimerState = 0x0UL;
    BCM_MemSet(&MDIO_CurrJobInfo, (uint8_t)0x0U, sizeof(MDIO_CurrJobInfoType));
    BCM_MemSet(&MDIO_RWDev, (uint8_t)0x0U, sizeof(MDIO_RWDevType));
    MDIO_RWDev[aID].state = MDIO_STATUS_UNINIT;

err:
    return;
}

/**
    @trace #BRCM_SWARCH_MDIO_GETINFO_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
int32_t MDIO_GetInfo(MDIO_TimerCmdType *const aTimerCmd)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aTimerCmd) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aTimerCmd = MDIO_TimerCmd;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
static void MDIO_CL22Xfer(ETHER_MDIOHwIDType aID,
                        uint32_t aOpCode,
                        ETHER_MDIOPktType *const aPkt)
{
    uint32_t regVal;

    regVal = ((1UL << MDIO_CMD_SB_SHIFT) & MDIO_CMD_SB_MASK)
        | ((aOpCode << MDIO_CMD_OP_SHIFT) & MDIO_CMD_OP_MASK)
        | ((((uint32_t)aPkt->slaveAddr) << MDIO_CMD_PA_SHIFT) & MDIO_CMD_PA_MASK)
        | ((((uint32_t)aPkt->regAddr) << MDIO_CMD_RA_SHIFT) & MDIO_CMD_RA_MASK)
        | ((0x2UL << MDIO_CMD_TA_SHIFT) & MDIO_CMD_TA_MASK);

    if (MDIO_CMD_OPCODE_CL22_WRITE == aOpCode) {
        regVal |= (aPkt->regData & MDIO_CMD_MDATA_MASK);
    }
    MDIO_Regs[aID]->cmd = regVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
static void MDIO_CL45Xfer(ETHER_MDIOHwIDType aID,
                        uint32_t aOpCode,
                        ETHER_MDIOPktType *const aPkt)
{
    uint32_t regVal;

    regVal = ((0UL << MDIO_CMD_SB_SHIFT) & MDIO_CMD_SB_MASK)
        | ((aOpCode << MDIO_CMD_OP_SHIFT) & MDIO_CMD_OP_MASK)
        | ((((uint32_t)aPkt->slaveAddr) << MDIO_CMD_PA_SHIFT) & MDIO_CMD_PA_MASK)
        | ((((uint32_t)aPkt->deviceType) << MDIO_CMD_RA_SHIFT) & MDIO_CMD_RA_MASK)
        | ((0x2UL << MDIO_CMD_TA_SHIFT) & MDIO_CMD_TA_MASK);
    if (MDIO_CMD_OPCODE_CL45_WRITE_ADDR == aOpCode) {
        regVal |= (aPkt->regAddr & MDIO_CMD_MDATA_MASK);
    } else if (MDIO_CMD_OPCODE_CL45_WRITE_DATA == aOpCode) {
        regVal |= (aPkt->regData & MDIO_CMD_MDATA_MASK);
    } else {
        /* Do nothing */
    }
    MDIO_Regs[aID]->cmd = regVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
static int32_t MDIO_WriteStateHandler(ETHER_MDIOHwIDType aID,
                             ETHER_MDIOPktType *const aPkt)
{
    int32_t retVal = BCM_ERR_EAGAIN;
    uint32_t regVal;

    if (MDIO_WRITESTATE_NONE == MDIO_CurrJobInfo[aID].state) {
        /* This is very first trigger for the job */
        if (ETHER_MDIOREGACCESS_CL22 == aPkt->regAccMode) {
            MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_CL22_XFER_REGVAL;
        } else if (ETHER_MDIOREGACCESS_CL45 == aPkt->regAccMode) {
            MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_CL45_XFER_REGADDR;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto exit;
        }
    }

    switch (MDIO_CurrJobInfo[aID].state) {
    case MDIO_WRITESTATE_CL22_XFER_REGVAL:
        MDIO_CL22Xfer(aID, MDIO_CMD_OPCODE_CL22_WRITE, aPkt);
        MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_CL22_XFER_COMP_WAIT;
        break;
    case MDIO_WRITESTATE_CL22_XFER_COMP_WAIT:
        regVal = (MDIO_CTRL_BSY_MASK & MDIO_Regs[aID]->ctrl);
        if (0UL == regVal) {
            MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_NONE;
            retVal = BCM_ERR_OK;
        }
        break;
    case MDIO_WRITESTATE_CL45_XFER_REGADDR:
        MDIO_CL45Xfer(aID, MDIO_CMD_OPCODE_CL45_WRITE_ADDR, aPkt);
        MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_CL45_XFER_REGADDR_COMP_WAIT;
        break;
    case MDIO_WRITESTATE_CL45_XFER_REGADDR_COMP_WAIT:
        regVal = (MDIO_CTRL_BSY_MASK & MDIO_Regs[aID]->ctrl);
        if (0UL == regVal) {
            MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_CL45_XFER_REGVAL;
        }
        break;
    case MDIO_WRITESTATE_CL45_XFER_REGVAL:
        MDIO_CL45Xfer(aID, MDIO_CMD_OPCODE_CL45_WRITE_DATA, aPkt);
        MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_CL45_XFER_REGVAL_COMP_WAIT;
        break;
    case MDIO_WRITESTATE_CL45_XFER_REGVAL_COMP_WAIT:
        regVal = (MDIO_CTRL_BSY_MASK & MDIO_Regs[aID]->ctrl);
        if (0UL == regVal) {
            MDIO_CurrJobInfo[aID].state = MDIO_WRITESTATE_NONE;
            retVal = BCM_ERR_OK;
        }
        break;
    default:
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

exit:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
static int32_t MDIO_ReadStateHandler(ETHER_MDIOHwIDType aID,
                            ETHER_MDIOPktType *const aPkt)
{
    int32_t retVal = BCM_ERR_EAGAIN;
    uint32_t regVal;

    if (MDIO_READSTATE_NONE == MDIO_CurrJobInfo[aID].state) {
        /* This is very first trigger for the job */
        if (ETHER_MDIOREGACCESS_CL22 == aPkt->regAccMode) {
            MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_CL22_READ_REGVAL;
        } else if (ETHER_MDIOREGACCESS_CL45 == aPkt->regAccMode) {
            MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_CL45_XFER_REGADDR;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto exit;
        }
    }

    switch (MDIO_CurrJobInfo[aID].state) {
    case MDIO_READSTATE_CL22_READ_REGVAL:
        MDIO_CL22Xfer(aID, MDIO_CMD_OPCODE_CL22_READ, aPkt);
        MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_CL22_READ_REGVAL_WAIT_COMP;
        break;
    case MDIO_READSTATE_CL22_READ_REGVAL_WAIT_COMP:
        regVal = (MDIO_CTRL_BSY_MASK & MDIO_Regs[aID]->ctrl);
        if (0UL == regVal) {
            aPkt->regData = ((uint16_t)(MDIO_Regs[aID]->cmd
                        & MDIO_CMD_MDATA_MASK));
            MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_NONE;
            retVal = BCM_ERR_OK;
        }
        break;
    case MDIO_READSTATE_CL45_XFER_REGADDR:
        MDIO_CL45Xfer(aID, MDIO_CMD_OPCODE_CL45_WRITE_ADDR, aPkt);
        MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_CL45_XFER_REGADDR_WAIT_COMP;
        break;
    case MDIO_READSTATE_CL45_XFER_REGADDR_WAIT_COMP:
        regVal = (MDIO_CTRL_BSY_MASK & MDIO_Regs[aID]->ctrl);
        if (0UL == regVal) {
            MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_CL45_READ_REGVAL;
        }
        break;
    case MDIO_READSTATE_CL45_READ_REGVAL:
        MDIO_CL45Xfer(aID, MDIO_CMD_OPCODE_CL45_READ, aPkt);
        MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_CL45_READ_REGVAL_WAIT_COMP;
        break;
    case MDIO_READSTATE_CL45_READ_REGVAL_WAIT_COMP:
        regVal = (MDIO_CTRL_BSY_MASK & MDIO_Regs[aID]->ctrl);
        if (0UL == regVal) {
            aPkt->regData = ((uint16_t)(MDIO_Regs[aID]->cmd
                        & MDIO_CMD_MDATA_MASK));
            MDIO_CurrJobInfo[aID].state = MDIO_READSTATE_NONE;
            retVal = BCM_ERR_OK;
        }
        break;
    default:
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

exit:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_STATEHANDLER_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
static int32_t MDIO_IntStateHandler(ETHER_MDIOHwIDType aID)
{
    int32_t retVal = BCM_ERR_NOT_FOUND;
    uint8_t jobID;

    if (0UL == LWQ_Length(MDIO_RWDev[aID].jobProcQ)) {
        /* No pending/in-progress job for this controller */
        MDIO_TimerState &= ~(0x1UL << aID);
        if ((0UL == MDIO_TimerState) && (MDIO_TIMERCMD_STOP != MDIO_TimerCmd)) {
            MDIO_TimerCmd = MDIO_TIMERCMD_STOP;
            if(FALSE == MDIO_RWDev[aID].isSync) {
                BCM_SystemHRTimerStop();
            }
        }
        goto err;
    }

    /* Check the job state at the front of the queue */
    jobID = LWQ_PeekFirst(MDIO_RWDev[aID].jobProcQ);

    /* Check the state of job */
    if ((MDIO_JOBSTATE_QUEUED == MDIO_RWDev[aID].jobInfo[jobID].state)
        || (MDIO_JOBSTATE_PROCESSING == MDIO_RWDev[aID].jobInfo[jobID].state)) {
        if (MDIO_JOB_READ == MDIO_RWDev[aID].jobInfo[jobID].jobType) {
            retVal = MDIO_ReadStateHandler(aID,
                                        &(MDIO_RWDev[aID].jobInfo[jobID].pkt));
        } else if (MDIO_JOB_WRITE == MDIO_RWDev[aID].jobInfo[jobID].jobType) {
            retVal = MDIO_WriteStateHandler(aID,
                                        &(MDIO_RWDev[aID].jobInfo[jobID].pkt));
        } else {
            /* Do nothing */
        }

        if (BCM_ERR_EAGAIN == retVal) {
            if (MDIO_JOBSTATE_QUEUED == MDIO_RWDev[aID].jobInfo[jobID].state) {
                MDIO_RWDev[aID].jobInfo[jobID].state = MDIO_JOBSTATE_PROCESSING;
                if ((0x0UL == MDIO_TimerState) && (MDIO_TIMERCMD_START != MDIO_TimerCmd)) {
                    MDIO_TimerCmd = MDIO_TIMERCMD_START;
                    /* Timer running because of following channels */
                    MDIO_TimerState |= 0x1UL << aID;
                    if(FALSE == MDIO_RWDev[aID].isSync) {
                        BCM_SystemHRTimerStart();
                    }
                }
            }
        } else if (BCM_ERR_OK == retVal) {
            (void)LWQ_Pop(&(MDIO_RWDev[aID].jobProcQ), &jobID);
            MDIO_RWDev[aID].jobInfo[jobID].state = MDIO_JOBSTATE_COMPLETE;
        } else {
            /* Do nothing */
        }
    }

err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_GETJOBQFREELEN_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
uint32_t MDIO_GetJobQFreeLen(ETHER_MDIOHwIDType aID)
{
    uint32_t freeLen = 0UL;
    int32_t retVal = MDIO_CheckStatus(aID);
    if (BCM_ERR_OK == retVal) {
        freeLen = MDIO_JOBINFO_Q_LEN - LWQ_Length(MDIO_RWDev[aID].jobProcQ);
    }

    return freeLen;
}
/**
    @trace #BRCM_SWARCH_MDIO_GETJOBRESULT_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS

*/
int32_t MDIO_GetJobResult(ETHER_MDIOHwIDType aID,
                          MDIO_JobIDType aJobID,
                          ETHER_MDIOPktType * const aPkt)
{
    int32_t retVal;
    uint32_t jobID = aJobID & MDIO_CLIENT_JOBID_DRVJOBID_MASK;
    uint32_t ctrlID = (aJobID & MDIO_CLIENT_JOBID_CTRLID_MASK)
                        >> MDIO_CLIENT_JOBID_CTRLID_SHIFT;

    if (MDIO_CTRLMODE_SLAVE == MDIO_RWDev[aID].mode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }

    retVal = MDIO_CheckStatus(aID);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    if ((NULL == aPkt) || (ctrlID != aID)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (MDIO_JOBINFO_Q_LEN <= jobID) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (MDIO_RWDev[aID].jobInfo[jobID].state == MDIO_JOBSTATE_IDLE) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if ((MDIO_RWDev[aID].jobInfo[jobID].state == MDIO_JOBSTATE_QUEUED)
        || (MDIO_RWDev[aID].jobInfo[jobID].state == MDIO_JOBSTATE_PROCESSING)) {
        retVal = BCM_ERR_BUSY;
        goto err;
    }

    BCM_MemCpy(aPkt, &(MDIO_RWDev[aID].jobInfo[jobID].pkt),
            sizeof(ETHER_MDIOPktType));
    MDIO_RWDev[aID].jobInfo[jobID].state = MDIO_JOBSTATE_IDLE;
    ATOMIC_SetBit(&MDIO_RWDev[aID].allocStatus, jobID);
    retVal = BCM_ERR_OK;

err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
static int32_t MDIO_QueueJob(ETHER_MDIOHwIDType aID,
                   ETHER_MDIOPktType *const aPkt,
                   MDIO_JobIDType *const aJobID,
                   MDIO_JobType aJobType)
{
    int32_t retVal;
    uint32_t jobID;

    if ((NULL == aPkt) || (NULL == aJobID)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if ((aPkt->slaveAddr & ~ETHER_MDIOSLAVEADDR_MASK) != 0UL) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (ETHER_MDIOREGACCESS_CL22 == aPkt->regAccMode) {
        if ((aPkt->regAddr & ~ETHER_MDIOREGADDR_CL22_MASK) != 0UL) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto err;
        }
    } else if (ETHER_MDIOREGACCESS_CL45 == aPkt->regAccMode) {
        if ((aPkt->deviceType & ~ETHER_MDIODEVICETYPE_MASK) != 0UL) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto err;
        }
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    jobID = ATOMIC_ClrNGetBit(&MDIO_RWDev[aID].allocStatus);
    if (jobID >= MDIO_JOBINFO_Q_LEN) {
        retVal = BCM_ERR_NOMEM;
        goto err;
    }

    if (MDIO_JOBSTATE_IDLE != MDIO_RWDev[aID].jobInfo[jobID].state) {
        retVal = BCM_ERR_INVAL_STATE;
        goto err;
    }

    retVal = LWQ_Push(&MDIO_RWDev[aID].jobProcQ, (uint8_t)jobID);
    if (BCM_ERR_OK == retVal) {
        *aJobID = (aID << MDIO_CLIENT_JOBID_CTRLID_SHIFT) | jobID;
        MDIO_RWDev[aID].jobInfo[jobID].state = MDIO_JOBSTATE_QUEUED;
        MDIO_RWDev[aID].jobInfo[jobID].jobType = aJobType;
        BCM_MemCpy(&MDIO_RWDev[aID].jobInfo[jobID].pkt, aPkt,
                sizeof(ETHER_MDIOPktType));
    } else {
        ATOMIC_SetBit(&MDIO_RWDev[aID].allocStatus, jobID);
        retVal = BCM_ERR_UNKNOWN;
    }

err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_WRITE_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
*/
int32_t MDIO_Write(ETHER_MDIOHwIDType aID,
                   ETHER_MDIOPktType *const aPkt,
                   MDIO_JobIDType *const aJobID)
{
    int32_t retVal;
    uint32_t isJobComp = FALSE;

    if (MDIO_CTRLMODE_SLAVE == MDIO_RWDev[aID].mode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }

    retVal = MDIO_CheckStatus(aID);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    retVal = MDIO_QueueJob(aID, aPkt, aJobID, MDIO_JOB_WRITE);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    /* Trigger state handler */
    retVal = MDIO_IntStateHandler(aID);
    if (BCM_ERR_EAGAIN == retVal) {
        /* BCM_ERR_EAGAIN is returned by MDIO_IntStateHandler, when the
         * current job is still in progress. Which will be the case for
         * most of the times. As MDIO read/write take multiple calls
         * to internal state handler to finish a job.
         * As ther is no actual error while processing internal state
         * handler. Return value is over-writing to BCM_ERR_OK */
        retVal = BCM_ERR_OK;
    }

    if(TRUE == MDIO_RWDev[aID].isSync) {
        if (BCM_ERR_OK == retVal) {
            while (FALSE == isJobComp)
            {
                MDIO_StateHandler(&isJobComp);
            }
            retVal = MDIO_GetJobResult(aID, *aJobID, aPkt);
        }
    }

err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_READ_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
 */
int32_t MDIO_Read(ETHER_MDIOHwIDType aID,
                  ETHER_MDIOPktType *const aPkt,
                  MDIO_JobIDType *const aJobID)
{
    int32_t retVal;
    uint32_t isJobComp = FALSE;

    if (MDIO_CTRLMODE_SLAVE == MDIO_RWDev[aID].mode) {
        retVal = BCM_ERR_NOSUPPORT;
        goto err;
    }

    retVal = MDIO_CheckStatus(aID);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    retVal = MDIO_QueueJob(aID, aPkt, aJobID, MDIO_JOB_READ);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    /* Trigger state handler */
    retVal = MDIO_IntStateHandler(aID);
    if (BCM_ERR_EAGAIN == retVal) {
        /* BCM_ERR_EAGAIN is returned by MDIO_IntStateHandler, when the
         * current job is still in progress. Which will be the case for
         * most of the times. As MDIO read/write take multiple calls
         * to internal state handler to finish a job.
         * As ther is no actual error while processing internal state
         * handler. Return value is over-writing to BCM_ERR_OK */
        retVal = BCM_ERR_OK;
    }

    if(TRUE == MDIO_RWDev[aID].isSync) {
        if (BCM_ERR_OK == retVal) {
            while (FALSE == isJobComp)
            {
                MDIO_StateHandler(&isJobComp);
            }
            retVal = MDIO_GetJobResult(aID, *aJobID, aPkt);
        }
    }

err:
    return retVal;
}

/**
    @trace #BRCM_SWARCH_MDIO_STATEHANDLER_PROC
    @trace #BRCM_SWREQ_MDIO_OPERATIONS
 */
void MDIO_StateHandler(uint32_t *const aIsJobComp)
{
    int32_t retVal;
    uint32_t i;
    uint32_t jobCompPerCtlr = 0UL;

    for (i = 0UL; i < MDIO_MAX_HW_ID; i++) {
        do {
            retVal = MDIO_IntStateHandler(i);
            if (BCM_ERR_OK == retVal) {
                jobCompPerCtlr |= 1UL << i;
            }
        } while (BCM_ERR_OK == retVal);
        if ((BCM_ERR_EAGAIN != retVal) && (BCM_ERR_NOT_FOUND != retVal)) {
            MDIO_ReportError(BCM_MIO_ID, i,
                    BRCM_SWARCH_MDIO_STATEHANDLER_PROC,
                    retVal, 0UL, 0UL, 0UL, 0UL);
            break;
        }
    }

    if (NULL != aIsJobComp) {
        if (0UL != jobCompPerCtlr) {
            *aIsJobComp = TRUE;
        } else {
            *aIsJobComp = FALSE;
        }
    }
}

/** @} */
