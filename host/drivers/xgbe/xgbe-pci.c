/*
 * Broadcom BCM8956X / BCM8957X / BCM8989X 10Gb Ethernet driver
 *
 * Copyright (c) 2021 Broadcom. The term "Broadcom" refers solely to the
 * Broadcom Inc. subsidiary that distributes the Licensed Product, as defined
 * below.
 *
 * The following copyright statements and licenses apply to open source software
 * ("OSS") distributed with the BCM8956X / BCM8957X / BCM8989X product (the "Licensed Product").
 * The Licensed Product does not necessarily use all the OSS referred to below and
 * may also only use portions of a given OSS component.
 *
 * To the extent required under an applicable open source license, Broadcom
 * will make source code available for applicable OSS upon request. Please send
 * an inquiry to opensource@broadcom.com including your name, address, the
 * product name and version, operating system, and the place of purchase.
 *
 * To the extent the Licensed Product includes OSS, the OSS is typically not
 * owned by Broadcom. THE OSS IS PROVIDED AS IS WITHOUT WARRANTY OR CONDITION
 * OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 * To the full extent permitted under applicable law, Broadcom disclaims all
 * warranties and liability arising from or related to any use of the OSS.
 *
 * To the extent the Licensed Product includes OSS licensed under the GNU
 * General Public License ("GPL") or the GNU Lesser General Public License
 * ("LGPL"), the use, copying, distribution and modification of the GPL OSS or
 * LGPL OSS is governed, respectively, by the GPL or LGPL.  A copy of the GPL
 * or LGPL license may be found with the applicable OSS.  Additionally, a copy
 * of the GPL License or LGPL License can be found at
 * https://www.gnu.org/licenses or obtained by writing to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
 *
 * This file is available to you under your choice of the following two
 * licenses:
 *
 * License 1: GPLv2 License
 *
 * Copyright (c) 2021 Broadcom
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation version 2.
 *
 * This program is distributed "as is" WITHOUT ANY WARRANTY of any
 * kind, whether express or implied; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * License 2: Modified BSD License
 *
 * Copyright (c) 2021 Broadcom
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of Advanced Micro Devices, Inc. nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * AMD 10Gb Ethernet driver
 *
 * This file is available to you under your choice of the following two
 * licenses:
 *
 * License 1: GPLv2
 *
 * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
 *
 * This file is free software; you may copy, redistribute and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or (at
 * your option) any later version.
 *
 * This file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * This file incorporates work covered by the following copyright and
 * permission notice:
 *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
 *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
 *     Inc. unless otherwise expressly agreed to in writing between Synopsys
 *     and you.
 *
 *     The Software IS NOT an item of Licensed Software or Licensed Product
 *     under any End User Software License Agreement or Agreement for Licensed
 *     Product with Synopsys or any supplement thereto.  Permission is hereby
 *     granted, free of charge, to any person obtaining a copy of this software
 *     annotated with this license and the Software, to deal in the Software
 *     without restriction, including without limitation the rights to use,
 *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 *     of the Software, and to permit persons to whom the Software is furnished
 *     to do so, subject to the following conditions:
 *
 *     The above copyright notice and this permission notice shall be included
 *     in all copies or substantial portions of the Software.
 *
 *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
 *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
 *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *     THE POSSIBILITY OF SUCH DAMAGE.
 *
 *
 * License 2: Modified BSD
 *
 * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of Advanced Micro Devices, Inc. nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * This file incorporates work covered by the following copyright and
 * permission notice:
 *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
 *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
 *     Inc. unless otherwise expressly agreed to in writing between Synopsys
 *     and you.
 *
 *     The Software IS NOT an item of Licensed Software or Licensed Product
 *     under any End User Software License Agreement or Agreement for Licensed
 *     Product with Synopsys or any supplement thereto.  Permission is hereby
 *     granted, free of charge, to any person obtaining a copy of this software
 *     annotated with this license and the Software, to deal in the Software
 *     without restriction, including without limitation the rights to use,
 *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 *     of the Software, and to permit persons to whom the Software is furnished
 *     to do so, subject to the following conditions:
 *
 *     The above copyright notice and this permission notice shall be included
 *     in all copies or substantial portions of the Software.
 *
 *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
 *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
 *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *     THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <linux/module.h>
#include <linux/device.h>
#include <linux/pci.h>
#include <linux/log2.h>
#include <linux/version.h>

#include <linux/fs.h>
#include <linux/miscdevice.h>
#include <linux/moduleparam.h>

#include "xgbe.h"
#include "xgbe-common.h"

#include "xgbe-ioctl.h"

#if XGBE_SRIOV_PF
#ifdef CONFIG_PCI_IOV
unsigned int max_vfs = XGBE_MAX_VFS_DEFAULT;
module_param(max_vfs, uint, 0);
MODULE_PARM_DESC(max_vfs,
        "Maximum number of virtual functions to allocate per physical function - default is zero and maximum value is 63. (Deprecated)");
#endif /* CONFIG_PCI_IOV */
#endif

