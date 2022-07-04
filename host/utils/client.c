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

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <mqueue.h>
#include <stdlib.h>
#include <string.h>
#include <server_ifc.h>
#include <host_etherswt.h>
#include <hipc.h>
#include <hlog.h>
#include <errno.h>
#include <bcm_utils.h>
#include <sys/sysinfo.h>
#include <ettm.h>
#include <ethernet_swt_ext.h>

#define HOST_ETS_ASYNC_PREFIX  "ETS Notification:"

const uint32_t MODULE_Event = 0UL;

static int32_t ETHSRVNotificationHandler(uint32_t currentSlave,
                BCM_CompIDType comp, uint8_t notificationId,
                uint8_t *msg, uint32_t size);

mqd_t asyncMqd = -1;

void * buffer_from_file(char *name, uint32_t *len)
{
    FILE *fp;
    uint32_t read_len;
    void *buffer;
    fp = fopen(name, "r");
    if (!fp) {
        HOST_Log("could not open %s\n", name);
        return NULL;
    }
    if (fseek(fp, 0, SEEK_END) < 0) {
        HOST_Log("error seeking to end of %s\n", name);
        fclose(fp);
        return NULL;
    }

    *len = ftell(fp);
    if(*len < 0 ) {
        HOST_Log("error in getting the current position\n");
        fclose(fp);
        return NULL;
    }
    if (fseek(fp, 0, SEEK_SET) < 0) {
        HOST_Log("error seeking to beginning of %s\n", name);
        fclose(fp);
        return NULL;
    }

    buffer = malloc(*len);
    if (!buffer) {
        HOST_Log("could not allocate %d bytes\n", *len);
        fclose(fp);
        return NULL;
    }

    read_len = fread(buffer, 1, *len, fp);
    fclose(fp);
    if (read_len != *len) {
        HOST_Log("error reading %s\n", name);
        free(buffer);
        return NULL;
    }

    return buffer;
}

int32_t HOST_Receive(mqd_t mqd, char* data, size_t dataSize, unsigned int* prio) {

    int retVal = -1;
    int recvLen = 0;
    struct timeval tv;
    fd_set rfds;

    do {
        FD_ZERO(&rfds);
        FD_SET(mqd, &rfds);

    #ifdef ENABLE_RECORD_NOTIFICATION
        /* poll every 100ms */
        tv.tv_sec = 0;
        tv.tv_usec = 100000;
    #else
        /* poll every sec */
        tv.tv_sec = 1;
        tv.tv_usec = 0;
    #endif
        /* Wait until we have an event */
        retVal = select(mqd + 1, &rfds, NULL, NULL, &tv);
        if (retVal == -1) {
            perror("select()");
        } else if (retVal) {
            if (FD_ISSET(mqd, &rfds)) {
                FD_CLR(mqd, &rfds);
                recvLen = mq_receive(mqd, data, dataSize, prio);
                if (-1 == retVal) {
                    if (EAGAIN != errno) {
                        perror("mq_receive");
                    }
                }
            }
        }
    }while(0 >= recvLen);
    return recvLen;
}

int32_t HOST_SendReceive(mqd_t sendMqd, mqd_t recvMqd, char* data,
                        size_t sendDataSize, size_t recvDataSize,
                        unsigned int  sendPrio, unsigned int *recvPrio)
{
    int retVal = -1;

    retVal = mq_send(sendMqd, data, sendDataSize, sendPrio);
    if (-1 == retVal) {
        perror("mq_send");
        return retVal;
    }

    retVal = HOST_Receive(recvMqd, data, recvDataSize, recvPrio);
    if(0U >= retVal) {
        retVal = BCM_ERR_NACK;
    } else {
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

void split_line(char * const input_string, uint32_t size, char **rem_string_ptr,
        uint32_t * const rem_len_ptr)
{
    uint32_t i = 0UL;
    while ((i < size)
            && ('\0' != input_string[i])
            && (' ' != input_string[i])
            && ('\r' != input_string[i])) {
        ++i;
    }
    if (' ' == input_string[i]) {
        rem_string_ptr[0UL] = &input_string[i + 1UL];
        rem_len_ptr[0UL] = size - (i + 1UL);
        input_string[i] = '\0'; /*don't modify the original string */
    }else {
        /* Empty argument string */
        rem_string_ptr[0UL] = NULL;
        rem_len_ptr[0UL] = 0UL;
    }
}

/*@api
 * parse_integer
 *
 * @brief
 * parse the integer.
 *
 * @param=s
 * @param=status - mask
 * @returns parsed value
 *
 * @desc
 */
uint32_t parse_integer(const char *s, int32_t *status)
{
    uint32_t  n, neg, base = 10;
    int8_t   *ch;

    *status = BCM_ERR_OK;
    s += (neg = (*s == '-'));
    if ((*s == '0') && ((*(s+1) == 'x') || (*(s+1) == 'X'))) {
        if (neg) {
            HOST_Log("Negative hex numbers are not supported\n");
            *status = BCM_ERR_INVAL_PARAMS;
            return -1;
        }
        else {
            base = 16;
            s = (s + 2);
        }
    }

    ch = (int8_t *) s;
    if (*ch == '\0') {
        HOST_Log("Invalid user input\n");
        *status = BCM_ERR_INVAL_PARAMS;
        return -1;
    }

    if (base == 10) {
        while ((*ch != '\0')
                && (*ch != ' ')){
            if (*ch < '0' || *ch > '9') {
                HOST_Log("Invalid decimal number \"%s\"\n", s);
                *status = BCM_ERR_INVAL_PARAMS;
                return -1;
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
                HOST_Log("Invalid hex number: \"0x%s\"\n", s);
                *status = BCM_ERR_INVAL_PARAMS;
                return -1;
            }
        }
    }

    for (n = 0; ((*s >= 'a' && *s <= 'f' && base > 10) ||
                (*s >= 'A' && *s <= 'F' && base > 10) ||
                (*s >= '0' && *s <= '9')); s++) {
        n = n * base +
            ((*s >= 'a' && *s <= 'f') ? *s - 'a' + 10 :
             (*s >= 'A' && *s <= 'F') ? *s - 'A' + 10 :
             *s - '0');
    }

    return (neg ? -n : n);
}

/* Print MAC Address */
void HOST_PrintMac(uint8_t *mac)
{
     HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x\n",
                  mac[0], mac[1],mac[2], mac[3], mac[4], mac[5]);
}

#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
/* Print IP Address */
void HOST_PrintIP(uint8_t *aIp, ETHSWT_FAFlagsType aFlag)
{
    if(ETHSWT_FAFLAGS_L3IPV4 == (aFlag & ETHSWT_FAFLAGS_L3IPV4)) {
            HOST_Log("%u.%0u.%u.%u\n",
                 aIp[0], aIp[1],
                 aIp[2], aIp[3]);
    } else {
            HOST_Log("%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
                 aIp[0], aIp[1], aIp[2], aIp[3], aIp[4], aIp[5], aIp[6], aIp[7],
                 aIp[8], aIp[9], aIp[10], aIp[11], aIp[12], aIp[13], aIp[14], aIp[15]);
    }
}
#endif

/*
 * Typedef:     cmd_result_t
 * Purpose:    Type retured from all commands indicating success, fail,
 *        or print usage.
 */
typedef enum cmd_result_e {
    CMD_OK   = 0,            /* Command completed successfully */
    CMD_FAIL = -1,            /* Command failed */
    CMD_USAGE= -2,            /* Command failed, print usage  */
} cmd_result_t;

#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
static int32_t mgmt_arl_show(mqd_t sendMqd, mqd_t recvMqd);
static ETHSWT_ARLEntryType ARLEntries[1000UL];
static ETHSWT_CFPEntrySnapshotType CFPRules[ETHSWT_CFP_MAX_RULES];
#endif

static const char HOST_Exec_cmd_usage[] = {
    "\texecute fw <img>\n"
};

void HOST_Exec_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *rem_str;
    uint32_t rem_str_len;
    int32_t rv = CMD_USAGE;
    int32_t retVal = 0;
    unsigned int param;
    HOST_InstallType execute;

    if ((input_str != NULL) && (input_str_len != 0)) {
        execute.cmdRsp.cmd = HOST_FW_EXECUTE;
        split_line(input_str, input_str_len, &rem_str, &rem_str_len);
        if (0UL == strncmp(input_str, "fw", 2)) {
            if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                memcpy(execute.fileName, rem_str, rem_str_len);
                execute.fileName[rem_str_len] = '\0';
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &execute ,
                                        sizeof(execute), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (execute.cmdRsp.rsp)) {
                    HOST_Log("failed to execute firmware ret:%d rsp:%d\n", retVal, execute.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        } else if (0UL == strncmp(input_str, "bl", 2)) {
            if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                memcpy(execute.fileName, rem_str, rem_str_len);
                execute.fileName[rem_str_len] = '\0';
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &execute ,
                                        sizeof(execute), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (execute.cmdRsp.rsp)) {
                       HOST_Log("failed to execute firmware\n");
                        rv = CMD_FAIL;
                } else {
                    rv = CMD_FAIL;
                }
            }
        }
    }

    if (rv == CMD_USAGE) {
        HOST_Log(HOST_Exec_cmd_usage);
    }
}

static const char HOST_Install_cmd_usage[] =
"\tinstall all <img>\n"
"\tinstall custom <img>\n";

void HOST_Install_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *rem_str;
    uint32_t rem_str_len;
    int32_t rv = CMD_USAGE;
    int32_t retVal = 0;
    unsigned int param;
    char *curr_str = input_str;
    uint32_t curr_str_len = input_str_len;
    HOST_InstallType install;

    if ((input_str != NULL) && (input_str_len != 0)) {
        split_line(input_str, input_str_len, &rem_str, &rem_str_len);
        if (0 == strncmp(input_str, "all", 3)) {
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                install.cmdRsp.cmd = HOST_INSTALL_MODE_ALL;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                memcpy(install.fileName, curr_str, curr_str_len);
                install.fileName[curr_str_len] = '\0';
                if ((rem_str == NULL) && (rem_str_len == 0)) {
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &install ,
                                            sizeof(install), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (install.cmdRsp.rsp)) {
                        HOST_Log("Failed to install images!\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            }
        } else if (0 == strncmp(input_str, "custom", 6)) {
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                install.cmdRsp.cmd = HOST_INSTALL_MODE_CUSTOM;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                memcpy(install.fileName, curr_str, curr_str_len);
                install.fileName[curr_str_len] = '\0';
                if ((rem_str == NULL) && (rem_str_len == 0)) {
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &install ,
                                            sizeof(install), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (install.cmdRsp.rsp)) {
                        HOST_Log("Failed to install images!\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            }
        }
    }
    if (rv == CMD_USAGE) {
        HOST_Log(HOST_Install_cmd_usage);
    }
    return;
}

static const char HOST_NVM_cmd_usage[] =
"\tnvm write <FlashID> <Offset> <Filename>\n"
"\tnvm read  <FlashID> <Offset> <size> <Filename>\n"
"\tnvm erase <FlashID> <Offset> <Sector size> <No Of Sectors>\n";

static int32_t HOST_NVMReadFileWrite (mqd_t sendMqd, mqd_t recvMqd, HOST_NVMReadType *aRead)
{
    int32_t retVal = BCM_ERR_OK;
    unsigned int param;
    uint32_t rxLen=0;
    FILE *fp;
    int8_t lBuff[512];

    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) aRead,
                                        sizeof(HOST_NVMReadType), MGMT_CMD_STR_MAX_LEN, 1, &param);
    if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == aRead->cmdRsp.rsp)) {
        fp = fopen(aRead->fileName,"wb");
        do {
            retVal = HOST_Receive(recvMqd, (char*) &lBuff[0], MGMT_CMD_STR_MAX_LEN, &param);
            if (-1 == retVal) {
                HOST_Log("mq_receive Failed \n");
                goto done;
            } else {
                fwrite(&lBuff[0], retVal, 1 , fp );
            }
            rxLen += retVal;
        } while(rxLen < aRead->size);
        /* retVal is maintained for the received data length in the above loop.
           So, Update the retVal to ERR_OK after completion of writing */
        retVal = BCM_ERR_OK;
    }
    if(BCM_ERR_OK != aRead->cmdRsp.rsp) {
        /* if the command's response is not ERR_OK then return the response */
        retVal = aRead->cmdRsp.rsp;
    }
done:
    return retVal;
}

void HOST_NVM_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *rem_str;
    uint32_t rem_str_len;
    int32_t rv = CMD_USAGE;
    int32_t retVal = 0;
    unsigned int param;
    char *curr_str = input_str;
    uint32_t curr_str_len = input_str_len;
    int32_t command_parse_status = 0;
    int32_t sector;

    if ((input_str != NULL) && (input_str_len != 0)) {
        split_line(input_str, input_str_len, &rem_str, &rem_str_len);
        if (0 == strncmp(input_str, "write", 5)) {
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                HOST_NVMWriteType nvmWr;
                nvmWr.cmdRsp.cmd = HOST_NVM_WRITE;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                nvmWr.devID = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                nvmWr.offSet = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                memcpy(nvmWr.fileName, curr_str, curr_str_len);
                nvmWr.fileName[curr_str_len] = '\0';

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &nvmWr ,
                                        sizeof(nvmWr), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (nvmWr.cmdRsp.rsp)) {
                    HOST_Log("Failed to flash images retVal = %d  Response = %d\n",
                                                          retVal, nvmWr.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        } else if (0 == strncmp(input_str, "erase", 5)) {
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                HOST_NVMEraseType nvmErase;
                nvmErase.cmdRsp.cmd = HOST_NVM_ERASE;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                nvmErase.devID = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                nvmErase.offSet = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                nvmErase.size = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                nvmErase.noOfsec = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                for(sector=0; sector < nvmErase.noOfsec; sector++) {
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &nvmErase ,
                                            sizeof(nvmErase), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (nvmErase.cmdRsp.rsp)) {
                        HOST_Log("Failed to erase flash!\n");
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log(" Erasing Sector %d \n",sector);
                        nvmErase.offSet += nvmErase.size;
                        rv = CMD_OK;
                    }
                }
            }
        } else if (0 == strncmp(input_str, "read", 4)) {
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                HOST_NVMReadType nvmRead;
                nvmRead.cmdRsp.cmd = HOST_NVM_READ;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                nvmRead.devID = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                nvmRead.offSet = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                nvmRead.size = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                memcpy(nvmRead.fileName, curr_str, curr_str_len);
                nvmRead.fileName[curr_str_len] = '\0';

                retVal = HOST_NVMReadFileWrite(sendMqd, recvMqd, &nvmRead);
                if ((BCM_ERR_OK != retVal) || (nvmRead.cmdRsp.rsp)) {
                    HOST_Log("Failed to Read the Data retVal= %d, Response = %d \n",
                                                       retVal, nvmRead.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        }
    }
done:
    if (rv == CMD_USAGE) {
        HOST_Log(HOST_NVM_cmd_usage);
    }
    return;
}
static const char HOST_FlashWrite_cmd_usage[] =
"\tflash write <addr>\n";
void HOST_FlashWrite_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *rem_str;
    uint32_t rem_str_len;
    int32_t rv = CMD_USAGE;
    int32_t retVal = 0;
    unsigned int param;
    HOST_FlashWriteType flash;

    if ((input_str != NULL) && (input_str_len != 0)) {
        split_line(input_str, input_str_len, &rem_str, &rem_str_len);
        if (0 == strncmp(input_str, "write", 5)) {
            flash.cmdRsp.cmd = HOST_SYS_FLASH_ERASE;
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                flash.address = (uint32_t)strtoul(rem_str, NULL, 16);
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &flash ,
                                            sizeof(flash), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (flash.cmdRsp.rsp)) {
                    HOST_Log("Failed to write to flash!\n");
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        }
    }
    if (rv == CMD_USAGE) {
        HOST_Log(HOST_FlashWrite_cmd_usage);
    }

    return;
}


static const char mgmt_otp_cmd_usage[] =
"\totp read <row_num (in hex)>\n"
"\totp write <row_num (in hex)> <data (in hex)>\n"
"\totp enable_sec\n"
"\totp key_write <key file>\n"
"\totp mac_addr write <mac address(xx:xx:xx:xx:xx:xx)> <loc(0/1)>\n"
"\totp mac_addr read\n";
void mgmt_otp_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *curr_str;
    uint32_t curr_str_len;
    char *rem_str;
    uint32_t rem_str_len;
    int32_t rv = CMD_USAGE;
    int32_t retVal;
    unsigned int param;

    if ((input_str != NULL) && (input_str_len != 0)) {
        split_line(input_str, input_str_len, &rem_str, &rem_str_len);
        if (0 == strncmp(input_str, "read", 4)) {
            if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                HOST_SysOtpReadType sysOtpRd;
                sysOtpRd.cmdRsp.cmd = HOST_SYS_OTP_READ;
                sysOtpRd.value = 0UL;
                sysOtpRd.row_num = (int)strtol(rem_str, NULL, 16);
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sysOtpRd ,
                                        sizeof(sysOtpRd), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (sysOtpRd.cmdRsp.rsp)) {
                    HOST_Log("Failed to read OTP!\n");
                    rv = CMD_FAIL;
                } else {
                    HOST_Log("OTP read: row_num:0x%x, data:0x%x\n",
                    sysOtpRd.row_num, sysOtpRd.value);
                    rv = CMD_OK;
                }
            }
        } else if (0 == strncmp(input_str, "write", 5)) {
            if ((rem_str != NULL) && (rem_str_len > 1UL)) {
                HOST_SysOtpWriteType sysOtpWr;
                sysOtpWr.cmdRsp.cmd = HOST_SYS_OTP_WRITE;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                sysOtpWr.row_num = (uint32_t)strtoul(curr_str, NULL, 16);
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                    sysOtpWr.data = (uint32_t)strtoul(rem_str, NULL, 16);
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sysOtpWr ,
                            sizeof(sysOtpWr), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (sysOtpWr.cmdRsp.rsp)) {
                        HOST_Log("Failed to write OTP!\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            }
        } else if (0 == strncmp(input_str, "enable_sec", 10)) {
            if ((rem_str == NULL) && (rem_str_len == 0UL)) {
                HOST_SysOtpEnableSecType sysOtpEn;
                sysOtpEn.cmdRsp.cmd = HOST_SYS_OTP_ENABLE_SEC;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sysOtpEn ,
                                        sizeof(sysOtpEn), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (sysOtpEn.cmdRsp.rsp)) {
                    HOST_Log("Failed to enable Secure OTP bit!\n");
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        } else if (0 == strncmp(input_str, "key_write", 9)) {
            if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                HOST_SysOtpKeyWriteType sysOtpKey;
                sysOtpKey.cmdRsp.cmd = HOST_SYS_OTP_KEY_WRITE;
                memcpy(sysOtpKey.fileName, rem_str, rem_str_len);
                sysOtpKey.fileName[rem_str_len] = '\0';
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sysOtpKey ,
                                        sizeof(sysOtpKey), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (sysOtpKey.cmdRsp.rsp)) {
                    HOST_Log("Failed to write key!\n");
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        } else if (0 == strncmp(input_str, "mac_addr", 8)) {
            if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                HOST_SWTConvMacType sendMacConv;
                sendMacConv.cmdRsp.cmd = HOST_SWT_CONV_MAC;

                HOST_SysOtpMacaddrWriteType sysOtpMacWr;
                sysOtpMacWr.cmdRsp.cmd = HOST_SYS_OTP_MAC_ADDR_WRITE;

                input_str = rem_str;
                input_str_len = rem_str_len;
                split_line(input_str, input_str_len, &rem_str, &rem_str_len);
                if (0 == strncmp(input_str, "write", 5)) {
                    if ((rem_str != NULL) && (rem_str_len > 0UL)) {
                        input_str = rem_str;
                        input_str_len = rem_str_len;
                        split_line(input_str, input_str_len, &rem_str, &rem_str_len);
                        memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                        memcpy(sendMacConv.str, input_str, sizeof(sendMacConv.str));
                        sendMacConv.str[17]='\0';
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                                    sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if ((BCM_ERR_OK != retVal) || (sendMacConv.result)) {
                            HOST_Log("Invalid MAC\n");
                            rv = CMD_FAIL;
                            goto done;
                        }

                        HOST_Log("OTP MAC addr-1: %02x:%02x:%02x:%02x:%02x:%02x\n",
                                (uint32_t)(sendMacConv.mac_addr[0]),
                                (uint32_t)(sendMacConv.mac_addr[1]),
                                (uint32_t)(sendMacConv.mac_addr[2]),
                                (uint32_t)(sendMacConv.mac_addr[3]),
                                (uint32_t)(sendMacConv.mac_addr[4]),
                                (uint32_t)(sendMacConv.mac_addr[5]));

                        if ((rem_str == NULL) || (rem_str_len == 0)) {
                            goto done;
                        }

                        sysOtpMacWr.loc = (int)strtol(rem_str, NULL, 16);
                        memcpy(sysOtpMacWr.macaddr, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sysOtpMacWr ,
                                                sizeof(sysOtpMacWr), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if ((BCM_ERR_OK != retVal) || (BCM_ERR_NOPERM == sysOtpMacWr.cmdRsp.rsp)) {
                            HOST_Log("Permission denied to write MAC address to OTP!\n");
                            rv = CMD_FAIL;
                        } else if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != sysOtpMacWr.cmdRsp.rsp)) {
                            HOST_Log("Failed to write MAC address to OTP, ret:%d\n", sysOtpMacWr.cmdRsp.rsp);
                            rv = CMD_FAIL;
                        } else {
                            rv = CMD_OK;
                        }
                    }
                } else if (0 == strncmp(input_str, "read", 4)) {
                    if ((rem_str == NULL) && (rem_str_len == 0UL)) {
                        HOST_SysOtpMacAddrReadType sysOtpMacRd;
                        sysOtpMacRd.cmdRsp.cmd = HOST_SYS_OTP_MAC_ADDR_READ;
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sysOtpMacRd ,
                                                sizeof(sysOtpMacRd), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if ((BCM_ERR_OK != retVal) || (sysOtpMacRd.cmdRsp.rsp)) {
                            HOST_Log("Failed to read MAC address to OTP!\n");
                            rv = CMD_FAIL;
                        } else {
                            HOST_Log("Location\t MAC Address\t\t Valid\n");
                            HOST_Log("0\t\t %02x:%02x:%02x:%02x:%02x:%02x\t %x\n",
                                    (uint32_t)(sysOtpMacRd.macaddr1[0]),
                                    (uint32_t)(sysOtpMacRd.macaddr1[1]),
                                    (uint32_t)(sysOtpMacRd.macaddr1[2]),
                                    (uint32_t)(sysOtpMacRd.macaddr1[3]),
                                    (uint32_t)(sysOtpMacRd.macaddr1[4]),
                                    (uint32_t)(sysOtpMacRd.macaddr1[5]),
                                    (sysOtpMacRd.value & 0x1));
                            HOST_Log("1\t\t %02x:%02x:%02x:%02x:%02x:%02x\t %x\n",
                                    (uint32_t)(sysOtpMacRd.macaddr2[0]),
                                    (uint32_t)(sysOtpMacRd.macaddr2[1]),
                                    (uint32_t)(sysOtpMacRd.macaddr2[2]),
                                    (uint32_t)(sysOtpMacRd.macaddr2[3]),
                                    (uint32_t)(sysOtpMacRd.macaddr2[4]),
                                    (uint32_t)(sysOtpMacRd.macaddr2[5]),
                                    ((sysOtpMacRd.value & 0x2) >> 1));
                            rv = CMD_OK;
                        }
                    }
                }
            }
        }
    }

    if (rv == CMD_USAGE) {
        HOST_Log(mgmt_otp_cmd_usage);
    }
done:
    return;
}

#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
static const char mgmt_switch_cmd_usage[] =
"\tswitch read <addr> <0:master|1:slave>\n"
"\tswitch write <addr> <dataHigh> <dataLow> <0:master|1:slave>\n"
"\tswitch cl22 read <mdioHwID> <phy> <reg> <0:master|1:slave>\n"
"\tswitch cl22 write <mdioHwID> <phy> <reg> <data> <0:master|1:slave>\n"
"\tswitch cl45 read <mdioHwID> <phy> <devType> <reg> <0:master|1:slave>\n"
"\tswitch cl45 write <mdioHwID> <phy> <devType> <reg> <data> <0:master|1:slave>\n"
"\tswitch port info <port>\n"
"\tswitch port mibs <port> [clear]\n"
"\tswitch age_time set <age_time>\n"
"\tswitch age_time get\n"
"\tswitch dumbfwd set <disable|enable>\n"
"\tswitch dumbfwd get\n"
"\tswitch brcmhdr set <disable|enable>\n"
"\tswitch brcmhdr get\n"
"\tswitch mgmtmode set <disable|enable>\n"
"\tswitch mgmtmode get\n"
"\tswitch admin_mode set <port> <disable|enable>\n"
"\tswitch admin_mode get <port>\n"
"\tswitch speed get <port>\n"
"\tswitch master_slave set <port> <slave|master>\n"
"\tswitch master_slave get <port>\n"
"\tswitch phy_lb_mode set <port> <disable|enable>\n"
"\tswitch phy_lb_mode get <port>\n"
"\tswitch jumbo_frame set <port> <disable|enable>\n"
"\tswitch jumbo_frame get <port>\n"
"\tswitch link sqi [port]\n"
"\tswitch pvidset <port> <pvid> <priority>\n"
"\tswitch ifilter [disable|enable]\n"
"\tswitch mirror enable <port bitmap> <probe port> <ingress|egress> [packetDivider]\n"
"\tswitch mirror disable\n"
"\tswitch mirror status\n"
"\tswitch vlan get <vlan id>\n"
"\tswitch vlan add <vlan id> <portMask> <tagMask>\n"
"\tswitch vlan del <vlan id> <portMask>\n"
#ifdef ENABLE_ETHSWT_SECURITY
"\tswitch vlan hop_detect set <0:disabled|1:drop pkt|2:redirect to CPU>\n"
"\tswitch vlan hop_detect get\n"
#endif /* ENABLE_ETHSWT_SECURITY */
"\tswitch arl add <mac address(xx:xx:xx:xx:xx:xx)> <vlan> <port_mask>\n"
"\tswitch arl del <mac address(xx:xx:xx:xx:xx:xx)> <vlan>\n"
#ifdef ENABLE_ETHSWT_SECURITY
"\tswitch arl port_limit set <port> <0:disabled|1:drop pkt|2:redirect to CPU|3:normal|4:copy to CPU> [limit]\n"
"\tswitch arl port_limit get <port>\n"
"\tswitch arl sticky set <port> <0:disabled|1:drop pkt|2:redirect to CPU>\n"
"\tswitch arl sticky get <port>\n"
"\tswitch arl move_detect set <port> <0:disabled|1:drop pkt|2:redirect to CPU>\n"
"\tswitch arl move_detect get <port>\n"
"\tswitch arl total_limit set <limit>\n"
"\tswitch arl total_limit get\n"
#endif /* ENABLE_ETHSWT_SECURITY */
"\tswitch stream policer add <mac address> <vlan> <rate> <burst> <src_mask> <threshold> <interval> <report> <block>\n"
"\tswitch stream policer del <stream index>\n"
"\tswitch stream policer block <stream index>\n"
"\tswitch stream policer resume <stream index>\n"
"\tswitch stream policer show [stream index]\n"
"\tswitch stream policer find <mac address> <vlan> <src_mask>\n"
"\tswitch arl show\n"
"\tswitch tc10 get wakeup_mode <port>\n"
"\tswitch tc10 get wakeup_reason <port>\n"
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
"\tswitch fa flow add <filename.bin>\n"
"\tswitch fa flow delete <flowID>\n"
"\tswitch fa flow get <flowID>\n"
"\tswitch fa flow status <usemac | active | static> <macAddr : valid only with usemac> <0:master|1:slave>\n"
"\tswitch fa stats\n"
"\tswitch fa mac add <macAddr> <external | internal> <0:master|1:slave>\n"
"\tswitch fa mac delete <macAddr>  <0:master|1:slave>\n"
"\tswitch fa mac force_delete <macAddr>  <0:master|1:slave>\n"
"\tswitch fa mac snapshot\n"
"\tswitch fa reset <filename.bin>\n"
"\tswitch fa interrupt_enable <help | Maskflag(0x03FFFFFF)>\n"
#endif /* ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER */
"\n";

