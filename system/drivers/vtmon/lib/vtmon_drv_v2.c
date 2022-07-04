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
    @defgroup grp_vtmondrv_drv_impl Driver Implementation
    @ingroup grp_vtmondrv

    @addtogroup grp_vtmondrv_drv_impl
    @{
*/

#include <stddef.h>

#include <bcm_err.h>
#include <bcm_utils.h>
#include <vtmon_osil.h>
#include <vtmon_rdb.h>

/**
    @name VTMON driver Implementation IDs
    @{
    @brief Implementation IDs for VTMON driver
*/
#define BRCM_SWDSGN_VTMON_DRV_GET_VOLTAGE_PROC    (0xB201U)    /**< @brief #VTMON_DrvGetVoltage     */
#define BRCM_SWDSGN_VTMON_DRV_SET_VOLTAGE_PROC    (0xB202U)    /**< @brief #VTMON_DrvSetVoltage     */
#define BRCM_SWDSGN_VTMON_DRV_GET_TEMP_PROC       (0xB203U)    /**< @brief #VTMON_DrvGetTemperature */
#define BRCM_SWDSGN_VTMON_DRV_SET_TEMP_PROC       (0xB204U)    /**< @brief #VTMON_DrvSetTemperature */
#define BRCM_SWDSGN_VTMON_DRV_POWER_UP_PROC       (0xB205U)    /**< @brief #VTMON_DrvPowerUp        */
#define BRCM_SWDSGN_VTMON_DRV_POWER_DOWN_PROC     (0xB206U)    /**< @brief #VTMON_DrvPowerDown      */
#define BRCM_SWDSGN_VTMON_SVCIO_TYPE              (0xB207U)    /**< @brief #VTMON_SVCIOType         */
#define BRCM_SWDSGN_VTMON_SYSCMDHANDLER_PROC      (0xB208U)    /**< @brief #VTMON_SysCmdHandler     */
#define BRCM_SWDSGN_VTMON_DRV_IRQHANDLER_PROC     (0xB209U)    /**< @brief #VTMON_DrvIRQHandler     */
/** @} */

/**
    @trace #BRCM_SWARCH_VTMON_GET_VOLT_PROC
    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_TEMP_VOLTAGE
*/
static int32_t VTMON_DrvGetVoltage(VTMON_VoltConfigType *aVoltConfig,
                                VTMON_VoltType *const aVolt)
{
    int32_t err = BCM_ERR_OK;
    VTMON_RDBType *const vtmonRegs = (VTMON_RDBType *)VTMON_BASE;
    uint16_t control = 0x0U;

    /* select 100: core voltage (vddc) * 0.7 */
    control = (((uint16_t)VTMON_I_PVTMON_SEL << VTMON_PVTMON_CTRL_I_PVTMON_SEL_SHIFT) & VTMON_PVTMON_CTRL_I_PVTMON_SEL_MASK);
    control |= ((uint16_t)VTMON_TEMP_CLKSEL << VTMON_PVTMON_CTRL_CLKSEL_SHIFT);
    vtmonRegs->ctrl |= control;

    aVoltConfig->threshLow = 0x0U;
    aVoltConfig->threshHigh = 0x0U;
    *aVolt = (uint16_t)VTMON_VOLT((uint16_t)(vtmonRegs->adc_data & VTMON_PVTMON_ADC_DATA_DATA_MASK));

    return err;
}

/**
    @trace #BRCM_SWARCH_VTMON_SET_VOLT_MONITOR_PROC
    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_INIT
*/
static int32_t VTMON_DrvSetVoltage(VTMON_VoltConfigType *aVoltConfig)
{
    int32_t err = BCM_ERR_OK;
    return err;
}

/**
    @trace #BRCM_SWARCH_VTMON_GET_TEMP_PROC
    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_TEMP_VOLTAGE
*/
static int32_t VTMON_DrvGetTemperature(VTMON_TempConfigType *aTempConfig, VTMON_TempType *const aTemp)
{
    int32_t err = BCM_ERR_OK;
    VTMON_RDBType *const vtmonRegs = (VTMON_RDBType *)VTMON_BASE;
    uint16_t control = 0x0U;

    /* Select  2.5 Mhz */
    control = (((uint16_t)VTMON_TEMP_CLKSEL << VTMON_PVTMON_CTRL_CLKSEL_SHIFT) & ~VTMON_PVTMON_CTRL_I_PVTMON_SEL_MASK);
    vtmonRegs->ctrl = control;

    aTempConfig->threshLow = 0x0;
    aTempConfig->threshHigh = 0x0;
    *aTemp = VTMON_TEMP((uint16_t)(vtmonRegs->adc_data & VTMON_PVTMON_ADC_DATA_DATA_MASK));

    return err;
}

/**
    @trace #BRCM_SWARCH_VTMON_SET_TEMP_MONITOR_PROC
    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_INIT
*/
static int32_t VTMON_DrvSetTemperature(VTMON_TempConfigType *aTempConfig)
{
    int32_t err = BCM_ERR_OK;
    return err;
}

/**
    @trace #BRCM_SWARCH_VTMON_DEINIT_PROC
    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_INIT
*/
static int32_t VTMON_DrvPowerDown(void)
{
    uint16_t cntrl;
    VTMON_RDBType *const vtmonRegs = (VTMON_RDBType *)VTMON_BASE;

    cntrl = (VTMON_PVTMON_CTRL_I_PWRDN_MASK << VTMON_PVTMON_CTRL_I_PWRDN_SHIFT);
    vtmonRegs->ctrl = cntrl;

    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_VTMON_INIT_PROC
    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_INIT
*/
static int32_t VTMON_DrvPowerUp(void)
{
    uint16_t cntrl;
    VTMON_RDBType *const vtmonRegs = (VTMON_RDBType *)VTMON_BASE;

    cntrl = vtmonRegs->ctrl;
    cntrl &= ~((uint16_t)VTMON_PVTMON_CTRL_I_PWRDN_MASK);
    vtmonRegs->ctrl = cntrl;

    return BCM_ERR_OK;
}

/**
    @brief Union to avoid MISRA Required error
    for Type conversion

    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace  #BRCM_SWREQ_VTMON_KERNEL_INTERFACE
*/
typedef union uVTMON_SVCIOType {
    uint8_t *data;
    VTMON_IOType *io;
} VTMON_SVCIOType;

/**
    @code{.c}
    if aSysIO is not NULL
        if aMagicID is SVC_MAGIC_VTM_ID
            Based on aCmd, call the respective functions
            VTMON_CMD_POWER_UP ==> VTMON_DrvPowerUp()
            VTMON_CMD_POWER_DOWN ==> VTMON_DrvPowerDown()
            VTMON_CMD_GET_CURR_VOLT ==> VTMON_DrvGetVoltage()
            VTMON_CMD_SET_VOLT_CONFIG ==> VTMON_DrvSetVoltage()
            VTMON_CMD_GET_CURR_TEMP ==> VTMON_DrvGetTemperature()
            VTMON_CMD_SET_TEMP_CONFIG ==> VTMON_DrvSetTemperature()
        else
            return Invalid Magic Code
    else
        Report Error appropriately
    @endcode

    @trace #BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_KERNEL_HANDLER
*/

void VTMON_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    VTMON_SVCIOType vtmon;
    vtmon.data = aSysIO;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (aSysIO != NULL) {
        if (aMagicID == SVC_MAGIC_VTM_ID) {
            switch (aCmd) {
            case VTMON_CMD_POWER_UP:
                retVal = VTMON_DrvPowerUp();
                break;
            case VTMON_CMD_POWER_DOWN:
                retVal = VTMON_DrvPowerDown();
                break;
            case VTMON_CMD_GET_CURR_VOLT:
                retVal = VTMON_DrvGetVoltage(&vtmon.io->voltConfig, &vtmon.io->currVolt);
                break;
            case VTMON_CMD_SET_VOLT_CONFIG:
                retVal = VTMON_DrvSetVoltage(&vtmon.io->voltConfig);
                break;
            case VTMON_CMD_GET_CURR_TEMP:
                retVal = VTMON_DrvGetTemperature(&vtmon.io->tempConfig, &vtmon.io->currTemp);
                break;
            case VTMON_CMD_SET_TEMP_CONFIG:
                retVal = VTMON_DrvSetTemperature(&vtmon.io->tempConfig);
                break;
            default:
                retVal = BCM_ERR_INVAL_PARAMS;
                break;
            }
            vtmon.io->retVal = retVal;
        } else {
            retVal = BCM_ERR_INVAL_MAGIC;
        }
    }
    if (BCM_ERR_OK != retVal) {
        const uint32_t values[4] = {aMagicID, aCmd, (uint32_t)aSysIO, 0UL};
        BCM_ReportError(BCM_VTM_ID, 0U, BRCM_SWARCH_VTMON_SYSCMDHANDLER_PROC, retVal,
                4UL, values);
    }
}

/**
    @trace #BRCM_SWARCH_VTMON_DRV_IRQHANDLER_PROC
    @trace #BRCM_SWREQ_VTMON_KERNEL_HANDLER
*/
void VTMON_DrvIRQHandler(void)
{
    /* No interrupt and hence nothing to be handled */
    /* Place holder for B0 or higher version */
}

/** @} */

