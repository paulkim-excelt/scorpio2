/*****************************************************************************
 Copyright 2019-2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_tftp_qt Qualification Tests
    @ingroup grp_tftp

    @addtogroup grp_tftp_qt
    @{

    @file tftp_qt.h
    @brief TFTP Component Qualification Test cases
    This source file contains the test cases for TFTP library
    @version 0.1 Initial version
*/

#ifndef TFTP_QT_H
#define TFTP_QT_H

/**
    @brief Configuration of TFTP contexts

    @pre TFTP context should be in #TFTP_STATE_RESET state and
    TFTP_MAX_DATA_LEN should be configured by application

    @test The #TFTP_Init should be invoked for the initializing
    the readConnection and writeConnection with passed TFTP block size.

    @post The TFTP_Init API should succeed and the library contexts
    should be in INIT state

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_TFTP
*/
#define BRCM_SWQTST_TFTP_CONFIG_CASE0    (0x101UL)

/**
    @brief TFTP protocol operation

    @pre readConnection and writeConnection should be in #TFTP_STATE_INIT condition.

    @test Setup the write and read connection requests. Invoke the
    #TFTP_PutDataHandler for the write connection to send out the
    data payload. Later invoke #TFTP_GetDataHandler to fetch the earlier
    written file.

    @post The received data must match with the earlier written data.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_TFTP
*/
#define BRCM_SWQTST_TFTP_CONFIG_CASE1    (0x102UL)

/**
    @brief TFTP protocol operation

    @pre readConnection and writeConnection should be in #TFTP_STATE_INIT condition.

    @test Setup the TFTP server and wait for incoming requests. On a write
    request, get the data from remote client and write into memory. On a
    read request to server, transmit the file to client.

    @post Both write and read operation from client should succeed and
    data written must match with data received.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_TFTP
*/
#define BRCM_SWQTST_TFTP_CONFIG_CASE2    (0x103UL)

/** @brief TFTP Test sequence 0

    This sequence tests the TFTP protocol operation for TFTP client
    operation.

    @code{.c}
    Test needs to be run for two TFTP block size - 512 & 1428 bytes
    configure the TFTP connections for 512/1428 bytes
    Check expected result for #BRCM_SWQTST_TFTP_CONFIG_CASE0
    Prepare a test payload
    Write the payload to remote TFTP server
    Check Expected Result for #BRCM_SWQTST_TFTP_CONFIG_CASE1
    Create a buffer to receive file from remote end
    Place a read request to remote TFTP server
    Receive incoming payload
    Check Expected Result for #BRCM_SWQTST_TFTP_CONFIG_CASE1
    Compare the payload from read request with the test payload
    repeat test for the other block size
    @endcode

    @board bcm8910x

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_TFTP_CONFIG_CASE0
    @testproc #BRCM_SWQTST_TFTP_CONFIG_CASE1

*/
#define BRCM_SWQTSEQ_TFTP_SEQ0           (0x104UL)

/** @brief TFTP Test sequence 1

    This sequence tests the TFTP protocol operation for TFTP server
    operation.

    @code{.c}
    Wait for requests from remote clients
    On a request, detect if its read/write request
    configure the TFTP connection based on the block size requested by client
    Check expected result for #BRCM_SWQTST_TFTP_CONFIG_CASE0
    If write, provide an empty buffer and fetch data from client
    If read, provide data to remote client
    Verify that return status is OK for #BRCM_SWQTST_TFTP_CONFIG_CASE2
    @endcode

    @board bcm8910x

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_TFTP_CONFIG_CASE0
    @testproc #BRCM_SWQTST_TFTP_CONFIG_CASE2

*/
#define BRCM_SWQTSEQ_TFTP_SEQ1           (0x105UL)

#endif /* TFTP_QT_H */

/** @} */
