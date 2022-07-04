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
    @defgroup grp_nif_cntrlr_cntrlr_osil_ifc Ethernet NIF controller Module OSIL Interface
    @ingroup grp_nif

    @addtogroup grp_nif_cntrlr_cntrlr_osil_ifc
    @{

    @file nif_cntrlr_osil.h

    @brief Ethernet NIF controller module OSIL Interface

    @version 0.1 Initial version
*/

#ifndef NIF_CNTRLR_OSIL_H
#define NIF_CNTRLR_OSIL_H

/**
    @name Ethernet NIF Module IDs for OSIL
    @{
    @brief Architecture API IDs for Ethernet cntrlr module OSIL
*/
#define BRCM_SWARCH_NIF_CNTRLREVENT_TYPE          (0x9401U)    /**< @brief #NIF_CntrlrEventType */
#define BRCM_SWARCH_NIF_CNTRLREVENTINFO_GLOBAL    (0x9402U)    /**< @brief #NIF_CntrlrEventInfo */
/** @} */

/**
    @name Ether NIF module event cntrlr structure

    @trace #BRCM_SWREQ_NIF_CNTRLR
*/
typedef struct sNIF_CntrlrEventType {
    uint32_t packetRx;      /**< @brief Event for Ethernet bottomhalf processing */
    uint32_t etherTimer;    /**< @brief Event for NIF bottomhalf processing */
    uint32_t mdioComplete;  /**< @brief Event for MDIO processing complete */
} NIF_CntrlrEventType;

/**
    @brief Event structure object of ETHER NIF cntrlr

    @trace #BRCM_SWREQ_NIF_CNTRLR
*/
extern const NIF_CntrlrEventType NIF_CntrlrEventInfo;

#endif /* NIF_CNTRLR_OSIL_H */
/** @} */
