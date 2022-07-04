/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_fa_drv_impl Flow Accelerator Driver Implementation
    @ingroup grp_ethswt

    @addtogroup grp_fa_drv_impl
    @{

    @file ethswt_fadrv.c
    @brief Flow Accelerator driver implementation
    This header file contains the implementation of Flow accelerator driver

    @version 0.1 Initial version
*/

#include <ethswt_fa.h>
#include <ethswt_common_osil.h>
#include <ethswt_fa_osil.h>

#include <bcm_utils.h>
#include <ctf_rdb.h>
#include <switch_rdb.h>
#include <bcm_time.h>
#include <crc.h>
#include <mcu_switch_ext.h>

/**
    @name Flow Accelerator DriverAPI IDs
    @{
    @brief API IDs for Flow Accelerator Driver
*/
#define BRCM_SWDSGN_ETHSWT_FA_TSPERIOD_DEF_MACRO    (0xB701U)    /**< @brief #ETHSWT_FA_TIMESTAMP_PERIOD_SEC_DEFAULT */
#define BRCM_SWDSGN_ETHSWT_FADRV_TYPE               (0xB702U)    /**< @brief #ETHSWT_FADrvType                       */
#define BRCM_SWDSGN_ETHSWT_FATABLE_TYPE             (0xB703U)    /**< @brief #ETHSWT_FATableType                     */
#define BRCM_SWDSGN_ETHSWT_FATABLEACCESS_TYPE       (0xB704U)    /**< @brief #ETHSWT_FATableAccessType               */
#define BRCM_SWDSGN_ETHSWT_FADRV_GLOBAL             (0xB705U)    /**< @brief #ETHSWT_FADrv                           */
#define BRCM_SWDSGN_ETHSWT_FAREGS_GLOBAL            (0xB706U)    /**< @brief #ETHSWT_FARegs                          */
#define BRCM_SWDSGN_ETHSWT_FAWAITFORCOMP_PROC       (0xB707U)    /**< @brief #ETHSWT_FAWaitForAccessCompletion       */
#define BRCM_SWDSGN_ETHSWT_FATABLEACCESS_PROC       (0xB708U)    /**< @brief #ETHSWT_FATableAccess                   */
#define BRCM_SWDSGN_ETHSWT_FAUPDTBUCKETID_PROC      (0xB709U)    /**< @brief #ETHSWT_FAUpdateBucketID                */
#define BRCM_SWDSGN_ETHSWT_FAPOOLTABLEDEL_PROC      (0xB70AU)    /**< @brief #ETHSWT_FAPoolEntryDelete               */
#define BRCM_SWDSGN_ETHSWT_FANHTABLEDELETE_PROC     (0xB70BU)    /**< @brief #ETHSWT_FANextHopEntryDelete            */
#define BRCM_SWDSGN_ETHSWT_FAPOOLTABLEADD_PROC      (0xB70CU)    /**< @brief #ETHSWT_FAPoolEntryAdd                  */
#define BRCM_SWDSGN_ETHSWT_FANHTABLEADD_PROC        (0xB70DU)    /**< @brief #ETHSWT_FANextHopEntryAdd               */
#define BRCM_SWDSGN_ETHSWT_FADRVINIT_PROC           (0xB70EU)    /**< @brief #ETHSWT_FADrvInit                       */
#define BRCM_SWDSGN_ETHSWT_FADRVDEINIT_PROC         (0xB70FU)    /**< @brief #ETHSWT_FADrvDeinit                     */
#define BRCM_SWDSGN_ETHSWT_FADRVFLOWADD_PROC        (0xB710U)    /**< @brief #ETHSWT_FADrvFlowAdd                    */
#define BRCM_SWDSGN_ETHSWT_FADRVFLOWDELETE_PROC     (0xB711U)    /**< @brief #ETHSWT_FADrvFlowDelete                 */
#define BRCM_SWDSGN_ETHSWT_FADRVFLOWGET_PROC        (0xB712U)    /**< @brief #ETHSWT_FADrvFlowGet                    */
#define BRCM_SWDSGN_ETHSWT_FADRVSTATS_PROC          (0xB713U)    /**< @brief #ETHSWT_FADrvStats                      */
#define BRCM_SWDSGN_ETHSWT_FADRVTIMER_PROC          (0xB714U)    /**< @brief #ETHSWT_FADrvTimer                      */
#define BRCM_SWDSGN_ETHSWT_FACMDHANDLER_PROC        (0xB715U)    /**< @brief #ETHSWT_FACmdHandler                    */
#define BRCM_SWDSGN_ETHSWT_FA_RETRIES_MACRO         (0xB716U)    /**< @brief #ETHSWT_FA_TABLE_ACCESS_RETRIES         */
#define BRCM_SWDSGN_ETHSWT_FA_HASH_BUCKETS_MACRO    (0xB717U)    /**< @brief #ETHSWT_FA_FLOWTABLE_HASH_BUCKETS       */
#define BRCM_SWDSGN_ETHSWT_FADRVERR_PROC            (0xB718U)    /**< @brief #ETHSWT_FADrvErr                        */
#define BRCM_SWDSGN_ETHSWT_FAFT2STRUCT_PROC         (0xB719U)    /**< @brief #ETHSWT_FAFlowTable2Struct              */
#define BRCM_SWDSGN_ETHSWT_FASTRUCT2FT_PROC         (0xB71AU)    /**< @brief #ETHSWT_FAStruct2FlowTable              */
#define BRCM_SWDSGN_ETHSWT_FAGENERATEHASH_PROC      (0xB71BU)    /**< @brief #ETHSWT_FAGenerateHash                  */
#define BRCM_SWDSGN_ETHSWT_FANEXTHOP_TYPE           (0xB71CU)    /**< @brief #ETHSWT_FANextHopType                   */
#define BRCM_SWDSGN_ETHSWT_FAIRQHANDLER_PROC        (0xB71DU)    /**< @brief #ETHSWT_FAIRQHandler                    */
#define BRCM_SWDSGN_ETHSWT_FAPOOLTABLEACQPROC       (0xB71EU)    /**< @brief #ETHSWT_FAPoolEntryAcquire              */
#define BRCM_SWDSGN_ETHSWT_FAPOOLTABLERELPROC       (0xB71FU)    /**< @brief #ETHSWT_FAPoolEntryRelease              */
#define BRCM_SWDSGN_ETHSWT_FADRVMACPOOLGETPROC      (0xB720U)    /**< @brief #ETHSWT_FADrvMacPoolGet                 */
#define BRCM_SWDSGN_ETHSWT_FADRVENABLEINTR_PROC     (0xB721U)    /**< @brief #ETHSWT_FADrvEnableInterrupt            */
/** @} */

/**
    @brief Default timestamp period

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
#define ETHSWT_FA_TIMESTAMP_PERIOD_SEC_DEFAULT  (3600UL)

/**
    @brief Number of retries for table access

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
#define ETHSWT_FA_TABLE_ACCESS_RETRIES  (10UL)

/**
    @brief Number of buckets per hash index(Flow Table)

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
#define ETHSWT_FA_FLOWTABLE_HASH_BUCKETS (4U)

/**
    @name ETHSWT_FANextHopType
    @{
    @brief FA Driver NextHop table parameter Type

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
typedef struct sETHSWT_FANextHopType {
    uint16_t refCount;  /**< @brief Reference count of Mac Address */
    uint16_t vlan;      /**< @brief TCI */
    uint8_t mac[6UL];   /**< @brief Mac Address */
    uint8_t misc;       /**< @brief [7:3]=Reserved, [2:1]=Operation and [0]=frame_type */
} ETHSWT_FANextHopType;
/** @} */

/**
    @name ETHSWT_FADrvType
    @{
    @brief FA Driver Type

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
typedef struct sETHSWT_FADrvType {
    ETHSWT_FAFlowStatusType flowStatus; /**< FLow status bitmask */
    uint64_t lastTimeNs;        /**< @brief Latest timestamp */
    uint32_t timestampPeriodSec;/**< @brief Timestamp period in seconds */
    ETHSWT_FAPoolTableInfoType pool; /**< @brief Pool table cache */
    ETHSWT_FANextHopType nextHop[ETHSWT_FA_NEXTHOP_MAX];/**< @brief NextHop table cache */
    uint16_t flowTableUsage;    /**< @brief Number of entries used in Flow Table */
    uint8_t nextHopTableUsage;  /**< @brief Number of entries used in Next-Hop Table */
    uint8_t currentTimestamp;   /**< @brief Current timestamp */
    uint32_t init;              /**< @brief Initialisation status */
    uint16_t seedValue;         /**< @brief Seedvalue */
    uint16_t polynomial;        /**< @brief CRC polynomial */
    ETHSWT_FAIntrFlagsType intrFlags; /**< @brief Interrupt Flags */
    ETHSWT_FACtfModeType mode;  /**< @brief CTF operational mode */
    uint32_t validateMatchDA;   /**< @brief TRUE:Validation of Match-DA will be enabled, FALSE: disabled */
} ETHSWT_FADrvType;
/** @} */

/**
    @name ETHSWT_FATableType

    @brief FA Table type

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
    @{
*/
typedef uint8_t ETHSWT_FATableType;
#define ETHSWT_FATABLE_FLOW     (0x00U)     /**< @brief Flow table */
#define ETHSWT_FATABLE_POOL     (0x01U)     /**< @brief Pool table */
#define ETHSWT_FATABLE_NEXTHOP  (0x02U)     /**< @brief Nexthop table */
/** @} */

/**
    @name ETHSWT_FATableAccessType

    @brief FA Table access type

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
    @{
*/
typedef uint8_t ETHSWT_FATableAccessType;
#define ETHSWT_FATABLEACCESS_READ  (0U)     /**< @brief Read access */
#define ETHSWT_FATABLEACCESS_WRITE (1U)     /**< @brief Write access */
/** @} */

/**
    @brief FA driver structure

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
static ETHSWT_FADrvType ETHSWT_FADrv[CTF_MAX_HW_ID] COMP_SECTION(".bss.drivers");

/**
    @brief FA register base

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
static CTF_RDBType *const ETHSWT_FARegs[CTF_MAX_HW_ID] = {(CTF_RDBType *)CTF_BASE,};

/** @brief Driver error report

    This API reports the error

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aApiID      API ID
    @param[in]  aErr        Error value
    @param[in]  aVal0       Value 0
    @param[in]  aVal1       Value 1
    @param[in]  aVal2       Value 2
    @param[in]  aVal3       Value 3

    @return    void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3}
    BCM_ReportError(BCM_SWT_ID, 0U, aApiID, aErr, 4UL, values)
    @endcode
*/
static void ETHSWT_FADrvErr(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                      uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_SWT_ID, 0U, aApiID, aErr, 4UL, values);
}

/** @brief Wait for completion of Table access

    This API will wait for a finite period for completion of Table access

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID         Instance identifier
    @param[in]  aIndex      Index of table entry who access is to be completed

    @return    void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    retries = ETHSWT_FA_TABLE_ACCESS_RETRIES
    do {
        regVal = ETHSWT_FARegs[aID]->mem_acc_control
        currIndex = (regVal & CTF_MEM_ACC_CONT_CONTROL_CURRENT_TABLE_INDEX_MASK)
            >> CTF_MEM_ACC_CONT_CONTROL_CURRENT_TABLE_INDEX_SHIFT
        if (currIndex != (aIndex + 1U))
            break
    } while (0UL != --retries)

    if (0UL == retries)
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FAWAITFORCOMP_PROC, BCM_ERR_TIME_OUT,
                        __LINE__, regVal, retries, aIndex)
    @endcode
*/
static inline void ETHSWT_FAWaitForAccessCompletion(uint8_t aID, uint16_t aIndex)
{
    uint32_t regVal;
    uint16_t currIndex;
    uint32_t retries = ETHSWT_FA_TABLE_ACCESS_RETRIES;

    do {
        regVal = ETHSWT_FARegs[aID]->mem_acc_control;
        currIndex = (uint16_t)((regVal & CTF_MEM_ACC_CONT_CONTROL_CURRENT_TABLE_INDEX_MASK)
            >> CTF_MEM_ACC_CONT_CONTROL_CURRENT_TABLE_INDEX_SHIFT);
        if (currIndex != aIndex) {
            break;
        }
    } while (0UL != --retries);

    if (0UL == retries) {
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FAWAITFORCOMP_PROC, BCM_ERR_TIME_OUT,
                        __LINE__, regVal, retries, aIndex);
    }
}

/** @brief Access a table entry

    This API will access(read/write) an entry in one of the tables(Pool, Flow
    or Next-hop tables).

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Instance identifier
    @param[in]      aTable      Type of table as #ETHSWT_FATableType
    @param[in]      aIndex      Index to be accessed
    @param[in]      aAccess     Access type as #ETHSWT_FATableAccessType
    @param[inOut]   aBuff       Pointer to an array of unsigned 32-bit integers
                                For a read operation, aBuff is updated with the
                                values in the table.
                                For a write operation, values in aBuff are
                                written to table.

    @return    void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (ETHSWT_FATABLE_FLOW == aTable)
        regIndex = 7L
    else if (ETHSWT_FATABLE_POOL == aTable)
        regIndex = 1L
    else
        regIndex = 2L

    if (ETHSWT_FATABLEACCESS_READ == aAccess)
        regVal = CTF_MEM_ACC_CONT_CONTROL_RD_WR_N_MASK

    regVal |= ((aTable << CTF_MEM_ACC_CONT_CONTROL_TABLE_SELECT_SHIFT)
            & CTF_MEM_ACC_CONT_CONTROL_TABLE_SELECT_MASK)
    regVal |= ((aIndex << CTF_MEM_ACC_CONT_CONTROL_TABLE_INDEX_SHIFT)
                & CTF_MEM_ACC_CONT_CONTROL_TABLE_INDEX_MASK)
    ETHSWT_FARegs[aID]->mem_acc_control = regVal

    if (ETHSWT_FATABLEACCESS_READ == aAccess)
        regVal = ETHSWT_FARegs[aID]->mem_acc_data[0];
        ETHSWT_FAWaitForAccessCompletion(aID, aIndex);
        while (regIndex >= 0UL)
            aBuff[regIndex] = ETHSWT_FARegs[aID]->mem_acc_data[regIndex];
            regIndex--
    else
        while (regIndex >= 0UL)
            ETHSWT_FARegs[aID]->mem_acc_data[regIndex] = aBuff[regIndex];
            regIndex--
        ETHSWT_FAWaitForAccessCompletion(aID, aIndex)
    @endcode
*/
static void ETHSWT_FATableAccess(uint8_t aID, ETHSWT_FATableType aTable,
                                 uint16_t aIndex,
                                 ETHSWT_FATableAccessType aAccess, uint32_t *aBuff)
{
    uint32_t regVal;
    int32_t regIndex; /* Number of registers to access */

    if (ETHSWT_FATABLE_FLOW == aTable) {
        regIndex = 7L; /* 256bits = 32 * 8 registers */
    } else if (ETHSWT_FATABLE_POOL == aTable) {
        regIndex = 1L; /* 49bits = 32 * 2 registers */
    } else {
        regIndex = 2L; /* 67bits = 32 * 3 registers */
    }

    if (ETHSWT_FATABLEACCESS_READ == aAccess) {
        regVal = CTF_MEM_ACC_CONT_CONTROL_RD_WR_N_MASK;
    } else {
        regVal = 0UL;
    }

    regVal |= (((uint32_t)aTable << CTF_MEM_ACC_CONT_CONTROL_TABLE_SELECT_SHIFT)
                & CTF_MEM_ACC_CONT_CONTROL_TABLE_SELECT_MASK);
    regVal |= (((uint32_t)aIndex << CTF_MEM_ACC_CONT_CONTROL_TABLE_INDEX_SHIFT)
                & CTF_MEM_ACC_CONT_CONTROL_TABLE_INDEX_MASK);
    ETHSWT_FARegs[aID]->mem_acc_control = regVal;

    if (ETHSWT_FATABLEACCESS_READ == aAccess) {
        /* dummy read to trigger table read */
        regVal = ETHSWT_FARegs[aID]->mem_acc_data[0];

        /* verify that table read has completed */
        ETHSWT_FAWaitForAccessCompletion(aID, aIndex);

        while (regIndex >= 0L) {
            aBuff[regIndex] = ETHSWT_FARegs[aID]->mem_acc_data[regIndex];
            regIndex--;
        }
    } else {
        while (regIndex >= 0L) {
            ETHSWT_FARegs[aID]->mem_acc_data[regIndex] = aBuff[regIndex];
            regIndex--;
        }

        /* verify that table write has completed */
        ETHSWT_FAWaitForAccessCompletion(aID, aIndex);
    }
}

