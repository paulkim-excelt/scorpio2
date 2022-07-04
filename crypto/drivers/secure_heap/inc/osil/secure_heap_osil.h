/*****************************************************************************
 Copyright 2019-2020 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_secureheap_il Integration Guide
    @ingroup grp_secureheap

    @addtogroup grp_secureheap_il
    @{

    @file secure_heap_osil.h
    @brief Secure heap driver Integration Interfaces
    This header file contains the integration interface for the secure heap driver
    @version 0.10 Initial version
*/

#ifndef SECURE_HEAP_OSIL_H
#define SECURE_HEAP_OSIL_H

#include <svc.h>
#include <bcm_err.h>

/**
    @name Secure heap driver interface IDs
    @{
    @brief Interface IDs for the secure heap driver
*/
#define BRCM_SWARCH_SECHEAP_CMD_TYPE               (0x9101U)    /**< @brief #SECHEAP_CmdType          */
#define BRCM_SWARCH_SECHEAP_IN_CMDALLOC_TYPE       (0x9102U)    /**< @brief #SECHEAP_InCmdAllocType   */
#define BRCM_SWARCH_SECHEAP_OUT_CMDALLOC_TYPE      (0x9103U)    /**< @brief #SECHEAP_OutCmdAllocType  */
#define BRCM_SWARCH_SECHEAP_IN_CMDFREE_TYPE        (0x9104U)    /**< @brief #SECHEAP_InCmdFreeType    */
#define BRCM_SWARCH_SECHEAP_IN_CMDCREATE_TYPE      (0x9105U)    /**< @brief #SECHEAP_InCmdCreateType  */
#define BRCM_SWARCH_SECHEAP_OUT_CMDCREATE_TYPE     (0x9106U)    /**< @brief #SECHEAP_OutCmdCreateType */
#define BRCM_SWARCH_SECHEAP_IN_CMDMEMCMP_TYPE      (0x9107U)    /**< @brief #SECHEAP_InCmdMemcmpType  */
#define BRCM_SWARCH_SECHEAP_IN_IOPARAMS_TYPE       (0x9108U)    /**< @brief #SECHEAP_InIOParamsType   */
#define BRCM_SWARCH_SECHEAP_OUT_IOPARAMS_TYPE      (0x9109U)    /**< @brief #SECHEAP_OutIOParamsType  */
#define BRCM_SWARCH_SECHEAP_IO_TYPE                (0x910AU)    /**< @brief #SECHEAP_IOType           */
#define BRCM_SWARCH_SECHEAP_SVC_IO_TYPE            (0x910BU)    /**< @brief #SECHEAP_SVCIOType        */
#define BRCM_SWARCH_SECHEAP_SYSCMD_REQ_PROC        (0x910CU)    /**< @brief #SECHEAP_SysCmdReq        */
#define BRCM_SWARCH_SECHEAP_SYSCMD_HANDLER_PROC    (0x910DU)    /**< @brief #SECHEAP_SysCmdHandler    */
/** @} */

/**
    @name SECHEAP_CmdType
    @{
    @brief Secure heap command type

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef uint32_t SECHEAP_CmdType;                           /**< @brief Secheap command type                    */
#define SECHEAP_CMD_ALLOC                           (0x0UL) /**< @brief Secheap command for memory allocation   */
#define SECHEAP_CMD_FREE                            (0x1UL) /**< @brief Secheap command for memory deallocation */
#define SECHEAP_CMD_CREATE                          (0x2UL) /**< @brief Secheap command for memory allocation and initialization    */
#define SECHEAP_CMD_MEMCMP                          (0x03U) /**< @brief Secheap command to execute a memcmp operation   */
/** @} */

/**
    @brief Input parametres to process the secure heap allocate command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_InCmdAllocType {
    uint32_t allocSize;                     /**< @brief Size to allocate    */
    uint32_t allocFlags;                    /**< @brief Allocation flags    */
} SECHEAP_InCmdAllocType;

/**
    @brief Results generated by the secure heap allocate command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_OutCmdAllocType {
    uint32_t allocHdl;                      /**< @brief Secure heap allocatin handle    */
} SECHEAP_OutCmdAllocType;