static void PrintRxStats(ETHER_RxStatsType *rxStats)
{
    HOST_Log("*** RX PKT STATS ***\n");
    HOST_Log("\t gdPkts : 0x%x\n", rxStats->gdPkts );
    HOST_Log("\t octets: %" PRIx64 "\n",
            ((uint64_t)rxStats->octetsHigh << 32UL) | rxStats->octetsLow);
    HOST_Log("\t allPkts: 0x%x\n", rxStats->allPkts);
    HOST_Log("\t brdCast: 0x%x\n", rxStats->brdCast);
    HOST_Log("\t multicast: 0x%x\n", rxStats->mutCast);
    HOST_Log("\t unicast: 0x%x\n", rxStats->uniCast);
    HOST_Log("\t pkts64: 0x%x\n", rxStats->pkts64);
    HOST_Log("\t pkts65_127: 0x%x\n", rxStats->pkts65_127);
    HOST_Log("\t pkts128_255: 0x%x\n", rxStats->pkts128_255);
    HOST_Log("\t pkts256_511: 0x%x\n", rxStats->pkts256_511);
    HOST_Log("\t pkts512_1023: 0x%x\n", rxStats->pkts512_1023);
    HOST_Log("\t pkts1024_1522: 0x%x\n", rxStats->pkts1024_1522);
    HOST_Log("\t pkts1024_MAX: 0x%x\n", rxStats->pkts1024_MAX);
    HOST_Log("\t pkts1523_2047: 0x%x\n", rxStats->pkts1523_2047);
    HOST_Log("\t pkts2048_4095: 0x%x\n", rxStats->pkts2048_4095);
    HOST_Log("\t pkts4096_8191: 0x%x\n", rxStats->pkts4096_8191);
    HOST_Log("\t pkts8192_MAX: 0x%x\n", rxStats->pkts8192_MAX);
    HOST_Log("\t pktsOvrSz: 0x%x\n", rxStats->pktsOvrSz);
    HOST_Log("\t pktsRxDrop: 0x%x\n", rxStats->pktsRxDrop);
    HOST_Log("\t pktsCrcErr: 0x%x\n", rxStats->pktsCrcErr);
    HOST_Log("\t pktsCrcAlignErr: 0x%x\n", rxStats->pktsCrcAlignErr);
    HOST_Log("\t pktsJabber: 0x%x\n", rxStats->pktsJabber);
    HOST_Log("\t pktsFrag: 0x%x\n", rxStats->pktsFrag);
    HOST_Log("\t pktsUndSz: 0x%x\n", rxStats->pktsUndSz);
    HOST_Log("\t pktsRxDiscard: 0x%x\n", rxStats->pktsRxDiscard);
    HOST_Log("\t rxPause: 0x%x\n", rxStats->rxPause);
}

static void PrintTxStats(ETHER_TxStatsType *txStats)
{
    HOST_Log("*** TX PKT STATS ***\n");
    HOST_Log("\t octets: 0x%x\n", txStats->octets);
    HOST_Log("\t brdCast: 0x%x\n", txStats->brdCast);
    HOST_Log("\t multicast: 0x%x\n", txStats->mutCast);
    HOST_Log("\t unicast: 0x%x\n", txStats->uniCast);
    HOST_Log("\t txDropped: 0x%x\n", txStats->txDropped);
    HOST_Log("\t txDroppedErr: 0x%x\n", txStats->txDroppedErr);
    HOST_Log("\t txCollision: 0x%x\n", txStats->txCollision);
    HOST_Log("\t txCollisionSingle: 0x%x\n", txStats->txCollisionSingle);
    HOST_Log("\t txCollisionMulti: 0x%x\n", txStats->txCollisionMulti);
    HOST_Log("\t txLateCollision: 0x%x\n", txStats->txLateCollision);
    HOST_Log("\t txExcessiveCollision: 0x%x\n", txStats->txExcessiveCollision);
    HOST_Log("\t txDeferredTransmit: 0x%x\n", txStats->txDeferredTransmit);
    HOST_Log("\t txFrameInDiscard: 0x%x\n", txStats->txFrameInDiscard);
    HOST_Log("\t txPause: 0x%x\n", txStats->txPause);
    HOST_Log("\t txQ0: 0x%x\n", txStats->txQ0);
    HOST_Log("\t txQ1: 0x%x\n", txStats->txQ1);
    HOST_Log("\t txQ2: 0x%x\n", txStats->txQ2);
    HOST_Log("\t txQ3: 0x%x\n", txStats->txQ3);
    HOST_Log("\t txQ4: 0x%x\n", txStats->txQ4);
    HOST_Log("\t txQ5: 0x%x\n", txStats->txQ5);
    HOST_Log("\t txQ6: 0x%x\n", txStats->txQ6);
    HOST_Log("\t txQ7: 0x%x\n", txStats->txQ7);
    HOST_Log("\t pkts64: 0x%x\n", txStats->pkts64);
    HOST_Log("\t pkts65_127: 0x%x\n", txStats->pkts65_127);
    HOST_Log("\t pkts128_255: 0x%x\n", txStats->pkts128_255);
    HOST_Log("\t pkts256_511: 0x%x\n", txStats->pkts256_511);
    HOST_Log("\t pkts512_1023: 0x%x\n", txStats->pkts512_1023);
    HOST_Log("\t pkts1024_MAX: 0x%x\n", txStats->pkts1024_MAX);
}

static void show_switch_mibs(ETHSWT_DebugMibType *aMibs)
{
    HOST_Log("******Rx Stats******\n");
    PrintRxStats(&aMibs->rxStats);
    HOST_Log("******Tx Stats******\n");
    PrintTxStats(&aMibs->txStats);
}
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER

static void PrintFAFlow(ETHSWT_FAFlowDataType *flow, ETHSWT_FAFlowStatsType *stats)
{
    /* FA FLOW Match Parameters */
    HOST_Log("\n\n****** FA FLOW Match Parameters ******\n");
    HOST_Log("Destination MAC Address\t: ");
    HOST_PrintMac(&flow->match.da[0]);
    HOST_Log("L4 Source Port\t\t: %u\n",flow->match.srcPort);
    HOST_Log("L4 destination Port\t: %u\n",flow->match.dstPort);
    if(ETHSWT_FAFLAGS_L3IPV4 == (flow->match.flags & ETHSWT_FAFLAGS_L3IPV4)) {
        HOST_Log("IPV4/IPV6\t\t: IPV4\n");
    } else {
        HOST_Log("IPV4/IPV6 : IPV6\n");
    }
    HOST_Log("Source IP Address\t: ");
    HOST_PrintIP(&flow->match.srcIp[0],flow->match.flags);
    HOST_Log("destination IP Address\t: ");
    HOST_PrintIP(&flow->match.dstIp[0],flow->match.flags);

    /* TCP/UDP */
    if(ETHSWT_FAFLAGS_L4TCP == (flow->match.flags & ETHSWT_FAFLAGS_L4TCP)) {
        HOST_Log("TCP/UDP\t\t\t: TCP\n");
    } else {
        HOST_Log("TCP/UDP\t\t\t: UDP\n");
    }

    /* LLCSNAP/DIXv2 */
    if(ETHSWT_FAFLAGS_L2LLCSNAP == (flow->match.flags & ETHSWT_FAFLAGS_L2LLCSNAP)) {
        HOST_Log("LLCSNAP/DIXv2\t\t: LLCSNAP\n");
    } else {
        HOST_Log("LLCSNAP/DIXv2\t\t: DIXv2\n");
    }

    /* Inboud/Outbound */
    if(ETHSWT_FAFLAGS_INBOUND == (flow->match.flags & ETHSWT_FAFLAGS_INBOUND)) {
        HOST_Log("Inboud/Outbound\t\t: Inbound\n");
    } else {
        HOST_Log("Inboud/Outbound\t\t: Outbound\n");
    }

    /* FA FLOW Remap Parameters */
    HOST_Log("\n\n******FA FLOW Remap Parameters******\n");
    /* FA Operation */
    HOST_Log("FA Operation\t\t:");
    if(ETHSWT_FAOPERATION_S_TAG == flow->remap.operation) {
        HOST_Log(" S-Tag\t");
    } else if(ETHSWT_FAOPERATION_C_TAG == flow->remap.operation){
        HOST_Log(" C-Tag\t");
    } else if(ETHSWT_FAOPERATION_NO_TAG == flow->remap.operation){
        HOST_Log(" No-Tag\n");
    } else {
        HOST_Log(" No-Op\n");
    }

    if((ETHSWT_FAOPERATION_C_TAG == flow->remap.operation)
               || (ETHSWT_FAOPERATION_S_TAG == flow->remap.operation)) {
        /* VID 11:0 */
        HOST_Log("VID: %u  ",(flow->remap.vlan & 0xFFFU));
        /* DEI b'12 */
        HOST_Log("DEI: %u  ",((flow->remap.vlan & 0x1000) >> 12U));
        /* PCP 15:13 */
        HOST_Log("PCP: %u  \n",(flow->remap.vlan & 0xE000U) >> 13U);
    }

    HOST_Log("Source MAC Address\t: ");
    HOST_PrintMac(&flow->remap.sa[0]);
    HOST_Log("Destination MAC Address\t: ");
    HOST_PrintMac(&flow->remap.da[0]);
    HOST_Log("L4 Remap Port\t\t: %u\n",flow->remap.port);
    HOST_Log(" Remap IP Address\t: ");
    HOST_PrintIP(&flow->remap.ip[0],flow->match.flags);

    /* Traffic class */
    if(ETHSWT_TC_INVALID != flow->remap.tc) {
        HOST_Log("Traffic class\t\t: %u\n",flow->remap.tc);
    } else {
        HOST_Log("Traffic class\t\t: Invalid Traffic\n");
    }

    /* Tag Enforcement */
    if(ETHSWT_TE_NONE == flow->remap.te) {
        HOST_Log("Tag Enforcement\t\t: None\n");
    } else if(ETHSWT_TE_UNTAG == flow->remap.te) {
        HOST_Log("Tag Enforcement\t\t: Untag\n");
    } else if(ETHSWT_TE_HEADER == flow->remap.te) {
        HOST_Log("Tag Enforcement\t\t: Header\n");
    } else {
        HOST_Log("Tag Enforcement\t\t: Reserved\n");
    }

    /* Portmask */
    HOST_Log("Portmask\t\t: %u\n",flow->remap.portMask);

    /* Master/Slave */
    HOST_Log("Device\t\t\t: ");
    if(MCU_DEVICE_MASTER == flow->mstSlvDevice) {
        HOST_Log("Master\n");
    } else if (MCU_DEVICE_SLAVE_1 == flow->mstSlvDevice) {
        HOST_Log("Slave1\n");
    } else if (MCU_DEVICE_SLAVE_2 == flow->mstSlvDevice){
        HOST_Log("Slave2\n");
    }

    /* Flow Stats */
    HOST_Log("\n\n******FA FLOW Stats******\n");
    HOST_Log("hits\t\t\t: %d\n",stats->hits);
    HOST_Log("lastTimestamp\t\t: %d\n",stats->lastTimestamp);
}

static void PrintFAGlobalStats(ETHSWT_FAStatsType *aStats)
{
    HOST_Log("\n\n****** FA Global Stats ******\n");
    HOST_Log("hits Count                     : 0x%x\n",aStats->hit);
    HOST_Log("misses Count                   : 0x%x\n",aStats->miss);
    HOST_Log("SNAP failures Count            : 0x%x\n",aStats->snapFail);
    HOST_Log("etype failures Count           : 0x%x\n",aStats->etypeFail);
    HOST_Log("version failures               : 0x%x\n",aStats->versionFail);
    HOST_Log("fragmentation failures         : 0x%x\n",aStats->fragFail);
    HOST_Log("UDP/TCP protocol failures      : 0x%x\n",aStats->protocolFail);
    HOST_Log("IPv4 checksum failures  Count  : 0x%x\n",aStats->checksumFail);
    HOST_Log("IPv4 option failures Count     : 0x%x\n",aStats->optionsFail);
    HOST_Log("IPv4 header length failures    : 0x%x\n",aStats->headerLengthFail);
    HOST_Log("Entries used in Flow Table     : 0x%x\n",aStats->flowTableUsage);
    HOST_Log("Entries used in Pool Table     : 0x%x\n",aStats->poolTableUsage);
    HOST_Log("Entries used in Next-Hop Table : 0x%x\n",aStats->nextHopTableUsage);
    HOST_Log("Current timestamp              : 0x%x\n",aStats->currentTimestamp);
    HOST_Log("Interrupt flags                : 0x%x\n",aStats->intrFlags);
}

static void PrintFAFlowStatus(ETHSWT_FAFlowStatusDataType *aFlowStatus)
{
    uint32_t flow;
    uint32_t flowBit;

    HOST_Log("\n\n****** FA FLOW Stats ******\n");
    if(ETHSWT_FAATTRIBUTE_ACTIVE == aFlowStatus->attribute) {
        HOST_Log("FA flow attribute\t: Active\n");
    } else if (ETHSWT_FAATTRIBUTE_STATIC == aFlowStatus->attribute) {
        HOST_Log("FA flow attribute\t: Static\n");
    } else {
        HOST_Log("FA flow attribute\t: MAC Use\n");
        HOST_Log(" MAC Address\t\t: ");
        HOST_PrintMac(&aFlowStatus->mac[0]);
    }

    HOST_Log("Associated  Flows\t: ");
    for(flow =0; flow <(ETHSWT_FA_FLOWS_MAX / 8UL); flow++) {
        if(FALSE != (aFlowStatus->mask[flow])) {
            for (flowBit=0; flowBit<8UL; flowBit++) {
                if(TRUE == ((aFlowStatus->mask[flow] >> flowBit) & 0x1U)) {
                    HOST_Log("%u ",((aFlowStatus->mstSlvDevice << 16U) | ((flow * 8) + flowBit)));
                }
            }
        }
    }
    HOST_Log("\n");
}

static void PrintFAMACSnapShot(ETHSWT_FAMacSnapshotType *aSnap, MCU_DeviceType aMstSlv)
{
    uint32_t poolId;
    uint8_t macZero[6U] = {0};

    HOST_Log("\n\n*********** MAC SnapShot ***************\n");
    HOST_Log("Device\t\t\t: ");
    /* Master/Slave */
    if(MCU_DEVICE_MASTER == aMstSlv) {
        HOST_Log("Master\n");
    } else if (MCU_DEVICE_SLAVE_1 == aMstSlv) {
        HOST_Log("Slave1\n");
    } else if (MCU_DEVICE_SLAVE_2 == aMstSlv){
        HOST_Log("Slave2\n");
    }
    HOST_Log("Device MAC Address\t: %02x:%02x:%02x:%02x:%02x:%02x\n\n",
                 aSnap->deviceMac[aMstSlv][0], aSnap->deviceMac[aMstSlv][1],
                 aSnap->deviceMac[aMstSlv][2], aSnap->deviceMac[aMstSlv][3],
                 aSnap->deviceMac[aMstSlv][4], aSnap->deviceMac[aMstSlv][5]);
    for(poolId=0; poolId<ETHSWT_FA_POOL_MAX; poolId++) {
        if(0UL != memcmp(macZero,&aSnap->info[aMstSlv][poolId].mac[0],6)) {
            HOST_Log("MAC Address %d\t\t: %02x:%02x:%02x:%02x:%02x:%02x",poolId,
                     aSnap->info[aMstSlv][poolId].mac[0], aSnap->info[aMstSlv][poolId].mac[1],
                     aSnap->info[aMstSlv][poolId].mac[2], aSnap->info[aMstSlv][poolId].mac[3],
                     aSnap->info[aMstSlv][poolId].mac[4], aSnap->info[aMstSlv][poolId].mac[5]);
            if(TRUE == aSnap->info[aMstSlv][poolId].external) {
                HOST_Log("\tExternal\n");
            } else {
                HOST_Log("\tInternal\n");
            }
        }
    }
}

/* These fields are from ETHSWT_FAIntrFlagsType*/
void HOST_InterruptHelp()
{
    HOST_Log("0x00000001: Broadcom header edit invalid\n");
    HOST_Log("0x00000002: Checksum error detected on incoming IPv4 frame\n");
    HOST_Log("0x00000004: Parsing did not complete during l3 stage\n");
    HOST_Log("0x00000008: Parsing did not complete during l2 stage\n");
    HOST_Log("0x00000010: Parsing did not complete during brcm header stage\n");
    HOST_Log("0x00000020: HW queue overflow\n");
    HOST_Log("0x00000040: Header buffer overflow\n");
    HOST_Log("0x00000080: RXQ buffer overflow\n");
    HOST_Log("0x00000100: Sop/Eop error\n");
    HOST_Log("0x00000200: Split buffer overflow\n");
    HOST_Log("0x00000400: Latency buffer overflow\n");
    HOST_Log("0x00000800: Merge error\n");
    HOST_Log("0x00001000: Tx queue overflow error\n");
    HOST_Log("0x00002000: RSV buffer overflow error\n");
    HOST_Log("0x00004000: Correctable ECC error has been detected in the header buffer\n");
    HOST_Log("0x00008000: Correctable ECC error has been detected in the HWQ buffer\n");
    HOST_Log("0x00010000: Correctable ECC error has been detected in the HWQ buffer\n");
    HOST_Log("0x00020000: Correctable ECC error has been detected in the latency buffer\n");
    HOST_Log("0x00040000: Correctable ECC error has been detected in the napt flow table\n");
    HOST_Log("0x00080000: Correctable ECC error has been detected in the next hop table\n");
    HOST_Log("0x00100000: Uncorrectable ECC error has been detected in the header buffer\n");
    HOST_Log("0x00200000: Uncorrectable ECC error has been detected in the HWQ buffer\n");
    HOST_Log("0x00400000: Uncorrectable ECC error has been detected in the HWQ buffer\n");
    HOST_Log("0x00800000: Uncorrectable ECC error has been detected in the latency buffer\n");
    HOST_Log("0x01000000: Uncorrectable ECC error has been detected in the napt flow table\n");
    HOST_Log("0x02000000: Uncorrectable ECC error has been detected in the next hop table\n");

    HOST_Log("These fields are from ETHSWT_FAIntrFlagsType\n");
    HOST_Log("Please refer Interface Document for Exact field definitions\n");
}

#endif /* #ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER */

