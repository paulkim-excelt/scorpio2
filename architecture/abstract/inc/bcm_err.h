/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_abstract_err Error Reporting
    @ingroup grp_abstract

    @addtogroup grp_abstract_err
    @{
    All Components use these errors as error return types.
    <BR>All Components use BCM_ReportError function for reporting errors.

    @file bcm_err.h
    @brief BCM Error Types
    This header file contains the interface functions for error types
    and error reporting function.
    @version 1.0 Initial Version
*/


#ifndef BCM_ERR_H
#define BCM_ERR_H

#include <stdint.h>
#include <stddef.h>
#include <bcm_comp.h>
/**
    @name BCM Error API IDs
    @{
    @brief API IDs for BCM Error APIs
*/
#define BRCM_SWARCH_BCM_ERR_MACRO               (0x8001U)    /**< @brief #BCM_ERR_OK                    */
#define BRCM_SWARCH_BCM_MACRO                   (0x8002U)    /**< @brief #BCM_LOGMASK_KERNEL            */
#define BRCM_SWARCH_BCM_REPORT_ERROR0_MACRO     (0x8003U)    /**< @brief #BCM_REPORT_ERROR0             */
#define BRCM_SWARCH_BCM_REPORT_ERROR1_MACRO     (0x8004U)    /**< @brief #BCM_REPORT_ERROR1             */
#define BRCM_SWARCH_BCM_REPORT_ERROR2_MACRO     (0x8005U)    /**< @brief #BCM_REPORT_ERROR2             */
#define BRCM_SWARCH_BCM_REPORT_ERROR3_MACRO     (0x8006U)    /**< @brief #BCM_REPORT_ERROR3             */
#define BRCM_SWARCH_BCM_REPORT_ERROR4_MACRO     (0x8007U)    /**< @brief #BCM_REPORT_ERROR4             */
#define BRCM_SWARCH_BCM_GET_REPORT_ERROR_MACRO  (0x8008U)    /**< @brief #BCM_GET_REPORT_ERROR_MACRO    */
#define BRCM_SWARCH_BCM_REPORT_ERROR_MACRO      (0x8009U)    /**< @brief #BCM_REPORT_ERROR              */
#define BRCM_SWARCH_BCM_ERR_VERSION_TYPE        (0x800AU)    /**< @brief #BCM_ErrVersionType            */
#define BRCM_SWARCH_BCM_ERR_REPORT_PROC         (0x800BU)    /**< @brief #BCM_ReportError               */
#define BRCM_SWARCH_BCM_ERR_REPORTV2_PROC       (0x800CU)    /**< @brief #BCM_ReportErrorV2             */
#define BRCM_SWARCH_BCM_ERROR_TYPE              (0x800DU)    /**< @brief #BCM_DbgMsgType                */
#define BRCM_SWARCH_BCM_ERR_CUSTOM_MACRO        (0x800EU)    /**< @brief #BCM_ERR_MAX_CUSTOM_VALUES     */
#define BRCM_SWARCH_BCM_GET_ERROR_PROC          (0x800FU)    /**< @brief #BCM_GetError                  */
#define BRCM_SWARCH_BCM_INIT_ERROR_PROC         (0x8010U)    /**< @brief #BCM_InitError                 */
#define BRCM_SWARCH_BCM_DEV_INFO_TYPE           (0x8011U)    /**< @brief #BCM_DevInfoType               */
#define BRCM_SWARCH_BCM_BOOT_MODE_IDX_TYPE      (0x8012U)    /**< @brief #BCM_BootModeIdxType           */
#define BRCM_SWARCH_BCM_DBGMSG_PUTRAW_PROC      (0x8013U)    /**< @brief #BCM_DbgMsgPutRaw              */

/** @} */

/**
    @name BCM Error Codes
    @{
    @brief Error return values

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_ERR_OK              (0x0)  /**< @brief No Error                          */
#define BCM_ERR_BUSY            (0x1)  /**< @brief Device or resource busy           */
#define BCM_ERR_NODEV           (0x2)  /**< @brief No device found                   */
#define BCM_ERR_NOT_FOUND       (0x3)  /**< @brief Not Found                         */
#define BCM_ERR_NOMEM           (0x4)  /**< @brief Out of memory                     */
#define BCM_ERR_NOSUPPORT       (0x5)  /**< @brief Not supported                     */
#define BCM_ERR_INVAL_PARAMS    (0x6)  /**< @brief Invalid argument                  */
#define BCM_ERR_INVAL_MAGIC     (0x7)  /**< @brief Invalid magic number              */
#define BCM_ERR_INVAL_STATE     (0x8)  /**< @brief Invalid state                     */
#define BCM_ERR_INVAL_BUF_STATE (0x9)  /**< @brief Invalid buffer state              */
#define BCM_ERR_EAGAIN          (0xA)  /**< @brief Try again                         */
#define BCM_ERR_TIME_OUT        (0xB)  /**< @brief Timeout                           */
#define BCM_ERR_UNINIT          (0xC)  /**< @brief Device or resource not initialized*/
#define BCM_ERR_CANCELLED       (0xD)  /**< @brief Cancel request success            */
#define BCM_ERR_DATA_INTEG      (0xE)  /**< @brief Data integrity error              */
#define BCM_ERR_AUTH_FAILED     (0xF)  /**< @brief Authentication error              */
#define BCM_ERR_VERSION         (0x10) /**< @brief Wrong version of hw/sw            */
#define BCM_ERR_BUS_FAILURE     (0x11) /**< @brief Bus Failure                       */
#define BCM_ERR_NACK            (0x12) /**< @brief NACK error                        */
#define BCM_ERR_MAX_ATTEMPS     (0x13) /**< @brief Maximum num of attempts           */
#define BCM_ERR_UNKNOWN         (0x14) /**< @brief Unknown error                     */
#define BCM_ERR_CUSTOM          (0x15) /**< @brief Module specific error             */
#define BCM_ERR_NOPERM          (0x16) /**< @brief Permission denied                 */
/** @} */

/**
    @name Masks for KLOG/ULOG
    @{
    @brief Mask for KLOG and ULOG in Component ID

    When an error is reported by a component, this bit in the component will identify whether the error is reported
    from Privileged context or Unprivileged context

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_LOGMASK_KERNEL (0x8000U)  /**< @brief mask for routing the error to KLOG */
#define BCM_LOGMASK_USER   (0x7FFFU)  /**< @brief mask for routing the error to ULOG */
/** @} */


/**
    @brief Report Error Macro with no data value

    This macro will call BCM_ReportErrorV2 function with no data value.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_REPORT_ERROR0(aCompID, aInstanceID, aApiID, aErr, aState, aMsg)                             \
    {                                                                                                   \
        const uint32_t values[] = {};                                                                   \
        BCM_ReportErrorV2(aCompID, aInstanceID, aApiID, aErr, __LINE__, aState, 0UL, values);           \
    }

/**
    @brief Report Error Macro with one data value

    This macro will call BCM_ReportErrorV2 function with one data value.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_REPORT_ERROR1(aCompID, aInstanceID, aApiID, aErr, aState, aVal0, aMsg)                      \
    {                                                                                                   \
        const uint32_t values[] = {aVal0};                                                              \
        BCM_ReportErrorV2(aCompID, aInstanceID, aApiID, aErr, __LINE__, aState, 1UL, values);           \
    }

/**
    @brief Report Error Macro with two data value

    This macro will call BCM_ReportErrorV2 function with two data value.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_REPORT_ERROR2(aCompID, aInstanceID, aApiID, aErr, aState, aVal0, aVal1, aMsg)               \
    {                                                                                                   \
        const uint32_t values[] = {aVal0, aVal1};                                                       \
        BCM_ReportErrorV2(aCompID, aInstanceID, aApiID, aErr, __LINE__, aState, 2UL, values);           \
    }

/**
    @brief Report Error Macro with three data value

    This macro will call BCM_ReportErrorV2 function with three data value.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_REPORT_ERROR3(aCompID, aInstanceID, aApiID, aErr, aState, aVal0, aVal1, aVal2, aMsg)        \
    {                                                                                                   \
        const uint32_t values[] = {aVal0, aVal1, aVal2};                                                \
        BCM_ReportErrorV2(aCompID, aInstanceID, aApiID, aErr, __LINE__, aState, 3UL, values);           \
    }

/**
    @brief Report Error Macro with four data value

    This macro will call BCM_ReportErrorV2 function with four data value.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_REPORT_ERROR4(aCompID, aInstanceID, aApiID, aErr, aState, aVal0, aVal1, aVal2, aVal3, aMsg)  \
    {                                                                                                    \
        const uint32_t values[] = {aVal0, aVal1, aVal2, aVal3};                                          \
        BCM_ReportErrorV2(aCompID, aInstanceID, aApiID, aErr, __LINE__, aState, 4UL, values);            \
    }

/**
    @brief Get Report Error Macro

    This macro funcion which decide which report error macro should be called.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_GET_REPORT_ERROR_MACRO(_0, _1, _2, _3, _4, _REPORT_ERROR_MACRO, ...) _REPORT_ERROR_MACRO

/**
    @brief Report Error Macro

    This macro accepts variable number of arguments and calls BCM_GET_REPORT_ERROR_MACRO macro function.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_REPORT_ERROR(aCompID, aInstanceID, aApiID, aErr, aState, ...)                               \
    BCM_GET_REPORT_ERROR_MACRO(__VA_ARGS__, BCM_REPORT_ERROR4, BCM_REPORT_ERROR3, BCM_REPORT_ERROR2, BCM_REPORT_ERROR1, BCM_REPORT_ERROR0) \
    (aCompID, aInstanceID, aApiID, aErr, aState, __VA_ARGS__)

/**
    @name Report Error Version
    @{
    @brief Report Error Version State.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint32_t BCM_ErrVersionType;              /**< @brief Error Version        */
#define BCM_ERR_VERSION_0    (0UL)                /**< @brief version 1            */
#define BCM_ERR_VERSION_1    (1UL)                /**< @brief version 2            */

/** @} */
/**
    @name Report Error Version
    @{
    @brief Report Error Version State.

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint32_t BCM_DevInfoType;                        /**< @brief Device Info                     */
#define BCM_DEV_INFO_STACKING_EN_MASK      (0x000FUL)    /**< @brief Stacking Enable Info(EN/DIS)    */
#define BCM_DEV_INFO_STACKING_EN_SHIFT     (0UL)         /**< @brief Stacking Enable shift           */
#define BCM_DEV_INFO_STACKING_MODE_MASK    (0x00F0UL)    /**< @brief Stacking Info(MASTER/SLAVE)     */
#define BCM_DEV_INFO_STACKING_MODE_SHIFT   (4UL)         /**< @brief Stacking shift                  */
#define BCM_DEV_INFO_CPU_MASK              (0x0F00UL)    /**< @brief CPU Info(ARM/ARC)               */
#define BCM_DEV_INFO_CPU_SHIFT             (8UL)         /**< @brief CPU shift                       */
#define BCM_DEV_INFO_CPU_APP               (0x0UL)       /**< @brief Application processor     */
#define BCM_DEV_INFO_CPU_HSM               (0x1UL)       /**< @brief HSM processor             */
/** @} */

/**
    @name Boot mode Type
    @{
    @brief Boot mode Type

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef uint8_t BCM_BootModeIdxType;        /**< @brief Boot mode Type         */
#define BCM_BOOT_MODE_IDX_ROM    (1U)       /**< @brief ROM                    */
#define BCM_BOOT_MODE_IDX_BL     (2U)       /**< @brief BL                     */
#define BCM_BOOT_MODE_IDX_FW     (3U)       /**< @brief FW                     */
/** @} */

/** @brief Report a component error to the system

    This API is called by components to report an error to the system.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCompID     16-bit component ID
    @param[in]      aInstanceID 8-bit instance ID (starting from 0)
    @param[in]      aApiID      16-bit component specific API or interface ID
    @param[in]      aErrorID    32-bit error ID
    @param[in]      aNumInts    Number of valid entries in aValues
    @param[in]      aValues     Pointer to 32-bit data for print/debug

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_COMPONENT

    @limitations None
*/
void BCM_ReportError(BCM_CompIDType aCompID,
                       uint8_t aInstanceID,
                       uint16_t aApiID,
                       int32_t aErrorID,
                       uint32_t aNumInts,
                       const uint32_t *const aValues);

/** @brief Report a component error to the system

    This API is called by components to report an error to the system.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCompID     16-bit component ID
    @param[in]      aInstanceID 8-bit instance ID (starting from 0)
    @param[in]      aApiID      16-bit component specific API or interface ID
    @param[in]      aErrorID    32-bit error ID
    @param[in]      aLineNo     32-bit line number
    @param[in]      aState      32-bit state info
    @param[in]      aNumInts    Number of valid entries in aValues
    @param[in]      aValues     Pointer to 32-bit data for print/debug

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_COMPONENT

    @limitations None
*/
void BCM_ReportErrorV2(BCM_CompIDType aCompID,
                       uint8_t aInstanceID,
                       uint16_t aApiID,
                       int32_t aErrorID,
                       uint32_t aLineNo,
                       uint32_t aState,
                       uint32_t aNumInts,
                       const uint32_t *const aValues);

/**
    @brief Error reporting - maximum custom values

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
#define BCM_ERR_MAX_CUSTOM_VALUES   (4UL)

/**
    @brief Error information Type

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
typedef struct sBCM_DbgMsgType {
    BCM_ErrVersionType  version;                            /**< @brief 32-bit version   */
    BCM_CompIDType      comp;                               /**< @brief 16-bit comp      */
    BCM_BootModeType    bootMode;                           /**< @brief  8-bit bootInfo  */
    uint8_t             instance;                           /**< @brief  8-bit instance  */
    uint64_t            timeMS;                             /**< @brief 64-bit api       */
    uint16_t            api;                                /**< @brief 16-bit api       */
    uint16_t            line;                               /**< @brief 16-bit line      */
    BCM_StateType       state;                              /**< @brief 32-bit state     */
    int32_t             error;                              /**< @brief 32-bit error     */
    uint32_t            custom[BCM_ERR_MAX_CUSTOM_VALUES];  /**< @brief 16 byte custom   */
    BCM_DevInfoType     devInfo;                            /**< @brief 32-bit devInfo   */
    uint32_t            rsvd[4];                            /**< @brief 16 byte reserved */
} BCM_DbgMsgType;

/** @brief Added Remote Debug Mesg to Local Debug Mesg Queue

    This API is called by modules to add an error to the system.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aDebugInfo     Debug Info to add in local system debug queue

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_COMPONENT
*/
void BCM_DbgMsgPutRaw(BCM_DbgMsgType* aDebugInfo);

/** @brief Get error information

    This API is Console/Shell to log errors

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aError     Error Type pointer to be filled

    @return  #BCM_ERR_OK        Error type is filled
             #BCM_ERR_NOMEM     No Errors in memory

    @post None

    @trace #BRCM_SWREQ_BCM_COMPONENT

    @limitations None
*/
int32_t BCM_GetError(BCM_DbgMsgType *aError);

/** @brief Initialize the error module

    This API is used to initialize the error module

    @behavior Sync, Non-reentrant

    @pre None

    @param void

    @return void

    @post None

    @trace #BRCM_SWREQ_BCM_COMPONENT

    @limitations None
*/
extern void BCM_InitError(void);

#endif /* BCM_ERR_H */
/** @} */
