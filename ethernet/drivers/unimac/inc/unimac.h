/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_unimac_ifc Unimac Interface
    @ingroup grp_unimac

    @addtogroup grp_unimac_ifc
    @{

    @file unimac.h
    @brief Unimac interface
    This header file contains the interface functions for Unimac

    @version 0.1 Initial version
*/

#ifndef UNIMAC_H
#define UNIMAC_H

#include <bcm_err.h>
#include <compiler.h>

/**
    @name Unimac API IDs
    @{
    @brief API IDs for Unimac
*/
#define BRCM_SWARCH_UNIMAC_SPEED_TYPE               (0x8101U)    /**< @brief #UNIMAC_SpeedType        */
#define BRCM_SWARCH_UNIMAC_LOOPBACK_TYPE            (0x8102U)    /**< @brief #UNIMAC_LoopBackType     */
#define BRCM_SWARCH_UNIMAC_CFG_TYPE                 (0x8103U)    /**< @brief #UNIMAC_CfgType          */
#define BRCM_SWARCH_UNIMAC_INIT_PROC                (0x8104U)    /**< @brief #UNIMAC_Init             */
#define BRCM_SWARCH_UNIMAC_DEINIT_PROC              (0x8105U)    /**< @brief #UNIMAC_Deinit           */
#define BRCM_SWARCH_UNIMAC_SETMAC_PROC              (0x8106U)    /**< @brief #UNIMAC_SetMAC           */
#define BRCM_SWARCH_UNIMAC_GETMAC_PROC              (0x8107U)    /**< @brief #UNIMAC_GetMAC           */
#define BRCM_SWARCH_UNIMAC_SETTXMODE_PROC           (0x8108U)    /**< @brief #UNIMAC_SetTxMode        */
#define BRCM_SWARCH_UNIMAC_SETRXMODE_PROC           (0x8109U)    /**< @brief #UNIMAC_SetRxMode        */
#define BRCM_SWARCH_UNIMAC_SETLINELOOPBACK_PROC     (0x810AU)    /**< @brief #UNIMAC_SetLineLoopBack  */
#define BRCM_SWARCH_UNIMAC_SETLOCALLOOPBACK_PROC    (0x810BU)    /**< @brief #UNIMAC_SetLocalLoopBack */
#define BRCM_SWARCH_UNIMAC_MAX_FRAMELENGTH_MACRO    (0x810CU)    /**< @brief #UNIMAC_MAX_FRAMELENGTH  */
/** @} */

/**
    @brief Maximum size frame with CRC

    @trace #BRCM_SWREQ_UNIMAC
*/
#define UNIMAC_MAX_FRAMELENGTH  (1500UL + 6UL + 6UL + 2UL + 4UL + 4UL)

/**
    @name UNIMAC_SpeedType
    @{
    @brief Speed of operation

    @trace #BRCM_SWREQ_UNIMAC
*/
typedef uint8_t UNIMAC_SpeedType;       /**< @brief UNIMAC_Speed typedef */
#define UNIMAC_SPEED_10MBPS     (0x01U) /**< @brief 10Mbps */
#define UNIMAC_SPEED_100MBPS    (0x02U) /**< @brief 100Mbps */
#define UNIMAC_SPEED_1000MBPS   (0x04U) /**< @brief 1000Mbps */
#define UNIMAC_SPEED_2500MBPS   (0x08U) /**< @brief 2500Mbps */
#define UNIMAC_SPEED_VALID_MASK (0x0FU) /**< @brief Mask indicating valid bits */
/** @} */

/**
    @name UNIMAC_LoopBackType
    @{
    @brief Loopback mode

    @trace #BRCM_SWREQ_UNIMAC
*/
typedef uint8_t UNIMAC_LoopBackType;    /**< @brief UNIMAC_LoopBack typedef */
#define UNIMAC_LOOPBACK_NONE    (0x0U)  /**< @brief No loopback */
#define UNIMAC_LOOPBACK_LINE    (0x1U)  /**< @brief Line loopback */
#define UNIMAC_LOOPBACK_LOCAL   (0x2U)  /**< @brief Local loopback */
/** @} */

/**
    @name UNIMAC_CfgType
    @{
    @brief Unimac Configuration Type

    @trace #BRCM_SWREQ_UNIMAC
*/
typedef struct COMP_PACKED sUNIMAC_CfgType {
    uint32_t maxFrameLength;        /**< @brief Maximum frame length */
    uint8_t enableExternalConfig;   /**< @brief Enable External configuration */
    UNIMAC_SpeedType speed;         /**< @brief Speed */
    UNIMAC_LoopBackType loopBack;   /**< @brief LoopBack mode */
    uint8_t macAddr[6UL];           /**< @brief MAC address in network byte order */
} UNIMAC_CfgType;
/** @} */

/** @brief Unimac Init

    This API initialises Unimac

    @behavior Sync, Re-entrant

    @pre None

    @param[in] aID      Instance Identifier
    @param[in] aCfg     Input configuration of type #UNIMAC_CfgType

    @return   void

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern void UNIMAC_Init(uint8_t aID, const UNIMAC_CfgType *const aCfg);

/** @brief Unimac Deinit

    This API de-initialises Unimac

    @behavior Sync, Re-entrant

    @pre None

    @param      none

    @return     void

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern void UNIMAC_Deinit(uint8_t aID);

/** @brief Set MAC address

    This API set the MAC address

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID             Instance Identifier
    @param[in]  aMacAddr        MAC address to be configured

    @return     BCM_ERR_UNINIT          Uninitialised
    @return     BCM_ERR_INVAL_PARAMS    Invalid aID or aMacAddr is NULL
    @return     BCM_ERR_OK              MAC address set uccessfully

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern int32_t UNIMAC_SetMAC(uint8_t aID, const uint8_t *const aMacAddr);

/** @brief Retrieve MAC address

    This API retrieves the MAC address configured

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID             Instance Identifier
    @param[out] aMacAddr        Pointer to retrieve MAC address

    @return     BCM_ERR_UNINIT          Uninitialised
    @return     BCM_ERR_INVAL_PARAMS    Invalid aID or aMacAddr is NULL
    @return     BCM_ERR_OK              MAC address retrieved successfully

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern int32_t UNIMAC_GetMAC(uint8_t aID, uint8_t *const aMacAddr);

/** @brief Set Transmit Mode

    This API will enable/disable the transmit path

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID             Instance Identifier
    @param[in]  aEnable         TRUE: Enable
                                FALSE: Disable

    @return     BCM_ERR_UNINIT          Uninitialised
    @return     BCM_ERR_INVAL_PARAMS    Invalid aID
    @return     BCM_ERR_OK              Transmit path enabled/disabled successfully

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern int32_t UNIMAC_SetTxMode(uint8_t aID, uint32_t aEnable);

/** @brief Set Receive Mode

    This API will enable/disable the receive path

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID             Instance Identifier
    @param[in]  aEnable         TRUE: Enable
                                FALSE: Disable

    @return     BCM_ERR_UNINIT          Uninitialised
    @return     BCM_ERR_INVAL_PARAMS    Invalid aID
    @return     BCM_ERR_OK              Receive path enabled/disabled successfully

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern int32_t UNIMAC_SetRxMode(uint8_t aID, uint32_t aEnable);

/** @brief Enable/Disable Unimac Line loopback

    This API enables/disables loopback on the line side

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID             Instance Identifier
    @param[in]  aEnable         TRUE: Enable loopback
                                FALSE: Disable loopback

    @return     BCM_ERR_UNINIT          Uninitialised
    @return     BCM_ERR_INVAL_PARAMS    Invalid aID
    @return     BCM_ERR_OK              Successfully enabled/disabled loopback

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern int32_t UNIMAC_SetLineLoopBack(uint8_t aID, uint32_t aEnable);

/** @brief Enable/Disable Unimac Local loopback

    This API enables/disables loopback on the Local side

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID             Instance Identifier
    @param[in]  aEnable         TRUE: Enable loopback
                                FALSE: Disable loopback

    @return     BCM_ERR_UNINIT          Uninitialised
    @return     BCM_ERR_INVAL_PARAMS    Invalid aID
    @return     BCM_ERR_OK              Successfully enabled/disabled loopback

    @post None

    @limitations To be called in privileged mode

    @trace #BRCM_SWREQ_UNIMAC
*/
extern int32_t UNIMAC_SetLocalLoopBack(uint8_t aID, uint32_t aEnable);

#endif /* UNIMAC_H */

/** @} */
