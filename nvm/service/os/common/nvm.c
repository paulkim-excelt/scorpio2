/*****************************************************************************
 Copyright 2017-2018 Broadcom Limited.  All rights reserved.

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
#include <stddef.h>
#include <inttypes.h>
#include <compiler.h>
#include <bcm_err.h>
#include <system.h>
#include <nvm.h>
#include <flash.h>
#include <chip_config.h>
#include <osil/nvm_osil.h>
#include <bcm_utils.h>

/* NVM internal function IDs */
/** NVM_IdleStateHandler ID */
#define NVM_IDLE_STATE_HANDLER_API_ID    (0x81U)
/** NVM_BusyStateHandler ID */
#define NVM_BUSY_STATE_HANDLER_API_ID    (0x82U)

/* NVM device component type */
typedef struct {
    NVM_StateType        state;
    NVM_MsgType *        currMsg;
} NVM_CompType;

static NVM_CompType COMP_SECTION(".data.nvm")
NVM_Comp = {
    .state = NVM_STATE_UNINIT,
    .currMsg = NULL,
};

static void NVM_ReportError(uint8_t aInstanceID, uint16_t aApiID,
        int32_t aErr, uint32_t aVal0, uint32_t aVal1, uint32_t aVal2,
        uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_FLM_ID, aInstanceID, aApiID, aErr, 4UL, values);
}


static int32_t NVM_CmdRead(NVM_DevIDType aID,
                            NVM_DevType aDev,
                            uint32_t aAddr,
                            uint8_t *aBufOut, uint32_t aLen)
{
    int32_t retVal;
    switch (aDev) {
        case NVM_TYPE_FLASH:
            retVal = FLASH_Read(aID, aAddr, aBufOut, aLen);
            if (retVal == BCM_ERR_OK) {
                NVM_Comp.state = NVM_STATE_BUSY;
            }
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }

    return retVal;
}

static int32_t NVM_CmdWrite(NVM_DevIDType aID,
                            NVM_DevType aDev,
                            uint32_t aAddr,
                            const uint8_t * const aBufIn,
                            uint32_t aLen)
{
    int32_t retVal;
    switch (aDev) {
        case NVM_TYPE_FLASH:
            retVal = FLASH_Write(aID, aAddr, aBufIn, aLen);
            if (retVal == BCM_ERR_OK) {
                NVM_Comp.state = NVM_STATE_BUSY;
            }
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }

    return retVal;
}

static int32_t NVM_CmdErase(NVM_DevIDType aID,
                            NVM_DevType aDev,
                            uint32_t aAddr,
                            uint32_t aLen)
{
    int32_t retVal;
    switch (aDev) {
        case NVM_TYPE_FLASH:
            retVal = FLASH_Erase(aID, aAddr, aLen);
            if (retVal == BCM_ERR_OK) {
                NVM_Comp.state = NVM_STATE_BUSY;
            }
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
    }

    return retVal;
}

static int32_t NVM_Virt2PhyAddr(NVM_AddrType aVirtAddr,
                                NVM_DevType* aDev,
                                NVM_DevIDType* aID,
                                uint32_t* aPhysAddr)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_OK;

    /*Check for Valid Address and length*/
    for (i = 0; i < NVM_CfgTblSz; i++)
    {
        if ((aVirtAddr >= NVM_CfgTbl[i].startAddr) &&
                (aVirtAddr  <= (NVM_CfgTbl[i].startAddr + NVM_CfgTbl[i].maxSize)))
        {
            *aPhysAddr = (uint32_t)(aVirtAddr - NVM_CfgTbl[i].startAddr);
            *aDev = NVM_CfgTbl[i].aDev;
            *aID = NVM_CfgTbl[i].aID;
            break;
        }
    }
    if (i >= NVM_CfgTblSz) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

static int32_t NVM_IdleStateHandler(NVM_MsgType * const aMsg)
{
    int32_t retVal;
    uint32_t physAddr;
    NVM_DevType         aDev;
    NVM_DevIDType aID = 0;

    /* Issue command to flash driver */
    NVM_Comp.state = NVM_STATE_BUSY;
    NVM_Comp.currMsg = aMsg;

    retVal = NVM_Virt2PhyAddr(aMsg->virtAddr, &aDev, &aID, &physAddr);
    if (retVal != BCM_ERR_OK) {
        goto err;
    }
    switch(aMsg->cmd) {
    case NVM_CMD_READ:
        retVal = NVM_CmdRead(aID, aDev, physAddr, aMsg->bufOut, aMsg->len);
        break;
    case NVM_CMD_WRITE:
        retVal = NVM_CmdWrite(aID, aDev, physAddr, aMsg->bufIn, aMsg->len);
        break;
    case NVM_CMD_ERASE:
        retVal = NVM_CmdErase(aID, aDev, physAddr, aMsg->len);
        break;
    default:
        retVal = BCM_ERR_INVAL_PARAMS;
        NVM_ReportError((uint8_t)aID, NVM_IDLE_STATE_HANDLER_API_ID,
                retVal, aMsg->cmd, 0UL, 0UL, __LINE__);
        break;
    }

err:
    if (BCM_ERR_OK != retVal) {
        NVM_ReportError((uint8_t)aID, NVM_IDLE_STATE_HANDLER_API_ID,
                retVal, aMsg->cmd, 0UL, 0UL, __LINE__);
        NVM_Comp.state = NVM_STATE_IDLE;
        NVM_Comp.currMsg = NULL;
        aMsg->opResult = NVM_OP_RESULT_FAILED;
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_EAGAIN;
    }

    return retVal;
}

