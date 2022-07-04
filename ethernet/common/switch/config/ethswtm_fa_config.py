#!/usr/bin/python3

# $Id$
# $Copyright: Copyright 2020-2021 Broadcom Limited.
# This program is the proprietary software of Broadcom Limited
# and/or its licensors, and may only be used, duplicated, modified
# or distributed pursuant to the terms and conditions of a separate,
# written license agreement executed between you and Broadcom
# (an "Authorized License").  Except as set forth in an Authorized
# License, Broadcom grants no license (express or implied), right
# to use, or waiver of any kind with respect to the Software, and
# Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE
# NO AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE
# IN ANY WAY, AND SHOULD IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE
# ALL USE OF THE SOFTWARE.
#
# Except as expressly set forth in the Authorized License,
#
# 1.     This program, including its structure, sequence and organization,
# constitutes the valuable trade secrets of Broadcom, and you shall use
# all reasonable efforts to protect the confidentiality thereof,
# and to use this information only in connection with your use of
# Broadcom integrated circuit products.
#
# 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS
# PROVIDED "AS IS" AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES,
# REPRESENTATIONS OR WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY,
# OR OTHERWISE, WITH RESPECT TO THE SOFTWARE.  BROADCOM SPECIFICALLY
# DISCLAIMS ANY AND ALL IMPLIED WARRANTIES OF TITLE, MERCHANTABILITY,
# NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF VIRUSES,
# ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
# CORRESPONDENCE TO nameRIPTION. YOU ASSUME THE ENTIRE RISK ARISING
# OUT OF USE OR PERFORMANCE OF THE SOFTWARE.
#
# 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL
# BROADCOM OR ITS LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL,
# INCIDENTAL, SPECIAL, INDIRECT, OR EXEMPLARY DAMAGES WHATSOEVER
# ARISING OUT OF OR IN ANY WAY RELATING TO YOUR USE OF OR INABILITY
# TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF
# THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR USD 1.00,
# WHICHEVER IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING
# ANY FAILURE OF ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.$
####################################################################################

##  @defgroup grp_ethsrv_fa_configurator Configurator
#   @ingroup grp_ethsrv_sw
#
#   @addtogroup grp_ethsrv_fa_configurator
#   @{
#
#   Detailed Overview to be populated here.
#
#   @limitations None
#
#   @file ethswtm_fa_config.py
#   @brief Ethsrv Flow Accelerator Configurator
#   This script file contains the configurator implementation for Ethsrv- Flow Accelerator
#   @version 0.1 Initial version

import sys
import getopt
import os
import struct
import binascii
import lxml

from lxml import etree
from lxml import objectify

##  @name FA COnfigurator Architecture IDs
#   @{
#   @brief Architecture IDs for FA Configurator
#
    ## @brief #ethsrv_fa_config.ETHSWTM_FA_Configurator
BRCM_SWARCH_ETHSWTM_FA_CONFIGURATOR_CLASS = 0
    ## @brief #ethsrv_fa_config.ETHSWTM_FA_ConfigUsage()
BRCM_SWARCH_ETHSWTM_FA_CONFIGUSAGE_PROC   = 1
    ## @brief #ethsrv_fa_config.ETHSWTM_FA_ConfigMain()
BRCM_SWARCH_ETHSWTM_FA_CONFIGMAIN_PROC    = 2
##  @}

