/*****************************************************************************
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

/** @defgroup grp_ipc_il Integration Guide
    @ingroup grp_ipc_v2

    @addtogroup grp_ipc_il
    @{
    @section sec_ipc_integration Integration Guide
    This section explains integration interfaces exposed by IPC.

    @file ipc_osil.h

    @brief IPC driver Integration Interfaces
    This header file contains the integration interface for IPC driver

    @version 0.1 Initial revision
*/

#ifndef IPC_OSIL_H
#define IPC_OSIL_H

#include <ipc.h>

/**
    @name IPC driver Integration Interface IDs
    @{
    @brief Integration Interface IDs for IPC driver
*/
#define BRCM_SWARCH_IPC_CMD_TYPE               (0x9100U) /**< @brief #IPC_CmdType */
#define BRCM_SWARCH_IPC_IO_TYPE                (0x9101U) /**< @brief #IPC_IOType */
#define BRCM_SWARCH_IPC_CHN_CFG_TYPE           (0x9102U) /**< @brief #IPC_ChannCfgType */
#define BRCM_SWARCH_IPC_CHN_CFG_GLOBAL         (0x9103U) /**< @brief #IPC_ChannCfg */
#define BRCM_SWARCH_IPC_SYS_CMD_REQ_PROC       (0x9104U) /**< @brief #IPC_SysCmdReq */
#define BRCM_SWARCH_IPC_SYS_CMD_HANDLER_PROC   (0x9105U) /**< @brief #IPC_SysCmdHandler */
#define BRCM_SWARCH_IPC_IRQ_HANDLER_PROC       (0x9106U) /**< @brief #IPC_IRQHandler */
#define BRCM_SWARCH_IPC_IRQ_CH0_HANDLER_PROC   (0x9107U) /**< @brief #IPC_IRQChann0Handler */
#define BRCM_SWARCH_IPC_IRQ_CH1_HANDLER_PROC   (0x9108U) /**< @brief #IPC_IRQChann1Handler */
/** @} */

/**
    @name IPC SVC Commands
    @{
    @brief IPC SVC Commands

    @trace #BRCM_SWREQ_IPC_KERNEL_INTERFACE
*/
typedef uint32_t IPC_CmdType;           /**< @brief IPC SVC command type  */
#define IPC_CMD_INIT            (0x1UL) /**< @brief #IPC_Init */
#define IPC_CMD_DEINIT          (0x2UL) /**< @brief #IPC_Deinit */
#define IPC_CMD_SEND            (0x3UL) /**< @brief #IPC_Send */
#define IPC_CMD_RECEIVE         (0x4UL) /**< @brief #IPC_Receive */
/** @} */

/**
    @brief IPC Driver IO structure passed from SysCmdReq
    to SysCmdHandler (for privileged access)

    @trace #BRCM_SWREQ_IPC_KERNEL_INTERFACE
*/
typedef struct sIPC_IOType {
    int32_t             status;           /**< @brief Status of system call */
    IPC_ChannIDType     channID;          /**< @brief IPC Channel ID */
    uint32_t            mode;             /**< @brief IPC Mode : Master or Slave */
    uint8_t             *msg;             /**< @brief Message buffer */
    uint32_t            cmd;              /**< @brief Command number */
    uint32_t            inLen;            /**< @brief Input length of the message buffer */
    uint32_t            outLen;           /**< @brief Output length of the message */
} IPC_IOType;

/**
    @brief IPC channel configuration type

    @trace #BRCM_SWREQ_IPC_DRIVER
 */
typedef struct sIPC_ChannCfgType {
    IPC_ChannModeType   mode;      /**< @brief Mode of the IPC */
    uint8_t             sizeLog2;  /**< @brief Size of the message in log2 (size = 2^sizeLog2) */
    uint8_t             cntLog2;   /**< @brief Number of the message (slots) in log2 */
} IPC_ChannCfgType;

/**
    @brief IPC channel configuration

    @trace #BRCM_SWREQ_IPC_DRIVER
 */
extern const IPC_ChannCfgType IPC_ChannCfg[IPC_MAX_CHANNELS];


/** @brief Trigger a system command request

    This API shall trigger a system command request for a given command.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCmd        Command to be executed in system context
    @param[inout]   aIO         IPC IO structure to exchange information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command request raised successfully
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid SVC magic
    @retval     #BCM_ERR_UNKNOWN        Integration error
    @return     others                  As returned by #IPC_CmdHandler

    @post Given command is executed

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_IPC_KERNEL_INTERFACE

    @limitations None
*/
int32_t IPC_SysCmdReq(const uint32_t aCmd, IPC_IOType *aIO);

/** @brief Handle all IPC driver command requests

    This interface handles all the IPC diver commands requested from System
    Command Request.

    @behavior Sync, Non-reentrant

    @pre TBD

    @param[in]      aMagicID    Magic ID of VGC
    @param[in]      aCmd        Command to be executed in system context
    @param[inout]   aSysIO      System IO structure to exchange information

    @return     void

    @post TBD

    @note This interface shall be implemented by the integrator and shall install
    it to SVC layer.

    @trace #BRCM_SWREQ_IPC_KERNEL_HANDLER

    @limitations None
*/
void IPC_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO);

/** @brief Interrupt handler

    This API shall be called by the respective channel IRQ handler

    @behavior Sync, Non-reentrant

    @param[in]  aID     IPC Channel ID

    @return     void

    @note This interface shall be called from the Interrupt Service Routine for
    IPC driver. The IPC client shall be notified from the Interrupt Service
    Routine through events.

    @trace #BRCM_SWREQ_IPC_KERNEL_HANDLER

    @limitations None
*/
void IPC_IRQHandler(IPC_ChannIDType aID);

/** @brief Interrupt service routine for Channel 0

    Interrupt service routine to be installed in the vector table
    for the IPC channel 0

    @behavior Sync, Non-reentrant

    @return     void

    @trace #BRCM_SWREQ_IPC_KERNEL_HANDLER

    @limitations None
*/
void IPC_IRQChann0Handler(void);

/** @brief Interrupt service routine for Channel 1

    Interrupt service routine to be installed in the vector table
    for the IPC channel 1

    @behavior Sync, Non-reentrant

    @return     void

    @trace #BRCM_SWREQ_IPC_KERNEL_HANDLER

    @limitations None
*/
void IPC_IRQChann1Handler(void);

#endif /* IPC_OSIL_H */
/** @} */
