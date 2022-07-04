

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


'' @REGISTER : SPG_spi_grant
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spi_grant                                  [15:0]           get_spi_grant
''                                                             set_spi_grant
''                                                             read_spi_grant
''                                                             write_spi_grant
''---------------------------------------------------------------------------------
Class REGISTER_SPG_spi_grant
    Private write_spi_grant_value
    Private read_spi_grant_value
    Private flag_spi_grant

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

    Property Get get_spi_grant
        get_spi_grant = read_spi_grant_value
    End Property

    Property Let set_spi_grant(aData)
        write_spi_grant_value = aData
        flag_spi_grant        = &H1
    End Property

    Property Get read_spi_grant
        read
        read_spi_grant = read_spi_grant_value
    End Property

    Property Let write_spi_grant(aData)
        set_spi_grant = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spi_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if spi_grant_mask = mask then
                read_spi_grant_value = data_low
            else
                read_spi_grant_value = (data_low - H8000_0000) and spi_grant_mask
            end If
        else
            read_spi_grant_value = data_low and spi_grant_mask
        end If

    End Sub

    Sub write
        If flag_spi_grant = &H0 Then read
        If flag_spi_grant = &H0 Then write_spi_grant_value = get_spi_grant

        regValue = leftShift((write_spi_grant_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spi_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if spi_grant_mask = mask then
                read_spi_grant_value = data_low
            else
                read_spi_grant_value = (data_low - H8000_0000) and spi_grant_mask
            end If
        else
            read_spi_grant_value = data_low and spi_grant_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spi_grant_value = &H0
        flag_spi_grant        = &H0
    End Sub
End Class


'' @REGISTER : SPG_spi_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spi_lock                                   [15:0]           get_spi_lock
''                                                             set_spi_lock
''                                                             read_spi_lock
''                                                             write_spi_lock
''---------------------------------------------------------------------------------
Class REGISTER_SPG_spi_lock
    Private write_spi_lock_value
    Private read_spi_lock_value
    Private flag_spi_lock

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

    Property Get get_spi_lock
        get_spi_lock = read_spi_lock_value
    End Property

    Property Let set_spi_lock(aData)
        write_spi_lock_value = aData
        flag_spi_lock        = &H1
    End Property

    Property Get read_spi_lock
        read
        read_spi_lock = read_spi_lock_value
    End Property

    Property Let write_spi_lock(aData)
        set_spi_lock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spi_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if spi_lock_mask = mask then
                read_spi_lock_value = data_low
            else
                read_spi_lock_value = (data_low - H8000_0000) and spi_lock_mask
            end If
        else
            read_spi_lock_value = data_low and spi_lock_mask
        end If

    End Sub

    Sub write
        If flag_spi_lock = &H0 Then read
        If flag_spi_lock = &H0 Then write_spi_lock_value = get_spi_lock

        regValue = leftShift((write_spi_lock_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spi_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if spi_lock_mask = mask then
                read_spi_lock_value = data_low
            else
                read_spi_lock_value = (data_low - H8000_0000) and spi_lock_mask
            end If
        else
            read_spi_lock_value = data_low and spi_lock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spi_lock_value = &H0
        flag_spi_lock        = &H0
    End Sub
End Class


'' @REGISTER : SPG_mdio_grant
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_grant                                 [15:0]           get_mdio_grant
''                                                             set_mdio_grant
''                                                             read_mdio_grant
''                                                             write_mdio_grant
''---------------------------------------------------------------------------------
Class REGISTER_SPG_mdio_grant
    Private write_mdio_grant_value
    Private read_mdio_grant_value
    Private flag_mdio_grant

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

    Property Get get_mdio_grant
        get_mdio_grant = read_mdio_grant_value
    End Property

    Property Let set_mdio_grant(aData)
        write_mdio_grant_value = aData
        flag_mdio_grant        = &H1
    End Property

    Property Get read_mdio_grant
        read
        read_mdio_grant = read_mdio_grant_value
    End Property

    Property Let write_mdio_grant(aData)
        set_mdio_grant = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_grant_mask = mask then
                read_mdio_grant_value = data_low
            else
                read_mdio_grant_value = (data_low - H8000_0000) and mdio_grant_mask
            end If
        else
            read_mdio_grant_value = data_low and mdio_grant_mask
        end If

    End Sub

    Sub write
        If flag_mdio_grant = &H0 Then read
        If flag_mdio_grant = &H0 Then write_mdio_grant_value = get_mdio_grant

        regValue = leftShift((write_mdio_grant_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_grant_mask = mask then
                read_mdio_grant_value = data_low
            else
                read_mdio_grant_value = (data_low - H8000_0000) and mdio_grant_mask
            end If
        else
            read_mdio_grant_value = data_low and mdio_grant_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_grant_value = &H0
        flag_mdio_grant        = &H0
    End Sub
End Class


'' @REGISTER : SPG_mdio_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_lock                                  [15:0]           get_mdio_lock
''                                                             set_mdio_lock
''                                                             read_mdio_lock
''                                                             write_mdio_lock
''---------------------------------------------------------------------------------
Class REGISTER_SPG_mdio_lock
    Private write_mdio_lock_value
    Private read_mdio_lock_value
    Private flag_mdio_lock

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

    Property Get get_mdio_lock
        get_mdio_lock = read_mdio_lock_value
    End Property

    Property Let set_mdio_lock(aData)
        write_mdio_lock_value = aData
        flag_mdio_lock        = &H1
    End Property

    Property Get read_mdio_lock
        read
        read_mdio_lock = read_mdio_lock_value
    End Property

    Property Let write_mdio_lock(aData)
        set_mdio_lock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_lock_mask = mask then
                read_mdio_lock_value = data_low
            else
                read_mdio_lock_value = (data_low - H8000_0000) and mdio_lock_mask
            end If
        else
            read_mdio_lock_value = data_low and mdio_lock_mask
        end If

    End Sub

    Sub write
        If flag_mdio_lock = &H0 Then read
        If flag_mdio_lock = &H0 Then write_mdio_lock_value = get_mdio_lock

        regValue = leftShift((write_mdio_lock_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_lock_mask = mask then
                read_mdio_lock_value = data_low
            else
                read_mdio_lock_value = (data_low - H8000_0000) and mdio_lock_mask
            end If
        else
            read_mdio_lock_value = data_low and mdio_lock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_lock_value = &H0
        flag_mdio_lock        = &H0
    End Sub
End Class


'' @REGISTER : SPG_jtag_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cpu_jtag_enable                            [0:0]            get_cpu_jtag_enable
''                                                             set_cpu_jtag_enable
''                                                             read_cpu_jtag_enable
''                                                             write_cpu_jtag_enable
''---------------------------------------------------------------------------------
Class REGISTER_SPG_jtag_ctl
    Private write_cpu_jtag_enable_value
    Private read_cpu_jtag_enable_value
    Private flag_cpu_jtag_enable

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

    Property Get get_cpu_jtag_enable
        get_cpu_jtag_enable = read_cpu_jtag_enable_value
    End Property

    Property Let set_cpu_jtag_enable(aData)
        write_cpu_jtag_enable_value = aData
        flag_cpu_jtag_enable        = &H1
    End Property

    Property Get read_cpu_jtag_enable
        read
        read_cpu_jtag_enable = read_cpu_jtag_enable_value
    End Property

    Property Let write_cpu_jtag_enable(aData)
        set_cpu_jtag_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_jtag_enable_mask = &H1
        if data_low > LONG_MAX then
            if cpu_jtag_enable_mask = mask then
                read_cpu_jtag_enable_value = data_low
            else
                read_cpu_jtag_enable_value = (data_low - H8000_0000) and cpu_jtag_enable_mask
            end If
        else
            read_cpu_jtag_enable_value = data_low and cpu_jtag_enable_mask
        end If

    End Sub

    Sub write
        If flag_cpu_jtag_enable = &H0 Then read
        If flag_cpu_jtag_enable = &H0 Then write_cpu_jtag_enable_value = get_cpu_jtag_enable

        regValue = leftShift((write_cpu_jtag_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cpu_jtag_enable_mask = &H1
        if data_low > LONG_MAX then
            if cpu_jtag_enable_mask = mask then
                read_cpu_jtag_enable_value = data_low
            else
                read_cpu_jtag_enable_value = (data_low - H8000_0000) and cpu_jtag_enable_mask
            end If
        else
            read_cpu_jtag_enable_value = data_low and cpu_jtag_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cpu_jtag_enable_value = &H0
        flag_cpu_jtag_enable        = &H0
    End Sub
End Class


'' @REGISTER : SPG_pcie_grant
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcie_grant                                 [15:0]           get_pcie_grant
''                                                             set_pcie_grant
''                                                             read_pcie_grant
''                                                             write_pcie_grant
''---------------------------------------------------------------------------------
Class REGISTER_SPG_pcie_grant
    Private write_pcie_grant_value
    Private read_pcie_grant_value
    Private flag_pcie_grant

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

    Property Get get_pcie_grant
        get_pcie_grant = read_pcie_grant_value
    End Property

    Property Let set_pcie_grant(aData)
        write_pcie_grant_value = aData
        flag_pcie_grant        = &H1
    End Property

    Property Get read_pcie_grant
        read
        read_pcie_grant = read_pcie_grant_value
    End Property

    Property Let write_pcie_grant(aData)
        set_pcie_grant = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcie_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if pcie_grant_mask = mask then
                read_pcie_grant_value = data_low
            else
                read_pcie_grant_value = (data_low - H8000_0000) and pcie_grant_mask
            end If
        else
            read_pcie_grant_value = data_low and pcie_grant_mask
        end If

    End Sub

    Sub write
        If flag_pcie_grant = &H0 Then read
        If flag_pcie_grant = &H0 Then write_pcie_grant_value = get_pcie_grant

        regValue = leftShift((write_pcie_grant_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcie_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if pcie_grant_mask = mask then
                read_pcie_grant_value = data_low
            else
                read_pcie_grant_value = (data_low - H8000_0000) and pcie_grant_mask
            end If
        else
            read_pcie_grant_value = data_low and pcie_grant_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcie_grant_value = &H0
        flag_pcie_grant        = &H0
    End Sub
End Class


'' @REGISTER : SPG_pcie_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcie_lock                                  [15:0]           get_pcie_lock
''                                                             set_pcie_lock
''                                                             read_pcie_lock
''                                                             write_pcie_lock
''---------------------------------------------------------------------------------
Class REGISTER_SPG_pcie_lock
    Private write_pcie_lock_value
    Private read_pcie_lock_value
    Private flag_pcie_lock

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

    Property Get get_pcie_lock
        get_pcie_lock = read_pcie_lock_value
    End Property

    Property Let set_pcie_lock(aData)
        write_pcie_lock_value = aData
        flag_pcie_lock        = &H1
    End Property

    Property Get read_pcie_lock
        read
        read_pcie_lock = read_pcie_lock_value
    End Property

    Property Let write_pcie_lock(aData)
        set_pcie_lock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcie_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if pcie_lock_mask = mask then
                read_pcie_lock_value = data_low
            else
                read_pcie_lock_value = (data_low - H8000_0000) and pcie_lock_mask
            end If
        else
            read_pcie_lock_value = data_low and pcie_lock_mask
        end If

    End Sub

    Sub write
        If flag_pcie_lock = &H0 Then read
        If flag_pcie_lock = &H0 Then write_pcie_lock_value = get_pcie_lock

        regValue = leftShift((write_pcie_lock_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcie_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if pcie_lock_mask = mask then
                read_pcie_lock_value = data_low
            else
                read_pcie_lock_value = (data_low - H8000_0000) and pcie_lock_mask
            end If
        else
            read_pcie_lock_value = data_low and pcie_lock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcie_lock_value = &H0
        flag_pcie_lock        = &H0
    End Sub
End Class


'' @REGISTER : SPG_hsm_ctl_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [31:3]           get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' prod_mode_cfg                              [2:2]            get_prod_mode_cfg
''                                                             set_prod_mode_cfg
''                                                             read_prod_mode_cfg
''                                                             write_prod_mode_cfg
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
Class REGISTER_SPG_hsm_ctl_reg
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_prod_mode_cfg_value
    Private read_prod_mode_cfg_value
    Private flag_prod_mode_cfg
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

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_prod_mode_cfg
        get_prod_mode_cfg = read_prod_mode_cfg_value
    End Property

    Property Let set_prod_mode_cfg(aData)
        write_prod_mode_cfg_value = aData
        flag_prod_mode_cfg        = &H1
    End Property

    Property Get read_prod_mode_cfg
        read
        read_prod_mode_cfg = read_prod_mode_cfg_value
    End Property

    Property Let write_prod_mode_cfg(aData)
        set_prod_mode_cfg = aData
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
        read_spare_value = rightShift(data_low, 3) and &H1fffffff
        read_prod_mode_cfg_value = rightShift(data_low, 2) and &H1
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
        If flag_spare = &H0 or flag_prod_mode_cfg = &H0 or flag_hsm_block_soft_rst = &H0 or flag_m3_core_soft_rst = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_prod_mode_cfg = &H0 Then write_prod_mode_cfg_value = get_prod_mode_cfg
        If flag_hsm_block_soft_rst = &H0 Then write_hsm_block_soft_rst_value = get_hsm_block_soft_rst
        If flag_m3_core_soft_rst = &H0 Then write_m3_core_soft_rst_value = get_m3_core_soft_rst

        regValue = leftShift((write_spare_value and &H1fffffff), 3) + leftShift((write_prod_mode_cfg_value and &H1), 2) + leftShift((write_hsm_block_soft_rst_value and &H1), 1) + leftShift((write_m3_core_soft_rst_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 3) and &H1fffffff
        read_prod_mode_cfg_value = rightShift(data_low, 2) and &H1
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
        write_spare_value = &H0
        flag_spare        = &H0
        write_prod_mode_cfg_value = &H0
        flag_prod_mode_cfg        = &H0
        write_hsm_block_soft_rst_value = &H0
        flag_hsm_block_soft_rst        = &H0
        write_m3_core_soft_rst_value = &H0
        flag_m3_core_soft_rst        = &H0
    End Sub
End Class


'' @REGISTER : SPG_amac_grant
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:15]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' amac_grant                                 [14:0]           get_amac_grant
''                                                             set_amac_grant
''                                                             read_amac_grant
''                                                             write_amac_grant
''---------------------------------------------------------------------------------
Class REGISTER_SPG_amac_grant
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_amac_grant_value
    Private read_amac_grant_value
    Private flag_amac_grant

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

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_amac_grant
        get_amac_grant = read_amac_grant_value
    End Property

    Property Let set_amac_grant(aData)
        write_amac_grant_value = aData
        flag_amac_grant        = &H1
    End Property

    Property Get read_amac_grant
        read
        read_amac_grant = read_amac_grant_value
    End Property

    Property Let write_amac_grant(aData)
        set_amac_grant = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 15) and &H1
        amac_grant_mask = &H7fff
        if data_low > LONG_MAX then
            if amac_grant_mask = mask then
                read_amac_grant_value = data_low
            else
                read_amac_grant_value = (data_low - H8000_0000) and amac_grant_mask
            end If
        else
            read_amac_grant_value = data_low and amac_grant_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_amac_grant = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_amac_grant = &H0 Then write_amac_grant_value = get_amac_grant

        regValue = leftShift((write_spare_value and &H1), 15) + leftShift((write_amac_grant_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 15) and &H1
        amac_grant_mask = &H7fff
        if data_low > LONG_MAX then
            if amac_grant_mask = mask then
                read_amac_grant_value = data_low
            else
                read_amac_grant_value = (data_low - H8000_0000) and amac_grant_mask
            end If
        else
            read_amac_grant_value = data_low and amac_grant_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_amac_grant_value = &H0
        flag_amac_grant        = &H0
    End Sub
End Class


'' @REGISTER : SPG_amac_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:15]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' amac_lock                                  [14:0]           get_amac_lock
''                                                             set_amac_lock
''                                                             read_amac_lock
''                                                             write_amac_lock
''---------------------------------------------------------------------------------
Class REGISTER_SPG_amac_lock
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_amac_lock_value
    Private read_amac_lock_value
    Private flag_amac_lock

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

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_amac_lock
        get_amac_lock = read_amac_lock_value
    End Property

    Property Let set_amac_lock(aData)
        write_amac_lock_value = aData
        flag_amac_lock        = &H1
    End Property

    Property Get read_amac_lock
        read
        read_amac_lock = read_amac_lock_value
    End Property

    Property Let write_amac_lock(aData)
        set_amac_lock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 15) and &H1
        amac_lock_mask = &H7fff
        if data_low > LONG_MAX then
            if amac_lock_mask = mask then
                read_amac_lock_value = data_low
            else
                read_amac_lock_value = (data_low - H8000_0000) and amac_lock_mask
            end If
        else
            read_amac_lock_value = data_low and amac_lock_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_amac_lock = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_amac_lock = &H0 Then write_amac_lock_value = get_amac_lock

        regValue = leftShift((write_spare_value and &H1), 15) + leftShift((write_amac_lock_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 15) and &H1
        amac_lock_mask = &H7fff
        if data_low > LONG_MAX then
            if amac_lock_mask = mask then
                read_amac_lock_value = data_low
            else
                read_amac_lock_value = (data_low - H8000_0000) and amac_lock_mask
            end If
        else
            read_amac_lock_value = data_low and amac_lock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_amac_lock_value = &H0
        flag_amac_lock        = &H0
    End Sub
End Class


'' @REGISTER : SPG_dmac_grant
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmac_grant                                 [15:0]           get_dmac_grant
''                                                             set_dmac_grant
''                                                             read_dmac_grant
''                                                             write_dmac_grant
''---------------------------------------------------------------------------------
Class REGISTER_SPG_dmac_grant
    Private write_dmac_grant_value
    Private read_dmac_grant_value
    Private flag_dmac_grant

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

    Property Get get_dmac_grant
        get_dmac_grant = read_dmac_grant_value
    End Property

    Property Let set_dmac_grant(aData)
        write_dmac_grant_value = aData
        flag_dmac_grant        = &H1
    End Property

    Property Get read_dmac_grant
        read
        read_dmac_grant = read_dmac_grant_value
    End Property

    Property Let write_dmac_grant(aData)
        set_dmac_grant = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dmac_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if dmac_grant_mask = mask then
                read_dmac_grant_value = data_low
            else
                read_dmac_grant_value = (data_low - H8000_0000) and dmac_grant_mask
            end If
        else
            read_dmac_grant_value = data_low and dmac_grant_mask
        end If

    End Sub

    Sub write
        If flag_dmac_grant = &H0 Then read
        If flag_dmac_grant = &H0 Then write_dmac_grant_value = get_dmac_grant

        regValue = leftShift((write_dmac_grant_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dmac_grant_mask = &Hffff
        if data_low > LONG_MAX then
            if dmac_grant_mask = mask then
                read_dmac_grant_value = data_low
            else
                read_dmac_grant_value = (data_low - H8000_0000) and dmac_grant_mask
            end If
        else
            read_dmac_grant_value = data_low and dmac_grant_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmac_grant_value = &H0
        flag_dmac_grant        = &H0
    End Sub
End Class


'' @REGISTER : SPG_dmac_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dmac_lock                                  [15:0]           get_dmac_lock
''                                                             set_dmac_lock
''                                                             read_dmac_lock
''                                                             write_dmac_lock
''---------------------------------------------------------------------------------
Class REGISTER_SPG_dmac_lock
    Private write_dmac_lock_value
    Private read_dmac_lock_value
    Private flag_dmac_lock

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

    Property Get get_dmac_lock
        get_dmac_lock = read_dmac_lock_value
    End Property

    Property Let set_dmac_lock(aData)
        write_dmac_lock_value = aData
        flag_dmac_lock        = &H1
    End Property

    Property Get read_dmac_lock
        read
        read_dmac_lock = read_dmac_lock_value
    End Property

    Property Let write_dmac_lock(aData)
        set_dmac_lock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dmac_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if dmac_lock_mask = mask then
                read_dmac_lock_value = data_low
            else
                read_dmac_lock_value = (data_low - H8000_0000) and dmac_lock_mask
            end If
        else
            read_dmac_lock_value = data_low and dmac_lock_mask
        end If

    End Sub

    Sub write
        If flag_dmac_lock = &H0 Then read
        If flag_dmac_lock = &H0 Then write_dmac_lock_value = get_dmac_lock

        regValue = leftShift((write_dmac_lock_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dmac_lock_mask = &Hffff
        if data_low > LONG_MAX then
            if dmac_lock_mask = mask then
                read_dmac_lock_value = data_low
            else
                read_dmac_lock_value = (data_low - H8000_0000) and dmac_lock_mask
            end If
        else
            read_dmac_lock_value = data_low and dmac_lock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dmac_lock_value = &H0
        flag_dmac_lock        = &H0
    End Sub
End Class


'' @REGISTER : SPG_scratch_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch                                    [31:0]           get_scratch
''                                                             set_scratch
''                                                             read_scratch
''                                                             write_scratch
''---------------------------------------------------------------------------------
Class REGISTER_SPG_scratch_reg
    Private write_scratch_value
    Private read_scratch_value
    Private flag_scratch

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_scratch
        get_scratch = read_scratch_value
    End Property

    Property Let set_scratch(aData)
        write_scratch_value = aData
        flag_scratch        = &H1
    End Property

    Property Get read_scratch
        read
        read_scratch = read_scratch_value
    End Property

    Property Let write_scratch(aData)
        set_scratch = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_mask = mask then
                read_scratch_value = data_low
            else
                read_scratch_value = (data_low - H8000_0000) and scratch_mask
            end If
        else
            read_scratch_value = data_low and scratch_mask
        end If

    End Sub

    Sub write
        If flag_scratch = &H0 Then read
        If flag_scratch = &H0 Then write_scratch_value = get_scratch

        regValue = leftShift(write_scratch_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_mask = mask then
                read_scratch_value = data_low
            else
                read_scratch_value = (data_low - H8000_0000) and scratch_mask
            end If
        else
            read_scratch_value = data_low and scratch_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_value = &H0
        flag_scratch        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SPG_INSTANCE

    Public spi_grant
    Public spi_lock
    Public mdio_grant
    Public mdio_lock
    Public jtag_ctl
    Public pcie_grant
    Public pcie_lock
    Public hsm_ctl_reg
    Public amac_grant
    Public amac_lock
    Public dmac_grant
    Public dmac_lock
    Public scratch_reg


    Public default function Init(aBaseAddr)
        Set spi_grant = (New REGISTER_SPG_spi_grant)(aBaseAddr, 32)
        Set spi_lock = (New REGISTER_SPG_spi_lock)(aBaseAddr, 32)
        Set mdio_grant = (New REGISTER_SPG_mdio_grant)(aBaseAddr, 32)
        Set mdio_lock = (New REGISTER_SPG_mdio_lock)(aBaseAddr, 32)
        Set jtag_ctl = (New REGISTER_SPG_jtag_ctl)(aBaseAddr, 32)
        Set pcie_grant = (New REGISTER_SPG_pcie_grant)(aBaseAddr, 32)
        Set pcie_lock = (New REGISTER_SPG_pcie_lock)(aBaseAddr, 32)
        Set hsm_ctl_reg = (New REGISTER_SPG_hsm_ctl_reg)(aBaseAddr, 32)
        Set amac_grant = (New REGISTER_SPG_amac_grant)(aBaseAddr, 32)
        Set amac_lock = (New REGISTER_SPG_amac_lock)(aBaseAddr, 32)
        Set dmac_grant = (New REGISTER_SPG_dmac_grant)(aBaseAddr, 32)
        Set dmac_lock = (New REGISTER_SPG_dmac_lock)(aBaseAddr, 32)
        Set scratch_reg = (New REGISTER_SPG_scratch_reg)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SPG = CreateObject("System.Collections.ArrayList")
SPG.Add ((New SPG_INSTANCE)(&H4c018000))