#define A0_DTCM_IPC_START       (0x2003C000)
#define A0_DTCM_IPC_END         (0x2003FFFF)
#define A0_PCIE_DTCM_OFFSET     (0x80000)
#define B0_DTCM_IPC_START       (0x2007C000)
#define B0_DTCM_IPC_END         (0x2007FFFF)
#define B0_PCIE_DTCM_OFFSET     (0x00100000)

#define IND_PCIE_START          (0x4B280000)
#define IND_PCIE_END            (0x4B28000F)
#define IND_DEV_BASE            (IND_PCIE_START)
#define PCIE_IND_OFFSET         (0x003FFF00)

#define DTCM_TOP_BRIDGE_START   (0x4A800000)
#define DTCM_TOP_BRIDGE_END     (0x4AA00000)

#define PCI_BAR1_ITCM_BASE      (0x20000000)
#define PCI_BAR1_DTCM_DEV_BASE  (0x20000000)
#define PCI_BAR1_BASE           (0x20000000)

static struct xgbe_prv_data *gPrivData;

#ifdef DEBUG
#define DBG_LOG    printk
#else
#define DBG_LOG
#endif

static int xgbe_pci_open(struct inode *inode, struct file *file)
{
    printk("%s: Device Opened.\n", __func__);
    return nonseekable_open(inode, file);
}

static int xgbe_pci_release(struct inode *inode, struct file *file)
{
    printk("%s:Device closed.\n", __func__);
    return 0;
}

static long xgbe_pci_ioctl(struct file *file, unsigned int cmd, unsigned long ioctl_arg)
{
    int err = 0;
    struct xgbe_ioctlcmd *u_iocmd;
    struct xgbe_ioctlcmd piocmd;
    struct xgbe_ioctlcmd *iocmd;
    struct pci_dev *pdev;
    uint32_t base;
    uint32_t offset;
    uint32_t val;
    int dev_mem = 0;
    uint32_t reg_read32 = 0x0UL;

    if (NULL == gPrivData) {
        err = EINVAL;
        goto err_exit;
    }
    pdev = gPrivData->pcidev;

    if ((XGBE_IOCTL_RDMEM != cmd) && (XGBE_IOCTL_WRMEM != cmd)) {
        err = EINVAL;
        goto err_exit;
    }

    u_iocmd = (struct xgbe_ioctlcmd *)ioctl_arg;
    copy_from_user(&piocmd, u_iocmd, sizeof(struct xgbe_ioctlcmd));
    iocmd = &piocmd;

    if(BCM8956X_A0_PF_ID == gPrivData->vdata->version_id) {
        if ((iocmd->addr >= A0_DTCM_IPC_START) && (iocmd->addr < A0_DTCM_IPC_END)) {
            base = PCI_BAR1_ITCM_BASE;
            offset = (iocmd->addr - PCI_BAR1_DTCM_DEV_BASE) + A0_PCIE_DTCM_OFFSET;
        } else if ((iocmd->addr >= DTCM_TOP_BRIDGE_START) && (iocmd->addr < DTCM_TOP_BRIDGE_END)) {
            base = 0x22000000;
            offset = iocmd->addr - 0x4A000000;
            offset = (offset & 0xFFFF0000) + (offset & 0xFFFF) * 2;
            dev_mem = 1;
        } else {
            err = EINVAL;
            goto err_exit;
        }
        pci_write_config_dword(pdev, 0x84, base);
        err = pci_read_config_dword(pdev, 0x84, &base);
        if (err)
            goto err_exit;

        switch (cmd) {
            case XGBE_IOCTL_RDMEM:
                switch (iocmd->width) {
                case 32:
                    *((uint32_t *)iocmd->data)= ioread32(gPrivData->xpcs_regs + offset);
                    break;
                case 16:
                    if (dev_mem) {
                        val = ioread32(gPrivData->xpcs_regs + offset);
                        if (iocmd->addr & 0x3) {
                            *((uint16_t *)iocmd->data)= (val >> 16) & 0xFFFF;
                        } else {
                            *((uint16_t *)iocmd->data) = val & 0xFFFF;
                        }
                    } else {
                        *((uint16_t *)iocmd->data) = ioread16(gPrivData->xpcs_regs + offset);
                    }
                    break;
                default:
                    err = EINVAL;
                    break;
                }
                break;
            case XGBE_IOCTL_WRMEM:
                switch (iocmd->width) {
                case 32:
                    iowrite32(*((uint32_t *)iocmd->data), gPrivData->xpcs_regs + offset);
                    break;
                case 16:
                    if (dev_mem) {
                        if (iocmd->addr & 0x3) {
                            val = ((*((uint16_t *)iocmd->data)) & 0xFFFF) << 16;
                        } else {
                            val = (*((uint16_t *)iocmd->data)) & 0xFFFF;
                        }
                        iowrite32(val, gPrivData->xpcs_regs + offset);
                    } else {
                        iowrite16((*((uint16_t *)iocmd->data)), gPrivData->xpcs_regs + offset);
                    }
                    break;
                default:
                    err = EINVAL;
                    break;
                }
                break;
            default:
                err = EINVAL;
                break;
        }
    }
    else if ((BCM8956X_PF_ID == gPrivData->vdata->version_id) ||
              (BCM8957X_PF_ID == gPrivData->vdata->version_id)) {

        if (32 != iocmd->width) {
            err = EINVAL;
            goto err_exit;
        }

        if ((iocmd->addr >= B0_DTCM_IPC_START) && (iocmd->addr < B0_DTCM_IPC_END)) {
            offset = (iocmd->addr - PCI_BAR1_DTCM_DEV_BASE) + B0_PCIE_DTCM_OFFSET;
        } else if ((iocmd->addr >= IND_PCIE_START) && (iocmd->addr < IND_PCIE_END)) {
            offset = (iocmd->addr - IND_DEV_BASE) + PCIE_IND_OFFSET;
        } else {
            err = EINVAL;
            goto err_exit;
        }

        switch (cmd) {
        case XGBE_IOCTL_RDMEM:
            reg_read32 = ioread32(gPrivData->xpcs_regs + offset);
            break;

        case XGBE_IOCTL_WRMEM:
            copy_from_user(&reg_read32, iocmd->data, sizeof(uint32_t));
            iowrite32(reg_read32, gPrivData->xpcs_regs + offset);
            break;
        default:
            err = EINVAL;
            break;
        }
        copy_to_user(iocmd->data, &reg_read32, sizeof(uint32_t));
    }
    else
        printk("Invalid version found during IOCTL execution\n");

err_exit:
    return err;
}

