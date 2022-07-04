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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/
#ifndef RPC_MOD_TEST_MODULE_H
#define RPC_MOD_TEST_MODULE_H

#include <rpc_interface.h>

extern const RPC_InterfaceType RPC_ModTestIfc1;

extern const RPC_InterfaceType RPC_ModTestIfc2;

/** Qualification Test Number Enumeration */
typedef uint32_t RPC_ModuleTestType;
#define RPC_MODULE_TEST1      (0x0001UL)            /**< Module Test Sequence   */
#define RPC_MODULE_TEST2      (0x0002UL)            /**< Module Recv Msg Test   */
#define RPC_MODULE_TEST3      (0x0003UL)            /**< Module Send Msg Test   */
#define RPC_MODULE_TEST4      (0x0004UL)            /**< Module init error Test   */
#define RPC_MODULE_TEST5      (0x0005UL)            /**< Module Invalid Interface */
#define RPC_MODULE_TEST_MAX   (RPC_MODULE_TEST5)    /**< Max tests for Module   */

#define RPC_MOD_TEST_EVENT    (1UL)

typedef uint32_t RPC_ModTestFlagType;
#define RPC_MODTESTFLAG_1    (0x1)
#define RPC_MODTESTFLAG_2    (0x2)
#define RPC_MODTESTFLAG_3    (0x3)
#define RPC_MODTESTFLAG_4    (0x4)
#define RPC_MODTESTFLAG_5    (0x5)
#define RPC_MODTESTFLAG_6    (0x6)

extern RPC_ModTestFlagType RPC_ModTestFlag;

#endif /* RPC_MOD_TEST_MODULE_H */
