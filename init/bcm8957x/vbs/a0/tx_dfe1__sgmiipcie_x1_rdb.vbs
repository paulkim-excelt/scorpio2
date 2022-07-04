

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


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata0                                     [15:0]           get_mdata0
''                                                             set_mdata0
''                                                             read_mdata0
''                                                             write_mdata0
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata0
    Private write_mdata0_value
    Private read_mdata0_value
    Private flag_mdata0

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

    Property Get get_mdata0
        get_mdata0 = read_mdata0_value
    End Property

    Property Let set_mdata0(aData)
        write_mdata0_value = aData
        flag_mdata0        = &H1
    End Property

    Property Get read_mdata0
        read
        read_mdata0 = read_mdata0_value
    End Property

    Property Let write_mdata0(aData)
        set_mdata0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata0_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata0_mask = mask then
                read_mdata0_value = data_low
            else
                read_mdata0_value = (data_low - H8000_0000) and mdata0_mask
            end If
        else
            read_mdata0_value = data_low and mdata0_mask
        end If

    End Sub

    Sub write
        If flag_mdata0 = &H0 Then read
        If flag_mdata0 = &H0 Then write_mdata0_value = get_mdata0

        regValue = leftShift((write_mdata0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata0_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata0_mask = mask then
                read_mdata0_value = data_low
            else
                read_mdata0_value = (data_low - H8000_0000) and mdata0_mask
            end If
        else
            read_mdata0_value = data_low and mdata0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata0_value = &H0
        flag_mdata0        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata1                                     [15:0]           get_mdata1
''                                                             set_mdata1
''                                                             read_mdata1
''                                                             write_mdata1
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata1
    Private write_mdata1_value
    Private read_mdata1_value
    Private flag_mdata1

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

    Property Get get_mdata1
        get_mdata1 = read_mdata1_value
    End Property

    Property Let set_mdata1(aData)
        write_mdata1_value = aData
        flag_mdata1        = &H1
    End Property

    Property Get read_mdata1
        read
        read_mdata1 = read_mdata1_value
    End Property

    Property Let write_mdata1(aData)
        set_mdata1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata1_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata1_mask = mask then
                read_mdata1_value = data_low
            else
                read_mdata1_value = (data_low - H8000_0000) and mdata1_mask
            end If
        else
            read_mdata1_value = data_low and mdata1_mask
        end If

    End Sub

    Sub write
        If flag_mdata1 = &H0 Then read
        If flag_mdata1 = &H0 Then write_mdata1_value = get_mdata1

        regValue = leftShift((write_mdata1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata1_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata1_mask = mask then
                read_mdata1_value = data_low
            else
                read_mdata1_value = (data_low - H8000_0000) and mdata1_mask
            end If
        else
            read_mdata1_value = data_low and mdata1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata1_value = &H0
        flag_mdata1        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata2                                     [15:0]           get_mdata2
''                                                             set_mdata2
''                                                             read_mdata2
''                                                             write_mdata2
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata2
    Private write_mdata2_value
    Private read_mdata2_value
    Private flag_mdata2

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

    Property Get get_mdata2
        get_mdata2 = read_mdata2_value
    End Property

    Property Let set_mdata2(aData)
        write_mdata2_value = aData
        flag_mdata2        = &H1
    End Property

    Property Get read_mdata2
        read
        read_mdata2 = read_mdata2_value
    End Property

    Property Let write_mdata2(aData)
        set_mdata2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata2_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata2_mask = mask then
                read_mdata2_value = data_low
            else
                read_mdata2_value = (data_low - H8000_0000) and mdata2_mask
            end If
        else
            read_mdata2_value = data_low and mdata2_mask
        end If

    End Sub

    Sub write
        If flag_mdata2 = &H0 Then read
        If flag_mdata2 = &H0 Then write_mdata2_value = get_mdata2

        regValue = leftShift((write_mdata2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata2_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata2_mask = mask then
                read_mdata2_value = data_low
            else
                read_mdata2_value = (data_low - H8000_0000) and mdata2_mask
            end If
        else
            read_mdata2_value = data_low and mdata2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata2_value = &H0
        flag_mdata2        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata3                                     [15:0]           get_mdata3
''                                                             set_mdata3
''                                                             read_mdata3
''                                                             write_mdata3
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata3
    Private write_mdata3_value
    Private read_mdata3_value
    Private flag_mdata3

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

    Property Get get_mdata3
        get_mdata3 = read_mdata3_value
    End Property

    Property Let set_mdata3(aData)
        write_mdata3_value = aData
        flag_mdata3        = &H1
    End Property

    Property Get read_mdata3
        read
        read_mdata3 = read_mdata3_value
    End Property

    Property Let write_mdata3(aData)
        set_mdata3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata3_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata3_mask = mask then
                read_mdata3_value = data_low
            else
                read_mdata3_value = (data_low - H8000_0000) and mdata3_mask
            end If
        else
            read_mdata3_value = data_low and mdata3_mask
        end If

    End Sub

    Sub write
        If flag_mdata3 = &H0 Then read
        If flag_mdata3 = &H0 Then write_mdata3_value = get_mdata3

        regValue = leftShift((write_mdata3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata3_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata3_mask = mask then
                read_mdata3_value = data_low
            else
                read_mdata3_value = (data_low - H8000_0000) and mdata3_mask
            end If
        else
            read_mdata3_value = data_low and mdata3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata3_value = &H0
        flag_mdata3        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata4                                     [15:0]           get_mdata4
''                                                             set_mdata4
''                                                             read_mdata4
''                                                             write_mdata4
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata4
    Private write_mdata4_value
    Private read_mdata4_value
    Private flag_mdata4

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

    Property Get get_mdata4
        get_mdata4 = read_mdata4_value
    End Property

    Property Let set_mdata4(aData)
        write_mdata4_value = aData
        flag_mdata4        = &H1
    End Property

    Property Get read_mdata4
        read
        read_mdata4 = read_mdata4_value
    End Property

    Property Let write_mdata4(aData)
        set_mdata4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata4_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata4_mask = mask then
                read_mdata4_value = data_low
            else
                read_mdata4_value = (data_low - H8000_0000) and mdata4_mask
            end If
        else
            read_mdata4_value = data_low and mdata4_mask
        end If

    End Sub

    Sub write
        If flag_mdata4 = &H0 Then read
        If flag_mdata4 = &H0 Then write_mdata4_value = get_mdata4

        regValue = leftShift((write_mdata4_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata4_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata4_mask = mask then
                read_mdata4_value = data_low
            else
                read_mdata4_value = (data_low - H8000_0000) and mdata4_mask
            end If
        else
            read_mdata4_value = data_low and mdata4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata4_value = &H0
        flag_mdata4        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata5                                     [15:0]           get_mdata5
''                                                             set_mdata5
''                                                             read_mdata5
''                                                             write_mdata5
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata5
    Private write_mdata5_value
    Private read_mdata5_value
    Private flag_mdata5

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

    Property Get get_mdata5
        get_mdata5 = read_mdata5_value
    End Property

    Property Let set_mdata5(aData)
        write_mdata5_value = aData
        flag_mdata5        = &H1
    End Property

    Property Get read_mdata5
        read
        read_mdata5 = read_mdata5_value
    End Property

    Property Let write_mdata5(aData)
        set_mdata5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata5_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata5_mask = mask then
                read_mdata5_value = data_low
            else
                read_mdata5_value = (data_low - H8000_0000) and mdata5_mask
            end If
        else
            read_mdata5_value = data_low and mdata5_mask
        end If

    End Sub

    Sub write
        If flag_mdata5 = &H0 Then read
        If flag_mdata5 = &H0 Then write_mdata5_value = get_mdata5

        regValue = leftShift((write_mdata5_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata5_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata5_mask = mask then
                read_mdata5_value = data_low
            else
                read_mdata5_value = (data_low - H8000_0000) and mdata5_mask
            end If
        else
            read_mdata5_value = data_low and mdata5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata5_value = &H0
        flag_mdata5        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_mdata6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_patgen_ena                            [15:15]          get_mdio_patgen_ena
''                                                             set_mdio_patgen_ena
''                                                             read_mdio_patgen_ena
''                                                             write_mdio_patgen_ena
''---------------------------------------------------------------------------------
'' mdata6                                     [3:0]            get_mdata6
''                                                             set_mdata6
''                                                             read_mdata6
''                                                             write_mdata6
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata6
    Private write_mdio_patgen_ena_value
    Private read_mdio_patgen_ena_value
    Private flag_mdio_patgen_ena
    Private write_mdata6_value
    Private read_mdata6_value
    Private flag_mdata6

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

    Property Get get_mdio_patgen_ena
        get_mdio_patgen_ena = read_mdio_patgen_ena_value
    End Property

    Property Let set_mdio_patgen_ena(aData)
        write_mdio_patgen_ena_value = aData
        flag_mdio_patgen_ena        = &H1
    End Property

    Property Get read_mdio_patgen_ena
        read
        read_mdio_patgen_ena = read_mdio_patgen_ena_value
    End Property

    Property Let write_mdio_patgen_ena(aData)
        set_mdio_patgen_ena = aData
        write
    End Property

    Property Get get_mdata6
        get_mdata6 = read_mdata6_value
    End Property

    Property Let set_mdata6(aData)
        write_mdata6_value = aData
        flag_mdata6        = &H1
    End Property

    Property Get read_mdata6
        read
        read_mdata6 = read_mdata6_value
    End Property

    Property Let write_mdata6(aData)
        set_mdata6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_patgen_ena_value = rightShift(data_low, 15) and &H1
        mdata6_mask = &Hf
        if data_low > LONG_MAX then
            if mdata6_mask = mask then
                read_mdata6_value = data_low
            else
                read_mdata6_value = (data_low - H8000_0000) and mdata6_mask
            end If
        else
            read_mdata6_value = data_low and mdata6_mask
        end If

    End Sub

    Sub write
        If flag_mdio_patgen_ena = &H0 or flag_mdata6 = &H0 Then read
        If flag_mdio_patgen_ena = &H0 Then write_mdio_patgen_ena_value = get_mdio_patgen_ena
        If flag_mdata6 = &H0 Then write_mdata6_value = get_mdata6

        regValue = leftShift((write_mdio_patgen_ena_value and &H1), 15) + leftShift((write_mdata6_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_patgen_ena_value = rightShift(data_low, 15) and &H1
        mdata6_mask = &Hf
        if data_low > LONG_MAX then
            if mdata6_mask = mask then
                read_mdata6_value = data_low
            else
                read_mdata6_value = (data_low - H8000_0000) and mdata6_mask
            end If
        else
            read_mdata6_value = data_low and mdata6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_patgen_ena_value = &H0
        flag_mdio_patgen_ena        = &H0
        write_mdata6_value = &H0
        flag_mdata6        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_acontrol5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_emph0                                  [9:5]            get_pre_emph0
''                                                             set_pre_emph0
''                                                             read_pre_emph0
''                                                             write_pre_emph0
''---------------------------------------------------------------------------------
'' g1_volt_swing0                             [4:0]            get_g1_volt_swing0
''                                                             set_g1_volt_swing0
''                                                             read_g1_volt_swing0
''                                                             write_g1_volt_swing0
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_acontrol5
    Private write_pre_emph0_value
    Private read_pre_emph0_value
    Private flag_pre_emph0
    Private write_g1_volt_swing0_value
    Private read_g1_volt_swing0_value
    Private flag_g1_volt_swing0

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

    Property Get get_pre_emph0
        get_pre_emph0 = read_pre_emph0_value
    End Property

    Property Let set_pre_emph0(aData)
        write_pre_emph0_value = aData
        flag_pre_emph0        = &H1
    End Property

    Property Get read_pre_emph0
        read
        read_pre_emph0 = read_pre_emph0_value
    End Property

    Property Let write_pre_emph0(aData)
        set_pre_emph0 = aData
        write
    End Property

    Property Get get_g1_volt_swing0
        get_g1_volt_swing0 = read_g1_volt_swing0_value
    End Property

    Property Let set_g1_volt_swing0(aData)
        write_g1_volt_swing0_value = aData
        flag_g1_volt_swing0        = &H1
    End Property

    Property Get read_g1_volt_swing0
        read
        read_g1_volt_swing0 = read_g1_volt_swing0_value
    End Property

    Property Let write_g1_volt_swing0(aData)
        set_g1_volt_swing0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pre_emph0_value = rightShift(data_low, 5) and &H1f
        g1_volt_swing0_mask = &H1f
        if data_low > LONG_MAX then
            if g1_volt_swing0_mask = mask then
                read_g1_volt_swing0_value = data_low
            else
                read_g1_volt_swing0_value = (data_low - H8000_0000) and g1_volt_swing0_mask
            end If
        else
            read_g1_volt_swing0_value = data_low and g1_volt_swing0_mask
        end If

    End Sub

    Sub write
        If flag_pre_emph0 = &H0 or flag_g1_volt_swing0 = &H0 Then read
        If flag_pre_emph0 = &H0 Then write_pre_emph0_value = get_pre_emph0
        If flag_g1_volt_swing0 = &H0 Then write_g1_volt_swing0_value = get_g1_volt_swing0

        regValue = leftShift((write_pre_emph0_value and &H1f), 5) + leftShift((write_g1_volt_swing0_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pre_emph0_value = rightShift(data_low, 5) and &H1f
        g1_volt_swing0_mask = &H1f
        if data_low > LONG_MAX then
            if g1_volt_swing0_mask = mask then
                read_g1_volt_swing0_value = data_low
            else
                read_g1_volt_swing0_value = (data_low - H8000_0000) and g1_volt_swing0_mask
            end If
        else
            read_g1_volt_swing0_value = data_low and g1_volt_swing0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_emph0_value = &H0
        flag_pre_emph0        = &H0
        write_g1_volt_swing0_value = &H0
        flag_g1_volt_swing0        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_tcacontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tca_disable                                [12:12]          get_tca_disable
''                                                             set_tca_disable
''                                                             read_tca_disable
''                                                             write_tca_disable
''---------------------------------------------------------------------------------
'' tca_restart                                [11:11]          get_tca_restart
''                                                             set_tca_restart
''                                                             read_tca_restart
''                                                             write_tca_restart
''---------------------------------------------------------------------------------
'' tca_coarse_timer_kgain                     [10:9]           get_tca_coarse_timer_kgain
''                                                             set_tca_coarse_timer_kgain
''                                                             read_tca_coarse_timer_kgain
''                                                             write_tca_coarse_timer_kgain
''---------------------------------------------------------------------------------
'' tca_start_force                            [8:8]            get_tca_start_force
''                                                             set_tca_start_force
''                                                             read_tca_start_force
''                                                             write_tca_start_force
''---------------------------------------------------------------------------------
'' tca_start_force_val                        [7:7]            get_tca_start_force_val
''                                                             set_tca_start_force_val
''                                                             read_tca_start_force_val
''                                                             write_tca_start_force_val
''---------------------------------------------------------------------------------
'' tca_pe_os_force                            [6:6]            get_tca_pe_os_force
''                                                             set_tca_pe_os_force
''                                                             read_tca_pe_os_force
''                                                             write_tca_pe_os_force
''---------------------------------------------------------------------------------
'' tca_add_pdoffst                            [5:5]            get_tca_add_pdoffst
''                                                             set_tca_add_pdoffst
''                                                             read_tca_add_pdoffst
''                                                             write_tca_add_pdoffst
''---------------------------------------------------------------------------------
'' tca_k_force                                [4:4]            get_tca_k_force
''                                                             set_tca_k_force
''                                                             read_tca_k_force
''                                                             write_tca_k_force
''---------------------------------------------------------------------------------
'' tca_k_force_val                            [3:2]            get_tca_k_force_val
''                                                             set_tca_k_force_val
''                                                             read_tca_k_force_val
''                                                             write_tca_k_force_val
''---------------------------------------------------------------------------------
'' tca_pdout_inv                              [1:1]            get_tca_pdout_inv
''                                                             set_tca_pdout_inv
''                                                             read_tca_pdout_inv
''                                                             write_tca_pdout_inv
''---------------------------------------------------------------------------------
'' tca_phs_step_size                          [0:0]            get_tca_phs_step_size
''                                                             set_tca_phs_step_size
''                                                             read_tca_phs_step_size
''                                                             write_tca_phs_step_size
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_tcacontrol
    Private write_tca_disable_value
    Private read_tca_disable_value
    Private flag_tca_disable
    Private write_tca_restart_value
    Private read_tca_restart_value
    Private flag_tca_restart
    Private write_tca_coarse_timer_kgain_value
    Private read_tca_coarse_timer_kgain_value
    Private flag_tca_coarse_timer_kgain
    Private write_tca_start_force_value
    Private read_tca_start_force_value
    Private flag_tca_start_force
    Private write_tca_start_force_val_value
    Private read_tca_start_force_val_value
    Private flag_tca_start_force_val
    Private write_tca_pe_os_force_value
    Private read_tca_pe_os_force_value
    Private flag_tca_pe_os_force
    Private write_tca_add_pdoffst_value
    Private read_tca_add_pdoffst_value
    Private flag_tca_add_pdoffst
    Private write_tca_k_force_value
    Private read_tca_k_force_value
    Private flag_tca_k_force
    Private write_tca_k_force_val_value
    Private read_tca_k_force_val_value
    Private flag_tca_k_force_val
    Private write_tca_pdout_inv_value
    Private read_tca_pdout_inv_value
    Private flag_tca_pdout_inv
    Private write_tca_phs_step_size_value
    Private read_tca_phs_step_size_value
    Private flag_tca_phs_step_size

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

    Property Get get_tca_disable
        get_tca_disable = read_tca_disable_value
    End Property

    Property Let set_tca_disable(aData)
        write_tca_disable_value = aData
        flag_tca_disable        = &H1
    End Property

    Property Get read_tca_disable
        read
        read_tca_disable = read_tca_disable_value
    End Property

    Property Let write_tca_disable(aData)
        set_tca_disable = aData
        write
    End Property

    Property Get get_tca_restart
        get_tca_restart = read_tca_restart_value
    End Property

    Property Let set_tca_restart(aData)
        write_tca_restart_value = aData
        flag_tca_restart        = &H1
    End Property

    Property Get read_tca_restart
        read
        read_tca_restart = read_tca_restart_value
    End Property

    Property Let write_tca_restart(aData)
        set_tca_restart = aData
        write
    End Property

    Property Get get_tca_coarse_timer_kgain
        get_tca_coarse_timer_kgain = read_tca_coarse_timer_kgain_value
    End Property

    Property Let set_tca_coarse_timer_kgain(aData)
        write_tca_coarse_timer_kgain_value = aData
        flag_tca_coarse_timer_kgain        = &H1
    End Property

    Property Get read_tca_coarse_timer_kgain
        read
        read_tca_coarse_timer_kgain = read_tca_coarse_timer_kgain_value
    End Property

    Property Let write_tca_coarse_timer_kgain(aData)
        set_tca_coarse_timer_kgain = aData
        write
    End Property

    Property Get get_tca_start_force
        get_tca_start_force = read_tca_start_force_value
    End Property

    Property Let set_tca_start_force(aData)
        write_tca_start_force_value = aData
        flag_tca_start_force        = &H1
    End Property

    Property Get read_tca_start_force
        read
        read_tca_start_force = read_tca_start_force_value
    End Property

    Property Let write_tca_start_force(aData)
        set_tca_start_force = aData
        write
    End Property

    Property Get get_tca_start_force_val
        get_tca_start_force_val = read_tca_start_force_val_value
    End Property

    Property Let set_tca_start_force_val(aData)
        write_tca_start_force_val_value = aData
        flag_tca_start_force_val        = &H1
    End Property

    Property Get read_tca_start_force_val
        read
        read_tca_start_force_val = read_tca_start_force_val_value
    End Property

    Property Let write_tca_start_force_val(aData)
        set_tca_start_force_val = aData
        write
    End Property

    Property Get get_tca_pe_os_force
        get_tca_pe_os_force = read_tca_pe_os_force_value
    End Property

    Property Let set_tca_pe_os_force(aData)
        write_tca_pe_os_force_value = aData
        flag_tca_pe_os_force        = &H1
    End Property

    Property Get read_tca_pe_os_force
        read
        read_tca_pe_os_force = read_tca_pe_os_force_value
    End Property

    Property Let write_tca_pe_os_force(aData)
        set_tca_pe_os_force = aData
        write
    End Property

    Property Get get_tca_add_pdoffst
        get_tca_add_pdoffst = read_tca_add_pdoffst_value
    End Property

    Property Let set_tca_add_pdoffst(aData)
        write_tca_add_pdoffst_value = aData
        flag_tca_add_pdoffst        = &H1
    End Property

    Property Get read_tca_add_pdoffst
        read
        read_tca_add_pdoffst = read_tca_add_pdoffst_value
    End Property

    Property Let write_tca_add_pdoffst(aData)
        set_tca_add_pdoffst = aData
        write
    End Property

    Property Get get_tca_k_force
        get_tca_k_force = read_tca_k_force_value
    End Property

    Property Let set_tca_k_force(aData)
        write_tca_k_force_value = aData
        flag_tca_k_force        = &H1
    End Property

    Property Get read_tca_k_force
        read
        read_tca_k_force = read_tca_k_force_value
    End Property

    Property Let write_tca_k_force(aData)
        set_tca_k_force = aData
        write
    End Property

    Property Get get_tca_k_force_val
        get_tca_k_force_val = read_tca_k_force_val_value
    End Property

    Property Let set_tca_k_force_val(aData)
        write_tca_k_force_val_value = aData
        flag_tca_k_force_val        = &H1
    End Property

    Property Get read_tca_k_force_val
        read
        read_tca_k_force_val = read_tca_k_force_val_value
    End Property

    Property Let write_tca_k_force_val(aData)
        set_tca_k_force_val = aData
        write
    End Property

    Property Get get_tca_pdout_inv
        get_tca_pdout_inv = read_tca_pdout_inv_value
    End Property

    Property Let set_tca_pdout_inv(aData)
        write_tca_pdout_inv_value = aData
        flag_tca_pdout_inv        = &H1
    End Property

    Property Get read_tca_pdout_inv
        read
        read_tca_pdout_inv = read_tca_pdout_inv_value
    End Property

    Property Let write_tca_pdout_inv(aData)
        set_tca_pdout_inv = aData
        write
    End Property

    Property Get get_tca_phs_step_size
        get_tca_phs_step_size = read_tca_phs_step_size_value
    End Property

    Property Let set_tca_phs_step_size(aData)
        write_tca_phs_step_size_value = aData
        flag_tca_phs_step_size        = &H1
    End Property

    Property Get read_tca_phs_step_size
        read
        read_tca_phs_step_size = read_tca_phs_step_size_value
    End Property

    Property Let write_tca_phs_step_size(aData)
        set_tca_phs_step_size = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tca_disable_value = rightShift(data_low, 12) and &H1
        read_tca_restart_value = rightShift(data_low, 11) and &H1
        read_tca_coarse_timer_kgain_value = rightShift(data_low, 9) and &H3
        read_tca_start_force_value = rightShift(data_low, 8) and &H1
        read_tca_start_force_val_value = rightShift(data_low, 7) and &H1
        read_tca_pe_os_force_value = rightShift(data_low, 6) and &H1
        read_tca_add_pdoffst_value = rightShift(data_low, 5) and &H1
        read_tca_k_force_value = rightShift(data_low, 4) and &H1
        read_tca_k_force_val_value = rightShift(data_low, 2) and &H3
        read_tca_pdout_inv_value = rightShift(data_low, 1) and &H1
        tca_phs_step_size_mask = &H1
        if data_low > LONG_MAX then
            if tca_phs_step_size_mask = mask then
                read_tca_phs_step_size_value = data_low
            else
                read_tca_phs_step_size_value = (data_low - H8000_0000) and tca_phs_step_size_mask
            end If
        else
            read_tca_phs_step_size_value = data_low and tca_phs_step_size_mask
        end If

    End Sub

    Sub write
        If flag_tca_disable = &H0 or flag_tca_restart = &H0 or flag_tca_coarse_timer_kgain = &H0 or flag_tca_start_force = &H0 or flag_tca_start_force_val = &H0 or flag_tca_pe_os_force = &H0 or flag_tca_add_pdoffst = &H0 or flag_tca_k_force = &H0 or flag_tca_k_force_val = &H0 or flag_tca_pdout_inv = &H0 or flag_tca_phs_step_size = &H0 Then read
        If flag_tca_disable = &H0 Then write_tca_disable_value = get_tca_disable
        If flag_tca_restart = &H0 Then write_tca_restart_value = get_tca_restart
        If flag_tca_coarse_timer_kgain = &H0 Then write_tca_coarse_timer_kgain_value = get_tca_coarse_timer_kgain
        If flag_tca_start_force = &H0 Then write_tca_start_force_value = get_tca_start_force
        If flag_tca_start_force_val = &H0 Then write_tca_start_force_val_value = get_tca_start_force_val
        If flag_tca_pe_os_force = &H0 Then write_tca_pe_os_force_value = get_tca_pe_os_force
        If flag_tca_add_pdoffst = &H0 Then write_tca_add_pdoffst_value = get_tca_add_pdoffst
        If flag_tca_k_force = &H0 Then write_tca_k_force_value = get_tca_k_force
        If flag_tca_k_force_val = &H0 Then write_tca_k_force_val_value = get_tca_k_force_val
        If flag_tca_pdout_inv = &H0 Then write_tca_pdout_inv_value = get_tca_pdout_inv
        If flag_tca_phs_step_size = &H0 Then write_tca_phs_step_size_value = get_tca_phs_step_size

        regValue = leftShift((write_tca_disable_value and &H1), 12) + leftShift((write_tca_restart_value and &H1), 11) + leftShift((write_tca_coarse_timer_kgain_value and &H3), 9) + leftShift((write_tca_start_force_value and &H1), 8) + leftShift((write_tca_start_force_val_value and &H1), 7) + leftShift((write_tca_pe_os_force_value and &H1), 6) + leftShift((write_tca_add_pdoffst_value and &H1), 5) + leftShift((write_tca_k_force_value and &H1), 4) + leftShift((write_tca_k_force_val_value and &H3), 2) + leftShift((write_tca_pdout_inv_value and &H1), 1) + leftShift((write_tca_phs_step_size_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tca_disable_value = rightShift(data_low, 12) and &H1
        read_tca_restart_value = rightShift(data_low, 11) and &H1
        read_tca_coarse_timer_kgain_value = rightShift(data_low, 9) and &H3
        read_tca_start_force_value = rightShift(data_low, 8) and &H1
        read_tca_start_force_val_value = rightShift(data_low, 7) and &H1
        read_tca_pe_os_force_value = rightShift(data_low, 6) and &H1
        read_tca_add_pdoffst_value = rightShift(data_low, 5) and &H1
        read_tca_k_force_value = rightShift(data_low, 4) and &H1
        read_tca_k_force_val_value = rightShift(data_low, 2) and &H3
        read_tca_pdout_inv_value = rightShift(data_low, 1) and &H1
        tca_phs_step_size_mask = &H1
        if data_low > LONG_MAX then
            if tca_phs_step_size_mask = mask then
                read_tca_phs_step_size_value = data_low
            else
                read_tca_phs_step_size_value = (data_low - H8000_0000) and tca_phs_step_size_mask
            end If
        else
            read_tca_phs_step_size_value = data_low and tca_phs_step_size_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tca_disable_value = &H0
        flag_tca_disable        = &H0
        write_tca_restart_value = &H0
        flag_tca_restart        = &H0
        write_tca_coarse_timer_kgain_value = &H0
        flag_tca_coarse_timer_kgain        = &H0
        write_tca_start_force_value = &H0
        flag_tca_start_force        = &H0
        write_tca_start_force_val_value = &H0
        flag_tca_start_force_val        = &H0
        write_tca_pe_os_force_value = &H0
        flag_tca_pe_os_force        = &H0
        write_tca_add_pdoffst_value = &H0
        flag_tca_add_pdoffst        = &H0
        write_tca_k_force_value = &H0
        flag_tca_k_force        = &H0
        write_tca_k_force_val_value = &H0
        flag_tca_k_force_val        = &H0
        write_tca_pdout_inv_value = &H0
        flag_tca_pdout_inv        = &H0
        write_tca_phs_step_size_value = &H0
        flag_tca_phs_step_size        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_txpicontrol0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txpi_en                                    [13:13]          get_txpi_en
''                                                             set_txpi_en
''                                                             read_txpi_en
''                                                             write_txpi_en
''---------------------------------------------------------------------------------
'' tx_interp_ctrl_cap                         [12:12]          get_tx_interp_ctrl_cap
''                                                             set_tx_interp_ctrl_cap
''                                                             read_tx_interp_ctrl_cap
''                                                             write_tx_interp_ctrl_cap
''---------------------------------------------------------------------------------
'' phase_step_mult                            [11:11]          get_phase_step_mult
''                                                             set_phase_step_mult
''                                                             read_phase_step_mult
''                                                             write_phase_step_mult
''---------------------------------------------------------------------------------
'' pi_phase_invert                            [10:10]          get_pi_phase_invert
''                                                             set_pi_phase_invert
''                                                             read_pi_phase_invert
''                                                             write_pi_phase_invert
''---------------------------------------------------------------------------------
'' phase_override_SM                          [9:9]            get_phase_override_SM
''                                                             set_phase_override_SM
''                                                             read_phase_override_SM
''                                                             write_phase_override_SM
''---------------------------------------------------------------------------------
'' phase_step_dir                             [8:8]            get_phase_step_dir
''                                                             set_phase_step_dir
''                                                             read_phase_step_dir
''                                                             write_phase_step_dir
''---------------------------------------------------------------------------------
'' phase_step_SM                              [7:6]            get_phase_step_SM
''                                                             set_phase_step_SM
''                                                             read_phase_step_SM
''                                                             write_phase_step_SM
''---------------------------------------------------------------------------------
'' phase_strobe_SM                            [5:5]            get_phase_strobe_SM
''                                                             set_phase_strobe_SM
''                                                             read_phase_strobe_SM
''                                                             write_phase_strobe_SM
''---------------------------------------------------------------------------------
'' phase_delta_SM                             [4:0]            get_phase_delta_SM
''                                                             set_phase_delta_SM
''                                                             read_phase_delta_SM
''                                                             write_phase_delta_SM
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_txpicontrol0
    Private write_txpi_en_value
    Private read_txpi_en_value
    Private flag_txpi_en
    Private write_tx_interp_ctrl_cap_value
    Private read_tx_interp_ctrl_cap_value
    Private flag_tx_interp_ctrl_cap
    Private write_phase_step_mult_value
    Private read_phase_step_mult_value
    Private flag_phase_step_mult
    Private write_pi_phase_invert_value
    Private read_pi_phase_invert_value
    Private flag_pi_phase_invert
    Private write_phase_override_SM_value
    Private read_phase_override_SM_value
    Private flag_phase_override_SM
    Private write_phase_step_dir_value
    Private read_phase_step_dir_value
    Private flag_phase_step_dir
    Private write_phase_step_SM_value
    Private read_phase_step_SM_value
    Private flag_phase_step_SM
    Private write_phase_strobe_SM_value
    Private read_phase_strobe_SM_value
    Private flag_phase_strobe_SM
    Private write_phase_delta_SM_value
    Private read_phase_delta_SM_value
    Private flag_phase_delta_SM

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

    Property Get get_txpi_en
        get_txpi_en = read_txpi_en_value
    End Property

    Property Let set_txpi_en(aData)
        write_txpi_en_value = aData
        flag_txpi_en        = &H1
    End Property

    Property Get read_txpi_en
        read
        read_txpi_en = read_txpi_en_value
    End Property

    Property Let write_txpi_en(aData)
        set_txpi_en = aData
        write
    End Property

    Property Get get_tx_interp_ctrl_cap
        get_tx_interp_ctrl_cap = read_tx_interp_ctrl_cap_value
    End Property

    Property Let set_tx_interp_ctrl_cap(aData)
        write_tx_interp_ctrl_cap_value = aData
        flag_tx_interp_ctrl_cap        = &H1
    End Property

    Property Get read_tx_interp_ctrl_cap
        read
        read_tx_interp_ctrl_cap = read_tx_interp_ctrl_cap_value
    End Property

    Property Let write_tx_interp_ctrl_cap(aData)
        set_tx_interp_ctrl_cap = aData
        write
    End Property

    Property Get get_phase_step_mult
        get_phase_step_mult = read_phase_step_mult_value
    End Property

    Property Let set_phase_step_mult(aData)
        write_phase_step_mult_value = aData
        flag_phase_step_mult        = &H1
    End Property

    Property Get read_phase_step_mult
        read
        read_phase_step_mult = read_phase_step_mult_value
    End Property

    Property Let write_phase_step_mult(aData)
        set_phase_step_mult = aData
        write
    End Property

    Property Get get_pi_phase_invert
        get_pi_phase_invert = read_pi_phase_invert_value
    End Property

    Property Let set_pi_phase_invert(aData)
        write_pi_phase_invert_value = aData
        flag_pi_phase_invert        = &H1
    End Property

    Property Get read_pi_phase_invert
        read
        read_pi_phase_invert = read_pi_phase_invert_value
    End Property

    Property Let write_pi_phase_invert(aData)
        set_pi_phase_invert = aData
        write
    End Property

    Property Get get_phase_override_SM
        get_phase_override_SM = read_phase_override_SM_value
    End Property

    Property Let set_phase_override_SM(aData)
        write_phase_override_SM_value = aData
        flag_phase_override_SM        = &H1
    End Property

    Property Get read_phase_override_SM
        read
        read_phase_override_SM = read_phase_override_SM_value
    End Property

    Property Let write_phase_override_SM(aData)
        set_phase_override_SM = aData
        write
    End Property

    Property Get get_phase_step_dir
        get_phase_step_dir = read_phase_step_dir_value
    End Property

    Property Let set_phase_step_dir(aData)
        write_phase_step_dir_value = aData
        flag_phase_step_dir        = &H1
    End Property

    Property Get read_phase_step_dir
        read
        read_phase_step_dir = read_phase_step_dir_value
    End Property

    Property Let write_phase_step_dir(aData)
        set_phase_step_dir = aData
        write
    End Property

    Property Get get_phase_step_SM
        get_phase_step_SM = read_phase_step_SM_value
    End Property

    Property Let set_phase_step_SM(aData)
        write_phase_step_SM_value = aData
        flag_phase_step_SM        = &H1
    End Property

    Property Get read_phase_step_SM
        read
        read_phase_step_SM = read_phase_step_SM_value
    End Property

    Property Let write_phase_step_SM(aData)
        set_phase_step_SM = aData
        write
    End Property

    Property Get get_phase_strobe_SM
        get_phase_strobe_SM = read_phase_strobe_SM_value
    End Property

    Property Let set_phase_strobe_SM(aData)
        write_phase_strobe_SM_value = aData
        flag_phase_strobe_SM        = &H1
    End Property

    Property Get read_phase_strobe_SM
        read
        read_phase_strobe_SM = read_phase_strobe_SM_value
    End Property

    Property Let write_phase_strobe_SM(aData)
        set_phase_strobe_SM = aData
        write
    End Property

    Property Get get_phase_delta_SM
        get_phase_delta_SM = read_phase_delta_SM_value
    End Property

    Property Let set_phase_delta_SM(aData)
        write_phase_delta_SM_value = aData
        flag_phase_delta_SM        = &H1
    End Property

    Property Get read_phase_delta_SM
        read
        read_phase_delta_SM = read_phase_delta_SM_value
    End Property

    Property Let write_phase_delta_SM(aData)
        set_phase_delta_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpi_en_value = rightShift(data_low, 13) and &H1
        read_tx_interp_ctrl_cap_value = rightShift(data_low, 12) and &H1
        read_phase_step_mult_value = rightShift(data_low, 11) and &H1
        read_pi_phase_invert_value = rightShift(data_low, 10) and &H1
        read_phase_override_SM_value = rightShift(data_low, 9) and &H1
        read_phase_step_dir_value = rightShift(data_low, 8) and &H1
        read_phase_step_SM_value = rightShift(data_low, 6) and &H3
        read_phase_strobe_SM_value = rightShift(data_low, 5) and &H1
        phase_delta_SM_mask = &H1f
        if data_low > LONG_MAX then
            if phase_delta_SM_mask = mask then
                read_phase_delta_SM_value = data_low
            else
                read_phase_delta_SM_value = (data_low - H8000_0000) and phase_delta_SM_mask
            end If
        else
            read_phase_delta_SM_value = data_low and phase_delta_SM_mask
        end If

    End Sub

    Sub write
        If flag_txpi_en = &H0 or flag_tx_interp_ctrl_cap = &H0 or flag_phase_step_mult = &H0 or flag_pi_phase_invert = &H0 or flag_phase_override_SM = &H0 or flag_phase_step_dir = &H0 or flag_phase_step_SM = &H0 or flag_phase_strobe_SM = &H0 or flag_phase_delta_SM = &H0 Then read
        If flag_txpi_en = &H0 Then write_txpi_en_value = get_txpi_en
        If flag_tx_interp_ctrl_cap = &H0 Then write_tx_interp_ctrl_cap_value = get_tx_interp_ctrl_cap
        If flag_phase_step_mult = &H0 Then write_phase_step_mult_value = get_phase_step_mult
        If flag_pi_phase_invert = &H0 Then write_pi_phase_invert_value = get_pi_phase_invert
        If flag_phase_override_SM = &H0 Then write_phase_override_SM_value = get_phase_override_SM
        If flag_phase_step_dir = &H0 Then write_phase_step_dir_value = get_phase_step_dir
        If flag_phase_step_SM = &H0 Then write_phase_step_SM_value = get_phase_step_SM
        If flag_phase_strobe_SM = &H0 Then write_phase_strobe_SM_value = get_phase_strobe_SM
        If flag_phase_delta_SM = &H0 Then write_phase_delta_SM_value = get_phase_delta_SM

        regValue = leftShift((write_txpi_en_value and &H1), 13) + leftShift((write_tx_interp_ctrl_cap_value and &H1), 12) + leftShift((write_phase_step_mult_value and &H1), 11) + leftShift((write_pi_phase_invert_value and &H1), 10) + leftShift((write_phase_override_SM_value and &H1), 9) + leftShift((write_phase_step_dir_value and &H1), 8) + leftShift((write_phase_step_SM_value and &H3), 6) + leftShift((write_phase_strobe_SM_value and &H1), 5) + leftShift((write_phase_delta_SM_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpi_en_value = rightShift(data_low, 13) and &H1
        read_tx_interp_ctrl_cap_value = rightShift(data_low, 12) and &H1
        read_phase_step_mult_value = rightShift(data_low, 11) and &H1
        read_pi_phase_invert_value = rightShift(data_low, 10) and &H1
        read_phase_override_SM_value = rightShift(data_low, 9) and &H1
        read_phase_step_dir_value = rightShift(data_low, 8) and &H1
        read_phase_step_SM_value = rightShift(data_low, 6) and &H3
        read_phase_strobe_SM_value = rightShift(data_low, 5) and &H1
        phase_delta_SM_mask = &H1f
        if data_low > LONG_MAX then
            if phase_delta_SM_mask = mask then
                read_phase_delta_SM_value = data_low
            else
                read_phase_delta_SM_value = (data_low - H8000_0000) and phase_delta_SM_mask
            end If
        else
            read_phase_delta_SM_value = data_low and phase_delta_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txpi_en_value = &H0
        flag_txpi_en        = &H0
        write_tx_interp_ctrl_cap_value = &H0
        flag_tx_interp_ctrl_cap        = &H0
        write_phase_step_mult_value = &H0
        flag_phase_step_mult        = &H0
        write_pi_phase_invert_value = &H0
        flag_pi_phase_invert        = &H0
        write_phase_override_SM_value = &H0
        flag_phase_override_SM        = &H0
        write_phase_step_dir_value = &H0
        flag_phase_step_dir        = &H0
        write_phase_step_SM_value = &H0
        flag_phase_step_SM        = &H0
        write_phase_strobe_SM_value = &H0
        flag_phase_strobe_SM        = &H0
        write_phase_delta_SM_value = &H0
        flag_phase_delta_SM        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_txpicontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txpi_ctrl_force                            [15:15]          get_txpi_ctrl_force
''                                                             set_txpi_ctrl_force
''                                                             read_txpi_ctrl_force
''                                                             write_txpi_ctrl_force
''---------------------------------------------------------------------------------
'' txpi_ctrl_quadrant_force_val               [14:13]          get_txpi_ctrl_quadrant_force_val
''                                                             set_txpi_ctrl_quadrant_force_val
''                                                             read_txpi_ctrl_quadrant_force_val
''                                                             write_txpi_ctrl_quadrant_force_val
''---------------------------------------------------------------------------------
'' txpi_ctrl_phase_force_val                  [12:8]           get_txpi_ctrl_phase_force_val
''                                                             set_txpi_ctrl_phase_force_val
''                                                             read_txpi_ctrl_phase_force_val
''                                                             write_txpi_ctrl_phase_force_val
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_txpicontrol1
    Private write_txpi_ctrl_force_value
    Private read_txpi_ctrl_force_value
    Private flag_txpi_ctrl_force
    Private write_txpi_ctrl_quadrant_force_val_value
    Private read_txpi_ctrl_quadrant_force_val_value
    Private flag_txpi_ctrl_quadrant_force_val
    Private write_txpi_ctrl_phase_force_val_value
    Private read_txpi_ctrl_phase_force_val_value
    Private flag_txpi_ctrl_phase_force_val

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

    Property Get get_txpi_ctrl_force
        get_txpi_ctrl_force = read_txpi_ctrl_force_value
    End Property

    Property Let set_txpi_ctrl_force(aData)
        write_txpi_ctrl_force_value = aData
        flag_txpi_ctrl_force        = &H1
    End Property

    Property Get read_txpi_ctrl_force
        read
        read_txpi_ctrl_force = read_txpi_ctrl_force_value
    End Property

    Property Let write_txpi_ctrl_force(aData)
        set_txpi_ctrl_force = aData
        write
    End Property

    Property Get get_txpi_ctrl_quadrant_force_val
        get_txpi_ctrl_quadrant_force_val = read_txpi_ctrl_quadrant_force_val_value
    End Property

    Property Let set_txpi_ctrl_quadrant_force_val(aData)
        write_txpi_ctrl_quadrant_force_val_value = aData
        flag_txpi_ctrl_quadrant_force_val        = &H1
    End Property

    Property Get read_txpi_ctrl_quadrant_force_val
        read
        read_txpi_ctrl_quadrant_force_val = read_txpi_ctrl_quadrant_force_val_value
    End Property

    Property Let write_txpi_ctrl_quadrant_force_val(aData)
        set_txpi_ctrl_quadrant_force_val = aData
        write
    End Property

    Property Get get_txpi_ctrl_phase_force_val
        get_txpi_ctrl_phase_force_val = read_txpi_ctrl_phase_force_val_value
    End Property

    Property Let set_txpi_ctrl_phase_force_val(aData)
        write_txpi_ctrl_phase_force_val_value = aData
        flag_txpi_ctrl_phase_force_val        = &H1
    End Property

    Property Get read_txpi_ctrl_phase_force_val
        read
        read_txpi_ctrl_phase_force_val = read_txpi_ctrl_phase_force_val_value
    End Property

    Property Let write_txpi_ctrl_phase_force_val(aData)
        set_txpi_ctrl_phase_force_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpi_ctrl_force_value = rightShift(data_low, 15) and &H1
        read_txpi_ctrl_quadrant_force_val_value = rightShift(data_low, 13) and &H3
        read_txpi_ctrl_phase_force_val_value = rightShift(data_low, 8) and &H1f

    End Sub

    Sub write
        If flag_txpi_ctrl_force = &H0 or flag_txpi_ctrl_quadrant_force_val = &H0 or flag_txpi_ctrl_phase_force_val = &H0 Then read
        If flag_txpi_ctrl_force = &H0 Then write_txpi_ctrl_force_value = get_txpi_ctrl_force
        If flag_txpi_ctrl_quadrant_force_val = &H0 Then write_txpi_ctrl_quadrant_force_val_value = get_txpi_ctrl_quadrant_force_val
        If flag_txpi_ctrl_phase_force_val = &H0 Then write_txpi_ctrl_phase_force_val_value = get_txpi_ctrl_phase_force_val

        regValue = leftShift((write_txpi_ctrl_force_value and &H1), 15) + leftShift((write_txpi_ctrl_quadrant_force_val_value and &H3), 13) + leftShift((write_txpi_ctrl_phase_force_val_value and &H1f), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpi_ctrl_force_value = rightShift(data_low, 15) and &H1
        read_txpi_ctrl_quadrant_force_val_value = rightShift(data_low, 13) and &H3
        read_txpi_ctrl_phase_force_val_value = rightShift(data_low, 8) and &H1f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txpi_ctrl_force_value = &H0
        flag_txpi_ctrl_force        = &H0
        write_txpi_ctrl_quadrant_force_val_value = &H0
        flag_txpi_ctrl_quadrant_force_val        = &H0
        write_txpi_ctrl_phase_force_val_value = &H0
        flag_txpi_ctrl_phase_force_val        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_txpistatus0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' status0                                    [15:0]           get_status0
''                                                             set_status0
''                                                             read_status0
''                                                             write_status0
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_txpistatus0
    Private write_status0_value
    Private read_status0_value
    Private flag_status0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_status0
        get_status0 = read_status0_value
    End Property

    Property Let set_status0(aData)
        write_status0_value = aData
        flag_status0        = &H1
    End Property

    Property Get read_status0
        read
        read_status0 = read_status0_value
    End Property

    Property Let write_status0(aData)
        set_status0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status0_mask = &Hffff
        if data_low > LONG_MAX then
            if status0_mask = mask then
                read_status0_value = data_low
            else
                read_status0_value = (data_low - H8000_0000) and status0_mask
            end If
        else
            read_status0_value = data_low and status0_mask
        end If

    End Sub

    Sub write
        If flag_status0 = &H0 Then read
        If flag_status0 = &H0 Then write_status0_value = get_status0

        regValue = leftShift((write_status0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status0_mask = &Hffff
        if data_low > LONG_MAX then
            if status0_mask = mask then
                read_status0_value = data_low
            else
                read_status0_value = (data_low - H8000_0000) and status0_mask
            end If
        else
            read_status0_value = data_low and status0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_status0_value = &H0
        flag_status0        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE1__SGMIIPCIE_X1_txpistatus1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' status1                                    [15:0]           get_status1
''                                                             set_status1
''                                                             read_status1
''                                                             write_status1
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE1__SGMIIPCIE_X1_txpistatus1
    Private write_status1_value
    Private read_status1_value
    Private flag_status1

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

    Property Get get_status1
        get_status1 = read_status1_value
    End Property

    Property Let set_status1(aData)
        write_status1_value = aData
        flag_status1        = &H1
    End Property

    Property Get read_status1
        read
        read_status1 = read_status1_value
    End Property

    Property Let write_status1(aData)
        set_status1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status1_mask = &Hffff
        if data_low > LONG_MAX then
            if status1_mask = mask then
                read_status1_value = data_low
            else
                read_status1_value = (data_low - H8000_0000) and status1_mask
            end If
        else
            read_status1_value = data_low and status1_mask
        end If

    End Sub

    Sub write
        If flag_status1 = &H0 Then read
        If flag_status1 = &H0 Then write_status1_value = get_status1

        regValue = leftShift((write_status1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status1_mask = &Hffff
        if data_low > LONG_MAX then
            if status1_mask = mask then
                read_status1_value = data_low
            else
                read_status1_value = (data_low - H8000_0000) and status1_mask
            end If
        else
            read_status1_value = data_low and status1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_status1_value = &H0
        flag_status1        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TX_DFE1__SGMIIPCIE_X1_INSTANCE

    Public mdata0
    Public mdata1
    Public mdata2
    Public mdata3
    Public mdata4
    Public mdata5
    Public mdata6
    Public acontrol5
    Public tcacontrol
    Public txpicontrol0
    Public txpicontrol1
    Public txpistatus0
    Public txpistatus1


    Public default function Init(aBaseAddr)
        Set mdata0 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata0)(aBaseAddr, 16)
        Set mdata1 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata1)(aBaseAddr, 16)
        Set mdata2 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata2)(aBaseAddr, 16)
        Set mdata3 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata3)(aBaseAddr, 16)
        Set mdata4 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata4)(aBaseAddr, 16)
        Set mdata5 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata5)(aBaseAddr, 16)
        Set mdata6 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_mdata6)(aBaseAddr, 16)
        Set acontrol5 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_acontrol5)(aBaseAddr, 16)
        Set tcacontrol = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_tcacontrol)(aBaseAddr, 16)
        Set txpicontrol0 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_txpicontrol0)(aBaseAddr, 16)
        Set txpicontrol1 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_txpicontrol1)(aBaseAddr, 16)
        Set txpistatus0 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_txpistatus0)(aBaseAddr, 16)
        Set txpistatus1 = (New REGISTER_TX_DFE1__SGMIIPCIE_X1_txpistatus1)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_DFE1__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
TX_DFE1__SGMIIPCIE_X1.Add ((New TX_DFE1__SGMIIPCIE_X1_INSTANCE)(&H4adea200))


