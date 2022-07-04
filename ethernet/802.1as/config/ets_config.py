#!/usr/bin/python3

#
# $Id$
# Copyright: Copyright 2021 Broadcom Limited.
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

##  @defgroup grp_ets_configurator Configurator
#   @ingroup grp_ets
#
#   @addtogroup grp_ets_configurator
#   @{
#   @section sec_ets_config_overview Overview
#
#   This file generates the binary configuration image
#   for the ETS library. It has the XML schema for the
#   configuration elements.
#
#   @limitations None
#
#   @file ets_config.py
#   @brief ETS Configurator
#   This script file contains the configurator implementation
#   for ETS library.
#   @version 1.0

import sys
import os.path
import getopt
import lxml
import struct

from lxml import etree
from lxml import objectify

##  @name ETS configurator Architecture IDs
#   @{
#   @brief Architecture IDs for ETS configurator
#
    ## @brief #ets_config.ETS_CFG_SIZE_SYSTEMIDENTITY()
BRCM_SWARCH_ETS_CFG_SIZE_GLOBAL             = 0

    ## @brief #ets_config.ETS_CfgMaxInterfaces()
BRCM_SWARCH_ETS_CFG_MAX_INTERFACES_GLOBAL   = 1

    ## @brief #ets_config.ETS_CfgGenerator
BRCM_SWARCH_ETS_CFGGENERATOR_CLASS          = 2

    ## @brief #ets_config.ETS_CfgValidator
BRCM_SWARCH_ETS_CFGVALIDATOR_CLASS          = 3

    ## @brief #ets_config.ETS_CfgUsage()
BRCM_SWARCH_ETS_CFGUSAGE_PROC               = 4

    ## @brief #ets_config.ETS_CfgMain()
BRCM_SWARCH_ETS_CFGMAIN_PROC                = 5
##  @}

##  @brief Miscellaneous definitions
#
#   Miscellaneous definitions
#
#   @trace #BRCM_SWREQ_ETS_CONFIG
ETS_CFG_SIZE_SYSTEMIDENTITY            = 6
ETS_CFG_SIZE_INTFCFG                   = 30
ETS_CFG_SIZE_DOMAININTFCFG             = 24
ETS_CFG_DEFAULT_INITLOGPDELAYINTVL     = 0
ETS_CFG_DEFAULT_AVNUOPERLOGPDELAYINTVL = 0
ETS_CFG_DEFAULT_AVNUNBRPROPDELAY       = 0
ETS_CFG_DEFAULT_AVNURATERATIO          = 1.0
ETS_CFG_DEFAULT_ALLOWEDLOSTRESP        = 3
ETS_CFG_DEFAULT_INITLOGSYNCINTVL       = -3
ETS_CFG_DEFAULT_AVNUOPERLOGSYNCINTVL   = -3
ETS_CFG_DEFAULT_SYNCRECEIPTTIMEOUT     = 3
ETS_CFG_DEFAULT_INITLOGANNINTVL        = 0
ETS_CFG_DEFAULT_ANNRECEIPTTIMEOUT      = 3
ETS_CFG_DEFAULT_PRIORITY1              = 248
ETS_CFG_DEFAULT_CLOCKCLASS             = 248
ETS_CFG_DEFAULT_CLOCKACCURACY          = 254
ETS_CFG_DEFAULT_OFFSETSCALEDLOGVARIANCE= 17258
ETS_CFG_DEFAULT_PRIORITY2              = 248
ETS_CFG_DEFAULT_AVNUSYNCABSENCETIMEOUT = 10
ETS_CFG_DEFAULT_DELAYTHRESHOLD         = 0


##  @brief Maximum number of interfaces for a chip family
#
#   Maximum number of interfaces for a chip family
#
#   @trace #BRCM_SWREQ_ETS_CONFIG
ETS_CfgMaxInterfaces = {
    "bcm8908x": 1,
    "bcm8910x": 1,
    "bcm8953x": 8,
    "bcm8956x": 14,
    "bcm8957x": 14,
}