/** @brief Extract elements from Flow Table

    This API will extract individual elements from the Flow table

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aBuff        Pointer to an array of 32-bit unsigned integers
    @param[out]     aFlow        Flow struct will be filled if not NULL
    @param[out]     aFlowStats   Flow statistics struct will be filled if not NULL
    @param[out]     aPoolIdx     Pool table index will be filled if not NULL
    @param[out]     aNextHopIdx  NextHop table index will be filled if not NULL

    Return values are documented in reverse-chronological order
    @retval     TRUE        Valid Entry found
    @retval     FALSE       No valid Entry found

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    ETHSWT_FAMatchType *match = &aFlow->match;
    ETHSWT_FARemapType *remap = &aFlow->remap

    if (0UL != (aBuff[7U] & (1UL<< 31UL)))
        isIPv4 = TRUE
        isValid = (uint8_t)((aBuff[6U] >> 20U) & 0x1U)
    else
        isIPv4 = FALSE
        isValid = (uint8_t)((aBuff[7U] >> 20U) & 0x1U)

    if (TRUE == isValid)
        if (NULL != aFlowStats)
            aFlowStats->lastTimestamp = (uint8_t)(aBuff[0U] & 0x7U)
            aFlowStats->hits = (aBuff[1U] << 28U) | (aBuff[0] >> 3U)

        if (NULL != aPoolIdx)
            *aPoolIdx = (uint8_t)((aBuff[1U] >> 6U) & 0x3U)

        if (NULL != aNextHopIdx)
            *aNextHopIdx = (uint8_t)((aBuff[1U] >> 8U) & 0x7FU)

        if (NULL != aFlow)
            remapIp = (aBuff[1U] >> 3U) & 0x1U
            remapPort = (aBuff[1U] >> 4U) & 0x1U
            if (1U == isIPv4)
                ipPtr = &match->dstIp[0]
                ipPtr[0U] = (uint8_t)((aBuff[4U] >> 24U) & 0xFFU)
                ipPtr[1U] = (uint8_t)((aBuff[4U] >> 16U) & 0xFFU)
                ipPtr[2U] = (uint8_t)((aBuff[4U] >> 8U) & 0xFFU)
                ipPtr[3U] = (uint8_t)((aBuff[4U] >> 0U) & 0xFFU)

                ipPtr = &match->srcIp[0]
                ipPtr[0U] = (uint8_t)((aBuff[5U] >> 24U) & 0xFFU)
                ipPtr[1U] = (uint8_t)((aBuff[5U] >> 16U) & 0xFFU)
                ipPtr[2U] = (uint8_t)((aBuff[5U] >> 8U) & 0xFFU)
                ipPtr[3U] = (uint8_t)((aBuff[5U] >> 0U) & 0xFFU)

                match->flags |= ETHSWT_FAFLAGS_L3IPV4

                bhRegValue = aBuff[6U]
                tcpRegValue = aBuff[3U]
                remapPortIpRegValue = aBuff[2U]

                if (0U != remapIp)
                    remap->ip[1U] = (uint8_t)(aBuff[1U] >> 31UL)
                    remap->ip[2U] = (uint8_t)(aBuff[1U] >> 23UL)
                    remap->ip[3U] = (uint8_t)(aBuff[1U] >> 15UL)
            else
                ipPtr = &match->dstIp[0]
                for (i = 0U i < 4U i++)
                    ipPtr[i * 4U + 0U] = (uint8_t)((aBuff[11U - i] >> 24U) & 0xFFU)
                    ipPtr[i * 4U + 1U] = (uint8_t)((aBuff[11U - i] >> 16U) & 0xFFU)
                    ipPtr[i * 4U + 2U] = (uint8_t)((aBuff[11U - i] >> 8U) & 0xFFU)
                    ipPtr[i * 4U + 3U] = (uint8_t)((aBuff[11U - i] >> 0U) & 0xFFU)

                ipPtr = &match->srcIp[0]
                for (i = 0U i < 4U i++)
                    ipPtr[i * 4U + 0U] = (uint8_t)((aBuff[15U - i] >> 24U) & 0xFFU)
                    ipPtr[i * 4U + 1U] = (uint8_t)((aBuff[15U - i] >> 16U) & 0xFFU)
                    ipPtr[i * 4U + 2U] = (uint8_t)((aBuff[15U - i] >> 8U) & 0xFFU)
                    ipPtr[i * 4U + 3U] = (uint8_t)((aBuff[15U - i] >> 0U) & 0xFFU)

                match->flags &= ~ETHSWT_FAFLAGS_L3IPV4

                bhRegValue = aBuff[7U]
                tcpRegValue = aBuff[6U]
                remapPortIpRegValue = aBuff[5U]
                if (0U != remapIp)
                    remap->ip[1U] = (uint8_t)(aBuff[4U] >> 31UL)
                    remap->ip[2U] = (uint8_t)((aBuff[4U] >> 23UL) & 0xFFU)
                    remap->ip[3U] = (uint8_t)((aBuff[4U] >> 15UL) & 0xFFU)
                    remap->ip[4U] = (uint8_t)((aBuff[4U] >> 7UL) & 0xFFU)
                    remap->ip[5U] = (uint8_t)(((aBuff[4U] << 1UL) & 0xFEU)
                                              | (aBuff[3U] >> 31UL))

                    remap->ip[6U] = (uint8_t)((aBuff[3U] >> 23UL) & 0xFFU)
                    remap->ip[7U] = (uint8_t)((aBuff[3U] >> 15UL) & 0xFFU)
                    remap->ip[8U] = (uint8_t)((aBuff[3U] >> 7UL) & 0xFFU)
                    remap->ip[9U] = (uint8_t)(((aBuff[3U] << 1UL) & 0xFEU)
                                              | (aBuff[2U] >> 31UL))

                    remap->ip[10U] = (uint8_t)((aBuff[2U] >> 23UL) & 0xFFU)
                    remap->ip[11U] = (uint8_t)((aBuff[2U] >> 15UL) & 0xFFU)
                    remap->ip[12U] = (uint8_t)((aBuff[2U] >> 7UL) & 0xFFU)
                    remap->ip[13U] = (uint8_t)(((aBuff[2U] << 1UL) & 0xFEU)
                                              | (aBuff[1U] >> 31UL))

                    remap->ip[14U] = (uint8_t)((aBuff[1U] >> 23UL) & 0xFFU)
                    remap->ip[15U] = (uint8_t)((aBuff[1U] >> 15UL) & 0xFFU)

             if (0UL != (bhRegValue & 0x1UL))
                 match->flags |= ETHSWT_FAFLAGS_INBOUND
             else
                 match->flags &= ~ETHSWT_FAFLAGS_INBOUND
             if (0UL == ((bhRegValue >> 17U) & 0x7U))
                remap->portMask = (uint16_t)((bhRegValue >> 1U) & 0x3FFUL)
             else
                remap->portMask = 0U
             remap->tc = (uint8_t)((bhRegValue >> 14U) & 0x7U)
             remap->te = (uint8_t)((bhRegValue >> 12U) & 0x3U)

             if (0UL != (tcpRegValue & (1UL << 31UL)))
                 match->flags |= ETHSWT_FAFLAGS_L4TCP
             else
                 match->flags &= ~ETHSWT_FAFLAGS_L4TCP
             match->srcPort = (uint16_t)((tcpRegValue >> 15UL) & 0xFFFFUL)
             match->dstPort = (uint16_t)(((tcpRegValue << 1UL) & 0xFFFFUL)
                                          | (remapPortIpRegValue >> 31UL))
             if (0U == remapPort)
                 remap->port = 0U
             else
                 remap->port = (uint16_t)((remapPortIpRegValue >> 15U) & 0xFFFFUL)
             if (0U == remapIp)
                 BCM_MemSet(remap->ip, 0U, 16UL)
             else
                remap->ip[0U] = (uint8_t)((remapPortIpRegValue >> 7U) & 0xFFUL)
                remap->ip[1U] |= (uint8_t)((remapPortIpRegValue << 1U) & 0xFEUL)
    return isValid
    @endcode
*/
static uint32_t ETHSWT_FAFlowTable2Struct(uint32_t *aBuff,
                                         ETHSWT_FAFlowType *const aFlow,
                                         ETHSWT_FAFlowStatsType *const aFlowStats,
                                         uint8_t *const aPoolIdx,
                                         uint8_t *const aNextHopIdx)
{
    uint32_t isValid;
    uint32_t isIPv4;
    uint32_t bhRegValue;
    uint32_t tcpRegValue;
    uint32_t remapPortIpRegValue;
    uint8_t *ipPtr;
    ETHSWT_FAMatchType *match = &aFlow->match;
    ETHSWT_FARemapType *remap = &aFlow->remap;
    uint32_t i;
    uint8_t remapIp;
    uint8_t remapPort;

    /* Identify if it is a IPv4 or IPv6 entry */
    if (0UL != (aBuff[7U] & (1UL<< 31UL))) {
        isIPv4 = TRUE;
        isValid = (uint8_t)((aBuff[6U] >> 20U) & 0x1U);
    } else {
        isIPv4 = FALSE;
        isValid = (uint8_t)((aBuff[7U] >> 20U) & 0x1U);
    }

    if (TRUE == isValid) {
        if (NULL != aFlowStats) {
            aFlowStats->lastTimestamp = (uint8_t)(aBuff[0U] & 0x7U);
            aFlowStats->hits = (aBuff[1U] << 28U) | (aBuff[0] >> 3U);
        }

        if (NULL != aPoolIdx) {
            *aPoolIdx = (uint8_t)((aBuff[1U] >> 6U) & 0x3U);
        }

        if (NULL != aNextHopIdx) {
            *aNextHopIdx = (uint8_t)((aBuff[1U] >> 8U) & 0x7FU);
        }

        if (NULL != aFlow) {
            remapIp = (uint8_t)((aBuff[1U] >> 3U) & 0x1U);
            remapPort = (uint8_t)((aBuff[1U] >> 4U) & 0x1U);
            /* If IPv6 entry, read the next table entry to get srcIP and dstIP */
            if (1U == isIPv4) {
                /* IPv4 Entry*/
                ipPtr = &match->dstIp[0];
                ipPtr[0U] = (uint8_t)((aBuff[4U] >> 24U) & 0xFFU);
                ipPtr[1U] = (uint8_t)((aBuff[4U] >> 16U) & 0xFFU);
                ipPtr[2U] = (uint8_t)((aBuff[4U] >> 8U) & 0xFFU);
                ipPtr[3U] = (uint8_t)((aBuff[4U] >> 0U) & 0xFFU);

                ipPtr = &match->srcIp[0];
                ipPtr[0U] = (uint8_t)((aBuff[5U] >> 24U) & 0xFFU);
                ipPtr[1U] = (uint8_t)((aBuff[5U] >> 16U) & 0xFFU);
                ipPtr[2U] = (uint8_t)((aBuff[5U] >> 8U) & 0xFFU);
                ipPtr[3U] = (uint8_t)((aBuff[5U] >> 0U) & 0xFFU);

                match->flags |= ETHSWT_FAFLAGS_L3IPV4;

                bhRegValue = aBuff[6U];
                tcpRegValue = aBuff[3U];
                remapPortIpRegValue = aBuff[2U];

                if (0U != remapIp) {
                    remap->ip[1U] = (uint8_t)(aBuff[1U] >> 31UL);
                    remap->ip[2U] = (uint8_t)(aBuff[1U] >> 23UL);
                    remap->ip[3U] = (uint8_t)(aBuff[1U] >> 15UL);
                }
            } else {
                /* IPv6 entry */
                ipPtr = &match->dstIp[0];
                for (i = 0U; i < 4U; i++) {
                    ipPtr[i * 4U + 0U] = (uint8_t)((aBuff[11U - i] >> 24U) & 0xFFU);
                    ipPtr[i * 4U + 1U] = (uint8_t)((aBuff[11U - i] >> 16U) & 0xFFU);
                    ipPtr[i * 4U + 2U] = (uint8_t)((aBuff[11U - i] >> 8U) & 0xFFU);
                    ipPtr[i * 4U + 3U] = (uint8_t)((aBuff[11U - i] >> 0U) & 0xFFU);
                }

                ipPtr = &match->srcIp[0];
                for (i = 0U; i < 4U; i++) {
                    ipPtr[i * 4U + 0U] = (uint8_t)((aBuff[15U - i] >> 24U) & 0xFFU);
                    ipPtr[i * 4U + 1U] = (uint8_t)((aBuff[15U - i] >> 16U) & 0xFFU);
                    ipPtr[i * 4U + 2U] = (uint8_t)((aBuff[15U - i] >> 8U) & 0xFFU);
                    ipPtr[i * 4U + 3U] = (uint8_t)((aBuff[15U - i] >> 0U) & 0xFFU);
                }

                match->flags &= (ETHSWT_FAFlagsType)~ETHSWT_FAFLAGS_L3IPV4;

                bhRegValue = aBuff[7U];
                tcpRegValue = aBuff[6U];
                remapPortIpRegValue = aBuff[5U];
                if (0U != remapIp) {
                    remap->ip[1U] = (uint8_t)(aBuff[4U] >> 31UL); /* Remaining will be filled later */
                    remap->ip[2U] = (uint8_t)((aBuff[4U] >> 23UL) & 0xFFU);
                    remap->ip[3U] = (uint8_t)((aBuff[4U] >> 15UL) & 0xFFU);
                    remap->ip[4U] = (uint8_t)((aBuff[4U] >> 7UL) & 0xFFU);
                    remap->ip[5U] = (uint8_t)(((aBuff[4U] << 1UL) & 0xFEU)
                                              | (aBuff[3U] >> 31UL));

                    remap->ip[6U] = (uint8_t)((aBuff[3U] >> 23UL) & 0xFFU);
                    remap->ip[7U] = (uint8_t)((aBuff[3U] >> 15UL) & 0xFFU);
                    remap->ip[8U] = (uint8_t)((aBuff[3U] >> 7UL) & 0xFFU);
                    remap->ip[9U] = (uint8_t)(((aBuff[3U] << 1UL) & 0xFEU)
                                              | (aBuff[2U] >> 31UL));

                    remap->ip[10U] = (uint8_t)((aBuff[2U] >> 23UL) & 0xFFU);
                    remap->ip[11U] = (uint8_t)((aBuff[2U] >> 15UL) & 0xFFU);
                    remap->ip[12U] = (uint8_t)((aBuff[2U] >> 7UL) & 0xFFU);
                    remap->ip[13U] = (uint8_t)(((aBuff[2U] << 1UL) & 0xFEU)
                                              | (aBuff[1U] >> 31UL));

                    remap->ip[14U] = (uint8_t)((aBuff[1U] >> 23UL) & 0xFFU);
                    remap->ip[15U] = (uint8_t)((aBuff[1U] >> 15UL) & 0xFFU);
                }
            }

            if (0UL != (bhRegValue & 0x1UL)) {
                match->flags |= ETHSWT_FAFLAGS_INBOUND;
            } else {
                match->flags &= (ETHSWT_FAFlagsType)~ETHSWT_FAFLAGS_INBOUND;
            }
            if (0UL == ((bhRegValue >> 17U) & 0x7U)) {
                remap->portMask = (uint16_t)((bhRegValue >> 1U) & 0x3FFUL);
            } else {
                remap->portMask = 0U;
            }
            remap->tc = (uint8_t)((bhRegValue >> 14U) & 0x7U);
            remap->te = (uint8_t)((bhRegValue >> 12U) & 0x3U);

            if (0UL != (tcpRegValue & (1UL << 31UL))) {
                match->flags |= ETHSWT_FAFLAGS_L4TCP;
            } else {
                match->flags &= (ETHSWT_FAFlagsType)~ETHSWT_FAFLAGS_L4TCP;
            }
            match->srcPort = (uint16_t)((tcpRegValue >> 15UL) & 0xFFFFUL);
            match->dstPort = (uint16_t)(((tcpRegValue << 1UL) & 0xFFFFUL)
                                        | (remapPortIpRegValue >> 31UL));
            if (0U == remapPort) {
                remap->port = 0U;
            } else {
                remap->port = (uint16_t)((remapPortIpRegValue >> 15U) & 0xFFFFUL);
            }
            if (0U == remapIp) {
                BCM_MemSet(remap->ip, 0U, 16UL);
            } else {
                remap->ip[0U] = (uint8_t)((remapPortIpRegValue >> 7U) & 0xFFUL);
                remap->ip[1U] |= (uint8_t)((remapPortIpRegValue << 1U) & 0xFEUL);
            }
        }
    }

    return isValid;
}