#ifdef ENABLE_ETHSWT_SECURITY
static void security_action_to_string(ETHSWT_SecurityActionType aAction)
{
    switch (aAction) {
        case ETHSWT_SECURITY_ACTION_DISABLED:
            HOST_Log("Disabled\n");
            break;
        case ETHSWT_SECURITY_ACTION_DROP_PKT:
            HOST_Log("Drop Packet\n");
            break;
        case ETHSWT_SECURITY_ACTION_NORMAL:
            HOST_Log("Normal\n");
            break;
        case ETHSWT_SECURITY_ACTION_REDIRECT_TO_CPU:
            HOST_Log("Redirect to CPU\n");
            break;
        case ETHSWT_SECURITY_ACTION_COPY_TO_CPU:
            HOST_Log("Copy to CPU\n");
            break;
        default:
            HOST_Log("Invalid\n");
            break;
    }
}
#endif /* ENABLE_ETHSWT_SECURITY */
void mgmt_switch_cmd_handler( mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    unsigned int param;
    char *curr_str = input_str;
    char *rem_str;
    uint32_t curr_str_len = input_str_len;
    uint32_t rem_str_len;
    int32_t retVal = 0;
    int32_t rv = CMD_USAGE;
    uint32_t value1, value2, value3, value4 = 0;
    uint64_t u64Val;
    int32_t command_parse_status;
    int32_t i;
    uint16_t u16Val;
    uint32_t write;
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
    void* buffer;
    uint32_t u32Val;
    ETHSWTM_FACfgType faCfg;
    ETHSWT_FAMacGroupType faMac[2UL];
    uint8_t macZero[6U] = {0};
    int32_t devMac;
    int32_t flow;
    int8_t dev; /* Devices Number*/
    uint8_t noOfDev = 0U; /* No of Devices */
    uint8_t availableEntriesDev[2U];
    uint8_t matchedEntriesDev[2U];
    uint32_t buf_size;
#endif

    if ((curr_str != NULL) && (curr_str_len != 0)) {
        if (!strncmp(curr_str, "port", 4)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            if (!strncmp(curr_str, "info", 4)) {
                HOST_SWTPortInfoType pInfo;
                pInfo.cmdRsp.cmd = HOST_SWT_PORT_INFO;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;

                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                pInfo.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &pInfo ,
                                            sizeof(pInfo), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (pInfo.cmdRsp.rsp)) {
                    rv = CMD_FAIL;
                    HOST_Log("Failed to get port info, retVal = %d\n", pInfo.cmdRsp.rsp);
                } else {
                    HOST_Log("Port : %u\n", pInfo.portInfo.port);
                    HOST_Log("AdminMode : ");
                    switch (pInfo.portInfo.adminMode) {
                    case ETHXCVR_MODE_ACTIVE:
                        HOST_Log("Active\n");
                        break;
                    case ETHXCVR_MODE_DOWN:
                        HOST_Log("Down\n");
                        break;
                    case ETHXCVR_MODE_ISOLATE:
                        HOST_Log("Isolate\n");
                        break;
                    default:
                        break;
                    }
                    HOST_Log("LinkStatus : %s\n", (pInfo.portInfo.linkStatus ==
                                ETHXCVR_LINKSTATE_ACTIVE) ? "Up" : "Down");
                    switch (pInfo.portInfo.speed) {
                    case ETHXCVR_SPEED_10MBPS:
                        HOST_Log("Speed : 10Mbps\n");
                        break;
                    case ETHXCVR_SPEED_100MBPS:
                        HOST_Log("Speed : 100Mbps\n");
                        break;
                    case ETHXCVR_SPEED_1000MBPS:
                        HOST_Log("Speed : 1000Mbps\n");
                        break;
                    case ETHXCVR_SPEED_2500MBPS:
                        HOST_Log("Speed: 2500Mbps\n");
                        break;
                    case ETHXCVR_SPEED_5000MBPS:
                        HOST_Log("Speed: 5000Mbps\n");
                        break;
                    default:
                        HOST_Log("Speed : Invalid\n");
                        break;
                    }
                    if ((pInfo.portInfo.phyMedia == ETHXCVR_PHYMEDIA_10BASET1) ||
                        (pInfo.portInfo.phyMedia == ETHXCVR_PHYMEDIA_100BASET1) ||
                        (pInfo.portInfo.phyMedia == ETHXCVR_PHYMEDIA_1000BASET1)) {
                        HOST_Log("BrMode : %s\n",
                                (pInfo.portInfo.masterEnable == ETHXCVR_BOOLEAN_TRUE) ?
                                "Master" : "Slave");
                    }
                    HOST_Log("JumboFrameMode : %s\n", (pInfo.portInfo.jumboEnable ==
                                ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
                    HOST_Log("LoopBackMode : %s\n", (pInfo.portInfo.loopbackEnable ==
                                ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
                    HOST_Log("Autoneg : %s\n", (pInfo.portInfo.autonegEnable ==
                                ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
                    switch (pInfo.portInfo.autonegComplete) {
                    case ETHXCVR_AUTONEGSTATUS_NO_ABILITY:
                        HOST_Log("AutonegComplete : No ability\n");
                        break;
                    case ETHXCVR_AUTONEGSTATUS_INCOMPLETE:
                        HOST_Log("AutonegComplete : Incomplete\n");
                        break;
                    case ETHXCVR_AUTONEGSTATUS_COMPLETE:
                        HOST_Log("AutonegComplete : Complete\n");
                        break;
                    default:
                        HOST_Log("AutonegComplete : Invalid\n");
                        break;
                    }
                    HOST_Log("Duplex : %s\n", (pInfo.portInfo.duplex ==
                                ETHXCVR_DUPLEXMODE_FULL) ? "Full" : "Half" );
                    HOST_Log("LED : %s\n", pInfo.portInfo.led ? "On" : "Off");
                    HOST_Log("LinkStateChangeCnt : %u\n", pInfo.portInfo.linkStateChangeCnt);
                    switch (pInfo.portInfo.busMode) {
                    case ETHXCVR_BUSMODE_INTG:
                        HOST_Log("Bus Mode : Integrated\n");
                        break;
                    case ETHXCVR_BUSMODE_RGMII:
                        HOST_Log("Bus Mode : RGMII\n");
                        break;
                    case ETHXCVR_BUSMODE_RVMII:
                        HOST_Log("Bus Mode : RVMII\n");
                        break;
                    case ETHXCVR_BUSMODE_RMII:
                        HOST_Log("Bus Mode : RMII\n");
                        break;
                    case ETHXCVR_BUSMODE_MII:
                        HOST_Log("Bus Mode : MII\n");
                        break;
                    case ETHXCVR_BUSMODE_SGMII:
                        HOST_Log("Bus Mode : SGMII\n");
                        break;
                    case ETHXCVR_BUSMODE_PCIE:
                        HOST_Log("Bus Mode : PCIE\n");
                        break;
                    default:
                        HOST_Log("Bus Mode: Unknown\n");
                        break;
                    }
                    switch (pInfo.portInfo.phyMedia) {
                    case ETHXCVR_PHYMEDIA_10BASET1:
                        HOST_Log("Phy Media : 10Base-T1\n");
                        break;
                    case ETHXCVR_PHYMEDIA_10BASET:
                        HOST_Log("Phy Media : 10Base-T\n");
                        break;
                    case ETHXCVR_PHYMEDIA_100BASET1:
                        HOST_Log("Phy Media : 100Base-T1\n");
                        break;
                    case ETHXCVR_PHYMEDIA_100BASETX:
                        HOST_Log("Phy Media : 100Base-Tx\n");
                        break;
                    case ETHXCVR_PHYMEDIA_1000BASET1:
                        HOST_Log("Phy Media : 1000Base-T1\n");
                        break;
                    case ETHXCVR_PHYMEDIA_1000BASET:
                        HOST_Log("Phy Media : 1000Base-T\n");
                        break;
                    case ETHXCVR_PHYMEDIA_1000BASEX:
                        HOST_Log("Phy Media : 1000Base-X\n");
                        break;
                    default:
                        break;
                    }
                    HOST_Log("LinkSQI : %u\n", pInfo.portInfo.linkSQI);
                    HOST_Log("PVID : %u\n", pInfo.portInfo.pvid);
                    HOST_Log("Prio : %u\n", pInfo.portInfo.prio);
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str, "mibs", 4)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if (rem_str != NULL) {
                    if (!strncmp(rem_str, "clear", 5)) {
                        HOST_SWTPortMibsClrType mibsClr;
                        mibsClr.cmdRsp.cmd = HOST_SWT_PORT_MIBS_CLR;
                        mibsClr.value1 = value1;
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mibsClr ,
                                                    sizeof(mibsClr), MGMT_CMD_STR_MAX_LEN,
                                                    1, &param);
                        if ((BCM_ERR_OK != retVal) || (mibsClr.cmdRsp.rsp)) {
                            HOST_Log("Failed to clear mibs for port=%u, retVal=%d\n", value1, mibsClr.cmdRsp.rsp);
                            rv = CMD_FAIL;
                        } else {
                            rv = CMD_OK;
                        }
                    } else {
                        goto done;
                    }
                } else if (rem_str_len != 0) {
                    goto done;
                } else {
                        HOST_SWTPortMibsType mibs;
                        mibs.cmdRsp.cmd = HOST_SWT_PORT_MIBS;
                        mibs.value1 = value1;
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mibs ,
                                                    sizeof(mibs), MGMT_CMD_STR_MAX_LEN,
                                                    1, &param);
                    /* rem_str==NULL and rem_str_len==0 */
                    if ((BCM_ERR_OK != retVal) || (mibs.cmdRsp.rsp)) {
                        HOST_Log("Failed to retrieve mibs for port=%u, retVal=%d\n", value1, mibs.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        show_switch_mibs(&mibs.mibs);
                        rv = CMD_OK;
                    }
                }
            }
        } else if (!strncmp(curr_str, "read", 4)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_SWTRegReadType swtRegRd = {{0}};
            swtRegRd.cmdRsp.cmd = HOST_SWT_REG_READ;
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            /* Fetch the address to be read */
            value1 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            value2 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            if (MCU_DEVICE_SLAVE_1 < value2) {
                goto done;
            }

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str != NULL) || (rem_str_len != 0)) {
                goto done;
            }
            swtRegRd.value2 = value2;
            swtRegRd.value1 = value1;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &swtRegRd ,
                                             sizeof(swtRegRd), MGMT_CMD_STR_MAX_LEN, 1, &param);
//            retVal = HOST_EtherSwtRegRead(info, value2, value1, 1UL, &u64Val);
            if ((BCM_ERR_OK != retVal) || (swtRegRd.cmdRsp.rsp)) {
                HOST_Log("Error in switch read 0x%x\n", swtRegRd.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
                HOST_Log("0x%016" PRIX64 "\n", swtRegRd.u64Val);
            }
         } else if (!strncmp(curr_str, "write", 5)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_SWTRegWriteType swtRegWr = {{0}};
            swtRegWr.cmdRsp.cmd = HOST_SWT_REG_WRITE;
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            /* Fetch the address */
            value1 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            /* Fetch dataHigh*/
            value2 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            /* Fetch dataLow */
            value3 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            u64Val = ((uint64_t)value2 << 32UL) | value3;

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            value2 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            if (MCU_DEVICE_SLAVE_1 < value2) {
                goto done;
            }

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str != NULL) || (rem_str_len != 0)) {
                goto done;
            }
            swtRegWr.value2 = value2;
            swtRegWr.value1 = value1;
            swtRegWr.u64Val = u64Val;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &swtRegWr ,
                                        sizeof(swtRegWr), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (swtRegWr.cmdRsp.rsp)) {
                HOST_Log("Error in switch write 0x%x\n", swtRegWr.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "cl", 2)) { /* cl22 and cl45 parsers */
            HOST_SWTMDIOType mdioRdWr;
            if (!strncmp(curr_str, "cl22", 4)) {
                mdioRdWr.access = ETHER_MDIOREGACCESS_CL22;
            } else if (!strncmp(curr_str, "cl45", 4)) {
                mdioRdWr.access = ETHER_MDIOREGACCESS_CL45;
            } else {
                goto done;
            }

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }

            if (!strncmp(curr_str, "read", 4)) {
                write = 0;
            } else if (!strncmp(curr_str, "write", 5)) {
                write = 1;
            } else {
                goto done;
            }

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            /* Fetch the mdio hw ID into value2 */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            mdioRdWr.value2 = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            /* Fetch the phy address into phy */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            mdioRdWr.phy = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            if (ETHER_MDIOREGACCESS_CL45 == mdioRdWr.access) {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                /* Fetch the dev address into dev */
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                mdioRdWr.dev = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            }

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            /* Fetch the register address into u16Val */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            mdioRdWr.u16Val = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;

            if (write == 0) {
                mdioRdWr.cmdRsp.cmd = HOST_SWT_MDIO_READ;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                /* Fetch device[master or slave] into value1 */
                mdioRdWr.value1 = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mdioRdWr ,
                                            sizeof(mdioRdWr), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (mdioRdWr.cmdRsp.rsp)) {
                    HOST_Log("Error in read function err:0x%x\n", mdioRdWr.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                    HOST_Log("0x%04X\n", mdioRdWr.u16Val2);
                }
            } else {
                mdioRdWr.cmdRsp.cmd = HOST_SWT_MDIO_WRITE;
                /* Fetch register value into u16val2 */
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                mdioRdWr.u16Val2 = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                /* Fetch device[master or slave] into value1 */
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                mdioRdWr.value1  = parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mdioRdWr ,
                                            sizeof(mdioRdWr), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (mdioRdWr.cmdRsp.rsp)) {
                    HOST_Log("Error in memory write 0x%x\n", mdioRdWr.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        } else if (!strncmp(curr_str, "age_time", 8)){
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) && (rem_str_len == 0)
                    && (!strncmp(curr_str,"get", 3))) {
                HOST_SWTAgeTimeType ageTimeGet;
                ageTimeGet.cmdRsp.cmd = HOST_SWT_AGE_TIME_GET;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &ageTimeGet ,
                                            sizeof(ageTimeGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (ageTimeGet.cmdRsp.rsp)) {
                    rv = CMD_FAIL;
                    HOST_Log("Failed to get AGE time, retVal = %d\n", ageTimeGet.cmdRsp.rsp);
                }else {
                    HOST_Log("Switch FDB age timeout (secs) =%d\n",ageTimeGet.value1);
                    rv = CMD_OK;
                }
            } else if ((rem_str != NULL) && (rem_str_len != 0)
                    && (!strncmp(curr_str,"set", 3))) {
                HOST_SWTAgeTimeType ageTimeSet;
                ageTimeSet.cmdRsp.cmd = HOST_SWT_AGE_TIME_SET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port bitmap */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                ageTimeSet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &ageTimeSet ,
                                                sizeof(ageTimeSet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                if ((BCM_ERR_OK != retVal) || (ageTimeSet.cmdRsp.rsp)) {
                    rv = CMD_FAIL;
                    HOST_Log("Failed to set AGE time, retVal = %d\n", ageTimeSet.cmdRsp.rsp);
                } else {
                    HOST_Log("Switch FDB age timeout set to = %d secs\n",ageTimeSet.value1);
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "dumbfwd", 7)){
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) && (rem_str_len == 0)
                    && (!strncmp(curr_str,"get", 3))) {
                HOST_SWTDmbFwdType dmbFwdGet;
                dmbFwdGet.cmdRsp.cmd = HOST_SWT_DMBFWD_GET;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &dmbFwdGet ,
                                            sizeof(dmbFwdGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (dmbFwdGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get P8 Dumb Forwarding  Mode, retVal = %d\n", dmbFwdGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    HOST_Log("P8 Dumb Forwarding is %s\n", (dmbFwdGet.value1 == ETHSWT_DUMBFWD_ENABLE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            } else if ((rem_str != NULL) && (rem_str_len != 0)
                    && (!strncmp(curr_str,"set", 3))) {
                HOST_SWTDmbFwdType dmbFwdSet;
                dmbFwdSet.cmdRsp.cmd = HOST_SWT_DMBFWD_SET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if (!strncmp(curr_str,"enable", 6)) {
                    value1 = ETHSWT_DUMBFWD_ENABLE;
                } else if (!strncmp(curr_str,"disable", 7)) {
                    value1 = ETHSWT_DUMBFWD_DISABLE;
                } else {
                    goto done;
                }
                dmbFwdSet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &dmbFwdSet ,
                                            sizeof(dmbFwdSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (dmbFwdSet.cmdRsp.rsp)) {
                    rv = CMD_FAIL;
                    HOST_Log("Failed to set P8 Dumb Forward mode, retVal = %d\n", dmbFwdSet.cmdRsp.rsp);
                } else {
                    HOST_Log("P8 Dumb Forwarding %s\n", (dmbFwdSet.value1 == ETHSWT_DUMBFWD_ENABLE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "brcmhdr", 7)){
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) && (rem_str_len == 0)
                    && (!strncmp(curr_str,"get", 3))) {
                HOST_SWTBrcmHdrType brcmHdrGet;
                brcmHdrGet.cmdRsp.cmd = HOST_SWT_BRCMHDR_GET;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &brcmHdrGet ,
                                            sizeof(brcmHdrGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (brcmHdrGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get IMP Broadcom Header Mode, retVal = %d\n", brcmHdrGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    HOST_Log("IMP Broadcom Header Mode is %s\n", (brcmHdrGet.value1 == ETHSWT_BRCMHDR_ENABLE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            } else if ((rem_str != NULL) && (rem_str_len != 0)
                    && (!strncmp(curr_str,"set", 3))) {
                HOST_SWTBrcmHdrType brcmHdrSet;
                brcmHdrSet.cmdRsp.cmd = HOST_SWT_BRCMHDR_SET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if (!strncmp(curr_str,"enable", 6)) {
                    value1 = ETHSWT_BRCMHDR_ENABLE;
                } else if (!strncmp(curr_str,"disable", 7)) {
                    value1 = ETHSWT_BRCMHDR_DISABLE;
                } else {
                    goto done;
                }
                brcmHdrSet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &brcmHdrSet ,
                                            sizeof(brcmHdrSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (brcmHdrSet.cmdRsp.rsp)) {
                    rv = CMD_FAIL;
                    HOST_Log("Failed to set IMP Broadcom Header mode, retVal = %d\n", brcmHdrSet.cmdRsp.rsp);
                } else {
                    HOST_Log("IMP Broadcom Header mode %s\n", (brcmHdrSet.value1 == ETHSWT_BRCMHDR_ENABLE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "mgmtmode", 7)){
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) && (rem_str_len == 0)
                    && (!strncmp(curr_str,"get", 3))) {
                HOST_SWTMgmtModeType mgmtModeGet;
                mgmtModeGet.cmdRsp.cmd = HOST_SWT_MGMTMODE_GET;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mgmtModeGet ,
                                            sizeof(mgmtModeGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (mgmtModeGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get Management Mode, retVal = %d\n", mgmtModeGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    HOST_Log("Management Mode is %s\n", (mgmtModeGet.value1 == ETHSWT_MGMTMODE_ENABLE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            } else if ((rem_str != NULL) && (rem_str_len != 0)
                    && (!strncmp(curr_str,"set", 3))) {
                HOST_SWTMgmtModeType mgmtModeSet;
                mgmtModeSet.cmdRsp.cmd = HOST_SWT_MGMTMODE_SET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if (!strncmp(curr_str,"enable", 6)) {
                    value1 = ETHSWT_MGMTMODE_ENABLE;
                } else if (!strncmp(curr_str,"disable", 7)) {
                    value1 = ETHSWT_MGMTMODE_DISABLE;
                } else {
                    goto done;
                }
                mgmtModeSet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mgmtModeSet ,
                                            sizeof(mgmtModeSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (mgmtModeSet.cmdRsp.rsp)) {
                    rv = CMD_FAIL;
                    HOST_Log("Failed to set management mode, retVal = %d\n", mgmtModeSet.cmdRsp.rsp);
                } else {
                    HOST_Log("Management mode %s\n", (mgmtModeSet.value1 == ETHSWT_MGMTMODE_ENABLE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            }
        }else if (!strncmp(curr_str, "mirror", 6)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "enable", 6)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTMirrorEnType mirrorEn;
                mirrorEn.cmdRsp.cmd = HOST_SWT_MIRROR_EN;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                value1 = parse_integer(curr_str, &command_parse_status); /* port bitmap */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                value2 = parse_integer(curr_str, &command_parse_status); /* probe port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;

                if(!strncmp(curr_str, "ingress", 7)){
                    value3 = ETHSWT_TRAFFICDIR_INGRESS;
                }else if(!strncmp(curr_str, "egress", 6)){
                    value3 = ETHSWT_TRAFFICDIR_EGRESS;
                }else{
                    goto done;
                }

                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) && (rem_str_len != 0)) {
                    value4 = parse_integer(rem_str, &command_parse_status); /* packetDivider */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                }
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                mirrorEn.value1 = value1;
                mirrorEn.value2 = value2;
                mirrorEn.value3 = value3;
                mirrorEn.value4 = value4;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mirrorEn ,
                                            sizeof(mirrorEn), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (mirrorEn.cmdRsp.rsp)) {
                    HOST_Log("Failed to enable mirroring mode, retVal = %d\n", mirrorEn.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }else if (!strncmp(curr_str,"disable", 7)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                HOST_SWTMirrorDisType mirrorDis;
                mirrorDis.cmdRsp.cmd = HOST_SWT_MIRROR_DIS;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mirrorDis ,
                                           sizeof(mirrorDis), MGMT_CMD_STR_MAX_LEN,
                                           1, &param);
                if ((BCM_ERR_OK != retVal) || (mirrorDis.cmdRsp.rsp)) {
                    HOST_Log("Failed to disable mirroring mode, retVal = %d\n", mirrorDis.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }else if (!strncmp(curr_str, "status", 6)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                HOST_SWTMirrorStatusType mirrorStat;
                mirrorStat.cmdRsp.cmd = HOST_SWT_MIRROR_STATUS;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mirrorStat ,
                                            sizeof(mirrorStat), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (mirrorStat.cmdRsp.rsp)) {
                    HOST_Log("Failed to get mirror status, retVal = %d\n", mirrorStat.cmdRsp.rsp);
                    rv = CMD_FAIL;
                    goto done;
                }
                rv = CMD_OK;
                if (mirrorStat.mirrorState == ETHSWT_PORTMIRRORSTATE_ENABLED) {
                    HOST_Log("Mirroring is enabled for ingress_port_bitmap=0x%x, egress_port_bitmap=0x%x and probe_port=%d\n",
                             mirrorStat.u16Val, mirrorStat.u16Val2, mirrorStat.value1);
                } else {
                    HOST_Log("Mirroring is disabled\n");
                }
            }
        }else if (!strncmp(curr_str, "admin_mode", 10)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str,"get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTAdmnGetType adminGet;
                adminGet.cmdRsp.cmd = HOST_SWT_ADMIN_GET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                adminGet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &adminGet ,
                                            sizeof(adminGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (adminGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get admin mode, retVal = %d\n", adminGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    HOST_Log("Admin mode: %s\n", (adminGet.mode == ETHXCVR_MODE_ACTIVE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str,"set", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTAdminSetType adminSet;
                adminSet.cmdRsp.cmd = HOST_SWT_ADMIN_SET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if(!strncmp(curr_str,"enable", 6)) {
                    value2 = ETHXCVR_MODE_ACTIVE;
                }else if(!strncmp(curr_str,"disable", 7)) {
                    value2 = ETHXCVR_MODE_DOWN;
                }else{
                    HOST_Log("port admin_mode set <port> <disable|enable>\n");
                    goto done;
                }
                adminSet.value1 = value1;
                adminSet.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &adminSet ,
                                            sizeof(adminSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (adminSet.cmdRsp.rsp)) {
                    HOST_Log("Failed to set admin mode, ret = %d\n", adminSet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "speed", 5)){
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str,"get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTSpeedGetType speedGet;
                speedGet.cmdRsp.cmd = HOST_SWT_SPEED_GET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                speedGet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &speedGet ,
                                            sizeof(speedGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (speedGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get speed, retVal = %d\n", speedGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    rv = CMD_OK;
                    switch (speedGet.speed) {
                    case ETHXCVR_SPEED_10MBPS:
                        HOST_Log("Speed: 10mbps\n");
                        break;
                    case ETHXCVR_SPEED_100MBPS:
                        HOST_Log("Speed: 100mbps\n");
                        break;
                    case ETHXCVR_SPEED_1000MBPS:
                        HOST_Log("Speed: 1000mbps\n");
                        break;
                    case ETHXCVR_SPEED_2500MBPS:
                        HOST_Log("Speed: 2500mbps\n");
                        break;
                    case ETHXCVR_SPEED_5000MBPS:
                        HOST_Log("Speed: 5000mbps\n");
                        break;
                    default:
                        HOST_Log("Speed: Invalid\n");
                        rv = CMD_FAIL;
                        break;
                    }
                }
            }
        }else if (!strncmp(curr_str, "master_slave", 12)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str,"get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTMasterSlaveGetType modeGet;
                modeGet.cmdRsp.cmd = HOST_SWT_MASTERSLAVE_GET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                modeGet.value1 =  value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &modeGet ,
                                            sizeof(modeGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) ||
                       ((0UL != modeGet.cmdRsp.rsp) && (BCM_ERR_NOSUPPORT != modeGet.cmdRsp.rsp))) {
                    HOST_Log("Failed to get master/slave mode, retVal = %d\n", modeGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    rv = CMD_OK;
                    switch (modeGet.mode) {
                    case ETHXCVR_BOOLEAN_TRUE:
                        HOST_Log("Master/Slave: Master\n");
                        break;
                    case ETHXCVR_BOOLEAN_FALSE:
                        HOST_Log("Master/Slave: Slave\n");
                        break;
                    default:
                        HOST_Log("Master/Slave: Invalid\n");
                        rv = CMD_FAIL;
                        break;
                    }
                }
            } else if (!strncmp(curr_str,"set", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTMasterSlaveSetType modeSet;
                modeSet.cmdRsp.cmd = HOST_SWT_MASTERSLAVE_SET;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if (!strncmp(curr_str,"slave", 5)) {
                    value2 = ETHXCVR_BOOLEAN_FALSE;
                } else if (!strncmp(curr_str,"master", 6)) {
                    value2 = ETHXCVR_BOOLEAN_TRUE;
                } else {
                    HOST_Log("port master_slave set <port> <slave|master>\n");
                    goto done;
                }
                modeSet.value1 = value1;
                modeSet.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &modeSet ,
                                            sizeof(modeSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (modeSet.cmdRsp.rsp)) {
                    HOST_Log("Failed to set BR mode, ret = %d\n", modeSet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "phy_lb_mode", 11)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str,"get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTPhyLBGetType phyLBGet;
                phyLBGet.cmdRsp.cmd = HOST_SWT_PHYLB_GET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                phyLBGet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &phyLBGet ,
                                            sizeof(phyLBGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (phyLBGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get phy_lb mode, retVal = %d\n", phyLBGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    HOST_Log("Phy_lb mode: %s\n", (phyLBGet.mode == ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str,"set", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTPhyLBSetType phyLBSet;
                phyLBSet.cmdRsp.cmd = HOST_SWT_PHYLB_SET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if(!strncmp(curr_str,"enable", 6)) {
                    value2 = ETHXCVR_BOOLEAN_TRUE;
                } else if(!strncmp(curr_str,"disable", 7)) {
                    value2 = ETHXCVR_BOOLEAN_FALSE;
                } else {
                    HOST_Log("port phy_lb_mode set <port> <disable|enable>\n");
                    goto done;
                }
                phyLBSet.value1 = value1;
                phyLBSet.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &phyLBSet ,
                                            sizeof(phyLBSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (phyLBSet.cmdRsp.rsp)) {
                    HOST_Log("Failed to set phy loop back mode, ret = %d\n", phyLBSet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "jumbo_frame", 11)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str,"get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTJumboFrameGetType jumboFrameGet;
                jumboFrameGet.cmdRsp.cmd = HOST_SWT_JUMBOFRAME_GET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                jumboFrameGet.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &jumboFrameGet ,
                                            sizeof(jumboFrameGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (jumboFrameGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get jumbo frame mode, retVal = %d\n", jumboFrameGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }else{
                    HOST_Log("Jumbo frame mode: %s\n", (jumboFrameGet.jumbo == ETHXCVR_BOOLEAN_TRUE) ? "Enabled" : "Disabled");
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str,"set", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTJumboFrameSetType jumboFrameSet;
                jumboFrameSet.cmdRsp.cmd = HOST_SWT_JUMBOFRAME_SET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                if(!strncmp(curr_str,"enable", 6)) {
                    value2 = ETHXCVR_BOOLEAN_TRUE;
                } else if(!strncmp(curr_str,"disable", 7)) {
                    value2 = ETHXCVR_BOOLEAN_FALSE;
                } else {
                    HOST_Log("port jumbo_frame set <port> <disable|enable>\n");
                    goto done;
                }
                jumboFrameSet.value1 = value1;
                jumboFrameSet.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &jumboFrameSet ,
                                            sizeof(jumboFrameSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (jumboFrameSet.cmdRsp.rsp)) {
                    HOST_Log("Failed to set jumbo frame mode, ret = %d\n", jumboFrameSet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        }else if(!strncmp(curr_str, "link", 4)){
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "sqi", 3)) {
                value2 = 0;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    HOST_SWTPortInfoType sendPortCmd;
                    sendPortCmd.cmdRsp.cmd = HOST_SWT_PORT_INFO;
                    MGMT_AVB_TRACE_LINE(20);
                    HOST_Log("%7s %10s\n", "Port", "SQI");
                    MGMT_AVB_TRACE_LINE(20);
                    for(i = 0; i < MAX_NUM_PORTS; i++){
                        memset(&sendPortCmd.portInfo, 0x00, sizeof(ETHSWT_ExtPortInfoType));
                        sendPortCmd.value1 = i;
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendPortCmd ,
                                                    sizeof(sendPortCmd), MGMT_CMD_STR_MAX_LEN,
                                                    1, &param);
                        if ((BCM_ERR_OK == retVal) && ((BCM_ERR_OK != sendPortCmd.cmdRsp.rsp)
                                        || (sendPortCmd.portInfo.linkStatus == ETHXCVR_LINKSTATE_DOWN))) {
                            continue;
                        }
                        HOST_Log("%7d %10d\n", i, sendPortCmd.portInfo.linkSQI);
                    }
                    rv = CMD_OK;
                } else {
                    HOST_SWTLinkSqiGetType sqiGet;
                    sqiGet.cmdRsp.cmd = HOST_SWT_LINK_SQI_GET;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    value1 = parse_integer(curr_str, &command_parse_status);
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    sqiGet.value1 = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sqiGet ,
                                                sizeof(sqiGet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK == retVal) && (0UL == sqiGet.cmdRsp.rsp)) {
                        HOST_Log("Signal Quality Indicator(SQI) value of port %d is %d\n", sqiGet.value1, sqiGet.value2);
                        rv = CMD_OK;
                    } else {
                        rv = CMD_FAIL;
                    }
                }
            }
        } else if(!strncmp(curr_str, "arl", 3)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_SWTConvMacType sendMacConv;
            sendMacConv.cmdRsp.cmd = HOST_SWT_CONV_MAC;

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "add", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTARLAddType arlAdd;
                arlAdd.cmdRsp.cmd = HOST_SWT_ARL_ADD;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                sendMacConv.str[17]='\0';
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                            sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (sendMacConv.result)) {
                    HOST_Log("Invalid MAC retVal = %d \n",sendMacConv.result);
                    rv = CMD_FAIL;
                    goto done;
                }

                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                u16Val = parse_integer(curr_str, &command_parse_status); /* vlan */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                arlAdd.u16Val = u16Val;
                arlAdd.value1 = value1;
                memcpy(arlAdd.mac_addr, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &arlAdd ,
                                            sizeof(arlAdd), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (arlAdd.cmdRsp.rsp)) {
                    HOST_Log("Failed to add ARL\n");
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str, "del", 3)){
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTARLDelType arlDel;
                arlDel.cmdRsp.cmd = HOST_SWT_ARL_DEL;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                sendMacConv.str[17]='\0';
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                            sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (sendMacConv.result)) {
                    HOST_Log("Invalid MAC\n");
                    rv = CMD_FAIL;
                    goto done;
                }

                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                u16Val = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                arlDel.u16Val = u16Val;
                memcpy(arlDel.mac_addr, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &arlDel ,
                                            sizeof(arlDel), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOPERM == arlDel.cmdRsp.rsp)) {
                    HOST_Log("Permission denied to delete static ARL entry\n");
                    rv = CMD_FAIL;
                } else if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != arlDel.cmdRsp.rsp)){
                    HOST_Log("Failed to delete ARL entry, ret=%d\n", retVal);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str, "show", 4)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                retVal = mgmt_arl_show(sendMqd, recvMqd);
                if (retVal) {
                    HOST_Log("Failed to show ARL\n");
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
#ifdef ENABLE_ETHSWT_SECURITY
            } else if (!strncmp(curr_str, "port_limit", 10)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                if (!strncmp(curr_str,"get", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTAddressLimitType addrLimitGet;
                    addrLimitGet.cmdRsp.cmd = HOST_SWT_ADDRESS_LIMITING_GET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    value1 = parse_integer(curr_str, &command_parse_status); /* port */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                    addrLimitGet.port = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &addrLimitGet ,
                                                sizeof(addrLimitGet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (addrLimitGet.cmdRsp.rsp)) {
                        HOST_Log("Failed to get port port_limit info, retVal = %d\n", addrLimitGet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log("port_limit action  : ");
                        security_action_to_string(addrLimitGet.overLimitAction);
                        HOST_Log("limit              : %hu\n", addrLimitGet.macLearningLimit);
                        HOST_Log("LearnedCounter     : %hu\n", addrLimitGet.portLearnedCounter);
                        HOST_Log("OverLimitCounter   : %lu\n", addrLimitGet.portOverLimitCounter);
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str,"set", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTAddressLimitType addrLimitSet;
                    addrLimitSet.cmdRsp.cmd = HOST_SWT_ADDRESS_LIMITING_SET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    addrLimitSet.port = parse_integer(curr_str, &command_parse_status); /* port */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    addrLimitSet.overLimitAction = parse_integer(curr_str, &command_parse_status); /* action */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if(ETHSWT_SECURITY_ACTION_DISABLED == addrLimitSet.overLimitAction){
                        if ((rem_str != NULL) || (rem_str_len != 0)) {
                            goto done;
                        }
                    } else  {
                        if ((rem_str == NULL) || (rem_str_len == 0)) {
                            goto done;
                        }
                        curr_str = rem_str;
                        curr_str_len = rem_str_len;
                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str != NULL) || (rem_str_len != 0)) {
                            goto done;
                        }
                        addrLimitSet.macLearningLimit = parse_integer(curr_str, &command_parse_status); /* limit */
                        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                    }

                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &addrLimitSet ,
                                                sizeof(addrLimitSet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (addrLimitSet.cmdRsp.rsp)) {
                        HOST_Log("Failed to set port port_limit info, ret = %d\n", addrLimitSet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            } else if (!strncmp(curr_str, "sticky", 6)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                if (!strncmp(curr_str,"get", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTStickyMACType stickyMACGet;
                    stickyMACGet.cmdRsp.cmd = HOST_SWT_STICKY_MAC_ADDRESS_GET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    value1 = parse_integer(curr_str, &command_parse_status); /* port */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                    stickyMACGet.port = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &stickyMACGet ,
                                                sizeof(stickyMACGet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (stickyMACGet.cmdRsp.rsp)) {
                        HOST_Log("Failed to get sticky action, retVal = %d\n", stickyMACGet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log("sticky action : ");
                        security_action_to_string(stickyMACGet.stickyMACAction);
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str,"set", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTStickyMACType stickyMACSet;
                    stickyMACSet.cmdRsp.cmd = HOST_SWT_STICKY_MAC_ADDRESS_SET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    stickyMACSet.port = parse_integer(curr_str, &command_parse_status); /* port */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }

                    stickyMACSet.stickyMACAction = parse_integer(curr_str, &command_parse_status); /* action */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &stickyMACSet ,
                                                sizeof(stickyMACSet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (stickyMACSet.cmdRsp.rsp)) {
                        HOST_Log("Failed to set sticky action, ret = %d\n", stickyMACSet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            } else if (!strncmp(curr_str, "move_detect", 11)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                if (!strncmp(curr_str,"get", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTStationMovementType stationMoveGet;
                    stationMoveGet.cmdRsp.cmd = HOST_SWT_STATION_MOVE_DETECT_GET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    value1 = parse_integer(curr_str, &command_parse_status); /* port */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                    stationMoveGet.port = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &stationMoveGet ,
                                                sizeof(stationMoveGet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (stationMoveGet.cmdRsp.rsp)) {
                        HOST_Log("Failed to get move_detect action, retVal = %d\n", stationMoveGet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    }else{
                        HOST_Log("move_detect action : ");
                        security_action_to_string(stationMoveGet.stationMoveAction);
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str,"set", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTStationMovementType stationMoveSet;
                    stationMoveSet.cmdRsp.cmd = HOST_SWT_STATION_MOVE_DETECT_SET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    stationMoveSet.port = parse_integer(curr_str, &command_parse_status); /* port */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }

                    stationMoveSet.stationMoveAction = parse_integer(curr_str, &command_parse_status); /* action */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &stationMoveSet ,
                                                sizeof(stationMoveSet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (stationMoveSet.cmdRsp.rsp)) {
                        HOST_Log("Failed to set move_detect action, ret = %d\n", stationMoveSet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
        } else if (!strncmp(curr_str, "total_limit", 11)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str,"get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                HOST_SWTTotalMACLearningLimitType totalAddressLimitGet;
                totalAddressLimitGet.cmdRsp.cmd = HOST_SWT_TOTAL_ADDRESS_LIMIT_GET;

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &totalAddressLimitGet ,
                                            sizeof(totalAddressLimitGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (totalAddressLimitGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get total_limit info, retVal = %d\n", totalAddressLimitGet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    HOST_Log("totalMACLearningLimit:  %hu\n", totalAddressLimitGet.totalMACLearningLimit);
                    HOST_Log("totalLearnedCounter  :  %hu\n", totalAddressLimitGet.totalLearnedCounter);
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str,"set", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTTotalMACLearningLimitType totalAddressLimitSet;
                totalAddressLimitSet.cmdRsp.cmd = HOST_SWT_TOTAL_ADDRESS_LIMIT_SET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                totalAddressLimitSet.totalMACLearningLimit = parse_integer(curr_str, &command_parse_status); /* limit */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &totalAddressLimitSet ,
                                            sizeof(totalAddressLimitSet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (totalAddressLimitSet.cmdRsp.rsp)) {
                    HOST_Log("Failed to set total_limit info, ret = %d\n", totalAddressLimitSet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
#endif /* ENABLE_ETHSWT_SECURITY */
            }
        } else if(!strncmp(curr_str, "stream", 6)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "policer", 7)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if (!strncmp(curr_str, "add", 3)) {
                    HOST_SWTConvMacType sendMacConv;
                    HOST_SWTStreamPolicerAddType policerAdd;
                    sendMacConv.cmdRsp.cmd = HOST_SWT_CONV_MAC;
                    policerAdd.cmdRsp.cmd = HOST_SWT_STREAM_POLICER_ADD;
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                    memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                    sendMacConv.str[17]='\0';
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                                sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (sendMacConv.result)) {
                        HOST_Log("Invalid MAC\n");
                        rv = CMD_FAIL;
                        goto done;
                    }

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.u16Val = parse_integer(curr_str, &command_parse_status); /* vlan */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.rate = parse_integer(curr_str, &command_parse_status); /* rate */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.burst = parse_integer(curr_str, &command_parse_status); /* burst */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.src_mask = parse_integer(curr_str, &command_parse_status); /* src_mask */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.threshold = parse_integer(curr_str, &command_parse_status); /* threshold */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.interval = parse_integer(curr_str, &command_parse_status); /* interval */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.report = parse_integer(curr_str, &command_parse_status); /* report */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    policerAdd.block = parse_integer(curr_str, &command_parse_status); /* block */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    memcpy(policerAdd.mac_addr, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &policerAdd ,
                                                sizeof(policerAdd), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (policerAdd.cmdRsp.rsp)) {
                        HOST_Log("Failed to add stream policer\n");
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log("SUCCESS: Added stream policer id %u\n", policerAdd.streamIdx);
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "del", 3)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTStreamPolicerDelType policerDel;
                    policerDel.cmdRsp.cmd = HOST_SWT_STREAM_POLICER_DEL;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* stream index */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    policerDel.value1 = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &policerDel ,
                                                sizeof(policerDel), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (policerDel.cmdRsp.rsp)) {
                        HOST_Log("Failed to delete stream policer\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "block", 5)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTBlockStreamType blkStream;
                    blkStream.cmdRsp.cmd = HOST_SWT_BLOCK_STREAM;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* stream index */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    blkStream.value1 = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &blkStream ,
                                                sizeof(blkStream), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (blkStream.cmdRsp.rsp)) {
                        HOST_Log("Failed to block stream policer\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "resume", 6)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTResumeStreamType resStream;
                    resStream.cmdRsp.cmd = HOST_SWT_RESUME_STREAM;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* stream index */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    resStream.value1 = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &resStream ,
                                                sizeof(resStream), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (resStream.cmdRsp.rsp)) {
                        HOST_Log("Failed to delete stream policer\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "show", 4)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        HOST_SWTStreamPolicerSnapshotType snapshot;
                        snapshot.cmdRsp.cmd = HOST_SWT_STREAM_POLICER_SNAPSHOT;
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &snapshot ,
                                                    sizeof(snapshot), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if ((BCM_ERR_OK == retVal) &&  (BCM_ERR_OK == snapshot.cmdRsp.rsp)) {
                            rv = CMD_OK;
                            HOST_Log("======= Stream Policer Snapshot =====\n");
                            for (i = 0UL; i < ETHSWT_CFP_MAX_STREAM_POLICER_ENTRIES; ++i) {
                                if( 0U != (snapshot.snapshot.policer[i] & ETHSWT_CFPSTREAMPOLICERSTATE_VALID_MASK)) {
                                    HOST_Log("Stream ID %u: Static: %u Blocked: %u\n", i,
                                    (snapshot.snapshot.policer[i] & ETHSWT_CFPSTREAMPOLICERSTATE_STATIC_MASK) >> ETHSWT_CFPSTREAMPOLICERSTATE_STATIC_SHIFT,
                                    (snapshot.snapshot.policer[i] & ETHSWT_CFPSTREAMPOLICERSTATE_BLOCKED_MASK) >> ETHSWT_CFPSTREAMPOLICERSTATE_BLOCKED_SHIFT);
                                }
                            }
                        } else {
                            HOST_Log("Stream policer get snapshot failed, retVal = %d\n", snapshot.cmdRsp.rsp);
                            rv = CMD_FAIL;
                        }
                    } else {
                        /* parse stream index */
                        HOST_SWTStreamPolicerGetStatusType getStatus;
                        getStatus.cmdRsp.cmd = HOST_SWT_STREAM_POLICER_GET_STATUS;
                        value1 = parse_integer(rem_str, &command_parse_status);
                        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                        if (value1 >= ETHSWT_CFP_MAX_STREAM_POLICER_ENTRIES) {
                            HOST_Log("Stream policer index must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_STREAM_POLICER_ENTRIES-1UL);
                            rv = CMD_FAIL;
                            goto done;
                        }
                        getStatus.status.idx = value1;
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &getStatus ,
                                                    sizeof(getStatus), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == getStatus.cmdRsp.rsp)) {
                            rv = CMD_OK;
                            HOST_Log("Stream Idx:          %u\n", getStatus.status.idx);
                            HOST_Log("MAC Address:         %02x:%02x:%02x:%02x:%02x:%02x\n",
                                    getStatus.status.macAddress[0], getStatus.status.macAddress[1],
                                    getStatus.status.macAddress[2], getStatus.status.macAddress[3],
                                    getStatus.status.macAddress[4], getStatus.status.macAddress[5]);
                            HOST_Log("VLAN:                %u\n", getStatus.status.vlan);
                            HOST_Log("PortMask:            0x%x\n", getStatus.status.portMask);
                            HOST_Log("Blocked:             %s\n", (TRUE == getStatus.status.blocked) ? "TRUE": "FALSE");
                            HOST_Log("Static:              %s\n", (TRUE == getStatus.status.isStatic) ? "TRUE": "FALSE");
                            HOST_Log("InBand stats:        %u\n", getStatus.status.greenCntr);
                            HOST_Log("OutOfBand stats:     %u\n", getStatus.status.redCntr);
                        } else {
                            HOST_Log("Stream policer get failed, retVal = %d\n", getStatus.cmdRsp.rsp);
                            rv = CMD_FAIL;
                        }
                    }
                } else if (!strncmp(curr_str, "find", 4)) {
                    HOST_SWTConvMacType sendMacConv;
                    HOST_SWTStreamPolicerFindIdxType policerIdx;
                    sendMacConv.cmdRsp.cmd = HOST_SWT_CONV_MAC;
                    policerIdx.cmdRsp.cmd = HOST_SWT_STREAM_POLICER_FIND_IDX;
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                    memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                    sendMacConv.str[17]='\0';
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                                sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (sendMacConv.result)) {
                        HOST_Log("Invalid MAC\n");
                        rv = CMD_FAIL;
                        goto done;
                    }

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    u16Val = parse_integer(curr_str, &command_parse_status); /* vlan */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* srcMask */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    memcpy(policerIdx.mac_addr, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                    policerIdx.u16Val = u16Val;
                    policerIdx.value1 = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &policerIdx ,
                                                sizeof(policerIdx), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (policerIdx.cmdRsp.rsp)) {
                        HOST_Log("Failed to find stream policer\n");
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                        HOST_Log("SUCCESS: Stream policer index %u\n", policerIdx.value2);
                    }
                }
            }
        } else if(!strncmp(curr_str, "tc10", 4)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                if (!strncmp(curr_str, "wakeup_mode", 11)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTGetWakeUpModeType getWakeUpMode;
                    getWakeUpMode.cmdRsp.cmd = HOST_TC10_GET_WAKEUPMODE;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* Port index */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    getWakeUpMode.port = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &getWakeUpMode ,
                                                sizeof(getWakeUpMode), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (getWakeUpMode.cmdRsp.rsp)) {
                        HOST_Log("Failed to Get wakeup Mode\n");
                        rv = CMD_FAIL;
                    } else {
                        if(ETHXCVR_BOOLEAN_TRUE == getWakeUpMode.value1) {
                            HOST_Log("WakeUp Mode Enabled\n");
                        } else {
                            HOST_Log("WakeUp Mode Disabled\n");
                        }
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "wakeup_reason", 13)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTGetWakeUpReasonType getReason;
                    getReason.cmdRsp.cmd = HOST_TC10_GET_WAKEUP_REASON;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* Port index */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    getReason.port = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &getReason ,
                                                sizeof(getReason), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK != retVal) || (getReason.cmdRsp.rsp)) {
                        HOST_Log("Failed to Get wakeup reason\n");
                        rv = CMD_FAIL;
                    } else {
                        switch (getReason.value1) {
                            case ETHXCVR_WAKEUPREASON_NONE:
                                HOST_Log("No WakeUp Detected\n");
                                break;
                            case ETHXCVR_WAKEUPREASON_UNKNOWN:
                                HOST_Log("No WakeUp Reason Detected\n");
                                break;
                            case ETHXCVR_WAKEUPREASON_REMOTE:
                                HOST_Log(" WakeUp On Remote Request\n");
                                break;
                            case ETHXCVR_WAKEUPREASON_LOCAL:
                                HOST_Log("WakeUp On Local Request\n");
                                break;
                            case ETHXCVR_WAKEUPREASON_POWER_ON:
                                HOST_Log("PowerOn WakeUp Detected\n");
                                break;
                            case ETHXCVR_WAKEUPREASON_PIN:
                                HOST_Log("WakeUp On PIN \n");
                                break;
                            default:
                                break;
                        }
                        rv = CMD_OK;
                    }
                } else {
                    goto done;
                }
            } else {
                goto done;
            }
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
        } else if(!strncmp(curr_str, "fa", 2)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "flow", 4)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if (!strncmp(curr_str, "add", 3)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }

                    HOST_SWTFAFlowAddType flowAdd;
                    flowAdd.cmdRsp.cmd = HOST_SWT_FA_ADD_FLOW;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    rv = CMD_OK;

                    buffer = buffer_from_file(curr_str, &buf_size);
                    if (buffer != NULL) {
                        memcpy(&faCfg, buffer, buf_size);
                        free(buffer);
                        buffer = NULL;
                    } else {
                        HOST_Log("ERROR: %d: Invalid Buffer \n",BCM_ERR_UNKNOWN);
                        goto done;
                    }

                    HOST_SWTFAMACSnapshotType macSnap;
                    macSnap.cmdRsp.cmd = HOST_SWT_FA_GET_MAC;

                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &macSnap ,
                                                sizeof(macSnap), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                        goto done;
                    } else if (BCM_ERR_OK != macSnap.cmdRsp.rsp) {
                        HOST_Log("ERROR: %d: Failed to get the MAC SnapShot for Flow Add\n", macSnap.cmdRsp.rsp);
                        rv = CMD_FAIL;
                        goto done;
                    } else {
                        /* Do Nothing */
                    }

                    memcpy(&faMac[0UL],&faCfg.macGroup[0UL],sizeof(ETHSWT_FAMacGroupType));
                    noOfDev = 1U;   /* Slave Device is not avilable */
                    /* Check if the device had Slave */
                    if(0UL != memcmp(macZero,&macSnap.snap.deviceMac[1U][0U],6)) {
                        memcpy(&faMac[1UL],&faCfg.macGroup[1UL],sizeof(ETHSWT_FAMacGroupType));
                        noOfDev = 2U;    /* Slave Device is avilable */
                    }
                    /* Check if any MAC Address is empty in config then replace with device 1 MAC */
                    for(devMac=0UL; devMac < faCfg.macGroup[0UL].count; devMac++){
                        if(0UL == memcmp(macZero,&faMac[0UL].info[devMac].mac[0UL],6UL)) {
                            memcpy(&faMac[0UL].info[devMac].mac[0UL], &macSnap.snap.deviceMac[0U][0U], 6UL);
                        }
                    }
                    if(2U == noOfDev) {
                        /* Check if any MAC Address is empty in config then replace with device 2 MAC */
                        for(dev=0UL; dev < faCfg.macGroup[1UL].count; dev++){
                            if(0UL == memcmp(macZero,&faMac[1UL].info[dev].mac[0UL],6UL)) {
                                memcpy(&faMac[1UL].info[dev].mac[0UL], &macSnap.snap.deviceMac[1U][0U], 6UL);
                            }
                        }
                         /* Check if MAC from one Device exists in other Device */
                        for(dev=0UL; dev < faCfg.macGroup[1UL].count; dev++) {
                            for(devMac=0UL; devMac < faCfg.macGroup[0UL].count; devMac++) {
                                if(0UL == memcmp(&faMac[0UL].info[devMac].mac[0UL],&faMac[1UL].info[dev].mac[0UL],6U)) {
                                    HOST_Log("ERROR: %d: Mac ID Present in other Group\n",BCM_ERR_UNKNOWN);
                                    rv = CMD_FAIL;
                                    goto done;
                                }
                            }
                        }
                    }

                    HOST_SWTFAMacOpType macAdd;
                    macAdd.cmdRsp.cmd = HOST_SWT_FA_ADD_MAC;

                    /* dev: device number */
                    for(dev = 0U; dev < noOfDev; dev++) {
                        /* Check if there are enough available MAC Entries in Device to add New Entry*/
                        availableEntriesDev[dev] =0U;
                        matchedEntriesDev[dev]   =0U;
                        /* Check for Empty MAC Entries */
                        for(devMac=0UL; devMac < ETHSWT_FA_POOL_MAX; devMac++){
                            if(0UL == memcmp(macZero,&macSnap.snap.info[dev][devMac].mac[0UL],6UL)) {
                                availableEntriesDev[dev]++;
                            }
                        }

                        /* Check for matching MAC Entries */
                        for(devMac=0UL; devMac < faCfg.macGroup[dev].count; devMac++){
                            for(i=0; i<ETHSWT_FA_POOL_MAX; i++) {
                                if(0UL == memcmp(&faMac[dev].info[devMac].mac[0UL],&macSnap.snap.info[dev][i].mac[0UL],6UL)) {
                                    matchedEntriesDev[dev]++;
                                }
                            }
                        }

                        /* If there is no sufficient space to add all New Entries Report Error*/
                        if(availableEntriesDev[dev] < (faCfg.macGroup[dev].count - matchedEntriesDev[dev])) {
                            HOST_Log("ERROR: %d: Insufficient space to add New Entries in device %d\n",BCM_ERR_UNKNOWN,dev);
                            goto done;
                        }
                    }

                    /* dev: device number */
                    for(dev = 0U; dev < noOfDev; dev++) {
                        /* Start Adding Mac Address */
                        for(devMac=0UL; devMac < faCfg.macGroup[dev].count; devMac++) {
                            macAdd.macOp.mstSlvDevice = dev;
                            macAdd.macOp.info.external = faMac[dev].info[devMac].external;
                            memcpy(&macAdd.macOp.info.mac[0],&faMac[dev].info[devMac].mac[0UL],6UL);

                            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &macAdd ,
                                                        sizeof(macAdd), MGMT_CMD_STR_MAX_LEN, 1, &param);
                            if ((BCM_ERR_OK == retVal) && (BCM_ERR_CUSTOM == macAdd.cmdRsp.rsp)){
                                /* Do Nothing. MAC is already exist */
                            } else if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOMEM == macAdd.cmdRsp.rsp)){
                                HOST_Log("ERROR: %d: No memory available to add a new entry for Flow Add\n", macAdd.cmdRsp.rsp);
                                rv = CMD_FAIL;
                                goto done;
                            } else if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOPERM == macAdd.cmdRsp.cmd)) {
                                HOST_Log("ERROR: %d: No permission to overwrite existing MAC for Flow Add\n", macAdd.cmdRsp.rsp);
                                rv = CMD_FAIL;
                                goto done;
                            } else if (BCM_ERR_OK != retVal) {
                                HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                                rv = CMD_FAIL;
                                goto done;
                            } else if (BCM_ERR_OK != macAdd.cmdRsp.rsp){
                                HOST_Log("ERROR: %d: Failed to Add MAC for Flow Add\n", macAdd.cmdRsp.rsp);
                                rv = CMD_FAIL;
                                goto done;
                            } else {
                                /* Do Nothing */
                            }
                        }
                    }

                    /* Add Flows */
                    for(flow=0UL; flow < faCfg.flowCount; flow++) {
                        /* If match.da is '0's' then add device(flow.mstSlvDevice) MAC Address */
                        if(0UL == memcmp(macZero,&faCfg.flow[flow].match.da[0],6)) {
                            memcpy(&faCfg.flow[flow].match.da[0], &macSnap.snap.deviceMac[faCfg.flow[flow].mstSlvDevice][0U], 6UL);
                        }
                        /* If flow match.da is '0's' then add device(flow.mstSlvDevice) MAC Address */
                        if(0UL == memcmp(macZero,&faCfg.flow[flow].remap.sa[0],6)) {
                            memcpy(&faCfg.flow[flow].remap.sa[0], &macSnap.snap.deviceMac[faCfg.flow[flow].mstSlvDevice][0U], 6UL);
                        }

                        /* Copy the Flow */
                        memcpy(&flowAdd.flow, &faCfg.flow[flow], sizeof(ETHSWT_FAFlowDataType));
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &flowAdd ,
                                sizeof(flowAdd), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if (BCM_ERR_OK != retVal) {
                            HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                            rv = CMD_FAIL;
                            goto done;
                        } else if (BCM_ERR_OK != flowAdd.cmdRsp.rsp) {
                            if(BCM_ERR_INVAL_BUF_STATE == flowAdd.cmdRsp.rsp) {
                                HOST_Log("ERROR: %d: Invalid File or File Not Found\n",BCM_ERR_UNKNOWN);
                            } else {
                                HOST_Log("ERROR: %d: Fail to add Flow\n",flowAdd.cmdRsp.rsp);
                            }
                            rv = CMD_FAIL;
                        } else {
                            HOST_Log("Flow added successfully. Flow ID is %d \n",flowAdd.flowID);
                            rv = CMD_OK;
                        }
                    }
                }
                if (!strncmp(curr_str, "delete", 6)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTFAFlowDelType flowDel;
                    flowDel.cmdRsp.cmd = HOST_SWT_FA_DEL_FLOW;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* flowID */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    flowDel.flowID = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &flowDel ,
                                                sizeof(flowDel), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                        goto done;
                    } else if (BCM_ERR_OK != flowDel.cmdRsp.rsp){
                        HOST_Log("ERROR: %d: Failed to delete the Flow\n",BCM_ERR_UNKNOWN);
                        rv = CMD_FAIL;
                        goto done;
                    } else {
                        rv = CMD_OK;
                    }
                }
                else if (!strncmp(curr_str, "get", 3)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }

                    HOST_SWTFAFlowGetType flowGet;
                    flowGet.cmdRsp.cmd = HOST_SWT_FA_GET_FLOW;
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    value1 = parse_integer(curr_str, &command_parse_status); /* flowID */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    flowGet.flowID = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &flowGet ,
                                                sizeof(flowGet), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                        goto done;
                    } else if (BCM_ERR_OK != flowGet.cmdRsp.rsp){
                        HOST_Log("ERROR: %d: Failed to get the Flow\n",BCM_ERR_UNKNOWN);
                        rv = CMD_FAIL;
                        goto done;
                    } else {
                        PrintFAFlow(&flowGet.flow, &flowGet.stats);
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "status", 6)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }

                    HOST_SWTFAFlowStatusType faStatus;
                    faStatus.cmdRsp.cmd = HOST_SWT_FA_GET_FLOW_STATUS;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    /* Chek if attribute is usemac */
                    if (!strncmp(curr_str, "usemac", 6)) {
                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str == NULL) || (rem_str_len == 0)) {
                            goto done;
                        }

                        curr_str = rem_str;
                        curr_str_len = rem_str_len;
                        HOST_SWTConvMacType sendMacConv;
                        sendMacConv.cmdRsp.cmd = HOST_SWT_CONV_MAC;

                        memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                        memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                        sendMacConv.str[17]='\0';

                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str == NULL) || (rem_str_len == 0)) {
                            goto done;
                        }

                        curr_str = rem_str;
                        curr_str_len = rem_str_len;
                        faStatus.status.mstSlvDevice = parse_integer(curr_str, &command_parse_status);
                        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str != NULL) || (rem_str_len != 0)) {
                            goto done;
                        }

                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                                    sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if (BCM_ERR_OK != retVal) {
                            HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                            rv = CMD_FAIL;
                            goto done;
                        } else if (BCM_ERR_OK != sendMacConv.result){
                            HOST_Log("ERROR: %d: Invalid MAC\n",BCM_ERR_UNKNOWN);
                            rv = CMD_FAIL;
                            goto done;
                        } else {
                            memcpy(faStatus.status.mac, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                            faStatus.status.attribute = ETHSWT_FAATTRIBUTE_MAC_USE;
                        }
                    } else if (!strncmp(curr_str, "active", 5)) {
                        /* Chek if attribute is active */
                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str == NULL) || (rem_str_len == 0)) {
                            goto done;
                        }
                        curr_str = rem_str;
                        curr_str_len = rem_str_len;
                        faStatus.status.mstSlvDevice = parse_integer(curr_str, &command_parse_status);
                        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str != NULL) || (rem_str_len != 0)) {
                            goto done;
                        }
                        faStatus.status.attribute = ETHSWT_FAATTRIBUTE_ACTIVE;
                    } else if (!strncmp(curr_str, "static", 6)) {
                        /* Chek if attribute is static */
                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str == NULL) || (rem_str_len == 0)) {
                            goto done;
                        }
                        curr_str = rem_str;
                        curr_str_len = rem_str_len;
                        faStatus.status.mstSlvDevice = parse_integer(curr_str, &command_parse_status);
                        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                        if ((rem_str != NULL) || (rem_str_len != 0)) {
                            goto done;
                        }
                        faStatus.status.attribute = ETHSWT_FAATTRIBUTE_STATIC;
                    } else {
                        goto done;
                    }
                    memset(faStatus.status.mask, 0x00, sizeof(faStatus.status.mask));
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &faStatus ,
                                                sizeof(faStatus), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                    } else if (BCM_ERR_OK != faStatus.cmdRsp.rsp) {
                        HOST_Log("ERROR: %d: Failed to get Flow status\n",BCM_ERR_UNKNOWN);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                        PrintFAFlowStatus(&faStatus.status);
                    }
                }
            } else if (!strncmp(curr_str, "stats", 5)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                HOST_SWTFAStatsType faStats;
                faStats.cmdRsp.cmd = HOST_SWT_FA_GET_GLOBAL_STATS;

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &faStats ,
                                            sizeof(faStats), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if (BCM_ERR_OK != retVal) {
                    HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                    rv = CMD_FAIL;
                } else if(BCM_ERR_OK != faStats.cmdRsp.rsp) {
                    HOST_Log("ERROR: %d: Failed to get FA stats\n",BCM_ERR_UNKNOWN);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                    PrintFAGlobalStats(&faStats.stats);
                }
            } else if (!strncmp(curr_str, "mac", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                HOST_SWTConvMacType sendMacConv;
                sendMacConv.cmdRsp.cmd = HOST_SWT_CONV_MAC;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if (!strncmp(curr_str, "add", 3)) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTFAMacOpType macAdd;
                    macAdd.cmdRsp.cmd = HOST_SWT_FA_ADD_MAC;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                    memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                    sendMacConv.str[17]='\0';
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                                sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                        goto done;
                    } else if (BCM_ERR_OK != sendMacConv.result){
                        HOST_Log("ERROR: %d: Invalid MAC\n",BCM_ERR_UNKNOWN);
                        rv = CMD_FAIL;
                        goto done;
                    } else {
                        /* Do Nothing */
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }

                    if (!strncmp(curr_str, "external", 8)) {
                        macAdd.macOp.info.external = TRUE;
                    } else if (!strncmp(curr_str, "internal", 8)) {
                        macAdd.macOp.info.external = FALSE;
                    } else {
                        goto done;
                    }

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }

                    u32Val = parse_integer(curr_str, &command_parse_status); /* Master/Slave */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    memcpy(macAdd.macOp.info.mac, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                    macAdd.macOp.mstSlvDevice = u32Val;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &macAdd ,
                                                sizeof(macAdd), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOMEM == macAdd.cmdRsp.rsp)){
                        HOST_Log("ERROR: %d: No memory available to add a new entry.\n", macAdd.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else if ((BCM_ERR_OK == retVal) && (BCM_ERR_CUSTOM == macAdd.cmdRsp.rsp)) {
                        HOST_Log("ERROR: %d: MAC is already exists in the Group\n",BCM_ERR_UNKNOWN);
                        rv = CMD_FAIL;
                    } else if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOPERM == macAdd.cmdRsp.rsp)) {
                        HOST_Log("ERROR: %d: No permission to overwrite existing MAC\n", macAdd.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    }else if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                    }else if (BCM_ERR_OK != macAdd.cmdRsp.rsp){
                        HOST_Log("ERROR: %d: Failed to Add MAC\n", macAdd.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log("MAC Entry Added Successfully\n");
                        rv = CMD_OK;
                    }
                } else if ((!strncmp(curr_str, "delete", 6)) || (!strncmp(curr_str, "force_delete", 12))) {
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTFAMacOpType macDel;
                    if(!strncmp(curr_str, "delete", 6)) {
                        macDel.cmdRsp.cmd = HOST_SWT_FA_DEL_MAC;
                    } else {
                        macDel.cmdRsp.cmd = HOST_SWT_FA_DEL_MAC_FORCE;
                    }

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    memset(sendMacConv.str, 0x00, sizeof(sendMacConv.str));
                    memcpy(sendMacConv.str, curr_str, sizeof(sendMacConv.str));
                    sendMacConv.str[17]='\0';
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &sendMacConv ,
                                                sizeof(sendMacConv), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                        goto done;
                    } else if (BCM_ERR_OK != sendMacConv.result){
                        HOST_Log("ERROR: %d: Invalid MAC\n",BCM_ERR_UNKNOWN);
                        rv = CMD_FAIL;
                        goto done;
                    } else {
                        /* Do Nothing */
                    }
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                    u32Val = parse_integer(curr_str, &command_parse_status); /* Master/Slave */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    macDel.macOp.mstSlvDevice = u32Val;
                    memcpy(macDel.macOp.info.mac, sendMacConv.mac_addr, sizeof(sendMacConv.mac_addr));
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &macDel ,
                                                sizeof(macDel), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK == retVal) && (BCM_ERR_BUSY == macDel.cmdRsp.rsp)){
                        if(BCM_ERR_BUSY == macDel.cmdRsp.cmd) {
                            HOST_Log("ERROR: %d: Cannot be deleted. It is in Use\n",BCM_ERR_UNKNOWN);
                        } else {
                            HOST_Log("ERROR: %d: Cannot be deleted. It is in Static\n",BCM_ERR_UNKNOWN);
                        }
                        rv = CMD_FAIL;
                    } else if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOT_FOUND == macDel.cmdRsp.rsp)) {
                        HOST_Log("ERROR: %d: Entry not found\n");
                        rv = CMD_FAIL;
                    } else if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                    } else if (BCM_ERR_OK != macDel.cmdRsp.rsp){
                        HOST_Log("ERROR: %d: Failed to delete MAC\n", macDel.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log("Entry Deleted Successfully\n");
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str, "snapshot", 8)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }

                    HOST_SWTFAMACSnapshotType macSnap;
                    macSnap.cmdRsp.cmd = HOST_SWT_FA_GET_MAC;

                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &macSnap ,
                                                sizeof(macSnap), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                    } else if (BCM_ERR_OK != macSnap.cmdRsp.rsp) {
                        HOST_Log("ERROR: %d: Failed to get the MAC SnapShot\n",macSnap.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                        PrintFAMACSnapShot(&macSnap.snap,0U);
                        if(0UL != memcmp(macZero,&macSnap.snap.deviceMac[1U][0U],6U)) {
                            PrintFAMACSnapShot(&macSnap.snap,1U);
                        }
                    }
                }
            } else if (!strncmp(curr_str, "reset", 5)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                HOST_SWTFAResetType faReset;
                faReset.cmdRsp.cmd = HOST_SWT_FA_RESET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                buffer = buffer_from_file(curr_str, &buf_size);
                if (buffer != NULL) {
                    memcpy(&faCfg, buffer, sizeof(ETHSWTM_FACfgType));
                    free(buffer);
                    buffer = NULL;
                } else {
                     HOST_Log("ERROR: %d: Invalid File or File Not Found\n",BCM_ERR_UNKNOWN);
                }

                memcpy(&faReset.ctf, &faCfg.ctf, sizeof(ETHSWT_FACtfCfgType));
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &faReset ,
                                sizeof(faReset), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if (BCM_ERR_OK != retVal) {
                    HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                    rv = CMD_FAIL;
                } else if (faReset.cmdRsp.rsp) {
                    HOST_Log("ERROR: Fail to Reset, ret= %d\n", faReset.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    HOST_Log("Reset Completed Successfully \n");
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str, "interrupt_enable", 16)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }

                HOST_SWTFAIntEnType faInt;
                faInt.cmdRsp.cmd = HOST_SWT_FA_INTERRUPT;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                }
                if (!strncmp(curr_str, "help", 4)) {
                    HOST_InterruptHelp();
                    rv = CMD_OK;
                } else {
                    value1 = parse_integer(curr_str, &command_parse_status); /* Interrupt Mask */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    faInt.intFlag = value1;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &faInt ,
                                                sizeof(faInt), MGMT_CMD_STR_MAX_LEN, 1, &param);
                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("ERROR: %d: Failed to send/receive Data\n",retVal);
                        rv = CMD_FAIL;
                    } else if (BCM_ERR_NOPERM == faInt.cmdRsp.rsp) {
                        HOST_Log("ERROR: %d: Not allowed in BYPASS Mode\n",faInt.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else if (faInt.cmdRsp.rsp) {
                        HOST_Log("ERROR: %d: Failed to set Interrupt Mask\n",faInt.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            }
#endif /* ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER */
        } else if(!strncmp(curr_str, "vlan", 3)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (!strncmp(curr_str, "get", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTVLANGetPortType vlanGet;
                vlanGet.cmdRsp.cmd = HOST_SWT_VLAN_PORT_GET;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                u16Val = parse_integer(curr_str, &command_parse_status); /* vlan */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                vlanGet.u16Val = u16Val;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &vlanGet ,
                                            sizeof(vlanGet), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (vlanGet.cmdRsp.rsp)) {
                    HOST_Log("Failed to get VLAN information retVal = %d\n", retVal);
                    rv = CMD_FAIL;
                }else{
                    rv = CMD_OK;
                    HOST_Log("VLAN %u PortMask : 0x%x\n", vlanGet.u16Val, vlanGet.value1);
                    HOST_Log("VLAN %u Tagged Port Mask: 0x%x\n", vlanGet.u16Val, vlanGet.value2);
                    HOST_Log("VLAN %u Static Port Mask: 0x%x\n", vlanGet.u16Val, vlanGet.value3);
                }
            } else if (!strncmp(curr_str, "add", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTVLANAddPortType vlanAdd;
                vlanAdd.cmdRsp.cmd = HOST_SWT_VLAN_PORT_ADD;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                u16Val = parse_integer(curr_str, &command_parse_status); /* vlan */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value1 = parse_integer(curr_str, &command_parse_status); /* portMask */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value2 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                vlanAdd.u16Val = u16Val;
                vlanAdd.value1 = value1;
                vlanAdd.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &vlanAdd ,
                                            sizeof(vlanAdd), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (vlanAdd.cmdRsp.rsp)) {
                    HOST_Log("Failed to add the port to the VLAN, ret = %d\n", vlanAdd.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            } else if (!strncmp(curr_str, "del", 3)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_SWTVLANDelPortType vlanDel;
                vlanDel.cmdRsp.cmd = HOST_SWT_VLAN_PORT_DEL;

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                u16Val = parse_integer(curr_str, &command_parse_status); /* vlan */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value1 = parse_integer(curr_str, &command_parse_status); /* portMask */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                vlanDel.u16Val = u16Val;
                vlanDel.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &vlanDel ,
                                            sizeof(vlanDel), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK == retVal) && (BCM_ERR_NOPERM == vlanDel.cmdRsp.rsp)) {
                    HOST_Log("Permission denied to delete static port from the VLAN\n");
                    rv = CMD_FAIL;
                } else if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != vlanDel.cmdRsp.rsp)){
                    HOST_Log("Failed to delete the port from the VLAN, ret = %d\n", vlanDel.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
#ifdef ENABLE_ETHSWT_SECURITY
            } else if (!strncmp(curr_str, "hop_detect", 10)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                if (!strncmp(curr_str,"get", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }
                    HOST_SWTVLAN_HoppingType vlanHoppingGet;
                    vlanHoppingGet.cmdRsp.cmd = HOST_SWT_VLAN_HOPPING_DETECTION_GET;
                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &vlanHoppingGet ,
                                                sizeof(vlanHoppingGet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (vlanHoppingGet.cmdRsp.rsp)) {
                        HOST_Log("Failed to get vlan hop_detect action, retVal = %d\n", vlanHoppingGet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        HOST_Log("vlan hop_detect action : ");
                        security_action_to_string(vlanHoppingGet.vlanHoppingAction);
                        rv = CMD_OK;
                    }
                } else if (!strncmp(curr_str,"set", 3)) {
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str == NULL) || (rem_str_len == 0)) {
                        goto done;
                    }
                    HOST_SWTVLAN_HoppingType vlanHoppingSet;
                    vlanHoppingSet.cmdRsp.cmd = HOST_SWT_VLAN_HOPPING_DETECTION_SET;

                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                    if ((rem_str != NULL) || (rem_str_len != 0)) {
                        goto done;
                    }

                    vlanHoppingSet.vlanHoppingAction = parse_integer(curr_str, &command_parse_status); /* action */
                    MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &vlanHoppingSet ,
                                                sizeof(vlanHoppingSet), MGMT_CMD_STR_MAX_LEN,
                                                1, &param);
                    if ((BCM_ERR_OK != retVal) || (vlanHoppingSet.cmdRsp.rsp)) {
                        HOST_Log("Failed to set vlan hop_detect action, ret = %d\n", vlanHoppingSet.cmdRsp.rsp);
                        rv = CMD_FAIL;
                    } else {
                        rv = CMD_OK;
                    }
                }
            }
#else
            }
