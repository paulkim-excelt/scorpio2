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
/**
    @defgroup grp_rpc_module_impl Design
    @ingroup grp_rpc_v2_mod

    @addtogroup grp_rpc_module_impl
    @{

    @file rpc_module.c
    @brief RPC Module Design
    This file contains the RPC module for integration layer

    @version 0.1 Initial draft
*/
#include <build_info.h>
#include <bcm_utils.h>
#include <msg_queue.h>
#include <bcm_err.h>
#include <stdlib.h>
#include <module.h>
#include <rpc_interface.h>
#include <rpc_module_v2.h>
#include <rpc_mem.h>
#include <rpc_mem_osil.h>
#include <module_osil.h>

/**
    @name RPC Module Notificaiton Design IDs
    @{
    @brief Design IDs for RPC Module Notificaiton

*/
#define BRCM_SWDSGN_RPC_SRV_MAX_HANDLES_MACRO         (0xA701U)    /**< @brief #RPC_SRV_MAX_HANDLES      */
#define BRCM_SWDSGN_RPC_SRVIFCCONTEXT_TYPE            (0xA702U)    /**< @brief #RPC_SrvIfcContextType    */
#define BRCM_SWDSGN_RPC_SRVCONTEXT_TYPE               (0xA703U)    /**< @brief #RPC_SrvContextType       */
#define BRCM_SWDSGN_RPC_SRVCONTEXT_GLOBAL             (0xA704U)    /**< @brief #RPC_SrvContext           */
#define BRCM_SWDSGN_RPC_SRVREPORTERROR_PROC           (0xA705U)    /**< @brief #RPC_SrvReportError       */
#define BRCM_SWDSGN_RPC_SRVENQ_PROC                   (0xA706U)    /**< @brief #RPC_SrvEnQ               */
#define BRCM_SWDSGN_RPC_SRVPEEKINQ_PROC               (0xA707U)    /**< @brief #RPC_SrvPeekInQ           */
#define BRCM_SWDSGN_RPC_SRVDEQ_PROC                   (0xA708U)    /**< @brief #RPC_SrvDeQ               */
#define BRCM_SWDSGN_RPC_SRVHANDLERESPONSES_PROC       (0xA709U)    /**< @brief #RPC_SrvHandleResponses   */
#define BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC        (0xA70AU)    /**< @brief #RPC_SrvHandleCommands    */
#define BRCM_SWDSGN_RPC_SRVRESETSTATE_HANDLER_PROC    (0xA70BU)    /**< @brief #RPC_SrvResetStateHandler */
#define BRCM_SWDSGN_RPC_SRVEVENTHANDLER_PROC          (0xA70CU)    /**< @brief #RPC_SrvEventHandler      */
#define BRCM_SWDSGN_RPC_SRVEVENTMASK_PROC             (0xA70DU)    /**< @brief #RPC_SrvGetEventMask      */
#define BRCM_SWDSGN_RPC_MODULE_GLOBAL                 (0xA70EU)    /**< @brief #RPC_Module               */
#define BRCM_SWDSGN_RPC_SRVREADYSTATEHANDLER_PROC     (0xA70FU)    /**< @brief #RPC_SrvReadyStateHandler */
/** @} */

/** @brief Report an RPC error

    This API is called by individual functions to report an error.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aErr        Error to be reported
    @param[in]      aApiId      API identification
    @param[in]      aInfo0      Error information
    @param[in]      aInfo1      Error information
    @param[in]      aInfo2      Error information
    @param[in]      aLineNo     line number

    @return void

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2

    @code{.c}
    values = {aInfo0, aInfo1, aInfo2, aLineNo}
    BCM_ReportError(BCM_RPC_ID, aInstanceID, API_ID, aErr, 4UL, values)
    @endcode
*/
static void RPC_SrvReportError(uint16_t aApiId, int32_t aErr,
                                 uint32_t aInfo0, uint32_t aInfo1,
                                 uint32_t aInfo2, uint32_t aLineNo)
{
    const uint32_t values[4] = {aInfo0, aInfo1, aInfo2, aLineNo};
    BCM_ReportError(BCM_RPC_ID, 0U, aApiId, aErr, 4UL, values);
}