/**
    @brief Input parametres to process the secure heap free command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_InCmdFreeType {
    uint32_t allocHdl;                      /**< @brief Secure heap allocatin handle to free    */
} SECHEAP_InCmdFreeType;

/**
    @brief Input parametres to process the secure heap create command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_InCmdCreateType {
    uint32_t allocSize;                     /**< @brief Size to allocate                            */
    uint32_t allocFlags;                    /**< @brief Allocation flags                            */
    const uint8_t *allocContent;            /**< @brief Content to be filled into the allocation    */
} SECHEAP_InCmdCreateType;

/**
    @brief Results generated by the secure heap create command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_OutCmdCreateType {
    uint32_t allocHdl;                          /**< @brief Secure heap allocatin handle    */
} SECHEAP_OutCmdCreateType;

/**
    @brief Input parametres to process the secure heap memcmp command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_InCmdMemcmpType {
    const uint8_t *mem;                     /**< @brief User supplied pointer to the memory chunk   */
    uint32_t memSize;                       /**< @brief Memcmp size                                 */
    uint32_t allocHdl;                      /**< @brief Secure heap handle to run memcmp against    */
} SECHEAP_InCmdMemcmpType;

/**
    @brief Input parametres to execute a reuested command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef union uSECHEAP_InIOParamsType {
    SECHEAP_InCmdAllocType cmdAlloc;        /**< @brief Command input data to perform an allocation         */
    SECHEAP_InCmdFreeType cmdFree;          /**< @brief Command input data to perform a free                */
    SECHEAP_InCmdCreateType cmdCreate;      /**< @brief Command input data to perform an allocation and initialization  */
    SECHEAP_InCmdMemcmpType cmdMemcmp;      /**< @brief Command input data to execute a memcmp operation    */
} SECHEAP_InIOParamsType;

/**
    @brief Results generated by executing the requested command

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef union uSECHEAP_OutIOParamsType {
    SECHEAP_OutCmdAllocType cmdAlloc;       /**< @brief Response to an allocation command   */
    SECHEAP_OutCmdCreateType cmdCreate;     /**< @brief Response to a create command        */
} SECHEAP_OutIOParamsType;

/**
    @brief Secure heap IO structure

    Data structure for the secure heap SVC interface

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef struct sSECHEAP_IOType {
    int32_t retVal;                         /**< @brief SVC response                            */
    SECHEAP_InIOParamsType inParams;        /**< @brief Data consumed by the command handler    */
    SECHEAP_OutIOParamsType outParams;      /**< @brief Data output by the command handler      */
} SECHEAP_IOType;

/**
    @brief SECHEAP_IOType typecast helper

    @trace #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE
*/
typedef union uSECHEAP_SVCIOType {
    uint8_t *data;
    SECHEAP_IOType *io;
} SECHEAP_SVCIOType;

/** @brief Secure heap system command request

    Interface for secure heap allocation/free command request.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCmd        Allocation/free command
    @param[inout]   aIO         Pointer to Timer IO

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Timer command operation success
    @retval     #BCM_ERR_INVAL_MAGIC    Invalid magic number
    @retval     Others                  Error values specific to the command
                                        raised
    @retval     #BCM_ERR_INVAL_PARAMS   aIO is NULL

    @post None

    @note This interface shall be implemented by the integrator.

    @trace  #BRCM_SWREQ_SECHEAP_KERNEL_INTERFACE

    @limitations None
*/
extern int32_t SECHEAP_SysCmdReq(SECHEAP_CmdType aCmd, SECHEAP_IOType *const aIO);


/** @brief Secure heap system command handler

    This interface handles all the secure heap commands requested from
    #SysCmdReq.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aMagicID    Magic ID for Timer
    @param[in]      aCmd        System command request
    @param[inout]   aSysIO      Pointer to system request IO

    @return     void

    @post None

    @note This interface shall be implemented by the integrator and shall hook
    it to SVC layer.

    @trace  #BRCM_SWREQ_SECHEAP_KERNEL_HANDLER
*/
extern void SECHEAP_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t *aSysIO);

#endif
/** @} */