#endif /* ENABLE_ETHSWT_SECURITY */
        } else if (!strncmp(curr_str, "pvidset", 7)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_SWTPVidSetType pVidSet;
            pVidSet.cmdRsp.cmd = HOST_SWT_PVID_SET;

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            value1 = parse_integer(curr_str, &command_parse_status); /* port */
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            value2 = parse_integer(curr_str, &command_parse_status); /* pvid */
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            if ((rem_str == NULL) || (rem_str_len == 0)) {
                HOST_Log("Priority value missing, should be between 0-7\n");
                rv = CMD_FAIL;
                goto done;
            } else {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value3 = parse_integer(curr_str, &command_parse_status); /* priority */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            }
            pVidSet.value1 = value1;
            pVidSet.value2 = value2;
            pVidSet.value3 = value3;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &pVidSet ,
                                        sizeof(pVidSet), MGMT_CMD_STR_MAX_LEN,
                                        1, &param);
            if ((BCM_ERR_OK != retVal) || (pVidSet.cmdRsp.rsp)) {
                HOST_Log("Failed to set the PVID, retVal = %d\n", pVidSet.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "ifilter", 7)) {
            HOST_SWTiFilterType iFilter;

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                iFilter.cmdRsp.cmd = HOST_SWT_IFILTER_GET;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &iFilter ,
                                            sizeof(iFilter), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (iFilter.cmdRsp.rsp)) {
                    HOST_Log("Failed to get the VLAN ingress filter, ret = %d\n", iFilter.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    HOST_Log("VLAN ingress filter is ");
                    if (iFilter.value1 == ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED) {
                        HOST_Log("Enabled\n");
                    } else if (iFilter.value1 == ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED) {
                        HOST_Log("Disabled\n");
                    } else {
                        HOST_Log("Unknown\n");
                    }
                    rv = CMD_OK;
                }
            } else {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                iFilter.cmdRsp.cmd = HOST_SWT_IFILTER_SET;
                if (!strncmp(curr_str, "enable", 6)) {
                    value1 = ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED;
                } else if(!strncmp(curr_str, "disable", 7)) {
                    value1 = ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED;
                } else {
                    goto done;
                }
                iFilter.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &iFilter ,
                                            sizeof(iFilter), MGMT_CMD_STR_MAX_LEN,
                                            1, &param);
                if ((BCM_ERR_OK != retVal) || (iFilter.cmdRsp.rsp)) {
                    HOST_Log("Failed to set the VLAN ingress filter, ret = %d\n", iFilter.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    HOST_Log("VLAN ingress filter has been ");
                    if (value1 == ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED) {
                        HOST_Log("Enabled\n");
                    } else {
                        HOST_Log("Disabled\n");
                    }
                    rv = CMD_OK;
                }
            }
        }
    }
