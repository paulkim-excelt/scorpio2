/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
#include <nvm_osil.h>
#include <board.h>

/**
  @addtogroup grp_nvm_il
  @{

  @file bcm8957x_nvm_cfg.c
  @brief Flash Manager Configuration
  This source file contains the integration of flash manager to system.
  @version 0.52 Imported from docx

*/

#if defined(ENABLE_NVM) && !defined(ENABLE_NVM_TEST)
#if !defined(ENABLE_FLASH_TEST)
/* Board flash configurations */
static const FLASH_FlsableSecType flasableSecList[] = {
    {FLASH0_FLSABLE_SEC_START_ADDR, 32UL}
};

const FLASH_CfgTblType FLASH_cfg_tbl[] = {
    {
        .hwID = FLASH_HW_ID_0,
        .config = {
            .size = FLASH0_SIZE, /* 4MB */
            .pageSize = 256UL,
            .sectorSize = (64UL * 1024UL), /* 64KB */
            .subSectorSize = FLASH0_SUBSECTOR_SIZE,
            .SPIMode = FLASH_SPI_MODE_3,
            .speed = FLASH0_SPEED,
            .readLane = FLASH0_READ_LANE_CFG,
            .flsableSecListSize = (sizeof(flasableSecList)/
                                    sizeof(FLASH_FlsableSecType)),
            .flsableSecList = flasableSecList,
            .flsID = FLASH0_FLASH_ID,
        },
    },
};
#endif  /*!ENABLE_FLASH_TEST */

static const NVM_CfgType nvm_cfg_tbl[] = {
#if !defined(ENABLE_FLASH_TEST)
    {
        .aCfg = (void *)&FLASH_cfg_tbl[0],
        .aDev = NVM_TYPE_FLASH,
        .aID = FLASH_HW_ID_0,
        .startAddr = NVM_START_ADDR_FLASH0,
        .nvmSize = NVM_MAX_REGION_FLASH,
        .maxSize = FLASH0_SIZE,
    },
#endif  /*!ENABLE_FLASH_TEST */
};

const NVM_CfgType  * const NVM_CfgTbl = nvm_cfg_tbl;
const uint32_t NVM_CfgTblSz = (sizeof(nvm_cfg_tbl)/
        sizeof(NVM_CfgType));


#endif /* ENABLE_NVM, !ENABLE_NVM_TEST */