##  @brief ETS Configurator Class
#
#   ETS configurator class for processing the schema
#   elements
#
#   @trace #BRCM_SWREQ_ETS_CONFIG
class ETS_CfgGenerator:
    ##  @brief Brief description of __init__
    #
    #   Configurator initialization function
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgValidator object
    #   @param[in]      maxInterfaces  Maximum number of supported interfaces
    #
    #   @return         An instance of this class
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None

    def __init__(self, maxInterfaces):
        self.maxInterfaces = maxInterfaces

    ##  @brief Convert time source to binary format
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgGenerator object
    #   @param[in]      timeSource     Time Source string
    #
    #   @return         Time source in binary format
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __getBinaryTimeSource(self, cfg):
        val = 0xA0
        if (hasattr(cfg, 'timeSource')):
            if (cfg.timeSource == 'atomic'):
                val = 0x10
            elif (cfg.timeSource == "gps"):
                val = 0x20
            elif (cfg.timeSource == "radio"):
                val = 0x30
            elif (cfg.timeSource == "ptp"):
                val = 0x40
            elif (cfg.timeSource == "ntp"):
                val = 0x50
            elif (cfg.timeSource == "handset"):
                val = 0x60
            elif (cfg.timeSource == "other"):
                val = 0x90

        return struct.pack("B", val)

    ##  @brief Convert operational mode to binary format
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgGenerator object
    #   @param[in]      operMode       Operational mode string
    #
    #   @return         Operational mode in binary format
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __getBinaryOperMode(self, operMode):
        if operMode == 'avnu':
            val = 1
        elif operMode == "ieee-2011":
            val = 2
        elif operMode == "ieee-2020":
            val = 3

        return struct.pack("B", val)

    ##  @brief Convert ETS interface configuration to binary format
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgGenerator object
    #   @param[in]      intf           Interface object
    #
    #   @return         ETS interface configuration in binary format
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __getIntfCfgBin(self, intf):

        data = bytearray()

        data += bytearray(struct.pack("B",  intf.hwPortNum))

        val = ETS_CFG_DEFAULT_INITLOGPDELAYINTVL
        if (hasattr(intf, 'initLogPdelayInterval')):
            val = intf.initLogPdelayInterval
        data += bytearray(struct.pack("<i", val))

        val = ETS_CFG_DEFAULT_AVNUOPERLOGPDELAYINTVL
        if (hasattr(intf, 'avnuOperLogPdelayInterval')):
            val = intf.avnuOperLogPdelayInterval
        data += bytearray(struct.pack("<I", val))

        val = ETS_CFG_DEFAULT_AVNUNBRPROPDELAY
        if (hasattr(intf, 'avnuNbrPropDelay')):
            val = intf.avnuNbrPropDelay
        data += bytearray(struct.pack("<I", val))

        fltVal = ETS_CFG_DEFAULT_AVNURATERATIO
        if (hasattr(intf, 'avnuNbrRateRatio')):
            fltVal = intf.avnuNbrRateRatio
        data += bytearray(struct.pack("<I", int(fltVal * 1073741824)))

        val = ETS_CFG_DEFAULT_ALLOWEDLOSTRESP
        if (hasattr(intf, 'allowedLostResp')):
            val = intf.allowedLostResp
        data += bytearray(struct.pack("<H", val))

        # allowedFaults is not implemented yet
        data += bytearray(1)

        val = ETS_CFG_DEFAULT_DELAYTHRESHOLD
        if (hasattr(intf, 'delayThreshold')):
            val = intf.delayThreshold
        data += bytearray(struct.pack("<I", val))

        # delayAsymmetry is not implemented yet
        data += bytearray(2)

        # ingressLatency is not implemented yet
        data += bytearray(2)

        # egressLatency is not implemented yet
        data += bytearray(2)

        return data

    ##  @brief Convert ETS domain-interface configuration to binary format
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgGenerator object
    #   @param[in]      intf           domain-interface object
    #
    #   @return         ETS domain-interface configuration in binary format
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __getDomainIntfCfgBin(self, intf):

        data = bytearray()

        data += bytearray(struct.pack("<I", int(intf.portEnable)))

        val = 0
        if (hasattr(intf, 'avnuPortRole')):
            if intf.avnuPortRole == 'slave':
                val = 1
        data += bytearray(struct.pack("B",  val))

        val = ETS_CFG_DEFAULT_INITLOGSYNCINTVL
        if (hasattr(intf, 'initLogSyncInterval')):
            val = intf.initLogSyncInterval
        data += bytearray(struct.pack("<i", val))

        val = ETS_CFG_DEFAULT_AVNUOPERLOGSYNCINTVL
        if (hasattr(intf, 'avnuOperLogSyncInterval')):
            val = intf.avnuOperLogSyncInterval
        data += bytearray(struct.pack("<i", val))

        val = ETS_CFG_DEFAULT_SYNCRECEIPTTIMEOUT
        if (hasattr(intf, 'syncReceiptTimeout')):
            val = intf.syncReceiptTimeout
        data += bytearray(struct.pack("B", val))

        val = ETS_CFG_DEFAULT_INITLOGANNINTVL
        if (hasattr(intf, 'initLogAnnInterval')):
            val = intf.initLogAnnInterval
        data += bytearray(struct.pack("<i", val))

        val = ETS_CFG_DEFAULT_ANNRECEIPTTIMEOUT
        if (hasattr(intf, 'announceReceiptTimeout')):
            val = intf.announceReceiptTimeout
        data += bytearray(struct.pack("B",  val))

        # initLogGptpCapInterval is not implemented yet
        data += bytearray(4)
        # gptpCapReceiptTimeout is not implemented yet
        data += bytearray(1)

        return data

    ##  @brief Convert ETS domain configuration to binary format
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgGenerator object
    #   @param[in]      domain         Domain object
    #
    #   @return         ETS domain configuration in binary format
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __getDomainCfgBin(self, domain):

        data = bytearray()

        data += bytearray(struct.pack("B",  domain.domainNumber))

        # domainEnable is not implemented yet
        data += bytearray(struct.pack("<I",  int(True)))

        priority1 = ETS_CFG_DEFAULT_PRIORITY1
        clockClass = ETS_CFG_DEFAULT_CLOCKCLASS
        clockAccuracy = ETS_CFG_DEFAULT_CLOCKACCURACY
        offsetScaledLogVariance = ETS_CFG_DEFAULT_OFFSETSCALEDLOGVARIANCE
        priority2 = ETS_CFG_DEFAULT_PRIORITY2

        if (hasattr(domain, "systemIdentity")):
            if (hasattr(domain.systemIdentity, "priority1")):
                priority1 = domain.systemIdentity.priority1

            if (hasattr(domain.systemIdentity, "clockClass")):
                clockClass = domain.systemIdentity.clockClass

            if (hasattr(domain.systemIdentity, "clockAccuracy")):
                clockAccuracy = domain.systemIdentity.clockAccuracy

            if (hasattr(domain.systemIdentity, "offsetScaledLogVariance")):
                offsetScaledLogVariance = domain.systemIdentity.offsetScaledLogVariance

            if (hasattr(domain.systemIdentity, "priority2")):
                priority2 = domain.systemIdentity.priority2

        if ((priority1 == 255) and (clockClass != 255)):
            ETS_CfgAbort("For non GM capable device, clockClass should be 255")

        data += bytearray(struct.pack("B",  priority1))
        data += bytearray(struct.pack("B",  clockClass))
        data += bytearray(struct.pack("B",  clockAccuracy))
        data += bytearray(struct.pack("<H", offsetScaledLogVariance))
        data += bytearray(struct.pack("B",  priority2))

        # timeScale is not implemented yet
        data += bytearray(1)

        # initState is not implemented yet
        data += bytearray(1)

        val = 0
        if (hasattr(domain, "avnuClockMode")):
            if domain.avnuClockMode == 'slave':
                val = 1
        data += bytearray(struct.pack("B", val))

        val = ETS_CFG_DEFAULT_AVNUSYNCABSENCETIMEOUT
        if (hasattr(domain, "avnuSyncAbsenceTimeout")):
            val = domain.avnuSyncAbsenceTimeout
        data += bytearray(struct.pack("B", val))

        fltVal = ETS_CFG_DEFAULT_AVNURATERATIO
        if (hasattr(domain, "avnuGmRateRatio")):
            fltVal = domain.avnuGmRateRatio
        data += bytearray(struct.pack("<I", int(fltVal * 1073741824)))

        for each in domain.domainIntfCfg.intf:
            data += self.__getDomainIntfCfgBin(each)
        data += bytearray(ETS_CFG_SIZE_DOMAININTFCFG * (self.maxInterfaces - len(domain.domainIntfCfg.intf)))
        return data

    ##  @brief Generate ETS configuration binary data
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ets_config.ETS_CfgGenerator object
    #   @param[in]      cfg         ETS configuration object
    #
    #   @return         ETS configuration in binary format
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __getBinaryCfg(self, cfg):
        data = bytearray()

        data += bytearray(struct.pack('<I', 0x50545047))
        data += self.__getBinaryOperMode(cfg.operMode)
        data += bytearray(struct.pack("<I", cfg.globalEnable))
        data += self.__getBinaryTimeSource(cfg)

        val = True
        if hasattr(cfg, 'syncLocked'):
            val = cfg.syncLocked
        data += bytearray(struct.pack("<I", val))

        val = False
        if hasattr(cfg, 'boundaryModeEnable'):
            val = cfg.boundaryModeEnable
        data += bytearray(struct.pack("<I", cfg.boundaryModeEnable))

        data += bytearray(struct.pack("<I", len(cfg.intfCfg.intf)))
        for each in cfg.intfCfg.intf:
            data += self.__getIntfCfgBin(each)
        data += bytearray(ETS_CFG_SIZE_INTFCFG * (self.maxInterfaces - len(cfg.intfCfg.intf)))

        data += bytearray(struct.pack("<I", len(cfg.domainCfg.domain)))
        for each in cfg.domainCfg.domain:
            data += self.__getDomainCfgBin(each)

        return data

    ##  @brief Write ETS configuration to binary file
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self        #ets_config.ETS_CfgGenerator object
    #   @param[in]      cfg         Configuration Tree object
    #   @param[in]      binfile     Binary output file path
    #
    #   @return         void
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def write(self, cfg, binFile):
        binData = bytearray()
        binData = self.__getBinaryCfg(cfg)

        fout = open(binFile, 'wb')
        fout.write(binData)
        fout.close()

