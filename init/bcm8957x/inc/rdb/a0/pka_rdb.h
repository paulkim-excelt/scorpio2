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
    @file pka_rdb.h
    @brief RDB File for PKA

    @version Orion_A0_20201104_SWDEV
*/

#ifndef PKA_RDB_H
#define PKA_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint32_t PKA_CTRL_TYPE;
#define PKA_CTRL_UNKNOP_MASK (0x80000000UL)
#define PKA_CTRL_UNKNOP_SHIFT (31UL)
#define PKA_CTRL_INVSRC0_MASK (0x40000000UL)
#define PKA_CTRL_INVSRC0_SHIFT (30UL)
#define PKA_CTRL_INVSRC1_MASK (0x20000000UL)
#define PKA_CTRL_INVSRC1_SHIFT (29UL)
#define PKA_CTRL_INVSRC2_MASK (0x10000000UL)
#define PKA_CTRL_INVSRC2_SHIFT (28UL)
#define PKA_CTRL_CAMFULL_MASK (0x8000000UL)
#define PKA_CTRL_CAMFULL_SHIFT (27UL)
#define PKA_CTRL_DIV0_MASK (0x4000000UL)
#define PKA_CTRL_DIV0_SHIFT (26UL)
#define PKA_CTRL_OPQOF_MASK (0x2000000UL)
#define PKA_CTRL_OPQOF_SHIFT (25UL)
#define PKA_CTRL_OPCIDX_MASK (0x1f00000UL)
#define PKA_CTRL_OPCIDX_SHIFT (20UL)
#define PKA_CTRL_ESC_MASK (0xf0000UL)
#define PKA_CTRL_ESC_SHIFT (16UL)
#define PKA_CTRL_ENDSEL_MASK (0x2000UL)
#define PKA_CTRL_ENDSEL_SHIFT (13UL)
#define PKA_CTRL_MEMCLR_MASK (0x1000UL)
#define PKA_CTRL_MEMCLR_SHIFT (12UL)
#define PKA_CTRL_OPQFULL_MASK (0x400UL)
#define PKA_CTRL_OPQFULL_SHIFT (10UL)
#define PKA_CTRL_PRIM_SEL_FAIL_MASK (0x200UL)
#define PKA_CTRL_PRIM_SEL_FAIL_SHIFT (9UL)
#define PKA_CTRL_LCOPC_MASK (0x100UL)
#define PKA_CTRL_LCOPC_SHIFT (8UL)
#define PKA_CTRL_PKARST_MASK (0x80UL)
#define PKA_CTRL_PKARST_SHIFT (7UL)
#define PKA_CTRL_PKACMDERR_MASK (0x8UL)
#define PKA_CTRL_PKACMDERR_SHIFT (3UL)
#define PKA_CTRL_PKABUSY_MASK (0x4UL)
#define PKA_CTRL_PKABUSY_SHIFT (2UL)
#define PKA_CTRL_PKACMDDONE_MASK (0x2UL)
#define PKA_CTRL_PKACMDDONE_SHIFT (1UL)
#define PKA_CTRL_PKAEN_MASK (0x1UL)
#define PKA_CTRL_PKAEN_SHIFT (0UL)




typedef uint32_t PKA_DIN_TYPE;
#define PKA_DIN_PKAIDAT_MASK (0xffffffffUL)
#define PKA_DIN_PKAIDAT_SHIFT (0UL)




typedef uint32_t PKA_DOUT_TYPE;
#define PKA_DOUT_PKAODAT_MASK (0xffffffffUL)
#define PKA_DOUT_PKAODAT_SHIFT (0UL)




typedef uint32_t PKA_ACC_TYPE;
#define PKA_ACC_PKALCK_MASK (0x80000000UL)
#define PKA_ACC_PKALCK_SHIFT (31UL)
#define PKA_ACC_LCK_MASK (0x8000UL)
#define PKA_ACC_LCK_SHIFT (15UL)




typedef uint32_t PKA_LFSR_TYPE;
#define PKA_LFSR_RNDSEED_MASK (0xffffffffUL)
#define PKA_LFSR_RNDSEED_SHIFT (0UL)




typedef volatile struct COMP_PACKED sPKA_RDBType {
    PKA_CTRL_TYPE ctrl; /* OFFSET: 0x0 */
    PKA_DIN_TYPE din; /* OFFSET: 0x4 */
    PKA_DOUT_TYPE dout; /* OFFSET: 0x8 */
    PKA_ACC_TYPE acc; /* OFFSET: 0xc */
    PKA_LFSR_TYPE lfsr; /* OFFSET: 0x10 */
} PKA_RDBType;


#define PKA_BASE                        (0x4C010000UL)



#define PKA_MAX_HW_ID                   (1UL)

#endif /* PKA_RDB_H */
