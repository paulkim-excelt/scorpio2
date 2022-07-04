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

/**
    @addtogroup grp_ethutils
    @{

    @file ethutils.h
    @brief Ethernet service Utilities Interface

    @version 0.1 Initial version
*/

#ifndef ETHUTILS_H
#define ETHUTILS_H

#include <bcm_err.h>
#include <mcu.h>

/**
    @name Eth Utils utils IDs
    @{
    @brief Architecture API IDs for Eth Utils
*/
#define BRCM_SWARCH_ETHUTILS_INVALID_PORT_MACRO               (0x8101U)    /**< @brief #ETHUTILS_INVALID_PORT             */
#define BRCM_SWARCH_ETHUTILS_MAX_PORTS_MACRO                  (0x8102U)    /**< @brief #ETHUTILS_MAX_PORTS                */
#define BRCM_SWARCH_ETHUTILS_INIT_PROC                        (0x8103U)    /**< @brief #ETHUTILS_Init                     */
#define BRCM_SWARCH_ETHUTILS_CONVERTTOLOCALPORT_PROC          (0x8104U)    /**< @brief #ETHUTILS_ConvertToLocalPort       */
#define BRCM_SWARCH_ETHUTILS_CONVERTTOUNIFIEDPORT_PROC        (0x8105U)    /**< @brief #ETHUTILS_ConvertToUnifiedPort     */
#define BRCM_SWARCH_ETHUTILS_CONVERTTOUNIFIEDPORTMASK_PROC    (0x8106U)    /**< @brief #ETHUTILS_ConvertToUnifiedPortMask */
#define BRCM_SWARCH_ETHUTILS_CONVERTTOLOCALPORTMASK_PROC      (0x8107U)    /**< @brief #ETHUTILS_ConvertToLocalPortMask   */
#define BRCM_SWARCH_ETHUTILS_FILEDEF_TYPE                     (0x8108U)    /**< @brief #ETHUTILS_FILEDEFType              */
#define BRCM_SWARCH_ETHUTILS_MAX_FILENAME_LEN_MACRO           (0x8109U)    /**< @brief #ETHUTILS_MAX_FILENAME_LEN         */
#define BRCM_SWARCH_ETHUTILS_CREATEBOOTFILENAME_PROC          (0x810AU)    /**< @brief #ETHUTILS_CreateBootFilename       */

/** @} */

/**
    @name Definitions used for parsing and construction of the filename

    bcm-manuf(8)-model(8)-rev(8)-istbl(2)pid(2)imgID(4)-offset(8)-size(8).bin

    @{
    @trace #BRCM_SWREQ_ETHUTILS
*/
typedef uint32_t ETHUTILS_FILEDEFType;
#define ETHUTILS_FILEDEF_MANUF_START    (4UL)                                                           /**< @brief Start of Manuf field         */
#define ETHUTILS_FILEDEF_MANUF_END      (11UL)                                                          /**< @brief End of Manuf field           */
#define ETHUTILS_FILEDEF_MANUF_LEN      (ETHUTILS_FILEDEF_MANUF_END-ETHUTILS_FILEDEF_MANUF_START+1UL)   /**< @brief Length of Manuf field        */
#define ETHUTILS_FILEDEF_MODEL_START    (13UL)                                                          /**< @brief Start of Model field         */
#define ETHUTILS_FILEDEF_MODEL_END      (20UL)                                                          /**< @brief End of Model field           */
#define ETHUTILS_FILEDEF_MODEL_LEN      (ETHUTILS_FILEDEF_MODEL_END-ETHUTILS_FILEDEF_MODEL_START+1UL)   /**< @brief Length of Model field        */
#define ETHUTILS_FILEDEF_REV_START      (22UL)                                                          /**< @brief Start of revision field      */
#define ETHUTILS_FILEDEF_REV_END        (29UL)                                                          /**< @brief End of revision field        */
#define ETHUTILS_FILEDEF_REV_LEN        (ETHUTILS_FILEDEF_REV_END-ETHUTILS_FILEDEF_REV_START+1UL)       /**< @brief Length of revision field     */
#define ETHUTILS_FILEDEF_ISTBL_START    (31UL)                                                          /**< @brief Start of 'is table' field    */
#define ETHUTILS_FILEDEF_ISTBL_END      (32UL)                                                          /**< @brief End of 'is table' field      */
#define ETHUTILS_FILEDEF_ISTBL_LEN      (ETHUTILS_FILEDEF_ISTBL_END-ETHUTILS_FILEDEF_ISTBL_START+1UL)   /**< @brief Length of 'is table' field   */
#define ETHUTILS_FILEDEF_PID_START      (33UL)                                                          /**< @brief Start of PID field           */
#define ETHUTILS_FILEDEF_PID_END        (34UL)                                                          /**< @brief End of PID field             */
#define ETHUTILS_FILEDEF_PID_LEN        (ETHUTILS_FILEDEF_PID_END-ETHUTILS_FILEDEF_PID_START+1UL)       /**< @brief Length of PID field          */
#define ETHUTILS_FILEDEF_IMGID_START    (35UL)                                                          /**< @brief Start of IMG ID field        */
#define ETHUTILS_FILEDEF_IMGID_END      (38UL)                                                          /**< @brief End of IMG ID field          */
#define ETHUTILS_FILEDEF_IMGID_LEN      (ETHUTILS_FILEDEF_IMGID_END-ETHUTILS_FILEDEF_IMGID_START+1UL)   /**< @brief Length of IMG ID field       */
#define ETHUTILS_FILEDEF_OFFSET_START   (40UL)                                                          /**< @brief Start of offset field        */
#define ETHUTILS_FILEDEF_OFFSET_END     (47UL)                                                          /**< @brief End of offset field          */
#define ETHUTILS_FILEDEF_OFFSET_LEN     (ETHUTILS_FILEDEF_OFFSET_END-ETHUTILS_FILEDEF_OFFSET_START+1UL) /**< @brief Length of offset field       */
#define ETHUTILS_FILEDEF_SIZE_START     (49UL)                                                          /**< @brief Start of size field          */
#define ETHUTILS_FILEDEF_SIZE_END       (56UL)                                                          /**< @brief End of size field            */
#define ETHUTILS_FILEDEF_SIZE_LEN       (ETHUTILS_FILEDEF_SIZE_END-ETHUTILS_FILEDEF_SIZE_START+1UL)     /**< @brief Length of size field         */
#define ETHUTILS_FILEDEF_BASE_HEX       (16UL)                                                          /**< @brief Base for hexadecimal         */
#define ETHUTILS_FILEDEF_BASE_DEC       (10UL)                                                          /**< @brief Base for decimal             */
/** @} */