##  @brief ETS Config Validator Class
#
#   ETS config validator class for processing the schema
#   elements
#
#   @trace #BRCM_SWREQ_ETS_CONFIG
class ETS_CfgValidator:
    ##  @brief Brief description of __init__
    #
    #   Configurator initialization function
    #
    #   @behavior Sync, Non-reentrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgValidator object
    #   @param[in]      schemaFile     XSD file containing schema
    #
    #   @return         An instance of this class
    #
    #   @post None
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None

    def __init__(self, schemaFile, xmlFile):
        self.cfgTree = None
        schema = etree.XMLSchema(etree.parse(schemaFile))
        parser = objectify.makeparser(schema = schema, attribute_defaults = True)

        fp = open(xmlFile, 'r')
        xmlData = fp.read()
        fp.close

        self.cfgTree = objectify.fromstring(xmlData, parser)

    ##  @brief Validate the parameters for Avnu mode of operation
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgValidator object
    #
    #   @return         void
    #
    #   @post Application exits if validation fails
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __checkAvnuParams(self):
        # Validation: gm cannot be boundary clock
        if (self.cfgTree.domainCfg[0].domain.avnuClockMode == 'gm') and (self.cfgTree.boundaryModeEnable == True):
            ETS_CfgAbort('Boundary mode not applicable to GM mode')

        # Validation: There should be exactly one slave port in slave device and zero in gm device
        numSlavePorts = 0
        for each in self.cfgTree.domainCfg[0].domain.domainIntfCfg.intf:
            if each.avnuPortRole == 'slave':
                numSlavePorts += 1

        if (self.cfgTree.domainCfg[0].domain.avnuClockMode == 'gm') and (0 != numSlavePorts):
            ETS_CfgAbort("GM device should not contain any slave ports")

        if (self.cfgTree.domainCfg[0].domain.avnuClockMode == 'slave') and (1 != numSlavePorts):
            ETS_CfgAbort("Slave device should contain a single slave port")

        # Validation: Init Sync interval to be in the range [-5, -3]
        for intf in self.cfgTree.domainCfg[0].domain.domainIntfCfg.intf:
            if (hasattr(intf, 'initLogSyncInterval')):
                if (intf.initLogSyncInterval > -3):
                    ETS_CfgAbort("Initial Sync interval has to be in the range [-5, -3]")

        # Validation: Init PDelay interval to be one of {0, 127}
        for intf in self.cfgTree.intfCfg.intf:
            if (hasattr(intf, 'initLogPdelayInterval')):
                if ((intf.initLogPdelayInterval != 0) and (intf.initLogPdelayInterval != 127)):
                    ETS_CfgAbort("Initial PDelay interval has to one of {0, 127}")

        # Validation: Do not allow Pdelay to be disabled on slave ports
        if self.cfgTree.domainCfg[0].domain.avnuClockMode == 'slave':
            for index, each in enumerate(self.cfgTree.domainCfg[0].domain.domainIntfCfg.intf):
                if ((each.avnuPortRole == 'slave') and
                    ((self.cfgTree.intfCfg.intf[index].initLogPdelayInterval == 127) or
                     (self.cfgTree.intfCfg.intf[index].avnuOperLogPdelayInterval == 127))):
                     ETS_CfgAbort("PDelay cannot be disabled on slave port")


    ##  @brief Validate the parameters for IEEE-2011 mode of operation
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgValidator object
    #
    #   @return         void
    #
    #   @post Application exits if validation fails
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __checkIEEE2011Params(self):
        # Validation: Not supported on endpoints
        if (self.numInterfaces == 1):
            ETS_CfgAbort("IEEE-2011 mode is not supported on endpoints")

        if hasattr(self.cfgTree, 'boundaryModeEnable'):
            if self.cfgTree.boundaryModeEnable == True:
                ETS_CfgAbort('Boundary clock not supported in IEEE-2011 mode')

        for intf in self.cfgTree.intfCfg.intf:
            # Validation: Check for unsupported Avnu parameters
            if ((hasattr(intf, 'avnuOperLogPdelayInterval')) or
                (hasattr(intf, 'avnuNbrPropDelay')) or
                (hasattr(intf, 'avnuNbrRateRatio'))):
                ETS_CfgAbort("Avnu parameters not supported")
            # Validation: Init PDelay interval should not be 127
            if (hasattr(intf, 'initLogPdelayInterval')):
                if (intf.initLogPdelayInterval == 127):
                    ETS_CfgAbort("Initial PDelay interval should not be 127")
            # Validation: delayThreshold is mandatory
            if not (hasattr(intf, 'delayThreshold')):
                ETS_CfgAbort("Delay Threshold is mandatory in IEEE 2011 mode. Not provided for port " + str(intf.hwPortNum))

        # Validation: Check for unsupported Avnu parameters
        if ((hasattr(self.cfgTree.domainCfg[0].domain, 'avnuClockMode')) or
            (hasattr(self.cfgTree.domainCfg[0].domain, 'avnuSyncAbsenceTimeout')) or
            (hasattr(self.cfgTree.domainCfg[0].domain, 'avnuGmRateRatio'))):
            ETS_CfgAbort("Avnu parameters not supported")

        for intf in self.cfgTree.domainCfg[0].domain.domainIntfCfg.intf:
            # Validation: Check for unsupported Avnu parameters
            if (hasattr(intf, 'avnuPortRole')):
                ETS_CfgAbort("Avnu parameters not supported")
            # Validation: Init Sync/Announce intervals should not be 127 (disabled)
            if (hasattr(intf, 'initLogSyncInterval')):
                if (intf.initLogSyncInterval == 127):
                    ETS_CfgAbort("Initial Sync interval should not be 127 (disabled)")
            if (hasattr(intf, 'initLogAnnInterval')):
                if (intf.initLogAnnInterval == 127):
                    ETS_CfgAbort("Initial Announce interval should not be 127 (disabled)")


    ##  @brief Validate the parameters for IEEE-2020 mode of operation
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgValidator object
    #
    #   @return         void
    #
    #   @post Application exits if validation fails
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def __checkIEEE2020Params(self):
        ETS_CFG_DEFAULT_ALLOWEDLOSTRESP = 9


    ##  @brief Validate the parameters
    #
    #   @behavior Sync, Re-entrant
    #
    #   @pre None
    #
    #   @param[in]      self           #ets_config.ETS_CfgValidator object
    #   @param[in]      maxInterfaces  Maximum number of supported interfaces
    #
    #   @return         configuration tree object parsed from the XML data
    #
    #   @post Application exits if validation fails
    #
    #   @trace #BRCM_SWREQ_ETS_CONFIG
    #
    #   @limitations None
    def check(self, maxInterfaces):
        self.numInterfaces = len(self.cfgTree.intfCfg.intf)
        self.numDomains    = len(self.cfgTree.domainCfg.domain)

        # Validation: Number of interfaces should not be more than supported
        if (self.numInterfaces > maxInterfaces):
            ETS_CfgAbort('Only upto ' + maxInterfaces + ' interfaces supported')

        # Validation: Only domain 0 supported
        if (self.numDomains != 1) or (self.cfgTree.domainCfg[0].domain.domainNumber != 0):
            ETS_CfgAbort('Only a single domain (with domain number 0) supported')

        # Validation: Each domain should have the interfaces defined as per the domain-independent configuration
        for domain in self.cfgTree.domainCfg.domain:
            if len(domain.domainIntfCfg.intf) != self.numInterfaces:
                ETS_CfgAbort("Domain " + str(domain.domainNumber) + " should have exactly " +
                             str(self.numInterfaces) + " interfaces defined")

        # Validation: Boundary clock mode not allowed for end points
        if hasattr(self.cfgTree, 'boundaryModeEnable'):
            if self.cfgTree.boundaryModeEnable == True:
                if (self.numInterfaces == 1):
                    ETS_CfgAbort('End point cannot be boundary clock')

        if self.cfgTree.operMode == "avnu":
            self.__checkAvnuParams()
        elif self.cfgTree.operMode == "ieee-2011":
            self.__checkIEEE2011Params()
        else:
            ETS_CfgAbort("Operational mode " + self.cfgTree.operMode + " is not supported")

        return self.cfgTree

