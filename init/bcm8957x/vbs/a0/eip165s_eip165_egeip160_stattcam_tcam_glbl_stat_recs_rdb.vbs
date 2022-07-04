

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1420c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_lo
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COUNTER_value = &H0
        flag_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COUNTER                                    [31:0]           get_COUNTER
''                                                             set_COUNTER
''                                                             read_COUNTER
''                                                             write_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_hi
    Private write_COUNTER_value
    Private read_COUNTER_value
    Private flag_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COUNTER
        get_COUNTER = read_COUNTER_value
    End Property

    Property Let set_COUNTER(aData)
        write_COUNTER_value = aData
        flag_COUNTER        = &H1
    End Property

    Property Get read_COUNTER
        read
        read_COUNTER = read_COUNTER_value
    End Property

    Property Let write_COUNTER(aData)
        set_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_COUNTER = &H0 Then read
        If flag_COUNTER = &H0 Then write_COUNTER_value = get_COUNTER

        regValue = leftShift(write_COUNTER_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        COUNTER_mask = &Hffffffff
        if data_low > LONG_MAX then
            if COUNTER_mask = mask then
                read_COUNTER_value = data_low
            else
                read_COUNTER_value = (data_low - H8000_0000) and COUNTER_mask
            end If
        else
            read_COUNTER_value = data_low and COUNTER_mask
        end If

        data = data_low
    End Property

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

Class EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE

    Public tcam_counter0_lo
    Public tcam_counter0_hi
    Public tcam_counter1_lo
    Public tcam_counter1_hi
    Public tcam_counter2_lo
    Public tcam_counter2_hi


    Public default function Init(aBaseAddr)
        Set tcam_counter0_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_lo)(aBaseAddr, 32)
        Set tcam_counter0_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_hi)(aBaseAddr, 32)
        Set tcam_counter1_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_lo)(aBaseAddr, 32)
        Set tcam_counter1_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_hi)(aBaseAddr, 32)
        Set tcam_counter2_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_lo)(aBaseAddr, 32)
        Set tcam_counter2_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d510000))


