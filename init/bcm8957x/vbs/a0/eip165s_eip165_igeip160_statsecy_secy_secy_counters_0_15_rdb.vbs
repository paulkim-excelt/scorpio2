

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_lo
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
        offset = &Ha000
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_hi
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
        offset = &Ha004
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsctrl_lo
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
        offset = &Ha008
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsctrl_hi
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
        offset = &Ha00c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsuntagged_lo
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
        offset = &Ha010
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsuntagged_hi
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
        offset = &Ha014
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnotag_lo
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
        offset = &Ha018
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnotag_hi
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
        offset = &Ha01c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsbadtag_lo
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
        offset = &Ha020
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsbadtag_hi
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
        offset = &Ha024
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnosci_lo
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
        offset = &Ha028
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnosci_hi
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
        offset = &Ha02c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsunknownsci_lo
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
        offset = &Ha030
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsunknownsci_hi
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
        offset = &Ha034
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktstaggedctrl_lo
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
        offset = &Ha038
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktstaggedctrl_hi
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
        offset = &Ha03c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_lo
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
        offset = &Ha080
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_hi
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
        offset = &Ha084
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsctrl_lo
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
        offset = &Ha088
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsctrl_hi
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
        offset = &Ha08c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsuntagged_lo
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
        offset = &Ha090
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsuntagged_hi
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
        offset = &Ha094
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnotag_lo
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
        offset = &Ha098
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnotag_hi
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
        offset = &Ha09c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsbadtag_lo
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
        offset = &Ha0a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsbadtag_hi
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
        offset = &Ha0a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnosci_lo
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
        offset = &Ha0a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnosci_hi
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
        offset = &Ha0ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsunknownsci_lo
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
        offset = &Ha0b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsunknownsci_hi
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
        offset = &Ha0b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktstaggedctrl_lo
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
        offset = &Ha0b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktstaggedctrl_hi
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
        offset = &Ha0bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_lo
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
        offset = &Ha100
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_hi
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
        offset = &Ha104
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsctrl_lo
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
        offset = &Ha108
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsctrl_hi
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
        offset = &Ha10c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsuntagged_lo
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
        offset = &Ha110
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsuntagged_hi
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
        offset = &Ha114
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnotag_lo
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
        offset = &Ha118
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnotag_hi
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
        offset = &Ha11c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsbadtag_lo
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
        offset = &Ha120
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsbadtag_hi
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
        offset = &Ha124
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnosci_lo
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
        offset = &Ha128
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnosci_hi
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
        offset = &Ha12c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsunknownsci_lo
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
        offset = &Ha130
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsunknownsci_hi
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
        offset = &Ha134
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktstaggedctrl_lo
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
        offset = &Ha138
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktstaggedctrl_hi
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
        offset = &Ha13c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_lo
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
        offset = &Ha180
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_hi
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
        offset = &Ha184
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsctrl_lo
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
        offset = &Ha188
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsctrl_hi
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
        offset = &Ha18c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsuntagged_lo
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
        offset = &Ha190
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsuntagged_hi
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
        offset = &Ha194
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnotag_lo
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
        offset = &Ha198
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnotag_hi
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
        offset = &Ha19c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsbadtag_lo
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
        offset = &Ha1a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsbadtag_hi
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
        offset = &Ha1a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnosci_lo
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
        offset = &Ha1a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnosci_hi
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
        offset = &Ha1ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsunknownsci_lo
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
        offset = &Ha1b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsunknownsci_hi
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
        offset = &Ha1b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktstaggedctrl_lo
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
        offset = &Ha1b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktstaggedctrl_hi
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
        offset = &Ha1bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_lo
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
        offset = &Ha200
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_hi
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
        offset = &Ha204
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsctrl_lo
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
        offset = &Ha208
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsctrl_hi
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
        offset = &Ha20c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsuntagged_lo
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
        offset = &Ha210
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsuntagged_hi
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
        offset = &Ha214
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnotag_lo
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
        offset = &Ha218
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnotag_hi
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
        offset = &Ha21c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsbadtag_lo
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
        offset = &Ha220
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsbadtag_hi
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
        offset = &Ha224
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnosci_lo
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
        offset = &Ha228
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnosci_hi
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
        offset = &Ha22c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsunknownsci_lo
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
        offset = &Ha230
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsunknownsci_hi
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
        offset = &Ha234
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktstaggedctrl_lo
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
        offset = &Ha238
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktstaggedctrl_hi
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
        offset = &Ha23c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_lo
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
        offset = &Ha280
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_hi
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
        offset = &Ha284
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsctrl_lo
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
        offset = &Ha288
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsctrl_hi
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
        offset = &Ha28c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsuntagged_lo
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
        offset = &Ha290
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsuntagged_hi
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
        offset = &Ha294
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnotag_lo
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
        offset = &Ha298
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnotag_hi
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
        offset = &Ha29c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsbadtag_lo
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
        offset = &Ha2a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsbadtag_hi
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
        offset = &Ha2a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnosci_lo
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
        offset = &Ha2a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnosci_hi
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
        offset = &Ha2ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsunknownsci_lo
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
        offset = &Ha2b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsunknownsci_hi
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
        offset = &Ha2b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktstaggedctrl_lo
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
        offset = &Ha2b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktstaggedctrl_hi
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
        offset = &Ha2bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_lo
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
        offset = &Ha300
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_hi
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
        offset = &Ha304
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsctrl_lo
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
        offset = &Ha308
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsctrl_hi
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
        offset = &Ha30c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsuntagged_lo
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
        offset = &Ha310
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsuntagged_hi
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
        offset = &Ha314
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnotag_lo
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
        offset = &Ha318
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnotag_hi
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
        offset = &Ha31c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsbadtag_lo
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
        offset = &Ha320
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsbadtag_hi
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
        offset = &Ha324
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnosci_lo
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
        offset = &Ha328
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnosci_hi
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
        offset = &Ha32c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsunknownsci_lo
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
        offset = &Ha330
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsunknownsci_hi
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
        offset = &Ha334
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktstaggedctrl_lo
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
        offset = &Ha338
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktstaggedctrl_hi
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
        offset = &Ha33c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_lo
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
        offset = &Ha380
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_hi
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
        offset = &Ha384
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsctrl_lo
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
        offset = &Ha388
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsctrl_hi
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
        offset = &Ha38c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsuntagged_lo
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
        offset = &Ha390
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsuntagged_hi
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
        offset = &Ha394
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnotag_lo
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
        offset = &Ha398
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnotag_hi
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
        offset = &Ha39c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsbadtag_lo
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
        offset = &Ha3a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsbadtag_hi
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
        offset = &Ha3a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnosci_lo
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
        offset = &Ha3a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnosci_hi
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
        offset = &Ha3ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsunknownsci_lo
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
        offset = &Ha3b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsunknownsci_hi
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
        offset = &Ha3b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktstaggedctrl_lo
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
        offset = &Ha3b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktstaggedctrl_hi
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
        offset = &Ha3bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_lo
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
        offset = &Ha400
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_hi
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
        offset = &Ha404
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsctrl_lo
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
        offset = &Ha408
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsctrl_hi
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
        offset = &Ha40c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsuntagged_lo
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
        offset = &Ha410
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsuntagged_hi
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
        offset = &Ha414
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnotag_lo
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
        offset = &Ha418
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnotag_hi
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
        offset = &Ha41c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsbadtag_lo
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
        offset = &Ha420
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsbadtag_hi
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
        offset = &Ha424
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnosci_lo
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
        offset = &Ha428
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnosci_hi
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
        offset = &Ha42c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsunknownsci_lo
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
        offset = &Ha430
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsunknownsci_hi
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
        offset = &Ha434
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktstaggedctrl_lo
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
        offset = &Ha438
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktstaggedctrl_hi
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
        offset = &Ha43c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_lo
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
        offset = &Ha480
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_hi
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
        offset = &Ha484
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsctrl_lo
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
        offset = &Ha488
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsctrl_hi
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
        offset = &Ha48c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsuntagged_lo
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
        offset = &Ha490
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsuntagged_hi
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
        offset = &Ha494
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnotag_lo
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
        offset = &Ha498
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnotag_hi
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
        offset = &Ha49c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsbadtag_lo
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
        offset = &Ha4a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsbadtag_hi
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
        offset = &Ha4a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnosci_lo
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
        offset = &Ha4a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnosci_hi
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
        offset = &Ha4ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsunknownsci_lo
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
        offset = &Ha4b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsunknownsci_hi
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
        offset = &Ha4b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktstaggedctrl_lo
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
        offset = &Ha4b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktstaggedctrl_hi
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
        offset = &Ha4bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_lo
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
        offset = &Ha500
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_hi
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
        offset = &Ha504
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsctrl_lo
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
        offset = &Ha508
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsctrl_hi
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
        offset = &Ha50c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsuntagged_lo
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
        offset = &Ha510
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsuntagged_hi
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
        offset = &Ha514
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnotag_lo
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
        offset = &Ha518
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnotag_hi
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
        offset = &Ha51c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsbadtag_lo
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
        offset = &Ha520
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsbadtag_hi
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
        offset = &Ha524
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnosci_lo
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
        offset = &Ha528
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnosci_hi
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
        offset = &Ha52c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsunknownsci_lo
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
        offset = &Ha530
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsunknownsci_hi
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
        offset = &Ha534
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktstaggedctrl_lo
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
        offset = &Ha538
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktstaggedctrl_hi
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
        offset = &Ha53c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_lo
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
        offset = &Ha580
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_hi
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
        offset = &Ha584
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsctrl_lo
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
        offset = &Ha588
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsctrl_hi
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
        offset = &Ha58c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsuntagged_lo
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
        offset = &Ha590
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsuntagged_hi
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
        offset = &Ha594
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnotag_lo
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
        offset = &Ha598
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnotag_hi
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
        offset = &Ha59c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsbadtag_lo
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
        offset = &Ha5a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsbadtag_hi
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
        offset = &Ha5a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnosci_lo
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
        offset = &Ha5a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnosci_hi
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
        offset = &Ha5ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsunknownsci_lo
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
        offset = &Ha5b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsunknownsci_hi
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
        offset = &Ha5b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktstaggedctrl_lo
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
        offset = &Ha5b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktstaggedctrl_hi
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
        offset = &Ha5bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_lo
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
        offset = &Ha600
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_hi
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
        offset = &Ha604
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsctrl_lo
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
        offset = &Ha608
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsctrl_hi
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
        offset = &Ha60c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsuntagged_lo
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
        offset = &Ha610
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsuntagged_hi
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
        offset = &Ha614
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnotag_lo
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
        offset = &Ha618
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnotag_hi
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
        offset = &Ha61c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsbadtag_lo
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
        offset = &Ha620
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsbadtag_hi
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
        offset = &Ha624
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnosci_lo
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
        offset = &Ha628
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnosci_hi
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
        offset = &Ha62c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsunknownsci_lo
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
        offset = &Ha630
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsunknownsci_hi
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
        offset = &Ha634
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktstaggedctrl_lo
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
        offset = &Ha638
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktstaggedctrl_hi
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
        offset = &Ha63c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_lo
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
        offset = &Ha680
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_hi
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
        offset = &Ha684
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsctrl_lo
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
        offset = &Ha688
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsctrl_hi
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
        offset = &Ha68c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsuntagged_lo
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
        offset = &Ha690
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsuntagged_hi
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
        offset = &Ha694
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnotag_lo
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
        offset = &Ha698
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnotag_hi
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
        offset = &Ha69c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsbadtag_lo
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
        offset = &Ha6a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsbadtag_hi
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
        offset = &Ha6a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnosci_lo
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
        offset = &Ha6a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnosci_hi
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
        offset = &Ha6ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsunknownsci_lo
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
        offset = &Ha6b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsunknownsci_hi
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
        offset = &Ha6b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktstaggedctrl_lo
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
        offset = &Ha6b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktstaggedctrl_hi
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
        offset = &Ha6bc
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_lo
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
        offset = &Ha700
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_hi
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
        offset = &Ha704
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsctrl_lo
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
        offset = &Ha708
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsctrl_hi
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
        offset = &Ha70c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsuntagged_lo
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
        offset = &Ha710
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsuntagged_hi
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
        offset = &Ha714
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnotag_lo
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
        offset = &Ha718
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnotag_hi
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
        offset = &Ha71c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsbadtag_lo
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
        offset = &Ha720
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsbadtag_hi
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
        offset = &Ha724
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnosci_lo
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
        offset = &Ha728
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnosci_hi
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
        offset = &Ha72c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsunknownsci_lo
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
        offset = &Ha730
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsunknownsci_hi
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
        offset = &Ha734
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktstaggedctrl_lo
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
        offset = &Ha738
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktstaggedctrl_hi
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
        offset = &Ha73c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_lo
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
        offset = &Ha780
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_hi
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
        offset = &Ha784
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsctrl_lo
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
        offset = &Ha788
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsctrl_hi
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
        offset = &Ha78c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsuntagged_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsuntagged_lo
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
        offset = &Ha790
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsuntagged_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsuntagged_hi
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
        offset = &Ha794
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnotag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnotag_lo
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
        offset = &Ha798
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnotag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnotag_hi
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
        offset = &Ha79c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsbadtag_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsbadtag_lo
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
        offset = &Ha7a0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsbadtag_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsbadtag_hi
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
        offset = &Ha7a4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnosci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnosci_lo
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
        offset = &Ha7a8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnosci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnosci_hi
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
        offset = &Ha7ac
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsunknownsci_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsunknownsci_lo
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
        offset = &Ha7b0
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsunknownsci_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsunknownsci_hi
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
        offset = &Ha7b4
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktstaggedctrl_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktstaggedctrl_lo
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
        offset = &Ha7b8
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktstaggedctrl_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktstaggedctrl_hi
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
        offset = &Ha7bc
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

