

Include("helper_functions.vbs")

Sub Include (strFile)
    'Create objects for opening text file
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objTextFile = objFSO.OpenTextFile(strFile, 1)

    'Execute content of file.
    ExecuteGlobal objTextFile.ReadAll

    'CLose file
    objTextFile.Close

    'Clean up
    Set objFSO = Nothing
    Set objTextFile = Nothing
End Sub


'***********************************

' Registers and Fields

'***********************************


'' @REGISTER : CFG_cfg_cpusys_misc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' M7_CORE_SOFT_RST                           [31:31]          get_M7_CORE_SOFT_RST
''                                                             set_M7_CORE_SOFT_RST
''                                                             read_M7_CORE_SOFT_RST
''                                                             write_M7_CORE_SOFT_RST
''---------------------------------------------------------------------------------
'' M7_CPU_CLKGATE_EN                          [30:30]          get_M7_CPU_CLKGATE_EN
''                                                             set_M7_CPU_CLKGATE_EN
''                                                             read_M7_CPU_CLKGATE_EN
''                                                             write_M7_CPU_CLKGATE_EN
''---------------------------------------------------------------------------------
'' MEM_INIT_DONE_cfg                          [29:29]          get_MEM_INIT_DONE_cfg
''                                                             set_MEM_INIT_DONE_cfg
''                                                             read_MEM_INIT_DONE_cfg
''                                                             write_MEM_INIT_DONE_cfg
''---------------------------------------------------------------------------------
'' ECC_ERR_CLEAR_cfg                          [28:28]          get_ECC_ERR_CLEAR_cfg
''                                                             set_ECC_ERR_CLEAR_cfg
''                                                             read_ECC_ERR_CLEAR_cfg
''                                                             write_ECC_ERR_CLEAR_cfg
''---------------------------------------------------------------------------------
'' NMI_CLEAR_cfg                              [27:27]          get_NMI_CLEAR_cfg
''                                                             set_NMI_CLEAR_cfg
''                                                             read_NMI_CLEAR_cfg
''                                                             write_NMI_CLEAR_cfg
''---------------------------------------------------------------------------------
'' CPU_LOCKUP_RST_EN                          [26:26]          get_CPU_LOCKUP_RST_EN
''                                                             set_CPU_LOCKUP_RST_EN
''                                                             read_CPU_LOCKUP_RST_EN
''                                                             write_CPU_LOCKUP_RST_EN
''---------------------------------------------------------------------------------
'' CPU_SYSRSTREQ_RST_EN                       [25:25]          get_CPU_SYSRSTREQ_RST_EN
''                                                             set_CPU_SYSRSTREQ_RST_EN
''                                                             read_CPU_SYSRSTREQ_RST_EN
''                                                             write_CPU_SYSRSTREQ_RST_EN
''---------------------------------------------------------------------------------
'' Spare_24                                   [24:24]          get_Spare_24
''                                                             set_Spare_24
''                                                             read_Spare_24
''                                                             write_Spare_24
''---------------------------------------------------------------------------------
'' SPI_ACC_IPC_DTCM_DIS                       [23:23]          get_SPI_ACC_IPC_DTCM_DIS
''                                                             set_SPI_ACC_IPC_DTCM_DIS
''                                                             read_SPI_ACC_IPC_DTCM_DIS
''                                                             write_SPI_ACC_IPC_DTCM_DIS
''---------------------------------------------------------------------------------
'' SPEED_UP_MEM_INIT_cfg                      [22:22]          get_SPEED_UP_MEM_INIT_cfg
''                                                             set_SPEED_UP_MEM_INIT_cfg
''                                                             read_SPEED_UP_MEM_INIT_cfg
''                                                             write_SPEED_UP_MEM_INIT_cfg
''---------------------------------------------------------------------------------
'' SER_ACCESS_CTRL_cfg                        [21:21]          get_SER_ACCESS_CTRL_cfg
''                                                             set_SER_ACCESS_CTRL_cfg
''                                                             read_SER_ACCESS_CTRL_cfg
''                                                             write_SER_ACCESS_CTRL_cfg
''---------------------------------------------------------------------------------
'' Spare                                      [20:20]          get_Spare
''                                                             set_Spare
''                                                             read_Spare
''                                                             write_Spare
''---------------------------------------------------------------------------------
'' Spare18to04                                [18:4]           get_Spare18to04
''                                                             set_Spare18to04
''                                                             read_Spare18to04
''                                                             write_Spare18to04
''---------------------------------------------------------------------------------
'' nRESET_ov                                  [3:3]            get_nRESET_ov
''                                                             set_nRESET_ov
''                                                             read_nRESET_ov
''                                                             write_nRESET_ov
''---------------------------------------------------------------------------------
'' nRESET_cfg                                 [2:2]            get_nRESET_cfg
''                                                             set_nRESET_cfg
''                                                             read_nRESET_cfg
''                                                             write_nRESET_cfg
''---------------------------------------------------------------------------------
'' nSYSPORESET_ov                             [1:1]            get_nSYSPORESET_ov
''                                                             set_nSYSPORESET_ov
''                                                             read_nSYSPORESET_ov
''                                                             write_nSYSPORESET_ov
''---------------------------------------------------------------------------------
'' nSYSPORESET_cfg                            [0:0]            get_nSYSPORESET_cfg
''                                                             set_nSYSPORESET_cfg
''                                                             read_nSYSPORESET_cfg
''                                                             write_nSYSPORESET_cfg
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cfg_cpusys_misc
    Private write_M7_CORE_SOFT_RST_value
    Private read_M7_CORE_SOFT_RST_value
    Private flag_M7_CORE_SOFT_RST
    Private write_M7_CPU_CLKGATE_EN_value
    Private read_M7_CPU_CLKGATE_EN_value
    Private flag_M7_CPU_CLKGATE_EN
    Private write_MEM_INIT_DONE_cfg_value
    Private read_MEM_INIT_DONE_cfg_value
    Private flag_MEM_INIT_DONE_cfg
    Private write_ECC_ERR_CLEAR_cfg_value
    Private read_ECC_ERR_CLEAR_cfg_value
    Private flag_ECC_ERR_CLEAR_cfg
    Private write_NMI_CLEAR_cfg_value
    Private read_NMI_CLEAR_cfg_value
    Private flag_NMI_CLEAR_cfg
    Private write_CPU_LOCKUP_RST_EN_value
    Private read_CPU_LOCKUP_RST_EN_value
    Private flag_CPU_LOCKUP_RST_EN
    Private write_CPU_SYSRSTREQ_RST_EN_value
    Private read_CPU_SYSRSTREQ_RST_EN_value
    Private flag_CPU_SYSRSTREQ_RST_EN
    Private write_Spare_24_value
    Private read_Spare_24_value
    Private flag_Spare_24
    Private write_SPI_ACC_IPC_DTCM_DIS_value
    Private read_SPI_ACC_IPC_DTCM_DIS_value
    Private flag_SPI_ACC_IPC_DTCM_DIS
    Private write_SPEED_UP_MEM_INIT_cfg_value
    Private read_SPEED_UP_MEM_INIT_cfg_value
    Private flag_SPEED_UP_MEM_INIT_cfg
    Private write_SER_ACCESS_CTRL_cfg_value
    Private read_SER_ACCESS_CTRL_cfg_value
    Private flag_SER_ACCESS_CTRL_cfg
    Private write_Spare_value
    Private read_Spare_value
    Private flag_Spare
    Private write_Spare18to04_value
    Private read_Spare18to04_value
    Private flag_Spare18to04
    Private write_nRESET_ov_value
    Private read_nRESET_ov_value
    Private flag_nRESET_ov
    Private write_nRESET_cfg_value
    Private read_nRESET_cfg_value
    Private flag_nRESET_cfg
    Private write_nSYSPORESET_ov_value
    Private read_nSYSPORESET_ov_value
    Private flag_nSYSPORESET_ov
    Private write_nSYSPORESET_cfg_value
    Private read_nSYSPORESET_cfg_value
    Private flag_nSYSPORESET_cfg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_M7_CORE_SOFT_RST
        get_M7_CORE_SOFT_RST = read_M7_CORE_SOFT_RST_value
    End Property

    Property Let set_M7_CORE_SOFT_RST(aData)
        write_M7_CORE_SOFT_RST_value = aData
        flag_M7_CORE_SOFT_RST        = &H1
    End Property

    Property Get read_M7_CORE_SOFT_RST
        read
        read_M7_CORE_SOFT_RST = read_M7_CORE_SOFT_RST_value
    End Property

    Property Let write_M7_CORE_SOFT_RST(aData)
        set_M7_CORE_SOFT_RST = aData
        write
    End Property

    Property Get get_M7_CPU_CLKGATE_EN
        get_M7_CPU_CLKGATE_EN = read_M7_CPU_CLKGATE_EN_value
    End Property

    Property Let set_M7_CPU_CLKGATE_EN(aData)
        write_M7_CPU_CLKGATE_EN_value = aData
        flag_M7_CPU_CLKGATE_EN        = &H1
    End Property

    Property Get read_M7_CPU_CLKGATE_EN
        read
        read_M7_CPU_CLKGATE_EN = read_M7_CPU_CLKGATE_EN_value
    End Property

    Property Let write_M7_CPU_CLKGATE_EN(aData)
        set_M7_CPU_CLKGATE_EN = aData
        write
    End Property

    Property Get get_MEM_INIT_DONE_cfg
        get_MEM_INIT_DONE_cfg = read_MEM_INIT_DONE_cfg_value
    End Property

    Property Let set_MEM_INIT_DONE_cfg(aData)
        write_MEM_INIT_DONE_cfg_value = aData
        flag_MEM_INIT_DONE_cfg        = &H1
    End Property

    Property Get read_MEM_INIT_DONE_cfg
        read
        read_MEM_INIT_DONE_cfg = read_MEM_INIT_DONE_cfg_value
    End Property

    Property Let write_MEM_INIT_DONE_cfg(aData)
        set_MEM_INIT_DONE_cfg = aData
        write
    End Property

    Property Get get_ECC_ERR_CLEAR_cfg
        get_ECC_ERR_CLEAR_cfg = read_ECC_ERR_CLEAR_cfg_value
    End Property

    Property Let set_ECC_ERR_CLEAR_cfg(aData)
        write_ECC_ERR_CLEAR_cfg_value = aData
        flag_ECC_ERR_CLEAR_cfg        = &H1
    End Property

    Property Get read_ECC_ERR_CLEAR_cfg
        read
        read_ECC_ERR_CLEAR_cfg = read_ECC_ERR_CLEAR_cfg_value
    End Property

    Property Let write_ECC_ERR_CLEAR_cfg(aData)
        set_ECC_ERR_CLEAR_cfg = aData
        write
    End Property

    Property Get get_NMI_CLEAR_cfg
        get_NMI_CLEAR_cfg = read_NMI_CLEAR_cfg_value
    End Property

    Property Let set_NMI_CLEAR_cfg(aData)
        write_NMI_CLEAR_cfg_value = aData
        flag_NMI_CLEAR_cfg        = &H1
    End Property

    Property Get read_NMI_CLEAR_cfg
        read
        read_NMI_CLEAR_cfg = read_NMI_CLEAR_cfg_value
    End Property

    Property Let write_NMI_CLEAR_cfg(aData)
        set_NMI_CLEAR_cfg = aData
        write
    End Property

    Property Get get_CPU_LOCKUP_RST_EN
        get_CPU_LOCKUP_RST_EN = read_CPU_LOCKUP_RST_EN_value
    End Property

    Property Let set_CPU_LOCKUP_RST_EN(aData)
        write_CPU_LOCKUP_RST_EN_value = aData
        flag_CPU_LOCKUP_RST_EN        = &H1
    End Property

    Property Get read_CPU_LOCKUP_RST_EN
        read
        read_CPU_LOCKUP_RST_EN = read_CPU_LOCKUP_RST_EN_value
    End Property

    Property Let write_CPU_LOCKUP_RST_EN(aData)
        set_CPU_LOCKUP_RST_EN = aData
        write
    End Property

    Property Get get_CPU_SYSRSTREQ_RST_EN
        get_CPU_SYSRSTREQ_RST_EN = read_CPU_SYSRSTREQ_RST_EN_value
    End Property

    Property Let set_CPU_SYSRSTREQ_RST_EN(aData)
        write_CPU_SYSRSTREQ_RST_EN_value = aData
        flag_CPU_SYSRSTREQ_RST_EN        = &H1
    End Property

    Property Get read_CPU_SYSRSTREQ_RST_EN
        read
        read_CPU_SYSRSTREQ_RST_EN = read_CPU_SYSRSTREQ_RST_EN_value
    End Property

    Property Let write_CPU_SYSRSTREQ_RST_EN(aData)
        set_CPU_SYSRSTREQ_RST_EN = aData
        write
    End Property

    Property Get get_Spare_24
        get_Spare_24 = read_Spare_24_value
    End Property

    Property Let set_Spare_24(aData)
        write_Spare_24_value = aData
        flag_Spare_24        = &H1
    End Property

    Property Get read_Spare_24
        read
        read_Spare_24 = read_Spare_24_value
    End Property

    Property Let write_Spare_24(aData)
        set_Spare_24 = aData
        write
    End Property

    Property Get get_SPI_ACC_IPC_DTCM_DIS
        get_SPI_ACC_IPC_DTCM_DIS = read_SPI_ACC_IPC_DTCM_DIS_value
    End Property

    Property Let set_SPI_ACC_IPC_DTCM_DIS(aData)
        write_SPI_ACC_IPC_DTCM_DIS_value = aData
        flag_SPI_ACC_IPC_DTCM_DIS        = &H1
    End Property

    Property Get read_SPI_ACC_IPC_DTCM_DIS
        read
        read_SPI_ACC_IPC_DTCM_DIS = read_SPI_ACC_IPC_DTCM_DIS_value
    End Property

    Property Let write_SPI_ACC_IPC_DTCM_DIS(aData)
        set_SPI_ACC_IPC_DTCM_DIS = aData
        write
    End Property

    Property Get get_SPEED_UP_MEM_INIT_cfg
        get_SPEED_UP_MEM_INIT_cfg = read_SPEED_UP_MEM_INIT_cfg_value
    End Property

    Property Let set_SPEED_UP_MEM_INIT_cfg(aData)
        write_SPEED_UP_MEM_INIT_cfg_value = aData
        flag_SPEED_UP_MEM_INIT_cfg        = &H1
    End Property

    Property Get read_SPEED_UP_MEM_INIT_cfg
        read
        read_SPEED_UP_MEM_INIT_cfg = read_SPEED_UP_MEM_INIT_cfg_value
    End Property

    Property Let write_SPEED_UP_MEM_INIT_cfg(aData)
        set_SPEED_UP_MEM_INIT_cfg = aData
        write
    End Property

    Property Get get_SER_ACCESS_CTRL_cfg
        get_SER_ACCESS_CTRL_cfg = read_SER_ACCESS_CTRL_cfg_value
    End Property

    Property Let set_SER_ACCESS_CTRL_cfg(aData)
        write_SER_ACCESS_CTRL_cfg_value = aData
        flag_SER_ACCESS_CTRL_cfg        = &H1
    End Property

    Property Get read_SER_ACCESS_CTRL_cfg
        read
        read_SER_ACCESS_CTRL_cfg = read_SER_ACCESS_CTRL_cfg_value
    End Property

    Property Let write_SER_ACCESS_CTRL_cfg(aData)
        set_SER_ACCESS_CTRL_cfg = aData
        write
    End Property

    Property Get get_Spare
        get_Spare = read_Spare_value
    End Property

    Property Let set_Spare(aData)
        write_Spare_value = aData
        flag_Spare        = &H1
    End Property

    Property Get read_Spare
        read
        read_Spare = read_Spare_value
    End Property

    Property Let write_Spare(aData)
        set_Spare = aData
        write
    End Property

    Property Get get_Spare18to04
        get_Spare18to04 = read_Spare18to04_value
    End Property

    Property Let set_Spare18to04(aData)
        write_Spare18to04_value = aData
        flag_Spare18to04        = &H1
    End Property

    Property Get read_Spare18to04
        read
        read_Spare18to04 = read_Spare18to04_value
    End Property

    Property Let write_Spare18to04(aData)
        set_Spare18to04 = aData
        write
    End Property

    Property Get get_nRESET_ov
        get_nRESET_ov = read_nRESET_ov_value
    End Property

    Property Let set_nRESET_ov(aData)
        write_nRESET_ov_value = aData
        flag_nRESET_ov        = &H1
    End Property

    Property Get read_nRESET_ov
        read
        read_nRESET_ov = read_nRESET_ov_value
    End Property

    Property Let write_nRESET_ov(aData)
        set_nRESET_ov = aData
        write
    End Property

    Property Get get_nRESET_cfg
        get_nRESET_cfg = read_nRESET_cfg_value
    End Property

    Property Let set_nRESET_cfg(aData)
        write_nRESET_cfg_value = aData
        flag_nRESET_cfg        = &H1
    End Property

    Property Get read_nRESET_cfg
        read
        read_nRESET_cfg = read_nRESET_cfg_value
    End Property

    Property Let write_nRESET_cfg(aData)
        set_nRESET_cfg = aData
        write
    End Property

    Property Get get_nSYSPORESET_ov
        get_nSYSPORESET_ov = read_nSYSPORESET_ov_value
    End Property

    Property Let set_nSYSPORESET_ov(aData)
        write_nSYSPORESET_ov_value = aData
        flag_nSYSPORESET_ov        = &H1
    End Property

    Property Get read_nSYSPORESET_ov
        read
        read_nSYSPORESET_ov = read_nSYSPORESET_ov_value
    End Property

    Property Let write_nSYSPORESET_ov(aData)
        set_nSYSPORESET_ov = aData
        write
    End Property

    Property Get get_nSYSPORESET_cfg
        get_nSYSPORESET_cfg = read_nSYSPORESET_cfg_value
    End Property

    Property Let set_nSYSPORESET_cfg(aData)
        write_nSYSPORESET_cfg_value = aData
        flag_nSYSPORESET_cfg        = &H1
    End Property

    Property Get read_nSYSPORESET_cfg
        read
        read_nSYSPORESET_cfg = read_nSYSPORESET_cfg_value
    End Property

    Property Let write_nSYSPORESET_cfg(aData)
        set_nSYSPORESET_cfg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_M7_CORE_SOFT_RST_value = rightShift(data_low, 31) and &H1
        read_M7_CPU_CLKGATE_EN_value = rightShift(data_low, 30) and &H1
        read_MEM_INIT_DONE_cfg_value = rightShift(data_low, 29) and &H1
        read_ECC_ERR_CLEAR_cfg_value = rightShift(data_low, 28) and &H1
        read_NMI_CLEAR_cfg_value = rightShift(data_low, 27) and &H1
        read_CPU_LOCKUP_RST_EN_value = rightShift(data_low, 26) and &H1
        read_CPU_SYSRSTREQ_RST_EN_value = rightShift(data_low, 25) and &H1
        read_Spare_24_value = rightShift(data_low, 24) and &H1
        read_SPI_ACC_IPC_DTCM_DIS_value = rightShift(data_low, 23) and &H1
        read_SPEED_UP_MEM_INIT_cfg_value = rightShift(data_low, 22) and &H1
        read_SER_ACCESS_CTRL_cfg_value = rightShift(data_low, 21) and &H1
        read_Spare_value = rightShift(data_low, 20) and &H1
        read_Spare18to04_value = rightShift(data_low, 4) and &H7fff
        read_nRESET_ov_value = rightShift(data_low, 3) and &H1
        read_nRESET_cfg_value = rightShift(data_low, 2) and &H1
        read_nSYSPORESET_ov_value = rightShift(data_low, 1) and &H1
        nSYSPORESET_cfg_mask = &H1
        if data_low > LONG_MAX then
            if nSYSPORESET_cfg_mask = mask then
                read_nSYSPORESET_cfg_value = data_low
            else
                read_nSYSPORESET_cfg_value = (data_low - H8000_0000) and nSYSPORESET_cfg_mask
            end If
        else
            read_nSYSPORESET_cfg_value = data_low and nSYSPORESET_cfg_mask
        end If

    End Sub

    Sub write
        If flag_M7_CORE_SOFT_RST = &H0 or flag_M7_CPU_CLKGATE_EN = &H0 or flag_MEM_INIT_DONE_cfg = &H0 or flag_ECC_ERR_CLEAR_cfg = &H0 or flag_NMI_CLEAR_cfg = &H0 or flag_CPU_LOCKUP_RST_EN = &H0 or flag_CPU_SYSRSTREQ_RST_EN = &H0 or flag_Spare_24 = &H0 or flag_SPI_ACC_IPC_DTCM_DIS = &H0 or flag_SPEED_UP_MEM_INIT_cfg = &H0 or flag_SER_ACCESS_CTRL_cfg = &H0 or flag_Spare = &H0 or flag_Spare18to04 = &H0 or flag_nRESET_ov = &H0 or flag_nRESET_cfg = &H0 or flag_nSYSPORESET_ov = &H0 or flag_nSYSPORESET_cfg = &H0 Then read
        If flag_M7_CORE_SOFT_RST = &H0 Then write_M7_CORE_SOFT_RST_value = get_M7_CORE_SOFT_RST
        If flag_M7_CPU_CLKGATE_EN = &H0 Then write_M7_CPU_CLKGATE_EN_value = get_M7_CPU_CLKGATE_EN
        If flag_MEM_INIT_DONE_cfg = &H0 Then write_MEM_INIT_DONE_cfg_value = get_MEM_INIT_DONE_cfg
        If flag_ECC_ERR_CLEAR_cfg = &H0 Then write_ECC_ERR_CLEAR_cfg_value = get_ECC_ERR_CLEAR_cfg
        If flag_NMI_CLEAR_cfg = &H0 Then write_NMI_CLEAR_cfg_value = get_NMI_CLEAR_cfg
        If flag_CPU_LOCKUP_RST_EN = &H0 Then write_CPU_LOCKUP_RST_EN_value = get_CPU_LOCKUP_RST_EN
        If flag_CPU_SYSRSTREQ_RST_EN = &H0 Then write_CPU_SYSRSTREQ_RST_EN_value = get_CPU_SYSRSTREQ_RST_EN
        If flag_Spare_24 = &H0 Then write_Spare_24_value = get_Spare_24
        If flag_SPI_ACC_IPC_DTCM_DIS = &H0 Then write_SPI_ACC_IPC_DTCM_DIS_value = get_SPI_ACC_IPC_DTCM_DIS
        If flag_SPEED_UP_MEM_INIT_cfg = &H0 Then write_SPEED_UP_MEM_INIT_cfg_value = get_SPEED_UP_MEM_INIT_cfg
        If flag_SER_ACCESS_CTRL_cfg = &H0 Then write_SER_ACCESS_CTRL_cfg_value = get_SER_ACCESS_CTRL_cfg
        If flag_Spare = &H0 Then write_Spare_value = get_Spare
        If flag_Spare18to04 = &H0 Then write_Spare18to04_value = get_Spare18to04
        If flag_nRESET_ov = &H0 Then write_nRESET_ov_value = get_nRESET_ov
        If flag_nRESET_cfg = &H0 Then write_nRESET_cfg_value = get_nRESET_cfg
        If flag_nSYSPORESET_ov = &H0 Then write_nSYSPORESET_ov_value = get_nSYSPORESET_ov
        If flag_nSYSPORESET_cfg = &H0 Then write_nSYSPORESET_cfg_value = get_nSYSPORESET_cfg

        regValue = leftShift((write_M7_CORE_SOFT_RST_value and &H1), 31) + leftShift((write_M7_CPU_CLKGATE_EN_value and &H1), 30) + leftShift((write_MEM_INIT_DONE_cfg_value and &H1), 29) + leftShift((write_ECC_ERR_CLEAR_cfg_value and &H1), 28) + leftShift((write_NMI_CLEAR_cfg_value and &H1), 27) + leftShift((write_CPU_LOCKUP_RST_EN_value and &H1), 26) + leftShift((write_CPU_SYSRSTREQ_RST_EN_value and &H1), 25) + leftShift((write_Spare_24_value and &H1), 24) + leftShift((write_SPI_ACC_IPC_DTCM_DIS_value and &H1), 23) + leftShift((write_SPEED_UP_MEM_INIT_cfg_value and &H1), 22) + leftShift((write_SER_ACCESS_CTRL_cfg_value and &H1), 21) + leftShift((write_Spare_value and &H1), 20) + leftShift((write_Spare18to04_value and &H7fff), 4) + leftShift((write_nRESET_ov_value and &H1), 3) + leftShift((write_nRESET_cfg_value and &H1), 2) + leftShift((write_nSYSPORESET_ov_value and &H1), 1) + leftShift((write_nSYSPORESET_cfg_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_M7_CORE_SOFT_RST_value = rightShift(data_low, 31) and &H1
        read_M7_CPU_CLKGATE_EN_value = rightShift(data_low, 30) and &H1
        read_MEM_INIT_DONE_cfg_value = rightShift(data_low, 29) and &H1
        read_ECC_ERR_CLEAR_cfg_value = rightShift(data_low, 28) and &H1
        read_NMI_CLEAR_cfg_value = rightShift(data_low, 27) and &H1
        read_CPU_LOCKUP_RST_EN_value = rightShift(data_low, 26) and &H1
        read_CPU_SYSRSTREQ_RST_EN_value = rightShift(data_low, 25) and &H1
        read_Spare_24_value = rightShift(data_low, 24) and &H1
        read_SPI_ACC_IPC_DTCM_DIS_value = rightShift(data_low, 23) and &H1
        read_SPEED_UP_MEM_INIT_cfg_value = rightShift(data_low, 22) and &H1
        read_SER_ACCESS_CTRL_cfg_value = rightShift(data_low, 21) and &H1
        read_Spare_value = rightShift(data_low, 20) and &H1
        read_Spare18to04_value = rightShift(data_low, 4) and &H7fff
        read_nRESET_ov_value = rightShift(data_low, 3) and &H1
        read_nRESET_cfg_value = rightShift(data_low, 2) and &H1
        read_nSYSPORESET_ov_value = rightShift(data_low, 1) and &H1
        nSYSPORESET_cfg_mask = &H1
        if data_low > LONG_MAX then
            if nSYSPORESET_cfg_mask = mask then
                read_nSYSPORESET_cfg_value = data_low
            else
                read_nSYSPORESET_cfg_value = (data_low - H8000_0000) and nSYSPORESET_cfg_mask
            end If
        else
            read_nSYSPORESET_cfg_value = data_low and nSYSPORESET_cfg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_M7_CORE_SOFT_RST_value = &H0
        flag_M7_CORE_SOFT_RST        = &H0
        write_M7_CPU_CLKGATE_EN_value = &H0
        flag_M7_CPU_CLKGATE_EN        = &H0
        write_MEM_INIT_DONE_cfg_value = &H0
        flag_MEM_INIT_DONE_cfg        = &H0
        write_ECC_ERR_CLEAR_cfg_value = &H0
        flag_ECC_ERR_CLEAR_cfg        = &H0
        write_NMI_CLEAR_cfg_value = &H0
        flag_NMI_CLEAR_cfg        = &H0
        write_CPU_LOCKUP_RST_EN_value = &H0
        flag_CPU_LOCKUP_RST_EN        = &H0
        write_CPU_SYSRSTREQ_RST_EN_value = &H0
        flag_CPU_SYSRSTREQ_RST_EN        = &H0
        write_Spare_24_value = &H0
        flag_Spare_24        = &H0
        write_SPI_ACC_IPC_DTCM_DIS_value = &H0
        flag_SPI_ACC_IPC_DTCM_DIS        = &H0
        write_SPEED_UP_MEM_INIT_cfg_value = &H0
        flag_SPEED_UP_MEM_INIT_cfg        = &H0
        write_SER_ACCESS_CTRL_cfg_value = &H0
        flag_SER_ACCESS_CTRL_cfg        = &H0
        write_Spare_value = &H0
        flag_Spare        = &H0
        write_Spare18to04_value = &H0
        flag_Spare18to04        = &H0
        write_nRESET_ov_value = &H0
        flag_nRESET_ov        = &H0
        write_nRESET_cfg_value = &H0
        flag_nRESET_cfg        = &H0
        write_nSYSPORESET_ov_value = &H0
        flag_nSYSPORESET_ov        = &H0
        write_nSYSPORESET_cfg_value = &H0
        flag_nSYSPORESET_cfg        = &H0
    End Sub
End Class


'' @REGISTER : CFG_tm_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CFG_ALL_TM                                 [15:0]           get_CFG_ALL_TM
''                                                             set_CFG_ALL_TM
''                                                             read_CFG_ALL_TM
''                                                             write_CFG_ALL_TM
''---------------------------------------------------------------------------------
Class REGISTER_CFG_tm_0
    Private write_CFG_ALL_TM_value
    Private read_CFG_ALL_TM_value
    Private flag_CFG_ALL_TM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CFG_ALL_TM
        get_CFG_ALL_TM = read_CFG_ALL_TM_value
    End Property

    Property Let set_CFG_ALL_TM(aData)
        write_CFG_ALL_TM_value = aData
        flag_CFG_ALL_TM        = &H1
    End Property

    Property Get read_CFG_ALL_TM
        read
        read_CFG_ALL_TM = read_CFG_ALL_TM_value
    End Property

    Property Let write_CFG_ALL_TM(aData)
        set_CFG_ALL_TM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CFG_ALL_TM_mask = &Hffff
        if data_low > LONG_MAX then
            if CFG_ALL_TM_mask = mask then
                read_CFG_ALL_TM_value = data_low
            else
                read_CFG_ALL_TM_value = (data_low - H8000_0000) and CFG_ALL_TM_mask
            end If
        else
            read_CFG_ALL_TM_value = data_low and CFG_ALL_TM_mask
        end If

    End Sub

    Sub write
        If flag_CFG_ALL_TM = &H0 Then read
        If flag_CFG_ALL_TM = &H0 Then write_CFG_ALL_TM_value = get_CFG_ALL_TM

        regValue = leftShift((write_CFG_ALL_TM_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CFG_ALL_TM_mask = &Hffff
        if data_low > LONG_MAX then
            if CFG_ALL_TM_mask = mask then
                read_CFG_ALL_TM_value = data_low
            else
                read_CFG_ALL_TM_value = (data_low - H8000_0000) and CFG_ALL_TM_mask
            end If
        else
            read_CFG_ALL_TM_value = data_low and CFG_ALL_TM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CFG_ALL_TM_value = &H0
        flag_CFG_ALL_TM        = &H0
    End Sub
End Class


'' @REGISTER : CFG_debug_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEBUG_MUX_SEL                              [4:1]            get_DEBUG_MUX_SEL
''                                                             set_DEBUG_MUX_SEL
''                                                             read_DEBUG_MUX_SEL
''                                                             write_DEBUG_MUX_SEL
''---------------------------------------------------------------------------------
'' DEBUG_ENABLE                               [0:0]            get_DEBUG_ENABLE
''                                                             set_DEBUG_ENABLE
''                                                             read_DEBUG_ENABLE
''                                                             write_DEBUG_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_CFG_debug_sel
    Private write_DEBUG_MUX_SEL_value
    Private read_DEBUG_MUX_SEL_value
    Private flag_DEBUG_MUX_SEL
    Private write_DEBUG_ENABLE_value
    Private read_DEBUG_ENABLE_value
    Private flag_DEBUG_ENABLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DEBUG_MUX_SEL
        get_DEBUG_MUX_SEL = read_DEBUG_MUX_SEL_value
    End Property

    Property Let set_DEBUG_MUX_SEL(aData)
        write_DEBUG_MUX_SEL_value = aData
        flag_DEBUG_MUX_SEL        = &H1
    End Property

    Property Get read_DEBUG_MUX_SEL
        read
        read_DEBUG_MUX_SEL = read_DEBUG_MUX_SEL_value
    End Property

    Property Let write_DEBUG_MUX_SEL(aData)
        set_DEBUG_MUX_SEL = aData
        write
    End Property

    Property Get get_DEBUG_ENABLE
        get_DEBUG_ENABLE = read_DEBUG_ENABLE_value
    End Property

    Property Let set_DEBUG_ENABLE(aData)
        write_DEBUG_ENABLE_value = aData
        flag_DEBUG_ENABLE        = &H1
    End Property

    Property Get read_DEBUG_ENABLE
        read
        read_DEBUG_ENABLE = read_DEBUG_ENABLE_value
    End Property

    Property Let write_DEBUG_ENABLE(aData)
        set_DEBUG_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DEBUG_MUX_SEL_value = rightShift(data_low, 1) and &Hf
        DEBUG_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if DEBUG_ENABLE_mask = mask then
                read_DEBUG_ENABLE_value = data_low
            else
                read_DEBUG_ENABLE_value = (data_low - H8000_0000) and DEBUG_ENABLE_mask
            end If
        else
            read_DEBUG_ENABLE_value = data_low and DEBUG_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_DEBUG_MUX_SEL = &H0 or flag_DEBUG_ENABLE = &H0 Then read
        If flag_DEBUG_MUX_SEL = &H0 Then write_DEBUG_MUX_SEL_value = get_DEBUG_MUX_SEL
        If flag_DEBUG_ENABLE = &H0 Then write_DEBUG_ENABLE_value = get_DEBUG_ENABLE

        regValue = leftShift((write_DEBUG_MUX_SEL_value and &Hf), 1) + leftShift((write_DEBUG_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DEBUG_MUX_SEL_value = rightShift(data_low, 1) and &Hf
        DEBUG_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if DEBUG_ENABLE_mask = mask then
                read_DEBUG_ENABLE_value = data_low
            else
                read_DEBUG_ENABLE_value = (data_low - H8000_0000) and DEBUG_ENABLE_mask
            end If
        else
            read_DEBUG_ENABLE_value = data_low and DEBUG_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEBUG_MUX_SEL_value = &H0
        flag_DEBUG_MUX_SEL        = &H0
        write_DEBUG_ENABLE_value = &H0
        flag_DEBUG_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : CFG_debug_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' jtagice_enable                             [0:0]            get_jtagice_enable
''                                                             set_jtagice_enable
''                                                             read_jtagice_enable
''                                                             write_jtagice_enable
''---------------------------------------------------------------------------------
Class REGISTER_CFG_debug_en
    Private write_jtagice_enable_value
    Private read_jtagice_enable_value
    Private flag_jtagice_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_jtagice_enable
        get_jtagice_enable = read_jtagice_enable_value
    End Property

    Property Let set_jtagice_enable(aData)
        write_jtagice_enable_value = aData
        flag_jtagice_enable        = &H1
    End Property

    Property Get read_jtagice_enable
        read
        read_jtagice_enable = read_jtagice_enable_value
    End Property

    Property Let write_jtagice_enable(aData)
        set_jtagice_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        jtagice_enable_mask = &H1
        if data_low > LONG_MAX then
            if jtagice_enable_mask = mask then
                read_jtagice_enable_value = data_low
            else
                read_jtagice_enable_value = (data_low - H8000_0000) and jtagice_enable_mask
            end If
        else
            read_jtagice_enable_value = data_low and jtagice_enable_mask
        end If

    End Sub

    Sub write
        If flag_jtagice_enable = &H0 Then read
        If flag_jtagice_enable = &H0 Then write_jtagice_enable_value = get_jtagice_enable

        regValue = leftShift((write_jtagice_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        jtagice_enable_mask = &H1
        if data_low > LONG_MAX then
            if jtagice_enable_mask = mask then
                read_jtagice_enable_value = data_low
            else
                read_jtagice_enable_value = (data_low - H8000_0000) and jtagice_enable_mask
            end If
        else
            read_jtagice_enable_value = data_low and jtagice_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_jtagice_enable_value = &H0
        flag_jtagice_enable        = &H0
    End Sub
End Class


'' @REGISTER : CFG_sw_if
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_init_done                               [6:6]            get_sw_init_done
''                                                             set_sw_init_done
''                                                             read_sw_init_done
''                                                             write_sw_init_done
''---------------------------------------------------------------------------------
'' host_intr                                  [1:1]            get_host_intr
''                                                             set_host_intr
''                                                             read_host_intr
''                                                             write_host_intr
''---------------------------------------------------------------------------------
Class REGISTER_CFG_sw_if
    Private write_sw_init_done_value
    Private read_sw_init_done_value
    Private flag_sw_init_done
    Private write_host_intr_value
    Private read_host_intr_value
    Private flag_host_intr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_init_done
        get_sw_init_done = read_sw_init_done_value
    End Property

    Property Let set_sw_init_done(aData)
        write_sw_init_done_value = aData
        flag_sw_init_done        = &H1
    End Property

    Property Get read_sw_init_done
        read
        read_sw_init_done = read_sw_init_done_value
    End Property

    Property Let write_sw_init_done(aData)
        set_sw_init_done = aData
        write
    End Property

    Property Get get_host_intr
        get_host_intr = read_host_intr_value
    End Property

    Property Let set_host_intr(aData)
        write_host_intr_value = aData
        flag_host_intr        = &H1
    End Property

    Property Get read_host_intr
        read
        read_host_intr = read_host_intr_value
    End Property

    Property Let write_host_intr(aData)
        set_host_intr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sw_init_done_value = rightShift(data_low, 6) and &H1
        read_host_intr_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_sw_init_done = &H0 or flag_host_intr = &H0 Then read
        If flag_sw_init_done = &H0 Then write_sw_init_done_value = get_sw_init_done
        If flag_host_intr = &H0 Then write_host_intr_value = get_host_intr

        regValue = leftShift((write_sw_init_done_value and &H1), 6) + leftShift((write_host_intr_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sw_init_done_value = rightShift(data_low, 6) and &H1
        read_host_intr_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_init_done_value = &H0
        flag_sw_init_done        = &H0
        write_host_intr_value = &H0
        flag_host_intr        = &H0
    End Sub
End Class


'' @REGISTER : CFG_sw_intr_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_intr_clr                                [31:0]           get_sw_intr_clr
''                                                             set_sw_intr_clr
''                                                             read_sw_intr_clr
''                                                             write_sw_intr_clr
''---------------------------------------------------------------------------------
Class REGISTER_CFG_sw_intr_clr
    Private write_sw_intr_clr_value
    Private read_sw_intr_clr_value
    Private flag_sw_intr_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_intr_clr
        get_sw_intr_clr = read_sw_intr_clr_value
    End Property

    Property Let set_sw_intr_clr(aData)
        write_sw_intr_clr_value = aData
        flag_sw_intr_clr        = &H1
    End Property

    Property Get read_sw_intr_clr
        read
        read_sw_intr_clr = read_sw_intr_clr_value
    End Property

    Property Let write_sw_intr_clr(aData)
        set_sw_intr_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_intr_clr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_intr_clr_mask = mask then
                read_sw_intr_clr_value = data_low
            else
                read_sw_intr_clr_value = (data_low - H8000_0000) and sw_intr_clr_mask
            end If
        else
            read_sw_intr_clr_value = data_low and sw_intr_clr_mask
        end If

    End Sub

    Sub write
        If flag_sw_intr_clr = &H0 Then read
        If flag_sw_intr_clr = &H0 Then write_sw_intr_clr_value = get_sw_intr_clr

        regValue = leftShift(write_sw_intr_clr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_intr_clr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_intr_clr_mask = mask then
                read_sw_intr_clr_value = data_low
            else
                read_sw_intr_clr_value = (data_low - H8000_0000) and sw_intr_clr_mask
            end If
        else
            read_sw_intr_clr_value = data_low and sw_intr_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_intr_clr_value = &H0
        flag_sw_intr_clr        = &H0
    End Sub
End Class


'' @REGISTER : CFG_qspi_io_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' strap_ip_disable_qspi                      [3:3]            get_strap_ip_disable_qspi
''                                                             set_strap_ip_disable_qspi
''                                                             read_strap_ip_disable_qspi
''                                                             write_strap_ip_disable_qspi
''---------------------------------------------------------------------------------
'' STRAP_4BYTE_ADDR_MODE                      [2:2]            get_STRAP_4BYTE_ADDR_MODE
''                                                             set_STRAP_4BYTE_ADDR_MODE
''                                                             read_STRAP_4BYTE_ADDR_MODE
''                                                             write_STRAP_4BYTE_ADDR_MODE
''---------------------------------------------------------------------------------
'' STRAP_QUAD_LANE                            [1:1]            get_STRAP_QUAD_LANE
''                                                             set_STRAP_QUAD_LANE
''                                                             read_STRAP_QUAD_LANE
''                                                             write_STRAP_QUAD_LANE
''---------------------------------------------------------------------------------
'' STRAP_DUAL_LANE                            [0:0]            get_STRAP_DUAL_LANE
''                                                             set_STRAP_DUAL_LANE
''                                                             read_STRAP_DUAL_LANE
''                                                             write_STRAP_DUAL_LANE
''---------------------------------------------------------------------------------
Class REGISTER_CFG_qspi_io_status
    Private write_strap_ip_disable_qspi_value
    Private read_strap_ip_disable_qspi_value
    Private flag_strap_ip_disable_qspi
    Private write_STRAP_4BYTE_ADDR_MODE_value
    Private read_STRAP_4BYTE_ADDR_MODE_value
    Private flag_STRAP_4BYTE_ADDR_MODE
    Private write_STRAP_QUAD_LANE_value
    Private read_STRAP_QUAD_LANE_value
    Private flag_STRAP_QUAD_LANE
    Private write_STRAP_DUAL_LANE_value
    Private read_STRAP_DUAL_LANE_value
    Private flag_STRAP_DUAL_LANE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_strap_ip_disable_qspi
        get_strap_ip_disable_qspi = read_strap_ip_disable_qspi_value
    End Property

    Property Let set_strap_ip_disable_qspi(aData)
        write_strap_ip_disable_qspi_value = aData
        flag_strap_ip_disable_qspi        = &H1
    End Property

    Property Get read_strap_ip_disable_qspi
        read
        read_strap_ip_disable_qspi = read_strap_ip_disable_qspi_value
    End Property

    Property Let write_strap_ip_disable_qspi(aData)
        set_strap_ip_disable_qspi = aData
        write
    End Property

    Property Get get_STRAP_4BYTE_ADDR_MODE
        get_STRAP_4BYTE_ADDR_MODE = read_STRAP_4BYTE_ADDR_MODE_value
    End Property

    Property Let set_STRAP_4BYTE_ADDR_MODE(aData)
        write_STRAP_4BYTE_ADDR_MODE_value = aData
        flag_STRAP_4BYTE_ADDR_MODE        = &H1
    End Property

    Property Get read_STRAP_4BYTE_ADDR_MODE
        read
        read_STRAP_4BYTE_ADDR_MODE = read_STRAP_4BYTE_ADDR_MODE_value
    End Property

    Property Let write_STRAP_4BYTE_ADDR_MODE(aData)
        set_STRAP_4BYTE_ADDR_MODE = aData
        write
    End Property

    Property Get get_STRAP_QUAD_LANE
        get_STRAP_QUAD_LANE = read_STRAP_QUAD_LANE_value
    End Property

    Property Let set_STRAP_QUAD_LANE(aData)
        write_STRAP_QUAD_LANE_value = aData
        flag_STRAP_QUAD_LANE        = &H1
    End Property

    Property Get read_STRAP_QUAD_LANE
        read
        read_STRAP_QUAD_LANE = read_STRAP_QUAD_LANE_value
    End Property

    Property Let write_STRAP_QUAD_LANE(aData)
        set_STRAP_QUAD_LANE = aData
        write
    End Property

    Property Get get_STRAP_DUAL_LANE
        get_STRAP_DUAL_LANE = read_STRAP_DUAL_LANE_value
    End Property

    Property Let set_STRAP_DUAL_LANE(aData)
        write_STRAP_DUAL_LANE_value = aData
        flag_STRAP_DUAL_LANE        = &H1
    End Property

    Property Get read_STRAP_DUAL_LANE
        read
        read_STRAP_DUAL_LANE = read_STRAP_DUAL_LANE_value
    End Property

    Property Let write_STRAP_DUAL_LANE(aData)
        set_STRAP_DUAL_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_strap_ip_disable_qspi_value = rightShift(data_low, 3) and &H1
        read_STRAP_4BYTE_ADDR_MODE_value = rightShift(data_low, 2) and &H1
        read_STRAP_QUAD_LANE_value = rightShift(data_low, 1) and &H1
        STRAP_DUAL_LANE_mask = &H1
        if data_low > LONG_MAX then
            if STRAP_DUAL_LANE_mask = mask then
                read_STRAP_DUAL_LANE_value = data_low
            else
                read_STRAP_DUAL_LANE_value = (data_low - H8000_0000) and STRAP_DUAL_LANE_mask
            end If
        else
            read_STRAP_DUAL_LANE_value = data_low and STRAP_DUAL_LANE_mask
        end If

    End Sub

    Sub write
        If flag_strap_ip_disable_qspi = &H0 or flag_STRAP_4BYTE_ADDR_MODE = &H0 or flag_STRAP_QUAD_LANE = &H0 or flag_STRAP_DUAL_LANE = &H0 Then read
        If flag_strap_ip_disable_qspi = &H0 Then write_strap_ip_disable_qspi_value = get_strap_ip_disable_qspi
        If flag_STRAP_4BYTE_ADDR_MODE = &H0 Then write_STRAP_4BYTE_ADDR_MODE_value = get_STRAP_4BYTE_ADDR_MODE
        If flag_STRAP_QUAD_LANE = &H0 Then write_STRAP_QUAD_LANE_value = get_STRAP_QUAD_LANE
        If flag_STRAP_DUAL_LANE = &H0 Then write_STRAP_DUAL_LANE_value = get_STRAP_DUAL_LANE

        regValue = leftShift((write_strap_ip_disable_qspi_value and &H1), 3) + leftShift((write_STRAP_4BYTE_ADDR_MODE_value and &H1), 2) + leftShift((write_STRAP_QUAD_LANE_value and &H1), 1) + leftShift((write_STRAP_DUAL_LANE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_strap_ip_disable_qspi_value = rightShift(data_low, 3) and &H1
        read_STRAP_4BYTE_ADDR_MODE_value = rightShift(data_low, 2) and &H1
        read_STRAP_QUAD_LANE_value = rightShift(data_low, 1) and &H1
        STRAP_DUAL_LANE_mask = &H1
        if data_low > LONG_MAX then
            if STRAP_DUAL_LANE_mask = mask then
                read_STRAP_DUAL_LANE_value = data_low
            else
                read_STRAP_DUAL_LANE_value = (data_low - H8000_0000) and STRAP_DUAL_LANE_mask
            end If
        else
            read_STRAP_DUAL_LANE_value = data_low and STRAP_DUAL_LANE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_strap_ip_disable_qspi_value = &H0
        flag_strap_ip_disable_qspi        = &H0
        write_STRAP_4BYTE_ADDR_MODE_value = &H0
        flag_STRAP_4BYTE_ADDR_MODE        = &H0
        write_STRAP_QUAD_LANE_value = &H0
        flag_STRAP_QUAD_LANE        = &H0
        write_STRAP_DUAL_LANE_value = &H0
        flag_STRAP_DUAL_LANE        = &H0
    End Sub
End Class


'' @REGISTER : CFG_qspi_io_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENABLE_ECC_DED_INTR                        [31:31]          get_ENABLE_ECC_DED_INTR
''                                                             set_ENABLE_ECC_DED_INTR
''                                                             read_ENABLE_ECC_DED_INTR
''                                                             write_ENABLE_ECC_DED_INTR
''---------------------------------------------------------------------------------
'' ENABLE_ECC_SEC_INTR                        [30:30]          get_ENABLE_ECC_SEC_INTR
''                                                             set_ENABLE_ECC_SEC_INTR
''                                                             read_ENABLE_ECC_SEC_INTR
''                                                             write_ENABLE_ECC_SEC_INTR
''---------------------------------------------------------------------------------
'' DISABLE_MSPI_FLUSH                         [10:10]          get_DISABLE_MSPI_FLUSH
''                                                             set_DISABLE_MSPI_FLUSH
''                                                             read_DISABLE_MSPI_FLUSH
''                                                             write_DISABLE_MSPI_FLUSH
''---------------------------------------------------------------------------------
'' ENABLE_RBUS_ARBITER_TIMER                  [9:9]            get_ENABLE_RBUS_ARBITER_TIMER
''                                                             set_ENABLE_RBUS_ARBITER_TIMER
''                                                             read_ENABLE_RBUS_ARBITER_TIMER
''                                                             write_ENABLE_RBUS_ARBITER_TIMER
''---------------------------------------------------------------------------------
'' ENABLE_MSPI_halt_set_transaction_done      [8:8]            get_ENABLE_MSPI_halt_set_transaction_done
''                                                             set_ENABLE_MSPI_halt_set_transaction_done
''                                                             read_ENABLE_MSPI_halt_set_transaction_done
''                                                             write_ENABLE_MSPI_halt_set_transaction_done
''---------------------------------------------------------------------------------
'' ENABLE_MSPI_done                           [7:7]            get_ENABLE_MSPI_done
''                                                             set_ENABLE_MSPI_done
''                                                             read_ENABLE_MSPI_done
''                                                             write_ENABLE_MSPI_done
''---------------------------------------------------------------------------------
'' ENABLE_spi_overread                        [6:6]            get_ENABLE_spi_overread
''                                                             set_ENABLE_spi_overread
''                                                             read_ENABLE_spi_overread
''                                                             write_ENABLE_spi_overread
''---------------------------------------------------------------------------------
'' ENABLE_spi_LR_session_done                 [5:5]            get_ENABLE_spi_LR_session_done
''                                                             set_ENABLE_spi_LR_session_done
''                                                             read_ENABLE_spi_LR_session_done
''                                                             write_ENABLE_spi_LR_session_done
''---------------------------------------------------------------------------------
'' ENABLE_spi_LR_impatient                    [4:4]            get_ENABLE_spi_LR_impatient
''                                                             set_ENABLE_spi_LR_impatient
''                                                             read_ENABLE_spi_LR_impatient
''                                                             write_ENABLE_spi_LR_impatient
''---------------------------------------------------------------------------------
'' ENABLE_spi_LR_truncated                    [3:3]            get_ENABLE_spi_LR_truncated
''                                                             set_ENABLE_spi_LR_truncated
''                                                             read_ENABLE_spi_LR_truncated
''                                                             write_ENABLE_spi_LR_truncated
''---------------------------------------------------------------------------------
'' ENABLE_spi_LR_fullness_reached             [2:2]            get_ENABLE_spi_LR_fullness_reached
''                                                             set_ENABLE_spi_LR_fullness_reached
''                                                             read_ENABLE_spi_LR_fullness_reached
''                                                             write_ENABLE_spi_LR_fullness_reached
''---------------------------------------------------------------------------------
'' clk_enable                                 [0:0]            get_clk_enable
''                                                             set_clk_enable
''                                                             read_clk_enable
''                                                             write_clk_enable
''---------------------------------------------------------------------------------
Class REGISTER_CFG_qspi_io_control
    Private write_ENABLE_ECC_DED_INTR_value
    Private read_ENABLE_ECC_DED_INTR_value
    Private flag_ENABLE_ECC_DED_INTR
    Private write_ENABLE_ECC_SEC_INTR_value
    Private read_ENABLE_ECC_SEC_INTR_value
    Private flag_ENABLE_ECC_SEC_INTR
    Private write_DISABLE_MSPI_FLUSH_value
    Private read_DISABLE_MSPI_FLUSH_value
    Private flag_DISABLE_MSPI_FLUSH
    Private write_ENABLE_RBUS_ARBITER_TIMER_value
    Private read_ENABLE_RBUS_ARBITER_TIMER_value
    Private flag_ENABLE_RBUS_ARBITER_TIMER
    Private write_ENABLE_MSPI_halt_set_transaction_done_value
    Private read_ENABLE_MSPI_halt_set_transaction_done_value
    Private flag_ENABLE_MSPI_halt_set_transaction_done
    Private write_ENABLE_MSPI_done_value
    Private read_ENABLE_MSPI_done_value
    Private flag_ENABLE_MSPI_done
    Private write_ENABLE_spi_overread_value
    Private read_ENABLE_spi_overread_value
    Private flag_ENABLE_spi_overread
    Private write_ENABLE_spi_LR_session_done_value
    Private read_ENABLE_spi_LR_session_done_value
    Private flag_ENABLE_spi_LR_session_done
    Private write_ENABLE_spi_LR_impatient_value
    Private read_ENABLE_spi_LR_impatient_value
    Private flag_ENABLE_spi_LR_impatient
    Private write_ENABLE_spi_LR_truncated_value
    Private read_ENABLE_spi_LR_truncated_value
    Private flag_ENABLE_spi_LR_truncated
    Private write_ENABLE_spi_LR_fullness_reached_value
    Private read_ENABLE_spi_LR_fullness_reached_value
    Private flag_ENABLE_spi_LR_fullness_reached
    Private write_clk_enable_value
    Private read_clk_enable_value
    Private flag_clk_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ENABLE_ECC_DED_INTR
        get_ENABLE_ECC_DED_INTR = read_ENABLE_ECC_DED_INTR_value
    End Property

    Property Let set_ENABLE_ECC_DED_INTR(aData)
        write_ENABLE_ECC_DED_INTR_value = aData
        flag_ENABLE_ECC_DED_INTR        = &H1
    End Property

    Property Get read_ENABLE_ECC_DED_INTR
        read
        read_ENABLE_ECC_DED_INTR = read_ENABLE_ECC_DED_INTR_value
    End Property

    Property Let write_ENABLE_ECC_DED_INTR(aData)
        set_ENABLE_ECC_DED_INTR = aData
        write
    End Property

    Property Get get_ENABLE_ECC_SEC_INTR
        get_ENABLE_ECC_SEC_INTR = read_ENABLE_ECC_SEC_INTR_value
    End Property

    Property Let set_ENABLE_ECC_SEC_INTR(aData)
        write_ENABLE_ECC_SEC_INTR_value = aData
        flag_ENABLE_ECC_SEC_INTR        = &H1
    End Property

    Property Get read_ENABLE_ECC_SEC_INTR
        read
        read_ENABLE_ECC_SEC_INTR = read_ENABLE_ECC_SEC_INTR_value
    End Property

    Property Let write_ENABLE_ECC_SEC_INTR(aData)
        set_ENABLE_ECC_SEC_INTR = aData
        write
    End Property

    Property Get get_DISABLE_MSPI_FLUSH
        get_DISABLE_MSPI_FLUSH = read_DISABLE_MSPI_FLUSH_value
    End Property

    Property Let set_DISABLE_MSPI_FLUSH(aData)
        write_DISABLE_MSPI_FLUSH_value = aData
        flag_DISABLE_MSPI_FLUSH        = &H1
    End Property

    Property Get read_DISABLE_MSPI_FLUSH
        read
        read_DISABLE_MSPI_FLUSH = read_DISABLE_MSPI_FLUSH_value
    End Property

    Property Let write_DISABLE_MSPI_FLUSH(aData)
        set_DISABLE_MSPI_FLUSH = aData
        write
    End Property

    Property Get get_ENABLE_RBUS_ARBITER_TIMER
        get_ENABLE_RBUS_ARBITER_TIMER = read_ENABLE_RBUS_ARBITER_TIMER_value
    End Property

    Property Let set_ENABLE_RBUS_ARBITER_TIMER(aData)
        write_ENABLE_RBUS_ARBITER_TIMER_value = aData
        flag_ENABLE_RBUS_ARBITER_TIMER        = &H1
    End Property

    Property Get read_ENABLE_RBUS_ARBITER_TIMER
        read
        read_ENABLE_RBUS_ARBITER_TIMER = read_ENABLE_RBUS_ARBITER_TIMER_value
    End Property

    Property Let write_ENABLE_RBUS_ARBITER_TIMER(aData)
        set_ENABLE_RBUS_ARBITER_TIMER = aData
        write
    End Property

    Property Get get_ENABLE_MSPI_halt_set_transaction_done
        get_ENABLE_MSPI_halt_set_transaction_done = read_ENABLE_MSPI_halt_set_transaction_done_value
    End Property

    Property Let set_ENABLE_MSPI_halt_set_transaction_done(aData)
        write_ENABLE_MSPI_halt_set_transaction_done_value = aData
        flag_ENABLE_MSPI_halt_set_transaction_done        = &H1
    End Property

    Property Get read_ENABLE_MSPI_halt_set_transaction_done
        read
        read_ENABLE_MSPI_halt_set_transaction_done = read_ENABLE_MSPI_halt_set_transaction_done_value
    End Property

    Property Let write_ENABLE_MSPI_halt_set_transaction_done(aData)
        set_ENABLE_MSPI_halt_set_transaction_done = aData
        write
    End Property

    Property Get get_ENABLE_MSPI_done
        get_ENABLE_MSPI_done = read_ENABLE_MSPI_done_value
    End Property

    Property Let set_ENABLE_MSPI_done(aData)
        write_ENABLE_MSPI_done_value = aData
        flag_ENABLE_MSPI_done        = &H1
    End Property

    Property Get read_ENABLE_MSPI_done
        read
        read_ENABLE_MSPI_done = read_ENABLE_MSPI_done_value
    End Property

    Property Let write_ENABLE_MSPI_done(aData)
        set_ENABLE_MSPI_done = aData
        write
    End Property

    Property Get get_ENABLE_spi_overread
        get_ENABLE_spi_overread = read_ENABLE_spi_overread_value
    End Property

    Property Let set_ENABLE_spi_overread(aData)
        write_ENABLE_spi_overread_value = aData
        flag_ENABLE_spi_overread        = &H1
    End Property

    Property Get read_ENABLE_spi_overread
        read
        read_ENABLE_spi_overread = read_ENABLE_spi_overread_value
    End Property

    Property Let write_ENABLE_spi_overread(aData)
        set_ENABLE_spi_overread = aData
        write
    End Property

    Property Get get_ENABLE_spi_LR_session_done
        get_ENABLE_spi_LR_session_done = read_ENABLE_spi_LR_session_done_value
    End Property

    Property Let set_ENABLE_spi_LR_session_done(aData)
        write_ENABLE_spi_LR_session_done_value = aData
        flag_ENABLE_spi_LR_session_done        = &H1
    End Property

    Property Get read_ENABLE_spi_LR_session_done
        read
        read_ENABLE_spi_LR_session_done = read_ENABLE_spi_LR_session_done_value
    End Property

    Property Let write_ENABLE_spi_LR_session_done(aData)
        set_ENABLE_spi_LR_session_done = aData
        write
    End Property

    Property Get get_ENABLE_spi_LR_impatient
        get_ENABLE_spi_LR_impatient = read_ENABLE_spi_LR_impatient_value
    End Property

    Property Let set_ENABLE_spi_LR_impatient(aData)
        write_ENABLE_spi_LR_impatient_value = aData
        flag_ENABLE_spi_LR_impatient        = &H1
    End Property

    Property Get read_ENABLE_spi_LR_impatient
        read
        read_ENABLE_spi_LR_impatient = read_ENABLE_spi_LR_impatient_value
    End Property

    Property Let write_ENABLE_spi_LR_impatient(aData)
        set_ENABLE_spi_LR_impatient = aData
        write
    End Property

    Property Get get_ENABLE_spi_LR_truncated
        get_ENABLE_spi_LR_truncated = read_ENABLE_spi_LR_truncated_value
    End Property

    Property Let set_ENABLE_spi_LR_truncated(aData)
        write_ENABLE_spi_LR_truncated_value = aData
        flag_ENABLE_spi_LR_truncated        = &H1
    End Property

    Property Get read_ENABLE_spi_LR_truncated
        read
        read_ENABLE_spi_LR_truncated = read_ENABLE_spi_LR_truncated_value
    End Property

    Property Let write_ENABLE_spi_LR_truncated(aData)
        set_ENABLE_spi_LR_truncated = aData
        write
    End Property

    Property Get get_ENABLE_spi_LR_fullness_reached
        get_ENABLE_spi_LR_fullness_reached = read_ENABLE_spi_LR_fullness_reached_value
    End Property

    Property Let set_ENABLE_spi_LR_fullness_reached(aData)
        write_ENABLE_spi_LR_fullness_reached_value = aData
        flag_ENABLE_spi_LR_fullness_reached        = &H1
    End Property

    Property Get read_ENABLE_spi_LR_fullness_reached
        read
        read_ENABLE_spi_LR_fullness_reached = read_ENABLE_spi_LR_fullness_reached_value
    End Property

    Property Let write_ENABLE_spi_LR_fullness_reached(aData)
        set_ENABLE_spi_LR_fullness_reached = aData
        write
    End Property

    Property Get get_clk_enable
        get_clk_enable = read_clk_enable_value
    End Property

    Property Let set_clk_enable(aData)
        write_clk_enable_value = aData
        flag_clk_enable        = &H1
    End Property

    Property Get read_clk_enable
        read
        read_clk_enable = read_clk_enable_value
    End Property

    Property Let write_clk_enable(aData)
        set_clk_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENABLE_ECC_DED_INTR_value = rightShift(data_low, 31) and &H1
        read_ENABLE_ECC_SEC_INTR_value = rightShift(data_low, 30) and &H1
        read_DISABLE_MSPI_FLUSH_value = rightShift(data_low, 10) and &H1
        read_ENABLE_RBUS_ARBITER_TIMER_value = rightShift(data_low, 9) and &H1
        read_ENABLE_MSPI_halt_set_transaction_done_value = rightShift(data_low, 8) and &H1
        read_ENABLE_MSPI_done_value = rightShift(data_low, 7) and &H1
        read_ENABLE_spi_overread_value = rightShift(data_low, 6) and &H1
        read_ENABLE_spi_LR_session_done_value = rightShift(data_low, 5) and &H1
        read_ENABLE_spi_LR_impatient_value = rightShift(data_low, 4) and &H1
        read_ENABLE_spi_LR_truncated_value = rightShift(data_low, 3) and &H1
        read_ENABLE_spi_LR_fullness_reached_value = rightShift(data_low, 2) and &H1
        clk_enable_mask = &H1
        if data_low > LONG_MAX then
            if clk_enable_mask = mask then
                read_clk_enable_value = data_low
            else
                read_clk_enable_value = (data_low - H8000_0000) and clk_enable_mask
            end If
        else
            read_clk_enable_value = data_low and clk_enable_mask
        end If

    End Sub

    Sub write
        If flag_ENABLE_ECC_DED_INTR = &H0 or flag_ENABLE_ECC_SEC_INTR = &H0 or flag_DISABLE_MSPI_FLUSH = &H0 or flag_ENABLE_RBUS_ARBITER_TIMER = &H0 or flag_ENABLE_MSPI_halt_set_transaction_done = &H0 or flag_ENABLE_MSPI_done = &H0 or flag_ENABLE_spi_overread = &H0 or flag_ENABLE_spi_LR_session_done = &H0 or flag_ENABLE_spi_LR_impatient = &H0 or flag_ENABLE_spi_LR_truncated = &H0 or flag_ENABLE_spi_LR_fullness_reached = &H0 or flag_clk_enable = &H0 Then read
        If flag_ENABLE_ECC_DED_INTR = &H0 Then write_ENABLE_ECC_DED_INTR_value = get_ENABLE_ECC_DED_INTR
        If flag_ENABLE_ECC_SEC_INTR = &H0 Then write_ENABLE_ECC_SEC_INTR_value = get_ENABLE_ECC_SEC_INTR
        If flag_DISABLE_MSPI_FLUSH = &H0 Then write_DISABLE_MSPI_FLUSH_value = get_DISABLE_MSPI_FLUSH
        If flag_ENABLE_RBUS_ARBITER_TIMER = &H0 Then write_ENABLE_RBUS_ARBITER_TIMER_value = get_ENABLE_RBUS_ARBITER_TIMER
        If flag_ENABLE_MSPI_halt_set_transaction_done = &H0 Then write_ENABLE_MSPI_halt_set_transaction_done_value = get_ENABLE_MSPI_halt_set_transaction_done
        If flag_ENABLE_MSPI_done = &H0 Then write_ENABLE_MSPI_done_value = get_ENABLE_MSPI_done
        If flag_ENABLE_spi_overread = &H0 Then write_ENABLE_spi_overread_value = get_ENABLE_spi_overread
        If flag_ENABLE_spi_LR_session_done = &H0 Then write_ENABLE_spi_LR_session_done_value = get_ENABLE_spi_LR_session_done
        If flag_ENABLE_spi_LR_impatient = &H0 Then write_ENABLE_spi_LR_impatient_value = get_ENABLE_spi_LR_impatient
        If flag_ENABLE_spi_LR_truncated = &H0 Then write_ENABLE_spi_LR_truncated_value = get_ENABLE_spi_LR_truncated
        If flag_ENABLE_spi_LR_fullness_reached = &H0 Then write_ENABLE_spi_LR_fullness_reached_value = get_ENABLE_spi_LR_fullness_reached
        If flag_clk_enable = &H0 Then write_clk_enable_value = get_clk_enable

        regValue = leftShift((write_ENABLE_ECC_DED_INTR_value and &H1), 31) + leftShift((write_ENABLE_ECC_SEC_INTR_value and &H1), 30) + leftShift((write_DISABLE_MSPI_FLUSH_value and &H1), 10) + leftShift((write_ENABLE_RBUS_ARBITER_TIMER_value and &H1), 9) + leftShift((write_ENABLE_MSPI_halt_set_transaction_done_value and &H1), 8) + leftShift((write_ENABLE_MSPI_done_value and &H1), 7) + leftShift((write_ENABLE_spi_overread_value and &H1), 6) + leftShift((write_ENABLE_spi_LR_session_done_value and &H1), 5) + leftShift((write_ENABLE_spi_LR_impatient_value and &H1), 4) + leftShift((write_ENABLE_spi_LR_truncated_value and &H1), 3) + leftShift((write_ENABLE_spi_LR_fullness_reached_value and &H1), 2) + leftShift((write_clk_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENABLE_ECC_DED_INTR_value = rightShift(data_low, 31) and &H1
        read_ENABLE_ECC_SEC_INTR_value = rightShift(data_low, 30) and &H1
        read_DISABLE_MSPI_FLUSH_value = rightShift(data_low, 10) and &H1
        read_ENABLE_RBUS_ARBITER_TIMER_value = rightShift(data_low, 9) and &H1
        read_ENABLE_MSPI_halt_set_transaction_done_value = rightShift(data_low, 8) and &H1
        read_ENABLE_MSPI_done_value = rightShift(data_low, 7) and &H1
        read_ENABLE_spi_overread_value = rightShift(data_low, 6) and &H1
        read_ENABLE_spi_LR_session_done_value = rightShift(data_low, 5) and &H1
        read_ENABLE_spi_LR_impatient_value = rightShift(data_low, 4) and &H1
        read_ENABLE_spi_LR_truncated_value = rightShift(data_low, 3) and &H1
        read_ENABLE_spi_LR_fullness_reached_value = rightShift(data_low, 2) and &H1
        clk_enable_mask = &H1
        if data_low > LONG_MAX then
            if clk_enable_mask = mask then
                read_clk_enable_value = data_low
            else
                read_clk_enable_value = (data_low - H8000_0000) and clk_enable_mask
            end If
        else
            read_clk_enable_value = data_low and clk_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENABLE_ECC_DED_INTR_value = &H0
        flag_ENABLE_ECC_DED_INTR        = &H0
        write_ENABLE_ECC_SEC_INTR_value = &H0
        flag_ENABLE_ECC_SEC_INTR        = &H0
        write_DISABLE_MSPI_FLUSH_value = &H0
        flag_DISABLE_MSPI_FLUSH        = &H0
        write_ENABLE_RBUS_ARBITER_TIMER_value = &H0
        flag_ENABLE_RBUS_ARBITER_TIMER        = &H0
        write_ENABLE_MSPI_halt_set_transaction_done_value = &H0
        flag_ENABLE_MSPI_halt_set_transaction_done        = &H0
        write_ENABLE_MSPI_done_value = &H0
        flag_ENABLE_MSPI_done        = &H0
        write_ENABLE_spi_overread_value = &H0
        flag_ENABLE_spi_overread        = &H0
        write_ENABLE_spi_LR_session_done_value = &H0
        flag_ENABLE_spi_LR_session_done        = &H0
        write_ENABLE_spi_LR_impatient_value = &H0
        flag_ENABLE_spi_LR_impatient        = &H0
        write_ENABLE_spi_LR_truncated_value = &H0
        flag_ENABLE_spi_LR_truncated        = &H0
        write_ENABLE_spi_LR_fullness_reached_value = &H0
        flag_ENABLE_spi_LR_fullness_reached        = &H0
        write_clk_enable_value = &H0
        flag_clk_enable        = &H0
    End Sub
End Class


'' @REGISTER : CFG_qspi_ip_revid
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' QSPI_REVID                                 [7:0]            get_QSPI_REVID
''                                                             set_QSPI_REVID
''                                                             read_QSPI_REVID
''                                                             write_QSPI_REVID
''---------------------------------------------------------------------------------
Class REGISTER_CFG_qspi_ip_revid
    Private write_QSPI_REVID_value
    Private read_QSPI_REVID_value
    Private flag_QSPI_REVID

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_QSPI_REVID
        get_QSPI_REVID = read_QSPI_REVID_value
    End Property

    Property Let set_QSPI_REVID(aData)
        write_QSPI_REVID_value = aData
        flag_QSPI_REVID        = &H1
    End Property

    Property Get read_QSPI_REVID
        read
        read_QSPI_REVID = read_QSPI_REVID_value
    End Property

    Property Let write_QSPI_REVID(aData)
        set_QSPI_REVID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        QSPI_REVID_mask = &Hff
        if data_low > LONG_MAX then
            if QSPI_REVID_mask = mask then
                read_QSPI_REVID_value = data_low
            else
                read_QSPI_REVID_value = (data_low - H8000_0000) and QSPI_REVID_mask
            end If
        else
            read_QSPI_REVID_value = data_low and QSPI_REVID_mask
        end If

    End Sub

    Sub write
        If flag_QSPI_REVID = &H0 Then read
        If flag_QSPI_REVID = &H0 Then write_QSPI_REVID_value = get_QSPI_REVID

        regValue = leftShift((write_QSPI_REVID_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        QSPI_REVID_mask = &Hff
        if data_low > LONG_MAX then
            if QSPI_REVID_mask = mask then
                read_QSPI_REVID_value = data_low
            else
                read_QSPI_REVID_value = (data_low - H8000_0000) and QSPI_REVID_mask
            end If
        else
            read_QSPI_REVID_value = data_low and QSPI_REVID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_QSPI_REVID_value = &H0
        flag_QSPI_REVID        = &H0
    End Sub
End Class


'' @REGISTER : CFG_spi_crc_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' crc_clear                                  [1:1]            get_crc_clear
''                                                             set_crc_clear
''                                                             read_crc_clear
''                                                             write_crc_clear
''---------------------------------------------------------------------------------
'' crc_enable                                 [0:0]            get_crc_enable
''                                                             set_crc_enable
''                                                             read_crc_enable
''                                                             write_crc_enable
''---------------------------------------------------------------------------------
Class REGISTER_CFG_spi_crc_control
    Private write_crc_clear_value
    Private read_crc_clear_value
    Private flag_crc_clear
    Private write_crc_enable_value
    Private read_crc_enable_value
    Private flag_crc_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_crc_clear
        get_crc_clear = read_crc_clear_value
    End Property

    Property Let set_crc_clear(aData)
        write_crc_clear_value = aData
        flag_crc_clear        = &H1
    End Property

    Property Get read_crc_clear
        read
        read_crc_clear = read_crc_clear_value
    End Property

    Property Let write_crc_clear(aData)
        set_crc_clear = aData
        write
    End Property

    Property Get get_crc_enable
        get_crc_enable = read_crc_enable_value
    End Property

    Property Let set_crc_enable(aData)
        write_crc_enable_value = aData
        flag_crc_enable        = &H1
    End Property

    Property Get read_crc_enable
        read
        read_crc_enable = read_crc_enable_value
    End Property

    Property Let write_crc_enable(aData)
        set_crc_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_crc_clear_value = rightShift(data_low, 1) and &H1
        crc_enable_mask = &H1
        if data_low > LONG_MAX then
            if crc_enable_mask = mask then
                read_crc_enable_value = data_low
            else
                read_crc_enable_value = (data_low - H8000_0000) and crc_enable_mask
            end If
        else
            read_crc_enable_value = data_low and crc_enable_mask
        end If

    End Sub

    Sub write
        If flag_crc_clear = &H0 or flag_crc_enable = &H0 Then read
        If flag_crc_clear = &H0 Then write_crc_clear_value = get_crc_clear
        If flag_crc_enable = &H0 Then write_crc_enable_value = get_crc_enable

        regValue = leftShift((write_crc_clear_value and &H1), 1) + leftShift((write_crc_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_crc_clear_value = rightShift(data_low, 1) and &H1
        crc_enable_mask = &H1
        if data_low > LONG_MAX then
            if crc_enable_mask = mask then
                read_crc_enable_value = data_low
            else
                read_crc_enable_value = (data_low - H8000_0000) and crc_enable_mask
            end If
        else
            read_crc_enable_value = data_low and crc_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_crc_clear_value = &H0
        flag_crc_clear        = &H0
        write_crc_enable_value = &H0
        flag_crc_enable        = &H0
    End Sub
End Class


'' @REGISTER : CFG_spi_crc_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' qspi_output                                [31:0]           get_qspi_output
''                                                             set_qspi_output
''                                                             read_qspi_output
''                                                             write_qspi_output
''---------------------------------------------------------------------------------
Class REGISTER_CFG_spi_crc_status
    Private write_qspi_output_value
    Private read_qspi_output_value
    Private flag_qspi_output

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_qspi_output
        get_qspi_output = read_qspi_output_value
    End Property

    Property Let set_qspi_output(aData)
        write_qspi_output_value = aData
        flag_qspi_output        = &H1
    End Property

    Property Get read_qspi_output
        read
        read_qspi_output = read_qspi_output_value
    End Property

    Property Let write_qspi_output(aData)
        set_qspi_output = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        qspi_output_mask = &Hffffffff
        if data_low > LONG_MAX then
            if qspi_output_mask = mask then
                read_qspi_output_value = data_low
            else
                read_qspi_output_value = (data_low - H8000_0000) and qspi_output_mask
            end If
        else
            read_qspi_output_value = data_low and qspi_output_mask
        end If

    End Sub

    Sub write
        If flag_qspi_output = &H0 Then read
        If flag_qspi_output = &H0 Then write_qspi_output_value = get_qspi_output

        regValue = leftShift(write_qspi_output_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        qspi_output_mask = &Hffffffff
        if data_low > LONG_MAX then
            if qspi_output_mask = mask then
                read_qspi_output_value = data_low
            else
                read_qspi_output_value = (data_low - H8000_0000) and qspi_output_mask
            end If
        else
            read_qspi_output_value = data_low and qspi_output_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_qspi_output_value = &H0
        flag_qspi_output        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_cfg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' soft2vic_intr_cfg                          [2:2]            get_soft2vic_intr_cfg
''                                                             set_soft2vic_intr_cfg
''                                                             read_soft2vic_intr_cfg
''                                                             write_soft2vic_intr_cfg
''---------------------------------------------------------------------------------
'' pad_intr_n_sel                             [1:1]            get_pad_intr_n_sel
''                                                             set_pad_intr_n_sel
''                                                             read_pad_intr_n_sel
''                                                             write_pad_intr_n_sel
''---------------------------------------------------------------------------------
'' pad_intr_n_mode                            [0:0]            get_pad_intr_n_mode
''                                                             set_pad_intr_n_mode
''                                                             read_pad_intr_n_mode
''                                                             write_pad_intr_n_mode
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_cfg
    Private write_soft2vic_intr_cfg_value
    Private read_soft2vic_intr_cfg_value
    Private flag_soft2vic_intr_cfg
    Private write_pad_intr_n_sel_value
    Private read_pad_intr_n_sel_value
    Private flag_pad_intr_n_sel
    Private write_pad_intr_n_mode_value
    Private read_pad_intr_n_mode_value
    Private flag_pad_intr_n_mode

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_soft2vic_intr_cfg
        get_soft2vic_intr_cfg = read_soft2vic_intr_cfg_value
    End Property

    Property Let set_soft2vic_intr_cfg(aData)
        write_soft2vic_intr_cfg_value = aData
        flag_soft2vic_intr_cfg        = &H1
    End Property

    Property Get read_soft2vic_intr_cfg
        read
        read_soft2vic_intr_cfg = read_soft2vic_intr_cfg_value
    End Property

    Property Let write_soft2vic_intr_cfg(aData)
        set_soft2vic_intr_cfg = aData
        write
    End Property

    Property Get get_pad_intr_n_sel
        get_pad_intr_n_sel = read_pad_intr_n_sel_value
    End Property

    Property Let set_pad_intr_n_sel(aData)
        write_pad_intr_n_sel_value = aData
        flag_pad_intr_n_sel        = &H1
    End Property

    Property Get read_pad_intr_n_sel
        read
        read_pad_intr_n_sel = read_pad_intr_n_sel_value
    End Property

    Property Let write_pad_intr_n_sel(aData)
        set_pad_intr_n_sel = aData
        write
    End Property

    Property Get get_pad_intr_n_mode
        get_pad_intr_n_mode = read_pad_intr_n_mode_value
    End Property

    Property Let set_pad_intr_n_mode(aData)
        write_pad_intr_n_mode_value = aData
        flag_pad_intr_n_mode        = &H1
    End Property

    Property Get read_pad_intr_n_mode
        read
        read_pad_intr_n_mode = read_pad_intr_n_mode_value
    End Property

    Property Let write_pad_intr_n_mode(aData)
        set_pad_intr_n_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_soft2vic_intr_cfg_value = rightShift(data_low, 2) and &H1
        read_pad_intr_n_sel_value = rightShift(data_low, 1) and &H1
        pad_intr_n_mode_mask = &H1
        if data_low > LONG_MAX then
            if pad_intr_n_mode_mask = mask then
                read_pad_intr_n_mode_value = data_low
            else
                read_pad_intr_n_mode_value = (data_low - H8000_0000) and pad_intr_n_mode_mask
            end If
        else
            read_pad_intr_n_mode_value = data_low and pad_intr_n_mode_mask
        end If

    End Sub

    Sub write
        If flag_soft2vic_intr_cfg = &H0 or flag_pad_intr_n_sel = &H0 or flag_pad_intr_n_mode = &H0 Then read
        If flag_soft2vic_intr_cfg = &H0 Then write_soft2vic_intr_cfg_value = get_soft2vic_intr_cfg
        If flag_pad_intr_n_sel = &H0 Then write_pad_intr_n_sel_value = get_pad_intr_n_sel
        If flag_pad_intr_n_mode = &H0 Then write_pad_intr_n_mode_value = get_pad_intr_n_mode

        regValue = leftShift((write_soft2vic_intr_cfg_value and &H1), 2) + leftShift((write_pad_intr_n_sel_value and &H1), 1) + leftShift((write_pad_intr_n_mode_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_soft2vic_intr_cfg_value = rightShift(data_low, 2) and &H1
        read_pad_intr_n_sel_value = rightShift(data_low, 1) and &H1
        pad_intr_n_mode_mask = &H1
        if data_low > LONG_MAX then
            if pad_intr_n_mode_mask = mask then
                read_pad_intr_n_mode_value = data_low
            else
                read_pad_intr_n_mode_value = (data_low - H8000_0000) and pad_intr_n_mode_mask
            end If
        else
            read_pad_intr_n_mode_value = data_low and pad_intr_n_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_soft2vic_intr_cfg_value = &H0
        flag_soft2vic_intr_cfg        = &H0
        write_pad_intr_n_sel_value = &H0
        flag_pad_intr_n_sel        = &H0
        write_pad_intr_n_mode_value = &H0
        flag_pad_intr_n_mode        = &H0
    End Sub
End Class


'' @REGISTER : CFG_spi_crc_idle_cycle_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' crc_idle_cycle_count                       [31:0]           get_crc_idle_cycle_count
''                                                             set_crc_idle_cycle_count
''                                                             read_crc_idle_cycle_count
''                                                             write_crc_idle_cycle_count
''---------------------------------------------------------------------------------
Class REGISTER_CFG_spi_crc_idle_cycle_count
    Private write_crc_idle_cycle_count_value
    Private read_crc_idle_cycle_count_value
    Private flag_crc_idle_cycle_count

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H70
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_crc_idle_cycle_count
        get_crc_idle_cycle_count = read_crc_idle_cycle_count_value
    End Property

    Property Let set_crc_idle_cycle_count(aData)
        write_crc_idle_cycle_count_value = aData
        flag_crc_idle_cycle_count        = &H1
    End Property

    Property Get read_crc_idle_cycle_count
        read
        read_crc_idle_cycle_count = read_crc_idle_cycle_count_value
    End Property

    Property Let write_crc_idle_cycle_count(aData)
        set_crc_idle_cycle_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        crc_idle_cycle_count_mask = &Hffffffff
        if data_low > LONG_MAX then
            if crc_idle_cycle_count_mask = mask then
                read_crc_idle_cycle_count_value = data_low
            else
                read_crc_idle_cycle_count_value = (data_low - H8000_0000) and crc_idle_cycle_count_mask
            end If
        else
            read_crc_idle_cycle_count_value = data_low and crc_idle_cycle_count_mask
        end If

    End Sub

    Sub write
        If flag_crc_idle_cycle_count = &H0 Then read
        If flag_crc_idle_cycle_count = &H0 Then write_crc_idle_cycle_count_value = get_crc_idle_cycle_count

        regValue = leftShift(write_crc_idle_cycle_count_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        crc_idle_cycle_count_mask = &Hffffffff
        if data_low > LONG_MAX then
            if crc_idle_cycle_count_mask = mask then
                read_crc_idle_cycle_count_value = data_low
            else
                read_crc_idle_cycle_count_value = (data_low - H8000_0000) and crc_idle_cycle_count_mask
            end If
        else
            read_crc_idle_cycle_count_value = data_low and crc_idle_cycle_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_crc_idle_cycle_count_value = &H0
        flag_crc_idle_cycle_count        = &H0
    End Sub
End Class


'' @REGISTER : CFG_ahb2rdb_timeout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ahb2rdb_timeout_qspi                       [18:18]          get_ahb2rdb_timeout_qspi
''                                                             set_ahb2rdb_timeout_qspi
''                                                             read_ahb2rdb_timeout_qspi
''                                                             write_ahb2rdb_timeout_qspi
''---------------------------------------------------------------------------------
'' ahb2rdb_timeout_rdb16                      [17:17]          get_ahb2rdb_timeout_rdb16
''                                                             set_ahb2rdb_timeout_rdb16
''                                                             read_ahb2rdb_timeout_rdb16
''                                                             write_ahb2rdb_timeout_rdb16
''---------------------------------------------------------------------------------
'' ahb2rdb_timeout_srab                       [16:16]          get_ahb2rdb_timeout_srab
''                                                             set_ahb2rdb_timeout_srab
''                                                             read_ahb2rdb_timeout_srab
''                                                             write_ahb2rdb_timeout_srab
''---------------------------------------------------------------------------------
'' ahb2rdb_timeout_time                       [15:0]           get_ahb2rdb_timeout_time
''                                                             set_ahb2rdb_timeout_time
''                                                             read_ahb2rdb_timeout_time
''                                                             write_ahb2rdb_timeout_time
''---------------------------------------------------------------------------------
Class REGISTER_CFG_ahb2rdb_timeout
    Private write_ahb2rdb_timeout_qspi_value
    Private read_ahb2rdb_timeout_qspi_value
    Private flag_ahb2rdb_timeout_qspi
    Private write_ahb2rdb_timeout_rdb16_value
    Private read_ahb2rdb_timeout_rdb16_value
    Private flag_ahb2rdb_timeout_rdb16
    Private write_ahb2rdb_timeout_srab_value
    Private read_ahb2rdb_timeout_srab_value
    Private flag_ahb2rdb_timeout_srab
    Private write_ahb2rdb_timeout_time_value
    Private read_ahb2rdb_timeout_time_value
    Private flag_ahb2rdb_timeout_time

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H74
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ahb2rdb_timeout_qspi
        get_ahb2rdb_timeout_qspi = read_ahb2rdb_timeout_qspi_value
    End Property

    Property Let set_ahb2rdb_timeout_qspi(aData)
        write_ahb2rdb_timeout_qspi_value = aData
        flag_ahb2rdb_timeout_qspi        = &H1
    End Property

    Property Get read_ahb2rdb_timeout_qspi
        read
        read_ahb2rdb_timeout_qspi = read_ahb2rdb_timeout_qspi_value
    End Property

    Property Let write_ahb2rdb_timeout_qspi(aData)
        set_ahb2rdb_timeout_qspi = aData
        write
    End Property

    Property Get get_ahb2rdb_timeout_rdb16
        get_ahb2rdb_timeout_rdb16 = read_ahb2rdb_timeout_rdb16_value
    End Property

    Property Let set_ahb2rdb_timeout_rdb16(aData)
        write_ahb2rdb_timeout_rdb16_value = aData
        flag_ahb2rdb_timeout_rdb16        = &H1
    End Property

    Property Get read_ahb2rdb_timeout_rdb16
        read
        read_ahb2rdb_timeout_rdb16 = read_ahb2rdb_timeout_rdb16_value
    End Property

    Property Let write_ahb2rdb_timeout_rdb16(aData)
        set_ahb2rdb_timeout_rdb16 = aData
        write
    End Property

    Property Get get_ahb2rdb_timeout_srab
        get_ahb2rdb_timeout_srab = read_ahb2rdb_timeout_srab_value
    End Property

    Property Let set_ahb2rdb_timeout_srab(aData)
        write_ahb2rdb_timeout_srab_value = aData
        flag_ahb2rdb_timeout_srab        = &H1
    End Property

    Property Get read_ahb2rdb_timeout_srab
        read
        read_ahb2rdb_timeout_srab = read_ahb2rdb_timeout_srab_value
    End Property

    Property Let write_ahb2rdb_timeout_srab(aData)
        set_ahb2rdb_timeout_srab = aData
        write
    End Property

    Property Get get_ahb2rdb_timeout_time
        get_ahb2rdb_timeout_time = read_ahb2rdb_timeout_time_value
    End Property

    Property Let set_ahb2rdb_timeout_time(aData)
        write_ahb2rdb_timeout_time_value = aData
        flag_ahb2rdb_timeout_time        = &H1
    End Property

    Property Get read_ahb2rdb_timeout_time
        read
        read_ahb2rdb_timeout_time = read_ahb2rdb_timeout_time_value
    End Property

    Property Let write_ahb2rdb_timeout_time(aData)
        set_ahb2rdb_timeout_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ahb2rdb_timeout_qspi_value = rightShift(data_low, 18) and &H1
        read_ahb2rdb_timeout_rdb16_value = rightShift(data_low, 17) and &H1
        read_ahb2rdb_timeout_srab_value = rightShift(data_low, 16) and &H1
        ahb2rdb_timeout_time_mask = &Hffff
        if data_low > LONG_MAX then
            if ahb2rdb_timeout_time_mask = mask then
                read_ahb2rdb_timeout_time_value = data_low
            else
                read_ahb2rdb_timeout_time_value = (data_low - H8000_0000) and ahb2rdb_timeout_time_mask
            end If
        else
            read_ahb2rdb_timeout_time_value = data_low and ahb2rdb_timeout_time_mask
        end If

    End Sub

    Sub write
        If flag_ahb2rdb_timeout_qspi = &H0 or flag_ahb2rdb_timeout_rdb16 = &H0 or flag_ahb2rdb_timeout_srab = &H0 or flag_ahb2rdb_timeout_time = &H0 Then read
        If flag_ahb2rdb_timeout_qspi = &H0 Then write_ahb2rdb_timeout_qspi_value = get_ahb2rdb_timeout_qspi
        If flag_ahb2rdb_timeout_rdb16 = &H0 Then write_ahb2rdb_timeout_rdb16_value = get_ahb2rdb_timeout_rdb16
        If flag_ahb2rdb_timeout_srab = &H0 Then write_ahb2rdb_timeout_srab_value = get_ahb2rdb_timeout_srab
        If flag_ahb2rdb_timeout_time = &H0 Then write_ahb2rdb_timeout_time_value = get_ahb2rdb_timeout_time

        regValue = leftShift((write_ahb2rdb_timeout_qspi_value and &H1), 18) + leftShift((write_ahb2rdb_timeout_rdb16_value and &H1), 17) + leftShift((write_ahb2rdb_timeout_srab_value and &H1), 16) + leftShift((write_ahb2rdb_timeout_time_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ahb2rdb_timeout_qspi_value = rightShift(data_low, 18) and &H1
        read_ahb2rdb_timeout_rdb16_value = rightShift(data_low, 17) and &H1
        read_ahb2rdb_timeout_srab_value = rightShift(data_low, 16) and &H1
        ahb2rdb_timeout_time_mask = &Hffff
        if data_low > LONG_MAX then
            if ahb2rdb_timeout_time_mask = mask then
                read_ahb2rdb_timeout_time_value = data_low
            else
                read_ahb2rdb_timeout_time_value = (data_low - H8000_0000) and ahb2rdb_timeout_time_mask
            end If
        else
            read_ahb2rdb_timeout_time_value = data_low and ahb2rdb_timeout_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ahb2rdb_timeout_qspi_value = &H0
        flag_ahb2rdb_timeout_qspi        = &H0
        write_ahb2rdb_timeout_rdb16_value = &H0
        flag_ahb2rdb_timeout_rdb16        = &H0
        write_ahb2rdb_timeout_srab_value = &H0
        flag_ahb2rdb_timeout_srab        = &H0
        write_ahb2rdb_timeout_time_value = &H0
        flag_ahb2rdb_timeout_time        = &H0
    End Sub
End Class


'' @REGISTER : CFG_amac_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AMAC_MDIO_ENABLE                           [22:22]          get_AMAC_MDIO_ENABLE
''                                                             set_AMAC_MDIO_ENABLE
''                                                             read_AMAC_MDIO_ENABLE
''                                                             write_AMAC_MDIO_ENABLE
''---------------------------------------------------------------------------------
'' TM_SP                                      [21:12]          get_TM_SP
''                                                             set_TM_SP
''                                                             read_TM_SP
''                                                             write_TM_SP
''---------------------------------------------------------------------------------
'' TM_RF                                      [11:4]           get_TM_RF
''                                                             set_TM_RF
''                                                             read_TM_RF
''                                                             write_TM_RF
''---------------------------------------------------------------------------------
'' OOB_FLOW_CTRL_EN                           [3:3]            get_OOB_FLOW_CTRL_EN
''                                                             set_OOB_FLOW_CTRL_EN
''                                                             read_OOB_FLOW_CTRL_EN
''                                                             write_OOB_FLOW_CTRL_EN
''---------------------------------------------------------------------------------
'' EN_AUTOCONFIG                              [2:2]            get_EN_AUTOCONFIG
''                                                             set_EN_AUTOCONFIG
''                                                             read_EN_AUTOCONFIG
''                                                             write_EN_AUTOCONFIG
''---------------------------------------------------------------------------------
'' EEE_EN                                     [1:1]            get_EEE_EN
''                                                             set_EEE_EN
''                                                             read_EEE_EN
''                                                             write_EEE_EN
''---------------------------------------------------------------------------------
'' DISABLE_AMAC                               [0:0]            get_DISABLE_AMAC
''                                                             set_DISABLE_AMAC
''                                                             read_DISABLE_AMAC
''                                                             write_DISABLE_AMAC
''---------------------------------------------------------------------------------
Class REGISTER_CFG_amac_ctrl
    Private write_AMAC_MDIO_ENABLE_value
    Private read_AMAC_MDIO_ENABLE_value
    Private flag_AMAC_MDIO_ENABLE
    Private write_TM_SP_value
    Private read_TM_SP_value
    Private flag_TM_SP
    Private write_TM_RF_value
    Private read_TM_RF_value
    Private flag_TM_RF
    Private write_OOB_FLOW_CTRL_EN_value
    Private read_OOB_FLOW_CTRL_EN_value
    Private flag_OOB_FLOW_CTRL_EN
    Private write_EN_AUTOCONFIG_value
    Private read_EN_AUTOCONFIG_value
    Private flag_EN_AUTOCONFIG
    Private write_EEE_EN_value
    Private read_EEE_EN_value
    Private flag_EEE_EN
    Private write_DISABLE_AMAC_value
    Private read_DISABLE_AMAC_value
    Private flag_DISABLE_AMAC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AMAC_MDIO_ENABLE
        get_AMAC_MDIO_ENABLE = read_AMAC_MDIO_ENABLE_value
    End Property

    Property Let set_AMAC_MDIO_ENABLE(aData)
        write_AMAC_MDIO_ENABLE_value = aData
        flag_AMAC_MDIO_ENABLE        = &H1
    End Property

    Property Get read_AMAC_MDIO_ENABLE
        read
        read_AMAC_MDIO_ENABLE = read_AMAC_MDIO_ENABLE_value
    End Property

    Property Let write_AMAC_MDIO_ENABLE(aData)
        set_AMAC_MDIO_ENABLE = aData
        write
    End Property

    Property Get get_TM_SP
        get_TM_SP = read_TM_SP_value
    End Property

    Property Let set_TM_SP(aData)
        write_TM_SP_value = aData
        flag_TM_SP        = &H1
    End Property

    Property Get read_TM_SP
        read
        read_TM_SP = read_TM_SP_value
    End Property

    Property Let write_TM_SP(aData)
        set_TM_SP = aData
        write
    End Property

    Property Get get_TM_RF
        get_TM_RF = read_TM_RF_value
    End Property

    Property Let set_TM_RF(aData)
        write_TM_RF_value = aData
        flag_TM_RF        = &H1
    End Property

    Property Get read_TM_RF
        read
        read_TM_RF = read_TM_RF_value
    End Property

    Property Let write_TM_RF(aData)
        set_TM_RF = aData
        write
    End Property

    Property Get get_OOB_FLOW_CTRL_EN
        get_OOB_FLOW_CTRL_EN = read_OOB_FLOW_CTRL_EN_value
    End Property

    Property Let set_OOB_FLOW_CTRL_EN(aData)
        write_OOB_FLOW_CTRL_EN_value = aData
        flag_OOB_FLOW_CTRL_EN        = &H1
    End Property

    Property Get read_OOB_FLOW_CTRL_EN
        read
        read_OOB_FLOW_CTRL_EN = read_OOB_FLOW_CTRL_EN_value
    End Property

    Property Let write_OOB_FLOW_CTRL_EN(aData)
        set_OOB_FLOW_CTRL_EN = aData
        write
    End Property

    Property Get get_EN_AUTOCONFIG
        get_EN_AUTOCONFIG = read_EN_AUTOCONFIG_value
    End Property

    Property Let set_EN_AUTOCONFIG(aData)
        write_EN_AUTOCONFIG_value = aData
        flag_EN_AUTOCONFIG        = &H1
    End Property

    Property Get read_EN_AUTOCONFIG
        read
        read_EN_AUTOCONFIG = read_EN_AUTOCONFIG_value
    End Property

    Property Let write_EN_AUTOCONFIG(aData)
        set_EN_AUTOCONFIG = aData
        write
    End Property

    Property Get get_EEE_EN
        get_EEE_EN = read_EEE_EN_value
    End Property

    Property Let set_EEE_EN(aData)
        write_EEE_EN_value = aData
        flag_EEE_EN        = &H1
    End Property

    Property Get read_EEE_EN
        read
        read_EEE_EN = read_EEE_EN_value
    End Property

    Property Let write_EEE_EN(aData)
        set_EEE_EN = aData
        write
    End Property

    Property Get get_DISABLE_AMAC
        get_DISABLE_AMAC = read_DISABLE_AMAC_value
    End Property

    Property Let set_DISABLE_AMAC(aData)
        write_DISABLE_AMAC_value = aData
        flag_DISABLE_AMAC        = &H1
    End Property

    Property Get read_DISABLE_AMAC
        read
        read_DISABLE_AMAC = read_DISABLE_AMAC_value
    End Property

    Property Let write_DISABLE_AMAC(aData)
        set_DISABLE_AMAC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AMAC_MDIO_ENABLE_value = rightShift(data_low, 22) and &H1
        read_TM_SP_value = rightShift(data_low, 12) and &H3ff
        read_TM_RF_value = rightShift(data_low, 4) and &Hff
        read_OOB_FLOW_CTRL_EN_value = rightShift(data_low, 3) and &H1
        read_EN_AUTOCONFIG_value = rightShift(data_low, 2) and &H1
        read_EEE_EN_value = rightShift(data_low, 1) and &H1
        DISABLE_AMAC_mask = &H1
        if data_low > LONG_MAX then
            if DISABLE_AMAC_mask = mask then
                read_DISABLE_AMAC_value = data_low
            else
                read_DISABLE_AMAC_value = (data_low - H8000_0000) and DISABLE_AMAC_mask
            end If
        else
            read_DISABLE_AMAC_value = data_low and DISABLE_AMAC_mask
        end If

    End Sub

    Sub write
        If flag_AMAC_MDIO_ENABLE = &H0 or flag_TM_SP = &H0 or flag_TM_RF = &H0 or flag_OOB_FLOW_CTRL_EN = &H0 or flag_EN_AUTOCONFIG = &H0 or flag_EEE_EN = &H0 or flag_DISABLE_AMAC = &H0 Then read
        If flag_AMAC_MDIO_ENABLE = &H0 Then write_AMAC_MDIO_ENABLE_value = get_AMAC_MDIO_ENABLE
        If flag_TM_SP = &H0 Then write_TM_SP_value = get_TM_SP
        If flag_TM_RF = &H0 Then write_TM_RF_value = get_TM_RF
        If flag_OOB_FLOW_CTRL_EN = &H0 Then write_OOB_FLOW_CTRL_EN_value = get_OOB_FLOW_CTRL_EN
        If flag_EN_AUTOCONFIG = &H0 Then write_EN_AUTOCONFIG_value = get_EN_AUTOCONFIG
        If flag_EEE_EN = &H0 Then write_EEE_EN_value = get_EEE_EN
        If flag_DISABLE_AMAC = &H0 Then write_DISABLE_AMAC_value = get_DISABLE_AMAC

        regValue = leftShift((write_AMAC_MDIO_ENABLE_value and &H1), 22) + leftShift((write_TM_SP_value and &H3ff), 12) + leftShift((write_TM_RF_value and &Hff), 4) + leftShift((write_OOB_FLOW_CTRL_EN_value and &H1), 3) + leftShift((write_EN_AUTOCONFIG_value and &H1), 2) + leftShift((write_EEE_EN_value and &H1), 1) + leftShift((write_DISABLE_AMAC_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AMAC_MDIO_ENABLE_value = rightShift(data_low, 22) and &H1
        read_TM_SP_value = rightShift(data_low, 12) and &H3ff
        read_TM_RF_value = rightShift(data_low, 4) and &Hff
        read_OOB_FLOW_CTRL_EN_value = rightShift(data_low, 3) and &H1
        read_EN_AUTOCONFIG_value = rightShift(data_low, 2) and &H1
        read_EEE_EN_value = rightShift(data_low, 1) and &H1
        DISABLE_AMAC_mask = &H1
        if data_low > LONG_MAX then
            if DISABLE_AMAC_mask = mask then
                read_DISABLE_AMAC_value = data_low
            else
                read_DISABLE_AMAC_value = (data_low - H8000_0000) and DISABLE_AMAC_mask
            end If
        else
            read_DISABLE_AMAC_value = data_low and DISABLE_AMAC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AMAC_MDIO_ENABLE_value = &H0
        flag_AMAC_MDIO_ENABLE        = &H0
        write_TM_SP_value = &H0
        flag_TM_SP        = &H0
        write_TM_RF_value = &H0
        flag_TM_RF        = &H0
        write_OOB_FLOW_CTRL_EN_value = &H0
        flag_OOB_FLOW_CTRL_EN        = &H0
        write_EN_AUTOCONFIG_value = &H0
        flag_EN_AUTOCONFIG        = &H0
        write_EEE_EN_value = &H0
        flag_EEE_EN        = &H0
        write_DISABLE_AMAC_value = &H0
        flag_DISABLE_AMAC        = &H0
    End Sub
End Class


'' @REGISTER : CFG_amac_io_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDR_MSB                                   [31:31]          get_ADDR_MSB
''                                                             set_ADDR_MSB
''                                                             read_ADDR_MSB
''                                                             write_ADDR_MSB
''---------------------------------------------------------------------------------
'' ADDR_MSB_SEL                               [30:30]          get_ADDR_MSB_SEL
''                                                             set_ADDR_MSB_SEL
''                                                             read_ADDR_MSB_SEL
''                                                             write_ADDR_MSB_SEL
''---------------------------------------------------------------------------------
'' ARUSER                                     [29:25]          get_ARUSER
''                                                             set_ARUSER
''                                                             read_ARUSER
''                                                             write_ARUSER
''---------------------------------------------------------------------------------
'' AWUSER                                     [24:20]          get_AWUSER
''                                                             set_AWUSER
''                                                             read_AWUSER
''                                                             write_AWUSER
''---------------------------------------------------------------------------------
'' ARCACHE                                    [19:16]          get_ARCACHE
''                                                             set_ARCACHE
''                                                             read_ARCACHE
''                                                             write_ARCACHE
''---------------------------------------------------------------------------------
'' RSVD_1                                     [15:14]          get_RSVD_1
''                                                             set_RSVD_1
''                                                             read_RSVD_1
''                                                             write_RSVD_1
''---------------------------------------------------------------------------------
'' LEDSCAN_FLOP_STAGES                        [13:11]          get_LEDSCAN_FLOP_STAGES
''                                                             set_LEDSCAN_FLOP_STAGES
''                                                             read_LEDSCAN_FLOP_STAGES
''                                                             write_LEDSCAN_FLOP_STAGES
''---------------------------------------------------------------------------------
'' AWCACHE                                    [10:7]           get_AWCACHE
''                                                             set_AWCACHE
''                                                             read_AWCACHE
''                                                             write_AWCACHE
''---------------------------------------------------------------------------------
'' INTERFACE_MODE_STRAP                       [6:2]            get_INTERFACE_MODE_STRAP
''                                                             set_INTERFACE_MODE_STRAP
''                                                             read_INTERFACE_MODE_STRAP
''                                                             write_INTERFACE_MODE_STRAP
''---------------------------------------------------------------------------------
'' RSVD_0                                     [1:1]            get_RSVD_0
''                                                             set_RSVD_0
''                                                             read_RSVD_0
''                                                             write_RSVD_0
''---------------------------------------------------------------------------------
'' CLK_ENABLE                                 [0:0]            get_CLK_ENABLE
''                                                             set_CLK_ENABLE
''                                                             read_CLK_ENABLE
''                                                             write_CLK_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_CFG_amac_io_ctrl
    Private write_ADDR_MSB_value
    Private read_ADDR_MSB_value
    Private flag_ADDR_MSB
    Private write_ADDR_MSB_SEL_value
    Private read_ADDR_MSB_SEL_value
    Private flag_ADDR_MSB_SEL
    Private write_ARUSER_value
    Private read_ARUSER_value
    Private flag_ARUSER
    Private write_AWUSER_value
    Private read_AWUSER_value
    Private flag_AWUSER
    Private write_ARCACHE_value
    Private read_ARCACHE_value
    Private flag_ARCACHE
    Private write_RSVD_1_value
    Private read_RSVD_1_value
    Private flag_RSVD_1
    Private write_LEDSCAN_FLOP_STAGES_value
    Private read_LEDSCAN_FLOP_STAGES_value
    Private flag_LEDSCAN_FLOP_STAGES
    Private write_AWCACHE_value
    Private read_AWCACHE_value
    Private flag_AWCACHE
    Private write_INTERFACE_MODE_STRAP_value
    Private read_INTERFACE_MODE_STRAP_value
    Private flag_INTERFACE_MODE_STRAP
    Private write_RSVD_0_value
    Private read_RSVD_0_value
    Private flag_RSVD_0
    Private write_CLK_ENABLE_value
    Private read_CLK_ENABLE_value
    Private flag_CLK_ENABLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ADDR_MSB
        get_ADDR_MSB = read_ADDR_MSB_value
    End Property

    Property Let set_ADDR_MSB(aData)
        write_ADDR_MSB_value = aData
        flag_ADDR_MSB        = &H1
    End Property

    Property Get read_ADDR_MSB
        read
        read_ADDR_MSB = read_ADDR_MSB_value
    End Property

    Property Let write_ADDR_MSB(aData)
        set_ADDR_MSB = aData
        write
    End Property

    Property Get get_ADDR_MSB_SEL
        get_ADDR_MSB_SEL = read_ADDR_MSB_SEL_value
    End Property

    Property Let set_ADDR_MSB_SEL(aData)
        write_ADDR_MSB_SEL_value = aData
        flag_ADDR_MSB_SEL        = &H1
    End Property

    Property Get read_ADDR_MSB_SEL
        read
        read_ADDR_MSB_SEL = read_ADDR_MSB_SEL_value
    End Property

    Property Let write_ADDR_MSB_SEL(aData)
        set_ADDR_MSB_SEL = aData
        write
    End Property

    Property Get get_ARUSER
        get_ARUSER = read_ARUSER_value
    End Property

    Property Let set_ARUSER(aData)
        write_ARUSER_value = aData
        flag_ARUSER        = &H1
    End Property

    Property Get read_ARUSER
        read
        read_ARUSER = read_ARUSER_value
    End Property

    Property Let write_ARUSER(aData)
        set_ARUSER = aData
        write
    End Property

    Property Get get_AWUSER
        get_AWUSER = read_AWUSER_value
    End Property

    Property Let set_AWUSER(aData)
        write_AWUSER_value = aData
        flag_AWUSER        = &H1
    End Property

    Property Get read_AWUSER
        read
        read_AWUSER = read_AWUSER_value
    End Property

    Property Let write_AWUSER(aData)
        set_AWUSER = aData
        write
    End Property

    Property Get get_ARCACHE
        get_ARCACHE = read_ARCACHE_value
    End Property

    Property Let set_ARCACHE(aData)
        write_ARCACHE_value = aData
        flag_ARCACHE        = &H1
    End Property

    Property Get read_ARCACHE
        read
        read_ARCACHE = read_ARCACHE_value
    End Property

    Property Let write_ARCACHE(aData)
        set_ARCACHE = aData
        write
    End Property

    Property Get get_RSVD_1
        get_RSVD_1 = read_RSVD_1_value
    End Property

    Property Let set_RSVD_1(aData)
        write_RSVD_1_value = aData
        flag_RSVD_1        = &H1
    End Property

    Property Get read_RSVD_1
        read
        read_RSVD_1 = read_RSVD_1_value
    End Property

    Property Let write_RSVD_1(aData)
        set_RSVD_1 = aData
        write
    End Property

    Property Get get_LEDSCAN_FLOP_STAGES
        get_LEDSCAN_FLOP_STAGES = read_LEDSCAN_FLOP_STAGES_value
    End Property

    Property Let set_LEDSCAN_FLOP_STAGES(aData)
        write_LEDSCAN_FLOP_STAGES_value = aData
        flag_LEDSCAN_FLOP_STAGES        = &H1
    End Property

    Property Get read_LEDSCAN_FLOP_STAGES
        read
        read_LEDSCAN_FLOP_STAGES = read_LEDSCAN_FLOP_STAGES_value
    End Property

    Property Let write_LEDSCAN_FLOP_STAGES(aData)
        set_LEDSCAN_FLOP_STAGES = aData
        write
    End Property

    Property Get get_AWCACHE
        get_AWCACHE = read_AWCACHE_value
    End Property

    Property Let set_AWCACHE(aData)
        write_AWCACHE_value = aData
        flag_AWCACHE        = &H1
    End Property

    Property Get read_AWCACHE
        read
        read_AWCACHE = read_AWCACHE_value
    End Property

    Property Let write_AWCACHE(aData)
        set_AWCACHE = aData
        write
    End Property

    Property Get get_INTERFACE_MODE_STRAP
        get_INTERFACE_MODE_STRAP = read_INTERFACE_MODE_STRAP_value
    End Property

    Property Let set_INTERFACE_MODE_STRAP(aData)
        write_INTERFACE_MODE_STRAP_value = aData
        flag_INTERFACE_MODE_STRAP        = &H1
    End Property

    Property Get read_INTERFACE_MODE_STRAP
        read
        read_INTERFACE_MODE_STRAP = read_INTERFACE_MODE_STRAP_value
    End Property

    Property Let write_INTERFACE_MODE_STRAP(aData)
        set_INTERFACE_MODE_STRAP = aData
        write
    End Property

    Property Get get_RSVD_0
        get_RSVD_0 = read_RSVD_0_value
    End Property

    Property Let set_RSVD_0(aData)
        write_RSVD_0_value = aData
        flag_RSVD_0        = &H1
    End Property

    Property Get read_RSVD_0
        read
        read_RSVD_0 = read_RSVD_0_value
    End Property

    Property Let write_RSVD_0(aData)
        set_RSVD_0 = aData
        write
    End Property

    Property Get get_CLK_ENABLE
        get_CLK_ENABLE = read_CLK_ENABLE_value
    End Property

    Property Let set_CLK_ENABLE(aData)
        write_CLK_ENABLE_value = aData
        flag_CLK_ENABLE        = &H1
    End Property

    Property Get read_CLK_ENABLE
        read
        read_CLK_ENABLE = read_CLK_ENABLE_value
    End Property

    Property Let write_CLK_ENABLE(aData)
        set_CLK_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ADDR_MSB_value = rightShift(data_low, 31) and &H1
        read_ADDR_MSB_SEL_value = rightShift(data_low, 30) and &H1
        read_ARUSER_value = rightShift(data_low, 25) and &H1f
        read_AWUSER_value = rightShift(data_low, 20) and &H1f
        read_ARCACHE_value = rightShift(data_low, 16) and &Hf
        read_RSVD_1_value = rightShift(data_low, 14) and &H3
        read_LEDSCAN_FLOP_STAGES_value = rightShift(data_low, 11) and &H7
        read_AWCACHE_value = rightShift(data_low, 7) and &Hf
        read_INTERFACE_MODE_STRAP_value = rightShift(data_low, 2) and &H1f
        read_RSVD_0_value = rightShift(data_low, 1) and &H1
        CLK_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if CLK_ENABLE_mask = mask then
                read_CLK_ENABLE_value = data_low
            else
                read_CLK_ENABLE_value = (data_low - H8000_0000) and CLK_ENABLE_mask
            end If
        else
            read_CLK_ENABLE_value = data_low and CLK_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_ADDR_MSB = &H0 or flag_ADDR_MSB_SEL = &H0 or flag_ARUSER = &H0 or flag_AWUSER = &H0 or flag_ARCACHE = &H0 or flag_RSVD_1 = &H0 or flag_LEDSCAN_FLOP_STAGES = &H0 or flag_AWCACHE = &H0 or flag_INTERFACE_MODE_STRAP = &H0 or flag_RSVD_0 = &H0 or flag_CLK_ENABLE = &H0 Then read
        If flag_ADDR_MSB = &H0 Then write_ADDR_MSB_value = get_ADDR_MSB
        If flag_ADDR_MSB_SEL = &H0 Then write_ADDR_MSB_SEL_value = get_ADDR_MSB_SEL
        If flag_ARUSER = &H0 Then write_ARUSER_value = get_ARUSER
        If flag_AWUSER = &H0 Then write_AWUSER_value = get_AWUSER
        If flag_ARCACHE = &H0 Then write_ARCACHE_value = get_ARCACHE
        If flag_RSVD_1 = &H0 Then write_RSVD_1_value = get_RSVD_1
        If flag_LEDSCAN_FLOP_STAGES = &H0 Then write_LEDSCAN_FLOP_STAGES_value = get_LEDSCAN_FLOP_STAGES
        If flag_AWCACHE = &H0 Then write_AWCACHE_value = get_AWCACHE
        If flag_INTERFACE_MODE_STRAP = &H0 Then write_INTERFACE_MODE_STRAP_value = get_INTERFACE_MODE_STRAP
        If flag_RSVD_0 = &H0 Then write_RSVD_0_value = get_RSVD_0
        If flag_CLK_ENABLE = &H0 Then write_CLK_ENABLE_value = get_CLK_ENABLE

        regValue = leftShift((write_ADDR_MSB_value and &H1), 31) + leftShift((write_ADDR_MSB_SEL_value and &H1), 30) + leftShift((write_ARUSER_value and &H1f), 25) + leftShift((write_AWUSER_value and &H1f), 20) + leftShift((write_ARCACHE_value and &Hf), 16) + leftShift((write_RSVD_1_value and &H3), 14) + leftShift((write_LEDSCAN_FLOP_STAGES_value and &H7), 11) + leftShift((write_AWCACHE_value and &Hf), 7) + leftShift((write_INTERFACE_MODE_STRAP_value and &H1f), 2) + leftShift((write_RSVD_0_value and &H1), 1) + leftShift((write_CLK_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ADDR_MSB_value = rightShift(data_low, 31) and &H1
        read_ADDR_MSB_SEL_value = rightShift(data_low, 30) and &H1
        read_ARUSER_value = rightShift(data_low, 25) and &H1f
        read_AWUSER_value = rightShift(data_low, 20) and &H1f
        read_ARCACHE_value = rightShift(data_low, 16) and &Hf
        read_RSVD_1_value = rightShift(data_low, 14) and &H3
        read_LEDSCAN_FLOP_STAGES_value = rightShift(data_low, 11) and &H7
        read_AWCACHE_value = rightShift(data_low, 7) and &Hf
        read_INTERFACE_MODE_STRAP_value = rightShift(data_low, 2) and &H1f
        read_RSVD_0_value = rightShift(data_low, 1) and &H1
        CLK_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if CLK_ENABLE_mask = mask then
                read_CLK_ENABLE_value = data_low
            else
                read_CLK_ENABLE_value = (data_low - H8000_0000) and CLK_ENABLE_mask
            end If
        else
            read_CLK_ENABLE_value = data_low and CLK_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDR_MSB_value = &H0
        flag_ADDR_MSB        = &H0
        write_ADDR_MSB_SEL_value = &H0
        flag_ADDR_MSB_SEL        = &H0
        write_ARUSER_value = &H0
        flag_ARUSER        = &H0
        write_AWUSER_value = &H0
        flag_AWUSER        = &H0
        write_ARCACHE_value = &H0
        flag_ARCACHE        = &H0
        write_RSVD_1_value = &H0
        flag_RSVD_1        = &H0
        write_LEDSCAN_FLOP_STAGES_value = &H0
        flag_LEDSCAN_FLOP_STAGES        = &H0
        write_AWCACHE_value = &H0
        flag_AWCACHE        = &H0
        write_INTERFACE_MODE_STRAP_value = &H0
        flag_INTERFACE_MODE_STRAP        = &H0
        write_RSVD_0_value = &H0
        flag_RSVD_0        = &H0
        write_CLK_ENABLE_value = &H0
        flag_CLK_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : CFG_amac_io_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AMAC_IO_STAT                               [31:0]           get_AMAC_IO_STAT
''                                                             set_AMAC_IO_STAT
''                                                             read_AMAC_IO_STAT
''                                                             write_AMAC_IO_STAT
''---------------------------------------------------------------------------------
Class REGISTER_CFG_amac_io_stat
    Private write_AMAC_IO_STAT_value
    Private read_AMAC_IO_STAT_value
    Private flag_AMAC_IO_STAT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AMAC_IO_STAT
        get_AMAC_IO_STAT = read_AMAC_IO_STAT_value
    End Property

    Property Let set_AMAC_IO_STAT(aData)
        write_AMAC_IO_STAT_value = aData
        flag_AMAC_IO_STAT        = &H1
    End Property

    Property Get read_AMAC_IO_STAT
        read
        read_AMAC_IO_STAT = read_AMAC_IO_STAT_value
    End Property

    Property Let write_AMAC_IO_STAT(aData)
        set_AMAC_IO_STAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AMAC_IO_STAT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if AMAC_IO_STAT_mask = mask then
                read_AMAC_IO_STAT_value = data_low
            else
                read_AMAC_IO_STAT_value = (data_low - H8000_0000) and AMAC_IO_STAT_mask
            end If
        else
            read_AMAC_IO_STAT_value = data_low and AMAC_IO_STAT_mask
        end If

    End Sub

    Sub write
        If flag_AMAC_IO_STAT = &H0 Then read
        If flag_AMAC_IO_STAT = &H0 Then write_AMAC_IO_STAT_value = get_AMAC_IO_STAT

        regValue = leftShift(write_AMAC_IO_STAT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AMAC_IO_STAT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if AMAC_IO_STAT_mask = mask then
                read_AMAC_IO_STAT_value = data_low
            else
                read_AMAC_IO_STAT_value = (data_low - H8000_0000) and AMAC_IO_STAT_mask
            end If
        else
            read_AMAC_IO_STAT_value = data_low and AMAC_IO_STAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AMAC_IO_STAT_value = &H0
        flag_AMAC_IO_STAT        = &H0
    End Sub
End Class


'' @REGISTER : CFG_amac_ip_revid
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AMAC_IP_REVID                              [7:0]            get_AMAC_IP_REVID
''                                                             set_AMAC_IP_REVID
''                                                             read_AMAC_IP_REVID
''                                                             write_AMAC_IP_REVID
''---------------------------------------------------------------------------------
Class REGISTER_CFG_amac_ip_revid
    Private write_AMAC_IP_REVID_value
    Private read_AMAC_IP_REVID_value
    Private flag_AMAC_IP_REVID

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AMAC_IP_REVID
        get_AMAC_IP_REVID = read_AMAC_IP_REVID_value
    End Property

    Property Let set_AMAC_IP_REVID(aData)
        write_AMAC_IP_REVID_value = aData
        flag_AMAC_IP_REVID        = &H1
    End Property

    Property Get read_AMAC_IP_REVID
        read
        read_AMAC_IP_REVID = read_AMAC_IP_REVID_value
    End Property

    Property Let write_AMAC_IP_REVID(aData)
        set_AMAC_IP_REVID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AMAC_IP_REVID_mask = &Hff
        if data_low > LONG_MAX then
            if AMAC_IP_REVID_mask = mask then
                read_AMAC_IP_REVID_value = data_low
            else
                read_AMAC_IP_REVID_value = (data_low - H8000_0000) and AMAC_IP_REVID_mask
            end If
        else
            read_AMAC_IP_REVID_value = data_low and AMAC_IP_REVID_mask
        end If

    End Sub

    Sub write
        If flag_AMAC_IP_REVID = &H0 Then read
        If flag_AMAC_IP_REVID = &H0 Then write_AMAC_IP_REVID_value = get_AMAC_IP_REVID

        regValue = leftShift((write_AMAC_IP_REVID_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AMAC_IP_REVID_mask = &Hff
        if data_low > LONG_MAX then
            if AMAC_IP_REVID_mask = mask then
                read_AMAC_IP_REVID_value = data_low
            else
                read_AMAC_IP_REVID_value = (data_low - H8000_0000) and AMAC_IP_REVID_mask
            end If
        else
            read_AMAC_IP_REVID_value = data_low and AMAC_IP_REVID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AMAC_IP_REVID_value = &H0
        flag_AMAC_IP_REVID        = &H0
    End Sub
End Class


'' @REGISTER : CFG_qspi_flash_base_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLASH_MEM_BASE_ADDR                        [31:0]           get_FLASH_MEM_BASE_ADDR
''                                                             set_FLASH_MEM_BASE_ADDR
''                                                             read_FLASH_MEM_BASE_ADDR
''                                                             write_FLASH_MEM_BASE_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_CFG_qspi_flash_base_addr
    Private write_FLASH_MEM_BASE_ADDR_value
    Private read_FLASH_MEM_BASE_ADDR_value
    Private flag_FLASH_MEM_BASE_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FLASH_MEM_BASE_ADDR
        get_FLASH_MEM_BASE_ADDR = read_FLASH_MEM_BASE_ADDR_value
    End Property

    Property Let set_FLASH_MEM_BASE_ADDR(aData)
        write_FLASH_MEM_BASE_ADDR_value = aData
        flag_FLASH_MEM_BASE_ADDR        = &H1
    End Property

    Property Get read_FLASH_MEM_BASE_ADDR
        read
        read_FLASH_MEM_BASE_ADDR = read_FLASH_MEM_BASE_ADDR_value
    End Property

    Property Let write_FLASH_MEM_BASE_ADDR(aData)
        set_FLASH_MEM_BASE_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLASH_MEM_BASE_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if FLASH_MEM_BASE_ADDR_mask = mask then
                read_FLASH_MEM_BASE_ADDR_value = data_low
            else
                read_FLASH_MEM_BASE_ADDR_value = (data_low - H8000_0000) and FLASH_MEM_BASE_ADDR_mask
            end If
        else
            read_FLASH_MEM_BASE_ADDR_value = data_low and FLASH_MEM_BASE_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_FLASH_MEM_BASE_ADDR = &H0 Then read
        If flag_FLASH_MEM_BASE_ADDR = &H0 Then write_FLASH_MEM_BASE_ADDR_value = get_FLASH_MEM_BASE_ADDR

        regValue = leftShift(write_FLASH_MEM_BASE_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLASH_MEM_BASE_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if FLASH_MEM_BASE_ADDR_mask = mask then
                read_FLASH_MEM_BASE_ADDR_value = data_low
            else
                read_FLASH_MEM_BASE_ADDR_value = (data_low - H8000_0000) and FLASH_MEM_BASE_ADDR_mask
            end If
        else
            read_FLASH_MEM_BASE_ADDR_value = data_low and FLASH_MEM_BASE_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLASH_MEM_BASE_ADDR_value = &H0
        flag_FLASH_MEM_BASE_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : CFG_qspi_flash_size
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLASH_MEM_BYTE_SIZE                        [31:0]           get_FLASH_MEM_BYTE_SIZE
''                                                             set_FLASH_MEM_BYTE_SIZE
''                                                             read_FLASH_MEM_BYTE_SIZE
''                                                             write_FLASH_MEM_BYTE_SIZE
''---------------------------------------------------------------------------------
Class REGISTER_CFG_qspi_flash_size
    Private write_FLASH_MEM_BYTE_SIZE_value
    Private read_FLASH_MEM_BYTE_SIZE_value
    Private flag_FLASH_MEM_BYTE_SIZE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FLASH_MEM_BYTE_SIZE
        get_FLASH_MEM_BYTE_SIZE = read_FLASH_MEM_BYTE_SIZE_value
    End Property

    Property Let set_FLASH_MEM_BYTE_SIZE(aData)
        write_FLASH_MEM_BYTE_SIZE_value = aData
        flag_FLASH_MEM_BYTE_SIZE        = &H1
    End Property

    Property Get read_FLASH_MEM_BYTE_SIZE
        read
        read_FLASH_MEM_BYTE_SIZE = read_FLASH_MEM_BYTE_SIZE_value
    End Property

    Property Let write_FLASH_MEM_BYTE_SIZE(aData)
        set_FLASH_MEM_BYTE_SIZE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLASH_MEM_BYTE_SIZE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if FLASH_MEM_BYTE_SIZE_mask = mask then
                read_FLASH_MEM_BYTE_SIZE_value = data_low
            else
                read_FLASH_MEM_BYTE_SIZE_value = (data_low - H8000_0000) and FLASH_MEM_BYTE_SIZE_mask
            end If
        else
            read_FLASH_MEM_BYTE_SIZE_value = data_low and FLASH_MEM_BYTE_SIZE_mask
        end If

    End Sub

    Sub write
        If flag_FLASH_MEM_BYTE_SIZE = &H0 Then read
        If flag_FLASH_MEM_BYTE_SIZE = &H0 Then write_FLASH_MEM_BYTE_SIZE_value = get_FLASH_MEM_BYTE_SIZE

        regValue = leftShift(write_FLASH_MEM_BYTE_SIZE_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLASH_MEM_BYTE_SIZE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if FLASH_MEM_BYTE_SIZE_mask = mask then
                read_FLASH_MEM_BYTE_SIZE_value = data_low
            else
                read_FLASH_MEM_BYTE_SIZE_value = (data_low - H8000_0000) and FLASH_MEM_BYTE_SIZE_mask
            end If
        else
            read_FLASH_MEM_BYTE_SIZE_value = data_low and FLASH_MEM_BYTE_SIZE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLASH_MEM_BYTE_SIZE_value = &H0
        flag_FLASH_MEM_BYTE_SIZE        = &H0
    End Sub
End Class


'' @REGISTER : CFG_apb_monitor_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' APB_TIMEOUT_IRQ_MASK                       [6:6]            get_APB_TIMEOUT_IRQ_MASK
''                                                             set_APB_TIMEOUT_IRQ_MASK
''                                                             read_APB_TIMEOUT_IRQ_MASK
''                                                             write_APB_TIMEOUT_IRQ_MASK
''---------------------------------------------------------------------------------
'' APB_TIMEOUT_ERR_RESP_EN                    [5:5]            get_APB_TIMEOUT_ERR_RESP_EN
''                                                             set_APB_TIMEOUT_ERR_RESP_EN
''                                                             read_APB_TIMEOUT_ERR_RESP_EN
''                                                             write_APB_TIMEOUT_ERR_RESP_EN
''---------------------------------------------------------------------------------
'' APB_TIMEOUT_EN                             [4:4]            get_APB_TIMEOUT_EN
''                                                             set_APB_TIMEOUT_EN
''                                                             read_APB_TIMEOUT_EN
''                                                             write_APB_TIMEOUT_EN
''---------------------------------------------------------------------------------
'' APB_TIMEOUT_SEL                            [3:0]            get_APB_TIMEOUT_SEL
''                                                             set_APB_TIMEOUT_SEL
''                                                             read_APB_TIMEOUT_SEL
''                                                             write_APB_TIMEOUT_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CFG_apb_monitor_ctrl
    Private write_APB_TIMEOUT_IRQ_MASK_value
    Private read_APB_TIMEOUT_IRQ_MASK_value
    Private flag_APB_TIMEOUT_IRQ_MASK
    Private write_APB_TIMEOUT_ERR_RESP_EN_value
    Private read_APB_TIMEOUT_ERR_RESP_EN_value
    Private flag_APB_TIMEOUT_ERR_RESP_EN
    Private write_APB_TIMEOUT_EN_value
    Private read_APB_TIMEOUT_EN_value
    Private flag_APB_TIMEOUT_EN
    Private write_APB_TIMEOUT_SEL_value
    Private read_APB_TIMEOUT_SEL_value
    Private flag_APB_TIMEOUT_SEL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_APB_TIMEOUT_IRQ_MASK
        get_APB_TIMEOUT_IRQ_MASK = read_APB_TIMEOUT_IRQ_MASK_value
    End Property

    Property Let set_APB_TIMEOUT_IRQ_MASK(aData)
        write_APB_TIMEOUT_IRQ_MASK_value = aData
        flag_APB_TIMEOUT_IRQ_MASK        = &H1
    End Property

    Property Get read_APB_TIMEOUT_IRQ_MASK
        read
        read_APB_TIMEOUT_IRQ_MASK = read_APB_TIMEOUT_IRQ_MASK_value
    End Property

    Property Let write_APB_TIMEOUT_IRQ_MASK(aData)
        set_APB_TIMEOUT_IRQ_MASK = aData
        write
    End Property

    Property Get get_APB_TIMEOUT_ERR_RESP_EN
        get_APB_TIMEOUT_ERR_RESP_EN = read_APB_TIMEOUT_ERR_RESP_EN_value
    End Property

    Property Let set_APB_TIMEOUT_ERR_RESP_EN(aData)
        write_APB_TIMEOUT_ERR_RESP_EN_value = aData
        flag_APB_TIMEOUT_ERR_RESP_EN        = &H1
    End Property

    Property Get read_APB_TIMEOUT_ERR_RESP_EN
        read
        read_APB_TIMEOUT_ERR_RESP_EN = read_APB_TIMEOUT_ERR_RESP_EN_value
    End Property

    Property Let write_APB_TIMEOUT_ERR_RESP_EN(aData)
        set_APB_TIMEOUT_ERR_RESP_EN = aData
        write
    End Property

    Property Get get_APB_TIMEOUT_EN
        get_APB_TIMEOUT_EN = read_APB_TIMEOUT_EN_value
    End Property

    Property Let set_APB_TIMEOUT_EN(aData)
        write_APB_TIMEOUT_EN_value = aData
        flag_APB_TIMEOUT_EN        = &H1
    End Property

    Property Get read_APB_TIMEOUT_EN
        read
        read_APB_TIMEOUT_EN = read_APB_TIMEOUT_EN_value
    End Property

    Property Let write_APB_TIMEOUT_EN(aData)
        set_APB_TIMEOUT_EN = aData
        write
    End Property

    Property Get get_APB_TIMEOUT_SEL
        get_APB_TIMEOUT_SEL = read_APB_TIMEOUT_SEL_value
    End Property

    Property Let set_APB_TIMEOUT_SEL(aData)
        write_APB_TIMEOUT_SEL_value = aData
        flag_APB_TIMEOUT_SEL        = &H1
    End Property

    Property Get read_APB_TIMEOUT_SEL
        read
        read_APB_TIMEOUT_SEL = read_APB_TIMEOUT_SEL_value
    End Property

    Property Let write_APB_TIMEOUT_SEL(aData)
        set_APB_TIMEOUT_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_APB_TIMEOUT_IRQ_MASK_value = rightShift(data_low, 6) and &H1
        read_APB_TIMEOUT_ERR_RESP_EN_value = rightShift(data_low, 5) and &H1
        read_APB_TIMEOUT_EN_value = rightShift(data_low, 4) and &H1
        APB_TIMEOUT_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if APB_TIMEOUT_SEL_mask = mask then
                read_APB_TIMEOUT_SEL_value = data_low
            else
                read_APB_TIMEOUT_SEL_value = (data_low - H8000_0000) and APB_TIMEOUT_SEL_mask
            end If
        else
            read_APB_TIMEOUT_SEL_value = data_low and APB_TIMEOUT_SEL_mask
        end If

    End Sub

    Sub write
        If flag_APB_TIMEOUT_IRQ_MASK = &H0 or flag_APB_TIMEOUT_ERR_RESP_EN = &H0 or flag_APB_TIMEOUT_EN = &H0 or flag_APB_TIMEOUT_SEL = &H0 Then read
        If flag_APB_TIMEOUT_IRQ_MASK = &H0 Then write_APB_TIMEOUT_IRQ_MASK_value = get_APB_TIMEOUT_IRQ_MASK
        If flag_APB_TIMEOUT_ERR_RESP_EN = &H0 Then write_APB_TIMEOUT_ERR_RESP_EN_value = get_APB_TIMEOUT_ERR_RESP_EN
        If flag_APB_TIMEOUT_EN = &H0 Then write_APB_TIMEOUT_EN_value = get_APB_TIMEOUT_EN
        If flag_APB_TIMEOUT_SEL = &H0 Then write_APB_TIMEOUT_SEL_value = get_APB_TIMEOUT_SEL

        regValue = leftShift((write_APB_TIMEOUT_IRQ_MASK_value and &H1), 6) + leftShift((write_APB_TIMEOUT_ERR_RESP_EN_value and &H1), 5) + leftShift((write_APB_TIMEOUT_EN_value and &H1), 4) + leftShift((write_APB_TIMEOUT_SEL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_APB_TIMEOUT_IRQ_MASK_value = rightShift(data_low, 6) and &H1
        read_APB_TIMEOUT_ERR_RESP_EN_value = rightShift(data_low, 5) and &H1
        read_APB_TIMEOUT_EN_value = rightShift(data_low, 4) and &H1
        APB_TIMEOUT_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if APB_TIMEOUT_SEL_mask = mask then
                read_APB_TIMEOUT_SEL_value = data_low
            else
                read_APB_TIMEOUT_SEL_value = (data_low - H8000_0000) and APB_TIMEOUT_SEL_mask
            end If
        else
            read_APB_TIMEOUT_SEL_value = data_low and APB_TIMEOUT_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_APB_TIMEOUT_IRQ_MASK_value = &H0
        flag_APB_TIMEOUT_IRQ_MASK        = &H0
        write_APB_TIMEOUT_ERR_RESP_EN_value = &H0
        flag_APB_TIMEOUT_ERR_RESP_EN        = &H0
        write_APB_TIMEOUT_EN_value = &H0
        flag_APB_TIMEOUT_EN        = &H0
        write_APB_TIMEOUT_SEL_value = &H0
        flag_APB_TIMEOUT_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CFG_apb_timeout_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' APB_TIMEOUT_ADDRESS                        [31:0]           get_APB_TIMEOUT_ADDRESS
''                                                             set_APB_TIMEOUT_ADDRESS
''                                                             read_APB_TIMEOUT_ADDRESS
''                                                             write_APB_TIMEOUT_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_CFG_apb_timeout_address
    Private write_APB_TIMEOUT_ADDRESS_value
    Private read_APB_TIMEOUT_ADDRESS_value
    Private flag_APB_TIMEOUT_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_APB_TIMEOUT_ADDRESS
        get_APB_TIMEOUT_ADDRESS = read_APB_TIMEOUT_ADDRESS_value
    End Property

    Property Let set_APB_TIMEOUT_ADDRESS(aData)
        write_APB_TIMEOUT_ADDRESS_value = aData
        flag_APB_TIMEOUT_ADDRESS        = &H1
    End Property

    Property Get read_APB_TIMEOUT_ADDRESS
        read
        read_APB_TIMEOUT_ADDRESS = read_APB_TIMEOUT_ADDRESS_value
    End Property

    Property Let write_APB_TIMEOUT_ADDRESS(aData)
        set_APB_TIMEOUT_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        APB_TIMEOUT_ADDRESS_mask = &Hffffffff
        if data_low > LONG_MAX then
            if APB_TIMEOUT_ADDRESS_mask = mask then
                read_APB_TIMEOUT_ADDRESS_value = data_low
            else
                read_APB_TIMEOUT_ADDRESS_value = (data_low - H8000_0000) and APB_TIMEOUT_ADDRESS_mask
            end If
        else
            read_APB_TIMEOUT_ADDRESS_value = data_low and APB_TIMEOUT_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_APB_TIMEOUT_ADDRESS = &H0 Then read
        If flag_APB_TIMEOUT_ADDRESS = &H0 Then write_APB_TIMEOUT_ADDRESS_value = get_APB_TIMEOUT_ADDRESS

        regValue = leftShift(write_APB_TIMEOUT_ADDRESS_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        APB_TIMEOUT_ADDRESS_mask = &Hffffffff
        if data_low > LONG_MAX then
            if APB_TIMEOUT_ADDRESS_mask = mask then
                read_APB_TIMEOUT_ADDRESS_value = data_low
            else
                read_APB_TIMEOUT_ADDRESS_value = (data_low - H8000_0000) and APB_TIMEOUT_ADDRESS_mask
            end If
        else
            read_APB_TIMEOUT_ADDRESS_value = data_low and APB_TIMEOUT_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_APB_TIMEOUT_ADDRESS_value = &H0
        flag_APB_TIMEOUT_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : CFG_apb_timeout_irq_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' APB_TIMEOUT_STATUS                         [0:0]            get_APB_TIMEOUT_STATUS
''                                                             set_APB_TIMEOUT_STATUS
''                                                             read_APB_TIMEOUT_STATUS
''                                                             write_APB_TIMEOUT_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_CFG_apb_timeout_irq_status
    Private write_APB_TIMEOUT_STATUS_value
    Private read_APB_TIMEOUT_STATUS_value
    Private flag_APB_TIMEOUT_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_APB_TIMEOUT_STATUS
        get_APB_TIMEOUT_STATUS = read_APB_TIMEOUT_STATUS_value
    End Property

    Property Let set_APB_TIMEOUT_STATUS(aData)
        write_APB_TIMEOUT_STATUS_value = aData
        flag_APB_TIMEOUT_STATUS        = &H1
    End Property

    Property Get read_APB_TIMEOUT_STATUS
        read
        read_APB_TIMEOUT_STATUS = read_APB_TIMEOUT_STATUS_value
    End Property

    Property Let write_APB_TIMEOUT_STATUS(aData)
        set_APB_TIMEOUT_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        APB_TIMEOUT_STATUS_mask = &H1
        if data_low > LONG_MAX then
            if APB_TIMEOUT_STATUS_mask = mask then
                read_APB_TIMEOUT_STATUS_value = data_low
            else
                read_APB_TIMEOUT_STATUS_value = (data_low - H8000_0000) and APB_TIMEOUT_STATUS_mask
            end If
        else
            read_APB_TIMEOUT_STATUS_value = data_low and APB_TIMEOUT_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_APB_TIMEOUT_STATUS = &H0 Then read
        If flag_APB_TIMEOUT_STATUS = &H0 Then write_APB_TIMEOUT_STATUS_value = get_APB_TIMEOUT_STATUS

        regValue = leftShift((write_APB_TIMEOUT_STATUS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        APB_TIMEOUT_STATUS_mask = &H1
        if data_low > LONG_MAX then
            if APB_TIMEOUT_STATUS_mask = mask then
                read_APB_TIMEOUT_STATUS_value = data_low
            else
                read_APB_TIMEOUT_STATUS_value = (data_low - H8000_0000) and APB_TIMEOUT_STATUS_mask
            end If
        else
            read_APB_TIMEOUT_STATUS_value = data_low and APB_TIMEOUT_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_APB_TIMEOUT_STATUS_value = &H0
        flag_APB_TIMEOUT_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : CFG_nmi_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NMI_STATUS                                 [31:0]           get_NMI_STATUS
''                                                             set_NMI_STATUS
''                                                             read_NMI_STATUS
''                                                             write_NMI_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_CFG_nmi_status
    Private write_NMI_STATUS_value
    Private read_NMI_STATUS_value
    Private flag_NMI_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NMI_STATUS
        get_NMI_STATUS = read_NMI_STATUS_value
    End Property

    Property Let set_NMI_STATUS(aData)
        write_NMI_STATUS_value = aData
        flag_NMI_STATUS        = &H1
    End Property

    Property Get read_NMI_STATUS
        read
        read_NMI_STATUS = read_NMI_STATUS_value
    End Property

    Property Let write_NMI_STATUS(aData)
        set_NMI_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NMI_STATUS_mask = &Hffffffff
        if data_low > LONG_MAX then
            if NMI_STATUS_mask = mask then
                read_NMI_STATUS_value = data_low
            else
                read_NMI_STATUS_value = (data_low - H8000_0000) and NMI_STATUS_mask
            end If
        else
            read_NMI_STATUS_value = data_low and NMI_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_NMI_STATUS = &H0 Then read
        If flag_NMI_STATUS = &H0 Then write_NMI_STATUS_value = get_NMI_STATUS

        regValue = leftShift(write_NMI_STATUS_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NMI_STATUS_mask = &Hffffffff
        if data_low > LONG_MAX then
            if NMI_STATUS_mask = mask then
                read_NMI_STATUS_value = data_low
            else
                read_NMI_STATUS_value = (data_low - H8000_0000) and NMI_STATUS_mask
            end If
        else
            read_NMI_STATUS_value = data_low and NMI_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NMI_STATUS_value = &H0
        flag_NMI_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : CFG_debug_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEBUG_STATUS                               [23:0]           get_DEBUG_STATUS
''                                                             set_DEBUG_STATUS
''                                                             read_DEBUG_STATUS
''                                                             write_DEBUG_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_CFG_debug_status
    Private write_DEBUG_STATUS_value
    Private read_DEBUG_STATUS_value
    Private flag_DEBUG_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DEBUG_STATUS
        get_DEBUG_STATUS = read_DEBUG_STATUS_value
    End Property

    Property Let set_DEBUG_STATUS(aData)
        write_DEBUG_STATUS_value = aData
        flag_DEBUG_STATUS        = &H1
    End Property

    Property Get read_DEBUG_STATUS
        read
        read_DEBUG_STATUS = read_DEBUG_STATUS_value
    End Property

    Property Let write_DEBUG_STATUS(aData)
        set_DEBUG_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEBUG_STATUS_mask = &Hffffff
        if data_low > LONG_MAX then
            if DEBUG_STATUS_mask = mask then
                read_DEBUG_STATUS_value = data_low
            else
                read_DEBUG_STATUS_value = (data_low - H8000_0000) and DEBUG_STATUS_mask
            end If
        else
            read_DEBUG_STATUS_value = data_low and DEBUG_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_DEBUG_STATUS = &H0 Then read
        If flag_DEBUG_STATUS = &H0 Then write_DEBUG_STATUS_value = get_DEBUG_STATUS

        regValue = leftShift((write_DEBUG_STATUS_value and &Hffffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEBUG_STATUS_mask = &Hffffff
        if data_low > LONG_MAX then
            if DEBUG_STATUS_mask = mask then
                read_DEBUG_STATUS_value = data_low
            else
                read_DEBUG_STATUS_value = (data_low - H8000_0000) and DEBUG_STATUS_mask
            end If
        else
            read_DEBUG_STATUS_value = data_low and DEBUG_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEBUG_STATUS_value = &H0
        flag_DEBUG_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : CFG_hsm_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HSM_STATUS                                 [6:0]            get_HSM_STATUS
''                                                             set_HSM_STATUS
''                                                             read_HSM_STATUS
''                                                             write_HSM_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_CFG_hsm_status
    Private write_HSM_STATUS_value
    Private read_HSM_STATUS_value
    Private flag_HSM_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_HSM_STATUS
        get_HSM_STATUS = read_HSM_STATUS_value
    End Property

    Property Let set_HSM_STATUS(aData)
        write_HSM_STATUS_value = aData
        flag_HSM_STATUS        = &H1
    End Property

    Property Get read_HSM_STATUS
        read
        read_HSM_STATUS = read_HSM_STATUS_value
    End Property

    Property Let write_HSM_STATUS(aData)
        set_HSM_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        HSM_STATUS_mask = &H7f
        if data_low > LONG_MAX then
            if HSM_STATUS_mask = mask then
                read_HSM_STATUS_value = data_low
            else
                read_HSM_STATUS_value = (data_low - H8000_0000) and HSM_STATUS_mask
            end If
        else
            read_HSM_STATUS_value = data_low and HSM_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_HSM_STATUS = &H0 Then read
        If flag_HSM_STATUS = &H0 Then write_HSM_STATUS_value = get_HSM_STATUS

        regValue = leftShift((write_HSM_STATUS_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        HSM_STATUS_mask = &H7f
        if data_low > LONG_MAX then
            if HSM_STATUS_mask = mask then
                read_HSM_STATUS_value = data_low
            else
                read_HSM_STATUS_value = (data_low - H8000_0000) and HSM_STATUS_mask
            end If
        else
            read_HSM_STATUS_value = data_low and HSM_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HSM_STATUS_value = &H0
        flag_HSM_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_raw0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_raw0                              [31:0]           get_cpu_intr_raw0
''                                                             set_cpu_intr_raw0
''                                                             read_cpu_intr_raw0
''                                                             write_cpu_intr_raw0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_raw0
    Private write_cpu_intr_raw0_value
    Private read_cpu_intr_raw0_value
    Private flag_cpu_intr_raw0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_raw0
        get_cpu_intr_raw0 = read_cpu_intr_raw0_value
    End Property

    Property Let set_cpu_intr_raw0(aData)
        write_cpu_intr_raw0_value = aData
        flag_cpu_intr_raw0        = &H1
    End Property

    Property Get read_cpu_intr_raw0
        read
        read_cpu_intr_raw0 = read_cpu_intr_raw0_value
    End Property

    Property Let write_cpu_intr_raw0(aData)
        set_cpu_intr_raw0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw0_mask = mask then
                read_cpu_intr_raw0_value = data_low
            else
                read_cpu_intr_raw0_value = (data_low - H8000_0000) and cpu_intr_raw0_mask
            end If
        else
            read_cpu_intr_raw0_value = data_low and cpu_intr_raw0_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_raw0 = &H0 Then read
        If flag_cpu_intr_raw0 = &H0 Then write_cpu_intr_raw0_value = get_cpu_intr_raw0

        regValue = leftShift(write_cpu_intr_raw0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw0_mask = mask then
                read_cpu_intr_raw0_value = data_low
            else
                read_cpu_intr_raw0_value = (data_low - H8000_0000) and cpu_intr_raw0_mask
            end If
        else
            read_cpu_intr_raw0_value = data_low and cpu_intr_raw0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_raw0_value = &H0
        flag_cpu_intr_raw0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_raw1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_raw1                              [31:0]           get_cpu_intr_raw1
''                                                             set_cpu_intr_raw1
''                                                             read_cpu_intr_raw1
''                                                             write_cpu_intr_raw1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_raw1
    Private write_cpu_intr_raw1_value
    Private read_cpu_intr_raw1_value
    Private flag_cpu_intr_raw1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_raw1
        get_cpu_intr_raw1 = read_cpu_intr_raw1_value
    End Property

    Property Let set_cpu_intr_raw1(aData)
        write_cpu_intr_raw1_value = aData
        flag_cpu_intr_raw1        = &H1
    End Property

    Property Get read_cpu_intr_raw1
        read
        read_cpu_intr_raw1 = read_cpu_intr_raw1_value
    End Property

    Property Let write_cpu_intr_raw1(aData)
        set_cpu_intr_raw1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw1_mask = mask then
                read_cpu_intr_raw1_value = data_low
            else
                read_cpu_intr_raw1_value = (data_low - H8000_0000) and cpu_intr_raw1_mask
            end If
        else
            read_cpu_intr_raw1_value = data_low and cpu_intr_raw1_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_raw1 = &H0 Then read
        If flag_cpu_intr_raw1 = &H0 Then write_cpu_intr_raw1_value = get_cpu_intr_raw1

        regValue = leftShift(write_cpu_intr_raw1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw1_mask = mask then
                read_cpu_intr_raw1_value = data_low
            else
                read_cpu_intr_raw1_value = (data_low - H8000_0000) and cpu_intr_raw1_mask
            end If
        else
            read_cpu_intr_raw1_value = data_low and cpu_intr_raw1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_raw1_value = &H0
        flag_cpu_intr_raw1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_raw2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_raw2                              [31:0]           get_cpu_intr_raw2
''                                                             set_cpu_intr_raw2
''                                                             read_cpu_intr_raw2
''                                                             write_cpu_intr_raw2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_raw2
    Private write_cpu_intr_raw2_value
    Private read_cpu_intr_raw2_value
    Private flag_cpu_intr_raw2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_raw2
        get_cpu_intr_raw2 = read_cpu_intr_raw2_value
    End Property

    Property Let set_cpu_intr_raw2(aData)
        write_cpu_intr_raw2_value = aData
        flag_cpu_intr_raw2        = &H1
    End Property

    Property Get read_cpu_intr_raw2
        read
        read_cpu_intr_raw2 = read_cpu_intr_raw2_value
    End Property

    Property Let write_cpu_intr_raw2(aData)
        set_cpu_intr_raw2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw2_mask = mask then
                read_cpu_intr_raw2_value = data_low
            else
                read_cpu_intr_raw2_value = (data_low - H8000_0000) and cpu_intr_raw2_mask
            end If
        else
            read_cpu_intr_raw2_value = data_low and cpu_intr_raw2_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_raw2 = &H0 Then read
        If flag_cpu_intr_raw2 = &H0 Then write_cpu_intr_raw2_value = get_cpu_intr_raw2

        regValue = leftShift(write_cpu_intr_raw2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw2_mask = mask then
                read_cpu_intr_raw2_value = data_low
            else
                read_cpu_intr_raw2_value = (data_low - H8000_0000) and cpu_intr_raw2_mask
            end If
        else
            read_cpu_intr_raw2_value = data_low and cpu_intr_raw2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_raw2_value = &H0
        flag_cpu_intr_raw2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_raw3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_raw3                              [31:0]           get_cpu_intr_raw3
''                                                             set_cpu_intr_raw3
''                                                             read_cpu_intr_raw3
''                                                             write_cpu_intr_raw3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_raw3
    Private write_cpu_intr_raw3_value
    Private read_cpu_intr_raw3_value
    Private flag_cpu_intr_raw3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_raw3
        get_cpu_intr_raw3 = read_cpu_intr_raw3_value
    End Property

    Property Let set_cpu_intr_raw3(aData)
        write_cpu_intr_raw3_value = aData
        flag_cpu_intr_raw3        = &H1
    End Property

    Property Get read_cpu_intr_raw3
        read
        read_cpu_intr_raw3 = read_cpu_intr_raw3_value
    End Property

    Property Let write_cpu_intr_raw3(aData)
        set_cpu_intr_raw3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw3_mask = mask then
                read_cpu_intr_raw3_value = data_low
            else
                read_cpu_intr_raw3_value = (data_low - H8000_0000) and cpu_intr_raw3_mask
            end If
        else
            read_cpu_intr_raw3_value = data_low and cpu_intr_raw3_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_raw3 = &H0 Then read
        If flag_cpu_intr_raw3 = &H0 Then write_cpu_intr_raw3_value = get_cpu_intr_raw3

        regValue = leftShift(write_cpu_intr_raw3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_raw3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_raw3_mask = mask then
                read_cpu_intr_raw3_value = data_low
            else
                read_cpu_intr_raw3_value = (data_low - H8000_0000) and cpu_intr_raw3_mask
            end If
        else
            read_cpu_intr_raw3_value = data_low and cpu_intr_raw3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_raw3_value = &H0
        flag_cpu_intr_raw3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_stat0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_stat0                             [31:0]           get_cpu_intr_stat0
''                                                             set_cpu_intr_stat0
''                                                             read_cpu_intr_stat0
''                                                             write_cpu_intr_stat0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_stat0
    Private write_cpu_intr_stat0_value
    Private read_cpu_intr_stat0_value
    Private flag_cpu_intr_stat0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_stat0
        get_cpu_intr_stat0 = read_cpu_intr_stat0_value
    End Property

    Property Let set_cpu_intr_stat0(aData)
        write_cpu_intr_stat0_value = aData
        flag_cpu_intr_stat0        = &H1
    End Property

    Property Get read_cpu_intr_stat0
        read
        read_cpu_intr_stat0 = read_cpu_intr_stat0_value
    End Property

    Property Let write_cpu_intr_stat0(aData)
        set_cpu_intr_stat0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat0_mask = mask then
                read_cpu_intr_stat0_value = data_low
            else
                read_cpu_intr_stat0_value = (data_low - H8000_0000) and cpu_intr_stat0_mask
            end If
        else
            read_cpu_intr_stat0_value = data_low and cpu_intr_stat0_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_stat0 = &H0 Then read
        If flag_cpu_intr_stat0 = &H0 Then write_cpu_intr_stat0_value = get_cpu_intr_stat0

        regValue = leftShift(write_cpu_intr_stat0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat0_mask = mask then
                read_cpu_intr_stat0_value = data_low
            else
                read_cpu_intr_stat0_value = (data_low - H8000_0000) and cpu_intr_stat0_mask
            end If
        else
            read_cpu_intr_stat0_value = data_low and cpu_intr_stat0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_stat0_value = &H0
        flag_cpu_intr_stat0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_stat1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_stat1                             [31:0]           get_cpu_intr_stat1
''                                                             set_cpu_intr_stat1
''                                                             read_cpu_intr_stat1
''                                                             write_cpu_intr_stat1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_stat1
    Private write_cpu_intr_stat1_value
    Private read_cpu_intr_stat1_value
    Private flag_cpu_intr_stat1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hbc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_stat1
        get_cpu_intr_stat1 = read_cpu_intr_stat1_value
    End Property

    Property Let set_cpu_intr_stat1(aData)
        write_cpu_intr_stat1_value = aData
        flag_cpu_intr_stat1        = &H1
    End Property

    Property Get read_cpu_intr_stat1
        read
        read_cpu_intr_stat1 = read_cpu_intr_stat1_value
    End Property

    Property Let write_cpu_intr_stat1(aData)
        set_cpu_intr_stat1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat1_mask = mask then
                read_cpu_intr_stat1_value = data_low
            else
                read_cpu_intr_stat1_value = (data_low - H8000_0000) and cpu_intr_stat1_mask
            end If
        else
            read_cpu_intr_stat1_value = data_low and cpu_intr_stat1_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_stat1 = &H0 Then read
        If flag_cpu_intr_stat1 = &H0 Then write_cpu_intr_stat1_value = get_cpu_intr_stat1

        regValue = leftShift(write_cpu_intr_stat1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat1_mask = mask then
                read_cpu_intr_stat1_value = data_low
            else
                read_cpu_intr_stat1_value = (data_low - H8000_0000) and cpu_intr_stat1_mask
            end If
        else
            read_cpu_intr_stat1_value = data_low and cpu_intr_stat1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_stat1_value = &H0
        flag_cpu_intr_stat1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_stat2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_stat2                             [31:0]           get_cpu_intr_stat2
''                                                             set_cpu_intr_stat2
''                                                             read_cpu_intr_stat2
''                                                             write_cpu_intr_stat2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_stat2
    Private write_cpu_intr_stat2_value
    Private read_cpu_intr_stat2_value
    Private flag_cpu_intr_stat2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_stat2
        get_cpu_intr_stat2 = read_cpu_intr_stat2_value
    End Property

    Property Let set_cpu_intr_stat2(aData)
        write_cpu_intr_stat2_value = aData
        flag_cpu_intr_stat2        = &H1
    End Property

    Property Get read_cpu_intr_stat2
        read
        read_cpu_intr_stat2 = read_cpu_intr_stat2_value
    End Property

    Property Let write_cpu_intr_stat2(aData)
        set_cpu_intr_stat2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat2_mask = mask then
                read_cpu_intr_stat2_value = data_low
            else
                read_cpu_intr_stat2_value = (data_low - H8000_0000) and cpu_intr_stat2_mask
            end If
        else
            read_cpu_intr_stat2_value = data_low and cpu_intr_stat2_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_stat2 = &H0 Then read
        If flag_cpu_intr_stat2 = &H0 Then write_cpu_intr_stat2_value = get_cpu_intr_stat2

        regValue = leftShift(write_cpu_intr_stat2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat2_mask = mask then
                read_cpu_intr_stat2_value = data_low
            else
                read_cpu_intr_stat2_value = (data_low - H8000_0000) and cpu_intr_stat2_mask
            end If
        else
            read_cpu_intr_stat2_value = data_low and cpu_intr_stat2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_stat2_value = &H0
        flag_cpu_intr_stat2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_stat3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_stat3                             [31:0]           get_cpu_intr_stat3
''                                                             set_cpu_intr_stat3
''                                                             read_cpu_intr_stat3
''                                                             write_cpu_intr_stat3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_stat3
    Private write_cpu_intr_stat3_value
    Private read_cpu_intr_stat3_value
    Private flag_cpu_intr_stat3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_stat3
        get_cpu_intr_stat3 = read_cpu_intr_stat3_value
    End Property

    Property Let set_cpu_intr_stat3(aData)
        write_cpu_intr_stat3_value = aData
        flag_cpu_intr_stat3        = &H1
    End Property

    Property Get read_cpu_intr_stat3
        read
        read_cpu_intr_stat3 = read_cpu_intr_stat3_value
    End Property

    Property Let write_cpu_intr_stat3(aData)
        set_cpu_intr_stat3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat3_mask = mask then
                read_cpu_intr_stat3_value = data_low
            else
                read_cpu_intr_stat3_value = (data_low - H8000_0000) and cpu_intr_stat3_mask
            end If
        else
            read_cpu_intr_stat3_value = data_low and cpu_intr_stat3_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_stat3 = &H0 Then read
        If flag_cpu_intr_stat3 = &H0 Then write_cpu_intr_stat3_value = get_cpu_intr_stat3

        regValue = leftShift(write_cpu_intr_stat3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_stat3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_stat3_mask = mask then
                read_cpu_intr_stat3_value = data_low
            else
                read_cpu_intr_stat3_value = (data_low - H8000_0000) and cpu_intr_stat3_mask
            end If
        else
            read_cpu_intr_stat3_value = data_low and cpu_intr_stat3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_stat3_value = &H0
        flag_cpu_intr_stat3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_mask0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_mask0                             [31:0]           get_cpu_intr_mask0
''                                                             set_cpu_intr_mask0
''                                                             read_cpu_intr_mask0
''                                                             write_cpu_intr_mask0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_mask0
    Private write_cpu_intr_mask0_value
    Private read_cpu_intr_mask0_value
    Private flag_cpu_intr_mask0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_mask0
        get_cpu_intr_mask0 = read_cpu_intr_mask0_value
    End Property

    Property Let set_cpu_intr_mask0(aData)
        write_cpu_intr_mask0_value = aData
        flag_cpu_intr_mask0        = &H1
    End Property

    Property Get read_cpu_intr_mask0
        read
        read_cpu_intr_mask0 = read_cpu_intr_mask0_value
    End Property

    Property Let write_cpu_intr_mask0(aData)
        set_cpu_intr_mask0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask0_mask = mask then
                read_cpu_intr_mask0_value = data_low
            else
                read_cpu_intr_mask0_value = (data_low - H8000_0000) and cpu_intr_mask0_mask
            end If
        else
            read_cpu_intr_mask0_value = data_low and cpu_intr_mask0_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_mask0 = &H0 Then read
        If flag_cpu_intr_mask0 = &H0 Then write_cpu_intr_mask0_value = get_cpu_intr_mask0

        regValue = leftShift(write_cpu_intr_mask0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask0_mask = mask then
                read_cpu_intr_mask0_value = data_low
            else
                read_cpu_intr_mask0_value = (data_low - H8000_0000) and cpu_intr_mask0_mask
            end If
        else
            read_cpu_intr_mask0_value = data_low and cpu_intr_mask0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_mask0_value = &H0
        flag_cpu_intr_mask0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_mask1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_mask1                             [31:0]           get_cpu_intr_mask1
''                                                             set_cpu_intr_mask1
''                                                             read_cpu_intr_mask1
''                                                             write_cpu_intr_mask1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_mask1
    Private write_cpu_intr_mask1_value
    Private read_cpu_intr_mask1_value
    Private flag_cpu_intr_mask1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hcc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_mask1
        get_cpu_intr_mask1 = read_cpu_intr_mask1_value
    End Property

    Property Let set_cpu_intr_mask1(aData)
        write_cpu_intr_mask1_value = aData
        flag_cpu_intr_mask1        = &H1
    End Property

    Property Get read_cpu_intr_mask1
        read
        read_cpu_intr_mask1 = read_cpu_intr_mask1_value
    End Property

    Property Let write_cpu_intr_mask1(aData)
        set_cpu_intr_mask1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask1_mask = mask then
                read_cpu_intr_mask1_value = data_low
            else
                read_cpu_intr_mask1_value = (data_low - H8000_0000) and cpu_intr_mask1_mask
            end If
        else
            read_cpu_intr_mask1_value = data_low and cpu_intr_mask1_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_mask1 = &H0 Then read
        If flag_cpu_intr_mask1 = &H0 Then write_cpu_intr_mask1_value = get_cpu_intr_mask1

        regValue = leftShift(write_cpu_intr_mask1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask1_mask = mask then
                read_cpu_intr_mask1_value = data_low
            else
                read_cpu_intr_mask1_value = (data_low - H8000_0000) and cpu_intr_mask1_mask
            end If
        else
            read_cpu_intr_mask1_value = data_low and cpu_intr_mask1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_mask1_value = &H0
        flag_cpu_intr_mask1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_mask2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_mask2                             [31:0]           get_cpu_intr_mask2
''                                                             set_cpu_intr_mask2
''                                                             read_cpu_intr_mask2
''                                                             write_cpu_intr_mask2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_mask2
    Private write_cpu_intr_mask2_value
    Private read_cpu_intr_mask2_value
    Private flag_cpu_intr_mask2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_mask2
        get_cpu_intr_mask2 = read_cpu_intr_mask2_value
    End Property

    Property Let set_cpu_intr_mask2(aData)
        write_cpu_intr_mask2_value = aData
        flag_cpu_intr_mask2        = &H1
    End Property

    Property Get read_cpu_intr_mask2
        read
        read_cpu_intr_mask2 = read_cpu_intr_mask2_value
    End Property

    Property Let write_cpu_intr_mask2(aData)
        set_cpu_intr_mask2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask2_mask = mask then
                read_cpu_intr_mask2_value = data_low
            else
                read_cpu_intr_mask2_value = (data_low - H8000_0000) and cpu_intr_mask2_mask
            end If
        else
            read_cpu_intr_mask2_value = data_low and cpu_intr_mask2_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_mask2 = &H0 Then read
        If flag_cpu_intr_mask2 = &H0 Then write_cpu_intr_mask2_value = get_cpu_intr_mask2

        regValue = leftShift(write_cpu_intr_mask2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask2_mask = mask then
                read_cpu_intr_mask2_value = data_low
            else
                read_cpu_intr_mask2_value = (data_low - H8000_0000) and cpu_intr_mask2_mask
            end If
        else
            read_cpu_intr_mask2_value = data_low and cpu_intr_mask2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_mask2_value = &H0
        flag_cpu_intr_mask2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_mask3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_mask3                             [31:0]           get_cpu_intr_mask3
''                                                             set_cpu_intr_mask3
''                                                             read_cpu_intr_mask3
''                                                             write_cpu_intr_mask3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_mask3
    Private write_cpu_intr_mask3_value
    Private read_cpu_intr_mask3_value
    Private flag_cpu_intr_mask3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_mask3
        get_cpu_intr_mask3 = read_cpu_intr_mask3_value
    End Property

    Property Let set_cpu_intr_mask3(aData)
        write_cpu_intr_mask3_value = aData
        flag_cpu_intr_mask3        = &H1
    End Property

    Property Get read_cpu_intr_mask3
        read
        read_cpu_intr_mask3 = read_cpu_intr_mask3_value
    End Property

    Property Let write_cpu_intr_mask3(aData)
        set_cpu_intr_mask3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask3_mask = mask then
                read_cpu_intr_mask3_value = data_low
            else
                read_cpu_intr_mask3_value = (data_low - H8000_0000) and cpu_intr_mask3_mask
            end If
        else
            read_cpu_intr_mask3_value = data_low and cpu_intr_mask3_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_mask3 = &H0 Then read
        If flag_cpu_intr_mask3 = &H0 Then write_cpu_intr_mask3_value = get_cpu_intr_mask3

        regValue = leftShift(write_cpu_intr_mask3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_mask3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_mask3_mask = mask then
                read_cpu_intr_mask3_value = data_low
            else
                read_cpu_intr_mask3_value = (data_low - H8000_0000) and cpu_intr_mask3_mask
            end If
        else
            read_cpu_intr_mask3_value = data_low and cpu_intr_mask3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_mask3_value = &H0
        flag_cpu_intr_mask3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_force0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_force0                            [31:0]           get_cpu_intr_force0
''                                                             set_cpu_intr_force0
''                                                             read_cpu_intr_force0
''                                                             write_cpu_intr_force0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_force0
    Private write_cpu_intr_force0_value
    Private read_cpu_intr_force0_value
    Private flag_cpu_intr_force0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_force0
        get_cpu_intr_force0 = read_cpu_intr_force0_value
    End Property

    Property Let set_cpu_intr_force0(aData)
        write_cpu_intr_force0_value = aData
        flag_cpu_intr_force0        = &H1
    End Property

    Property Get read_cpu_intr_force0
        read
        read_cpu_intr_force0 = read_cpu_intr_force0_value
    End Property

    Property Let write_cpu_intr_force0(aData)
        set_cpu_intr_force0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force0_mask = mask then
                read_cpu_intr_force0_value = data_low
            else
                read_cpu_intr_force0_value = (data_low - H8000_0000) and cpu_intr_force0_mask
            end If
        else
            read_cpu_intr_force0_value = data_low and cpu_intr_force0_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_force0 = &H0 Then read
        If flag_cpu_intr_force0 = &H0 Then write_cpu_intr_force0_value = get_cpu_intr_force0

        regValue = leftShift(write_cpu_intr_force0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force0_mask = mask then
                read_cpu_intr_force0_value = data_low
            else
                read_cpu_intr_force0_value = (data_low - H8000_0000) and cpu_intr_force0_mask
            end If
        else
            read_cpu_intr_force0_value = data_low and cpu_intr_force0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_force0_value = &H0
        flag_cpu_intr_force0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_force1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_force1                            [31:0]           get_cpu_intr_force1
''                                                             set_cpu_intr_force1
''                                                             read_cpu_intr_force1
''                                                             write_cpu_intr_force1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_force1
    Private write_cpu_intr_force1_value
    Private read_cpu_intr_force1_value
    Private flag_cpu_intr_force1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hdc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_force1
        get_cpu_intr_force1 = read_cpu_intr_force1_value
    End Property

    Property Let set_cpu_intr_force1(aData)
        write_cpu_intr_force1_value = aData
        flag_cpu_intr_force1        = &H1
    End Property

    Property Get read_cpu_intr_force1
        read
        read_cpu_intr_force1 = read_cpu_intr_force1_value
    End Property

    Property Let write_cpu_intr_force1(aData)
        set_cpu_intr_force1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force1_mask = mask then
                read_cpu_intr_force1_value = data_low
            else
                read_cpu_intr_force1_value = (data_low - H8000_0000) and cpu_intr_force1_mask
            end If
        else
            read_cpu_intr_force1_value = data_low and cpu_intr_force1_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_force1 = &H0 Then read
        If flag_cpu_intr_force1 = &H0 Then write_cpu_intr_force1_value = get_cpu_intr_force1

        regValue = leftShift(write_cpu_intr_force1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force1_mask = mask then
                read_cpu_intr_force1_value = data_low
            else
                read_cpu_intr_force1_value = (data_low - H8000_0000) and cpu_intr_force1_mask
            end If
        else
            read_cpu_intr_force1_value = data_low and cpu_intr_force1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_force1_value = &H0
        flag_cpu_intr_force1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_force2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_force2                            [31:0]           get_cpu_intr_force2
''                                                             set_cpu_intr_force2
''                                                             read_cpu_intr_force2
''                                                             write_cpu_intr_force2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_force2
    Private write_cpu_intr_force2_value
    Private read_cpu_intr_force2_value
    Private flag_cpu_intr_force2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_force2
        get_cpu_intr_force2 = read_cpu_intr_force2_value
    End Property

    Property Let set_cpu_intr_force2(aData)
        write_cpu_intr_force2_value = aData
        flag_cpu_intr_force2        = &H1
    End Property

    Property Get read_cpu_intr_force2
        read
        read_cpu_intr_force2 = read_cpu_intr_force2_value
    End Property

    Property Let write_cpu_intr_force2(aData)
        set_cpu_intr_force2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force2_mask = mask then
                read_cpu_intr_force2_value = data_low
            else
                read_cpu_intr_force2_value = (data_low - H8000_0000) and cpu_intr_force2_mask
            end If
        else
            read_cpu_intr_force2_value = data_low and cpu_intr_force2_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_force2 = &H0 Then read
        If flag_cpu_intr_force2 = &H0 Then write_cpu_intr_force2_value = get_cpu_intr_force2

        regValue = leftShift(write_cpu_intr_force2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force2_mask = mask then
                read_cpu_intr_force2_value = data_low
            else
                read_cpu_intr_force2_value = (data_low - H8000_0000) and cpu_intr_force2_mask
            end If
        else
            read_cpu_intr_force2_value = data_low and cpu_intr_force2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_force2_value = &H0
        flag_cpu_intr_force2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_cpu_intr_force3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_intr_force3                            [31:0]           get_cpu_intr_force3
''                                                             set_cpu_intr_force3
''                                                             read_cpu_intr_force3
''                                                             write_cpu_intr_force3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_cpu_intr_force3
    Private write_cpu_intr_force3_value
    Private read_cpu_intr_force3_value
    Private flag_cpu_intr_force3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_intr_force3
        get_cpu_intr_force3 = read_cpu_intr_force3_value
    End Property

    Property Let set_cpu_intr_force3(aData)
        write_cpu_intr_force3_value = aData
        flag_cpu_intr_force3        = &H1
    End Property

    Property Get read_cpu_intr_force3
        read
        read_cpu_intr_force3 = read_cpu_intr_force3_value
    End Property

    Property Let write_cpu_intr_force3(aData)
        set_cpu_intr_force3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force3_mask = mask then
                read_cpu_intr_force3_value = data_low
            else
                read_cpu_intr_force3_value = (data_low - H8000_0000) and cpu_intr_force3_mask
            end If
        else
            read_cpu_intr_force3_value = data_low and cpu_intr_force3_mask
        end If

    End Sub

    Sub write
        If flag_cpu_intr_force3 = &H0 Then read
        If flag_cpu_intr_force3 = &H0 Then write_cpu_intr_force3_value = get_cpu_intr_force3

        regValue = leftShift(write_cpu_intr_force3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_intr_force3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_intr_force3_mask = mask then
                read_cpu_intr_force3_value = data_low
            else
                read_cpu_intr_force3_value = (data_low - H8000_0000) and cpu_intr_force3_mask
            end If
        else
            read_cpu_intr_force3_value = data_low and cpu_intr_force3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_intr_force3_value = &H0
        flag_cpu_intr_force3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_arm2pcie_intr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_pcie_intr_force_en                      [2:2]            get_sw_pcie_intr_force_en
''                                                             set_sw_pcie_intr_force_en
''                                                             read_sw_pcie_intr_force_en
''                                                             write_sw_pcie_intr_force_en
''---------------------------------------------------------------------------------
'' arm2pcie_host_intr                         [1:0]            get_arm2pcie_host_intr
''                                                             set_arm2pcie_host_intr
''                                                             read_arm2pcie_host_intr
''                                                             write_arm2pcie_host_intr
''---------------------------------------------------------------------------------
Class REGISTER_CFG_arm2pcie_intr
    Private write_sw_pcie_intr_force_en_value
    Private read_sw_pcie_intr_force_en_value
    Private flag_sw_pcie_intr_force_en
    Private write_arm2pcie_host_intr_value
    Private read_arm2pcie_host_intr_value
    Private flag_arm2pcie_host_intr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_pcie_intr_force_en
        get_sw_pcie_intr_force_en = read_sw_pcie_intr_force_en_value
    End Property

    Property Let set_sw_pcie_intr_force_en(aData)
        write_sw_pcie_intr_force_en_value = aData
        flag_sw_pcie_intr_force_en        = &H1
    End Property

    Property Get read_sw_pcie_intr_force_en
        read
        read_sw_pcie_intr_force_en = read_sw_pcie_intr_force_en_value
    End Property

    Property Let write_sw_pcie_intr_force_en(aData)
        set_sw_pcie_intr_force_en = aData
        write
    End Property

    Property Get get_arm2pcie_host_intr
        get_arm2pcie_host_intr = read_arm2pcie_host_intr_value
    End Property

    Property Let set_arm2pcie_host_intr(aData)
        write_arm2pcie_host_intr_value = aData
        flag_arm2pcie_host_intr        = &H1
    End Property

    Property Get read_arm2pcie_host_intr
        read
        read_arm2pcie_host_intr = read_arm2pcie_host_intr_value
    End Property

    Property Let write_arm2pcie_host_intr(aData)
        set_arm2pcie_host_intr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sw_pcie_intr_force_en_value = rightShift(data_low, 2) and &H1
        arm2pcie_host_intr_mask = &H3
        if data_low > LONG_MAX then
            if arm2pcie_host_intr_mask = mask then
                read_arm2pcie_host_intr_value = data_low
            else
                read_arm2pcie_host_intr_value = (data_low - H8000_0000) and arm2pcie_host_intr_mask
            end If
        else
            read_arm2pcie_host_intr_value = data_low and arm2pcie_host_intr_mask
        end If

    End Sub

    Sub write
        If flag_sw_pcie_intr_force_en = &H0 or flag_arm2pcie_host_intr = &H0 Then read
        If flag_sw_pcie_intr_force_en = &H0 Then write_sw_pcie_intr_force_en_value = get_sw_pcie_intr_force_en
        If flag_arm2pcie_host_intr = &H0 Then write_arm2pcie_host_intr_value = get_arm2pcie_host_intr

        regValue = leftShift((write_sw_pcie_intr_force_en_value and &H1), 2) + leftShift((write_arm2pcie_host_intr_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sw_pcie_intr_force_en_value = rightShift(data_low, 2) and &H1
        arm2pcie_host_intr_mask = &H3
        if data_low > LONG_MAX then
            if arm2pcie_host_intr_mask = mask then
                read_arm2pcie_host_intr_value = data_low
            else
                read_arm2pcie_host_intr_value = (data_low - H8000_0000) and arm2pcie_host_intr_mask
            end If
        else
            read_arm2pcie_host_intr_value = data_low and arm2pcie_host_intr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_pcie_intr_force_en_value = &H0
        flag_sw_pcie_intr_force_en        = &H0
        write_arm2pcie_host_intr_value = &H0
        flag_arm2pcie_host_intr        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_stat0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_stat0                            [31:0]           get_PCIE_intr_stat0
''                                                             set_PCIE_intr_stat0
''                                                             read_PCIE_intr_stat0
''                                                             write_PCIE_intr_stat0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_stat0
    Private write_PCIE_intr_stat0_value
    Private read_PCIE_intr_stat0_value
    Private flag_PCIE_intr_stat0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_stat0
        get_PCIE_intr_stat0 = read_PCIE_intr_stat0_value
    End Property

    Property Let set_PCIE_intr_stat0(aData)
        write_PCIE_intr_stat0_value = aData
        flag_PCIE_intr_stat0        = &H1
    End Property

    Property Get read_PCIE_intr_stat0
        read
        read_PCIE_intr_stat0 = read_PCIE_intr_stat0_value
    End Property

    Property Let write_PCIE_intr_stat0(aData)
        set_PCIE_intr_stat0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat0_mask = mask then
                read_PCIE_intr_stat0_value = data_low
            else
                read_PCIE_intr_stat0_value = (data_low - H8000_0000) and PCIE_intr_stat0_mask
            end If
        else
            read_PCIE_intr_stat0_value = data_low and PCIE_intr_stat0_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_stat0 = &H0 Then read
        If flag_PCIE_intr_stat0 = &H0 Then write_PCIE_intr_stat0_value = get_PCIE_intr_stat0

        regValue = leftShift(write_PCIE_intr_stat0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat0_mask = mask then
                read_PCIE_intr_stat0_value = data_low
            else
                read_PCIE_intr_stat0_value = (data_low - H8000_0000) and PCIE_intr_stat0_mask
            end If
        else
            read_PCIE_intr_stat0_value = data_low and PCIE_intr_stat0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_stat0_value = &H0
        flag_PCIE_intr_stat0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_stat1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_stat1                            [31:0]           get_PCIE_intr_stat1
''                                                             set_PCIE_intr_stat1
''                                                             read_PCIE_intr_stat1
''                                                             write_PCIE_intr_stat1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_stat1
    Private write_PCIE_intr_stat1_value
    Private read_PCIE_intr_stat1_value
    Private flag_PCIE_intr_stat1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_stat1
        get_PCIE_intr_stat1 = read_PCIE_intr_stat1_value
    End Property

    Property Let set_PCIE_intr_stat1(aData)
        write_PCIE_intr_stat1_value = aData
        flag_PCIE_intr_stat1        = &H1
    End Property

    Property Get read_PCIE_intr_stat1
        read
        read_PCIE_intr_stat1 = read_PCIE_intr_stat1_value
    End Property

    Property Let write_PCIE_intr_stat1(aData)
        set_PCIE_intr_stat1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat1_mask = mask then
                read_PCIE_intr_stat1_value = data_low
            else
                read_PCIE_intr_stat1_value = (data_low - H8000_0000) and PCIE_intr_stat1_mask
            end If
        else
            read_PCIE_intr_stat1_value = data_low and PCIE_intr_stat1_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_stat1 = &H0 Then read
        If flag_PCIE_intr_stat1 = &H0 Then write_PCIE_intr_stat1_value = get_PCIE_intr_stat1

        regValue = leftShift(write_PCIE_intr_stat1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat1_mask = mask then
                read_PCIE_intr_stat1_value = data_low
            else
                read_PCIE_intr_stat1_value = (data_low - H8000_0000) and PCIE_intr_stat1_mask
            end If
        else
            read_PCIE_intr_stat1_value = data_low and PCIE_intr_stat1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_stat1_value = &H0
        flag_PCIE_intr_stat1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_stat2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_stat2                            [31:0]           get_PCIE_intr_stat2
''                                                             set_PCIE_intr_stat2
''                                                             read_PCIE_intr_stat2
''                                                             write_PCIE_intr_stat2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_stat2
    Private write_PCIE_intr_stat2_value
    Private read_PCIE_intr_stat2_value
    Private flag_PCIE_intr_stat2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_stat2
        get_PCIE_intr_stat2 = read_PCIE_intr_stat2_value
    End Property

    Property Let set_PCIE_intr_stat2(aData)
        write_PCIE_intr_stat2_value = aData
        flag_PCIE_intr_stat2        = &H1
    End Property

    Property Get read_PCIE_intr_stat2
        read
        read_PCIE_intr_stat2 = read_PCIE_intr_stat2_value
    End Property

    Property Let write_PCIE_intr_stat2(aData)
        set_PCIE_intr_stat2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat2_mask = mask then
                read_PCIE_intr_stat2_value = data_low
            else
                read_PCIE_intr_stat2_value = (data_low - H8000_0000) and PCIE_intr_stat2_mask
            end If
        else
            read_PCIE_intr_stat2_value = data_low and PCIE_intr_stat2_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_stat2 = &H0 Then read
        If flag_PCIE_intr_stat2 = &H0 Then write_PCIE_intr_stat2_value = get_PCIE_intr_stat2

        regValue = leftShift(write_PCIE_intr_stat2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat2_mask = mask then
                read_PCIE_intr_stat2_value = data_low
            else
                read_PCIE_intr_stat2_value = (data_low - H8000_0000) and PCIE_intr_stat2_mask
            end If
        else
            read_PCIE_intr_stat2_value = data_low and PCIE_intr_stat2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_stat2_value = &H0
        flag_PCIE_intr_stat2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_stat3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_stat3                            [31:0]           get_PCIE_intr_stat3
''                                                             set_PCIE_intr_stat3
''                                                             read_PCIE_intr_stat3
''                                                             write_PCIE_intr_stat3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_stat3
    Private write_PCIE_intr_stat3_value
    Private read_PCIE_intr_stat3_value
    Private flag_PCIE_intr_stat3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_stat3
        get_PCIE_intr_stat3 = read_PCIE_intr_stat3_value
    End Property

    Property Let set_PCIE_intr_stat3(aData)
        write_PCIE_intr_stat3_value = aData
        flag_PCIE_intr_stat3        = &H1
    End Property

    Property Get read_PCIE_intr_stat3
        read
        read_PCIE_intr_stat3 = read_PCIE_intr_stat3_value
    End Property

    Property Let write_PCIE_intr_stat3(aData)
        set_PCIE_intr_stat3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat3_mask = mask then
                read_PCIE_intr_stat3_value = data_low
            else
                read_PCIE_intr_stat3_value = (data_low - H8000_0000) and PCIE_intr_stat3_mask
            end If
        else
            read_PCIE_intr_stat3_value = data_low and PCIE_intr_stat3_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_stat3 = &H0 Then read
        If flag_PCIE_intr_stat3 = &H0 Then write_PCIE_intr_stat3_value = get_PCIE_intr_stat3

        regValue = leftShift(write_PCIE_intr_stat3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_stat3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_stat3_mask = mask then
                read_PCIE_intr_stat3_value = data_low
            else
                read_PCIE_intr_stat3_value = (data_low - H8000_0000) and PCIE_intr_stat3_mask
            end If
        else
            read_PCIE_intr_stat3_value = data_low and PCIE_intr_stat3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_stat3_value = &H0
        flag_PCIE_intr_stat3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_mask0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_mask0                            [31:0]           get_PCIE_intr_mask0
''                                                             set_PCIE_intr_mask0
''                                                             read_PCIE_intr_mask0
''                                                             write_PCIE_intr_mask0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_mask0
    Private write_PCIE_intr_mask0_value
    Private read_PCIE_intr_mask0_value
    Private flag_PCIE_intr_mask0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_mask0
        get_PCIE_intr_mask0 = read_PCIE_intr_mask0_value
    End Property

    Property Let set_PCIE_intr_mask0(aData)
        write_PCIE_intr_mask0_value = aData
        flag_PCIE_intr_mask0        = &H1
    End Property

    Property Get read_PCIE_intr_mask0
        read
        read_PCIE_intr_mask0 = read_PCIE_intr_mask0_value
    End Property

    Property Let write_PCIE_intr_mask0(aData)
        set_PCIE_intr_mask0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask0_mask = mask then
                read_PCIE_intr_mask0_value = data_low
            else
                read_PCIE_intr_mask0_value = (data_low - H8000_0000) and PCIE_intr_mask0_mask
            end If
        else
            read_PCIE_intr_mask0_value = data_low and PCIE_intr_mask0_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_mask0 = &H0 Then read
        If flag_PCIE_intr_mask0 = &H0 Then write_PCIE_intr_mask0_value = get_PCIE_intr_mask0

        regValue = leftShift(write_PCIE_intr_mask0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask0_mask = mask then
                read_PCIE_intr_mask0_value = data_low
            else
                read_PCIE_intr_mask0_value = (data_low - H8000_0000) and PCIE_intr_mask0_mask
            end If
        else
            read_PCIE_intr_mask0_value = data_low and PCIE_intr_mask0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_mask0_value = &H0
        flag_PCIE_intr_mask0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_mask1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_mask1                            [31:0]           get_PCIE_intr_mask1
''                                                             set_PCIE_intr_mask1
''                                                             read_PCIE_intr_mask1
''                                                             write_PCIE_intr_mask1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_mask1
    Private write_PCIE_intr_mask1_value
    Private read_PCIE_intr_mask1_value
    Private flag_PCIE_intr_mask1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_mask1
        get_PCIE_intr_mask1 = read_PCIE_intr_mask1_value
    End Property

    Property Let set_PCIE_intr_mask1(aData)
        write_PCIE_intr_mask1_value = aData
        flag_PCIE_intr_mask1        = &H1
    End Property

    Property Get read_PCIE_intr_mask1
        read
        read_PCIE_intr_mask1 = read_PCIE_intr_mask1_value
    End Property

    Property Let write_PCIE_intr_mask1(aData)
        set_PCIE_intr_mask1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask1_mask = mask then
                read_PCIE_intr_mask1_value = data_low
            else
                read_PCIE_intr_mask1_value = (data_low - H8000_0000) and PCIE_intr_mask1_mask
            end If
        else
            read_PCIE_intr_mask1_value = data_low and PCIE_intr_mask1_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_mask1 = &H0 Then read
        If flag_PCIE_intr_mask1 = &H0 Then write_PCIE_intr_mask1_value = get_PCIE_intr_mask1

        regValue = leftShift(write_PCIE_intr_mask1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask1_mask = mask then
                read_PCIE_intr_mask1_value = data_low
            else
                read_PCIE_intr_mask1_value = (data_low - H8000_0000) and PCIE_intr_mask1_mask
            end If
        else
            read_PCIE_intr_mask1_value = data_low and PCIE_intr_mask1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_mask1_value = &H0
        flag_PCIE_intr_mask1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_mask2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_mask2                            [31:0]           get_PCIE_intr_mask2
''                                                             set_PCIE_intr_mask2
''                                                             read_PCIE_intr_mask2
''                                                             write_PCIE_intr_mask2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_mask2
    Private write_PCIE_intr_mask2_value
    Private read_PCIE_intr_mask2_value
    Private flag_PCIE_intr_mask2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_mask2
        get_PCIE_intr_mask2 = read_PCIE_intr_mask2_value
    End Property

    Property Let set_PCIE_intr_mask2(aData)
        write_PCIE_intr_mask2_value = aData
        flag_PCIE_intr_mask2        = &H1
    End Property

    Property Get read_PCIE_intr_mask2
        read
        read_PCIE_intr_mask2 = read_PCIE_intr_mask2_value
    End Property

    Property Let write_PCIE_intr_mask2(aData)
        set_PCIE_intr_mask2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask2_mask = mask then
                read_PCIE_intr_mask2_value = data_low
            else
                read_PCIE_intr_mask2_value = (data_low - H8000_0000) and PCIE_intr_mask2_mask
            end If
        else
            read_PCIE_intr_mask2_value = data_low and PCIE_intr_mask2_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_mask2 = &H0 Then read
        If flag_PCIE_intr_mask2 = &H0 Then write_PCIE_intr_mask2_value = get_PCIE_intr_mask2

        regValue = leftShift(write_PCIE_intr_mask2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask2_mask = mask then
                read_PCIE_intr_mask2_value = data_low
            else
                read_PCIE_intr_mask2_value = (data_low - H8000_0000) and PCIE_intr_mask2_mask
            end If
        else
            read_PCIE_intr_mask2_value = data_low and PCIE_intr_mask2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_mask2_value = &H0
        flag_PCIE_intr_mask2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_mask3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_mask3                            [31:0]           get_PCIE_intr_mask3
''                                                             set_PCIE_intr_mask3
''                                                             read_PCIE_intr_mask3
''                                                             write_PCIE_intr_mask3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_mask3
    Private write_PCIE_intr_mask3_value
    Private read_PCIE_intr_mask3_value
    Private flag_PCIE_intr_mask3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_mask3
        get_PCIE_intr_mask3 = read_PCIE_intr_mask3_value
    End Property

    Property Let set_PCIE_intr_mask3(aData)
        write_PCIE_intr_mask3_value = aData
        flag_PCIE_intr_mask3        = &H1
    End Property

    Property Get read_PCIE_intr_mask3
        read
        read_PCIE_intr_mask3 = read_PCIE_intr_mask3_value
    End Property

    Property Let write_PCIE_intr_mask3(aData)
        set_PCIE_intr_mask3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask3_mask = mask then
                read_PCIE_intr_mask3_value = data_low
            else
                read_PCIE_intr_mask3_value = (data_low - H8000_0000) and PCIE_intr_mask3_mask
            end If
        else
            read_PCIE_intr_mask3_value = data_low and PCIE_intr_mask3_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_mask3 = &H0 Then read
        If flag_PCIE_intr_mask3 = &H0 Then write_PCIE_intr_mask3_value = get_PCIE_intr_mask3

        regValue = leftShift(write_PCIE_intr_mask3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_mask3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_mask3_mask = mask then
                read_PCIE_intr_mask3_value = data_low
            else
                read_PCIE_intr_mask3_value = (data_low - H8000_0000) and PCIE_intr_mask3_mask
            end If
        else
            read_PCIE_intr_mask3_value = data_low and PCIE_intr_mask3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_mask3_value = &H0
        flag_PCIE_intr_mask3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_force0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_force0                           [31:0]           get_PCIE_intr_force0
''                                                             set_PCIE_intr_force0
''                                                             read_PCIE_intr_force0
''                                                             write_PCIE_intr_force0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_force0
    Private write_PCIE_intr_force0_value
    Private read_PCIE_intr_force0_value
    Private flag_PCIE_intr_force0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_force0
        get_PCIE_intr_force0 = read_PCIE_intr_force0_value
    End Property

    Property Let set_PCIE_intr_force0(aData)
        write_PCIE_intr_force0_value = aData
        flag_PCIE_intr_force0        = &H1
    End Property

    Property Get read_PCIE_intr_force0
        read
        read_PCIE_intr_force0 = read_PCIE_intr_force0_value
    End Property

    Property Let write_PCIE_intr_force0(aData)
        set_PCIE_intr_force0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force0_mask = mask then
                read_PCIE_intr_force0_value = data_low
            else
                read_PCIE_intr_force0_value = (data_low - H8000_0000) and PCIE_intr_force0_mask
            end If
        else
            read_PCIE_intr_force0_value = data_low and PCIE_intr_force0_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_force0 = &H0 Then read
        If flag_PCIE_intr_force0 = &H0 Then write_PCIE_intr_force0_value = get_PCIE_intr_force0

        regValue = leftShift(write_PCIE_intr_force0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force0_mask = mask then
                read_PCIE_intr_force0_value = data_low
            else
                read_PCIE_intr_force0_value = (data_low - H8000_0000) and PCIE_intr_force0_mask
            end If
        else
            read_PCIE_intr_force0_value = data_low and PCIE_intr_force0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_force0_value = &H0
        flag_PCIE_intr_force0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_force1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_force1                           [31:0]           get_PCIE_intr_force1
''                                                             set_PCIE_intr_force1
''                                                             read_PCIE_intr_force1
''                                                             write_PCIE_intr_force1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_force1
    Private write_PCIE_intr_force1_value
    Private read_PCIE_intr_force1_value
    Private flag_PCIE_intr_force1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_force1
        get_PCIE_intr_force1 = read_PCIE_intr_force1_value
    End Property

    Property Let set_PCIE_intr_force1(aData)
        write_PCIE_intr_force1_value = aData
        flag_PCIE_intr_force1        = &H1
    End Property

    Property Get read_PCIE_intr_force1
        read
        read_PCIE_intr_force1 = read_PCIE_intr_force1_value
    End Property

    Property Let write_PCIE_intr_force1(aData)
        set_PCIE_intr_force1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force1_mask = mask then
                read_PCIE_intr_force1_value = data_low
            else
                read_PCIE_intr_force1_value = (data_low - H8000_0000) and PCIE_intr_force1_mask
            end If
        else
            read_PCIE_intr_force1_value = data_low and PCIE_intr_force1_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_force1 = &H0 Then read
        If flag_PCIE_intr_force1 = &H0 Then write_PCIE_intr_force1_value = get_PCIE_intr_force1

        regValue = leftShift(write_PCIE_intr_force1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force1_mask = mask then
                read_PCIE_intr_force1_value = data_low
            else
                read_PCIE_intr_force1_value = (data_low - H8000_0000) and PCIE_intr_force1_mask
            end If
        else
            read_PCIE_intr_force1_value = data_low and PCIE_intr_force1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_force1_value = &H0
        flag_PCIE_intr_force1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_force2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_force2                           [31:0]           get_PCIE_intr_force2
''                                                             set_PCIE_intr_force2
''                                                             read_PCIE_intr_force2
''                                                             write_PCIE_intr_force2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_force2
    Private write_PCIE_intr_force2_value
    Private read_PCIE_intr_force2_value
    Private flag_PCIE_intr_force2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_force2
        get_PCIE_intr_force2 = read_PCIE_intr_force2_value
    End Property

    Property Let set_PCIE_intr_force2(aData)
        write_PCIE_intr_force2_value = aData
        flag_PCIE_intr_force2        = &H1
    End Property

    Property Get read_PCIE_intr_force2
        read
        read_PCIE_intr_force2 = read_PCIE_intr_force2_value
    End Property

    Property Let write_PCIE_intr_force2(aData)
        set_PCIE_intr_force2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force2_mask = mask then
                read_PCIE_intr_force2_value = data_low
            else
                read_PCIE_intr_force2_value = (data_low - H8000_0000) and PCIE_intr_force2_mask
            end If
        else
            read_PCIE_intr_force2_value = data_low and PCIE_intr_force2_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_force2 = &H0 Then read
        If flag_PCIE_intr_force2 = &H0 Then write_PCIE_intr_force2_value = get_PCIE_intr_force2

        regValue = leftShift(write_PCIE_intr_force2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force2_mask = mask then
                read_PCIE_intr_force2_value = data_low
            else
                read_PCIE_intr_force2_value = (data_low - H8000_0000) and PCIE_intr_force2_mask
            end If
        else
            read_PCIE_intr_force2_value = data_low and PCIE_intr_force2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_force2_value = &H0
        flag_PCIE_intr_force2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_pcie_intr_force3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCIE_intr_force3                           [31:0]           get_PCIE_intr_force3
''                                                             set_PCIE_intr_force3
''                                                             read_PCIE_intr_force3
''                                                             write_PCIE_intr_force3
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_intr_force3
    Private write_PCIE_intr_force3_value
    Private read_PCIE_intr_force3_value
    Private flag_PCIE_intr_force3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCIE_intr_force3
        get_PCIE_intr_force3 = read_PCIE_intr_force3_value
    End Property

    Property Let set_PCIE_intr_force3(aData)
        write_PCIE_intr_force3_value = aData
        flag_PCIE_intr_force3        = &H1
    End Property

    Property Get read_PCIE_intr_force3
        read
        read_PCIE_intr_force3 = read_PCIE_intr_force3_value
    End Property

    Property Let write_PCIE_intr_force3(aData)
        set_PCIE_intr_force3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force3_mask = mask then
                read_PCIE_intr_force3_value = data_low
            else
                read_PCIE_intr_force3_value = (data_low - H8000_0000) and PCIE_intr_force3_mask
            end If
        else
            read_PCIE_intr_force3_value = data_low and PCIE_intr_force3_mask
        end If

    End Sub

    Sub write
        If flag_PCIE_intr_force3 = &H0 Then read
        If flag_PCIE_intr_force3 = &H0 Then write_PCIE_intr_force3_value = get_PCIE_intr_force3

        regValue = leftShift(write_PCIE_intr_force3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCIE_intr_force3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PCIE_intr_force3_mask = mask then
                read_PCIE_intr_force3_value = data_low
            else
                read_PCIE_intr_force3_value = (data_low - H8000_0000) and PCIE_intr_force3_mask
            end If
        else
            read_PCIE_intr_force3_value = data_low and PCIE_intr_force3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCIE_intr_force3_value = &H0
        flag_PCIE_intr_force3        = &H0
    End Sub
End Class


'' @REGISTER : CFG_hw_mem_init_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hw_mem_init_en                             [10:0]           get_hw_mem_init_en
''                                                             set_hw_mem_init_en
''                                                             read_hw_mem_init_en
''                                                             write_hw_mem_init_en
''---------------------------------------------------------------------------------
Class REGISTER_CFG_hw_mem_init_en
    Private write_hw_mem_init_en_value
    Private read_hw_mem_init_en_value
    Private flag_hw_mem_init_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hw_mem_init_en
        get_hw_mem_init_en = read_hw_mem_init_en_value
    End Property

    Property Let set_hw_mem_init_en(aData)
        write_hw_mem_init_en_value = aData
        flag_hw_mem_init_en        = &H1
    End Property

    Property Get read_hw_mem_init_en
        read
        read_hw_mem_init_en = read_hw_mem_init_en_value
    End Property

    Property Let write_hw_mem_init_en(aData)
        set_hw_mem_init_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_mem_init_en_mask = &H7ff
        if data_low > LONG_MAX then
            if hw_mem_init_en_mask = mask then
                read_hw_mem_init_en_value = data_low
            else
                read_hw_mem_init_en_value = (data_low - H8000_0000) and hw_mem_init_en_mask
            end If
        else
            read_hw_mem_init_en_value = data_low and hw_mem_init_en_mask
        end If

    End Sub

    Sub write
        If flag_hw_mem_init_en = &H0 Then read
        If flag_hw_mem_init_en = &H0 Then write_hw_mem_init_en_value = get_hw_mem_init_en

        regValue = leftShift((write_hw_mem_init_en_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_mem_init_en_mask = &H7ff
        if data_low > LONG_MAX then
            if hw_mem_init_en_mask = mask then
                read_hw_mem_init_en_value = data_low
            else
                read_hw_mem_init_en_value = (data_low - H8000_0000) and hw_mem_init_en_mask
            end If
        else
            read_hw_mem_init_en_value = data_low and hw_mem_init_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hw_mem_init_en_value = &H0
        flag_hw_mem_init_en        = &H0
    End Sub
End Class


'' @REGISTER : CFG_hw_mem_init_done_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hw_mem_init_done                           [10:0]           get_hw_mem_init_done
''                                                             set_hw_mem_init_done
''                                                             read_hw_mem_init_done
''                                                             write_hw_mem_init_done
''---------------------------------------------------------------------------------
Class REGISTER_CFG_hw_mem_init_done_sts
    Private write_hw_mem_init_done_value
    Private read_hw_mem_init_done_value
    Private flag_hw_mem_init_done

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hw_mem_init_done
        get_hw_mem_init_done = read_hw_mem_init_done_value
    End Property

    Property Let set_hw_mem_init_done(aData)
        write_hw_mem_init_done_value = aData
        flag_hw_mem_init_done        = &H1
    End Property

    Property Get read_hw_mem_init_done
        read
        read_hw_mem_init_done = read_hw_mem_init_done_value
    End Property

    Property Let write_hw_mem_init_done(aData)
        set_hw_mem_init_done = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_mem_init_done_mask = &H7ff
        if data_low > LONG_MAX then
            if hw_mem_init_done_mask = mask then
                read_hw_mem_init_done_value = data_low
            else
                read_hw_mem_init_done_value = (data_low - H8000_0000) and hw_mem_init_done_mask
            end If
        else
            read_hw_mem_init_done_value = data_low and hw_mem_init_done_mask
        end If

    End Sub

    Sub write
        If flag_hw_mem_init_done = &H0 Then read
        If flag_hw_mem_init_done = &H0 Then write_hw_mem_init_done_value = get_hw_mem_init_done

        regValue = leftShift((write_hw_mem_init_done_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_mem_init_done_mask = &H7ff
        if data_low > LONG_MAX then
            if hw_mem_init_done_mask = mask then
                read_hw_mem_init_done_value = data_low
            else
                read_hw_mem_init_done_value = (data_low - H8000_0000) and hw_mem_init_done_mask
            end If
        else
            read_hw_mem_init_done_value = data_low and hw_mem_init_done_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hw_mem_init_done_value = &H0
        flag_hw_mem_init_done        = &H0
    End Sub
End Class


'' @REGISTER : CFG_spim_if_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cfg_spim_ssb_oeb_val                       [18:18]          get_cfg_spim_ssb_oeb_val
''                                                             set_cfg_spim_ssb_oeb_val
''                                                             read_cfg_spim_ssb_oeb_val
''                                                             write_cfg_spim_ssb_oeb_val
''---------------------------------------------------------------------------------
'' cfg_spim_ssb_val                           [17:17]          get_cfg_spim_ssb_val
''                                                             set_cfg_spim_ssb_val
''                                                             read_cfg_spim_ssb_val
''                                                             write_cfg_spim_ssb_val
''---------------------------------------------------------------------------------
'' cfg_spim_ssb_sw_override                   [16:16]          get_cfg_spim_ssb_sw_override
''                                                             set_cfg_spim_ssb_sw_override
''                                                             read_cfg_spim_ssb_sw_override
''                                                             write_cfg_spim_ssb_sw_override
''---------------------------------------------------------------------------------
'' spare15to12                                [15:12]          get_spare15to12
''                                                             set_spare15to12
''                                                             read_spare15to12
''                                                             write_spare15to12
''---------------------------------------------------------------------------------
'' bypass_spi_slave_done_fix                  [11:11]          get_bypass_spi_slave_done_fix
''                                                             set_bypass_spi_slave_done_fix
''                                                             read_bypass_spi_slave_done_fix
''                                                             write_bypass_spi_slave_done_fix
''---------------------------------------------------------------------------------
'' RSVD                                       [10:10]          get_RSVD
''                                                             set_RSVD
''                                                             read_RSVD
''                                                             write_RSVD
''---------------------------------------------------------------------------------
Class REGISTER_CFG_spim_if_control
    Private write_cfg_spim_ssb_oeb_val_value
    Private read_cfg_spim_ssb_oeb_val_value
    Private flag_cfg_spim_ssb_oeb_val
    Private write_cfg_spim_ssb_val_value
    Private read_cfg_spim_ssb_val_value
    Private flag_cfg_spim_ssb_val
    Private write_cfg_spim_ssb_sw_override_value
    Private read_cfg_spim_ssb_sw_override_value
    Private flag_cfg_spim_ssb_sw_override
    Private write_spare15to12_value
    Private read_spare15to12_value
    Private flag_spare15to12
    Private write_bypass_spi_slave_done_fix_value
    Private read_bypass_spi_slave_done_fix_value
    Private flag_bypass_spi_slave_done_fix
    Private write_RSVD_value
    Private read_RSVD_value
    Private flag_RSVD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cfg_spim_ssb_oeb_val
        get_cfg_spim_ssb_oeb_val = read_cfg_spim_ssb_oeb_val_value
    End Property

    Property Let set_cfg_spim_ssb_oeb_val(aData)
        write_cfg_spim_ssb_oeb_val_value = aData
        flag_cfg_spim_ssb_oeb_val        = &H1
    End Property

    Property Get read_cfg_spim_ssb_oeb_val
        read
        read_cfg_spim_ssb_oeb_val = read_cfg_spim_ssb_oeb_val_value
    End Property

    Property Let write_cfg_spim_ssb_oeb_val(aData)
        set_cfg_spim_ssb_oeb_val = aData
        write
    End Property

    Property Get get_cfg_spim_ssb_val
        get_cfg_spim_ssb_val = read_cfg_spim_ssb_val_value
    End Property

    Property Let set_cfg_spim_ssb_val(aData)
        write_cfg_spim_ssb_val_value = aData
        flag_cfg_spim_ssb_val        = &H1
    End Property

    Property Get read_cfg_spim_ssb_val
        read
        read_cfg_spim_ssb_val = read_cfg_spim_ssb_val_value
    End Property

    Property Let write_cfg_spim_ssb_val(aData)
        set_cfg_spim_ssb_val = aData
        write
    End Property

    Property Get get_cfg_spim_ssb_sw_override
        get_cfg_spim_ssb_sw_override = read_cfg_spim_ssb_sw_override_value
    End Property

    Property Let set_cfg_spim_ssb_sw_override(aData)
        write_cfg_spim_ssb_sw_override_value = aData
        flag_cfg_spim_ssb_sw_override        = &H1
    End Property

    Property Get read_cfg_spim_ssb_sw_override
        read
        read_cfg_spim_ssb_sw_override = read_cfg_spim_ssb_sw_override_value
    End Property

    Property Let write_cfg_spim_ssb_sw_override(aData)
        set_cfg_spim_ssb_sw_override = aData
        write
    End Property

    Property Get get_spare15to12
        get_spare15to12 = read_spare15to12_value
    End Property

    Property Let set_spare15to12(aData)
        write_spare15to12_value = aData
        flag_spare15to12        = &H1
    End Property

    Property Get read_spare15to12
        read
        read_spare15to12 = read_spare15to12_value
    End Property

    Property Let write_spare15to12(aData)
        set_spare15to12 = aData
        write
    End Property

    Property Get get_bypass_spi_slave_done_fix
        get_bypass_spi_slave_done_fix = read_bypass_spi_slave_done_fix_value
    End Property

    Property Let set_bypass_spi_slave_done_fix(aData)
        write_bypass_spi_slave_done_fix_value = aData
        flag_bypass_spi_slave_done_fix        = &H1
    End Property

    Property Get read_bypass_spi_slave_done_fix
        read
        read_bypass_spi_slave_done_fix = read_bypass_spi_slave_done_fix_value
    End Property

    Property Let write_bypass_spi_slave_done_fix(aData)
        set_bypass_spi_slave_done_fix = aData
        write
    End Property

    Property Get get_RSVD
        get_RSVD = read_RSVD_value
    End Property

    Property Let set_RSVD(aData)
        write_RSVD_value = aData
        flag_RSVD        = &H1
    End Property

    Property Get read_RSVD
        read
        read_RSVD = read_RSVD_value
    End Property

    Property Let write_RSVD(aData)
        set_RSVD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cfg_spim_ssb_oeb_val_value = rightShift(data_low, 18) and &H1
        read_cfg_spim_ssb_val_value = rightShift(data_low, 17) and &H1
        read_cfg_spim_ssb_sw_override_value = rightShift(data_low, 16) and &H1
        read_spare15to12_value = rightShift(data_low, 12) and &Hf
        read_bypass_spi_slave_done_fix_value = rightShift(data_low, 11) and &H1
        read_RSVD_value = rightShift(data_low, 10) and &H1

    End Sub

    Sub write
        If flag_cfg_spim_ssb_oeb_val = &H0 or flag_cfg_spim_ssb_val = &H0 or flag_cfg_spim_ssb_sw_override = &H0 or flag_spare15to12 = &H0 or flag_bypass_spi_slave_done_fix = &H0 or flag_RSVD = &H0 Then read
        If flag_cfg_spim_ssb_oeb_val = &H0 Then write_cfg_spim_ssb_oeb_val_value = get_cfg_spim_ssb_oeb_val
        If flag_cfg_spim_ssb_val = &H0 Then write_cfg_spim_ssb_val_value = get_cfg_spim_ssb_val
        If flag_cfg_spim_ssb_sw_override = &H0 Then write_cfg_spim_ssb_sw_override_value = get_cfg_spim_ssb_sw_override
        If flag_spare15to12 = &H0 Then write_spare15to12_value = get_spare15to12
        If flag_bypass_spi_slave_done_fix = &H0 Then write_bypass_spi_slave_done_fix_value = get_bypass_spi_slave_done_fix
        If flag_RSVD = &H0 Then write_RSVD_value = get_RSVD

        regValue = leftShift((write_cfg_spim_ssb_oeb_val_value and &H1), 18) + leftShift((write_cfg_spim_ssb_val_value and &H1), 17) + leftShift((write_cfg_spim_ssb_sw_override_value and &H1), 16) + leftShift((write_spare15to12_value and &Hf), 12) + leftShift((write_bypass_spi_slave_done_fix_value and &H1), 11) + leftShift((write_RSVD_value and &H1), 10)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cfg_spim_ssb_oeb_val_value = rightShift(data_low, 18) and &H1
        read_cfg_spim_ssb_val_value = rightShift(data_low, 17) and &H1
        read_cfg_spim_ssb_sw_override_value = rightShift(data_low, 16) and &H1
        read_spare15to12_value = rightShift(data_low, 12) and &Hf
        read_bypass_spi_slave_done_fix_value = rightShift(data_low, 11) and &H1
        read_RSVD_value = rightShift(data_low, 10) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cfg_spim_ssb_oeb_val_value = &H0
        flag_cfg_spim_ssb_oeb_val        = &H0
        write_cfg_spim_ssb_val_value = &H0
        flag_cfg_spim_ssb_val        = &H0
        write_cfg_spim_ssb_sw_override_value = &H0
        flag_cfg_spim_ssb_sw_override        = &H0
        write_spare15to12_value = &H0
        flag_spare15to12        = &H0
        write_bypass_spi_slave_done_fix_value = &H0
        flag_bypass_spi_slave_done_fix        = &H0
        write_RSVD_value = &H0
        flag_RSVD        = &H0
    End Sub
End Class


'' @REGISTER : CFG_proc_sys_ahb_mon_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' macsec_if_timeout                          [7:7]            get_macsec_if_timeout
''                                                             set_macsec_if_timeout
''                                                             read_macsec_if_timeout
''                                                             write_macsec_if_timeout
''---------------------------------------------------------------------------------
'' spi_10t1s_if_timeout                       [6:6]            get_spi_10t1s_if_timeout
''                                                             set_spi_10t1s_if_timeout
''                                                             read_spi_10t1s_if_timeout
''                                                             write_spi_10t1s_if_timeout
''---------------------------------------------------------------------------------
'' dma_10t1s_if_timeout                       [5:5]            get_dma_10t1s_if_timeout
''                                                             set_dma_10t1s_if_timeout
''                                                             read_dma_10t1s_if_timeout
''                                                             write_dma_10t1s_if_timeout
''---------------------------------------------------------------------------------
'' hsm_if_timeout                             [4:4]            get_hsm_if_timeout
''                                                             set_hsm_if_timeout
''                                                             read_hsm_if_timeout
''                                                             write_hsm_if_timeout
''---------------------------------------------------------------------------------
'' sw_fa_if_timeout                           [3:3]            get_sw_fa_if_timeout
''                                                             set_sw_fa_if_timeout
''                                                             read_sw_fa_if_timeout
''                                                             write_sw_fa_if_timeout
''---------------------------------------------------------------------------------
'' top_bridge_if_timeout                      [2:2]            get_top_bridge_if_timeout
''                                                             set_top_bridge_if_timeout
''                                                             read_top_bridge_if_timeout
''                                                             write_top_bridge_if_timeout
''---------------------------------------------------------------------------------
'' apb_hub_if_timeout                         [1:1]            get_apb_hub_if_timeout
''                                                             set_apb_hub_if_timeout
''                                                             read_apb_hub_if_timeout
''                                                             write_apb_hub_if_timeout
''---------------------------------------------------------------------------------
'' amac_ahb_if_timeout                        [0:0]            get_amac_ahb_if_timeout
''                                                             set_amac_ahb_if_timeout
''                                                             read_amac_ahb_if_timeout
''                                                             write_amac_ahb_if_timeout
''---------------------------------------------------------------------------------
Class REGISTER_CFG_proc_sys_ahb_mon_sts
    Private write_macsec_if_timeout_value
    Private read_macsec_if_timeout_value
    Private flag_macsec_if_timeout
    Private write_spi_10t1s_if_timeout_value
    Private read_spi_10t1s_if_timeout_value
    Private flag_spi_10t1s_if_timeout
    Private write_dma_10t1s_if_timeout_value
    Private read_dma_10t1s_if_timeout_value
    Private flag_dma_10t1s_if_timeout
    Private write_hsm_if_timeout_value
    Private read_hsm_if_timeout_value
    Private flag_hsm_if_timeout
    Private write_sw_fa_if_timeout_value
    Private read_sw_fa_if_timeout_value
    Private flag_sw_fa_if_timeout
    Private write_top_bridge_if_timeout_value
    Private read_top_bridge_if_timeout_value
    Private flag_top_bridge_if_timeout
    Private write_apb_hub_if_timeout_value
    Private read_apb_hub_if_timeout_value
    Private flag_apb_hub_if_timeout
    Private write_amac_ahb_if_timeout_value
    Private read_amac_ahb_if_timeout_value
    Private flag_amac_ahb_if_timeout

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_macsec_if_timeout
        get_macsec_if_timeout = read_macsec_if_timeout_value
    End Property

    Property Let set_macsec_if_timeout(aData)
        write_macsec_if_timeout_value = aData
        flag_macsec_if_timeout        = &H1
    End Property

    Property Get read_macsec_if_timeout
        read
        read_macsec_if_timeout = read_macsec_if_timeout_value
    End Property

    Property Let write_macsec_if_timeout(aData)
        set_macsec_if_timeout = aData
        write
    End Property

    Property Get get_spi_10t1s_if_timeout
        get_spi_10t1s_if_timeout = read_spi_10t1s_if_timeout_value
    End Property

    Property Let set_spi_10t1s_if_timeout(aData)
        write_spi_10t1s_if_timeout_value = aData
        flag_spi_10t1s_if_timeout        = &H1
    End Property

    Property Get read_spi_10t1s_if_timeout
        read
        read_spi_10t1s_if_timeout = read_spi_10t1s_if_timeout_value
    End Property

    Property Let write_spi_10t1s_if_timeout(aData)
        set_spi_10t1s_if_timeout = aData
        write
    End Property

    Property Get get_dma_10t1s_if_timeout
        get_dma_10t1s_if_timeout = read_dma_10t1s_if_timeout_value
    End Property

    Property Let set_dma_10t1s_if_timeout(aData)
        write_dma_10t1s_if_timeout_value = aData
        flag_dma_10t1s_if_timeout        = &H1
    End Property

    Property Get read_dma_10t1s_if_timeout
        read
        read_dma_10t1s_if_timeout = read_dma_10t1s_if_timeout_value
    End Property

    Property Let write_dma_10t1s_if_timeout(aData)
        set_dma_10t1s_if_timeout = aData
        write
    End Property

    Property Get get_hsm_if_timeout
        get_hsm_if_timeout = read_hsm_if_timeout_value
    End Property

    Property Let set_hsm_if_timeout(aData)
        write_hsm_if_timeout_value = aData
        flag_hsm_if_timeout        = &H1
    End Property

    Property Get read_hsm_if_timeout
        read
        read_hsm_if_timeout = read_hsm_if_timeout_value
    End Property

    Property Let write_hsm_if_timeout(aData)
        set_hsm_if_timeout = aData
        write
    End Property

    Property Get get_sw_fa_if_timeout
        get_sw_fa_if_timeout = read_sw_fa_if_timeout_value
    End Property

    Property Let set_sw_fa_if_timeout(aData)
        write_sw_fa_if_timeout_value = aData
        flag_sw_fa_if_timeout        = &H1
    End Property

    Property Get read_sw_fa_if_timeout
        read
        read_sw_fa_if_timeout = read_sw_fa_if_timeout_value
    End Property

    Property Let write_sw_fa_if_timeout(aData)
        set_sw_fa_if_timeout = aData
        write
    End Property

    Property Get get_top_bridge_if_timeout
        get_top_bridge_if_timeout = read_top_bridge_if_timeout_value
    End Property

    Property Let set_top_bridge_if_timeout(aData)
        write_top_bridge_if_timeout_value = aData
        flag_top_bridge_if_timeout        = &H1
    End Property

    Property Get read_top_bridge_if_timeout
        read
        read_top_bridge_if_timeout = read_top_bridge_if_timeout_value
    End Property

    Property Let write_top_bridge_if_timeout(aData)
        set_top_bridge_if_timeout = aData
        write
    End Property

    Property Get get_apb_hub_if_timeout
        get_apb_hub_if_timeout = read_apb_hub_if_timeout_value
    End Property

    Property Let set_apb_hub_if_timeout(aData)
        write_apb_hub_if_timeout_value = aData
        flag_apb_hub_if_timeout        = &H1
    End Property

    Property Get read_apb_hub_if_timeout
        read
        read_apb_hub_if_timeout = read_apb_hub_if_timeout_value
    End Property

    Property Let write_apb_hub_if_timeout(aData)
        set_apb_hub_if_timeout = aData
        write
    End Property

    Property Get get_amac_ahb_if_timeout
        get_amac_ahb_if_timeout = read_amac_ahb_if_timeout_value
    End Property

    Property Let set_amac_ahb_if_timeout(aData)
        write_amac_ahb_if_timeout_value = aData
        flag_amac_ahb_if_timeout        = &H1
    End Property

    Property Get read_amac_ahb_if_timeout
        read
        read_amac_ahb_if_timeout = read_amac_ahb_if_timeout_value
    End Property

    Property Let write_amac_ahb_if_timeout(aData)
        set_amac_ahb_if_timeout = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_macsec_if_timeout_value = rightShift(data_low, 7) and &H1
        read_spi_10t1s_if_timeout_value = rightShift(data_low, 6) and &H1
        read_dma_10t1s_if_timeout_value = rightShift(data_low, 5) and &H1
        read_hsm_if_timeout_value = rightShift(data_low, 4) and &H1
        read_sw_fa_if_timeout_value = rightShift(data_low, 3) and &H1
        read_top_bridge_if_timeout_value = rightShift(data_low, 2) and &H1
        read_apb_hub_if_timeout_value = rightShift(data_low, 1) and &H1
        amac_ahb_if_timeout_mask = &H1
        if data_low > LONG_MAX then
            if amac_ahb_if_timeout_mask = mask then
                read_amac_ahb_if_timeout_value = data_low
            else
                read_amac_ahb_if_timeout_value = (data_low - H8000_0000) and amac_ahb_if_timeout_mask
            end If
        else
            read_amac_ahb_if_timeout_value = data_low and amac_ahb_if_timeout_mask
        end If

    End Sub

    Sub write
        If flag_macsec_if_timeout = &H0 or flag_spi_10t1s_if_timeout = &H0 or flag_dma_10t1s_if_timeout = &H0 or flag_hsm_if_timeout = &H0 or flag_sw_fa_if_timeout = &H0 or flag_top_bridge_if_timeout = &H0 or flag_apb_hub_if_timeout = &H0 or flag_amac_ahb_if_timeout = &H0 Then read
        If flag_macsec_if_timeout = &H0 Then write_macsec_if_timeout_value = get_macsec_if_timeout
        If flag_spi_10t1s_if_timeout = &H0 Then write_spi_10t1s_if_timeout_value = get_spi_10t1s_if_timeout
        If flag_dma_10t1s_if_timeout = &H0 Then write_dma_10t1s_if_timeout_value = get_dma_10t1s_if_timeout
        If flag_hsm_if_timeout = &H0 Then write_hsm_if_timeout_value = get_hsm_if_timeout
        If flag_sw_fa_if_timeout = &H0 Then write_sw_fa_if_timeout_value = get_sw_fa_if_timeout
        If flag_top_bridge_if_timeout = &H0 Then write_top_bridge_if_timeout_value = get_top_bridge_if_timeout
        If flag_apb_hub_if_timeout = &H0 Then write_apb_hub_if_timeout_value = get_apb_hub_if_timeout
        If flag_amac_ahb_if_timeout = &H0 Then write_amac_ahb_if_timeout_value = get_amac_ahb_if_timeout

        regValue = leftShift((write_macsec_if_timeout_value and &H1), 7) + leftShift((write_spi_10t1s_if_timeout_value and &H1), 6) + leftShift((write_dma_10t1s_if_timeout_value and &H1), 5) + leftShift((write_hsm_if_timeout_value and &H1), 4) + leftShift((write_sw_fa_if_timeout_value and &H1), 3) + leftShift((write_top_bridge_if_timeout_value and &H1), 2) + leftShift((write_apb_hub_if_timeout_value and &H1), 1) + leftShift((write_amac_ahb_if_timeout_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_macsec_if_timeout_value = rightShift(data_low, 7) and &H1
        read_spi_10t1s_if_timeout_value = rightShift(data_low, 6) and &H1
        read_dma_10t1s_if_timeout_value = rightShift(data_low, 5) and &H1
        read_hsm_if_timeout_value = rightShift(data_low, 4) and &H1
        read_sw_fa_if_timeout_value = rightShift(data_low, 3) and &H1
        read_top_bridge_if_timeout_value = rightShift(data_low, 2) and &H1
        read_apb_hub_if_timeout_value = rightShift(data_low, 1) and &H1
        amac_ahb_if_timeout_mask = &H1
        if data_low > LONG_MAX then
            if amac_ahb_if_timeout_mask = mask then
                read_amac_ahb_if_timeout_value = data_low
            else
                read_amac_ahb_if_timeout_value = (data_low - H8000_0000) and amac_ahb_if_timeout_mask
            end If
        else
            read_amac_ahb_if_timeout_value = data_low and amac_ahb_if_timeout_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_macsec_if_timeout_value = &H0
        flag_macsec_if_timeout        = &H0
        write_spi_10t1s_if_timeout_value = &H0
        flag_spi_10t1s_if_timeout        = &H0
        write_dma_10t1s_if_timeout_value = &H0
        flag_dma_10t1s_if_timeout        = &H0
        write_hsm_if_timeout_value = &H0
        flag_hsm_if_timeout        = &H0
        write_sw_fa_if_timeout_value = &H0
        flag_sw_fa_if_timeout        = &H0
        write_top_bridge_if_timeout_value = &H0
        flag_top_bridge_if_timeout        = &H0
        write_apb_hub_if_timeout_value = &H0
        flag_apb_hub_if_timeout        = &H0
        write_amac_ahb_if_timeout_value = &H0
        flag_amac_ahb_if_timeout        = &H0
    End Sub
End Class


'' @REGISTER : CFG_sw_bootmode_strap
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_CFG_sw_bootmode_strap

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : CFG_pcie_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' arm2pcie_dma_per_func                      [7:4]            get_arm2pcie_dma_per_func
''                                                             set_arm2pcie_dma_per_func
''                                                             read_arm2pcie_dma_per_func
''                                                             write_arm2pcie_dma_per_func
''---------------------------------------------------------------------------------
'' arm2pcie_num_func                          [3:0]            get_arm2pcie_num_func
''                                                             set_arm2pcie_num_func
''                                                             read_arm2pcie_num_func
''                                                             write_arm2pcie_num_func
''---------------------------------------------------------------------------------
Class REGISTER_CFG_pcie_config
    Private write_arm2pcie_dma_per_func_value
    Private read_arm2pcie_dma_per_func_value
    Private flag_arm2pcie_dma_per_func
    Private write_arm2pcie_num_func_value
    Private read_arm2pcie_num_func_value
    Private flag_arm2pcie_num_func

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_arm2pcie_dma_per_func
        get_arm2pcie_dma_per_func = read_arm2pcie_dma_per_func_value
    End Property

    Property Let set_arm2pcie_dma_per_func(aData)
        write_arm2pcie_dma_per_func_value = aData
        flag_arm2pcie_dma_per_func        = &H1
    End Property

    Property Get read_arm2pcie_dma_per_func
        read
        read_arm2pcie_dma_per_func = read_arm2pcie_dma_per_func_value
    End Property

    Property Let write_arm2pcie_dma_per_func(aData)
        set_arm2pcie_dma_per_func = aData
        write
    End Property

    Property Get get_arm2pcie_num_func
        get_arm2pcie_num_func = read_arm2pcie_num_func_value
    End Property

    Property Let set_arm2pcie_num_func(aData)
        write_arm2pcie_num_func_value = aData
        flag_arm2pcie_num_func        = &H1
    End Property

    Property Get read_arm2pcie_num_func
        read
        read_arm2pcie_num_func = read_arm2pcie_num_func_value
    End Property

    Property Let write_arm2pcie_num_func(aData)
        set_arm2pcie_num_func = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_arm2pcie_dma_per_func_value = rightShift(data_low, 4) and &Hf
        arm2pcie_num_func_mask = &Hf
        if data_low > LONG_MAX then
            if arm2pcie_num_func_mask = mask then
                read_arm2pcie_num_func_value = data_low
            else
                read_arm2pcie_num_func_value = (data_low - H8000_0000) and arm2pcie_num_func_mask
            end If
        else
            read_arm2pcie_num_func_value = data_low and arm2pcie_num_func_mask
        end If

    End Sub

    Sub write
        If flag_arm2pcie_dma_per_func = &H0 or flag_arm2pcie_num_func = &H0 Then read
        If flag_arm2pcie_dma_per_func = &H0 Then write_arm2pcie_dma_per_func_value = get_arm2pcie_dma_per_func
        If flag_arm2pcie_num_func = &H0 Then write_arm2pcie_num_func_value = get_arm2pcie_num_func

        regValue = leftShift((write_arm2pcie_dma_per_func_value and &Hf), 4) + leftShift((write_arm2pcie_num_func_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_arm2pcie_dma_per_func_value = rightShift(data_low, 4) and &Hf
        arm2pcie_num_func_mask = &Hf
        if data_low > LONG_MAX then
            if arm2pcie_num_func_mask = mask then
                read_arm2pcie_num_func_value = data_low
            else
                read_arm2pcie_num_func_value = (data_low - H8000_0000) and arm2pcie_num_func_mask
            end If
        else
            read_arm2pcie_num_func_value = data_low and arm2pcie_num_func_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_arm2pcie_dma_per_func_value = &H0
        flag_arm2pcie_dma_per_func        = &H0
        write_arm2pcie_num_func_value = &H0
        flag_arm2pcie_num_func        = &H0
    End Sub
End Class


'' @REGISTER : CFG_sw_strap0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_strap0                                  [31:0]           get_sw_strap0
''                                                             set_sw_strap0
''                                                             read_sw_strap0
''                                                             write_sw_strap0
''---------------------------------------------------------------------------------
Class REGISTER_CFG_sw_strap0
    Private write_sw_strap0_value
    Private read_sw_strap0_value
    Private flag_sw_strap0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_strap0
        get_sw_strap0 = read_sw_strap0_value
    End Property

    Property Let set_sw_strap0(aData)
        write_sw_strap0_value = aData
        flag_sw_strap0        = &H1
    End Property

    Property Get read_sw_strap0
        read
        read_sw_strap0 = read_sw_strap0_value
    End Property

    Property Let write_sw_strap0(aData)
        set_sw_strap0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_strap0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_strap0_mask = mask then
                read_sw_strap0_value = data_low
            else
                read_sw_strap0_value = (data_low - H8000_0000) and sw_strap0_mask
            end If
        else
            read_sw_strap0_value = data_low and sw_strap0_mask
        end If

    End Sub

    Sub write
        If flag_sw_strap0 = &H0 Then read
        If flag_sw_strap0 = &H0 Then write_sw_strap0_value = get_sw_strap0

        regValue = leftShift(write_sw_strap0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_strap0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_strap0_mask = mask then
                read_sw_strap0_value = data_low
            else
                read_sw_strap0_value = (data_low - H8000_0000) and sw_strap0_mask
            end If
        else
            read_sw_strap0_value = data_low and sw_strap0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_strap0_value = &H0
        flag_sw_strap0        = &H0
    End Sub
End Class


'' @REGISTER : CFG_sw_strap1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_strap1                                  [31:0]           get_sw_strap1
''                                                             set_sw_strap1
''                                                             read_sw_strap1
''                                                             write_sw_strap1
''---------------------------------------------------------------------------------
Class REGISTER_CFG_sw_strap1
    Private write_sw_strap1_value
    Private read_sw_strap1_value
    Private flag_sw_strap1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_strap1
        get_sw_strap1 = read_sw_strap1_value
    End Property

    Property Let set_sw_strap1(aData)
        write_sw_strap1_value = aData
        flag_sw_strap1        = &H1
    End Property

    Property Get read_sw_strap1
        read
        read_sw_strap1 = read_sw_strap1_value
    End Property

    Property Let write_sw_strap1(aData)
        set_sw_strap1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_strap1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_strap1_mask = mask then
                read_sw_strap1_value = data_low
            else
                read_sw_strap1_value = (data_low - H8000_0000) and sw_strap1_mask
            end If
        else
            read_sw_strap1_value = data_low and sw_strap1_mask
        end If

    End Sub

    Sub write
        If flag_sw_strap1 = &H0 Then read
        If flag_sw_strap1 = &H0 Then write_sw_strap1_value = get_sw_strap1

        regValue = leftShift(write_sw_strap1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_strap1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_strap1_mask = mask then
                read_sw_strap1_value = data_low
            else
                read_sw_strap1_value = (data_low - H8000_0000) and sw_strap1_mask
            end If
        else
            read_sw_strap1_value = data_low and sw_strap1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_strap1_value = &H0
        flag_sw_strap1        = &H0
    End Sub
End Class


'' @REGISTER : CFG_sw_strap2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_strap2                                  [13:0]           get_sw_strap2
''                                                             set_sw_strap2
''                                                             read_sw_strap2
''                                                             write_sw_strap2
''---------------------------------------------------------------------------------
Class REGISTER_CFG_sw_strap2
    Private write_sw_strap2_value
    Private read_sw_strap2_value
    Private flag_sw_strap2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_strap2
        get_sw_strap2 = read_sw_strap2_value
    End Property

    Property Let set_sw_strap2(aData)
        write_sw_strap2_value = aData
        flag_sw_strap2        = &H1
    End Property

    Property Get read_sw_strap2
        read
        read_sw_strap2 = read_sw_strap2_value
    End Property

    Property Let write_sw_strap2(aData)
        set_sw_strap2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_strap2_mask = &H3fff
        if data_low > LONG_MAX then
            if sw_strap2_mask = mask then
                read_sw_strap2_value = data_low
            else
                read_sw_strap2_value = (data_low - H8000_0000) and sw_strap2_mask
            end If
        else
            read_sw_strap2_value = data_low and sw_strap2_mask
        end If

    End Sub

    Sub write
        If flag_sw_strap2 = &H0 Then read
        If flag_sw_strap2 = &H0 Then write_sw_strap2_value = get_sw_strap2

        regValue = leftShift((write_sw_strap2_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_strap2_mask = &H3fff
        if data_low > LONG_MAX then
            if sw_strap2_mask = mask then
                read_sw_strap2_value = data_low
            else
                read_sw_strap2_value = (data_low - H8000_0000) and sw_strap2_mask
            end If
        else
            read_sw_strap2_value = data_low and sw_strap2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_strap2_value = &H0
        flag_sw_strap2        = &H0
    End Sub
End Class


'' @REGISTER : CFG_hsm_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hsm_block_clk_en                           [5:5]            get_hsm_block_clk_en
''                                                             set_hsm_block_clk_en
''                                                             read_hsm_block_clk_en
''                                                             write_hsm_block_clk_en
''---------------------------------------------------------------------------------
'' M3_core_clk_en                             [4:4]            get_M3_core_clk_en
''                                                             set_M3_core_clk_en
''                                                             read_M3_core_clk_en
''                                                             write_M3_core_clk_en
''---------------------------------------------------------------------------------
'' hsm_prod_mode_cfg                          [3:3]            get_hsm_prod_mode_cfg
''                                                             set_hsm_prod_mode_cfg
''                                                             read_hsm_prod_mode_cfg
''                                                             write_hsm_prod_mode_cfg
''---------------------------------------------------------------------------------
'' m7_prod_mode_cfg                           [2:2]            get_m7_prod_mode_cfg
''                                                             set_m7_prod_mode_cfg
''                                                             read_m7_prod_mode_cfg
''                                                             write_m7_prod_mode_cfg
''---------------------------------------------------------------------------------
'' hsm_block_soft_rst                         [1:1]            get_hsm_block_soft_rst
''                                                             set_hsm_block_soft_rst
''                                                             read_hsm_block_soft_rst
''                                                             write_hsm_block_soft_rst
''---------------------------------------------------------------------------------
'' m3_core_soft_rst                           [0:0]            get_m3_core_soft_rst
''                                                             set_m3_core_soft_rst
''                                                             read_m3_core_soft_rst
''                                                             write_m3_core_soft_rst
''---------------------------------------------------------------------------------
Class REGISTER_CFG_hsm_ctl
    Private write_hsm_block_clk_en_value
    Private read_hsm_block_clk_en_value
    Private flag_hsm_block_clk_en
    Private write_M3_core_clk_en_value
    Private read_M3_core_clk_en_value
    Private flag_M3_core_clk_en
    Private write_hsm_prod_mode_cfg_value
    Private read_hsm_prod_mode_cfg_value
    Private flag_hsm_prod_mode_cfg
    Private write_m7_prod_mode_cfg_value
    Private read_m7_prod_mode_cfg_value
    Private flag_m7_prod_mode_cfg
    Private write_hsm_block_soft_rst_value
    Private read_hsm_block_soft_rst_value
    Private flag_hsm_block_soft_rst
    Private write_m3_core_soft_rst_value
    Private read_m3_core_soft_rst_value
    Private flag_m3_core_soft_rst

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hsm_block_clk_en
        get_hsm_block_clk_en = read_hsm_block_clk_en_value
    End Property

    Property Let set_hsm_block_clk_en(aData)
        write_hsm_block_clk_en_value = aData
        flag_hsm_block_clk_en        = &H1
    End Property

    Property Get read_hsm_block_clk_en
        read
        read_hsm_block_clk_en = read_hsm_block_clk_en_value
    End Property

    Property Let write_hsm_block_clk_en(aData)
        set_hsm_block_clk_en = aData
        write
    End Property

    Property Get get_M3_core_clk_en
        get_M3_core_clk_en = read_M3_core_clk_en_value
    End Property

    Property Let set_M3_core_clk_en(aData)
        write_M3_core_clk_en_value = aData
        flag_M3_core_clk_en        = &H1
    End Property

    Property Get read_M3_core_clk_en
        read
        read_M3_core_clk_en = read_M3_core_clk_en_value
    End Property

    Property Let write_M3_core_clk_en(aData)
        set_M3_core_clk_en = aData
        write
    End Property

    Property Get get_hsm_prod_mode_cfg
        get_hsm_prod_mode_cfg = read_hsm_prod_mode_cfg_value
    End Property

    Property Let set_hsm_prod_mode_cfg(aData)
        write_hsm_prod_mode_cfg_value = aData
        flag_hsm_prod_mode_cfg        = &H1
    End Property

    Property Get read_hsm_prod_mode_cfg
        read
        read_hsm_prod_mode_cfg = read_hsm_prod_mode_cfg_value
    End Property

    Property Let write_hsm_prod_mode_cfg(aData)
        set_hsm_prod_mode_cfg = aData
        write
    End Property

    Property Get get_m7_prod_mode_cfg
        get_m7_prod_mode_cfg = read_m7_prod_mode_cfg_value
    End Property

    Property Let set_m7_prod_mode_cfg(aData)
        write_m7_prod_mode_cfg_value = aData
        flag_m7_prod_mode_cfg        = &H1
    End Property

    Property Get read_m7_prod_mode_cfg
        read
        read_m7_prod_mode_cfg = read_m7_prod_mode_cfg_value
    End Property

    Property Let write_m7_prod_mode_cfg(aData)
        set_m7_prod_mode_cfg = aData
        write
    End Property

    Property Get get_hsm_block_soft_rst
        get_hsm_block_soft_rst = read_hsm_block_soft_rst_value
    End Property

    Property Let set_hsm_block_soft_rst(aData)
        write_hsm_block_soft_rst_value = aData
        flag_hsm_block_soft_rst        = &H1
    End Property

    Property Get read_hsm_block_soft_rst
        read
        read_hsm_block_soft_rst = read_hsm_block_soft_rst_value
    End Property

    Property Let write_hsm_block_soft_rst(aData)
        set_hsm_block_soft_rst = aData
        write
    End Property

    Property Get get_m3_core_soft_rst
        get_m3_core_soft_rst = read_m3_core_soft_rst_value
    End Property

    Property Let set_m3_core_soft_rst(aData)
        write_m3_core_soft_rst_value = aData
        flag_m3_core_soft_rst        = &H1
    End Property

    Property Get read_m3_core_soft_rst
        read
        read_m3_core_soft_rst = read_m3_core_soft_rst_value
    End Property

    Property Let write_m3_core_soft_rst(aData)
        set_m3_core_soft_rst = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_hsm_block_clk_en_value = rightShift(data_low, 5) and &H1
        read_M3_core_clk_en_value = rightShift(data_low, 4) and &H1
        read_hsm_prod_mode_cfg_value = rightShift(data_low, 3) and &H1
        read_m7_prod_mode_cfg_value = rightShift(data_low, 2) and &H1
        read_hsm_block_soft_rst_value = rightShift(data_low, 1) and &H1
        m3_core_soft_rst_mask = &H1
        if data_low > LONG_MAX then
            if m3_core_soft_rst_mask = mask then
                read_m3_core_soft_rst_value = data_low
            else
                read_m3_core_soft_rst_value = (data_low - H8000_0000) and m3_core_soft_rst_mask
            end If
        else
            read_m3_core_soft_rst_value = data_low and m3_core_soft_rst_mask
        end If

    End Sub

    Sub write
        If flag_hsm_block_clk_en = &H0 or flag_M3_core_clk_en = &H0 or flag_hsm_prod_mode_cfg = &H0 or flag_m7_prod_mode_cfg = &H0 or flag_hsm_block_soft_rst = &H0 or flag_m3_core_soft_rst = &H0 Then read
        If flag_hsm_block_clk_en = &H0 Then write_hsm_block_clk_en_value = get_hsm_block_clk_en
        If flag_M3_core_clk_en = &H0 Then write_M3_core_clk_en_value = get_M3_core_clk_en
        If flag_hsm_prod_mode_cfg = &H0 Then write_hsm_prod_mode_cfg_value = get_hsm_prod_mode_cfg
        If flag_m7_prod_mode_cfg = &H0 Then write_m7_prod_mode_cfg_value = get_m7_prod_mode_cfg
        If flag_hsm_block_soft_rst = &H0 Then write_hsm_block_soft_rst_value = get_hsm_block_soft_rst
        If flag_m3_core_soft_rst = &H0 Then write_m3_core_soft_rst_value = get_m3_core_soft_rst

        regValue = leftShift((write_hsm_block_clk_en_value and &H1), 5) + leftShift((write_M3_core_clk_en_value and &H1), 4) + leftShift((write_hsm_prod_mode_cfg_value and &H1), 3) + leftShift((write_m7_prod_mode_cfg_value and &H1), 2) + leftShift((write_hsm_block_soft_rst_value and &H1), 1) + leftShift((write_m3_core_soft_rst_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_hsm_block_clk_en_value = rightShift(data_low, 5) and &H1
        read_M3_core_clk_en_value = rightShift(data_low, 4) and &H1
        read_hsm_prod_mode_cfg_value = rightShift(data_low, 3) and &H1
        read_m7_prod_mode_cfg_value = rightShift(data_low, 2) and &H1
        read_hsm_block_soft_rst_value = rightShift(data_low, 1) and &H1
        m3_core_soft_rst_mask = &H1
        if data_low > LONG_MAX then
            if m3_core_soft_rst_mask = mask then
                read_m3_core_soft_rst_value = data_low
            else
                read_m3_core_soft_rst_value = (data_low - H8000_0000) and m3_core_soft_rst_mask
            end If
        else
            read_m3_core_soft_rst_value = data_low and m3_core_soft_rst_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hsm_block_clk_en_value = &H0
        flag_hsm_block_clk_en        = &H0
        write_M3_core_clk_en_value = &H0
        flag_M3_core_clk_en        = &H0
        write_hsm_prod_mode_cfg_value = &H0
        flag_hsm_prod_mode_cfg        = &H0
        write_m7_prod_mode_cfg_value = &H0
        flag_m7_prod_mode_cfg        = &H0
        write_hsm_block_soft_rst_value = &H0
        flag_hsm_block_soft_rst        = &H0
        write_m3_core_soft_rst_value = &H0
        flag_m3_core_soft_rst        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CFG_INSTANCE

    Public cfg_cpusys_misc
    Public tm_0
    Public debug_sel
    Public debug_en
    Public sw_if
    Public sw_intr_clr
    Public qspi_io_status
    Public qspi_io_control
    Public qspi_ip_revid
    Public spi_crc_control
    Public spi_crc_status
    Public cpu_intr_cfg
    Public spi_crc_idle_cycle_count
    Public ahb2rdb_timeout
    Public amac_ctrl
    Public amac_io_ctrl
    Public amac_io_stat
    Public amac_ip_revid
    Public qspi_flash_base_addr
    Public qspi_flash_size
    Public apb_monitor_ctrl
    Public apb_timeout_address
    Public apb_timeout_irq_status
    Public nmi_status
    Public debug_status
    Public hsm_status
    Public cpu_intr_raw0
    Public cpu_intr_raw1
    Public cpu_intr_raw2
    Public cpu_intr_raw3
    Public cpu_intr_stat0
    Public cpu_intr_stat1
    Public cpu_intr_stat2
    Public cpu_intr_stat3
    Public cpu_intr_mask0
    Public cpu_intr_mask1
    Public cpu_intr_mask2
    Public cpu_intr_mask3
    Public cpu_intr_force0
    Public cpu_intr_force1
    Public cpu_intr_force2
    Public cpu_intr_force3
    Public arm2pcie_intr
    Public pcie_intr_stat0
    Public pcie_intr_stat1
    Public pcie_intr_stat2
    Public pcie_intr_stat3
    Public pcie_intr_mask0
    Public pcie_intr_mask1
    Public pcie_intr_mask2
    Public pcie_intr_mask3
    Public pcie_intr_force0
    Public pcie_intr_force1
    Public pcie_intr_force2
    Public pcie_intr_force3
    Public hw_mem_init_en
    Public hw_mem_init_done_sts
    Public spim_if_control
    Public proc_sys_ahb_mon_sts
    Public sw_bootmode_strap
    Public pcie_config
    Public sw_strap0
    Public sw_strap1
    Public sw_strap2
    Public hsm_ctl


    Public default function Init(aBaseAddr)
        Set cfg_cpusys_misc = (New REGISTER_CFG_cfg_cpusys_misc)(aBaseAddr, 32)
        Set tm_0 = (New REGISTER_CFG_tm_0)(aBaseAddr, 32)
        Set debug_sel = (New REGISTER_CFG_debug_sel)(aBaseAddr, 32)
        Set debug_en = (New REGISTER_CFG_debug_en)(aBaseAddr, 32)
        Set sw_if = (New REGISTER_CFG_sw_if)(aBaseAddr, 32)
        Set sw_intr_clr = (New REGISTER_CFG_sw_intr_clr)(aBaseAddr, 32)
        Set qspi_io_status = (New REGISTER_CFG_qspi_io_status)(aBaseAddr, 32)
        Set qspi_io_control = (New REGISTER_CFG_qspi_io_control)(aBaseAddr, 32)
        Set qspi_ip_revid = (New REGISTER_CFG_qspi_ip_revid)(aBaseAddr, 32)
        Set spi_crc_control = (New REGISTER_CFG_spi_crc_control)(aBaseAddr, 32)
        Set spi_crc_status = (New REGISTER_CFG_spi_crc_status)(aBaseAddr, 32)
        Set cpu_intr_cfg = (New REGISTER_CFG_cpu_intr_cfg)(aBaseAddr, 32)
        Set spi_crc_idle_cycle_count = (New REGISTER_CFG_spi_crc_idle_cycle_count)(aBaseAddr, 32)
        Set ahb2rdb_timeout = (New REGISTER_CFG_ahb2rdb_timeout)(aBaseAddr, 32)
        Set amac_ctrl = (New REGISTER_CFG_amac_ctrl)(aBaseAddr, 32)
        Set amac_io_ctrl = (New REGISTER_CFG_amac_io_ctrl)(aBaseAddr, 32)
        Set amac_io_stat = (New REGISTER_CFG_amac_io_stat)(aBaseAddr, 32)
        Set amac_ip_revid = (New REGISTER_CFG_amac_ip_revid)(aBaseAddr, 32)
        Set qspi_flash_base_addr = (New REGISTER_CFG_qspi_flash_base_addr)(aBaseAddr, 32)
        Set qspi_flash_size = (New REGISTER_CFG_qspi_flash_size)(aBaseAddr, 32)
        Set apb_monitor_ctrl = (New REGISTER_CFG_apb_monitor_ctrl)(aBaseAddr, 32)
        Set apb_timeout_address = (New REGISTER_CFG_apb_timeout_address)(aBaseAddr, 32)
        Set apb_timeout_irq_status = (New REGISTER_CFG_apb_timeout_irq_status)(aBaseAddr, 32)
        Set nmi_status = (New REGISTER_CFG_nmi_status)(aBaseAddr, 32)
        Set debug_status = (New REGISTER_CFG_debug_status)(aBaseAddr, 32)
        Set hsm_status = (New REGISTER_CFG_hsm_status)(aBaseAddr, 32)
        Set cpu_intr_raw0 = (New REGISTER_CFG_cpu_intr_raw0)(aBaseAddr, 32)
        Set cpu_intr_raw1 = (New REGISTER_CFG_cpu_intr_raw1)(aBaseAddr, 32)
        Set cpu_intr_raw2 = (New REGISTER_CFG_cpu_intr_raw2)(aBaseAddr, 32)
        Set cpu_intr_raw3 = (New REGISTER_CFG_cpu_intr_raw3)(aBaseAddr, 32)
        Set cpu_intr_stat0 = (New REGISTER_CFG_cpu_intr_stat0)(aBaseAddr, 32)
        Set cpu_intr_stat1 = (New REGISTER_CFG_cpu_intr_stat1)(aBaseAddr, 32)
        Set cpu_intr_stat2 = (New REGISTER_CFG_cpu_intr_stat2)(aBaseAddr, 32)
        Set cpu_intr_stat3 = (New REGISTER_CFG_cpu_intr_stat3)(aBaseAddr, 32)
        Set cpu_intr_mask0 = (New REGISTER_CFG_cpu_intr_mask0)(aBaseAddr, 32)
        Set cpu_intr_mask1 = (New REGISTER_CFG_cpu_intr_mask1)(aBaseAddr, 32)
        Set cpu_intr_mask2 = (New REGISTER_CFG_cpu_intr_mask2)(aBaseAddr, 32)
        Set cpu_intr_mask3 = (New REGISTER_CFG_cpu_intr_mask3)(aBaseAddr, 32)
        Set cpu_intr_force0 = (New REGISTER_CFG_cpu_intr_force0)(aBaseAddr, 32)
        Set cpu_intr_force1 = (New REGISTER_CFG_cpu_intr_force1)(aBaseAddr, 32)
        Set cpu_intr_force2 = (New REGISTER_CFG_cpu_intr_force2)(aBaseAddr, 32)
        Set cpu_intr_force3 = (New REGISTER_CFG_cpu_intr_force3)(aBaseAddr, 32)
        Set arm2pcie_intr = (New REGISTER_CFG_arm2pcie_intr)(aBaseAddr, 32)
        Set pcie_intr_stat0 = (New REGISTER_CFG_pcie_intr_stat0)(aBaseAddr, 32)
        Set pcie_intr_stat1 = (New REGISTER_CFG_pcie_intr_stat1)(aBaseAddr, 32)
        Set pcie_intr_stat2 = (New REGISTER_CFG_pcie_intr_stat2)(aBaseAddr, 32)
        Set pcie_intr_stat3 = (New REGISTER_CFG_pcie_intr_stat3)(aBaseAddr, 32)
        Set pcie_intr_mask0 = (New REGISTER_CFG_pcie_intr_mask0)(aBaseAddr, 32)
        Set pcie_intr_mask1 = (New REGISTER_CFG_pcie_intr_mask1)(aBaseAddr, 32)
        Set pcie_intr_mask2 = (New REGISTER_CFG_pcie_intr_mask2)(aBaseAddr, 32)
        Set pcie_intr_mask3 = (New REGISTER_CFG_pcie_intr_mask3)(aBaseAddr, 32)
        Set pcie_intr_force0 = (New REGISTER_CFG_pcie_intr_force0)(aBaseAddr, 32)
        Set pcie_intr_force1 = (New REGISTER_CFG_pcie_intr_force1)(aBaseAddr, 32)
        Set pcie_intr_force2 = (New REGISTER_CFG_pcie_intr_force2)(aBaseAddr, 32)
        Set pcie_intr_force3 = (New REGISTER_CFG_pcie_intr_force3)(aBaseAddr, 32)
        Set hw_mem_init_en = (New REGISTER_CFG_hw_mem_init_en)(aBaseAddr, 32)
        Set hw_mem_init_done_sts = (New REGISTER_CFG_hw_mem_init_done_sts)(aBaseAddr, 32)
        Set spim_if_control = (New REGISTER_CFG_spim_if_control)(aBaseAddr, 32)
        Set proc_sys_ahb_mon_sts = (New REGISTER_CFG_proc_sys_ahb_mon_sts)(aBaseAddr, 32)
        Set sw_bootmode_strap = (New REGISTER_CFG_sw_bootmode_strap)(aBaseAddr, 32)
        Set pcie_config = (New REGISTER_CFG_pcie_config)(aBaseAddr, 32)
        Set sw_strap0 = (New REGISTER_CFG_sw_strap0)(aBaseAddr, 32)
        Set sw_strap1 = (New REGISTER_CFG_sw_strap1)(aBaseAddr, 32)
        Set sw_strap2 = (New REGISTER_CFG_sw_strap2)(aBaseAddr, 32)
        Set hsm_ctl = (New REGISTER_CFG_hsm_ctl)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CFG = CreateObject("System.Collections.ArrayList")
CFG.Add ((New CFG_INSTANCE)(&H40148000))


