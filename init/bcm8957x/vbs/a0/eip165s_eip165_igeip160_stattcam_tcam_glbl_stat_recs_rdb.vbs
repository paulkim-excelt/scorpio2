

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_lo
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
        offset = &H4200
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_hi
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
        offset = &H4204
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_lo
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
        offset = &H4208
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_hi
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
        offset = &H420c
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_lo
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_lo
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
        offset = &H4210
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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_hi
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
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_hi
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
        offset = &H4214
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

Class EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE

    Public tcam_counter0_lo
    Public tcam_counter0_hi
    Public tcam_counter1_lo
    Public tcam_counter1_hi
    Public tcam_counter2_lo
    Public tcam_counter2_hi


    Public default function Init(aBaseAddr)
        Set tcam_counter0_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_lo)(aBaseAddr, 32)
        Set tcam_counter0_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter0_hi)(aBaseAddr, 32)
        Set tcam_counter1_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_lo)(aBaseAddr, 32)
        Set tcam_counter1_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter1_hi)(aBaseAddr, 32)
        Set tcam_counter2_lo = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_lo)(aBaseAddr, 32)
        Set tcam_counter2_hi = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_tcam_counter2_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_GLBL_STAT_RECS_INSTANCE)(&H4d510000))