static const struct file_operations xgbe_file_ops = {
    .owner = THIS_MODULE,
    .unlocked_ioctl = xgbe_pci_ioctl,
    .open = xgbe_pci_open,
    .release = xgbe_pci_release,
    .llseek = noop_llseek,
};

static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
{
    unsigned int vector_count;
    unsigned int i, j = 0;
    int ret;

#if XGBE_SRIOV_VF
    int rx_reg = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX_VF;
    int tx_reg = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX_VF;
#endif

    vector_count = XGBE_MSI_BASE_COUNT;
    vector_count += max(pdata->rx_ring_count, pdata->tx_ring_count);

    ret = pci_alloc_irq_vectors(pdata->pcidev, XGBE_MSI_MIN_COUNT,
            vector_count, PCI_IRQ_MSI | PCI_IRQ_MSIX);

    if (ret < 0) {
        dev_info(pdata->dev, "multi MSI/MSI-X enablement failed\n");
        return ret;
    } else {
        dev_info(pdata->dev, "multi MSI/MSI-X enablement passed\n");
    }

    pdata->isr_as_tasklet = 1;
    pdata->irq_count = ret;

#if XGBE_SRIOV_PF
    pdata->dev_irq = pci_irq_vector(pdata->pcidev, 0);
    pdata->dev_2_host_irq = pci_irq_vector(pdata->pcidev, 1);
    for (i = 0; i < max_vfs; i++)
        pdata->vf_mbox_irq[i] = pci_irq_vector(pdata->pcidev, i + (XGBE_MSI_BASE_COUNT - SRIOV_MAX_VF));

    if (i)
        mbox_request_irqs(pdata);

    for (i = XGBE_MSI_BASE_COUNT, j = 0; i < ret; i++, j++)
        pdata->channel_irq[j] = pci_irq_vector(pdata->pcidev, i);
#endif

#if XGBE_SRIOV_VF
    pdata->mbx_irq = pci_irq_vector(pdata->pcidev, 0);
    MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_MB_PF0_to_VF, 0x00);

    TEST_PRNT("Total MSI num = %d\n", ret);
    TEST_PRNT("mbx_irq = %d\n", pdata->mbx_irq);

    if (ret-1 == pdata->tx_ring_count)  {
        for (i = XGBE_MSI_BASE_COUNT, j = 0; i < ret; i++, j++) {
            pdata->channel_irq[j] =
                    pci_irq_vector(pdata->pcidev, i);
            /*assiging vector numbers and storing in reg */
            MISC_IOWRITE(pdata, rx_reg, i);
            rx_reg += MSIC_INC;
            MISC_IOWRITE(pdata, tx_reg, i);
            tx_reg += MSIC_INC;
            TEST_PRNT("channel_num = %d\n vector_num = %d\n",
                    j, pdata->channel_irq[j]);
        }
    }
