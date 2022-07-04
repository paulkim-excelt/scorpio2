/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_drv_inter_ifc Switch driver internal interface
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_drv_inter_ifc
    @{

    @file switch_drv.h

    @brief Switch driver interface

    @version 0.1 Initial version

*/
#ifndef SWITCH_DRV_H
#define SWITCH_DRV_H

#include <stdint.h>
#include <eth_switch.h>

/**
    @name Switch driver Architecture IDs
    @{
    @brief Architecture IDs for Switch driver
*/
#define BRCM_SWARCH_ETHSWT_DRV_READ_REG_PROC             (0x8201U)    /**< @brief #ETHSWT_DrvReadReg        */
#define BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_PROC            (0x8202U)    /**< @brief #ETHSWT_DrvWriteReg       */
#define BRCM_SWARCH_ETHSWT_DRV_REPORT_ERROR_PROC         (0x8203U)    /**< @brief #ETHSWT_DrvReportError    */
#define BRCM_SWARCH_ETHSWT_PORTID2HWMASK_MACRO           (0x8204U)    /**< @brief #ETHSWT_PORTID2HWMASK     */
#define BRCM_SWARCH_ETHSWT_RDWR_TIMEOUT_MACRO            (0x8205U)    /**< @brief #ETHSWT_RDWR_TIMEOUT      */
#define BRCM_SWARCH_ETHSWT_DRV_RW_DATA_TYPE              (0x8206U)    /**< @brief #ETHSWT_DrvRWDataType     */
#define BRCM_SWARCH_ETHSWT_DRV_DATA_GLOBAL               (0x8207U)    /**< @brief #ETHSWT_DrvData           */
#define BRCM_SWARCH_ETHSWT_NMAC2HWMAC_MACRO              (0x8208U)    /**< @brief #ETHSWT_NMAC2HWMAC        */
#define BRCM_SWARCH_ETHSWT_DRV_SET_PORT_ROLE_PROC        (0x8209U)    /**< @brief #ETHSWT_DrvSetPortRole    */
#define BRCM_SWARCH_ETHSWT_DRV_SET_SWITCH_TYPE_PROC      (0x820AU)    /**< @brief #ETHSWT_DrvSetSwitchType  */
#define BRCM_SWARCH_ETHSWT_DRV_SET_BRCM_HDR_MODE_PROC    (0x820BU)    /**< @brief #ETHSWT_DrvSetBrcmHdrMode */
#define BRCM_SWARCH_ETHSWT_CHECK_ERR_GLOBAL              (0x820CU)    /**< @brief #ETHSWT_CHECK_ERR         */
#define BRCM_SWARCH_ETHSWT_REPORT_ERR_GLOBAL             (0x820DU)    /**< @brief #ETHSWT_REPORT_ERR        */
#define BRCM_SWARCH_ETHSWT_DRV_READ_REG_32_PROC          (0x820EU)    /**< @brief #ETHSWT_DrvReadReg32      */
#define BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_32_PROC         (0x820FU)    /**< @brief #ETHSWT_DrvWriteReg32     */
#define BRCM_SWARCH_ETHSWT_DRV_READ_REG_16_PROC          (0x8210U)    /**< @brief #ETHSWT_DrvReadReg16      */
#define BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_16_PROC         (0x8211U)    /**< @brief #ETHSWT_DrvWriteReg16     */
#define BRCM_SWARCH_ETHSWT_DRV_READ_REG_8_PROC           (0x8212U)    /**< @brief #ETHSWT_DrvReadReg8       */
#define BRCM_SWARCH_ETHSWT_DRV_WRITE_REG_8_PROC          (0x8213U)    /**< @brief #ETHSWT_DrvWriteReg8      */

/** @} */

/**
    @brief NMAC to HWMAC

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_NMAC2HWMAC(macAddr)   \
    (((uint64_t)macAddr[0] << 40UL) |\
     ((uint64_t)macAddr[1] << 32UL) |\
     ((uint64_t)macAddr[2] << 24UL) |\
     ((uint64_t)macAddr[3] << 16UL) |\
     ((uint64_t)macAddr[4] << 8UL)  |\
     ((uint64_t)macAddr[5] << 0UL))

/**
    @brief Read/Write data type

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef struct sETHSWT_DrvRWDataType{
    ETHSWT_StateType    state;
    ETHSWT_SwitchType   switchType;
    uint32_t            mirrorPortID;
    uint32_t            portLinkStatus;
    uint32_t            portLinkStateChngCnt[ETHSWT_PORT_ID_MAX];
    uint32_t            port2TimeFifoMap[ETHSWT_PORT_ID_MAX];
    uint32_t            enableTimeStamp[ETHSWT_PORT_ID_MAX];
    uint32_t            bhShiftEnable;
} ETHSWT_DrvRWDataType;

/**
    @brief Switch driver data

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
extern ETHSWT_DrvRWDataType ETHSWT_DrvData;

/**
    @brief Read/Write time out

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_RDWR_TIMEOUT             (4UL * 8000UL)

/**
    @brief Port ID to HWMAC

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_PORTID2HWMASK(portID)           (0x1ULL << ((uint64_t)portID))

/**
    @brief Switch check error

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_CHECK_ERR(ret, linePtr, label)                   \
    if ((BCM_ERR_OK != (ret))) {                                \
        *(linePtr) = __LINE__;                                  \
        goto label;}                                            \

/**
    @brief Switch report error

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
#define ETHSWT_REPORT_ERR(ret, instanceID, line, apiID, val1, val2, val3)                    \
    if ((BCM_ERR_OK != (ret))) {                                                             \
        ETHSWT_DrvReportError(BCM_SWT_ID, instanceID, apiID, ret, line, val1, val2, val3);}  \

/** @brief Read register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aAddr       Address of memory location from which we need to read data
    @param[inout]   aVal        Pointer to the variable to read data into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If read operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvReadReg(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint64_t *const aVal);

/** @brief Write register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aAddr       Address of memory location to which we need to write data
    @param[in]  aVal        Value to written into the given address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If write operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvWriteReg(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint64_t aVal);

/** @brief Read 32 bit register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aAddr       Address of memory location from which we need to read data
    @param[inout]   aVal        Pointer to the 32 bit variable to read data into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If read operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvReadReg32(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint32_t *const aVal);

/** @brief Write 32 bit register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aAddr       Address of memory location to which we need to write data
    @param[in]  aVal        32 bit Value to written into the given address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If write operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvWriteReg32(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint32_t aVal);

/** @brief Read 16 bit register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aAddr       Address of memory location from which we need to read data
    @param[inout]   aVal        Pointer to the 16 bit variable to read data into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If read operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvReadReg16(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint16_t *const aVal);

/** @brief Write 16 bit register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aAddr       Address of memory location to which we need to write data
    @param[in]  aVal        16 bit Value to written into the given address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If write operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvWriteReg16(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint16_t aVal);

/** @brief Read 8 bit register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aAddr       Address of memory location from which we need to read data
    @param[inout]   aVal        Pointer to the 8 bit variable to read data into it

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If read operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/

extern int32_t ETHSWT_DrvReadReg8(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint8_t *const aVal);

/** @brief Write 8 bit register

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID      Switch Index
    @param[in]  aAddr       Address of memory location to which we need to write data
    @param[in]  aVal        8 bit Value to written into the given address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aAddr is zero
    @retval     #BCM_ERR_TIME_OUT       If write operation times out

    @post None

    @trace  #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
extern int32_t ETHSWT_DrvWriteReg8(ETHSWT_HwIDType aSwtID,
        uint32_t aAddr,
        uint8_t aVal);

/** @brief Switch report error

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCompID         Component ID
    @param[in]      aInstanceID     Instance ID
    @param[in]      aApiID          API ID
    @param[in]      aErr            Error
    @param[in]      aVal0           Related information about the error
    @param[in]      aVal1           Related information about the error
    @param[in]      aVal2           Related information about the error
    @param[in]      aVal3           Related information about the error

    @return void

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_KERNEL_INTERFACE
*/
void ETHSWT_DrvReportError(uint16_t aCompID, uint32_t aInstanceID, uint16_t aApiID,
        int32_t aErr, uint32_t aVal0, uint32_t aVal1,
        uint32_t aVal2, uint32_t aVal3);

/**
    @brief Set port role

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID      Switch Index
    @param[in]      aSwiType    Switch type
    @param[in]      aPortID     Port ID
    @param[in]      aRole       Role

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On Success
    @retval         #BCM_ERR_INVAL_PARAMS   (aSwtType is invalid) or
                                            (aPortID in invalid) or
                                            (aRole is invalid)

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
 */
int32_t ETHSWT_DrvSetPortRole(ETHSWT_HwIDType aSwtID,
                                ETHSWT_SwitchType aSwtType,
                                ETHSWT_PortIDType aPortID,
                                ETHSWT_PortType aRole);

/** @brief Set Broadcom header mode on IMP

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aSwtID  Switch Index
    @param[in]  aMode   Mode

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   aSwtID or aMode is invalid
    @retval     #BCM_ERR_NOPERM         Switch is in unmanaged mode,
                                        Broadcom header cannot be set

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_DrvSetBrcmHdrMode(ETHSWT_HwIDType aSwtID,
        ETHSWT_BrcmHdrModeType aMode);

/**
    @brief Set switch type

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aSwtID          Switch Index
    @param[in]      aSwitchType     Switch type
    @param[in]      aUplinkPortCnt  Number of uplink ports
    @param[in]      aUplinkPortMap  Array containing the uplink port numbers

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK            On Success
    @return     Others                 As returned by #ETHSWT_DrvReadReg or #ETHSWT_DrvWriteReg
    @retval     #BCM_ERR_INVAL_PARAMS  aSwitch is invalid or
                                       aUplinkPortMap is NULL when aUplinkPortCnt is non-zero

    @post None

    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_DrvSetSwitchType(ETHSWT_HwIDType aSwtID,
                                   ETHSWT_SwitchType aSwitchType,
                                   uint32_t aUplinkPortCnt,
                                   uint32_t *const aUplinkPortMap);

#endif /* SWITCH_DRV_H */
/** @} */