/**
    @brief Maximum number of handles per interfae

    @limitations The value must be power of 2

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
#define RPC_SRV_MAX_HANDLES   ((RPC_MEM_MSG_COUNT) / (RPC_ASSOCIATIONINDEX_MAX))

/**
    @brief Handles to be sent on interface

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
typedef struct sRPC_SrvIfcContextType{
    uint32_t rdIdx;                         /**< @brief Read Index of the Handle  */
    uint32_t wrIdx;                         /**< @brief write Index of the Handle */
    RPC_HdlType  hdl[RPC_SRV_MAX_HANDLES];  /**< @brief Handle                    */
} RPC_SrvIfcContextType;

/**
    @brief RPC Module Context Type

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
typedef struct sRPC_SrvContextType {
    MODULE_ContextType    innerContext;  /**< @brief Module context */
    RPC_SrvIfcContextType ifc[RPC_INTERFACEID_MAX];
                                         /**< @brief Memory for msg handles */
    RPC_HdlType           strmhdl[RPC_MEM_STREAM_COUNT];
                                         /**< @brief Memory for stream handles */
} RPC_SrvContextType;

/**
    @brief RPC Module Context

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
static RPC_SrvContextType RPC_SrvContext COMP_SECTION(".bss.rpc");

/** @brief EnQ the handles on interface

    This API Push the handle to the queue

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aIfc               Pointer to Module context Interface of the Module
    @param[in]      aHdl               Handle to be queued

    @retval     #BCM_ERR_OK            Matching stream found
    @retval     #BCM_ERR_UNKNOWN       Unknown Index failure

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2

    @limitations None

    @code{.unparsed}
    if((aIfc->wrIdx - aIfc->rdIdx) >= RPC_SRV_MAX_HANDLES)
        retVal = BCM_ERR_UNKNOWN
    else
        idx = aIfc->wrIdx & (RPC_SRV_MAX_HANDLES - 1UL)
        aIfc->hdl[idx] = aHdl
        aIfc->wrIdx++
        retVal = BCM_ERR_OK
    @endcode
*/
static int32_t RPC_SrvEnQ(RPC_SrvIfcContextType *aIfc, RPC_HdlType aHdl)
{
    uint32_t idx;
    int32_t retVal;

    if((aIfc->wrIdx - aIfc->rdIdx) >= RPC_SRV_MAX_HANDLES) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        idx = aIfc->wrIdx & (RPC_SRV_MAX_HANDLES - 1UL);
        aIfc->hdl[idx] = aHdl;
        aIfc->wrIdx++;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Peek The first element in Q

    This API Peek into Q and return the first element

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aIfc    Pointer to Module context Interface of the Module

    @return RPC_HdlType aHdl if found in Q
            RPC_HDL_INVALID otherwise

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2

    @limitations None

    @code{.unparsed}
    if(aIfc->wrIdx == aIfc->rdIdx)
        return RPC_HDL_INVALID;
    else
        idx = aIfc->rdIdx & (RPC_SRV_MAX_HANDLES-1UL)
        return aIfc->hdl[idx]
    @endcode
*/
static RPC_HdlType RPC_SrvPeekInQ(RPC_SrvIfcContextType *aIfc)
{
    uint32_t idx;
    RPC_HdlType hdl = RPC_HDL_INVALID;

    if(aIfc->wrIdx != aIfc->rdIdx) {
        idx = aIfc->rdIdx & (RPC_SRV_MAX_HANDLES-1UL);
        hdl = aIfc->hdl[idx];
    }

    return hdl;
}

/** @brief DeQ the handles on interface

    This API Pop the handle from the queue

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aIfc    Pointer to Module context Interface of the Module

    @return RPC_HdlType aHdl if found in Q
            RPC_HDL_INVALID otherwise

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2

    @limitations None

    @code{.unparsed}
        hdl = RPC_SrvPeekInQ(aIfc)
        if(hdl IS NOT RPC_HDL_INVALID)
           idx = aIfc->rdIdx & (RPC_SRV_MAX_HANDLES-1UL)
            aIfc->hdl[idx] = RPC_HDL_INVALID
            aIfc->rdIdx++
            if((aIfc->rdIdx & (~(RPC_SRV_MAX_HANDLES - 1UL))) == (aIfc->wrIdx & (~(RPC_SRV_MAX_HANDLES - 1UL))))
                aIfc->wrIdx = aIfc->wrIdx & (RPC_SRV_MAX_HANDLES - 1UL)
                aIfc->rdIdx = aIfc->rdIdx & (RPC_SRV_MAX_HANDLES - 1UL)
        return hdl
    @endcode
*/
static RPC_HdlType RPC_SrvDeQ(RPC_SrvIfcContextType *aIfc)
{
    uint32_t idx;
    RPC_HdlType hdl = RPC_HDL_INVALID;

    hdl = RPC_SrvPeekInQ(aIfc);
    if(RPC_HDL_INVALID != hdl) {
        idx = aIfc->rdIdx & (RPC_SRV_MAX_HANDLES-1UL);
        aIfc->hdl[idx] = RPC_HDL_INVALID;
        aIfc->rdIdx++;
        if((aIfc->rdIdx & (~(RPC_SRV_MAX_HANDLES - 1UL))) == (aIfc->wrIdx & (~(RPC_SRV_MAX_HANDLES - 1UL)))) {
            aIfc->wrIdx = aIfc->wrIdx & (RPC_SRV_MAX_HANDLES - 1UL);
            aIfc->rdIdx = aIfc->rdIdx & (RPC_SRV_MAX_HANDLES - 1UL);
        }
    }

    return hdl;
}

/** @brief Handle the responses and Async

    This API will be called to Handle the responses and Async Messages

    @behavior Sync, Re-entrant

    @pre None

    @retval     None

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2

    @limitations None

    @code{.unparsed}
    for(ifc = (RPC_INTERFACEID_MAX-1); ifc >= 0; ifc--)
        if (interfaces[ifc] IS NOT NULL)
            if(interfaces[ifc]->mode IS RPC_IFC_CHAN_MODE_MASTER)
                do
                    retVal = interfaces[ifc]->recvMsg(&hdl)
                    if(retVal IS BCM_ERR_OK)
                        slaveIfc = (hdl & RPC_HDL_SLAVEID_MASK) >> RPC_HDL_SLAVEID_SHIFT
                        retVal = RPC_SrvEnQ(&RPC_SrvContext.ifc[slaveIfc], hdl)
                        if(retVal IS NOT BCM_ERR_OK)
                             (void)RPC_Release(hdl)
                             RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLERESPONSES_PROC, retVal,(uint32_t) hdl,
                                                   (uint32_t) slaveIfc, (uint32_t) ifc,(uint32_t)__LINE__)
                    for(strm = 0; strm < RPC_Memory.strmCnt; strm++)
                        if(RPC_SrvContext.strmhdl[strm] IS RPC_HDL_INVALID)
                            if(BCM_ERR_OK IS interfaces[ifc]->detectStrm(&hdl))
                                RPC_SrvContext.strmhdl[strm] = hdl
                                break
                while(retVal IS NOT BCM_ERR_NOT_FOUND);
            else
                retVal = BCM_ERR_OK
                hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc])
                while((retVal IS BCM_ERR_OK) && (hdl IS NOT RPC_HDL_INVALID))
                    retVal = interfaces[ifc]->sendMsg(hdl)
                    if(retVal IS BCM_ERR_OK)
                        De-Queue RPC_SrvContext.ifc[ifc]
                    else
                        Report Error
                    hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc])
    @endcode
*/
static void RPC_SrvHandleResponses(void)
{
    int32_t ifc;
    uint32_t hdl = RPC_HDL_INVALID;
    uint32_t strm;
    uint32_t slaveIfc;
    int32_t retVal;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    for(ifc = ((int32_t)RPC_INTERFACEID_MAX - 1L); ifc >= 0; ifc--) {
        if ((NULL != interfaces) && (NULL != interfaces[ifc])) {
            if(RPC_IFC_CHAN_MODE_MASTER == interfaces[ifc]->mode) {
                retVal = BCM_ERR_NOT_FOUND;
                do {
                    if(NULL != interfaces[ifc]->recvMsg) {
                        retVal = interfaces[ifc]->recvMsg(&hdl);
                        if((BCM_ERR_OK == retVal) && (RPC_HDL_INVALID != hdl)) {
                            slaveIfc = (hdl & RPC_HDL_SLAVEID_MASK) >> RPC_HDL_SLAVEID_SHIFT;
                            retVal = RPC_SrvEnQ(&RPC_SrvContext.ifc[slaveIfc], hdl);
                            if(BCM_ERR_OK != retVal) {
                                 (void)RPC_Release(hdl);
                                 RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLERESPONSES_PROC, retVal,(uint32_t) hdl,
                                                       (uint32_t) slaveIfc, (uint32_t) ifc,(uint32_t)__LINE__);
                            }
                        }
                    }

                    for(strm = 0; strm < RPC_Memory.strmCnt; strm++) {
                        if(RPC_HDL_INVALID == RPC_SrvContext.strmhdl[strm]) {
                            if((NULL != interfaces[ifc]->detectStrm) &&
                               (BCM_ERR_OK == interfaces[ifc]->detectStrm(&hdl))) {
                                RPC_SrvContext.strmhdl[strm] = hdl;
                                break;
                            }
                        }
                    }
                } while(BCM_ERR_NOT_FOUND != retVal);
            } else {
                retVal = BCM_ERR_OK;
                hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc]);
                while((BCM_ERR_OK == retVal) && (RPC_HDL_INVALID != hdl)) {
                    if(NULL != interfaces[ifc]->sendMsg) {
                        retVal = interfaces[ifc]->sendMsg(hdl);
                        if ((BCM_ERR_OK == retVal) || (BCM_ERR_UNKNOWN == retVal)) {
                            (void)RPC_SrvDeQ(&RPC_SrvContext.ifc[ifc]);
                        }
                        hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc]);
                    }
                }
            }
        }
    }
}

