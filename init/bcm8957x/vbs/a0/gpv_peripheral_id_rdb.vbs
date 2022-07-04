

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


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID4                             [7:0]            get_Peripheral_ID4
''                                                             set_Peripheral_ID4
''                                                             read_Peripheral_ID4
''                                                             write_Peripheral_ID4
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id4
    Private write_Peripheral_ID4_value
    Private read_Peripheral_ID4_value
    Private flag_Peripheral_ID4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfd0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID4
        get_Peripheral_ID4 = read_Peripheral_ID4_value
    End Property

    Property Let set_Peripheral_ID4(aData)
        write_Peripheral_ID4_value = aData
        flag_Peripheral_ID4        = &H1
    End Property

    Property Get read_Peripheral_ID4
        read
        read_Peripheral_ID4 = read_Peripheral_ID4_value
    End Property

    Property Let write_Peripheral_ID4(aData)
        set_Peripheral_ID4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID4_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID4_mask = mask then
                read_Peripheral_ID4_value = data_low
            else
                read_Peripheral_ID4_value = (data_low - H8000_0000) and Peripheral_ID4_mask
            end If
        else
            read_Peripheral_ID4_value = data_low and Peripheral_ID4_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID4 = &H0 Then read
        If flag_Peripheral_ID4 = &H0 Then write_Peripheral_ID4_value = get_Peripheral_ID4

        regValue = leftShift((write_Peripheral_ID4_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID4_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID4_mask = mask then
                read_Peripheral_ID4_value = data_low
            else
                read_Peripheral_ID4_value = (data_low - H8000_0000) and Peripheral_ID4_mask
            end If
        else
            read_Peripheral_ID4_value = data_low and Peripheral_ID4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID4_value = &H0
        flag_Peripheral_ID4        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID5                             [7:0]            get_Peripheral_ID5
''                                                             set_Peripheral_ID5
''                                                             read_Peripheral_ID5
''                                                             write_Peripheral_ID5
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id5
    Private write_Peripheral_ID5_value
    Private read_Peripheral_ID5_value
    Private flag_Peripheral_ID5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfd4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID5
        get_Peripheral_ID5 = read_Peripheral_ID5_value
    End Property

    Property Let set_Peripheral_ID5(aData)
        write_Peripheral_ID5_value = aData
        flag_Peripheral_ID5        = &H1
    End Property

    Property Get read_Peripheral_ID5
        read
        read_Peripheral_ID5 = read_Peripheral_ID5_value
    End Property

    Property Let write_Peripheral_ID5(aData)
        set_Peripheral_ID5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID5_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID5_mask = mask then
                read_Peripheral_ID5_value = data_low
            else
                read_Peripheral_ID5_value = (data_low - H8000_0000) and Peripheral_ID5_mask
            end If
        else
            read_Peripheral_ID5_value = data_low and Peripheral_ID5_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID5 = &H0 Then read
        If flag_Peripheral_ID5 = &H0 Then write_Peripheral_ID5_value = get_Peripheral_ID5

        regValue = leftShift((write_Peripheral_ID5_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID5_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID5_mask = mask then
                read_Peripheral_ID5_value = data_low
            else
                read_Peripheral_ID5_value = (data_low - H8000_0000) and Peripheral_ID5_mask
            end If
        else
            read_Peripheral_ID5_value = data_low and Peripheral_ID5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID5_value = &H0
        flag_Peripheral_ID5        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID6                             [7:0]            get_Peripheral_ID6
''                                                             set_Peripheral_ID6
''                                                             read_Peripheral_ID6
''                                                             write_Peripheral_ID6
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id6
    Private write_Peripheral_ID6_value
    Private read_Peripheral_ID6_value
    Private flag_Peripheral_ID6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfd8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID6
        get_Peripheral_ID6 = read_Peripheral_ID6_value
    End Property

    Property Let set_Peripheral_ID6(aData)
        write_Peripheral_ID6_value = aData
        flag_Peripheral_ID6        = &H1
    End Property

    Property Get read_Peripheral_ID6
        read
        read_Peripheral_ID6 = read_Peripheral_ID6_value
    End Property

    Property Let write_Peripheral_ID6(aData)
        set_Peripheral_ID6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID6_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID6_mask = mask then
                read_Peripheral_ID6_value = data_low
            else
                read_Peripheral_ID6_value = (data_low - H8000_0000) and Peripheral_ID6_mask
            end If
        else
            read_Peripheral_ID6_value = data_low and Peripheral_ID6_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID6 = &H0 Then read
        If flag_Peripheral_ID6 = &H0 Then write_Peripheral_ID6_value = get_Peripheral_ID6

        regValue = leftShift((write_Peripheral_ID6_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID6_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID6_mask = mask then
                read_Peripheral_ID6_value = data_low
            else
                read_Peripheral_ID6_value = (data_low - H8000_0000) and Peripheral_ID6_mask
            end If
        else
            read_Peripheral_ID6_value = data_low and Peripheral_ID6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID6_value = &H0
        flag_Peripheral_ID6        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID7                             [7:0]            get_Peripheral_ID7
''                                                             set_Peripheral_ID7
''                                                             read_Peripheral_ID7
''                                                             write_Peripheral_ID7
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id7
    Private write_Peripheral_ID7_value
    Private read_Peripheral_ID7_value
    Private flag_Peripheral_ID7

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfdc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID7
        get_Peripheral_ID7 = read_Peripheral_ID7_value
    End Property

    Property Let set_Peripheral_ID7(aData)
        write_Peripheral_ID7_value = aData
        flag_Peripheral_ID7        = &H1
    End Property

    Property Get read_Peripheral_ID7
        read
        read_Peripheral_ID7 = read_Peripheral_ID7_value
    End Property

    Property Let write_Peripheral_ID7(aData)
        set_Peripheral_ID7 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID7_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID7_mask = mask then
                read_Peripheral_ID7_value = data_low
            else
                read_Peripheral_ID7_value = (data_low - H8000_0000) and Peripheral_ID7_mask
            end If
        else
            read_Peripheral_ID7_value = data_low and Peripheral_ID7_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID7 = &H0 Then read
        If flag_Peripheral_ID7 = &H0 Then write_Peripheral_ID7_value = get_Peripheral_ID7

        regValue = leftShift((write_Peripheral_ID7_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID7_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID7_mask = mask then
                read_Peripheral_ID7_value = data_low
            else
                read_Peripheral_ID7_value = (data_low - H8000_0000) and Peripheral_ID7_mask
            end If
        else
            read_Peripheral_ID7_value = data_low and Peripheral_ID7_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID7_value = &H0
        flag_Peripheral_ID7        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID0                             [7:0]            get_Peripheral_ID0
''                                                             set_Peripheral_ID0
''                                                             read_Peripheral_ID0
''                                                             write_Peripheral_ID0
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id0
    Private write_Peripheral_ID0_value
    Private read_Peripheral_ID0_value
    Private flag_Peripheral_ID0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID0
        get_Peripheral_ID0 = read_Peripheral_ID0_value
    End Property

    Property Let set_Peripheral_ID0(aData)
        write_Peripheral_ID0_value = aData
        flag_Peripheral_ID0        = &H1
    End Property

    Property Get read_Peripheral_ID0
        read
        read_Peripheral_ID0 = read_Peripheral_ID0_value
    End Property

    Property Let write_Peripheral_ID0(aData)
        set_Peripheral_ID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID0_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID0_mask = mask then
                read_Peripheral_ID0_value = data_low
            else
                read_Peripheral_ID0_value = (data_low - H8000_0000) and Peripheral_ID0_mask
            end If
        else
            read_Peripheral_ID0_value = data_low and Peripheral_ID0_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID0 = &H0 Then read
        If flag_Peripheral_ID0 = &H0 Then write_Peripheral_ID0_value = get_Peripheral_ID0

        regValue = leftShift((write_Peripheral_ID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID0_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID0_mask = mask then
                read_Peripheral_ID0_value = data_low
            else
                read_Peripheral_ID0_value = (data_low - H8000_0000) and Peripheral_ID0_mask
            end If
        else
            read_Peripheral_ID0_value = data_low and Peripheral_ID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID0_value = &H0
        flag_Peripheral_ID0        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID1                             [7:0]            get_Peripheral_ID1
''                                                             set_Peripheral_ID1
''                                                             read_Peripheral_ID1
''                                                             write_Peripheral_ID1
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id1
    Private write_Peripheral_ID1_value
    Private read_Peripheral_ID1_value
    Private flag_Peripheral_ID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID1
        get_Peripheral_ID1 = read_Peripheral_ID1_value
    End Property

    Property Let set_Peripheral_ID1(aData)
        write_Peripheral_ID1_value = aData
        flag_Peripheral_ID1        = &H1
    End Property

    Property Get read_Peripheral_ID1
        read
        read_Peripheral_ID1 = read_Peripheral_ID1_value
    End Property

    Property Let write_Peripheral_ID1(aData)
        set_Peripheral_ID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID1_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID1_mask = mask then
                read_Peripheral_ID1_value = data_low
            else
                read_Peripheral_ID1_value = (data_low - H8000_0000) and Peripheral_ID1_mask
            end If
        else
            read_Peripheral_ID1_value = data_low and Peripheral_ID1_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID1 = &H0 Then read
        If flag_Peripheral_ID1 = &H0 Then write_Peripheral_ID1_value = get_Peripheral_ID1

        regValue = leftShift((write_Peripheral_ID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID1_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID1_mask = mask then
                read_Peripheral_ID1_value = data_low
            else
                read_Peripheral_ID1_value = (data_low - H8000_0000) and Peripheral_ID1_mask
            end If
        else
            read_Peripheral_ID1_value = data_low and Peripheral_ID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID1_value = &H0
        flag_Peripheral_ID1        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID2                             [7:0]            get_Peripheral_ID2
''                                                             set_Peripheral_ID2
''                                                             read_Peripheral_ID2
''                                                             write_Peripheral_ID2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id2
    Private write_Peripheral_ID2_value
    Private read_Peripheral_ID2_value
    Private flag_Peripheral_ID2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID2
        get_Peripheral_ID2 = read_Peripheral_ID2_value
    End Property

    Property Let set_Peripheral_ID2(aData)
        write_Peripheral_ID2_value = aData
        flag_Peripheral_ID2        = &H1
    End Property

    Property Get read_Peripheral_ID2
        read
        read_Peripheral_ID2 = read_Peripheral_ID2_value
    End Property

    Property Let write_Peripheral_ID2(aData)
        set_Peripheral_ID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID2_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID2_mask = mask then
                read_Peripheral_ID2_value = data_low
            else
                read_Peripheral_ID2_value = (data_low - H8000_0000) and Peripheral_ID2_mask
            end If
        else
            read_Peripheral_ID2_value = data_low and Peripheral_ID2_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID2 = &H0 Then read
        If flag_Peripheral_ID2 = &H0 Then write_Peripheral_ID2_value = get_Peripheral_ID2

        regValue = leftShift((write_Peripheral_ID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID2_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID2_mask = mask then
                read_Peripheral_ID2_value = data_low
            else
                read_Peripheral_ID2_value = (data_low - H8000_0000) and Peripheral_ID2_mask
            end If
        else
            read_Peripheral_ID2_value = data_low and Peripheral_ID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID2_value = &H0
        flag_Peripheral_ID2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_peripheral_id3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Peripheral_ID3                             [7:0]            get_Peripheral_ID3
''                                                             set_Peripheral_ID3
''                                                             read_Peripheral_ID3
''                                                             write_Peripheral_ID3
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_peripheral_id3
    Private write_Peripheral_ID3_value
    Private read_Peripheral_ID3_value
    Private flag_Peripheral_ID3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Peripheral_ID3
        get_Peripheral_ID3 = read_Peripheral_ID3_value
    End Property

    Property Let set_Peripheral_ID3(aData)
        write_Peripheral_ID3_value = aData
        flag_Peripheral_ID3        = &H1
    End Property

    Property Get read_Peripheral_ID3
        read
        read_Peripheral_ID3 = read_Peripheral_ID3_value
    End Property

    Property Let write_Peripheral_ID3(aData)
        set_Peripheral_ID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID3_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID3_mask = mask then
                read_Peripheral_ID3_value = data_low
            else
                read_Peripheral_ID3_value = (data_low - H8000_0000) and Peripheral_ID3_mask
            end If
        else
            read_Peripheral_ID3_value = data_low and Peripheral_ID3_mask
        end If

    End Sub

    Sub write
        If flag_Peripheral_ID3 = &H0 Then read
        If flag_Peripheral_ID3 = &H0 Then write_Peripheral_ID3_value = get_Peripheral_ID3

        regValue = leftShift((write_Peripheral_ID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Peripheral_ID3_mask = &Hff
        if data_low > LONG_MAX then
            if Peripheral_ID3_mask = mask then
                read_Peripheral_ID3_value = data_low
            else
                read_Peripheral_ID3_value = (data_low - H8000_0000) and Peripheral_ID3_mask
            end If
        else
            read_Peripheral_ID3_value = data_low and Peripheral_ID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Peripheral_ID3_value = &H0
        flag_Peripheral_ID3        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_component_id0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Component_ID0                              [7:0]            get_Component_ID0
''                                                             set_Component_ID0
''                                                             read_Component_ID0
''                                                             write_Component_ID0
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_component_id0
    Private write_Component_ID0_value
    Private read_Component_ID0_value
    Private flag_Component_ID0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Component_ID0
        get_Component_ID0 = read_Component_ID0_value
    End Property

    Property Let set_Component_ID0(aData)
        write_Component_ID0_value = aData
        flag_Component_ID0        = &H1
    End Property

    Property Get read_Component_ID0
        read
        read_Component_ID0 = read_Component_ID0_value
    End Property

    Property Let write_Component_ID0(aData)
        set_Component_ID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID0_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID0_mask = mask then
                read_Component_ID0_value = data_low
            else
                read_Component_ID0_value = (data_low - H8000_0000) and Component_ID0_mask
            end If
        else
            read_Component_ID0_value = data_low and Component_ID0_mask
        end If

    End Sub

    Sub write
        If flag_Component_ID0 = &H0 Then read
        If flag_Component_ID0 = &H0 Then write_Component_ID0_value = get_Component_ID0

        regValue = leftShift((write_Component_ID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID0_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID0_mask = mask then
                read_Component_ID0_value = data_low
            else
                read_Component_ID0_value = (data_low - H8000_0000) and Component_ID0_mask
            end If
        else
            read_Component_ID0_value = data_low and Component_ID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Component_ID0_value = &H0
        flag_Component_ID0        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_component_id1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Component_ID1                              [7:0]            get_Component_ID1
''                                                             set_Component_ID1
''                                                             read_Component_ID1
''                                                             write_Component_ID1
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_component_id1
    Private write_Component_ID1_value
    Private read_Component_ID1_value
    Private flag_Component_ID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Component_ID1
        get_Component_ID1 = read_Component_ID1_value
    End Property

    Property Let set_Component_ID1(aData)
        write_Component_ID1_value = aData
        flag_Component_ID1        = &H1
    End Property

    Property Get read_Component_ID1
        read
        read_Component_ID1 = read_Component_ID1_value
    End Property

    Property Let write_Component_ID1(aData)
        set_Component_ID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID1_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID1_mask = mask then
                read_Component_ID1_value = data_low
            else
                read_Component_ID1_value = (data_low - H8000_0000) and Component_ID1_mask
            end If
        else
            read_Component_ID1_value = data_low and Component_ID1_mask
        end If

    End Sub

    Sub write
        If flag_Component_ID1 = &H0 Then read
        If flag_Component_ID1 = &H0 Then write_Component_ID1_value = get_Component_ID1

        regValue = leftShift((write_Component_ID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID1_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID1_mask = mask then
                read_Component_ID1_value = data_low
            else
                read_Component_ID1_value = (data_low - H8000_0000) and Component_ID1_mask
            end If
        else
            read_Component_ID1_value = data_low and Component_ID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Component_ID1_value = &H0
        flag_Component_ID1        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_component_id2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Component_ID2                              [7:0]            get_Component_ID2
''                                                             set_Component_ID2
''                                                             read_Component_ID2
''                                                             write_Component_ID2
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_component_id2
    Private write_Component_ID2_value
    Private read_Component_ID2_value
    Private flag_Component_ID2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Component_ID2
        get_Component_ID2 = read_Component_ID2_value
    End Property

    Property Let set_Component_ID2(aData)
        write_Component_ID2_value = aData
        flag_Component_ID2        = &H1
    End Property

    Property Get read_Component_ID2
        read
        read_Component_ID2 = read_Component_ID2_value
    End Property

    Property Let write_Component_ID2(aData)
        set_Component_ID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID2_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID2_mask = mask then
                read_Component_ID2_value = data_low
            else
                read_Component_ID2_value = (data_low - H8000_0000) and Component_ID2_mask
            end If
        else
            read_Component_ID2_value = data_low and Component_ID2_mask
        end If

    End Sub

    Sub write
        If flag_Component_ID2 = &H0 Then read
        If flag_Component_ID2 = &H0 Then write_Component_ID2_value = get_Component_ID2

        regValue = leftShift((write_Component_ID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID2_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID2_mask = mask then
                read_Component_ID2_value = data_low
            else
                read_Component_ID2_value = (data_low - H8000_0000) and Component_ID2_mask
            end If
        else
            read_Component_ID2_value = data_low and Component_ID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Component_ID2_value = &H0
        flag_Component_ID2        = &H0
    End Sub
End Class


'' @REGISTER : GPV_PERIPHERAL_ID_component_id3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Component_ID3                              [7:0]            get_Component_ID3
''                                                             set_Component_ID3
''                                                             read_Component_ID3
''                                                             write_Component_ID3
''---------------------------------------------------------------------------------
Class REGISTER_GPV_PERIPHERAL_ID_component_id3
    Private write_Component_ID3_value
    Private read_Component_ID3_value
    Private flag_Component_ID3

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

    Property Get get_Component_ID3
        get_Component_ID3 = read_Component_ID3_value
    End Property

    Property Let set_Component_ID3(aData)
        write_Component_ID3_value = aData
        flag_Component_ID3        = &H1
    End Property

    Property Get read_Component_ID3
        read
        read_Component_ID3 = read_Component_ID3_value
    End Property

    Property Let write_Component_ID3(aData)
        set_Component_ID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID3_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID3_mask = mask then
                read_Component_ID3_value = data_low
            else
                read_Component_ID3_value = (data_low - H8000_0000) and Component_ID3_mask
            end If
        else
            read_Component_ID3_value = data_low and Component_ID3_mask
        end If

    End Sub

    Sub write
        If flag_Component_ID3 = &H0 Then read
        If flag_Component_ID3 = &H0 Then write_Component_ID3_value = get_Component_ID3

        regValue = leftShift((write_Component_ID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Component_ID3_mask = &Hff
        if data_low > LONG_MAX then
            if Component_ID3_mask = mask then
                read_Component_ID3_value = data_low
            else
                read_Component_ID3_value = (data_low - H8000_0000) and Component_ID3_mask
            end If
        else
            read_Component_ID3_value = data_low and Component_ID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Component_ID3_value = &H0
        flag_Component_ID3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class GPV_PERIPHERAL_ID_INSTANCE

    Public peripheral_id4
    Public peripheral_id5
    Public peripheral_id6
    Public peripheral_id7
    Public peripheral_id0
    Public peripheral_id1
    Public peripheral_id2
    Public peripheral_id3
    Public component_id0
    Public component_id1
    Public component_id2
    Public component_id3


    Public default function Init(aBaseAddr)
        Set peripheral_id4 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id4)(aBaseAddr, 32)
        Set peripheral_id5 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id5)(aBaseAddr, 32)
        Set peripheral_id6 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id6)(aBaseAddr, 32)
        Set peripheral_id7 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id7)(aBaseAddr, 32)
        Set peripheral_id0 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id0)(aBaseAddr, 32)
        Set peripheral_id1 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id1)(aBaseAddr, 32)
        Set peripheral_id2 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id2)(aBaseAddr, 32)
        Set peripheral_id3 = (New REGISTER_GPV_PERIPHERAL_ID_peripheral_id3)(aBaseAddr, 32)
        Set component_id0 = (New REGISTER_GPV_PERIPHERAL_ID_component_id0)(aBaseAddr, 32)
        Set component_id1 = (New REGISTER_GPV_PERIPHERAL_ID_component_id1)(aBaseAddr, 32)
        Set component_id2 = (New REGISTER_GPV_PERIPHERAL_ID_component_id2)(aBaseAddr, 32)
        Set component_id3 = (New REGISTER_GPV_PERIPHERAL_ID_component_id3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set GPV_PERIPHERAL_ID = CreateObject("System.Collections.ArrayList")
GPV_PERIPHERAL_ID.Add ((New GPV_PERIPHERAL_ID_INSTANCE)(&H4c201000))