#endif

    pdata->channel_irq_count = j;
    pdata->per_channel_irq = 1;
    pdata->channel_irq_mode = XGBE_IRQ_MODE_EDGE;
    if (netif_msg_probe(pdata))
        dev_dbg(pdata->dev, "multi %s interrupts enabled\n",
                pdata->pcidev->msix_enabled ? "MSI-X" : "MSI");

    return 0;
}

static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
{
    int ret;

    ret = xgbe_config_multi_msi(pdata);
    if (!ret)
        goto out;

    ret = pci_alloc_irq_vectors(pdata->pcidev, 1, 1,
            PCI_IRQ_LEGACY | PCI_IRQ_MSI);
    if (ret < 0) {
        dev_info(pdata->dev, "single IRQ enablement failed\n");
        return ret;
    }

    pdata->isr_as_tasklet = pdata->pcidev->msi_enabled ? 1 : 0;
    pdata->irq_count = 1;
    pdata->channel_irq_count = 1;

    pdata->dev_irq = pci_irq_vector(pdata->pcidev, 0);
    if (netif_msg_probe(pdata))
        dev_dbg(pdata->dev, "single %s interrupt enabled\n",
                pdata->pcidev->msi_enabled ?  "MSI" : "legacy");

out:
    if (netif_msg_probe(pdata)) {
        unsigned int i;
#if XGBE_SRIOV_PF
        dev_dbg(pdata->dev, " dev irq=%d\n", pdata->dev_irq);
#endif
#if XGBE_SRIOV_VF
        dev_dbg(pdata->dev, " mbx irq = %d\n", pdata->mbx_irq);
#endif
        for (i = 0; i < pdata->channel_irq_count; i++)
            dev_dbg(pdata->dev, " dma%u irq = %d\n", i, pdata->channel_irq[i]);
    }

    return 0;
}

static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
    struct device *dev = &pdev->dev;
    struct xgbe_prv_data *pdata;
    void __iomem * const *iomap_table;
    struct miscdevice *miscdev;
    int bar_mask;
    int ret;
    unsigned short device;

#if XGBE_SRIOV_PF
    int i;
    unsigned int num_pf_dma, num_vf_funs;
#endif

    pdata = xgbe_alloc_pdata(dev);
    if (IS_ERR(pdata)) {
        ret = PTR_ERR(pdata);
        goto err_alloc;
    }

    gPrivData = pdata;
    pdata->pcidev = pdev;
    pci_set_drvdata(pdev, pdata);

    /* Get the version data */
    pdata->vdata = (struct xgbe_version_data *)id->driver_data;

    pci_read_config_word(pdev, PCI_DEV_ID_OFFSET, &device);

    ret = pcim_enable_device(pdev);
    if (ret) {
        dev_err(dev, "pcim_enable_device failed\n");
        goto err_pci_enable;
    }

    /* Obtain the mmio areas for the device */
    bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);

#if XGBE_SRIOV_PF
    if (device == XGBE_PF_ID)
#endif
#if XGBE_SRIOV_VF
    if (device == XGBE_VF_ID)
#endif
    bar_mask &= XGMAC_BAR_MASK;

    ret = pcim_iomap_regions(pdev, bar_mask, XGBE_DRV_NAME);
    if (ret) {
        dev_err(dev, "pcim_iomap_regions failed\n");
        goto err_pci_enable;
    }

    iomap_table = pcim_iomap_table(pdev);
    if (!iomap_table) {
        dev_err(dev, "pcim_iomap_table failed\n");
        ret = -ENOMEM;
        goto err_pci_enable;
    }

    printk("%s: iomap addresses: BAR0: %p BAR1: %p\n",
            __func__, (uint32_t *)(iomap_table[XGBE_XGMAC_BAR]),
            (uint32_t *)(iomap_table[2]));

#if XGBE_SRIOV_PF
    /* Initialize Phy register base address */
    pdata->phy_regs = iomap_table[XGBE_PHY_BAR] + XGMAC_PHY_REGS_OFFSET;
#endif
    pdata->xgmac_regs = iomap_table[XGBE_XGMAC_BAR];
    pdata->misc_regs = pdata->xgmac_regs;
    pdata->mbox_regs = pdata->xgmac_regs + MBOX_REGS_OFFSET;

