------------------------------------------
BCM8957X a0 ROM QT Readme
------------------------------------------
Date         : 2020/03/12
TAG          : wauto_dev_2020.11.3
------------------------------------------
ROM Hex File : out/rom/bcm8957x/bcm8957x_rom_a0.rom_0.hex
               out/rom/bcm8957x/bcm8957x_rom_a0.rom_1.hex
------------------------------------------
Other test files needed for each test case

BRCM_SWQTST_BCM8957X_ROM_BYPASS:
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_rom_bypass.hex
    Flash File : None

BRCM_SWQTST_BCM8957X_ROM_FAULT
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : None

BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_SEC_BOOT
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_secure_key0.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_TC10_AXI
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_tc10_axi.hex
    Flash File : None

BRCM_SWQTST_BCM8957X_ROM_MCM_COMM
    Master OTP File : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_mcm_comm_master.hex
    Slave OTP File  : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_mcm_comm_slave.hex
    Flash File      : None

BRCM_SWQTST_BCM8957X_ROM_BIN_MATCH
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : None
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_signed.raw

BRCM_SWQTST_BCM8957X_ROM_RAM_DUMP
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl_rdump/bcm8957x_rom_tbl_rdump_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_DTCM_ERR
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex

BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_CRC_ERR
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash_crc.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_IMG_HDR_ERROR
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash_imgh.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_BOOT_ENTRY_ADDR_ERROR
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash_ent.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_MAX_SIZE
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_full_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_NON_SEC_BOOT_SIZE_OV
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_ov_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_encrypt.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_encrypt_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_ENCRYPT_BOOT_ERR
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_encrypt.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_encrypt_flash_err.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_PT_COPY
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash_ptc.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_PT_COPY_ERR
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash_pterr.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_IPC_BL
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_pcie.hex
    Image File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_ipc_a0.img

BRCM_SWQTST_BCM8957X_ROM_IPC_SEC_BL
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_pcie_sec.hex
    Image File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_ipc_a0.img

BRCM_SWQTST_BCM8957X_ROM_FORCE_DL_TFTP
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_static_ip_otp.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_tftp_a0_signed.raw -> bcm-00000000-00089570-00000009-00123456.bin

BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_TIMEOUT
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_tftp_a0_signed.raw

BRCM_SWQTST_BCM8957X_ROM_TFTP_SEC_BL
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_secure_key0.hex
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_full_a0_signed.raw

BRCM_SWQTST_BCM8957X_ROM_TFTP_BL_LARGE
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_ov_a0_signed.raw

BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_FL
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_signed.raw
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_non_secure.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP_IPC
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_tftp_a0_signed.raw
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_no_flash.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_IPC
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_tftp_a0_signed.raw
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_no_flash_tftp.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex
    Image File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_ipc_a0.img

BRCM_SWQTST_BCM8957X_ROM_BL_SELECT_TFTP
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_no_flash_ipc.hex
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_tftp_a0_signed.raw
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_TC10_AXI
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_tc10_axi.hex

BRCM_SWQTST_BCM8957X_ROM_TC10_MDIO
    OTP File   : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_tc10_axi_denali.hex

BRCM_SWQTST_BCM8957X_ROM_MCM_BOOT
    OTP File : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_mcm_comm_master.hex
    Flash File : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_a0_flash.bin_0.hex

BRCM_SWQTST_BCM8957X_ROM_EMPTY_OTP
    Bin File   : out/rom/bcm8957x/a0/tbl/bcm8957x_rom_tbl_tftp_a0_signed.raw
    OTP File : nvm/drivers/otp/config/bcm8957x/otp_bcm8957x_empty.hex
