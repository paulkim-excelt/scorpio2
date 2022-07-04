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

typedef struct sRPC_ModTestIfc1CtxType {
    RPC_InterfaceIdType selfId;
    RPC_InterfaceIdType peerId;
    RPC_AssociationIndexType assocId;
    uint8_t   cnt;
} RPC_ModTestIfc1CtxType;

static RPC_ModTestIfc1CtxType RPC_ModTestIfc1Ctx;

static int32_t RPC_ModTestIfc1Init(void)
{
    int32_t retVal;

    retVal = RPC_GetModIfcAndAssoc(&RPC_ModTestIfc1, &RPC_ModTestIfc1Ctx.selfId,
                                 &RPC_ModTestIfc1Ctx.peerId,
                                 &RPC_ModTestIfc1Ctx.assocId);

    return retVal;
}

static int32_t RPC_ModTestIfc1Connect(void)
{
    return BCM_ERR_OK;
}

static int32_t RPC_ModTestIfc1SendMsg(RPC_HdlType aHdl)
{
    return BCM_ERR_OK;

}

static int32_t RPC_ModTestIfc1RecvMsg(RPC_HdlType* const aHdl)
{
    int32_t retVal;

    if(RPC_MODTESTFLAG_2 == RPC_ModTestFlag) {
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_ModTestIfc1Ctx.selfId,
                              RPC_ModTestIfc1Ctx.peerId,
                              RPC_ModTestIfc1Ctx.assocId,
                              aHdl);
        if(BCM_ERR_NOMEM == retVal) {
            retVal = BCM_ERR_NOT_FOUND;
        }
    } else if (RPC_MODTESTFLAG_3 == RPC_ModTestFlag) {
        /* ERR_OK with invalid handle. to test the fail case */
        if(0UL == RPC_ModTestIfc1Ctx.cnt) {
            retVal = BCM_ERR_OK;
            *aHdl = RPC_HDL_INVALID;
            RPC_ModTestIfc1Ctx.cnt ++;
        } else {
            /* to break the loop */
            retVal = BCM_ERR_NOT_FOUND;
        }
    } else {
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}

static int32_t RPC_ModTestIfc1Process(void)
{
    return BCM_ERR_OK;
}

static int32_t RPC_ModTestIfc1DetectStream(RPC_HdlType* const aHdl)
{
    int32_t retVal= BCM_ERR_NOT_FOUND;
    RPC_StrmCfgType cfg;

    if((RPC_MODTESTFLAG_2 == RPC_ModTestFlag)
                   || (RPC_MODTESTFLAG_3 == RPC_ModTestFlag)) {
        retVal = RPC_StrmAlloc(&cfg, RPC_ModTestIfc1Ctx.selfId,
                                RPC_ModTestIfc1Ctx.peerId,
                                RPC_ModTestIfc1Ctx.assocId,
                                aHdl);
    } else {
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

static int32_t RPC_ModTestIfc1ProcessStream(RPC_HdlType aHdl, BCM_SubStateType aPeerState)
{
    int32_t retVal= BCM_ERR_NOT_FOUND;
    RPC_MemStrmClientInfoType *clientInfo = NULL;

    if(RPC_MODTESTFLAG_3 == RPC_ModTestFlag) {
        /* return error for a valid handle */
        retVal = BCM_ERR_UNKNOWN;
    } else {
        clientInfo = RPC_StrmGetMasterClientInfo(aHdl);
        clientInfo->state = BCM_STATE_SUB_STATE_DONE;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

static uint32_t RPC_ModTestIfc1GetEventMask(void)
{
    return RPC_MOD_TEST_EVENT;
}

static int32_t RPC_ModTestIfc1Disconnect(void)
{
    return BCM_ERR_OK;
}


static void RPC_ModTestIfc1Deinit(void)
{
    return;
}


const RPC_InterfaceType RPC_ModTestIfc1 = {
    .mode          = RPC_IFC_CHAN_MODE_MASTER,
    .assoc         = RPC_ASSOCIATIONINDEX_0,
    .init          = RPC_ModTestIfc1Init,
    .connect       = RPC_ModTestIfc1Connect,
    .sendMsg       = RPC_ModTestIfc1SendMsg,
    .recvMsg       = RPC_ModTestIfc1RecvMsg,
    .processMsg    = RPC_ModTestIfc1Process,
    .detectStrm    = RPC_ModTestIfc1DetectStream,
    .processStrm   = RPC_ModTestIfc1ProcessStream,
    .getEventMask  = RPC_ModTestIfc1GetEventMask,
    .disconnect    = RPC_ModTestIfc1Disconnect,
    .deinit        = RPC_ModTestIfc1Deinit,
};