##  @brief FA Configurator
#
#   FA configurator class for generating FA configuration binary.
#
#   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
class ETHSWTM_FA_Configurator:
    ##  @brief Configuration magic
    #
    #   Magic value of FA configuration for identification purpose- 'F''L''A''C'
    ETHSWTM_FA_CONFIG_MAGIC     = 0x464C4143

    ##  @brief Maximum static flows
    #
    #   Maximum number of static flows supported
    ETHSRV_FA_STATIC_FLOWS_MAX = 128

    ##  @brief Maxmum MAC addresses
    #
    #   Maximum number of MAC addresses supported per Device
    ETHSWTM_FA_MAC_MAX = 4

    ##  @brief Flow size
    #
    #   Size(in bytes) of the each flow element
    ETHSWTM_FA_FLOW_SIZE        = 83

    ##  @brief Instantiation operation
    #
    #   Creates a new instanace of the class
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self            #ETHSWTM_FA_Configurator object
    #   @param[in]      xmlFile         XML file containing FA configuration
    #   @param[in]      schemaFile      schema file for FA configuration
    #
    #   @retval     An instance of this class
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def __init__(self, xmlFile, schemaFile):
        schema = etree.XMLSchema(etree.parse(schemaFile))
        self.parser = objectify.makeparser(schema = schema)

        with open(xmlFile, 'r') as file:
            xml = file.read()

        self.cfg = objectify.fromstring(xml, self.parser)

    ##  @brief Get CRC type
    #
    #   Convert string into CRC type
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]  self        #ETHSWTM_FA_Configurator object
    #   @param[in]  str         String format of CRC type
    #
    #   Return values are documented in reverse-chronological order
    #   @retval     1           str is "CRC16"
    #   @retval     0           str is "CCITT"
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getCrc(self, str):
        if str == 'CCITT':
            ret = 0x0
        else:
            ret = 0x1
        return ret

    ##  @brief Get Mode value
    #
    #   Convert string into Mode value
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]   self        #ETHSWTM_FA_Configurator object
    #   @param[in]   str         String format of Mode of operation
    #
    #   Return values are documented in reverse-chronological order
    #   @retval      0          str is "NORMAL"
    #   @retval      1          str is "BYPASS"
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getMode(self, str):
        if str == 'BYPASS':
            ret = 0x1
        else:
            ret = 0x0
        return ret

    ##  @brief Get TE value
    #
    #   Convert string into TE value
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      str         String format of TE
    #
    #   Return values are documented in reverse-chronological order
    #   @retval     0       str is "NONE"
    #   @retval     1       str is "UNTAG"
    #   @retval     2       str is "HEADER"
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None

    def getTE(self, str):
        if str == 'HEADER':
            ret = 0x2
        elif str == 'UNTAG':
            ret = 0x1
        else:
            ret = 0x0
        return ret

    ##  @brief Get L2 operation value
    #
    #   Convert string into L2 operation value
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      str         String format of Operation
    #
    #   Return values are documented in reverse-chronological order
    #   @retval     3       str is "NO_OP"
    #   @retval     2       str is "NO_TAG"
    #   @retval     1       str is "C_TAG"
    #   @retval     0       str is "S_TAG"
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getL2Operation(self, str):
        if str == 'S_TAG':
            ret = 0x0
        elif str == 'C_TAG':
            ret = 0x1
        elif str == 'NO_TAG':
            ret = 0x2
        else:
            ret = 0x3
        return ret

    ##  @brief Get domain type
    #
    #   Convert string into internal/external type
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      str         String format of domain
    #
    #   Return values are documented in reverse-chronological order
    #   @retval     1       str is "EXTERNAL"
    #   @retval     0       str is "INTERNAL"
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getDomain(self, str):
        if str == 'EXTERNAL':
            ret = 0x1
        else:
            ret = 0x0
        return ret

    ##  @brief Get MAC address
    #
    #   Convert string into a byte array of MAC address
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      macString   String containing MAC address
    #
    #   @retval     bytearray of MAC Address
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getMAC(self, macString):
        macArray = macString.split(':')

        if len(macArray) != 6:
            print("Error: Incorrect mac length " + str(len(macArray)) + " for MAC: " + macString)
            sys.exit(1)
        else:
            for i in range(6):
                macArray[i] = int(macArray[i], 16)
        return bytearray(macArray)

    ##  @brief Get Device type
    #
    #   Convert string into MCU_DeviceType
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      str         string format of MCU_DeviceType
    #
    #   Return values are documented in reverse-chronological order
    #   @retval     0       str is "MASTER"
    #   @retval     1       str is "SLAVE"
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getDevice(self, str):
        if str == 'MASTER':
            ret = 0x0
        else:
            ret = 0x1
        return ret

    ##@brief Get IPv4 address
    #
    #   Convert string into a byte array of IPv4 address
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      ipString    String containing IP address in v4 format
    #
    #   @retval     bytearray of IPv4 Address
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getIPv4(self, ipString):
        ipArray = ipString.split('.')

        if len(ipArray) != 4:
            print("Error: Incorrect IPv4 address length " + str(len(ipArray)) + " for IP: " + ipString)
            sys.exit(1)
        else:
            for i in range(4):
                ipArray[i] = int(ipArray[i])
        return bytearray(ipArray) + bytearray(12)

    ##  @brief Get IPv6 address
    #
    #   Convert string into a byte array of IPv6 address
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      ipString    String containing IP address in v6 format
    #
    #   @retval     bytearray of IPv6 Address
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def getIPv6(self, ipString):
        ipStrArray = ipString.split(':')
        ipByteArray = []

        if len(ipStrArray) != 8:
            print("Error: Incorrect IPv6 address length " + str(len(ipStrArray)) + " for IP: " + ipString)
            sys.exit(1)
        else:
            for i in range(8):
                ipStrArray[i] = int(ipStrArray[i], 16)
                ipByteArray.append(ipStrArray[i] >> 8)
                ipByteArray.append(ipStrArray[i] & 0xff)
        return bytearray(ipByteArray)

    ##  @brief Write to output file
    #
    #   Writes configuration data in a binary output file
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ETHSWTM_FA_Configurator object
    #   @param[in]      fil         Output file handle
    #   @param[in]      cfg         XML file containing FA configuration
    #
    #   @return     void
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def write(self, fil, cfg):
        fil.write(struct.pack('I', self.ETHSWTM_FA_CONFIG_MAGIC))
        macCount = [0] * 2
        oneList = [255] * 6
        oneArray = bytearray(oneList)
        zeroList = [0] * 6
        zeroArray = bytearray(zeroList)
        macList = [bytearray(6)] * self.ETHSWTM_FA_MAC_MAX * 2
        externalList = [0] * self.ETHSWTM_FA_MAC_MAX * 2

        deviceCount = len(cfg.findall('deviceMacEntry'))

        # For each Device in the xml
        for deviceIndex in range(deviceCount):
            grp = cfg.deviceMacEntry[deviceIndex]
            macCount[deviceIndex] = len(grp.findall('entry'))

            # For each mac address entry in the device
            for macIndex in range(macCount[deviceIndex]):
                currIndex = deviceIndex * self.ETHSWTM_FA_MAC_MAX + macIndex
                if hasattr(grp.entry[macIndex], "domain"):
                    externalList[currIndex] = self.getDomain(grp.entry[macIndex].domain)

                # Retrieve user-provided MAC
                currMac = self.getMAC(grp.entry[macIndex].mac.text)

                # Is address unsupported
                if currMac == oneArray:
                    print("Error: Invalid Match DA at device " + str(deviceIndex) + " entry " + str(macIndex))
                    sys.exit(1)

                # If current MAC already exists in the list
                if currMac in macList:
                    # One zero mac allowed per device
                    if (currMac != zeroArray) or (currMac in macList[deviceIndex * self.ETHSWTM_FA_MAC_MAX : currIndex]):
                        print("Duplicate entry found Device"  + str(deviceIndex) + " entry" + str(macIndex))
                        sys.exit(1)


                macList[currIndex] = currMac

        count = len(cfg.findall('flow'))
        if count > self.ETHSRV_FA_STATIC_FLOWS_MAX:
            print("Error: Number of flows limited to " + str(FA_STATIC_FLOWS_MAX))
            sys.exit(1)

        fil.write(struct.pack('H', count))
        mode = "NORMAL"
        crc = "CRC16"
        seedValue = "0x0"
        timestampPeriodSec = 0
        validateMatchDA = 1

        if hasattr(cfg, "ctfCfg"):
            if hasattr(cfg.ctfCfg, "mode"):
                mode = cfg.ctfCfg.mode
            if hasattr(cfg.ctfCfg, "crc"):
                crc = cfg.ctfCfg.crc
            if hasattr(cfg.ctfCfg, "seedValue"):
                seedValue = cfg.ctfCfg.seedValue
            if hasattr(cfg.ctfCfg, "timestampPeriodSec"):
                timestampPeriodSec = cfg.ctfCfg.timestampPeriodSec
            if hasattr(cfg.ctfCfg, "validateMatchDA"):
                validateMatchDA = cfg.ctfCfg.validateMatchDA

        if mode == 'BYPASS' or 0 == (macCount[0] + macCount[1]):
            if 0 != count:
                print("Error: No flows accepted, mode " + mode + " macCount = "
                + str(macCount[0] + macCount[1]))
                sys.exit(1)

        # Add ctf configuration
        fil.write(struct.pack('B', self.getMode(mode)))
        fil.write(struct.pack('B', self.getCrc(crc)))
        fil.write(struct.pack('H', int(str(seedValue), 16)))
        fil.write(struct.pack('I', timestampPeriodSec))
        fil.write(struct.pack('I', validateMatchDA))

        #Add MAC Config
        fil.write(struct.pack('I', macCount[0]))
        for index in range(self.ETHSWTM_FA_MAC_MAX):
            fil.write(struct.pack('I', externalList[index]))
            fil.write(macList[index])

        fil.write(struct.pack('I', macCount[1]))
        for index in range(self.ETHSWTM_FA_MAC_MAX, 2 * self.ETHSWTM_FA_MAC_MAX):
            fil.write(struct.pack('I', externalList[index]))
            fil.write(macList[index])

        if count > 0:
            for each in cfg.flow:
                # Remap SA is optional in vlan switching case
                # Match DA is optional if validateMatchDA is false
                if hasattr(each.remap, "sa"):
                    remapSADevice = self.getDevice(each.remap.sa.device)
                    remapSAEntry = each.remap.sa.entry
                    remapSAFound = 1
                else:
                    remapSAFound = 0

                if hasattr(each.match, "da"):
                    matchDADevice = self.getDevice(each.match.da.device)
                    matchDAEntry = each.match.da.entry
                # validateMatchDA is true and match DA is not present
                elif validateMatchDA == 1:
                    print("Error: match DA needed when validateMatchDA is true")
                    sys.exit(1)
                # if both match DA and remap SA are not present
                elif remapSAFound == 0:
                    print("Error: One of MatchDA and RemapSA is needed");
                    sys.exit(1)
                else:
                    matchDADevice = remapSADevice
                    matchDAEntry = remapSAEntry

                if remapSAFound == 0:
                    remapSADevice = matchDADevice
                    remapSAEntry = matchDAEntry

                # Valid Device and Entry values of MatchDA and RemapSA
                if matchDADevice >= deviceCount or remapSADevice >= deviceCount or matchDADevice != remapSADevice or matchDAEntry >= macCount[matchDADevice] or remapSAEntry >= macCount[remapSADevice]:
                    print("Error: Invalid matchDA[Device" + str(matchDADevice) +
                        " Entry" + str(matchDAEntry) + "] remapSA[Device" +
                        str(remapSADevice) + " Entry" + str(remapSAEntry) + "]")
                    sys.exit(1)

                # Match parameters
                fil.write(macList[matchDADevice * self.ETHSWTM_FA_MAC_MAX + matchDAEntry])

                if hasattr(each.match, "isTcp"):
                    isTcp = each.match.isTcp
                else:
                    isTcp = 1
                if hasattr(each.match, "isIpV4"):
                    isIpV4 = each.match.isIpV4
                else:
                    isIpV4 = 1
                if hasattr(each.match, "isL2LlcSnap"):
                    isL2LlcSnap = each.match.isL2LlcSnap
                else:
                    isL2LlcSnap = 0
                if hasattr(each.match, "isInBound"):
                    isInBound = each.match.isInBound
                else:
                    isInBound = 0

                if (validateMatchDA == 1):
                    if (isInBound != externalList[(self.ETHSWTM_FA_MAC_MAX * matchDADevice) + matchDAEntry]):
                        print("Error: Flow parameter isInBound doesn't match with the domain parameter \"external\" in MAC list")

                fil.write(struct.pack('H', each.match.srcPort))
                fil.write(struct.pack('H', each.match.dstPort))
                if isIpV4 == 1:
                    fil.write(self.getIPv4(each.match.srcIP.text))
                    fil.write(self.getIPv4(each.match.dstIP.text))
                else:
                    fil.write(self.getIPv6(each.match.srcIP.text))
                    fil.write(self.getIPv6(each.match.dstIP.text))

                #Flags
                value = isTcp
                value = value | (isIpV4 << 1)
                value = value | (isL2LlcSnap << 2)
                value = value | (isInBound << 3)
                fil.write(struct.pack('B', value))

                # REMAP Parameters
                fil.write(struct.pack('B', self.getL2Operation(each.remap.operation)))

                fil.write(macList[remapSADevice * self.ETHSWTM_FA_MAC_MAX + remapSAEntry])

                mac = self.getMAC(each.remap.da.text)
                if mac == zeroArray:
                    print("Error: Invalid Remap DA\n")
                    sys.exit(1)
                fil.write(mac)

                # vlan forced to 0 if operation is NO_OP or NO_TAG
                if each.remap.operation == 'NO_OP' or each.remap.operation == 'NO_TAG':
                    value = 0
                else:
                    #throw error if each.remap.vlan is not present
                    #vlan- pcp, dei, vid clubbed into 16bit field
                    value = each.remap.vlan.vid
                    value = value | (each.remap.vlan.dei << 12)
                    value = value | (each.remap.vlan.pcp << 13)
                fil.write(struct.pack('H', value))

                if hasattr(each.remap, "port"):
                    fil.write(struct.pack('H', each.remap.port))
                else:
                    fil.write(struct.pack('H', 0))

                if hasattr(each.remap, "ip"):
                    if isIpV4 == 1:
                        fil.write(self.getIPv4(each.remap.ip.text))
                    else:
                        fil.write(self.getIPv6(each.remap.ip.text))
                else:
                    fil.write(self.getIPv6("0:0:0:0:0:0:0:0"))

                fil.write(struct.pack('B', each.remap.bhTc))
                fil.write(struct.pack('B', self.getTE(each.remap.bhTe)))
                if hasattr(each.remap, "bhDstPort"):
                    bhDstPort = each.remap.bhDstPort
                else:
                    bhDstPort = "0x0"
                fil.write(struct.pack('I', int(str(bhDstPort), 16)))

                # Both remapSA and matchDA would be from same Device by now
                fil.write(struct.pack('I', matchDADevice))
        fil.write(bytearray(self.ETHSWTM_FA_FLOW_SIZE * (self.ETHSRV_FA_STATIC_FLOWS_MAX - count)))

    ##  @brief Generate Flow Accelerator configuration binary
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]  self        #ETHSWTM_FA_Configurator object
    #   @param[in]  binfile     Filename of the output binary
    #
    #   @return   void
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
    #
    #   @limitations None
    def generateBin(self, binfile):
        binData = bytearray()

        fout = open(binfile, 'wb')
        self.write(fout, self.cfg)
        fout.close()

