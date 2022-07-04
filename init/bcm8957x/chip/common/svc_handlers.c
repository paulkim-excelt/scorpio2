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
    @defgroup grp_svc_handler_impl SVC Handler Implementation
    @ingroup grp_svc

    @addtogroup grp_svc_handler_impl
    @{

    @file svc_handlers.c

    @version 0.1 Initial version
*/

/* include files */
#include <stdlib.h>
#include <svc.h>
#include <osil/mcu_osil.h>

#ifdef ENABLE_UART_PL011
#include <uart_osil.h>
#endif

#if defined(ENABLE_FLASH)
#include <osil/flash_osil.h>
#endif  /* ENABLE_FLASH */

#if defined(ENABLE_GPIO_GIO_V1)
#include <osil/gpio_osil.h>
#include <osil/pinmux_osil.h>
#endif  /* ENABLE_GPIO_GIO_V1 */

#if defined(ENABLE_UART_CONSOLE)
#include <osil/uconsole_osil.h>
#endif  /* ENABLE_UART_CONSOLE */

#if defined(ENABLE_ETH)
#include <osil/eth_osil.h>
#if defined(ENABLE_ETHXCVRM)
#include <osil/ethxcvr_osil.h>
#endif  /* ENABLE_ETHXCVRM */
#endif  /* ENABLE_ETH */

#if defined(ENABLE_ETH_SWITCH)
#include <osil/eth_switch_osil.h>
#endif

#if defined(ENABLE_MSG_QUEUE)
#include <osil/msg_queue_osil.h>
#endif  /* ENABLE_MSG_QUEUE */

#if defined(ENABLE_ULOG)
#include <osil/log_osil.h>
#endif  /* ENABLE_ULOG */

#if defined(ENABLE_TIMER_SP804)
#include <osil/tim_osil.h>
#endif  /* ENABLE_TIMER_SP804 */
#include "ee_internal.h"

#if defined(ENABLE_SPI_PL022)
#include <osil/spi_osil.h>
#endif  /* ENABLE_SPI_PL022 */

#if defined(ENABLE_IPC)
#include <osil/ipc_osil.h>
#endif

#ifdef ENABLE_DBGMEM
#include <osil/dbgmem_osil.h>
#endif
#if defined(ENABLE_OTP)
#include <osil/otp_osil.h>
#endif /* ENABLE_OTP */

#include <osil/bcm_osil_svc.h>
#include <osil/cache_osil.h>

#if defined(ENABLE_WATCHDOG_SP805)
#include <osil/wdt_osil.h>
#endif  /* ENABLE_WATCHDOG_SP805 */

#if defined(ENABLE_PKA)
#include <osil/pka_osil.h>
#endif

#if defined(ENABLE_SPUM)
#include <osil/spum_osil.h>
#endif

#if defined(ENABLE_RAND)
#include <osil/rand_osil.h>
#endif

#if defined(ENABLE_SECHEAP)
#include <osil/secure_heap_osil.h>
#endif

#if defined(ENABLE_VTMON)
#include <osil/vtmon_osil.h>
#endif  /* ENABLE_VTMON */

#if defined(ENABLE_PATCH)
#include <osil/pchdrv_osil.h>
#endif

#if defined(ENABLE_MACSEC)
#include <osil/macsec_osil.h>
#endif

/**
    @name BCM8957X SVC Handelr Design IDs
    @{
    @brief Design IDs for BCM8957X SVC Handler
*/
#define BRCM_SWDSGN_SVC_DEFAULT_HANDLER_PROC  (0xB201U)   /**< @brief #SVC_DefaultHandler  */
#define BRCM_SWDSGN_SVC_HANDLER_TABLE_GLOBAL  (0xB202U)   /**< @brief #SVC_HandlerFuncTbl  */
/** @} */

/**
    @trace #BRCM_SWARCH_SVC_HANDLER_TYPE
    @trace #BRCM_SWARCH_SVC_HANDLER_PROC
    @trace #BRCM_SWREQ_SVC_REQUEST_BCM8957X
*/
static void SVC_DefaultHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    (void)aMagicID;
    (void)aCmd;
    (void)aSysIO;
}

