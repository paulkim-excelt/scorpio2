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
#include <stdint.h>
#include <chip_config.h>
#include <board.h>
#include <bcm_err.h>
#include <bcm_utils.h>
#include <osil/log_osil.h>
#include <ulog.h>
#if defined(ENABLE_IPC)
#include <ipc_osil.h>
#endif /* defined(ENABLE_IPC) */
#if defined(ENABLE_ETH)
#include <ethxcvr_osil.h>
#if defined(ENABLE_ETH_BRPHY)
#include <brphy_osil.h>
#endif
#if defined(ENABLE_ETH_SGMII)
#include <sgmii_osil.h>
#endif
#include <dummyphy_osil.h>
#endif

#define ETHERCFG_RX_MAX_FRM_SIZE    (1522UL)

#define BRPHY_PORTS     (4UL)
#define SGMII_MAX_HW_ID (5UL)

#define FREQ_MHZ(x)         (1000000UL * (x))

const uint8_t DefaultMacAddr[] = {0x02, 0xAA, 0xBB, 0xCC, 0xDD, 0x00};



#ifdef ENABLE_IPC
#ifdef IPC_BUS_MEMMAP
const IPC_ChannCfgType IPC_ChannCfg[IPC_MAX_CHANNELS] = {
    {
        .ID = 0U,
        .mode = IPC_CHANN_MODE_SLAVE,
        .sizeLog2 = 9U,
        .cntLog2 = 3U,
        .busInfo = {
            .hwID = 0U,
            .busType = IPC_BUS_MEMMAP,
            .slaveID = 0U,
            .fnTbl = NULL,
        },
    },
};
#endif
#endif