/**
    @brief Max file name length
    @trace #BRCM_SWREQ_ETHUTILS
*/
#define ETHUTILS_MAX_FILENAME_LEN    (64U)

/**
    @brief Invalid port number
    @trace #BRCM_SWREQ_ETHUTILS
*/
#define ETHUTILS_INVALID_PORT     (0xFFFFFFFFUL)

/**
    @brief Maximum ports
    @trace #BRCM_SWREQ_ETHUTILS
*/
#define ETHUTILS_MAX_PORTS        (16UL)

/** @brief Ethsrv utilities initialization

    This initializes the Eth Utils library

    @behavior Sync, Reentrant

    @trace #BRCM_SWREQ_ETHUTILS
*/
void ETHUTILS_Init(void);

/** @brief Convert input port number to local port number

    This converts the input port number to local port number

    @behavior Sync, Reentrant

    @param[in]       aPort                  Input unified port number
    @param[out]      aIsStackingPort        Local port is the stacking port

    @retval          #ETHUTILS_INVALID_PORT    aPort is invalid
    @retval          Local port number

    @trace #BRCM_SWREQ_ETHUTILS
*/
uint32_t ETHUTILS_ConvertToLocalPort(uint32_t aPort,
                                     uint32_t *const aIsStackingPort);

/** @brief Convert input port number to unified port number

    This converts the input port number to unified port number

    @behavior Sync, Reentrant

    @param[in]       aPort               Input local port number
    @param[out]      aIsStackingPort     Input port is a stacking port

    @retval          #ETHUTILS_INVALID_PORT aPort is invalid
    @retval          Unified port number

    @trace #BRCM_SWREQ_ETHUTILS
*/
uint32_t ETHUTILS_ConvertToUnifiedPort(uint32_t aPort,
                                       uint32_t *const aIsStackingPort);

/** @brief Convert input port mask to unified port mask

    This converts the input port mask to unified port mask

    @behavior Sync, Reentrant

    @param[in]       aPortMask           Local port mask

    @retval          #ETHUTILS_INVALID_PORT aPortMask is invalid
    @retval          Unified port bit mask

    @trace #BRCM_SWREQ_ETHUTILS
*/
uint16_t ETHUTILS_ConvertToUnifiedPortMask(uint16_t const aPortMask);

/** @brief Convert input unified port mask to local port mask

    This converts the input unified port mask to local port mask

    @behavior Sync, Reentrant

    @param[in]  aPortMask              Unified port mask
    @param[out] aIsStackingPortPresent TRUE: aPortMask has port bitmasks in
                                             other devices
                                       FALSE: aPortMask doesn't have port
                                              bitmasks in other devices

    @retval          #ETHUTILS_INVALID_PORT aPortMask is invalid
    @retval          Local port bit mask

    @trace #BRCM_SWREQ_ETHUTILS
*/
uint16_t ETHUTILS_ConvertToLocalPortMask(uint16_t aInputMask);

/** @brief Create boot file name to be used as hintfile in dhcp config

    @behavior Sync, Reentrant

    @param[out] aBuf        File name
    @param[in]  aImgID      Image ID
    @param[in]  aPID        PID
    @param[in]  aOffset     Offset
    @param[in]  aTotalSize  Total Size of file
    @param[in]  aIsImgTbl   IsImgTbl

    @retval          NA

    @trace #BRCM_SWREQ_ETHUTILS
*/
void ETHUTILS_CreateBootFilename(uint8_t *const aBuf,
                                       const uint16_t aImgID,
                                       const uint8_t  aPID,
                                       const uint32_t aOffset,
                                       const uint32_t aTotalSize,
                                       const uint32_t aIsImgTbl);

#endif /* ETHUTILS_H */
/** @} */
