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
    @file spg_rdb.h
    @brief RDB File for SPG

    @version Orion_A0_20201104_SWDEV
*/

#ifndef SPG_RDB_H
#define SPG_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint32_t SPG_SPI_GRANT_TYPE;
#define SPG_SPI_GRANT_GRANT_MASK (0xffffUL)
#define SPG_SPI_GRANT_GRANT_SHIFT (0UL)




typedef uint32_t SPG_SPI_LOCK_TYPE;
#define SPG_SPI_LOCK_LOCK_MASK (0xffffUL)
#define SPG_SPI_LOCK_LOCK_SHIFT (0UL)




typedef uint32_t SPG_MDIO_GRANT_TYPE;
#define SPG_MDIO_GRANT_GRANT_MASK (0xffffUL)
#define SPG_MDIO_GRANT_GRANT_SHIFT (0UL)




typedef uint32_t SPG_MDIO_LOCK_TYPE;
#define SPG_MDIO_LOCK_LOCK_MASK (0xffffUL)
#define SPG_MDIO_LOCK_LOCK_SHIFT (0UL)




typedef uint32_t SPG_JTAG_CTL_TYPE;
#define SPG_JTAG_CTL_CPU_ENABLE_MASK (0x1UL)
#define SPG_JTAG_CTL_CPU_ENABLE_SHIFT (0UL)




typedef uint32_t SPG_PCIE_GRANT_TYPE;
#define SPG_PCIE_GRANT_GRANT_MASK (0xffffUL)
#define SPG_PCIE_GRANT_GRANT_SHIFT (0UL)




typedef uint32_t SPG_PCIE_LOCK_TYPE;
#define SPG_PCIE_LOCK_LOCK_MASK (0xffffUL)
#define SPG_PCIE_LOCK_LOCK_SHIFT (0UL)




typedef uint32_t SPG_HSM_CTL_REG_TYPE;
#define SPG_HSM_CTL_REG_SPARE_MASK (0xfffffff8UL)
#define SPG_HSM_CTL_REG_SPARE_SHIFT (3UL)
#define SPG_HSM_CTL_REG_PROD_MODE_CFG_MASK (0x4UL)
#define SPG_HSM_CTL_REG_PROD_MODE_CFG_SHIFT (2UL)
#define SPG_HSM_CTL_REG_HSM_BLOCK_SOFT_RST_MASK (0x2UL)
#define SPG_HSM_CTL_REG_HSM_BLOCK_SOFT_RST_SHIFT (1UL)
#define SPG_HSM_CTL_REG_M3_CORE_SOFT_RST_MASK (0x1UL)
#define SPG_HSM_CTL_REG_M3_CORE_SOFT_RST_SHIFT (0UL)




typedef uint32_t SPG_AMAC_GRANT_TYPE;
#define SPG_AMAC_GRANT_SPARE_MASK (0x8000UL)
#define SPG_AMAC_GRANT_SPARE_SHIFT (15UL)
#define SPG_AMAC_GRANT_AMAC_GRANT_MASK (0x7fffUL)
#define SPG_AMAC_GRANT_AMAC_GRANT_SHIFT (0UL)




typedef uint32_t SPG_AMAC_LOCK_TYPE;
#define SPG_AMAC_LOCK_SPARE_MASK (0x8000UL)
#define SPG_AMAC_LOCK_SPARE_SHIFT (15UL)
#define SPG_AMAC_LOCK_AMAC_LOCK_MASK (0x7fffUL)
#define SPG_AMAC_LOCK_AMAC_LOCK_SHIFT (0UL)




typedef uint32_t SPG_DMAC_GRANT_TYPE;
#define SPG_DMAC_GRANT_GRANT_MASK (0xffffUL)
#define SPG_DMAC_GRANT_GRANT_SHIFT (0UL)




typedef uint32_t SPG_DMAC_LOCK_TYPE;
#define SPG_DMAC_LOCK_LOCK_MASK (0xffffUL)
#define SPG_DMAC_LOCK_LOCK_SHIFT (0UL)




typedef uint8_t SPG_RESERVED_TYPE;




typedef uint32_t SPG_SCRATCH_REG_TYPE;
#define SPG_SCRATCH_REG_SCRATCH_MASK (0xffffffffUL)
#define SPG_SCRATCH_REG_SCRATCH_SHIFT (0UL)




typedef volatile struct COMP_PACKED sSPG_RDBType {
    SPG_SPI_GRANT_TYPE spi_grant; /* OFFSET: 0x0 */
    SPG_SPI_LOCK_TYPE spi_lock; /* OFFSET: 0x4 */
    SPG_MDIO_GRANT_TYPE mdio_grant; /* OFFSET: 0x8 */
    SPG_MDIO_LOCK_TYPE mdio_lock; /* OFFSET: 0xc */
    SPG_JTAG_CTL_TYPE jtag_ctl; /* OFFSET: 0x10 */
    SPG_PCIE_GRANT_TYPE pcie_grant; /* OFFSET: 0x14 */
    SPG_PCIE_LOCK_TYPE pcie_lock; /* OFFSET: 0x18 */
    SPG_HSM_CTL_REG_TYPE hsm_ctl_reg; /* OFFSET: 0x1c */
    SPG_AMAC_GRANT_TYPE amac_grant; /* OFFSET: 0x20 */
    SPG_AMAC_LOCK_TYPE amac_lock; /* OFFSET: 0x24 */
    SPG_DMAC_GRANT_TYPE dmac_grant; /* OFFSET: 0x28 */
    SPG_DMAC_LOCK_TYPE dmac_lock; /* OFFSET: 0x2c */
    SPG_RESERVED_TYPE rsvd0[4044]; /* OFFSET: 0x30 */
    SPG_SCRATCH_REG_TYPE scratch_reg; /* OFFSET: 0xffc */
} SPG_RDBType;


#define SPG_BASE                        (0x4C018000UL)



#define SPG_MAX_HW_ID                   (1UL)

#endif /* SPG_RDB_H */
