

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18000
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18004
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1800c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18010
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18014
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18018
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1801c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18080
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18084
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18088
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1808c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18090
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18094
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18098
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1809c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1810c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1811c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18180
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18184
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18188
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1818c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18190
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18194
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18198
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1819c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1820c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1821c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18280
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18284
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18288
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1828c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18290
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18294
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18298
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1829c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18300
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18304
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18308
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1830c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18310
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18314
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18318
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1831c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18380
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18384
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18388
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1838c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18390
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18394
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18398
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1839c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18404
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1840c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18410
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18418
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1841c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18480
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18484
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18488
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1848c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18490
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18494
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18498
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1849c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18500
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18504
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18508
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1850c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18510
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18514
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18518
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1851c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18580
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18584
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18588
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1858c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18590
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18594
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18598
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1859c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18600
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18604
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18608
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1860c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18610
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18614
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18618
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1861c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18680
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18684
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18688
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1868c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18690
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18694
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18698
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1869c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18700
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18704
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18708
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1870c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18710
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18714
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18718
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1871c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18780
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18784
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18788
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1878c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18790
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18794
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18798
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1879c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18800
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18804
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18808
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1880c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18810
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18814
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18818
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1881c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18880
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18884
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18888
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1888c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18890
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18894
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18898
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1889c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18900
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18904
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18908
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1890c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18910
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18914
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18918
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1891c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18980
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18984
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18988
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1898c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18990
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18994
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18998
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1899c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18a9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18b9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18d9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18e9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outoctetsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outoctetsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outoctetsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outoctetsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktsencryptedprotected_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktsencryptedprotected_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktsencryptedprotected_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktsencryptedprotected_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktstoolong_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktstoolong_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktstoolong_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktstoolong_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktssanotinuse_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktssanotinuse_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktssanotinuse_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [7:0]            get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktssanotinuse_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18f9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift((write_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

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

Class EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE

    Public sa_sa_0_outoctetsencryptedprotected_lo
    Public sa_sa_0_outoctetsencryptedprotected_hi
    Public sa_sa_0_outpktsencryptedprotected_lo
    Public sa_sa_0_outpktsencryptedprotected_hi
    Public sa_sa_0_outpktstoolong_lo
    Public sa_sa_0_outpktstoolong_hi
    Public sa_sa_0_outpktssanotinuse_lo
    Public sa_sa_0_outpktssanotinuse_hi
    Public sa_sa_1_outoctetsencryptedprotected_lo
    Public sa_sa_1_outoctetsencryptedprotected_hi
    Public sa_sa_1_outpktsencryptedprotected_lo
    Public sa_sa_1_outpktsencryptedprotected_hi
    Public sa_sa_1_outpktstoolong_lo
    Public sa_sa_1_outpktstoolong_hi
    Public sa_sa_1_outpktssanotinuse_lo
    Public sa_sa_1_outpktssanotinuse_hi
    Public sa_sa_2_outoctetsencryptedprotected_lo
    Public sa_sa_2_outoctetsencryptedprotected_hi
    Public sa_sa_2_outpktsencryptedprotected_lo
    Public sa_sa_2_outpktsencryptedprotected_hi
    Public sa_sa_2_outpktstoolong_lo
    Public sa_sa_2_outpktstoolong_hi
    Public sa_sa_2_outpktssanotinuse_lo
    Public sa_sa_2_outpktssanotinuse_hi
    Public sa_sa_3_outoctetsencryptedprotected_lo
    Public sa_sa_3_outoctetsencryptedprotected_hi
    Public sa_sa_3_outpktsencryptedprotected_lo
    Public sa_sa_3_outpktsencryptedprotected_hi
    Public sa_sa_3_outpktstoolong_lo
    Public sa_sa_3_outpktstoolong_hi
    Public sa_sa_3_outpktssanotinuse_lo
    Public sa_sa_3_outpktssanotinuse_hi
    Public sa_sa_4_outoctetsencryptedprotected_lo
    Public sa_sa_4_outoctetsencryptedprotected_hi
    Public sa_sa_4_outpktsencryptedprotected_lo
    Public sa_sa_4_outpktsencryptedprotected_hi
    Public sa_sa_4_outpktstoolong_lo
    Public sa_sa_4_outpktstoolong_hi
    Public sa_sa_4_outpktssanotinuse_lo
    Public sa_sa_4_outpktssanotinuse_hi
    Public sa_sa_5_outoctetsencryptedprotected_lo
    Public sa_sa_5_outoctetsencryptedprotected_hi
    Public sa_sa_5_outpktsencryptedprotected_lo
    Public sa_sa_5_outpktsencryptedprotected_hi
    Public sa_sa_5_outpktstoolong_lo
    Public sa_sa_5_outpktstoolong_hi
    Public sa_sa_5_outpktssanotinuse_lo
    Public sa_sa_5_outpktssanotinuse_hi
    Public sa_sa_6_outoctetsencryptedprotected_lo
    Public sa_sa_6_outoctetsencryptedprotected_hi
    Public sa_sa_6_outpktsencryptedprotected_lo
    Public sa_sa_6_outpktsencryptedprotected_hi
    Public sa_sa_6_outpktstoolong_lo
    Public sa_sa_6_outpktstoolong_hi
    Public sa_sa_6_outpktssanotinuse_lo
    Public sa_sa_6_outpktssanotinuse_hi
    Public sa_sa_7_outoctetsencryptedprotected_lo
    Public sa_sa_7_outoctetsencryptedprotected_hi
    Public sa_sa_7_outpktsencryptedprotected_lo
    Public sa_sa_7_outpktsencryptedprotected_hi
    Public sa_sa_7_outpktstoolong_lo
    Public sa_sa_7_outpktstoolong_hi
    Public sa_sa_7_outpktssanotinuse_lo
    Public sa_sa_7_outpktssanotinuse_hi
    Public sa_sa_8_outoctetsencryptedprotected_lo
    Public sa_sa_8_outoctetsencryptedprotected_hi
    Public sa_sa_8_outpktsencryptedprotected_lo
    Public sa_sa_8_outpktsencryptedprotected_hi
    Public sa_sa_8_outpktstoolong_lo
    Public sa_sa_8_outpktstoolong_hi
    Public sa_sa_8_outpktssanotinuse_lo
    Public sa_sa_8_outpktssanotinuse_hi
    Public sa_sa_9_outoctetsencryptedprotected_lo
    Public sa_sa_9_outoctetsencryptedprotected_hi
    Public sa_sa_9_outpktsencryptedprotected_lo
    Public sa_sa_9_outpktsencryptedprotected_hi
    Public sa_sa_9_outpktstoolong_lo
    Public sa_sa_9_outpktstoolong_hi
    Public sa_sa_9_outpktssanotinuse_lo
    Public sa_sa_9_outpktssanotinuse_hi
    Public sa_sa_10_outoctetsencryptedprotected_lo
    Public sa_sa_10_outoctetsencryptedprotected_hi
    Public sa_sa_10_outpktsencryptedprotected_lo
    Public sa_sa_10_outpktsencryptedprotected_hi
    Public sa_sa_10_outpktstoolong_lo
    Public sa_sa_10_outpktstoolong_hi
    Public sa_sa_10_outpktssanotinuse_lo
    Public sa_sa_10_outpktssanotinuse_hi
    Public sa_sa_11_outoctetsencryptedprotected_lo
    Public sa_sa_11_outoctetsencryptedprotected_hi
    Public sa_sa_11_outpktsencryptedprotected_lo
    Public sa_sa_11_outpktsencryptedprotected_hi
    Public sa_sa_11_outpktstoolong_lo
    Public sa_sa_11_outpktstoolong_hi
    Public sa_sa_11_outpktssanotinuse_lo
    Public sa_sa_11_outpktssanotinuse_hi
    Public sa_sa_12_outoctetsencryptedprotected_lo
    Public sa_sa_12_outoctetsencryptedprotected_hi
    Public sa_sa_12_outpktsencryptedprotected_lo
    Public sa_sa_12_outpktsencryptedprotected_hi
    Public sa_sa_12_outpktstoolong_lo
    Public sa_sa_12_outpktstoolong_hi
    Public sa_sa_12_outpktssanotinuse_lo
    Public sa_sa_12_outpktssanotinuse_hi
    Public sa_sa_13_outoctetsencryptedprotected_lo
    Public sa_sa_13_outoctetsencryptedprotected_hi
    Public sa_sa_13_outpktsencryptedprotected_lo
    Public sa_sa_13_outpktsencryptedprotected_hi
    Public sa_sa_13_outpktstoolong_lo
    Public sa_sa_13_outpktstoolong_hi
    Public sa_sa_13_outpktssanotinuse_lo
    Public sa_sa_13_outpktssanotinuse_hi
    Public sa_sa_14_outoctetsencryptedprotected_lo
    Public sa_sa_14_outoctetsencryptedprotected_hi
    Public sa_sa_14_outpktsencryptedprotected_lo
    Public sa_sa_14_outpktsencryptedprotected_hi
    Public sa_sa_14_outpktstoolong_lo
    Public sa_sa_14_outpktstoolong_hi
    Public sa_sa_14_outpktssanotinuse_lo
    Public sa_sa_14_outpktssanotinuse_hi
    Public sa_sa_15_outoctetsencryptedprotected_lo
    Public sa_sa_15_outoctetsencryptedprotected_hi
    Public sa_sa_15_outpktsencryptedprotected_lo
    Public sa_sa_15_outpktsencryptedprotected_hi
    Public sa_sa_15_outpktstoolong_lo
    Public sa_sa_15_outpktstoolong_hi
    Public sa_sa_15_outpktssanotinuse_lo
    Public sa_sa_15_outpktssanotinuse_hi
    Public sa_sa_16_outoctetsencryptedprotected_lo
    Public sa_sa_16_outoctetsencryptedprotected_hi
    Public sa_sa_16_outpktsencryptedprotected_lo
    Public sa_sa_16_outpktsencryptedprotected_hi
    Public sa_sa_16_outpktstoolong_lo
    Public sa_sa_16_outpktstoolong_hi
    Public sa_sa_16_outpktssanotinuse_lo
    Public sa_sa_16_outpktssanotinuse_hi
    Public sa_sa_17_outoctetsencryptedprotected_lo
    Public sa_sa_17_outoctetsencryptedprotected_hi
    Public sa_sa_17_outpktsencryptedprotected_lo
    Public sa_sa_17_outpktsencryptedprotected_hi
    Public sa_sa_17_outpktstoolong_lo
    Public sa_sa_17_outpktstoolong_hi
    Public sa_sa_17_outpktssanotinuse_lo
    Public sa_sa_17_outpktssanotinuse_hi
    Public sa_sa_18_outoctetsencryptedprotected_lo
    Public sa_sa_18_outoctetsencryptedprotected_hi
    Public sa_sa_18_outpktsencryptedprotected_lo
    Public sa_sa_18_outpktsencryptedprotected_hi
    Public sa_sa_18_outpktstoolong_lo
    Public sa_sa_18_outpktstoolong_hi
    Public sa_sa_18_outpktssanotinuse_lo
    Public sa_sa_18_outpktssanotinuse_hi
    Public sa_sa_19_outoctetsencryptedprotected_lo
    Public sa_sa_19_outoctetsencryptedprotected_hi
    Public sa_sa_19_outpktsencryptedprotected_lo
    Public sa_sa_19_outpktsencryptedprotected_hi
    Public sa_sa_19_outpktstoolong_lo
    Public sa_sa_19_outpktstoolong_hi
    Public sa_sa_19_outpktssanotinuse_lo
    Public sa_sa_19_outpktssanotinuse_hi
    Public sa_sa_20_outoctetsencryptedprotected_lo
    Public sa_sa_20_outoctetsencryptedprotected_hi
    Public sa_sa_20_outpktsencryptedprotected_lo
    Public sa_sa_20_outpktsencryptedprotected_hi
    Public sa_sa_20_outpktstoolong_lo
    Public sa_sa_20_outpktstoolong_hi
    Public sa_sa_20_outpktssanotinuse_lo
    Public sa_sa_20_outpktssanotinuse_hi
    Public sa_sa_21_outoctetsencryptedprotected_lo
    Public sa_sa_21_outoctetsencryptedprotected_hi
    Public sa_sa_21_outpktsencryptedprotected_lo
    Public sa_sa_21_outpktsencryptedprotected_hi
    Public sa_sa_21_outpktstoolong_lo
    Public sa_sa_21_outpktstoolong_hi
    Public sa_sa_21_outpktssanotinuse_lo
    Public sa_sa_21_outpktssanotinuse_hi
    Public sa_sa_22_outoctetsencryptedprotected_lo
    Public sa_sa_22_outoctetsencryptedprotected_hi
    Public sa_sa_22_outpktsencryptedprotected_lo
    Public sa_sa_22_outpktsencryptedprotected_hi
    Public sa_sa_22_outpktstoolong_lo
    Public sa_sa_22_outpktstoolong_hi
    Public sa_sa_22_outpktssanotinuse_lo
    Public sa_sa_22_outpktssanotinuse_hi
    Public sa_sa_23_outoctetsencryptedprotected_lo
    Public sa_sa_23_outoctetsencryptedprotected_hi
    Public sa_sa_23_outpktsencryptedprotected_lo
    Public sa_sa_23_outpktsencryptedprotected_hi
    Public sa_sa_23_outpktstoolong_lo
    Public sa_sa_23_outpktstoolong_hi
    Public sa_sa_23_outpktssanotinuse_lo
    Public sa_sa_23_outpktssanotinuse_hi
    Public sa_sa_24_outoctetsencryptedprotected_lo
    Public sa_sa_24_outoctetsencryptedprotected_hi
    Public sa_sa_24_outpktsencryptedprotected_lo
    Public sa_sa_24_outpktsencryptedprotected_hi
    Public sa_sa_24_outpktstoolong_lo
    Public sa_sa_24_outpktstoolong_hi
    Public sa_sa_24_outpktssanotinuse_lo
    Public sa_sa_24_outpktssanotinuse_hi
    Public sa_sa_25_outoctetsencryptedprotected_lo
    Public sa_sa_25_outoctetsencryptedprotected_hi
    Public sa_sa_25_outpktsencryptedprotected_lo
    Public sa_sa_25_outpktsencryptedprotected_hi
    Public sa_sa_25_outpktstoolong_lo
    Public sa_sa_25_outpktstoolong_hi
    Public sa_sa_25_outpktssanotinuse_lo
    Public sa_sa_25_outpktssanotinuse_hi
    Public sa_sa_26_outoctetsencryptedprotected_lo
    Public sa_sa_26_outoctetsencryptedprotected_hi
    Public sa_sa_26_outpktsencryptedprotected_lo
    Public sa_sa_26_outpktsencryptedprotected_hi
    Public sa_sa_26_outpktstoolong_lo
    Public sa_sa_26_outpktstoolong_hi
    Public sa_sa_26_outpktssanotinuse_lo
    Public sa_sa_26_outpktssanotinuse_hi
    Public sa_sa_27_outoctetsencryptedprotected_lo
    Public sa_sa_27_outoctetsencryptedprotected_hi
    Public sa_sa_27_outpktsencryptedprotected_lo
    Public sa_sa_27_outpktsencryptedprotected_hi
    Public sa_sa_27_outpktstoolong_lo
    Public sa_sa_27_outpktstoolong_hi
    Public sa_sa_27_outpktssanotinuse_lo
    Public sa_sa_27_outpktssanotinuse_hi
    Public sa_sa_28_outoctetsencryptedprotected_lo
    Public sa_sa_28_outoctetsencryptedprotected_hi
    Public sa_sa_28_outpktsencryptedprotected_lo
    Public sa_sa_28_outpktsencryptedprotected_hi
    Public sa_sa_28_outpktstoolong_lo
    Public sa_sa_28_outpktstoolong_hi
    Public sa_sa_28_outpktssanotinuse_lo
    Public sa_sa_28_outpktssanotinuse_hi
    Public sa_sa_29_outoctetsencryptedprotected_lo
    Public sa_sa_29_outoctetsencryptedprotected_hi
    Public sa_sa_29_outpktsencryptedprotected_lo
    Public sa_sa_29_outpktsencryptedprotected_hi
    Public sa_sa_29_outpktstoolong_lo
    Public sa_sa_29_outpktstoolong_hi
    Public sa_sa_29_outpktssanotinuse_lo
    Public sa_sa_29_outpktssanotinuse_hi
    Public sa_sa_30_outoctetsencryptedprotected_lo
    Public sa_sa_30_outoctetsencryptedprotected_hi
    Public sa_sa_30_outpktsencryptedprotected_lo
    Public sa_sa_30_outpktsencryptedprotected_hi
    Public sa_sa_30_outpktstoolong_lo
    Public sa_sa_30_outpktstoolong_hi
    Public sa_sa_30_outpktssanotinuse_lo
    Public sa_sa_30_outpktssanotinuse_hi
    Public sa_sa_31_outoctetsencryptedprotected_lo
    Public sa_sa_31_outoctetsencryptedprotected_hi
    Public sa_sa_31_outpktsencryptedprotected_lo
    Public sa_sa_31_outpktsencryptedprotected_hi
    Public sa_sa_31_outpktstoolong_lo
    Public sa_sa_31_outpktstoolong_hi
    Public sa_sa_31_outpktssanotinuse_lo
    Public sa_sa_31_outpktssanotinuse_hi


    Public default function Init(aBaseAddr)
        Set sa_sa_0_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_0_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_0_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_0_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_0_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_0_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_0_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_0_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_0_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_1_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_1_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_1_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_1_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_1_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_1_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_1_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_1_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_1_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_2_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_2_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_2_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_2_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_2_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_2_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_2_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_2_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_2_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_3_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_3_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_3_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_3_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_3_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_3_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_3_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_3_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_3_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_4_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_4_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_4_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_4_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_4_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_4_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_4_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_4_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_4_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_5_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_5_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_5_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_5_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_5_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_5_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_5_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_5_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_5_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_6_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_6_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_6_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_6_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_6_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_6_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_6_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_6_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_6_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_7_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_7_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_7_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_7_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_7_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_7_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_7_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_7_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_7_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_8_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_8_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_8_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_8_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_8_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_8_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_8_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_8_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_8_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_9_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_9_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_9_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_9_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_9_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_9_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_9_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_9_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_9_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_10_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_10_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_10_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_10_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_10_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_10_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_10_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_10_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_10_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_11_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_11_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_11_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_11_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_11_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_11_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_11_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_11_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_11_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_12_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_12_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_12_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_12_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_12_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_12_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_12_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_12_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_12_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_13_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_13_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_13_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_13_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_13_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_13_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_13_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_13_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_13_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_14_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_14_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_14_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_14_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_14_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_14_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_14_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_14_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_14_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_15_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_15_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_15_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_15_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_15_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_15_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_15_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_15_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_15_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_16_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_16_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_16_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_16_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_16_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_16_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_16_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_16_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_16_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_17_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_17_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_17_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_17_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_17_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_17_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_17_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_17_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_17_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_18_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_18_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_18_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_18_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_18_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_18_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_18_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_18_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_18_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_19_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_19_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_19_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_19_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_19_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_19_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_19_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_19_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_19_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_20_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_20_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_20_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_20_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_20_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_20_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_20_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_20_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_20_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_21_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_21_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_21_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_21_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_21_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_21_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_21_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_21_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_21_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_22_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_22_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_22_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_22_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_22_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_22_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_22_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_22_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_22_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_23_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_23_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_23_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_23_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_23_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_23_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_23_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_23_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_23_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_24_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_24_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_24_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_24_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_24_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_24_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_24_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_24_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_24_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_25_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_25_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_25_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_25_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_25_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_25_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_25_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_25_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_25_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_26_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_26_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_26_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_26_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_26_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_26_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_26_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_26_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_26_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_27_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_27_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_27_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_27_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_27_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_27_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_27_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_27_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_27_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_28_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_28_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_28_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_28_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_28_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_28_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_28_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_28_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_28_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_29_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_29_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_29_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_29_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_29_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_29_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_29_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_29_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_29_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_30_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_30_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_30_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_30_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_30_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_30_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_30_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_30_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_30_outpktssanotinuse_hi)(aBaseAddr, 32)
        Set sa_sa_31_outoctetsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outoctetsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_31_outoctetsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outoctetsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_31_outpktsencryptedprotected_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktsencryptedprotected_lo)(aBaseAddr, 32)
        Set sa_sa_31_outpktsencryptedprotected_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktsencryptedprotected_hi)(aBaseAddr, 32)
        Set sa_sa_31_outpktstoolong_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktstoolong_lo)(aBaseAddr, 32)
        Set sa_sa_31_outpktstoolong_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktstoolong_hi)(aBaseAddr, 32)
        Set sa_sa_31_outpktssanotinuse_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktssanotinuse_lo)(aBaseAddr, 32)
        Set sa_sa_31_outpktssanotinuse_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_sa_sa_31_outpktssanotinuse_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_SA_COUNTERS_0_31_INSTANCE)(&H4d510000))