/** @brief Fill elements into FLow Table

    This API will fill individual elements into the Flow table

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aBuff        Pointer to an array of 32-bit unsigned integers
    @param[in]      aFlow        Flow struct
    @param[in]      aPoolIdx     Pool table index
    @param[in]      aNextHopIdx  NextHop table index

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    match = &aFlow->match;
    remap = &aFlow->remap;
    if (0U != remap->port)
        action |= 0x2U
    for (i = 0; i < 16UL; i++)
        if (0U != remap->ip[i])
            action |= 1U
            break
    if (ETHSWT_FAFLAGS_L4TCP == (match->flags & ETHSWT_FAFLAGS_L4TCP))
        isTcp = 1U
    if (ETHSWT_FAFLAGS_INBOUND == (match->flags & ETHSWT_FAFLAGS_INBOUND))
        direction = 1U
    if (0U != remap->portMask)
        bhOpcode = 1U
    bhRegValue = ((1UL << 20U)
                 | ((uint32_t)bhOpcode << 17U)
                 | ((uint32_t)remap->tc << 14U)
                 | ((uint32_t)remap->te << 12U)
                 | ((uint32_t)remap->portMask << 1U)
                 | ((uint32_t)direction))

    tcpRegValue = (((uint32_t)isTcp << 31U)
                   | ((uint32_t)match->srcPort << 15U)
                   | ((uint32_t)match->dstPort >> 1U))

    remapPortIpRegValue = (uint32_t)match->dstPort << 31U;
    if (0U != remap->port)
        remapPortIpRegValue |= ((uint32_t)remap->port << 15U)
    if (1U == (action & 1U))
        remapPortIpRegValue |= (((uint32_t)remap->ip[0U] << 7U)
                                | (uint32_t)remap->ip[1U] >> 1U)

    if (ETHSWT_FAFLAGS_L3IPV4 == (match->flags & ETHSWT_FAFLAGS_L3IPV4))
        aBuff[7U] = (1UL << 31U)

        aBuff[6U] = bhRegValue

        aBuff[5U] = (((uint32_t)match->dstIp[0] << 24U)
                     | ((uint32_t)match->dstIp[1] << 16U)
                     | ((uint32_t)match->dstIp[2] << 8U)
                     | ((uint32_t)match->dstIp[3]))

        aBuff[4U] = (((uint32_t)match->srcIp[0] << 24U)
                     | ((uint32_t)match->srcIp[1] << 16U)
                     | ((uint32_t)match->srcIp[2] << 8U)
                     | ((uint32_t)match->srcIp[3]))

        aBuff[3U] = tcpRegValue

        aBuff[2U] = remapPortIpRegValue
    else
        ipPtr = &aFlow->match.dstIp[0]
        for (i = 0U; i < 4U; i++)
            aBuff[11U - i] = ((uint32_t)ipPtr[i * 4U + 0U] << 24U)
                              | ((uint32_t)ipPtr[i * 4U + 1U] << 16U)
                              | ((uint32_t)ipPtr[i * 4U + 2U] << 8U)
                              | ((uint32_t)ipPtr[i * 4U + 3U] << 0U)

        ipPtr = &aFlow->match.srcIp[0]
        for (i = 0U; i < 4U; i++)
            aBuff[15U - i] = ((uint32_t)ipPtr[i * 4U + 0U] << 24U)
                              | ((uint32_t)ipPtr[i * 4U + 1U] << 16U)
                              | ((uint32_t)ipPtr[i * 4U + 2U] << 8U)
                              | ((uint32_t)ipPtr[i * 4U + 3U] << 0U)

        aBuff[7U] = bhRegValue

        aBuff[6U] = tcpRegValue

        aBuff[5U] = remapPortIpRegValue

        if (1U == (action & 1U))
            aBuff[4U] = (((uint32_t)remap->ip[1U] << 31U)
                         | ((uint32_t)remap->ip[2U] << 23U)
                         | ((uint32_t)remap->ip[3U] << 15U)
                         | ((uint32_t)remap->ip[4U] << 7U)
                         | ((uint32_t)remap->ip[5U] >> 1U))

            aBuff[3U] = (((uint32_t)remap->ip[5U] << 31U)
                         | ((uint32_t)remap->ip[6U] << 23U)
                         | ((uint32_t)remap->ip[7U] << 15U)
                         | ((uint32_t)remap->ip[8U] << 7U)
                         | ((uint32_t)remap->ip[9U] >> 1U))

            aBuff[2U] = (((uint32_t)remap->ip[9U] << 31U)
                         | ((uint32_t)remap->ip[10U] << 23U)
                         | ((uint32_t)remap->ip[11U] << 15U)
                         | ((uint32_t)remap->ip[12U] << 7U)
                         | ((uint32_t)remap->ip[13U] >> 1U))
        else
            aBuff[4U] = 0UL
            aBuff[3U] = 0UL
            aBuff[2U] = 0UL
        ipv4Delta = 12U

    aBuff[1U] = (((uint32_t)aNextHopIdx << 8U)
                 | ((uint32_t)aPoolIdx << 6U)
                 | ((uint32_t)action << 3U))
    if (1U == (action & 1U))
        aBuff[1U] |= (((uint32_t)remap->ip[ipv4Delta + 1U] << 31U)
                      | ((uint32_t)remap->ip[ipv4Delta + 2U] << 23U)
                      | ((uint32_t)remap->ip[ipv4Delta + 3U] << 15U))

    aBuff[0U] = 0UL
    return
    @endcode
*/
static void ETHSWT_FAStruct2FlowTable(uint32_t *aBuff,
                                      const ETHSWT_FAFlowType *const aFlow,
                                      uint16_t aPoolIdx,
                                      uint16_t aNextHopIdx)
{
    uint8_t action = 0U;
    const ETHSWT_FAMatchType *match = &aFlow->match;
    const ETHSWT_FARemapType *remap = &aFlow->remap;
    uint32_t i;
    uint8_t direction = 0U;
    uint8_t isTcp = 0U;
    uint8_t bhOpcode = 0U;
    const uint8_t *ipPtr;
    uint32_t bhRegValue;
    uint32_t tcpRegValue;
    uint32_t remapPortIpRegValue;
    uint8_t ipv4Delta = 0U;

    if (0U != remap->port) {
        /* Remap port enable */
        action |= 0x2U;
    }
    for (i = 0; i < 16UL; i++) {
        if (0U != remap->ip[i]) {
            /* Remap IP enable */
            action |= 1U;
            break;
        }
    }
    if (ETHSWT_FAFLAGS_L4TCP == (match->flags & ETHSWT_FAFLAGS_L4TCP)) {
        isTcp = 1U;
    }
    if (ETHSWT_FAFLAGS_INBOUND == (match->flags & ETHSWT_FAFLAGS_INBOUND)) {
        direction = 1U;
    }
    if (0U != remap->portMask) {
        bhOpcode = 1U;
    }

    bhRegValue = ((1UL << 20U) /* Valid bit*/
                 | ((uint32_t)bhOpcode << 17U)
                 | ((uint32_t)remap->tc << 14U)
                 | ((uint32_t)remap->te << 12U) /* ts = 0*/
                 | ((uint32_t)remap->portMask << 1U)
                 | ((uint32_t)direction));

    tcpRegValue = (((uint32_t)isTcp << 31U)
                   | ((uint32_t)match->srcPort << 15U)
                   | ((uint32_t)match->dstPort >> 1U));

    remapPortIpRegValue = (uint32_t)match->dstPort << 31U;
    if (0U != remap->port) {
        /* Remap port enable */
        remapPortIpRegValue |= ((uint32_t)remap->port << 15U);
    }
    if (1U == (action & 1U)) {
        /* Remap IP is enabled */
        remapPortIpRegValue |= (((uint32_t)remap->ip[0U] << 7U)
                                | (uint32_t)remap->ip[1U] >> 1U);
    }

    if (ETHSWT_FAFLAGS_L3IPV4 == (match->flags & ETHSWT_FAFLAGS_L3IPV4)) {
        aBuff[7U] = (1UL << 31U); /* ipv4 */

        aBuff[6U] = bhRegValue;

        aBuff[5U] = (((uint32_t)match->srcIp[0] << 24U)
                     | ((uint32_t)match->srcIp[1] << 16U)
                     | ((uint32_t)match->srcIp[2] << 8U)
                     | ((uint32_t)match->srcIp[3]));

        aBuff[4U] = (((uint32_t)match->dstIp[0] << 24U)
                     | ((uint32_t)match->dstIp[1] << 16U)
                     | ((uint32_t)match->dstIp[2] << 8U)
                     | ((uint32_t)match->dstIp[3]));

        aBuff[3U] = tcpRegValue;

        aBuff[2U] = remapPortIpRegValue;
    } else {
        /* IPv6 entry */
        ipPtr = &aFlow->match.dstIp[0];
        for (i = 0U; i < 4U; i++) {
            aBuff[11U - i] = ((uint32_t)ipPtr[i * 4U + 0U] << 24U)
                              | ((uint32_t)ipPtr[i * 4U + 1U] << 16U)
                              | ((uint32_t)ipPtr[i * 4U + 2U] << 8U)
                              | ((uint32_t)ipPtr[i * 4U + 3U] << 0U);
        }

        ipPtr = &aFlow->match.srcIp[0];
        for (i = 0U; i < 4U; i++) {
            aBuff[15U - i] = ((uint32_t)ipPtr[i * 4U + 0U] << 24U)
                              | ((uint32_t)ipPtr[i * 4U + 1U] << 16U)
                              | ((uint32_t)ipPtr[i * 4U + 2U] << 8U)
                              | ((uint32_t)ipPtr[i * 4U + 3U] << 0U);
        }

        aBuff[7U] = bhRegValue;

        aBuff[6U] = tcpRegValue;

        aBuff[5U] = remapPortIpRegValue;

        if (1U == (action & 1U)) {
            aBuff[4U] = (((uint32_t)remap->ip[1U] << 31U)
                         | ((uint32_t)remap->ip[2U] << 23U)
                         | ((uint32_t)remap->ip[3U] << 15U)
                         | ((uint32_t)remap->ip[4U] << 7U)
                         | ((uint32_t)remap->ip[5U] >> 1U));

            aBuff[3U] = (((uint32_t)remap->ip[5U] << 31U)
                         | ((uint32_t)remap->ip[6U] << 23U)
                         | ((uint32_t)remap->ip[7U] << 15U)
                         | ((uint32_t)remap->ip[8U] << 7U)
                         | ((uint32_t)remap->ip[9U] >> 1U));

            aBuff[2U] = (((uint32_t)remap->ip[9U] << 31U)
                         | ((uint32_t)remap->ip[10U] << 23U)
                         | ((uint32_t)remap->ip[11U] << 15U)
                         | ((uint32_t)remap->ip[12U] << 7U)
                         | ((uint32_t)remap->ip[13U] >> 1U));
        } else {
            aBuff[4U] = 0UL;
            aBuff[3U] = 0UL;
            aBuff[2U] = 0UL;
        }
        ipv4Delta = 12U; /* Difference in sizes of IPv4 and current type(IPv6) addresses */
    }

    aBuff[1U] = (((uint32_t)aNextHopIdx << 8U)
                 | ((uint32_t)aPoolIdx << 6U)
                 | ((uint32_t)action << 3U)); /* des_dma_channel = 0 */
    if (1U == (action & 1U)) {
        /* Remap IP is enabled */
        aBuff[1U] |= (((uint32_t)remap->ip[ipv4Delta + 1U] << 31U)
                      | ((uint32_t)remap->ip[ipv4Delta + 2U] << 23U)
                      | ((uint32_t)remap->ip[ipv4Delta + 3U] << 15U));
    }

    aBuff[0U] = 0UL;

    return;
}

/** @brief Update Bucket ID

    This API will identify an empty bucket for the given hash index

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Instance identifier
    @param[inOut]   aFlowID     Flow ID containing the hash. Bucket ID being
                                the least significant two bits will be updated
    @param[in]      aIsIpv4     TRUE: IPv4 entry, FALSE: IPv6 entry
    @param[out]     aBuff       Pointer to an array of unsigned 32-bit integers
                                Flow table entry when success. Applicable only
                                VALID bit in table is read to confirm
                                availability.

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK      Bucket ID updated successfully
    @retval    #BCM_ERR_NOMEM   No empty bucket found
    @retval    #BCM_ERR_NOPERM  Duplicate entry found, no permission to add/update

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    duplicate = FALSE
    active = ETHSWT_FADrv[aID].flowStatus.activeMask[*aFlowID >> 3U]

    if (0U != (*aFlowID & (1U << 2U)))
        active = active >> ETHSWT_FA_FLOWTABLE_HASH_BUCKETS
    else
        active = active & 0xFU
    if (TRUE == aIsIpv4)
        needMask = 1U
    else
        needMask = 3U

    i = 0U
    while (i < ETHSWT_FA_FLOWTABLE_HASH_BUCKETS)
        if (0U == (active & (needMask << i)))
            if (FALSE == freeBucketFound)
                freeBucketFound = TRUE
                freeBucket = i
        else
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (*aFlowID + i),
                                 ETHSWT_FATABLEACCESS_READ, &buff[0U])
            buff[1U] &= ~0x7U
            buff[0U] = 0UL

            if (FALSE == aIsIpv4)
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (*aFlowID + i+ 1U),
                                     ETHSWT_FATABLEACCESS_READ, &buff[8U])
                regIndex = 16L
            else
                regIndex = 8L
            while (0L < regIndex--)
                if (aBuff[regIndex] != buff[regIndex])
                    break;
            if (-1L == regIndex)
                duplicate = TRUE;
                break;
        if (FALSE == aIsIpv4)
            i += 2U
        else
            i++
    if (TRUE == duplicate)
        retVal = BCM_ERR_NOPERM
    else if (FALSE == freeBucketFound)
        retVal = BCM_ERR_NOMEM
    else
        *aFlowID |= freeBucket
        retVal = BCM_ERR_OK
    }
    return retVal
    @endcode
*/
static int32_t ETHSWT_FAUpdateBucketID(uint8_t aID, uint16_t *const aFlowID,
                                       uint32_t aIsIpv4, uint32_t *aBuff)
{
    uint8_t active;
    uint8_t freeBucket;
    uint32_t freeBucketFound = FALSE;
    uint8_t needMask;
    int32_t retVal;
    uint32_t buff[16UL] = {0UL};
    uint8_t i;
    uint32_t duplicate = FALSE;
#if 0
    uint32_t isValid;
#endif
    int32_t regIndex;

    /* Each byte of mask has the bit values of 8 entries*/
    active = ETHSWT_FADrv[aID].flowStatus.activeMask[*aFlowID >> 3U];

    /* Each byte of mask corresponds to 2 hash values, each with 4 buckets */
    if (0U != (*aFlowID & (1U << 2U))) {
        active = active >> ETHSWT_FA_FLOWTABLE_HASH_BUCKETS;
    } else {
        active = active & 0xFU;
    }

    /* 1 bucket for IPv4 and 2 buckets for IPv6 */
    if (TRUE == aIsIpv4) {
        needMask = 1U;
    } else {
        /* Need two table entries for IPv6 flow */
        needMask = 3U;
    }

    /* Identify if a free slot is available */
    i = 0U;
    while (i < ETHSWT_FA_FLOWTABLE_HASH_BUCKETS) {
        if (0U == (active & (needMask << i))) {
            /* ID not in use */
            if (FALSE == freeBucketFound) {
                /* Don't break here, continue search and validate duplicate
                 * entries. It could so happen that the first available entry
                 * was indeed deleted after second one was added. So second one
                 * could be a duplicate of the new entry being added currently */

#if 0
                /* Confirm if the table entry is available by reading the table itself */
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (*aFlowID + i),
                                     ETHSWT_FATABLEACCESS_READ, &buff[0U]);
                if (FALSE == aIsIpv4) {
                    /* IPv6 entry */
                    ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (*aFlowID + i + 1U),
                                         ETHSWT_FATABLEACCESS_READ, &buff[8U]);
                }
                isValid = ETHSWT_FAFlowTable2Struct(buff, NULL, NULL, NULL, NULL);
                if (FALSE == isValid) {
                    /* unused */
                    freeBucketFound = TRUE;
                    freeBucket = i;
                }
#else
                freeBucketFound = TRUE;
                freeBucket = i;
#endif
            }
        } else {
            /* ID in use, read table and verify that it is not a duplicate */
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (*aFlowID + i),
                                 ETHSWT_FATABLEACCESS_READ, &buff[0U]);
            /* mask off hits and timestamp fields */
            buff[1U] &= ~0x7U;
            buff[0U] = 0UL;

            if (FALSE == aIsIpv4) {
                /* IPv6 entry */
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (*aFlowID + i+ 1U),
                                     ETHSWT_FATABLEACCESS_READ, &buff[8U]);
                regIndex = 16L;
            } else {
                regIndex = 8L;
            }
            while (0L < regIndex--) {
                /* Abandon further comparisons if they are differnet now */
                if (aBuff[regIndex] != buff[regIndex]) {
                    /* regIndex indicates the index where the flow parameters are different */
                    break;
                }
            }
            /* If duplicate entry found, abandon search */
            if (-1L == regIndex) {
                duplicate = TRUE;
                break;
            }
        }
        /* Look for the next slot */
        if (FALSE == aIsIpv4) {
            i += 2U;
        } else {
            i++;
        }
    }

    if (TRUE == duplicate) {
        retVal = BCM_ERR_NOPERM;
    } else if (FALSE == freeBucketFound) {
        retVal = BCM_ERR_NOMEM;
    } else {
        *aFlowID |= freeBucket;
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

/** @brief Delete Pool table entry

    This API will will delete a pool table entry if it is no more referenced

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Instance identifier
    @param[in]      aMac        Pointer to MAC address

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Entry deleted successfully
    @retval    #BCM_ERR_BUSY            Entry cannot be deleted as it is in use
    @retval    #BCM_ERR_NOT_FOUND       Entry not found
    @retval    #BCM_ERR_INVAL_PARAMS    aMac is NULL

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    uint32_t buff[2UL] = {0UL, 0UL}

    if (NULL == aMac) {
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode)
        retVal = BCM_ERR_INVAL_STATE
    else
        for (index = 0; index < ETHSWT_FA_POOL_MAX; index++)
            if (TRUE == ETHSWT_FADrv[aID].pool.macInfo[index].valid)
                retVal = memcmp(aMac, ETHSWT_FADrv[aID].pool.macInfo[index].mac, 6U)
                if (0L == retVal)
                    break

        if (ETHSWT_FA_POOL_MAX == index)
            retVal = BCM_ERR_NOT_FOUND
        else if (0U != ETHSWT_FADrv[aID].pool.macInfo[index].refCount)
            retVal = BCM_ERR_BUSY
        else
            BCM_MemSet(ETHSWT_FADrv[aID].pool.macInfo[index].mac, 0U, 6U)
            ETHSWT_FADrv[aID].pool.tableUsage--
            ETHSWT_FADrv[aID].pool.macInfo[index].valid = FALSE
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_POOL, index,
                    ETHSWT_FATABLEACCESS_WRITE, buff)
            retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t ETHSWT_FAPoolEntryDelete(uint8_t aID,
                                        const uint8_t *const aMac)
{
    int32_t retVal;
    uint32_t buff[2UL] = {0UL, 0UL};
    uint16_t index;

    if (NULL == aMac) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        for (index = 0U; index < ETHSWT_FA_POOL_MAX; index++) {
            if (TRUE == ETHSWT_FADrv[aID].pool.macInfo[index].valid) {
                retVal = memcmp(aMac, ETHSWT_FADrv[aID].pool.macInfo[index].mac, 6U);
                if (0L == retVal) {
                    /* matching entry exists, nothing more to do */
                    break;
                }
            }
        }
        if (ETHSWT_FA_POOL_MAX == index) {
            retVal = BCM_ERR_NOT_FOUND;
        } else if (0U != ETHSWT_FADrv[aID].pool.macInfo[index].refCount) {
            retVal = BCM_ERR_BUSY;
        } else {
            /* Clear cached value */
            BCM_MemSet(ETHSWT_FADrv[aID].pool.macInfo[index].mac, 0U, 6U);
            ETHSWT_FADrv[aID].pool.tableUsage--;
            ETHSWT_FADrv[aID].pool.macInfo[index].valid = FALSE;

            /* Delete entry from Pool table */
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_POOL, index,
                    ETHSWT_FATABLEACCESS_WRITE, buff);
            retVal = BCM_ERR_OK;
        }
    }
    return retVal;
}

/** @brief Delete Next-hop table entry

    This API will decrement the reference count of the indexed next-hop table
    entry and if it is nomore referenced, will delete it from the table

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Instance identifier
    @param[in]      aIndex      Index of table entry
    @param[out]     aBuff       Pointer to an array of unsigned 32-bit integers
                                Memset to 0 in case reference count reaches 0L
                                Untouched otherwise


    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    refCntPtr = &ETHSWT_FADrv[aID].nextHop[aIndex].refCount
    if (0U < *refCntPtr)
        (*refCntPtr)--
        if (0U == *refCntPtr)
            ETHSWT_FADrv[aID].nextHopTableUsage--
            BCM_MemSet(aBuff, 0U, 3U * sizeof(uint32_t))
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_NEXTHOP, aIndex,
                                 ETHSWT_FATABLEACCESS_WRITE, aBuff)
    else
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FANHTABLEDELETE_PROC, BCM_ERR_INVAL_STATE,
                        __LINE__, *refCntPtr, aIndex, 0UL)
    @endcode
*/
static void ETHSWT_FANextHopEntryDelete(uint8_t aID, uint16_t aIndex,
                                        uint32_t *aBuff)
{
    uint16_t *refCntPtr;

    refCntPtr = &ETHSWT_FADrv[aID].nextHop[aIndex].refCount;

    if (0U < *refCntPtr) {
        (*refCntPtr)--;
        if (0U == *refCntPtr) {
            ETHSWT_FADrv[aID].nextHopTableUsage--;
            BCM_MemSet(aBuff, 0U, 3U * sizeof(uint32_t));
            /* Delete entry from NextHop table */
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_NEXTHOP, aIndex,
                                 ETHSWT_FATABLEACCESS_WRITE, aBuff);
        }
    } else {
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FANHTABLEDELETE_PROC, BCM_ERR_INVAL_STATE,
                        __LINE__, *refCntPtr, aIndex, 0UL);
    }
    return;
}

