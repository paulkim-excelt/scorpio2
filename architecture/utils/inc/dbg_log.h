/*****************************************************************************
 Copyright 2017-20 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_utils_dbg_log_ifc Debug log Interface
    @ingroup grp_utils

    @addtogroup grp_utils_dbg_log_ifc
    @{

    @file dbg_log.h
    @brief Debug codes

    @version 1.0 Imported
*/
#ifndef DBG_LOG_H
#define DBG_LOG_H

#include <inttypes.h>

/**
    @name Architecture IDs
    @{
    @brief Architecture IDs for debug codes

*/
#define BRCM_SWARCH_DBG_LOG_MACRO         (0x8401U)    /**< @brief #DBG_LogType   */
#define BRCM_SWARCH_DBG_LOGSTATUS_PROC    (0x8402U)    /**< @brief #DBG_LogStatus */
/** @} */

/**
    @name Debug Codes
    @{
    @brief Debug codes for logging

    In addition to codes described here, below codes could be used in Startup
    routine and are passed via compiler/assembler flags
    DBG_LOG_START_CODE=1
    DBG_LOG_ROM_BYPASS=2
    DBG_LOG_CHECK_PLL_STATUS=3
    DBG_LOG_PLL_NOT_LOCKED_LOOP=4
    DBG_LOG_SWITCH_CPU_CLK=5
    DBG_LOG_TCM_INIT=6
    DBG_LOG_TCM_TEST_PASS=7
    DBG_LOG_TCM_TEST_FAIL=8

    @trace #BRCM_SWREQ_DBG_LOG
*/
typedef uint8_t DBG_LogType;
#define DBG_LOG_EARLY_INIT_ENTER                  (16U)                           /**< @brief Entered early init      */
#define DBG_LOG_MPU_ENABLED                       (DBG_LOG_EARLY_INIT_ENTER + 1U) /**< @brief MPU Configured          */
#define DBG_LOG_MCU_INIT                          (DBG_LOG_EARLY_INIT_ENTER + 2U) /**< @brief MCU Init done           */

#define DBG_LOG_ENTRY_MAIN                        (32U)                           /**< @brief Entry into the C main   */
#define DBG_LOG_WDT_INIT                          (DBG_LOG_ENTRY_MAIN +  1U)      /**< @brief Watchdog Timer Init done*/
#define DBG_LOG_TIM_INIT                          (DBG_LOG_ENTRY_MAIN +  2U)      /**< @brief Timer Init done         */
#define DBG_LOG_LOG_INIT                          (DBG_LOG_ENTRY_MAIN +  3U)      /**< @brief Logging Init done       */
#define DBG_LOG_OTP_INIT                          (DBG_LOG_ENTRY_MAIN +  4U)      /**< @brief OTP Init done           */
#define DBG_LOG_READ_IP_CONFIG                    (DBG_LOG_ENTRY_MAIN +  5U)      /**< @brief Read IP Configuration   */
#define DBG_LOG_READ_SWT_CONFIG                   (DBG_LOG_ENTRY_MAIN +  6U)      /**< @brief Read Switch Config      */
#define DBG_LOG_WAIT_FOR_SWITCH_INIT              (DBG_LOG_ENTRY_MAIN +  7U)      /**< @brief Wait for Switch Init    */
#define DBG_LOG_WAIT_FOR_SWITCH_INIT_DONE         (DBG_LOG_ENTRY_MAIN +  8U)      /**< @brief Wait for Switch Init Done*/
#define DBG_LOG_ETHER_INIT                        (DBG_LOG_ENTRY_MAIN +  9U)      /**< @brief Ethernet Driver Init    */
#define DBG_LOG_NIF_INIT                          (DBG_LOG_ENTRY_MAIN + 10U)      /**< @brief NIF Init                */
#define DBG_LOG_INET_INIT                         (DBG_LOG_ENTRY_MAIN + 11U)      /**< @brief INET Init               */
#define DBG_LOG_SWT_INIT                          (DBG_LOG_ENTRY_MAIN + 12U)      /**< @brief Switch Init             */
#define DBG_LOG_SWT_SET_UPLINK_PORT               (DBG_LOG_ENTRY_MAIN + 13U)      /**< @brief Switch Set Uplink port  */
#define DBG_LOG_SWT_SET_TYPE                      (DBG_LOG_ENTRY_MAIN + 14U)      /**< @brief Switch Set Type         */
#define DBG_LOG_SWT_ADD_VLAN_UNTAGGED             (DBG_LOG_ENTRY_MAIN + 15U)      /**< @brief Switch Add VLAN for untagged*/
#define DBG_LOG_SWT_ADD_VLAN_PRIVATE              (DBG_LOG_ENTRY_MAIN + 16U)      /**< @brief Switch Add private VLAN */
#define DBG_LOG_SWT_MGMT_INIT                     (DBG_LOG_ENTRY_MAIN + 17U)      /**< @brief Switch Management Init  */