/**
    @trace #BRCM_SWARCH_SVC_HANDLER_TYPE
    @trace #BRCM_SWARCH_SVC_HANDLER_PROC
    @trace #BRCM_SWREQ_SVC_REQUEST_BCM8957X
*/
const SVC_ReqHandlerType SVC_HandlerFuncTbl[(SVC_CMD_END - SVC_CMD_START) + 1UL] = {
    MCU_SysCmdHandler,      /* 0x80 */
#if defined(ENABLE_TIMER_SP804)
    TIM_SysCmdHandler,          /* 0x81 */
#else
    SVC_DefaultHandler,          /* 0x81 */
#endif
    SVC_DefaultHandler,          /* 0x82 */
#if defined(ENABLE_UART_PL011)
    UART_SysCmdHandler,         /* 0x83 */
#else
    SVC_DefaultHandler,          /* 0x83 */
#endif
    SVC_DefaultHandler,          /* 0x84 */
#if defined(ENABLE_SPI_PL022)
    SPI_SysCmdHandler,          /* 0x85 */
#else
    SVC_DefaultHandler,          /* 0x85 */
#endif
#if defined(ENABLE_FLASH)
    FLASH_SysCmdHandler,        /* 0x86 */
#else
    SVC_DefaultHandler,          /* 0x86 */
#endif
#if defined(ENABLE_WATCHDOG_SP805)
    WDT_SysCmdHandler,          /* 0x87 */
#else
    SVC_DefaultHandler,          /* 0x87 */
#endif
#if defined(ENABLE_GPIO_GIO_V1)
    GPIO_SysCmdHandler,         /* 0x88 */
    PINMUX_SysCmdHandler,       /* 0x89 */
#else
    SVC_DefaultHandler,          /* 0x88 */
    SVC_DefaultHandler,          /* 0x89 */
#endif
    SVC_DefaultHandler,          /* 0x8A */
    SVC_DefaultHandler,          /* 0x8B */
    SVC_DefaultHandler,          /* 0x8C */
    SVC_DefaultHandler,          /* 0x8D */
#if defined(ENABLE_OTP)
    OTP_SysCmdHandler,          /* 0x8E */
#else
    SVC_DefaultHandler,          /* 0x8E */
#endif
#if defined(ENABLE_VTMON)
    VTMON_SysCmdHandler,        /* 0x8F */
#else
    SVC_DefaultHandler,         /* 0x8F */
#endif
#if defined(ENABLE_IPC)
    IPC_SysCmdHandler,          /* 0x90 */
#else
    SVC_DefaultHandler,          /* 0x90 */
#endif
#if defined(ENABLE_PATCH)
    PATCH_CmdHandler,           /* 0x91 */
#else
    SVC_DefaultHandler,          /* 0x91 */
#endif
    SVC_DefaultHandler,          /* 0x92 */
    SVC_DefaultHandler,          /* 0x93 */
    SVC_DefaultHandler,          /* 0x94 */
    SVC_DefaultHandler,          /* 0x95 */
    SVC_DefaultHandler,          /* 0x96 */
    SVC_DefaultHandler,          /* 0x97 */
    SVC_DefaultHandler,          /* 0x98 */
    SVC_DefaultHandler,          /* 0x99 */
    SVC_DefaultHandler,          /* 0x9A */
    SVC_DefaultHandler,          /* 0x9B */
    SVC_DefaultHandler,          /* 0x9C */
    SVC_DefaultHandler,          /* 0x9D */
    SVC_DefaultHandler,          /* 0x9E */
    SVC_DefaultHandler,          /* 0x9F */
    SVC_DefaultHandler,          /* 0xA0 */
    SVC_DefaultHandler,          /* 0xA1 */
    SVC_DefaultHandler,          /* 0xA2 */
    SVC_DefaultHandler,          /* 0xA3 */
    SVC_DefaultHandler,          /* 0xA4 */
    SVC_DefaultHandler,          /* 0xA5 */
    SVC_DefaultHandler,          /* 0xA6 */
    SVC_DefaultHandler,          /* 0xA7 */
    SVC_DefaultHandler,          /* 0xA8 */
    SVC_DefaultHandler,          /* 0xA9 */
    SVC_DefaultHandler,          /* 0xAA */
    SVC_DefaultHandler,          /* 0xAB */
    SVC_DefaultHandler,          /* 0xAC */
    SVC_DefaultHandler,          /* 0xAD */
    SVC_DefaultHandler,          /* 0xAE */
    SVC_DefaultHandler,          /* 0xAF */
#if defined(ENABLE_ETH)
    ETHER_SysCmdHandler,        /* 0xB0 */
#else
    SVC_DefaultHandler,          /* 0xB0 */
#endif
    SVC_DefaultHandler,          /* 0xB1 */
    SVC_DefaultHandler,          /* 0xB2 */
    SVC_DefaultHandler,          /* 0xB3 */
#if defined(ENABLE_ETH_SWITCH)
    ETHSWT_SysCmdHandler,        /* 0xB4 */
#else
    SVC_DefaultHandler,          /* 0xB4 */
#endif
#if defined(ENABLE_ETH) && defined(ENABLE_ETHXCVRM)
    ETHXCVR_SysCmdHandler,      /* 0xB5 */
#else
    SVC_DefaultHandler,          /* 0xB5 */
#endif
#if defined(ENABLE_ETH_TIME)
    ETHER_TimeSysCmdHandler,    /* 0xB6 */
#else
    SVC_DefaultHandler,          /* 0xB6 */
#endif
    SVC_DefaultHandler,          /* 0xB7 */
    SVC_DefaultHandler,          /* 0xB8 */
    SVC_DefaultHandler,          /* 0xB9 */
    SVC_DefaultHandler,          /* 0xBA */
    SVC_DefaultHandler,          /* 0xBB */
    SVC_DefaultHandler,          /* 0xBC */
    SVC_DefaultHandler,          /* 0xBD */
    SVC_DefaultHandler,          /* 0xBE */
    SVC_DefaultHandler,          /* 0xBF */
#if defined(ENABLE_MSG_QUEUE)
    MSGQ_CmdHandler,            /* 0xC0 */
#else
    SVC_DefaultHandler,          /* 0xC0 */
#endif  /* ENABLE_MSG_QUEUE */
#if defined(ENABLE_UART_CONSOLE)
    UCONSOLE_SysCmdHandler,      /* 0xC1 */
#else
    SVC_DefaultHandler,           /* 0xC1 */
#endif /*ENABLE_UART_CONSOLE */
    SVC_DefaultHandler,          /* 0xC2 */
#ifdef ENABLE_DBGMEM
    DBGMEM_SysCmdHandler,       /* 0xC3 */
#else
    SVC_DefaultHandler,          /* 0xC3 */
#endif
    BCM_OsSysCmdHandler,        /* 0xC4 */
#if defined(ENABLE_DCACHE_OPS)
    DCACHE_SysCmdHandler,       /* 0xC5 */
#else
    SVC_DefaultHandler,          /* 0xC5 */
#endif
    SVC_DefaultHandler,          /* 0xC6 */
    SVC_DefaultHandler,          /* 0xC7 */
    SVC_DefaultHandler,          /* 0xC8 */
    SVC_DefaultHandler,          /* 0xC9 */
    SVC_DefaultHandler,          /* 0xCA */
    SVC_DefaultHandler,          /* 0xCB */
    SVC_DefaultHandler,          /* 0xCC */
    SVC_DefaultHandler,          /* 0xCD */
    SVC_DefaultHandler,          /* 0xCE */
    SVC_DefaultHandler,          /* 0xCF */
#if defined(ENABLE_SECHEAP)
    SECHEAP_SysCmdHandler,       /* 0xD0 */
#else
    SVC_DefaultHandler,          /* 0xD0 */
#endif
#if defined(ENABLE_PKA)
    PKA_SysCmdHandler,           /* 0xD1 */
#else
    SVC_DefaultHandler,          /* 0xD1 */
#endif
#if defined(ENABLE_SPUM)
    SPUM_SysCmdHandler,          /* 0xD2 */
#else
    SVC_DefaultHandler,          /* 0xD2 */
#endif
#if defined(ENABLE_RAND)
    RAND_SysCmdHandler,          /* 0xD3 */
#else
    SVC_DefaultHandler,          /* 0xD3 */
#endif
#if defined(ENABLE_MACSEC)
    MACSEC_SysCmdHandler,        /* 0xD4 */
#else
    SVC_DefaultHandler,          /* 0xD4 */
#endif
    SVC_DefaultHandler,          /* 0xD5 */
    SVC_DefaultHandler,          /* 0xD6 */
    SVC_DefaultHandler,          /* 0xD7 */
    SVC_DefaultHandler,          /* 0xD8 */
    SVC_DefaultHandler,          /* 0xD9 */
    SVC_DefaultHandler,          /* 0xDA */
    SVC_DefaultHandler,          /* 0xDB */
    SVC_DefaultHandler,          /* 0xDC */
    SVC_DefaultHandler,          /* 0xDD */
    SVC_DefaultHandler,          /* 0xDE */
#ifdef ENABLE_TEST_SVC
    SVC_TestSvcHandler,          /* 0xDF */
#else
    SVC_DefaultHandler,          /* 0xDF */
#endif
};



/** @} */