done:
    if (rv == CMD_USAGE) {
        HOST_Log(mgmt_switch_cmd_usage);
    }
    return;
}
#endif /* ENABLE_HOST_ETHSWTM_CMD_HANDLER */

#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
static int32_t mgmt_arl_show(mqd_t sendMqd, mqd_t recvMqd)
{
    int32_t retVal;
    uint32_t i;
    uint32_t arlRdIdx;
    unsigned int param;
    HOST_SWTARLGetType arlGet;
    uint32_t available = sizeof(ARLEntries)/sizeof(ETHSWT_ARLEntryType);
    ETHSWT_ARLEntryType recv_ARL[MGMT_CMD_STR_MAX_LEN];

    arlGet.cmdRsp.cmd = HOST_SWT_ARL_GET;
    arlGet.value1 = available;
    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &arlGet ,
                                sizeof(arlGet), MGMT_CMD_STR_MAX_LEN,
                                1, &param);
    if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == arlGet.cmdRsp.rsp) && (0UL != arlGet.value1)) {
        arlRdIdx = 0;
        if (arlGet.value1 > sizeof(ARLEntries)/sizeof(ETHSWT_ARLEntryType)) {
            arlGet.value1 = sizeof(ARLEntries)/sizeof(ETHSWT_ARLEntryType);
        }
        HOST_Log("\tMAC\t\tVLAN\tPortMask\n");
        do {
            retVal = HOST_Receive(recvMqd, (char*) recv_ARL, MGMT_CMD_STR_MAX_LEN, &param);
            if (-1 == retVal) {
                HOST_Log("mq_receive Failed \n");
                return retVal;
            } else {
                memcpy(&ARLEntries[arlRdIdx],recv_ARL,retVal);
                available = retVal / sizeof(ETHSWT_ARLEntryType);
                arlRdIdx +=available;
            }
        } while(arlRdIdx < arlGet.value1);
        for (i = 0; i < arlGet.value1; i++) {
            HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x\t",
                    ARLEntries[i].macAddr[0], ARLEntries[i].macAddr[1],
                    ARLEntries[i].macAddr[2], ARLEntries[i].macAddr[3],
                    ARLEntries[i].macAddr[4], ARLEntries[i].macAddr[5]);
            HOST_Log("%u\t", ARLEntries[i].vlanID);
            HOST_Log("0x%x\n", ARLEntries[i].portMask);
        }
        retVal = BCM_ERR_OK;
    }
    return retVal;
}
#endif

#ifdef ENABLE_HOST_ETS_CMD_HANDLER
static const char mgmt_ets_cmd_usage[] =
"\tets admin_mode <disable|enable>\n"
"\tets stats <port> [domain]\n"
"\tets clearstats <port> [domain]\n"
"\tets status [domain]\n"
"\tets portstatus <port> [domain]\n"
"\tets portenable <port> <true|false> [domain]\n"
"\tets time set <sec> <nanosec>\n"
#ifdef ENABLE_RECORD_NOTIFICATION
"\tets show records <port>\n"
"\tets start notification\n"
"\tets stop notification\n"
#endif
"\n";

int32_t show_mgmt_ets_port_stats(mqd_t sendMqd, mqd_t recvMqd, uint32_t port, ETS_DomainType domain)
{
    int32_t retVal;
    unsigned int param;
    HOST_EtsDomainPortStatusType etsStatus;

    memset(&etsStatus.domainPortStatus, 0x00, sizeof(etsStatus.domainPortStatus));
    etsStatus.cmdRsp.cmd = HOST_ETS_GETDOMAINPORTSTATUS;
    etsStatus.domainPortStatus.portNum = port;
    etsStatus.domainPortStatus.domain  = domain;

    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsStatus ,
                                sizeof(etsStatus), MGMT_CMD_STR_MAX_LEN, 1, &param);
    if ((BCM_ERR_OK != retVal) || (etsStatus.cmdRsp.rsp)) {
        goto done;
    }

    HOST_Log("\n");
    HOST_Log("Sync Rx                        : %d\n",etsStatus.domainPortStatus.stats.syncRxCount);
    HOST_Log("Sync Tx                        : %d\n",etsStatus.domainPortStatus.stats.syncTxCount);
    HOST_Log("Sync Tx Resends                : %d\n",etsStatus.domainPortStatus.stats.syncTransmitTimeouts);
    HOST_Log("Followup Rx                    : %d\n",etsStatus.domainPortStatus.stats.followUpRxCount);
    HOST_Log("Followup Tx                    : %d\n",etsStatus.domainPortStatus.stats.followUpTxCount);
    HOST_Log("Sync Rx Timeouts               : %d\n",etsStatus.domainPortStatus.stats.syncReceiptTimeouts);
    HOST_Log("FollowUp Rx Timeouts           : %d\n",etsStatus.domainPortStatus.stats.followupReceiptTimeouts);
    HOST_Log("Sync Discards                  : %d\n",etsStatus.domainPortStatus.stats.syncRxDiscards);
    HOST_Log("FollowUp Rx Discards           : %d\n",etsStatus.domainPortStatus.stats.followUpRxDiscards);

    HOST_Log("\n");
    HOST_Log("Pdelay Req Rx                  : %d\n",etsStatus.domainPortStatus.stats.pDelayReqRxCount);
    HOST_Log("Pdelay Req Tx                  : %d\n",etsStatus.domainPortStatus.stats.pDelayReqTxCount);
    HOST_Log("Pdelay Resp Rx                 : %d\n",etsStatus.domainPortStatus.stats.pDelayRespRxCount);
    HOST_Log("Pdelay Resp Tx                 : %d\n",etsStatus.domainPortStatus.stats.pDelayRespTxCount);
    HOST_Log("Pdelay Resp FollowUp Rx        : %d\n",etsStatus.domainPortStatus.stats.pDelayRespFollowUpRxCount);
    HOST_Log("Pdelay Resp FollowUp Tx        : %d\n",etsStatus.domainPortStatus.stats.pDelayRespFollowUpTxCount);
    HOST_Log("Pdelay Req Rx Discards         : %d\n",etsStatus.domainPortStatus.stats.pDelayReqRxDiscards);
    HOST_Log("Pdelay Resp Rx Discards        : %d\n",etsStatus.domainPortStatus.stats.pDelayRespRxDiscards);
    HOST_Log("Pdelay Rx Timeouts             : %d\n",etsStatus.domainPortStatus.stats.pDelayReceiptTimeouts);
    HOST_Log("Bad Pdelay Values              : %d\n",etsStatus.domainPortStatus.stats.badPdelayValues);
    HOST_Log("Pdelay Lost Resp Exceeded      : %d\n",etsStatus.domainPortStatus.stats.pDelayLostResponsesExceeded);
    HOST_Log("Pdelay Rx Discards             : %d\n",etsStatus.domainPortStatus.stats.pDelayReqRxDiscards
                                                      + etsStatus.domainPortStatus.stats.pDelayRespRxDiscards);

    HOST_Log("\n");
    HOST_Log("Announce Rx                    : %d\n",etsStatus.domainPortStatus.stats.announceRxCount);
    HOST_Log("Announce Tx                    : %d\n",etsStatus.domainPortStatus.stats.announceTxCount);
    HOST_Log("Announce Discards              : %d\n",etsStatus.domainPortStatus.stats.announceRxDiscards);
    HOST_Log("Announce Rx Timeouts           : %d\n",etsStatus.domainPortStatus.stats.announceReceiptTimeouts);

    HOST_Log("\n");
    HOST_Log("Signaling Rx                   : %d\n",etsStatus.domainPortStatus.stats.signalingRxCount);
    HOST_Log("Signaling Tx                   : %d\n",etsStatus.domainPortStatus.stats.signalingTxCount);
    HOST_Log("Signaling Discards             : %d\n",etsStatus.domainPortStatus.stats.signalingRxDiscards);

    HOST_Log("\n");
    HOST_Log("Tx Errors                      : %d\n",etsStatus.domainPortStatus.stats.txErrors);
    HOST_Log("Timestamp Errors               : %d\n",etsStatus.domainPortStatus.stats.tsErrors);
    HOST_Log("Bad headers                    : %d\n",etsStatus.domainPortStatus.stats.parseFailed);
    HOST_Log("PTP Discards                   : %d\n",etsStatus.domainPortStatus.stats.ptpDiscardCount);
    HOST_Log("Tx Total                       : %d\n",etsStatus.domainPortStatus.stats.txConf);

    HOST_Log("\n");
    HOST_Log("Set Time Count                 : %d\n",etsStatus.domainPortStatus.stats.setTimeCount);
    HOST_Log("Time Correction 0ns-10ns       : %d\n",etsStatus.domainPortStatus.stats.deltaTime0NsTo10Ns);
    HOST_Log("Time Correction 11ns-40ns      : %d\n",etsStatus.domainPortStatus.stats.deltaTime11NsTo40Ns);
    HOST_Log("Time Correction 41ns-80ns      : %d\n",etsStatus.domainPortStatus.stats.deltaTime41NsTo80Ns);
    HOST_Log("Time Correction 81ns-100ns     : %d\n",etsStatus.domainPortStatus.stats.deltaTime81NsTo100Ns);
    HOST_Log("Time Correction 101ns-1000ns   : %d\n",etsStatus.domainPortStatus.stats.deltaTime101NsTo1000Ns);
    HOST_Log("Time Correction 1001ns-10000ns : %d\n",etsStatus.domainPortStatus.stats.deltaTime1001NsTo10000Ns);
    HOST_Log("Time Correction 10001ns-MAX    : %d\n",etsStatus.domainPortStatus.stats.deltaTime10001NsToMax);
done:
    return etsStatus.cmdRsp.rsp;
}

void show_ets_gm_status(ETS_GMStatusType gmStatus)
{
    switch (gmStatus){
        case ETS_GMSTATUS_STARTUP_ABSENT:
            HOST_Log("GM Status                 : Absent At Startup\n");
            break;
        case ETS_GMSTATUS_OPER_ABSENT:
            HOST_Log("GM Status                 : Absent\n");
            break;
        case ETS_GMSTATUS_UNDETERMINED:
            HOST_Log("GM Status                 : Undetermined\n");
            break;
        case ETS_GMSTATUS_DISABLED:
            HOST_Log("GM Status                 : Disabled\n");
            break;
        case ETS_GMSTATUS_NO_SLAVEPORT:
            HOST_Log("GM Status                 : No slave port\n");
            break;
        case ETS_GMSTATUS_PRESENT:
            HOST_Log("GM Status                 : Present\n");
            break;
        default:
            HOST_Log("GM Status                 : Invalid\n");
            break;
    }
}

/* Display ETS global status */
int32_t show_ets_global_status(mqd_t sendMqd, mqd_t recvMqd)
{
    HOST_EtsGlobalStatusType etsGStatus;
    int32_t retVal=0;
    uint8_t *id = &etsGStatus.status.clockId.id[0];
    unsigned int param;

    memset(&etsGStatus.status, 0x00, sizeof(etsGStatus.status));
    etsGStatus.cmdRsp.cmd = HOST_ETS_GETGLOBALSTATUS;
    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsGStatus ,
                                sizeof(etsGStatus), MGMT_CMD_STR_MAX_LEN, 1, &param);
    if ((BCM_ERR_OK != retVal) || (etsGStatus.cmdRsp.rsp)) {
        HOST_Log("Error: Could not get ETS Global Status\n");
        goto done;
    }

    HOST_Log("\n");
    HOST_Log("Local clock id            : %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
            id[0], id[1], id[2], id[3], id[4], id[5], id[6], id[7]);

    HOST_Log("BridgeLocalTime           : %" PRIu64 ".%09u\n",
            etsGStatus.status.networkTime.seconds, etsGStatus.status.networkTime.nanoseconds);
    switch (etsGStatus.status.networkTimeState) {
    case ETS_TIMESTATE_SYNC:
        HOST_Log("NetworkTimeState          : Network clock is synced to GM\n");
        break;
    case ETS_TIMESTATE_UNSYNC:
        HOST_Log("NetworkTimeState          : Network clock is not synced to GM\n");
        break;
    case ETS_TIMESTATE_UNCERTAIN:
        HOST_Log("NetworkTimeState          : Network clock is in holdover\n");
        break;
    default:
        HOST_Log("NetworkTimeState          : Invalid\n");
        break;
    }
    HOST_Log("Active domain number      : %u\n", etsGStatus.status.activeDomainNum);
