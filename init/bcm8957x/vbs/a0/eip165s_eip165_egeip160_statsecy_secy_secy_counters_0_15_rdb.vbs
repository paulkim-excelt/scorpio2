

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a000
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a004
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a00c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a010
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a014
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a080
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a084
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a088
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a08c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a090
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a094
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a10c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a180
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a184
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a188
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a18c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a190
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a194
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a280
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a284
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a288
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a28c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a290
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a294
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a300
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a304
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a308
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a30c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a310
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a314
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a380
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a384
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a388
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a38c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a390
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a394
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a404
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a40c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a410
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a480
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a484
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a488
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a48c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a490
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a494
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a500
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a504
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a508
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a50c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a510
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a514
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a580
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a584
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a588
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a58c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a590
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a594
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a600
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a604
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a608
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a60c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a610
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a614
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a680
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a684
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a688
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a68c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a690
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a694
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a700
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a704
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a708
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a70c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a710
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a714
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a780
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a784
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsctrl_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsctrl_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a788
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsctrl_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsctrl_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a78c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsuntagged_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsuntagged_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a790
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsuntagged_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsuntagged_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a794
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE

    Public secy_0_transformerrorpkts_lo
    Public secy_0_transformerrorpkts_hi
    Public secy_0_outpktsctrl_lo
    Public secy_0_outpktsctrl_hi
    Public secy_0_outpktsuntagged_lo
    Public secy_0_outpktsuntagged_hi
    Public secy_1_transformerrorpkts_lo
    Public secy_1_transformerrorpkts_hi
    Public secy_1_outpktsctrl_lo
    Public secy_1_outpktsctrl_hi
    Public secy_1_outpktsuntagged_lo
    Public secy_1_outpktsuntagged_hi
    Public secy_2_transformerrorpkts_lo
    Public secy_2_transformerrorpkts_hi
    Public secy_2_outpktsctrl_lo
    Public secy_2_outpktsctrl_hi
    Public secy_2_outpktsuntagged_lo
    Public secy_2_outpktsuntagged_hi
    Public secy_3_transformerrorpkts_lo
    Public secy_3_transformerrorpkts_hi
    Public secy_3_outpktsctrl_lo
    Public secy_3_outpktsctrl_hi
    Public secy_3_outpktsuntagged_lo
    Public secy_3_outpktsuntagged_hi
    Public secy_4_transformerrorpkts_lo
    Public secy_4_transformerrorpkts_hi
    Public secy_4_outpktsctrl_lo
    Public secy_4_outpktsctrl_hi
    Public secy_4_outpktsuntagged_lo
    Public secy_4_outpktsuntagged_hi
    Public secy_5_transformerrorpkts_lo
    Public secy_5_transformerrorpkts_hi
    Public secy_5_outpktsctrl_lo
    Public secy_5_outpktsctrl_hi
    Public secy_5_outpktsuntagged_lo
    Public secy_5_outpktsuntagged_hi
    Public secy_6_transformerrorpkts_lo
    Public secy_6_transformerrorpkts_hi
    Public secy_6_outpktsctrl_lo
    Public secy_6_outpktsctrl_hi
    Public secy_6_outpktsuntagged_lo
    Public secy_6_outpktsuntagged_hi
    Public secy_7_transformerrorpkts_lo
    Public secy_7_transformerrorpkts_hi
    Public secy_7_outpktsctrl_lo
    Public secy_7_outpktsctrl_hi
    Public secy_7_outpktsuntagged_lo
    Public secy_7_outpktsuntagged_hi
    Public secy_8_transformerrorpkts_lo
    Public secy_8_transformerrorpkts_hi
    Public secy_8_outpktsctrl_lo
    Public secy_8_outpktsctrl_hi
    Public secy_8_outpktsuntagged_lo
    Public secy_8_outpktsuntagged_hi
    Public secy_9_transformerrorpkts_lo
    Public secy_9_transformerrorpkts_hi
    Public secy_9_outpktsctrl_lo
    Public secy_9_outpktsctrl_hi
    Public secy_9_outpktsuntagged_lo
    Public secy_9_outpktsuntagged_hi
    Public secy_10_transformerrorpkts_lo
    Public secy_10_transformerrorpkts_hi
    Public secy_10_outpktsctrl_lo
    Public secy_10_outpktsctrl_hi
    Public secy_10_outpktsuntagged_lo
    Public secy_10_outpktsuntagged_hi
    Public secy_11_transformerrorpkts_lo
    Public secy_11_transformerrorpkts_hi
    Public secy_11_outpktsctrl_lo
    Public secy_11_outpktsctrl_hi
    Public secy_11_outpktsuntagged_lo
    Public secy_11_outpktsuntagged_hi
    Public secy_12_transformerrorpkts_lo
    Public secy_12_transformerrorpkts_hi
    Public secy_12_outpktsctrl_lo
    Public secy_12_outpktsctrl_hi
    Public secy_12_outpktsuntagged_lo
    Public secy_12_outpktsuntagged_hi
    Public secy_13_transformerrorpkts_lo
    Public secy_13_transformerrorpkts_hi
    Public secy_13_outpktsctrl_lo
    Public secy_13_outpktsctrl_hi
    Public secy_13_outpktsuntagged_lo
    Public secy_13_outpktsuntagged_hi
    Public secy_14_transformerrorpkts_lo
    Public secy_14_transformerrorpkts_hi
    Public secy_14_outpktsctrl_lo
    Public secy_14_outpktsctrl_hi
    Public secy_14_outpktsuntagged_lo
    Public secy_14_outpktsuntagged_hi
    Public secy_15_transformerrorpkts_lo
    Public secy_15_transformerrorpkts_hi
    Public secy_15_outpktsctrl_lo
    Public secy_15_outpktsctrl_hi
    Public secy_15_outpktsuntagged_lo
    Public secy_15_outpktsuntagged_hi


    Public default function Init(aBaseAddr)
        Set secy_0_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_0_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_0_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_0_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_0_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_0_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_1_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_1_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_1_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_1_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_1_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_1_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_2_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_2_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_2_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_2_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_2_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_2_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_3_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_3_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_3_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_3_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_3_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_3_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_4_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_4_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_4_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_4_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_4_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_4_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_5_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_5_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_5_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_5_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_5_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_5_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_6_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_6_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_6_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_6_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_6_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_6_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_7_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_7_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_7_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_7_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_7_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_7_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_8_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_8_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_8_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_8_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_8_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_8_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_9_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_9_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_9_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_9_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_9_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_9_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_10_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_10_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_10_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_10_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_10_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_10_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_11_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_11_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_11_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_11_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_11_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_11_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_12_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_12_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_12_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_12_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_12_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_12_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_13_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_13_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_13_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_13_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_13_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_13_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_14_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_14_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_14_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_14_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_14_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_14_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_outpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_15_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_15_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_15_outpktsctrl_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsctrl_lo)(aBaseAddr, 32)
        Set secy_15_outpktsctrl_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsctrl_hi)(aBaseAddr, 32)
        Set secy_15_outpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_15_outpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_outpktsuntagged_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d510000))


