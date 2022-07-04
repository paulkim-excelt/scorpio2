

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


'' @REGISTER : SPI_10T1S_ctrl0_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Addr_val                                   [31:0]           get_Addr_val
''                                                             set_Addr_val
''                                                             read_Addr_val
''                                                             write_Addr_val
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl0_addr
    Private write_Addr_val_value
    Private read_Addr_val_value
    Private flag_Addr_val

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

    Property Get get_Addr_val
        get_Addr_val = read_Addr_val_value
    End Property

    Property Let set_Addr_val(aData)
        write_Addr_val_value = aData
        flag_Addr_val        = &H1
    End Property

    Property Get read_Addr_val
        read
        read_Addr_val = read_Addr_val_value
    End Property

    Property Let write_Addr_val(aData)
        set_Addr_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Addr_val_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Addr_val_mask = mask then
                read_Addr_val_value = data_low
            else
                read_Addr_val_value = (data_low - H8000_0000) and Addr_val_mask
            end If
        else
            read_Addr_val_value = data_low and Addr_val_mask
        end If

    End Sub

    Sub write
        If flag_Addr_val = &H0 Then read
        If flag_Addr_val = &H0 Then write_Addr_val_value = get_Addr_val

        regValue = leftShift(write_Addr_val_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Addr_val_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Addr_val_mask = mask then
                read_Addr_val_value = data_low
            else
                read_Addr_val_value = (data_low - H8000_0000) and Addr_val_mask
            end If
        else
            read_Addr_val_value = data_low and Addr_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Addr_val_value = &H0
        flag_Addr_val        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl1_modebits
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Modebits_val                               [31:0]           get_Modebits_val
''                                                             set_Modebits_val
''                                                             read_Modebits_val
''                                                             write_Modebits_val
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl1_modebits
    Private write_Modebits_val_value
    Private read_Modebits_val_value
    Private flag_Modebits_val

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

    Property Get get_Modebits_val
        get_Modebits_val = read_Modebits_val_value
    End Property

    Property Let set_Modebits_val(aData)
        write_Modebits_val_value = aData
        flag_Modebits_val        = &H1
    End Property

    Property Get read_Modebits_val
        read
        read_Modebits_val = read_Modebits_val_value
    End Property

    Property Let write_Modebits_val(aData)
        set_Modebits_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Modebits_val_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Modebits_val_mask = mask then
                read_Modebits_val_value = data_low
            else
                read_Modebits_val_value = (data_low - H8000_0000) and Modebits_val_mask
            end If
        else
            read_Modebits_val_value = data_low and Modebits_val_mask
        end If

    End Sub

    Sub write
        If flag_Modebits_val = &H0 Then read
        If flag_Modebits_val = &H0 Then write_Modebits_val_value = get_Modebits_val

        regValue = leftShift(write_Modebits_val_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Modebits_val_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Modebits_val_mask = mask then
                read_Modebits_val_value = data_low
            else
                read_Modebits_val_value = (data_low - H8000_0000) and Modebits_val_mask
            end If
        else
            read_Modebits_val_value = data_low and Modebits_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Modebits_val_value = &H0
        flag_Modebits_val        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl2_data_len
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Data_len                                   [31:0]           get_Data_len
''                                                             set_Data_len
''                                                             read_Data_len
''                                                             write_Data_len
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl2_data_len
    Private write_Data_len_value
    Private read_Data_len_value
    Private flag_Data_len

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

    Property Get get_Data_len
        get_Data_len = read_Data_len_value
    End Property

    Property Let set_Data_len(aData)
        write_Data_len_value = aData
        flag_Data_len        = &H1
    End Property

    Property Get read_Data_len
        read
        read_Data_len = read_Data_len_value
    End Property

    Property Let write_Data_len(aData)
        set_Data_len = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Data_len_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Data_len_mask = mask then
                read_Data_len_value = data_low
            else
                read_Data_len_value = (data_low - H8000_0000) and Data_len_mask
            end If
        else
            read_Data_len_value = data_low and Data_len_mask
        end If

    End Sub

    Sub write
        If flag_Data_len = &H0 Then read
        If flag_Data_len = &H0 Then write_Data_len_value = get_Data_len

        regValue = leftShift(write_Data_len_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Data_len_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Data_len_mask = mask then
                read_Data_len_value = data_low
            else
                read_Data_len_value = (data_low - H8000_0000) and Data_len_mask
            end If
        else
            read_Data_len_value = data_low and Data_len_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Data_len_value = &H0
        flag_Data_len        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl3_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Start_spi                                  [31:31]          get_Start_spi
''                                                             set_Start_spi
''                                                             read_Start_spi
''                                                             write_Start_spi
''---------------------------------------------------------------------------------
'' Write_read_n                               [30:30]          get_Write_read_n
''                                                             set_Write_read_n
''                                                             read_Write_read_n
''                                                             write_Write_read_n
''---------------------------------------------------------------------------------
'' Slave_sel                                  [29:28]          get_Slave_sel
''                                                             set_Slave_sel
''                                                             read_Slave_sel
''                                                             write_Slave_sel
''---------------------------------------------------------------------------------
'' Dummy_len                                  [23:20]          get_Dummy_len
''                                                             set_Dummy_len
''                                                             read_Dummy_len
''                                                             write_Dummy_len
''---------------------------------------------------------------------------------
'' Data_mode                                  [19:18]          get_Data_mode
''                                                             set_Data_mode
''                                                             read_Data_mode
''                                                             write_Data_mode
''---------------------------------------------------------------------------------
'' Modebits_len                               [17:16]          get_Modebits_len
''                                                             set_Modebits_len
''                                                             read_Modebits_len
''                                                             write_Modebits_len
''---------------------------------------------------------------------------------
'' Modebits_mode                              [15:14]          get_Modebits_mode
''                                                             set_Modebits_mode
''                                                             read_Modebits_mode
''                                                             write_Modebits_mode
''---------------------------------------------------------------------------------
'' Addr_len                                   [13:12]          get_Addr_len
''                                                             set_Addr_len
''                                                             read_Addr_len
''                                                             write_Addr_len
''---------------------------------------------------------------------------------
'' Addr_mode                                  [11:10]          get_Addr_mode
''                                                             set_Addr_mode
''                                                             read_Addr_mode
''                                                             write_Addr_mode
''---------------------------------------------------------------------------------
'' Opcode_mode                                [9:8]            get_Opcode_mode
''                                                             set_Opcode_mode
''                                                             read_Opcode_mode
''                                                             write_Opcode_mode
''---------------------------------------------------------------------------------
'' Opcode_val                                 [7:0]            get_Opcode_val
''                                                             set_Opcode_val
''                                                             read_Opcode_val
''                                                             write_Opcode_val
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl3_config
    Private write_Start_spi_value
    Private read_Start_spi_value
    Private flag_Start_spi
    Private write_Write_read_n_value
    Private read_Write_read_n_value
    Private flag_Write_read_n
    Private write_Slave_sel_value
    Private read_Slave_sel_value
    Private flag_Slave_sel
    Private write_Dummy_len_value
    Private read_Dummy_len_value
    Private flag_Dummy_len
    Private write_Data_mode_value
    Private read_Data_mode_value
    Private flag_Data_mode
    Private write_Modebits_len_value
    Private read_Modebits_len_value
    Private flag_Modebits_len
    Private write_Modebits_mode_value
    Private read_Modebits_mode_value
    Private flag_Modebits_mode
    Private write_Addr_len_value
    Private read_Addr_len_value
    Private flag_Addr_len
    Private write_Addr_mode_value
    Private read_Addr_mode_value
    Private flag_Addr_mode
    Private write_Opcode_mode_value
    Private read_Opcode_mode_value
    Private flag_Opcode_mode
    Private write_Opcode_val_value
    Private read_Opcode_val_value
    Private flag_Opcode_val

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

    Property Get get_Start_spi
        get_Start_spi = read_Start_spi_value
    End Property

    Property Let set_Start_spi(aData)
        write_Start_spi_value = aData
        flag_Start_spi        = &H1
    End Property

    Property Get read_Start_spi
        read
        read_Start_spi = read_Start_spi_value
    End Property

    Property Let write_Start_spi(aData)
        set_Start_spi = aData
        write
    End Property

    Property Get get_Write_read_n
        get_Write_read_n = read_Write_read_n_value
    End Property

    Property Let set_Write_read_n(aData)
        write_Write_read_n_value = aData
        flag_Write_read_n        = &H1
    End Property

    Property Get read_Write_read_n
        read
        read_Write_read_n = read_Write_read_n_value
    End Property

    Property Let write_Write_read_n(aData)
        set_Write_read_n = aData
        write
    End Property

    Property Get get_Slave_sel
        get_Slave_sel = read_Slave_sel_value
    End Property

    Property Let set_Slave_sel(aData)
        write_Slave_sel_value = aData
        flag_Slave_sel        = &H1
    End Property

    Property Get read_Slave_sel
        read
        read_Slave_sel = read_Slave_sel_value
    End Property

    Property Let write_Slave_sel(aData)
        set_Slave_sel = aData
        write
    End Property

    Property Get get_Dummy_len
        get_Dummy_len = read_Dummy_len_value
    End Property

    Property Let set_Dummy_len(aData)
        write_Dummy_len_value = aData
        flag_Dummy_len        = &H1
    End Property

    Property Get read_Dummy_len
        read
        read_Dummy_len = read_Dummy_len_value
    End Property

    Property Let write_Dummy_len(aData)
        set_Dummy_len = aData
        write
    End Property

    Property Get get_Data_mode
        get_Data_mode = read_Data_mode_value
    End Property

    Property Let set_Data_mode(aData)
        write_Data_mode_value = aData
        flag_Data_mode        = &H1
    End Property

    Property Get read_Data_mode
        read
        read_Data_mode = read_Data_mode_value
    End Property

    Property Let write_Data_mode(aData)
        set_Data_mode = aData
        write
    End Property

    Property Get get_Modebits_len
        get_Modebits_len = read_Modebits_len_value
    End Property

    Property Let set_Modebits_len(aData)
        write_Modebits_len_value = aData
        flag_Modebits_len        = &H1
    End Property

    Property Get read_Modebits_len
        read
        read_Modebits_len = read_Modebits_len_value
    End Property

    Property Let write_Modebits_len(aData)
        set_Modebits_len = aData
        write
    End Property

    Property Get get_Modebits_mode
        get_Modebits_mode = read_Modebits_mode_value
    End Property

    Property Let set_Modebits_mode(aData)
        write_Modebits_mode_value = aData
        flag_Modebits_mode        = &H1
    End Property

    Property Get read_Modebits_mode
        read
        read_Modebits_mode = read_Modebits_mode_value
    End Property

    Property Let write_Modebits_mode(aData)
        set_Modebits_mode = aData
        write
    End Property

    Property Get get_Addr_len
        get_Addr_len = read_Addr_len_value
    End Property

    Property Let set_Addr_len(aData)
        write_Addr_len_value = aData
        flag_Addr_len        = &H1
    End Property

    Property Get read_Addr_len
        read
        read_Addr_len = read_Addr_len_value
    End Property

    Property Let write_Addr_len(aData)
        set_Addr_len = aData
        write
    End Property

    Property Get get_Addr_mode
        get_Addr_mode = read_Addr_mode_value
    End Property

    Property Let set_Addr_mode(aData)
        write_Addr_mode_value = aData
        flag_Addr_mode        = &H1
    End Property

    Property Get read_Addr_mode
        read
        read_Addr_mode = read_Addr_mode_value
    End Property

    Property Let write_Addr_mode(aData)
        set_Addr_mode = aData
        write
    End Property

    Property Get get_Opcode_mode
        get_Opcode_mode = read_Opcode_mode_value
    End Property

    Property Let set_Opcode_mode(aData)
        write_Opcode_mode_value = aData
        flag_Opcode_mode        = &H1
    End Property

    Property Get read_Opcode_mode
        read
        read_Opcode_mode = read_Opcode_mode_value
    End Property

    Property Let write_Opcode_mode(aData)
        set_Opcode_mode = aData
        write
    End Property

    Property Get get_Opcode_val
        get_Opcode_val = read_Opcode_val_value
    End Property

    Property Let set_Opcode_val(aData)
        write_Opcode_val_value = aData
        flag_Opcode_val        = &H1
    End Property

    Property Get read_Opcode_val
        read
        read_Opcode_val = read_Opcode_val_value
    End Property

    Property Let write_Opcode_val(aData)
        set_Opcode_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Start_spi_value = rightShift(data_low, 31) and &H1
        read_Write_read_n_value = rightShift(data_low, 30) and &H1
        read_Slave_sel_value = rightShift(data_low, 28) and &H3
        read_Dummy_len_value = rightShift(data_low, 20) and &Hf
        read_Data_mode_value = rightShift(data_low, 18) and &H3
        read_Modebits_len_value = rightShift(data_low, 16) and &H3
        read_Modebits_mode_value = rightShift(data_low, 14) and &H3
        read_Addr_len_value = rightShift(data_low, 12) and &H3
        read_Addr_mode_value = rightShift(data_low, 10) and &H3
        read_Opcode_mode_value = rightShift(data_low, 8) and &H3
        Opcode_val_mask = &Hff
        if data_low > LONG_MAX then
            if Opcode_val_mask = mask then
                read_Opcode_val_value = data_low
            else
                read_Opcode_val_value = (data_low - H8000_0000) and Opcode_val_mask
            end If
        else
            read_Opcode_val_value = data_low and Opcode_val_mask
        end If

    End Sub

    Sub write
        If flag_Start_spi = &H0 or flag_Write_read_n = &H0 or flag_Slave_sel = &H0 or flag_Dummy_len = &H0 or flag_Data_mode = &H0 or flag_Modebits_len = &H0 or flag_Modebits_mode = &H0 or flag_Addr_len = &H0 or flag_Addr_mode = &H0 or flag_Opcode_mode = &H0 or flag_Opcode_val = &H0 Then read
        If flag_Start_spi = &H0 Then write_Start_spi_value = get_Start_spi
        If flag_Write_read_n = &H0 Then write_Write_read_n_value = get_Write_read_n
        If flag_Slave_sel = &H0 Then write_Slave_sel_value = get_Slave_sel
        If flag_Dummy_len = &H0 Then write_Dummy_len_value = get_Dummy_len
        If flag_Data_mode = &H0 Then write_Data_mode_value = get_Data_mode
        If flag_Modebits_len = &H0 Then write_Modebits_len_value = get_Modebits_len
        If flag_Modebits_mode = &H0 Then write_Modebits_mode_value = get_Modebits_mode
        If flag_Addr_len = &H0 Then write_Addr_len_value = get_Addr_len
        If flag_Addr_mode = &H0 Then write_Addr_mode_value = get_Addr_mode
        If flag_Opcode_mode = &H0 Then write_Opcode_mode_value = get_Opcode_mode
        If flag_Opcode_val = &H0 Then write_Opcode_val_value = get_Opcode_val

        regValue = leftShift((write_Start_spi_value and &H1), 31) + leftShift((write_Write_read_n_value and &H1), 30) + leftShift((write_Slave_sel_value and &H3), 28) + leftShift((write_Dummy_len_value and &Hf), 20) + leftShift((write_Data_mode_value and &H3), 18) + leftShift((write_Modebits_len_value and &H3), 16) + leftShift((write_Modebits_mode_value and &H3), 14) + leftShift((write_Addr_len_value and &H3), 12) + leftShift((write_Addr_mode_value and &H3), 10) + leftShift((write_Opcode_mode_value and &H3), 8) + leftShift((write_Opcode_val_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Start_spi_value = rightShift(data_low, 31) and &H1
        read_Write_read_n_value = rightShift(data_low, 30) and &H1
        read_Slave_sel_value = rightShift(data_low, 28) and &H3
        read_Dummy_len_value = rightShift(data_low, 20) and &Hf
        read_Data_mode_value = rightShift(data_low, 18) and &H3
        read_Modebits_len_value = rightShift(data_low, 16) and &H3
        read_Modebits_mode_value = rightShift(data_low, 14) and &H3
        read_Addr_len_value = rightShift(data_low, 12) and &H3
        read_Addr_mode_value = rightShift(data_low, 10) and &H3
        read_Opcode_mode_value = rightShift(data_low, 8) and &H3
        Opcode_val_mask = &Hff
        if data_low > LONG_MAX then
            if Opcode_val_mask = mask then
                read_Opcode_val_value = data_low
            else
                read_Opcode_val_value = (data_low - H8000_0000) and Opcode_val_mask
            end If
        else
            read_Opcode_val_value = data_low and Opcode_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Start_spi_value = &H0
        flag_Start_spi        = &H0
        write_Write_read_n_value = &H0
        flag_Write_read_n        = &H0
        write_Slave_sel_value = &H0
        flag_Slave_sel        = &H0
        write_Dummy_len_value = &H0
        flag_Dummy_len        = &H0
        write_Data_mode_value = &H0
        flag_Data_mode        = &H0
        write_Modebits_len_value = &H0
        flag_Modebits_len        = &H0
        write_Modebits_mode_value = &H0
        flag_Modebits_mode        = &H0
        write_Addr_len_value = &H0
        flag_Addr_len        = &H0
        write_Addr_mode_value = &H0
        flag_Addr_mode        = &H0
        write_Opcode_mode_value = &H0
        flag_Opcode_mode        = &H0
        write_Opcode_val_value = &H0
        flag_Opcode_val        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl4_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FDX_mode                                   [31:31]          get_FDX_mode
''                                                             set_FDX_mode
''                                                             read_FDX_mode
''                                                             write_FDX_mode
''---------------------------------------------------------------------------------
'' TxDMAEnable                                [30:30]          get_TxDMAEnable
''                                                             set_TxDMAEnable
''                                                             read_TxDMAEnable
''                                                             write_TxDMAEnable
''---------------------------------------------------------------------------------
'' TxFIFOFlush                                [29:29]          get_TxFIFOFlush
''                                                             set_TxFIFOFlush
''                                                             read_TxFIFOFlush
''                                                             write_TxFIFOFlush
''---------------------------------------------------------------------------------
'' TxFIFOThresh                               [28:24]          get_TxFIFOThresh
''                                                             set_TxFIFOThresh
''                                                             read_TxFIFOThresh
''                                                             write_TxFIFOThresh
''---------------------------------------------------------------------------------
'' RxDMAEnable                                [23:23]          get_RxDMAEnable
''                                                             set_RxDMAEnable
''                                                             read_RxDMAEnable
''                                                             write_RxDMAEnable
''---------------------------------------------------------------------------------
'' RxFIFOWordAlign                            [22:22]          get_RxFIFOWordAlign
''                                                             set_RxFIFOWordAlign
''                                                             read_RxFIFOWordAlign
''                                                             write_RxFIFOWordAlign
''---------------------------------------------------------------------------------
'' RxFIFOFlush                                [21:21]          get_RxFIFOFlush
''                                                             set_RxFIFOFlush
''                                                             read_RxFIFOFlush
''                                                             write_RxFIFOFlush
''---------------------------------------------------------------------------------
'' RxFIFOThresh                               [20:16]          get_RxFIFOThresh
''                                                             set_RxFIFOThresh
''                                                             read_RxFIFOThresh
''                                                             write_RxFIFOThresh
''---------------------------------------------------------------------------------
'' Holdoff_len                                [15:12]          get_Holdoff_len
''                                                             set_Holdoff_len
''                                                             read_Holdoff_len
''                                                             write_Holdoff_len
''---------------------------------------------------------------------------------
'' Clock_div                                  [9:4]            get_Clock_div
''                                                             set_Clock_div
''                                                             read_Clock_div
''                                                             write_Clock_div
''---------------------------------------------------------------------------------
'' CPOL_CPHA_ctrl                             [2:1]            get_CPOL_CPHA_ctrl
''                                                             set_CPOL_CPHA_ctrl
''                                                             read_CPOL_CPHA_ctrl
''                                                             write_CPOL_CPHA_ctrl
''---------------------------------------------------------------------------------
'' Spi_enable                                 [0:0]            get_Spi_enable
''                                                             set_Spi_enable
''                                                             read_Spi_enable
''                                                             write_Spi_enable
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl4_config
    Private write_FDX_mode_value
    Private read_FDX_mode_value
    Private flag_FDX_mode
    Private write_TxDMAEnable_value
    Private read_TxDMAEnable_value
    Private flag_TxDMAEnable
    Private write_TxFIFOFlush_value
    Private read_TxFIFOFlush_value
    Private flag_TxFIFOFlush
    Private write_TxFIFOThresh_value
    Private read_TxFIFOThresh_value
    Private flag_TxFIFOThresh
    Private write_RxDMAEnable_value
    Private read_RxDMAEnable_value
    Private flag_RxDMAEnable
    Private write_RxFIFOWordAlign_value
    Private read_RxFIFOWordAlign_value
    Private flag_RxFIFOWordAlign
    Private write_RxFIFOFlush_value
    Private read_RxFIFOFlush_value
    Private flag_RxFIFOFlush
    Private write_RxFIFOThresh_value
    Private read_RxFIFOThresh_value
    Private flag_RxFIFOThresh
    Private write_Holdoff_len_value
    Private read_Holdoff_len_value
    Private flag_Holdoff_len
    Private write_Clock_div_value
    Private read_Clock_div_value
    Private flag_Clock_div
    Private write_CPOL_CPHA_ctrl_value
    Private read_CPOL_CPHA_ctrl_value
    Private flag_CPOL_CPHA_ctrl
    Private write_Spi_enable_value
    Private read_Spi_enable_value
    Private flag_Spi_enable

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

    Property Get get_FDX_mode
        get_FDX_mode = read_FDX_mode_value
    End Property

    Property Let set_FDX_mode(aData)
        write_FDX_mode_value = aData
        flag_FDX_mode        = &H1
    End Property

    Property Get read_FDX_mode
        read
        read_FDX_mode = read_FDX_mode_value
    End Property

    Property Let write_FDX_mode(aData)
        set_FDX_mode = aData
        write
    End Property

    Property Get get_TxDMAEnable
        get_TxDMAEnable = read_TxDMAEnable_value
    End Property

    Property Let set_TxDMAEnable(aData)
        write_TxDMAEnable_value = aData
        flag_TxDMAEnable        = &H1
    End Property

    Property Get read_TxDMAEnable
        read
        read_TxDMAEnable = read_TxDMAEnable_value
    End Property

    Property Let write_TxDMAEnable(aData)
        set_TxDMAEnable = aData
        write
    End Property

    Property Get get_TxFIFOFlush
        get_TxFIFOFlush = read_TxFIFOFlush_value
    End Property

    Property Let set_TxFIFOFlush(aData)
        write_TxFIFOFlush_value = aData
        flag_TxFIFOFlush        = &H1
    End Property

    Property Get read_TxFIFOFlush
        read
        read_TxFIFOFlush = read_TxFIFOFlush_value
    End Property

    Property Let write_TxFIFOFlush(aData)
        set_TxFIFOFlush = aData
        write
    End Property

    Property Get get_TxFIFOThresh
        get_TxFIFOThresh = read_TxFIFOThresh_value
    End Property

    Property Let set_TxFIFOThresh(aData)
        write_TxFIFOThresh_value = aData
        flag_TxFIFOThresh        = &H1
    End Property

    Property Get read_TxFIFOThresh
        read
        read_TxFIFOThresh = read_TxFIFOThresh_value
    End Property

    Property Let write_TxFIFOThresh(aData)
        set_TxFIFOThresh = aData
        write
    End Property

    Property Get get_RxDMAEnable
        get_RxDMAEnable = read_RxDMAEnable_value
    End Property

    Property Let set_RxDMAEnable(aData)
        write_RxDMAEnable_value = aData
        flag_RxDMAEnable        = &H1
    End Property

    Property Get read_RxDMAEnable
        read
        read_RxDMAEnable = read_RxDMAEnable_value
    End Property

    Property Let write_RxDMAEnable(aData)
        set_RxDMAEnable = aData
        write
    End Property

    Property Get get_RxFIFOWordAlign
        get_RxFIFOWordAlign = read_RxFIFOWordAlign_value
    End Property

    Property Let set_RxFIFOWordAlign(aData)
        write_RxFIFOWordAlign_value = aData
        flag_RxFIFOWordAlign        = &H1
    End Property

    Property Get read_RxFIFOWordAlign
        read
        read_RxFIFOWordAlign = read_RxFIFOWordAlign_value
    End Property

    Property Let write_RxFIFOWordAlign(aData)
        set_RxFIFOWordAlign = aData
        write
    End Property

    Property Get get_RxFIFOFlush
        get_RxFIFOFlush = read_RxFIFOFlush_value
    End Property

    Property Let set_RxFIFOFlush(aData)
        write_RxFIFOFlush_value = aData
        flag_RxFIFOFlush        = &H1
    End Property

    Property Get read_RxFIFOFlush
        read
        read_RxFIFOFlush = read_RxFIFOFlush_value
    End Property

    Property Let write_RxFIFOFlush(aData)
        set_RxFIFOFlush = aData
        write
    End Property

    Property Get get_RxFIFOThresh
        get_RxFIFOThresh = read_RxFIFOThresh_value
    End Property

    Property Let set_RxFIFOThresh(aData)
        write_RxFIFOThresh_value = aData
        flag_RxFIFOThresh        = &H1
    End Property

    Property Get read_RxFIFOThresh
        read
        read_RxFIFOThresh = read_RxFIFOThresh_value
    End Property

    Property Let write_RxFIFOThresh(aData)
        set_RxFIFOThresh = aData
        write
    End Property

    Property Get get_Holdoff_len
        get_Holdoff_len = read_Holdoff_len_value
    End Property

    Property Let set_Holdoff_len(aData)
        write_Holdoff_len_value = aData
        flag_Holdoff_len        = &H1
    End Property

    Property Get read_Holdoff_len
        read
        read_Holdoff_len = read_Holdoff_len_value
    End Property

    Property Let write_Holdoff_len(aData)
        set_Holdoff_len = aData
        write
    End Property

    Property Get get_Clock_div
        get_Clock_div = read_Clock_div_value
    End Property

    Property Let set_Clock_div(aData)
        write_Clock_div_value = aData
        flag_Clock_div        = &H1
    End Property

    Property Get read_Clock_div
        read
        read_Clock_div = read_Clock_div_value
    End Property

    Property Let write_Clock_div(aData)
        set_Clock_div = aData
        write
    End Property

    Property Get get_CPOL_CPHA_ctrl
        get_CPOL_CPHA_ctrl = read_CPOL_CPHA_ctrl_value
    End Property

    Property Let set_CPOL_CPHA_ctrl(aData)
        write_CPOL_CPHA_ctrl_value = aData
        flag_CPOL_CPHA_ctrl        = &H1
    End Property

    Property Get read_CPOL_CPHA_ctrl
        read
        read_CPOL_CPHA_ctrl = read_CPOL_CPHA_ctrl_value
    End Property

    Property Let write_CPOL_CPHA_ctrl(aData)
        set_CPOL_CPHA_ctrl = aData
        write
    End Property

    Property Get get_Spi_enable
        get_Spi_enable = read_Spi_enable_value
    End Property

    Property Let set_Spi_enable(aData)
        write_Spi_enable_value = aData
        flag_Spi_enable        = &H1
    End Property

    Property Get read_Spi_enable
        read
        read_Spi_enable = read_Spi_enable_value
    End Property

    Property Let write_Spi_enable(aData)
        set_Spi_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FDX_mode_value = rightShift(data_low, 31) and &H1
        read_TxDMAEnable_value = rightShift(data_low, 30) and &H1
        read_TxFIFOFlush_value = rightShift(data_low, 29) and &H1
        read_TxFIFOThresh_value = rightShift(data_low, 24) and &H1f
        read_RxDMAEnable_value = rightShift(data_low, 23) and &H1
        read_RxFIFOWordAlign_value = rightShift(data_low, 22) and &H1
        read_RxFIFOFlush_value = rightShift(data_low, 21) and &H1
        read_RxFIFOThresh_value = rightShift(data_low, 16) and &H1f
        read_Holdoff_len_value = rightShift(data_low, 12) and &Hf
        read_Clock_div_value = rightShift(data_low, 4) and &H3f
        read_CPOL_CPHA_ctrl_value = rightShift(data_low, 1) and &H3
        Spi_enable_mask = &H1
        if data_low > LONG_MAX then
            if Spi_enable_mask = mask then
                read_Spi_enable_value = data_low
            else
                read_Spi_enable_value = (data_low - H8000_0000) and Spi_enable_mask
            end If
        else
            read_Spi_enable_value = data_low and Spi_enable_mask
        end If

    End Sub

    Sub write
        If flag_FDX_mode = &H0 or flag_TxDMAEnable = &H0 or flag_TxFIFOFlush = &H0 or flag_TxFIFOThresh = &H0 or flag_RxDMAEnable = &H0 or flag_RxFIFOWordAlign = &H0 or flag_RxFIFOFlush = &H0 or flag_RxFIFOThresh = &H0 or flag_Holdoff_len = &H0 or flag_Clock_div = &H0 or flag_CPOL_CPHA_ctrl = &H0 or flag_Spi_enable = &H0 Then read
        If flag_FDX_mode = &H0 Then write_FDX_mode_value = get_FDX_mode
        If flag_TxDMAEnable = &H0 Then write_TxDMAEnable_value = get_TxDMAEnable
        If flag_TxFIFOFlush = &H0 Then write_TxFIFOFlush_value = get_TxFIFOFlush
        If flag_TxFIFOThresh = &H0 Then write_TxFIFOThresh_value = get_TxFIFOThresh
        If flag_RxDMAEnable = &H0 Then write_RxDMAEnable_value = get_RxDMAEnable
        If flag_RxFIFOWordAlign = &H0 Then write_RxFIFOWordAlign_value = get_RxFIFOWordAlign
        If flag_RxFIFOFlush = &H0 Then write_RxFIFOFlush_value = get_RxFIFOFlush
        If flag_RxFIFOThresh = &H0 Then write_RxFIFOThresh_value = get_RxFIFOThresh
        If flag_Holdoff_len = &H0 Then write_Holdoff_len_value = get_Holdoff_len
        If flag_Clock_div = &H0 Then write_Clock_div_value = get_Clock_div
        If flag_CPOL_CPHA_ctrl = &H0 Then write_CPOL_CPHA_ctrl_value = get_CPOL_CPHA_ctrl
        If flag_Spi_enable = &H0 Then write_Spi_enable_value = get_Spi_enable

        regValue = leftShift((write_FDX_mode_value and &H1), 31) + leftShift((write_TxDMAEnable_value and &H1), 30) + leftShift((write_TxFIFOFlush_value and &H1), 29) + leftShift((write_TxFIFOThresh_value and &H1f), 24) + leftShift((write_RxDMAEnable_value and &H1), 23) + leftShift((write_RxFIFOWordAlign_value and &H1), 22) + leftShift((write_RxFIFOFlush_value and &H1), 21) + leftShift((write_RxFIFOThresh_value and &H1f), 16) + leftShift((write_Holdoff_len_value and &Hf), 12) + leftShift((write_Clock_div_value and &H3f), 4) + leftShift((write_CPOL_CPHA_ctrl_value and &H3), 1) + leftShift((write_Spi_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FDX_mode_value = rightShift(data_low, 31) and &H1
        read_TxDMAEnable_value = rightShift(data_low, 30) and &H1
        read_TxFIFOFlush_value = rightShift(data_low, 29) and &H1
        read_TxFIFOThresh_value = rightShift(data_low, 24) and &H1f
        read_RxDMAEnable_value = rightShift(data_low, 23) and &H1
        read_RxFIFOWordAlign_value = rightShift(data_low, 22) and &H1
        read_RxFIFOFlush_value = rightShift(data_low, 21) and &H1
        read_RxFIFOThresh_value = rightShift(data_low, 16) and &H1f
        read_Holdoff_len_value = rightShift(data_low, 12) and &Hf
        read_Clock_div_value = rightShift(data_low, 4) and &H3f
        read_CPOL_CPHA_ctrl_value = rightShift(data_low, 1) and &H3
        Spi_enable_mask = &H1
        if data_low > LONG_MAX then
            if Spi_enable_mask = mask then
                read_Spi_enable_value = data_low
            else
                read_Spi_enable_value = (data_low - H8000_0000) and Spi_enable_mask
            end If
        else
            read_Spi_enable_value = data_low and Spi_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FDX_mode_value = &H0
        flag_FDX_mode        = &H0
        write_TxDMAEnable_value = &H0
        flag_TxDMAEnable        = &H0
        write_TxFIFOFlush_value = &H0
        flag_TxFIFOFlush        = &H0
        write_TxFIFOThresh_value = &H0
        flag_TxFIFOThresh        = &H0
        write_RxDMAEnable_value = &H0
        flag_RxDMAEnable        = &H0
        write_RxFIFOWordAlign_value = &H0
        flag_RxFIFOWordAlign        = &H0
        write_RxFIFOFlush_value = &H0
        flag_RxFIFOFlush        = &H0
        write_RxFIFOThresh_value = &H0
        flag_RxFIFOThresh        = &H0
        write_Holdoff_len_value = &H0
        flag_Holdoff_len        = &H0
        write_Clock_div_value = &H0
        flag_Clock_div        = &H0
        write_CPOL_CPHA_ctrl_value = &H0
        flag_CPOL_CPHA_ctrl        = &H0
        write_Spi_enable_value = &H0
        flag_Spi_enable        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl5_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spi_trans_repeat                           [31:24]          get_spi_trans_repeat
''                                                             set_spi_trans_repeat
''                                                             read_spi_trans_repeat
''                                                             write_spi_trans_repeat
''---------------------------------------------------------------------------------
'' csb_high_len                               [23:16]          get_csb_high_len
''                                                             set_csb_high_len
''                                                             read_csb_high_len
''                                                             write_csb_high_len
''---------------------------------------------------------------------------------
'' Auto_Poll_Selfclear                        [6:6]            get_Auto_Poll_Selfclear
''                                                             set_Auto_Poll_Selfclear
''                                                             read_Auto_Poll_Selfclear
''                                                             write_Auto_Poll_Selfclear
''---------------------------------------------------------------------------------
'' Auto_Poll_Mode                             [5:5]            get_Auto_Poll_Mode
''                                                             set_Auto_Poll_Mode
''                                                             read_Auto_Poll_Mode
''                                                             write_Auto_Poll_Mode
''---------------------------------------------------------------------------------
'' Auto_Poll_Enable                           [4:4]            get_Auto_Poll_Enable
''                                                             set_Auto_Poll_Enable
''                                                             read_Auto_Poll_Enable
''                                                             write_Auto_Poll_Enable
''---------------------------------------------------------------------------------
'' QuadMode_En                                [2:2]            get_QuadMode_En
''                                                             set_QuadMode_En
''                                                             read_QuadMode_En
''                                                             write_QuadMode_En
''---------------------------------------------------------------------------------
'' HOLDn_ctrl                                 [1:1]            get_HOLDn_ctrl
''                                                             set_HOLDn_ctrl
''                                                             read_HOLDn_ctrl
''                                                             write_HOLDn_ctrl
''---------------------------------------------------------------------------------
'' WPn_ctrl                                   [0:0]            get_WPn_ctrl
''                                                             set_WPn_ctrl
''                                                             read_WPn_ctrl
''                                                             write_WPn_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl5_config
    Private write_spi_trans_repeat_value
    Private read_spi_trans_repeat_value
    Private flag_spi_trans_repeat
    Private write_csb_high_len_value
    Private read_csb_high_len_value
    Private flag_csb_high_len
    Private write_Auto_Poll_Selfclear_value
    Private read_Auto_Poll_Selfclear_value
    Private flag_Auto_Poll_Selfclear
    Private write_Auto_Poll_Mode_value
    Private read_Auto_Poll_Mode_value
    Private flag_Auto_Poll_Mode
    Private write_Auto_Poll_Enable_value
    Private read_Auto_Poll_Enable_value
    Private flag_Auto_Poll_Enable
    Private write_QuadMode_En_value
    Private read_QuadMode_En_value
    Private flag_QuadMode_En
    Private write_HOLDn_ctrl_value
    Private read_HOLDn_ctrl_value
    Private flag_HOLDn_ctrl
    Private write_WPn_ctrl_value
    Private read_WPn_ctrl_value
    Private flag_WPn_ctrl

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

    Property Get get_spi_trans_repeat
        get_spi_trans_repeat = read_spi_trans_repeat_value
    End Property

    Property Let set_spi_trans_repeat(aData)
        write_spi_trans_repeat_value = aData
        flag_spi_trans_repeat        = &H1
    End Property

    Property Get read_spi_trans_repeat
        read
        read_spi_trans_repeat = read_spi_trans_repeat_value
    End Property

    Property Let write_spi_trans_repeat(aData)
        set_spi_trans_repeat = aData
        write
    End Property

    Property Get get_csb_high_len
        get_csb_high_len = read_csb_high_len_value
    End Property

    Property Let set_csb_high_len(aData)
        write_csb_high_len_value = aData
        flag_csb_high_len        = &H1
    End Property

    Property Get read_csb_high_len
        read
        read_csb_high_len = read_csb_high_len_value
    End Property

    Property Let write_csb_high_len(aData)
        set_csb_high_len = aData
        write
    End Property

    Property Get get_Auto_Poll_Selfclear
        get_Auto_Poll_Selfclear = read_Auto_Poll_Selfclear_value
    End Property

    Property Let set_Auto_Poll_Selfclear(aData)
        write_Auto_Poll_Selfclear_value = aData
        flag_Auto_Poll_Selfclear        = &H1
    End Property

    Property Get read_Auto_Poll_Selfclear
        read
        read_Auto_Poll_Selfclear = read_Auto_Poll_Selfclear_value
    End Property

    Property Let write_Auto_Poll_Selfclear(aData)
        set_Auto_Poll_Selfclear = aData
        write
    End Property

    Property Get get_Auto_Poll_Mode
        get_Auto_Poll_Mode = read_Auto_Poll_Mode_value
    End Property

    Property Let set_Auto_Poll_Mode(aData)
        write_Auto_Poll_Mode_value = aData
        flag_Auto_Poll_Mode        = &H1
    End Property

    Property Get read_Auto_Poll_Mode
        read
        read_Auto_Poll_Mode = read_Auto_Poll_Mode_value
    End Property

    Property Let write_Auto_Poll_Mode(aData)
        set_Auto_Poll_Mode = aData
        write
    End Property

    Property Get get_Auto_Poll_Enable
        get_Auto_Poll_Enable = read_Auto_Poll_Enable_value
    End Property

    Property Let set_Auto_Poll_Enable(aData)
        write_Auto_Poll_Enable_value = aData
        flag_Auto_Poll_Enable        = &H1
    End Property

    Property Get read_Auto_Poll_Enable
        read
        read_Auto_Poll_Enable = read_Auto_Poll_Enable_value
    End Property

    Property Let write_Auto_Poll_Enable(aData)
        set_Auto_Poll_Enable = aData
        write
    End Property

    Property Get get_QuadMode_En
        get_QuadMode_En = read_QuadMode_En_value
    End Property

    Property Let set_QuadMode_En(aData)
        write_QuadMode_En_value = aData
        flag_QuadMode_En        = &H1
    End Property

    Property Get read_QuadMode_En
        read
        read_QuadMode_En = read_QuadMode_En_value
    End Property

    Property Let write_QuadMode_En(aData)
        set_QuadMode_En = aData
        write
    End Property

    Property Get get_HOLDn_ctrl
        get_HOLDn_ctrl = read_HOLDn_ctrl_value
    End Property

    Property Let set_HOLDn_ctrl(aData)
        write_HOLDn_ctrl_value = aData
        flag_HOLDn_ctrl        = &H1
    End Property

    Property Get read_HOLDn_ctrl
        read
        read_HOLDn_ctrl = read_HOLDn_ctrl_value
    End Property

    Property Let write_HOLDn_ctrl(aData)
        set_HOLDn_ctrl = aData
        write
    End Property

    Property Get get_WPn_ctrl
        get_WPn_ctrl = read_WPn_ctrl_value
    End Property

    Property Let set_WPn_ctrl(aData)
        write_WPn_ctrl_value = aData
        flag_WPn_ctrl        = &H1
    End Property

    Property Get read_WPn_ctrl
        read
        read_WPn_ctrl = read_WPn_ctrl_value
    End Property

    Property Let write_WPn_ctrl(aData)
        set_WPn_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spi_trans_repeat_value = rightShift(data_low, 24) and &Hff
        read_csb_high_len_value = rightShift(data_low, 16) and &Hff
        read_Auto_Poll_Selfclear_value = rightShift(data_low, 6) and &H1
        read_Auto_Poll_Mode_value = rightShift(data_low, 5) and &H1
        read_Auto_Poll_Enable_value = rightShift(data_low, 4) and &H1
        read_QuadMode_En_value = rightShift(data_low, 2) and &H1
        read_HOLDn_ctrl_value = rightShift(data_low, 1) and &H1
        WPn_ctrl_mask = &H1
        if data_low > LONG_MAX then
            if WPn_ctrl_mask = mask then
                read_WPn_ctrl_value = data_low
            else
                read_WPn_ctrl_value = (data_low - H8000_0000) and WPn_ctrl_mask
            end If
        else
            read_WPn_ctrl_value = data_low and WPn_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_spi_trans_repeat = &H0 or flag_csb_high_len = &H0 or flag_Auto_Poll_Selfclear = &H0 or flag_Auto_Poll_Mode = &H0 or flag_Auto_Poll_Enable = &H0 or flag_QuadMode_En = &H0 or flag_HOLDn_ctrl = &H0 or flag_WPn_ctrl = &H0 Then read
        If flag_spi_trans_repeat = &H0 Then write_spi_trans_repeat_value = get_spi_trans_repeat
        If flag_csb_high_len = &H0 Then write_csb_high_len_value = get_csb_high_len
        If flag_Auto_Poll_Selfclear = &H0 Then write_Auto_Poll_Selfclear_value = get_Auto_Poll_Selfclear
        If flag_Auto_Poll_Mode = &H0 Then write_Auto_Poll_Mode_value = get_Auto_Poll_Mode
        If flag_Auto_Poll_Enable = &H0 Then write_Auto_Poll_Enable_value = get_Auto_Poll_Enable
        If flag_QuadMode_En = &H0 Then write_QuadMode_En_value = get_QuadMode_En
        If flag_HOLDn_ctrl = &H0 Then write_HOLDn_ctrl_value = get_HOLDn_ctrl
        If flag_WPn_ctrl = &H0 Then write_WPn_ctrl_value = get_WPn_ctrl

        regValue = leftShift((write_spi_trans_repeat_value and &Hff), 24) + leftShift((write_csb_high_len_value and &Hff), 16) + leftShift((write_Auto_Poll_Selfclear_value and &H1), 6) + leftShift((write_Auto_Poll_Mode_value and &H1), 5) + leftShift((write_Auto_Poll_Enable_value and &H1), 4) + leftShift((write_QuadMode_En_value and &H1), 2) + leftShift((write_HOLDn_ctrl_value and &H1), 1) + leftShift((write_WPn_ctrl_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spi_trans_repeat_value = rightShift(data_low, 24) and &Hff
        read_csb_high_len_value = rightShift(data_low, 16) and &Hff
        read_Auto_Poll_Selfclear_value = rightShift(data_low, 6) and &H1
        read_Auto_Poll_Mode_value = rightShift(data_low, 5) and &H1
        read_Auto_Poll_Enable_value = rightShift(data_low, 4) and &H1
        read_QuadMode_En_value = rightShift(data_low, 2) and &H1
        read_HOLDn_ctrl_value = rightShift(data_low, 1) and &H1
        WPn_ctrl_mask = &H1
        if data_low > LONG_MAX then
            if WPn_ctrl_mask = mask then
                read_WPn_ctrl_value = data_low
            else
                read_WPn_ctrl_value = (data_low - H8000_0000) and WPn_ctrl_mask
            end If
        else
            read_WPn_ctrl_value = data_low and WPn_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spi_trans_repeat_value = &H0
        flag_spi_trans_repeat        = &H0
        write_csb_high_len_value = &H0
        flag_csb_high_len        = &H0
        write_Auto_Poll_Selfclear_value = &H0
        flag_Auto_Poll_Selfclear        = &H0
        write_Auto_Poll_Mode_value = &H0
        flag_Auto_Poll_Mode        = &H0
        write_Auto_Poll_Enable_value = &H0
        flag_Auto_Poll_Enable        = &H0
        write_QuadMode_En_value = &H0
        flag_QuadMode_En        = &H0
        write_HOLDn_ctrl_value = &H0
        flag_HOLDn_ctrl        = &H0
        write_WPn_ctrl_value = &H0
        flag_WPn_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl6_autopollexp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Auto_poll_Exp                              [31:0]           get_Auto_poll_Exp
''                                                             set_Auto_poll_Exp
''                                                             read_Auto_poll_Exp
''                                                             write_Auto_poll_Exp
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl6_autopollexp
    Private write_Auto_poll_Exp_value
    Private read_Auto_poll_Exp_value
    Private flag_Auto_poll_Exp

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

    Property Get get_Auto_poll_Exp
        get_Auto_poll_Exp = read_Auto_poll_Exp_value
    End Property

    Property Let set_Auto_poll_Exp(aData)
        write_Auto_poll_Exp_value = aData
        flag_Auto_poll_Exp        = &H1
    End Property

    Property Get read_Auto_poll_Exp
        read
        read_Auto_poll_Exp = read_Auto_poll_Exp_value
    End Property

    Property Let write_Auto_poll_Exp(aData)
        set_Auto_poll_Exp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Auto_poll_Exp_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Auto_poll_Exp_mask = mask then
                read_Auto_poll_Exp_value = data_low
            else
                read_Auto_poll_Exp_value = (data_low - H8000_0000) and Auto_poll_Exp_mask
            end If
        else
            read_Auto_poll_Exp_value = data_low and Auto_poll_Exp_mask
        end If

    End Sub

    Sub write
        If flag_Auto_poll_Exp = &H0 Then read
        If flag_Auto_poll_Exp = &H0 Then write_Auto_poll_Exp_value = get_Auto_poll_Exp

        regValue = leftShift(write_Auto_poll_Exp_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Auto_poll_Exp_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Auto_poll_Exp_mask = mask then
                read_Auto_poll_Exp_value = data_low
            else
                read_Auto_poll_Exp_value = (data_low - H8000_0000) and Auto_poll_Exp_mask
            end If
        else
            read_Auto_poll_Exp_value = data_low and Auto_poll_Exp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Auto_poll_Exp_value = &H0
        flag_Auto_poll_Exp        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_ctrl7_autopollmask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Auto_poll_Mask                             [31:0]           get_Auto_poll_Mask
''                                                             set_Auto_poll_Mask
''                                                             read_Auto_poll_Mask
''                                                             write_Auto_poll_Mask
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_ctrl7_autopollmask
    Private write_Auto_poll_Mask_value
    Private read_Auto_poll_Mask_value
    Private flag_Auto_poll_Mask

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

    Property Get get_Auto_poll_Mask
        get_Auto_poll_Mask = read_Auto_poll_Mask_value
    End Property

    Property Let set_Auto_poll_Mask(aData)
        write_Auto_poll_Mask_value = aData
        flag_Auto_poll_Mask        = &H1
    End Property

    Property Get read_Auto_poll_Mask
        read
        read_Auto_poll_Mask = read_Auto_poll_Mask_value
    End Property

    Property Let write_Auto_poll_Mask(aData)
        set_Auto_poll_Mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Auto_poll_Mask_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Auto_poll_Mask_mask = mask then
                read_Auto_poll_Mask_value = data_low
            else
                read_Auto_poll_Mask_value = (data_low - H8000_0000) and Auto_poll_Mask_mask
            end If
        else
            read_Auto_poll_Mask_value = data_low and Auto_poll_Mask_mask
        end If

    End Sub

    Sub write
        If flag_Auto_poll_Mask = &H0 Then read
        If flag_Auto_poll_Mask = &H0 Then write_Auto_poll_Mask_value = get_Auto_poll_Mask

        regValue = leftShift(write_Auto_poll_Mask_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Auto_poll_Mask_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Auto_poll_Mask_mask = mask then
                read_Auto_poll_Mask_value = data_low
            else
                read_Auto_poll_Mask_value = (data_low - H8000_0000) and Auto_poll_Mask_mask
            end If
        else
            read_Auto_poll_Mask_value = data_low and Auto_poll_Mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Auto_poll_Mask_value = &H0
        flag_Auto_poll_Mask        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TxFIFOUnderflowStat                        [24:24]          get_TxFIFOUnderflowStat
''                                                             set_TxFIFOUnderflowStat
''                                                             read_TxFIFOUnderflowStat
''                                                             write_TxFIFOUnderflowStat
''---------------------------------------------------------------------------------
'' TxFIFOThreshStat                           [23:23]          get_TxFIFOThreshStat
''                                                             set_TxFIFOThreshStat
''                                                             read_TxFIFOThreshStat
''                                                             write_TxFIFOThreshStat
''---------------------------------------------------------------------------------
'' TxFIFOEmpty                                [22:22]          get_TxFIFOEmpty
''                                                             set_TxFIFOEmpty
''                                                             read_TxFIFOEmpty
''                                                             write_TxFIFOEmpty
''---------------------------------------------------------------------------------
'' TxFIFOFullnessStat                         [21:16]          get_TxFIFOFullnessStat
''                                                             set_TxFIFOFullnessStat
''                                                             read_TxFIFOFullnessStat
''                                                             write_TxFIFOFullnessStat
''---------------------------------------------------------------------------------
'' RxFIFOOverflowStat                         [12:12]          get_RxFIFOOverflowStat
''                                                             set_RxFIFOOverflowStat
''                                                             read_RxFIFOOverflowStat
''                                                             write_RxFIFOOverflowStat
''---------------------------------------------------------------------------------
'' RxFIFOThreshStat                           [11:11]          get_RxFIFOThreshStat
''                                                             set_RxFIFOThreshStat
''                                                             read_RxFIFOThreshStat
''                                                             write_RxFIFOThreshStat
''---------------------------------------------------------------------------------
'' RxFIFOEmpty                                [10:10]          get_RxFIFOEmpty
''                                                             set_RxFIFOEmpty
''                                                             read_RxFIFOEmpty
''                                                             write_RxFIFOEmpty
''---------------------------------------------------------------------------------
'' RxFIFOFullnessStat                         [9:4]            get_RxFIFOFullnessStat
''                                                             set_RxFIFOFullnessStat
''                                                             read_RxFIFOFullnessStat
''                                                             write_RxFIFOFullnessStat
''---------------------------------------------------------------------------------
'' Busy                                       [0:0]            get_Busy
''                                                             set_Busy
''                                                             read_Busy
''                                                             write_Busy
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_stat
    Private write_TxFIFOUnderflowStat_value
    Private read_TxFIFOUnderflowStat_value
    Private flag_TxFIFOUnderflowStat
    Private write_TxFIFOThreshStat_value
    Private read_TxFIFOThreshStat_value
    Private flag_TxFIFOThreshStat
    Private write_TxFIFOEmpty_value
    Private read_TxFIFOEmpty_value
    Private flag_TxFIFOEmpty
    Private write_TxFIFOFullnessStat_value
    Private read_TxFIFOFullnessStat_value
    Private flag_TxFIFOFullnessStat
    Private write_RxFIFOOverflowStat_value
    Private read_RxFIFOOverflowStat_value
    Private flag_RxFIFOOverflowStat
    Private write_RxFIFOThreshStat_value
    Private read_RxFIFOThreshStat_value
    Private flag_RxFIFOThreshStat
    Private write_RxFIFOEmpty_value
    Private read_RxFIFOEmpty_value
    Private flag_RxFIFOEmpty
    Private write_RxFIFOFullnessStat_value
    Private read_RxFIFOFullnessStat_value
    Private flag_RxFIFOFullnessStat
    Private write_Busy_value
    Private read_Busy_value
    Private flag_Busy

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

    Property Get get_TxFIFOUnderflowStat
        get_TxFIFOUnderflowStat = read_TxFIFOUnderflowStat_value
    End Property

    Property Let set_TxFIFOUnderflowStat(aData)
        write_TxFIFOUnderflowStat_value = aData
        flag_TxFIFOUnderflowStat        = &H1
    End Property

    Property Get read_TxFIFOUnderflowStat
        read
        read_TxFIFOUnderflowStat = read_TxFIFOUnderflowStat_value
    End Property

    Property Let write_TxFIFOUnderflowStat(aData)
        set_TxFIFOUnderflowStat = aData
        write
    End Property

    Property Get get_TxFIFOThreshStat
        get_TxFIFOThreshStat = read_TxFIFOThreshStat_value
    End Property

    Property Let set_TxFIFOThreshStat(aData)
        write_TxFIFOThreshStat_value = aData
        flag_TxFIFOThreshStat        = &H1
    End Property

    Property Get read_TxFIFOThreshStat
        read
        read_TxFIFOThreshStat = read_TxFIFOThreshStat_value
    End Property

    Property Let write_TxFIFOThreshStat(aData)
        set_TxFIFOThreshStat = aData
        write
    End Property

    Property Get get_TxFIFOEmpty
        get_TxFIFOEmpty = read_TxFIFOEmpty_value
    End Property

    Property Let set_TxFIFOEmpty(aData)
        write_TxFIFOEmpty_value = aData
        flag_TxFIFOEmpty        = &H1
    End Property

    Property Get read_TxFIFOEmpty
        read
        read_TxFIFOEmpty = read_TxFIFOEmpty_value
    End Property

    Property Let write_TxFIFOEmpty(aData)
        set_TxFIFOEmpty = aData
        write
    End Property

    Property Get get_TxFIFOFullnessStat
        get_TxFIFOFullnessStat = read_TxFIFOFullnessStat_value
    End Property

    Property Let set_TxFIFOFullnessStat(aData)
        write_TxFIFOFullnessStat_value = aData
        flag_TxFIFOFullnessStat        = &H1
    End Property

    Property Get read_TxFIFOFullnessStat
        read
        read_TxFIFOFullnessStat = read_TxFIFOFullnessStat_value
    End Property

    Property Let write_TxFIFOFullnessStat(aData)
        set_TxFIFOFullnessStat = aData
        write
    End Property

    Property Get get_RxFIFOOverflowStat
        get_RxFIFOOverflowStat = read_RxFIFOOverflowStat_value
    End Property

    Property Let set_RxFIFOOverflowStat(aData)
        write_RxFIFOOverflowStat_value = aData
        flag_RxFIFOOverflowStat        = &H1
    End Property

    Property Get read_RxFIFOOverflowStat
        read
        read_RxFIFOOverflowStat = read_RxFIFOOverflowStat_value
    End Property

    Property Let write_RxFIFOOverflowStat(aData)
        set_RxFIFOOverflowStat = aData
        write
    End Property

    Property Get get_RxFIFOThreshStat
        get_RxFIFOThreshStat = read_RxFIFOThreshStat_value
    End Property

    Property Let set_RxFIFOThreshStat(aData)
        write_RxFIFOThreshStat_value = aData
        flag_RxFIFOThreshStat        = &H1
    End Property

    Property Get read_RxFIFOThreshStat
        read
        read_RxFIFOThreshStat = read_RxFIFOThreshStat_value
    End Property

    Property Let write_RxFIFOThreshStat(aData)
        set_RxFIFOThreshStat = aData
        write
    End Property

    Property Get get_RxFIFOEmpty
        get_RxFIFOEmpty = read_RxFIFOEmpty_value
    End Property

    Property Let set_RxFIFOEmpty(aData)
        write_RxFIFOEmpty_value = aData
        flag_RxFIFOEmpty        = &H1
    End Property

    Property Get read_RxFIFOEmpty
        read
        read_RxFIFOEmpty = read_RxFIFOEmpty_value
    End Property

    Property Let write_RxFIFOEmpty(aData)
        set_RxFIFOEmpty = aData
        write
    End Property

    Property Get get_RxFIFOFullnessStat
        get_RxFIFOFullnessStat = read_RxFIFOFullnessStat_value
    End Property

    Property Let set_RxFIFOFullnessStat(aData)
        write_RxFIFOFullnessStat_value = aData
        flag_RxFIFOFullnessStat        = &H1
    End Property

    Property Get read_RxFIFOFullnessStat
        read
        read_RxFIFOFullnessStat = read_RxFIFOFullnessStat_value
    End Property

    Property Let write_RxFIFOFullnessStat(aData)
        set_RxFIFOFullnessStat = aData
        write
    End Property

    Property Get get_Busy
        get_Busy = read_Busy_value
    End Property

    Property Let set_Busy(aData)
        write_Busy_value = aData
        flag_Busy        = &H1
    End Property

    Property Get read_Busy
        read
        read_Busy = read_Busy_value
    End Property

    Property Let write_Busy(aData)
        set_Busy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TxFIFOUnderflowStat_value = rightShift(data_low, 24) and &H1
        read_TxFIFOThreshStat_value = rightShift(data_low, 23) and &H1
        read_TxFIFOEmpty_value = rightShift(data_low, 22) and &H1
        read_TxFIFOFullnessStat_value = rightShift(data_low, 16) and &H3f
        read_RxFIFOOverflowStat_value = rightShift(data_low, 12) and &H1
        read_RxFIFOThreshStat_value = rightShift(data_low, 11) and &H1
        read_RxFIFOEmpty_value = rightShift(data_low, 10) and &H1
        read_RxFIFOFullnessStat_value = rightShift(data_low, 4) and &H3f
        Busy_mask = &H1
        if data_low > LONG_MAX then
            if Busy_mask = mask then
                read_Busy_value = data_low
            else
                read_Busy_value = (data_low - H8000_0000) and Busy_mask
            end If
        else
            read_Busy_value = data_low and Busy_mask
        end If

    End Sub

    Sub write
        If flag_TxFIFOUnderflowStat = &H0 or flag_TxFIFOThreshStat = &H0 or flag_TxFIFOEmpty = &H0 or flag_TxFIFOFullnessStat = &H0 or flag_RxFIFOOverflowStat = &H0 or flag_RxFIFOThreshStat = &H0 or flag_RxFIFOEmpty = &H0 or flag_RxFIFOFullnessStat = &H0 or flag_Busy = &H0 Then read
        If flag_TxFIFOUnderflowStat = &H0 Then write_TxFIFOUnderflowStat_value = get_TxFIFOUnderflowStat
        If flag_TxFIFOThreshStat = &H0 Then write_TxFIFOThreshStat_value = get_TxFIFOThreshStat
        If flag_TxFIFOEmpty = &H0 Then write_TxFIFOEmpty_value = get_TxFIFOEmpty
        If flag_TxFIFOFullnessStat = &H0 Then write_TxFIFOFullnessStat_value = get_TxFIFOFullnessStat
        If flag_RxFIFOOverflowStat = &H0 Then write_RxFIFOOverflowStat_value = get_RxFIFOOverflowStat
        If flag_RxFIFOThreshStat = &H0 Then write_RxFIFOThreshStat_value = get_RxFIFOThreshStat
        If flag_RxFIFOEmpty = &H0 Then write_RxFIFOEmpty_value = get_RxFIFOEmpty
        If flag_RxFIFOFullnessStat = &H0 Then write_RxFIFOFullnessStat_value = get_RxFIFOFullnessStat
        If flag_Busy = &H0 Then write_Busy_value = get_Busy

        regValue = leftShift((write_TxFIFOUnderflowStat_value and &H1), 24) + leftShift((write_TxFIFOThreshStat_value and &H1), 23) + leftShift((write_TxFIFOEmpty_value and &H1), 22) + leftShift((write_TxFIFOFullnessStat_value and &H3f), 16) + leftShift((write_RxFIFOOverflowStat_value and &H1), 12) + leftShift((write_RxFIFOThreshStat_value and &H1), 11) + leftShift((write_RxFIFOEmpty_value and &H1), 10) + leftShift((write_RxFIFOFullnessStat_value and &H3f), 4) + leftShift((write_Busy_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TxFIFOUnderflowStat_value = rightShift(data_low, 24) and &H1
        read_TxFIFOThreshStat_value = rightShift(data_low, 23) and &H1
        read_TxFIFOEmpty_value = rightShift(data_low, 22) and &H1
        read_TxFIFOFullnessStat_value = rightShift(data_low, 16) and &H3f
        read_RxFIFOOverflowStat_value = rightShift(data_low, 12) and &H1
        read_RxFIFOThreshStat_value = rightShift(data_low, 11) and &H1
        read_RxFIFOEmpty_value = rightShift(data_low, 10) and &H1
        read_RxFIFOFullnessStat_value = rightShift(data_low, 4) and &H3f
        Busy_mask = &H1
        if data_low > LONG_MAX then
            if Busy_mask = mask then
                read_Busy_value = data_low
            else
                read_Busy_value = (data_low - H8000_0000) and Busy_mask
            end If
        else
            read_Busy_value = data_low and Busy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TxFIFOUnderflowStat_value = &H0
        flag_TxFIFOUnderflowStat        = &H0
        write_TxFIFOThreshStat_value = &H0
        flag_TxFIFOThreshStat        = &H0
        write_TxFIFOEmpty_value = &H0
        flag_TxFIFOEmpty        = &H0
        write_TxFIFOFullnessStat_value = &H0
        flag_TxFIFOFullnessStat        = &H0
        write_RxFIFOOverflowStat_value = &H0
        flag_RxFIFOOverflowStat        = &H0
        write_RxFIFOThreshStat_value = &H0
        flag_RxFIFOThreshStat        = &H0
        write_RxFIFOEmpty_value = &H0
        flag_RxFIFOEmpty        = &H0
        write_RxFIFOFullnessStat_value = &H0
        flag_RxFIFOFullnessStat        = &H0
        write_Busy_value = &H0
        flag_Busy        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_int
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DoneInt                                    [13:13]          get_DoneInt
''                                                             set_DoneInt
''                                                             read_DoneInt
''                                                             write_DoneInt
''---------------------------------------------------------------------------------
'' AutoPollInt                                [12:12]          get_AutoPollInt
''                                                             set_AutoPollInt
''                                                             read_AutoPollInt
''                                                             write_AutoPollInt
''---------------------------------------------------------------------------------
'' TxUnderflowInt                             [11:11]          get_TxUnderflowInt
''                                                             set_TxUnderflowInt
''                                                             read_TxUnderflowInt
''                                                             write_TxUnderflowInt
''---------------------------------------------------------------------------------
'' TxFullInt                                  [10:10]          get_TxFullInt
''                                                             set_TxFullInt
''                                                             read_TxFullInt
''                                                             write_TxFullInt
''---------------------------------------------------------------------------------
'' TxThreshInt                                [9:9]            get_TxThreshInt
''                                                             set_TxThreshInt
''                                                             read_TxThreshInt
''                                                             write_TxThreshInt
''---------------------------------------------------------------------------------
'' TxEmptyInt                                 [8:8]            get_TxEmptyInt
''                                                             set_TxEmptyInt
''                                                             read_TxEmptyInt
''                                                             write_TxEmptyInt
''---------------------------------------------------------------------------------
'' RxOverflowInt                              [3:3]            get_RxOverflowInt
''                                                             set_RxOverflowInt
''                                                             read_RxOverflowInt
''                                                             write_RxOverflowInt
''---------------------------------------------------------------------------------
'' RxFullInt                                  [2:2]            get_RxFullInt
''                                                             set_RxFullInt
''                                                             read_RxFullInt
''                                                             write_RxFullInt
''---------------------------------------------------------------------------------
'' RxThreshInt                                [1:1]            get_RxThreshInt
''                                                             set_RxThreshInt
''                                                             read_RxThreshInt
''                                                             write_RxThreshInt
''---------------------------------------------------------------------------------
'' RxEmptyInt                                 [0:0]            get_RxEmptyInt
''                                                             set_RxEmptyInt
''                                                             read_RxEmptyInt
''                                                             write_RxEmptyInt
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_int
    Private write_DoneInt_value
    Private read_DoneInt_value
    Private flag_DoneInt
    Private write_AutoPollInt_value
    Private read_AutoPollInt_value
    Private flag_AutoPollInt
    Private write_TxUnderflowInt_value
    Private read_TxUnderflowInt_value
    Private flag_TxUnderflowInt
    Private write_TxFullInt_value
    Private read_TxFullInt_value
    Private flag_TxFullInt
    Private write_TxThreshInt_value
    Private read_TxThreshInt_value
    Private flag_TxThreshInt
    Private write_TxEmptyInt_value
    Private read_TxEmptyInt_value
    Private flag_TxEmptyInt
    Private write_RxOverflowInt_value
    Private read_RxOverflowInt_value
    Private flag_RxOverflowInt
    Private write_RxFullInt_value
    Private read_RxFullInt_value
    Private flag_RxFullInt
    Private write_RxThreshInt_value
    Private read_RxThreshInt_value
    Private flag_RxThreshInt
    Private write_RxEmptyInt_value
    Private read_RxEmptyInt_value
    Private flag_RxEmptyInt

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

    Property Get get_DoneInt
        get_DoneInt = read_DoneInt_value
    End Property

    Property Let set_DoneInt(aData)
        write_DoneInt_value = aData
        flag_DoneInt        = &H1
    End Property

    Property Get read_DoneInt
        read
        read_DoneInt = read_DoneInt_value
    End Property

    Property Let write_DoneInt(aData)
        set_DoneInt = aData
        write
    End Property

    Property Get get_AutoPollInt
        get_AutoPollInt = read_AutoPollInt_value
    End Property

    Property Let set_AutoPollInt(aData)
        write_AutoPollInt_value = aData
        flag_AutoPollInt        = &H1
    End Property

    Property Get read_AutoPollInt
        read
        read_AutoPollInt = read_AutoPollInt_value
    End Property

    Property Let write_AutoPollInt(aData)
        set_AutoPollInt = aData
        write
    End Property

    Property Get get_TxUnderflowInt
        get_TxUnderflowInt = read_TxUnderflowInt_value
    End Property

    Property Let set_TxUnderflowInt(aData)
        write_TxUnderflowInt_value = aData
        flag_TxUnderflowInt        = &H1
    End Property

    Property Get read_TxUnderflowInt
        read
        read_TxUnderflowInt = read_TxUnderflowInt_value
    End Property

    Property Let write_TxUnderflowInt(aData)
        set_TxUnderflowInt = aData
        write
    End Property

    Property Get get_TxFullInt
        get_TxFullInt = read_TxFullInt_value
    End Property

    Property Let set_TxFullInt(aData)
        write_TxFullInt_value = aData
        flag_TxFullInt        = &H1
    End Property

    Property Get read_TxFullInt
        read
        read_TxFullInt = read_TxFullInt_value
    End Property

    Property Let write_TxFullInt(aData)
        set_TxFullInt = aData
        write
    End Property

    Property Get get_TxThreshInt
        get_TxThreshInt = read_TxThreshInt_value
    End Property

    Property Let set_TxThreshInt(aData)
        write_TxThreshInt_value = aData
        flag_TxThreshInt        = &H1
    End Property

    Property Get read_TxThreshInt
        read
        read_TxThreshInt = read_TxThreshInt_value
    End Property

    Property Let write_TxThreshInt(aData)
        set_TxThreshInt = aData
        write
    End Property

    Property Get get_TxEmptyInt
        get_TxEmptyInt = read_TxEmptyInt_value
    End Property

    Property Let set_TxEmptyInt(aData)
        write_TxEmptyInt_value = aData
        flag_TxEmptyInt        = &H1
    End Property

    Property Get read_TxEmptyInt
        read
        read_TxEmptyInt = read_TxEmptyInt_value
    End Property

    Property Let write_TxEmptyInt(aData)
        set_TxEmptyInt = aData
        write
    End Property

    Property Get get_RxOverflowInt
        get_RxOverflowInt = read_RxOverflowInt_value
    End Property

    Property Let set_RxOverflowInt(aData)
        write_RxOverflowInt_value = aData
        flag_RxOverflowInt        = &H1
    End Property

    Property Get read_RxOverflowInt
        read
        read_RxOverflowInt = read_RxOverflowInt_value
    End Property

    Property Let write_RxOverflowInt(aData)
        set_RxOverflowInt = aData
        write
    End Property

    Property Get get_RxFullInt
        get_RxFullInt = read_RxFullInt_value
    End Property

    Property Let set_RxFullInt(aData)
        write_RxFullInt_value = aData
        flag_RxFullInt        = &H1
    End Property

    Property Get read_RxFullInt
        read
        read_RxFullInt = read_RxFullInt_value
    End Property

    Property Let write_RxFullInt(aData)
        set_RxFullInt = aData
        write
    End Property

    Property Get get_RxThreshInt
        get_RxThreshInt = read_RxThreshInt_value
    End Property

    Property Let set_RxThreshInt(aData)
        write_RxThreshInt_value = aData
        flag_RxThreshInt        = &H1
    End Property

    Property Get read_RxThreshInt
        read
        read_RxThreshInt = read_RxThreshInt_value
    End Property

    Property Let write_RxThreshInt(aData)
        set_RxThreshInt = aData
        write
    End Property

    Property Get get_RxEmptyInt
        get_RxEmptyInt = read_RxEmptyInt_value
    End Property

    Property Let set_RxEmptyInt(aData)
        write_RxEmptyInt_value = aData
        flag_RxEmptyInt        = &H1
    End Property

    Property Get read_RxEmptyInt
        read
        read_RxEmptyInt = read_RxEmptyInt_value
    End Property

    Property Let write_RxEmptyInt(aData)
        set_RxEmptyInt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DoneInt_value = rightShift(data_low, 13) and &H1
        read_AutoPollInt_value = rightShift(data_low, 12) and &H1
        read_TxUnderflowInt_value = rightShift(data_low, 11) and &H1
        read_TxFullInt_value = rightShift(data_low, 10) and &H1
        read_TxThreshInt_value = rightShift(data_low, 9) and &H1
        read_TxEmptyInt_value = rightShift(data_low, 8) and &H1
        read_RxOverflowInt_value = rightShift(data_low, 3) and &H1
        read_RxFullInt_value = rightShift(data_low, 2) and &H1
        read_RxThreshInt_value = rightShift(data_low, 1) and &H1
        RxEmptyInt_mask = &H1
        if data_low > LONG_MAX then
            if RxEmptyInt_mask = mask then
                read_RxEmptyInt_value = data_low
            else
                read_RxEmptyInt_value = (data_low - H8000_0000) and RxEmptyInt_mask
            end If
        else
            read_RxEmptyInt_value = data_low and RxEmptyInt_mask
        end If

    End Sub

    Sub write
        If flag_DoneInt = &H0 or flag_AutoPollInt = &H0 or flag_TxUnderflowInt = &H0 or flag_TxFullInt = &H0 or flag_TxThreshInt = &H0 or flag_TxEmptyInt = &H0 or flag_RxOverflowInt = &H0 or flag_RxFullInt = &H0 or flag_RxThreshInt = &H0 or flag_RxEmptyInt = &H0 Then read
        If flag_DoneInt = &H0 Then write_DoneInt_value = get_DoneInt
        If flag_AutoPollInt = &H0 Then write_AutoPollInt_value = get_AutoPollInt
        If flag_TxUnderflowInt = &H0 Then write_TxUnderflowInt_value = get_TxUnderflowInt
        If flag_TxFullInt = &H0 Then write_TxFullInt_value = get_TxFullInt
        If flag_TxThreshInt = &H0 Then write_TxThreshInt_value = get_TxThreshInt
        If flag_TxEmptyInt = &H0 Then write_TxEmptyInt_value = get_TxEmptyInt
        If flag_RxOverflowInt = &H0 Then write_RxOverflowInt_value = get_RxOverflowInt
        If flag_RxFullInt = &H0 Then write_RxFullInt_value = get_RxFullInt
        If flag_RxThreshInt = &H0 Then write_RxThreshInt_value = get_RxThreshInt
        If flag_RxEmptyInt = &H0 Then write_RxEmptyInt_value = get_RxEmptyInt

        regValue = leftShift((write_DoneInt_value and &H1), 13) + leftShift((write_AutoPollInt_value and &H1), 12) + leftShift((write_TxUnderflowInt_value and &H1), 11) + leftShift((write_TxFullInt_value and &H1), 10) + leftShift((write_TxThreshInt_value and &H1), 9) + leftShift((write_TxEmptyInt_value and &H1), 8) + leftShift((write_RxOverflowInt_value and &H1), 3) + leftShift((write_RxFullInt_value and &H1), 2) + leftShift((write_RxThreshInt_value and &H1), 1) + leftShift((write_RxEmptyInt_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DoneInt_value = rightShift(data_low, 13) and &H1
        read_AutoPollInt_value = rightShift(data_low, 12) and &H1
        read_TxUnderflowInt_value = rightShift(data_low, 11) and &H1
        read_TxFullInt_value = rightShift(data_low, 10) and &H1
        read_TxThreshInt_value = rightShift(data_low, 9) and &H1
        read_TxEmptyInt_value = rightShift(data_low, 8) and &H1
        read_RxOverflowInt_value = rightShift(data_low, 3) and &H1
        read_RxFullInt_value = rightShift(data_low, 2) and &H1
        read_RxThreshInt_value = rightShift(data_low, 1) and &H1
        RxEmptyInt_mask = &H1
        if data_low > LONG_MAX then
            if RxEmptyInt_mask = mask then
                read_RxEmptyInt_value = data_low
            else
                read_RxEmptyInt_value = (data_low - H8000_0000) and RxEmptyInt_mask
            end If
        else
            read_RxEmptyInt_value = data_low and RxEmptyInt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DoneInt_value = &H0
        flag_DoneInt        = &H0
        write_AutoPollInt_value = &H0
        flag_AutoPollInt        = &H0
        write_TxUnderflowInt_value = &H0
        flag_TxUnderflowInt        = &H0
        write_TxFullInt_value = &H0
        flag_TxFullInt        = &H0
        write_TxThreshInt_value = &H0
        flag_TxThreshInt        = &H0
        write_TxEmptyInt_value = &H0
        flag_TxEmptyInt        = &H0
        write_RxOverflowInt_value = &H0
        flag_RxOverflowInt        = &H0
        write_RxFullInt_value = &H0
        flag_RxFullInt        = &H0
        write_RxThreshInt_value = &H0
        flag_RxThreshInt        = &H0
        write_RxEmptyInt_value = &H0
        flag_RxEmptyInt        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_intmask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DoneMask                                   [13:13]          get_DoneMask
''                                                             set_DoneMask
''                                                             read_DoneMask
''                                                             write_DoneMask
''---------------------------------------------------------------------------------
'' AutoPollMask                               [12:12]          get_AutoPollMask
''                                                             set_AutoPollMask
''                                                             read_AutoPollMask
''                                                             write_AutoPollMask
''---------------------------------------------------------------------------------
'' TxUnderflowMask                            [11:11]          get_TxUnderflowMask
''                                                             set_TxUnderflowMask
''                                                             read_TxUnderflowMask
''                                                             write_TxUnderflowMask
''---------------------------------------------------------------------------------
'' TxFullMask                                 [10:10]          get_TxFullMask
''                                                             set_TxFullMask
''                                                             read_TxFullMask
''                                                             write_TxFullMask
''---------------------------------------------------------------------------------
'' TxThreshMask                               [9:9]            get_TxThreshMask
''                                                             set_TxThreshMask
''                                                             read_TxThreshMask
''                                                             write_TxThreshMask
''---------------------------------------------------------------------------------
'' TxEmptyMask                                [8:8]            get_TxEmptyMask
''                                                             set_TxEmptyMask
''                                                             read_TxEmptyMask
''                                                             write_TxEmptyMask
''---------------------------------------------------------------------------------
'' RxOverflowMask                             [3:3]            get_RxOverflowMask
''                                                             set_RxOverflowMask
''                                                             read_RxOverflowMask
''                                                             write_RxOverflowMask
''---------------------------------------------------------------------------------
'' RxFullMask                                 [2:2]            get_RxFullMask
''                                                             set_RxFullMask
''                                                             read_RxFullMask
''                                                             write_RxFullMask
''---------------------------------------------------------------------------------
'' RxThreshMask                               [1:1]            get_RxThreshMask
''                                                             set_RxThreshMask
''                                                             read_RxThreshMask
''                                                             write_RxThreshMask
''---------------------------------------------------------------------------------
'' RxEmptyMask                                [0:0]            get_RxEmptyMask
''                                                             set_RxEmptyMask
''                                                             read_RxEmptyMask
''                                                             write_RxEmptyMask
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_intmask
    Private write_DoneMask_value
    Private read_DoneMask_value
    Private flag_DoneMask
    Private write_AutoPollMask_value
    Private read_AutoPollMask_value
    Private flag_AutoPollMask
    Private write_TxUnderflowMask_value
    Private read_TxUnderflowMask_value
    Private flag_TxUnderflowMask
    Private write_TxFullMask_value
    Private read_TxFullMask_value
    Private flag_TxFullMask
    Private write_TxThreshMask_value
    Private read_TxThreshMask_value
    Private flag_TxThreshMask
    Private write_TxEmptyMask_value
    Private read_TxEmptyMask_value
    Private flag_TxEmptyMask
    Private write_RxOverflowMask_value
    Private read_RxOverflowMask_value
    Private flag_RxOverflowMask
    Private write_RxFullMask_value
    Private read_RxFullMask_value
    Private flag_RxFullMask
    Private write_RxThreshMask_value
    Private read_RxThreshMask_value
    Private flag_RxThreshMask
    Private write_RxEmptyMask_value
    Private read_RxEmptyMask_value
    Private flag_RxEmptyMask

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

    Property Get get_DoneMask
        get_DoneMask = read_DoneMask_value
    End Property

    Property Let set_DoneMask(aData)
        write_DoneMask_value = aData
        flag_DoneMask        = &H1
    End Property

    Property Get read_DoneMask
        read
        read_DoneMask = read_DoneMask_value
    End Property

    Property Let write_DoneMask(aData)
        set_DoneMask = aData
        write
    End Property

    Property Get get_AutoPollMask
        get_AutoPollMask = read_AutoPollMask_value
    End Property

    Property Let set_AutoPollMask(aData)
        write_AutoPollMask_value = aData
        flag_AutoPollMask        = &H1
    End Property

    Property Get read_AutoPollMask
        read
        read_AutoPollMask = read_AutoPollMask_value
    End Property

    Property Let write_AutoPollMask(aData)
        set_AutoPollMask = aData
        write
    End Property

    Property Get get_TxUnderflowMask
        get_TxUnderflowMask = read_TxUnderflowMask_value
    End Property

    Property Let set_TxUnderflowMask(aData)
        write_TxUnderflowMask_value = aData
        flag_TxUnderflowMask        = &H1
    End Property

    Property Get read_TxUnderflowMask
        read
        read_TxUnderflowMask = read_TxUnderflowMask_value
    End Property

    Property Let write_TxUnderflowMask(aData)
        set_TxUnderflowMask = aData
        write
    End Property

    Property Get get_TxFullMask
        get_TxFullMask = read_TxFullMask_value
    End Property

    Property Let set_TxFullMask(aData)
        write_TxFullMask_value = aData
        flag_TxFullMask        = &H1
    End Property

    Property Get read_TxFullMask
        read
        read_TxFullMask = read_TxFullMask_value
    End Property

    Property Let write_TxFullMask(aData)
        set_TxFullMask = aData
        write
    End Property

    Property Get get_TxThreshMask
        get_TxThreshMask = read_TxThreshMask_value
    End Property

    Property Let set_TxThreshMask(aData)
        write_TxThreshMask_value = aData
        flag_TxThreshMask        = &H1
    End Property

    Property Get read_TxThreshMask
        read
        read_TxThreshMask = read_TxThreshMask_value
    End Property

    Property Let write_TxThreshMask(aData)
        set_TxThreshMask = aData
        write
    End Property

    Property Get get_TxEmptyMask
        get_TxEmptyMask = read_TxEmptyMask_value
    End Property

    Property Let set_TxEmptyMask(aData)
        write_TxEmptyMask_value = aData
        flag_TxEmptyMask        = &H1
    End Property

    Property Get read_TxEmptyMask
        read
        read_TxEmptyMask = read_TxEmptyMask_value
    End Property

    Property Let write_TxEmptyMask(aData)
        set_TxEmptyMask = aData
        write
    End Property

    Property Get get_RxOverflowMask
        get_RxOverflowMask = read_RxOverflowMask_value
    End Property

    Property Let set_RxOverflowMask(aData)
        write_RxOverflowMask_value = aData
        flag_RxOverflowMask        = &H1
    End Property

    Property Get read_RxOverflowMask
        read
        read_RxOverflowMask = read_RxOverflowMask_value
    End Property

    Property Let write_RxOverflowMask(aData)
        set_RxOverflowMask = aData
        write
    End Property

    Property Get get_RxFullMask
        get_RxFullMask = read_RxFullMask_value
    End Property

    Property Let set_RxFullMask(aData)
        write_RxFullMask_value = aData
        flag_RxFullMask        = &H1
    End Property

    Property Get read_RxFullMask
        read
        read_RxFullMask = read_RxFullMask_value
    End Property

    Property Let write_RxFullMask(aData)
        set_RxFullMask = aData
        write
    End Property

    Property Get get_RxThreshMask
        get_RxThreshMask = read_RxThreshMask_value
    End Property

    Property Let set_RxThreshMask(aData)
        write_RxThreshMask_value = aData
        flag_RxThreshMask        = &H1
    End Property

    Property Get read_RxThreshMask
        read
        read_RxThreshMask = read_RxThreshMask_value
    End Property

    Property Let write_RxThreshMask(aData)
        set_RxThreshMask = aData
        write
    End Property

    Property Get get_RxEmptyMask
        get_RxEmptyMask = read_RxEmptyMask_value
    End Property

    Property Let set_RxEmptyMask(aData)
        write_RxEmptyMask_value = aData
        flag_RxEmptyMask        = &H1
    End Property

    Property Get read_RxEmptyMask
        read
        read_RxEmptyMask = read_RxEmptyMask_value
    End Property

    Property Let write_RxEmptyMask(aData)
        set_RxEmptyMask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DoneMask_value = rightShift(data_low, 13) and &H1
        read_AutoPollMask_value = rightShift(data_low, 12) and &H1
        read_TxUnderflowMask_value = rightShift(data_low, 11) and &H1
        read_TxFullMask_value = rightShift(data_low, 10) and &H1
        read_TxThreshMask_value = rightShift(data_low, 9) and &H1
        read_TxEmptyMask_value = rightShift(data_low, 8) and &H1
        read_RxOverflowMask_value = rightShift(data_low, 3) and &H1
        read_RxFullMask_value = rightShift(data_low, 2) and &H1
        read_RxThreshMask_value = rightShift(data_low, 1) and &H1
        RxEmptyMask_mask = &H1
        if data_low > LONG_MAX then
            if RxEmptyMask_mask = mask then
                read_RxEmptyMask_value = data_low
            else
                read_RxEmptyMask_value = (data_low - H8000_0000) and RxEmptyMask_mask
            end If
        else
            read_RxEmptyMask_value = data_low and RxEmptyMask_mask
        end If

    End Sub

    Sub write
        If flag_DoneMask = &H0 or flag_AutoPollMask = &H0 or flag_TxUnderflowMask = &H0 or flag_TxFullMask = &H0 or flag_TxThreshMask = &H0 or flag_TxEmptyMask = &H0 or flag_RxOverflowMask = &H0 or flag_RxFullMask = &H0 or flag_RxThreshMask = &H0 or flag_RxEmptyMask = &H0 Then read
        If flag_DoneMask = &H0 Then write_DoneMask_value = get_DoneMask
        If flag_AutoPollMask = &H0 Then write_AutoPollMask_value = get_AutoPollMask
        If flag_TxUnderflowMask = &H0 Then write_TxUnderflowMask_value = get_TxUnderflowMask
        If flag_TxFullMask = &H0 Then write_TxFullMask_value = get_TxFullMask
        If flag_TxThreshMask = &H0 Then write_TxThreshMask_value = get_TxThreshMask
        If flag_TxEmptyMask = &H0 Then write_TxEmptyMask_value = get_TxEmptyMask
        If flag_RxOverflowMask = &H0 Then write_RxOverflowMask_value = get_RxOverflowMask
        If flag_RxFullMask = &H0 Then write_RxFullMask_value = get_RxFullMask
        If flag_RxThreshMask = &H0 Then write_RxThreshMask_value = get_RxThreshMask
        If flag_RxEmptyMask = &H0 Then write_RxEmptyMask_value = get_RxEmptyMask

        regValue = leftShift((write_DoneMask_value and &H1), 13) + leftShift((write_AutoPollMask_value and &H1), 12) + leftShift((write_TxUnderflowMask_value and &H1), 11) + leftShift((write_TxFullMask_value and &H1), 10) + leftShift((write_TxThreshMask_value and &H1), 9) + leftShift((write_TxEmptyMask_value and &H1), 8) + leftShift((write_RxOverflowMask_value and &H1), 3) + leftShift((write_RxFullMask_value and &H1), 2) + leftShift((write_RxThreshMask_value and &H1), 1) + leftShift((write_RxEmptyMask_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DoneMask_value = rightShift(data_low, 13) and &H1
        read_AutoPollMask_value = rightShift(data_low, 12) and &H1
        read_TxUnderflowMask_value = rightShift(data_low, 11) and &H1
        read_TxFullMask_value = rightShift(data_low, 10) and &H1
        read_TxThreshMask_value = rightShift(data_low, 9) and &H1
        read_TxEmptyMask_value = rightShift(data_low, 8) and &H1
        read_RxOverflowMask_value = rightShift(data_low, 3) and &H1
        read_RxFullMask_value = rightShift(data_low, 2) and &H1
        read_RxThreshMask_value = rightShift(data_low, 1) and &H1
        RxEmptyMask_mask = &H1
        if data_low > LONG_MAX then
            if RxEmptyMask_mask = mask then
                read_RxEmptyMask_value = data_low
            else
                read_RxEmptyMask_value = (data_low - H8000_0000) and RxEmptyMask_mask
            end If
        else
            read_RxEmptyMask_value = data_low and RxEmptyMask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DoneMask_value = &H0
        flag_DoneMask        = &H0
        write_AutoPollMask_value = &H0
        flag_AutoPollMask        = &H0
        write_TxUnderflowMask_value = &H0
        flag_TxUnderflowMask        = &H0
        write_TxFullMask_value = &H0
        flag_TxFullMask        = &H0
        write_TxThreshMask_value = &H0
        flag_TxThreshMask        = &H0
        write_TxEmptyMask_value = &H0
        flag_TxEmptyMask        = &H0
        write_RxOverflowMask_value = &H0
        flag_RxOverflowMask        = &H0
        write_RxFullMask_value = &H0
        flag_RxFullMask        = &H0
        write_RxThreshMask_value = &H0
        flag_RxThreshMask        = &H0
        write_RxEmptyMask_value = &H0
        flag_RxEmptyMask        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias1
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias2
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias3
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias4
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias5
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias6
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_dataregister_alias7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataRegiter                                [31:0]           get_DataRegiter
''                                                             set_DataRegiter
''                                                             read_DataRegiter
''                                                             write_DataRegiter
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_dataregister_alias7
    Private write_DataRegiter_value
    Private read_DataRegiter_value
    Private flag_DataRegiter

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

    Property Get get_DataRegiter
        get_DataRegiter = read_DataRegiter_value
    End Property

    Property Let set_DataRegiter(aData)
        write_DataRegiter_value = aData
        flag_DataRegiter        = &H1
    End Property

    Property Get read_DataRegiter
        read
        read_DataRegiter = read_DataRegiter_value
    End Property

    Property Let write_DataRegiter(aData)
        set_DataRegiter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

    End Sub

    Sub write
        If flag_DataRegiter = &H0 Then read
        If flag_DataRegiter = &H0 Then write_DataRegiter_value = get_DataRegiter

        regValue = leftShift(write_DataRegiter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataRegiter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DataRegiter_mask = mask then
                read_DataRegiter_value = data_low
            else
                read_DataRegiter_value = (data_low - H8000_0000) and DataRegiter_mask
            end If
        else
            read_DataRegiter_value = data_low and DataRegiter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataRegiter_value = &H0
        flag_DataRegiter        = &H0
    End Sub
End Class


'' @REGISTER : SPI_10T1S_reserved_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RSVP                                       [31:0]           get_RSVP
''                                                             set_RSVP
''                                                             read_RSVP
''                                                             write_RSVP
''---------------------------------------------------------------------------------
Class REGISTER_SPI_10T1S_reserved_reg
    Private write_RSVP_value
    Private read_RSVP_value
    Private flag_RSVP

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

    Property Get get_RSVP
        get_RSVP = read_RSVP_value
    End Property

    Property Let set_RSVP(aData)
        write_RSVP_value = aData
        flag_RSVP        = &H1
    End Property

    Property Get read_RSVP
        read
        read_RSVP = read_RSVP_value
    End Property

    Property Let write_RSVP(aData)
        set_RSVP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RSVP_mask = &Hffffffff
        if data_low > LONG_MAX then
            if RSVP_mask = mask then
                read_RSVP_value = data_low
            else
                read_RSVP_value = (data_low - H8000_0000) and RSVP_mask
            end If
        else
            read_RSVP_value = data_low and RSVP_mask
        end If

    End Sub

    Sub write
        If flag_RSVP = &H0 Then read
        If flag_RSVP = &H0 Then write_RSVP_value = get_RSVP

        regValue = leftShift(write_RSVP_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RSVP_mask = &Hffffffff
        if data_low > LONG_MAX then
            if RSVP_mask = mask then
                read_RSVP_value = data_low
            else
                read_RSVP_value = (data_low - H8000_0000) and RSVP_mask
            end If
        else
            read_RSVP_value = data_low and RSVP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RSVP_value = &H0
        flag_RSVP        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SPI_10T1S_INSTANCE

    Public ctrl0_addr
    Public ctrl1_modebits
    Public ctrl2_data_len
    Public ctrl3_config
    Public ctrl4_config
    Public ctrl5_config
    Public ctrl6_autopollexp
    Public ctrl7_autopollmask
    Public stat
    Public int
    Public intmask
    Public dataregister
    Public dataregister_alias1
    Public dataregister_alias2
    Public dataregister_alias3
    Public dataregister_alias4
    Public dataregister_alias5
    Public dataregister_alias6
    Public dataregister_alias7
    Public reserved_reg


    Public default function Init(aBaseAddr)
        Set ctrl0_addr = (New REGISTER_SPI_10T1S_ctrl0_addr)(aBaseAddr, 32)
        Set ctrl1_modebits = (New REGISTER_SPI_10T1S_ctrl1_modebits)(aBaseAddr, 32)
        Set ctrl2_data_len = (New REGISTER_SPI_10T1S_ctrl2_data_len)(aBaseAddr, 32)
        Set ctrl3_config = (New REGISTER_SPI_10T1S_ctrl3_config)(aBaseAddr, 32)
        Set ctrl4_config = (New REGISTER_SPI_10T1S_ctrl4_config)(aBaseAddr, 32)
        Set ctrl5_config = (New REGISTER_SPI_10T1S_ctrl5_config)(aBaseAddr, 32)
        Set ctrl6_autopollexp = (New REGISTER_SPI_10T1S_ctrl6_autopollexp)(aBaseAddr, 32)
        Set ctrl7_autopollmask = (New REGISTER_SPI_10T1S_ctrl7_autopollmask)(aBaseAddr, 32)
        Set stat = (New REGISTER_SPI_10T1S_stat)(aBaseAddr, 32)
        Set int = (New REGISTER_SPI_10T1S_int)(aBaseAddr, 32)
        Set intmask = (New REGISTER_SPI_10T1S_intmask)(aBaseAddr, 32)
        Set dataregister = (New REGISTER_SPI_10T1S_dataregister)(aBaseAddr, 32)
        Set dataregister_alias1 = (New REGISTER_SPI_10T1S_dataregister_alias1)(aBaseAddr, 32)
        Set dataregister_alias2 = (New REGISTER_SPI_10T1S_dataregister_alias2)(aBaseAddr, 32)
        Set dataregister_alias3 = (New REGISTER_SPI_10T1S_dataregister_alias3)(aBaseAddr, 32)
        Set dataregister_alias4 = (New REGISTER_SPI_10T1S_dataregister_alias4)(aBaseAddr, 32)
        Set dataregister_alias5 = (New REGISTER_SPI_10T1S_dataregister_alias5)(aBaseAddr, 32)
        Set dataregister_alias6 = (New REGISTER_SPI_10T1S_dataregister_alias6)(aBaseAddr, 32)
        Set dataregister_alias7 = (New REGISTER_SPI_10T1S_dataregister_alias7)(aBaseAddr, 32)
        Set reserved_reg = (New REGISTER_SPI_10T1S_reserved_reg)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SPI_10T1S = CreateObject("System.Collections.ArrayList")
SPI_10T1S.Add ((New SPI_10T1S_INSTANCE)(&H4b181000))
SPI_10T1S.Add ((New SPI_10T1S_INSTANCE)(&H4b181100))