done:
    return etsGStatus.cmdRsp.rsp;
}

/* Display ETS domain status */
int32_t show_ets_domain_status(mqd_t sendMqd, mqd_t recvMqd, ETS_DomainType domain)
{
    HOST_EtsDomainStatusType etsDStatus;
    int32_t retVal=0;
    unsigned int param;

    memset(&etsDStatus.domainStatus, 0x00, sizeof(etsDStatus.domainStatus));
    etsDStatus.domainStatus.num = domain;
    etsDStatus.cmdRsp.cmd = HOST_ETS_GETDOMAINSTATUS;
    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsDStatus ,
                                sizeof(etsDStatus), MGMT_CMD_STR_MAX_LEN, 1, &param);
    if ((BCM_ERR_OK != retVal) || (etsDStatus.cmdRsp.rsp)) {
        HOST_Log("Error: Could not get ETS domain Status\n");
        goto done;
    }

    HOST_Log("\n");
    switch (etsDStatus.domainStatus.status.clockState) {
    case ETS_CLOCKSTATE_INIT_GM:
        HOST_Log("Clock state : Yet to be initialized as GM\n");
        break;
    case ETS_CLOCKSTATE_UPDATE_GM:
        HOST_Log("Clock state : Initialized as GM\n");
        break;
    case ETS_CLOCKSTATE_INIT_SLAVE:
        HOST_Log("Clock state : Yet to be initialized as slave\n");
        break;
    case ETS_CLOCKSTATE_UPDATE_SLAVE:
        HOST_Log("Clock state : Initialized as slave\n");
        break;
    default:
        HOST_Log("Clock state : Invalid\n");
        break;
    }

    if ((etsDStatus.domainStatus.status.clockState == ETS_CLOCKSTATE_INIT_SLAVE) ||
        (etsDStatus.domainStatus.status.clockState == ETS_CLOCKSTATE_UPDATE_SLAVE)) {
        show_ets_gm_status(etsDStatus.domainStatus.status.gmStatus);
        HOST_Log("Slave Port                : %d\n", etsDStatus.domainStatus.status.slavePort);
        HOST_Log("Rate Ratio (In)           : 0x%x\n", etsDStatus.domainStatus.status.rateRatioIn);
        HOST_Log("Rate Ratio (Out)          : 0x%x\n", etsDStatus.domainStatus.status.gmRateRatio);
        HOST_Log("Is Sync Received          : %u\n", etsDStatus.domainStatus.status.isSyncReceived);
        HOST_Log("Signaling Sequence Number : %u\n", etsDStatus.domainStatus.status.signalingTxSeqId);
        HOST_Log("Requested Sync Interval   : %d\n", etsDStatus.domainStatus.status.reqSyncLogInterval);
        HOST_Log("Is Signaling Timer Started: %u\n", etsDStatus.domainStatus.status.isSignalingTimerStarted);
        HOST_Log("Rx Correction             : %" PRIu64 "\n", etsDStatus.domainStatus.status.rxFollowupCorrection);
        HOST_Log("Precise Origin TimeStamp  : %" PRIu64 ".%09u\n", etsDStatus.domainStatus.status.rxPOT.seconds,
                etsDStatus.domainStatus.status.rxPOT.nanoseconds);

        HOST_Log("GM Clock Id               : ");
        HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[0],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[1],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[2],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[3],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[4],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[5],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[6],
                etsDStatus.domainStatus.status.gmIdentifier.clockId.id[7]);

        HOST_Log("GM priority1              : %u\n", etsDStatus.domainStatus.status.gmIdentifier.systemId.priority1);
        HOST_Log("GM clock class            : %u\n", etsDStatus.domainStatus.status.gmIdentifier.systemId.clockClass);
        HOST_Log("GM clock accuracy         : %u\n", etsDStatus.domainStatus.status.gmIdentifier.systemId.clockAccuracy);
        HOST_Log("GM offset scaled log var  : %u\n", etsDStatus.domainStatus.status.gmIdentifier.systemId.offsetScaledLogVariance);
        HOST_Log("GM priority2              : %u\n", etsDStatus.domainStatus.status.gmIdentifier.systemId.priority2);
        HOST_Log("GM steps removed          : %u\n", etsDStatus.domainStatus.status.gmIdentifier.stepsRemoved);
        HOST_Log("GM time source            : 0x%x\n", etsDStatus.domainStatus.status.gmIdentifier.timeSource);
        HOST_Log("GM UTC offset             : %u\n", etsDStatus.domainStatus.status.gmIdentifier.utcOffset);
        HOST_Log("GM Flags                  : 0x%x\n", etsDStatus.domainStatus.status.gmIdentifier.flags);
        if (etsDStatus.domainStatus.status.gmIdentifier.pathTrace.length > 0U) {
            uint32_t numPaths = (etsDStatus.domainStatus.status.gmIdentifier.pathTrace.length / ETS_CLOCK_ID_LEN);
            uint32_t i = 0UL;

            HOST_Log("Path trace                : ");
            for (; i < numPaths; ++i) {
                HOST_Log("\nPath Element %u            : ", i+1);
                HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[0],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[1],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[2],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[3],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[4],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[5],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[6],
                        etsDStatus.domainStatus.status.gmIdentifier.pathTrace.clkID[i].id[7]);
            }
        }
        HOST_Log("\nGM change count           : %u\n", etsDStatus.domainStatus.status.gmChangeCount);
        HOST_Log("Parent Clock Id           : ");
        HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
                etsDStatus.domainStatus.status.parentId.clockID.id[0],
                etsDStatus.domainStatus.status.parentId.clockID.id[1],
                etsDStatus.domainStatus.status.parentId.clockID.id[2],
                etsDStatus.domainStatus.status.parentId.clockID.id[3],
                etsDStatus.domainStatus.status.parentId.clockID.id[4],
                etsDStatus.domainStatus.status.parentId.clockID.id[5],
                etsDStatus.domainStatus.status.parentId.clockID.id[6],
                etsDStatus.domainStatus.status.parentId.clockID.id[7]);
        HOST_Log("Parent Port Id            : %u\n", etsDStatus.domainStatus.status.parentId.port);

    }
done:
    return etsDStatus.cmdRsp.rsp;
}

int32_t show_ets_port_status(mqd_t sendMqd, mqd_t recvMqd, uint32_t port)
{
    int32_t retVal;
    HOST_EtsPortStatusType ets_port_status;
    unsigned int param;

    ets_port_status.cmdRsp.cmd = HOST_ETS_GETPORTSTATUS;
    memset(&ets_port_status.portStatus, 0x00, sizeof(ets_port_status.portStatus));
    ets_port_status.portStatus.num  = port;
    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &ets_port_status ,
            sizeof(ets_port_status), MGMT_CMD_STR_MAX_LEN, 1, &param);
    if ((BCM_ERR_OK != retVal) || (ets_port_status.cmdRsp.rsp)) {
        HOST_Log("Error: Could not get ets port status\n");
        goto done;
    }

    HOST_Log("\n");
    HOST_Log("Peer delay                : %d\n", ets_port_status.portStatus.status.nbrPropDelay);
    HOST_Log("Rate ratio                : 0x%08x\n", ets_port_status.portStatus.status.nbrRateRatio);
    HOST_Log("Is measuring delay        : %s\n", ets_port_status.portStatus.status.isMeasuringPdelay ? "True" : "False");
    HOST_Log("Is AVnu Config Saved      : %u\n", ets_port_status.portStatus.status.isAVnuPdelayConfigSaved);
    HOST_Log("Pdelay interval           : %d\n", ets_port_status.portStatus.status.currentLogPdelayIntvl);

    HOST_Log("Partner Clock Id          : ");
    HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
            ets_port_status.portStatus.status.partnerId.clockID.id[0],
            ets_port_status.portStatus.status.partnerId.clockID.id[1],
            ets_port_status.portStatus.status.partnerId.clockID.id[2],
            ets_port_status.portStatus.status.partnerId.clockID.id[3],
            ets_port_status.portStatus.status.partnerId.clockID.id[4],
            ets_port_status.portStatus.status.partnerId.clockID.id[5],
            ets_port_status.portStatus.status.partnerId.clockID.id[6],
            ets_port_status.portStatus.status.partnerId.clockID.id[7]);

    HOST_Log("Partner Port Id           : %u\n", ets_port_status.portStatus.status.partnerId.port);
    HOST_Log("Pdelay Sequence Number    : %u\n", ets_port_status.portStatus.status.pDelayTxSeqId);
    HOST_Log("Number of lost responses  : %u\n", ets_port_status.portStatus.status.numPdelayRespLost);
    HOST_Log("Peer delay request state  : %d\n", ets_port_status.portStatus.status.pDelayReqState);
    HOST_Log("Peer delay response state : %d\n", ets_port_status.portStatus.status.pDelayRespState);
    HOST_Log("PDelay Timestamp T1       : %" PRIu64 ".%09u\n", ets_port_status.portStatus.status.pDelayT1.seconds, ets_port_status.portStatus.status.pDelayT1.nanoseconds);
    HOST_Log("PDelay Timestamp T2       : %" PRIu64 ".%09u\n", ets_port_status.portStatus.status.pDelayT2.seconds, ets_port_status.portStatus.status.pDelayT2.nanoseconds);
    HOST_Log("PDelay Timestamp T3       : %" PRIu64 ".%09u\n", ets_port_status.portStatus.status.pDelayT3.seconds, ets_port_status.portStatus.status.pDelayT3.nanoseconds);
    HOST_Log("PDelay Timestamp T4       : %" PRIu64 ".%09u\n", ets_port_status.portStatus.status.pDelayT4.seconds, ets_port_status.portStatus.status.pDelayT4.nanoseconds);
    HOST_Log("asCapable across domains  : %u\n", ets_port_status.portStatus.status.asCapableAcrossDomains);

done:
    return ets_port_status.cmdRsp.rsp;
}

void show_ets_port_role(ETS_RoleType role) {

    switch (role) {
    case ETS_ROLE_MASTER:
        HOST_Log("Port Role              : Master\n");
        break;
    case ETS_ROLE_SLAVE:
        HOST_Log("Port Role              : Slave\n");
        break;
    case ETS_ROLE_DISABLED:
        HOST_Log("Port Role              : Disabled\n");
        break;
    case ETS_ROLE_PASSIVE:
        HOST_Log("Port Role              : Passive\n");
        break;
    default:
        HOST_Log("Port Role              : Invalid\n");
        break;
    }
}

int32_t show_ets_per_domain_port_status(mqd_t sendMqd, mqd_t recvMqd, uint32_t port, ETS_DomainType domain)
{
    int32_t retVal;
    HOST_EtsDomainPortStatusType etsPDPStatus;
    unsigned int param;

    etsPDPStatus.cmdRsp.cmd = HOST_ETS_GETDOMAINPORTSTATUS;
    memset(&etsPDPStatus.domainPortStatus, 0x00, sizeof(etsPDPStatus.domainPortStatus));
    etsPDPStatus.domainPortStatus.portNum = port;
    etsPDPStatus.domainPortStatus.domain = domain;
    retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsPDPStatus,
            sizeof(etsPDPStatus), MGMT_CMD_STR_MAX_LEN, 1, &param);
    if ((BCM_ERR_OK != retVal) || (etsPDPStatus.cmdRsp.rsp)) {
        HOST_Log("Error: Could not get ets port status\n");
        goto done;
    }

    HOST_Log("\n");
    show_ets_port_role(etsPDPStatus.domainPortStatus.status.role);
    HOST_Log("Sync interval                : %d\n", etsPDPStatus.domainPortStatus.status.currentLogSyncIntvl);
    HOST_Log("Sync receipt timeout         : %u\n", etsPDPStatus.domainPortStatus.status.syncReceiptTimeoutIntvl);
    HOST_Log("Sync Info Available          : %u\n", etsPDPStatus.domainPortStatus.status.syncInfoAvailable);
    HOST_Log("Sync Sequence Number         : %u\n", etsPDPStatus.domainPortStatus.status.syncSeqNum);
    HOST_Log("Tx Correction                : %" PRIu64 "\n", etsPDPStatus.domainPortStatus.status.txFollowupCorrection);
    HOST_Log("Sync state                   : %d\n", etsPDPStatus.domainPortStatus.status.syncState);
    HOST_Log("Sync Timestamp               : %" PRIu64 ".%09u\n", etsPDPStatus.domainPortStatus.status.syncTimestamp.seconds,
                                                                etsPDPStatus.domainPortStatus.status.syncTimestamp.nanoseconds);
    HOST_Log("Announce Sequence Number     : %u\n", etsPDPStatus.domainPortStatus.status.announceSeqNum);
    HOST_Log("Announce interval            : %d\n", etsPDPStatus.domainPortStatus.status.currentLogAnnIntvl);
    HOST_Log("Announce receipt timeout     : %u\n", etsPDPStatus.domainPortStatus.status.annReceiptTimeoutIntvl);
    HOST_Log("gPTP capable interval        : %d\n", etsPDPStatus.domainPortStatus.status.currentLogGptpCapIntvl);
    HOST_Log("gPTP capable receipt timeout : %u\n", etsPDPStatus.domainPortStatus.status.gPTPCapReceiptTimeoutIntvl);

done:
    return etsPDPStatus.cmdRsp.rsp;
}

#ifdef ENABLE_RECORD_NOTIFICATION
void show_ets_port_records(uint32_t port, ETS_RecordType* record, uint32_t size)
{
    uint32_t i;
    ETS_MsgType pktType;

    HOST_Log("Port %u ::\n", port);
    for (i = 0UL; i < size; ++i) {
        if (((record[i].flag & ETS_RECORDDEFS_IS_VALID_MASK) >> ETS_RECORDDEFS_IS_VALID_SHIFT) == 1UL) {
            HOST_Log("\n============Record %u==============\n", i);
            pktType =  (record[i].flag & ETS_RECORDDEFS_PACKET_TYPE_MASK) >> ETS_RECORDDEFS_PACKET_TYPE_SHIFT;
            HOST_Log("Packet Type            : %lu\n", pktType);
            HOST_Log("Sequence Number        : %u\n", (record[i].flag & ETS_RECORDDEFS_SEQ_NUM_MASK) >> ETS_RECORDDEFS_SEQ_NUM_SHIFT);
            HOST_Log("GM Time                : %lus:%09luns\n", record[i].gmTime.s, record[i].gmTime.ns);
            HOST_Log("Local Time             : %lus:%09luns\n", record[i].localTime.s, record[i].localTime.ns);
            if ((ETS_MSG_PDELAY_RESP == pktType) || (ETS_MSG_PDELAY_RESP_FOLLOWUP == pktType)) {
                HOST_Log("Followup Timestamp     : %lus:%09luns\n", record[i].followupTimestamp.s, record[i].followupTimestamp.ns);
            }
            HOST_Log("Source Port Identity   : ");
            HOST_Log("%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x:%04x\n",
                record[i].srcPortIdentity.clockID.id[0], record[i].srcPortIdentity.clockID.id[1],
                record[i].srcPortIdentity.clockID.id[2], record[i].srcPortIdentity.clockID.id[3],
                record[i].srcPortIdentity.clockID.id[4], record[i].srcPortIdentity.clockID.id[5],
                record[i].srcPortIdentity.clockID.id[6], record[i].srcPortIdentity.clockID.id[7],
                record[i].srcPortIdentity.port);
            show_ets_port_role((record[i].flag & ETS_RECORDDEFS_ROLE_MASK) >> ETS_RECORDDEFS_ROLE_SHIFT);
            show_ets_gm_status((record[i].flag & ETS_RECORDDEFS_GM_STATUS_MASK) >> ETS_RECORDDEFS_GM_STATUS_SHIFT);
            HOST_Log("Record Number          : %u\n", (record[i].portAndRecNum & ETS_RECORDDEFS_NUM_MASK) >> ETS_RECORDDEFS_NUM_SHIFT);
            HOST_Log("LinkUp Status          : %u\n", (record[i].flag & ETS_RECORDDEFS_IS_LINK_UP_MASK) >> ETS_RECORDDEFS_IS_LINK_UP_SHIFT);
            HOST_Log("IsTx                   : %u\n", (record[i].flag & ETS_RECORDDEFS_IS_TX_MASK) >> ETS_RECORDDEFS_IS_TX_SHIFT);
            HOST_Log("pDelay Value           : %u\n", record[i].pDelay);
            HOST_Log("Delta Correction Time  : %" PRIu64 "\n", record[i].deltaCorrectionTime);
        }
    }
}
#endif

void mgmt_ets_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    int32_t retVal = 0;
    int32_t rv = CMD_USAGE;
    char *curr_str = input_str;
    uint32_t curr_str_len = input_str_len;
    char * rem_str = NULL;
    uint32_t rem_str_len;
    uint32_t value1, value2;
    unsigned int param;
    int32_t command_parse_status;

    if ((input_str != NULL) && (input_str_len != 0)){
        if (!strncmp(curr_str, "admin_mode", 10)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_EtsGlobalEnableType etsAdmin;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            if(!strncmp(curr_str, "enable", 6)) {
                value1 = TRUE;
            } else if (!strncmp(curr_str, "disable", 7)) {
                value1 = FALSE;
            } else {
                HOST_Log("ets admin_mode <disable|enable>\n");
                goto done;
            }
            etsAdmin.cmdRsp.cmd = HOST_ETS_SETGLOBALENABLE;
            etsAdmin.value1 = value1;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsAdmin ,
                                        sizeof(etsAdmin), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (etsAdmin.cmdRsp.rsp)) {
                HOST_Log("ets global admin mode set failed, ret = %d\n", etsAdmin.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "stats", 5)){
            value2 = 0UL;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            value1 = parse_integer(curr_str, &command_parse_status); /* port */
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            if ((rem_str != NULL) && (rem_str_len != 0)) {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                value2 = parse_integer(curr_str, &command_parse_status); /* domain number*/
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
            }
            retVal = show_mgmt_ets_port_stats(sendMqd, recvMqd, value1, value2);
            if (retVal) {
                HOST_Log("ets stats get  failed, retVal = %d\n", retVal);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "clearstats", 10)) {
            value2 = 0UL;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_EtsClearStatsType etsClr;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            value1 = parse_integer(curr_str, &command_parse_status); /* port */
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            if ((rem_str != NULL) && (rem_str_len != 0)) {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                value2 = parse_integer(curr_str, &command_parse_status); /* domain number*/
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
            }
            etsClr.cmdRsp.cmd = HOST_ETS_CLEARSTATS;
            etsClr.value1 = value1;
            etsClr.value2 = value2;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsClr ,
                                        sizeof(etsClr), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (etsClr.cmdRsp.rsp)) {
                HOST_Log("ets stats clear  failed, retVal = %d\n", etsClr.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if(!strncmp(curr_str, "status", 6)){
            value1 = 0UL;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str != NULL) && (rem_str_len != 0)) {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                value1 = parse_integer(curr_str, &command_parse_status); /* domain number*/
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                retVal = show_ets_domain_status(sendMqd, recvMqd, value1);
            } else {
                retVal = show_ets_global_status(sendMqd, recvMqd);
            }
            if (retVal) {
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "portstatus", 10)){
            value1 = 0UL;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            value1 = parse_integer(curr_str, &command_parse_status); /* port number*/
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            if ((rem_str != NULL) && (rem_str_len != 0)) {
                value2 = 0UL;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                value2 = parse_integer(curr_str, &command_parse_status); /* domain number*/
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                retVal = show_ets_per_domain_port_status(sendMqd, recvMqd, value1, value2);
            } else {
                retVal = show_ets_port_status(sendMqd, recvMqd, value1);
            }
            if (retVal) {
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "portenable", 9)) {
            uint32_t value3 = 0UL;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            value1 = parse_integer(curr_str, &command_parse_status); /* port number */
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_EtsPortEnableSetType etsPortEn;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            if (!strncmp(curr_str, "true", 4)){
                value2 = TRUE;
            } else if (!strncmp(curr_str, "false", 5)){
                value2 = FALSE;
            } else {
                HOST_Log("ets portenable <port> <true|false> [domain]\n");
                goto done;
            }

            if ((rem_str != NULL) && (rem_str_len != 0)) {
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value3 = parse_integer(curr_str, &command_parse_status); /* domain number */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            }
            etsPortEn.cmdRsp.cmd = HOST_ETS_SETPORTENABLE;
            etsPortEn.value1 = value1;
            etsPortEn.value2 = value2;
            etsPortEn.value3 = value3;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsPortEn,
                                    sizeof(etsPortEn), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (etsPortEn.cmdRsp.rsp)) {
                HOST_Log("Error in configuring port enable, ret = %d \n", etsPortEn.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(curr_str, "time", 4)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            if (!strncmp(curr_str, "set", 3)) {
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_EtsTimeSetType etsTimeSet;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value1 = parse_integer(curr_str, &command_parse_status); /* sec_low32 */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value2 = parse_integer(curr_str, &command_parse_status); /* nanosec */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);


                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }

                etsTimeSet.cmdRsp.cmd = HOST_ETS_SETTIME;
                etsTimeSet.value1 = value1;
                etsTimeSet.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsTimeSet ,
                                    sizeof(etsTimeSet), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (etsTimeSet.cmdRsp.rsp)) {
                    HOST_Log("ets time set failed, retVal = %d\n", etsTimeSet.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
#ifdef ENABLE_RECORD_NOTIFICATION
        } else if (!strncmp(curr_str, "show", 4)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            if (!strncmp(curr_str, "records", 7)) {
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                HOST_EtsValidationRecordGetType etsValidRec;
                curr_str = rem_str;
                curr_str_len = rem_str_len;
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

                value1 = parse_integer(curr_str, &command_parse_status); /* port */
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                etsValidRec.cmdRsp.cmd = HOST_ETS_GETVALIDATIONRECORD;
                etsValidRec.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsValidRec ,
                                    sizeof(etsValidRec), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (etsValidRec.cmdRsp.rsp)) {
                    HOST_Log("ets show records failed, retVal = %d\n", etsValidRec.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    show_ets_port_records(value1, etsValidRec.record, ETS_NUM_RECORDS_PER_INTF);
                    rv = CMD_OK;
                }
            }
        } else if ((!strncmp(curr_str, "start", 5)) || (!strncmp(curr_str, "stop", 4))) {
            uint8_t isStart;
            char *curr_str_store = curr_str;
            isStart = !strncmp(curr_str, "start", 5);
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            HOST_EtsStartStopValidationType etsValid;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            if (!strncmp(curr_str, "notification", 11)) {

                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
                etsValid.cmdRsp.cmd = HOST_ETS_STARTSTOP_VALIDATION;
                etsValid.isStart = isStart;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &etsValid ,
                                    sizeof(etsValid), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (etsValid.cmdRsp.rsp)) {
                    HOST_Log("ets %s notification failed, retVal = %d\n", strtok(curr_str_store, " "), etsValid.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    HOST_Log("ets %s notification completed\n", strtok(curr_str_store, " "));
                    rv = CMD_OK;
                }
            }
        }
#else   /* ENABLE_RECORD_NOTIFICATION */
        }
#endif /* ENABLE_RECORD_NOTIFICATION */
    }

done:
    if (rv == CMD_USAGE) {
        HOST_Log(mgmt_ets_cmd_usage);
    }
    return;
}
#endif /* ENABLE_HOST_ETS_CMD_HANDLER */

#ifdef ENABLE_DBGMEM
static const char mgmt_mem_cmd_usage[] =
"\tmem read <addr> <width 8|16|32> <device ID>\n"
"\t                                 device ID 0: master\n"
"\t                                 device ID 1: slave\n"
"\tmem write <addr> <width 8|16|32> <data> <device ID>\n"
"\t                                         device ID 0: master\n"
"\t                                         device ID 1: slave\n"
"\n";

void mgmt_mem_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *curr_str = input_str;
    char *rem_str = NULL;
    uint32_t curr_str_len = input_str_len;
    uint32_t rem_str_len = 0;
    int32_t command_parse_status = 0;
    uint32_t addr = 0;
    uint32_t width = 0;
    uint32_t data = 0;
    int32_t rv = CMD_USAGE;
    uint32_t write = 0;
    uint32_t destn;
    int32_t  retVal = -1;
    unsigned int param;
    HOST_MemType mem;


    if ((curr_str != NULL) && (curr_str_len != 0)) {
        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
        if ((rem_str == NULL) || (rem_str_len == 0)) {
            goto done;
        }

        if (!strncmp(curr_str, "read", 4)) {
            write = 0;
        } else if (!strncmp(curr_str, "write", 5)) {
            write = 1;
        } else {
            goto done;
        }

        curr_str = rem_str;
        curr_str_len = rem_str_len;
        /* Fetch the address */
        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
        if ((rem_str == NULL) || (rem_str_len == 0)) {
            goto done;
        }
        addr = parse_integer(curr_str, &command_parse_status);
        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

        curr_str = rem_str;
        curr_str_len = rem_str_len;

        /* Fetch the width */
        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
        if ((rem_str == NULL) || (rem_str_len == 0)) {
            goto done;
        }
        width = parse_integer(curr_str, &command_parse_status);
        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

        if ((width != 8) && (width != 16) && (width != 32)) {
            HOST_Log("Unsupported width:%u\n", width);
            goto done;
        }

        curr_str = rem_str;
        curr_str_len = rem_str_len;

        if (write == 0) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            destn = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            if (MCU_DEVICE_SLAVE_1 < destn) {
                HOST_Log("read <addr> <width 8|16|32> <device ID [0|1]>\n");
                goto done;
            }

            if ((rem_str != NULL) || (rem_str_len != 0)) {
                goto done;
            }
            mem.cmdRsp.cmd = HOST_MEM_READ;
            mem.destn = destn;
            mem.addr = addr;
            mem.width = width;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mem ,
                                    sizeof(mem), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (mem.cmdRsp.rsp)) {
                HOST_Log("Error in read function err:0x%x\n", mem.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
                if (mem.width == 8) {
                    HOST_Log("0x%02X\n", mem.data.u8data);
                } else if (width == 16) {
                    HOST_Log("0x%04X\n", mem.data.u16data);
                } else {
                    HOST_Log("0x%08X\n", mem.data.u32data);
                }
            }
        } else {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            data = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

            destn = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            if (MCU_DEVICE_SLAVE_1 < destn) {
                HOST_Log("write <addr> <width 8|16|32> <device ID [0|1]>\n");
                goto done;
            }

            if ((rem_str != NULL) || (rem_str_len != 0)) {
                goto done;
            }

            //convert to an array of "width" size starting at &data
            if (width == 8) {
                mem.data.u8data = (uint8_t)data;
            } else if (width == 16) {
                mem.data.u16data = (uint16_t)data;
            } else if (width == 32) {
                mem.data.u32data = (uint32_t)data;
            }

            mem.cmdRsp.cmd = HOST_MEM_WRITE;
            mem.destn = destn;
            mem.addr = addr;
            mem.width = width;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &mem ,
                                    sizeof(mem), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (mem.cmdRsp.rsp)) {
                HOST_Log("Error in memory write 0x%x\n", mem.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        }
    }