#if XGBE_SRIOV_PF
    pdata->eli_regs = pdata->xgmac_regs + XGMAC_ELI_REGS_OFFSET;
    pdata->xgmac_regs += XGMAC_REGS_OFFSET; /* XGMAC offset from BAR 0 */
    num_pf_dma = (MISC_IOREAD(pdata, XGMAC_MISC_FUNC_RESOURCES_PF0));

    /* Set the PCIBAR1Window */
    pci_write_config_dword(pdev, 0x84, PCI_BAR1_BASE);
    pdata->xpcs_regs = iomap_table[2];
    printk( "xgmac_reg base = %p\n", pdata->xpcs_regs);

    /* total number of virtual functions */
    num_vf_funs = ((MISC_IOREAD_BITS(pdata, XGMAC_PCIE_MISC_POWER_STATE,
                    NUM_FUNCTIONS)) - 1);
    pdata->xgmac_regs -= XGMAC_REGS_OFFSET; /* XGMAC offset from BAR 0 */

    /* Errorouting if max_vfs is greater than supported vfs */
    if (max_vfs > num_vf_funs) {
        dev_err(dev, "ERROR: INVALID Entry for VFs count %d is NOT SUPPORTED,\
                Provide valid VF count\n", max_vfs);
        dev_err(dev, "Maximum Number of VFs supported for current \
                configuration are %d\n", num_vf_funs);
        dev_err(dev, "MODULE IS NOT INSERTED PROPERLY, \
                PLEASE REMOVE AND REINSERT WITH VALID INPUT\n");
        ret  = -ERRVF;
        goto err_alloc;
    }

    if (device == XGBE_PF_ID) {
        pci_write_config_dword(pdev, MMC_RX64OCTETS_GB_LO, MMC_RX64OCTETS_GB_LO_VAL);
        pci_write_config_dword(pdev, MMC_RX64OCTETS_GB_HI, MMC_RX64OCTETS_GB_HI_VAL);

        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VAL);
        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VAL);

#if SRIOV_MAX_VF > 0
        MISC_IOWRITE(pdata, XGMAC_MISC_MAILBOX_INT_EN_PF0, SRIOV_VF_PF_INT_EN);

        for (i = 0; i < max_vfs; i++) {
            if (i == (SRIOV_MAX_VF - 1))
                MISC_IOWRITE(pdata, XGMAC_MISC_MSIX_VECTOR_MAP_MB_VF7, XGMAC_MAP_VF_MBOX_INT(i));
            else
                MISC_IOWRITE_OFFSET(pdata, XGMAC_MISC_MSIX_VECTOR_MAP_MB_BASE,
                        i * XGMAC_MISC_MSIX_VECTOR_MAP_OFFSET, XGMAC_MAP_VF_MBOX_INT(i));
        }
#endif

        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VAL);

        /* EP to Host DB intr 0 */
        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DOORBELL, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DOORBELL_VAL);
        /* EP to Host HW interrupts */
        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VAL);
        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VAL);

        for (i = 0; i < num_pf_dma; i++) {
            MISC_IOWRITE_OFFSET(pdata, XGMAC_MISC_MSIX_VECTOR_MAP_RX_PF0_BASE,
                    i * XGMAC_MISC_MSIX_VECTOR_MAP_OFFSET, XGBE_MSI_BASE_COUNT + i);
            MISC_IOWRITE_OFFSET(pdata, XGMAC_MISC_MSIX_VECTOR_MAP_TX_PF0_BASE,
                    i * XGMAC_MISC_MSIX_VECTOR_MAP_OFFSET, XGBE_MSI_BASE_COUNT + i);
        }
        /* switch enable */
        MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MII_CTRL, XGMAC_PCIE_MISC_MII_CTRL_VAL);
    }

    pdata->xgmac_regs = iomap_table[XGBE_XGMAC_BAR];
#endif

#if XGBE_SRIOV_VF
    MISC_IOWRITE(pdata, XGMAC_PCIE_MISC_MAILBOX_INT_EN_VF, 0x01);
#endif
    pdata->xgmac_regs += XGMAC_REGS_OFFSET; /* XGMAC offset from BAR 0 */

    if (!pdata->xgmac_regs) {
        dev_err(dev, "xgmac ioremap failed\n");
        ret = -ENOMEM;
        goto err_pci_enable;
    } else
        dev_err(dev, "xgmac ioremap done\n");


    pci_set_master(pdev);

    /* Clock settings */
    pdata->sysclk_rate = XGBE_V2_DMA_CLOCK_FREQ;
    pdata->ptpclk_rate = XGBE_V2_PTP_CLOCK_FREQ;

    /* Set the DMA coherency values */
    pdata->coherent = XGBE_DMA_PCI_COHERENT;
    pdata->arcr = XGBE_DMA_PCI_ARCR;
    pdata->awcr = XGBE_DMA_PCI_AWCR;
    pdata->awarcr = XGBE_DMA_PCI_AWARCR;

    /* Set the hardware channel and queue counts */
    xgbe_set_counts(pdata);

    /* Configure interrupt support */
    ret = xgbe_config_irqs(pdata);
    if (ret)
        goto err_pci_enable;

