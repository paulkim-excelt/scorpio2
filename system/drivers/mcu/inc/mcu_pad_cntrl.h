/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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

    @file mcu_pad_cntrl.h

    @brief MCU Pad Control Interface
    This header file contains MCU Pad Control Interface
    pad configuration

    @version 0.86 Imported from docx
*/

#ifndef MCU_PAD_CNTRL_H
#define MCU_PAD_CNTRL_H

#include <stdint.h>

/**
    @name MCU Pad Control API IDs
    @{
    @brief MCU Pad Control API IDs
*/
#define BRCM_SWARCH_MCU_BT656PADCFG_PROC                 (0x8501U)    /**< @brief #MCU_BT656PadCfg               */
#define BRCM_SWARCH_MCU_SDPADCFG_PROC                    (0x8502U)    /**< @brief #MCU_SDPadCfg                  */
#define BRCM_SWARCH_MCU_RGMIIPADCFG_PROC                 (0x8503U)    /**< @brief #MCU_RGMIIPadCfg               */
#define BRCM_SWARCH_MCU_RGMII_MODEHV_TYPE                (0x8504U)    /**< @brief #MCU_RGMIIModeHVType           */
#define BRCM_SWARCH_MCU_RGMII_PADCFG_TYPE                (0x8505U)    /**< @brief #MCU_RGMIIPadCfgType           */
#define BRCM_SWARCH_MCU_RGMII_SLEW_RATE_CONTROL_TYPE     (0x8506U)    /**< @brief #MCU_RGMIISlewRateControlType  */
#define BRCM_SWARCH_MCU_RGMII_PAD_DRIVE_STRENGTH_TYPE    (0x8507U)    /**< @brief #MCU_RGMIIPadDriveStrengthType */
#define BRCM_SWARCH_MCU_RGMII_PAD_HSTL_TYPE              (0x8508U)    /**< @brief #MCU_RGMIIPadHSTLEnableType    */
/** @} */

 /**
     @name MCU_RGMIIModeHVType
     @{
     @brief MODEHV to RGMII power domain

    @trace #BRCM_SWREQ_MCU_PADCFG_EXTENSION
 */
 typedef uint8_t MCU_RGMIIModeHVType;    /**< @brief MCU RGMII power domain typedef */
 #define MCU_RGMII_MODEHV_LOW    (0U)   /**< @brief 2.5/1.8V Operation */
 #define MCU_RGMII_MODEHV_HIGH   (1U)   /**< @brief 3.3V Operation */
 /** @} */

  /**
     @name MCU_RGMIISlewRateControlType
     @{
     @brief Slew rate control to RGMII Pads.

    @trace #BRCM_SWREQ_MCU_PADCFG_EXTENSION
 */
 typedef uint8_t MCU_RGMIISlewRateControlType;          /**< @brief Slew rate control to GMII Pads. */
 #define MCU_RGMII_SLEW_RATE_CONTROL_NORMAL    (0U)     /**< @brief Nominal Edge */
 #define MCU_RGMII_SLEW_RATE_CONTROL_2X        (1U)     /**< @brief 2x of Nominal Edge */
 #define MCU_RGMII_SLEW_RATE_CONTROL_3X        (2U)     /**< @brief 3x of Nominal Edge */
 #define MCU_RGMII_SLEW_RATE_CONTROL_4X        (3U)     /**< @brief 4x of Nominal Edge */
 /** @} */

   /**
     @name MCU_RGMIIPadDriveStrengthType
     @{
     @brief RGMII PAD drive strength

    @trace #BRCM_SWREQ_MCU_PADCFG_EXTENSION
 */
 typedef uint8_t MCU_RGMIIPadDriveStrengthType;            /**< @brief RGMII PAD drive strength */
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_2MA         (0U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_4MA         (1U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_6MA         (2U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_8MA         (3U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_10MA        (4U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_12MA        (5U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_14MA        (6U)     /**< @brief 2mA High Speed*/
 #define MCU_RGMII_PAD_DRIVE_STRENGTH_16MA        (7U)     /**< @brief 2mA High Speed*/
 /** @} */

  /**
     @name MCU_RGMIIPadHSTLEnableType
     @{
     @brief RGMII pad hstl enable/disable

    @trace #BRCM_SWREQ_MCU_PADCFG_EXTENSION
 */
 typedef uint8_t MCU_RGMIIPadHSTLEnableType;    /**< @brief RGMII pad hstl enable */
 #define MCU_RGMII_PAD_HSTL_DISABLE   (0U)   /**< @brief HSTL disabled, RGMII */
 #define MCU_RGMII_PAD_HSTL_ENABLE    (1U)   /**< @brief HSTL enabled, HSTL */
 /** @} */

/** @brief MCU RGMII Pad config type
    @trace #BRCM_SWREQ_MCU_PADCFG_EXTENSION
 */
 typedef struct sMCU_RGMIIPadCfgType {
    MCU_RGMIIModeHVType              modeHV;         /**< @brief power domain mode */
    MCU_RGMIISlewRateControlType     slewRate;       /**< @brief Slew rate control */
    MCU_RGMIIPadDriveStrengthType    driveStrength;  /**< @brief PAD drive strength */
    MCU_RGMIIPadHSTLEnableType       isHSTLEnable;   /**< @brief pad hstl enable */
} MCU_RGMIIPadCfgType;

/** @brief Pad configuration for BT656 display

    This API will configure the PADs to send BT656 display over RGMII pins

    @behavior Sync, Non-reentrant

    @pre None

    @param       none

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_NOPERM         Pad config is already locked

    @post None

    @trace  #BRCM_SWREQ_MCU_PADCFG_EXTENSION
*/
extern int32_t MCU_BT656PadCfg(void);

/** @brief Pad configuration for SD

    This API will configure the PADs required for SD

    @behavior Sync, Non-reentrant

    @pre None

    @param       none

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_NOPERM         Pad config is already locked

    @post None

    @trace  #BRCM_SWREQ_MCU_PADCFG_EXTENSION
*/
extern int32_t MCU_SDPadCfg(void);

/** @brief Pad configuration for RGMII

    This API will configure the PADs required for RGMII

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]   aRGMIIPadConfig    Pointer to RGMII pad configuration

    @param       none

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_NOPERM         Pad config is already locked
    @retval     #BCM_ERR_INVAL_PARAMS  aRGMIIPadConfig is NULL or invalid

    @post None

    @trace  #BRCM_SWREQ_MCU_PADCFG_EXTENSION
*/
extern int32_t MCU_RGMIIPadCfg(const MCU_RGMIIPadCfgType *const aRGMIIPadConfig);

#endif /* MCU_PAD_CNTRL_H */

/** @} */