done:
    if(CMD_USAGE == rv) {
        HOST_Log(mgmt_mem_cmd_usage);
    }
    return;
}
#endif /* ENABLE_DBGMEM */

static const char mgmt_reg_cmd_usage[] =
"\treg read <addr> <width 8|16|32|64>\n"
"\treg write <addr> <width 8|16|32|64> <dataHigh> [<dataLow>]\n"
"\n";

void mgmt_reg_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char *curr_str = input_str;
    char *rem_str = NULL;
    uint32_t curr_str_len = input_str_len;
    uint32_t rem_str_len = 0;
    int32_t command_parse_status = 0;
    uint32_t addr = 0;
    uint32_t width = 0;
    uint64_t data = 0;
    int32_t rv = CMD_USAGE;
    uint32_t write = 0;
    int32_t  retVal = -1;
    unsigned int param;
    HOST_RegType regAccess;


    if ((curr_str != NULL) && (curr_str_len != 0)) {
        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
        if ((rem_str == NULL) || (rem_str_len == 0)) {
            goto done;
        }

        if (!strncmp(curr_str, "read", 4)) {
            write = 0;
        } else if (!strncmp(curr_str, "write", 5)) {
            write = 1;
        } else {
            goto done;
        }

        curr_str = rem_str;
        curr_str_len = rem_str_len;
        /* Fetch the address */
        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
        if ((rem_str == NULL) || (rem_str_len == 0)) {
            goto done;
        }
        addr = parse_integer(curr_str, &command_parse_status);
        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

        curr_str = rem_str;
        curr_str_len = rem_str_len;

        /* Fetch the width */
        split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);

        width = parse_integer(curr_str, &command_parse_status);
        MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

        if ((width != 8) && (width != 16) && (width != 32) && (width != 64)) {
            HOST_Log("Unsupported width:%u\n", width);
            goto done;
        }

        if (write == 0) {
            if ((rem_str != NULL) || (rem_str_len != 0)) {
                goto done;
            }
            regAccess.cmdRsp.cmd = HOST_REG_READ;
            regAccess.addr = addr;
            regAccess.width = width;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &regAccess,
                                    sizeof(regAccess), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (regAccess.cmdRsp.rsp)) {
                HOST_Log("Error in read function err:0x%x\n", regAccess.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
                if (regAccess.width == 8) {
                    HOST_Log("0x%02X\n", (uint8_t)(regAccess.data & 0xFFU));
                } else if (width == 16) {
                    HOST_Log("0x%04X\n", (uint16_t)(regAccess.data & 0xFFFFU));
                } else if (width == 32) {
                    HOST_Log("0x%08X\n", (uint32_t)(regAccess.data & 0xFFFFFFFFU));
                } else {
                    HOST_Log("0x%llX\n", regAccess.data);
                }
            }
        } else {
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            curr_str = rem_str;
            curr_str_len = rem_str_len;

            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            data = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;

            if (width != 64) {
                /* don't expect anything more for 8/16/32bit accesses */
                if ((rem_str != NULL) || (rem_str_len != 0)) {
                    goto done;
                }
            } else {
                /* expect one more field for 64bit access */
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    goto done;
                }
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                data = (data << 32UL) | parse_integer(curr_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
            }

            regAccess.cmdRsp.cmd = HOST_REG_WRITE;
            regAccess.addr = addr;
            regAccess.width = width;
            regAccess.data = data;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &regAccess ,
                                    sizeof(regAccess), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (regAccess.cmdRsp.rsp)) {
                HOST_Log("Error in memory write 0x%x\n", regAccess.cmdRsp.rsp);
                rv = CMD_FAIL;
            } else {
                rv = CMD_OK;
            }
        }
    }
done:
    if(CMD_USAGE == rv) {
        HOST_Log(mgmt_reg_cmd_usage);
    }
    return;
}

#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
static const char mgmt_cfp_cmd_usage[] =
"\tcfp add <row> <slice> <filename>\n"
"\tcfp delete <row>\n"
"\tcfp update <row> <filename>\n"
"\tcfp stats <row>\n"
"\tcfp show\n"
"\tcfp show <row>\n"
"\tcfp port <num> enable\n"
"\tcfp port <num> disable\n"
"\n";

ETHSWT_CFPL3FramingType formatToL3Framing(uint32_t format)
{
    switch(format) {
        case 0UL:
            return ETHSWT_CFP_L3FRAMING_IPV4;
        case 1UL:
            return ETHSWT_CFP_L3FRAMING_IPV6;
        case 2UL:
            return ETHSWT_CFP_L3FRAMING_NONIP;
        default:
            return ETHSWT_CFP_L3FRAMING_NONIP+1U;
    }
}

char* l3FramingToStr(ETHSWT_CFPL3FramingType l3Framing)
{
    switch (l3Framing) {
        case ETHSWT_CFP_L3FRAMING_NONIP:
            return "Non-IP";
        case ETHSWT_CFP_L3FRAMING_IPV4:
            return "IPv4";
        case ETHSWT_CFP_L3FRAMING_IPV6:
            return "IPv6";
        default:
            return "Invalid L3Framing";
    }
}

char* UDFBaseIdToStr(uint32_t baseId)
{
    switch (baseId) {
        case ETHSWT_CFP_UDFBASE_SOP:
            return "SOP";
        case ETHSWT_CFP_UDFBASE_ENDL2HDR:
            return "End-L2-Header";
        case ETHSWT_CFP_UDFBASE_ENDL3HDR:
            return "End-L3-Header";
        default:
            return "Invalid BaseId";
    }
}

void printTag(uint32_t aTag, uint32_t aTagMask)
{
    char *unTagged   = "Un-Tagged";
    char *prioTagged = "Priority-Tagged";
    char *vlanTagged = "VLAN-Tagged";
    uint8_t flag     = FALSE;

    /* check for invalid case
       1. Un-tagged or VLAN-Tagged is not a supported combination
       2. Tag-status bit-map should not be zero */
    if(((aTag & ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK) && (aTag & ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK)
       && (!(aTag & ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK))) ||
        ((!(aTag & ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK) && (!(aTag & ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK)))
       && (!(aTag & ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK)))) {
        HOST_Log("%s","Invalid Acceptable Frame Type");
    } else {
        if(aTag & ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK) {
            HOST_Log("%s", unTagged);
            flag = TRUE;
        }
        if(aTag & ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK) {
            if(FALSE == flag) {
                HOST_Log("%s", prioTagged);
            } else {
                HOST_Log(", %s", prioTagged);
            }
            flag = TRUE;
        }
        if(aTag & ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK) {
            if(FALSE == flag) {
                HOST_Log("%s", vlanTagged);
            } else {
                HOST_Log(", %s", vlanTagged);
            }
        }
    }

    if ((aTag & ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) == ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) {
        HOST_Log(" VID %lu", (aTag & ETHSWT_CFP_KEY_TAG_ID_MASK) >> ETHSWT_CFP_KEY_TAG_ID_SHIFT);
        if(0xFFFUL != (aTagMask & ETHSWT_CFP_KEY_TAG_IDMASK_MASK) >> ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT) {
            HOST_Log(" VID Mask 0x%lx", (aTagMask & ETHSWT_CFP_KEY_TAG_IDMASK_MASK) >> ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT);
        }
    }
    if ((aTag & ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK) == ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK) {
        HOST_Log(" DEI %lu", (aTag & ETHSWT_CFP_KEY_TAG_DEI_MASK) >> ETHSWT_CFP_KEY_TAG_DEI_SHIFT);
    }
    if ((aTag & ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK) == ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK) {
        HOST_Log(" PCP %lu", (aTag & ETHSWT_CFP_KEY_TAG_PCP_MASK) >> ETHSWT_CFP_KEY_TAG_PCP_SHIFT);
        if(ETHSWT_CFP_KEY_TAG_PCPMASK_MASK != (aTagMask & ETHSWT_CFP_KEY_TAG_PCPMASK_MASK)) {
            HOST_Log(" PCP Mask 0x%lx", (aTagMask & ETHSWT_CFP_KEY_TAG_PCPMASK_MASK) >> ETHSWT_CFP_KEY_TAG_PCPMASK_SHIFT);
        }
    }
}

int32_t show_cfp_rule(ETHSWT_CFPRuleType* rule)
{
    uint32_t i;
    int32_t  retVal = -1;
    uint16_t slice = (rule->rowAndSlice & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK) >> ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT;

    if (ETHSWT_CFP_MAX_SLICES > slice) {
        HOST_Log("\nSlice                    : %u\n", slice);
        HOST_Log("================== Key ==================\n");
        HOST_Log("L3 Framing               : %s\n", l3FramingToStr(rule->key.l3Framing));
        HOST_Log("L2 Framing               : ");
        switch (rule->key.l2Framing) {
            case ETHSWT_CFP_L2FRAMING_DIXV2:
                HOST_Log("DIXv2\n");
                break;
            case ETHSWT_CFP_L2FRAMING_SNAP_PUB:
                HOST_Log("SNAP Public\n");
                break;
            case ETHSWT_CFP_L2FRAMING_SNAP_PVT:
                HOST_Log("SNAP Private\n");
                break;
            case ETHSWT_CFP_L2FRAMING_LLC:
                HOST_Log("LLC\n");
                break;
            default:
                break;
        }
        HOST_Log("Ingress Port Bitmap      : 0x%.4x\n", rule->key.ingressPortBitmap);
        HOST_Log("C-Tag                    : ");
        printTag(rule->key.cTagFlags, rule->key.cTagMask);
        HOST_Log("\nS-Tag                    : ");
        printTag(rule->key.sTagFlags, rule->key.sTagMask);

        HOST_Log("\n");
        if (rule->key.l3Framing == ETHSWT_CFP_L3FRAMING_NONIP) {
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_ETHTYPE_MASK) != 0UL) {
                HOST_Log("Ethertype                : 0x%lx\n", rule->key.flags & ETHSWT_CFP_KEY_ETHTYPE_MASK);
                if(0xFFFF != (rule->key.flagsMask & ETHSWT_CFP_KEY_ETHTYPE_MASK)) {
                    HOST_Log("Ethertype Mask           : 0x%lx\n", rule->key.flagsMask & ETHSWT_CFP_KEY_ETHTYPE_MASK);
                }
            }
        } else {
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_TTL_MASK) == ETHSWT_CFP_KEY_TTL_MASK) {
                HOST_Log("TTL                      : ");
                switch(rule->key.flags & ETHSWT_CFP_KEY_TTL_MASK) {
                    case 0U ... 1U:
                      HOST_Log("%lu\n", rule->key.flags & ETHSWT_CFP_KEY_TTL_MASK);
                      break;
                    case 2U:
                      HOST_Log("Others\n");
                      break;
                    case 3U:
                      HOST_Log("255\n");
                      break;
                    default:
                      HOST_Log("Error\n");
                      break;
                }
            }
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_AUTH_MASK) == ETHSWT_CFP_KEY_AUTH_MASK) {
                HOST_Log("Auth                     : %lu\n", (rule->key.flags & ETHSWT_CFP_KEY_AUTH_MASK) >> ETHSWT_CFP_KEY_AUTH_SHIFT);
            }
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_FRAG_MASK) == ETHSWT_CFP_KEY_FRAG_MASK) {
                HOST_Log("Fragmentation            : %lu\n", (rule->key.flags & ETHSWT_CFP_KEY_FRAG_MASK) >> ETHSWT_CFP_KEY_FRAG_SHIFT);
            }
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_NONFIRSTFRAG_MASK) == ETHSWT_CFP_KEY_NONFIRSTFRAG_MASK) {
                HOST_Log("Non-First Fragment       : %lu\n", (rule->key.flags & ETHSWT_CFP_KEY_NONFIRSTFRAG_MASK) >> ETHSWT_CFP_KEY_NONFIRSTFRAG_SHIFT);
            }
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_PROTO_MASK) != 0UL) {
                HOST_Log("Protocol                 : %lu\n", (rule->key.flags & ETHSWT_CFP_KEY_PROTO_MASK) >> ETHSWT_CFP_KEY_PROTO_SHIFT);
                HOST_Log("ProtocolMask             : %#x\n", (rule->key.flagsMask & ETHSWT_CFP_KEY_PROTO_MASK) >> ETHSWT_CFP_KEY_PROTO_SHIFT);
            }
            if ((rule->key.flagsMask & ETHSWT_CFP_KEY_TOS_MASK) != 0UL) {
                HOST_Log("Type Of Service          : %lu\n", (rule->key.flags & ETHSWT_CFP_KEY_TOS_MASK) >> ETHSWT_CFP_KEY_TOS_SHIFT);
                HOST_Log("Type Of Service Mask     : %#x\n", (rule->key.flagsMask & ETHSWT_CFP_KEY_TOS_MASK) >> ETHSWT_CFP_KEY_TOS_SHIFT);
            }
        }

        for (i = 0UL; i < rule->key.numEnabledUDFs; i++) {
            HOST_Log("UDF[%u] Base: ", i);
            switch ((rule->key.udfList[i].baseAndOffset & ETHSWT_CFP_UDF_DEFS_BASE_MASK) >> ETHSWT_CFP_UDF_DEFS_BASE_SHIFT) {
                case ETHSWT_CFP_UDFBASE_SOP:
                    HOST_Log("Start of Packet ");
                    break;
                case ETHSWT_CFP_UDFBASE_ENDL2HDR:
                    HOST_Log("End of L2 Header");
                    break;
                case ETHSWT_CFP_UDFBASE_ENDL3HDR:
                    HOST_Log("End of L2 Header");
                    break;
                default:
                    break;
            }
            HOST_Log(" Offset: %u Value: 0x%.4x Mask: 0x%.4x\n", (rule->key.udfList[i].baseAndOffset & ETHSWT_CFP_UDF_DEFS_OFFSET_MASK) >> ETHSWT_CFP_UDF_DEFS_OFFSET_SHIFT,
                    rule->key.udfList[i].value, rule->key.udfList[i].mask);
        }

        HOST_Log("\n================ Action =================\n");
        switch ((rule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >> ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) {
            case ETHSWT_CFP_CHANGEFWDMAP_REM:
                HOST_Log("Destination InBand Map : Remove 0x%x\n", (rule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_REP:
                HOST_Log("Destination InBand Map : Replace 0x%x\n", (rule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_ADD:
                HOST_Log("Destination InBand Map : Add 0x%x\n", (rule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            default:
                break;
        }
        switch ((rule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >> ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) {
            case ETHSWT_CFP_CHANGEFWDMAP_REM:
                HOST_Log("Destination OutOfBand Map: Remove 0x%x\n", (rule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_REP:
                HOST_Log("Destination OutOfBand Map: Replace 0x%x\n", (rule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_ADD:
                HOST_Log("Destination OutOfBand Map: Add 0x%x\n", (rule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            default:
                break;
        }
        if ((rule->action.tosIBFlags & ETHSWT_CFP_ACTION_CHANGE_TOS_MASK) >> ETHSWT_CFP_ACTION_CHANGE_TOS_SHIFT) {
            HOST_Log("InBand Type Of Service : %u\n", (rule->action.tosIBFlags & ETHSWT_CFP_ACTION_TOS_MASK) >> ETHSWT_CFP_ACTION_TOS_SHIFT);
        }
        if ((rule->action.tosOBFlags & ETHSWT_CFP_ACTION_CHANGE_TOS_MASK) >> ETHSWT_CFP_ACTION_CHANGE_TOS_SHIFT) {
            HOST_Log("OutOfBand Type Of Service: %u\n", (rule->action.tosOBFlags & ETHSWT_CFP_ACTION_TOS_MASK) >> ETHSWT_CFP_ACTION_TOS_SHIFT);
        }
        if ((rule->action.tcFlags & ETHSWT_CFP_ACTION_CHANGE_TC_MASK) >> ETHSWT_CFP_ACTION_CHANGE_TC_SHIFT) {
            HOST_Log("Trafic Class             : %u\n", (rule->action.tcFlags & ETHSWT_CFP_ACTION_TC_MASK) >> ETHSWT_CFP_ACTION_TC_SHIFT);
        }
        if ((rule->action.colorFlags & ETHSWT_CFP_ACTION_CHANGE_COLOR_MASK) >> ETHSWT_CFP_ACTION_CHANGE_COLOR_SHIFT) {
            HOST_Log("Color                    : ");
            switch((rule->action.colorFlags & ETHSWT_CFP_ACTION_COLOR_MASK) >> ETHSWT_CFP_ACTION_COLOR_SHIFT) {
                case ETHSWT_CFP_COLOR_GREEN:
                    HOST_Log("Green\n");
                    break;
                case ETHSWT_CFP_COLOR_YELLOW:
                    HOST_Log("Yellow\n");
                    break;
                case ETHSWT_CFP_COLOR_RED:
                    HOST_Log("Red\n");
                    break;
                default:
                    break;
            }
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_BYPASS_VLAN_MASK) >> ETHSWT_CFP_ACTION_BYPASS_VLAN_SHIFT) {
            HOST_Log("Bypass VLAN              : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_BYPASS_EAP_MASK) >> ETHSWT_CFP_ACTION_BYPASS_EAP_SHIFT) {
            HOST_Log("Bypass EAP               : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_BYPASS_STP_MASK) >> ETHSWT_CFP_ACTION_BYPASS_STP_SHIFT) {
            HOST_Log("Bypass STP               : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_LPBK_EN_MASK) >> ETHSWT_CFP_ACTION_LPBK_EN_SHIFT) {
            HOST_Log("Loopback                 : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_USE_DFLT_RED_MASK) >> ETHSWT_CFP_ACTION_USE_DFLT_RED_SHIFT) {
            HOST_Log("Use default RED profile  : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_MIRROR_OB_MASK) >> ETHSWT_CFP_ACTION_MIRROR_OB_SHIFT) {
            HOST_Log("Mirror OutOfBand data : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_MIRROR_IB_MASK) >> ETHSWT_CFP_ACTION_MIRROR_IB_SHIFT) {
            HOST_Log("Mirror InBand data     : Yes\n");
        }
        if ((rule->action.otherFlags & ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_MASK) >> ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_SHIFT) {
            HOST_Log("Bypass MAC limit         : Yes\n");
        }
        if (rule->action.reasonCode != 0U) {
            HOST_Log("Reason code              : %u\n", rule->action.reasonCode);
        }
        if (rule->action.chainID != 0U) {
            HOST_Log("Chain ID                 : %u\n", rule->action.chainID);
        }

        if (((rule->action.meter.policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT) != ETHSWT_CFP_POLICERMODE_DISABLED) {
            HOST_Log("Meter mode               : ");
            switch ((rule->action.meter.policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT) {
                case ETHSWT_CFP_POLICERMODE_RFC2698:
                    HOST_Log("RFC2698\n");
                    break;
                case ETHSWT_CFP_POLICERMODE_RFC4115:
                    HOST_Log("RFC4115\n");
                    break;
                case ETHSWT_CFP_POLICERMODE_MEF:
                    HOST_Log("MEF\n");
                    break;
                default:
                    break;
            }
            if ((rule->action.meter.policerFlags & ETHSWT_CFP_METER_CF_MASK) >> ETHSWT_CFP_METER_CF_SHIFT) {
                HOST_Log("Coupling flag            : Yes\n");
            }
            if ((rule->action.meter.policerFlags & ETHSWT_CFP_METER_CM_MASK) >> ETHSWT_CFP_METER_CM_SHIFT) {
                HOST_Log("Color Mode               : Blind\n");
            }
            if (((rule->action.meter.policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT) != ETHSWT_CFP_POLICERMODE_MEF) {
                if ((rule->action.meter.policerFlags & ETHSWT_CFP_METER_ACT_MASK) >> ETHSWT_CFP_METER_ACT_SHIFT) {
                    HOST_Log("Red packets treated as   : OutOfBands\n");
                }
            }
            HOST_Log("CIR                      : %u Kbps\n", (rule->action.meter.cirRefCnt * 1000)/256);
            HOST_Log("CBS                      : %u bytes\n", rule->action.meter.cirBktSize);
            HOST_Log("CTB                      : %u bytes\n", rule->action.meter.cirTkBkt/8);
            HOST_Log("EIR                      : %u Kbps\n", (rule->action.meter.eirRefCnt * 1000) /256);
            HOST_Log("EBS                      : %u bytes\n", rule->action.meter.eirBktSize);
            HOST_Log("ETB                      : %u bytes\n", rule->action.meter.eirTkBkt/8);
        }
    }

    return retVal;
}

void mgmt_cfp_cmd_handler(mqd_t sendMqd, mqd_t recvMqd, char *input_str, uint32_t input_str_len)
{
    char     *curr_str            = input_str;
    char     *rem_str             = NULL;
    uint32_t curr_str_len         = input_str_len;
    uint32_t rem_str_len          = 0;
    int32_t  command_parse_status = 0;
    int32_t  rv                   = CMD_USAGE;
    int32_t  retVal;
    uint32_t value1;
    uint32_t value2;
    uint32_t i;
    uint32_t j;
    uint32_t k;
    unsigned int param;

    if ((curr_str != NULL) && (curr_str_len != 0)) {
        if (!strncmp(input_str, "add", 3)) {
            HOST_CFPAddRuleType cfpAdd;
            rv = CMD_USAGE;
            /* parse row number */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            value1 = parse_integer(rem_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            /* parse slice number */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            value2 = parse_integer(rem_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            /* parse file name */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            cfpAdd.cmdRsp.cmd = HOST_CFP_ADD_RULE;
            memcpy(cfpAdd.fileName, rem_str, rem_str_len);
            cfpAdd.fileName[rem_str_len] = '\0';
            cfpAdd.value1 = value1;
            cfpAdd.value2 = value2;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfpAdd ,
                                    sizeof(cfpAdd), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (cfpAdd.cmdRsp.rsp)) {
                rv = CMD_FAIL;
                HOST_Log("CFP add rule returned %d\n", cfpAdd.cmdRsp.rsp);
            } else {
                rv = CMD_OK;
                show_cfp_rule(&cfpAdd.ruleList);
            }
        } else if (!strncmp(input_str, "delete", 6)) {
            HOST_CFPDeleteRuleType cfpDel;
            /* parse row number */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                rv = CMD_USAGE;
            } else {
                value1 = parse_integer(rem_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                if (value1 >= ETHSWT_CFP_MAX_RULES) {
                    HOST_Log("CFP row number must be in the range [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                    rv = CMD_FAIL;
                    goto done;
                }
                cfpDel.cmdRsp.cmd = HOST_CFP_DELETE_RULE;
                cfpDel.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfpDel ,
                                        sizeof(cfpDel), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (cfpDel.cmdRsp.rsp)) {
                    HOST_Log("CFP delete rule failed, retVal = %d\n", cfpDel.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    rv = CMD_OK;
                }
            }
        } else if (!strncmp(input_str, "update", 6)) {
            HOST_CFPUpdateRuleType cfpCfg;
            rv = CMD_USAGE;

            /* parse row number */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            value1 = parse_integer(rem_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

            curr_str = rem_str;
            curr_str_len = rem_str_len;
            /* parse file name */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                goto done;
            }
            if (value1 >= ETHSWT_CFP_MAX_RULES) {
                HOST_Log("CFP row number must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                rv = CMD_FAIL;
                goto done;
            }
            cfpCfg.cmdRsp.cmd = HOST_CFP_UPDATE_RULE;
            cfpCfg.value1 = value1;
            memcpy(cfpCfg.fileName, rem_str, rem_str_len);
            cfpCfg.fileName[rem_str_len] = '\0';
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfpCfg ,
                                    sizeof(cfpCfg), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (cfpCfg.cmdRsp.rsp)) {
                rv = CMD_FAIL;
                HOST_Log("CFP update rule returned %d\n", cfpCfg.cmdRsp.rsp);
            } else {
                rv = CMD_OK;
            }
        } else if (!strncmp(input_str, "show", 4)) {
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                HOST_CFPGetSnapshotType cfgSnap;
                uint32_t cfpRdIdx = 0UL;
                uint32_t available = 0UL;
                ETHSWT_CFPEntrySnapshotType recv_CFP[MGMT_CMD_STR_MAX_LEN];
                cfgSnap.cmdRsp.cmd = HOST_CFP_GETSNAPSHOT;
                memset(&cfgSnap.snapShot, 0U, sizeof(cfgSnap.snapShot));

                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfgSnap ,
                                    sizeof(cfgSnap), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == cfgSnap.cmdRsp.rsp)) {
                    HOST_Log("Total entries: %u\n", cfgSnap.snapShot.numValidEntries);
                    HOST_Log("Ports enabled: 0x%x\n", cfgSnap.snapShot.portEnableMask);
                    HOST_Log("======= UDFs =========\n");
                    for (k = 0UL; k < ETHSWT_CFP_NUM_FORMATS; ++k) {
                        HOST_Log("----- Format %s ------\n", l3FramingToStr(formatToL3Framing(k)));
                        for (i = 0UL; i < ETHSWT_CFP_MAX_SLICES; ++i) {
                            HOST_Log("Slice %u:\n", i);
                            for (j = 0UL; j < ETHSWT_CFP_MAX_UDFS; ++j) {
                                if (0U != cfgSnap.snapShot.udfList[k].udfs[i][j].enable) {
                                    HOST_Log("%u) Base %s Offset %u\n", j,
                                    UDFBaseIdToStr((cfgSnap.snapShot.udfList[k].udfs[i][j].address & ETHSWT_CFP_UDF_DEFS_BASE_MASK) >> ETHSWT_CFP_UDF_DEFS_BASE_SHIFT),
                                    (cfgSnap.snapShot.udfList[k].udfs[i][j].address & ETHSWT_CFP_UDF_DEFS_OFFSET_MASK) >> ETHSWT_CFP_UDF_DEFS_OFFSET_SHIFT);
                                }
                            }
                        }
                    }
                    do {
                        retVal = HOST_Receive(recvMqd, (char*) recv_CFP, MGMT_CMD_STR_MAX_LEN, &param);
                        if (-1 == retVal) {
                            HOST_Log("mq_receive Failed \n");
                            goto done;
                        } else {
                            memcpy(&CFPRules[cfpRdIdx], recv_CFP, retVal);
                            available = retVal / sizeof(ETHSWT_CFPEntrySnapshotType);
                            cfpRdIdx +=available;
                        }
                    } while(cfpRdIdx < ETHSWT_CFP_MAX_RULES);
                    HOST_Log("======= Rules =========\n");
                    for (i = 0UL; i < ETHSWT_CFP_MAX_RULES; ++i) {
                        if (0U != (CFPRules[i] & ETHSWT_CFP_ENTRYSNAPSHOT_ENABLE_MASK)) {
                            HOST_Log("%u) Slice %u Format %s Static %u\n", i,
                                    (CFPRules[i] & ETHSWT_CFP_ENTRYSNAPSHOT_SLICE_MASK) >> ETHSWT_CFP_ENTRYSNAPSHOT_SLICE_SHIFT,
                                    l3FramingToStr(formatToL3Framing(
                                        (CFPRules[i] & ETHSWT_CFP_ENTRYSNAPSHOT_FORMAT_MASK) >> ETHSWT_CFP_ENTRYSNAPSHOT_FORMAT_SHIFT)),
                                        (CFPRules[i] & ETHSWT_CFP_ENTRYSNAPSHOT_STATIC_MASK) >> ETHSWT_CFP_ENTRYSNAPSHOT_STATIC_SHIFT);
                        }
                    }

                    rv = CMD_OK;
                } else {
                    HOST_Log("CFP get snapshot failed, retVal = %d\n", cfgSnap.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }
            } else {
                HOST_CFPGetRowCfgType cfpRowCfg;
                memset(&cfpRowCfg.rowConfig, 0U, sizeof(cfpRowCfg.rowConfig));
                /* parse row number */
                value1 = parse_integer(rem_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                if (value1 >= ETHSWT_CFP_MAX_RULES) {
                    HOST_Log("CFP row number must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                    rv = CMD_FAIL;
                    goto done;
                }
                cfpRowCfg.value1 = value1;
                cfpRowCfg.cmdRsp.cmd = HOST_CFP_GETROWCFG;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfpRowCfg ,
                                        sizeof(cfpRowCfg), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (cfpRowCfg.cmdRsp.rsp)) {
                    HOST_Log("CFP get row config failed, retVal = %d\n", cfpRowCfg.cmdRsp.rsp);
                    rv = CMD_FAIL;
                } else {
                    show_cfp_rule(&cfpRowCfg.rowConfig);
                    rv = CMD_OK;
                }
            }
        } else if (!strncmp(input_str, "stats", 5)) {
            HOST_CFPGetStatsType cfpStats;

            /* parse row number */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                rv = CMD_USAGE;
            } else {
                cfpStats.cmdRsp.cmd = HOST_CFP_GETSTATS;
                value1 = parse_integer(rem_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
                cfpStats.value1 = value1;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfpStats ,
                                        sizeof(cfpStats), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == cfpStats.cmdRsp.rsp)) {
                    HOST_Log("Green : %u\n", cfpStats.stats.green);
                    HOST_Log("Yellow: %u\n", cfpStats.stats.yellow);
                    HOST_Log("Red   : %u\n", cfpStats.stats.red);
                    rv = CMD_OK;
                } else {
                    HOST_Log("CFP get stats failed, retVal = %d\n", cfpStats.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }
            }
        } else if (!strncmp(input_str, "port", 4)) {
            HOST_CFPSetPortModeType cfpPort;
            cfpPort.cmdRsp.cmd = HOST_CFP_SET_PORTMODE;
            /* parse port number */
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str == NULL) || (rem_str_len == 0)) {
                rv = CMD_USAGE;
            } else {

                value1 = parse_integer(rem_str, &command_parse_status);
                MGMT_CMD_INT_PARSE_STATUS(command_parse_status);

                curr_str = rem_str;
                curr_str_len = rem_str_len;
                /* parse file name */
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str == NULL) || (rem_str_len == 0)) {
                    rv = CMD_USAGE;
                    goto done;
                }

                if (!strncmp(rem_str, "enable", 6)) {
                    value2 = 1UL;
                } else if (!strncmp(rem_str, "disable", 7)) {
                    value2 = 0UL;
                } else {
                    rv = CMD_USAGE;
                    goto done;
                }
                cfpPort.value1 = value1;
                cfpPort.value2 = value2;
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &cfpPort ,
                                        sizeof(cfpPort), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == cfpPort.cmdRsp.rsp)) {
                    rv = CMD_OK;
                } else {
                    HOST_Log("CFP set port mode failed, retVal = %d\n", cfpPort.cmdRsp.rsp);
                    rv = CMD_FAIL;
                }
            }
        } else {
            rv = CMD_USAGE;
            goto done;
        }
    }

done:
    if(CMD_USAGE == rv) {
        HOST_Log(mgmt_cfp_cmd_usage);
    }
    return;
}
#endif /* ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER */

static const char mgmt_generic_cmd_usage[] =
"\terase <img>\n"
"\treboot\n"
"\tversion\n"
"\tspi_id [id]\n"
"\tprobe\n"
"\tconn_mode <spi/pcie>\n"
"\tasync count heartbeat\n"
"\tasync dump \n"
"\ttraffic stop\n"
"\ttraffic start\n"
"\thelp\n";

static void print_usage(mqd_t sendMqd, mqd_t recvMqd)
{
    char str[] = "help";
    HOST_Exec_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
    HOST_Install_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
    HOST_NVM_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
    mgmt_switch_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
#endif
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
    mgmt_ets_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
#endif
#ifdef ENABLE_DBGMEM
    mgmt_mem_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
#endif
    mgmt_reg_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
    mgmt_cfp_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
#endif
    mgmt_otp_cmd_handler(sendMqd, recvMqd, str, sizeof(str));
    HOST_Log(mgmt_generic_cmd_usage);
}

static void process_user_cmd(char *input_str, mqd_t sendMqd, mqd_t recvMqd)
{
    struct mq_attr attr;
    uint32_t msgCnt =0;
    unsigned int param;
    int retVal;
    char *rem_str;
    char *curr_str;
    uint32_t rem_str_len;
    uint32_t curr_str_len;
    int32_t command_parse_status = 0;

    HOST_Log("bcmutil: %s\n", input_str);
    /* Parse the input command and parameters */
    split_line(input_str, strlen(input_str), &rem_str, &rem_str_len);

    if (0 == strncmp(input_str, "install", 7)) {
        HOST_Install_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
    } else if (0UL == strncmp(input_str, "execute", 7)) {
        HOST_Exec_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
    } else if (0 == strncmp(input_str, "switch", 6)) {
        mgmt_switch_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
#endif
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
    } else if (0 == strncmp(input_str, "ets", 3)) {
        mgmt_ets_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
    } else if (0 == strncmp(input_str, "avnu", 4)) {
        mgmt_ets_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
#endif
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
    } else if (0 == strncmp(input_str, "cfp", 3)) {
            mgmt_cfp_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
#endif
    } else if (0 == strncmp(input_str, "nvm", 3)) {
        HOST_NVM_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
    } else if (0 == strncmp(input_str, "erase", 5)) {
        if ((rem_str != NULL) && (rem_str_len > 1UL)) {
            HOST_InstallType erase;
            erase.cmdRsp.cmd = HOST_ERASE_IMAGE;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            memcpy(erase.fileName, curr_str, curr_str_len);
            erase.fileName[curr_str_len] = '\0';
            if ((rem_str == NULL) && (rem_str_len == 0)) {
                retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &erase ,
                        sizeof(erase), MGMT_CMD_STR_MAX_LEN, 1, &param);
                if ((BCM_ERR_OK != retVal) || (erase.cmdRsp.rsp)) {
                    HOST_Log("HOST_FlashErase returned %d\n", erase.cmdRsp.rsp);
                }
            } else {
                HOST_Log("erase <img>\n");
            }
        } else {
            HOST_Log("bootloader needed\n");
        }
    } else if (0 == strncmp(input_str, "reboot", 6)) {
        HOST_InstallType reboot;
        reboot.cmdRsp.cmd = HOST_SWT_REBOOT;
        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &reboot ,
                                sizeof(reboot), MGMT_CMD_STR_MAX_LEN, 1, &param);
        if ((BCM_ERR_OK != retVal) || (reboot.cmdRsp.rsp)) {
            HOST_Log("Reboot Failed\n");
        } else {
            HOST_Log("Rebooted \n");
        }
    } else if (0 == strncmp(input_str, "version", 7)) {
        HOST_VersionType ver;
        ver.cmdRsp.cmd = HOST_SWT_VERSION;
        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &ver ,
                                sizeof(ver), MGMT_CMD_STR_MAX_LEN, 1, &param);
        if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == ver.cmdRsp.rsp)) {
            HOST_Log("%s\n", ver.version);
        }
#ifdef ENABLE_DBGMEM
    } else if (0 == strncmp(input_str, "mem", 3)) {
        mgmt_mem_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
#endif
    } else if (0 == strncmp(input_str, "reg", 3)) {
        mgmt_reg_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
    } else if (0 == strncmp(input_str, "flash", 5)) {
        HOST_FlashWrite_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
    } else if (0 == strncmp(input_str, "otp", 3)) {
        mgmt_otp_cmd_handler(sendMqd, recvMqd, rem_str, rem_str_len);
    } else if (0 == strncmp(input_str, "probe", 5)) {
        HOST_GetActiveSlavesType slave;

        slave.cmdRsp.cmd = HOST_GET_ACTIVE_SLAVES;
        slave.count = 4;
        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &slave ,
                                sizeof(slave), MGMT_CMD_STR_MAX_LEN, 1, &param);
        if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != slave.cmdRsp.rsp)) {
            HOST_Log("Failed to retrieve active slaves, err:%d\n", slave.cmdRsp.rsp);
        } else {
            HOST_Log("Active Slave Count: %u\n", slave.count);
            HOST_Log("Ids:[%d %d %d %d]\n", slave.activeSpiId[0], slave.activeSpiId[1],
                slave.activeSpiId[2], slave.activeSpiId[3]);
        }
    } else if (0 == strncmp(input_str, "spi_id", 6)) {
        if ((rem_str == NULL) || (rem_str_len == 0UL)) {
            HOST_GetSlaveType getSlave;
            getSlave.cmdRsp.cmd = HOST_GET_SLAVE;
        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &getSlave ,
                                sizeof(getSlave), MGMT_CMD_STR_MAX_LEN, 1, &param);
        if ((BCM_ERR_OK == retVal) && (BCM_ERR_OK == getSlave.cmdRsp.rsp)) {
                HOST_Log("Current SPI ID: %u\n", getSlave.param);
            } else {
                HOST_Log("Failed to retrieve ID err:%x\n", getSlave.cmdRsp.rsp);
                goto done;
            }
        } else {
            HOST_SetSlaveType setSlave;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
            if ((rem_str != NULL) || (rem_str_len != 0UL)) {
                HOST_Log("Invalid syntax\n");
                goto done;
            }
            setSlave.cmdRsp.cmd = HOST_SET_SLAVE;
            setSlave.param = parse_integer(curr_str, &command_parse_status);
            MGMT_CMD_INT_PARSE_STATUS(command_parse_status);
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &setSlave ,
                                    sizeof(setSlave), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != setSlave.cmdRsp.rsp)) {
                HOST_Log("Failed to set ID err:%x\n", setSlave.cmdRsp.rsp);
                goto done;
            }
        }
    } else if (strncmp(input_str, "conn_mode", 9) == 0UL) {
        if ((rem_str == NULL) || (rem_str_len == 0UL)) {
            HOST_GetConnType getCon;
            getCon.cmdRsp.cmd = HOST_GET_CONN_MODE;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &getCon ,
                                    sizeof(getCon), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if (BCM_ERR_OK == retVal) {
                if (MGMT_SPI_CONNECTION == getCon.cmdRsp.rsp) {
                    HOST_Log("current mode: spi\n");
                } else if (MGMT_PCIE_CONNECTION == getCon.cmdRsp.rsp) {
                    HOST_Log("current mode: pcie\n");
                } else {
                    HOST_Log("current mode: unknown\n");
                }
            } else {
                HOST_Log("Failed to receive Response\n");
                goto done;
            }
        } else {
            HOST_SetConnType setCon;
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (strncmp(curr_str, "spi", 3) == 0UL) {
                setCon.mode=MGMT_SPI_CONNECTION;
            } else if (strncmp(curr_str, "pcie", 4) == 0UL) {
                setCon.mode=MGMT_PCIE_CONNECTION;
            } else {
                HOST_Log("Invalid connection mode\n");
                goto done;
            }
            setCon.cmdRsp.cmd = HOST_SET_CONN_MODE;
            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &setCon ,
                                    sizeof(setCon), MGMT_CMD_STR_MAX_LEN, 1, &param);
            if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != setCon.cmdRsp.rsp)) {
                HOST_Log("Failed to set Connection mode %d\n",setCon.cmdRsp.rsp);
                goto done;
            }

        }
    } else if(strncmp(input_str, "async", 5) == 0UL) {
            HOST_GetSlaveType getSlave;
            HOST_KeepAliveType keepAlive;
            getSlave.cmdRsp.cmd = HOST_GET_SLAVE;
            keepAlive.cmdRsp.cmd = HOST_KEEP_ALIVE;
        if ((rem_str != NULL) && (rem_str_len != 0)) {
            curr_str = rem_str;
            curr_str_len = rem_str_len;
            if (0UL == strncmp(curr_str, "count", 5)) {
                split_line(curr_str, curr_str_len, &rem_str, &rem_str_len);
                if ((rem_str != NULL) && (rem_str_len != 0)) {
                    curr_str = rem_str;
                    curr_str_len = rem_str_len;
                    if (strncmp(curr_str, "heartbeat", 9) == 0UL) {
                        retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &getSlave ,
                                                sizeof(getSlave), MGMT_CMD_STR_MAX_LEN, 1, &param);
                        if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != getSlave.cmdRsp.rsp)) {
                            HOST_Log("Failed to retrieve slave ID err:%x\n", getSlave.cmdRsp.rsp);
                        } else {
                            keepAlive.param = getSlave.param;
                            retVal = HOST_SendReceive(sendMqd, recvMqd, (char*) &keepAlive ,
                                                    sizeof(keepAlive), MGMT_CMD_STR_MAX_LEN, 1, &param);
                            if ((BCM_ERR_OK != retVal) || (BCM_ERR_OK != keepAlive.cmdRsp.rsp)) {
                                HOST_Log("Failed to get heartbeat information retVal:0x%x\n", keepAlive.cmdRsp.rsp);
                            } else {
                                HOST_Log("Async heartbeats Count:%u Time:%d.%09d\n",
                                        keepAlive.keepAlive.count,
                                        keepAlive.keepAlive.upTime.s,
                                        keepAlive.keepAlive.upTime.ns);
                                HOST_Log("State:%d \nVolatge:%d mV \nTemperature:%d C\n",
                                        keepAlive.keepAlive.state,
                                        keepAlive.keepAlive.voltage,
                                        keepAlive.keepAlive.temperature);
                            }
                        }
                    }
                }
            } else if (0UL == strncmp(curr_str, "dump", 4)) {
                HOST_AsyncNotificationType asyncMsg;
                if (mq_getattr(asyncMqd, &attr) == -1) {
                    perror("mq_getattr");
                }
                msgCnt = attr.mq_curmsgs;
                if(0 < msgCnt) {
                    while(0 < msgCnt){
                        retVal = HOST_Receive(asyncMqd, (char*) &asyncMsg, ASYNCQ_MAX_LEN, &param);
                        if (-1 == retVal) {
                            HOST_Log("mq_receive Failed \n");
                            return;
                        } else {
                            retVal = ETHSRVNotificationHandler(asyncMsg.currentSlave, asyncMsg.comp,
                                                asyncMsg.notificationId, &asyncMsg.msg[0], asyncMsg.size);
                            if(BCM_ERR_OK !=retVal) {
                                HOST_Log("%s: Failed to Process Id:0x%x len:0x%x\n",
                                        __func__, asyncMsg.replyId, asyncMsg.size);
                            }
                        }
                        msgCnt--;
                     }/* while */
                } else { /* if no Messages */
                    HOST_Log("No Async Messages in Queue\n");
                }
            }
        } else {
            print_usage(sendMqd, recvMqd);
        }
    } else if(strncmp(input_str, "help", 5) == 0UL) {
        print_usage(sendMqd, recvMqd);
    } else { /**/
        HOST_Log("Unknown Command\n");
        print_usage(sendMqd, recvMqd);
    }
    HOST_Log("bcmutil: %s processed successfully\n", input_str);