static int32_t NVM_BusyStateHandler(NVM_MsgType * const aMsg)
{
    int32_t retVal;
    FLASH_OpsResultType flashOpResult;
    NVM_DevType         aDev;
    NVM_DevIDType aID;
    uint32_t physAddr;

    retVal = NVM_Virt2PhyAddr(aMsg->virtAddr, &aDev, &aID, &physAddr);
    if (retVal != BCM_ERR_OK) {
        goto err;
    }
    if (NVM_Comp.currMsg == aMsg) {
        /* Check the result of flash operation */
        retVal = FLASH_GetOpsResult(aID, &flashOpResult);
        if (BCM_ERR_OK != retVal) {
            goto err;
        }

        if (FLASH_OPS_RESULT_OK == flashOpResult) {
            aMsg->opResult = NVM_OP_RESULT_SUCCESS;
        } else if (FLASH_OPS_RESULT_FAIL == flashOpResult) {
            aMsg->opResult = NVM_OP_RESULT_FAILED;
        } else if (FLASH_OPS_RESULT_PENDING == flashOpResult) {
            retVal = BCM_ERR_EAGAIN;
            goto err;
        } else {
            retVal = BCM_ERR_UNKNOWN;
            NVM_ReportError((uint8_t)aID, NVM_BUSY_STATE_HANDLER_API_ID,
                    retVal, flashOpResult, 0UL, 0UL, 0UL);
            goto err;
        }

        NVM_Comp.state = NVM_STATE_IDLE;
        NVM_Comp.currMsg = NULL;
        retVal = BCM_ERR_OK;
    } else {
        NVM_ReportError((uint8_t)aID, NVM_BUSY_STATE_HANDLER_API_ID,
                retVal, (uint32_t)NVM_Comp.currMsg, (uint32_t)aMsg, 0UL, 0UL);
    }
err:
    return retVal;
}

int32_t NVM_MsgHandler(NVM_MsgType * const aMsg)
{
    int32_t retVal;

    if (NULL == aMsg) {
        retVal = BCM_ERR_INVAL_PARAMS;
        NVM_ReportError((uint8_t)0UL, BRCM_SWARCH_NVM_IL_MSG_HANDLER_PROC, retVal, 0UL,
                0UL, 0UL, 0UL);
    } else {
        /* Check NVM device state */
        switch (NVM_Comp.state) {
        case NVM_STATE_IDLE:
            retVal = NVM_IdleStateHandler(aMsg);
            break;
        case NVM_STATE_BUSY:
            retVal = NVM_BusyStateHandler(aMsg);
            break;
        default:
            retVal = BCM_ERR_UNKNOWN;
            break;
        }
    }

    return retVal;
}

int32_t NVM_GetState(NVM_StateType * const aState)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aState) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    *aState = NVM_Comp.state;
err:
    return retVal;
}