##  @brief Print usage for FA Configurator
#
#   @behavior Sync, Non-reentrant
#
#   @param          void
#
#   @return void
#
#   @post Application exits
#
#   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
#
#   @limitations None
def ETHSWTM_FA_ConfigUsage():
    print("""
usage: ethswtm_fa_config.py
    [-h, --help]    Display this help message
    -i, --xml       Input XML file
    -o, --out       Output binary file
    -s, --schema    Schema file
    -c, --chip      Chip Family""")
    sys.exit(2)

##  @brief main function for FA Configurator
#
#   @behavior Sync, Re-entrant
#
#   @pre None
#
#   @param[in]      void
#
#   @return void
#
#   @post None
#
#   @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
#
#   @limitations None
def ETHSWTM_FA_ConfigMain():
    xml_file = None
    bin_file = None
    schema_file = None
    chipFamily = None
    try:
        optlist, args = getopt.getopt(sys.argv[1:], 'hdi:o:s:c:',
                    ['help', 'xml=', 'out=', 'schema=', 'chip='])
    except:
        print('Error: Invalid Arguments')
        ETHSWTM_FA_ConfigUsage()
    for opt, arg in optlist:
        if opt in ('-h', '--help'):
            ETHSWTM_FA_ConfigUsage()
        elif opt in ('-i', '--xml'):
            if os.path.isfile(arg) == True:
                xml_file = arg
            else:
                print('File {0} does not exist'.format(arg))
                ETHSWTM_FA_ConfigUsage()
        elif opt in ('-o', '--out'):
            bin_file = arg
        elif opt in ('-s', '--schema'):
            if os.path.isfile(arg) == True:
                schema_file = arg
            else:
                print('File {0} does not exist'.format(arg))
                ETHSWTM_FA_ConfigUsage()
        elif opt in ('-c', '--chip'):
            chipFamily = arg
        else:
            print('Unknown Argument {0}'.format(opt))
            ETHSWTM_FA_ConfigUsage()
    if ((xml_file == None) or (bin_file == None) or (schema_file == None)):
        print('Missing arguments')
        ETHSWTM_FA_ConfigUsage()

    configurator = ETHSWTM_FA_Configurator(xml_file, schema_file)
    configurator.generateBin(bin_file)
    print(bin_file + ' is generated.')

if __name__ == '__main__':
    ETHSWTM_FA_ConfigMain()
## @}