/** @brief Handle Commands

    This API will be called to Handle the commands

    @behavior Sync, Re-entrant

    @pre None

    @retval     None

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2

    @code{.unparsed}
    for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++)
        if (interfaces[ifc] IS NOT NULL)
            if(interfaces[ifc]->mode IS RPC_IFC_CHAN_MODE_SLAVE)
                do
                    retVal = interfaces[ifc]->recvMsg(&hdl)
                    if(retVal IS BCM_ERR_OK)
                        masterIfc = (hdl & RPC_HDL_MASTERID_MASK) >> RPC_HDL_MASTERID_SHIFT
                        retVal = RPC_SrvEnQ(&RPC_SrvContext.ifc[masterIfc], hdl);
                        if(retVal IS NOT BCM_ERR_OK)
                            (void)RPC_Release(hdl)
                            RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC, retVal,(uint32_t) hdl,
                                                      (uint32_t) ifc, 0UL, (uint32_t)__LINE__);
                        else
                            break

                    for(strm = 0; strm < RPC_Memory.strmCnt; strm++)
                        hdl = RPC_SrvContext.strmhdl[strm]
                        if(hdl IS NOT RPC_HDL_INVALID)
                            slaveIfc = (hdl & RPC_HDL_SLAVEID_MASK) >> RPC_HDL_SLAVEID_SHIFT
                            masterIfc = (hdl & RPC_HDL_MASTERID_MASK) >> RPC_HDL_MASTERID_SHIFT
                            if(slaveIfc == ifc)
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus)
                                if ((NULL != interfaces[slaveIfc]->processStrm) && (BCM_STATE_SUB_STATE_DONE != slaveIfcStatus))
                                    streamRet = interfaces[slaveIfc]->processStrm(hdl, masterIfcStatus)
                                    if (BCM_ERR_UNKNOWN == streamRet)
                                         RPC_SrvReportError()
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus)
                                if ((NULL != interfaces[masterIfc]->processStrm) && (BCM_STATE_SUB_STATE_DONE != masterIfcStatus))
                                    streamRet = interfaces[masterIfc]->processStrm(hdl, slaveIfcStatus)
                                    if (BCM_ERR_UNKNOWN == streamRet)
                                         RPC_SrvReportError()
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus)
                                if ((NULL != interfaces[slaveIfc]->processStrm) && (BCM_STATE_SUB_STATE_DONE != slaveIfcStatus))
                                    streamRet = interfaces[slaveIfc]->processStrm(hdl, masterIfcStatus)
                                    if (BCM_ERR_UNKNOWN == streamRet)
                                         RPC_SrvReportError()
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus)
                                if ((BCM_STATE_SUB_STATE_DONE == slaveIfcStatus) && (BCM_STATE_SUB_STATE_DONE == masterIfcStatus))
                                    RPC_Release(RPC_SrvContext.strmhdl[strm])
                                    RPC_SrvContext.strmhdl[strm] = RPC_HDL_INVALID
                while(retVal IS NOT BCM_ERR_NOT_FOUND)

            else
                retVal = BCM_ERR_OK
                hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc])
                while((retVal IS BCM_ERR_OK) && (hdl IS NOT RPC_HDL_INVALID))
                    retVal = interfaces[ifc]->sendMsg(hdl)
                    if(retVal IS BCM_ERR_OK)
                        De-Queue RPC_SrvContext.ifc[ifc]
                    else
                        Report Error
                    hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc])
                }
    @endcode
*/
static void RPC_SrvHandleCommands(void)
{
    uint32_t ifc;
    uint32_t hdl = RPC_HDL_INVALID;
    uint32_t strm;
    uint32_t slaveIfc = 0UL;
    uint32_t masterIfc = 0UL;
    int32_t retVal;
    int32_t ret = BCM_ERR_OK;
    int32_t streamRet = BCM_ERR_BUSY;
    BCM_SubStateType slaveIfcStatus = BCM_STATE_SUB_STATE_DONE;
    BCM_SubStateType masterIfcStatus = BCM_STATE_SUB_STATE_DONE;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++) {
        if ((NULL != interfaces) && (NULL != interfaces[ifc])) {
            if(RPC_IFC_CHAN_MODE_SLAVE == interfaces[ifc]->mode) {
                retVal = BCM_ERR_NOT_FOUND;
                do {
                    if(NULL != interfaces[ifc]->recvMsg) {
                        retVal = interfaces[ifc]->recvMsg(&hdl);
                        if((BCM_ERR_OK == retVal) && (RPC_HDL_INVALID != hdl)) {
                            masterIfc = (hdl & RPC_HDL_MASTERID_MASK) >> RPC_HDL_MASTERID_SHIFT;
                            retVal = RPC_SrvEnQ(&RPC_SrvContext.ifc[masterIfc], hdl);
                            if(BCM_ERR_OK != retVal) {
                                (void)RPC_Release(hdl);
                                RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC, retVal,(uint32_t) hdl,
                                                          (uint32_t) ifc, 0UL, (uint32_t)__LINE__);
                            } else {
                                break;
                            }
                        }
                    }

                    for(strm = 0; strm < RPC_Memory.strmCnt; strm++) {
                        hdl = RPC_SrvContext.strmhdl[strm];
                        if(RPC_HDL_INVALID != hdl) {
                            slaveIfc = (hdl & RPC_HDL_SLAVEID_MASK) >> RPC_HDL_SLAVEID_SHIFT;
                            masterIfc = (hdl & RPC_HDL_MASTERID_MASK) >> RPC_HDL_MASTERID_SHIFT;
                            if(slaveIfc == ifc) {
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus);
                                if ((NULL != interfaces[slaveIfc]->processStrm) && (BCM_STATE_SUB_STATE_DONE != slaveIfcStatus)) {
                                    streamRet = interfaces[slaveIfc]->processStrm(hdl, masterIfcStatus);
                                    if (BCM_ERR_UNKNOWN == streamRet) {
                                         RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC, BCM_ERR_UNKNOWN,(uint32_t) hdl,
                                                                (uint32_t) slaveIfc, (uint32_t) ifc,(uint32_t)__LINE__);
                                    }
                                }
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus);
                                if ((NULL != interfaces[masterIfc]->processStrm) && (BCM_STATE_SUB_STATE_DONE != masterIfcStatus)){
                                    streamRet = interfaces[masterIfc]->processStrm(hdl, slaveIfcStatus);
                                    if (BCM_ERR_UNKNOWN == streamRet) {
                                        RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC, BCM_ERR_UNKNOWN,(uint32_t) hdl,
                                                               (uint32_t) masterIfc, (uint32_t) ifc,(uint32_t)__LINE__);
                                    }
                                }
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus);
                                if ((NULL != interfaces[slaveIfc]->processStrm) && (BCM_STATE_SUB_STATE_DONE != slaveIfcStatus)) {
                                    streamRet = interfaces[slaveIfc]->processStrm(hdl, masterIfcStatus);
                                    if (BCM_ERR_UNKNOWN == streamRet) {
                                         RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC, BCM_ERR_UNKNOWN,(uint32_t) hdl,
                                                                (uint32_t) slaveIfc, (uint32_t) ifc,(uint32_t)__LINE__);
                                    }
                                }
                                /* Free up the stream handle only after both interfaces indicate complete */
                                (void)RPC_GetStreamStatus(hdl, &slaveIfcStatus, &masterIfcStatus);
                                if ((BCM_STATE_SUB_STATE_DONE == slaveIfcStatus) &&
                                    (BCM_STATE_SUB_STATE_DONE == masterIfcStatus)) {
                                    /* Free the handle in context as processing is completed */
                                    ret = RPC_Release(RPC_SrvContext.strmhdl[strm]);
                                    if (BCM_ERR_OK != ret) {
                                        RPC_SrvReportError(BRCM_SWDSGN_RPC_SRVHANDLECOMMANDS_PROC, BCM_ERR_UNKNOWN,(uint32_t) RPC_SrvContext.strmhdl[strm],
                                                               (uint32_t) slaveIfc, (uint32_t) ifc,(uint32_t)__LINE__);
                                    }
                                    RPC_SrvContext.strmhdl[strm] = RPC_HDL_INVALID;
                                }
                            }
                        }
                    }
                } while(BCM_ERR_NOT_FOUND != retVal);
            } else {
                retVal = BCM_ERR_OK;
                hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc]);
                while((BCM_ERR_OK == retVal) && (RPC_HDL_INVALID != hdl)) {
                    if(NULL != interfaces[ifc]->sendMsg) {
                        retVal = interfaces[ifc]->sendMsg(hdl);
                        if ((BCM_ERR_OK == retVal) || (BCM_ERR_UNKNOWN == retVal)) {
                            (void)RPC_SrvDeQ(&RPC_SrvContext.ifc[ifc]);
                        }
                        hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc]);
                    }
                }
            }
        }
    }
}