int32_t NVM_Cancel(NVM_OpResultType* const aOpResult,
                      const MSGQ_MsgHdrType* const aMsgHdr)
{
    int32_t retVal;
    NVM_MsgType mesg = {0};
    MSGQ_Type MsgQ;

    if ((NULL == aMsgHdr)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    NVM_GetMsgQ(&MsgQ);

    /* Try cancelling message */
    retVal = MSGQ_TryCancelMsg(&MsgQ, aMsgHdr, &mesg);
    if (BCM_ERR_OK == retVal) {
        *aOpResult = mesg.opResult;
    }

    if (BCM_ERR_BUSY == retVal) {
        retVal = BCM_ERR_OK;
        *aOpResult = NVM_OP_RESULT_PENDING;
    }

err:
    return retVal;
}

int32_t NVM_Read(NVM_AddrType aAddr,
                    uint8_t * const aBuf,
                    uint32_t aLen,
                    const uint32_t aClientMask,
                    const MSGQ_MsgHdrType ** const aMsgHdr)
{
    int32_t retVal;
    NVM_MsgType mesg = {0};
    MSGQ_Type MsgQ;

    if ((NULL == aBuf) || (0UL == aLen)
            || (NULL == aMsgHdr)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    mesg.cmd = NVM_CMD_READ;
    mesg.virtAddr = aAddr;
    mesg.len = aLen;
    mesg.bufOut = aBuf;
    mesg.opResult = NVM_OP_RESULT_PENDING;

    NVM_GetMsgQ(&MsgQ);
    /* Post message to message queue */
    retVal = MSGQ_SendMsg(&MsgQ, &mesg, aClientMask, aMsgHdr);

err:
    return retVal;
}

int32_t NVM_Write(NVM_AddrType aAddr,
                        const uint8_t * const aBuf,
                        uint32_t aLen,
                        const uint32_t aClientMask,
                        const MSGQ_MsgHdrType ** const aMsgHdr)
{
    int32_t retVal;
    NVM_MsgType mesg = {0};
    MSGQ_Type MsgQ;

    if ((NULL == aBuf) || (0UL == aLen)
            || (NULL == aMsgHdr)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    mesg.cmd = NVM_CMD_WRITE;
    mesg.virtAddr = aAddr;
    mesg.len = aLen;
    mesg.bufIn = aBuf;
    mesg.opResult = NVM_OP_RESULT_PENDING;

    NVM_GetMsgQ(&MsgQ);
    /* Post message to message queue */
    retVal = MSGQ_SendMsg(&MsgQ, &mesg, aClientMask, aMsgHdr);

err:
    return retVal;
}

int32_t NVM_Erase(NVM_AddrType aAddr,
                    uint32_t aLen,
                    const uint32_t aClientMask,
                    const MSGQ_MsgHdrType ** const aMsgHdr)
{
    int32_t retVal;
    NVM_MsgType mesg = {0};
    MSGQ_Type MsgQ;

    if ((0UL == aLen) || (NULL == aMsgHdr)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    mesg.cmd = NVM_CMD_ERASE;
    mesg.virtAddr = aAddr;
    mesg.len = aLen;
    mesg.opResult = NVM_OP_RESULT_PENDING;

    NVM_GetMsgQ(&MsgQ);
    /* Post message to message queue */
    retVal = MSGQ_SendMsg(&MsgQ, &mesg, aClientMask, aMsgHdr);

err:
    return retVal;
}

int32_t NVM_GetStatus(NVM_OpResultType * const aOpResult,
                           const MSGQ_MsgHdrType * const aMsgHdr,
                                  uint32_t *aLen)
{
    int32_t retVal;
    NVM_MsgType mesg = {0};
    MSGQ_Type MsgQ;

    if ((NULL == aOpResult) || (NULL == aMsgHdr)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    NVM_GetMsgQ(&MsgQ);
    /* Receive message from message queue */
    retVal = MSGQ_RecvMsg(&MsgQ, aMsgHdr, &mesg);
    if (BCM_ERR_OK == retVal) {
        *aOpResult = mesg.opResult;
        *aLen = mesg.len;
    }

    if (BCM_ERR_BUSY == retVal) {
        retVal = BCM_ERR_OK;
        *aOpResult = NVM_OP_RESULT_PENDING;
    }

err:
    return retVal;
}

int32_t NVM_Init(void)
{
    int32_t retVal = BCM_ERR_INVAL_STATE;

    if (NVM_Comp.state == NVM_STATE_UNINIT) {
        NVM_Comp.state = NVM_STATE_IDLE;
        NVM_Comp.currMsg = NULL;
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

int32_t NVM_DeInit(void)
{
    int32_t retVal = BCM_ERR_INVAL_STATE;

    if (NVM_Comp.state != NVM_STATE_UNINIT)
    {
        NVM_Comp.state = NVM_STATE_UNINIT;
        retVal = BCM_ERR_OK;
    }
    return retVal;

}

int32_t NVM_Phy2VirtAddr(uint32_t aPhysAddr,
                            NVM_DevType aDev,
                            NVM_DevIDType aID,
                            NVM_AddrType *aVirtAddr)
{
    uint32_t i;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    NVM_AddrType lastAddr;
    NVM_AddrType mappedAddr;

    for (i = 0; i < NVM_CfgTblSz; i++)
    {
        if (NVM_CfgTbl[i].aDev == aDev
                && NVM_CfgTbl[i].aID == aID)
        {
            lastAddr = (NVM_AddrType)NVM_CfgTbl[i].startAddr + NVM_CfgTbl[i].maxSize;
            mappedAddr = (NVM_AddrType)NVM_CfgTbl[i].startAddr + aPhysAddr;

            if (mappedAddr < lastAddr) {
                retVal = BCM_ERR_OK;
                *aVirtAddr = mappedAddr;
            }
            break;
        }
    }

    return retVal;
}
