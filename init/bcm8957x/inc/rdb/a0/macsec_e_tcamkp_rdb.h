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
    @file macsec_e_tcamkp_rdb.h
    @brief RDB File for MACSEC_E_TCAMKP

    @version Orion_A0_20201104_SWDEV
*/

#ifndef MACSEC_E_TCAMKP_RDB_H
#define MACSEC_E_TCAMKP_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t MACSEC_E_TCAMKP_RESERVED_TYPE;




typedef uint32_t MACSEC_E_TCAMKP_TCAM_POLICY_0_TYPE;
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_VPORT_INDEX_MASK (0xfUL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_VPORT_INDEX_SHIFT (0UL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_PRIO_MASK (0x38000000UL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_PRIO_SHIFT (27UL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_DROP_MASK (0x40000000UL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_DROP_SHIFT (30UL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_CONTROL_PKT_MASK (0x80000000UL)
#define MACSEC_E_TCAMKP_TCAM_POLICY_0_CONTROL_PKT_SHIFT (31UL)



#define MACSEC_E_TCAMKP_TCAM_SIZE  (32UL)


typedef volatile struct COMP_PACKED sMACSEC_E_TCAMKP_RDBType {
    MACSEC_E_TCAMKP_RESERVED_TYPE rsvd0[77824]; /* OFFSET: 0x0 */
    MACSEC_E_TCAMKP_TCAM_POLICY_0_TYPE tcam[MACSEC_E_TCAMKP_TCAM_SIZE]; /* OFFSET: 0x13000 */
} MACSEC_E_TCAMKP_RDBType;


#define EIP_160S_E_32_BRCM_TCAM_POLICY0_BASE  (0x4D010000UL)

#define EIP_160S_E_32_BRCM_TCAM_POLICY1_BASE  (0x4D110000UL)

#define EIP_160S_E_32_BRCM_TCAM_POLICY2_BASE  (0x4D210000UL)

#define EIP_160S_E_32_BRCM_TCAM_POLICY3_BASE  (0x4D310000UL)

#define EIP_160S_E_32_BRCM_TCAM_POLICY4_BASE  (0x4D410000UL)

#define EIP_160S_E_32_BRCM_TCAM_POLICY5_BASE  (0x4D510000UL)



#define MACSEC_E_TCAMKP_MAX_HW_ID       (6UL)

#endif /* MACSEC_E_TCAMKP_RDB_H */
