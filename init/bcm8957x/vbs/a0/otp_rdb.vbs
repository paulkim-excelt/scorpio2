

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


'' @REGISTER : OTP_cpu_command
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' opcode                                     [5:0]            get_opcode
''                                                             set_opcode
''                                                             read_opcode
''                                                             write_opcode
''---------------------------------------------------------------------------------
Class REGISTER_OTP_cpu_command
    Private write_opcode_value
    Private read_opcode_value
    Private flag_opcode

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_opcode
        get_opcode = read_opcode_value
    End Property

    Property Let set_opcode(aData)
        write_opcode_value = aData
        flag_opcode        = &H1
    End Property

    Property Get read_opcode
        read
        read_opcode = read_opcode_value
    End Property

    Property Let write_opcode(aData)
        set_opcode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        opcode_mask = &H3f
        if data_low > LONG_MAX then
            if opcode_mask = mask then
                read_opcode_value = data_low
            else
                read_opcode_value = (data_low - H8000_0000) and opcode_mask
            end If
        else
            read_opcode_value = data_low and opcode_mask
        end If

    End Sub

    Sub write
        If flag_opcode = &H0 Then read
        If flag_opcode = &H0 Then write_opcode_value = get_opcode

        regValue = leftShift((write_opcode_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        opcode_mask = &H3f
        if data_low > LONG_MAX then
            if opcode_mask = mask then
                read_opcode_value = data_low
            else
                read_opcode_value = (data_low - H8000_0000) and opcode_mask
            end If
        else
            read_opcode_value = data_low and opcode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_opcode_value = &H0
        flag_opcode        = &H0
    End Sub
End Class


'' @REGISTER : OTP_cpu_wrdata
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_wrdata                                 [31:0]           get_cpu_wrdata
''                                                             set_cpu_wrdata
''                                                             read_cpu_wrdata
''                                                             write_cpu_wrdata
''---------------------------------------------------------------------------------
Class REGISTER_OTP_cpu_wrdata
    Private write_cpu_wrdata_value
    Private read_cpu_wrdata_value
    Private flag_cpu_wrdata

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

    Property Get get_cpu_wrdata
        get_cpu_wrdata = read_cpu_wrdata_value
    End Property

    Property Let set_cpu_wrdata(aData)
        write_cpu_wrdata_value = aData
        flag_cpu_wrdata        = &H1
    End Property

    Property Get read_cpu_wrdata
        read
        read_cpu_wrdata = read_cpu_wrdata_value
    End Property

    Property Let write_cpu_wrdata(aData)
        set_cpu_wrdata = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_wrdata_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_wrdata_mask = mask then
                read_cpu_wrdata_value = data_low
            else
                read_cpu_wrdata_value = (data_low - H8000_0000) and cpu_wrdata_mask
            end If
        else
            read_cpu_wrdata_value = data_low and cpu_wrdata_mask
        end If

    End Sub

    Sub write
        If flag_cpu_wrdata = &H0 Then read
        If flag_cpu_wrdata = &H0 Then write_cpu_wrdata_value = get_cpu_wrdata

        regValue = leftShift(write_cpu_wrdata_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_wrdata_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_wrdata_mask = mask then
                read_cpu_wrdata_value = data_low
            else
                read_cpu_wrdata_value = (data_low - H8000_0000) and cpu_wrdata_mask
            end If
        else
            read_cpu_wrdata_value = data_low and cpu_wrdata_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_wrdata_value = &H0
        flag_cpu_wrdata        = &H0
    End Sub
End Class


'' @REGISTER : OTP_cpu_wrdata_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_wrdata_hi                              [6:0]            get_cpu_wrdata_hi
''                                                             set_cpu_wrdata_hi
''                                                             read_cpu_wrdata_hi
''                                                             write_cpu_wrdata_hi
''---------------------------------------------------------------------------------
Class REGISTER_OTP_cpu_wrdata_hi
    Private write_cpu_wrdata_hi_value
    Private read_cpu_wrdata_hi_value
    Private flag_cpu_wrdata_hi

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

    Property Get get_cpu_wrdata_hi
        get_cpu_wrdata_hi = read_cpu_wrdata_hi_value
    End Property

    Property Let set_cpu_wrdata_hi(aData)
        write_cpu_wrdata_hi_value = aData
        flag_cpu_wrdata_hi        = &H1
    End Property

    Property Get read_cpu_wrdata_hi
        read
        read_cpu_wrdata_hi = read_cpu_wrdata_hi_value
    End Property

    Property Let write_cpu_wrdata_hi(aData)
        set_cpu_wrdata_hi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_wrdata_hi_mask = &H7f
        if data_low > LONG_MAX then
            if cpu_wrdata_hi_mask = mask then
                read_cpu_wrdata_hi_value = data_low
            else
                read_cpu_wrdata_hi_value = (data_low - H8000_0000) and cpu_wrdata_hi_mask
            end If
        else
            read_cpu_wrdata_hi_value = data_low and cpu_wrdata_hi_mask
        end If

    End Sub

    Sub write
        If flag_cpu_wrdata_hi = &H0 Then read
        If flag_cpu_wrdata_hi = &H0 Then write_cpu_wrdata_hi_value = get_cpu_wrdata_hi

        regValue = leftShift((write_cpu_wrdata_hi_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_wrdata_hi_mask = &H7f
        if data_low > LONG_MAX then
            if cpu_wrdata_hi_mask = mask then
                read_cpu_wrdata_hi_value = data_low
            else
                read_cpu_wrdata_hi_value = (data_low - H8000_0000) and cpu_wrdata_hi_mask
            end If
        else
            read_cpu_wrdata_hi_value = data_low and cpu_wrdata_hi_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_wrdata_hi_value = &H0
        flag_cpu_wrdata_hi        = &H0
    End Sub
End Class


'' @REGISTER : OTP_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_DMAC_Enable                            [16:16]          get_OTP_DMAC_Enable
''                                                             set_OTP_DMAC_Enable
''                                                             read_OTP_DMAC_Enable
''                                                             write_OTP_DMAC_Enable
''---------------------------------------------------------------------------------
'' soft_reset                                 [14:14]          get_soft_reset
''                                                             set_soft_reset
''                                                             read_soft_reset
''                                                             write_soft_reset
''---------------------------------------------------------------------------------
'' SRIOV_ENABLE                               [12:12]          get_SRIOV_ENABLE
''                                                             set_SRIOV_ENABLE
''                                                             read_SRIOV_ENABLE
''                                                             write_SRIOV_ENABLE
''---------------------------------------------------------------------------------
'' OTP_M7_DEV_MODE_Enable                     [11:11]          get_OTP_M7_DEV_MODE_Enable
''                                                             set_OTP_M7_DEV_MODE_Enable
''                                                             read_OTP_M7_DEV_MODE_Enable
''                                                             write_OTP_M7_DEV_MODE_Enable
''---------------------------------------------------------------------------------
'' SM_EN_PLL_RESET                            [10:10]          get_SM_EN_PLL_RESET
''                                                             set_SM_EN_PLL_RESET
''                                                             read_SM_EN_PLL_RESET
''                                                             write_SM_EN_PLL_RESET
''---------------------------------------------------------------------------------
'' OTP_DEV_MODE_Enable                        [9:9]            get_OTP_DEV_MODE_Enable
''                                                             set_OTP_DEV_MODE_Enable
''                                                             read_OTP_DEV_MODE_Enable
''                                                             write_OTP_DEV_MODE_Enable
''---------------------------------------------------------------------------------
'' OTP_PCIE_Enable                            [8:8]            get_OTP_PCIE_Enable
''                                                             set_OTP_PCIE_Enable
''                                                             read_OTP_PCIE_Enable
''                                                             write_OTP_PCIE_Enable
''---------------------------------------------------------------------------------
'' OTP_CPU_JTAG_Enable                        [7:7]            get_OTP_CPU_JTAG_Enable
''                                                             set_OTP_CPU_JTAG_Enable
''                                                             read_OTP_CPU_JTAG_Enable
''                                                             write_OTP_CPU_JTAG_Enable
''---------------------------------------------------------------------------------
'' OTP_OTP_JTAG_Enable                        [6:6]            get_OTP_OTP_JTAG_Enable
''                                                             set_OTP_OTP_JTAG_Enable
''                                                             read_OTP_OTP_JTAG_Enable
''                                                             write_OTP_OTP_JTAG_Enable
''---------------------------------------------------------------------------------
'' OTP_MDIO_SLV_Enable                        [5:5]            get_OTP_MDIO_SLV_Enable
''                                                             set_OTP_MDIO_SLV_Enable
''                                                             read_OTP_MDIO_SLV_Enable
''                                                             write_OTP_MDIO_SLV_Enable
''---------------------------------------------------------------------------------
'' OTP_SECURITY_MONITOR_Enable                [4:4]            get_OTP_SECURITY_MONITOR_Enable
''                                                             set_OTP_SECURITY_MONITOR_Enable
''                                                             read_OTP_SECURITY_MONITOR_Enable
''                                                             write_OTP_SECURITY_MONITOR_Enable
''---------------------------------------------------------------------------------
'' OTP_SPI_SLV_Enable                         [3:3]            get_OTP_SPI_SLV_Enable
''                                                             set_OTP_SPI_SLV_Enable
''                                                             read_OTP_SPI_SLV_Enable
''                                                             write_OTP_SPI_SLV_Enable
''---------------------------------------------------------------------------------
'' OTP_CMD_WR                                 [2:2]            get_OTP_CMD_WR
''                                                             set_OTP_CMD_WR
''                                                             read_OTP_CMD_WR
''                                                             write_OTP_CMD_WR
''---------------------------------------------------------------------------------
'' OTP_CMD_MODE                               [1:1]            get_OTP_CMD_MODE
''                                                             set_OTP_CMD_MODE
''                                                             read_OTP_CMD_MODE
''                                                             write_OTP_CMD_MODE
''---------------------------------------------------------------------------------
'' DIS_OTP_ACC                                [0:0]            get_DIS_OTP_ACC
''                                                             set_DIS_OTP_ACC
''                                                             read_DIS_OTP_ACC
''                                                             write_DIS_OTP_ACC
''---------------------------------------------------------------------------------
Class REGISTER_OTP_config
    Private write_OTP_DMAC_Enable_value
    Private read_OTP_DMAC_Enable_value
    Private flag_OTP_DMAC_Enable
    Private write_soft_reset_value
    Private read_soft_reset_value
    Private flag_soft_reset
    Private write_SRIOV_ENABLE_value
    Private read_SRIOV_ENABLE_value
    Private flag_SRIOV_ENABLE
    Private write_OTP_M7_DEV_MODE_Enable_value
    Private read_OTP_M7_DEV_MODE_Enable_value
    Private flag_OTP_M7_DEV_MODE_Enable
    Private write_SM_EN_PLL_RESET_value
    Private read_SM_EN_PLL_RESET_value
    Private flag_SM_EN_PLL_RESET
    Private write_OTP_DEV_MODE_Enable_value
    Private read_OTP_DEV_MODE_Enable_value
    Private flag_OTP_DEV_MODE_Enable
    Private write_OTP_PCIE_Enable_value
    Private read_OTP_PCIE_Enable_value
    Private flag_OTP_PCIE_Enable
    Private write_OTP_CPU_JTAG_Enable_value
    Private read_OTP_CPU_JTAG_Enable_value
    Private flag_OTP_CPU_JTAG_Enable
    Private write_OTP_OTP_JTAG_Enable_value
    Private read_OTP_OTP_JTAG_Enable_value
    Private flag_OTP_OTP_JTAG_Enable
    Private write_OTP_MDIO_SLV_Enable_value
    Private read_OTP_MDIO_SLV_Enable_value
    Private flag_OTP_MDIO_SLV_Enable
    Private write_OTP_SECURITY_MONITOR_Enable_value
    Private read_OTP_SECURITY_MONITOR_Enable_value
    Private flag_OTP_SECURITY_MONITOR_Enable
    Private write_OTP_SPI_SLV_Enable_value
    Private read_OTP_SPI_SLV_Enable_value
    Private flag_OTP_SPI_SLV_Enable
    Private write_OTP_CMD_WR_value
    Private read_OTP_CMD_WR_value
    Private flag_OTP_CMD_WR
    Private write_OTP_CMD_MODE_value
    Private read_OTP_CMD_MODE_value
    Private flag_OTP_CMD_MODE
    Private write_DIS_OTP_ACC_value
    Private read_DIS_OTP_ACC_value
    Private flag_DIS_OTP_ACC

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

    Property Get get_OTP_DMAC_Enable
        get_OTP_DMAC_Enable = read_OTP_DMAC_Enable_value
    End Property

    Property Let set_OTP_DMAC_Enable(aData)
        write_OTP_DMAC_Enable_value = aData
        flag_OTP_DMAC_Enable        = &H1
    End Property

    Property Get read_OTP_DMAC_Enable
        read
        read_OTP_DMAC_Enable = read_OTP_DMAC_Enable_value
    End Property

    Property Let write_OTP_DMAC_Enable(aData)
        set_OTP_DMAC_Enable = aData
        write
    End Property

    Property Get get_soft_reset
        get_soft_reset = read_soft_reset_value
    End Property

    Property Let set_soft_reset(aData)
        write_soft_reset_value = aData
        flag_soft_reset        = &H1
    End Property

    Property Get read_soft_reset
        read
        read_soft_reset = read_soft_reset_value
    End Property

    Property Let write_soft_reset(aData)
        set_soft_reset = aData
        write
    End Property

    Property Get get_SRIOV_ENABLE
        get_SRIOV_ENABLE = read_SRIOV_ENABLE_value
    End Property

    Property Let set_SRIOV_ENABLE(aData)
        write_SRIOV_ENABLE_value = aData
        flag_SRIOV_ENABLE        = &H1
    End Property

    Property Get read_SRIOV_ENABLE
        read
        read_SRIOV_ENABLE = read_SRIOV_ENABLE_value
    End Property

    Property Let write_SRIOV_ENABLE(aData)
        set_SRIOV_ENABLE = aData
        write
    End Property

    Property Get get_OTP_M7_DEV_MODE_Enable
        get_OTP_M7_DEV_MODE_Enable = read_OTP_M7_DEV_MODE_Enable_value
    End Property

    Property Let set_OTP_M7_DEV_MODE_Enable(aData)
        write_OTP_M7_DEV_MODE_Enable_value = aData
        flag_OTP_M7_DEV_MODE_Enable        = &H1
    End Property

    Property Get read_OTP_M7_DEV_MODE_Enable
        read
        read_OTP_M7_DEV_MODE_Enable = read_OTP_M7_DEV_MODE_Enable_value
    End Property

    Property Let write_OTP_M7_DEV_MODE_Enable(aData)
        set_OTP_M7_DEV_MODE_Enable = aData
        write
    End Property

    Property Get get_SM_EN_PLL_RESET
        get_SM_EN_PLL_RESET = read_SM_EN_PLL_RESET_value
    End Property

    Property Let set_SM_EN_PLL_RESET(aData)
        write_SM_EN_PLL_RESET_value = aData
        flag_SM_EN_PLL_RESET        = &H1
    End Property

    Property Get read_SM_EN_PLL_RESET
        read
        read_SM_EN_PLL_RESET = read_SM_EN_PLL_RESET_value
    End Property

    Property Let write_SM_EN_PLL_RESET(aData)
        set_SM_EN_PLL_RESET = aData
        write
    End Property

    Property Get get_OTP_DEV_MODE_Enable
        get_OTP_DEV_MODE_Enable = read_OTP_DEV_MODE_Enable_value
    End Property

    Property Let set_OTP_DEV_MODE_Enable(aData)
        write_OTP_DEV_MODE_Enable_value = aData
        flag_OTP_DEV_MODE_Enable        = &H1
    End Property

    Property Get read_OTP_DEV_MODE_Enable
        read
        read_OTP_DEV_MODE_Enable = read_OTP_DEV_MODE_Enable_value
    End Property

    Property Let write_OTP_DEV_MODE_Enable(aData)
        set_OTP_DEV_MODE_Enable = aData
        write
    End Property

    Property Get get_OTP_PCIE_Enable
        get_OTP_PCIE_Enable = read_OTP_PCIE_Enable_value
    End Property

    Property Let set_OTP_PCIE_Enable(aData)
        write_OTP_PCIE_Enable_value = aData
        flag_OTP_PCIE_Enable        = &H1
    End Property

    Property Get read_OTP_PCIE_Enable
        read
        read_OTP_PCIE_Enable = read_OTP_PCIE_Enable_value
    End Property

    Property Let write_OTP_PCIE_Enable(aData)
        set_OTP_PCIE_Enable = aData
        write
    End Property

    Property Get get_OTP_CPU_JTAG_Enable
        get_OTP_CPU_JTAG_Enable = read_OTP_CPU_JTAG_Enable_value
    End Property

    Property Let set_OTP_CPU_JTAG_Enable(aData)
        write_OTP_CPU_JTAG_Enable_value = aData
        flag_OTP_CPU_JTAG_Enable        = &H1
    End Property

    Property Get read_OTP_CPU_JTAG_Enable
        read
        read_OTP_CPU_JTAG_Enable = read_OTP_CPU_JTAG_Enable_value
    End Property

    Property Let write_OTP_CPU_JTAG_Enable(aData)
        set_OTP_CPU_JTAG_Enable = aData
        write
    End Property

    Property Get get_OTP_OTP_JTAG_Enable
        get_OTP_OTP_JTAG_Enable = read_OTP_OTP_JTAG_Enable_value
    End Property

    Property Let set_OTP_OTP_JTAG_Enable(aData)
        write_OTP_OTP_JTAG_Enable_value = aData
        flag_OTP_OTP_JTAG_Enable        = &H1
    End Property

    Property Get read_OTP_OTP_JTAG_Enable
        read
        read_OTP_OTP_JTAG_Enable = read_OTP_OTP_JTAG_Enable_value
    End Property

    Property Let write_OTP_OTP_JTAG_Enable(aData)
        set_OTP_OTP_JTAG_Enable = aData
        write
    End Property

    Property Get get_OTP_MDIO_SLV_Enable
        get_OTP_MDIO_SLV_Enable = read_OTP_MDIO_SLV_Enable_value
    End Property

    Property Let set_OTP_MDIO_SLV_Enable(aData)
        write_OTP_MDIO_SLV_Enable_value = aData
        flag_OTP_MDIO_SLV_Enable        = &H1
    End Property

    Property Get read_OTP_MDIO_SLV_Enable
        read
        read_OTP_MDIO_SLV_Enable = read_OTP_MDIO_SLV_Enable_value
    End Property

    Property Let write_OTP_MDIO_SLV_Enable(aData)
        set_OTP_MDIO_SLV_Enable = aData
        write
    End Property

    Property Get get_OTP_SECURITY_MONITOR_Enable
        get_OTP_SECURITY_MONITOR_Enable = read_OTP_SECURITY_MONITOR_Enable_value
    End Property

    Property Let set_OTP_SECURITY_MONITOR_Enable(aData)
        write_OTP_SECURITY_MONITOR_Enable_value = aData
        flag_OTP_SECURITY_MONITOR_Enable        = &H1
    End Property

    Property Get read_OTP_SECURITY_MONITOR_Enable
        read
        read_OTP_SECURITY_MONITOR_Enable = read_OTP_SECURITY_MONITOR_Enable_value
    End Property

    Property Let write_OTP_SECURITY_MONITOR_Enable(aData)
        set_OTP_SECURITY_MONITOR_Enable = aData
        write
    End Property

    Property Get get_OTP_SPI_SLV_Enable
        get_OTP_SPI_SLV_Enable = read_OTP_SPI_SLV_Enable_value
    End Property

    Property Let set_OTP_SPI_SLV_Enable(aData)
        write_OTP_SPI_SLV_Enable_value = aData
        flag_OTP_SPI_SLV_Enable        = &H1
    End Property

    Property Get read_OTP_SPI_SLV_Enable
        read
        read_OTP_SPI_SLV_Enable = read_OTP_SPI_SLV_Enable_value
    End Property

    Property Let write_OTP_SPI_SLV_Enable(aData)
        set_OTP_SPI_SLV_Enable = aData
        write
    End Property

    Property Get get_OTP_CMD_WR
        get_OTP_CMD_WR = read_OTP_CMD_WR_value
    End Property

    Property Let set_OTP_CMD_WR(aData)
        write_OTP_CMD_WR_value = aData
        flag_OTP_CMD_WR        = &H1
    End Property

    Property Get read_OTP_CMD_WR
        read
        read_OTP_CMD_WR = read_OTP_CMD_WR_value
    End Property

    Property Let write_OTP_CMD_WR(aData)
        set_OTP_CMD_WR = aData
        write
    End Property

    Property Get get_OTP_CMD_MODE
        get_OTP_CMD_MODE = read_OTP_CMD_MODE_value
    End Property

    Property Let set_OTP_CMD_MODE(aData)
        write_OTP_CMD_MODE_value = aData
        flag_OTP_CMD_MODE        = &H1
    End Property

    Property Get read_OTP_CMD_MODE
        read
        read_OTP_CMD_MODE = read_OTP_CMD_MODE_value
    End Property

    Property Let write_OTP_CMD_MODE(aData)
        set_OTP_CMD_MODE = aData
        write
    End Property

    Property Get get_DIS_OTP_ACC
        get_DIS_OTP_ACC = read_DIS_OTP_ACC_value
    End Property

    Property Let set_DIS_OTP_ACC(aData)
        write_DIS_OTP_ACC_value = aData
        flag_DIS_OTP_ACC        = &H1
    End Property

    Property Get read_DIS_OTP_ACC
        read
        read_DIS_OTP_ACC = read_DIS_OTP_ACC_value
    End Property

    Property Let write_DIS_OTP_ACC(aData)
        set_DIS_OTP_ACC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OTP_DMAC_Enable_value = rightShift(data_low, 16) and &H1
        read_soft_reset_value = rightShift(data_low, 14) and &H1
        read_SRIOV_ENABLE_value = rightShift(data_low, 12) and &H1
        read_OTP_M7_DEV_MODE_Enable_value = rightShift(data_low, 11) and &H1
        read_SM_EN_PLL_RESET_value = rightShift(data_low, 10) and &H1
        read_OTP_DEV_MODE_Enable_value = rightShift(data_low, 9) and &H1
        read_OTP_PCIE_Enable_value = rightShift(data_low, 8) and &H1
        read_OTP_CPU_JTAG_Enable_value = rightShift(data_low, 7) and &H1
        read_OTP_OTP_JTAG_Enable_value = rightShift(data_low, 6) and &H1
        read_OTP_MDIO_SLV_Enable_value = rightShift(data_low, 5) and &H1
        read_OTP_SECURITY_MONITOR_Enable_value = rightShift(data_low, 4) and &H1
        read_OTP_SPI_SLV_Enable_value = rightShift(data_low, 3) and &H1
        read_OTP_CMD_WR_value = rightShift(data_low, 2) and &H1
        read_OTP_CMD_MODE_value = rightShift(data_low, 1) and &H1
        DIS_OTP_ACC_mask = &H1
        if data_low > LONG_MAX then
            if DIS_OTP_ACC_mask = mask then
                read_DIS_OTP_ACC_value = data_low
            else
                read_DIS_OTP_ACC_value = (data_low - H8000_0000) and DIS_OTP_ACC_mask
            end If
        else
            read_DIS_OTP_ACC_value = data_low and DIS_OTP_ACC_mask
        end If

    End Sub

    Sub write
        If flag_OTP_DMAC_Enable = &H0 or flag_soft_reset = &H0 or flag_SRIOV_ENABLE = &H0 or flag_OTP_M7_DEV_MODE_Enable = &H0 or flag_SM_EN_PLL_RESET = &H0 or flag_OTP_DEV_MODE_Enable = &H0 or flag_OTP_PCIE_Enable = &H0 or flag_OTP_CPU_JTAG_Enable = &H0 or flag_OTP_OTP_JTAG_Enable = &H0 or flag_OTP_MDIO_SLV_Enable = &H0 or flag_OTP_SECURITY_MONITOR_Enable = &H0 or flag_OTP_SPI_SLV_Enable = &H0 or flag_OTP_CMD_WR = &H0 or flag_OTP_CMD_MODE = &H0 or flag_DIS_OTP_ACC = &H0 Then read
        If flag_OTP_DMAC_Enable = &H0 Then write_OTP_DMAC_Enable_value = get_OTP_DMAC_Enable
        If flag_soft_reset = &H0 Then write_soft_reset_value = get_soft_reset
        If flag_SRIOV_ENABLE = &H0 Then write_SRIOV_ENABLE_value = get_SRIOV_ENABLE
        If flag_OTP_M7_DEV_MODE_Enable = &H0 Then write_OTP_M7_DEV_MODE_Enable_value = get_OTP_M7_DEV_MODE_Enable
        If flag_SM_EN_PLL_RESET = &H0 Then write_SM_EN_PLL_RESET_value = get_SM_EN_PLL_RESET
        If flag_OTP_DEV_MODE_Enable = &H0 Then write_OTP_DEV_MODE_Enable_value = get_OTP_DEV_MODE_Enable
        If flag_OTP_PCIE_Enable = &H0 Then write_OTP_PCIE_Enable_value = get_OTP_PCIE_Enable
        If flag_OTP_CPU_JTAG_Enable = &H0 Then write_OTP_CPU_JTAG_Enable_value = get_OTP_CPU_JTAG_Enable
        If flag_OTP_OTP_JTAG_Enable = &H0 Then write_OTP_OTP_JTAG_Enable_value = get_OTP_OTP_JTAG_Enable
        If flag_OTP_MDIO_SLV_Enable = &H0 Then write_OTP_MDIO_SLV_Enable_value = get_OTP_MDIO_SLV_Enable
        If flag_OTP_SECURITY_MONITOR_Enable = &H0 Then write_OTP_SECURITY_MONITOR_Enable_value = get_OTP_SECURITY_MONITOR_Enable
        If flag_OTP_SPI_SLV_Enable = &H0 Then write_OTP_SPI_SLV_Enable_value = get_OTP_SPI_SLV_Enable
        If flag_OTP_CMD_WR = &H0 Then write_OTP_CMD_WR_value = get_OTP_CMD_WR
        If flag_OTP_CMD_MODE = &H0 Then write_OTP_CMD_MODE_value = get_OTP_CMD_MODE
        If flag_DIS_OTP_ACC = &H0 Then write_DIS_OTP_ACC_value = get_DIS_OTP_ACC

        regValue = leftShift((write_OTP_DMAC_Enable_value and &H1), 16) + leftShift((write_soft_reset_value and &H1), 14) + leftShift((write_SRIOV_ENABLE_value and &H1), 12) + leftShift((write_OTP_M7_DEV_MODE_Enable_value and &H1), 11) + leftShift((write_SM_EN_PLL_RESET_value and &H1), 10) + leftShift((write_OTP_DEV_MODE_Enable_value and &H1), 9) + leftShift((write_OTP_PCIE_Enable_value and &H1), 8) + leftShift((write_OTP_CPU_JTAG_Enable_value and &H1), 7) + leftShift((write_OTP_OTP_JTAG_Enable_value and &H1), 6) + leftShift((write_OTP_MDIO_SLV_Enable_value and &H1), 5) + leftShift((write_OTP_SECURITY_MONITOR_Enable_value and &H1), 4) + leftShift((write_OTP_SPI_SLV_Enable_value and &H1), 3) + leftShift((write_OTP_CMD_WR_value and &H1), 2) + leftShift((write_OTP_CMD_MODE_value and &H1), 1) + leftShift((write_DIS_OTP_ACC_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OTP_DMAC_Enable_value = rightShift(data_low, 16) and &H1
        read_soft_reset_value = rightShift(data_low, 14) and &H1
        read_SRIOV_ENABLE_value = rightShift(data_low, 12) and &H1
        read_OTP_M7_DEV_MODE_Enable_value = rightShift(data_low, 11) and &H1
        read_SM_EN_PLL_RESET_value = rightShift(data_low, 10) and &H1
        read_OTP_DEV_MODE_Enable_value = rightShift(data_low, 9) and &H1
        read_OTP_PCIE_Enable_value = rightShift(data_low, 8) and &H1
        read_OTP_CPU_JTAG_Enable_value = rightShift(data_low, 7) and &H1
        read_OTP_OTP_JTAG_Enable_value = rightShift(data_low, 6) and &H1
        read_OTP_MDIO_SLV_Enable_value = rightShift(data_low, 5) and &H1
        read_OTP_SECURITY_MONITOR_Enable_value = rightShift(data_low, 4) and &H1
        read_OTP_SPI_SLV_Enable_value = rightShift(data_low, 3) and &H1
        read_OTP_CMD_WR_value = rightShift(data_low, 2) and &H1
        read_OTP_CMD_MODE_value = rightShift(data_low, 1) and &H1
        DIS_OTP_ACC_mask = &H1
        if data_low > LONG_MAX then
            if DIS_OTP_ACC_mask = mask then
                read_DIS_OTP_ACC_value = data_low
            else
                read_DIS_OTP_ACC_value = (data_low - H8000_0000) and DIS_OTP_ACC_mask
            end If
        else
            read_DIS_OTP_ACC_value = data_low and DIS_OTP_ACC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_DMAC_Enable_value = &H0
        flag_OTP_DMAC_Enable        = &H0
        write_soft_reset_value = &H0
        flag_soft_reset        = &H0
        write_SRIOV_ENABLE_value = &H0
        flag_SRIOV_ENABLE        = &H0
        write_OTP_M7_DEV_MODE_Enable_value = &H0
        flag_OTP_M7_DEV_MODE_Enable        = &H0
        write_SM_EN_PLL_RESET_value = &H0
        flag_SM_EN_PLL_RESET        = &H0
        write_OTP_DEV_MODE_Enable_value = &H0
        flag_OTP_DEV_MODE_Enable        = &H0
        write_OTP_PCIE_Enable_value = &H0
        flag_OTP_PCIE_Enable        = &H0
        write_OTP_CPU_JTAG_Enable_value = &H0
        flag_OTP_CPU_JTAG_Enable        = &H0
        write_OTP_OTP_JTAG_Enable_value = &H0
        flag_OTP_OTP_JTAG_Enable        = &H0
        write_OTP_MDIO_SLV_Enable_value = &H0
        flag_OTP_MDIO_SLV_Enable        = &H0
        write_OTP_SECURITY_MONITOR_Enable_value = &H0
        flag_OTP_SECURITY_MONITOR_Enable        = &H0
        write_OTP_SPI_SLV_Enable_value = &H0
        flag_OTP_SPI_SLV_Enable        = &H0
        write_OTP_CMD_WR_value = &H0
        flag_OTP_CMD_WR        = &H0
        write_OTP_CMD_MODE_value = &H0
        flag_OTP_CMD_MODE        = &H0
        write_DIS_OTP_ACC_value = &H0
        flag_DIS_OTP_ACC        = &H0
    End Sub
End Class


'' @REGISTER : OTP_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDRESS                                    [9:0]            get_ADDRESS
''                                                             set_ADDRESS
''                                                             read_ADDRESS
''                                                             write_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_OTP_address
    Private write_ADDRESS_value
    Private read_ADDRESS_value
    Private flag_ADDRESS

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

    Property Get get_ADDRESS
        get_ADDRESS = read_ADDRESS_value
    End Property

    Property Let set_ADDRESS(aData)
        write_ADDRESS_value = aData
        flag_ADDRESS        = &H1
    End Property

    Property Get read_ADDRESS
        read
        read_ADDRESS = read_ADDRESS_value
    End Property

    Property Let write_ADDRESS(aData)
        set_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_mask = &H3ff
        if data_low > LONG_MAX then
            if ADDRESS_mask = mask then
                read_ADDRESS_value = data_low
            else
                read_ADDRESS_value = (data_low - H8000_0000) and ADDRESS_mask
            end If
        else
            read_ADDRESS_value = data_low and ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_ADDRESS = &H0 Then read
        If flag_ADDRESS = &H0 Then write_ADDRESS_value = get_ADDRESS

        regValue = leftShift((write_ADDRESS_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_mask = &H3ff
        if data_low > LONG_MAX then
            if ADDRESS_mask = mask then
                read_ADDRESS_value = data_low
            else
                read_ADDRESS_value = (data_low - H8000_0000) and ADDRESS_mask
            end If
        else
            read_ADDRESS_value = data_low and ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDRESS_value = &H0
        flag_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : OTP_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Ecc_ded_flag_status                        [23:23]          get_Ecc_ded_flag_status
''                                                             set_Ecc_ded_flag_status
''                                                             read_Ecc_ded_flag_status
''                                                             write_Ecc_ded_flag_status
''---------------------------------------------------------------------------------
'' Ecc_sec_flag_status                        [22:22]          get_Ecc_sec_flag_status
''                                                             set_Ecc_sec_flag_status
''                                                             read_Ecc_sec_flag_status
''                                                             write_Ecc_sec_flag_status
''---------------------------------------------------------------------------------
'' Prescreen_Fail                             [20:20]          get_Prescreen_Fail
''                                                             set_Prescreen_Fail
''                                                             read_Prescreen_Fail
''                                                             write_Prescreen_Fail
''---------------------------------------------------------------------------------
'' ILLEGAL_ADDR                               [19:19]          get_ILLEGAL_ADDR
''                                                             set_ILLEGAL_ADDR
''                                                             read_ILLEGAL_ADDR
''                                                             write_ILLEGAL_ADDR
''---------------------------------------------------------------------------------
'' MAX_SW                                     [18:18]          get_MAX_SW
''                                                             set_MAX_SW
''                                                             read_MAX_SW
''                                                             write_MAX_SW
''---------------------------------------------------------------------------------
'' AUTO_RW_MAX                                [17:17]          get_AUTO_RW_MAX
''                                                             set_AUTO_RW_MAX
''                                                             read_AUTO_RW_MAX
''                                                             write_AUTO_RW_MAX
''---------------------------------------------------------------------------------
'' MAX_RWP                                    [16:16]          get_MAX_RWP
''                                                             set_MAX_RWP
''                                                             read_MAX_RWP
''                                                             write_MAX_RWP
''---------------------------------------------------------------------------------
'' MAX_RW                                     [15:15]          get_MAX_RW
''                                                             set_MAX_RW
''                                                             read_MAX_RW
''                                                             write_MAX_RW
''---------------------------------------------------------------------------------
'' PG_WD_FP_FAIL                              [14:14]          get_PG_WD_FP_FAIL
''                                                             set_PG_WD_FP_FAIL
''                                                             read_PG_WD_FP_FAIL
''                                                             write_PG_WD_FP_FAIL
''---------------------------------------------------------------------------------
'' PROG_EN                                    [13:13]          get_PROG_EN
''                                                             set_PROG_EN
''                                                             read_PROG_EN
''                                                             write_PROG_EN
''---------------------------------------------------------------------------------
'' PROG_BLK_CMD                               [12:12]          get_PROG_BLK_CMD
''                                                             set_PROG_BLK_CMD
''                                                             read_PROG_BLK_CMD
''                                                             write_PROG_BLK_CMD
''---------------------------------------------------------------------------------
'' PROG_SCR_FAIL                              [11:11]          get_PROG_SCR_FAIL
''                                                             set_PROG_SCR_FAIL
''                                                             read_PROG_SCR_FAIL
''                                                             write_PROG_SCR_FAIL
''---------------------------------------------------------------------------------
'' PROG_WORD_FAIL                             [10:10]          get_PROG_WORD_FAIL
''                                                             set_PROG_WORD_FAIL
''                                                             read_PROG_WORD_FAIL
''                                                             write_PROG_WORD_FAIL
''---------------------------------------------------------------------------------
'' INVALID_ADDR                               [9:9]            get_INVALID_ADDR
''                                                             set_INVALID_ADDR
''                                                             read_INVALID_ADDR
''                                                             write_INVALID_ADDR
''---------------------------------------------------------------------------------
'' DEBUG_MODE                                 [8:8]            get_DEBUG_MODE
''                                                             set_DEBUG_MODE
''                                                             read_DEBUG_MODE
''                                                             write_DEBUG_MODE
''---------------------------------------------------------------------------------
'' MST_FSM_ERROR                              [7:7]            get_MST_FSM_ERROR
''                                                             set_MST_FSM_ERROR
''                                                             read_MST_FSM_ERROR
''                                                             write_MST_FSM_ERROR
''---------------------------------------------------------------------------------
'' DEBUG_MODE_SET                             [6:6]            get_DEBUG_MODE_SET
''                                                             set_DEBUG_MODE_SET
''                                                             read_DEBUG_MODE_SET
''                                                             write_DEBUG_MODE_SET
''---------------------------------------------------------------------------------
'' REF_OK                                     [5:5]            get_REF_OK
''                                                             set_REF_OK
''                                                             read_REF_OK
''                                                             write_REF_OK
''---------------------------------------------------------------------------------
'' CMD_FAIL                                   [4:4]            get_CMD_FAIL
''                                                             set_CMD_FAIL
''                                                             read_CMD_FAIL
''                                                             write_CMD_FAIL
''---------------------------------------------------------------------------------
'' FDONE                                      [3:3]            get_FDONE
''                                                             set_FDONE
''                                                             read_FDONE
''                                                             write_FDONE
''---------------------------------------------------------------------------------
'' PROG_OK                                    [2:2]            get_PROG_OK
''                                                             set_PROG_OK
''                                                             read_PROG_OK
''                                                             write_PROG_OK
''---------------------------------------------------------------------------------
'' CMD_DONE                                   [1:1]            get_CMD_DONE
''                                                             set_CMD_DONE
''                                                             read_CMD_DONE
''                                                             write_CMD_DONE
''---------------------------------------------------------------------------------
'' DATA_VALID                                 [0:0]            get_DATA_VALID
''                                                             set_DATA_VALID
''                                                             read_DATA_VALID
''                                                             write_DATA_VALID
''---------------------------------------------------------------------------------
Class REGISTER_OTP_status
    Private write_Ecc_ded_flag_status_value
    Private read_Ecc_ded_flag_status_value
    Private flag_Ecc_ded_flag_status
    Private write_Ecc_sec_flag_status_value
    Private read_Ecc_sec_flag_status_value
    Private flag_Ecc_sec_flag_status
    Private write_Prescreen_Fail_value
    Private read_Prescreen_Fail_value
    Private flag_Prescreen_Fail
    Private write_ILLEGAL_ADDR_value
    Private read_ILLEGAL_ADDR_value
    Private flag_ILLEGAL_ADDR
    Private write_MAX_SW_value
    Private read_MAX_SW_value
    Private flag_MAX_SW
    Private write_AUTO_RW_MAX_value
    Private read_AUTO_RW_MAX_value
    Private flag_AUTO_RW_MAX
    Private write_MAX_RWP_value
    Private read_MAX_RWP_value
    Private flag_MAX_RWP
    Private write_MAX_RW_value
    Private read_MAX_RW_value
    Private flag_MAX_RW
    Private write_PG_WD_FP_FAIL_value
    Private read_PG_WD_FP_FAIL_value
    Private flag_PG_WD_FP_FAIL
    Private write_PROG_EN_value
    Private read_PROG_EN_value
    Private flag_PROG_EN
    Private write_PROG_BLK_CMD_value
    Private read_PROG_BLK_CMD_value
    Private flag_PROG_BLK_CMD
    Private write_PROG_SCR_FAIL_value
    Private read_PROG_SCR_FAIL_value
    Private flag_PROG_SCR_FAIL
    Private write_PROG_WORD_FAIL_value
    Private read_PROG_WORD_FAIL_value
    Private flag_PROG_WORD_FAIL
    Private write_INVALID_ADDR_value
    Private read_INVALID_ADDR_value
    Private flag_INVALID_ADDR
    Private write_DEBUG_MODE_value
    Private read_DEBUG_MODE_value
    Private flag_DEBUG_MODE
    Private write_MST_FSM_ERROR_value
    Private read_MST_FSM_ERROR_value
    Private flag_MST_FSM_ERROR
    Private write_DEBUG_MODE_SET_value
    Private read_DEBUG_MODE_SET_value
    Private flag_DEBUG_MODE_SET
    Private write_REF_OK_value
    Private read_REF_OK_value
    Private flag_REF_OK
    Private write_CMD_FAIL_value
    Private read_CMD_FAIL_value
    Private flag_CMD_FAIL
    Private write_FDONE_value
    Private read_FDONE_value
    Private flag_FDONE
    Private write_PROG_OK_value
    Private read_PROG_OK_value
    Private flag_PROG_OK
    Private write_CMD_DONE_value
    Private read_CMD_DONE_value
    Private flag_CMD_DONE
    Private write_DATA_VALID_value
    Private read_DATA_VALID_value
    Private flag_DATA_VALID

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Ecc_ded_flag_status
        get_Ecc_ded_flag_status = read_Ecc_ded_flag_status_value
    End Property

    Property Let set_Ecc_ded_flag_status(aData)
        write_Ecc_ded_flag_status_value = aData
        flag_Ecc_ded_flag_status        = &H1
    End Property

    Property Get read_Ecc_ded_flag_status
        read
        read_Ecc_ded_flag_status = read_Ecc_ded_flag_status_value
    End Property

    Property Let write_Ecc_ded_flag_status(aData)
        set_Ecc_ded_flag_status = aData
        write
    End Property

    Property Get get_Ecc_sec_flag_status
        get_Ecc_sec_flag_status = read_Ecc_sec_flag_status_value
    End Property

    Property Let set_Ecc_sec_flag_status(aData)
        write_Ecc_sec_flag_status_value = aData
        flag_Ecc_sec_flag_status        = &H1
    End Property

    Property Get read_Ecc_sec_flag_status
        read
        read_Ecc_sec_flag_status = read_Ecc_sec_flag_status_value
    End Property

    Property Let write_Ecc_sec_flag_status(aData)
        set_Ecc_sec_flag_status = aData
        write
    End Property

    Property Get get_Prescreen_Fail
        get_Prescreen_Fail = read_Prescreen_Fail_value
    End Property

    Property Let set_Prescreen_Fail(aData)
        write_Prescreen_Fail_value = aData
        flag_Prescreen_Fail        = &H1
    End Property

    Property Get read_Prescreen_Fail
        read
        read_Prescreen_Fail = read_Prescreen_Fail_value
    End Property

    Property Let write_Prescreen_Fail(aData)
        set_Prescreen_Fail = aData
        write
    End Property

    Property Get get_ILLEGAL_ADDR
        get_ILLEGAL_ADDR = read_ILLEGAL_ADDR_value
    End Property

    Property Let set_ILLEGAL_ADDR(aData)
        write_ILLEGAL_ADDR_value = aData
        flag_ILLEGAL_ADDR        = &H1
    End Property

    Property Get read_ILLEGAL_ADDR
        read
        read_ILLEGAL_ADDR = read_ILLEGAL_ADDR_value
    End Property

    Property Let write_ILLEGAL_ADDR(aData)
        set_ILLEGAL_ADDR = aData
        write
    End Property

    Property Get get_MAX_SW
        get_MAX_SW = read_MAX_SW_value
    End Property

    Property Let set_MAX_SW(aData)
        write_MAX_SW_value = aData
        flag_MAX_SW        = &H1
    End Property

    Property Get read_MAX_SW
        read
        read_MAX_SW = read_MAX_SW_value
    End Property

    Property Let write_MAX_SW(aData)
        set_MAX_SW = aData
        write
    End Property

    Property Get get_AUTO_RW_MAX
        get_AUTO_RW_MAX = read_AUTO_RW_MAX_value
    End Property

    Property Let set_AUTO_RW_MAX(aData)
        write_AUTO_RW_MAX_value = aData
        flag_AUTO_RW_MAX        = &H1
    End Property

    Property Get read_AUTO_RW_MAX
        read
        read_AUTO_RW_MAX = read_AUTO_RW_MAX_value
    End Property

    Property Let write_AUTO_RW_MAX(aData)
        set_AUTO_RW_MAX = aData
        write
    End Property

    Property Get get_MAX_RWP
        get_MAX_RWP = read_MAX_RWP_value
    End Property

    Property Let set_MAX_RWP(aData)
        write_MAX_RWP_value = aData
        flag_MAX_RWP        = &H1
    End Property

    Property Get read_MAX_RWP
        read
        read_MAX_RWP = read_MAX_RWP_value
    End Property

    Property Let write_MAX_RWP(aData)
        set_MAX_RWP = aData
        write
    End Property

    Property Get get_MAX_RW
        get_MAX_RW = read_MAX_RW_value
    End Property

    Property Let set_MAX_RW(aData)
        write_MAX_RW_value = aData
        flag_MAX_RW        = &H1
    End Property

    Property Get read_MAX_RW
        read
        read_MAX_RW = read_MAX_RW_value
    End Property

    Property Let write_MAX_RW(aData)
        set_MAX_RW = aData
        write
    End Property

    Property Get get_PG_WD_FP_FAIL
        get_PG_WD_FP_FAIL = read_PG_WD_FP_FAIL_value
    End Property

    Property Let set_PG_WD_FP_FAIL(aData)
        write_PG_WD_FP_FAIL_value = aData
        flag_PG_WD_FP_FAIL        = &H1
    End Property

    Property Get read_PG_WD_FP_FAIL
        read
        read_PG_WD_FP_FAIL = read_PG_WD_FP_FAIL_value
    End Property

    Property Let write_PG_WD_FP_FAIL(aData)
        set_PG_WD_FP_FAIL = aData
        write
    End Property

    Property Get get_PROG_EN
        get_PROG_EN = read_PROG_EN_value
    End Property

    Property Let set_PROG_EN(aData)
        write_PROG_EN_value = aData
        flag_PROG_EN        = &H1
    End Property

    Property Get read_PROG_EN
        read
        read_PROG_EN = read_PROG_EN_value
    End Property

    Property Let write_PROG_EN(aData)
        set_PROG_EN = aData
        write
    End Property

    Property Get get_PROG_BLK_CMD
        get_PROG_BLK_CMD = read_PROG_BLK_CMD_value
    End Property

    Property Let set_PROG_BLK_CMD(aData)
        write_PROG_BLK_CMD_value = aData
        flag_PROG_BLK_CMD        = &H1
    End Property

    Property Get read_PROG_BLK_CMD
        read
        read_PROG_BLK_CMD = read_PROG_BLK_CMD_value
    End Property

    Property Let write_PROG_BLK_CMD(aData)
        set_PROG_BLK_CMD = aData
        write
    End Property

    Property Get get_PROG_SCR_FAIL
        get_PROG_SCR_FAIL = read_PROG_SCR_FAIL_value
    End Property

    Property Let set_PROG_SCR_FAIL(aData)
        write_PROG_SCR_FAIL_value = aData
        flag_PROG_SCR_FAIL        = &H1
    End Property

    Property Get read_PROG_SCR_FAIL
        read
        read_PROG_SCR_FAIL = read_PROG_SCR_FAIL_value
    End Property

    Property Let write_PROG_SCR_FAIL(aData)
        set_PROG_SCR_FAIL = aData
        write
    End Property

    Property Get get_PROG_WORD_FAIL
        get_PROG_WORD_FAIL = read_PROG_WORD_FAIL_value
    End Property

    Property Let set_PROG_WORD_FAIL(aData)
        write_PROG_WORD_FAIL_value = aData
        flag_PROG_WORD_FAIL        = &H1
    End Property

    Property Get read_PROG_WORD_FAIL
        read
        read_PROG_WORD_FAIL = read_PROG_WORD_FAIL_value
    End Property

    Property Let write_PROG_WORD_FAIL(aData)
        set_PROG_WORD_FAIL = aData
        write
    End Property

    Property Get get_INVALID_ADDR
        get_INVALID_ADDR = read_INVALID_ADDR_value
    End Property

    Property Let set_INVALID_ADDR(aData)
        write_INVALID_ADDR_value = aData
        flag_INVALID_ADDR        = &H1
    End Property

    Property Get read_INVALID_ADDR
        read
        read_INVALID_ADDR = read_INVALID_ADDR_value
    End Property

    Property Let write_INVALID_ADDR(aData)
        set_INVALID_ADDR = aData
        write
    End Property

    Property Get get_DEBUG_MODE
        get_DEBUG_MODE = read_DEBUG_MODE_value
    End Property

    Property Let set_DEBUG_MODE(aData)
        write_DEBUG_MODE_value = aData
        flag_DEBUG_MODE        = &H1
    End Property

    Property Get read_DEBUG_MODE
        read
        read_DEBUG_MODE = read_DEBUG_MODE_value
    End Property

    Property Let write_DEBUG_MODE(aData)
        set_DEBUG_MODE = aData
        write
    End Property

    Property Get get_MST_FSM_ERROR
        get_MST_FSM_ERROR = read_MST_FSM_ERROR_value
    End Property

    Property Let set_MST_FSM_ERROR(aData)
        write_MST_FSM_ERROR_value = aData
        flag_MST_FSM_ERROR        = &H1
    End Property

    Property Get read_MST_FSM_ERROR
        read
        read_MST_FSM_ERROR = read_MST_FSM_ERROR_value
    End Property

    Property Let write_MST_FSM_ERROR(aData)
        set_MST_FSM_ERROR = aData
        write
    End Property

    Property Get get_DEBUG_MODE_SET
        get_DEBUG_MODE_SET = read_DEBUG_MODE_SET_value
    End Property

    Property Let set_DEBUG_MODE_SET(aData)
        write_DEBUG_MODE_SET_value = aData
        flag_DEBUG_MODE_SET        = &H1
    End Property

    Property Get read_DEBUG_MODE_SET
        read
        read_DEBUG_MODE_SET = read_DEBUG_MODE_SET_value
    End Property

    Property Let write_DEBUG_MODE_SET(aData)
        set_DEBUG_MODE_SET = aData
        write
    End Property

    Property Get get_REF_OK
        get_REF_OK = read_REF_OK_value
    End Property

    Property Let set_REF_OK(aData)
        write_REF_OK_value = aData
        flag_REF_OK        = &H1
    End Property

    Property Get read_REF_OK
        read
        read_REF_OK = read_REF_OK_value
    End Property

    Property Let write_REF_OK(aData)
        set_REF_OK = aData
        write
    End Property

    Property Get get_CMD_FAIL
        get_CMD_FAIL = read_CMD_FAIL_value
    End Property

    Property Let set_CMD_FAIL(aData)
        write_CMD_FAIL_value = aData
        flag_CMD_FAIL        = &H1
    End Property

    Property Get read_CMD_FAIL
        read
        read_CMD_FAIL = read_CMD_FAIL_value
    End Property

    Property Let write_CMD_FAIL(aData)
        set_CMD_FAIL = aData
        write
    End Property

    Property Get get_FDONE
        get_FDONE = read_FDONE_value
    End Property

    Property Let set_FDONE(aData)
        write_FDONE_value = aData
        flag_FDONE        = &H1
    End Property

    Property Get read_FDONE
        read
        read_FDONE = read_FDONE_value
    End Property

    Property Let write_FDONE(aData)
        set_FDONE = aData
        write
    End Property

    Property Get get_PROG_OK
        get_PROG_OK = read_PROG_OK_value
    End Property

    Property Let set_PROG_OK(aData)
        write_PROG_OK_value = aData
        flag_PROG_OK        = &H1
    End Property

    Property Get read_PROG_OK
        read
        read_PROG_OK = read_PROG_OK_value
    End Property

    Property Let write_PROG_OK(aData)
        set_PROG_OK = aData
        write
    End Property

    Property Get get_CMD_DONE
        get_CMD_DONE = read_CMD_DONE_value
    End Property

    Property Let set_CMD_DONE(aData)
        write_CMD_DONE_value = aData
        flag_CMD_DONE        = &H1
    End Property

    Property Get read_CMD_DONE
        read
        read_CMD_DONE = read_CMD_DONE_value
    End Property

    Property Let write_CMD_DONE(aData)
        set_CMD_DONE = aData
        write
    End Property

    Property Get get_DATA_VALID
        get_DATA_VALID = read_DATA_VALID_value
    End Property

    Property Let set_DATA_VALID(aData)
        write_DATA_VALID_value = aData
        flag_DATA_VALID        = &H1
    End Property

    Property Get read_DATA_VALID
        read
        read_DATA_VALID = read_DATA_VALID_value
    End Property

    Property Let write_DATA_VALID(aData)
        set_DATA_VALID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Ecc_ded_flag_status_value = rightShift(data_low, 23) and &H1
        read_Ecc_sec_flag_status_value = rightShift(data_low, 22) and &H1
        read_Prescreen_Fail_value = rightShift(data_low, 20) and &H1
        read_ILLEGAL_ADDR_value = rightShift(data_low, 19) and &H1
        read_MAX_SW_value = rightShift(data_low, 18) and &H1
        read_AUTO_RW_MAX_value = rightShift(data_low, 17) and &H1
        read_MAX_RWP_value = rightShift(data_low, 16) and &H1
        read_MAX_RW_value = rightShift(data_low, 15) and &H1
        read_PG_WD_FP_FAIL_value = rightShift(data_low, 14) and &H1
        read_PROG_EN_value = rightShift(data_low, 13) and &H1
        read_PROG_BLK_CMD_value = rightShift(data_low, 12) and &H1
        read_PROG_SCR_FAIL_value = rightShift(data_low, 11) and &H1
        read_PROG_WORD_FAIL_value = rightShift(data_low, 10) and &H1
        read_INVALID_ADDR_value = rightShift(data_low, 9) and &H1
        read_DEBUG_MODE_value = rightShift(data_low, 8) and &H1
        read_MST_FSM_ERROR_value = rightShift(data_low, 7) and &H1
        read_DEBUG_MODE_SET_value = rightShift(data_low, 6) and &H1
        read_REF_OK_value = rightShift(data_low, 5) and &H1
        read_CMD_FAIL_value = rightShift(data_low, 4) and &H1
        read_FDONE_value = rightShift(data_low, 3) and &H1
        read_PROG_OK_value = rightShift(data_low, 2) and &H1
        read_CMD_DONE_value = rightShift(data_low, 1) and &H1
        DATA_VALID_mask = &H1
        if data_low > LONG_MAX then
            if DATA_VALID_mask = mask then
                read_DATA_VALID_value = data_low
            else
                read_DATA_VALID_value = (data_low - H8000_0000) and DATA_VALID_mask
            end If
        else
            read_DATA_VALID_value = data_low and DATA_VALID_mask
        end If

    End Sub

    Sub write
        If flag_Ecc_ded_flag_status = &H0 or flag_Ecc_sec_flag_status = &H0 or flag_Prescreen_Fail = &H0 or flag_ILLEGAL_ADDR = &H0 or flag_MAX_SW = &H0 or flag_AUTO_RW_MAX = &H0 or flag_MAX_RWP = &H0 or flag_MAX_RW = &H0 or flag_PG_WD_FP_FAIL = &H0 or flag_PROG_EN = &H0 or flag_PROG_BLK_CMD = &H0 or flag_PROG_SCR_FAIL = &H0 or flag_PROG_WORD_FAIL = &H0 or flag_INVALID_ADDR = &H0 or flag_DEBUG_MODE = &H0 or flag_MST_FSM_ERROR = &H0 or flag_DEBUG_MODE_SET = &H0 or flag_REF_OK = &H0 or flag_CMD_FAIL = &H0 or flag_FDONE = &H0 or flag_PROG_OK = &H0 or flag_CMD_DONE = &H0 or flag_DATA_VALID = &H0 Then read
        If flag_Ecc_ded_flag_status = &H0 Then write_Ecc_ded_flag_status_value = get_Ecc_ded_flag_status
        If flag_Ecc_sec_flag_status = &H0 Then write_Ecc_sec_flag_status_value = get_Ecc_sec_flag_status
        If flag_Prescreen_Fail = &H0 Then write_Prescreen_Fail_value = get_Prescreen_Fail
        If flag_ILLEGAL_ADDR = &H0 Then write_ILLEGAL_ADDR_value = get_ILLEGAL_ADDR
        If flag_MAX_SW = &H0 Then write_MAX_SW_value = get_MAX_SW
        If flag_AUTO_RW_MAX = &H0 Then write_AUTO_RW_MAX_value = get_AUTO_RW_MAX
        If flag_MAX_RWP = &H0 Then write_MAX_RWP_value = get_MAX_RWP
        If flag_MAX_RW = &H0 Then write_MAX_RW_value = get_MAX_RW
        If flag_PG_WD_FP_FAIL = &H0 Then write_PG_WD_FP_FAIL_value = get_PG_WD_FP_FAIL
        If flag_PROG_EN = &H0 Then write_PROG_EN_value = get_PROG_EN
        If flag_PROG_BLK_CMD = &H0 Then write_PROG_BLK_CMD_value = get_PROG_BLK_CMD
        If flag_PROG_SCR_FAIL = &H0 Then write_PROG_SCR_FAIL_value = get_PROG_SCR_FAIL
        If flag_PROG_WORD_FAIL = &H0 Then write_PROG_WORD_FAIL_value = get_PROG_WORD_FAIL
        If flag_INVALID_ADDR = &H0 Then write_INVALID_ADDR_value = get_INVALID_ADDR
        If flag_DEBUG_MODE = &H0 Then write_DEBUG_MODE_value = get_DEBUG_MODE
        If flag_MST_FSM_ERROR = &H0 Then write_MST_FSM_ERROR_value = get_MST_FSM_ERROR
        If flag_DEBUG_MODE_SET = &H0 Then write_DEBUG_MODE_SET_value = get_DEBUG_MODE_SET
        If flag_REF_OK = &H0 Then write_REF_OK_value = get_REF_OK
        If flag_CMD_FAIL = &H0 Then write_CMD_FAIL_value = get_CMD_FAIL
        If flag_FDONE = &H0 Then write_FDONE_value = get_FDONE
        If flag_PROG_OK = &H0 Then write_PROG_OK_value = get_PROG_OK
        If flag_CMD_DONE = &H0 Then write_CMD_DONE_value = get_CMD_DONE
        If flag_DATA_VALID = &H0 Then write_DATA_VALID_value = get_DATA_VALID

        regValue = leftShift((write_Ecc_ded_flag_status_value and &H1), 23) + leftShift((write_Ecc_sec_flag_status_value and &H1), 22) + leftShift((write_Prescreen_Fail_value and &H1), 20) + leftShift((write_ILLEGAL_ADDR_value and &H1), 19) + leftShift((write_MAX_SW_value and &H1), 18) + leftShift((write_AUTO_RW_MAX_value and &H1), 17) + leftShift((write_MAX_RWP_value and &H1), 16) + leftShift((write_MAX_RW_value and &H1), 15) + leftShift((write_PG_WD_FP_FAIL_value and &H1), 14) + leftShift((write_PROG_EN_value and &H1), 13) + leftShift((write_PROG_BLK_CMD_value and &H1), 12) + leftShift((write_PROG_SCR_FAIL_value and &H1), 11) + leftShift((write_PROG_WORD_FAIL_value and &H1), 10) + leftShift((write_INVALID_ADDR_value and &H1), 9) + leftShift((write_DEBUG_MODE_value and &H1), 8) + leftShift((write_MST_FSM_ERROR_value and &H1), 7) + leftShift((write_DEBUG_MODE_SET_value and &H1), 6) + leftShift((write_REF_OK_value and &H1), 5) + leftShift((write_CMD_FAIL_value and &H1), 4) + leftShift((write_FDONE_value and &H1), 3) + leftShift((write_PROG_OK_value and &H1), 2) + leftShift((write_CMD_DONE_value and &H1), 1) + leftShift((write_DATA_VALID_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Ecc_ded_flag_status_value = rightShift(data_low, 23) and &H1
        read_Ecc_sec_flag_status_value = rightShift(data_low, 22) and &H1
        read_Prescreen_Fail_value = rightShift(data_low, 20) and &H1
        read_ILLEGAL_ADDR_value = rightShift(data_low, 19) and &H1
        read_MAX_SW_value = rightShift(data_low, 18) and &H1
        read_AUTO_RW_MAX_value = rightShift(data_low, 17) and &H1
        read_MAX_RWP_value = rightShift(data_low, 16) and &H1
        read_MAX_RW_value = rightShift(data_low, 15) and &H1
        read_PG_WD_FP_FAIL_value = rightShift(data_low, 14) and &H1
        read_PROG_EN_value = rightShift(data_low, 13) and &H1
        read_PROG_BLK_CMD_value = rightShift(data_low, 12) and &H1
        read_PROG_SCR_FAIL_value = rightShift(data_low, 11) and &H1
        read_PROG_WORD_FAIL_value = rightShift(data_low, 10) and &H1
        read_INVALID_ADDR_value = rightShift(data_low, 9) and &H1
        read_DEBUG_MODE_value = rightShift(data_low, 8) and &H1
        read_MST_FSM_ERROR_value = rightShift(data_low, 7) and &H1
        read_DEBUG_MODE_SET_value = rightShift(data_low, 6) and &H1
        read_REF_OK_value = rightShift(data_low, 5) and &H1
        read_CMD_FAIL_value = rightShift(data_low, 4) and &H1
        read_FDONE_value = rightShift(data_low, 3) and &H1
        read_PROG_OK_value = rightShift(data_low, 2) and &H1
        read_CMD_DONE_value = rightShift(data_low, 1) and &H1
        DATA_VALID_mask = &H1
        if data_low > LONG_MAX then
            if DATA_VALID_mask = mask then
                read_DATA_VALID_value = data_low
            else
                read_DATA_VALID_value = (data_low - H8000_0000) and DATA_VALID_mask
            end If
        else
            read_DATA_VALID_value = data_low and DATA_VALID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Ecc_ded_flag_status_value = &H0
        flag_Ecc_ded_flag_status        = &H0
        write_Ecc_sec_flag_status_value = &H0
        flag_Ecc_sec_flag_status        = &H0
        write_Prescreen_Fail_value = &H0
        flag_Prescreen_Fail        = &H0
        write_ILLEGAL_ADDR_value = &H0
        flag_ILLEGAL_ADDR        = &H0
        write_MAX_SW_value = &H0
        flag_MAX_SW        = &H0
        write_AUTO_RW_MAX_value = &H0
        flag_AUTO_RW_MAX        = &H0
        write_MAX_RWP_value = &H0
        flag_MAX_RWP        = &H0
        write_MAX_RW_value = &H0
        flag_MAX_RW        = &H0
        write_PG_WD_FP_FAIL_value = &H0
        flag_PG_WD_FP_FAIL        = &H0
        write_PROG_EN_value = &H0
        flag_PROG_EN        = &H0
        write_PROG_BLK_CMD_value = &H0
        flag_PROG_BLK_CMD        = &H0
        write_PROG_SCR_FAIL_value = &H0
        flag_PROG_SCR_FAIL        = &H0
        write_PROG_WORD_FAIL_value = &H0
        flag_PROG_WORD_FAIL        = &H0
        write_INVALID_ADDR_value = &H0
        flag_INVALID_ADDR        = &H0
        write_DEBUG_MODE_value = &H0
        flag_DEBUG_MODE        = &H0
        write_MST_FSM_ERROR_value = &H0
        flag_MST_FSM_ERROR        = &H0
        write_DEBUG_MODE_SET_value = &H0
        flag_DEBUG_MODE_SET        = &H0
        write_REF_OK_value = &H0
        flag_REF_OK        = &H0
        write_CMD_FAIL_value = &H0
        flag_CMD_FAIL        = &H0
        write_FDONE_value = &H0
        flag_FDONE        = &H0
        write_PROG_OK_value = &H0
        flag_PROG_OK        = &H0
        write_CMD_DONE_value = &H0
        flag_CMD_DONE        = &H0
        write_DATA_VALID_value = &H0
        flag_DATA_VALID        = &H0
    End Sub
End Class


'' @REGISTER : OTP_status_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_OTP_status_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18
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


'' @REGISTER : OTP_cpu_rdata
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_rdata                                  [31:0]           get_cpu_rdata
''                                                             set_cpu_rdata
''                                                             read_cpu_rdata
''                                                             write_cpu_rdata
''---------------------------------------------------------------------------------
Class REGISTER_OTP_cpu_rdata
    Private write_cpu_rdata_value
    Private read_cpu_rdata_value
    Private flag_cpu_rdata

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_rdata
        get_cpu_rdata = read_cpu_rdata_value
    End Property

    Property Let set_cpu_rdata(aData)
        write_cpu_rdata_value = aData
        flag_cpu_rdata        = &H1
    End Property

    Property Get read_cpu_rdata
        read
        read_cpu_rdata = read_cpu_rdata_value
    End Property

    Property Let write_cpu_rdata(aData)
        set_cpu_rdata = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_rdata_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_rdata_mask = mask then
                read_cpu_rdata_value = data_low
            else
                read_cpu_rdata_value = (data_low - H8000_0000) and cpu_rdata_mask
            end If
        else
            read_cpu_rdata_value = data_low and cpu_rdata_mask
        end If

    End Sub

    Sub write
        If flag_cpu_rdata = &H0 Then read
        If flag_cpu_rdata = &H0 Then write_cpu_rdata_value = get_cpu_rdata

        regValue = leftShift(write_cpu_rdata_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_rdata_mask = &Hffffffff
        if data_low > LONG_MAX then
            if cpu_rdata_mask = mask then
                read_cpu_rdata_value = data_low
            else
                read_cpu_rdata_value = (data_low - H8000_0000) and cpu_rdata_mask
            end If
        else
            read_cpu_rdata_value = data_low and cpu_rdata_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_rdata_value = &H0
        flag_cpu_rdata        = &H0
    End Sub
End Class


'' @REGISTER : OTP_cpu_rdata_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_rdata_hi                               [6:0]            get_cpu_rdata_hi
''                                                             set_cpu_rdata_hi
''                                                             read_cpu_rdata_hi
''                                                             write_cpu_rdata_hi
''---------------------------------------------------------------------------------
Class REGISTER_OTP_cpu_rdata_hi
    Private write_cpu_rdata_hi_value
    Private read_cpu_rdata_hi_value
    Private flag_cpu_rdata_hi

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cpu_rdata_hi
        get_cpu_rdata_hi = read_cpu_rdata_hi_value
    End Property

    Property Let set_cpu_rdata_hi(aData)
        write_cpu_rdata_hi_value = aData
        flag_cpu_rdata_hi        = &H1
    End Property

    Property Get read_cpu_rdata_hi
        read
        read_cpu_rdata_hi = read_cpu_rdata_hi_value
    End Property

    Property Let write_cpu_rdata_hi(aData)
        set_cpu_rdata_hi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_rdata_hi_mask = &H7f
        if data_low > LONG_MAX then
            if cpu_rdata_hi_mask = mask then
                read_cpu_rdata_hi_value = data_low
            else
                read_cpu_rdata_hi_value = (data_low - H8000_0000) and cpu_rdata_hi_mask
            end If
        else
            read_cpu_rdata_hi_value = data_low and cpu_rdata_hi_mask
        end If

    End Sub

    Sub write
        If flag_cpu_rdata_hi = &H0 Then read
        If flag_cpu_rdata_hi = &H0 Then write_cpu_rdata_hi_value = get_cpu_rdata_hi

        regValue = leftShift((write_cpu_rdata_hi_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_rdata_hi_mask = &H7f
        if data_low > LONG_MAX then
            if cpu_rdata_hi_mask = mask then
                read_cpu_rdata_hi_value = data_low
            else
                read_cpu_rdata_hi_value = (data_low - H8000_0000) and cpu_rdata_hi_mask
            end If
        else
            read_cpu_rdata_hi_value = data_low and cpu_rdata_hi_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_rdata_hi_value = &H0
        flag_cpu_rdata_hi        = &H0
    End Sub
End Class


'' @REGISTER : OTP_bisr_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_OTP_bisr_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24
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


'' @REGISTER : OTP_ecc_interrupt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ecc_ded_flag_int                           [15:15]          get_ecc_ded_flag_int
''                                                             set_ecc_ded_flag_int
''                                                             read_ecc_ded_flag_int
''                                                             write_ecc_ded_flag_int
''---------------------------------------------------------------------------------
'' ecc_sec_flag_int                           [14:14]          get_ecc_sec_flag_int
''                                                             set_ecc_sec_flag_int
''                                                             read_ecc_sec_flag_int
''                                                             write_ecc_sec_flag_int
''---------------------------------------------------------------------------------
'' unused_int                                 [13:0]           get_unused_int
''                                                             set_unused_int
''                                                             read_unused_int
''                                                             write_unused_int
''---------------------------------------------------------------------------------
Class REGISTER_OTP_ecc_interrupt
    Private write_ecc_ded_flag_int_value
    Private read_ecc_ded_flag_int_value
    Private flag_ecc_ded_flag_int
    Private write_ecc_sec_flag_int_value
    Private read_ecc_sec_flag_int_value
    Private flag_ecc_sec_flag_int
    Private write_unused_int_value
    Private read_unused_int_value
    Private flag_unused_int

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ecc_ded_flag_int
        get_ecc_ded_flag_int = read_ecc_ded_flag_int_value
    End Property

    Property Let set_ecc_ded_flag_int(aData)
        write_ecc_ded_flag_int_value = aData
        flag_ecc_ded_flag_int        = &H1
    End Property

    Property Get read_ecc_ded_flag_int
        read
        read_ecc_ded_flag_int = read_ecc_ded_flag_int_value
    End Property

    Property Let write_ecc_ded_flag_int(aData)
        set_ecc_ded_flag_int = aData
        write
    End Property

    Property Get get_ecc_sec_flag_int
        get_ecc_sec_flag_int = read_ecc_sec_flag_int_value
    End Property

    Property Let set_ecc_sec_flag_int(aData)
        write_ecc_sec_flag_int_value = aData
        flag_ecc_sec_flag_int        = &H1
    End Property

    Property Get read_ecc_sec_flag_int
        read
        read_ecc_sec_flag_int = read_ecc_sec_flag_int_value
    End Property

    Property Let write_ecc_sec_flag_int(aData)
        set_ecc_sec_flag_int = aData
        write
    End Property

    Property Get get_unused_int
        get_unused_int = read_unused_int_value
    End Property

    Property Let set_unused_int(aData)
        write_unused_int_value = aData
        flag_unused_int        = &H1
    End Property

    Property Get read_unused_int
        read
        read_unused_int = read_unused_int_value
    End Property

    Property Let write_unused_int(aData)
        set_unused_int = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ecc_ded_flag_int_value = rightShift(data_low, 15) and &H1
        read_ecc_sec_flag_int_value = rightShift(data_low, 14) and &H1
        unused_int_mask = &H3fff
        if data_low > LONG_MAX then
            if unused_int_mask = mask then
                read_unused_int_value = data_low
            else
                read_unused_int_value = (data_low - H8000_0000) and unused_int_mask
            end If
        else
            read_unused_int_value = data_low and unused_int_mask
        end If

    End Sub

    Sub write
        If flag_ecc_ded_flag_int = &H0 or flag_ecc_sec_flag_int = &H0 or flag_unused_int = &H0 Then read
        If flag_ecc_ded_flag_int = &H0 Then write_ecc_ded_flag_int_value = get_ecc_ded_flag_int
        If flag_ecc_sec_flag_int = &H0 Then write_ecc_sec_flag_int_value = get_ecc_sec_flag_int
        If flag_unused_int = &H0 Then write_unused_int_value = get_unused_int

        regValue = leftShift((write_ecc_ded_flag_int_value and &H1), 15) + leftShift((write_ecc_sec_flag_int_value and &H1), 14) + leftShift((write_unused_int_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ecc_ded_flag_int_value = rightShift(data_low, 15) and &H1
        read_ecc_sec_flag_int_value = rightShift(data_low, 14) and &H1
        unused_int_mask = &H3fff
        if data_low > LONG_MAX then
            if unused_int_mask = mask then
                read_unused_int_value = data_low
            else
                read_unused_int_value = (data_low - H8000_0000) and unused_int_mask
            end If
        else
            read_unused_int_value = data_low and unused_int_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ecc_ded_flag_int_value = &H0
        flag_ecc_ded_flag_int        = &H0
        write_ecc_sec_flag_int_value = &H0
        flag_ecc_sec_flag_int        = &H0
        write_unused_int_value = &H0
        flag_unused_int        = &H0
    End Sub
End Class


'' @REGISTER : OTP_ecc_interrupt_en_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ecc_ded_flag_int_en                        [15:15]          get_ecc_ded_flag_int_en
''                                                             set_ecc_ded_flag_int_en
''                                                             read_ecc_ded_flag_int_en
''                                                             write_ecc_ded_flag_int_en
''---------------------------------------------------------------------------------
'' ecc_sec_flag_int_en                        [14:14]          get_ecc_sec_flag_int_en
''                                                             set_ecc_sec_flag_int_en
''                                                             read_ecc_sec_flag_int_en
''                                                             write_ecc_sec_flag_int_en
''---------------------------------------------------------------------------------
'' unused_int_en                              [13:0]           get_unused_int_en
''                                                             set_unused_int_en
''                                                             read_unused_int_en
''                                                             write_unused_int_en
''---------------------------------------------------------------------------------
Class REGISTER_OTP_ecc_interrupt_en_reg
    Private write_ecc_ded_flag_int_en_value
    Private read_ecc_ded_flag_int_en_value
    Private flag_ecc_ded_flag_int_en
    Private write_ecc_sec_flag_int_en_value
    Private read_ecc_sec_flag_int_en_value
    Private flag_ecc_sec_flag_int_en
    Private write_unused_int_en_value
    Private read_unused_int_en_value
    Private flag_unused_int_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ecc_ded_flag_int_en
        get_ecc_ded_flag_int_en = read_ecc_ded_flag_int_en_value
    End Property

    Property Let set_ecc_ded_flag_int_en(aData)
        write_ecc_ded_flag_int_en_value = aData
        flag_ecc_ded_flag_int_en        = &H1
    End Property

    Property Get read_ecc_ded_flag_int_en
        read
        read_ecc_ded_flag_int_en = read_ecc_ded_flag_int_en_value
    End Property

    Property Let write_ecc_ded_flag_int_en(aData)
        set_ecc_ded_flag_int_en = aData
        write
    End Property

    Property Get get_ecc_sec_flag_int_en
        get_ecc_sec_flag_int_en = read_ecc_sec_flag_int_en_value
    End Property

    Property Let set_ecc_sec_flag_int_en(aData)
        write_ecc_sec_flag_int_en_value = aData
        flag_ecc_sec_flag_int_en        = &H1
    End Property

    Property Get read_ecc_sec_flag_int_en
        read
        read_ecc_sec_flag_int_en = read_ecc_sec_flag_int_en_value
    End Property

    Property Let write_ecc_sec_flag_int_en(aData)
        set_ecc_sec_flag_int_en = aData
        write
    End Property

    Property Get get_unused_int_en
        get_unused_int_en = read_unused_int_en_value
    End Property

    Property Let set_unused_int_en(aData)
        write_unused_int_en_value = aData
        flag_unused_int_en        = &H1
    End Property

    Property Get read_unused_int_en
        read
        read_unused_int_en = read_unused_int_en_value
    End Property

    Property Let write_unused_int_en(aData)
        set_unused_int_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ecc_ded_flag_int_en_value = rightShift(data_low, 15) and &H1
        read_ecc_sec_flag_int_en_value = rightShift(data_low, 14) and &H1
        unused_int_en_mask = &H3fff
        if data_low > LONG_MAX then
            if unused_int_en_mask = mask then
                read_unused_int_en_value = data_low
            else
                read_unused_int_en_value = (data_low - H8000_0000) and unused_int_en_mask
            end If
        else
            read_unused_int_en_value = data_low and unused_int_en_mask
        end If

    End Sub

    Sub write
        If flag_ecc_ded_flag_int_en = &H0 or flag_ecc_sec_flag_int_en = &H0 or flag_unused_int_en = &H0 Then read
        If flag_ecc_ded_flag_int_en = &H0 Then write_ecc_ded_flag_int_en_value = get_ecc_ded_flag_int_en
        If flag_ecc_sec_flag_int_en = &H0 Then write_ecc_sec_flag_int_en_value = get_ecc_sec_flag_int_en
        If flag_unused_int_en = &H0 Then write_unused_int_en_value = get_unused_int_en

        regValue = leftShift((write_ecc_ded_flag_int_en_value and &H1), 15) + leftShift((write_ecc_sec_flag_int_en_value and &H1), 14) + leftShift((write_unused_int_en_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ecc_ded_flag_int_en_value = rightShift(data_low, 15) and &H1
        read_ecc_sec_flag_int_en_value = rightShift(data_low, 14) and &H1
        unused_int_en_mask = &H3fff
        if data_low > LONG_MAX then
            if unused_int_en_mask = mask then
                read_unused_int_en_value = data_low
            else
                read_unused_int_en_value = (data_low - H8000_0000) and unused_int_en_mask
            end If
        else
            read_unused_int_en_value = data_low and unused_int_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ecc_ded_flag_int_en_value = &H0
        flag_ecc_ded_flag_int_en        = &H0
        write_ecc_sec_flag_int_en_value = &H0
        flag_ecc_sec_flag_int_en        = &H0
        write_unused_int_en_value = &H0
        flag_unused_int_en        = &H0
    End Sub
End Class


'' @REGISTER : OTP_ecc_interrupt_clr_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ecc_ded_flag_int_clr                       [15:15]          get_ecc_ded_flag_int_clr
''                                                             set_ecc_ded_flag_int_clr
''                                                             read_ecc_ded_flag_int_clr
''                                                             write_ecc_ded_flag_int_clr
''---------------------------------------------------------------------------------
'' ecc_sec_flag_int_clr                       [14:14]          get_ecc_sec_flag_int_clr
''                                                             set_ecc_sec_flag_int_clr
''                                                             read_ecc_sec_flag_int_clr
''                                                             write_ecc_sec_flag_int_clr
''---------------------------------------------------------------------------------
'' unused_int_clr                             [13:0]           get_unused_int_clr
''                                                             set_unused_int_clr
''                                                             read_unused_int_clr
''                                                             write_unused_int_clr
''---------------------------------------------------------------------------------
Class REGISTER_OTP_ecc_interrupt_clr_reg
    Private write_ecc_ded_flag_int_clr_value
    Private read_ecc_ded_flag_int_clr_value
    Private flag_ecc_ded_flag_int_clr
    Private write_ecc_sec_flag_int_clr_value
    Private read_ecc_sec_flag_int_clr_value
    Private flag_ecc_sec_flag_int_clr
    Private write_unused_int_clr_value
    Private read_unused_int_clr_value
    Private flag_unused_int_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ecc_ded_flag_int_clr
        get_ecc_ded_flag_int_clr = read_ecc_ded_flag_int_clr_value
    End Property

    Property Let set_ecc_ded_flag_int_clr(aData)
        write_ecc_ded_flag_int_clr_value = aData
        flag_ecc_ded_flag_int_clr        = &H1
    End Property

    Property Get read_ecc_ded_flag_int_clr
        read
        read_ecc_ded_flag_int_clr = read_ecc_ded_flag_int_clr_value
    End Property

    Property Let write_ecc_ded_flag_int_clr(aData)
        set_ecc_ded_flag_int_clr = aData
        write
    End Property

    Property Get get_ecc_sec_flag_int_clr
        get_ecc_sec_flag_int_clr = read_ecc_sec_flag_int_clr_value
    End Property

    Property Let set_ecc_sec_flag_int_clr(aData)
        write_ecc_sec_flag_int_clr_value = aData
        flag_ecc_sec_flag_int_clr        = &H1
    End Property

    Property Get read_ecc_sec_flag_int_clr
        read
        read_ecc_sec_flag_int_clr = read_ecc_sec_flag_int_clr_value
    End Property

    Property Let write_ecc_sec_flag_int_clr(aData)
        set_ecc_sec_flag_int_clr = aData
        write
    End Property

    Property Get get_unused_int_clr
        get_unused_int_clr = read_unused_int_clr_value
    End Property

    Property Let set_unused_int_clr(aData)
        write_unused_int_clr_value = aData
        flag_unused_int_clr        = &H1
    End Property

    Property Get read_unused_int_clr
        read
        read_unused_int_clr = read_unused_int_clr_value
    End Property

    Property Let write_unused_int_clr(aData)
        set_unused_int_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ecc_ded_flag_int_clr_value = rightShift(data_low, 15) and &H1
        read_ecc_sec_flag_int_clr_value = rightShift(data_low, 14) and &H1
        unused_int_clr_mask = &H3fff
        if data_low > LONG_MAX then
            if unused_int_clr_mask = mask then
                read_unused_int_clr_value = data_low
            else
                read_unused_int_clr_value = (data_low - H8000_0000) and unused_int_clr_mask
            end If
        else
            read_unused_int_clr_value = data_low and unused_int_clr_mask
        end If

    End Sub

    Sub write
        If flag_ecc_ded_flag_int_clr = &H0 or flag_ecc_sec_flag_int_clr = &H0 or flag_unused_int_clr = &H0 Then read
        If flag_ecc_ded_flag_int_clr = &H0 Then write_ecc_ded_flag_int_clr_value = get_ecc_ded_flag_int_clr
        If flag_ecc_sec_flag_int_clr = &H0 Then write_ecc_sec_flag_int_clr_value = get_ecc_sec_flag_int_clr
        If flag_unused_int_clr = &H0 Then write_unused_int_clr_value = get_unused_int_clr

        regValue = leftShift((write_ecc_ded_flag_int_clr_value and &H1), 15) + leftShift((write_ecc_sec_flag_int_clr_value and &H1), 14) + leftShift((write_unused_int_clr_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ecc_ded_flag_int_clr_value = rightShift(data_low, 15) and &H1
        read_ecc_sec_flag_int_clr_value = rightShift(data_low, 14) and &H1
        unused_int_clr_mask = &H3fff
        if data_low > LONG_MAX then
            if unused_int_clr_mask = mask then
                read_unused_int_clr_value = data_low
            else
                read_unused_int_clr_value = (data_low - H8000_0000) and unused_int_clr_mask
            end If
        else
            read_unused_int_clr_value = data_low and unused_int_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ecc_ded_flag_int_clr_value = &H0
        flag_ecc_ded_flag_int_clr        = &H0
        write_ecc_sec_flag_int_clr_value = &H0
        flag_ecc_sec_flag_int_clr        = &H0
        write_unused_int_clr_value = &H0
        flag_unused_int_clr        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA0                             [31:0]           get_OTP_FOUT_DATA0
''                                                             set_OTP_FOUT_DATA0
''                                                             read_OTP_FOUT_DATA0
''                                                             write_OTP_FOUT_DATA0
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data0
    Private write_OTP_FOUT_DATA0_value
    Private read_OTP_FOUT_DATA0_value
    Private flag_OTP_FOUT_DATA0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_FOUT_DATA0
        get_OTP_FOUT_DATA0 = read_OTP_FOUT_DATA0_value
    End Property

    Property Let set_OTP_FOUT_DATA0(aData)
        write_OTP_FOUT_DATA0_value = aData
        flag_OTP_FOUT_DATA0        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA0
        read
        read_OTP_FOUT_DATA0 = read_OTP_FOUT_DATA0_value
    End Property

    Property Let write_OTP_FOUT_DATA0(aData)
        set_OTP_FOUT_DATA0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA0_mask = mask then
                read_OTP_FOUT_DATA0_value = data_low
            else
                read_OTP_FOUT_DATA0_value = (data_low - H8000_0000) and OTP_FOUT_DATA0_mask
            end If
        else
            read_OTP_FOUT_DATA0_value = data_low and OTP_FOUT_DATA0_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA0 = &H0 Then read
        If flag_OTP_FOUT_DATA0 = &H0 Then write_OTP_FOUT_DATA0_value = get_OTP_FOUT_DATA0

        regValue = leftShift(write_OTP_FOUT_DATA0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA0_mask = mask then
                read_OTP_FOUT_DATA0_value = data_low
            else
                read_OTP_FOUT_DATA0_value = (data_low - H8000_0000) and OTP_FOUT_DATA0_mask
            end If
        else
            read_OTP_FOUT_DATA0_value = data_low and OTP_FOUT_DATA0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA0_value = &H0
        flag_OTP_FOUT_DATA0        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA1                             [31:0]           get_OTP_FOUT_DATA1
''                                                             set_OTP_FOUT_DATA1
''                                                             read_OTP_FOUT_DATA1
''                                                             write_OTP_FOUT_DATA1
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data1
    Private write_OTP_FOUT_DATA1_value
    Private read_OTP_FOUT_DATA1_value
    Private flag_OTP_FOUT_DATA1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_FOUT_DATA1
        get_OTP_FOUT_DATA1 = read_OTP_FOUT_DATA1_value
    End Property

    Property Let set_OTP_FOUT_DATA1(aData)
        write_OTP_FOUT_DATA1_value = aData
        flag_OTP_FOUT_DATA1        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA1
        read
        read_OTP_FOUT_DATA1 = read_OTP_FOUT_DATA1_value
    End Property

    Property Let write_OTP_FOUT_DATA1(aData)
        set_OTP_FOUT_DATA1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA1_mask = mask then
                read_OTP_FOUT_DATA1_value = data_low
            else
                read_OTP_FOUT_DATA1_value = (data_low - H8000_0000) and OTP_FOUT_DATA1_mask
            end If
        else
            read_OTP_FOUT_DATA1_value = data_low and OTP_FOUT_DATA1_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA1 = &H0 Then read
        If flag_OTP_FOUT_DATA1 = &H0 Then write_OTP_FOUT_DATA1_value = get_OTP_FOUT_DATA1

        regValue = leftShift(write_OTP_FOUT_DATA1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA1_mask = mask then
                read_OTP_FOUT_DATA1_value = data_low
            else
                read_OTP_FOUT_DATA1_value = (data_low - H8000_0000) and OTP_FOUT_DATA1_mask
            end If
        else
            read_OTP_FOUT_DATA1_value = data_low and OTP_FOUT_DATA1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA1_value = &H0
        flag_OTP_FOUT_DATA1        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA2                             [31:0]           get_OTP_FOUT_DATA2
''                                                             set_OTP_FOUT_DATA2
''                                                             read_OTP_FOUT_DATA2
''                                                             write_OTP_FOUT_DATA2
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data2
    Private write_OTP_FOUT_DATA2_value
    Private read_OTP_FOUT_DATA2_value
    Private flag_OTP_FOUT_DATA2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_OTP_FOUT_DATA2
        get_OTP_FOUT_DATA2 = read_OTP_FOUT_DATA2_value
    End Property

    Property Let set_OTP_FOUT_DATA2(aData)
        write_OTP_FOUT_DATA2_value = aData
        flag_OTP_FOUT_DATA2        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA2
        read
        read_OTP_FOUT_DATA2 = read_OTP_FOUT_DATA2_value
    End Property

    Property Let write_OTP_FOUT_DATA2(aData)
        set_OTP_FOUT_DATA2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA2_mask = mask then
                read_OTP_FOUT_DATA2_value = data_low
            else
                read_OTP_FOUT_DATA2_value = (data_low - H8000_0000) and OTP_FOUT_DATA2_mask
            end If
        else
            read_OTP_FOUT_DATA2_value = data_low and OTP_FOUT_DATA2_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA2 = &H0 Then read
        If flag_OTP_FOUT_DATA2 = &H0 Then write_OTP_FOUT_DATA2_value = get_OTP_FOUT_DATA2

        regValue = leftShift(write_OTP_FOUT_DATA2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA2_mask = mask then
                read_OTP_FOUT_DATA2_value = data_low
            else
                read_OTP_FOUT_DATA2_value = (data_low - H8000_0000) and OTP_FOUT_DATA2_mask
            end If
        else
            read_OTP_FOUT_DATA2_value = data_low and OTP_FOUT_DATA2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA2_value = &H0
        flag_OTP_FOUT_DATA2        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA3                             [31:0]           get_OTP_FOUT_DATA3
''                                                             set_OTP_FOUT_DATA3
''                                                             read_OTP_FOUT_DATA3
''                                                             write_OTP_FOUT_DATA3
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data3
    Private write_OTP_FOUT_DATA3_value
    Private read_OTP_FOUT_DATA3_value
    Private flag_OTP_FOUT_DATA3

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

    Property Get get_OTP_FOUT_DATA3
        get_OTP_FOUT_DATA3 = read_OTP_FOUT_DATA3_value
    End Property

    Property Let set_OTP_FOUT_DATA3(aData)
        write_OTP_FOUT_DATA3_value = aData
        flag_OTP_FOUT_DATA3        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA3
        read
        read_OTP_FOUT_DATA3 = read_OTP_FOUT_DATA3_value
    End Property

    Property Let write_OTP_FOUT_DATA3(aData)
        set_OTP_FOUT_DATA3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA3_mask = mask then
                read_OTP_FOUT_DATA3_value = data_low
            else
                read_OTP_FOUT_DATA3_value = (data_low - H8000_0000) and OTP_FOUT_DATA3_mask
            end If
        else
            read_OTP_FOUT_DATA3_value = data_low and OTP_FOUT_DATA3_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA3 = &H0 Then read
        If flag_OTP_FOUT_DATA3 = &H0 Then write_OTP_FOUT_DATA3_value = get_OTP_FOUT_DATA3

        regValue = leftShift(write_OTP_FOUT_DATA3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA3_mask = mask then
                read_OTP_FOUT_DATA3_value = data_low
            else
                read_OTP_FOUT_DATA3_value = (data_low - H8000_0000) and OTP_FOUT_DATA3_mask
            end If
        else
            read_OTP_FOUT_DATA3_value = data_low and OTP_FOUT_DATA3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA3_value = &H0
        flag_OTP_FOUT_DATA3        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA4                             [31:0]           get_OTP_FOUT_DATA4
''                                                             set_OTP_FOUT_DATA4
''                                                             read_OTP_FOUT_DATA4
''                                                             write_OTP_FOUT_DATA4
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data4
    Private write_OTP_FOUT_DATA4_value
    Private read_OTP_FOUT_DATA4_value
    Private flag_OTP_FOUT_DATA4

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

    Property Get get_OTP_FOUT_DATA4
        get_OTP_FOUT_DATA4 = read_OTP_FOUT_DATA4_value
    End Property

    Property Let set_OTP_FOUT_DATA4(aData)
        write_OTP_FOUT_DATA4_value = aData
        flag_OTP_FOUT_DATA4        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA4
        read
        read_OTP_FOUT_DATA4 = read_OTP_FOUT_DATA4_value
    End Property

    Property Let write_OTP_FOUT_DATA4(aData)
        set_OTP_FOUT_DATA4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA4_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA4_mask = mask then
                read_OTP_FOUT_DATA4_value = data_low
            else
                read_OTP_FOUT_DATA4_value = (data_low - H8000_0000) and OTP_FOUT_DATA4_mask
            end If
        else
            read_OTP_FOUT_DATA4_value = data_low and OTP_FOUT_DATA4_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA4 = &H0 Then read
        If flag_OTP_FOUT_DATA4 = &H0 Then write_OTP_FOUT_DATA4_value = get_OTP_FOUT_DATA4

        regValue = leftShift(write_OTP_FOUT_DATA4_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA4_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA4_mask = mask then
                read_OTP_FOUT_DATA4_value = data_low
            else
                read_OTP_FOUT_DATA4_value = (data_low - H8000_0000) and OTP_FOUT_DATA4_mask
            end If
        else
            read_OTP_FOUT_DATA4_value = data_low and OTP_FOUT_DATA4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA4_value = &H0
        flag_OTP_FOUT_DATA4        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA5                             [31:0]           get_OTP_FOUT_DATA5
''                                                             set_OTP_FOUT_DATA5
''                                                             read_OTP_FOUT_DATA5
''                                                             write_OTP_FOUT_DATA5
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data5
    Private write_OTP_FOUT_DATA5_value
    Private read_OTP_FOUT_DATA5_value
    Private flag_OTP_FOUT_DATA5

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

    Property Get get_OTP_FOUT_DATA5
        get_OTP_FOUT_DATA5 = read_OTP_FOUT_DATA5_value
    End Property

    Property Let set_OTP_FOUT_DATA5(aData)
        write_OTP_FOUT_DATA5_value = aData
        flag_OTP_FOUT_DATA5        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA5
        read
        read_OTP_FOUT_DATA5 = read_OTP_FOUT_DATA5_value
    End Property

    Property Let write_OTP_FOUT_DATA5(aData)
        set_OTP_FOUT_DATA5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA5_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA5_mask = mask then
                read_OTP_FOUT_DATA5_value = data_low
            else
                read_OTP_FOUT_DATA5_value = (data_low - H8000_0000) and OTP_FOUT_DATA5_mask
            end If
        else
            read_OTP_FOUT_DATA5_value = data_low and OTP_FOUT_DATA5_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA5 = &H0 Then read
        If flag_OTP_FOUT_DATA5 = &H0 Then write_OTP_FOUT_DATA5_value = get_OTP_FOUT_DATA5

        regValue = leftShift(write_OTP_FOUT_DATA5_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA5_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA5_mask = mask then
                read_OTP_FOUT_DATA5_value = data_low
            else
                read_OTP_FOUT_DATA5_value = (data_low - H8000_0000) and OTP_FOUT_DATA5_mask
            end If
        else
            read_OTP_FOUT_DATA5_value = data_low and OTP_FOUT_DATA5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA5_value = &H0
        flag_OTP_FOUT_DATA5        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA6                             [31:0]           get_OTP_FOUT_DATA6
''                                                             set_OTP_FOUT_DATA6
''                                                             read_OTP_FOUT_DATA6
''                                                             write_OTP_FOUT_DATA6
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data6
    Private write_OTP_FOUT_DATA6_value
    Private read_OTP_FOUT_DATA6_value
    Private flag_OTP_FOUT_DATA6

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

    Property Get get_OTP_FOUT_DATA6
        get_OTP_FOUT_DATA6 = read_OTP_FOUT_DATA6_value
    End Property

    Property Let set_OTP_FOUT_DATA6(aData)
        write_OTP_FOUT_DATA6_value = aData
        flag_OTP_FOUT_DATA6        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA6
        read
        read_OTP_FOUT_DATA6 = read_OTP_FOUT_DATA6_value
    End Property

    Property Let write_OTP_FOUT_DATA6(aData)
        set_OTP_FOUT_DATA6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA6_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA6_mask = mask then
                read_OTP_FOUT_DATA6_value = data_low
            else
                read_OTP_FOUT_DATA6_value = (data_low - H8000_0000) and OTP_FOUT_DATA6_mask
            end If
        else
            read_OTP_FOUT_DATA6_value = data_low and OTP_FOUT_DATA6_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA6 = &H0 Then read
        If flag_OTP_FOUT_DATA6 = &H0 Then write_OTP_FOUT_DATA6_value = get_OTP_FOUT_DATA6

        regValue = leftShift(write_OTP_FOUT_DATA6_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA6_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA6_mask = mask then
                read_OTP_FOUT_DATA6_value = data_low
            else
                read_OTP_FOUT_DATA6_value = (data_low - H8000_0000) and OTP_FOUT_DATA6_mask
            end If
        else
            read_OTP_FOUT_DATA6_value = data_low and OTP_FOUT_DATA6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA6_value = &H0
        flag_OTP_FOUT_DATA6        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA7                             [31:0]           get_OTP_FOUT_DATA7
''                                                             set_OTP_FOUT_DATA7
''                                                             read_OTP_FOUT_DATA7
''                                                             write_OTP_FOUT_DATA7
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data7
    Private write_OTP_FOUT_DATA7_value
    Private read_OTP_FOUT_DATA7_value
    Private flag_OTP_FOUT_DATA7

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

    Property Get get_OTP_FOUT_DATA7
        get_OTP_FOUT_DATA7 = read_OTP_FOUT_DATA7_value
    End Property

    Property Let set_OTP_FOUT_DATA7(aData)
        write_OTP_FOUT_DATA7_value = aData
        flag_OTP_FOUT_DATA7        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA7
        read
        read_OTP_FOUT_DATA7 = read_OTP_FOUT_DATA7_value
    End Property

    Property Let write_OTP_FOUT_DATA7(aData)
        set_OTP_FOUT_DATA7 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA7_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA7_mask = mask then
                read_OTP_FOUT_DATA7_value = data_low
            else
                read_OTP_FOUT_DATA7_value = (data_low - H8000_0000) and OTP_FOUT_DATA7_mask
            end If
        else
            read_OTP_FOUT_DATA7_value = data_low and OTP_FOUT_DATA7_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA7 = &H0 Then read
        If flag_OTP_FOUT_DATA7 = &H0 Then write_OTP_FOUT_DATA7_value = get_OTP_FOUT_DATA7

        regValue = leftShift(write_OTP_FOUT_DATA7_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA7_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA7_mask = mask then
                read_OTP_FOUT_DATA7_value = data_low
            else
                read_OTP_FOUT_DATA7_value = (data_low - H8000_0000) and OTP_FOUT_DATA7_mask
            end If
        else
            read_OTP_FOUT_DATA7_value = data_low and OTP_FOUT_DATA7_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA7_value = &H0
        flag_OTP_FOUT_DATA7        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA8                             [31:0]           get_OTP_FOUT_DATA8
''                                                             set_OTP_FOUT_DATA8
''                                                             read_OTP_FOUT_DATA8
''                                                             write_OTP_FOUT_DATA8
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data8
    Private write_OTP_FOUT_DATA8_value
    Private read_OTP_FOUT_DATA8_value
    Private flag_OTP_FOUT_DATA8

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

    Property Get get_OTP_FOUT_DATA8
        get_OTP_FOUT_DATA8 = read_OTP_FOUT_DATA8_value
    End Property

    Property Let set_OTP_FOUT_DATA8(aData)
        write_OTP_FOUT_DATA8_value = aData
        flag_OTP_FOUT_DATA8        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA8
        read
        read_OTP_FOUT_DATA8 = read_OTP_FOUT_DATA8_value
    End Property

    Property Let write_OTP_FOUT_DATA8(aData)
        set_OTP_FOUT_DATA8 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA8_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA8_mask = mask then
                read_OTP_FOUT_DATA8_value = data_low
            else
                read_OTP_FOUT_DATA8_value = (data_low - H8000_0000) and OTP_FOUT_DATA8_mask
            end If
        else
            read_OTP_FOUT_DATA8_value = data_low and OTP_FOUT_DATA8_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA8 = &H0 Then read
        If flag_OTP_FOUT_DATA8 = &H0 Then write_OTP_FOUT_DATA8_value = get_OTP_FOUT_DATA8

        regValue = leftShift(write_OTP_FOUT_DATA8_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA8_mask = &Hffffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA8_mask = mask then
                read_OTP_FOUT_DATA8_value = data_low
            else
                read_OTP_FOUT_DATA8_value = (data_low - H8000_0000) and OTP_FOUT_DATA8_mask
            end If
        else
            read_OTP_FOUT_DATA8_value = data_low and OTP_FOUT_DATA8_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA8_value = &H0
        flag_OTP_FOUT_DATA8        = &H0
    End Sub
End Class


'' @REGISTER : OTP_fout_data9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OTP_FOUT_DATA9                             [23:0]           get_OTP_FOUT_DATA9
''                                                             set_OTP_FOUT_DATA9
''                                                             read_OTP_FOUT_DATA9
''                                                             write_OTP_FOUT_DATA9
''---------------------------------------------------------------------------------
Class REGISTER_OTP_fout_data9
    Private write_OTP_FOUT_DATA9_value
    Private read_OTP_FOUT_DATA9_value
    Private flag_OTP_FOUT_DATA9

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

    Property Get get_OTP_FOUT_DATA9
        get_OTP_FOUT_DATA9 = read_OTP_FOUT_DATA9_value
    End Property

    Property Let set_OTP_FOUT_DATA9(aData)
        write_OTP_FOUT_DATA9_value = aData
        flag_OTP_FOUT_DATA9        = &H1
    End Property

    Property Get read_OTP_FOUT_DATA9
        read
        read_OTP_FOUT_DATA9 = read_OTP_FOUT_DATA9_value
    End Property

    Property Let write_OTP_FOUT_DATA9(aData)
        set_OTP_FOUT_DATA9 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA9_mask = &Hffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA9_mask = mask then
                read_OTP_FOUT_DATA9_value = data_low
            else
                read_OTP_FOUT_DATA9_value = (data_low - H8000_0000) and OTP_FOUT_DATA9_mask
            end If
        else
            read_OTP_FOUT_DATA9_value = data_low and OTP_FOUT_DATA9_mask
        end If

    End Sub

    Sub write
        If flag_OTP_FOUT_DATA9 = &H0 Then read
        If flag_OTP_FOUT_DATA9 = &H0 Then write_OTP_FOUT_DATA9_value = get_OTP_FOUT_DATA9

        regValue = leftShift((write_OTP_FOUT_DATA9_value and &Hffffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OTP_FOUT_DATA9_mask = &Hffffff
        if data_low > LONG_MAX then
            if OTP_FOUT_DATA9_mask = mask then
                read_OTP_FOUT_DATA9_value = data_low
            else
                read_OTP_FOUT_DATA9_value = (data_low - H8000_0000) and OTP_FOUT_DATA9_mask
            end If
        else
            read_OTP_FOUT_DATA9_value = data_low and OTP_FOUT_DATA9_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OTP_FOUT_DATA9_value = &H0
        flag_OTP_FOUT_DATA9        = &H0
    End Sub
End Class


'' @REGISTER : OTP_sriov_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sriov_config                               [7:0]            get_sriov_config
''                                                             set_sriov_config
''                                                             read_sriov_config
''                                                             write_sriov_config
''---------------------------------------------------------------------------------
Class REGISTER_OTP_sriov_config
    Private write_sriov_config_value
    Private read_sriov_config_value
    Private flag_sriov_config

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sriov_config
        get_sriov_config = read_sriov_config_value
    End Property

    Property Let set_sriov_config(aData)
        write_sriov_config_value = aData
        flag_sriov_config        = &H1
    End Property

    Property Get read_sriov_config
        read
        read_sriov_config = read_sriov_config_value
    End Property

    Property Let write_sriov_config(aData)
        set_sriov_config = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sriov_config_mask = &Hff
        if data_low > LONG_MAX then
            if sriov_config_mask = mask then
                read_sriov_config_value = data_low
            else
                read_sriov_config_value = (data_low - H8000_0000) and sriov_config_mask
            end If
        else
            read_sriov_config_value = data_low and sriov_config_mask
        end If

    End Sub

    Sub write
        If flag_sriov_config = &H0 Then read
        If flag_sriov_config = &H0 Then write_sriov_config_value = get_sriov_config

        regValue = leftShift((write_sriov_config_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sriov_config_mask = &Hff
        if data_low > LONG_MAX then
            if sriov_config_mask = mask then
                read_sriov_config_value = data_low
            else
                read_sriov_config_value = (data_low - H8000_0000) and sriov_config_mask
            end If
        else
            read_sriov_config_value = data_low and sriov_config_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sriov_config_value = &H0
        flag_sriov_config        = &H0
    End Sub
End Class


'' @REGISTER : OTP_spare_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg1                                 [14:0]           get_spare_reg1
''                                                             set_spare_reg1
''                                                             read_spare_reg1
''                                                             write_spare_reg1
''---------------------------------------------------------------------------------
Class REGISTER_OTP_spare_reg1
    Private write_spare_reg1_value
    Private read_spare_reg1_value
    Private flag_spare_reg1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg1
        get_spare_reg1 = read_spare_reg1_value
    End Property

    Property Let set_spare_reg1(aData)
        write_spare_reg1_value = aData
        flag_spare_reg1        = &H1
    End Property

    Property Get read_spare_reg1
        read
        read_spare_reg1 = read_spare_reg1_value
    End Property

    Property Let write_spare_reg1(aData)
        set_spare_reg1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg1_mask = &H7fff
        if data_low > LONG_MAX then
            if spare_reg1_mask = mask then
                read_spare_reg1_value = data_low
            else
                read_spare_reg1_value = (data_low - H8000_0000) and spare_reg1_mask
            end If
        else
            read_spare_reg1_value = data_low and spare_reg1_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg1 = &H0 Then read
        If flag_spare_reg1 = &H0 Then write_spare_reg1_value = get_spare_reg1

        regValue = leftShift((write_spare_reg1_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg1_mask = &H7fff
        if data_low > LONG_MAX then
            if spare_reg1_mask = mask then
                read_spare_reg1_value = data_low
            else
                read_spare_reg1_value = (data_low - H8000_0000) and spare_reg1_mask
            end If
        else
            read_spare_reg1_value = data_low and spare_reg1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg1_value = &H0
        flag_spare_reg1        = &H0
    End Sub
End Class


'' @REGISTER : OTP_spare_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg2                                 [31:0]           get_spare_reg2
''                                                             set_spare_reg2
''                                                             read_spare_reg2
''                                                             write_spare_reg2
''---------------------------------------------------------------------------------
Class REGISTER_OTP_spare_reg2
    Private write_spare_reg2_value
    Private read_spare_reg2_value
    Private flag_spare_reg2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg2
        get_spare_reg2 = read_spare_reg2_value
    End Property

    Property Let set_spare_reg2(aData)
        write_spare_reg2_value = aData
        flag_spare_reg2        = &H1
    End Property

    Property Get read_spare_reg2
        read
        read_spare_reg2 = read_spare_reg2_value
    End Property

    Property Let write_spare_reg2(aData)
        set_spare_reg2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg2_mask = mask then
                read_spare_reg2_value = data_low
            else
                read_spare_reg2_value = (data_low - H8000_0000) and spare_reg2_mask
            end If
        else
            read_spare_reg2_value = data_low and spare_reg2_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg2 = &H0 Then read
        If flag_spare_reg2 = &H0 Then write_spare_reg2_value = get_spare_reg2

        regValue = leftShift(write_spare_reg2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg2_mask = mask then
                read_spare_reg2_value = data_low
            else
                read_spare_reg2_value = (data_low - H8000_0000) and spare_reg2_mask
            end If
        else
            read_spare_reg2_value = data_low and spare_reg2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg2_value = &H0
        flag_spare_reg2        = &H0
    End Sub
End Class


'' @REGISTER : OTP_spare_reg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_reg3                                 [31:0]           get_spare_reg3
''                                                             set_spare_reg3
''                                                             read_spare_reg3
''                                                             write_spare_reg3
''---------------------------------------------------------------------------------
Class REGISTER_OTP_spare_reg3
    Private write_spare_reg3_value
    Private read_spare_reg3_value
    Private flag_spare_reg3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H68
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_reg3
        get_spare_reg3 = read_spare_reg3_value
    End Property

    Property Let set_spare_reg3(aData)
        write_spare_reg3_value = aData
        flag_spare_reg3        = &H1
    End Property

    Property Get read_spare_reg3
        read
        read_spare_reg3 = read_spare_reg3_value
    End Property

    Property Let write_spare_reg3(aData)
        set_spare_reg3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg3_mask = mask then
                read_spare_reg3_value = data_low
            else
                read_spare_reg3_value = (data_low - H8000_0000) and spare_reg3_mask
            end If
        else
            read_spare_reg3_value = data_low and spare_reg3_mask
        end If

    End Sub

    Sub write
        If flag_spare_reg3 = &H0 Then read
        If flag_spare_reg3 = &H0 Then write_spare_reg3_value = get_spare_reg3

        regValue = leftShift(write_spare_reg3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_reg3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spare_reg3_mask = mask then
                read_spare_reg3_value = data_low
            else
                read_spare_reg3_value = (data_low - H8000_0000) and spare_reg3_mask
            end If
        else
            read_spare_reg3_value = data_low and spare_reg3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_reg3_value = &H0
        flag_spare_reg3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class OTP_INSTANCE

    Public cpu_command
    Public cpu_wrdata
    Public cpu_wrdata_hi
    Public config
    Public address
    Public status
    Public status_2
    Public cpu_rdata
    Public cpu_rdata_hi
    Public bisr_status
    Public ecc_interrupt
    Public ecc_interrupt_en_reg
    Public ecc_interrupt_clr_reg
    Public fout_data0
    Public fout_data1
    Public fout_data2
    Public fout_data3
    Public fout_data4
    Public fout_data5
    Public fout_data6
    Public fout_data7
    Public fout_data8
    Public fout_data9
    Public sriov_config
    Public spare_reg1
    Public spare_reg2
    Public spare_reg3


    Public default function Init(aBaseAddr)
        Set cpu_command = (New REGISTER_OTP_cpu_command)(aBaseAddr, 32)
        Set cpu_wrdata = (New REGISTER_OTP_cpu_wrdata)(aBaseAddr, 32)
        Set cpu_wrdata_hi = (New REGISTER_OTP_cpu_wrdata_hi)(aBaseAddr, 32)
        Set config = (New REGISTER_OTP_config)(aBaseAddr, 32)
        Set address = (New REGISTER_OTP_address)(aBaseAddr, 32)
        Set status = (New REGISTER_OTP_status)(aBaseAddr, 32)
        Set status_2 = (New REGISTER_OTP_status_2)(aBaseAddr, 32)
        Set cpu_rdata = (New REGISTER_OTP_cpu_rdata)(aBaseAddr, 32)
        Set cpu_rdata_hi = (New REGISTER_OTP_cpu_rdata_hi)(aBaseAddr, 32)
        Set bisr_status = (New REGISTER_OTP_bisr_status)(aBaseAddr, 32)
        Set ecc_interrupt = (New REGISTER_OTP_ecc_interrupt)(aBaseAddr, 32)
        Set ecc_interrupt_en_reg = (New REGISTER_OTP_ecc_interrupt_en_reg)(aBaseAddr, 32)
        Set ecc_interrupt_clr_reg = (New REGISTER_OTP_ecc_interrupt_clr_reg)(aBaseAddr, 32)
        Set fout_data0 = (New REGISTER_OTP_fout_data0)(aBaseAddr, 32)
        Set fout_data1 = (New REGISTER_OTP_fout_data1)(aBaseAddr, 32)
        Set fout_data2 = (New REGISTER_OTP_fout_data2)(aBaseAddr, 32)
        Set fout_data3 = (New REGISTER_OTP_fout_data3)(aBaseAddr, 32)
        Set fout_data4 = (New REGISTER_OTP_fout_data4)(aBaseAddr, 32)
        Set fout_data5 = (New REGISTER_OTP_fout_data5)(aBaseAddr, 32)
        Set fout_data6 = (New REGISTER_OTP_fout_data6)(aBaseAddr, 32)
        Set fout_data7 = (New REGISTER_OTP_fout_data7)(aBaseAddr, 32)
        Set fout_data8 = (New REGISTER_OTP_fout_data8)(aBaseAddr, 32)
        Set fout_data9 = (New REGISTER_OTP_fout_data9)(aBaseAddr, 32)
        Set sriov_config = (New REGISTER_OTP_sriov_config)(aBaseAddr, 32)
        Set spare_reg1 = (New REGISTER_OTP_spare_reg1)(aBaseAddr, 32)
        Set spare_reg2 = (New REGISTER_OTP_spare_reg2)(aBaseAddr, 32)
        Set spare_reg3 = (New REGISTER_OTP_spare_reg3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set OTP = CreateObject("System.Collections.ArrayList")
OTP.Add ((New OTP_INSTANCE)(&H4c012000))