/**
    @brief RPC Module Reset Handler

    @code{.c}
    BCM_MemSet(&RPC_SrvContext, 0U, sizeof(RPC_SrvContextType))
    RPC_MemInit()
    retVal = Initialize all the available interfaces
    if (retVal IS BCM_ERR_OK)
        return BCM_ERR_UNKNOWN
    else
        return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
static int32_t RPC_SrvResetStateHandler(BCM_StateType aRequestedState)
{
    uint32_t ifc;
    int32_t retVal = BCM_ERR_OK;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    RPC_MemInit();
    BCM_MemSet(&RPC_SrvContext, 0U, sizeof(RPC_SrvContextType));
    for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++) {
        if ((NULL != interfaces) && (NULL != interfaces[ifc])) {
            if(NULL != interfaces[ifc]->init) {
                retVal = interfaces[ifc]->init();
            }
            if (BCM_ERR_OK != retVal) {
                break;
            }

            if(NULL != interfaces[ifc]->connect) {
                (void)interfaces[ifc]->connect();
            }
        }
    }

    return retVal;
}

/**
    @brief RPC Module Get Event Mask

    @code{.c}
    eventMask = 0
    for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++)
        if (interfaces[ifc] IS NOT NULL)
        eventMask |= interfaces[ifc]->getEventMask()
    @endcode

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
static uint32_t RPC_SrvGetEventMask(void)
{
    uint32_t ifc;
    uint32_t eventMask = 0UL;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++) {
        if ((NULL != interfaces) && (NULL != interfaces[ifc])) {
            if(NULL != interfaces[ifc]->getEventMask) {
                eventMask |= interfaces[ifc]->getEventMask();
            }
        }
    }
    eventMask |= MODULE_Event;

    return eventMask;
}

/**
    @brief RPC Module Event Handler

    @code{.c}
    for(id = 0; id < RPC_INTERFACEID_MAX; id++)
        if ((interfaces[id] IS NOT NULL)
              AND (interfaces[id]->processMsg IS NOT NULL))
            (void)interfaces[id].processMsg()

    (void)RPC_SrvHandleResponses()

    for(id = 0; id < RPC_INTERFACEID_MAX; id++)
        if ((interfaces[id] IS NOT NULL)
              AND (interfaces[id]->processMsg IS NOT NULL))
            (void)interfaces[id].processMsg()

    (void)RPC_SrvHandleCommands()
    @endcode

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
static void RPC_SrvEventHandler(uint32_t aMask)
{
    uint32_t id;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    for(id = 0UL; id < RPC_INTERFACEID_MAX; id++) {
        if ((NULL != interfaces) && (NULL != interfaces[id])
              && (NULL != interfaces[id]->processMsg)) {
            (void)interfaces[id]->processMsg();
        }
    }

    (void)RPC_SrvHandleResponses();

    for(id = 0UL; id < RPC_INTERFACEID_MAX; id++) {
        if ((NULL != interfaces) && (NULL != interfaces[id])
              && (NULL != interfaces[id]->processMsg)) {
            (void)interfaces[id]->processMsg();
        }
    }

    (void)RPC_SrvHandleCommands();
}

/**
    @brief RPC Module Ready state Handler

    @code{.c}
    if (BCM_STATE_UNINIT == aRequestedState)
        for(ifc = 0 ifc < RPC_INTERFACEID_MAX ifc++)
            if ((NULL != interfaces) && (NULL != interfaces[ifc]))
                hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc])
                if (RPC_HDL_INVALID != hdl)
                    RPC_SrvEventHandler(0UL)
                    break
        if (RPC_INTERFACEID_MAX == ifc)
            retVal = BCM_ERR_OK
     else
        retVal = BCM_ERR_OK
    return retVal
    @endcode

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
int32_t RPC_SrvReadyStateHandler(BCM_StateType aRequestedState)
{
    uint32_t ifc;
    int32_t retVal = BCM_ERR_OK;
    uint32_t hdl = RPC_HDL_INVALID;
    const RPC_InterfaceType * const *interfaces = RPC_GetModInterfaces();

    if (BCM_STATE_UNINIT == aRequestedState) {
        for(ifc = 0; ifc < RPC_INTERFACEID_MAX; ifc++) {
            if ((NULL != interfaces) && (NULL != interfaces[ifc])) {
                hdl = RPC_SrvPeekInQ(&RPC_SrvContext.ifc[ifc]);
                if (RPC_HDL_INVALID != hdl) {
                    RPC_Release(hdl);
                }
                if(NULL != interfaces[ifc]->disconnect) {
                    (void)interfaces[ifc]->disconnect();
                }
                if (NULL != interfaces[ifc]->deinit) {
                    (void)interfaces[ifc]->deinit();
                }
            }
        }
        BCM_MemSet(&RPC_SrvContext, 0U, sizeof(RPC_SrvContextType));
        RPC_MemDeinit();
    }

    return retVal;
}

/** @} */

/**
    @addtogroup grp_rpc_v2_mod_ifc
    @{
*/
/**
    @brief RPC Module

    @trace #BRCM_SWARCH_RPC_MODULE_GLOBAL
    @trace #BRCM_SWREQ_RPC_MODULE_V2
*/
const MODULE_Type RPC_Module = {
    .groupID           = BCM_GROUPID_SYS,
    .compID            = BCM_RPC_ID,
    .configImgID       = 0U,
    .configImgData     = NULL,
    .configImgSize     = 0UL,
    .context           = &RPC_SrvContext.innerContext,
    .resetStateHandler = RPC_SrvResetStateHandler,
    .initStateHandler  = NULL,
    .readyStateHandler = RPC_SrvReadyStateHandler,
    .runStateHandler   = RPC_SrvReadyStateHandler,
    .eventHandler      = RPC_SrvEventHandler,
    .sendCmd           = NULL,
    .processCmd        = NULL,
    .mergeResult       = NULL,
    .getEventMask      = RPC_SrvGetEventMask,
};
/** @} */
