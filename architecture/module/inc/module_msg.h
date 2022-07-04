/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_architecture_msg Message
    @ingroup grp_abstract

    @addtogroup grp_architecture_msg
    @{

    @file bcm_msg.h
    @brief Messages Interface

    @version 0.1 Initial version
*/

#ifndef MODULE_MSG_H
#define MODULE_MSG_H

#include <inttypes.h>
#include <bcm_err.h>
#include <bcm_comp.h>

/**
    @name Architecture IDs
    @{
    @brief Architecture IDs
*/
#define BRCM_SWARCH_MODULE_MSG_MAX_STR_LENGTH_MACRO     (0x8401U)   /**< @brief #MODULE_MSG_MAX_STR_LENGTH   */
#define BRCM_SWARCH_MODULE_MAXMAC_TYPE                  (0x8402U)   /**< @brief #MODULE_MaxMacType           */
#define BRCM_SWARCH_MODULE_MSGPROCESS_TYPE              (0x8403U)   /**< @brief #MODULE_MsgProcessType       */
#define BRCM_SWARCH_MODULE_MSGCONTEXT_TYPE              (0x8404U)   /**< @brief #MODULE_MsgContextType       */
#define BRCM_SWARCH_MODULE_MSGCONVERTER_TYPE            (0x8405U)   /**< @brief #MODULE_MsgConverterType     */
#define BRCM_SWARCH_MODULE_MSGSPLITSTRING_PROC          (0x8406U)   /**< @brief #MODULE_MsgSplitString       */
#define BRCM_SWARCH_MODULE_MSGPARSEINT_PROC             (0x8407U)   /**< @brief #MODULE_MsgParseInt          */
#define BRCM_SWARCH_MODULE_BUFFERFROMFILE_PROC          (0x8408U)   /**< @brief #MODULE_BufferFromFile       */
#define BRCM_SWARCH_MODULE_HOSTHELPERLOG_PROC           (0x8409U)   /**< @brief #MODULE_HostHelperLog        */
#define BRCM_SWARCH_MODULE_CONVERT_STR_TO_MAC_PROC      (0x840AU)   /**< @brief #MODULE_ConvertStrToMac      */
#define BRCM_SWARCH_MODULE_MSGPRINT_TYPE                (0x840BU)   /**< @brief #MODULE_MsgPrintType         */
#define BRCM_SWARCH_MODULE_MSGPARSELONGINT_PROC         (0x840CU)   /**< @brief #MODULE_MsgParseLongInt      */
/** @} */

/**
    @brief Maximum number of string

    @trace #BRCM_SWREQ_MODULE
*/
#define MODULE_MSG_MAX_STR_LENGTH  (512U)

/**
    @brief Maximum Max MAC Length

    @trace #BRCM_SWREQ_MODULE
*/
typedef uint8_t MODULE_MaxMacType;
#define MODULE_MAXMAC_OCTECTS        (6U)
#define MODULE_MAXMAC_STRINGLENGTH   (17U)

/** @brief Process a message string or response byte array

    This API handles:
    -# Input message string and generates a byte array
    -# Processes input response and generates a byte array in case of any follow up commands
    -# Processes input response and generates a string array that caller can output to console
       This is only when the original message is fully processed

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsgId              Message ID (group, comp, cmd)
    @param[inout]   aCmdStr             Input String to process
    @param[inOut]   aStrLen             Length of input string
                                        Lenght of the output buffer
    @param[inout]   aInOut              input/output buffer for the the command
                                        input/output buffer for the response
    @param[in]      aInputLen           Length of input message data buffer.
                                        Valid for the response message
                                        For a command it is '0'
                                        If Substate is RESET then this will be '0'
    @param[out]     aOutLen             Ouput length of command/string
                                        This bufffer shall always be of 4 KB in size.
                                        Generated commands will be < 512 bytes, but the 4KB
                                        buffer will be fully used when interpreting the
                                        response and composing strings for display
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Message processed successfully.
                                        Output pointed by #aOut is a string when the
                                        #aSubState is #BCM_STATE_SUB_STATE_RESET.
                                        Output pointed by #aOut is a byte array when the
                                        #aSubState is NOT #BCM_STATE_SUB_STATE_RESET, in
                                        which case generated byte array needs to be sent to
                                        target and this API should be invoked when
                                        the response is received.
    @retval     #BCM_ERR_NOSUPPORT      Message not supported
    @retval     #BCM_ERR_UNKNOWN        Unknown Failure/Integration fault
    @retval     #BCM_ERR_INVAL_PARAMS   aSubState is NULL
                                        aMsg is NULL
                                        aInput is NULL or aInputLen is zero
                                        aOut/aOutLen is NULL or aOutLen < 4KB
                                        aQueue/aResponse is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_MsgProcessType)(BCM_CmdType  *aMsgId,
                                      char            *aCmdStr,
                                      uint32_t        *aStrLen,
                                      uint8_t         *aInOut,
                                      uint32_t         aInputLen,
                                      uint32_t        *aOutLen,
                                      uint32_t         aMaxLength,
                                      int32_t          aResponse);

/** @brief Split the string

    Split the string to nearest space and return the remaining string

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aInStr            Input String to process
    @param[in]      aInStrLen         Length of input string
    @param[out]     aOutStr           Remaining string after split
    @param[out]     aOutLen           Remaining string Length after split

    Return values are documented in reverse-chronological order
    @retval None

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
extern void MODULE_MsgSplitString(char * const aInStr, uint32_t aInStrLen,
                          char **aOutStr, uint32_t * const aOutLen);

/** @brief Parse the integer from string

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStr           String to process
    @param[out]     status         Status of the parse

    Return values are documented in reverse-chronological order
    @retval   Parsed integer

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
extern int32_t MODULE_MsgParseInt(const char *aStr, int32_t *status);

/** @brief Parse the long integer from string

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStr           String to process
    @param[out]     status         Status of the parse

    Return values are documented in reverse-chronological order
    @retval   Parsed 64 bit long integer

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
extern int64_t MODULE_MsgParseLongInt(const char *aStr, int32_t *status);

/**
    @brief NVM Supported commands

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aName                File Name to read
    @param[in]      aMaxSz               Maximum data size allowed
    @param[out]     aBuff                Buffer ptr to copy from file
    @param[out]     aLen                 Actuval data length of the file

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Data copied to #aBuff buffer successfully
    @retval     #BCM_ERR_INVAL_PARAMS    aName is NULL OR Invalid File Name OR
                                         aMaxSz is 0 OR
                                         aBuff is NULL OR
                                         aLen is NULL OR
                                         File reading error

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
extern int32_t MODULE_BufferFromFile(char *aName, uint32_t aMaxSz, uint8_t *aBuff, uint32_t *aLen);

/**
    @brief Print the Message on consile

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStr              String to print

    Return values are documented in reverse-chronological order
    @retval     On success retuns total number of characters written
    @retval     On Failure returns negative number

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
extern int32_t MODULE_HostHelperLog(const char *aStr, ...);

/**
    @brief Convert the MAC string to MAC Hex Value

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]         aMacStr             Mac address string
    @param[out]        aMacHex             Mac address string

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Data copied to #aBuff buffer successfully
    @retval     #BCM_ERR_INVAL_PARAMS    aName is NULL OR Invalid File Name OR
                                         aMaxSz is 0 OR
                                         aBuff is NULL OR
                                         aLen is NULL OR
                                         File reading error

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
extern int32_t MODULE_ConvertStrToMac(char *aMacStr, unsigned char *aMacHex);

/**
    @brief Print the response

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]     aCmd       Command ID
    @param[in]     aMsg       Message Pointer
    @param[in]     aSize      Message size

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Notification processed successfully
    @retval     #BCM_ERR_INVAL_PARAMS    aMsg is NULL

    @post None

    @limitations None

    @trace #BRCM_SWREQ_MODULE
*/
typedef int32_t (*MODULE_MsgPrintType)(BCM_CmdType aCmd,
                                        uint8_t *aMsg, uint32_t aSize);

/** @brief Context structure for helpers

    @trace #BRCM_SWREQ_MODULE
*/
typedef struct sMODULE_MsgContextType {
    BCM_SubStateType  substate;                 /**< @brief Sub state of the current process */
    uint32_t          val;                      /**< @brief Context values defined
                                                        and used by helper module */
} MODULE_MsgContextType;

/**
    @trace #BRCM_SWREQ_MODULE
*/
typedef struct sMODULE_MsgConverterType {
    const char *helpstr;               /**< @brief Prefix String        */
    BCM_GroupIDType groupId;           /**< @brief Group ID             */
    BCM_CompIDType  compId;            /**< @brief Component ID         */
    MODULE_MsgContextType  *context;   /**< @brief Context memory       */
    MODULE_MsgProcessType  process;    /**< @brief Process msg/response */
    MODULE_MsgPrintType    print;      /**< @brief Print response       */
} MODULE_MsgConverterType;
#endif /* MODULE_MSG_H */
/** @} */
