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
#include <rpc_interface.h>
#include <rpc_mod_test.h>
#include <bcm_comp.h>

typedef struct sRPC_ModTestIfc2CtxType {
    RPC_InterfaceIdType selfId;
    RPC_InterfaceIdType peerId;
    RPC_AssociationIndexType assocId;
    uint8_t   entryCount;  /* maintain the function entry count for single test
                              This can be used to simulate the different cases */
} RPC_ModTestIfc2CtxType;

static RPC_ModTestIfc2CtxType RPC_ModTestIfc2Ctx;

static int32_t RPC_ModTestIfc2Init(void)
{
    int32_t retVal;

    RPC_ModTestIfc2Ctx.entryCount = 0UL;
    if(RPC_MODTESTFLAG_4 == RPC_ModTestFlag) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = RPC_GetModIfcAndAssoc(&RPC_ModTestIfc2, &RPC_ModTestIfc2Ctx.selfId,
                                     &RPC_ModTestIfc2Ctx.peerId,
                                     &RPC_ModTestIfc2Ctx.assocId);
    }

    return retVal;
}

static int32_t RPC_ModTestIfc2SendMsg(RPC_HdlType aHdl)
{
    return BCM_ERR_OK;

}

static int32_t RPC_ModTestIfc2RecvMsg(RPC_HdlType* const aHdl)
{
    int32_t retVal= BCM_ERR_NOT_FOUND;

    if((RPC_MODTESTFLAG_3 == RPC_ModTestFlag)
                || (RPC_MODTESTFLAG_2 == RPC_ModTestFlag)) {
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_ModTestIfc2Ctx.selfId,
                              RPC_ModTestIfc2Ctx.peerId,
                              RPC_ModTestIfc2Ctx.assocId,
                              aHdl);
        if(BCM_ERR_NOMEM == retVal) {
            retVal = BCM_ERR_NOT_FOUND;
        }
    }

    return retVal;
}

static int32_t RPC_ModTestIfc2Process(void)
{
    return BCM_ERR_OK;
}

static int32_t RPC_ModTestIfc2DetectStream(RPC_HdlType* const aHdl)
{
    int32_t retVal;

    if(RPC_MODTESTFLAG_2 == RPC_ModTestFlag) {
        /* provide Msg handle.
           The process stream will reject the stream with error
               as it is not a valid stream handle */
        (void)RPC_MsgAlloc(RPC_HDL_INVALID,
                          RPC_ModTestIfc2Ctx.selfId,
                          RPC_ModTestIfc2Ctx.peerId,
                          RPC_ModTestIfc2Ctx.assocId,
                          aHdl);
        retVal = BCM_ERR_OK;
    } else if(RPC_MODTESTFLAG_3 == RPC_ModTestFlag) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

static int32_t RPC_ModTestIfc2ProcessStream(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    int32_t retVal;

    RPC_MemStrmClientInfoType *clientInfo = NULL;

    if(RPC_MODTESTFLAG_3 == RPC_ModTestFlag) {
        /* return error for a valid handle */
        retVal = BCM_ERR_UNKNOWN;
    } else if (RPC_MODTESTFLAG_2 == RPC_ModTestFlag) {
        if(0UL == RPC_ModTestIfc2Ctx.entryCount) {
            RPC_ModTestIfc2Ctx.entryCount++;
            clientInfo = RPC_StrmGetSlaveClientInfo(aHdl);
            clientInfo->state = BCM_STATE_SUB_STATE_DONE;
            retVal = BCM_ERR_OK;
        } else {
            RPC_ModTestIfc2Ctx.entryCount = 0UL;
            retVal = BCM_ERR_UNKNOWN;
        }
    } else {
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}

static uint32_t RPC_ModTestIfc2GetEventMask(void)
{
    return RPC_MOD_TEST_EVENT;
}

const RPC_InterfaceType RPC_ModTestIfc2 = {
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
    .init          = RPC_ModTestIfc2Init,
    .sendMsg       = RPC_ModTestIfc2SendMsg,
    .recvMsg       = RPC_ModTestIfc2RecvMsg,
    .processMsg    = RPC_ModTestIfc2Process,
    .detectStrm    = RPC_ModTestIfc2DetectStream,
    .processStrm   = RPC_ModTestIfc2ProcessStream,
    .getEventMask  = RPC_ModTestIfc2GetEventMask,
};
