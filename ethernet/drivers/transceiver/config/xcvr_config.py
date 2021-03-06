#!/usr/bin/python3

#
# $Id$
# $Copyright: Copyright 2017-2021 Broadcom Limited.
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
# CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE ENTIRE RISK ARISING
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

##  @defgroup grp_xcvr_config Transceiver Configuration Generator
#   @ingroup grp_eth_xcvrdrv
#
#   @addtogroup grp_xcvr_config
#   @{
#
#
#   @file xcvr_config.py
#   @brief Transceiver Configurator
#   This script file contains the configurator implementation for Transceiver
#   @version 0.30 Initial version

import sys
import getopt
import os
import struct
import binascii
import lxml

from lxml import etree
from lxml import objectify

ETHXCVR_MAX_PORTS         = 16
ETHXCVR_PORT_CFG_SZ       = 52
ETHXCVR_MAX_DRIVER_PARAMS = 4
ETHXCVR_DRIVER_PARAMS_SZ  = 4

##  @brief Port Configurator
#
#   Port configurator class for generating Port configuration binary
#
#   @trace #BRCM_SWREQ_ETHXCVR_INIT
class ETHXCVR_PortConfig:
    ##  @brief Instantiation operation
    #
    #   Creates a new instanace of the class
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre TBD
    #
    #   @param[in]      self        #ETHXCVR_PortConfig object
    #   @param[in]      cfg         Objectify tree for #ETHXCVR_PortConfig
    #
    #   Return values are documented in reverse-chronological order
    #   @return     An instance of this class
    #
    #   @post TBD
    #
    #   @trace #BRCM_SWREQ_SYSCFG_PORT_CONFIG_TYPE
    #
    #   @limitations None
    def __init__(self, port):
        self.port = port

    def getBinarySpeed(self, speed):
        if speed == '10':
            val = 0x1
        elif speed == '100':
            val = 0x2
        elif speed == '1000':
            val = 0x4
        elif speed == "2500":
            val = 0x8
        elif speed == "5000":
            val = 0x10
        else:
            print('unknown speed' , speed, 'for port', self.port.id)
            sys.exit(1)
        return val

    ##  @brief Generate binary data
    #
    #   This function generates the binary data corressponding
    #   #ETHXCVR_PortConfig.
    #
    #   @behavior Sync/Async, Re-entrant/Non-reentrant
    #
    #   @pre TBD
    #
    #   @param[in]      self        #PortConfig object
    #
    #   @return     Port configuration in binary format
    #
    #   @post TBD
    #
    #   @trace #BRCM_SWREQ_SYSCFG_PORT_CONFIG_TYPE
    #
    #   @limitations None
    def generateBin(self):
        data = bytearray()
        validPort = 0

        # 1 byte port identifier
        data += struct.pack("<B", self.port.id)

        # 1 byte enable
        if hasattr(self.port, 'enable'):
            if self.port.enable == True:
                data.append(1)
            else:
                data.append(0)
        else:
            data.append(1)

        # 1 byte speed
        speedStr = str(self.port.speed).split(' ')
        val = 0
        for speed in speedStr:
            val |= self.getBinarySpeed(speed)
        data.append(val)

        # 1 byte autonegEnable
        if self.port.autoNegEnable == False:
            if len(speedStr) > 1:
                print('Multiple speeds allowed only in autoneg')
                sys.exit(1)
            else:
                data.append(0)
        else:
            data.append(1)

        # 1 byte duplex
        if hasattr(self.port, 'duplex') and self.port.duplex != 'half':
            print('Only full duplex supported')
            sys.exit(1)
        data.append(2)

        # 1 byte flow control
        if hasattr(self.port, 'flowControl') and self.port.flowControl != 'none':
            print('Only no flow control supported')
            sys.exit(1)
        data.append(0)

        # 1 byte jumbo
        if hasattr(self.port, 'jumbo'):
            data += struct.pack("<B", self.port.jumbo)
        else:
            data.append(0)

        # 1 byte busMode
        if hasattr(self.port, 'busMode'):
            if self.port.busMode == 'rgmii':
                data.append(2)
            elif self.port.busMode == 'rvmii':
                data.append(3)
            elif self.port.busMode == 'sgmii':
                data.append(4)
            elif self.port.busMode == 'rmii':
                data.append(5)
            elif self.port.busMode == 'mii':
                data.append(6)
            elif self.port.busMode == "pcie":
                data.append(7)
            else:
                print('unknown busMode')
                sys.exit(1)
        elif hasattr(self.port, 'phy') and str(self.port.phy.accessMode) == 'MMAP':
            data.append(1)
        else:
            print('unknown busMode')
            sys.exit(1)

        # Bus parameters
        if hasattr(self.port, 'bus'):
            validPort = 1
            # 1 byte controller id
            data += struct.pack("<B", self.port.bus.cntrlID)
            # 1 byte instance id
            if hasattr(self.port.bus, 'instID'):
                data += struct.pack("<B", self.port.bus.instID)
            else:
                data.append(0)

            # 2 bytes reserved field for alignment
            data += bytearray(2)

            numParams = 0
            # Bus driver specific parameters
            if hasattr(self.port.bus, 'driverParams'):
                for param in self.port.bus.driverParams.param:
                    # 2 bytes of key
                    data += struct.pack("<H", param.key)
                    # 2 bytes of value
                    data += struct.pack("<H", param.value)
                    numParams += 1
            data += bytearray(ETHXCVR_DRIVER_PARAMS_SZ*(ETHXCVR_MAX_DRIVER_PARAMS-numParams))

        else:
            data += bytearray(20)

        # Phy parameters
        if hasattr(self.port, 'phy'):
            validPort = 1
            # 1 byte controller id
            data += struct.pack("<B", self.port.phy.hwID)
            # 1 byte instance id
            if hasattr(self.port.phy, 'slaveID'):
                data += struct.pack("<B", self.port.phy.slaveID)
            else:
                data.append(0)

            # 1 byte access mode
            if self.port.phy.accessMode == 'MMAP':
                data.append(1)
            elif self.port.phy.accessMode == 'MDIO':
                data.append(2)
                if not hasattr(self.port.phy, 'slaveID'):
                    print('phy slaveID mandatory in MDIO mode')
                    sys.exit(1)
            else:
                print('unknown accessMode ' + str(self.port.phy.accessMode))
                sys.exit(1)

            # 1 byte phyMedia type
            if self.port.phy.phyMedia == '10Base-T1':
                data.append(1)
            elif self.port.phy.phyMedia == '10Base-T':
                data.append(2)
            elif self.port.phy.phyMedia == '100Base-T1':
                data.append(3)
            elif self.port.phy.phyMedia == '100Base-Tx':
                data.append(4)
            elif self.port.phy.phyMedia == '1000Base-T1':
                data.append(5)
            elif self.port.phy.phyMedia == '1000Base-T':
                data.append(6)
            elif self.port.phy.media == '1000Base-X':
                data.append(7)
            else:
                print('unknown phyMedia ' + str(self.port.phy.phyMedia))
                sys.exit(1)

            # 1 byte master/slave mode
            if hasattr(self.port.phy, 'master'):
                if self.port.phy.master == True:
                    data.append(1)
                else:
                    data.append(0)
            else:
                data.append(1)

            # 3 bytes reserved field for alignment
            data += bytearray(3)

            # Phy driver specific parameters
            if hasattr(self.port.phy, 'driverParams'):
                numParams = 0
                for param in self.port.phy.driverParams.param:
                    # 2 bytes of key
                    data += struct.pack("<H", param.key)
                    # 2 bytes of value
                    data += struct.pack("<H", param.value)
                    numParams += 1
                if numParams < ETHXCVR_MAX_DRIVER_PARAMS:
                    data += bytearray(ETHXCVR_DRIVER_PARAMS_SZ * (ETHXCVR_MAX_DRIVER_PARAMS-numParams))
            else:
                data += bytearray(ETHXCVR_DRIVER_PARAMS_SZ * ETHXCVR_MAX_DRIVER_PARAMS)
        else:
            data += bytearray(24)

        if validPort == 0:
            print('port needs to have one of {bus, phy}')
            sys.exit(1)
        return data

