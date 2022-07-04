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
    @file hsm_scratch_rdb.h
    @brief RDB File for HSM_SCRATCH

    @version Orion_A0_20201104_SWDEV
*/

#ifndef HSM_SCRATCH_RDB_H
#define HSM_SCRATCH_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint32_t HSM_SCRATCH_SCRATCH_REG_0_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_0_REGISTER0_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_0_REGISTER0_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_1_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_1_REGISTER1_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_1_REGISTER1_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_2_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_2_REGISTER2_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_2_REGISTER2_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_3_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_3_REGISTER3_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_3_REGISTER3_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_4_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_4_REGISTER4_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_4_REGISTER4_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_5_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_5_REGISTER5_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_5_REGISTER5_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_6_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_6_REGISTER6_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_6_REGISTER6_SHIFT (0UL)




typedef uint32_t HSM_SCRATCH_SCRATCH_REG_7_TYPE;
#define HSM_SCRATCH_SCRATCH_REG_7_REGISTER7_MASK (0xffffffffUL)
#define HSM_SCRATCH_SCRATCH_REG_7_REGISTER7_SHIFT (0UL)




typedef volatile struct COMP_PACKED sHSM_SCRATCH_RDBType {
    HSM_SCRATCH_SCRATCH_REG_0_TYPE m0; /* OFFSET: 0x0 */
    HSM_SCRATCH_SCRATCH_REG_1_TYPE m1; /* OFFSET: 0x4 */
    HSM_SCRATCH_SCRATCH_REG_2_TYPE m2; /* OFFSET: 0x8 */
    HSM_SCRATCH_SCRATCH_REG_3_TYPE m3; /* OFFSET: 0xc */
    HSM_SCRATCH_SCRATCH_REG_4_TYPE m4; /* OFFSET: 0x10 */
    HSM_SCRATCH_SCRATCH_REG_5_TYPE m5; /* OFFSET: 0x14 */
    HSM_SCRATCH_SCRATCH_REG_6_TYPE m6; /* OFFSET: 0x18 */
    HSM_SCRATCH_SCRATCH_REG_7_TYPE m7; /* OFFSET: 0x1c */
} HSM_SCRATCH_RDBType;


#define HSM_SCRATCH_BASE                (0x4C019000UL)



#define HSM_SCRATCH_MAX_HW_ID           (1UL)

#endif /* HSM_SCRATCH_RDB_H */
