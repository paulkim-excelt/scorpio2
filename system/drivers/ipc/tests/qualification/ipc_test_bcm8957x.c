/****************************************************************************
 *
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
#include <ipc.h>
#include <ipc_osil.h>
#include <chipmisc_rdb.h>
#include "ipc_test_plat.h"

#define IPC_CHIPMISC_REGS               ((CHIPMISC_RDBType *)CHIPMISC_BASE)
#define IPC_MAX_PTR_MASK                (0xFU)

#define IPC_BUFF_INFO_REG               (&(IPC_CHIPMISC_REGS->spare_sw_reg7))
#define IPC_BUFF_INFO_BASE_SHIFT        (8UL)
#define IPC_BUFF_INFO_BASE_MASK         (0xFF00U)
#define IPC_BUFF_INFO_SZ_SHIFT          (4UL)
#define IPC_BUFF_INFO_SZ_MASK           (0x00F0U)
#define IPC_BUFF_INFO_CNT_SHIFT         (2UL)
#define IPC_BUFF_INFO_CNT_MASK          (0x000CU)
#define IPC_BUFF_INFO_RSVD_SHIFT        (1UL)
#define IPC_BUFF_INFO_RSVD_MASK         (0x0002U)
#define IPC_BUFF_INFO_PAR_SHIFT         (0UL)
#define IPC_BUFF_INFO_PAR_MASK          (0x0001U)
#define IPC_BUFF_INFO_BASE_ALIGN_SHIFT  (11UL)

#define IPC_BUFF_INFO2_REG              (&(IPC_CHIPMISC_REGS->spare_sw_reg10))
#define IPC_BUFF_INFO2_BASE_SHIFT       (1UL)
#define IPC_BUFF_INFO2_BASE_MASK        (0x3FFEU)
#define IPC_BUFF_INFO2_RSVD_SHIFT       (14UL)
#define IPC_BUFF_INFO2_RSVD_MASK        (0xC000U)
#define IPC_BUFF_INFO2_PAR_SHIFT        (0UL)
#define IPC_BUFF_INFO2_PAR_MASK         (0x0001U)
#define IPC_BUFF_INFO2_BASE_ALIGN_SHIFT (19UL)

#define IPC_TARGET_STAT_REG             (&(IPC_CHIPMISC_REGS->spare_sw_reg8))
#define IPC_TARGET_STAT_RSVD_SHIFT      (11UL)
#define IPC_TARGET_STAT_RSVD_MASK       (0xF100U)
#define IPC_TARGET_STAT_WR_SHIFT        (4UL)
#define IPC_TARGET_STAT_WR_MASK         (IPC_MAX_PTR_MASK << IPC_TARGET_STAT_WR_SHIFT)
#define IPC_TARGET_STAT_RD_SHIFT        (0UL)
#define IPC_TARGET_STAT_RD_MASK         (IPC_MAX_PTR_MASK << IPC_TARGET_STAT_RD_SHIFT)

#define IPC_HOST_STAT_REG               (&(IPC_CHIPMISC_REGS->spare_sw_reg9))
#define IPC_HOST_STAT_RSVD_SHIFT        (8UL)
#define IPC_HOST_STAT_RSVD_MASK         (0xFF00U)
#define IPC_HOST_STAT_WR_SHIFT          (4UL)
#define IPC_HOST_STAT_WR_MASK           (IPC_MAX_PTR_MASK << IPC_HOST_STAT_WR_SHIFT)
#define IPC_HOST_STAT_RD_SHIFT          (0UL)
#define IPC_HOST_STAT_RD_MASK           (IPC_MAX_PTR_MASK << IPC_HOST_STAT_RD_SHIFT)

int32_t IPCT_PlatSetIntr(IPC_ChannIDType aID)
{
   IPC_CHIPMISC_REGS->cpusys_misc |= (uint16_t)(CHIPMISC_CPUSYS_MISC_SOFT_INTR_MASK);
   return BCM_ERR_OK;
}

int32_t IPCT_PlatSetBuffInfo(IPC_ChannIDType aID)
{
   return BCM_ERR_OK;
}

int32_t IPCT_PlatGetBuffInfo(IPC_ChannIDType aID, IPC_BuffInfoType * const aBuffInfo)
{
   uint16_t info0;
   uint16_t info1;
   uint32_t address0;
   uint32_t address1;
   uint32_t address;
   int32_t ret = BCM_ERR_OK;

   info0 = *IPC_BUFF_INFO_REG;
   info1 = *IPC_BUFF_INFO2_REG;

   if ((info0 != 0xFFFFU) && (info0 != 0U)
          && (IPCT_CalcEvenParity(info0) == 0U)
          && (IPCT_CalcEvenParity(info1) == 0U)) {
      address0 = ((info0 & IPC_BUFF_INFO_BASE_MASK) >> IPC_BUFF_INFO_BASE_SHIFT);
      address1 = ((info1 & IPC_BUFF_INFO2_BASE_MASK) >> IPC_BUFF_INFO2_BASE_SHIFT);
      address = (address0 << IPC_BUFF_INFO_BASE_ALIGN_SHIFT) | (address1 << IPC_BUFF_INFO2_BASE_ALIGN_SHIFT);
      aBuffInfo->buffer = (uint8_t *)(intptr_t)address;
      aBuffInfo->msgCount = 1U << ((info0 & IPC_BUFF_INFO_CNT_MASK) >> IPC_BUFF_INFO_CNT_SHIFT);
      aBuffInfo->msgSize = 1U << ((info0 & IPC_BUFF_INFO_SZ_MASK) >> IPC_BUFF_INFO_SZ_SHIFT);
      aBuffInfo->rolloverMask = 0xFU;
   } else {
      aBuffInfo->buffer = NULL;
      aBuffInfo->msgCount = 0U;
      aBuffInfo->msgSize = 0U;
      aBuffInfo->rolloverMask = 0U;
      ret = BCM_ERR_UNINIT;
   }
   return ret;
}

int32_t IPCT_PlatGetRemoteStatus(IPC_ChannIDType aID, IPC_BuffStatusType * const aBuffStatus)
{
   uint16_t data = *IPC_TARGET_STAT_REG;
   aBuffStatus->writeIndex = (data & IPC_HOST_STAT_WR_MASK) >> IPC_HOST_STAT_WR_SHIFT;
   aBuffStatus->readIndex = (data & IPC_HOST_STAT_RD_MASK) >> IPC_HOST_STAT_RD_SHIFT;
   return BCM_ERR_OK;
}

int32_t IPCT_PlatSetLocalStatus(IPC_ChannIDType aID, IPC_BuffStatusType * const aBuffStatus)
{
   uint16_t data =
       ((aBuffStatus->writeIndex << IPC_TARGET_STAT_WR_SHIFT) & IPC_TARGET_STAT_WR_MASK) |
       ((aBuffStatus->readIndex << IPC_TARGET_STAT_RD_SHIFT) & IPC_TARGET_STAT_RD_MASK);

   *IPC_HOST_STAT_REG = data;
   return BCM_ERR_OK;
}

void IPCT_PlatReset(IPC_ChannIDType aID)
{
    *IPC_TARGET_STAT_REG = 0U;
    *IPC_HOST_STAT_REG = 0U;
    return;
}