##  @brief Transceiver Configurator
#
#   Transceiver configurator class for generating Transceiver configuration
#   binary.
#
#   @trace #BRCM_SWREQ_SYSCFG_XCVR_CONFIG_TYPE
class ETHXCVR_Configurator:
    ##  @brief Instantiation operation
    #
    #   Creates a new instanace of the class
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre TBD
    #
    #   @param[in]      self        #ETHXCVR_Configurator object
    #   @param[in]      xmlFile     XML file containing transceiver
    #                               configuration
    #   @param[in]      schemaFile  Schema file for XCVR configuration
    #   @return     An instance of this class
    #
    #   @post TBD
    #
    #   @trace #BRCM_SWREQ_SYSCFG_XCVR_CONFIG_TYPE
    #
    #   @limitations None
    def __init__(self, xmlFile, schemaFile):
        ## @brief Magic number (#XCVR_CONFIG_MAGIC)
        self.magic = 0x52564358
        ## @brief Transceiver configuration version
        self.version = 0x00000101
        ## @brief Transceiver configuration XML file
        self.xmlFile = xmlFile
        schema = etree.XMLSchema(etree.parse(schemaFile))
        ## @brief Validating parser for the schema
        self.parser = objectify.makeparser(schema = schema)
        fp = open(self.xmlFile, 'r')
        xml = fp.read()
        fp.close()
        ## @brief Objectify tree for the transceiver configuration
        self.xcvrCfg = objectify.fromstring(xml, self.parser)
        ## @brief Configuration name
        self.name = str(self.xcvrCfg.name)
        ## @brief File name
        self.file = os.path.basename(self.xmlFile)
        ## @brief Port configuration
        self.port = []
        for port in self.xcvrCfg.port:
            self.port.append(ETHXCVR_PortConfig(port))
    ##  @brief Generate binary data
    #
    #   This function generates the binary data corressponding to XML file
    #   ETHXCVR_Configurator::xmlFile
    #
    #   @behavior Sync/Async, Re-entrant/Non-reentrant
    #
    #   @pre TBD
    #
    #   @param[in]      self        #ETHXCVR_Configurator object
    #
    #   @return     Transceiver configuration in binary format
    #
    #   @post TBD
    #
    #   @trace #BRCM_SWREQ_SYSCFG_XCVR_CONFIG_TYPE
    #
    #   @limitations None
    #
    def generateBin(self):
        data = bytearray()
        data += struct.pack('I', self.magic)
        data += struct.pack('I', self.version)
        data += struct.pack('I', len(self.port))
        for each in self.port:
            data += each.generateBin()
        data += bytearray(ETHXCVR_PORT_CFG_SZ*(ETHXCVR_MAX_PORTS - len(self.port)))
        name = self.name.encode()
        if len(name) > 15:
            name = name[0:14].encode()
            name += bytearray(1)
        else:
            name += bytearray(16-len(name))
        data += name
        name = str(os.path.basename(self.xmlFile)).encode()
        if len(name) > 128:
            name = name[0:126].encode()
            name += bytearray(1)
        else:
            name += bytearray(128-len(name))
        data += name
        return data