/** @brief Generate Hash

    This API will generate hash value needed to obtain Flow ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Instance identifier
    @param[in]      aMatch      Match parameters of the type #ETHSWT_FAMatchType

    @retval     16-bit unsigned hash result

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (ETHSWT_FAFLAGS_L3IPV4 == (aMatch->flags & ETHSWT_FAFLAGS_L3IPV4))
        isIPv4 = 1U
    else
        isIPv4 = 0U

    buf[bufIdx++] = aMatch->srcIp[0U] >> 7UL

    if (1U == isIPv4)
        loop = 4U
    else
        loop = 16U
    ipIdx = 0U
    while (0U != loop--)
        if (0U == loop)
            nextByte = aMatch->dstIp[0U] >> 7U
        else
            nextByte = aMatch->srcIp[ipIdx + 1U] >> 7U
        buf[bufIdx++] = (aMatch->srcIp[ipIdx] << 1U) | nextByte
        ipIdx++

    if (1U == isIPv4)
        loop = 4U
    else
        loop = 16U
    ipIdx = 0U
    while(0U != loop--)
        if (0U == loop)
            nextByte = isIPv4
        else
            nextByte = aMatch->dstIp[ipIdx + 1U] >> 7U
        buf[bufIdx++] = (aMatch->dstIp[ipIdx] << 1U) | nextByte
        ipIdx++
    buf[bufIdx++] = (aMatch->srcPort >> 8UL) & 0xFFU
    buf[bufIdx++] = aMatch->srcPort & 0xFFU
    buf[bufIdx++] = (aMatch->dstPort >> 8UL) & 0xFFU
    buf[bufIdx++] = aMatch->dstPort & 0xFFU
    hash = BCM_CRC16(&buf[0], bufIdx,
                     ETHSWT_FADrv[aID].polynomial,
                     ETHSWT_FADrv[aID].seedValue)
    return hash
    @endcode
*/
static uint16_t ETHSWT_FAGenerateHash(uint8_t aID, const ETHSWT_FAMatchType *const aMatch)
{
    uint16_t hash = 0U;
    uint8_t buf[37UL];
    uint8_t isIPv4;
    uint8_t bufIdx = 0;
    uint8_t ipIdx;
    uint8_t nextByte;
    uint8_t loop;
    uint8_t isTcp;

    if (ETHSWT_FAFLAGS_L3IPV4 == (aMatch->flags & ETHSWT_FAFLAGS_L3IPV4)) {
        isIPv4 = 1U;
    } else {
        isIPv4 = 0U;
    }

    if (ETHSWT_FAFLAGS_L4TCP == (aMatch->flags & ETHSWT_FAFLAGS_L4TCP)) {
        isTcp = 1U;
    } else {
        isTcp = 0U;
    }

    /* IPv4: [96:65] - srcIP, [64:33]-dstIP, [32:32]-isTcp, [31:16]-srcPort, [15:0]-dstPort */
    /* PIv6: [288:161] - srcIP, [160:33]-dstIP, [32:32]-isTcp, [31:16]-srcPort, [15:0]-dstPort */

    /* Capture the MS bit of 1st byte of IP*/
    buf[bufIdx++] = aMatch->srcIp[0U] >> 7UL;

    if (1U == isIPv4) {
        loop = 4U; /* IPv4 is 4bytes */
    } else {
        loop = 16U; /* IPv6 is 16bytes */
    }
    ipIdx = 0U;

    while (0U != loop--) {
        /* last byte of the IP? */
        if (0U == loop) {
            /* choose the LS bit from next field- dstIP */
            nextByte = aMatch->dstIp[0U] >> 7U;
        } else {
            /* choose the LS bit from next byte of the same field- srcIP */
            nextByte = aMatch->srcIp[ipIdx + 1U] >> 7U;
        }
        buf[bufIdx++] = (aMatch->srcIp[ipIdx] << 1U) | nextByte;
        ipIdx++;
    }

    if (1U == isIPv4) {
        loop = 4U; /* IPv4 is 4bytes */
    } else {
        loop = 16U; /* IPv6 is 16bytes */
    }
    ipIdx = 0U;

    while (0U != loop--) {
        /* last byte of the IP? */
        if (0U == loop) {
            /* choose the LS bit from next field- isTCP */
            nextByte = isTcp;
        } else {
            /* choose the LS bit from next byte of the same field- dstIP */
            nextByte = aMatch->dstIp[ipIdx + 1U] >> 7U;
        }
        buf[bufIdx++] = (aMatch->dstIp[ipIdx] << 1U) | nextByte;
        ipIdx++;
    }
    buf[bufIdx++] = (uint8_t)(aMatch->srcPort >> 8UL);
    buf[bufIdx++] = (uint8_t)(aMatch->srcPort & 0xFFU);
    buf[bufIdx++] = (uint8_t)(aMatch->dstPort >> 8UL);
    buf[bufIdx++] = (uint8_t)(aMatch->dstPort & 0xFFU);

    hash = BCM_CRC16(&buf[0], bufIdx,
                     ETHSWT_FADrv[aID].polynomial,
                     ETHSWT_FADrv[aID].seedValue);

    return hash;
}

/** @brief Add Pool table entry

    This API will add a pool table entry

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID         Instance identifier
    @param[in]  aMac        Pointer to MAC address
    @param[in]  aExternal   Domain: TRUE=External, FALSE=Internal

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK           Successfully added or same exists already
    @retval     #BCM_ERR_NOMEM        No memory available to add a new entry
    @retval     #BCM_ERR_NOPERM       No permission to overwrite existing MAC
                                      with different "external" field
    @retval     #BCM_ERR_INVAL_PARAMS aMac is NULL OR MAC address is all 0s
                                      aExternal is neither TRUE nor FALSE

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    zeroMac[6UL] = {0U, 0U, 0U, 0U, 0U, 0U}
    freeIndexFound = FALSE

    if ((NULL == aMac)
            || (aExternal > TRUE))
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode)
        retVal = BCM_ERR_INVAL_STATE
    else
        retVal = memcmp(aMac, zeroMac, 6U)
        if (retVal == 0L)
            retVal = BCM_ERR_INVAL_PARAMS
        else
            for (index = 0U; index < ETHSWT_FA_POOL_MAX; index++)
                if (TRUE == ETHSWT_FADrv[aID].pool.macInfo[index].valid)
                    cmpRet = memcmp(aMac,
                                    ETHSWT_FADrv[aID].pool.macInfo[index].mac, 6U)
                    if (0L == cmpRet)
                        if (aExternal == ETHSWT_FADrv[aID].pool.macInfo[index].external)
                            retVal = BCM_ERR_OK
                        else
                            retVal = BCM_ERR_NOPERM
                        break
                else
                    if (FALSE == freeIndexFound)
                        freeIndex = index
                        freeIndexFound = TRUE

            if (ETHSWT_FA_POOL_MAX == index)
                if (TRUE == freeIndexFound)
                    ETHSWT_FADrv[aID].pool.macInfo[freeIndex].valid = TRUE
                    BCM_MemCpy(ETHSWT_FADrv[aID].pool.macInfo[freeIndex].mac, aMac, 6U)
                    ETHSWT_FADrv[aID].pool.tableUsage++
                    ETHSWT_FADrv[aID].pool.macInfo[freeIndex].external = aExternal
                    buff[1U] = ((uint32_t)aMac[0U] << 9U)
                        | ((uint32_t)aMac[1U] << 1U)
                        | ((uint32_t)aMac[2U] >> 7U)
                    buff[0U] = (((uint32_t)aMac[2U] & 0x7FU) << 25U)
                        | ((uint32_t)aMac[3U] << 17U)
                        | ((uint32_t)aMac[4U] << 9U)
                        | ((uint32_t)aMac[5U] << 1U)
                        | ((uint32_t)aExternal)
                    ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_POOL, freeIndex,
                            ETHSWT_FATABLEACCESS_WRITE, buff)

                    retVal = BCM_ERR_OK
                else
                    retVal = BCM_ERR_NOMEM
    return retVal
    @endcode
*/
static int32_t ETHSWT_FAPoolEntryAdd(uint8_t aID, const uint8_t *const aMac,
                                     uint32_t aExternal)
{
    int32_t cmpRet;
    int32_t retVal;
    uint16_t index;
    uint32_t buff[2UL];
    uint8_t zeroMac[6UL] = {0U, 0U, 0U, 0U, 0U, 0U};
    uint16_t freeIndex;
    uint32_t freeIndexFound = FALSE;

    if ((NULL == aMac)
        || (aExternal > TRUE)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        retVal = memcmp(aMac, zeroMac, 6U);
        if (retVal == 0L) {
            /* zero mac is not allowed */
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            for (index = 0U; index < ETHSWT_FA_POOL_MAX; index++) {
                if (TRUE == ETHSWT_FADrv[aID].pool.macInfo[index].valid) {
                    cmpRet = memcmp(aMac,
                                    ETHSWT_FADrv[aID].pool.macInfo[index].mac,
                                    6U);
                    if (0L == cmpRet) {
                        if (aExternal == ETHSWT_FADrv[aID].pool.macInfo[index].external) {
                            /* matching entry exists, nothing more to do */
                            retVal = BCM_ERR_OK;
                        } else {
                            /* mac matches but not direction. No permission to overwrite */
                            retVal = BCM_ERR_NOPERM;
                        }
                        break;
                    }
                } else {
                    /* Free entry found, matching entry might be present */
                    if (FALSE == freeIndexFound) {
                        freeIndex = index;
                        freeIndexFound = TRUE;
                    }
                }
            }

            /* if neither partial or complete match found */
            if (ETHSWT_FA_POOL_MAX == index) {
                if (TRUE == freeIndexFound) {
                    /* Maintain local cache */
                    ETHSWT_FADrv[aID].pool.macInfo[freeIndex].valid = TRUE;
                    BCM_MemCpy(ETHSWT_FADrv[aID].pool.macInfo[freeIndex].mac, aMac, 6U);
                    ETHSWT_FADrv[aID].pool.tableUsage++;
                    ETHSWT_FADrv[aID].pool.macInfo[freeIndex].external = aExternal;

                    /* Update Table entry */
                    buff[1U] = ((uint32_t)aMac[0U] << 9U)
                                | ((uint32_t)aMac[1U] << 1U)
                                | ((uint32_t)aMac[2U] >> 7U);
                    buff[0U] = (((uint32_t)aMac[2U] & 0x7FU) << 25U)
                                | ((uint32_t)aMac[3U] << 17U)
                                | ((uint32_t)aMac[4U] << 9U)
                                | ((uint32_t)aMac[5U] << 1U)
                                | ((uint32_t)aExternal);
                    ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_POOL, freeIndex,
                            ETHSWT_FATABLEACCESS_WRITE, buff);

                    retVal = BCM_ERR_OK;
                } else {
                    /* Neither free nor matches existing ones */
                    retVal = BCM_ERR_NOMEM;
                }
            }
        }
    }

    return retVal;
}

/** @brief Get Pool Table Entry

    This API retrieves the index of a matching Pool Table entry and increments
    the reference count.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID         Instance identifier
    @param[in]  aMac        Pointer to MAC address
    @param[in]  aExternal   Domain: TRUE=External, FALSE=Internal
    @param[out] aIdx        Pointer to return index in the table

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK           Successfully retrieved index of pooltable
    @retval   #BCM_ERR_NOT_FOUND    Matching entry not found in the table

    @post None

    @limitations None

    @code{.unparsed}
    for (index = 0; index < ETHSWT_FA_POOL_MAX; index++)
        if (TRUE == ETHSWT_FADrv[aID].pool.macInfo[index].valid)
            retVal = memcmp(aPool->mac, ETHSWT_FADrv[aID].pool.macInfo[index].mac, 6U)
            if ((0L == retVal) && (aPool->external
                        == ETHSWT_FADrv[aID].pool.macInfo[index].external))
                ETHSWT_FADrv[aID].pool.macInfo[index].refCount++
                *aIdx = index
                retVal = BCM_ERR_OK
                break
    if (ETHSWT_FA_POOL_MAX == index)
        retVal = BCM_ERR_NOT_FOUND
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
static int32_t ETHSWT_FAPoolEntryAcquire(uint8_t aID, const uint8_t *const aMac,
                                     uint32_t aExternal, uint8_t *aIdx)
{
    int32_t retVal;
    uint8_t index;

    for (index = 0; index < ETHSWT_FA_POOL_MAX; index++) {
        if (TRUE == ETHSWT_FADrv[aID].pool.macInfo[index].valid) {
            retVal = memcmp(aMac, ETHSWT_FADrv[aID].pool.macInfo[index].mac, 6U);
            if ((0L == retVal) && (aExternal
                        == ETHSWT_FADrv[aID].pool.macInfo[index].external)) {
                ETHSWT_FADrv[aID].pool.macInfo[index].refCount++;
                /* Return table index */
                *aIdx = index;
                retVal = BCM_ERR_OK;
                break;
            }
        }
    }

    if (ETHSWT_FA_POOL_MAX == index) {
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}

/** @brief Pool Table Put

    This API will decrement the reference of Pool table being referred to

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID         Instance identifier
    @param[in]  aIdx        Pool table index

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK           Reference count decremented successfully
    @retval   #BCM_ERR_INVAL_STATE  Pool Table entry is not valid OR
                                    reference count is already zero

    @post None

    @limitations None

    @code{.unparsed}
    if ((TRUE == ETHSWT_FADrv[aID].pool.macInfo[aIdx].valid)
        && (0U != ETHSWT_FADrv[aID].pool.macInfo[aIdx].refCount))
        ETHSWT_FADrv[aID].pool.macInfo[aIdx].refCount--
        retVal = BCM_ERR_OK
    else
        retVal = BCM_ERR_INVAL_STATE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
static int32_t ETHSWT_FAPoolEntryRelease(uint8_t aID, uint8_t aIdx)
{
    int32_t retVal;

    if ((TRUE == ETHSWT_FADrv[aID].pool.macInfo[aIdx].valid)
        && (0U != ETHSWT_FADrv[aID].pool.macInfo[aIdx].refCount)) {
        ETHSWT_FADrv[aID].pool.macInfo[aIdx].refCount--;
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_INVAL_STATE;
    }

    return retVal;
}

/** @brief Add Next-hop table entry

    This API will increment the reference count of an already existing Next-hop
    table entry and if the entry didn't exist, it will add to the table

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Instance identifier
    @param[out]     aBuff       Pointer to an array of unsigned 32-bit integers
                                Untouched in case of an existing entry.
                                Set to Next-hop table entry when added fresh
    @param[in]      aMac        Pointer to MAC address
    @param[in]      aVlanTag    16-bit TCI
    @param[in]      aOperation  Operation of type #ETHSWT_FAOperationType
    @param[in]      aFrameType  TRUE:LLC/SNAP, FALSE: Ethernet II
    @param[out]     aIdx        Index where the entry is stored

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK     Successfully added
    @retval     #BCM_ERR_NOMEM  No memory available to add a new entry

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    for (index = 0; index < ETHSWT_FA_NEXTHOP_MAX; index++)
        nhPtr = &ETHSWT_FADrv[aID].nextHop[index]
        if (0U != nhPtr->refCount)
            if ((aVlanTag == nhPtr->vlan)
                    && (nhPtr->misc == ((aOperation << 1U) | aFrameType)))
                retVal = memcmp(aMac, nhPtr->mac, 6UL)
                if (0L == retVal)
                    nhPtr->refCount++
                    *aIdx = index
                    retVal = BCM_ERR_OK
                    break
        else
            if (FALSE == freeIndexFound)
                freeIndex = index
                freeIndexFound = TRUE

    if (ETHSWT_FA_NEXTHOP_MAX == index)
        if (TRUE == freeIndexFound)
            *aIdx = freeIndex
            nhPtr = &ETHSWT_FADrv[aID].nextHop[freeIndex]
            nhPtr->refCount++
            ETHSWT_FADrv[aID].nextHopTableUsage++
            nhPtr->vlan = aVlanTag
            BCM_MemCpy(nhPtr->mac, aMac, 6UL)
            nhPtr->misc = (aOperation << 1U) | aFrameType
            aBuff[2] = (uint32_t)aMac[0] >> 5U
            aBuff[1] = (((uint32_t)aMac[0] & 0x1FU) << 27U)
                        | ((uint32_t)aMac[1] << 19U)
                        | ((uint32_t)aMac[2] << 11U)
                        | ((uint32_t)aMac[3] << 3U)
                        | ((uint32_t)aMac[4] >> 5U)
            aBuff[0] = (((uint32_t)aMac[4] & 0x1FU) << 27U)
                        | ((uint32_t)aMac[5] << 19U)
                        | ((uint32_t)aVlanTag << 3U)
                        | ((uint32_t)nhPtr->misc)
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_NEXTHOP, freeIndex,
                                 ETHSWT_FATABLEACCESS_WRITE, aBuff)
            retVal = BCM_ERR_OK
        else
            retVal = BCM_ERR_NOMEM
    return retVal;
    @endcode
*/
static int32_t ETHSWT_FANextHopEntryAdd(uint8_t aID, uint32_t *aBuff,
                                        const uint8_t *aMac, uint16_t aVlanTag,
                                        ETHSWT_FAOperationType aOperation,
                                        uint8_t aFrameType,
                                        uint8_t *aIdx)
{
    int32_t retVal;
    uint8_t freeIndex;
    uint32_t freeIndexFound = FALSE;
    uint8_t index;
    ETHSWT_FANextHopType *nhPtr;

    for (index = 0U; index < ETHSWT_FA_NEXTHOP_MAX; index++) {
        nhPtr = &ETHSWT_FADrv[aID].nextHop[index];
        if (0U != nhPtr->refCount) {
            if ((aVlanTag == nhPtr->vlan)
                    && (nhPtr->misc == ((aOperation << 1U) | aFrameType))) {
                retVal = memcmp(aMac, nhPtr->mac, 6UL);
                if (0L == retVal) {
                    /* Entry exists, increment reference count */
                    nhPtr->refCount++;

                    /* Return table index */
                    *aIdx = index;
                    retVal = BCM_ERR_OK;
                    break;
                }
            }
        } else {
            if (FALSE == freeIndexFound) {
                freeIndex = index;
                freeIndexFound = TRUE;
            }
        }
    }

    if (ETHSWT_FA_NEXTHOP_MAX == index) {
        if (TRUE == freeIndexFound) {
            /* Return table index */
            *aIdx = freeIndex;

            /* Maintain local cache */
            nhPtr = &ETHSWT_FADrv[aID].nextHop[freeIndex];
            nhPtr->refCount++;
            ETHSWT_FADrv[aID].nextHopTableUsage++;
            nhPtr->vlan = aVlanTag;
            BCM_MemCpy(nhPtr->mac, aMac, 6UL);
            nhPtr->misc = (aOperation << 1U) | aFrameType;

            /* Update Table entry */
            aBuff[2] = (uint32_t)aMac[0] >> 5U;
            aBuff[1] = (((uint32_t)aMac[0] & 0x1FU) << 27U)
                        | ((uint32_t)aMac[1] << 19U)
                        | ((uint32_t)aMac[2] << 11U)
                        | ((uint32_t)aMac[3] << 3U)
                        | ((uint32_t)aMac[4] >> 5U);
            aBuff[0] = (((uint32_t)aMac[4] & 0x1FU) << 27U)
                        | ((uint32_t)aMac[5] << 19U)
                        | ((uint32_t)aVlanTag << 3U)
                        | ((uint32_t)nhPtr->misc);
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_NEXTHOP, freeIndex,
                                 ETHSWT_FATABLEACCESS_WRITE, aBuff);

            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_NOMEM;
        }
    }

    return retVal;
}

