

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


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_15_0_ep                           [15:0]           get_pll_ctrl_15_0_ep
''                                                             set_pll_ctrl_15_0_ep
''                                                             read_pll_ctrl_15_0_ep
''                                                             write_pll_ctrl_15_0_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl0
    Private write_pll_ctrl_15_0_ep_value
    Private read_pll_ctrl_15_0_ep_value
    Private flag_pll_ctrl_15_0_ep

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

    Property Get get_pll_ctrl_15_0_ep
        get_pll_ctrl_15_0_ep = read_pll_ctrl_15_0_ep_value
    End Property

    Property Let set_pll_ctrl_15_0_ep(aData)
        write_pll_ctrl_15_0_ep_value = aData
        flag_pll_ctrl_15_0_ep        = &H1
    End Property

    Property Get read_pll_ctrl_15_0_ep
        read
        read_pll_ctrl_15_0_ep = read_pll_ctrl_15_0_ep_value
    End Property

    Property Let write_pll_ctrl_15_0_ep(aData)
        set_pll_ctrl_15_0_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_15_0_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_15_0_ep_mask = mask then
                read_pll_ctrl_15_0_ep_value = data_low
            else
                read_pll_ctrl_15_0_ep_value = (data_low - H8000_0000) and pll_ctrl_15_0_ep_mask
            end If
        else
            read_pll_ctrl_15_0_ep_value = data_low and pll_ctrl_15_0_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_15_0_ep = &H0 Then read
        If flag_pll_ctrl_15_0_ep = &H0 Then write_pll_ctrl_15_0_ep_value = get_pll_ctrl_15_0_ep

        regValue = leftShift((write_pll_ctrl_15_0_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_15_0_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_15_0_ep_mask = mask then
                read_pll_ctrl_15_0_ep_value = data_low
            else
                read_pll_ctrl_15_0_ep_value = (data_low - H8000_0000) and pll_ctrl_15_0_ep_mask
            end If
        else
            read_pll_ctrl_15_0_ep_value = data_low and pll_ctrl_15_0_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_15_0_ep_value = &H0
        flag_pll_ctrl_15_0_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_31_16_ep                          [15:0]           get_pll_ctrl_31_16_ep
''                                                             set_pll_ctrl_31_16_ep
''                                                             read_pll_ctrl_31_16_ep
''                                                             write_pll_ctrl_31_16_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl1
    Private write_pll_ctrl_31_16_ep_value
    Private read_pll_ctrl_31_16_ep_value
    Private flag_pll_ctrl_31_16_ep

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

    Property Get get_pll_ctrl_31_16_ep
        get_pll_ctrl_31_16_ep = read_pll_ctrl_31_16_ep_value
    End Property

    Property Let set_pll_ctrl_31_16_ep(aData)
        write_pll_ctrl_31_16_ep_value = aData
        flag_pll_ctrl_31_16_ep        = &H1
    End Property

    Property Get read_pll_ctrl_31_16_ep
        read
        read_pll_ctrl_31_16_ep = read_pll_ctrl_31_16_ep_value
    End Property

    Property Let write_pll_ctrl_31_16_ep(aData)
        set_pll_ctrl_31_16_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_31_16_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_31_16_ep_mask = mask then
                read_pll_ctrl_31_16_ep_value = data_low
            else
                read_pll_ctrl_31_16_ep_value = (data_low - H8000_0000) and pll_ctrl_31_16_ep_mask
            end If
        else
            read_pll_ctrl_31_16_ep_value = data_low and pll_ctrl_31_16_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_31_16_ep = &H0 Then read
        If flag_pll_ctrl_31_16_ep = &H0 Then write_pll_ctrl_31_16_ep_value = get_pll_ctrl_31_16_ep

        regValue = leftShift((write_pll_ctrl_31_16_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_31_16_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_31_16_ep_mask = mask then
                read_pll_ctrl_31_16_ep_value = data_low
            else
                read_pll_ctrl_31_16_ep_value = (data_low - H8000_0000) and pll_ctrl_31_16_ep_mask
            end If
        else
            read_pll_ctrl_31_16_ep_value = data_low and pll_ctrl_31_16_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_31_16_ep_value = &H0
        flag_pll_ctrl_31_16_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_47_32_ep                          [15:0]           get_pll_ctrl_47_32_ep
''                                                             set_pll_ctrl_47_32_ep
''                                                             read_pll_ctrl_47_32_ep
''                                                             write_pll_ctrl_47_32_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl2
    Private write_pll_ctrl_47_32_ep_value
    Private read_pll_ctrl_47_32_ep_value
    Private flag_pll_ctrl_47_32_ep

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

    Property Get get_pll_ctrl_47_32_ep
        get_pll_ctrl_47_32_ep = read_pll_ctrl_47_32_ep_value
    End Property

    Property Let set_pll_ctrl_47_32_ep(aData)
        write_pll_ctrl_47_32_ep_value = aData
        flag_pll_ctrl_47_32_ep        = &H1
    End Property

    Property Get read_pll_ctrl_47_32_ep
        read
        read_pll_ctrl_47_32_ep = read_pll_ctrl_47_32_ep_value
    End Property

    Property Let write_pll_ctrl_47_32_ep(aData)
        set_pll_ctrl_47_32_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_47_32_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_47_32_ep_mask = mask then
                read_pll_ctrl_47_32_ep_value = data_low
            else
                read_pll_ctrl_47_32_ep_value = (data_low - H8000_0000) and pll_ctrl_47_32_ep_mask
            end If
        else
            read_pll_ctrl_47_32_ep_value = data_low and pll_ctrl_47_32_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_47_32_ep = &H0 Then read
        If flag_pll_ctrl_47_32_ep = &H0 Then write_pll_ctrl_47_32_ep_value = get_pll_ctrl_47_32_ep

        regValue = leftShift((write_pll_ctrl_47_32_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_47_32_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_47_32_ep_mask = mask then
                read_pll_ctrl_47_32_ep_value = data_low
            else
                read_pll_ctrl_47_32_ep_value = (data_low - H8000_0000) and pll_ctrl_47_32_ep_mask
            end If
        else
            read_pll_ctrl_47_32_ep_value = data_low and pll_ctrl_47_32_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_47_32_ep_value = &H0
        flag_pll_ctrl_47_32_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_63_48_ep                          [15:0]           get_pll_ctrl_63_48_ep
''                                                             set_pll_ctrl_63_48_ep
''                                                             read_pll_ctrl_63_48_ep
''                                                             write_pll_ctrl_63_48_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl3
    Private write_pll_ctrl_63_48_ep_value
    Private read_pll_ctrl_63_48_ep_value
    Private flag_pll_ctrl_63_48_ep

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

    Property Get get_pll_ctrl_63_48_ep
        get_pll_ctrl_63_48_ep = read_pll_ctrl_63_48_ep_value
    End Property

    Property Let set_pll_ctrl_63_48_ep(aData)
        write_pll_ctrl_63_48_ep_value = aData
        flag_pll_ctrl_63_48_ep        = &H1
    End Property

    Property Get read_pll_ctrl_63_48_ep
        read
        read_pll_ctrl_63_48_ep = read_pll_ctrl_63_48_ep_value
    End Property

    Property Let write_pll_ctrl_63_48_ep(aData)
        set_pll_ctrl_63_48_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_63_48_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_63_48_ep_mask = mask then
                read_pll_ctrl_63_48_ep_value = data_low
            else
                read_pll_ctrl_63_48_ep_value = (data_low - H8000_0000) and pll_ctrl_63_48_ep_mask
            end If
        else
            read_pll_ctrl_63_48_ep_value = data_low and pll_ctrl_63_48_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_63_48_ep = &H0 Then read
        If flag_pll_ctrl_63_48_ep = &H0 Then write_pll_ctrl_63_48_ep_value = get_pll_ctrl_63_48_ep

        regValue = leftShift((write_pll_ctrl_63_48_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_63_48_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_63_48_ep_mask = mask then
                read_pll_ctrl_63_48_ep_value = data_low
            else
                read_pll_ctrl_63_48_ep_value = (data_low - H8000_0000) and pll_ctrl_63_48_ep_mask
            end If
        else
            read_pll_ctrl_63_48_ep_value = data_low and pll_ctrl_63_48_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_63_48_ep_value = &H0
        flag_pll_ctrl_63_48_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_79_64_ep                          [15:0]           get_pll_ctrl_79_64_ep
''                                                             set_pll_ctrl_79_64_ep
''                                                             read_pll_ctrl_79_64_ep
''                                                             write_pll_ctrl_79_64_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl4
    Private write_pll_ctrl_79_64_ep_value
    Private read_pll_ctrl_79_64_ep_value
    Private flag_pll_ctrl_79_64_ep

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

    Property Get get_pll_ctrl_79_64_ep
        get_pll_ctrl_79_64_ep = read_pll_ctrl_79_64_ep_value
    End Property

    Property Let set_pll_ctrl_79_64_ep(aData)
        write_pll_ctrl_79_64_ep_value = aData
        flag_pll_ctrl_79_64_ep        = &H1
    End Property

    Property Get read_pll_ctrl_79_64_ep
        read
        read_pll_ctrl_79_64_ep = read_pll_ctrl_79_64_ep_value
    End Property

    Property Let write_pll_ctrl_79_64_ep(aData)
        set_pll_ctrl_79_64_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_79_64_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_79_64_ep_mask = mask then
                read_pll_ctrl_79_64_ep_value = data_low
            else
                read_pll_ctrl_79_64_ep_value = (data_low - H8000_0000) and pll_ctrl_79_64_ep_mask
            end If
        else
            read_pll_ctrl_79_64_ep_value = data_low and pll_ctrl_79_64_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_79_64_ep = &H0 Then read
        If flag_pll_ctrl_79_64_ep = &H0 Then write_pll_ctrl_79_64_ep_value = get_pll_ctrl_79_64_ep

        regValue = leftShift((write_pll_ctrl_79_64_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_79_64_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_79_64_ep_mask = mask then
                read_pll_ctrl_79_64_ep_value = data_low
            else
                read_pll_ctrl_79_64_ep_value = (data_low - H8000_0000) and pll_ctrl_79_64_ep_mask
            end If
        else
            read_pll_ctrl_79_64_ep_value = data_low and pll_ctrl_79_64_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_79_64_ep_value = &H0
        flag_pll_ctrl_79_64_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_95_80_ep                          [15:0]           get_pll_ctrl_95_80_ep
''                                                             set_pll_ctrl_95_80_ep
''                                                             read_pll_ctrl_95_80_ep
''                                                             write_pll_ctrl_95_80_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl5
    Private write_pll_ctrl_95_80_ep_value
    Private read_pll_ctrl_95_80_ep_value
    Private flag_pll_ctrl_95_80_ep

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

    Property Get get_pll_ctrl_95_80_ep
        get_pll_ctrl_95_80_ep = read_pll_ctrl_95_80_ep_value
    End Property

    Property Let set_pll_ctrl_95_80_ep(aData)
        write_pll_ctrl_95_80_ep_value = aData
        flag_pll_ctrl_95_80_ep        = &H1
    End Property

    Property Get read_pll_ctrl_95_80_ep
        read
        read_pll_ctrl_95_80_ep = read_pll_ctrl_95_80_ep_value
    End Property

    Property Let write_pll_ctrl_95_80_ep(aData)
        set_pll_ctrl_95_80_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_95_80_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_95_80_ep_mask = mask then
                read_pll_ctrl_95_80_ep_value = data_low
            else
                read_pll_ctrl_95_80_ep_value = (data_low - H8000_0000) and pll_ctrl_95_80_ep_mask
            end If
        else
            read_pll_ctrl_95_80_ep_value = data_low and pll_ctrl_95_80_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_95_80_ep = &H0 Then read
        If flag_pll_ctrl_95_80_ep = &H0 Then write_pll_ctrl_95_80_ep_value = get_pll_ctrl_95_80_ep

        regValue = leftShift((write_pll_ctrl_95_80_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_95_80_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_95_80_ep_mask = mask then
                read_pll_ctrl_95_80_ep_value = data_low
            else
                read_pll_ctrl_95_80_ep_value = (data_low - H8000_0000) and pll_ctrl_95_80_ep_mask
            end If
        else
            read_pll_ctrl_95_80_ep_value = data_low and pll_ctrl_95_80_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_95_80_ep_value = &H0
        flag_pll_ctrl_95_80_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_111_96_ep                         [15:0]           get_pll_ctrl_111_96_ep
''                                                             set_pll_ctrl_111_96_ep
''                                                             read_pll_ctrl_111_96_ep
''                                                             write_pll_ctrl_111_96_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl6
    Private write_pll_ctrl_111_96_ep_value
    Private read_pll_ctrl_111_96_ep_value
    Private flag_pll_ctrl_111_96_ep

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

    Property Get get_pll_ctrl_111_96_ep
        get_pll_ctrl_111_96_ep = read_pll_ctrl_111_96_ep_value
    End Property

    Property Let set_pll_ctrl_111_96_ep(aData)
        write_pll_ctrl_111_96_ep_value = aData
        flag_pll_ctrl_111_96_ep        = &H1
    End Property

    Property Get read_pll_ctrl_111_96_ep
        read
        read_pll_ctrl_111_96_ep = read_pll_ctrl_111_96_ep_value
    End Property

    Property Let write_pll_ctrl_111_96_ep(aData)
        set_pll_ctrl_111_96_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_111_96_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_111_96_ep_mask = mask then
                read_pll_ctrl_111_96_ep_value = data_low
            else
                read_pll_ctrl_111_96_ep_value = (data_low - H8000_0000) and pll_ctrl_111_96_ep_mask
            end If
        else
            read_pll_ctrl_111_96_ep_value = data_low and pll_ctrl_111_96_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_111_96_ep = &H0 Then read
        If flag_pll_ctrl_111_96_ep = &H0 Then write_pll_ctrl_111_96_ep_value = get_pll_ctrl_111_96_ep

        regValue = leftShift((write_pll_ctrl_111_96_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_111_96_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_111_96_ep_mask = mask then
                read_pll_ctrl_111_96_ep_value = data_low
            else
                read_pll_ctrl_111_96_ep_value = (data_low - H8000_0000) and pll_ctrl_111_96_ep_mask
            end If
        else
            read_pll_ctrl_111_96_ep_value = data_low and pll_ctrl_111_96_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_111_96_ep_value = &H0
        flag_pll_ctrl_111_96_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_127_112_ep                        [15:0]           get_pll_ctrl_127_112_ep
''                                                             set_pll_ctrl_127_112_ep
''                                                             read_pll_ctrl_127_112_ep
''                                                             write_pll_ctrl_127_112_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl7
    Private write_pll_ctrl_127_112_ep_value
    Private read_pll_ctrl_127_112_ep_value
    Private flag_pll_ctrl_127_112_ep

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

    Property Get get_pll_ctrl_127_112_ep
        get_pll_ctrl_127_112_ep = read_pll_ctrl_127_112_ep_value
    End Property

    Property Let set_pll_ctrl_127_112_ep(aData)
        write_pll_ctrl_127_112_ep_value = aData
        flag_pll_ctrl_127_112_ep        = &H1
    End Property

    Property Get read_pll_ctrl_127_112_ep
        read
        read_pll_ctrl_127_112_ep = read_pll_ctrl_127_112_ep_value
    End Property

    Property Let write_pll_ctrl_127_112_ep(aData)
        set_pll_ctrl_127_112_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_127_112_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_127_112_ep_mask = mask then
                read_pll_ctrl_127_112_ep_value = data_low
            else
                read_pll_ctrl_127_112_ep_value = (data_low - H8000_0000) and pll_ctrl_127_112_ep_mask
            end If
        else
            read_pll_ctrl_127_112_ep_value = data_low and pll_ctrl_127_112_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_127_112_ep = &H0 Then read
        If flag_pll_ctrl_127_112_ep = &H0 Then write_pll_ctrl_127_112_ep_value = get_pll_ctrl_127_112_ep

        regValue = leftShift((write_pll_ctrl_127_112_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_127_112_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_127_112_ep_mask = mask then
                read_pll_ctrl_127_112_ep_value = data_low
            else
                read_pll_ctrl_127_112_ep_value = (data_low - H8000_0000) and pll_ctrl_127_112_ep_mask
            end If
        else
            read_pll_ctrl_127_112_ep_value = data_low and pll_ctrl_127_112_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_127_112_ep_value = &H0
        flag_pll_ctrl_127_112_ep        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE1__SGMIIPCIE_X1_ep_ctrl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl_143_128_ep                        [15:0]           get_pll_ctrl_143_128_ep
''                                                             set_pll_ctrl_143_128_ep
''                                                             read_pll_ctrl_143_128_ep
''                                                             write_pll_ctrl_143_128_ep
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl8
    Private write_pll_ctrl_143_128_ep_value
    Private read_pll_ctrl_143_128_ep_value
    Private flag_pll_ctrl_143_128_ep

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

    Property Get get_pll_ctrl_143_128_ep
        get_pll_ctrl_143_128_ep = read_pll_ctrl_143_128_ep_value
    End Property

    Property Let set_pll_ctrl_143_128_ep(aData)
        write_pll_ctrl_143_128_ep_value = aData
        flag_pll_ctrl_143_128_ep        = &H1
    End Property

    Property Get read_pll_ctrl_143_128_ep
        read
        read_pll_ctrl_143_128_ep = read_pll_ctrl_143_128_ep_value
    End Property

    Property Let write_pll_ctrl_143_128_ep(aData)
        set_pll_ctrl_143_128_ep = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_143_128_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_143_128_ep_mask = mask then
                read_pll_ctrl_143_128_ep_value = data_low
            else
                read_pll_ctrl_143_128_ep_value = (data_low - H8000_0000) and pll_ctrl_143_128_ep_mask
            end If
        else
            read_pll_ctrl_143_128_ep_value = data_low and pll_ctrl_143_128_ep_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl_143_128_ep = &H0 Then read
        If flag_pll_ctrl_143_128_ep = &H0 Then write_pll_ctrl_143_128_ep_value = get_pll_ctrl_143_128_ep

        regValue = leftShift((write_pll_ctrl_143_128_ep_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl_143_128_ep_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl_143_128_ep_mask = mask then
                read_pll_ctrl_143_128_ep_value = data_low
            else
                read_pll_ctrl_143_128_ep_value = (data_low - H8000_0000) and pll_ctrl_143_128_ep_mask
            end If
        else
            read_pll_ctrl_143_128_ep_value = data_low and pll_ctrl_143_128_ep_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl_143_128_ep_value = &H0
        flag_pll_ctrl_143_128_ep        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PLL_AFE1__SGMIIPCIE_X1_INSTANCE

    Public ep_ctrl0
    Public ep_ctrl1
    Public ep_ctrl2
    Public ep_ctrl3
    Public ep_ctrl4
    Public ep_ctrl5
    Public ep_ctrl6
    Public ep_ctrl7
    Public ep_ctrl8


    Public default function Init(aBaseAddr)
        Set ep_ctrl0 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl0)(aBaseAddr, 16)
        Set ep_ctrl1 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl1)(aBaseAddr, 16)
        Set ep_ctrl2 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl2)(aBaseAddr, 16)
        Set ep_ctrl3 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl3)(aBaseAddr, 16)
        Set ep_ctrl4 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl4)(aBaseAddr, 16)
        Set ep_ctrl5 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl5)(aBaseAddr, 16)
        Set ep_ctrl6 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl6)(aBaseAddr, 16)
        Set ep_ctrl7 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl7)(aBaseAddr, 16)
        Set ep_ctrl8 = (New REGISTER_PLL_AFE1__SGMIIPCIE_X1_ep_ctrl8)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PLL_AFE1__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PLL_AFE1__SGMIIPCIE_X1.Add ((New PLL_AFE1__SGMIIPCIE_X1_INSTANCE)(&H4ade4200))