Class EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE

    Public secy_0_transformerrorpkts_lo
    Public secy_0_transformerrorpkts_hi
    Public secy_0_inpktsctrl_lo
    Public secy_0_inpktsctrl_hi
    Public secy_0_inpktsuntagged_lo
    Public secy_0_inpktsuntagged_hi
    Public secy_0_inpktsnotag_lo
    Public secy_0_inpktsnotag_hi
    Public secy_0_inpktsbadtag_lo
    Public secy_0_inpktsbadtag_hi
    Public secy_0_inpktsnosci_lo
    Public secy_0_inpktsnosci_hi
    Public secy_0_inpktsunknownsci_lo
    Public secy_0_inpktsunknownsci_hi
    Public secy_0_inpktstaggedctrl_lo
    Public secy_0_inpktstaggedctrl_hi
    Public secy_1_transformerrorpkts_lo
    Public secy_1_transformerrorpkts_hi
    Public secy_1_inpktsctrl_lo
    Public secy_1_inpktsctrl_hi
    Public secy_1_inpktsuntagged_lo
    Public secy_1_inpktsuntagged_hi
    Public secy_1_inpktsnotag_lo
    Public secy_1_inpktsnotag_hi
    Public secy_1_inpktsbadtag_lo
    Public secy_1_inpktsbadtag_hi
    Public secy_1_inpktsnosci_lo
    Public secy_1_inpktsnosci_hi
    Public secy_1_inpktsunknownsci_lo
    Public secy_1_inpktsunknownsci_hi
    Public secy_1_inpktstaggedctrl_lo
    Public secy_1_inpktstaggedctrl_hi
    Public secy_2_transformerrorpkts_lo
    Public secy_2_transformerrorpkts_hi
    Public secy_2_inpktsctrl_lo
    Public secy_2_inpktsctrl_hi
    Public secy_2_inpktsuntagged_lo
    Public secy_2_inpktsuntagged_hi
    Public secy_2_inpktsnotag_lo
    Public secy_2_inpktsnotag_hi
    Public secy_2_inpktsbadtag_lo
    Public secy_2_inpktsbadtag_hi
    Public secy_2_inpktsnosci_lo
    Public secy_2_inpktsnosci_hi
    Public secy_2_inpktsunknownsci_lo
    Public secy_2_inpktsunknownsci_hi
    Public secy_2_inpktstaggedctrl_lo
    Public secy_2_inpktstaggedctrl_hi
    Public secy_3_transformerrorpkts_lo
    Public secy_3_transformerrorpkts_hi
    Public secy_3_inpktsctrl_lo
    Public secy_3_inpktsctrl_hi
    Public secy_3_inpktsuntagged_lo
    Public secy_3_inpktsuntagged_hi
    Public secy_3_inpktsnotag_lo
    Public secy_3_inpktsnotag_hi
    Public secy_3_inpktsbadtag_lo
    Public secy_3_inpktsbadtag_hi
    Public secy_3_inpktsnosci_lo
    Public secy_3_inpktsnosci_hi
    Public secy_3_inpktsunknownsci_lo
    Public secy_3_inpktsunknownsci_hi
    Public secy_3_inpktstaggedctrl_lo
    Public secy_3_inpktstaggedctrl_hi
    Public secy_4_transformerrorpkts_lo
    Public secy_4_transformerrorpkts_hi
    Public secy_4_inpktsctrl_lo
    Public secy_4_inpktsctrl_hi
    Public secy_4_inpktsuntagged_lo
    Public secy_4_inpktsuntagged_hi
    Public secy_4_inpktsnotag_lo
    Public secy_4_inpktsnotag_hi
    Public secy_4_inpktsbadtag_lo
    Public secy_4_inpktsbadtag_hi
    Public secy_4_inpktsnosci_lo
    Public secy_4_inpktsnosci_hi
    Public secy_4_inpktsunknownsci_lo
    Public secy_4_inpktsunknownsci_hi
    Public secy_4_inpktstaggedctrl_lo
    Public secy_4_inpktstaggedctrl_hi
    Public secy_5_transformerrorpkts_lo
    Public secy_5_transformerrorpkts_hi
    Public secy_5_inpktsctrl_lo
    Public secy_5_inpktsctrl_hi
    Public secy_5_inpktsuntagged_lo
    Public secy_5_inpktsuntagged_hi
    Public secy_5_inpktsnotag_lo
    Public secy_5_inpktsnotag_hi
    Public secy_5_inpktsbadtag_lo
    Public secy_5_inpktsbadtag_hi
    Public secy_5_inpktsnosci_lo
    Public secy_5_inpktsnosci_hi
    Public secy_5_inpktsunknownsci_lo
    Public secy_5_inpktsunknownsci_hi
    Public secy_5_inpktstaggedctrl_lo
    Public secy_5_inpktstaggedctrl_hi
    Public secy_6_transformerrorpkts_lo
    Public secy_6_transformerrorpkts_hi
    Public secy_6_inpktsctrl_lo
    Public secy_6_inpktsctrl_hi
    Public secy_6_inpktsuntagged_lo
    Public secy_6_inpktsuntagged_hi
    Public secy_6_inpktsnotag_lo
    Public secy_6_inpktsnotag_hi
    Public secy_6_inpktsbadtag_lo
    Public secy_6_inpktsbadtag_hi
    Public secy_6_inpktsnosci_lo
    Public secy_6_inpktsnosci_hi
    Public secy_6_inpktsunknownsci_lo
    Public secy_6_inpktsunknownsci_hi
    Public secy_6_inpktstaggedctrl_lo
    Public secy_6_inpktstaggedctrl_hi
    Public secy_7_transformerrorpkts_lo
    Public secy_7_transformerrorpkts_hi
    Public secy_7_inpktsctrl_lo
    Public secy_7_inpktsctrl_hi
    Public secy_7_inpktsuntagged_lo
    Public secy_7_inpktsuntagged_hi
    Public secy_7_inpktsnotag_lo
    Public secy_7_inpktsnotag_hi
    Public secy_7_inpktsbadtag_lo
    Public secy_7_inpktsbadtag_hi
    Public secy_7_inpktsnosci_lo
    Public secy_7_inpktsnosci_hi
    Public secy_7_inpktsunknownsci_lo
    Public secy_7_inpktsunknownsci_hi
    Public secy_7_inpktstaggedctrl_lo
    Public secy_7_inpktstaggedctrl_hi
    Public secy_8_transformerrorpkts_lo
    Public secy_8_transformerrorpkts_hi
    Public secy_8_inpktsctrl_lo
    Public secy_8_inpktsctrl_hi
    Public secy_8_inpktsuntagged_lo
    Public secy_8_inpktsuntagged_hi
    Public secy_8_inpktsnotag_lo
    Public secy_8_inpktsnotag_hi
    Public secy_8_inpktsbadtag_lo
    Public secy_8_inpktsbadtag_hi
    Public secy_8_inpktsnosci_lo
    Public secy_8_inpktsnosci_hi
    Public secy_8_inpktsunknownsci_lo
    Public secy_8_inpktsunknownsci_hi
    Public secy_8_inpktstaggedctrl_lo
    Public secy_8_inpktstaggedctrl_hi
    Public secy_9_transformerrorpkts_lo
    Public secy_9_transformerrorpkts_hi
    Public secy_9_inpktsctrl_lo
    Public secy_9_inpktsctrl_hi
    Public secy_9_inpktsuntagged_lo
    Public secy_9_inpktsuntagged_hi
    Public secy_9_inpktsnotag_lo
    Public secy_9_inpktsnotag_hi
    Public secy_9_inpktsbadtag_lo
    Public secy_9_inpktsbadtag_hi
    Public secy_9_inpktsnosci_lo
    Public secy_9_inpktsnosci_hi
    Public secy_9_inpktsunknownsci_lo
    Public secy_9_inpktsunknownsci_hi
    Public secy_9_inpktstaggedctrl_lo
    Public secy_9_inpktstaggedctrl_hi
    Public secy_10_transformerrorpkts_lo
    Public secy_10_transformerrorpkts_hi
    Public secy_10_inpktsctrl_lo
    Public secy_10_inpktsctrl_hi
    Public secy_10_inpktsuntagged_lo
    Public secy_10_inpktsuntagged_hi
    Public secy_10_inpktsnotag_lo
    Public secy_10_inpktsnotag_hi
    Public secy_10_inpktsbadtag_lo
    Public secy_10_inpktsbadtag_hi
    Public secy_10_inpktsnosci_lo
    Public secy_10_inpktsnosci_hi
    Public secy_10_inpktsunknownsci_lo
    Public secy_10_inpktsunknownsci_hi
    Public secy_10_inpktstaggedctrl_lo
    Public secy_10_inpktstaggedctrl_hi
    Public secy_11_transformerrorpkts_lo
    Public secy_11_transformerrorpkts_hi
    Public secy_11_inpktsctrl_lo
    Public secy_11_inpktsctrl_hi
    Public secy_11_inpktsuntagged_lo
    Public secy_11_inpktsuntagged_hi
    Public secy_11_inpktsnotag_lo
    Public secy_11_inpktsnotag_hi
    Public secy_11_inpktsbadtag_lo
    Public secy_11_inpktsbadtag_hi
    Public secy_11_inpktsnosci_lo
    Public secy_11_inpktsnosci_hi
    Public secy_11_inpktsunknownsci_lo
    Public secy_11_inpktsunknownsci_hi
    Public secy_11_inpktstaggedctrl_lo
    Public secy_11_inpktstaggedctrl_hi
    Public secy_12_transformerrorpkts_lo
    Public secy_12_transformerrorpkts_hi
    Public secy_12_inpktsctrl_lo
    Public secy_12_inpktsctrl_hi
    Public secy_12_inpktsuntagged_lo
    Public secy_12_inpktsuntagged_hi
    Public secy_12_inpktsnotag_lo
    Public secy_12_inpktsnotag_hi
    Public secy_12_inpktsbadtag_lo
    Public secy_12_inpktsbadtag_hi
    Public secy_12_inpktsnosci_lo
    Public secy_12_inpktsnosci_hi
    Public secy_12_inpktsunknownsci_lo
    Public secy_12_inpktsunknownsci_hi
    Public secy_12_inpktstaggedctrl_lo
    Public secy_12_inpktstaggedctrl_hi
    Public secy_13_transformerrorpkts_lo
    Public secy_13_transformerrorpkts_hi
    Public secy_13_inpktsctrl_lo
    Public secy_13_inpktsctrl_hi
    Public secy_13_inpktsuntagged_lo
    Public secy_13_inpktsuntagged_hi
    Public secy_13_inpktsnotag_lo
    Public secy_13_inpktsnotag_hi
    Public secy_13_inpktsbadtag_lo
    Public secy_13_inpktsbadtag_hi
    Public secy_13_inpktsnosci_lo
    Public secy_13_inpktsnosci_hi
    Public secy_13_inpktsunknownsci_lo
    Public secy_13_inpktsunknownsci_hi
    Public secy_13_inpktstaggedctrl_lo
    Public secy_13_inpktstaggedctrl_hi
    Public secy_14_transformerrorpkts_lo
    Public secy_14_transformerrorpkts_hi
    Public secy_14_inpktsctrl_lo
    Public secy_14_inpktsctrl_hi
    Public secy_14_inpktsuntagged_lo
    Public secy_14_inpktsuntagged_hi
    Public secy_14_inpktsnotag_lo
    Public secy_14_inpktsnotag_hi
    Public secy_14_inpktsbadtag_lo
    Public secy_14_inpktsbadtag_hi
    Public secy_14_inpktsnosci_lo
    Public secy_14_inpktsnosci_hi
    Public secy_14_inpktsunknownsci_lo
    Public secy_14_inpktsunknownsci_hi
    Public secy_14_inpktstaggedctrl_lo
    Public secy_14_inpktstaggedctrl_hi
    Public secy_15_transformerrorpkts_lo
    Public secy_15_transformerrorpkts_hi
    Public secy_15_inpktsctrl_lo
    Public secy_15_inpktsctrl_hi
    Public secy_15_inpktsuntagged_lo
    Public secy_15_inpktsuntagged_hi
    Public secy_15_inpktsnotag_lo
    Public secy_15_inpktsnotag_hi
    Public secy_15_inpktsbadtag_lo
    Public secy_15_inpktsbadtag_hi
    Public secy_15_inpktsnosci_lo
    Public secy_15_inpktsnosci_hi
    Public secy_15_inpktsunknownsci_lo
    Public secy_15_inpktsunknownsci_hi
    Public secy_15_inpktstaggedctrl_lo
    Public secy_15_inpktstaggedctrl_hi


    Public default function Init(aBaseAddr)
        Set secy_0_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_0_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_0_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_0_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_0_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_0_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_0_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_0_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_0_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_0_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_0_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_0_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_0_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_0_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_0_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_0_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_0_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_1_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_1_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_1_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_1_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_1_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_1_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_1_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_1_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_1_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_1_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_1_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_1_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_1_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_1_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_1_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_1_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_1_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_2_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_2_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_2_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_2_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_2_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_2_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_2_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_2_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_2_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_2_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_2_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_2_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_2_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_2_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_2_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_2_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_2_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_3_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_3_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_3_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_3_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_3_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_3_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_3_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_3_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_3_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_3_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_3_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_3_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_3_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_3_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_3_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_3_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_3_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_4_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_4_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_4_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_4_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_4_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_4_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_4_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_4_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_4_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_4_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_4_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_4_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_4_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_4_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_4_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_4_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_4_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_5_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_5_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_5_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_5_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_5_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_5_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_5_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_5_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_5_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_5_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_5_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_5_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_5_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_5_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_5_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_5_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_5_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_6_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_6_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_6_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_6_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_6_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_6_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_6_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_6_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_6_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_6_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_6_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_6_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_6_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_6_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_6_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_6_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_6_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_7_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_7_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_7_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_7_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_7_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_7_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_7_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_7_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_7_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_7_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_7_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_7_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_7_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_7_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_7_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_7_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_7_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_8_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_8_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_8_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_8_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_8_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_8_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_8_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_8_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_8_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_8_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_8_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_8_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_8_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_8_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_8_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_8_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_8_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_9_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_9_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_9_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_9_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_9_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_9_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_9_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_9_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_9_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_9_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_9_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_9_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_9_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_9_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_9_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_9_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_9_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_10_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_10_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_10_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_10_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_10_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_10_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_10_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_10_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_10_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_10_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_10_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_10_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_10_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_10_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_10_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_10_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_10_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_11_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_11_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_11_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_11_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_11_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_11_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_11_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_11_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_11_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_11_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_11_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_11_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_11_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_11_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_11_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_11_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_11_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_12_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_12_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_12_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_12_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_12_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_12_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_12_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_12_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_12_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_12_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_12_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_12_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_12_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_12_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_12_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_12_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_12_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_13_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_13_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_13_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_13_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_13_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_13_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_13_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_13_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_13_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_13_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_13_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_13_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_13_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_13_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_13_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_13_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_13_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_14_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_14_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_14_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_14_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_14_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_14_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_14_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_14_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_14_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_14_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_14_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_14_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_14_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_14_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_14_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_14_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_14_inpktstaggedctrl_hi)(aBaseAddr, 32)
        Set secy_15_transformerrorpkts_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_lo)(aBaseAddr, 32)
        Set secy_15_transformerrorpkts_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_transformerrorpkts_hi)(aBaseAddr, 32)
        Set secy_15_inpktsctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsctrl_lo)(aBaseAddr, 32)
        Set secy_15_inpktsctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsctrl_hi)(aBaseAddr, 32)
        Set secy_15_inpktsuntagged_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsuntagged_lo)(aBaseAddr, 32)
        Set secy_15_inpktsuntagged_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsuntagged_hi)(aBaseAddr, 32)
        Set secy_15_inpktsnotag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnotag_lo)(aBaseAddr, 32)
        Set secy_15_inpktsnotag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnotag_hi)(aBaseAddr, 32)
        Set secy_15_inpktsbadtag_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsbadtag_lo)(aBaseAddr, 32)
        Set secy_15_inpktsbadtag_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsbadtag_hi)(aBaseAddr, 32)
        Set secy_15_inpktsnosci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnosci_lo)(aBaseAddr, 32)
        Set secy_15_inpktsnosci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsnosci_hi)(aBaseAddr, 32)
        Set secy_15_inpktsunknownsci_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsunknownsci_lo)(aBaseAddr, 32)
        Set secy_15_inpktsunknownsci_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktsunknownsci_hi)(aBaseAddr, 32)
        Set secy_15_inpktstaggedctrl_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktstaggedctrl_lo)(aBaseAddr, 32)
        Set secy_15_inpktstaggedctrl_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_secy_15_inpktstaggedctrl_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15.Add ((New EIP165S_EIP165_IGEIP160_STATSECY_SECY_SECY_COUNTERS_0_15_INSTANCE)(&H4d510000))


