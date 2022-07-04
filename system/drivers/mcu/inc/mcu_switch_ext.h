/*****************************************************************************
 Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_mcudrv_ifc
    @{

    @file mcu_switch_ext.h
    @brief MCU Switch Extension Interface
    This header file contains MCU Switch Extension Interface

    @version 0.86 Imported from docx
*/

#ifndef MCU_SWITCH_EXT_H
#define MCU_SWITCH_EXT_H

#include <stdint.h>
#include <mcu.h>

/**
    @name MCU Switch Extension API IDs
    @{
    @brief MCU Switch Extension API IDs
*/
#define BRCM_SWARCH_MCU_GETSWITCHPORT2TIMEFIFOMAP_PROC    (0x8601U)    /**< @brief #MCU_GetSwitchPort2TimeFifoMap */
#define BRCM_SWARCH_MCU_STACKINGINFO_TYPE                 (0x8604U)    /**< @brief #MCU_StackingInfoType          */
#define BRCM_SWARCH_MCU_SWITCHINTRFLAGS_TYPE              (0x8605U)    /**< @brief #MCU_SwitchIntrFlagsType       */
#define BRCM_SWARCH_MCU_SWITCHINTERRUPTCLEAR_PROC         (0x8606U)    /**< @brief #MCU_SwitchInterruptClear      */
#define BRCM_SWARCH_MCU_SETSERDESCLK_PROC                 (0x8607U)    /**< @brief #MCU_SetSerDesClk              */
#define BRCM_SWARCH_MCU_RESETSERDESCLK_PROC               (0x8608U)    /**< @brief #MCU_ResetSerDesClk            */
#define BRCM_SWARCH_MCU_GEN1588SYNCPULSE_PROC             (0x8609U)    /**< @brief #MCU_Gen1588SyncPulse          */
/** @} */

/**
   @name Stacking Info
   @{
   @trace #BRCM_SWREQ_MCU_SWITCH_EXTENSION
 */
typedef uint32_t MCU_StackingInfoType;
#define MCU_STACKINGINFO_EN_MASK            (0x1UL)       /**< @brief Stacking enable mask */
#define MCU_STACKINGINFO_EN_SHIFT           (0UL)         /**< @brief Stacking enable shift */
#define MCU_STACKINGINFO_MST_SLV_MASK       (0x6UL)       /**< @brief Stacking master slave id mask */
#define MCU_STACKINGINFO_MST_SLV_SHIFT      (1UL)         /**< @brief Stacking master slave id shift */
#define MCU_STACKINGINFO_PORT_0_MASK        (0xF0UL)      /**< @brief Stacking Port 0 mask Bit[11:8] */
#define MCU_STACKINGINFO_PORT_0_SHIFT       (4UL)         /**< @brief Stacking Port 0 Shift Bit[11:8] */
#define MCU_STACKINGINFO_PORT_1_MASK        (0xF00UL)     /**< @brief Stacking Port 1 mask Bit[15:12] */
#define MCU_STACKINGINFO_PORT_1_SHIFT       (8UL)         /**< @brief Stacking Port 1 Shift Bit[15:12] */
#define MCU_STACKINGINFO_VLAN_MASK          (0xFFF0000UL) /**< @brief Stacking vlan mask */
#define MCU_STACKINGINFO_VLAN_SHIFT         (16UL)        /**< @brief Stacking vlan shift */
/** @} */

/**
    @name Switch Interrupt Flags
    @{
    @brief Switch interrupt flags that are converted to level by CFG

    @trace #BRCM_SWREQ_MCU_INIT
*/
typedef uint32_t MCU_SwitchIntrFlagsType;
#define MCU_SWITCHINTRFLAGS_LINKSTATUS0   (0x00000001UL) /**< @brief Link status Port 0 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS1   (0x00000002UL) /**< @brief Link status Port 1 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS2   (0x00000004UL) /**< @brief Link status Port 2 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS3   (0x00000008UL) /**< @brief Link status Port 3 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS4   (0x00000010UL) /**< @brief Link status Port 4 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS5   (0x00000020UL) /**< @brief Link status Port 5 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS6   (0x00000040UL) /**< @brief Link status Port 6 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS7   (0x00000080UL) /**< @brief Link status Port 7 */
#define MCU_SWITCHINTRFLAGS_LINKSTATUS8   (0x00000100UL) /**< @brief Link status Port 8 */
#define MCU_SWITCHINTRFLAGS_CFP_TCAM      (0x00000200UL) /**< @brief CFP TCAM checksum error */
#define MCU_SWITCHINTRFLAGS_CFP_OUTOFPROF (0x00000400UL) /**< @brief CFP Flow Meter Out of profile Interrupt */
#define MCU_SWITCHINTRFLAGS_WAKEUP5       (0x00000800UL) /**< @brief Port 5 wakeup */
#define MCU_SWITCHINTRFLAGS_WAKEUP7       (0x00001000UL) /**< @brief Port 7 wakeup */
#define MCU_SWITCHINTRFLAGS_WAKEUP8       (0x00002000UL) /**< @brief Port 8 wakeup */
#define MCU_SWITCHINTRFLAGS_EEE_LPI       (0x00004000UL) /**< @brief EEE LPI status change */
#define MCU_SWITCHINTRFLAGS_MEM_DED       (0x00008000UL) /**< @brief Memory DED error */
#define MCU_SWITCHINTRFLAGS_DOS           (0x00010000UL) /**< @brief DOS */
#define MCU_SWITCHINTRFLAGS_PSFP          (0x00020000UL) /**< @brief PSFP */
#define MCU_SWITCHINTRFLAGS_CTF           (0x00040000UL) /**< @brief CTF */
#define MCU_SWITCHINTRFLAGS_ALL           (0x0007FFFFUL) /**< @brief All */
/** @} */

