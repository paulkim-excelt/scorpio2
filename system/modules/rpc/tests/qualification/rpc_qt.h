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
    @defgroup grp_rpc_v2_qt Qualification Tests
    @ingroup grp_rpc_v2

    @addtogroup grp_rpc_v2_qt
    @{

    @file rpc_qt.h
    @brief RPC Qualification Test cases
    This source file contains the test cases for RPC communication layer
    @version 0.1 Initial version
*/

#ifndef RPC_QT_H
#define RPC_QT_H
/**
    @brief RPC Master Initialization

    @pre RPC Master should be in un-initialized state

    @test Initialize RPC Master Module

    @post MsgQ Master should be initialized successfully

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_INIT                (0x201UL)

/**
    @brief RPC Master Get Max Message Size

    @pre RPC Master should be in initialized state

    @test Get RPC Master Module Message Size

    @post MsgQ Master should return the size

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_GETMSGSIZE     (0x202UL)

/**
    @brief RPC Master Send Message

    @pre RPC Master should be in initialized state

    @test RPC Send Message to MsgQ Master

    @post MsgQ Master should send the message to appropriate party

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_SENDMSG        (0x203UL)

/**
    @brief RPC Master Receive Message

    @pre RPC Master should be in initialized state

    @test RPC Receive message on MsgQ Master

    @post MsgQ Master should Receive the available message

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_RECVMSG        (0x204UL)

/**
    @brief MsgQ Master Detect Stream Test

    @pre RPC Master should be in initialized state

    @test Detect Stream on MsgQ Master

    @post MsgQ Master should detect the stream

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_DETECTSTRM     (0x206UL)

/**
    @brief MsgQ Master Process Stream Test

    @pre RPC Master should be in initialized state
    @pre Stream is detected

    @test Process Stream on RPC Master

    @post Stream of data is processed

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_PROCESSSTRM    (0x207UL)

/**
    @brief RPC Master De-Init Test

    @pre RPC Master should be in initialized state

    @test De-Init the RPC Master

    @post RPC Master DeInitialized

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MASTER_DEINIT         (0x208UL)

/**
    @brief RPC Slave Initialization

    @pre RPC Slave should be in un-initialized state

    @test Initialize RPC Slave Module

    @post MsgQ Slave should be initialized successfully

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_INIT                (0x210UL)

/**
    @brief RPC Slave Get Max Message Size

    @pre RPC Slave should be in initialized state

    @test Get RPC Slave Module Message Size

    @post MsgQ Slave should return the size

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_GETMSGSIZE     (0x211UL)

/**
    @brief RPC Slave Send Message

    @pre RPC Slave should be in initialized state

    @test RPC Send Message to MsgQ Slave

    @post MsgQ Slave should send the message to appropriate party

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_SENDMSG        (0x212UL)

/**
    @brief RPC Slave Receive Message

    @pre RPC Slave should be in initialized state

    @test RPC Receive message on MsgQ Slave

    @post MsgQ Slave should Receive the available message

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_RECVMSG        (0x213UL)

/**
    @brief MsgQ Slave Detect Stream Test

    @pre RPC Slave should be in initialized state

    @test Detect Stream on MsgQ Slave

    @post MsgQ Slave should detect the stream

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_DETECTSTRM     (0x214UL)

/**
    @brief MsgQ Slave Process Stream Test

    @pre RPC Slave should be in initialized state
    @pre Stream is detected

    @test Process Stream on RPC Slave

    @post Stream of data is processed

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_PROCESSSTRM    (0x215UL)

/**
    @brief RPC Slave De-Init Test

    @pre RPC Slave should be in initialized state

    @test De-Init the RPC Slave

    @post RPC Slave DeInitialized

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_SLAVE_DEINIT         (0x216UL)

/**
    @brief RPC Send Message to MsgQ Slave

    @pre RPC Slave should be in initialized state

    @test Send Message To MsgQ Slave

    @post Message send to Slave successfully

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MSGQ_SEND_TO_SLAVE         (0x217UL)


/**
    @brief RPC Receive Message From MsgQ Slave

    @pre RPC Slave should be in initialized state

    @test Receive Message From MsgQ Slave

    @post Successfully Received Message from Slave

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_RPC_INTERFACE_LOCAL
*/
#define BRCM_SWQTST_RPC_MSGQ_RECV_FROM_SLAVE         (0x218UL)

/** @brief RPC Test sequence 2

    This sequence tests the operation of RPC Master Module Command

    @code{.c}
    -# Initialise RPC Master through #BRCM_SWQTST_RPC_MASTER_INIT <BR>
    -# Send Message #BRCM_SWQTST_RPC_MASTER_SENDMSG <BR>
    -# Receive Message #BRCM_SWQTST_RPC_MASTER_RECVMSG <BR>
    -# DeInitialization #BRCM_SWQTST_RPC_MASTER_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_V2_SEQ2               (0x2F1UL)

/** @brief RPC Test sequence 3

    This sequence tests the operation of RPC Master Interface stream

    @code{.c}
    -# Initialise RPC Master through #BRCM_SWQTST_RPC_MASTER_INIT <BR>
    -# Detect Stream #BRCM_SWQTST_RPC_MASTER_DETECTSTRM <BR>
    -# Process Stream #BRCM_SWQTST_RPC_MASTER_PROCESSSTRM <BR>
    -# DeInitialization #BRCM_SWQTST_RPC_MASTER_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_V2_SEQ3               (0x2F2UL)

/** @brief RPC Test sequence 4

    This test sends the command to slave interface

    @code{.c}
    -# Initialise RPC Slave through #BRCM_SWQTST_RPC_SLAVE_INIT <BR>
    -# Send Message #BRCM_SWQTST_RPC_SLAVE_SENDMSG <BR>
    -# Receive Message #BRCM_SWQTST_RPC_SLAVE_RECVMSG <BR>
    -# DeInitialize #BRCM_SWQTST_RPC_SLAVE_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_V2_SEQ4               (0x2F3UL)


/** @brief RPC Test sequence 5

    This test sends the local command to slave interface

    @code{.c}
    -# Initialise RPC Slave through #BRCM_SWQTST_RPC_SLAVE_INIT <BR>
    -# Send Message to Slave #BRCM_SWQTST_RPC_MSGQ_SEND_TO_SLAVE <BR>
    -# Receive Message on Slave #BRCM_SWQTST_RPC_SLAVE_RECVMSG <BR>
    -# Send response on Slave #BRCM_SWQTST_RPC_SLAVE_SENDMSG <BR>
    -# Receive response from Slave #BRCM_SWQTST_RPC_MSGQ_RECV_FROM_SLAVE <BR>
    -# DeInitialize #BRCM_SWQTST_RPC_SLAVE_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    1S

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_V2_SEQ5               (0x2F4UL)


/** @brief RPC Test sequence 6

    This sequence tests the operation of RPC Slave Module

    @code{.c}
    -# Initialise RPC Slave through #BRCM_SWQTST_RPC_SLAVE_INIT <BR>
    -# create a file <BR>
    -# Allocate the stream handle with <BR>
       cfg.pid = 0x5
       cfg.imgId = 0xFF00
       cfg.offset = 0x0
       cfg.isTbl = FALSE
       cfg.xferSize = sizeof(file)
       cfg.blkSize = 0x400
       cfg.isRead = TRUE
    -# Process Stream #BRCM_SWQTST_RPC_SLAVE_PROCESSSTRM for the above handle <BR>
    -# copy the data to a local buffer <BR>
    -# Compare the copied buffer <BR>
    -# DeInitialization #BRCM_SWQTST_RPC_SLAVE_DEINIT <BR>
    @endcode

    @board bcm8956x

    @auto           Yes

    @type           Sanity

    @executetime    3s

    @analyzetime    1d
*/
#define BRCM_SWQTSEQ_RPC_V2_SEQ6               (0x2F5UL)
#endif /* RPC_QT_H */
/** @} */
