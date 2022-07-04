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
    @file rng_rdb.h
    @brief RDB File for RNG

    @version Orion_A0_20201104_SWDEV
*/

#ifndef RNG_RDB_H
#define RNG_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint32_t RNG_CTRL_TYPE;
#define RNG_CTRL_RNG_COMBLK2_OSC_DIS_MASK (0xfc00000UL)
#define RNG_CTRL_RNG_COMBLK2_OSC_DIS_SHIFT (22UL)
#define RNG_CTRL_RNG_COMBLK1_OSC_DIS_MASK (0x3f0000UL)
#define RNG_CTRL_RNG_COMBLK1_OSC_DIS_SHIFT (16UL)
#define RNG_CTRL_RNG_JCLK_BYP_DIV_CNT_MASK (0xff00UL)
#define RNG_CTRL_RNG_JCLK_BYP_DIV_CNT_SHIFT (8UL)
#define RNG_CTRL_RNG_JCLK_BYP_SEL_MASK (0x10UL)
#define RNG_CTRL_RNG_JCLK_BYP_SEL_SHIFT (4UL)
#define RNG_CTRL_RBG_DIV_MASK (0x6UL)
#define RNG_CTRL_RBG_DIV_SHIFT (1UL)
#define RNG_CTRL_RBG_EN_MASK (0x1UL)
#define RNG_CTRL_RBG_EN_SHIFT (0UL)




typedef uint32_t RNG_STATUS_TYPE;
#define RNG_STATUS_VAL_MASK (0xff000000UL)
#define RNG_STATUS_VAL_SHIFT (24UL)
#define RNG_STATUS_WARM_CNT_MASK (0xfffffUL)
#define RNG_STATUS_WARM_CNT_SHIFT (0UL)




typedef uint32_t RNG_DATA_TYPE;
#define RNG_DATA_NUM_MASK (0xffffffffUL)
#define RNG_DATA_NUM_SHIFT (0UL)




typedef uint32_t RNG_FF_THRES_TYPE;
#define RNG_FF_THRES_THRESH_MASK (0x1fUL)
#define RNG_FF_THRES_THRESH_SHIFT (0UL)




typedef uint32_t RNG_INT_MASK_TYPE;
#define RNG_INT_MASK_OFF_MASK (0x1UL)
#define RNG_INT_MASK_OFF_SHIFT (0UL)




typedef uint32_t RNG_RING_TUNE_1_TYPE;
#define RNG_RING_TUNE_1_1F_MASK (0xf00000UL)
#define RNG_RING_TUNE_1_1F_SHIFT (20UL)
#define RNG_RING_TUNE_1_1E_MASK (0xf0000UL)
#define RNG_RING_TUNE_1_1E_SHIFT (16UL)
#define RNG_RING_TUNE_1_1D_MASK (0xf000UL)
#define RNG_RING_TUNE_1_1D_SHIFT (12UL)
#define RNG_RING_TUNE_1_1C_MASK (0xf00UL)
#define RNG_RING_TUNE_1_1C_SHIFT (8UL)
#define RNG_RING_TUNE_1_1B_MASK (0xf0UL)
#define RNG_RING_TUNE_1_1B_SHIFT (4UL)
#define RNG_RING_TUNE_1_1A_MASK (0xfUL)
#define RNG_RING_TUNE_1_1A_SHIFT (0UL)




typedef uint32_t RNG_RING_TUNE_2_TYPE;
#define RNG_RING_TUNE_2_2F_MASK (0xf00000UL)
#define RNG_RING_TUNE_2_2F_SHIFT (20UL)
#define RNG_RING_TUNE_2_2E_MASK (0xf0000UL)
#define RNG_RING_TUNE_2_2E_SHIFT (16UL)
#define RNG_RING_TUNE_2_2D_MASK (0xf000UL)
#define RNG_RING_TUNE_2_2D_SHIFT (12UL)
#define RNG_RING_TUNE_2_2C_MASK (0xf00UL)
#define RNG_RING_TUNE_2_2C_SHIFT (8UL)
#define RNG_RING_TUNE_2_2B_MASK (0xf0UL)
#define RNG_RING_TUNE_2_2B_SHIFT (4UL)
#define RNG_RING_TUNE_2_2A_MASK (0xfUL)
#define RNG_RING_TUNE_2_2A_SHIFT (0UL)




typedef uint32_t RNG_LOCK_TYPE;
#define RNG_LOCK_RNG_COMBLK_OSC_DIS_LOCK_MASK (0x8UL)
#define RNG_LOCK_RNG_COMBLK_OSC_DIS_LOCK_SHIFT (3UL)
#define RNG_LOCK_RNG_JCLK_BYP_SEL_LOCK_MASK (0x4UL)
#define RNG_LOCK_RNG_JCLK_BYP_SEL_LOCK_SHIFT (2UL)
#define RNG_LOCK_RING_TUNE_2_LOCK_MASK (0x2UL)
#define RNG_LOCK_RING_TUNE_2_LOCK_SHIFT (1UL)
#define RNG_LOCK_RING_TUNE_1_LOCK_MASK (0x1UL)
#define RNG_LOCK_RING_TUNE_1_LOCK_SHIFT (0UL)




typedef volatile struct COMP_PACKED sRNG_RDBType {
    RNG_CTRL_TYPE ctrl; /* OFFSET: 0x0 */
    RNG_STATUS_TYPE status; /* OFFSET: 0x4 */
    RNG_DATA_TYPE data; /* OFFSET: 0x8 */
    RNG_FF_THRES_TYPE ff_thres; /* OFFSET: 0xc */
    RNG_INT_MASK_TYPE int_mask; /* OFFSET: 0x10 */
    RNG_RING_TUNE_1_TYPE ring_tune_1; /* OFFSET: 0x14 */
    RNG_RING_TUNE_2_TYPE ring_tune_2; /* OFFSET: 0x18 */
    RNG_LOCK_TYPE lock; /* OFFSET: 0x1c */
} RNG_RDBType;


#define RNG_BASE                        (0x4C011000UL)



#define RNG_MAX_HW_ID                   (1UL)

#endif /* RNG_RDB_H */
