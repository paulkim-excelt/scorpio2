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
    @file brphy1gv2_phycontrol_rdb.h
    @brief RDB File for BRPHY1GV2_PHYCONTROL

    @version Orion_A0_20201104_SWDEV
*/

#ifndef BRPHY1GV2_PHYCONTROL_RDB_H
#define BRPHY1GV2_PHYCONTROL_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t BRPHY1GV2_PHYCONTROL_RESERVED_TYPE;




typedef uint16_t BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_TYPE;
#define BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_WC_MASK (0xe0U)
#define BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_WC_SHIFT (5U)
#define BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_SQI_MASK (0xeU)
#define BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_SQI_SHIFT (1U)




typedef volatile struct COMP_PACKED sBRPHY1GV2_PHYCONTROL_RDBType {
    BRPHY1GV2_PHYCONTROL_RESERVED_TYPE rsvd0[164]; /* OFFSET: 0x0 */
    BRPHY1GV2_PHYCONTROL_TC1_DCQ_SQI_TYPE sqi; /* OFFSET: 0xa4 */
    BRPHY1GV2_PHYCONTROL_RESERVED_TYPE rsvd1[2392]; /* OFFSET: 0xa6 */
} BRPHY1GV2_PHYCONTROL_RDBType;


#define BRPHY1GV2_PHYCONTROL_BASE       (0x49030000UL)



#define BRPHY1GV2_PHYCONTROL_MAX_HW_ID  (1UL)

#endif /* BRPHY1GV2_PHYCONTROL_RDB_H */