/** @brief Initialize FA

    Initializes the Flow Accelerator with the given configuration.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aConfig     Pointer to FA configuration

    @return     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if ((NULL == aConfig) || (aID >= CTF_MAX_HW_ID))
        val[0UL] = __LINE__
        val[1UL] = aID
        val[2UL] = 0UL
        val[3UL] = 0UL
        retVal = BCM_ERR_INVAL_PARAMS
    else if (((ETHSWT_FACTFMODE_BYPASS != aConfig->ctfCfg.mode)
                && (ETHSWT_FACTFMODE_NORMAL != aConfig->ctfCfg.mode))
            || ((FALSE != aConfig->ctfCfg.validateMatchDA)
                && (TRUE != aConfig->ctfCfg.validateMatchDA))
            || ((ETHSWT_FACRC_CCITT != aConfig->ctfCfg.crc)
                && (ETHSWT_FACRC_CRC16 != aConfig->ctfCfg.crc)))
        val[0UL] = __LINE__
        val[1UL] = aConfig->ctfCfg.validateMatchDA
        val[2UL] = aConfig->ctfCfg.mode
        val[3UL] = aConfig->ctfCfg.crc
        retVal = BCM_ERR_INVAL_PARAMS
    else if (TRUE == ETHSWT_FADrv[aID].init)
        val[0] = __LINE__
        val[1] = ETHSWT_FADrv[aID].init
        val[2UL] = 0UL
        val[3UL] = 0UL
        retVal = BCM_ERR_INVAL_STATE
    else
        BCM_MemSet(&ETHSWT_FADrv[aID], 0U, sizeof(ETHSWT_FADrvType))
        UNIMAC_Init(1U, &aConfig->unimacCfg)

        if (ETHSWT_FACTFMODE_BYPASS == aConfig->ctfCfg.mode)
            ETHSWT_FARegs[aID]->control |= CTF_CONTROL_BYPASS_CTF_MASK
        else
            regVal = ETHSWT_FARegs[aID]->control
            regVal &= ~CTF_CONTROL_BYPASS_CTF_MASK
            if (FALSE == aConfig->ctfCfg.validateMatchDA)
                regVal |= CTF_CONTROL_DISABLE_MAC_DA_CHECK_MASK
            ETHSWT_FADrv[aID].validateMatchDA = aConfig->ctfCfg.validateMatchDA
            regVal |= CTF_CONTROL_HB_INIT_MASK
                      | CTF_CONTROL_LAB_INIT_MASK
                      | CTF_CONTROL_HWQ_INIT_MASK
                      | CTF_CONTROL_NEXT_HOP_INIT_MASK
                      | CTF_CONTROL_NAPT_FLOW_INIT_MASK
                      | CTF_CONTROL_CRC_OWRT_CONFIG_MASK
            ETHSWT_FARegs[aID]->control = regVal
            ETHSWT_FARegs[aID]->brcm_hdr_control |= CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_MASK
                                                    | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_MASK
                                                    | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_MASK
                                                    | CTF_BHC_CBHCBHPIE_MASK

        ETHSWT_FADrv[aID].mode = aConfig->ctfCfg.mode
        regVal = ETHSWT_FARegs[aID]->l3_napt_control
        regVal &= ~(CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_MASK
                    | CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_MASK
                    | CTF_L3_NAPT_CONT_CL3NCHCORE_MASK)
        regVal |= aConfig->ctfCfg.seedValue
        if (ETHSWT_FACRC_CRC16 == aConfig->ctfCfg.crc)
            regVal |= CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_MASK
            ETHSWT_FADrv[aID].polynomial = 0x8005U
        else
            regVal &= ~CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_MASK
            ETHSWT_FADrv[aID].polynomial = 0x1021U
        ETHSWT_FARegs[aID]->l3_napt_control = regVal

        if (0UL != aConfig->ctfCfg.timestampPeriodSec)
            ETHSWT_FADrv[aID].timestampPeriodSec = aConfig->ctfCfg.timestampPeriodSec
        else
            ETHSWT_FADrv[aID].timestampPeriodSec = ETHSWT_FA_TIMESTAMP_PERIOD_SEC_DEFAULT

        ETHSWT_FARegs[aID]->l3_ipv4_type |= CTF_L3_IPV4_TYPE_PARSE_CHECKSUM_ENABLE_MASK
        ETHSWT_FARegs[aID]->receive_status_enable = (CTF_RSE_CTF_RECEIVE_STATUS_ENABLE_RESERVED_MASK ^ 0xFFFFFFFFUL)

        if (ETHSWT_FACTFMODE_NORMAL == aConfig->ctfCfg.mode)
            ETHSWT_FARegs[aID]->status_mask = CTF_STATUS_MASK_CSMBHEIIE_MASK
                                                | CTF_STATUS_MASK_CSML3I4CEIE_MASK
                                                | CTF_STATUS_MASK_CSML3PIIE_MASK
                                                | CTF_STATUS_MASK_CSML2PIIE_MASK
                                                | CTF_STATUS_MASK_CSMBHPIIE_MASK

            ETHSWT_FARegs[aID]->error_mask = CTF_ERROR_MASK_HWQ_OVERFLOW_ENABLE_MASK
                                            | CTF_ERROR_MASK_HB_OVERFLOW_ENABLE_MASK
                                            | CTF_ERROR_MASK_RXQ_OVERFLOW_ENABLE_MASK
                                            | CTF_ERROR_MASK_SOP_EOP_ENABLE_MASK
                                            | CTF_ERROR_MASK_SPB_OVERFLOW_ENABLE_MASK
                                            | CTF_ERROR_MASK_LAB_OVERFLOW_ENABLE_MASK
                                            | CTF_ERROR_MASK_INTERNAL_MERGE_ENABLE_MASK
                                            | CTF_ERROR_MASK_TXQ_OVERFLOW_ENABLE_MASK
                                            | CTF_ERROR_MASK_RB_OVERFLOW_ENABLE_MASK

            ETHSWT_FARegs[aID]->ecc_error_mask = CTF_ECC_ERRO_MASK_CEEMHUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMHCEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMLUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMLCEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH1UEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH1CEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH0UEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH0CEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNHUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNHCEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNFUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNFCEIE_MASK

        UNIMAC_Init(2U, &aConfig->unimacCfg)
        ETHSWT_FADrv[aID].seedValue = aConfig->ctfCfg.seedValue

        if (ETHSWT_FACTFMODE_NORMAL == aConfig->ctfCfg.mode)
            completionMask = CTF_STATUS_HB_INIT_DONE_MASK
                                | CTF_STATUS_LAB_INIT_DONE_MASK
                                | CTF_STATUS_HWQ_INIT_DONE_MASK
                                | CTF_STATUS_NEXT_HOP_INIT_DONE_MASK
                                | CTF_STATUS_NAPT_FLOW_INIT_DONE_MASK

            for (count = 4UL; count != 0UL; count--)
                regVal = ETHSWT_FARegs[aID]->status
                if (completionMask == (regVal & completionMask))
                    break
                else
                    BCM_DelayUs(1UL)

            if (0UL == count)
                val[0UL] = regVal
                val[1UL] = __LINE__
                val[2UL] = 0UL
                val[3UL] = 0UL
                retVal = BCM_ERR_TIME_OUT
            else
                retVal = BCM_ERR_OK
        else
            retVal = BCM_ERR_OK
    if (BCM_ERR_OK == retVal)
        ETHSWT_FADrv[aID].init = TRUE
    else
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVINIT_PROC, retVal, val[0], val[1], val[2], val[3])

    return
    @endcode
*/
static void ETHSWT_FADrvInit(uint8_t aID, const ETHSWT_FACfgType *const aConfig)
{
    uint32_t regVal;
    int32_t retVal;
    uint32_t val[4];
    uint32_t count;
    uint32_t completionMask;

    if ((NULL == aConfig) || (aID >= CTF_MAX_HW_ID)) {
        val[0UL] = __LINE__;
        val[1UL] = aID;
        val[2UL] = 0UL;
        val[3UL] = 0UL;
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (((ETHSWT_FACTFMODE_BYPASS != aConfig->ctfCfg.mode)
                && (ETHSWT_FACTFMODE_NORMAL != aConfig->ctfCfg.mode))
            || ((FALSE != aConfig->ctfCfg.validateMatchDA)
                && (TRUE != aConfig->ctfCfg.validateMatchDA))
            || ((ETHSWT_FACRC_CCITT != aConfig->ctfCfg.crc)
                && (ETHSWT_FACRC_CRC16 != aConfig->ctfCfg.crc))) {
        val[0UL] = __LINE__;
        val[1UL] = aConfig->ctfCfg.validateMatchDA;
        val[2UL] = aConfig->ctfCfg.mode;
        val[3UL] = aConfig->ctfCfg.crc;
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (TRUE == ETHSWT_FADrv[aID].init) {
        val[0UL] = __LINE__;
        val[1UL] = ETHSWT_FADrv[aID].init;
        val[2UL] = 0UL;
        val[3UL] = 0UL;
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        BCM_MemSet(&ETHSWT_FADrv[aID], 0U, sizeof(ETHSWT_FADrvType));

        UNIMAC_Init(1U, &aConfig->unimacCfg);
        if (ETHSWT_FACTFMODE_BYPASS == aConfig->ctfCfg.mode) {
            /* Enable Bypass mode */
            ETHSWT_FARegs[aID]->control |= CTF_CONTROL_BYPASS_CTF_MASK;
        } else {
            regVal = ETHSWT_FARegs[aID]->control;

            /* Disable Bypass mode */
            regVal &= ~CTF_CONTROL_BYPASS_CTF_MASK;

            if (FALSE == aConfig->ctfCfg.validateMatchDA) {
                regVal |= CTF_CONTROL_DISABLE_MAC_DA_CHECK_MASK;
            }
            ETHSWT_FADrv[aID].validateMatchDA = aConfig->ctfCfg.validateMatchDA;

            /* Init memories */
            regVal |= CTF_CONTROL_HB_INIT_MASK
                | CTF_CONTROL_LAB_INIT_MASK
                | CTF_CONTROL_HWQ_INIT_MASK
                | CTF_CONTROL_NEXT_HOP_INIT_MASK
                | CTF_CONTROL_NAPT_FLOW_INIT_MASK
                | CTF_CONTROL_CRC_OWRT_CONFIG_MASK;
            ETHSWT_FARegs[aID]->control = regVal;

            /* check back if the init is complete, before exiting this function */

            /* Enable BHA */
            ETHSWT_FARegs[aID]->brcm_hdr_control |=
                CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_MASK
                | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_MASK
                | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_MASK
                | CTF_BHC_CBHCBHPIE_MASK;
        }
        ETHSWT_FADrv[aID].mode = aConfig->ctfCfg.mode;

        regVal = ETHSWT_FARegs[aID]->l3_napt_control;
        /* Clear seed value, timestamp and hits-clear-on-read-enable(HWSCORPIO-1109) */
        regVal &= ~(CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_MASK
                | CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_MASK
                | CTF_L3_NAPT_CONT_CL3NCHCORE_MASK);
        /* Choose seed value */
        regVal |= aConfig->ctfCfg.seedValue;
        if (ETHSWT_FACRC_CRC16 == aConfig->ctfCfg.crc) {
            /* Enable CRC16 */
            regVal |= CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_MASK;
            ETHSWT_FADrv[aID].polynomial = 0x8005U; /* BUYPASS */
        } else {
            /* Enable CCITT */
            regVal &= ~CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_MASK;
            ETHSWT_FADrv[aID].polynomial = 0x1021U; /* XMODEM */
        }
        ETHSWT_FARegs[aID]->l3_napt_control = regVal;

        if (0UL != aConfig->ctfCfg.timestampPeriodSec) {
            ETHSWT_FADrv[aID].timestampPeriodSec = aConfig->ctfCfg.timestampPeriodSec;
        } else {
            ETHSWT_FADrv[aID].timestampPeriodSec = ETHSWT_FA_TIMESTAMP_PERIOD_SEC_DEFAULT;
        }
        ETHSWT_FARegs[aID]->l3_ipv4_type |= CTF_L3_IPV4_TYPE_PARSE_CHECKSUM_ENABLE_MASK;
        ETHSWT_FARegs[aID]->receive_status_enable = (CTF_RSE_CTF_RECEIVE_STATUS_ENABLE_RESERVED_MASK ^ 0xFFFFFFFFUL);

        if (ETHSWT_FACTFMODE_NORMAL == aConfig->ctfCfg.mode) {
            /* Enable interrupts if Normal Mode only*/
            ETHSWT_FARegs[aID]->status_mask = CTF_STATUS_MASK_CSMBHEIIE_MASK
                                                | CTF_STATUS_MASK_CSML3I4CEIE_MASK
                                                | CTF_STATUS_MASK_CSML3PIIE_MASK
                                                | CTF_STATUS_MASK_CSML2PIIE_MASK
                                                | CTF_STATUS_MASK_CSMBHPIIE_MASK;

            ETHSWT_FARegs[aID]->error_mask = CTF_ERROR_MASK_HWQ_OVERFLOW_ENABLE_MASK
                                                | CTF_ERROR_MASK_HB_OVERFLOW_ENABLE_MASK
                                                | CTF_ERROR_MASK_RXQ_OVERFLOW_ENABLE_MASK
                                                | CTF_ERROR_MASK_SOP_EOP_ENABLE_MASK
                                                | CTF_ERROR_MASK_SPB_OVERFLOW_ENABLE_MASK
                                                | CTF_ERROR_MASK_LAB_OVERFLOW_ENABLE_MASK
                                                | CTF_ERROR_MASK_INTERNAL_MERGE_ENABLE_MASK
                                                | CTF_ERROR_MASK_TXQ_OVERFLOW_ENABLE_MASK
                                                | CTF_ERROR_MASK_RB_OVERFLOW_ENABLE_MASK;

            ETHSWT_FARegs[aID]->ecc_error_mask = CTF_ECC_ERRO_MASK_CEEMHUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMHCEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMLUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMLCEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH1UEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH1CEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH0UEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMH0CEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNHUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNHCEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNFUEIE_MASK
                                                | CTF_ECC_ERRO_MASK_CEEMNFCEIE_MASK;
        }

        UNIMAC_Init(2U, &aConfig->unimacCfg);

        ETHSWT_FADrv[aID].seedValue = aConfig->ctfCfg.seedValue;

        if (ETHSWT_FACTFMODE_NORMAL == aConfig->ctfCfg.mode) {
            completionMask = CTF_STATUS_HB_INIT_DONE_MASK
                                | CTF_STATUS_LAB_INIT_DONE_MASK
                                | CTF_STATUS_HWQ_INIT_DONE_MASK
                                | CTF_STATUS_NEXT_HOP_INIT_DONE_MASK
                                | CTF_STATUS_NAPT_FLOW_INIT_DONE_MASK;

            for (count = 4UL; count != 0UL; count--) {
                regVal = ETHSWT_FARegs[aID]->status;
                if (completionMask == (regVal & completionMask)) {
                    break;
                } else {
                    /* Wait for 1us */
                    BCM_DelayUs(1UL);
                }
            }
            if (0UL == count) {
                val[0UL] = regVal;
                val[1UL] = __LINE__;
                val[2UL] = 0UL;
                val[3UL] = 0UL;
                retVal = BCM_ERR_TIME_OUT;
            } else {
                retVal = BCM_ERR_OK;
            }
        } else {
            retVal = BCM_ERR_OK;
        }
    }

    if (BCM_ERR_OK == retVal) {
        ETHSWT_FADrv[aID].init = TRUE;
    } else {
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVINIT_PROC, retVal, val[0], val[1], val[2], val[3]);
    }
    return;
}

/** @brief Deinitialize FA

    De-initializes the Flow Accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier

    @return     void

    @post None

    @limitations None
    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (TRUE == ETHSWT_FADrv[aID].init)
        UNIMAC_Deinit(2U)
        ETHSWT_FARegs[aID]->status_mask = 0UL
        ETHSWT_FARegs[aID]->error_mask = 0UL
        ETHSWT_FARegs[aID]->ecc_error_mask = 0UL

        ETHSWT_FARegs[aID]->status |= 0UL
        ETHSWT_FARegs[aID]->error |= 0UL
        ETHSWT_FARegs[aID]->ecc_error |= 0UL

        retVal = MCU_SwitchInterruptClear(MCU_SWITCHINTRFLAGS_CTF)
        if (BCM_ERR_OK != retVal)
            ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVDEINIT_PROC, retVal,
                0UL, 0UL, 0UL, 0UL)

        ETHSWT_FARegs[aID]->control |= CTF_CONTROL_BYPASS_CTF_MASK
        ETHSWT_FARegs[aID]->brcm_hdr_control &= ~(CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_MASK
                                                | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_MASK
                                                | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_MASK
                                                | CTF_BHC_CBHCBHPIE_MASK)
        UNIMAC_Deinit(1U)
        ETHSWT_FADrv[aID].init = FALSE
    return
    @endcode
*/
static void ETHSWT_FADrvDeinit(uint8_t aID)
{
    int32_t retVal;

    if (TRUE == ETHSWT_FADrv[aID].init) {
        UNIMAC_Deinit(2U);

        /* Disable all interrupts */
        ETHSWT_FARegs[aID]->status_mask = 0UL;
        ETHSWT_FARegs[aID]->error_mask = 0UL;
        ETHSWT_FARegs[aID]->ecc_error_mask = 0UL;

        /* Clear any pending interrupts */
        ETHSWT_FARegs[aID]->status |= 0UL;
        ETHSWT_FARegs[aID]->error |= 0UL;
        ETHSWT_FARegs[aID]->ecc_error |= 0UL;

        /* Clear the interrupt latched in Switch */
        retVal = MCU_SwitchInterruptClear(MCU_SWITCHINTRFLAGS_CTF);
        if (BCM_ERR_OK != retVal) {
            ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVDEINIT_PROC, retVal,
                0UL, 0UL, 0UL, 0UL);
        }

        ETHSWT_FARegs[aID]->control |= CTF_CONTROL_BYPASS_CTF_MASK;
        ETHSWT_FARegs[aID]->brcm_hdr_control &= ~(CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_MASK
                | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_MASK
                | CTF_BHC_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_MASK
                | CTF_BHC_CBHCBHPIE_MASK);

        UNIMAC_Deinit(1U);

        ETHSWT_FADrv[aID].init = FALSE;
    }
    return;
}

