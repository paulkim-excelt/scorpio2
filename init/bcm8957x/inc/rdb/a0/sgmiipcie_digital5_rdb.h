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
    @file sgmiipcie_digital5_rdb.h
    @brief RDB File for SGMIIPCIE_DIGITAL5

    @version Orion_A0_20201104_SWDEV
*/

#ifndef SGMIIPCIE_DIGITAL5_RDB_H
#define SGMIIPCIE_DIGITAL5_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t SGMIIPCIE_DIGITAL5_RESERVED_TYPE;




typedef uint16_t SGMIIPCIE_DIGITAL5_MISC8_SGMIIPCIE_X1_TYPE;
#define SGMIIPCIE_DIGITAL5_MISC8_SGMIIPCIE_X1_FORCE_OSCDR_MODE_MASK (0xfU)
#define SGMIIPCIE_DIGITAL5_MISC8_SGMIIPCIE_X1_FORCE_OSCDR_MODE_SHIFT (0U)




typedef uint16_t SGMIIPCIE_DIGITAL5_LSSSX1_TYPE;
#define SGMIIPCIE_DIGITAL5_LSSSX1_LINK_SPEED_STATUS_MASK (0x7U)
#define SGMIIPCIE_DIGITAL5_LSSSX1_LINK_SPEED_STATUS_SHIFT (0U)




typedef uint16_t SGMIIPCIE_DIGITAL5_BLOCKADDRESS_SGMIIPCIE_X1_TYPE;
#define SGMIIPCIE_DIGITAL5_BLOCKADDRESS_SGMIIPCIE_X1_BLOCKADDRESS_MASK (0x7ff0U)
#define SGMIIPCIE_DIGITAL5_BLOCKADDRESS_SGMIIPCIE_X1_BLOCKADDRESS_SHIFT (4U)




typedef volatile struct COMP_PACKED sSGMIIPCIE_DIGITAL5_RDBType {
    SGMIIPCIE_DIGITAL5_RESERVED_TYPE rsvd0[20]; /* OFFSET: 0x0 */
    SGMIIPCIE_DIGITAL5_MISC8_SGMIIPCIE_X1_TYPE misc8; /* OFFSET: 0x14 */
    SGMIIPCIE_DIGITAL5_LSSSX1_TYPE link_speed; /* OFFSET: 0x16 */
    SGMIIPCIE_DIGITAL5_RESERVED_TYPE rsvd1[6]; /* OFFSET: 0x18 */
    SGMIIPCIE_DIGITAL5_BLOCKADDRESS_SGMIIPCIE_X1_TYPE blockaddress; /* OFFSET: 0x1e */
} SGMIIPCIE_DIGITAL5_RDBType;


#define DIGITAL5_SGMIIPCIE_X1_BASE      (0x4ADD0680UL)



#define SGMIIPCIE_DIGITAL5_MAX_HW_ID    (1UL)

#endif /* SGMIIPCIE_DIGITAL5_RDB_H */