done:
    return;
}

int main(int argc, char *argv[])
{
    mqd_t sendMqd = -1;
    mqd_t recvMqd = -1;
    int i;
    int retVal = -1;
    int strsize = 0;
    char *cmdstring;
    char env[200] = "";
    char mqName[200];

    if (argc < 2) {
        goto done;
    }
    for (i=1; i<argc; i++) {
        strsize += strlen(argv[i]);
        strsize++; /* account for space and null termination */
    }
    if (strsize > MGMT_CMD_STR_MAX_LEN) {
        HOST_Log("Command size:%d > maximum allowed:%d\n", strsize, MGMT_CMD_STR_MAX_LEN);
        goto done;
    }

    cmdstring = malloc(strsize);
    cmdstring[0] = '\0';
    for (i=1; i<argc; i++) {
        strcat(cmdstring, argv[i]);
        if (i < (argc - 1)) {
            strcat(cmdstring, " ");
        }
    }

    if (NULL != getenv("BCMUTIL_INSTANCE")) {
        sprintf(env, "_%s", getenv("BCMUTIL_INSTANCE"));
    }

    strcpy(mqName, HOST_SEND_MSGQ_NAME);
    strcat(mqName, env);
    sendMqd = mq_open(mqName, O_WRONLY);
    if (sendMqd == -1) {
        perror("mq_open");
        goto done;
    }

    strcpy(mqName, HOST_RECV_MSGQ_NAME);
    strcat(mqName, env);
    recvMqd = mq_open(mqName, O_RDONLY);
    if (recvMqd == -1) {
        perror("mq_open");
        goto done;
    }

    strcpy(mqName, HOST_ASYNC_MSGQ_NAME);
    strcat(mqName, env);
    asyncMqd = mq_open(mqName, O_RDONLY);
    if (asyncMqd == -1) {
        perror("mq_open");
        goto done;
    }

    if (0 == cmdstring[0]) {
        goto done;
    }

    process_user_cmd(cmdstring, sendMqd, recvMqd);

done:
    if (-1 != sendMqd) {
        retVal = mq_close(sendMqd);
        if (-1 == retVal) {
            perror("mq_close");
        }
    }
    if (-1 != recvMqd) {
        retVal = mq_close(recvMqd);
        if (-1 == retVal) {
            perror("mq_close");
        }
    }
    if (-1 != asyncMqd) {
        retVal = mq_close(asyncMqd);
        if (-1 == retVal) {
            perror("mq_close");
        }
    }

    return retVal;
}

#ifdef ENABLE_HOST_ETS_CMD_HANDLER
static int32_t ETSNotificationHandler(uint32_t currentSlave, ETS_EventType notificationId,
                                              uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETS_MsgUnionType notificationHdl;

    if (NULL == msg) {
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x msg:%p size=%d\n",
            __func__, currentSlave, notificationId, msg, size);
        goto done;
    }

    BCM_MemCpy(notificationHdl.data, msg, size);

    switch (notificationId) {
    case ETS_EVENT_IF_UP:
        HOST_Log("%s SPI-Id:%u Interface:%u Up\n", HOST_ETS_ASYNC_PREFIX,
                currentSlave, uswap32(notificationHdl.portNum));
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_IF_DOWN:
        HOST_Log("%s SPI-Id:%u Interface:%u Down\n", HOST_ETS_ASYNC_PREFIX,
                currentSlave, uswap32(notificationHdl.portNum));
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_SYNC:
        HOST_Log("%s SPI-Id:%u Sync\n", HOST_ETS_ASYNC_PREFIX, currentSlave);
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_SYNC_LOST:
        HOST_Log("%s SPI-Id:%u Sync Lost\n", HOST_ETS_ASYNC_PREFIX, currentSlave);
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_IF_LOST_RESP_EXCEEDED:
        HOST_Log("%s SPI-Id:%u Interface:%u Lost response exceeded\n",
                HOST_ETS_ASYNC_PREFIX, currentSlave, uswap32(notificationHdl.portNum));
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_IF_LOST_RESP_RECOVERED:
        HOST_Log("%s SPI-Id:%u Interface:%u Lost response recovered\n",
                HOST_ETS_ASYNC_PREFIX, currentSlave, uswap32(notificationHdl.portNum));
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_IF_PDELAY_CHANGED:
        HOST_Log("%s SPI-Id:%u Interface:%u PDelay changed to %u NBRR 0x%x\n",
                HOST_ETS_ASYNC_PREFIX, currentSlave, uswap32(notificationHdl.pDelayNBRR.port),
                uswap32(notificationHdl.pDelayNBRR.pDelay), uswap32(notificationHdl.pDelayNBRR.nbrr));
        retVal = BCM_ERR_OK;
        break;
    case ETS_EVENT_IF_RECORD:
        retVal = BCM_ERR_OK;
        break;
    default:
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x size=%d\n",
            __func__, currentSlave, notificationId, size);
        break;
    }

done:
    return retVal;
}
#endif

static int32_t EtherSwtNotificationHandler(uint32_t currentSlave,
                uint32_t  notificationId, uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_CFPMsgUnionType cfpPayLd;
    ETHSWT_ExtMsgUnionType extPayLdHdl;

    if (NULL == msg) {
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x msg:%p size=%d\n",
            __func__, currentSlave, notificationId, msg, size);
        goto done;
    }


    switch (notificationId) {
    case ETHSWT_EXTASYNCEVENT_PORT_LINK_INFO:
        if (size == sizeof(ETHSWT_ExtPortLinkInfoType)) {
            BCM_MemCpy(extPayLdHdl.data, msg, size);
            HOST_Log("%s SPI-Id:%u Interface:%u Status:%s ChangeCount:%u\n",
                    __func__, currentSlave,
                    uswap32(extPayLdHdl.portLinkInfo.port),
                    (uswap32(extPayLdHdl.portLinkInfo.linkState) ==
                    ETHXCVR_LINKSTATE_ACTIVE) ? "Active" : "Down",
                    uswap32(extPayLdHdl.portLinkInfo.portStats.linkStateChangeCount));
            retVal = BCM_ERR_OK;
        } else {

            HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x size=%d\n",
                __func__, currentSlave, notificationId, size);
        }
        break;
    case ETHSWT_CFPASYNCID_STREAM_EXCEEDED:
        if (size == sizeof(ETHSWT_CFPStreamPolicerStatusType)) {
            memcpy(&cfpPayLd, msg, sizeof(ETHSWT_CFPStreamPolicerStatusType));
            HOST_Log("%s SPI-Id:%u Stream: %u exceeded, blocked %u\n",
                    __func__, currentSlave,
                    uswap32(cfpPayLd.streamPolicerStatus.idx),
                    uswap32(cfpPayLd.streamPolicerStatus.blocked));
            retVal = BCM_ERR_OK;
        } else {

            HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x size=%d\n",
                __func__, currentSlave, notificationId, size);
        }
        break;
    default:
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x size=%d\n",
            __func__, currentSlave, notificationId, size);
        break;
    }

done:
    return retVal;
}

static int32_t EtherNotificationHandler(uint32_t currentSlave,
                  uint8_t notificationId, uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    return retVal;
}

#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
static int32_t CFPNotificationHandler(uint32_t currentSlave,
                 uint8_t notificationId, uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    return retVal;
}
#endif

#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
static int32_t FANotificationHandler(uint32_t currentSlave,
                 uint8_t notificationId, uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    ETHSWT_FAMsgUnionType notificationHdl;

    if (NULL == msg) {
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x msg:%p size=%d\n",
            __func__, currentSlave, notificationId, msg, size);
        goto done;
    }

    memcpy(&(notificationHdl.data), msg, sizeof(ETHSWT_FAIntrFlagsType));

    switch (notificationId) {
    case ETHSWT_FAASYNCEVENT_INTERRUPT:
        if (size == sizeof(ETHSWT_FAIntrFlagsType)) {
            HOST_Log("SPI-Id:%u FA Interrupt flags:0x%x\n",
                     currentSlave, uswap32(notificationHdl.intrFlags));
            retVal = BCM_ERR_OK;
        } else {

            HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x size=%d\n",
                __func__, currentSlave, notificationId, size);
        }
        break;
    default:
        HOST_Log("%s SPI-Id:%u Invalid parameter notificationId:0x%x size=%d\n",
            __func__, currentSlave, notificationId, size);
        break;
    }

done:
    return retVal;
}
#endif

static int32_t ETHSRVNotificationHandler(uint32_t currentSlave,
            BCM_CompIDType comp, uint8_t notificationId,
            uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    switch (comp) {
    case BCM_COM_ID:
        switch (notificationId) {
        case ETTM_CMDID_READY_FOR_TIMESYNC:
            HOST_Log("%s SPI-Id:%u Ready to synchronise time-blocks\n",
                    __func__, currentSlave);
            retVal = BCM_ERR_OK;
            break;
        default:
            HOST_Log("%s SPI-Id:%u Invalid comp:0x%x notificationId:0x%x\n",
                    __func__, currentSlave, comp, notificationId);
            break;
        }
        break;
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
    case BCM_ETS_ID:
        retVal = ETSNotificationHandler(currentSlave, notificationId, msg,size);
        break;
#endif
    case BCM_SWT_ID:
        retVal = EtherSwtNotificationHandler(currentSlave, notificationId, msg, size);
        break;
    case BCM_AMC_ID:
        retVal = EtherNotificationHandler(currentSlave, notificationId, msg, size);
        break;
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
    case BCM_CFP_ID:
        retVal = CFPNotificationHandler(currentSlave, notificationId, msg, size);
        break;
#endif
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
    case BCM_FAC_ID:
        retVal = FANotificationHandler(currentSlave, notificationId, msg, size);
        break;
#endif
    default:
        HOST_Log("%s Invalid comp:0x%x notificationId:0x%x\n",
                __func__, comp, notificationId);
        break;
    }

    return retVal;
}

void BCM_ReportError(uint16_t aCompID,
                     uint8_t aInstanceID,
                     uint16_t aApiID,
                     int32_t aErrorID,
                     uint32_t aNumInts,
                     const uint32_t *const aValues)
{
    printf("Error from comp %x\t apiID %x ret %x val = [%d %d %d %d] \n",aCompID,aApiID,aErrorID,*(aValues),*(aValues+1),*(aValues+2),*(aValues+3));
}
