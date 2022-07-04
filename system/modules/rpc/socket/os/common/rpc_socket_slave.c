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
    @defgroup grp_rpc_socket_slave_impl Socket Slave Design
    @ingroup grp_rpc_v2_socket

    @addtogroup grp_rpc_socket_slave_impl
    @{

    @file rpc_socket_slave.c
    @brief Socket Slave Module Implementation

    @version 0.1 Initial Version
*/
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <bcm_comp.h>
#include <rpc_mem.h>
#include <rpc_interface.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <errno.h>
#include <sys/unistd.h>
#include <cpu.h>

/**
    @name RPC Socket Slave module Design IDs
    @{
    @brief Design IDs for RPC Socket slave module
*/
#define BRCM_SWDSGN_RPC_SOCKETSLAVECONTEXT_GLOBAL      (0xA501U)    /**< @brief #RPC_SocketSlaveCtxt */
#define BRCM_SWDSGN_RPC_SOCKETSLAVECONTEXT_TYPE        (0xA502U)    /**< @brief #RPC_SocketSlaveContextType */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEINIT_PROC           (0xA503U)    /**< @brief #RPC_SocketSlaveInit */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEISCONNECTED_PROC    (0xA504U)    /**< @brief #RPC_SocketSlaveIsConnected */
#define BRCM_SWDSGN_RPC_SOCKETSLAVECONNECT_PROC        (0xA505U)    /**< @brief #RPC_SocketSlaveConnect */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEGETEVENTMASK_PROC   (0xA506U)    /**< @brief #RPC_SocketSlaveGetEventMask */
#define BRCM_SWDSGN_RPC_SOCKETSLAVESENDMSG_PROC        (0xA507U)    /**< @brief #RPC_SocketSlaveSendMsg */
#define BRCM_SWDSGN_RPC_SOCKETSLAVERECVMSG_PROC        (0xA508U)    /**< @brief #RPC_SocketSlaveRecvMsg */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEDISCONNECT_PROC     (0xA509U)    /**< @brief #RPC_SocketSlaveDisconnect */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEDEINIT_PROC         (0xA50AU)    /**< @brief #RPC_SocketSlaveDeinit */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEIFC_GLOBAL          (0xA50BU)    /**< @brief #RPC_SocketSlaveIfc */
#define BRCM_SWDSGN_RPC_SOCKETSLAVEGETFREESLOT_PROC    (0xA50CU)    /**< @brief #RPC_SocketSlaveGetFreeSlot */
#define BRCM_SWDSGN_RPC_SOCKETACCEPTCLIENT_PROC        (0xA50DU)    /**< @brief #RPC_SocketAcceptClient */
/** @} */

/**
    @brief RPC Socket slave Context type

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE
*/
typedef struct sRPC_SocketSlaveContextType {
    RPC_InterfaceIdType      selfId;                /**< @brief This Module Interface ID       */
    RPC_InterfaceIdType      peerId;                /**< @brief Connected Master ID            */
    RPC_AssociationIndexType assocId;               /**< @brief This Module Association ID     */
    int32_t                  serverFd;              /**< @brief Server socket FD               */
    uint32_t                 clientFDUsageMask;     /**< @brief Client FD list usage bit mask  */
    uint32_t                 nextClientIndex;       /**< @brief Next client FD index on which
                                                         we need to receive data               */
    uint32_t                 clientFD[RPC_SOCK_CLIENT_MAX_FD];
                                                    /**< @brief Cliend FD list                 */
} RPC_SocketSlaveContextType;

/**
    @brief RPC Socket slave Context

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE
*/
static RPC_SocketSlaveContextType RPC_SocketSlaveCtxt COMP_SECTION(".bss.rpc");

/** @brief Get a free slot to store client FD

    This API identifies a free slot in the pool of FDs and returns the
    index

    @behavior Sync, Re-entrant

    @pre None

    @param[out] aIndex      Pointer to retrieve message index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK       Free slot identified and pointer filled
    @retval     #BCM_ERR_NOMEM    No free slot found

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.c}
    int32_t retVal = BCM_ERR_NOMEM <BR>
    uint32_t index <BR>
    index = CPU_Clz(CPU_BitReverse(RPC_SocketSlaveCtxt.clientFDUsageMask ^ 0xFFFFFFFFUL)); <BR>
    if (RPC_SOCK_CLIENT_MAX_FD > index) <BR>
        *aIndex = index <BR>
        retVal = BCM_ERR_OK <BR>
    return retVal <BR>
    @endcode
*/
static int32_t RPC_SocketSlaveGetFreeSlot(uint32_t *aIndex)
{
    int32_t retVal = BCM_ERR_NOMEM;
    uint32_t index;
    index = CPU_Clz(CPU_BitReverse(RPC_SocketSlaveCtxt.clientFDUsageMask ^ 0xFFFFFFFFUL));
    if (RPC_SOCK_CLIENT_MAX_FD > index) {
        *aIndex = index;
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

/** @brief Get a free slot to store client FD

    This API receives a new client connection and updates its
    file descriptor into context

    @behavior Sync, Re-entrant

    @pre None

    @param void

    @retval     void

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.c}
    uint32_t index = 0UL <BR>
    do <BR>
        retVal = RPC_SocketSlaveGetFreeSlot(&index) <BR>
        if (BCM_ERR_OK == retVal) <BR>
            client_fd = accept(RPC_SocketSlaveCtxt.serverFd, (struct sockaddr *)&remote, &t) <BR>
            if (client_fd < 0L) <BR>
                retVal = BCM_ERR_NOT_FOUND <BR>
            else <BR>
                RPC_SocketSlaveCtxt.clientFD[index] = client_fd <BR>
                RPC_SocketSlaveCtxt.clientFDUsageMask |= (1UL << index) <BR>
                retVal = BCM_ERR_OK <BR>
    while (BCM_ERR_OK == retVal) <BR>
    return <BR>
    @endcode
*/
static void RPC_SocketAcceptClient(void)
{
    struct sockaddr_un remote;
    socklen_t temp = 0L;
    int32_t clientFD;
    uint32_t index = 0UL;
    int32_t retVal;

    do {
        retVal = RPC_SocketSlaveGetFreeSlot(&index);
        if (BCM_ERR_OK == retVal) {
            clientFD = accept(RPC_SocketSlaveCtxt.serverFd, (struct sockaddr *)&remote, &temp);
            if (clientFD < 0L) {
                retVal = BCM_ERR_NOT_FOUND;
            } else {
                RPC_SocketSlaveCtxt.clientFD[index] = clientFD;
                RPC_SocketSlaveCtxt.clientFDUsageMask |= (1UL << index);
                retVal = BCM_ERR_OK;
            }
        }
    } while (BCM_ERR_OK == retVal);

    return;
}

/** @brief RPC Socket Slave Module Initialization

    Function to initialize the Socket Slave Module

    @behavior Sync, Non-Reentrant

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Init successful
    @retval     #BCM_ERR_UNKNOWN        Init Failed

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @limitations None

    @code{.unparsed}
    int32_t retVal = BCM_ERR_OK
    struct sockaddr_un local
    uint32_t len

    if (NULL != getenv("RPCUTIL_INSTANCE")) {
        sprintf(env, "_%s", getenv("RPCUTIL_INSTANCE"));
    }
    strcpy(sockName, RPC_SOCKETSLAVE_IFC_NAME);
    strcat(sockName, env);

    BCM_MemSet(&RPC_SocketSlaveCtxt, 0U, sizeof(RPC_SocketSlaveCtxt))
    strcpy(local.sun_path, sockName);
    local.sun_family = AF_UNIX
    unlink(local.sun_path)
    len = strlen(local.sun_path) + sizeof(local.sun_family)

    RPC_SocketSlaveCtxt.serverFd = socket(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0)
    if (-1 == RPC_SocketSlaveCtxt.serverFd)
        log error
        retVal = BCM_ERR_UNKNOWN
    else
        if (bind(RPC_SocketSlaveCtxt.serverFd, (struct sockaddr *)&local, len) == -1)
            log error
            retVal = BCM_ERR_UNKNOWN

        if (listen(RPC_SocketSlaveCtxt.serverFd, RPC_SOCKETSLAVE_COUNT_CONNECTIONS) == -1)
            perror("listen")
            retVal = BCM_ERR_UNKNOWN

    if (BCM_ERR_OK == retVal)
        retVal = RPC_GetModIfcAndAssoc(&RPC_SocketSlaveIfc, &RPC_SocketSlaveCtxt.selfId,
                                       &RPC_SocketSlaveCtxt.peerId,
                                       &RPC_SocketSlaveCtxt.assocId)
    return retVal
    @endcode
*/
static int32_t RPC_SocketSlaveInit(void)
{
    int32_t retVal = BCM_ERR_OK;
    struct sockaddr_un local;
    uint32_t len;
    char env[100] = "";
    char sockName[100];

    if (NULL != getenv("RPCUTIL_INSTANCE")) {
        sprintf(env, "_%s", getenv("RPCUTIL_INSTANCE"));
    }
    strcpy(sockName, RPC_SOCKETSLAVE_IFC_NAME);
    strcat(sockName, env);

    BCM_MemSet(&RPC_SocketSlaveCtxt, 0U, sizeof(RPC_SocketSlaveCtxt));
    local.sun_family = AF_UNIX;
    printf("sockName = %s \n",sockName);
    strcpy(local.sun_path, sockName);
    unlink(local.sun_path);
    len = strlen(local.sun_path) + sizeof(local.sun_family);

    RPC_SocketSlaveCtxt.serverFd = socket(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0);
    if (-1 == RPC_SocketSlaveCtxt.serverFd) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        if (bind(RPC_SocketSlaveCtxt.serverFd, (struct sockaddr *)&local, len) == -1) {
            retVal = BCM_ERR_UNKNOWN;
        }
        if (listen(RPC_SocketSlaveCtxt.serverFd, RPC_SOCK_CLIENT_MAX_FD) == -1) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    if (BCM_ERR_OK == retVal) {
        retVal = RPC_GetModIfcAndAssoc(&RPC_SocketSlaveIfc, &RPC_SocketSlaveCtxt.selfId,
                                       &RPC_SocketSlaveCtxt.peerId,
                                       &RPC_SocketSlaveCtxt.assocId);
    }
    return retVal;
}

/** @brief RPC Socket Slave Module connection status

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.unparsed}
    return TRUE
    @endcode
*/
static uint32_t RPC_SocketSlaveIsConnected(void)
{
    return TRUE;
}

/** @brief RPC Socket Slave Module Connect

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_SocketSlaveConnect(void)
{
    return BCM_ERR_OK;
}

/** @brief Get the event mask for the module

    API to return the event mask for the module.

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.unparsed}
    @endcode
*/
static uint32_t RPC_SocketSlaveGetEventMask(void)
{
    return 0UL;
}

/** @brief RPC Socket Slave Module Send message

    Module Function to send response/async message

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @limitations None

    @code{.unparsed}
    retVal = BCM_ERR_UNKNOWN
    msg = RPC_MsgGet(aHdl)
    if (NULL != msg)
        msg->magic = RPC_MEMMSG_MAGIC
        retVal = RPC_MemPopAppInfo(aHdl, &client_fd)
        if (BCM_ERR_OK == retVal)
            retVal = send(client_fd, msg, sizeof(RPC_MemMsgType))
            if (retVal < 0L)
                retVal = BCM_ERR_UNKNOWN
            else
                retVal = BCM_ERR_OK
        rpc_release(*aHdl)
    return retVal
    @endcode
*/
static int32_t RPC_SocketSlaveSendMsg(RPC_HdlType aHdl)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    RPC_MemMsgType *msg = NULL;
    uint32_t client_fd = -1L;

    msg = RPC_MsgGet(aHdl);
    if (NULL != msg) {
        msg->magic = RPC_MEMMSG_MAGIC;
        retVal = RPC_MemPopAppInfo(aHdl, &client_fd);
        if (BCM_ERR_OK == retVal) {
            retVal = send(client_fd, msg, sizeof(RPC_MemMsgType), 0L);
            if (retVal < 0L) {
                retVal = BCM_ERR_UNKNOWN;
            } else {
                retVal = BCM_ERR_OK;
            }
        }
        RPC_Release(aHdl);
    }
    return retVal;
}

/** @brief RPC Socket Slave Module Receive Message

    Module function used to receive command message.
    Client to invoke this API until #BCM_ERR_NOT_FOUND is got

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.unparsed}
    int32_t retVal
    uint32_t index
    uint32_t loopCnt = 0UL
    uint32_t packetLen = sizeof(RPC_MemMsgType)

    receive new client connections
    RPC_SocketAcceptClient()

    if (NULL == aHdl)
        retVal = BCM_ERR_UNKNOWN
    else
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_SocketSlaveCtxt.selfId,
                              RPC_SocketSlaveCtxt.peerId,
                              RPC_SocketSlaveCtxt.assocId,
                              aHdl)
        if (BCM_ERR_OK == retVal)
            msgType = RPC_MsgGet(aHdl)
            do
                prevMask = RPC_SocketSlaveCtxt.clientFDUsageMask
                loopCnt = 0UL
                retVal = BCM_ERR_NOT_FOUND
                We check for data on all clients in a round-robin manner
                to give equal priority to all clients
                for (index = (RPC_SocketSlaveCtxt.nextClientIndex % RPC_SOCK_CLIENT_MAX_FD)
                     loopCnt < RPC_SOCK_CLIENT_MAX_FD
                     index = ((index+1UL) % RPC_SOCK_CLIENT_MAX_FD), loopCnt++)

                    Update the next client FD that needs to be used
                    RPC_SocketSlaveCtxt.nextClientIndex = index + 1UL

                    If there is no active client at 'index', then continue & check on others
                    if (0UL == (RPC_SocketSlaveCtxt.clientFDUsageMask & (1U << index)))
                        continue

                    Receive data from client
                    retVal = recv(RPC_SocketSlaveCtxt.clientFD[index], (uint8_t*)msgType, packetLen, MSG_DONTWAIT)
                    if (retVal <= 0L)
                        If there is no data received, then check if client is active by sending a packet of length 0
                        retVal = send(RPC_SocketSlaveCtxt.clientFD[index], msgType, 0UL , MSG_NOSIGNAL | MSG_DONTWAIT)
                        if (retVal < 0L)
                            RPC_SocketSlaveCtxt.clientFDUsageMask &= ((1UL << index) ^ 0xFFFFFFFFUL)
                            close(RPC_SocketSlaveCtxt.clientFD[index])
                            Since a slot was freed, check for any new client connections
                            RPC_SocketAcceptClient()
                        no data received
                        retVal = BCM_ERR_NOT_FOUND
                     else
                        Push the client_fd into handle, used when sending response
                        retVal = RPC_MemPushAppInfo(*aHdl, RPC_SocketSlaveCtxt.clientFD[index])
                        if (BCM_ERR_OK == retVal)
                            aHdl already holds valid handle
                            retVal = BCM_ERR_OK
                         else
                            retVal = BCM_ERR_UNKNOWN
                        break
            In case any new client/s were connected, recheck for data on all client FDs
            while ((prevMask != RPC_SocketSlaveCtxt.clientFDUsageMask) && (BCM_ERR_OK != retVal))

            if (BCM_ERR_OK != retVal)
                RPC_Release(*aHdl)
        else
            retVal = BCM_ERR_NOMEM
    return retVal
    @endcode
*/
static int32_t RPC_SocketSlaveRecvMsg(RPC_HdlType* const aHdl)
{
    int32_t retVal = BCM_ERR_EAGAIN;
    uint32_t index;
    uint32_t loopCnt = 0UL;
    uint32_t prevMask = 0UL;
    uint32_t packetLen = sizeof(RPC_MemMsgType);
    RPC_MemMsgType *msgType;

    /* Receive new client connections */
    RPC_SocketAcceptClient();

    if (NULL == aHdl) {
        retVal = BCM_ERR_UNKNOWN;
    } else {
        retVal = RPC_MsgAlloc(RPC_HDL_INVALID,
                              RPC_SocketSlaveCtxt.selfId,
                              RPC_SocketSlaveCtxt.peerId,
                              RPC_SocketSlaveCtxt.assocId,
                              aHdl);
        if (BCM_ERR_OK == retVal) {
            msgType = RPC_MsgGet(*aHdl);

            do {
                prevMask = RPC_SocketSlaveCtxt.clientFDUsageMask;
                loopCnt = 0UL;
                /* In case no clients are connected, then we wont enter below loop */
                /* Updating error for such a case                                  */
                retVal = BCM_ERR_NOT_FOUND;

                /* We check for data on all clients in a round-robin manner */
                /* to give equal priority to all clients                    */
                for (index = (RPC_SocketSlaveCtxt.nextClientIndex % RPC_SOCK_CLIENT_MAX_FD);
                     loopCnt < RPC_SOCK_CLIENT_MAX_FD;
                     index = ((index+1UL) % RPC_SOCK_CLIENT_MAX_FD), loopCnt++) {

                    /* Update the next client FD that needs to be used */
                    RPC_SocketSlaveCtxt.nextClientIndex = index + 1UL;

                    /* If there is no active client at 'index', then continue & check on others */
                    if (0UL == (RPC_SocketSlaveCtxt.clientFDUsageMask & (1U << index))) {
                        continue;
                    }

                    /* Receive data from client */
                    retVal = recv(RPC_SocketSlaveCtxt.clientFD[index], (uint8_t*)msgType, packetLen, MSG_DONTWAIT);
                    if (retVal <= 0L) {
                        /* If there is no data received, then check if client is active by sending a packet of length 0 */
                        retVal = send(RPC_SocketSlaveCtxt.clientFD[index], msgType, 0UL , MSG_NOSIGNAL | MSG_DONTWAIT);
                        if (retVal < 0L) {
                            RPC_SocketSlaveCtxt.clientFDUsageMask &= ((1UL << index) ^ 0xFFFFFFFFUL);
                            close(RPC_SocketSlaveCtxt.clientFD[index]);

                            /* Since a slot was freed, check for any new client connections */
                            RPC_SocketAcceptClient();
                        }
                        /* no data received */
                        retVal = BCM_ERR_NOT_FOUND;
                    } else {
                        /* Push the client_fd into handle, used when sending response */
                        retVal = RPC_MemPushAppInfo(*aHdl, RPC_SocketSlaveCtxt.clientFD[index]);
                        if (BCM_ERR_OK == retVal) {
                            /* aHdl already holds valid handle */
                            retVal = BCM_ERR_OK;
                        } else {
                            retVal = BCM_ERR_UNKNOWN;
                        }
                        break;
                    }
                }
            /* In case any new client/s were connected, recheck for data on all client FDs */
            } while ((prevMask != RPC_SocketSlaveCtxt.clientFDUsageMask) && (BCM_ERR_OK != retVal));

            if (BCM_ERR_OK != retVal) {
                RPC_Release(*aHdl);
            }
        } else {
            retVal = BCM_ERR_NOMEM;
        }
    }
    return retVal;

}

/** @brief RPC Socket Slave Module Disconnect

    @behavior Sync, Non-Reentrant

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.unparsed}
    return BCM_ERR_OK
    @endcode
*/
static int32_t RPC_SocketSlaveDisconnect(void)
{
    return BCM_ERR_OK;
}

/** @brief RPC Socket Slave Module channel de-initialization

    This API used to deinitialize the Socket Slave Module

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE

    @code{.unparsed}
    for (index = 0UL;
        (index < RPC_SOCK_CLIENT_MAX_FD) && (0UL != (RPC_SocketSlaveCtxt.clientFDUsageMask & (1U << index)));
         index++)
        close(RPC_SocketSlaveCtxt.clientFD[index])
    close(RPC_SocketSlaveCtxt.serverFD)
    BCM_MemSet(RPC_SocketSlaveCtxt, 0U, sizeof(RPC_SocketSlaveCtxt))
    @endcode
*/
static void RPC_SocketSlaveDeinit(void)
{
    uint32_t index;
    for (index = 0UL;
        (index < RPC_SOCK_CLIENT_MAX_FD) && (0UL != (RPC_SocketSlaveCtxt.clientFDUsageMask & (1U << index)));
         index++) {
        close(RPC_SocketSlaveCtxt.clientFD[index]);
    }
    close(RPC_SocketSlaveCtxt.serverFd);
    BCM_MemSet(&RPC_SocketSlaveCtxt, 0U, sizeof(RPC_SocketSlaveCtxt));
    return;
}

/** @brief Socket Slave Module interface structure

    @trace #BRCM_SWARCH_RPC_SOCKETSLAVEIFC_GLOBAL
    @trace #BRCM_SWREQ_RPC_INTERFACE_SOCKET_SLAVE
*/
const RPC_InterfaceType RPC_SocketSlaveIfc = {
    .type          = RPC_IFC_CHAN_SOCKET,
    .mode          = RPC_IFC_CHAN_MODE_SLAVE,
    .init          = RPC_SocketSlaveInit,
    .isConnected   = RPC_SocketSlaveIsConnected,
    .connect       = RPC_SocketSlaveConnect,
    .sendMsg       = RPC_SocketSlaveSendMsg,
    .recvMsg       = RPC_SocketSlaveRecvMsg,
    .disconnect    = RPC_SocketSlaveDisconnect,
    .getEventMask  = RPC_SocketSlaveGetEventMask,
    .deinit        = RPC_SocketSlaveDeinit,
};

/** @} */
