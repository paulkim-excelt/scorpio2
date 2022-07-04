#
# Copyright 2020-2021 Broadcom Limited.  All rights reserved.
#
# This program is the proprietary software of Broadcom Limited and/or its
# licensors, and may only be used, duplicated, modified or distributed pursuant
# to the terms and conditions of a separate, written license agreement executed
# between you and Broadcom (an "Authorized License").
#
# Except as set forth in an Authorized License, Broadcom grants no license
# (express or implied), right to use, or waiver of any kind with respect to the
# Software, and Broadcom expressly reserves all rights in and to the Software
# and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
# LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
# IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.
#
#  Except as expressly set forth in the Authorized License,
# 1. This program, including its structure, sequence and organization,
#    constitutes the valuable trade secrets of Broadcom, and you shall use all
#    reasonable efforts to protect the confidentiality thereof, and to use this
#    information only in connection with your use of Broadcom integrated
#    circuit products.
#
# 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
#    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
#    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
#    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
#    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
#    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
#    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
#    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
#    SOFTWARE.
#
# 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
#    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
#    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
#    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
#    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
#    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. \$1, WHICHEVER
#    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
#    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
#
####################################################################################


##  @defchapter grp_introduction Introduction
#
#   @addtogroup grp_introduction
#   @{
#   This document covers Requirements, Architecture, Design and Test specification for BCM8957X ROM.
#   <BR>BCM8957X ROM supports below features
#   -# Boot over different media
#       -# Flash connected over QSPI (using Partition Table)
#       -# Ethenet Boot
#           -# TFTP and DHCP Protocols
#           -# Optional Static IP address configuration
#           -# Transceiver configuration (via OTP based configuration)
#       -# IPC Boot (Broadcom custom protocol using SPI/PCIe)
#   -# Boot modes
#       -# Non-secure Boot (default option with CRC32 based image verification)
#       -# Secure Boot with RSA-2K based image authentication, with optional decryption using AES-CBC (keys in OTP)
#       -# Support for Key revocation post-production
#           -# Support for 2xRSA-2K keys in OTP
#           -# Support for 8xAES-256 Keys in OTP
#           -# Support for key revocation/invalidation
#   -# Switch & Transceiver
#       -# Limited Transceiver configuration for faster link up (including PCIe, via configuration in OTP)
#       -# Limited TC10 Wake up detection and Forwarding
#       -# Limited Switch configuration (stacking mode, IMP port, and private VLAN)
#       -# Stacking link setup
#   -# Debug features
#       -# Status Logging (to identify ROM status)
#       -# Optional ROM Bypass mode
#       -# Optional Watchdog disable
#   .
#
#   For a quick startup guide, user may refer to @ref page_bcm8957x_rom_qsg
#   @}
#
#   @defchapter grp_bcm8957x_rom_qsg Quick Start Guide
#
#   @addtogroup grp_bcm8957x_rom_qsg
#   @{
#   This chapter describes how to build and run the ROM release on BCM8957X based
#   Palladium platforms. Details include
#       -# Build & Environment setup
#       -# Flashing and Debugging environment setup
#       -# Running and Debugging an application
#
#   @}
#
#   @defchapter grp_bcm8957x References & Examples
#
#   @addtogroup grp_bcm8957x
#   @{
#   This chapter describes
#       -# Example configurations
#       -# External references
#   @}
#
#   @defchapter grp_bcm8957x_rom Initialization & Application
#
#   @addtogroup grp_bcm8957x_rom
#   @{
#   This chapter describes initialization sequence for BCM8953X ROM including
#       -# Processor subsystem initialization
#       -# Memory tests & Initialization
#       -# Driver initialization
#       -# Application Initialization
#
#    Below flowchart describes startup sequence flow.
#
#    @image html bcm8957x_rom_startup.jpg Startup Flowchart
#
#    Processor initialization consists of
#       -# Interrupt/Vector setup
#       -# Stack setup
#       -# MPU Configuration
#       -# Division By 0 Trap
#       -# Switching to 400 MHz clock
#
#    Memory Tests and initialization consists of
#       -# Initialzation of TCM
#       -# TCM Test
#       -# BSS Initialization
#
#   Driver initialization consists of
#       -# MCU Initialization, including Address remapping
#       -# Clock and PLL initialization
#
#   After above mentioned Initialzation steps, execution flow is handed over to
#   Application (Bootloader/ROM) with exceptions enabled (and interrupts disabled)
#
#   ROM application flow is described @ref BCM8957X_RomMain
#
#   @file init/bcm8957x/comp1.mk
#   @brief Makefile for BCM8957X Initialization
#   @version 0.1 Initial version
#   @}
#


