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
/** @defgroup grp_macsecdrv_il Integration Guide
    @ingroup grp_macsecdrv

    @addtogroup grp_macsecdrv_il
    @{
    @section sec_macsecdrv_integration MACSec driver integration Guide
    This section describes the integration interfaces and defines for
    the macsec driver.

    @file macsec_osil.h

    @brief MACSec driver Integration Interfaces
    This header file contains the integration interface for MACSec driver

    @version 0.1 Initial revision
*/

#ifndef MACSEC_OSIL_H
#define MACSEC_OSIL_H

#include <svc.h>
#include <macsec.h>

/**
    @name MACSEC driver integration IDs
    @{
    @brief Integration IDs for the MACSec driver
*/
#define BRCM_SWARCH_MACSEC_CMD_TYPE                             (0x9000U) /**< @brief #MACSEC_CmdType                 */
#define BRCM_SWARCH_MACSEC_IRQEVENT_TYPE                        (0x9001U) /**< @brief #MACSEC_IRQEventType            */
#define BRCM_SWARCH_MACSEC_IOTYPE_TYPE                          (0x9002U) /**< @brief #MACSEC_IOType                  */
#define BRCM_SWARCH_MACSEC_SYS_CMD_REQ_PROC                     (0x9003U) /**< @brief #MACSEC_SysCmdReq               */
#define BRCM_SWARCH_MACSEC_SYS_CMD_HANDLER_PROC                 (0x9004U) /**< @brief #MACSEC_SysCmdHandler           */
#define BRCM_SWARCH_MACSEC_IRQHANDLER_PROC                      (0x9005U) /**< @brief #MACSEC_IRQHandler              */
#define BRCM_SWARCH_MACSEC_DRV_IRQHANDLER_PROC                  (0x9006U) /**< @brief #MACSEC_DrvIRQHandler           */
/** @} */

/**
    @name MACSEC_CmdType
    @{
    @brief MACSec SVC command IDs

    @trace #BRCM_SWREQ_MACSEC_KERNEL_INTERFACE
*/
typedef uint32_t MACSEC_CmdType;
#define MACSEC_CMD_INIT                 (0x01UL)    /**< @brief Init command */
#define MACSEC_CMD_ADDCPRULEOPT0        (0x02UL)    /**< @brief add CP rule */
#define MACSEC_CMD_ADDCPRULEOPT1        (0x03UL)    /**< @brief add CP rule */
#define MACSEC_CMD_CREATESECY           (0x04UL)    /**< @brief Create SecY */
#define MACSEC_CMD_GETCIPHERCAP         (0x05UL)    /**< @brief Get cipher capability */
#define MACSEC_CMD_SETCIPHERSUITE       (0x06UL)    /**< @brief Set cipher suite */
#define MACSEC_CMD_ADDSECYLOOKUPRULE    (0x07UL)    /**< @brief Add SecY lookup rule */
#define MACSEC_CMD_CREATETXSC           (0x08UL)    /**< @brief create transmit channel */
#define MACSEC_CMD_CREATERXSC           (0x09UL)    /**< @brief create receive channel */
#define MACSEC_CMD_CREATETXSA           (0x0AUL)    /**< @brief create transmit SA */
#define MACSEC_CMD_CREATERXSA           (0x0BUL)    /**< @brief create receive SA */
#define MACSEC_CMD_SETPNTHRESHOLD       (0x0CUL)    /**< @brief set PN threshold cmd */
#define MACSEC_CMD_SAENABLE             (0x0DUL)    /**< @brief SA enable */
#define MACSEC_CMD_SADISABLE            (0x0EUL)    /**< @brief SA disable */
#define MACSEC_CMD_SETPROTECTFRAME      (0x0FUL)    /**< @brief set protect frame */
#define MACSEC_CMD_SETREPLAYPROTECT     (0x10UL)    /**< @brief set replay protect */
#define MACSEC_CMD_SETFRAMEVALIDATE     (0x11UL)    /**< @brief set frame validate */
#define MACSEC_CMD_SAGETSTATUS          (0x12UL)    /**< @brief SA get status */
#define MACSEC_CMD_SAGETNEXTPN          (0x13UL)    /**< @brief SA get next PN */
#define MACSEC_CMD_SASETNEXTPN          (0x14UL)    /**< @brief SA set next PN */
#define MACSEC_CMD_GETTXSCSTATS         (0x15UL)    /**< @brief Get Tx SC stats */
#define MACSEC_CMD_GETRXSCSTATS         (0x16UL)    /**< @brief Get Rx SC stats */
#define MACSEC_CMD_GETTXSASTATS         (0x17UL)    /**< @brief Get TX SA stats */
#define MACSEC_CMD_GETSECYSTATS         (0x18UL)    /**< @brief Get SecY stats */
#define MACSEC_CMD_REMOVECPRULE         (0x19U)     /**< @brief remove CP rule command */
#define MACSEC_CMD_REMOVESECYLOOKUPRULE (0x1AU)     /**< @brief remove SecY lookup rule command */
#define MACSEC_CMD_DELTXSC              (0x1BUL)    /**< @brief delete TXSC */
#define MACSEC_CMD_DELRXSC              (0x1CUL)    /**< @brief delete RXSC */
#define MACSEC_CMD_DELSA                (0x1DUL)    /**< @brief delete SA */
#define MACSEC_CMD_DELSECY              (0x1EUL)    /**< @brief delete SecY */
#define MACSEC_CMD_DEINIT               (0x1FU)     /**< @brief MACSec Deinit */
/** @} */