#if XGBE_SRIOV_PF
#ifdef CONFIG_PCI_IOV
    if (device == XGBE_PF_ID) {
        if (max_vfs > 0) {
            pci_sriov_set_totalvfs(pdev, XGBE_MAX_VFS_DRV_LIMIT);
            if (xgbe_enable_sriov(pdata, max_vfs))
                goto err_irq_vectors;
        }
    }
#endif
#endif

#if XGBE_SRIOV_VF
    if (device == XGBE_VF_ID) {
        pdata->mbx.request_irq(pdata);
        TEST_PRNT("mbx irq done\n");
    }

    pdata->mbx.get_hw_features(pdata);
#endif

    miscdev = &pdata->miscdev;
    miscdev->minor = 0;
    miscdev->name = XGBE_DRV_NAME;
    miscdev->nodename = "net/bcm";
    miscdev->fops = &xgbe_file_ops;
    ret = misc_register(miscdev);
    if (ret) {
        printk("%s: Can't register misc device\n", __func__);
        goto err_irq_vectors;
    }

    /* Configure the netdev resource */
    ret = xgbe_config_netdev(pdata);
    if (ret)
        goto err_irq_vectors;

#if XGBE_SRIOV_PF
#if ELI_ENABLE
    /* Initializing the ELI BLOCK */
    pdata->eli_if.eli_init(pdata);
#endif
#endif

    netdev_notice(pdata->netdev, "net device enabled\n");

    dev_err(dev, "xgbe_config_netdev done\n");

    return 0;

err_irq_vectors:
    pci_free_irq_vectors(pdata->pcidev);

err_pci_enable:
    xgbe_free_pdata(pdata);

err_alloc:
    dev_notice(dev, "net device not enabled\n");

    return ret;
}

#if XGBE_SRIOV_PF
static void dma_reset_tx(struct xgbe_prv_data *pdata, int ch_start_num, int no_of_ch)
{
    unsigned int i, total = ch_start_num + no_of_ch;
    unsigned int reg;
    unsigned int val;

    for(i = ch_start_num; i < total; i++){
        reg = DMA_CH_BASE + (i * DMA_CH_INC);
        val = XGMAC_IOREAD(pdata, (reg + DMA_CH_TCR));
        XGMAC_SET_BITS(val, DMA_CH_TCR, ST, 0);
        XGMAC_IOWRITE(pdata, (reg + DMA_CH_TCR), val);
    }
}

static void dma_reset_rx(struct xgbe_prv_data *pdata, int ch_start_num, int no_of_ch)
{
    unsigned int i, total = ch_start_num + no_of_ch;
    unsigned int timeout = XGBE_IO_TIMEOUT, stat = 0, reg;
    unsigned int val;

    for(i = ch_start_num; i < total; i++){
        reg = DMA_CH_BASE + (i * DMA_CH_INC);

        val = XGMAC_IOREAD(pdata, (reg + DMA_CH_RCR));
        XGMAC_SET_BITS(val, DMA_CH_RCR, SR, 0);
        XGMAC_IOWRITE(pdata, (reg + DMA_CH_RCR), val);

        val = XGMAC_IOREAD(pdata, (reg + DMA_CH_SR));
        stat = XGMAC_GET_BITS(val, DMA_CH_SR, RPS);
        while((!stat) && (timeout != 0)){
            timeout--;
            val = XGMAC_IOREAD(pdata, (reg + DMA_CH_SR));
            stat = XGMAC_GET_BITS(val, DMA_CH_SR, RPS);
        }
        if(timeout == 0)
            TEST_PRNT("Timed out waiting for Rx DMA channel %d to stop\n", i);

        val = XGMAC_IOREAD(pdata, (reg + DMA_CH_RCR));
        XGMAC_SET_BITS(val, DMA_CH_RCR, RPF, 1);
        XGMAC_IOWRITE(pdata, (reg + DMA_CH_RCR), val);

        timeout = XGBE_IO_TIMEOUT;
    }
}
#endif