/** @brief Add a Flow

    Adds a new flow into Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aFlow       Pointer to flow of type #ETHSWT_FAFlowType
    @param[Out] aFlowID     Pointer to obtain the flow identifier upon success
                            Driver stores the flow identifier upon addition

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow added successfully
    @retval    #BCM_ERR_NOMEM           Insufficient memory to add
    @retval    #BCM_ERR_NOT_FOUND       Matching entry not found in Pool table
    @retval    #BCM_ERR_INVAL_STATE     FA is initialised in BYPASS mode
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aFlow is NULL OR aFlowID is NULL

    @post None

    @limitations None
    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    uint8_t matchPoolIndex = 0U
    uint8_t remapPoolIndex = 0U
    uint8_t nextHopIndex = 0U
    int32_t tempError = BCM_ERR_OK

    if ((NULL == aFlow) || (NULL == aFlowID))
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode)
        retVal = BCM_ERR_INVAL_STATE
    else
        *aFlowID = ETHSWT_FAGenerateHash(aID, &aFlow->match)
        *aFlowID = (*aFlowID & 0xFFU) * ETHSWT_FA_FLOWTABLE_HASH_BUCKETS

        if (0U == (aFlow->match.flags & ETHSWT_FAFLAGS_L3IPV4))
            isIpv4 = FALSE
        else
            isIpv4 = TRUE

        if (ETHSWT_FAFLAGS_INBOUND == (aFlow->match.flags & ETHSWT_FAFLAGS_INBOUND))
            external = 1U
        else
            external = 0U

        if (TRUE == ETHSWT_FADrv[aID].validateMatchDA)
            retVal = ETHSWT_FAPoolEntryAcquire(aID, aFlow->match.da, external, &matchPoolIndex);
        else
            retVal = BCM_ERR_OK

        if (BCM_ERR_OK == retVal)
            retVal = ETHSWT_FAPoolEntryAcquire(aID, aFlow->remap.sa, external, &remapPoolIndex);
            if (BCM_ERR_OK == retVal)
                if (0U == (aFlow->match.flags & ETHSWT_FAFLAGS_L2LLCSNAP))
                    frameType = 0U
                else
                    frameType = 1U

                retVal = ETHSWT_FANextHopEntryAdd(aID, &buff[0],
                                                  aFlow->remap.da,
                                                  aFlow->remap.vlan,
                                                  aFlow->remap.operation,
                                                  frameType, &nextHopIndex)
                if (BCM_ERR_OK == retVal)
                    ETHSWT_FAStruct2FlowTable(&buff[0], aFlow, remapPoolIndex,
                                              nextHopIndex)

                    retVal = ETHSWT_FAUpdateBucketID(aID, aFlowID, isIpv4, buff)
                    if (BCM_ERR_OK == retVal)
                        ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, *aFlowID,
                                             ETHSWT_FATABLEACCESS_WRITE,
                                             &buff[0])
                        mask = 1U
                        ETHSWT_FADrv[aID].flowTableUsage++
                        if (FALSE == isIpv4)
                            mask |= 2U
                            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW,
                                                 (*aFlowID +1U),
                                                 ETHSWT_FATABLEACCESS_WRITE,
                                                 &buff[8U])
                            ETHSWT_FADrv[aID].flowTableUsage++
                        mask = mask << (*aFlowID & 7U)
                        ETHSWT_FADrv[aID].flowStatus.activeMask[*aFlowID >> 3U] |= mask

                        if (ETHSWT_FAFLOWVALID_TILLREBOOT == aFlow->valid)
                            ETHSWT_FADrv[aID].flowStatus.staticMask[*aFlowID >> 3U] |= mask
                        ETHSWT_FADrv[aID].pool.macInfo[remapPoolIndex].flowMask[*aFlowID >> 3U] |= mask

                        if (TRUE == ETHSWT_FADrv[aID].validateMatchDA)
                            ETHSWT_FADrv[aID].pool.macInfo[matchPoolIndex].flowMask[*aFlowID >> 3U] |= mask

                        retVal = BCM_ERR_OK
                    else
                        ETHSWT_FANextHopEntryDelete(aID, nextHopIndex, &buff[0])
                        tempError = ETHSWT_FAPoolEntryRelease(aID, matchPoolIndex)
                        if (BCM_ERR_OK != tempError)
                            val[0UL] = __LINE__
                            val[1UL] = matchPoolIndex
                        else
                            tempError = ETHSWT_FAPoolEntryRelease(aID, remapPoolIndex)
                            if (BCM_ERR_OK != tempError)
                                val[0UL] = __LINE__
                                val[1UL] = remapPoolIndex
                else
                    tempError = ETHSWT_FAPoolEntryRelease(aID, matchPoolIndex)
                    if (BCM_ERR_OK != tempError)
                        val[0UL] = __LINE__
                        val[1UL] = matchPoolIndex
                    else
                        tempError = ETHSWT_FAPoolEntryRelease(aID, remapPoolIndex)
                        if (BCM_ERR_OK != tempError)
                            val[0UL] = __LINE__
                            val[1UL] = remapPoolIndex
            else
                tempError = ETHSWT_FAPoolEntryRelease(aID, matchPoolIndex)
                if (BCM_ERR_OK != tempError)
                    val[0UL] = __LINE__
                    val[1UL] = matchPoolIndex
            if (BCM_ERR_OK != tempError)
                ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVFLOWADD_PROC, retVal,
                    val[0UL], val[1UL], __LINE__, 0UL)
    return retVal
    @endcode
*/
static int32_t ETHSWT_FADrvFlowAdd(uint8_t aID, const ETHSWT_FAFlowType *const aFlow,
                                   uint16_t *const aFlowID)
{
    int32_t retVal;
    uint32_t buff[16UL];
    uint8_t matchPoolIndex = 0U;
    uint8_t remapPoolIndex = 0U;
    uint8_t frameType;
    uint8_t nextHopIndex = 0U;
    uint32_t isIpv4;
    uint8_t mask;
    int32_t tempError = BCM_ERR_OK;
    uint32_t val[2UL];
    uint32_t external;

    if ((NULL == aFlow) || (NULL == aFlowID)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        *aFlowID = ETHSWT_FAGenerateHash(aID, &aFlow->match);
        *aFlowID = (*aFlowID & 0xFFU) * ETHSWT_FA_FLOWTABLE_HASH_BUCKETS;

        if (0U == (aFlow->match.flags & ETHSWT_FAFLAGS_L3IPV4)) {
            isIpv4 = FALSE;
        } else {
            isIpv4 = TRUE;
        }
        if (ETHSWT_FAFLAGS_INBOUND == (aFlow->match.flags & ETHSWT_FAFLAGS_INBOUND)) {
            external = 1U;
        } else {
            external = 0U;
        }

        /* Add incoming MAC address if validateMatchDA is enabled */
        if (TRUE == ETHSWT_FADrv[aID].validateMatchDA) {
            retVal = ETHSWT_FAPoolEntryAcquire(aID, aFlow->match.da, external, &matchPoolIndex);
        } else {
            retVal = BCM_ERR_OK;
        }
        if (BCM_ERR_OK == retVal) {
            /* Add remap MAC address */
            retVal = ETHSWT_FAPoolEntryAcquire(aID, aFlow->remap.sa, external, &remapPoolIndex);
            if (BCM_ERR_OK == retVal) {
                if (0U == (aFlow->match.flags & ETHSWT_FAFLAGS_L2LLCSNAP)) {
                    frameType = 0U;
                } else {
                    frameType = 1U;
                }
                /* Add next-hop entry */
                retVal = ETHSWT_FANextHopEntryAdd(aID, &buff[0],
                                                  aFlow->remap.da,
                                                  aFlow->remap.vlan,
                                                  aFlow->remap.operation,
                                                  frameType, &nextHopIndex);
                if (BCM_ERR_OK == retVal) {
                    /* Add flow table entry/entries */
                    ETHSWT_FAStruct2FlowTable(&buff[0], aFlow, remapPoolIndex,
                                              nextHopIndex);

                    retVal = ETHSWT_FAUpdateBucketID(aID, aFlowID, isIpv4, buff);
                    if (BCM_ERR_OK == retVal) {
                        /* Bucket Found, continue with actual Table Update */
                        ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, *aFlowID,
                                             ETHSWT_FATABLEACCESS_WRITE,
                                             &buff[0]);
                        mask = 1U;
                        ETHSWT_FADrv[aID].flowTableUsage++;
                        if (FALSE == isIpv4) {
                            mask |= 2U;
                            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW,
                                                 (*aFlowID +1U),
                                                 ETHSWT_FATABLEACCESS_WRITE,
                                                 &buff[8U]);
                            ETHSWT_FADrv[aID].flowTableUsage++;
                        }

                        /* Update Active/Static fields for current Flow IDs */
                        mask = mask << (*aFlowID & 7U);
                        ETHSWT_FADrv[aID].flowStatus.activeMask[*aFlowID >> 3U] |= mask;

                        if (ETHSWT_FAFLOWVALID_TILLREBOOT == aFlow->valid) {
                            ETHSWT_FADrv[aID].flowStatus.staticMask[*aFlowID >> 3U] |= mask;
                        }

                        /* Update FlowStatus with remap-Mac usage */
                        ETHSWT_FADrv[aID].pool.macInfo[remapPoolIndex].flowMask[*aFlowID >> 3U] |= mask;

                        if (TRUE == ETHSWT_FADrv[aID].validateMatchDA) {
                            /* Update FlowStatus with match-Mac usage */
                            ETHSWT_FADrv[aID].pool.macInfo[matchPoolIndex].flowMask[*aFlowID >> 3U] |= mask;
                        }
                        retVal = BCM_ERR_OK;
                    } else { /* Roolback due to failure to find flow bucket */
                        ETHSWT_FANextHopEntryDelete(aID, nextHopIndex, &buff[0]);
                        tempError = ETHSWT_FAPoolEntryRelease(aID, matchPoolIndex);
                        if (BCM_ERR_OK != tempError) {
                            val[0UL] = __LINE__;
                            val[1UL] = matchPoolIndex;
                        } else {
                            tempError = ETHSWT_FAPoolEntryRelease(aID, remapPoolIndex);
                            if (BCM_ERR_OK != tempError) {
                                val[0UL] = __LINE__;
                                val[1UL] = remapPoolIndex;
                            }
                        }
                    }
                } else { /* Roolback due to failure to add next hop entry */
                    tempError = ETHSWT_FAPoolEntryRelease(aID, matchPoolIndex);
                    if (BCM_ERR_OK != tempError) {
                        val[0UL] = __LINE__;
                        val[1UL] = matchPoolIndex;
                    } else {
                        tempError = ETHSWT_FAPoolEntryRelease(aID, remapPoolIndex);
                        if (BCM_ERR_OK != tempError) {
                            val[0UL] = __LINE__;
                            val[1UL] = remapPoolIndex;
                        }
                    }
                }
            } else { /* Rollback due to failure to add remapSA to pool table */
                tempError = ETHSWT_FAPoolEntryRelease(aID, matchPoolIndex);
                if (BCM_ERR_OK != tempError) {
                    val[0UL] = __LINE__;
                    val[1UL] = matchPoolIndex;
                }
            }
            if (BCM_ERR_OK != tempError) {
                ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVFLOWADD_PROC, retVal,
                    val[0UL], val[1UL], __LINE__, 0UL);
            }
        }
    }

    return retVal;
}

/** @brief Delete a Flow

    Deletes an existing flow from Flow accelerator by providing the
    Flow ID obtained after adding the same.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aFlowID     Flow ID of the flow to be deleted.

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow deleted successfully
    @retval    #BCM_ERR_NOPERM          No permission to delete static entry
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aFlowID is invalid OR inactive

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (ETHSWT_FA_FLOWS_MAX <= aFlowID)
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else if (0U == ((ETHSWT_FADrv[aID].flowStatus.activeMask[aFlowID >> 3U] >> (aFlowID & 0x7U)) & 0x1U))
        retVal = BCM_ERR_INVAL_PARAMS
    else if (0U != ((ETHSWT_FADrv[aID].flowStatus.staticMask[aFlowID >> 3U] >> (aFlowID & 0x7U)) & 0x1U))
        retVal = BCM_ERR_NOPERM
    else
        flowIndex = aFlowID & (((uint16_t)ETHSWT_FA_FLOWS_MAX - 1U) ^ 0x1U)

        ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, &buff[0U])
        if (1UL == ((buff[7U] >> 20UL) & 0x1UL))
            isValid = TRUE
        else
            isValid = FALSE
        if (0UL == ((buff[7U] >> 31UL) & 0x1UL))
            isIPv4 = FALSE
        else
            isIPv4 = TRUE

        if ((FALSE == isIPv4) && (TRUE == isValid))
            Valid IPv6 entry, delete two entries from flowID
        else
            if (aFlowID != flowIndex)
                flowIndex = aFlowID
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, buff)
            else
                table has already been read from aFlowID, delete it
            isValid = (uint8_t)((buff[6U] >> 20U) & 0x1U)
            isIPv4 = TRUE

        if (TRUE == isValid)
            ETHSWT_FAFlowTable2Struct(&buff[0], NULL, NULL, &remapSaIdx, &nextHopIdx)
            buff[7U] = (1UL << 31UL)
            buff[6U] = 0UL

            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex,
                                 ETHSWT_FATABLEACCESS_WRITE, &buff[0U])
            ETHSWT_FADrv[aID].flowTableUsage--
            mask = 1U

            if (FALSE == isIPv4)
                mask |= 2U
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (flowIndex + 1U),
                                     ETHSWT_FATABLEACCESS_WRITE, &buff[0U])
                ETHSWT_FADrv[aID].flowTableUsage--

            mask = mask << (flowIndex & 7U)
            ETHSWT_FADrv[aID].flowStatus.activeMask[flowIndex >> 3U] &= ~mask

            ETHSWT_FAPoolEntryRelease(aID, remapSaIdx)
            ETHSWT_FADrv[aID].pool.macInfo[remapSaIdx].flowMask[flowIndex >> 3U] &= ~mask

            if (TRUE == ETHSWT_FADrv[aID].validateMatchDA)
                for (i = 0UL; i < ETHSWT_FA_POOL_MAX; i++)
                    if ((i != remapSaIdx) && (TRUE == ETHSWT_FADrv[aID].pool.macInfo[i].valid))
                        macUsageMask = ETHSWT_FADrv[aID].pool.macInfo[i].flowMask[flowIndex >> 3U]
                        if (0U != (macUsageMask & mask))
                            break
                if (ETHSWT_FA_POOL_MAX == i)
                    i = remapSaIdx
                ETHSWT_FAPoolEntryRelease(aID, i)
                ETHSWT_FADrv[aID].pool.macInfo[i].flowMask[flowIndex >> 3U] &= ~mask

            ETHSWT_FANextHopEntryDelete(aID, nextHopIdx, buff)
            retVal = BCM_ERR_OK
        else
            retVal = BCM_ERR_INVAL_PARAMS
    return retVal
    @endcode
*/
static int32_t ETHSWT_FADrvFlowDelete(uint8_t aID, const uint16_t aFlowID)
{
    int32_t retVal;
    uint32_t buff[16UL] = {0UL};
    uint8_t remapSaIdx = 0U;
    uint8_t nextHopIdx = 0U;
    uint32_t isValid;
    uint32_t isIPv4;
    uint8_t mask;
    uint8_t macUsageMask;;
    uint8_t i;
    uint16_t flowIndex;

    if (ETHSWT_FA_FLOWS_MAX <= aFlowID) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else if (0U == ((ETHSWT_FADrv[aID].flowStatus.activeMask[aFlowID >> 3U] >> (aFlowID & 0x7U)) & 0x1U)) {
        /* Flow not active, invalid aFlowID */
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (0U != ((ETHSWT_FADrv[aID].flowStatus.staticMask[aFlowID >> 3U] >> (aFlowID & 0x7U)) & 0x1U)) {
        /* Flow is static */
        retVal = BCM_ERR_NOPERM;
    } else {
        /* reset bit0 of aFlowID to check if it is of IPv6 or IPv4 */
        flowIndex = aFlowID & (((uint16_t)ETHSWT_FA_FLOWS_MAX - 1U) ^ 0x1U);

        ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, &buff[0U]);
        if (1UL == ((buff[7U] >> 20UL) & 0x1UL)) {
            isValid = TRUE;
        } else {
            isValid = FALSE;
        }
        if (0UL == ((buff[7U] >> 31UL) & 0x1UL)) {
            isIPv4 = FALSE;
        } else {
            isIPv4 = TRUE;
        }

        if ((FALSE == isIPv4) && (TRUE == isValid)) {
            /* Valid IPv6 entry, delete two entries from flowID */
        } else {
            if (aFlowID != flowIndex) {
                /* read the table corresponding to aFlowID and delete that entry */
                flowIndex = aFlowID;
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, buff);
            } else {
                /* table has already been read from aFlowID, delete it */
            }
            isValid = (uint8_t)((buff[6U] >> 20U) & 0x1U);
            isIPv4 = TRUE;
        }

        if (TRUE == isValid) {
            (void)ETHSWT_FAFlowTable2Struct(&buff[0], NULL, NULL, &remapSaIdx, &nextHopIdx);
            /* Set IPv4 (also valid=0 in case of IPv6) */
            buff[7U] = (1UL << 31UL);
            /* Mark invalid incase of IPv4 */
            buff[6U] = 0UL;

            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex,
                                 ETHSWT_FATABLEACCESS_WRITE, &buff[0U]);
            /* Decrement FlowTable Usage Count */
            ETHSWT_FADrv[aID].flowTableUsage--;
            mask = 1U;

            if (FALSE == isIPv4) {
                mask |= 2U;
                ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, (flowIndex + 1U),
                                     ETHSWT_FATABLEACCESS_WRITE, &buff[0U]);
                ETHSWT_FADrv[aID].flowTableUsage--;
            }

            /* Mark entries as invalid in sw status */
            mask = mask << (flowIndex & 7U);
            ETHSWT_FADrv[aID].flowStatus.activeMask[flowIndex >> 3U] &= ~mask;

            /* No need to update staticMask since we have reached this point
             * only because it is ETHSWT_FAFLOWVALID_TILLDELETE */

            /* Delete Pool table entry - RemapSA */
            retVal = ETHSWT_FAPoolEntryRelease(aID, remapSaIdx);
            if (BCM_ERR_OK != retVal) {
                ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVFLOWDELETE_PROC, retVal,
                        0UL, 0UL, 0UL, __LINE__);
            }
            ETHSWT_FADrv[aID].pool.macInfo[remapSaIdx].flowMask[flowIndex >> 3U] &= ~mask;

            /* Delete Pool table entry - Match DA */
            if (TRUE == ETHSWT_FADrv[aID].validateMatchDA) {
                /* If MAC address was other than remapSa, then it must be set in macUsageMask */
                for (i = 0U; i < ETHSWT_FA_POOL_MAX; i++) {
                    /* Ignore remapSaIdx for now */
                    if ((i != remapSaIdx) && (TRUE == ETHSWT_FADrv[aID].pool.macInfo[i].valid)){
                        macUsageMask = ETHSWT_FADrv[aID].pool.macInfo[i].flowMask[flowIndex >> 3U];
                        if (0U != (macUsageMask & mask)) {
                            break;
                        }
                    }
                }
                /* If not found, then it means that remapSA = matchDA */
                if (ETHSWT_FA_POOL_MAX == i) {
                    i = remapSaIdx;
                }
                retVal = ETHSWT_FAPoolEntryRelease(aID, i);
                if (BCM_ERR_OK != retVal) {
                    ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FADRVFLOWDELETE_PROC, retVal,
                            0UL, 0UL, 0UL, __LINE__);
                }
                ETHSWT_FADrv[aID].pool.macInfo[i].flowMask[flowIndex >> 3U] &= ~mask;
            }

            /* Delete NextHop table entry */
            ETHSWT_FANextHopEntryDelete(aID, nextHopIdx, buff);

            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }
    return retVal;
}

