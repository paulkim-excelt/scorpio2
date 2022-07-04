/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_falib_qt Qualification Tests
    @ingroup grp_ethswt

    @addtogroup grp_falib_qt
    @{

    @file falib_qt.h
    @brief Flow Accelerator Qualification Test
     This file contains test cases and test sequences for FA.

    @version 0.1 Initial version
*/

#ifndef FALIB_QT_H
#define FALIB_QT_H
/**
    @brief Test Initialize the Flow Accelerator in Normal

    @pre #BRCM_SWARCH_ETHSWT_FACFG_TYPE to be configured
        unimacCfg
            maxFrameLength = 1522UL
            enableExternalConfig = 1U
            speed = 0U
            loopBack = UNIMAC_LOOPBACK_NONE
            macAddr = {0U, 0U, 0U, 0U, 0U, 0U}
        ctfCfg
            mode = ETHSWT_FACTFMODE_NORMAL
            crc  = ETHSWT_FACRC_CCITT
            seedValue = 0
            timestampPeriodSec = 64

    @test Initialize the Flow Accelerator

    @post Flow Accelerator Initialised

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
#define BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0          (0x201UL)

/**
    @brief Test Initialize the Flow Accelerator in Bypass

    @pre #BRCM_SWARCH_ETHSWT_FACFG_TYPE to be configured
        unimacCfg
            maxFrameLength = 1522UL
            enableExternalConfig = 1U
            speed = 0U
            loopBack = UNIMAC_LOOPBACK_NONE
            macAddr = {0U, 0U, 0U, 0U, 0U, 0U}
        ctfCfg
            mode = ETHSWT_FACTFMODE_BYPASS
            crc  = ETHSWT_FACRC_CCITT
            seedValue = 0
            timestampPeriodSec = 64

    @test Initialize the Flow Accelerator

    @post Flow Accelerator Initialised

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
#define BRCM_SWQTST_ETHSWT_FA_INITIALISATION_BYPASS_CASE1          (0x202UL)

/**
    @brief Test to De-Initializes the Flow Accelerator

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0

    @test De-Initialize the Flow Accelerator

    @post Flow Accelerator De-Initialised

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION
*/
#define BRCM_SWQTST_ETHSWT_FA_DEINITIALISATION_CASE2               (0x203UL)

/**
    @brief Test to Add Flow to Flow Accelerator

    @pre
        -# Vlan id #BRCM_SWARCH_ETHSWT_ADD_VLAN_PORTS_PROC is added

        FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        Configure Flow 0
            #BRCM_SWARCH_ETHSWT_FAFLOWVALID_TYPE
                #ETHSWT_FAFLOWVALID_TILLDELETE
            #BRCM_SWARCH_ETHSWTM_FAFLOW_TYPE
                #BRCM_SWARCH_ETHSWT_FAMATCH_TYPE
                da = 0
                srcPort = 40000
                dstPort = 50000
                srcIp = 10.20.30.40
                dstIp = 10.20.30.41
                #BRCM_SWARCH_ETHSWTM_FAREMAP_TYPE
                operation = ETHSWT_FAOPERATION_S_TAG
                da = AA:BB:CC:DD:EE:0B
                port = 00
                ip = 00.00.00.00
                tc = 0
                te = NONE
                remapSA=matchDA
        Configure Flow 1
            #BRCM_SWARCH_ETHSWT_FAFLOWVALID_TYPE
                #ETHSWT_FAFLOWVALID_TILLREBOOT
            #BRCM_SWARCH_ETHSWTM_FAFLOW_TYPE
                #BRCM_SWARCH_ETHSWT_FAMATCH_TYPE
                sa = 1
                srcPort = 40000
                dstPort = 50000
                srcIp = FD0A:0000:0000:0000:0000:0000:0000:000A
                dstIp = FD0B:0000:0000:0000:0000:0000:0000:000B
                #BRCM_SWARCH_ETHSWTM_FAREMAP_TYPE
                operation = ETHSWT_FAOPERATION_NO_TAG
                da = ETHSWT_FAOPERATION_NO_TAG
                port = 00
                ip = 0000:0000:0000:0000:0000:0000:0000:0000
                tc = 0
                te = NONE
                remapSA=matchDA
    @test Add a new Flow into Flow accelerator

    @post Driver stores the flow identifier

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAFLOWADD_POS_CASE3                     (0x204UL)


/**
    @brief Test to Add Flow to Flow Accelerator

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_BYPASS_CASE1
        Configure Flow 0
            #BRCM_SWARCH_ETHSWT_FAFLOWVALID_TYPE
                #ETHSWT_FAFLOWVALID_TILLDELETE
            #BRCM_SWARCH_ETHSWTM_FAFLOW_TYPE
                #BRCM_SWARCH_ETHSWT_FAMATCH_TYPE
                da = 0
                srcPort = 40000
                dstPort = 50000
                srcIp = 10.20.30.40
                dstIp = 10.20.30.41
                #BRCM_SWARCH_ETHSWTM_FAREMAP_TYPE
                operation = ETHSWT_FAOPERATION_S_TAG
                da = AA:BB:CC:DD:EE:0B
                port = 00
                ip = 00.00.00.00
                tc = 0
                te = NONE
                remapSA=matchDA
        Configure Flow 1
            #BRCM_SWARCH_ETHSWT_FAFLOWVALID_TYPE
                #ETHSWT_FAFLOWVALID_TILLREBOOT
            #BRCM_SWARCH_ETHSWTM_FAFLOW_TYPE
                #BRCM_SWARCH_ETHSWT_FAMATCH_TYPE
                sa = 1
                srcPort = 40000
                dstPort = 50000
                srcIp = FD0A:0000:0000:0000:0000:0000:0000:000A
                dstIp = FD0B:0000:0000:0000:0000:0000:0000:000B
                #BRCM_SWARCH_ETHSWTM_FAREMAP_TYPE
                operation = ETHSWT_FAOPERATION_NO_TAG
                da = ETHSWT_FAOPERATION_NO_TAG
                port = 00
                ip = 0000:0000:0000:0000:0000:0000:0000:0000
                tc = 0
                te = NONE
                remapSA=matchDA
    @test Add a new Flow into Flow accelerator

    @post should return #BCM_ERR_INVAL_STATE as FA is initialized in Bypass mode

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAFLOWADD_NEG_CASE4                     (0x205UL)

/**
    @brief Get Flow of FA

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA flow added #BRCM_SWQTST_ETHSWT_FAFLOWADD

    @test retrieve flow parameters, flow statistics

    @post Successfully retrieve and Matches configured flow

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
#define BRCM_SWQTST_ETHSWT_FAFLOWGET_POS_CASE5                     (0x206UL)

/**
    @brief Get Flow of FA

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA flow added #BRCM_SWQTST_ETHSWT_FAFLOWADD

    @test Try to retrieve flow parameters. It should fail as the flow not available

    @post should return #BCM_ERR_INVAL_PARAMS as the flow is not available

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
#define BRCM_SWQTST_ETHSWT_FAFLOWGET_NEG_CASE6                     (0x207UL)

/**
    @brief Test to Delete a Flow

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA flow added #BRCM_SWQTST_ETHSWT_FAFLOWADD

    @test Delete a Flow VALID_TILL_REBOOT

    @post Flow will be Not be Deleted

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_REBOOT_CASE7    (0x208UL)

/**
    @brief Test to Delete a Flow

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA flow added #BRCM_SWQTST_ETHSWT_FAFLOWADD

    @test Delete a Flow VALID_TILL_DELETE

    @post Flow will be Deleted

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_DELETE_CASE8    (0x209UL)

/**
    @brief Test to Retrieve statistics

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
                        #BRCM_SWQTST_ETHSWT_FAFLOWADD_POS_CASE3

    @test Retrieve statistics

    @post successfully retrive the statistics if Flow Found

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
#define BRCM_SWQTST_ETHSWT_FASTATS_POS_CASE9                       (0x20AUL)

/**
    @brief Test to Retrieve statistics

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
                        #BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_DELETE_CASE8

    @test Retrieve statistics

    @post successfully retrive the statistics if Flow Found

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
#define BRCM_SWQTST_ETHSWT_FASTATS_NEG_CASE10                      (0x20BUL)

/**
    @brief Test to add MAC address to FA

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
       Add MAC group 0 #BRCM_SWARCH_ETHSWTM_FAMACGROUP_TYPE
            macGroup0.info0.mac = 00:11:22:33:44:03
            macGroup0.info0.external = FALSE
            macGroup0.info1.mac = 10:11:22:33:44:03
            macGroup0.info2.mac = 00:00:00:00:00:00
            macGroup0.info2.external = TRUE
       Add MAC group 1 #BRCM_SWARCH_ETHSWTM_FAMACGROUP_TYPE
            macGroup1.info0.mac =11:11:22:33:44:03
            macGroup1.info0.external = FALSE
            macGroup1.info1.mac =10:00:00:00:00:00
            macGroup1.info2.mac =00:00:00:00:00:00
            macGroup1.info2.external = TRUE
    @test Add Pool table entry

    @post Pool table Entry will be added

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAMACADD_POS_CASE11                     (0x20CUL)

/**
    @brief Test to add MAC address to FA

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
       Add MAC group 0 #BRCM_SWARCH_ETHSWTM_FAMACGROUP_TYPE
            macGroup0.info0.mac = 00:11:22:33:44:03
            macGroup0.info0.external = FALSE
            macGroup0.info1.mac = 10:11:22:33:44:03
            macGroup0.info2.mac = 00:00:00:00:00:00
            macGroup0.info2.external = TRUE
       Add MAC group 1 #BRCM_SWARCH_ETHSWTM_FAMACGROUP_TYPE
            macGroup1.info0.mac =11:11:22:33:44:03
            macGroup1.info0.external = FALSE
            macGroup1.info1.mac =10:00:00:00:00:00
            macGroup1.info2.mac =00:00:00:00:00:00
            macGroup1.info2.external = TRUE
    @test Add Pool table entry

    @post Pool table Entry will be added

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAMACADD_NEG_CASE12                     (0x20DUL)

/**
    @brief Test to Get the added MAC addresses from FA

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA MACID added #BRCM_SWQTST_ETHSWT_FAMACADD

    @test Get the added MAC addresses and validate with the configuration.

    @post Get the MAC addresses successfully

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY
*/
#define BRCM_SWQTST_ETHSWT_FAMACGET_CASE13                         (0x20EUL)

/**
    @brief Test to Delete MAC ID from FA

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA Flow added #BRCM_SWQTST_ETHSWT_FAFLOWADD
        -# FA MACID added #BRCM_SWQTST_ETHSWT_FAMACADD

    @test Delete MAC ID from the list when Flow is using

    @post MACID could not be Deleted

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAMACDELETE_NEG_CASE14                  (0x20FUL)

/**
    @brief Test to Delete MAC ID from FA

    @pre
        -# FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
        -# FA MACID added #BRCM_SWQTST_ETHSWT_FAMACADD

    @test Delete MAC ID from the list

    @post MACID Deleted Successfully

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS
*/
#define BRCM_SWQTST_ETHSWT_FAMACDELETE_POS_CASE15                  (0x210UL)

/**
    @brief Test to execute Periodic Timer

    @pre FA Initialised #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_NORMAL_CASE0
                        #BRCM_SWQTST_ETHSWT_FAFLOWADD_POS_CASE3

    @test FA Timer

    @post Check for #BCM_ERR_OK to validate successful processing of Timer Event

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_ETHSWT_FA_HANDLER
*/
#define BRCM_SWQTST_ETHSWT_FATIMER_CASE16                          (0x211UL)

/** @brief FA Lib API Test

    Initialise the Flow Accelerator and add a Flow, MACID
    and verify they are added.
    Delete Flow, MAC and Deinitialize
    @code{.c}
    Initialise FA Check Expected Result for #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_BYPASS_CASE1
    Add the MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACADD_POS_CASE11
    Get and check the MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACGET_CASE13
    Add Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWADD_POS_CASE3
    Query Stats Check Expected Result for #BRCM_SWQTST_ETHSWT_FASTATS_POS_CASE9
    Check the Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWGET_POS_CASE5
    Query Stats Check Expected Result for #BRCM_SWQTST_ETHSWT_FASTATS_POS_CASE9
    Trigger #BRCM_SWQTST_ETHSWT_FATIMER_CASE16 and check for timer increment and overFlow
    Delete MACID It is expected to be fail as it is in Use by Flow #BRCM_SWQTST_ETHSWT_FAMACDELETE_NEG_CASE14
    Delete Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_REBOOT_CASE7
    Delete Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_DELETE_CASE8
    Query Stats Check Expected Result for #BRCM_SWQTST_ETHSWT_FASTATS_NEG_CASE10
    Delete MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACDELETE_POS_CASE15
    Get and check the MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACGET_CASE13
    Check the Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWGET_NEG_CASE6
    Deinitialize #BRCM_SWQTST_ETHSWT_FA_DEINITIALISATION_CASE2
    Initialise Flow Accelerator Check Expected Result for #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_BYPASS_CASE1
    Try to add the flow when Bypass Mode Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWADD_NEG_CASE4
    Deinitialize #BRCM_SWQTST_ETHSWT_FA_DEINITIALISATION_CASE2

    @endcode

    @board bcm8956x

    @auto           Yes

    @type           ShortRun

    @executetime    18s

    @analyzetime    1m

*/
#define BRCM_SWQTSEQ_ETHSWT_SEQ0                                   (0x212UL)

/** @brief FA Data Transfer Test

    Initialise the Flow Accelerator and add a Flow, MACID
    and verify they are added.
    Transfer the data and check for parametes.
    Delete Flow, MAC and Deinitialize

    @code{.c}
    Initialise FA Check Expected Result for #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_BYPASS_CASE1
    Add the MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACADD_POS_CASE11
    Get and check the MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACGET_CASE13
    Add Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWADD_POS_CASE3
    Query Stats Check Expected Result for #BRCM_SWQTST_ETHSWT_FASTATS_POS_CASE9
    Check the Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWGET_POS_CASE5
    Query Stats Check Expected Result for #BRCM_SWQTST_ETHSWT_FASTATS_POS_CASE9
    wait for the Data Traffic for the finite amount of time
    Trigger #BRCM_SWQTST_ETHSWT_FATIMER_CASE16 and check for timer increment and overFlow
    Delete MACID It is expected to be fail as it is in Use by Flow #BRCM_SWQTST_ETHSWT_FAMACDELETE_NEG_CASE14
    Delete Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_REBOOT_CASE7
    Delete Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWDELETE_VALID_TILL_DELETE_CASE8
    Query Stats Check Expected Result for #BRCM_SWQTST_ETHSWT_FASTATS_NEG_CASE10
    Delete MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACDELETE_POS_CASE15
    Get and check the MACID Check Expected Result for #BRCM_SWQTST_ETHSWT_FAMACGET_CASE13
    Check the Flow Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWGET_NEG_CASE6
    Deinitialize #BRCM_SWQTST_ETHSWT_FA_DEINITIALISATION_CASE2
    Initialise Flow Accelerator Check Expected Result for #BRCM_SWQTST_ETHSWT_FA_INITIALISATION_BYPASS_CASE1
    Try to add the flow when Bypass Mode Check Expected Result for #BRCM_SWQTST_ETHSWT_FAFLOWADD_NEG_CASE4
    Deinitialize #BRCM_SWQTST_ETHSWT_FA_DEINITIALISATION_CASE2

    @endcode

    @board bcm8956x

    @auto           Yes

    @type           ShortRun

    @executetime    3m

    @analyzetime    5m

*/
#define BRCM_SWQTSEQ_ETHSWT_FA_SEQ1                                (0x213UL)

#endif /* FALIB_QT_H */

/** @} */