#define DBG_LOG_READ_XCVR_CONFIG                  (64U)                           /**< @brief Read Transceiver Config */
#define DBG_LOG_APPLY_XCVR_MIN_CONFIG             (DBG_LOG_READ_XCVR_CONFIG + 1U) /**< @brief Apply Minimal Transceiver Config*/
#define DBG_LOG_APPLY_XCVR_FULL_CONFIG            (DBG_LOG_READ_XCVR_CONFIG + 2U) /**< @brief Apply Full Transceiver Config   */

#define DBG_LOG_READ_TC10_CONFIG                 (96U)                           /**< @brief Read TC10 Configuration */
#define DBG_LOG_COLLECT_TC10_FWD_FAILED          (DBG_LOG_READ_TC10_CONFIG + 1U) /**< @brief Collect TC10 Forward Failed */
#define DBG_LOG_COLLECT_TC10_FWD_SUCCESS         (DBG_LOG_READ_TC10_CONFIG + 2U) /**< @brief Collect TC10 Forward Success*/
#define DBG_LOG_APPLY_TC10_FWD_FAILED            (DBG_LOG_READ_TC10_CONFIG + 3U) /**< @brief Apply TC10 Forward Failed   */
#define DBG_LOG_APPLY_TC10_FWD_SUCCESS           (DBG_LOG_READ_TC10_CONFIG + 4U) /**< @brief Apply TC10 Forward Success  */
#define DBG_LOG_APPLY_TC10_SYNC_SUCCESS          (DBG_LOG_READ_TC10_CONFIG + 5U) /**< @brief TC10 Sync Complete          */
#define DBG_LOG_APPLY_TC10_FWD_COMPLETE          (DBG_LOG_READ_TC10_CONFIG + 6U) /**< @brief Apply TC10 Forward Complete */

#define DBG_LOG_READ_PKEY_CONFIG                  (128U) /**< @brief Read Public Key         */
#define DBG_LOG_READ_SKEY_CONFIG                  (DBG_LOG_READ_PKEY_CONFIG + 1U) /**< @brief Read Symmetric Key      */
#define DBG_LOG_SKIP_FLASH_LOADER                 (DBG_LOG_READ_PKEY_CONFIG + 2U) /**< @brief Skip Flash Loader       */
#define DBG_LOG_LOADER_INIT_SUCCESS               (DBG_LOG_READ_PKEY_CONFIG + 3U) /**< @brief Loader Init Success     */
#define DBG_LOG_LOADER_INIT_FAILED                (DBG_LOG_READ_PKEY_CONFIG + 4U) /**< @brief Loader Init Failed      */
#define DBG_LOG_LOADER_IMG_NOT_FOUND              (DBG_LOG_READ_PKEY_CONFIG + 5U) /**< @brief Loader Image not found  */
#define DBG_LOG_LOADER_VERIFY_SUCCESS             (DBG_LOG_READ_PKEY_CONFIG + 6U) /**< @brief Loader Verification Success     */
#define DBG_LOG_LOADER_VERIFY_FAILED              (DBG_LOG_READ_PKEY_CONFIG + 7U) /**< @brief Loader Verification Failed      */
#define DBG_LOG_LOADER_DEINIT_SUCCESS             (DBG_LOG_READ_PKEY_CONFIG + 8U) /**< @brief Loader Deinit Success   */

#define DBG_LOG_IPCLDR_FETCH_IMG_ENTRY            (144U)
#define DBG_LOG_IPCLDR_CMD_PING_ROM               (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 1U)
#define DBG_LOG_IPCLDR_CMD_PING_INT               (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 2U)
#define DBG_LOG_IPCLDR_CMD_IMG_HDR                (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 3U)
#define DBG_LOG_IPCLDR_CMD_IMG                    (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 4U)
#define DBG_LOG_IPCLDR_CMD_INVALID                (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 5U)
#define DBG_LOG_IPCLDR_CMD_TIMEOUT                (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 6U)
#define DBG_LOG_IPCLDR_FETCH_IMG_SUCCESS          (DBG_LOG_IPCLDR_FETCH_IMG_ENTRY + 7U)

