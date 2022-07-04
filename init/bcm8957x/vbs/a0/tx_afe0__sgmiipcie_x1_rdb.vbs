

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


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_15_0                            [15:0]           get_ana_txctrl_15_0
''                                                             set_ana_txctrl_15_0
''                                                             read_ana_txctrl_15_0
''                                                             write_ana_txctrl_15_0
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control0
    Private write_ana_txctrl_15_0_value
    Private read_ana_txctrl_15_0_value
    Private flag_ana_txctrl_15_0

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

    Property Get get_ana_txctrl_15_0
        get_ana_txctrl_15_0 = read_ana_txctrl_15_0_value
    End Property

    Property Let set_ana_txctrl_15_0(aData)
        write_ana_txctrl_15_0_value = aData
        flag_ana_txctrl_15_0        = &H1
    End Property

    Property Get read_ana_txctrl_15_0
        read
        read_ana_txctrl_15_0 = read_ana_txctrl_15_0_value
    End Property

    Property Let write_ana_txctrl_15_0(aData)
        set_ana_txctrl_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_15_0_mask = mask then
                read_ana_txctrl_15_0_value = data_low
            else
                read_ana_txctrl_15_0_value = (data_low - H8000_0000) and ana_txctrl_15_0_mask
            end If
        else
            read_ana_txctrl_15_0_value = data_low and ana_txctrl_15_0_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_15_0 = &H0 Then read
        If flag_ana_txctrl_15_0 = &H0 Then write_ana_txctrl_15_0_value = get_ana_txctrl_15_0

        regValue = leftShift((write_ana_txctrl_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_15_0_mask = mask then
                read_ana_txctrl_15_0_value = data_low
            else
                read_ana_txctrl_15_0_value = (data_low - H8000_0000) and ana_txctrl_15_0_mask
            end If
        else
            read_ana_txctrl_15_0_value = data_low and ana_txctrl_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_15_0_value = &H0
        flag_ana_txctrl_15_0        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_31_16                           [15:0]           get_ana_txctrl_31_16
''                                                             set_ana_txctrl_31_16
''                                                             read_ana_txctrl_31_16
''                                                             write_ana_txctrl_31_16
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control1
    Private write_ana_txctrl_31_16_value
    Private read_ana_txctrl_31_16_value
    Private flag_ana_txctrl_31_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ana_txctrl_31_16
        get_ana_txctrl_31_16 = read_ana_txctrl_31_16_value
    End Property

    Property Let set_ana_txctrl_31_16(aData)
        write_ana_txctrl_31_16_value = aData
        flag_ana_txctrl_31_16        = &H1
    End Property

    Property Get read_ana_txctrl_31_16
        read
        read_ana_txctrl_31_16 = read_ana_txctrl_31_16_value
    End Property

    Property Let write_ana_txctrl_31_16(aData)
        set_ana_txctrl_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_31_16_mask = mask then
                read_ana_txctrl_31_16_value = data_low
            else
                read_ana_txctrl_31_16_value = (data_low - H8000_0000) and ana_txctrl_31_16_mask
            end If
        else
            read_ana_txctrl_31_16_value = data_low and ana_txctrl_31_16_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_31_16 = &H0 Then read
        If flag_ana_txctrl_31_16 = &H0 Then write_ana_txctrl_31_16_value = get_ana_txctrl_31_16

        regValue = leftShift((write_ana_txctrl_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_31_16_mask = mask then
                read_ana_txctrl_31_16_value = data_low
            else
                read_ana_txctrl_31_16_value = (data_low - H8000_0000) and ana_txctrl_31_16_mask
            end If
        else
            read_ana_txctrl_31_16_value = data_low and ana_txctrl_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_31_16_value = &H0
        flag_ana_txctrl_31_16        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_47_32                           [15:0]           get_ana_txctrl_47_32
''                                                             set_ana_txctrl_47_32
''                                                             read_ana_txctrl_47_32
''                                                             write_ana_txctrl_47_32
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control2
    Private write_ana_txctrl_47_32_value
    Private read_ana_txctrl_47_32_value
    Private flag_ana_txctrl_47_32

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

    Property Get get_ana_txctrl_47_32
        get_ana_txctrl_47_32 = read_ana_txctrl_47_32_value
    End Property

    Property Let set_ana_txctrl_47_32(aData)
        write_ana_txctrl_47_32_value = aData
        flag_ana_txctrl_47_32        = &H1
    End Property

    Property Get read_ana_txctrl_47_32
        read
        read_ana_txctrl_47_32 = read_ana_txctrl_47_32_value
    End Property

    Property Let write_ana_txctrl_47_32(aData)
        set_ana_txctrl_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_47_32_mask = mask then
                read_ana_txctrl_47_32_value = data_low
            else
                read_ana_txctrl_47_32_value = (data_low - H8000_0000) and ana_txctrl_47_32_mask
            end If
        else
            read_ana_txctrl_47_32_value = data_low and ana_txctrl_47_32_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_47_32 = &H0 Then read
        If flag_ana_txctrl_47_32 = &H0 Then write_ana_txctrl_47_32_value = get_ana_txctrl_47_32

        regValue = leftShift((write_ana_txctrl_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_47_32_mask = mask then
                read_ana_txctrl_47_32_value = data_low
            else
                read_ana_txctrl_47_32_value = (data_low - H8000_0000) and ana_txctrl_47_32_mask
            end If
        else
            read_ana_txctrl_47_32_value = data_low and ana_txctrl_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_47_32_value = &H0
        flag_ana_txctrl_47_32        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_63_48                           [15:0]           get_ana_txctrl_63_48
''                                                             set_ana_txctrl_63_48
''                                                             read_ana_txctrl_63_48
''                                                             write_ana_txctrl_63_48
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control3
    Private write_ana_txctrl_63_48_value
    Private read_ana_txctrl_63_48_value
    Private flag_ana_txctrl_63_48

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ana_txctrl_63_48
        get_ana_txctrl_63_48 = read_ana_txctrl_63_48_value
    End Property

    Property Let set_ana_txctrl_63_48(aData)
        write_ana_txctrl_63_48_value = aData
        flag_ana_txctrl_63_48        = &H1
    End Property

    Property Get read_ana_txctrl_63_48
        read
        read_ana_txctrl_63_48 = read_ana_txctrl_63_48_value
    End Property

    Property Let write_ana_txctrl_63_48(aData)
        set_ana_txctrl_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_63_48_mask = mask then
                read_ana_txctrl_63_48_value = data_low
            else
                read_ana_txctrl_63_48_value = (data_low - H8000_0000) and ana_txctrl_63_48_mask
            end If
        else
            read_ana_txctrl_63_48_value = data_low and ana_txctrl_63_48_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_63_48 = &H0 Then read
        If flag_ana_txctrl_63_48 = &H0 Then write_ana_txctrl_63_48_value = get_ana_txctrl_63_48

        regValue = leftShift((write_ana_txctrl_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_63_48_mask = mask then
                read_ana_txctrl_63_48_value = data_low
            else
                read_ana_txctrl_63_48_value = (data_low - H8000_0000) and ana_txctrl_63_48_mask
            end If
        else
            read_ana_txctrl_63_48_value = data_low and ana_txctrl_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_63_48_value = &H0
        flag_ana_txctrl_63_48        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_15_0_6dB                        [15:0]           get_ana_txctrl_15_0_6dB
''                                                             set_ana_txctrl_15_0_6dB
''                                                             read_ana_txctrl_15_0_6dB
''                                                             write_ana_txctrl_15_0_6dB
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control4
    Private write_ana_txctrl_15_0_6dB_value
    Private read_ana_txctrl_15_0_6dB_value
    Private flag_ana_txctrl_15_0_6dB

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

    Property Get get_ana_txctrl_15_0_6dB
        get_ana_txctrl_15_0_6dB = read_ana_txctrl_15_0_6dB_value
    End Property

    Property Let set_ana_txctrl_15_0_6dB(aData)
        write_ana_txctrl_15_0_6dB_value = aData
        flag_ana_txctrl_15_0_6dB        = &H1
    End Property

    Property Get read_ana_txctrl_15_0_6dB
        read
        read_ana_txctrl_15_0_6dB = read_ana_txctrl_15_0_6dB_value
    End Property

    Property Let write_ana_txctrl_15_0_6dB(aData)
        set_ana_txctrl_15_0_6dB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_15_0_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_15_0_6dB_mask = mask then
                read_ana_txctrl_15_0_6dB_value = data_low
            else
                read_ana_txctrl_15_0_6dB_value = (data_low - H8000_0000) and ana_txctrl_15_0_6dB_mask
            end If
        else
            read_ana_txctrl_15_0_6dB_value = data_low and ana_txctrl_15_0_6dB_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_15_0_6dB = &H0 Then read
        If flag_ana_txctrl_15_0_6dB = &H0 Then write_ana_txctrl_15_0_6dB_value = get_ana_txctrl_15_0_6dB

        regValue = leftShift((write_ana_txctrl_15_0_6dB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_15_0_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_15_0_6dB_mask = mask then
                read_ana_txctrl_15_0_6dB_value = data_low
            else
                read_ana_txctrl_15_0_6dB_value = (data_low - H8000_0000) and ana_txctrl_15_0_6dB_mask
            end If
        else
            read_ana_txctrl_15_0_6dB_value = data_low and ana_txctrl_15_0_6dB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_15_0_6dB_value = &H0
        flag_ana_txctrl_15_0_6dB        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_31_16_6dB                       [15:0]           get_ana_txctrl_31_16_6dB
''                                                             set_ana_txctrl_31_16_6dB
''                                                             read_ana_txctrl_31_16_6dB
''                                                             write_ana_txctrl_31_16_6dB
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control5
    Private write_ana_txctrl_31_16_6dB_value
    Private read_ana_txctrl_31_16_6dB_value
    Private flag_ana_txctrl_31_16_6dB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ana_txctrl_31_16_6dB
        get_ana_txctrl_31_16_6dB = read_ana_txctrl_31_16_6dB_value
    End Property

    Property Let set_ana_txctrl_31_16_6dB(aData)
        write_ana_txctrl_31_16_6dB_value = aData
        flag_ana_txctrl_31_16_6dB        = &H1
    End Property

    Property Get read_ana_txctrl_31_16_6dB
        read
        read_ana_txctrl_31_16_6dB = read_ana_txctrl_31_16_6dB_value
    End Property

    Property Let write_ana_txctrl_31_16_6dB(aData)
        set_ana_txctrl_31_16_6dB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_31_16_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_31_16_6dB_mask = mask then
                read_ana_txctrl_31_16_6dB_value = data_low
            else
                read_ana_txctrl_31_16_6dB_value = (data_low - H8000_0000) and ana_txctrl_31_16_6dB_mask
            end If
        else
            read_ana_txctrl_31_16_6dB_value = data_low and ana_txctrl_31_16_6dB_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_31_16_6dB = &H0 Then read
        If flag_ana_txctrl_31_16_6dB = &H0 Then write_ana_txctrl_31_16_6dB_value = get_ana_txctrl_31_16_6dB

        regValue = leftShift((write_ana_txctrl_31_16_6dB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_31_16_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_31_16_6dB_mask = mask then
                read_ana_txctrl_31_16_6dB_value = data_low
            else
                read_ana_txctrl_31_16_6dB_value = (data_low - H8000_0000) and ana_txctrl_31_16_6dB_mask
            end If
        else
            read_ana_txctrl_31_16_6dB_value = data_low and ana_txctrl_31_16_6dB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_31_16_6dB_value = &H0
        flag_ana_txctrl_31_16_6dB        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_1_6dB                           [15:0]           get_ana_txctrl_1_6dB
''                                                             set_ana_txctrl_1_6dB
''                                                             read_ana_txctrl_1_6dB
''                                                             write_ana_txctrl_1_6dB
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control6
    Private write_ana_txctrl_1_6dB_value
    Private read_ana_txctrl_1_6dB_value
    Private flag_ana_txctrl_1_6dB

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

    Property Get get_ana_txctrl_1_6dB
        get_ana_txctrl_1_6dB = read_ana_txctrl_1_6dB_value
    End Property

    Property Let set_ana_txctrl_1_6dB(aData)
        write_ana_txctrl_1_6dB_value = aData
        flag_ana_txctrl_1_6dB        = &H1
    End Property

    Property Get read_ana_txctrl_1_6dB
        read
        read_ana_txctrl_1_6dB = read_ana_txctrl_1_6dB_value
    End Property

    Property Let write_ana_txctrl_1_6dB(aData)
        set_ana_txctrl_1_6dB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_1_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_1_6dB_mask = mask then
                read_ana_txctrl_1_6dB_value = data_low
            else
                read_ana_txctrl_1_6dB_value = (data_low - H8000_0000) and ana_txctrl_1_6dB_mask
            end If
        else
            read_ana_txctrl_1_6dB_value = data_low and ana_txctrl_1_6dB_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_1_6dB = &H0 Then read
        If flag_ana_txctrl_1_6dB = &H0 Then write_ana_txctrl_1_6dB_value = get_ana_txctrl_1_6dB

        regValue = leftShift((write_ana_txctrl_1_6dB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_1_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_1_6dB_mask = mask then
                read_ana_txctrl_1_6dB_value = data_low
            else
                read_ana_txctrl_1_6dB_value = (data_low - H8000_0000) and ana_txctrl_1_6dB_mask
            end If
        else
            read_ana_txctrl_1_6dB_value = data_low and ana_txctrl_1_6dB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_1_6dB_value = &H0
        flag_ana_txctrl_1_6dB        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE0__SGMIIPCIE_X1_control7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_txctrl_0_6dB                           [15:0]           get_ana_txctrl_0_6dB
''                                                             set_ana_txctrl_0_6dB
''                                                             read_ana_txctrl_0_6dB
''                                                             write_ana_txctrl_0_6dB
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE0__SGMIIPCIE_X1_control7
    Private write_ana_txctrl_0_6dB_value
    Private read_ana_txctrl_0_6dB_value
    Private flag_ana_txctrl_0_6dB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ana_txctrl_0_6dB
        get_ana_txctrl_0_6dB = read_ana_txctrl_0_6dB_value
    End Property

    Property Let set_ana_txctrl_0_6dB(aData)
        write_ana_txctrl_0_6dB_value = aData
        flag_ana_txctrl_0_6dB        = &H1
    End Property

    Property Get read_ana_txctrl_0_6dB
        read
        read_ana_txctrl_0_6dB = read_ana_txctrl_0_6dB_value
    End Property

    Property Let write_ana_txctrl_0_6dB(aData)
        set_ana_txctrl_0_6dB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_0_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_0_6dB_mask = mask then
                read_ana_txctrl_0_6dB_value = data_low
            else
                read_ana_txctrl_0_6dB_value = (data_low - H8000_0000) and ana_txctrl_0_6dB_mask
            end If
        else
            read_ana_txctrl_0_6dB_value = data_low and ana_txctrl_0_6dB_mask
        end If

    End Sub

    Sub write
        If flag_ana_txctrl_0_6dB = &H0 Then read
        If flag_ana_txctrl_0_6dB = &H0 Then write_ana_txctrl_0_6dB_value = get_ana_txctrl_0_6dB

        regValue = leftShift((write_ana_txctrl_0_6dB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_txctrl_0_6dB_mask = &Hffff
        if data_low > LONG_MAX then
            if ana_txctrl_0_6dB_mask = mask then
                read_ana_txctrl_0_6dB_value = data_low
            else
                read_ana_txctrl_0_6dB_value = (data_low - H8000_0000) and ana_txctrl_0_6dB_mask
            end If
        else
            read_ana_txctrl_0_6dB_value = data_low and ana_txctrl_0_6dB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_txctrl_0_6dB_value = &H0
        flag_ana_txctrl_0_6dB        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TX_AFE0__SGMIIPCIE_X1_INSTANCE

    Public control0
    Public control1
    Public control2
    Public control3
    Public control4
    Public control5
    Public control6
    Public control7


    Public default function Init(aBaseAddr)
        Set control0 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control0)(aBaseAddr, 16)
        Set control1 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control1)(aBaseAddr, 16)
        Set control2 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control2)(aBaseAddr, 16)
        Set control3 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control3)(aBaseAddr, 16)
        Set control4 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control4)(aBaseAddr, 16)
        Set control5 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control5)(aBaseAddr, 16)
        Set control6 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control6)(aBaseAddr, 16)
        Set control7 = (New REGISTER_TX_AFE0__SGMIIPCIE_X1_control7)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_AFE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
TX_AFE0__SGMIIPCIE_X1.Add ((New TX_AFE0__SGMIIPCIE_X1_INSTANCE)(&H4ade8000))