##  @brief Print usage for ETS Configurator
#
#   @behavior Sync, Non-reentrant
#
#   @param          void
#
#   @return void
#
#   @post Application exits
#
#   @trace #BRCM_SWREQ_ETS_CONFIG
#
#   @limitations None
def ETS_CfgUsage():
    print("""\
    Usage: ets_config.py
    [-h, --help]    Display this help message
    -i, --xml       Input XML file
    -s, --schema    Input schema file
    -o, --out       Output binary file
    -c, --chip      Chip Family""")
    sys.exit(1)

##  @brief Print error and abort
#
#   @behavior Sync, Non-reentrant
#
#   @param          void
#
#   @return void
#
#   @post Application exits
#
#   @trace #BRCM_SWREQ_ETS_CONFIG
#
#   @limitations None
def ETS_CfgAbort(errorMsg):
    print(errorMsg)
    sys.exit(1)

##  @brief main function for ETS Configurator
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
#   @trace #BRCM_SWREQ_ETS_CONFIG
#
#   @limitations None
def ETS_CfgMain():
    XMLFile = None
    BinOutputFile = None
    SchemaFile = None
    chipFamily = None
    try:
        optlist, args = getopt.getopt(sys.argv[1:], 'hi:o:s:c:',
            ['help=', 'xml=', "out=", 'schema=', 'chip='])
    except:
        print('Invalid Arguments')
        ETS_CfgUsage()
    for opt, arg in optlist:
        if opt in ('-h', '--help'):
            ETS_CfgUsage()
        elif opt in ('-i', '--xml'):
            if os.path.isfile(arg) == True:
                XMLFile = arg
            else:
                print('File {0} does not exist'.format(arg))
                ETS_CfgUsage()
        elif opt in ('-o', '--out'):
            BinOutputFile = arg
        elif opt in ('-s', '--schema'):
            if os.path.isfile(arg) == True:
                SchemaFile = arg
            else:
                print('File {0} does not exist'.format(arg))
                ETS_CfgUsage()
        elif opt in ('-c', '--chip'):
            chipFamily = arg
            maxInterfaces = ETS_CfgMaxInterfaces.get(chipFamily)
            if (None == maxInterfaces):
                ETS_CfgAbort("Invalid chip family")
        else:
            print('Unknown Argument {0}'.format(opt))
            ETS_CfgUsage()
    if ((XMLFile == None) or (BinOutputFile == None) or (SchemaFile == None) or (chipFamily == None)):
        print('Missing arguments')
        ETS_CfgUsage()

    validator = ETS_CfgValidator(SchemaFile, XMLFile);
    cfg = validator.check(maxInterfaces)

    generator = ETS_CfgGenerator(maxInterfaces)
    generator.write(cfg, BinOutputFile)

    del validator
    del generator

if __name__ == '__main__':
    ETS_CfgMain()
## @}