/** @brief Flow Get

    Retrieves flow parameters pertaining to a Flow ID

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[in]  aFlowID     Flow ID of the flow
    @param[out] aFlow       Pointer to retrieve flow parameters, to be updated by driver
    @param[out] aFlowStats  Pointer to retrieve flow statistics, to be updated by driver

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Flow parameters obtained successfully
    @retval    #BCM_ERR_INVAL_PARAMS    aFlowID is invalid OR
                                        aFlow is NULL OR aStat is NULL
    @retval    #BCM_ERR_UNINIT          FA is uninitialised

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    nextHopIdx = 0U
    remapSaIdx= 0U
    mask = 1U

    if ((NULL == aFlowStats) || (NULL == aFlow)
            || (ETHSWT_FA_FLOWS_MAX <= aFlowID))
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else
        flowIndex = aFlowID & (((uint16_t)ETHSWT_FA_FLOWS_MAX - 1U) ^ 0x1U)
        ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, &buff[0U])

        if (1UL == ((buff[7U] >> 20UL) & 0x1UL))
            isValid = TRUE
        else
            isValid = FALSE

        if (0UL == ((buff[7U] >> 31UL) & 0x1uL))
            isIpv4 = FALSE
        else
            isIpv4 = TRUE

        if ((FALSE == isIpv4) && (TRUE == isValid))
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex + 1U, ETHSWT_FATABLEACCESS_READ, &buff[8U])
            mask |= 2U
        else if (aFlowID != flowIndex)
            flowIndex = aFlowID
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, buff)
        else
            table has already been read, continue to interpret the values

        mask = mask << (flowIndex & 7U)
        aFlow->match.flags = 0U

        isValid = ETHSWT_FAFlowTable2Struct(&buff[0], aFlow, aFlowStats, &remapSaIdx, &nextHopIdx)
        if (TRUE == isValid)
            BCM_MemCpy(aFlow->remap.sa, ETHSWT_FADrv[aID].pool.macInfo[remapSaIdx].mac, 6UL)
            if (TRUE == ETHSWT_FADrv[aID].validateMatchDA)
                for (i = 0UL; i < ETHSWT_FA_POOL_MAX; i++)
                    if ((i != remapSaIdx) && (TRUE == ETHSWT_FADrv[aID].pool.macInfo[i].valid))
                        macUsageMask = ETHSWT_FADrv[aID].pool.macInfo[i].flowMask[flowIndex  >> 3U]
                        if (0U != (macUsageMask & mask))
                            break
                if (ETHSWT_FA_POOL_MAX == i)
                    i = remapSaIdx
                BCM_MemCpy(aFlow->match.da, ETHSWT_FADrv[aID].pool.macInfo[i].mac, 6UL)
            else
                BCM_MemSet(aFlow->match.da, 0U, 6UL)
            if (0U != (ETHSWT_FADrv[aID].flowStatus.staticMask[flowIndex  >> 3U] & mask))
                aFlow->valid = ETHSWT_FAFLOWVALID_TILLREBOOT
            else
                aFlow->valid = ETHSWT_FAFLOWVALID_TILLDELETE
            nhPtr = &ETHSWT_FADrv[aID].nextHop[nextHopIdx]
            if (1U == (nhPtr->misc & 0x1U))
                aFlow->match.flags |= ETHSWT_FAFLAGS_L2LLCSNAP

            aFlow->remap.operation = (uint8_t)((nhPtr->misc & 0x6UL) >> 1UL)
            aFlow->remap.vlan = nhPtr->vlan
            BCM_MemCpy(aFlow->remap.da, nhPtr->mac, 6UL)
            retVal = BCM_ERR_OK
        else
            retVal = BCM_ERR_INVAL_PARAMS
    return retVal
    @endcode
*/
static int32_t ETHSWT_FADrvFlowGet(uint8_t aID, const uint16_t aFlowID,
                                ETHSWT_FAFlowType *const aFlow,
                                ETHSWT_FAFlowStatsType *const aFlowStats)
{
    int32_t retVal;
    uint32_t buff[16UL] = {0UL};
    uint32_t isValid;
    uint8_t nextHopIdx = 0U;
    uint8_t remapSaIdx= 0U;
    ETHSWT_FANextHopType *nhPtr;
    uint8_t i;
    uint8_t macUsageMask;
    uint8_t mask = 1U;
    uint16_t flowIndex;
    uint32_t isIpv4;

    if ((NULL == aFlowStats) || (NULL == aFlow)
            || (ETHSWT_FA_FLOWS_MAX <= aFlowID)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else {
        /* reset bit0 of aFlowID to check if it is of IPv6 or IPv4 */
        flowIndex = aFlowID & (((uint16_t)ETHSWT_FA_FLOWS_MAX - 1U) ^ 0x1U);

        /* Read the table instead of ascertaining the status of flow from cached bitMask */
        ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, &buff[0U]);

        if (1UL == ((buff[7U] >> 20UL) & 0x1UL)) {
            isValid = TRUE;
        } else {
            isValid = FALSE;
        }
        if (0UL == ((buff[7U] >> 31UL) & 0x1uL)) {
            isIpv4 = FALSE;
        } else {
            isIpv4 = TRUE;
        }

        /* If IPv6, read the next table too */
        if ((FALSE == isIpv4) && (TRUE == isValid)) {
            /* Valid IPv6 entry */
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex + 1U, ETHSWT_FATABLEACCESS_READ, &buff[8U]);
            mask |= 2U;
        } else if (aFlowID != flowIndex) {
            /* read the table corresponding to aflowID */
            flowIndex = aFlowID;
            ETHSWT_FATableAccess(aID, ETHSWT_FATABLE_FLOW, flowIndex, ETHSWT_FATABLEACCESS_READ, buff);
        } else {
            /* table has already been read, continue to interpret the values */
        }
        mask = mask << (flowIndex & 7U);

        /* Reset this. It will be updated by Flow and next-hop tables */
        aFlow->match.flags = 0U;

        isValid = ETHSWT_FAFlowTable2Struct(&buff[0], aFlow, aFlowStats, &remapSaIdx, &nextHopIdx);
        if (TRUE == isValid) {
            /* Retrieve information from (cached) Pool table */
            BCM_MemCpy(aFlow->remap.sa, ETHSWT_FADrv[aID].pool.macInfo[remapSaIdx].mac, 6UL);
            if (TRUE == ETHSWT_FADrv[aID].validateMatchDA) {
                /* If MAC address was other than remapSa, then it must be set in macUsageMask */
                for (i = 0U; i < ETHSWT_FA_POOL_MAX; i++) {
                    /* Ignore remapSaIdx for now */
                    if ((i != remapSaIdx) && (TRUE == ETHSWT_FADrv[aID].pool.macInfo[i].valid)) {
                        macUsageMask = ETHSWT_FADrv[aID].pool.macInfo[i].flowMask[flowIndex >> 3U];
                        if (0U != (macUsageMask & mask)) {
                            break;
                        }
                    }
                }
                /* If not found, then it means that remapSA = matchDA */
                if (ETHSWT_FA_POOL_MAX == i) {
                    i = remapSaIdx;
                }
                BCM_MemCpy(aFlow->match.da, ETHSWT_FADrv[aID].pool.macInfo[i].mac, 6UL);
            } else {
                BCM_MemSet(aFlow->match.da, 0U, 6UL);
            }

            if (0U != (ETHSWT_FADrv[aID].flowStatus.staticMask[flowIndex >> 3U] & mask)) {
                aFlow->valid = ETHSWT_FAFLOWVALID_TILLREBOOT;
            } else {
                aFlow->valid = ETHSWT_FAFLOWVALID_TILLDELETE;
            }

            /* Retrieve information from (cached) NextHop table */
            nhPtr = &ETHSWT_FADrv[aID].nextHop[nextHopIdx];
            if (1U == (nhPtr->misc & 0x1U)) {
                aFlow->match.flags |= ETHSWT_FAFLAGS_L2LLCSNAP;
            }
            aFlow->remap.operation = (uint8_t)((nhPtr->misc & 0x6UL) >> 1UL);
            aFlow->remap.vlan = nhPtr->vlan;
            BCM_MemCpy(aFlow->remap.da, nhPtr->mac, 6UL);

            retVal = BCM_ERR_OK;
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/** @brief Retrieve statistics

    Retrieves statistics from Flow accelerator

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier
    @param[out] aStats  Pointer to statistics structure of type
                        #ETHSWT_FAStatsType to be filled by the driver

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK              Statistics retrieved successfully
    @retval    #BCM_ERR_UNINIT          FA is uninitialised
    @retval    #BCM_ERR_INVAL_PARAMS    aStats is NULL

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (NULL == aStats)
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else
        aStats->hit               = ETHSWT_FARegs[aID]->hit_count
        aStats->miss              = ETHSWT_FARegs[aID]->miss_count
        aStats->snapFail          = ETHSWT_FARegs[aID]->snap_fail_count
        aStats->etypeFail         = ETHSWT_FARegs[aID]->etype_fail_count
        aStats->versionFail       = ETHSWT_FARegs[aID]->version_fail_count
        aStats->fragFail          = ETHSWT_FARegs[aID]->frag_fail_count
        aStats->protocolFail      = ETHSWT_FARegs[aID]->protocol_ext_fail_count
        aStats->checksumFail      = ETHSWT_FARegs[aID]->ipv4_checksum_fail_count
        aStats->optionsFail       = ETHSWT_FARegs[aID]->ipv4_options_fail_count
        aStats->headerLengthFail  = ETHSWT_FARegs[aID]->ipv4_header_length_fail_count
        aStats->flowTableUsage = ETHSWT_FADrv[aID].flowTableUsage
        aStats->poolTableUsage = ETHSWT_FADrv[aID].pool.tableUsage
        aStats->nextHopTableUsage = ETHSWT_FADrv[aID].nextHopTableUsage
        aStats->currentTimestamp = ETHSWT_FADrv[aID].currentTimestamp
        aStats->intrFlags = ETHSWT_FADrv[aID].intrFlags
        ETHSWT_FADrv[aID].intrFlags = 0UL
        BCM_MemCpy(aFlowStatus, &ETHSWT_FADrv[aID].flowStatus,
                   sizeof(ETHSWT_FAFlowStatusType))
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t ETHSWT_FADrvStats(uint8_t aID, ETHSWT_FAStatsType *const aStats,
                                 ETHSWT_FAFlowStatusType *const aFlowStatus)
{
    int32_t retVal;

    if (NULL == aStats) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else {
        aStats->hit               = ETHSWT_FARegs[aID]->hit_count;
        aStats->miss              = ETHSWT_FARegs[aID]->miss_count;
        aStats->snapFail          = ETHSWT_FARegs[aID]->snap_fail_count;
        aStats->etypeFail         = ETHSWT_FARegs[aID]->etype_fail_count;
        aStats->versionFail       = ETHSWT_FARegs[aID]->version_fail_count;
        aStats->fragFail          = ETHSWT_FARegs[aID]->frag_fail_count;
        aStats->protocolFail      = ETHSWT_FARegs[aID]->protocol_ext_fail_count;
        aStats->checksumFail      = ETHSWT_FARegs[aID]->ipv4_checksum_fail_count;
        aStats->optionsFail       = ETHSWT_FARegs[aID]->ipv4_options_fail_count;
        aStats->headerLengthFail  = ETHSWT_FARegs[aID]->ipv4_header_length_fail_count;

        aStats->flowTableUsage = ETHSWT_FADrv[aID].flowTableUsage;
        aStats->poolTableUsage = ETHSWT_FADrv[aID].pool.tableUsage;
        aStats->nextHopTableUsage = ETHSWT_FADrv[aID].nextHopTableUsage;
        aStats->currentTimestamp = ETHSWT_FADrv[aID].currentTimestamp;
        aStats->intrFlags = ETHSWT_FADrv[aID].intrFlags;

        /* Clear read interrupt flags */
        ETHSWT_FADrv[aID].intrFlags = 0UL;

        BCM_MemCpy(aFlowStatus, &ETHSWT_FADrv[aID].flowStatus,
                   sizeof(ETHSWT_FAFlowStatusType));

        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Periodic Timer

    Handles the periodic timer meant for managing timestamp

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aFAID       FA Hardware Instance Identifier

    Return values are documented in reverse-chronological order
    @retval    #BCM_ERR_OK      Timer event processed successfully
    @retval    #BCM_ERR_UNINIT  FA is uninitialised

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else
        currentNs = BCM_GetSystemTimeNs()
        elapsedSec = (currentNs - ETHSWT_FADrv[aID].lastTimeNs) / (1000UL * 1000UL * 1000UL)
        if (elapsedSec >= ETHSWT_FADrv[aID].timestampPeriodSec)
            ETHSWT_FADrv[aID].currentTimestamp++
            ETHSWT_FADrv[aID].currentTimestamp &= (CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_MASK
                    >> CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_SHIFT)
            ETHSWT_FADrv[aID].lastTimeNs = currentNs

            regVal = ETHSWT_FARegs[aID]->l3_napt_control
            regVal &= ~CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_MASK
            regVal |= (ETHSWT_FADrv[aID].currentTimestamp
                    << CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_SHIFT)
            ETHSWT_FARegs[aID]->l3_napt_control = regVal
        retVal = BCM_ERR_OK
    return retVal
    @endcode
*/
static int32_t ETHSWT_FADrvTimer(uint8_t aID)
{
    int32_t retVal;
    uint32_t regVal;
    uint64_t currentNs;
    uint32_t elapsedSec;

    if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else {
        currentNs = BCM_GetSystemTimeNs();
        elapsedSec = (uint32_t)((currentNs - ETHSWT_FADrv[aID].lastTimeNs)
                        / (1000UL * 1000UL * 1000UL));
        if (elapsedSec >= ETHSWT_FADrv[aID].timestampPeriodSec) {
            /* store updated timestamp */
            ETHSWT_FADrv[aID].currentTimestamp++;
            ETHSWT_FADrv[aID].currentTimestamp &= (uint8_t)(CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_MASK
                    >> CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_SHIFT);
            /* Store current time */
            ETHSWT_FADrv[aID].lastTimeNs = currentNs;

            /* Update timestamp in ctf register */
            regVal = ETHSWT_FARegs[aID]->l3_napt_control;
            regVal &= ~CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_MASK;
            regVal |= ((uint32_t)ETHSWT_FADrv[aID].currentTimestamp
                    << CTF_L3_NAPT_CONT_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_SHIFT);
            ETHSWT_FARegs[aID]->l3_napt_control = regVal;
        }
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAIRQHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    for (id = 0UL; id < CTF_MAX_HW_ID; id++)
        status = ETHSWT_FARegs[id]->status & ETHSWT_FARegs[id]->status_mask
        unRsvdMask = CTF_STATUS_MASK_CTF_STATUS_MASK_RESERVED_MASK ^ 0xFFFFFFFFUL
        ETHSWT_FARegs[id]->status_mask &= (status ^ unRsvdMask)
        ETHSWT_FARegs[id]->status = status

        error = ETHSWT_FARegs[id]->error & ETHSWT_FARegs[id]->error_mask
        unRsvdMask = CTF_ERROR_MASK_RESERVED_MASK ^ 0xFFFFFFFFUL
        ETHSWT_FARegs[id]->error_mask &= (error ^ unRsvdMask)
        ETHSWT_FARegs[id]->error = error

        eccError = ETHSWT_FARegs[id]->ecc_error
                    & ETHSWT_FARegs[id]->ecc_error_mask
        unRsvdMask = CTF_ECC_ERRO_MASK_CTF_ECC_ERROR_MASK_RESERVED_MASK ^ 0xFFFFFFFFUL
        ETHSWT_FARegs[id]->ecc_error_mask &= (eccError ^ unRsvdMask)
        ETHSWT_FARegs[id]->ecc_error = eccError


        if (0UL != status)
            if (0UL != (status & CTF_STATUS_BRCM_HDR_EDIT_INVALID_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_EDIT_BH
            if (0UL != (status & CTF_STATUS_L3_IPV4_CHECKSUM_ERR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_IPV4_CHECKSUM
            if (0UL != (status & CTF_STATUS_L3_PARSING_INCOMPLETE_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_PARSE_L3
            if (0UL != (status & CTF_STATUS_L2_PARSING_INCOMPLETE_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_PARSE_L2
            if (0UL != (status & CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_PARSE_BH

        if (0UL != error)
            if (0UL != (error & CTF_ERROR_HWQ_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_HWQ
            if (0UL != (error & CTF_ERROR_HB_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_HB
            if (0UL != (error & CTF_ERROR_RXQ_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_RXQ
            if (0UL != (error & CTF_ERROR_SOP_EOP_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_SOP_EOP
            if (0UL != (error & CTF_ERROR_SPB_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_SPB
            if (0UL != (error & CTF_ERROR_LAB_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_LAB
            if (0UL != (error & CTF_ERROR_INTERNAL_MERGE_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_INTERNAL_MERGE
            if (0UL != (error & CTF_ERROR_TXQ_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_TXQ
            if (0UL != (error & CTF_ERROR_RB_OVERFLOW_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_RSV

        if (0UL != eccError)
            if (0UL != (eccError & CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_HB
            if (0UL != (eccError & CTF_ECC_ERROR_HB_CORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_HB
            if (0UL != (eccError & CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_LAB
            if (0UL != (eccError & CTF_ECC_ERROR_LAB_CORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_LAB
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_HWQ_1
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_HWQ_1
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_HWQ_0
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_HWQ_0
            if (0UL != (eccError & CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_NEXT_HOP
            if (0UL != (eccError & CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_NEXT_HOP
            if (0UL != (eccError & CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_NAPT_FLOW
            if (0UL != (eccError & CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_MASK))
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_NAPT_FLOW
    retVal = MCU_SwitchInterruptClear(MCU_SWITCHINTRFLAGS_CTF)
    if (BCM_ERR_OK != retVal)
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FAIRQHANDLER_PROC, retVal,
            0UL, 0UL, 0UL, 0UL)
    return
    @endcode
*/
void ETHSWT_FAIRQHandler(void)
{
    uint32_t status;
    uint32_t error;
    uint32_t eccError;
    uint32_t id;
    int32_t retVal;
    uint32_t unRsvdMask;

    /* Get interrupt statuses, disable and ack them */
    for (id = 0UL; id < CTF_MAX_HW_ID; id++) {
        /* interrupts which are enabled and active */
        status = ETHSWT_FARegs[id]->status & ETHSWT_FARegs[id]->status_mask;
        /* valid interrupts = ~CTF_STATUS_MASK_CTF_STATUS_MASK_RESERVED_MASK*/
        unRsvdMask = CTF_STATUS_MASK_CTF_STATUS_MASK_RESERVED_MASK ^ 0xFFFFFFFFUL;
        /* mask off active interrupts */
        ETHSWT_FARegs[id]->status_mask &= (status ^ unRsvdMask);
        /* acknowledge active interrupts */
        ETHSWT_FARegs[id]->status = status;

        error = ETHSWT_FARegs[id]->error & ETHSWT_FARegs[id]->error_mask;
        unRsvdMask = CTF_ERROR_MASK_RESERVED_MASK ^ 0xFFFFFFFFUL;
        ETHSWT_FARegs[id]->error_mask &= (error ^ unRsvdMask);
        ETHSWT_FARegs[id]->error = error;

        eccError = ETHSWT_FARegs[id]->ecc_error
                    & ETHSWT_FARegs[id]->ecc_error_mask;
        unRsvdMask = CTF_ECC_ERRO_MASK_CTF_ECC_ERROR_MASK_RESERVED_MASK ^ 0xFFFFFFFFUL;
        ETHSWT_FARegs[id]->ecc_error_mask &= (eccError ^ unRsvdMask);
        ETHSWT_FARegs[id]->ecc_error = eccError;


        /* Check if there is any bit active before checking individual bits */
        if (0UL != status) {
            /* Set IntrFlags by mapping individual bitfields */
            if (0UL != (status & CTF_STATUS_BRCM_HDR_EDIT_INVALID_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_EDIT_BH;
            }
            if (0UL != (status & CTF_STATUS_L3_IPV4_CHECKSUM_ERR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_IPV4_CHECKSUM;
            }
            if (0UL != (status & CTF_STATUS_L3_PARSING_INCOMPLETE_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_PARSE_L3;
            }
            if (0UL != (status & CTF_STATUS_L2_PARSING_INCOMPLETE_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_PARSE_L2;
            }
            if (0UL != (status & CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_PARSE_BH;
            }
        }

        if (0UL != error) {
            if (0UL != (error & CTF_ERROR_HWQ_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_HWQ;
            }
            if (0UL != (error & CTF_ERROR_HB_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_HB;
            }
            if (0UL != (error & CTF_ERROR_RXQ_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_RXQ;
            }
            if (0UL != (error & CTF_ERROR_SOP_EOP_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_SOP_EOP;
            }
            if (0UL != (error & CTF_ERROR_SPB_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_SPB;
            }
            if (0UL != (error & CTF_ERROR_LAB_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_LAB;
            }
            if (0UL != (error & CTF_ERROR_INTERNAL_MERGE_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_INTERNAL_MERGE;
            }
            if (0UL != (error & CTF_ERROR_TXQ_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_TXQ;
            }
            if (0UL != (error & CTF_ERROR_RB_OVERFLOW_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_OVERFLOW_RSV;
            }
        }

        if (0UL != eccError) {
            if (0UL != (eccError & CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_HB;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_HB_CORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_HB;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_LAB;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_LAB_CORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_LAB;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_HWQ_1;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_HWQ_1;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_HWQ_0;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_HWQ_0;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_NEXT_HOP;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_NEXT_HOP;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_UNCOR_NAPT_FLOW;
            }
            if (0UL != (eccError & CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_MASK)) {
                ETHSWT_FADrv[id].intrFlags |= ETHSWT_FAINTRFLAGS_COR_NAPT_FLOW;
            }
        }
    }

    /* Clear the interrupt latched in Switch */
    retVal = MCU_SwitchInterruptClear(MCU_SWITCHINTRFLAGS_CTF);
    if (BCM_ERR_OK != retVal) {
        ETHSWT_FADrvErr(BRCM_SWDSGN_ETHSWT_FAIRQHANDLER_PROC, retVal,
            0UL, 0UL, 0UL, 0UL);
    }

    return;
}

/** @brief Get MAC addresses

    This API will retrieve MAC addresses and their domain(internal/external)
    fields from the Pool Table

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aID               Instance identifier
    @param[out]   aPoolTableInfo    Pointer to retrieve Pool table information

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK           Successfully retrieved MAC addresses
    @retval   #BCM_ERR_INVAL_PARAMS aPoolTableInfo is NULL

    @post None

    @limitations None

    @code{.unparsed}
    if (NULL == aPoolTableInfo)
        retVal = BCM_ERR_INVAL_PARAMS
    else if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else
        BCM_MemCpy(aPoolTableInfo, &ETHSWT_FADrv[aID].pool,
                   sizeof(ETHSWT_FAPoolTableInfoType))
        retVal = BCM_ERR_OK
    return retVal
    @endcode

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
static int32_t ETHSWT_FADrvMacPoolGet(ETHSWT_FAIDType aID,
                        ETHSWT_FAPoolTableInfoType *const aPoolTableInfo)
{
    int32_t retVal;

    if (NULL == aPoolTableInfo) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else {
        BCM_MemCpy(aPoolTableInfo, &ETHSWT_FADrv[aID].pool,
                   sizeof(ETHSWT_FAPoolTableInfoType));
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @brief Enable Interrupts

    This API will enable interrupts

    @behavior Sync, Re-entrant

    @pre None

    @param[in]    aID               FA Hardware Instance Identifier
    @param[out]   aFlags            Flag mask of interrupts to be enabled

    Return values are documented in reverse-chronological order
    @retval   #BCM_ERR_OK           Successfully enabled interrupts
    @retval   #BCM_ERR_UNINIT       FA is uninitialised
    @retval   #BCM_ERR_NOPERM       No permission when CTF is in BYPASS Mode

    @post None

    @limitations None

    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    statusMask = 0UL
    errorMask = 0UL
    eccErrorMask = 0UL

    if (FALSE == ETHSWT_FADrv[aID].init)
        retVal = BCM_ERR_UNINIT
    else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode)
        retVal = BCM_ERR_NOPERM
    else
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_EDIT_BH))
            statusClearMask |= CTF_STATUS_BRCM_HDR_EDIT_INVALID_MASK
            statusMask |= CTF_STATUS_MASK_CSMBHEIIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_IPV4_CHECKSUM))
            statusClearMask |= CTF_STATUS_L3_IPV4_CHECKSUM_ERR_MASK
            statusMask |= CTF_STATUS_MASK_CSML3I4CEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_PARSE_L3))
            statusClearMask |= CTF_STATUS_L3_PARSING_INCOMPLETE_MASK
            statusMask |= CTF_STATUS_MASK_CSML3PIIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_PARSE_L2))
            statusClearMask |= CTF_STATUS_L2_PARSING_INCOMPLETE_MASK
            statusMask |= CTF_STATUS_MASK_CSML2PIIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_PARSE_BH))
            statusClearMask |= CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_MASK
            statusMask |= CTF_STATUS_MASK_CSMBHPIIE_MASK

        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_HWQ))
            errorClearMask |= CTF_ERROR_HWQ_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_HWQ_OVERFLOW_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_HB))
            errorClearMask |= CTF_ERROR_HB_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_HB_OVERFLOW_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_RXQ))
            errorClearMask |= CTF_ERROR_RXQ_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_RXQ_OVERFLOW_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_SOP_EOP))
            errorClearMask |= CTF_ERROR_SOP_EOP_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_SOP_EOP_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_SPB))
            errorClearMask |= CTF_ERROR_SPB_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_SPB_OVERFLOW_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_LAB))
            errorClearMask |= CTF_ERROR_LAB_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_LAB_OVERFLOW_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_INTERNAL_MERGE))
            errorClearMask |= CTF_ERROR_INTERNAL_MERGE_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_INTERNAL_MERGE_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_TXQ))
            errorClearMask |= CTF_ERROR_TXQ_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_TXQ_OVERFLOW_ENABLE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_RSV))
            errorClearMask |= CTF_ERROR_RB_OVERFLOW_ERROR_MASK
            errorMask |= CTF_ERROR_MASK_RB_OVERFLOW_ENABLE_MASK

        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_HB))
            eccErrorClearMask |= CTF_ECC_ERROR_HB_CORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMHCEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_HWQ_1))
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH1CEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_HWQ_0))
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH0CEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_LAB))
            eccErrorClearMask |= CTF_ECC_ERROR_LAB_CORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMLCEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_NAPT_FLOW))
            eccErrorClearMask |= CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNFCEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_NEXT_HOP))
            eccErrorClearMask |= CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNHCEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_HB))
            eccErrorClearMask |= CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMHUEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_HWQ_1))
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH1UEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_HWQ_0))
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH0UEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_LAB))
            eccErrorClearMask |= CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMLUEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_NAPT_FLOW))
            eccErrorClearMask |= CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNFUEIE_MASK
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_NEXT_HOP))
            eccErrorClearMask |= CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_MASK
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNHUEIE_MASK

        if (0UL != statusMask)
            ETHSWT_FARegs[aID]->status |= statusClearMask
            ETHSWT_FARegs[aID]->status_mask = ETHSWT_FARegs[aID]->status_mask OR statusMask
        if (0UL != errorMask)
            ETHSWT_FARegs[aID]->error |= errorClearMask
            ETHSWT_FARegs[aID]->error_mask = ETHSWT_FARegs[aID]->error_mask OR errorMask
        if (0UL != eccErrorMask)
            ETHSWT_FARegs[aID]->ecc_error |= eccErrorClearMask
            ETHSWT_FARegs[aID]->ecc_error_mask = ETHSWT_FARegs[aID]->ecc_error_mask OR eccErrorMask
        retVal = BCM_ERR_OK
    return retVal
    @encode

    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
*/
static int32_t ETHSWT_FADrvEnableInterrupt(ETHSWT_FAIDType aID,
                                           ETHSWT_FAIntrFlagsType aFlags)
{
    int32_t retVal;
    uint32_t statusMask = 0UL;
    uint32_t statusClearMask = 0UL;
    uint32_t errorMask = 0UL;
    uint32_t errorClearMask = 0UL;
    uint32_t eccErrorMask  = 0UL;
    uint32_t eccErrorClearMask  = 0UL;

    if (FALSE == ETHSWT_FADrv[aID].init) {
        retVal = BCM_ERR_UNINIT;
    } else if (ETHSWT_FACTFMODE_BYPASS == ETHSWT_FADrv[aID].mode) {
        retVal = BCM_ERR_NOPERM;
    } else {
        /* statusMask */
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_EDIT_BH)) {
            statusClearMask |= CTF_STATUS_BRCM_HDR_EDIT_INVALID_MASK;
            statusMask |= CTF_STATUS_MASK_CSMBHEIIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_IPV4_CHECKSUM)) {
            statusClearMask |= CTF_STATUS_L3_IPV4_CHECKSUM_ERR_MASK;
            statusMask |= CTF_STATUS_MASK_CSML3I4CEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_PARSE_L3)) {
            statusClearMask |= CTF_STATUS_L3_PARSING_INCOMPLETE_MASK;
            statusMask |= CTF_STATUS_MASK_CSML3PIIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_PARSE_L2)) {
            statusClearMask |= CTF_STATUS_L2_PARSING_INCOMPLETE_MASK;
            statusMask |= CTF_STATUS_MASK_CSML2PIIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_PARSE_BH)) {
            statusClearMask |= CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_MASK;
            statusMask |= CTF_STATUS_MASK_CSMBHPIIE_MASK;
        }

        /* errorMask */
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_HWQ)) {
            errorClearMask |= CTF_ERROR_HWQ_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_HWQ_OVERFLOW_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_HB)) {
            errorClearMask |= CTF_ERROR_HB_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_HB_OVERFLOW_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_RXQ)) {
            errorClearMask |= CTF_ERROR_RXQ_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_RXQ_OVERFLOW_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_SOP_EOP)) {
            errorClearMask |= CTF_ERROR_SOP_EOP_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_SOP_EOP_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_SPB)) {
            errorClearMask |= CTF_ERROR_SPB_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_SPB_OVERFLOW_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_LAB)) {
            errorClearMask |= CTF_ERROR_LAB_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_LAB_OVERFLOW_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_INTERNAL_MERGE)) {
            errorClearMask |= CTF_ERROR_INTERNAL_MERGE_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_INTERNAL_MERGE_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_TXQ)) {
            errorClearMask |= CTF_ERROR_TXQ_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_TXQ_OVERFLOW_ENABLE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_OVERFLOW_RSV)) {
            errorClearMask |= CTF_ERROR_RB_OVERFLOW_ERROR_MASK;
            errorMask |= CTF_ERROR_MASK_RB_OVERFLOW_ENABLE_MASK;
        }

        /* eccErrorMask */
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_HB)) {
            eccErrorClearMask |= CTF_ECC_ERROR_HB_CORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMHCEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_HWQ_1)) {
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH1CEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_HWQ_0)) {
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH0CEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_LAB)) {
            eccErrorClearMask |= CTF_ECC_ERROR_LAB_CORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMLCEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_NAPT_FLOW)) {
            eccErrorClearMask |= CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNFCEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_COR_NEXT_HOP)) {
            eccErrorClearMask |= CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNHCEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_HB)) {
            eccErrorClearMask |= CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMHUEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_HWQ_1)) {
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH1UEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_HWQ_0)) {
            eccErrorClearMask |= CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMH0UEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_LAB)) {
            eccErrorClearMask |= CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMLUEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_NAPT_FLOW)) {
            eccErrorClearMask |= CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNFUEIE_MASK;
        }
        if (0UL != (aFlags & ETHSWT_FAINTRFLAGS_UNCOR_NEXT_HOP)) {
            eccErrorClearMask |= CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_MASK;
            eccErrorMask |= CTF_ECC_ERRO_MASK_CEEMNHUEIE_MASK;
        }

        if (0UL != statusMask) {
            ETHSWT_FARegs[aID]->status |= statusClearMask;
            ETHSWT_FARegs[aID]->status_mask |= statusMask;
        }
        if (0UL != errorMask) {
            ETHSWT_FARegs[aID]->error |= errorClearMask;
            ETHSWT_FARegs[aID]->error_mask |= errorMask;
        }
        if (0UL != eccErrorMask) {
            ETHSWT_FARegs[aID]->ecc_error |= eccErrorClearMask;
            ETHSWT_FARegs[aID]->ecc_error_mask |= eccErrorMask;
        }
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FACMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER

    @code{.unparsed}
    if (SWITCH_MAX_HW_ID <= aSwtID) OR (NULL == aIO) OR (CTF_MAX_HW_ID <= aIO->id))
        retVal = BCM_ERR_INVAL_PARAMS
    else
        if aCmd is ETHSWT_IO_CMD_FA_INIT
            ETHSWT_FADrvInit(aIO->id, aIO->cfg)
            retVal = BCM_ERR_OK
        else if aCmd is ETHSWT_IO_CMD_FA_DEINIT
            ETHSWT_FADrvDeinit(aIO->id)
            retVal = BCM_ERR_OK
        else if aCmd is ETHSWT_IO_CMD_FA_FLOWADD
            retVal = ETHSWT_FADrvFlowAdd(aIO->id, aIO->flowIn, &aIO->flowID)
        else if aCmd is ETHSWT_IO_CMD_FA_FLOWDELETE
            retVal = ETHSWT_FADrvFlowDelete(aIO->id, aIO->flowID)
        else if aCmd is ETHSWT_IO_CMD_FA_FLOWGET
            retVal = ETHSWT_FADrvFlowGet(aIO->id, aIO->flowID, aIO->flowOut, aIO->flowStats)
        else if aCmd is ETHSWT_IO_CMD_FA_STATS
            retVal = ETHSWT_FADrvStats(aIO->id, aIO->faStats)
        else if aCmd is ETHSWT_IO_CMD_FA_TIMER
            retVal = ETHSWT_FADrvTimer(aIO->id)
        else if aCmd is ETHSWT_IO_CMD_FA_MAC_ADD
            retVal = ETHSWT_FAPoolEntryAdd(aIO->id, aIO->mac, aIO->external)
        else if aCmd is ETHSWT_IO_CMD_FA_MAC_DELETE
            retVal = ETHSWT_FAPoolEntryDelete(aIO->id, aIO->mac)
        else if aCmd is ETHSWT_IO_CMD_FA_MAC_POOL_GET
            retVal = ETHSWT_FADrvMacPoolGet(aIO->id, aIO->poolTableInfo)
        else if aCmd is ETHSWT_IO_CMD_FA_ENABLE_INTERRUPT
            retVal = ETHSWT_FADrvEnableInterrupt(aIO->id, aIO->intrFlags)
        else
            retVal = BCM_ERR_INVAL_PARAMS
    return retVal
    @endcode
*/
int32_t ETHSWT_FACmdHandler(ETHSWT_HwIDType aSwtID, ETHSWT_IOCmdType aCmd,
                            ETHSWT_FAIOType * const aIO)
{
    int32_t retVal;

    if ((SWITCH_MAX_HW_ID <= aSwtID) || (NULL == aIO)
            || (CTF_MAX_HW_ID <= aIO->id)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        switch (aCmd) {
        case ETHSWT_IO_CMD_FA_INIT:
            ETHSWT_FADrvInit(aIO->id, aIO->cfg);
            retVal = BCM_ERR_OK;
            break;
        case ETHSWT_IO_CMD_FA_DEINIT:
            ETHSWT_FADrvDeinit(aIO->id);
            retVal = BCM_ERR_OK;
            break;
        case ETHSWT_IO_CMD_FA_FLOWADD:
            retVal = ETHSWT_FADrvFlowAdd(aIO->id, aIO->flowIn, &aIO->flowID);
            break;
        case ETHSWT_IO_CMD_FA_FLOWDELETE:
            retVal = ETHSWT_FADrvFlowDelete(aIO->id, aIO->flowID);
            break;
        case ETHSWT_IO_CMD_FA_FLOWGET:
            retVal = ETHSWT_FADrvFlowGet(aIO->id, aIO->flowID, aIO->flowOut, aIO->flowStats);
            break;
        case ETHSWT_IO_CMD_FA_STATS:
            retVal = ETHSWT_FADrvStats(aIO->id, aIO->faStats, aIO->flowStatus);
            break;
        case ETHSWT_IO_CMD_FA_TIMER:
            retVal = ETHSWT_FADrvTimer(aIO->id);
            break;
        case ETHSWT_IO_CMD_FA_MAC_ADD:
            retVal = ETHSWT_FAPoolEntryAdd(aIO->id, aIO->mac, aIO->external);
            break;
        case ETHSWT_IO_CMD_FA_MAC_DELETE:
            retVal = ETHSWT_FAPoolEntryDelete(aIO->id, aIO->mac);
            break;
        case ETHSWT_IO_CMD_FA_MAC_POOL_GET:
            retVal = ETHSWT_FADrvMacPoolGet(aIO->id, aIO->poolTableInfo);
            break;
        case ETHSWT_IO_CMD_FA_ENABLE_INTERRUPT:
            retVal = ETHSWT_FADrvEnableInterrupt(aIO->id, aIO->intrFlags);
            break;
        default:
            retVal = BCM_ERR_INVAL_PARAMS;
            break;
        }
    }

    return retVal;
}

/** @} */
