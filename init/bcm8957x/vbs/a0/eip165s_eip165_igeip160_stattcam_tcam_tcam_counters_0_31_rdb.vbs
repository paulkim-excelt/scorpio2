

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_0_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_0_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4000
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_0_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_0_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4004
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_1_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_1_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_1_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_1_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H400c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_2_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_2_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4010
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_2_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_2_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4014
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_3_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_3_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4018
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_3_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_3_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H401c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_4_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_4_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4020
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_4_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_4_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_5_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_5_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_5_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_5_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H402c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_6_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_6_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4030
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_6_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_6_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4034
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_7_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_7_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4038
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_7_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_7_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H403c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_8_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_8_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4040
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_8_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_8_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_9_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_9_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4048
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_9_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_9_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H404c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_10_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_10_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4050
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_10_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_10_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4054
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_11_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_11_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4058
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_11_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_11_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H405c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_12_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_12_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4060
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_12_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_12_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4064
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_13_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_13_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4068
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_13_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_13_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H406c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_14_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_14_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4070
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_14_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_14_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4074
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_15_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_15_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4078
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_15_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_15_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H407c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_16_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_16_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4080
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_16_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_16_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4084
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_17_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_17_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4088
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_17_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_17_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H408c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_18_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_18_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4090
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_18_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_18_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4094
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_19_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_19_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4098
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_19_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_19_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H409c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_20_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_20_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_20_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_20_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_21_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_21_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_21_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_21_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_22_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_22_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_22_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_22_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_23_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_23_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_23_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_23_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_24_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_24_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_24_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_24_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_25_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_25_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_25_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_25_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_26_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_26_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_26_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_26_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_27_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_27_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_27_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_27_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40dc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_28_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_28_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_28_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_28_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_29_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_29_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_29_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_29_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40ec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_30_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_30_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_30_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_30_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_31_tcamhit_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_31_tcamhit_lo
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_31_tcamhit_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' counter                                    [31:0]           get_counter
''                                                             set_counter
''                                                             read_counter
''                                                             write_counter
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_31_tcamhit_hi
    Private write_counter_value
    Private read_counter_value
    Private flag_counter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_counter
        get_counter = read_counter_value
    End Property

    Property Let set_counter(aData)
        write_counter_value = aData
        flag_counter        = &H1
    End Property

    Property Get read_counter
        read
        read_counter = read_counter_value
    End Property

    Property Let write_counter(aData)
        set_counter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

    End Sub

    Sub write
        If flag_counter = &H0 Then read
        If flag_counter = &H0 Then write_counter_value = get_counter

        regValue = leftShift(write_counter_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        counter_mask = &Hffffffff
        if data_low > LONG_MAX then
            if counter_mask = mask then
                read_counter_value = data_low
            else
                read_counter_value = (data_low - H8000_0000) and counter_mask
            end If
        else
            read_counter_value = data_low and counter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_counter_value = &H0
        flag_counter        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE

    Public tcam_0_tcamhit_lo
    Public tcam_0_tcamhit_hi
    Public tcam_1_tcamhit_lo
    Public tcam_1_tcamhit_hi
    Public tcam_2_tcamhit_lo
    Public tcam_2_tcamhit_hi
    Public tcam_3_tcamhit_lo
    Public tcam_3_tcamhit_hi
    Public tcam_4_tcamhit_lo
    Public tcam_4_tcamhit_hi
    Public tcam_5_tcamhit_lo
    Public tcam_5_tcamhit_hi
    Public tcam_6_tcamhit_lo
    Public tcam_6_tcamhit_hi
    Public tcam_7_tcamhit_lo
    Public tcam_7_tcamhit_hi
    Public tcam_8_tcamhit_lo
    Public tcam_8_tcamhit_hi
    Public tcam_9_tcamhit_lo
    Public tcam_9_tcamhit_hi
    Public tcam_10_tcamhit_lo
    Public tcam_10_tcamhit_hi
    Public tcam_11_tcamhit_lo
    Public tcam_11_tcamhit_hi
    Public tcam_12_tcamhit_lo
    Public tcam_12_tcamhit_hi
    Public tcam_13_tcamhit_lo
    Public tcam_13_tcamhit_hi
    Public tcam_14_tcamhit_lo
    Public tcam_14_tcamhit_hi
    Public tcam_15_tcamhit_lo
    Public tcam_15_tcamhit_hi
    Public tcam_16_tcamhit_lo
    Public tcam_16_tcamhit_hi
    Public tcam_17_tcamhit_lo
    Public tcam_17_tcamhit_hi
    Public tcam_18_tcamhit_lo
    Public tcam_18_tcamhit_hi
    Public tcam_19_tcamhit_lo
    Public tcam_19_tcamhit_hi
    Public tcam_20_tcamhit_lo
    Public tcam_20_tcamhit_hi
    Public tcam_21_tcamhit_lo
    Public tcam_21_tcamhit_hi
    Public tcam_22_tcamhit_lo
    Public tcam_22_tcamhit_hi
    Public tcam_23_tcamhit_lo
    Public tcam_23_tcamhit_hi
    Public tcam_24_tcamhit_lo
    Public tcam_24_tcamhit_hi
    Public tcam_25_tcamhit_lo
    Public tcam_25_tcamhit_hi
    Public tcam_26_tcamhit_lo
    Public tcam_26_tcamhit_hi
    Public tcam_27_tcamhit_lo
    Public tcam_27_tcamhit_hi
    Public tcam_28_tcamhit_lo
    Public tcam_28_tcamhit_hi
    Public tcam_29_tcamhit_lo
    Public tcam_29_tcamhit_hi
    Public tcam_30_tcamhit_lo
    Public tcam_30_tcamhit_hi
    Public tcam_31_tcamhit_lo
    Public tcam_31_tcamhit_hi


    Public default function Init(aBaseAddr)
        Set tcam_0_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_0_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_0_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_0_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_1_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_1_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_1_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_1_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_2_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_2_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_2_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_2_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_3_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_3_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_3_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_3_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_4_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_4_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_4_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_4_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_5_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_5_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_5_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_5_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_6_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_6_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_6_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_6_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_7_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_7_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_7_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_7_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_8_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_8_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_8_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_8_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_9_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_9_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_9_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_9_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_10_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_10_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_10_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_10_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_11_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_11_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_11_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_11_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_12_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_12_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_12_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_12_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_13_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_13_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_13_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_13_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_14_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_14_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_14_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_14_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_15_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_15_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_15_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_15_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_16_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_16_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_16_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_16_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_17_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_17_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_17_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_17_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_18_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_18_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_18_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_18_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_19_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_19_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_19_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_19_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_20_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_20_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_20_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_20_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_21_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_21_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_21_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_21_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_22_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_22_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_22_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_22_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_23_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_23_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_23_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_23_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_24_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_24_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_24_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_24_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_25_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_25_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_25_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_25_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_26_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_26_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_26_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_26_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_27_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_27_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_27_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_27_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_28_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_28_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_28_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_28_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_29_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_29_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_29_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_29_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_30_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_30_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_30_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_30_tcamhit_hi)(aBaseAddr, 32)
        Set tcam_31_tcamhit_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_31_tcamhit_lo)(aBaseAddr, 32)
        Set tcam_31_tcamhit_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_tcam_31_tcamhit_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_TCAM_COUNTERS_0_31_INSTANCE)(&H4d510000))