##  @brief Print usage for Transceiver Configurator
#
#   @behavior Sync, Non-reentrant
#
#   @param          void
#
#   @return void
#
#   @post Application exits
#
#   @trace #BRCM_SWREQ_SYSCFG_XCVR_CONFIG_TYPE
#
#   @limitations None
def usage():
    print("./xcvr_config.py  -i <input XML file> -s <input Schema file> -o <output binary file> -c <chip family>")
    sys.exit(1)

##  @brief main function for Transceiver Configurator
#
#   @behavior Sync, Re-entrant
#
#   @pre TBD
#
#   @param[in]      void
#
#   @return void
#
#   @post TBD
#
#   @trace #BRCM_SWREQ_SYSCFG_XCVR_CONFIG_TYPE
#
#   @limitations None
def main():
    input_file = None
    output_file = None
    SchemaFile = None
    chipFamily = None
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hi:o:s:c:",
                                    ["help=", "input=", "output=", 'schema=', 'chip='])
    except:
        print("Error in parsing arguments")
        usage()
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
        elif opt in ("-i", "--input"):
            input_file = arg
        elif opt in ("-o", "--output"):
            output_file = arg
        elif opt in ("-s", "--schema"):
            SchemaFile = arg
        elif opt in ('-c', '--chip'):
            chipFamily = arg
        else:
            print("Unknown argument %s" % opt)
            usage()
    if ((input_file == None) or (output_file == None) or (SchemaFile == None)):
        print ('Missing arguments')
        usage()

    configurator = ETHXCVR_Configurator(input_file, SchemaFile)
    fp = open(output_file, 'wb')
    fp.write(configurator.generateBin())
    del configurator
    fp.close()

if __name__ == '__main__':
    main()
## @}
