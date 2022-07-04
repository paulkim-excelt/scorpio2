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
    @defgroup grp_msg_queue_qt MSG Queue Qualification Test
    @ingroup grp_timdrv

    @addtogroup grp_msg_queue_qt
    @{

    @file msg_queue_qt.h

    @board

    @brief MSG Queue qualification Test
    This source file contains the qualification test for MSG Queue
    @version 0.1 Initial draft
*/

#ifndef MSG_QUEUE_QT_H
#define MSG_QUEUE_QT_H

/**
   @brief Get msg index in server task

   @pre msg is posted and server event is received from client

   @test Call MSGQ_GetMsgIdx

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_GET_MSG_IDX_POS                              (0x0001UL)

/**
   @brief Complete msg index in server task

   @pre msg is received in server

   @test Call MSGQ_CompleteMsgIdx

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_COMPLETE_MSG_IDX_POS                         (0x0002UL)

/**
   @brief Send msg to server task

   @pre Server task is running

   @test Call MSGQ_SendMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_SEND_MSG_POS                                 (0x0003UL)

/**
   @brief Receive msg from server task

   @pre Server notification is received

   @test Call MSGQ_RecvMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_RECV_MSG_POS                                 (0x0004UL)

/**
   @brief Send msg to server task from client 2

   @pre Server task is running

   @test Call MSGQ_SendMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_SEND_MSG_POS_2                               (0x0005UL)

/**
   @brief Receive msg from server task in client 2

   @pre Server notification is received

   @test Call MSGQ_RecvMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_RECV_MSG_POS_2                               (0x0006UL)

/**
   @brief Get msg in server task in client in context

   @pre Server notification is received

   @test Call MSGQ_CtxGetMsgIdx

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_GET_MSG_IDX_POS                          (0x0007UL)

/**
   @brief Complete msg in server task in client in context

   @pre msg index is found and server response is updated

   @test Call MSGQ_CtxCompleteMsgIdx

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_COMPLETE_MSG_IDX_POS                     (0x0008UL)

/**
   @brief Create msg context in client

   @pre NA

   @test Call MSGQ_CtxCreate

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_CREATE_POS                               (0x0009UL)

/**
   @brief Send msg in client with context

   @pre Server task is running

   @test Call MSGQ_CtxSendMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_SEND_POS                                 (0x000AUL)

/**
   @brief Receive msg in client with context

   @pre Server task is running

   @test Call MSGQ_CtxRecvMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_RECV_POS                                 (0x000BUL)

/**
   @brief Destroy msg context in client

   @pre Server task is running

   @test Call MSGQ_CtxDestroy

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_DESTROY_POS                              (0x000CUL)

/**
   @brief Create msg context in client 2

   @pre NA

   @test Call MSGQ_CtxCreate

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_CREATE_POS_2                             (0x000DUL)

/**
   @brief Send msg in client 2 with context

   @pre Server task is running

   @test Call MSGQ_CtxSendMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_SEND_POS_2                               (0x000EUL)

/**
   @brief Receive msg in client 2 with context

   @pre Server task is running

   @test Call MSGQ_CtxRecvMsg

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_RECV_POS_2                               (0x000FUL)

/**
   @brief Destroy msg context in client 2

   @pre Server task is running

   @test Call MSGQ_CtxDestroy

   @post BCM_ERR_OK should be returned

   @functional Yes

   @type pos

   @trace #BRCM_SWREQ_MSGQ_USER_INTERFACE
*/
#define BRCM_SWQTST_MSGQ_CTX_DESTROY_POS_2                            (0x0010UL)

/** @brief Qualification test sequence to test the message queue with
           client notifcation enabled.

   @code{.c}

   Start Server Task MsgQQT1_ServerTask
      - wait for MsgQQT1_TriggerServer
      - call MSGQ_GetMsgIdx,
        check for expected result as per #BRCM_SWQTST_MSGQ_GET_MSG_IDX_POS
      - update server response
      - call MSGQ_CompleteMsgIdx,
        check for expected result as per #BRCM_SWQTST_MSGQ_COMPLETE_MSG_IDX_POS

   Start Client Task  MsgQQT1_TaskClient1 and loop 10 times,
      - update command in msg
      - call MSGQ_SendMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_SEND_MSG_POS
      - wait for notification MsgQQT1_TriggerClient1
      - call MSGQ_RecvMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_RECV_MSG_POS

   Start Client Task  MsgQQT1_TaskClient2
      - update command in msg
      - call MSGQ_SendMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_SEND_MSG_POS_2
      - wait for notification MsgQQT1_TriggerClient1
      - call MSGQ_RecvMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_RECV_MSG_POS_2

   Verifiy both the clients received all msg responses

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MSGQ_EN_NOTIF_1                                  (0x0001UL)

/** @brief Qualification test sequence to test the message queue with
           client notifcation disabled.

   @code{.c}

   Start Server Task MsgQQT2_ServerTask, in loop
      - wait for MsgQQT2_TriggerServer
      - call MSGQ_GetMsgIdx
      - call MSGQ_CompleteMsgIdx

   Start Client Task  MsgQQT1_TaskClient1 and loop 10 times,
      - update pktNo in msg
      - call MSGQ_SendMsg

   Start Client Task  MsgQQT1_TaskClient2
      - update pktNo in msg
      - call MSGQ_SendMsg

   Verifiy both the clients received all msg responses

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_2                                 (0x0002UL)

/** @brief Qualification test sequence to test the message queue with
           client notifcation disabled.

   @code{.c}

   Start Server Task MsgQQT3_ServerTask, in loop
      - wait for MsgQQT3_TriggerServer
      - call MSGQ_GetMsgIdx
      - call MSGQ_CompleteMsgIdx

   Start Client Task  MsgQQT3_TaskClient1 and loop 10 times,
      - update pktNo in msg
      - call MSGQ_SendMsg

   Start Client Task  MsgQQT3_TaskClient2
      - update pktNo in msg
      - call MSGQ_SendMsg

   Verifiy both the clients received all msg responses

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MSGQ_DIS_NOTIF_3                                 (0x0003UL)

/** @brief Qualification test sequence to test the message queue with
           client notifcation enabled with conext.

   @code{.c}

   Start Server Task MsgQQT4_ServerTask
      - wait for MsgQQT4_TriggerServer
      - call MSGQ_CtxGetMsgIdx,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_GET_MSG_IDX_POS
      - update server response
      - call MSGQ_CtxCompleteMsgIdx,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_COMPLETE_MSG_IDX_POS

   Start Client Task  MsgQQT4_TaskClient1 and loop 10 times,
      - call MSGQ_CtxCreate,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_CREATE_POS
      - update command in msg
      - call MSGQ_CtxSendMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_SEND_POS
      - wait for notification MsgQQT4_TriggerClient1
      - call MSGQ_CtxRecvMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_RECV_POS
      - call MSGQ_CtxDestroy,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_DESTROY_POS

   Start Client Task  MsgQQT4_TaskClient2
      - call MSGQ_CtxCreate,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_CREATE_POS_2
      - update command in msg
      - call MSGQ_CtxSendMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_SEND_POS_2
      - wait for notification MsgQQT4_TriggerClient2
      - call MSGQ_CtxRecvMsg,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_RECV_POS_2
      - call MSGQ_CtxDestroy,
        check for expected result as per #BRCM_SWQTST_MSGQ_CTX_DESTROY_POS_2

   Verifiy both the clients received all msg responses

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1h
*/
#define BRCM_SWQTSEQ_MSGQ_EN_NOTIF_4                                  (0x0004UL)

#endif /* MSG_QUEUE_QT_H */