/** @brief Get Ethernet Switch port to Time hardware FIFO mapping

    This API retrieves Ethernet switch port to time hardware FIFO mapping as
    per the hardware configuration of the chip.

    @behavior Sync, reentrant

    @pre None

    @param[in]   aPort2TimeFifoMap   Pointer to array to retrieve switch port
                                     to time fifo map. The size of array is
                                     equal to #ETHERSWT_PORT_ID_MAX

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved switch port to
                                        time fifo map
    @retval     #BCM_ERR_UNINIT         MCU not initialized
    @retval     #BCM_ERR_INVAL_PARAMS   aPort2TimeFifoMap is NULL


    @post None

    @trace  #BRCM_SWREQ_MCU_SWITCH_EXTENSION
*/
extern int32_t MCU_GetSwitchPort2TimeFifoMap(uint32_t *const aPort2TimeFifoMap);

/** @brief Clear Switch interrupt

    This API clears the switch interrupt in CFG block

    @behavior Sync, reentrant

    @pre None

    @param[in]   aIntrFlags     Bitmask of interrupts to be cleared

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK         Successfully cleared specified interrupts
    @retval     #BCM_ERR_UNINIT     MCU is uninitialized

    @post None

    @trace  #BRCM_SWREQ_MCU_INIT

    @limitations This API shall only be called from privileged context.
*/
extern int32_t MCU_SwitchInterruptClear(MCU_SwitchIntrFlagsType aIntrFlags);

/** @brief Set RGMII/PCIe SerDes Controller Clock
    This API enable the PLL clock and active SGMII/PCIe Controller

    @behavior Sync, reentrant

    @pre #MCU_ClkInit Should be called

    @param[in]   clkID     MCU_CLK_ID_SGA
                           MCU_CLK_ID_SGB
                           MCU_CLK_ID_PCI
    @param[in]   cntrlID   SGMII Controller ID


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Successfully set SGMII/PCIe Clock
    @retval     #BCM_ERR_UNKNOWN         Something went wrong
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid cntrlID
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid clkID
    @retval     #BCM_ERR_UNINIT          MCU is uninitialized

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations This API shall only be called from privileged context.
*/
extern int32_t MCU_SetSerDesClk(MCU_ClkIDType clkID, uint32_t cntrlID);

/** @brief Reset RGMII/PCIe SerDes Controller Clock
    This API enable the PLL clock and active SGMII/PCIe Controller

    @behavior Sync, reentrant

    @pre #MCU_ClkInit Should be called

    @param[in]   clkID     MCU_CLK_ID_SGA
                           MCU_CLK_ID_SGB
                           MCU_CLK_ID_PCI
    @param[in]   cntrlID   SGMII Controller ID


    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Successfully set SGMII/PCIe Clock
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid cntrlID
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid clkID
    @retval     #BCM_ERR_UNINIT          MCU is uninitialized

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG

    @limitations This API shall only be called from privileged context.
*/
extern int32_t MCU_ResetSerDesClk(MCU_ClkIDType clkID, uint32_t cntrlID);

/** @brief Generate 1588 Sync Pulse

    This API generates a 1588 sync pulse

    @behavior Sync, reentrant

    @pre None

    @param      void

    @retval     #BCM_ERR_OK              Successfully triggered 1588 pulse generation

    @post None

    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
extern int32_t MCU_Gen1588SyncPulse(void);

#endif /* MCU_SWITCH_EXT_H */
/** @} */
