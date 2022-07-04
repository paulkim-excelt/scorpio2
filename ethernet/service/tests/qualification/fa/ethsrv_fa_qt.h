/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethsrv_fa_qt Qualification Test
    @ingroup grp_ethsrv_sw

    @addtogroup grp_ethsrv_fa_qt
    @{

    @file ethsrv_fa_qt.h
    @brief ETHSRV Flow Accelerator Qualification Test
     This file contains test cases and test sequence for ETHSRV FA

    @version 0.1 Initial version
*/

#ifndef ETHSRV_FA_QT_H
#define ETHSRV_FA_QT_H

/**
    @brief Get the configured MAC addresses

    @pre
     - FA configuration is available as a binary with pid="0x5" imgid="0xBC50"
        <ETHSRV_FA_Cfg>
            <ctfCfg>
                <mode>NORMAL</mode>
                <crc>CCITT</crc>
                <seedValue>0x0</seedValue>
                <timestampPeriodSec>2</timestampPeriodSec>
                <validateMatchDA>true</validateMatchDA>
            </ctfCfg>
            <macGroup>
                <entry>
                    <mac>00:11:22:33:44:03</mac>
                    <domain>INTERNAL</domain>
                </entry>
                <entry>
                    <mac>10:11:22:33:44:03</mac>
                    <domain>INTERNAL</domain>
                </entry>
                </entry>
            </macGroup>
            <flow>
                <match>
                    <da>
                        <group>0</group>
                        <entry>0</entry>
                    </da>
                    <srcPort>40000</srcPort>
                    <dstPort>50000</dstPort>
                    <srcIP>10.20.30.40</srcIP>
                    <dstIP>10.20.30.41</dstIP>
                    <isTcp>false</isTcp>
                    <isIpV4>true</isIpV4>
                    <isL2LlcSnap>false</isL2LlcSnap>
                    <isInBound>false</isInBound>
                </match>
                <remap>
                    <operation>S_TAG</operation>
                    <da>AA:BB:CC:DD:EE:0B</da>
                    <vlan>
                        <pcp>3</pcp>
                        <dei>false</dei>
                        <vid>11</vid>
                    </vlan>
                    <port>00</port>
                    <ip>00.00.00.00</ip>
                    <bhTc>0</bhTc>
                    <bhTe>NONE</bhTe>
                    <bhDstPort>0x00000000</bhDstPort>
                </remap>
            </flow>
            <flow>
                <match>
                    <da>
                        <group>0</group>
                        <entry>1</entry>
                    </da>
                    <srcPort>40000</srcPort>
                    <dstPort>50000</dstPort>
                    <srcIP>FD0A:0000:0000:0000:0000:0000:0000:000A</srcIP>
                    <dstIP>FD0B:0000:0000:0000:0000:0000:0000:000B</dstIP>
                    <isTcp>false</isTcp>
                    <isIpV4>false</isIpV4>
                    <isL2LlcSnap>false</isL2LlcSnap>
                    <isInBound>false</isInBound>
                </match>
                <remap>
                    <operation>NO_TAG</operation>
                    <sa>
                        <group>0</group>
                        <entry>1</entry>
                    </sa>
                    <da>AA:BB:CC:DD:EE:0B</da>
                    <port>00</port>
                    <ip>0000:0000:0000:0000:0000:0000:0000:0000</ip>
                    <bhTc>0</bhTc>
                    <bhTe>NONE</bhTe>
                    <bhDstPort>0x00000000</bhDstPort>
                </remap>
            </flow>
        </ETHSRV_FA_Cfg>
     - ETHSRV_FAInit has been called with aforementioned configuration

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_MAC_SNAPSHOT
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET                         (0x101UL)

/**
    @brief Add an existing MAC address

    @pre #BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_MAC_ADD
        <mac>00:11:22:33:44:03</mac>
        <domain>INTERNAL</domain>
        <group>0</group>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_MAC_ADD_EXISTING                    (0x102UL)

/**
    @brief Add a new MAC address

    @pre #BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_MAC_ADD
        <mac>20:11:22:33:44:03</mac>
        <domain>INTERNAL</domain>
        <group>0</group>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_MAC_ADD_NEW                         (0x103UL)

/**
    @brief Add flow with one of the configured MACs

    @pre #ETHSRV_FAInit

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_FLOW_ADD
        <flow>
            <match>
                <da>10:11:22:33:44:03</da>
                <srcPort>40000</srcPort>
                <dstPort>50000</dstPort>
                <srcIP>10.20.30.40</srcIP>
                <dstIP>10.20.30.41</dstIP>
                <isTcp>false</isTcp>
                <isIpV4>true</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>false</isInBound>
            </match>
            <remap>
                <operation>S_TAG</operation>
                <sa>10:11:22:33:44:03</sa>
                <da>AA:BB:CC:DD:EE:0B</da>
                <vlan>
                    <pcp>3</pcp>
                    <dei>false</dei>
                    <vid>11</vid>
                </vlan>
                <port>00</port>
                <ip>00.00.00.00</ip>
                <bhTc>0</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x00000000</bhDstPort>
            </remap>
        </flow>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS                         (0x104UL)

/**
    @brief Add flow with non-configured MAC

    @pre
    - #ETHSRV_FAInit
    - #BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_FLOW_ADD
        <flow>
            <match>
                <da>40:11:22:33:44:03</da>
                <srcPort>40000</srcPort>
                <dstPort>50000</dstPort>
                <srcIP>10.20.30.40</srcIP>
                <dstIP>10.20.30.41</dstIP>
                <isTcp>false</isTcp>
                <isIpV4>true</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>false</isInBound>
            </match>
            <remap>
                <operation>S_TAG</operation>
                <sa>20:11:22:33:44:03</sa>
                <da>AA:BB:CC:DD:EE:0B</da>
                <vlan>
                    <pcp>3</pcp>
                    <dei>false</dei>
                    <vid>11</vid>
                </vlan>
                <port>00</port>
                <ip>00.00.00.00</ip>
                <bhTc>0</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x00000000</bhDstPort>
            </remap>
        </flow>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is not BCM_ERR_OK

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_FLOWADD_NEG                         (0x105UL)

/**
    @brief Retrieve flow status

    @pre #ETHSRV_FAInit

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_FLOW_STATUS
     - With Attribute as Static, Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response
     - With Attribute as Valid, Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_FLOWSTATUS_GET                      (0x106UL)

/**
    @brief Retrieve flow paramters

    @pre
    #ETHSRV_FAInit
    #BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS has successfully completed with a flowID

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_FLOW_GET
       Set flowID received through #BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_FLOWGET                             (0x107UL)

/**
    @brief Deletion a static flow

    @pre
    #ETHSRV_FAInit
    #BRCM_SWQTST_ETHSRV_FA_FLOWSTATUS_GET

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_FLOW_DELETE
       Choose flowID from of static flows obtained through
       #BRCM_SWQTST_ETHSRV_FA_FLOWSTATUS_GET
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is not BCM_ERR_OK

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_FLOWDELETE_NEG                      (0x108UL)

/**
    @brief Deletion a non-static flow

    @pre
    - #ETHSRV_FAInit
    - #BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_FLOW_DELETE
       Set flowID received through #BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_FLOWDELETE_POS                      (0x109UL)

/**
    @brief Deletion of MAC address in use

    @pre
    - #BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET
    - #BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_MAC_DELETE
       <mac>00:11:22:33:44:03</mac>
       <group>0</group>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is not BCM_ERR_OK

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_MACDELETE_NEG                       (0x10AUL)

/**
    @brief Deletion of MAC address not in use

    @pre #BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_MAC_DELETE
       <mac>20:11:22:33:44:03</mac>
       <group>0</group>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_MACDELETE_POS                       (0x10BUL)

/**
    @brief Retrieve global statistics

    @pre #ETHSRV_FAInit

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_STATS
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_STATS                               (0x10CUL)

/**
    @brief Enable interrupts

    @pre #ETHSRV_FAInit

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_INTERRUPT_ENABLE
       Set intrFlags as (ETHSWT_FAINTRFLAGS_PARSE_L2
           | ETHSWT_FAINTRFLAGS_OVERFLOW_RSV | ETHSWT_FAINTRFLAGS_COR_NEXT_HOP)
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_INTERRUPT_EN                        (0x10DUL)

/**
    @brief Reset FA into BYPASS mode

    @pre #ETHSRV_FAInit

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_RESET
        <ctfCfg>
            <mode>BYPASS</mode>
            <crc>CCITT</crc>
            <seedValue>0x0</seedValue>
            <timestampPeriodSec>2</timestampPeriodSec>
            <validateMatchDA>true</validateMatchDA>
        </ctfCfg>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_RESET_BYPASS                        (0x10EUL)

/**
    @brief Reset FA into NORMAL mode

    @pre #ETHSRV_FAInit

    @test
     - Create a message with command ID: ETHSRV_ETHSWTCMDID_FA_RESET
        <ctfCfg>
            <mode>BYPASS</mode>
            <crc>CCITT</crc>
            <seedValue>0x0</seedValue>
            <timestampPeriodSec>2</timestampPeriodSec>
            <validateMatchDA>true</validateMatchDA>
        </ctfCfg>
     - Queue a command to ETHSRV Command Handler using ETHSRV_SendCmd
     - Wait for response

    @post return value is BCM_ERR_OK

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSRV_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSRV_FA_RESET_NORMAL                        (0x10FUL)

/**
    @brief Verify FA config generation fails with invalid parameters

    @pre

    @test
        -# Configure "ctf_cfg" in "fa_config.xml" as below
            <ctfCfg>
                <mode>NORMAL</mode>
                <crc>CCITT</crc>
                <seedValue>0x0</seedValue>
                <timestampPeriodSec>2</timestampPeriodSec>
                <validateMatchDA>true</validateMatchDA>
            </ctfCfg>
        -# Add a new "flow" with invalid "match" or "remap" attributes
        -# Generate bin file using python config generator script "ethswtm_fa_config.py"

    @post
        -# bin file generation should fail

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
*/
#define BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE           (0x110UL)

/**
    @brief Verify config generator throws error when flows are present in BYPASS mode

    @pre

    @test
        -# Configure "ctf_cfg" in "fa_config.xml" as below
            <ctfCfg>
                <mode>BYPASS</mode>
                <crc>CCITT</crc>
                <seedValue>0x0</seedValue>
                <timestampPeriodSec>2</timestampPeriodSec>
                <validateMatchDA>true</validateMatchDA>
            </ctfCfg>
        -# Add a new "flow" with valid "match" and "remap" attributes
        -# Generate bin file using python config generator script "ethswtm_fa_config.py"

    @post
        -# bin file generation should fail with appropriate errors

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSRV_FA_CONFIG_GENERATOR
*/
#define BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE_BYPASS    (0x111UL)



/** @brief ETHSRV FA in NORMAL and BYPASS Modes

    Verify Normal mode of operation with addition/deletion/retrieval of MAC and
    flows. After resetting into BYPASS mode, verify that flow addition is disallowed.

    @code{.c}
    - Get the configured MAC addresses through #BRCM_SWQTST_ETHSRV_FA_MACPOOL_GET
    - Add an existing MAC address using #BRCM_SWQTST_ETHSRV_FA_MAC_ADD_EXISTING
    - Add a new MAC address using #BRCM_SWQTST_ETHSRV_FA_MAC_ADD_NEW
    - Add flows through #BRCM_SWQTST_ETHSRV_FA_FLOWADD_POS with one of the configured MACs
    - Add flows through #BRCM_SWQTST_ETHSRV_FA_FLOWADD_NEG with non-configured MAC
    - Verify that added flows are available in static and active flow masks
    - Get the configured flowstatus #BRCM_SWQTST_ETHSRV_FA_FLOWSTATUS_GET
    - Retrieve flow paramters and compare them with configured values using #BRCM_SWQTST_ETHSRV_FA_FLOWGET
    - Verify that Deletion a static flow fails though #BRCM_SWQTST_ETHSRV_FA_FLOWDELETE_NEG
    - Verify that Deletion a non-static flow succeeds though #BRCM_SWQTST_ETHSRV_FA_FLOWDELETE_POS
    - Verify that deletion of MAC address in use, fails through #BRCM_SWQTST_ETHSRV_FA_MACDELETE_NEG
    - Verify that deletion of MAC address not in use, succeeds through #BRCM_SWQTST_ETHSRV_FA_MACDELETE_POS
    - Retrieve global statistics using #BRCM_SWQTST_ETHSRV_FA_STATS
    - Enable interrupts through #BRCM_SWQTST_ETHSRV_FA_INTERRUPT_EN
    - Reset FA into BYPASS mode through #BRCM_SWQTST_ETHSRV_FA_RESET_BYPASS
    - Verify that Flow Addition is disallowed through #BRCM_SWQTST_ETHSRV_FA_FLOWADD_NEG
    - Reset FA into NORMAL mode through #BRCM_SWQTST_ETHSRV_FA_RESET_NORMAL
    - Get the configured flowstatus #BRCM_SWQTST_ETHSRV_FA_FLOWSTATUS_GET

    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           Yes

    @type           ShortRun

    @executetime    50s

    @analyzetime    1m

*/
#define BRCM_SWQTSEQ_ETHSRV_FA                                    (0x112UL)


/** @brief FA config generator invalid MAC addresses

    This test sequence verifies if config generator throws error when invalid L2 values are configured in XML file
    Below are the MAC address checks expected
    1) Allow zero mac for match DA or remap SA
    2) Don't allow all 1s in match DA (all 0s allowed, multicast allowed)
    3) Don't allow all 1s in remap SA (all 0s allowed, multicast allowed)
    4) Don't allow all 0s in remap DA (all 1s allowed for broadcast, multicast allowed)

    @code{.c}
    1. Create an fa_config xml with flow configured as below
        <macGroup>
            <entry>
                <mac>00:FG:22:66:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:66:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
            <match>
                <da>
                    <group>0</group>
                    <entry>0</entry>
                </da>
                <srcPort>9088</srcPort>
                <dstPort>50288</dstPort>
                <srcIP>fc00:aaaa:bbbb:cccc:0:b885:a885:ffb0</srcIP>
                <dstIP>fc00:bbbb:aaaa:8888:2222:1088:bad:dad</dstIP>
                <isTcp>true</isTcp>
                <isIpV4>false</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>C_TAG</operation>
                <sa>
                    <group>0</group>
                    <entry>1</entry>
                </sa>
                <da>00:AA:BB:CC:DD:66</da>
                <port>0</port>
                <ip>0:0:0:0:0:0:0:0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x200</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    3. Replace <macGroup>[0]<entry/mac> value with FF:FF:FF:FF:FF:FF
    4. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    5. Replace <macGroup>[0]<entry/mac> value with 00:00:00:00:00:00
    6. Replace <remap/da> value with 00:00:00:00:00:00
    7. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    8. Replace <remap/da> value with FG:AA:BB:CC:DD:EE
    9. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    10. Replace <remap/da> value with 00:AA:BB:CC:DD:66
    11. Replace <remap/vlan/vid> value with 4095
    12. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE

    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_L2                        (0x113UL)

/** @brief FA config generator invalid IPv6 addresses

    This test sequence verifies if config generator throws error when invalid IPv6 addresses are configured in XML file

    @code{.c}
    1. Create an fa_config xml with flow configured as below
         <macGroup>
            <entry>
                <mac>00:11:22:77:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:77:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
             <match>
                <da>
                    <group>0</group>
                    <entry>1</entry>
                </da>
                <srcPort>9088</srcPort>
                <dstPort>50288</dstPort>
                <srcIP>fc0o:aaaa:bbbb:cccc:0:b885:a885:ffb0</srcIP>
                <dstIP>fc00:bbbb:aaaa:8888:2222:1088:bad:dad</dstIP>
                <isTcp>true</isTcp>
                <isIpV4>false</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>NO_TAG</operation>
                <da>00:AA:BB:CC:DD:77</da>
                <vlan>
                    <pcp>5</pcp>
                    <dei>false</dei>
                    <vid>4090</vid>
                </vlan>
                <port>0</port>
                <ip>0:0:0:0:0:0:0:0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x200</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    3. Replace <match/srcIP> value with fc00:aaaa:bbbb:cccc:0:b885:a885:ffb0
    4. Replace <remap/ip> value with fd46:6340:c06b:8888:aaaa:8888:333
    5. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    6. Replace <remap/ip> value with 192.168.10.100
    7. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_L3_IPV6                   (0x114UL)

/** @brief FA config generator invalid IPv4 addresses

    This test sequence verifies if config generator throws error when invalid IPv4 addresses are configured in XML file

    @code{.c}
    1. Create an fa_config xml with flow configured as below
        <macGroup>
            <entry>
                <mac>00:11:22:88:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:88:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
            <match>
                <da>
                    <group>0</group>
                    <entry>1</entry>
                </da>
                <srcPort>1088</srcPort>
                <dstPort>10266</dstPort>
                <srcIP>256.223.54.100</srcIP>
                <dstIP>10.53.54.53</dstIP>
                <isTcp>true</isTcp>
                <isIpV4>true</isIpV4>
                <isL2LlcSnap>true</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>NO_OP</operation>
                <da>00:AA:BB:CC:DD:88</da>
                <port>0</port>
                <ip>0.0.0.0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x0</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    3. Replace <match/srcIP> value with 10.223.54.100
    4. Replace <remap/ip> value with 192.168.a.f
    5. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    6. Replace <remap/ip> value with fd46:6340:c06b:1a8d:8888:aaaa:8888:333
    7. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_L3_IPV4                   (0x115UL)

/** @brief FA config generator invalid value for bool types

    This test sequence verifies if config generator throws error when invalid values are configured
    for all boolean types in XML file

    @code{.c}
    1. Create an fa_config xml with flow configured as below
        <macGroup>
            <entry>
                <mac>00:11:22:99:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:99:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
            <match>
                <da>
                    <group>0</group>
                    <entry>1</entry>
                </da>
                <srcPort>1088</srcPort>
                <dstPort>10266</dstPort>
                <srcIP>10.223.54.100</srcIP>
                <dstIP>10.53.54.53</dstIP>
                <isTcp>-1</isTcp>
                <isIpV4>true</isIpV4>
                <isL2LlcSnap>true</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>NO_OP</operation>
                <da>00:AA:BB:CC:DD:99</da>
                <port>0</port>
                <ip>0.0.0.0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x0</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    3. Replace <match/isTcp> value with true
    4. Replace <match/isIpV4> value with IPv6
    5. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    6. Replace <match/isIpV4> value with true
    7. Replace <match/isL2LlcSnap> value with EthII
    8. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    9. Replace <match/isL2LlcSnap> value with false
    10. Replace <match/isInBound> value with yes
    11. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_BOOL                      (0x116UL)

/** @brief FA config generator invalid L4 ports

    This test sequence verifies if config generator throws error when invalid port numbers
    are configured in XML file

    @code{.c}
    1. Create an fa_config xml with flow configured as below
        <macGroup>
            <entry>
                <mac>00:11:22:AA:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:AA:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
            <match>
                <da>
                    <group>0</group>
                    <entry>1</entry>
                </da>
                <srcPort>65536</srcPort>
                <dstPort>50288</dstPort>
                <srcIP>fc00:aaaa:bbbb:cccc:0:b885:a885:ffb0</srcIP>
                <dstIP>fc00:bbbb:aaaa:8888:2222:1088:bad:dad</dstIP>
                <isTcp>true</isTcp>
                <isIpV4>false</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>NO_TAG</operation>
                <da>00:AA:BB:CC:DD:AA</da>
                <port>0</port>
                <ip>0:0:0:0:0:0:0:0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x200</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    3. Replace <match/srcPort> value with 1089
    4. Replace <match/dstPort> value with -1
    5. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    6. Replace <match/dstPort> value with 50288
    7. Replace <remap/port> value with "zero"
    8. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_L4                        (0x117UL)

/** @brief FA config generator invalid Broadcom Header and Operation fields

    This test sequence verifies if config generator throws error when invalid values are configured for Broadcom Header or Operation fields in XML file

    @code{.c}
    1. Create an fa_config xml with flow configured as below
        <macGroup>
            <entry>
                <mac>00:11:22:BB:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:BB:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
            <match>
                <da>
                    <group>0</group>
                    <entry>1</entry>
                </da>
                <srcPort>536</srcPort>
                <dstPort>50288</dstPort>
                <srcIP>fc00:aaaa:bbbb:cccc:0:b885:a885:ffb0</srcIP>
                <dstIP>fc00:bbbb:aaaa:8888:2222:1088:bad:dad</dstIP>
                <isTcp>true</isTcp>
                <isIpV4>false</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>None</operation>
                <sa>02:01:02:03:04:05</sa>
                <da>00:AA:BB:CC:DD:BB</da>
                <port>0</port>
                <ip>0:0:0:0:0:0:0:0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x200</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    3. Replace <remap/operation> value with NO_TAG
    4. Replace <remap/bhTc> value with 8
    5. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    6. Replace <remap/bhTc> value with 2
    7. Replace <remap/bhTe> value with 3
    8. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    9. Replace <remap/bhTe> value with 2
    10. Replace <remap/bhDstPort> value with 0x1FFFFAAAA
    11. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_REMAP                     (0x118UL)

/** @brief FA config generator for bypass mode with flows present

    This test sequence verifies if config generator throws error when FA is configured
    in BYPASS mode with flows present in XML

    @code{.c}
    1. Create an fa_config xml with flow configured as below
        <macGroup>
            <entry>
                <mac>00:11:22:CC:AA:11</mac>
                <domain>INTERNAL</domain>
            </entry>
            <entry>
                <mac>00:11:22:CC:AA:22</mac>
                <domain>INTERNAL</domain>
            </entry>
        </macGroup>
        <flow>
            <match>
                <da>
                    <group>0</group>
                    <entry>1</entry>
                </da>
                <srcPort>536</srcPort>
                <dstPort>50288</dstPort>
                <srcIP>fc00:aaaa:bbbb:cccc:0:b885:a885:ffb0</srcIP>
                <dstIP>fc00:bbbb:aaaa:8888:2222:1088:bad:dad</dstIP>
                <isTcp>true</isTcp>
                <isIpV4>false</isIpV4>
                <isL2LlcSnap>false</isL2LlcSnap>
                <isInBound>true</isInBound>
            </match>
            <remap>
                <operation>NO_TAG</operation>
                <da>00:AA:BB:CC:DD:CC</da>
                <port>0</port>
                <ip>0:0:0:0:0:0:0:0</ip>
                <bhTc>2</bhTc>
                <bhTe>NONE</bhTe>
                <bhDstPort>0x200</bhDstPort>
            </remap>
        </flow>
    2. Verify that config generator python script throws appropriate error #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE_BYPASS with above flow configured
    @endcode

    @board bcm89564g_evk
    @board bcm89561_evk

    @auto           No

    @type           Sanity

    @testproc #BRCM_SWQTST_ETHSRV_FA_CONFIG_GENERATOR_NEGATIVE
*/
#define BRCM_SWQTSEQ_ETHSRV_FA_NEGATIVE_BYPASS                    (0x119UL)

#endif /* ETHSRV_FA_QT_H */

/** @} */

