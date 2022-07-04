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

#include <stddef.h>
#include <stdio.h>
#include <compiler.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <bcm_err.h>
#include <rpc_interface.h>
#include <rpc_module_v2.h>
#include <rpc_hosthelper.h>
#include <rpc_ipc_host.h>
#include <rpc_hostcmd.h>

const uint32_t MODULE_Event = 0UL;

void print_usage(void)
{
    printf("------------------------------------------------------------------\n");
    printf("Required Arguments: \n");
    printf("            -c <chip>\n");
    printf("Optional Arguments: \n");
    printf("            -i [interface] \n");
    printf("            -s [serial/ip:port] \n\n");
    printf("<chip>      : bcm89571 bcm89572 bcm89561 bcm89564\n");
    printf("[interface] : pcie jlink \n");
    printf("[serial]    : Segger Serial Number for jlink or IP addr with Port e.g. 192.168.10.2:19210\n");
    printf("\nNote: Default interface is jlink\n");
    printf("------------------------------------------------------------------\n");
}

int32_t configure_host_ipc(int argc, char *argv[])
{
    int retVal = BCM_ERR_OK;
    RPC_IpcHostIfcConfigType hostIpcfcCfg;
    uint32_t i;
    uint8_t ipAddr[4];
    char * tempIp;

    hostIpcfcCfg.mode   = RPC_IPCHOST_INTERFACE_JLINK;
    hostIpcfcCfg.serial = 0UL;
    hostIpcfcCfg.devId  = 0xFFFFFFFF;
    hostIpcfcCfg.chip   = RPC_IPCHOST_CHIP_IDX_MAX;

    if (argc >= 3) {
        for(i = 1; i < argc; i++) {
            if (0 == strcmp("-i", argv[i])) {
                i++;
                if (0 == strcmp("pcie", argv[i])) {
                    hostIpcfcCfg.mode = RPC_IPCHOST_INTERFACE_PCIE;
                } else if (0 == strcmp("jlink", argv[i])) {
                    hostIpcfcCfg.mode = RPC_IPCHOST_INTERFACE_JLINK;
                } else {
                    printf("Invalid Interface Name");
                    print_usage();
                    retVal = BCM_ERR_INVAL_PARAMS;
                    goto done;
                }
            } else if (0 == strcmp("-s", argv[i])) {
                i++;
                if (NULL == strchr(argv[i], ':')) {
                    /* Its segger serial number */
                    hostIpcfcCfg.serial = atoi(argv[i]);
                    printf("Segger Serial:%d\n", hostIpcfcCfg.serial);
                } else {
                    /* Its segger ip address */
                    tempIp = strtok(argv[i], ":");
                    hostIpcfcCfg.devId = atoi(strtok(NULL, ":"));
                    ipAddr[3] = atoi(strtok(tempIp, "."));
                    ipAddr[2] = atoi(strtok(NULL, "."));
                    ipAddr[1] = atoi(strtok(NULL, "."));
                    ipAddr[0] = atoi(strtok(NULL, "."));
                    hostIpcfcCfg.serial = (ipAddr[3] << 24) | (ipAddr[2] << 16) | (ipAddr[1] << 8) | ipAddr[0];
                    printf("Segger IP:%d.%d.%d.%d Port:%d\n", ipAddr[3], ipAddr[2], ipAddr[1], ipAddr[0], hostIpcfcCfg.devId);
                }
            } else if (0 == strcmp("-c", argv[i])) {
                i++;
                if (0 == strcmp("bcm89571", argv[i])) {
                    hostIpcfcCfg.chip = RPC_IPCHOST_CHIP_IDX_BCM89571;
                } else if (0 == strcmp("bcm89572", argv[i])) {
                    hostIpcfcCfg.chip = RPC_IPCHOST_CHIP_IDX_BCM89572;
                } else if (0 == strcmp("bcm89561", argv[i])) {
                    hostIpcfcCfg.chip = RPC_IPCHOST_CHIP_IDX_BCM89561;
                } else if (0 == strcmp("bcm89564", argv[i])) {
                    hostIpcfcCfg.chip = RPC_IPCHOST_CHIP_IDX_BCM89564;
                } else {
                    printf("Invalid Chip Name");
                    print_usage();
                    retVal = BCM_ERR_INVAL_PARAMS;
                    goto done;
                }
            } else {
                print_usage();
                retVal = BCM_ERR_INVAL_PARAMS;
                goto done;
            }
        }
    } else {
        print_usage();
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    /* Chip name is a mandatory parameter */
    if (RPC_IPCHOST_CHIP_IDX_MAX == hostIpcfcCfg.chip) {
        print_usage();
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    printf("Host IPC Interface Config bus:%d serial:%d \n", hostIpcfcCfg.mode,
                                                            hostIpcfcCfg.serial);

    retVal = RPC_IpcHostSetConfig(&hostIpcfcCfg);

done:
    return retVal;
}

int main(int argc, char *argv[])
{
    int32_t retVal;

    if (BCM_ERR_OK != configure_host_ipc(argc, argv)) {
        printf("Could not confgiure host ipc interface\n");
        goto done;
    }

    retVal = RPC_Module.resetStateHandler(BCM_STATE_INIT);
    if (BCM_ERR_OK != retVal) {
        printf("RPC Module INIT Failed\n");
        exit(-1);
    }

    do {
        /* NOTE: Currently we are invoking the RPC module handler      */
        /* using a timer. This will be replaced by the Linux           */
        /* 'select' API which will use the list of file descriptors    */
        /* used by the socket slave module and also of the IPC master. */
        /* Whenever there is data at either of the these modules,      */
        /* it will get processed with the invocation of 'eventHandler' */
        RPC_Module.eventHandler(0UL);
        RPC_HostCmdService.server.eventHandler(0UL);
        usleep(100);
    } while (1);

done:
    return 0;
}

void BCM_ReportError(uint16_t aCompID,
                     uint8_t aInstanceID,
                     uint16_t aApiID,
                     int32_t aErrorID,
                     uint32_t aNumInts,
                     const uint32_t *const aValues)
{
    printf("Error from comp %x\t apiID %x ret %x val = [%d %d %d %d] \n",
                 aCompID,aApiID,aErrorID,
                 *(aValues),*(aValues+1),*(aValues+2),*(aValues+3));
}