BRCM_COMP_NAME := bcm8957x_rom
BRCM_COMP_DEPENDS += loader xcvr
#BRCM_COMP_DEPENDS := nvm console
#BRCM_COMP_DEPENDS += spum secureheap
BRCM_COMP_DEPENDS += mcudrv utils arm
BRCM_COMP_DEPENDS += otpdrv pinmuxdrv gpiodrv
BRCM_COMP_DEPENDS += timdrv
BRCM_COMP_DEPENDS += time
BRCM_COMP_DEPENDS += queue wdtdrv tc10
BRCM_COMP_DEPENDS += ethswitch

BRCM_COMP_TYPE := doc

BRCM_COMP_REQ_SRC += doc/bcm8957x_rom_req.c
BRCM_COMP_REQ_SRC += doc/rom_page.c
BRCM_COMP_EXPORT_HDR += inc/rom_main.h
BRCM_COMP_LIB_SRC += chip/common/rom_main.c

BRCM_COMP_REQ_SRC += doc/a0/bcm8957x_rdb_req.c
BRCM_COMP_QT_SRC  += tests/qualification/bcm8957x_rom_qt.h

BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_REGISTER=\(0x4a800ffe\)
BRCM_COMP_LIB_CFLAGS += -DDBG_LOG_BUFFER_SIZE=\(1024UL\)

