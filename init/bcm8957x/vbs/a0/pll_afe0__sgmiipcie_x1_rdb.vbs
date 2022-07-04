

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


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_15_0                              [15:0]           get_pll_ctrl_15_0
''                                                             set_pll_ctrl_15_0
''                                                             read_pll_ctrl_15_0
''                                                             write_pll_ctrl_15_0
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl0
    Private write_pll_ctrl_15_0_value
    Private read_pll_ctrl_15_0_value
    Private flag_pll_ctrl_15_0

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

    Property Get get_pll_ctrl_15_0
        get_pll_ctrl_15_0 = read_pll_ctrl_15_0_value
    End Property

    Property Let set_pll_ctrl_15_0(aData)
        write_pll_ctrl_15_0_value = aData
        flag_pll_ctrl_15_0        = &H1
    End Property

    Property Get read_pll_ctrl_15_0
        read
        read_pll_ctrl_15_0 = read_pll_ctrl_15_0_value
    End Property

    Property Let write_pll_ctrl_15_0(aData)
        set_pll_ctrl_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_15_0_mask = mask then
                read_pll_ctrl_15_0_value = data_low
            else
                read_pll_ctrl_15_0_value = (data_low - H8000_0000) and pll_ctrl_15_0_mask
            end If
        else
            read_pll_ctrl_15_0_value = data_low and pll_ctrl_15_0_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_15_0 = &H0 Then read
        If flag_pll_ctrl_15_0 = &H0 Then write_pll_ctrl_15_0_value = get_pll_ctrl_15_0

        regValue = leftShift((write_pll_ctrl_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_15_0_mask = mask then
                read_pll_ctrl_15_0_value = data_low
            else
                read_pll_ctrl_15_0_value = (data_low - H8000_0000) and pll_ctrl_15_0_mask
            end If
        else
            read_pll_ctrl_15_0_value = data_low and pll_ctrl_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_15_0_value = &H0
        flag_pll_ctrl_15_0        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_31_16                             [15:0]           get_pll_ctrl_31_16
''                                                             set_pll_ctrl_31_16
''                                                             read_pll_ctrl_31_16
''                                                             write_pll_ctrl_31_16
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl1
    Private write_pll_ctrl_31_16_value
    Private read_pll_ctrl_31_16_value
    Private flag_pll_ctrl_31_16

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

    Property Get get_pll_ctrl_31_16
        get_pll_ctrl_31_16 = read_pll_ctrl_31_16_value
    End Property

    Property Let set_pll_ctrl_31_16(aData)
        write_pll_ctrl_31_16_value = aData
        flag_pll_ctrl_31_16        = &H1
    End Property

    Property Get read_pll_ctrl_31_16
        read
        read_pll_ctrl_31_16 = read_pll_ctrl_31_16_value
    End Property

    Property Let write_pll_ctrl_31_16(aData)
        set_pll_ctrl_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_31_16_mask = mask then
                read_pll_ctrl_31_16_value = data_low
            else
                read_pll_ctrl_31_16_value = (data_low - H8000_0000) and pll_ctrl_31_16_mask
            end If
        else
            read_pll_ctrl_31_16_value = data_low and pll_ctrl_31_16_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_31_16 = &H0 Then read
        If flag_pll_ctrl_31_16 = &H0 Then write_pll_ctrl_31_16_value = get_pll_ctrl_31_16

        regValue = leftShift((write_pll_ctrl_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_31_16_mask = mask then
                read_pll_ctrl_31_16_value = data_low
            else
                read_pll_ctrl_31_16_value = (data_low - H8000_0000) and pll_ctrl_31_16_mask
            end If
        else
            read_pll_ctrl_31_16_value = data_low and pll_ctrl_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_31_16_value = &H0
        flag_pll_ctrl_31_16        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_47_32                             [15:0]           get_pll_ctrl_47_32
''                                                             set_pll_ctrl_47_32
''                                                             read_pll_ctrl_47_32
''                                                             write_pll_ctrl_47_32
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl2
    Private write_pll_ctrl_47_32_value
    Private read_pll_ctrl_47_32_value
    Private flag_pll_ctrl_47_32

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

    Property Get get_pll_ctrl_47_32
        get_pll_ctrl_47_32 = read_pll_ctrl_47_32_value
    End Property

    Property Let set_pll_ctrl_47_32(aData)
        write_pll_ctrl_47_32_value = aData
        flag_pll_ctrl_47_32        = &H1
    End Property

    Property Get read_pll_ctrl_47_32
        read
        read_pll_ctrl_47_32 = read_pll_ctrl_47_32_value
    End Property

    Property Let write_pll_ctrl_47_32(aData)
        set_pll_ctrl_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_47_32_mask = mask then
                read_pll_ctrl_47_32_value = data_low
            else
                read_pll_ctrl_47_32_value = (data_low - H8000_0000) and pll_ctrl_47_32_mask
            end If
        else
            read_pll_ctrl_47_32_value = data_low and pll_ctrl_47_32_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_47_32 = &H0 Then read
        If flag_pll_ctrl_47_32 = &H0 Then write_pll_ctrl_47_32_value = get_pll_ctrl_47_32

        regValue = leftShift((write_pll_ctrl_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_47_32_mask = mask then
                read_pll_ctrl_47_32_value = data_low
            else
                read_pll_ctrl_47_32_value = (data_low - H8000_0000) and pll_ctrl_47_32_mask
            end If
        else
            read_pll_ctrl_47_32_value = data_low and pll_ctrl_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_47_32_value = &H0
        flag_pll_ctrl_47_32        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_63_48                             [15:0]           get_pll_ctrl_63_48
''                                                             set_pll_ctrl_63_48
''                                                             read_pll_ctrl_63_48
''                                                             write_pll_ctrl_63_48
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl3
    Private write_pll_ctrl_63_48_value
    Private read_pll_ctrl_63_48_value
    Private flag_pll_ctrl_63_48

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

    Property Get get_pll_ctrl_63_48
        get_pll_ctrl_63_48 = read_pll_ctrl_63_48_value
    End Property

    Property Let set_pll_ctrl_63_48(aData)
        write_pll_ctrl_63_48_value = aData
        flag_pll_ctrl_63_48        = &H1
    End Property

    Property Get read_pll_ctrl_63_48
        read
        read_pll_ctrl_63_48 = read_pll_ctrl_63_48_value
    End Property

    Property Let write_pll_ctrl_63_48(aData)
        set_pll_ctrl_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_63_48_mask = mask then
                read_pll_ctrl_63_48_value = data_low
            else
                read_pll_ctrl_63_48_value = (data_low - H8000_0000) and pll_ctrl_63_48_mask
            end If
        else
            read_pll_ctrl_63_48_value = data_low and pll_ctrl_63_48_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_63_48 = &H0 Then read
        If flag_pll_ctrl_63_48 = &H0 Then write_pll_ctrl_63_48_value = get_pll_ctrl_63_48

        regValue = leftShift((write_pll_ctrl_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_63_48_mask = mask then
                read_pll_ctrl_63_48_value = data_low
            else
                read_pll_ctrl_63_48_value = (data_low - H8000_0000) and pll_ctrl_63_48_mask
            end If
        else
            read_pll_ctrl_63_48_value = data_low and pll_ctrl_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_63_48_value = &H0
        flag_pll_ctrl_63_48        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_79_64                             [15:0]           get_pll_ctrl_79_64
''                                                             set_pll_ctrl_79_64
''                                                             read_pll_ctrl_79_64
''                                                             write_pll_ctrl_79_64
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl4
    Private write_pll_ctrl_79_64_value
    Private read_pll_ctrl_79_64_value
    Private flag_pll_ctrl_79_64

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

    Property Get get_pll_ctrl_79_64
        get_pll_ctrl_79_64 = read_pll_ctrl_79_64_value
    End Property

    Property Let set_pll_ctrl_79_64(aData)
        write_pll_ctrl_79_64_value = aData
        flag_pll_ctrl_79_64        = &H1
    End Property

    Property Get read_pll_ctrl_79_64
        read
        read_pll_ctrl_79_64 = read_pll_ctrl_79_64_value
    End Property

    Property Let write_pll_ctrl_79_64(aData)
        set_pll_ctrl_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_79_64_mask = mask then
                read_pll_ctrl_79_64_value = data_low
            else
                read_pll_ctrl_79_64_value = (data_low - H8000_0000) and pll_ctrl_79_64_mask
            end If
        else
            read_pll_ctrl_79_64_value = data_low and pll_ctrl_79_64_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_79_64 = &H0 Then read
        If flag_pll_ctrl_79_64 = &H0 Then write_pll_ctrl_79_64_value = get_pll_ctrl_79_64

        regValue = leftShift((write_pll_ctrl_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_79_64_mask = mask then
                read_pll_ctrl_79_64_value = data_low
            else
                read_pll_ctrl_79_64_value = (data_low - H8000_0000) and pll_ctrl_79_64_mask
            end If
        else
            read_pll_ctrl_79_64_value = data_low and pll_ctrl_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_79_64_value = &H0
        flag_pll_ctrl_79_64        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_95_80                             [15:0]           get_pll_ctrl_95_80
''                                                             set_pll_ctrl_95_80
''                                                             read_pll_ctrl_95_80
''                                                             write_pll_ctrl_95_80
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl5
    Private write_pll_ctrl_95_80_value
    Private read_pll_ctrl_95_80_value
    Private flag_pll_ctrl_95_80

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

    Property Get get_pll_ctrl_95_80
        get_pll_ctrl_95_80 = read_pll_ctrl_95_80_value
    End Property

    Property Let set_pll_ctrl_95_80(aData)
        write_pll_ctrl_95_80_value = aData
        flag_pll_ctrl_95_80        = &H1
    End Property

    Property Get read_pll_ctrl_95_80
        read
        read_pll_ctrl_95_80 = read_pll_ctrl_95_80_value
    End Property

    Property Let write_pll_ctrl_95_80(aData)
        set_pll_ctrl_95_80 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_95_80_mask = mask then
                read_pll_ctrl_95_80_value = data_low
            else
                read_pll_ctrl_95_80_value = (data_low - H8000_0000) and pll_ctrl_95_80_mask
            end If
        else
            read_pll_ctrl_95_80_value = data_low and pll_ctrl_95_80_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_95_80 = &H0 Then read
        If flag_pll_ctrl_95_80 = &H0 Then write_pll_ctrl_95_80_value = get_pll_ctrl_95_80

        regValue = leftShift((write_pll_ctrl_95_80_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_95_80_mask = mask then
                read_pll_ctrl_95_80_value = data_low
            else
                read_pll_ctrl_95_80_value = (data_low - H8000_0000) and pll_ctrl_95_80_mask
            end If
        else
            read_pll_ctrl_95_80_value = data_low and pll_ctrl_95_80_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_95_80_value = &H0
        flag_pll_ctrl_95_80        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_111_96                            [15:0]           get_pll_ctrl_111_96
''                                                             set_pll_ctrl_111_96
''                                                             read_pll_ctrl_111_96
''                                                             write_pll_ctrl_111_96
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl6
    Private write_pll_ctrl_111_96_value
    Private read_pll_ctrl_111_96_value
    Private flag_pll_ctrl_111_96

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

    Property Get get_pll_ctrl_111_96
        get_pll_ctrl_111_96 = read_pll_ctrl_111_96_value
    End Property

    Property Let set_pll_ctrl_111_96(aData)
        write_pll_ctrl_111_96_value = aData
        flag_pll_ctrl_111_96        = &H1
    End Property

    Property Get read_pll_ctrl_111_96
        read
        read_pll_ctrl_111_96 = read_pll_ctrl_111_96_value
    End Property

    Property Let write_pll_ctrl_111_96(aData)
        set_pll_ctrl_111_96 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_111_96_mask = mask then
                read_pll_ctrl_111_96_value = data_low
            else
                read_pll_ctrl_111_96_value = (data_low - H8000_0000) and pll_ctrl_111_96_mask
            end If
        else
            read_pll_ctrl_111_96_value = data_low and pll_ctrl_111_96_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_111_96 = &H0 Then read
        If flag_pll_ctrl_111_96 = &H0 Then write_pll_ctrl_111_96_value = get_pll_ctrl_111_96

        regValue = leftShift((write_pll_ctrl_111_96_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_111_96_mask = mask then
                read_pll_ctrl_111_96_value = data_low
            else
                read_pll_ctrl_111_96_value = (data_low - H8000_0000) and pll_ctrl_111_96_mask
            end If
        else
            read_pll_ctrl_111_96_value = data_low and pll_ctrl_111_96_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_111_96_value = &H0
        flag_pll_ctrl_111_96        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_127_112                           [15:0]           get_pll_ctrl_127_112
''                                                             set_pll_ctrl_127_112
''                                                             read_pll_ctrl_127_112
''                                                             write_pll_ctrl_127_112
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl7
    Private write_pll_ctrl_127_112_value
    Private read_pll_ctrl_127_112_value
    Private flag_pll_ctrl_127_112

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

    Property Get get_pll_ctrl_127_112
        get_pll_ctrl_127_112 = read_pll_ctrl_127_112_value
    End Property

    Property Let set_pll_ctrl_127_112(aData)
        write_pll_ctrl_127_112_value = aData
        flag_pll_ctrl_127_112        = &H1
    End Property

    Property Get read_pll_ctrl_127_112
        read
        read_pll_ctrl_127_112 = read_pll_ctrl_127_112_value
    End Property

    Property Let write_pll_ctrl_127_112(aData)
        set_pll_ctrl_127_112 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_127_112_mask = mask then
                read_pll_ctrl_127_112_value = data_low
            else
                read_pll_ctrl_127_112_value = (data_low - H8000_0000) and pll_ctrl_127_112_mask
            end If
        else
            read_pll_ctrl_127_112_value = data_low and pll_ctrl_127_112_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_127_112 = &H0 Then read
        If flag_pll_ctrl_127_112 = &H0 Then write_pll_ctrl_127_112_value = get_pll_ctrl_127_112

        regValue = leftShift((write_pll_ctrl_127_112_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_127_112_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_127_112_mask = mask then
                read_pll_ctrl_127_112_value = data_low
            else
                read_pll_ctrl_127_112_value = (data_low - H8000_0000) and pll_ctrl_127_112_mask
            end If
        else
            read_pll_ctrl_127_112_value = data_low and pll_ctrl_127_112_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_127_112_value = &H0
        flag_pll_ctrl_127_112        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_ctrl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_143_128                           [15:0]           get_pll_ctrl_143_128
''                                                             set_pll_ctrl_143_128
''                                                             read_pll_ctrl_143_128
''                                                             write_pll_ctrl_143_128
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl8
    Private write_pll_ctrl_143_128_value
    Private read_pll_ctrl_143_128_value
    Private flag_pll_ctrl_143_128

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

    Property Get get_pll_ctrl_143_128
        get_pll_ctrl_143_128 = read_pll_ctrl_143_128_value
    End Property

    Property Let set_pll_ctrl_143_128(aData)
        write_pll_ctrl_143_128_value = aData
        flag_pll_ctrl_143_128        = &H1
    End Property

    Property Get read_pll_ctrl_143_128
        read
        read_pll_ctrl_143_128 = read_pll_ctrl_143_128_value
    End Property

    Property Let write_pll_ctrl_143_128(aData)
        set_pll_ctrl_143_128 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_143_128_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_143_128_mask = mask then
                read_pll_ctrl_143_128_value = data_low
            else
                read_pll_ctrl_143_128_value = (data_low - H8000_0000) and pll_ctrl_143_128_mask
            end If
        else
            read_pll_ctrl_143_128_value = data_low and pll_ctrl_143_128_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_143_128 = &H0 Then read
        If flag_pll_ctrl_143_128 = &H0 Then write_pll_ctrl_143_128_value = get_pll_ctrl_143_128

        regValue = leftShift((write_pll_ctrl_143_128_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_143_128_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_143_128_mask = mask then
                read_pll_ctrl_143_128_value = data_low
            else
                read_pll_ctrl_143_128_value = (data_low - H8000_0000) and pll_ctrl_143_128_mask
            end If
        else
            read_pll_ctrl_143_128_value = data_low and pll_ctrl_143_128_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_143_128_value = &H0
        flag_pll_ctrl_143_128        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE0__SGMIIPCIE_X1_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' anaPllAStatus1                             [15:0]           get_anaPllAStatus1
''                                                             set_anaPllAStatus1
''                                                             read_anaPllAStatus1
''                                                             write_anaPllAStatus1
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE0__SGMIIPCIE_X1_status1
    Private write_anaPllAStatus1_value
    Private read_anaPllAStatus1_value
    Private flag_anaPllAStatus1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_anaPllAStatus1
        get_anaPllAStatus1 = read_anaPllAStatus1_value
    End Property

    Property Let set_anaPllAStatus1(aData)
        write_anaPllAStatus1_value = aData
        flag_anaPllAStatus1        = &H1
    End Property

    Property Get read_anaPllAStatus1
        read
        read_anaPllAStatus1 = read_anaPllAStatus1_value
    End Property

    Property Let write_anaPllAStatus1(aData)
        set_anaPllAStatus1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPllAStatus1_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPllAStatus1_mask = mask then
                read_anaPllAStatus1_value = data_low
            else
                read_anaPllAStatus1_value = (data_low - H8000_0000) and anaPllAStatus1_mask
            end If
        else
            read_anaPllAStatus1_value = data_low and anaPllAStatus1_mask
        end If

    End Sub

    Sub write
        If flag_anaPllAStatus1 = &H0 Then read
        If flag_anaPllAStatus1 = &H0 Then write_anaPllAStatus1_value = get_anaPllAStatus1

        regValue = leftShift((write_anaPllAStatus1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPllAStatus1_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPllAStatus1_mask = mask then
                read_anaPllAStatus1_value = data_low
            else
                read_anaPllAStatus1_value = (data_low - H8000_0000) and anaPllAStatus1_mask
            end If
        else
            read_anaPllAStatus1_value = data_low and anaPllAStatus1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_anaPllAStatus1_value = &H0
        flag_anaPllAStatus1        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PLL_AFE0__SGMIIPCIE_X1_INSTANCE

    Public ctrl0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public ctrl4
    Public ctrl5
    Public ctrl6
    Public ctrl7
    Public ctrl8
    Public status1


    Public default function Init(aBaseAddr)
        Set ctrl0 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl3)(aBaseAddr, 16)
        Set ctrl4 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl4)(aBaseAddr, 16)
        Set ctrl5 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl5)(aBaseAddr, 16)
        Set ctrl6 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl6)(aBaseAddr, 16)
        Set ctrl7 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl7)(aBaseAddr, 16)
        Set ctrl8 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_ctrl8)(aBaseAddr, 16)
        Set status1 = (New REGISTER_PLL_AFE0__SGMIIPCIE_X1_status1)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PLL_AFE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PLL_AFE0__SGMIIPCIE_X1.Add ((New PLL_AFE0__SGMIIPCIE_X1_INSTANCE)(&H4ade4000))