#define DBG_LOG_TFTPLDR_STATICIP_ASSIGNED         (160U)                                    /**< @brief Static IP assigned */
#define DBG_LOG_TFTPLDR_DHCP_INIT_FAILED          (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 1U)  /**< @brief DHCP initialization failed */
#define DBG_LOG_TFTPLDR_TFTP_ENDPT_NOTFOUND       (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 2U)  /**< @brief TFTP end point not found */
#define DBG_LOG_TFTPLDR_INTF_NOTFOUND             (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 3U)  /**< @brief INET interface not found */
#define DBG_LOG_TFTPLDR_DHCP_ENDPT_NOTFOUND       (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 4U)  /**< @brief DHCP end point not found */
#define DBG_LOG_TFTPLDR_DHCP_STARTED              (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 5U)  /**< @brief DHCP started */
#define DBG_LOG_TFTPLDR_DHCP_OFFER_SELECTED       (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 6U)  /**< @brief DHCP offer selected */
#define DBG_LOG_TFTPLDR_DHCP_FINISHED             (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 7U)  /**< @brief DHCP finished */
#define DBG_LOG_TFTPLDR_DHCP_INVALID_IP           (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 8U)  /**< @brief Invalid IP address */
#define DBG_LOG_TFTPLDR_DHCP_INVALID_ROUTER       (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 9U)  /**< @brief Invalid router IP address */
#define DBG_LOG_TFTPLDR_DHCP_INVALID_SUBNET       (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 10U) /**< @brief Invalid subnet */
#define DBG_LOG_TFTPLDR_DHCP_IF_UPDATE_FAILED     (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 11U) /**< @brief Interface update failed  */
#define DBG_LOG_TFTPLDR_DHCP_INVALID_TFTP_SERVER  (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 12U) /**< @brief Invalid TFTP server IP address */
#define DBG_LOG_TFTPLDR_DHCP_INVALID_BOOTFILE     (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 13U) /**< @brief Invalid boot file */
#define DBG_LOG_TFTPLDR_FETCH_IMG_ENTRY           (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 14U) /**< @brief TFTP loader fetch image invoked */
#define DBG_LOG_TFTPLDR_TFTP_REQ_SENT             (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 15U) /**< @brief TFTP read request sent */
#define DBG_LOG_TFTPLDR_FETCH_IMG_SUCCESS         (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 16U) /**< @brief TFTP loader fetch image successful */
#define DBG_LOG_TFTPLDR_FETCH_IMG_FAILED          (DBG_LOG_TFTPLDR_STATICIP_ASSIGNED + 17U) /**< @brief TFTP loader fetch image failed */

#define DBG_LOG_SWT_DISABLE_CPU_PORT              (192U)                              /**< @brief Disable CPU Port    */
#define DBG_LOG_INET_DEINIT                       (DBG_LOG_SWT_DISABLE_CPU_PORT + 1U) /**< @brief INET Deinit         */
#define DBG_LOG_NIF_DEINIT                        (DBG_LOG_SWT_DISABLE_CPU_PORT + 2U) /**< @brief NIF Deinit          */
#define DBG_LOG_ETHER_DEINIT                      (DBG_LOG_SWT_DISABLE_CPU_PORT + 3U) /**< @brief Ethernet Deinit     */
#define DBG_LOG_OTP_DEINIT                        (DBG_LOG_SWT_DISABLE_CPU_PORT + 4U) /**< @brief OTP Deinit          */
#define DBG_LOG_LOG_DEINIT                        (DBG_LOG_SWT_DISABLE_CPU_PORT + 5U) /**< @brief Logging Deinit      */

#define DBG_LOG_ENTER_DOWNLOADED_EXE              (255U)    /**< @brief Branching to loaded exe */



/** @} */

/** @brief Log the debug status code

    This API is called by components to log the status of the execution.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aDebugCode  8-bit Debug code

    @return void

    @post None

    @trace #BRCM_SWREQ_DBG_LOG

    @limitations Only codes beyond DBG_LOG_START_OFFSET will be logged to memory

    @note This is placed here for declaration only. Definition shall be platform specific, and may be
    implemented in assembly, as some calls would be made in very early stages of boot and is expected
    to work without using any stack
*/
extern void DBG_LogStatus(DBG_LogType aDebugCode);

#endif /* DBG_LOG_H */
/** @} */