static void rewrite_l3l4_registers(struct xgbe_prv_data *pdata, int register_number, int register_type, __be32 register_value)
{
    XGMAC_IOWRITE(pdata, MAC_L3L4WRR, register_value);
    XGMAC_IOWRITE_BITS(pdata, MAC_L3L4ACTL, IDDR_REGSEL, register_type);
    XGMAC_IOWRITE_BITS(pdata, MAC_L3L4ACTL, IDDR_NUM, register_number);
    // Set TT field to 0
    XGMAC_IOWRITE_BITS(pdata, MAC_L3L4ACTL, TT, 0);

    // Set XB field to 1
    XGMAC_IOWRITE_BITS(pdata, MAC_L3L4ACTL, XB, 1);

    while(XGMAC_IOREAD_BITS(pdata, MAC_L3L4ACTL, XB));
    printk("xb: %x\n", XGMAC_IOREAD_BITS(pdata, MAC_L3L4ACTL, XB));

}

static void xgbe_l3l4_filter_exit(struct xgbe_prv_data *pdata)
{
    struct hlist_node *node2;
    struct l3l4_filter *filter;

    spin_lock(&pdata->lock);

    hlist_for_each_entry_safe(filter, node2, &pdata->l3l4_filter_list, l3l4_node) {
        hlist_del(&filter->l3l4_node);
        kfree(filter);
    }
    pdata->l3l4_filter_count = 0;

    spin_unlock(&pdata->lock);
}

static void xgbe_pci_remove(struct pci_dev *pdev)
{
    struct xgbe_prv_data *pdata = pci_get_drvdata(pdev);
    unsigned short device;
    int j = 0;


#if XGBE_SRIOV_PF
    int i;
    struct vf_data_storage *vfinfo = NULL;

    if(pdata->vfinfo && (pdata->flags & XGBE_FLAG_SRIOV_ENABLED)){
        for(i = 0; i < pdata->num_vfs; i++){
            vfinfo = &pdata->vfinfo[i];
            if(!vfinfo)
                continue;
            if(!vfinfo->enabled)
                continue;
            dma_reset_tx(pdata, vfinfo->dma_channel_start_num, vfinfo->num_dma_channels);
            dma_reset_rx(pdata, vfinfo->dma_channel_start_num, vfinfo->num_dma_channels);
        }
    }

#ifdef CONFIG_PCI_IOV
    pci_read_config_word(pdev, 0x2, &device);
    if (device == XGBE_PF_ID) {
        mbox_free_irqs(pdata);
        xgbe_disable_sriov(pdata);
    }
#endif
    misc_deregister(&pdata->miscdev);
    xgbe_deconfig_netdev(pdata);

    pci_free_irq_vectors(pdata->pcidev);

    xgbe_free_pdata(pdata);
#endif

    /* Clearing all filters */
    for (j  = 7; j > -1; j--) {
        rewrite_l3l4_registers(pdata, j, MAC_L3_L4_CONTROL, 0);
        rewrite_l3l4_registers(pdata, j, MAC_L4_ADDRESS , 0);
        rewrite_l3l4_registers(pdata, j, MAC_L3_ADDRESS0    , 0);
        rewrite_l3l4_registers(pdata, j, MAC_L3_ADDRESS1    , 0);
    }
    /* Freeing Memory consumed if any */
    xgbe_l3l4_filter_exit(pdata);

    /* Disabling the register */
    XGMAC_IOWRITE_BITS(pdata, MAC_PFR, IPFE, 0);
#if XGBE_SRIOV_VF
    unsigned short temp, pos;
    unsigned char stat;
    unsigned int timeout = 1000;

    pci_read_config_word(pdev, 0x2, &device);

    pdata->mbx.vf_flr_notice(pdata);
    if (device == XGBE_VF_ID)
        pdata->mbx.free_irq(pdata);

    xgbe_deconfig_netdev(pdata);

    pci_free_irq_vectors(pdata->pcidev);

    pci_write_config_word(pdev, 0x4, 0);

    pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);

    pci_read_config_byte(pdev, (pos + 0xA), &stat);
    printk("stat %x\n", stat);

    while(((stat >> 5) & 0x1) && (timeout != 0)){
        pci_read_config_byte(pdev, (pos + 0xA), &stat);
        printk("stat %x\n", stat);
        timeout--;
    }

    /* FLR */
    msleep(1);
    pdata->mbx.clr_mac_addr(pdata);
    TEST_PRNT("Initiate FLR");
    pci_read_config_word(pdev, (pos + 0x8), &temp);
    temp |=  0x8000;
    pci_write_config_word(pdev, (pos + 0x8), temp);

    /* kernel sleep for 100ms */
    msleep(100);
    printk("here after msleep\n");

    printk("FLR Done\n");

    xgbe_free_pdata(pdata);
#endif
}

#ifdef CONFIG_PM
static int xgbe_pci_suspend(struct pci_dev *pdev, pm_message_t state)
{
    int ret = 0;

#if XGBE_SRIOV_PF
    struct xgbe_prv_data *pdata = pci_get_drvdata(pdev);
    struct net_device *netdev = pdata->netdev;

    if (netif_running(netdev))
        ret = xgbe_powerdown(netdev, XGMAC_DRIVER_CONTEXT);

    pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
    pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
    XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
#endif

    return ret;
}

