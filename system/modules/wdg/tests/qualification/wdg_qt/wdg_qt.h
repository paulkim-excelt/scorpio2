/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_wdg_qt Qualification Tests
    @ingroup grp_wdg

    @addtogroup grp_wdg_qt
    @{

    @file wdg_qt.h
    @brief WDG Component Qualification Test cases
    This source file contains the test cases for Watchdog Module
    @version 0.1 Initial version
*/

#ifndef WDG_QT_H
#define WDG_QT_H

/**
    @brief WDG Client Logical Monitoring

    @pre Enable a Supervision Entity with a valid state transition of
    [(0) -> (1) -> (2)].

    @test On an event, notify a new state and transition through
    complete graph.

    @post #WDG_NotifyState should always return #BCM_ERR_OK.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_CLIENT_1               (0x101UL)

/**
    @brief WDG Client Logical, Frequency & Deadline Monitoring

    @pre Enable a Supervision Entity with a valid state transition of
    {{1U, 2U}, {2U, 3U}, {3U, WDG_INVALID_GRAPH_BUF_ENTRY},
    {0U, WDG_INVALID_GRAPH_BUF_ENTRY}}. Deadline of 60ms and frequency
    values of min=2 and max=3 for the SE is set.

    @test on an event, notify a new state and transition through
    graph sequence [(0) -> (2) -> (3) -> (0) -> (1) -> (3) -> (0) ->
    (1) -> (2) -> (3)]

    @post #WDG_NotifyState should always return #BCM_ERR_OK.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_CLIENT_2               (0x102UL)

/**
    @brief WDG Client Logical & Frequency Monitoring

    @pre Enable a Supervision Entity with a single state [(0)].
    Frequency values of min=2 and max=3 for SE is set.

    @test on an event, notify state (0).

    @post #WDG_NotifyState should always return #BCM_ERR_OK.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_CLIENT_3               (0x103UL)

/**
    @brief WDG Client Negative Tests

    @pre Enable a Supervision Entity with a valid state transition of
    {{1U, 2U}, {2U, 3U}, {3U, WDG_INVALID_GRAPH_BUF_ENTRY},
    {0U, WDG_INVALID_GRAPH_BUF_ENTRY}}. Deadline of 60ms and frequency
    values of min=2 and max=3 for the SE is set.

    @test on an event, test SE to notify incorrect state to the system
    using WDG_NotifyState API.
    -# logical error is forced using below invalid transition
       [(0) -> (3)]
    -# For deadline monitoring, the start checkpoint is notified,
       but end checkpoint is not notified
       [(0) -> (2)]
    -# For frequency monitoring, no new state is notified which forces
       a frequency of less than configured minimum value of 2.

    @post #WDG_NotifyState should always return #BCM_ERR_OK.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_CLIENT_NEGATIVETEST    (0x104UL)

/**
    @brief WDG Server Operation

    @pre The WDG service should be initialized.

    @test On an event, call the #WDG_Monitor API.

    @post #WDG_Monitor should always return #BCM_ERR_OK.

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_SYSTEM_CASE0           (0x105UL)

/**
    @brief WDG Server Operation (Negative Tests)

    @pre The WDG service should be initialized.

    @test On an event, call the #WDG_Monitor API.

    @post #WDG_Monitor should return #BCM_ERR_CUSTOM for all
    monitoring calls done during negative tests. Verify that the
    logical/deadline/frequency error counts are incrementing in the
    monitor structure.

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_SYSTEM_NEGATIVETEST    (0x106UL)

/**
    @brief WDG Configuration & Initialization

    @pre None

    @test Review whether the information is segregated w.r.t
    access permissions and verify that all the clients have created
    the SEs correctly.

    @post WDG_SE is in const region. Monitor context is accessed only
    in Monitor function. Context is written only in client context,
    may be read in Monitor context

    @functional     No

    @type           Pos

    @trace #BRCM_SWREQ_WDG
*/
#define BRCM_SWQTST_WDG_CONFIG_CASE0           (0x107UL)

/** @brief WDG Test sequence 0

    This sequence tests the WDG client and system operation.

    @code{.c}
    Review information as per #BRCM_SWQTST_WDG_CONFIG_CASE0
    Create an alarm to periodically signal the client and monitoring tasks
    Initialize WDG using #WDG_Init
    Enable checkpoints of Client 1 using #WDG_EnableSE
    Enable checkpoints of Client 2 using #WDG_EnableSE with deadline
    interval of 60ms and frequency values of min=2 and max=3
    Enable checkpoints of Client 3 using #WDG_EnableSE with frequency
    values of min=2 and max=3
    On an client alarm event interval
        Verify expected result of #BRCM_SWQTST_WDG_CLIENT_1
        Verify expected result of #BRCM_SWQTST_WDG_CLIENT_2
        Verify expected result of #BRCM_SWQTST_WDG_CLIENT_3
    On an system monitor alarm event interval
        Verify expected Result for #BRCM_SWQTST_WDG_SYSTEM_CASE0
    On an client alarm event interval
        Verify expected result of #BRCM_SWQTST_WDG_CLIENT_NEGATIVETEST
    On an system monitor alarm event interval
        Verify expected Result for #BRCM_SWQTST_WDG_SYSTEM_NEGATIVETEST
    Disable all SEs of each client task using #WDG_DisableSE
    Disable WDG monitor using #WDG_DeInit
    @endcode

    @board bcm8910x/bcm8908x

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_WDG_CONFIG_CASE0
    @testproc #BRCM_SWQTST_WDG_CLIENT_1
    @testproc #BRCM_SWQTST_WDG_CLIENT_2
    @testproc #BRCM_SWQTST_WDG_CLIENT_3
    @testproc #BRCM_SWQTST_WDG_CLIENT_NEGATIVETEST
    @testproc #BRCM_SWQTST_WDG_SYSTEM_CASE0
    @testproc #BRCM_SWQTST_WDG_SYSTEM_NEGATIVETEST
*/
#define BRCM_SWQTSEQ_WDG_SEQ0                  (0x108UL)

#endif /* WDG_QT_H */

/** @} */
