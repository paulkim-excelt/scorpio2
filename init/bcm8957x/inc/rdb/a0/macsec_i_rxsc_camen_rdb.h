/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @file macsec_i_rxsc_camen_rdb.h
    @brief RDB File for MACSEC_I_RXSC_CAMEN

    @version Orion_A0_20201104_SWDEV
*/

#ifndef MACSEC_I_RXSC_CAMEN_RDB_H
#define MACSEC_I_RXSC_CAMEN_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t MACSEC_I_RXSC_CAMEN_RESERVED_TYPE;




typedef uint32_t MACSEC_I_RXSC_CAMEN_RXSC_ENTRY_ENABLE1_TYPE;
#define MACSEC_I_RXSC_CAMEN_RXSC_ENTRY_ENABLE1_ENABLE_15_31_MASK (0xffffUL)
#define MACSEC_I_RXSC_CAMEN_RXSC_ENTRY_ENABLE1_ENABLE_15_31_SHIFT (0UL)




typedef uint32_t MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_TYPE;
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SC_INDEX_SET_MASK (0xfUL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SC_INDEX_SET_SHIFT (0UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SET_ENABLE_MASK (0x4000UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SET_ENABLE_SHIFT (14UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SET_ALL_MASK (0x8000UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SET_ALL_SHIFT (15UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SC_INDEX_CLEAR_MASK (0xf0000UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_SC_INDEX_CLEAR_SHIFT (16UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_CLEAR_ENABLE_MASK (0x40000000UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_CLEAR_ENABLE_SHIFT (30UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_CLEAR_ALL_MASK (0x80000000UL)
#define MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_CLEAR_ALL_SHIFT (31UL)




typedef volatile struct COMP_PACKED sMACSEC_I_RXSC_CAMEN_RDBType {
    MACSEC_I_RXSC_CAMEN_RESERVED_TYPE rsvd0[13824]; /* OFFSET: 0x0 */
    MACSEC_I_RXSC_CAMEN_RXSC_ENTRY_ENABLE1_TYPE entry_enable1; /* OFFSET: 0x3600 */
    MACSEC_I_RXSC_CAMEN_RESERVED_TYPE rsvd1[252]; /* OFFSET: 0x3604 */
    MACSEC_I_RXSC_CAMEN_RXSC_CAM_ENABLE_CTRL_TYPE cam_enable_ctrl; /* OFFSET: 0x3700 */
} MACSEC_I_RXSC_CAMEN_RDBType;


#define EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE0_BASE  (0x4D010000UL)

#define EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE1_BASE  (0x4D110000UL)

#define EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE2_BASE  (0x4D210000UL)

#define EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE3_BASE  (0x4D310000UL)

#define EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE4_BASE  (0x4D410000UL)

#define EIP_160S_I_32_BRCM_RXSC_CAM_ENABLE5_BASE  (0x4D510000UL)



#define MACSEC_I_RXSC_CAMEN_MAX_HW_ID   (6UL)

#endif /* MACSEC_I_RXSC_CAMEN_RDB_H */