static int xgbe_pci_resume(struct pci_dev *pdev)
{
    int ret = 0;

#if XGBE_SRIOV_PF
    struct xgbe_prv_data *pdata = pci_get_drvdata(pdev);
    struct net_device *netdev = pdata->netdev;

    /* Re-initializing registers reset by PERST */
    pci_write_config_dword(pdev, MMC_RX64OCTETS_GB_LO, MMC_RX64OCTETS_GB_LO_VAL);
    pci_write_config_dword(pdev, MMC_RX64OCTETS_GB_HI, MMC_RX64OCTETS_GB_HI_VAL);

    pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
    XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);

    if (netif_running(netdev)) {
        ret = xgbe_powerup(netdev, XGMAC_DRIVER_CONTEXT);

        /* Schedule a restart in case the link or phy state changed
         * while we were powered down.
         */
        schedule_work(&pdata->restart_work);
    }
#endif

    return ret;
}
#endif /* CONFIG_PM */

static const struct xgbe_version_data xgbe_v2a = {
#if XGBE_SRIOV_PF
    .init_function_ptrs_phy_impl = xgbe_init_function_ptrs_phy,
    .mmc_64bit              = 1,
    .tx_tstamp_workaround   = 1,
#endif
    .tx_desc_prefetch       = XGBE_TX_DECS_PREFETCH,
    .rx_desc_prefetch       = XGBE_RX_DECS_PREFETCH,
    .version_id             = BCM8957X_PF_ID,
};

static const struct xgbe_version_data xgbe_v2b = {
#if XGBE_SRIOV_PF
    .init_function_ptrs_phy_impl = xgbe_init_function_ptrs_phy,
    .mmc_64bit              = 1,
    .tx_tstamp_workaround   = 1,
#endif
    .tx_desc_prefetch       = XGBE_TX_DECS_PREFETCH,
    .rx_desc_prefetch       = XGBE_RX_DECS_PREFETCH,
    .version_id             = BCM8956X_PF_ID,
};

static const struct xgbe_version_data xgbe_v2c = {
#if XGBE_SRIOV_PF
    .init_function_ptrs_phy_impl = xgbe_init_function_ptrs_phy,
    .mmc_64bit              = 1,
    .tx_tstamp_workaround   = 1,
#endif
    .tx_desc_prefetch       = XGBE_TX_DECS_PREFETCH,
    .rx_desc_prefetch       = XGBE_RX_DECS_PREFETCH,
    .version_id             = BCM8956X_A0_PF_ID,
};

static const struct pci_device_id xgbe_pci_table[] = {
    { PCI_VDEVICE(BROADCOM, 0x4311),
        .driver_data = (kernel_ulong_t)&xgbe_v2a },
#if XGBE_SRIOV_PF
    { PCI_VDEVICE(BROADCOM, 0xa005),
        .driver_data = (kernel_ulong_t)&xgbe_v2c },
    { PCI_VDEVICE(BROADCOM, 0xa006),
        .driver_data = (kernel_ulong_t)&xgbe_v2b },
    { PCI_VDEVICE(BROADCOM, 0xa008),
        .driver_data = (kernel_ulong_t)&xgbe_v2a },
    { PCI_VDEVICE(BROADCOM, 0xa00b),
        .driver_data = (kernel_ulong_t)&xgbe_v2a },
    { PCI_VDEVICE(BROADCOM, 0x5f00),
#endif

#if XGBE_SRIOV_VF
    { PCI_VDEVICE(BROADCOM, 0xa007),
        .driver_data = (kernel_ulong_t)&xgbe_v2a },
    { PCI_VDEVICE(BROADCOM, 0xa009),
        .driver_data = (kernel_ulong_t)&xgbe_v2a },
    { PCI_VDEVICE(BROADCOM, 0xa00c),
#endif
        .driver_data = (kernel_ulong_t)&xgbe_v2a },
    /* Last entry must be zero */
    { 0, }
};
MODULE_DEVICE_TABLE(pci, xgbe_pci_table);

static struct pci_driver xgbe_driver = {
    .name = XGBE_DRV_NAME,
    .id_table = xgbe_pci_table,
    .probe = xgbe_pci_probe,
    .remove = xgbe_pci_remove,
#ifdef CONFIG_PM
    .suspend = xgbe_pci_suspend,
    .resume = xgbe_pci_resume,
#endif
};

int xgbe_pci_init(void)
{
    return pci_register_driver(&xgbe_driver);
}

void xgbe_pci_exit(void)
{
    pci_unregister_driver(&xgbe_driver);
}