BRCM_COMP_LIB_CFLAGS += -DFLSLDR_SIZE_0=\(2UL*1024UL*1024UL\)
BRCM_COMP_LIB_CFLAGS += -DFLSLDR_ADDR_0=\(0x60000000UL\)
BRCM_COMP_LIB_CFLAGS += -DIPCLDR_TIMEOUT_NS=100000000UL
BRCM_COMP_LIB_CFLAGS += -DLOADER_EXE_IMGID=0UL
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_TIMEOUT_NS=\(1000000000UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_DHCP_MAX_RETRIES=\(255U\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_DHCP_SELECT_TIMEOUT=\(2000UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_DHCP_INIT_DELAY_SEED=\(0UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_DHCP_INIT_RETRY_PERIOD=\(1000UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_DHCP_MAX_RETRY_PERIOD=\(2000UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_TFTP_MAX_RETRIES=\(2UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_TFTP_TIMEOUT_MS=\(100UL\)
BRCM_COMP_LIB_CFLAGS += -DTFTPLDR_INET_TIMER_NS=\(1000000UL\)
BRCM_COMP_LIB_CFLAGS += -DDHCP_ADDRESS_PROBE_TIMEOUT=\(0UL\)

BRCM_COMP_LIB_CFLAGS += -DXCVR_TIMEOUT=100000UL

ifeq ($(comp),)
BRCM_COMP_LIB_CFLAGS += -DLOADER_DOWNLOAD_SIZE_0=\(128UL*1024UL\)
BRCM_COMP_LIB_CFLAGS += -DLOADER_EXE_PID=1
else
BRCM_COMP_LIB_CFLAGS += -DLOADER_DOWNLOAD_SIZE_0=\(256UL*1024UL\)
BRCM_COMP_LIB_CFLAGS += -DENABLE_RESET_FUNC_AT_START
BRCM_COMP_LIB_CFLAGS += -DLOADER_EXE_PID=3
endif

ifeq ($(strip $(version)),a0)
ifeq ($(comp),)
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_ENABLE_TCM_INIT
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_ENABLE_CLK_SWITCH
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_ENABLE_DBG_LOG
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_ENABLE_ROM_BYPASS
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_ENABLE_ADDR_REMAP
endif
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_MEM_DTCM_IPC_REGION_START=0x2007C000UL
else
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_MEM_DTCM_IPC_REGION_START=0x2003C000UL
BRCM_COMP_LIB_CFLAGS += -DBCM8956X_ENABLE_A0
BRCM_SRC += $(BRCM_SDK_ROOT)/init/bcm8956x/chip/common/rom_a0.c
endif
BRCM_COMP_LIB_CFLAGS += -DIPC_MAX_CHANNELS=1

BRCM_COMP_LIB_CFLAGS += -DBCM_TIME_USES_SP804

BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/lib/common
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc/bcm8957x
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/lib/bcm8957x
BRCM_INC += $(BRCM_SDK_ROOT)/system/imgl/inc

BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/lib/common/ipc.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/lib/common/ipc_drv.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/lib/bcm8957x/ipc_plat_rom.c

#BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/include
#BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8957x/chip
#BRCM_INC += $(BRCM_SDK_ROOT)/bootloader/bcm8957x/chip/common

BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/timer/os/none/tim_osil.c
BRCM_SRC += $(BRCM_SDK_ROOT)/nvm/drivers/otp/os/none/otp_osil.c
BRCM_SRC += $(BRCM_SDK_ROOT)/system/time/lib/bcm_time.c
BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/gpio/lib/gpio.c
BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/gpio/lib/gpio_gio_v1.c
BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/pinmux/lib/pinmux.c
BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/pinmux/os/none/pinmux_osil.c
BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/mcu/os/none/mcu_osil.c
BRCM_SRC += $(BRCM_SDK_ROOT)/drivers/watchdog/os/none/wdt_osil.c

BRCM_INC += $(BRCM_SDK_ROOT)/drivers/pinmux/inc
BRCM_INC += $(BRCM_SDK_ROOT)/drivers/pinmux/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/drivers/gpio/inc
BRCM_INC += $(BRCM_SDK_ROOT)/drivers/gpio/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/system/common/inc
BRCM_INC += $(BRCM_SDK_ROOT)/init/bcm8957x/inc
BRCM_INC += $(BRCM_SDK_ROOT)/init/bcm8957x/chip
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc


BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/transceiver/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/ipc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/transceiver/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/transceiver/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/system/common/inc
BRCM_INC += $(BRCM_SDK_ROOT)/architecture/queue/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/rpc/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/ethsrv/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/nif/inc

BRCM_COMP_LIB_CFLAGS += -DENABLE_ETHER_SEND_SYNC
BRCM_COMP_LIB_CFLAGS += -DETHER_TIMEHWIDMAX=1UL -DETHER_HW_ID_MAX=1UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXPKTSTARTALIGN=4UL
BRCM_COMP_LIB_CFLAGS += -DETHER_MTU=640UL
BRCM_COMP_LIB_CFLAGS += -DETHER_RXBUFFCOUNT=16UL
BRCM_COMP_LIB_CFLAGS += -DETHER_TXCH0BUFFCOUNT=1UL
BRCM_COMP_LIB_CFLAGS += -DENABLE_ETH_AMAC
BRCM_COMP_LIB_CFLAGS += -DAMAC_DMA_MEM_VIEW_BASE=0x10000
BRCM_COMP_LIB_CFLAGS += -DETHER_COPY_RX_DESC
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/lib/bcm8957x/ether_bcm8957x_mdio_cfg.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/lib/ethernet.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/lib/amac.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/drivers/controller/lib/eth_cntlr_buf.c

BRCM_SRC += $(BRCM_SDK_ROOT)/init/bcm8957x/chip/common/rom_config.c
BRCM_INC += $(BRCM_SDK_ROOT)/system/console/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/init/bcm8957x/chip/common
BRCM_INC += $(BRCM_SDK_ROOT)/init/bcm8957x/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/drivers/transceiver/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/nif/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/inc/osil
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/os/platform/bcm8957x
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/tftp/inc
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/ethsrv/inc/
BRCM_INC += $(BRCM_SDK_ROOT)/ethernet/common/nif/os/platform/bcm8957x

# ETHSRV file
BRCM_COMP_APP_OPT += ENABLE_BCM8957X_ROM
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/common/nif/os/platform/bcm8957x/nif_bcm8957x_cfg_rom.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/os/platform/bcm8957x/inet_cfg_rom.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/os/none/inet_osil_rom.c

# NIF Module files
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/common/nif/os/common/nif.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/common/nif/os/common/nif_switch.c
# INET Module files
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/api.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/udp.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/ip.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/arp.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/icmp.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/netif.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/lib/dhcp.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/os/common/ethif.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/os/common/inet_system.c
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/inet/os/platform/bcm8957x/inet_switch_rom.c
# TFTP Module files
BRCM_SRC += $(BRCM_SDK_ROOT)/ethernet/tcp_ip/tftp/lib/tftp.c

# Size of the ARP cache
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_ENTRIES_ARPCACHE=\(5U\)
# Lifetime of a resolved ARP address in the cache in seconds
BRCM_COMP_LIB_CFLAGS += -DINET_ARP_COMPLETE_ENTRY_LIFETIME=\(7200UL\)
# Max number of fragments we expect an incoming datagram to consist 2^0 = 1
BRCM_COMP_LIB_CFLAGS += -DINET_LOG2_MAX_REASS_FRAGS=\(0U\)
# Maximum size of reassembled datagram that we expect
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_SIZE=\(700U\)
# Maximum duration in micro seconds to wait before freeing a reassembly buffer
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_CLIENT_READ_TIMEOUT=\(1000UL\)
# Interval in seconds after which an ARP request needs to be resent
BRCM_COMP_LIB_CFLAGS += -DINET_ARP_RETRY_PERIOD=\(1UL\)
# Maximum duration in micro seconds to wait before freeing a reassembly buffer
BRCM_COMP_LIB_CFLAGS += -DINET_MAX_REASS_BUF_TIMEOUT=\(50000UL\)
BRCM_COMP_LIB_CFLAGS += -DDHCP_MAX_OFFERS_CACHED=\(1UL\)

BRCM_COMP_LIB_CFLAGS += -DBCM8957X_DEFAULT_IP_ADDR=\(0xC0A80A00UL\)
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_NETMASK_VALUE=\(24U\)
BRCM_COMP_LIB_CFLAGS += -DBCM8957X_DEFAULT_VLAN=\(4094U\)

BRCM_ASM_SRC += $(BRCM_SDK_ROOT)/init/bcm8957x/chip/common/rom_startup.S

BRCM_SRC += $(BRCM_SDK_ROOT)/security/drivers/spum/os/none/spum_osil_none.c
BRCM_SRC += $(BRCM_SDK_ROOT)/security/drivers/secure_heap/os/none/secure_heap_osil_none.c

BRCM_COMP_DOC_SRC += doc/rom_qsg_page.c
BRCM_COMP_DOC_SRC += doc/rom_references_page.c
BRCM_COMP_DOC_SRC += doc/rom_coverage_page.c
BRCM_COMP_DOC_SRC += doc/images/bcm8957x_palladium_dwnld_complete.jpg
BRCM_COMP_DOC_SRC += doc/images/bcm8957x_palladium_dwnld_progress.jpg
BRCM_COMP_DOC_SRC += doc/images/bcm8957x_palladium_fsdb_ui.jpg
BRCM_COMP_DOC_SRC += doc/images/bcm8957x_palladium_fsdb_ui_new.jpg
BRCM_COMP_DOC_SRC += doc/images/bcm8957x_palladium_tera_term.jpg
