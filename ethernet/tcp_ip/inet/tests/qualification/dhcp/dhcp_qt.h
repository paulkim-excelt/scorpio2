/*****************************************************************************
  Copyright 2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_dhcp_qt DHCP Qualification Tests
    @ingroup grp_inet

    @addtogroup grp_dhcp_qt
    @{

    @file dhcp_qt.h
    @brief DHCP Qualification Test cases
    This source file contains the test cases for DHCP
    @version 0.1 Initial version
*/

#ifndef DHCP_QT_H
#define DHCP_QT_H

/**
    @brief Initialization of DHCP client

    @pre
     -# Endpoint should be created with local port as #DHCP_CLIENT_PORT and
        remote port as #DHCP_SERVER_PORT
     -# Device should be connected to a DHCP server over a functional Ethernet
        link

    @test The #DHCP_Init API should be invoked for the initializing
    the library

    @post
      -# The #DHCP_Init API should succeed
      -# Packet capture should see DHCP Discover messages being transmitted from the DUT

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_CONFIG_INIT          (0x101UL)

/**
    @brief DHCP protocol operation

    @pre DHCP library should have been initialized with #DHCP_Init

    @test Setup an alarm for 5s to act as an upper bound on the time
    for the IP address to be assigned by the server. Also install the
    #DHCP_BoundCallback to inform when invoked. Wait for either of the
    2 events to occur.

    @post
      -# #DHCP_BoundCallback should get invoked before the timer fires
      -# Packet capture should see DHCP Ack being received by the DUT

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_OPER                 (0x102UL)

/**
    @brief Host IP address query

    @pre The #DHCP_BoundCallback should have been invoked

    @test Fetch the Host IP address from the DHCP library
    using the #DHCP_GetParameter with DHCP_PARAM_IPADDR as
    the key

    @post The #DHCP_GetParameter should return success and
    Host IP address should be valid

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_IPADDR_QUERY         (0x103UL)

/**
    @brief Router IP address query

    @pre The #DHCP_BoundCallback should have been invoked

    @test Fetch the router IP address from the DHCP library
    using the #DHCP_GetParameter with DHCP_PARAM_ROUTER as
    the key

    @post The #DHCP_GetParameter should return success and
    router IP address should be valid

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_ROUTER_QUERY         (0x104UL)

/**
    @brief Subnet mask query

    @pre The #DHCP_BoundCallback should have been invoked

    @test Fetch the subnet mask from the DHCP library
    using the #DHCP_GetParameter with DHCP_PARAM_SUBNET_MASK as
    the key

    @post The #DHCP_GetParameter should return success and
    subnet mask should be valid

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_SUBNETMASK_QUERY     (0x105UL)

/**
    @brief TFTP server IP address query

    @pre The #DHCP_BoundCallback should have been invoked

    @test Fetch the TFTP server IP address from the DHCP library
    using the #DHCP_GetParameter with DHCP_PARAM_TFTP_SERVER_ADDR as
    the key

    @post The #DHCP_GetParameter should return success and
    TFTP server IP address should be valid

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_TFTPSERVER_QUERY     (0x106UL)

/**
    @brief Boot filename query

    @pre The #DHCP_BoundCallback should have been invoked

    @test Fetch the boot filename from the DHCP library
    using the #DHCP_GetParameter with DHCP_PARAM_BOOT_FILE_NAME
    as the key

    @post The #DHCP_GetParameter should return success and
    a non-empty boot filename

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_BOOTFILE_QUERY       (0x107UL)

/**
    @brief DHCP renewal time query

    @pre The #DHCP_BoundCallback should have been invoked

    @test Fetch the renewal time from the DHCP library
    using the #DHCP_GetParameter with DHCP_PARAM_RENEWAL_TIME
    as the key

    @post The #DHCP_GetParameter should return success and a non
    zero renewal time

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_RENEWALTIME_QUERY    (0x108UL)

/**
    @brief DHCP ARP cache management

    @pre The allocated IP address should have been assigned to the interface

    @test Send an ARP announcement claiming the allocated IP address. Setup an
    alarm for 1s waiting for an ARP reply to be received. Check the ARP cache for
    the entry corresponding to the IP address

    @post
      -# The ARP entry should not have been resolved/learnt
      -# Packet capture should see a single gratuitous ARP being transmitted by the DUT

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_ARP_MGMT             (0x109UL)

/**
    @brief DHCP lease renewal

    @pre The allocated IP address should have been assigned to the interface

    @test Setup a timer to wait for the renewal time duration to elapse

    @post Packet capture should see a DHCP request being transmitted by the DUT
          and a DHCP Ack being received in response

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_RENEWAL              (0x10AUL)

/**
    @brief DHCP de-initialization

    @pre The allocated IP address should have been assigned to the interface

    @test Invoke the #DHCP_DeInit API to inform the server of the release of
    the IP address

    @post
     -# The API should return #BCM_ERR_OK
     -# Packet capture should see a DHCP release message transmitted by the DUT

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_DHCP
*/
#define BRCM_SWQTST_DHCP_DEINIT               (0x10BUL)

/** @brief DHCP Test sequence 0

    This sequence tests the DHCP client operation.

    @code{.c}
    Initialize DHCP using #DHCP_Init
    Verify the expected result of #BRCM_SWQTST_DHCP_CONFIG_INIT
    Create a single-shot alarm timer to signal the task after 5s
    Wait for timer or #DHCP_BoundCallback to signal the task
    Verify the expected result of #BRCM_SWQTST_DHCP_OPER
    Fetch the IP address as per #BRCM_SWQTST_DHCP_IPADDR_QUERY and
    print it on the console
    Fetch the router IP address as per #BRCM_SWQTST_DHCP_ROUTER_QUERY
    and print it on the console
    Fetch the subnet mask as per #BRCM_SWQTST_DHCP_SUBNETMASK_QUERY
    and print it on the console
    Fetch the TFTP server address as per #BRCM_SWQTST_DHCP_TFTPSERVER_QUERY
    and print it on the console
    Fetch the boot filename as per #BRCM_SWQTST_DHCP_BOOTFILE_QUERY
    and print it on the console
    Update the interface with the host IP address, router IP address
    and subnet mask
    Send an ARP announcement with #INET_ARPSendRequest
    Create a single-shot alarm timer to signal the task after 1s
    Find the ARP entry for the host IP address and verify its flags
    as per #BRCM_SWQTST_DHCP_ARP_MGMT
    Delete the ARP entry with #INET_RemoveARPEntry
    Create a single-shot alarm timer to signal the task after the
    renewal time has expired
    Verify the expected result of #BRCM_SWQTST_DHCP_RENEWAL
    De-initialize the DHCP library with #DHCP_DeInit
    Verify the expected result of #BRCM_SWQTST_DHCP_DEINIT
    @endcode

    @board bcm8910x
    @board bcm8956x

    @auto           yes

    @type           Sanity

    @testproc #BRCM_SWQTST_DHCP_CONFIG_INIT
    @testproc #BRCM_SWQTST_DHCP_OPER
    @testproc #BRCM_SWQTST_DHCP_PARAM_QUERY
    @testproc #BRCM_SWQTST_DHCP_ARP_MGMT
    @testproc #BRCM_SWQTST_DHCP_RENEWAL
    @testproc #BRCM_SWQTST_DHCP_DEINIT
*/
#define BRCM_SWQTSEQ_DHCP_SEQ0                (0x10CUL)

#endif /* DHCP_QT_H */

/** @} */
