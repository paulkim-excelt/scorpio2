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
    @defgroup grp_architecture_msg_impl Helper Implementation
    @ingroup grp_abstract

    @addtogroup grp_architecture_msg_impl
    @{

    @file module_msg_helper.c
    @brief Message Helper Implementation

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <stddef.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <bcm_err.h>
#include <module_msg.h>

/**
    @name Module helper Design IDs
    @{
    @brief Design IDs for Module Helper
*/
#define BRCM_SWDSGN_MODULE_HOSTHELPERLOG_PROC         (0xB501U)    /**< @brief #MODULE_HostHelperLog   */
#define BRCM_SWDSGN_MODULE_MSGSPLITSTRING_PROC        (0xB502U)    /**< @brief #MODULE_MsgSplitString  */
#define BRCM_SWDSGN_MODULE_MSGPARSEINT_PROC           (0xB503U)    /**< @brief #MODULE_MsgParseInt     */
#define BRCM_SWDSGN_MODULE_BUFFERFROMFILE_PROC        (0xB504U)    /**< @brief #MODULE_BufferFromFile  */
#define BRCM_SWDSGN_MODULE_CONVERT_STR_TO_MAC_PROC    (0xB505U)    /**< @brief #MODULE_ConvertStrToMac */
#define BRCM_SWDSGN_MODULE_MSGPARSELONGINT_PROC       (0xB506U)    /**< @brief #MODULE_MsgParseLongInt */
/** @} */

/** @brief Print the Message on consile

    @code{.unparsed}
    @trace #BRCM_SWARCH_MODULE_MSGSPLITSTRING_PROC
    @trace #BRCM_SWREQ_MODULE
    @endcode
*/
int32_t MODULE_HostHelperLog(const char *aStr, ...)
{
    int32_t retVal;
    va_list args;

    va_start(args, aStr);
    retVal = vprintf(aStr, args);
    va_end(args);

    fflush(stdout);

    return retVal;
}

/** @brief Split the string

    @code{.unparsed}
    @trace #BRCM_SWARCH_MODULE_MSGSPLITSTRING_PROC
    @trace #BRCM_SWREQ_MODULE
    @endcode
*/
void MODULE_MsgSplitString(char * const aInStr, uint32_t aInStrLen,
                          char **aOutStr, uint32_t * const aOutLen)
{
    uint32_t i = 0UL;

    while ((i < aInStrLen)
            && ('\0' != aInStr[i])
            && (' ' != aInStr[i])
            && ('\r' != aInStr[i])) {
        ++i;
    }

    if (' ' == aInStr[i]) {
        aOutStr[0UL] = &aInStr[i + 1UL];
        aOutLen[0UL] = aInStrLen - (i + 1UL);
        /*don't modify the original string */
        aInStr[i] = '\0';
    } else {
        /* Empty argument string */
        aOutStr[0UL] = NULL;
        aOutLen[0UL] = 0UL;
    }
}

/** @brief Parse integer from string

    @code{.unparsed}
    @trace #BRCM_SWARCH_MODULE_MSGPARSEINT_PROC
    @trace #BRCM_SWREQ_MODULE
    @endcode
*/
int32_t MODULE_MsgParseInt(const char *aStr, int32_t *aStatus)
{
    uint32_t  n;
    int8_t   *ch;
    uint32_t  neg;
    uint32_t  base = 10;
    int32_t retVal = BCM_ERR_OK;

    *aStatus = BCM_ERR_OK;
    aStr += (neg = (*aStr == '-'));
    if ((*aStr == '0') && ((*(aStr+1) == 'x') || (*(aStr+1) == 'X'))) {
        if (neg) {
            *aStatus = BCM_ERR_INVAL_PARAMS;
            retVal = -1;
            goto err;
        }
        else {
            base = 16;
            aStr = (aStr + 2);
        }
    }

    ch = (int8_t *) aStr;
    if (*ch == '\0') {
        *aStatus = BCM_ERR_INVAL_PARAMS;
        retVal = -1;
        goto err;
    }

    if (base == 10) {
        while ((*ch != '\0')
                && (*ch != ' ')){
            if (*ch < '0' || *ch > '9') {
                *aStatus = BCM_ERR_INVAL_PARAMS;
                retVal = -1;
                goto err;
            }
            ch++;
        }
    } else if (base == 16) {
        while ((*ch !='\0')
                && (*ch != ' ')){
            if ((*ch >= '0' && *ch <= '9') || (*ch >= 'A' && *ch <= 'F') || (*ch >= 'a' && *ch <= 'f')){
                ch++;
                continue;
            }
            else {
                *aStatus = BCM_ERR_INVAL_PARAMS;
                retVal = -1;
                goto err;
            }
        }
    }

    for (n = 0; ((*aStr >= 'a' && *aStr <= 'f' && base > 10) ||
                (*aStr >= 'A' && *aStr <= 'F' && base > 10) ||
                (*aStr >= '0' && *aStr <= '9')); aStr++) {
        n = n * base +
            ((*aStr >= 'a' && *aStr <= 'f') ? *aStr - 'a' + 10 :
             (*aStr >= 'A' && *aStr <= 'F') ? *aStr - 'A' + 10 :
             *aStr - '0');
    }

    retVal = (neg ? -n : n);
err:
    return retVal;
}

/** @brief Parse integer from string

    @code{.unparsed}
    @trace #BRCM_SWARCH_MODULE_MSGPARSELONGINT_PROC
    @trace #BRCM_SWREQ_MODULE
    @endcode
*/
int64_t MODULE_MsgParseLongInt(const char *aStr, int32_t *aStatus)
{
    uint64_t  n;
    int8_t   *ch;
    uint32_t  neg;
    uint32_t  base = 10;
    int64_t retVal;

    *aStatus = BCM_ERR_OK;
    aStr += (neg = (*aStr == '-'));
    if ((*aStr == '0') && ((*(aStr+1) == 'x') || (*(aStr+1) == 'X'))) {
        if (neg) {
            *aStatus = BCM_ERR_INVAL_PARAMS;
            retVal = -1;
            goto err;
        }
        else {
            base = 16;
            aStr = (aStr + 2);
        }
    }

    ch = (int8_t *) aStr;
    if (*ch == '\0') {
        *aStatus = BCM_ERR_INVAL_PARAMS;
        retVal = -1;
        goto err;
    }

    if (base == 10) {
        while ((*ch != '\0')
                && (*ch != ' ')) {
            if (*ch < '0' || *ch > '9') {
                *aStatus = BCM_ERR_INVAL_PARAMS;
                retVal = -1;
                goto err;
            }
            ch++;
        }
    } else if (base == 16) {
        while ((*ch !='\0')
                && (*ch != ' ')) {
            if ((*ch >= '0' && *ch <= '9') || (*ch >= 'A' && *ch <= 'F') || (*ch >= 'a' && *ch <= 'f')){
                ch++;
                continue;
            }
            else {
                *aStatus = BCM_ERR_INVAL_PARAMS;
                retVal = -1;
                goto err;
            }
        }
    }

    for (n = 0; ((*aStr >= 'a' && *aStr <= 'f' && base > 10) ||
                (*aStr >= 'A' && *aStr <= 'F' && base > 10) ||
                (*aStr >= '0' && *aStr <= '9')); aStr++) {
        n = n * base +
            ((*aStr >= 'a' && *aStr <= 'f') ? *aStr - 'a' + 10 :
             (*aStr >= 'A' && *aStr <= 'F') ? *aStr - 'A' + 10 :
             *aStr - '0');
    }

    retVal = (neg ? -n : n);
err:
    return retVal;
}

/**
    @brief Read the file and write to buffer

    @trace #BRCM_SWARCH_MODULE_BUFFERFROMFILE_PROC
    @trace #BRCM_SWREQ_MODULE

    @code{.unparsed}
    if((NAME IS NULL) OR (aMaxSz IS 0) OR (aBuff IS NULL) OR (aLen IS 0))
        return BCM_ERR_INVAL_PARAMS
    else
        fp = fopen(aName, "r")
        if(fail to open)
            return BCM_ERR_INVAL_PARAMS
        if(no data in opened File)
            return BCM_ERR_INVAL_PARAMS
        *aLen = ftell(fp)
        if(*aLen IS 0) OR (*aLen > aMaxSz)
            return BCM_ERR_INVAL_PARAMS
        Set the File Position to Begining
        readlen = fread(aBuff, 1, *aLen, fp
        fclose(fp)
        if(readlen != *aLen)
            return BCM_ERR_INVAL_PARAMS
    @endcode
*/
int32_t MODULE_BufferFromFile(char *aName, uint32_t aMaxSz, uint8_t *aBuff, uint32_t *aLen)
{
    FILE *fp;
    uint32_t readlen;
    int32_t retVal = BCM_ERR_OK;

    if((NULL == aName) || (0UL == aMaxSz)
            || (NULL == aBuff) || (NULL == aLen)) {
            retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        fp = fopen(aName, "r");
        if (!fp) {
            (void)MODULE_HostHelperLog("Failed to Open the file\n");
            retVal = BCM_ERR_INVAL_PARAMS;
            goto done;
        }

        if (fseek(fp, 0, SEEK_END) < 0) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto done;
        }

        *aLen = ftell(fp);
        if((*aLen <= 0UL) || (aMaxSz < *aLen)) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto done;
        }
        if (fseek(fp, 0, SEEK_SET) < 0) {
            retVal = BCM_ERR_INVAL_PARAMS;
            goto done;
        }

        readlen = fread(aBuff, 1, *aLen, fp);
        fclose(fp);

        if (readlen != *aLen) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }
done:
    return retVal;
}

/**
    @brief Convert the MAC string to MAC Hex Value

    @trace #BRCM_SWARCH_MODULE_CONVERT_STR_TO_MAC_PROC
    @trace #BRCM_SWREQ_MODULE

    @code{.unparsed}
    if((aMacStr IS NULL) OR (aMacHex IS NULL))
        return BCM_ERR_INVAL_PARAMS
    if(Invalid MAC String)
        return BCM_ERR_INVAL_PARAMS
    for(i = 0; i < MODULE_MAXMAC_OCTECTS; ++i)
        if (!i)
            octet = strtol(aMacStr, &ptr, 16UL)
        else
            octet = strtol(ptr+1, &ptr, 16UL)
        if(i == (MODULE_MAXMAC_STRINGLENGTH - 1U))
            if ((*ptr != '\0') || (octet > 0xFF))
                return BCM_ERR_INVAL_PARAMS
        else
            if ((*ptr != ':') || (octet > 0xFF))
                return BCM_ERR_INVAL_PARAMS
        aMacHex[i] = octet;
    return BCM_ERR_ok
    @endcode
*/
int32_t MODULE_ConvertStrToMac(char *aMacStr, unsigned char *aMacHex)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t i;
    uint32_t octet;
    char *ptr = aMacStr;

    if ((aMacStr != NULL)  && (aMacHex != NULL)
                        && (strlen(aMacStr) == 17U)){
        for (i = 0; i < MODULE_MAXMAC_STRINGLENGTH; i++) {
            if ((i % 3) == 2) {
                if (aMacStr[i] != ':') {
                    goto done;
                }
            } else {
                if ((aMacStr[i] < '0')
                        || ((aMacStr[i] > '9') && (aMacStr[i] < 'A'))
                        || ((aMacStr[i] > 'F') && (aMacStr[i] < 'a'))
                        || (aMacStr[i] > 'f')) {
                    goto done;
                }
            }
        }

        for (i = 0; i < MODULE_MAXMAC_OCTECTS; ++i) {
            if (!i) {
                octet = strtol(aMacStr, &ptr, 16UL);
            } else {
                octet = strtol(ptr+1, &ptr, 16UL);
            }

            if (i == (MODULE_MAXMAC_OCTECTS - 1U)) {
                if ((*ptr != '\0') || (octet > 0xFF)) {
                    goto done;
                }
            } else {
                if ((*ptr != ':') || (octet > 0xFF)) {
                    goto done;
                }
            }

            aMacHex[i] = octet;
        }
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

/** @} */