/**
    @name MACSEC_IRQEventType
    @{
    @brief MACSEC driver events
    Define the events which can occur in the driver (Bit mask values) and integration layer
    need to process those events.

    @trace #BRCM_SWREQ_MACSEC_KERNEL_HANDLER
*/
typedef uint32_t MACSEC_IRQEventType;
#define MACSEC_IRQEVENT_PN_THRLD       (0x01)      /**< @brief PN number threshold hit */
#define MACSEC_IRQEVENT_PN_ROLLOVER    (0x02)      /**< @brief PN number rollover */
#define MACSEC_IRQEVENT_HW_ERROR       (0x04)      /**< @brief Fatal hardware error */
/** @} */

/**
    @brief MACSec SVC IO type
    This structure is filled by the unprivileged interface
    and passed to the priviledged layer.

    @trace #BRCM_SWREQ_MACSEC_KERNEL_INTERFACE
*/
typedef struct sMACSEC_IOType {
    int32_t                     retVal;             /**< @brief return value filled by handler */
    uint32_t                    enable;             /**< @brief set to true or false */
    uint32_t                    window;             /**< @brief replay window */
    MACSEC_HwIDType             hwID;               /**< @brief hardware index */
    MACSEC_SecYHdlType          secYHdl;            /**< @brief SecY handle */
    MACSEC_SAHdlType            SAHdl;              /**< @brief SA handle */
    MACSEC_RuleHdlType          ruleHdl;            /**< @brief rule handle */
    uint32_t                    ssci;               /**< @brief SSCI value */
    uint64_t                    pn;                 /**< @brief PN value */
    MACSEC_ANType               an;                 /**< @brief Association number */
    MACSEC_ValidateFrameType    validateFrame;      /**< @brief validate frame option */
    MACSEC_CipherIdType         cipherID;           /**< @brief cipher id */
    MACSEC_CipherCapType        *cipherCap;         /**< @brief cipher capability */
    uint32_t                    confidentiality;    /**< @brief confidentiality option */
    MACSEC_ConfOffsetType       confOffset;         /**< @brief confidentiality offset */
    const MACSEC_SCIType        *sci;               /**< @brief Secure channel identified */
    const MACSEC_CfgType        *config;            /**< @brief hardware configuration */
    const MACSEC_KeyType        *key;               /**< @brief key */
    const MACSEC_SecYCfgType    *secyCfg;           /**< @brief SecY configuration */
    const MACSEC_RuleOpt0Type   *ruleOpt0;          /**< @brief rule option 0 */
    const MACSEC_RuleOpt1Type   *ruleOpt1;          /**< @brief rule option 1 */
    MACSEC_SAStatusType         *saStatus;          /**< @brief SA status */
    MACSEC_TxSCStatsType        *txSCStats;         /**< @brief TX SC stats */
    MACSEC_RxSCStatsType        *rxSCStats;         /**< @brief RX SC stats */
    MACSEC_TxSAStatsType        *txSAStats;         /**< @brief TX SA stats */
    MACSEC_SecYStatsType        *secYStats;         /**< @brief SecY stats */
} MACSEC_IOType;

/** @brief Trigger a system command request

    This API shall trigger a system command request for a given command.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCmd        Command to be executed in system context
    @param[inout]   aIO         IO structure

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Command request raised successfully
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid SVC magic
    @retval     #BCM_ERR_UNKNOWN        Integration error
    @return     others                  As defined by the the respective driver API

    @post Given command is executed

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_MACSEC_KERNEL_INTERFACE

    @limitations None
*/
int32_t MACSEC_SysCmdReq(MACSEC_CmdType aCmd, MACSEC_IOType *const aIO);

/** @brief Privileged command handler

    This interface shall handles all SVC commands raised by #MACSEC_SysCmdReq()

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMagicID    Magic ID of SVC
    @param[in]      aCmd        Command to be executed in system context
    @param[inout]   aSysIO      System IO structure to exchange information

    @return     void

    @post TBD

    @note This handler shall be installed in the SVC handlers table in system.

    @trace #BRCM_SWREQ_MACSEC_KERNEL_HANDLER

    @limitations None
*/
void MACSEC_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO);

/** @brief Interrupt handler
    Integration layer interrupt handler which is installed in the vector table.
    This handler shall call driver core interrupt handler (#MACSEC_DrvIRQHandler)

    @behavior Sync, Non-reentrant

    @param     void

    @return     void

    @note

    @trace #BRCM_SWREQ_MACSEC_KERNEL_HANDLER

    @limitations None
*/
void MACSEC_IRQHandler(void);

/** @brief Driver core interrupt handler
    MACSEC driver core interrupt handler which shall be called from the integration
    layer function (#MACSEC_IRQHandler).

    @behavior Sync, Non-reentrant

    @param[out]     aEvent      BitMasked Ored value of the IRQ Events which has occurred and need
                                to be handled by the integration layer. For example,
                                if PN threshold event has occurred, aEvent bit-1 will be set by
                                driver IRQ handler.  Integration layer shall signal to task which
                                shall prepare to create new SA with new key and switch to that
                                before PN rollover event.


    @return     void

    @note

    @trace #BRCM_SWREQ_MACSEC_KERNEL_HANDLER

    @limitations None
*/
void MACSEC_DrvIRQHandler(MACSEC_IRQEventType *const aEvent);

#endif /* MACSEC_OSIL_H */
/** @} */
