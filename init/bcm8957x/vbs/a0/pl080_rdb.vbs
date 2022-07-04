

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


'' @REGISTER : PL080_dmacintstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntStatus                                  [7:0]            get_IntStatus
''                                                             set_IntStatus
''                                                             read_IntStatus
''                                                             write_IntStatus
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacintstatus
    Private write_IntStatus_value
    Private read_IntStatus_value
    Private flag_IntStatus

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

    Property Get get_IntStatus
        get_IntStatus = read_IntStatus_value
    End Property

    Property Let set_IntStatus(aData)
        write_IntStatus_value = aData
        flag_IntStatus        = &H1
    End Property

    Property Get read_IntStatus
        read
        read_IntStatus = read_IntStatus_value
    End Property

    Property Let write_IntStatus(aData)
        set_IntStatus = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntStatus_mask = &Hff
        if data_low > LONG_MAX then
            if IntStatus_mask = mask then
                read_IntStatus_value = data_low
            else
                read_IntStatus_value = (data_low - H8000_0000) and IntStatus_mask
            end If
        else
            read_IntStatus_value = data_low and IntStatus_mask
        end If

    End Sub

    Sub write
        If flag_IntStatus = &H0 Then read
        If flag_IntStatus = &H0 Then write_IntStatus_value = get_IntStatus

        regValue = leftShift((write_IntStatus_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntStatus_mask = &Hff
        if data_low > LONG_MAX then
            if IntStatus_mask = mask then
                read_IntStatus_value = data_low
            else
                read_IntStatus_value = (data_low - H8000_0000) and IntStatus_mask
            end If
        else
            read_IntStatus_value = data_low and IntStatus_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IntStatus_value = &H0
        flag_IntStatus        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacinttcstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntTCStatus                                [7:0]            get_IntTCStatus
''                                                             set_IntTCStatus
''                                                             read_IntTCStatus
''                                                             write_IntTCStatus
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacinttcstatus
    Private write_IntTCStatus_value
    Private read_IntTCStatus_value
    Private flag_IntTCStatus

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

    Property Get get_IntTCStatus
        get_IntTCStatus = read_IntTCStatus_value
    End Property

    Property Let set_IntTCStatus(aData)
        write_IntTCStatus_value = aData
        flag_IntTCStatus        = &H1
    End Property

    Property Get read_IntTCStatus
        read
        read_IntTCStatus = read_IntTCStatus_value
    End Property

    Property Let write_IntTCStatus(aData)
        set_IntTCStatus = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntTCStatus_mask = &Hff
        if data_low > LONG_MAX then
            if IntTCStatus_mask = mask then
                read_IntTCStatus_value = data_low
            else
                read_IntTCStatus_value = (data_low - H8000_0000) and IntTCStatus_mask
            end If
        else
            read_IntTCStatus_value = data_low and IntTCStatus_mask
        end If

    End Sub

    Sub write
        If flag_IntTCStatus = &H0 Then read
        If flag_IntTCStatus = &H0 Then write_IntTCStatus_value = get_IntTCStatus

        regValue = leftShift((write_IntTCStatus_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntTCStatus_mask = &Hff
        if data_low > LONG_MAX then
            if IntTCStatus_mask = mask then
                read_IntTCStatus_value = data_low
            else
                read_IntTCStatus_value = (data_low - H8000_0000) and IntTCStatus_mask
            end If
        else
            read_IntTCStatus_value = data_low and IntTCStatus_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IntTCStatus_value = &H0
        flag_IntTCStatus        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacinttcclear
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntTCClear                                 [7:0]            get_IntTCClear
''                                                             set_IntTCClear
''                                                             read_IntTCClear
''                                                             write_IntTCClear
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacinttcclear
    Private write_IntTCClear_value
    Private read_IntTCClear_value
    Private flag_IntTCClear

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

    Property Get get_IntTCClear
        get_IntTCClear = read_IntTCClear_value
    End Property

    Property Let set_IntTCClear(aData)
        write_IntTCClear_value = aData
        flag_IntTCClear        = &H1
    End Property

    Property Get read_IntTCClear
        read
        read_IntTCClear = read_IntTCClear_value
    End Property

    Property Let write_IntTCClear(aData)
        set_IntTCClear = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntTCClear_mask = &Hff
        if data_low > LONG_MAX then
            if IntTCClear_mask = mask then
                read_IntTCClear_value = data_low
            else
                read_IntTCClear_value = (data_low - H8000_0000) and IntTCClear_mask
            end If
        else
            read_IntTCClear_value = data_low and IntTCClear_mask
        end If

    End Sub

    Sub write
        If flag_IntTCClear = &H0 Then read
        If flag_IntTCClear = &H0 Then write_IntTCClear_value = get_IntTCClear

        regValue = leftShift((write_IntTCClear_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntTCClear_mask = &Hff
        if data_low > LONG_MAX then
            if IntTCClear_mask = mask then
                read_IntTCClear_value = data_low
            else
                read_IntTCClear_value = (data_low - H8000_0000) and IntTCClear_mask
            end If
        else
            read_IntTCClear_value = data_low and IntTCClear_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IntTCClear_value = &H0
        flag_IntTCClear        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacinterrorstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntErrorStatus                             [7:0]            get_IntErrorStatus
''                                                             set_IntErrorStatus
''                                                             read_IntErrorStatus
''                                                             write_IntErrorStatus
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacinterrorstatus
    Private write_IntErrorStatus_value
    Private read_IntErrorStatus_value
    Private flag_IntErrorStatus

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

    Property Get get_IntErrorStatus
        get_IntErrorStatus = read_IntErrorStatus_value
    End Property

    Property Let set_IntErrorStatus(aData)
        write_IntErrorStatus_value = aData
        flag_IntErrorStatus        = &H1
    End Property

    Property Get read_IntErrorStatus
        read
        read_IntErrorStatus = read_IntErrorStatus_value
    End Property

    Property Let write_IntErrorStatus(aData)
        set_IntErrorStatus = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntErrorStatus_mask = &Hff
        if data_low > LONG_MAX then
            if IntErrorStatus_mask = mask then
                read_IntErrorStatus_value = data_low
            else
                read_IntErrorStatus_value = (data_low - H8000_0000) and IntErrorStatus_mask
            end If
        else
            read_IntErrorStatus_value = data_low and IntErrorStatus_mask
        end If

    End Sub

    Sub write
        If flag_IntErrorStatus = &H0 Then read
        If flag_IntErrorStatus = &H0 Then write_IntErrorStatus_value = get_IntErrorStatus

        regValue = leftShift((write_IntErrorStatus_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntErrorStatus_mask = &Hff
        if data_low > LONG_MAX then
            if IntErrorStatus_mask = mask then
                read_IntErrorStatus_value = data_low
            else
                read_IntErrorStatus_value = (data_low - H8000_0000) and IntErrorStatus_mask
            end If
        else
            read_IntErrorStatus_value = data_low and IntErrorStatus_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IntErrorStatus_value = &H0
        flag_IntErrorStatus        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacinterrclr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntErrClr                                  [7:0]            get_IntErrClr
''                                                             set_IntErrClr
''                                                             read_IntErrClr
''                                                             write_IntErrClr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacinterrclr
    Private write_IntErrClr_value
    Private read_IntErrClr_value
    Private flag_IntErrClr

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

    Property Get get_IntErrClr
        get_IntErrClr = read_IntErrClr_value
    End Property

    Property Let set_IntErrClr(aData)
        write_IntErrClr_value = aData
        flag_IntErrClr        = &H1
    End Property

    Property Get read_IntErrClr
        read
        read_IntErrClr = read_IntErrClr_value
    End Property

    Property Let write_IntErrClr(aData)
        set_IntErrClr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntErrClr_mask = &Hff
        if data_low > LONG_MAX then
            if IntErrClr_mask = mask then
                read_IntErrClr_value = data_low
            else
                read_IntErrClr_value = (data_low - H8000_0000) and IntErrClr_mask
            end If
        else
            read_IntErrClr_value = data_low and IntErrClr_mask
        end If

    End Sub

    Sub write
        If flag_IntErrClr = &H0 Then read
        If flag_IntErrClr = &H0 Then write_IntErrClr_value = get_IntErrClr

        regValue = leftShift((write_IntErrClr_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntErrClr_mask = &Hff
        if data_low > LONG_MAX then
            if IntErrClr_mask = mask then
                read_IntErrClr_value = data_low
            else
                read_IntErrClr_value = (data_low - H8000_0000) and IntErrClr_mask
            end If
        else
            read_IntErrClr_value = data_low and IntErrClr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IntErrClr_value = &H0
        flag_IntErrClr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacrawinttcstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RawIntTCStatus                             [7:0]            get_RawIntTCStatus
''                                                             set_RawIntTCStatus
''                                                             read_RawIntTCStatus
''                                                             write_RawIntTCStatus
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacrawinttcstatus
    Private write_RawIntTCStatus_value
    Private read_RawIntTCStatus_value
    Private flag_RawIntTCStatus

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

    Property Get get_RawIntTCStatus
        get_RawIntTCStatus = read_RawIntTCStatus_value
    End Property

    Property Let set_RawIntTCStatus(aData)
        write_RawIntTCStatus_value = aData
        flag_RawIntTCStatus        = &H1
    End Property

    Property Get read_RawIntTCStatus
        read
        read_RawIntTCStatus = read_RawIntTCStatus_value
    End Property

    Property Let write_RawIntTCStatus(aData)
        set_RawIntTCStatus = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RawIntTCStatus_mask = &Hff
        if data_low > LONG_MAX then
            if RawIntTCStatus_mask = mask then
                read_RawIntTCStatus_value = data_low
            else
                read_RawIntTCStatus_value = (data_low - H8000_0000) and RawIntTCStatus_mask
            end If
        else
            read_RawIntTCStatus_value = data_low and RawIntTCStatus_mask
        end If

    End Sub

    Sub write
        If flag_RawIntTCStatus = &H0 Then read
        If flag_RawIntTCStatus = &H0 Then write_RawIntTCStatus_value = get_RawIntTCStatus

        regValue = leftShift((write_RawIntTCStatus_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RawIntTCStatus_mask = &Hff
        if data_low > LONG_MAX then
            if RawIntTCStatus_mask = mask then
                read_RawIntTCStatus_value = data_low
            else
                read_RawIntTCStatus_value = (data_low - H8000_0000) and RawIntTCStatus_mask
            end If
        else
            read_RawIntTCStatus_value = data_low and RawIntTCStatus_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RawIntTCStatus_value = &H0
        flag_RawIntTCStatus        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacrawinterrorstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RawIntErrorStatus                          [7:0]            get_RawIntErrorStatus
''                                                             set_RawIntErrorStatus
''                                                             read_RawIntErrorStatus
''                                                             write_RawIntErrorStatus
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacrawinterrorstatus
    Private write_RawIntErrorStatus_value
    Private read_RawIntErrorStatus_value
    Private flag_RawIntErrorStatus

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

    Property Get get_RawIntErrorStatus
        get_RawIntErrorStatus = read_RawIntErrorStatus_value
    End Property

    Property Let set_RawIntErrorStatus(aData)
        write_RawIntErrorStatus_value = aData
        flag_RawIntErrorStatus        = &H1
    End Property

    Property Get read_RawIntErrorStatus
        read
        read_RawIntErrorStatus = read_RawIntErrorStatus_value
    End Property

    Property Let write_RawIntErrorStatus(aData)
        set_RawIntErrorStatus = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RawIntErrorStatus_mask = &Hff
        if data_low > LONG_MAX then
            if RawIntErrorStatus_mask = mask then
                read_RawIntErrorStatus_value = data_low
            else
                read_RawIntErrorStatus_value = (data_low - H8000_0000) and RawIntErrorStatus_mask
            end If
        else
            read_RawIntErrorStatus_value = data_low and RawIntErrorStatus_mask
        end If

    End Sub

    Sub write
        If flag_RawIntErrorStatus = &H0 Then read
        If flag_RawIntErrorStatus = &H0 Then write_RawIntErrorStatus_value = get_RawIntErrorStatus

        regValue = leftShift((write_RawIntErrorStatus_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RawIntErrorStatus_mask = &Hff
        if data_low > LONG_MAX then
            if RawIntErrorStatus_mask = mask then
                read_RawIntErrorStatus_value = data_low
            else
                read_RawIntErrorStatus_value = (data_low - H8000_0000) and RawIntErrorStatus_mask
            end If
        else
            read_RawIntErrorStatus_value = data_low and RawIntErrorStatus_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RawIntErrorStatus_value = &H0
        flag_RawIntErrorStatus        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacenbldchns
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EnabledChannels                            [7:0]            get_EnabledChannels
''                                                             set_EnabledChannels
''                                                             read_EnabledChannels
''                                                             write_EnabledChannels
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacenbldchns
    Private write_EnabledChannels_value
    Private read_EnabledChannels_value
    Private flag_EnabledChannels

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EnabledChannels
        get_EnabledChannels = read_EnabledChannels_value
    End Property

    Property Let set_EnabledChannels(aData)
        write_EnabledChannels_value = aData
        flag_EnabledChannels        = &H1
    End Property

    Property Get read_EnabledChannels
        read
        read_EnabledChannels = read_EnabledChannels_value
    End Property

    Property Let write_EnabledChannels(aData)
        set_EnabledChannels = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EnabledChannels_mask = &Hff
        if data_low > LONG_MAX then
            if EnabledChannels_mask = mask then
                read_EnabledChannels_value = data_low
            else
                read_EnabledChannels_value = (data_low - H8000_0000) and EnabledChannels_mask
            end If
        else
            read_EnabledChannels_value = data_low and EnabledChannels_mask
        end If

    End Sub

    Sub write
        If flag_EnabledChannels = &H0 Then read
        If flag_EnabledChannels = &H0 Then write_EnabledChannels_value = get_EnabledChannels

        regValue = leftShift((write_EnabledChannels_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EnabledChannels_mask = &Hff
        if data_low > LONG_MAX then
            if EnabledChannels_mask = mask then
                read_EnabledChannels_value = data_low
            else
                read_EnabledChannels_value = (data_low - H8000_0000) and EnabledChannels_mask
            end If
        else
            read_EnabledChannels_value = data_low and EnabledChannels_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EnabledChannels_value = &H0
        flag_EnabledChannels        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacsoftbreq
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SoftBReq                                   [15:0]           get_SoftBReq
''                                                             set_SoftBReq
''                                                             read_SoftBReq
''                                                             write_SoftBReq
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacsoftbreq
    Private write_SoftBReq_value
    Private read_SoftBReq_value
    Private flag_SoftBReq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SoftBReq
        get_SoftBReq = read_SoftBReq_value
    End Property

    Property Let set_SoftBReq(aData)
        write_SoftBReq_value = aData
        flag_SoftBReq        = &H1
    End Property

    Property Get read_SoftBReq
        read
        read_SoftBReq = read_SoftBReq_value
    End Property

    Property Let write_SoftBReq(aData)
        set_SoftBReq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftBReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftBReq_mask = mask then
                read_SoftBReq_value = data_low
            else
                read_SoftBReq_value = (data_low - H8000_0000) and SoftBReq_mask
            end If
        else
            read_SoftBReq_value = data_low and SoftBReq_mask
        end If

    End Sub

    Sub write
        If flag_SoftBReq = &H0 Then read
        If flag_SoftBReq = &H0 Then write_SoftBReq_value = get_SoftBReq

        regValue = leftShift((write_SoftBReq_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftBReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftBReq_mask = mask then
                read_SoftBReq_value = data_low
            else
                read_SoftBReq_value = (data_low - H8000_0000) and SoftBReq_mask
            end If
        else
            read_SoftBReq_value = data_low and SoftBReq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SoftBReq_value = &H0
        flag_SoftBReq        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacsoftsreq
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SoftSReq                                   [15:0]           get_SoftSReq
''                                                             set_SoftSReq
''                                                             read_SoftSReq
''                                                             write_SoftSReq
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacsoftsreq
    Private write_SoftSReq_value
    Private read_SoftSReq_value
    Private flag_SoftSReq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SoftSReq
        get_SoftSReq = read_SoftSReq_value
    End Property

    Property Let set_SoftSReq(aData)
        write_SoftSReq_value = aData
        flag_SoftSReq        = &H1
    End Property

    Property Get read_SoftSReq
        read
        read_SoftSReq = read_SoftSReq_value
    End Property

    Property Let write_SoftSReq(aData)
        set_SoftSReq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftSReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftSReq_mask = mask then
                read_SoftSReq_value = data_low
            else
                read_SoftSReq_value = (data_low - H8000_0000) and SoftSReq_mask
            end If
        else
            read_SoftSReq_value = data_low and SoftSReq_mask
        end If

    End Sub

    Sub write
        If flag_SoftSReq = &H0 Then read
        If flag_SoftSReq = &H0 Then write_SoftSReq_value = get_SoftSReq

        regValue = leftShift((write_SoftSReq_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftSReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftSReq_mask = mask then
                read_SoftSReq_value = data_low
            else
                read_SoftSReq_value = (data_low - H8000_0000) and SoftSReq_mask
            end If
        else
            read_SoftSReq_value = data_low and SoftSReq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SoftSReq_value = &H0
        flag_SoftSReq        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacsoftlbreq
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SoftLBReq                                  [15:0]           get_SoftLBReq
''                                                             set_SoftLBReq
''                                                             read_SoftLBReq
''                                                             write_SoftLBReq
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacsoftlbreq
    Private write_SoftLBReq_value
    Private read_SoftLBReq_value
    Private flag_SoftLBReq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SoftLBReq
        get_SoftLBReq = read_SoftLBReq_value
    End Property

    Property Let set_SoftLBReq(aData)
        write_SoftLBReq_value = aData
        flag_SoftLBReq        = &H1
    End Property

    Property Get read_SoftLBReq
        read
        read_SoftLBReq = read_SoftLBReq_value
    End Property

    Property Let write_SoftLBReq(aData)
        set_SoftLBReq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftLBReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftLBReq_mask = mask then
                read_SoftLBReq_value = data_low
            else
                read_SoftLBReq_value = (data_low - H8000_0000) and SoftLBReq_mask
            end If
        else
            read_SoftLBReq_value = data_low and SoftLBReq_mask
        end If

    End Sub

    Sub write
        If flag_SoftLBReq = &H0 Then read
        If flag_SoftLBReq = &H0 Then write_SoftLBReq_value = get_SoftLBReq

        regValue = leftShift((write_SoftLBReq_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftLBReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftLBReq_mask = mask then
                read_SoftLBReq_value = data_low
            else
                read_SoftLBReq_value = (data_low - H8000_0000) and SoftLBReq_mask
            end If
        else
            read_SoftLBReq_value = data_low and SoftLBReq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SoftLBReq_value = &H0
        flag_SoftLBReq        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacsoftlsreq
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SoftLSReq                                  [15:0]           get_SoftLSReq
''                                                             set_SoftLSReq
''                                                             read_SoftLSReq
''                                                             write_SoftLSReq
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacsoftlsreq
    Private write_SoftLSReq_value
    Private read_SoftLSReq_value
    Private flag_SoftLSReq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SoftLSReq
        get_SoftLSReq = read_SoftLSReq_value
    End Property

    Property Let set_SoftLSReq(aData)
        write_SoftLSReq_value = aData
        flag_SoftLSReq        = &H1
    End Property

    Property Get read_SoftLSReq
        read
        read_SoftLSReq = read_SoftLSReq_value
    End Property

    Property Let write_SoftLSReq(aData)
        set_SoftLSReq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftLSReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftLSReq_mask = mask then
                read_SoftLSReq_value = data_low
            else
                read_SoftLSReq_value = (data_low - H8000_0000) and SoftLSReq_mask
            end If
        else
            read_SoftLSReq_value = data_low and SoftLSReq_mask
        end If

    End Sub

    Sub write
        If flag_SoftLSReq = &H0 Then read
        If flag_SoftLSReq = &H0 Then write_SoftLSReq_value = get_SoftLSReq

        regValue = leftShift((write_SoftLSReq_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SoftLSReq_mask = &Hffff
        if data_low > LONG_MAX then
            if SoftLSReq_mask = mask then
                read_SoftLSReq_value = data_low
            else
                read_SoftLSReq_value = (data_low - H8000_0000) and SoftLSReq_mask
            end If
        else
            read_SoftLSReq_value = data_low and SoftLSReq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SoftLSReq_value = &H0
        flag_SoftLSReq        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacconfiguration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MasterEndian                               [1:1]            get_MasterEndian
''                                                             set_MasterEndian
''                                                             read_MasterEndian
''                                                             write_MasterEndian
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacconfiguration
    Private write_MasterEndian_value
    Private read_MasterEndian_value
    Private flag_MasterEndian
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MasterEndian
        get_MasterEndian = read_MasterEndian_value
    End Property

    Property Let set_MasterEndian(aData)
        write_MasterEndian_value = aData
        flag_MasterEndian        = &H1
    End Property

    Property Get read_MasterEndian
        read
        read_MasterEndian = read_MasterEndian_value
    End Property

    Property Let write_MasterEndian(aData)
        set_MasterEndian = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MasterEndian_value = rightShift(data_low, 1) and &H1
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_MasterEndian = &H0 or flag_Enable = &H0 Then read
        If flag_MasterEndian = &H0 Then write_MasterEndian_value = get_MasterEndian
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_MasterEndian_value and &H1), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MasterEndian_value = rightShift(data_low, 1) and &H1
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MasterEndian_value = &H0
        flag_MasterEndian        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacsync
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACSync                                   [15:0]           get_DMACSync
''                                                             set_DMACSync
''                                                             read_DMACSync
''                                                             write_DMACSync
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacsync
    Private write_DMACSync_value
    Private read_DMACSync_value
    Private flag_DMACSync

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DMACSync
        get_DMACSync = read_DMACSync_value
    End Property

    Property Let set_DMACSync(aData)
        write_DMACSync_value = aData
        flag_DMACSync        = &H1
    End Property

    Property Get read_DMACSync
        read
        read_DMACSync = read_DMACSync_value
    End Property

    Property Let write_DMACSync(aData)
        set_DMACSync = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACSync_mask = &Hffff
        if data_low > LONG_MAX then
            if DMACSync_mask = mask then
                read_DMACSync_value = data_low
            else
                read_DMACSync_value = (data_low - H8000_0000) and DMACSync_mask
            end If
        else
            read_DMACSync_value = data_low and DMACSync_mask
        end If

    End Sub

    Sub write
        If flag_DMACSync = &H0 Then read
        If flag_DMACSync = &H0 Then write_DMACSync_value = get_DMACSync

        regValue = leftShift((write_DMACSync_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACSync_mask = &Hffff
        if data_low > LONG_MAX then
            if DMACSync_mask = mask then
                read_DMACSync_value = data_low
            else
                read_DMACSync_value = (data_low - H8000_0000) and DMACSync_mask
            end If
        else
            read_DMACSync_value = data_low and DMACSync_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACSync_value = &H0
        flag_DMACSync        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc0srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc0srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc0destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc0destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc0lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc0lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc0control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc0control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc0configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc0configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc1srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc1srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc1destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc1destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc1lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc1lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc1control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc1control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc1configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc1configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc2srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc2srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H140
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc2destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc2destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H144
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc2lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc2lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H148
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc2control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc2control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc2configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc2configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H150
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc3srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc3srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H160
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc3destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc3destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H164
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc3lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc3lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H168
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc3control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc3control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc3configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc3configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H170
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc4srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc4srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H180
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc4destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc4destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H184
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc4lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc4lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H188
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc4control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc4control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc4configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc4configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H190
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc5srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc5srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc5destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc5destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc5lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc5lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc5control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc5control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc5configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc5configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc6srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc6srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc6destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc6destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc6lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc6lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc6control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc6control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc6configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc6configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc7srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SrcAddr                                    [31:0]           get_SrcAddr
''                                                             set_SrcAddr
''                                                             read_SrcAddr
''                                                             write_SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc7srcaddr
    Private write_SrcAddr_value
    Private read_SrcAddr_value
    Private flag_SrcAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SrcAddr
        get_SrcAddr = read_SrcAddr_value
    End Property

    Property Let set_SrcAddr(aData)
        write_SrcAddr_value = aData
        flag_SrcAddr        = &H1
    End Property

    Property Get read_SrcAddr
        read
        read_SrcAddr = read_SrcAddr_value
    End Property

    Property Let write_SrcAddr(aData)
        set_SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_SrcAddr = &H0 Then read
        If flag_SrcAddr = &H0 Then write_SrcAddr_value = get_SrcAddr

        regValue = leftShift(write_SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SrcAddr_mask = mask then
                read_SrcAddr_value = data_low
            else
                read_SrcAddr_value = (data_low - H8000_0000) and SrcAddr_mask
            end If
        else
            read_SrcAddr_value = data_low and SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SrcAddr_value = &H0
        flag_SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc7destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DestAddr                                   [31:0]           get_DestAddr
''                                                             set_DestAddr
''                                                             read_DestAddr
''                                                             write_DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc7destaddr
    Private write_DestAddr_value
    Private read_DestAddr_value
    Private flag_DestAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DestAddr
        get_DestAddr = read_DestAddr_value
    End Property

    Property Let set_DestAddr(aData)
        write_DestAddr_value = aData
        flag_DestAddr        = &H1
    End Property

    Property Get read_DestAddr
        read
        read_DestAddr = read_DestAddr_value
    End Property

    Property Let write_DestAddr(aData)
        set_DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_DestAddr = &H0 Then read
        If flag_DestAddr = &H0 Then write_DestAddr_value = get_DestAddr

        regValue = leftShift(write_DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if DestAddr_mask = mask then
                read_DestAddr_value = data_low
            else
                read_DestAddr_value = (data_low - H8000_0000) and DestAddr_mask
            end If
        else
            read_DestAddr_value = data_low and DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DestAddr_value = &H0
        flag_DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc7lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LLI                                        [31:2]           get_LLI
''                                                             set_LLI
''                                                             read_LLI
''                                                             write_LLI
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc7lli
    Private write_LLI_value
    Private read_LLI_value
    Private flag_LLI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LLI
        get_LLI = read_LLI_value
    End Property

    Property Let set_LLI(aData)
        write_LLI_value = aData
        flag_LLI        = &H1
    End Property

    Property Get read_LLI
        read
        read_LLI = read_LLI_value
    End Property

    Property Let write_LLI(aData)
        set_LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_LLI = &H0 Then read
        If flag_LLI = &H0 Then write_LLI_value = get_LLI

        regValue = leftShift((write_LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LLI_value = &H0
        flag_LLI        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc7control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' I                                          [31:31]          get_I
''                                                             set_I
''                                                             read_I
''                                                             write_I
''---------------------------------------------------------------------------------
'' Prot                                       [30:28]          get_Prot
''                                                             set_Prot
''                                                             read_Prot
''                                                             write_Prot
''---------------------------------------------------------------------------------
'' DestInc                                    [27:27]          get_DestInc
''                                                             set_DestInc
''                                                             read_DestInc
''                                                             write_DestInc
''---------------------------------------------------------------------------------
'' SrcInc                                     [26:26]          get_SrcInc
''                                                             set_SrcInc
''                                                             read_SrcInc
''                                                             write_SrcInc
''---------------------------------------------------------------------------------
'' DestWidth                                  [23:21]          get_DestWidth
''                                                             set_DestWidth
''                                                             read_DestWidth
''                                                             write_DestWidth
''---------------------------------------------------------------------------------
'' SrcWidth                                   [20:18]          get_SrcWidth
''                                                             set_SrcWidth
''                                                             read_SrcWidth
''                                                             write_SrcWidth
''---------------------------------------------------------------------------------
'' DestBurstSize                              [17:15]          get_DestBurstSize
''                                                             set_DestBurstSize
''                                                             read_DestBurstSize
''                                                             write_DestBurstSize
''---------------------------------------------------------------------------------
'' SrcBurstSize                               [14:12]          get_SrcBurstSize
''                                                             set_SrcBurstSize
''                                                             read_SrcBurstSize
''                                                             write_SrcBurstSize
''---------------------------------------------------------------------------------
'' TransferSize                               [11:0]           get_TransferSize
''                                                             set_TransferSize
''                                                             read_TransferSize
''                                                             write_TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc7control
    Private write_I_value
    Private read_I_value
    Private flag_I
    Private write_Prot_value
    Private read_Prot_value
    Private flag_Prot
    Private write_DestInc_value
    Private read_DestInc_value
    Private flag_DestInc
    Private write_SrcInc_value
    Private read_SrcInc_value
    Private flag_SrcInc
    Private write_DestWidth_value
    Private read_DestWidth_value
    Private flag_DestWidth
    Private write_SrcWidth_value
    Private read_SrcWidth_value
    Private flag_SrcWidth
    Private write_DestBurstSize_value
    Private read_DestBurstSize_value
    Private flag_DestBurstSize
    Private write_SrcBurstSize_value
    Private read_SrcBurstSize_value
    Private flag_SrcBurstSize
    Private write_TransferSize_value
    Private read_TransferSize_value
    Private flag_TransferSize

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1ec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_I
        get_I = read_I_value
    End Property

    Property Let set_I(aData)
        write_I_value = aData
        flag_I        = &H1
    End Property

    Property Get read_I
        read
        read_I = read_I_value
    End Property

    Property Let write_I(aData)
        set_I = aData
        write
    End Property

    Property Get get_Prot
        get_Prot = read_Prot_value
    End Property

    Property Let set_Prot(aData)
        write_Prot_value = aData
        flag_Prot        = &H1
    End Property

    Property Get read_Prot
        read
        read_Prot = read_Prot_value
    End Property

    Property Let write_Prot(aData)
        set_Prot = aData
        write
    End Property

    Property Get get_DestInc
        get_DestInc = read_DestInc_value
    End Property

    Property Let set_DestInc(aData)
        write_DestInc_value = aData
        flag_DestInc        = &H1
    End Property

    Property Get read_DestInc
        read
        read_DestInc = read_DestInc_value
    End Property

    Property Let write_DestInc(aData)
        set_DestInc = aData
        write
    End Property

    Property Get get_SrcInc
        get_SrcInc = read_SrcInc_value
    End Property

    Property Let set_SrcInc(aData)
        write_SrcInc_value = aData
        flag_SrcInc        = &H1
    End Property

    Property Get read_SrcInc
        read
        read_SrcInc = read_SrcInc_value
    End Property

    Property Let write_SrcInc(aData)
        set_SrcInc = aData
        write
    End Property

    Property Get get_DestWidth
        get_DestWidth = read_DestWidth_value
    End Property

    Property Let set_DestWidth(aData)
        write_DestWidth_value = aData
        flag_DestWidth        = &H1
    End Property

    Property Get read_DestWidth
        read
        read_DestWidth = read_DestWidth_value
    End Property

    Property Let write_DestWidth(aData)
        set_DestWidth = aData
        write
    End Property

    Property Get get_SrcWidth
        get_SrcWidth = read_SrcWidth_value
    End Property

    Property Let set_SrcWidth(aData)
        write_SrcWidth_value = aData
        flag_SrcWidth        = &H1
    End Property

    Property Get read_SrcWidth
        read
        read_SrcWidth = read_SrcWidth_value
    End Property

    Property Let write_SrcWidth(aData)
        set_SrcWidth = aData
        write
    End Property

    Property Get get_DestBurstSize
        get_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let set_DestBurstSize(aData)
        write_DestBurstSize_value = aData
        flag_DestBurstSize        = &H1
    End Property

    Property Get read_DestBurstSize
        read
        read_DestBurstSize = read_DestBurstSize_value
    End Property

    Property Let write_DestBurstSize(aData)
        set_DestBurstSize = aData
        write
    End Property

    Property Get get_SrcBurstSize
        get_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let set_SrcBurstSize(aData)
        write_SrcBurstSize_value = aData
        flag_SrcBurstSize        = &H1
    End Property

    Property Get read_SrcBurstSize
        read
        read_SrcBurstSize = read_SrcBurstSize_value
    End Property

    Property Let write_SrcBurstSize(aData)
        set_SrcBurstSize = aData
        write
    End Property

    Property Get get_TransferSize
        get_TransferSize = read_TransferSize_value
    End Property

    Property Let set_TransferSize(aData)
        write_TransferSize_value = aData
        flag_TransferSize        = &H1
    End Property

    Property Get read_TransferSize
        read
        read_TransferSize = read_TransferSize_value
    End Property

    Property Let write_TransferSize(aData)
        set_TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_I = &H0 or flag_Prot = &H0 or flag_DestInc = &H0 or flag_SrcInc = &H0 or flag_DestWidth = &H0 or flag_SrcWidth = &H0 or flag_DestBurstSize = &H0 or flag_SrcBurstSize = &H0 or flag_TransferSize = &H0 Then read
        If flag_I = &H0 Then write_I_value = get_I
        If flag_Prot = &H0 Then write_Prot_value = get_Prot
        If flag_DestInc = &H0 Then write_DestInc_value = get_DestInc
        If flag_SrcInc = &H0 Then write_SrcInc_value = get_SrcInc
        If flag_DestWidth = &H0 Then write_DestWidth_value = get_DestWidth
        If flag_SrcWidth = &H0 Then write_SrcWidth_value = get_SrcWidth
        If flag_DestBurstSize = &H0 Then write_DestBurstSize_value = get_DestBurstSize
        If flag_SrcBurstSize = &H0 Then write_SrcBurstSize_value = get_SrcBurstSize
        If flag_TransferSize = &H0 Then write_TransferSize_value = get_TransferSize

        regValue = leftShift((write_I_value and &H1), 31) + leftShift((write_Prot_value and &H7), 28) + leftShift((write_DestInc_value and &H1), 27) + leftShift((write_SrcInc_value and &H1), 26) + leftShift((write_DestWidth_value and &H7), 21) + leftShift((write_SrcWidth_value and &H7), 18) + leftShift((write_DestBurstSize_value and &H7), 15) + leftShift((write_SrcBurstSize_value and &H7), 12) + leftShift((write_TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_I_value = rightShift(data_low, 31) and &H1
        read_Prot_value = rightShift(data_low, 28) and &H7
        read_DestInc_value = rightShift(data_low, 27) and &H1
        read_SrcInc_value = rightShift(data_low, 26) and &H1
        read_DestWidth_value = rightShift(data_low, 21) and &H7
        read_SrcWidth_value = rightShift(data_low, 18) and &H7
        read_DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_SrcBurstSize_value = rightShift(data_low, 12) and &H7
        TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if TransferSize_mask = mask then
                read_TransferSize_value = data_low
            else
                read_TransferSize_value = (data_low - H8000_0000) and TransferSize_mask
            end If
        else
            read_TransferSize_value = data_low and TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_I_value = &H0
        flag_I        = &H0
        write_Prot_value = &H0
        flag_Prot        = &H0
        write_DestInc_value = &H0
        flag_DestInc        = &H0
        write_SrcInc_value = &H0
        flag_SrcInc        = &H0
        write_DestWidth_value = &H0
        flag_DestWidth        = &H0
        write_SrcWidth_value = &H0
        flag_SrcWidth        = &H0
        write_DestBurstSize_value = &H0
        flag_DestBurstSize        = &H0
        write_SrcBurstSize_value = &H0
        flag_SrcBurstSize        = &H0
        write_TransferSize_value = &H0
        flag_TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacc7configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Halt                                       [18:18]          get_Halt
''                                                             set_Halt
''                                                             read_Halt
''                                                             write_Halt
''---------------------------------------------------------------------------------
'' Active                                     [17:17]          get_Active
''                                                             set_Active
''                                                             read_Active
''                                                             write_Active
''---------------------------------------------------------------------------------
'' Lock                                       [16:16]          get_Lock
''                                                             set_Lock
''                                                             read_Lock
''                                                             write_Lock
''---------------------------------------------------------------------------------
'' IntTCMask                                  [15:15]          get_IntTCMask
''                                                             set_IntTCMask
''                                                             read_IntTCMask
''                                                             write_IntTCMask
''---------------------------------------------------------------------------------
'' IntErrorMask                               [14:14]          get_IntErrorMask
''                                                             set_IntErrorMask
''                                                             read_IntErrorMask
''                                                             write_IntErrorMask
''---------------------------------------------------------------------------------
'' FlowCntrl                                  [13:11]          get_FlowCntrl
''                                                             set_FlowCntrl
''                                                             read_FlowCntrl
''                                                             write_FlowCntrl
''---------------------------------------------------------------------------------
'' DestPeripheral                             [9:6]            get_DestPeripheral
''                                                             set_DestPeripheral
''                                                             read_DestPeripheral
''                                                             write_DestPeripheral
''---------------------------------------------------------------------------------
'' SrcPeripheral                              [4:1]            get_SrcPeripheral
''                                                             set_SrcPeripheral
''                                                             read_SrcPeripheral
''                                                             write_SrcPeripheral
''---------------------------------------------------------------------------------
'' Enable                                     [0:0]            get_Enable
''                                                             set_Enable
''                                                             read_Enable
''                                                             write_Enable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacc7configuration
    Private write_Halt_value
    Private read_Halt_value
    Private flag_Halt
    Private write_Active_value
    Private read_Active_value
    Private flag_Active
    Private write_Lock_value
    Private read_Lock_value
    Private flag_Lock
    Private write_IntTCMask_value
    Private read_IntTCMask_value
    Private flag_IntTCMask
    Private write_IntErrorMask_value
    Private read_IntErrorMask_value
    Private flag_IntErrorMask
    Private write_FlowCntrl_value
    Private read_FlowCntrl_value
    Private flag_FlowCntrl
    Private write_DestPeripheral_value
    Private read_DestPeripheral_value
    Private flag_DestPeripheral
    Private write_SrcPeripheral_value
    Private read_SrcPeripheral_value
    Private flag_SrcPeripheral
    Private write_Enable_value
    Private read_Enable_value
    Private flag_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Halt
        get_Halt = read_Halt_value
    End Property

    Property Let set_Halt(aData)
        write_Halt_value = aData
        flag_Halt        = &H1
    End Property

    Property Get read_Halt
        read
        read_Halt = read_Halt_value
    End Property

    Property Let write_Halt(aData)
        set_Halt = aData
        write
    End Property

    Property Get get_Active
        get_Active = read_Active_value
    End Property

    Property Let set_Active(aData)
        write_Active_value = aData
        flag_Active        = &H1
    End Property

    Property Get read_Active
        read
        read_Active = read_Active_value
    End Property

    Property Let write_Active(aData)
        set_Active = aData
        write
    End Property

    Property Get get_Lock
        get_Lock = read_Lock_value
    End Property

    Property Let set_Lock(aData)
        write_Lock_value = aData
        flag_Lock        = &H1
    End Property

    Property Get read_Lock
        read
        read_Lock = read_Lock_value
    End Property

    Property Let write_Lock(aData)
        set_Lock = aData
        write
    End Property

    Property Get get_IntTCMask
        get_IntTCMask = read_IntTCMask_value
    End Property

    Property Let set_IntTCMask(aData)
        write_IntTCMask_value = aData
        flag_IntTCMask        = &H1
    End Property

    Property Get read_IntTCMask
        read
        read_IntTCMask = read_IntTCMask_value
    End Property

    Property Let write_IntTCMask(aData)
        set_IntTCMask = aData
        write
    End Property

    Property Get get_IntErrorMask
        get_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let set_IntErrorMask(aData)
        write_IntErrorMask_value = aData
        flag_IntErrorMask        = &H1
    End Property

    Property Get read_IntErrorMask
        read
        read_IntErrorMask = read_IntErrorMask_value
    End Property

    Property Let write_IntErrorMask(aData)
        set_IntErrorMask = aData
        write
    End Property

    Property Get get_FlowCntrl
        get_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let set_FlowCntrl(aData)
        write_FlowCntrl_value = aData
        flag_FlowCntrl        = &H1
    End Property

    Property Get read_FlowCntrl
        read
        read_FlowCntrl = read_FlowCntrl_value
    End Property

    Property Let write_FlowCntrl(aData)
        set_FlowCntrl = aData
        write
    End Property

    Property Get get_DestPeripheral
        get_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let set_DestPeripheral(aData)
        write_DestPeripheral_value = aData
        flag_DestPeripheral        = &H1
    End Property

    Property Get read_DestPeripheral
        read
        read_DestPeripheral = read_DestPeripheral_value
    End Property

    Property Let write_DestPeripheral(aData)
        set_DestPeripheral = aData
        write
    End Property

    Property Get get_SrcPeripheral
        get_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let set_SrcPeripheral(aData)
        write_SrcPeripheral_value = aData
        flag_SrcPeripheral        = &H1
    End Property

    Property Get read_SrcPeripheral
        read
        read_SrcPeripheral = read_SrcPeripheral_value
    End Property

    Property Let write_SrcPeripheral(aData)
        set_SrcPeripheral = aData
        write
    End Property

    Property Get get_Enable
        get_Enable = read_Enable_value
    End Property

    Property Let set_Enable(aData)
        write_Enable_value = aData
        flag_Enable        = &H1
    End Property

    Property Get read_Enable
        read
        read_Enable = read_Enable_value
    End Property

    Property Let write_Enable(aData)
        set_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

    End Sub

    Sub write
        If flag_Halt = &H0 or flag_Active = &H0 or flag_Lock = &H0 or flag_IntTCMask = &H0 or flag_IntErrorMask = &H0 or flag_FlowCntrl = &H0 or flag_DestPeripheral = &H0 or flag_SrcPeripheral = &H0 or flag_Enable = &H0 Then read
        If flag_Halt = &H0 Then write_Halt_value = get_Halt
        If flag_Active = &H0 Then write_Active_value = get_Active
        If flag_Lock = &H0 Then write_Lock_value = get_Lock
        If flag_IntTCMask = &H0 Then write_IntTCMask_value = get_IntTCMask
        If flag_IntErrorMask = &H0 Then write_IntErrorMask_value = get_IntErrorMask
        If flag_FlowCntrl = &H0 Then write_FlowCntrl_value = get_FlowCntrl
        If flag_DestPeripheral = &H0 Then write_DestPeripheral_value = get_DestPeripheral
        If flag_SrcPeripheral = &H0 Then write_SrcPeripheral_value = get_SrcPeripheral
        If flag_Enable = &H0 Then write_Enable_value = get_Enable

        regValue = leftShift((write_Halt_value and &H1), 18) + leftShift((write_Active_value and &H1), 17) + leftShift((write_Lock_value and &H1), 16) + leftShift((write_IntTCMask_value and &H1), 15) + leftShift((write_IntErrorMask_value and &H1), 14) + leftShift((write_FlowCntrl_value and &H7), 11) + leftShift((write_DestPeripheral_value and &Hf), 6) + leftShift((write_SrcPeripheral_value and &Hf), 1) + leftShift((write_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Halt_value = rightShift(data_low, 18) and &H1
        read_Active_value = rightShift(data_low, 17) and &H1
        read_Lock_value = rightShift(data_low, 16) and &H1
        read_IntTCMask_value = rightShift(data_low, 15) and &H1
        read_IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        Enable_mask = &H1
        if data_low > LONG_MAX then
            if Enable_mask = mask then
                read_Enable_value = data_low
            else
                read_Enable_value = (data_low - H8000_0000) and Enable_mask
            end If
        else
            read_Enable_value = data_low and Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Halt_value = &H0
        flag_Halt        = &H0
        write_Active_value = &H0
        flag_Active        = &H0
        write_Lock_value = &H0
        flag_Lock        = &H0
        write_IntTCMask_value = &H0
        flag_IntTCMask        = &H0
        write_IntErrorMask_value = &H0
        flag_IntErrorMask        = &H0
        write_FlowCntrl_value = &H0
        flag_FlowCntrl        = &H0
        write_DestPeripheral_value = &H0
        flag_DestPeripheral        = &H0
        write_SrcPeripheral_value = &H0
        flag_SrcPeripheral        = &H0
        write_Enable_value = &H0
        flag_Enable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacitcr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TestEnable                                 [0:0]            get_TestEnable
''                                                             set_TestEnable
''                                                             read_TestEnable
''                                                             write_TestEnable
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacitcr
    Private write_TestEnable_value
    Private read_TestEnable_value
    Private flag_TestEnable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H500
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TestEnable
        get_TestEnable = read_TestEnable_value
    End Property

    Property Let set_TestEnable(aData)
        write_TestEnable_value = aData
        flag_TestEnable        = &H1
    End Property

    Property Get read_TestEnable
        read
        read_TestEnable = read_TestEnable_value
    End Property

    Property Let write_TestEnable(aData)
        set_TestEnable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TestEnable_mask = &H1
        if data_low > LONG_MAX then
            if TestEnable_mask = mask then
                read_TestEnable_value = data_low
            else
                read_TestEnable_value = (data_low - H8000_0000) and TestEnable_mask
            end If
        else
            read_TestEnable_value = data_low and TestEnable_mask
        end If

    End Sub

    Sub write
        If flag_TestEnable = &H0 Then read
        If flag_TestEnable = &H0 Then write_TestEnable_value = get_TestEnable

        regValue = leftShift((write_TestEnable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TestEnable_mask = &H1
        if data_low > LONG_MAX then
            if TestEnable_mask = mask then
                read_TestEnable_value = data_low
            else
                read_TestEnable_value = (data_low - H8000_0000) and TestEnable_mask
            end If
        else
            read_TestEnable_value = data_low and TestEnable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TestEnable_value = &H0
        flag_TestEnable        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacitop1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACCLR                                    [15:0]           get_DMACCLR
''                                                             set_DMACCLR
''                                                             read_DMACCLR
''                                                             write_DMACCLR
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacitop1
    Private write_DMACCLR_value
    Private read_DMACCLR_value
    Private flag_DMACCLR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H504
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DMACCLR
        get_DMACCLR = read_DMACCLR_value
    End Property

    Property Let set_DMACCLR(aData)
        write_DMACCLR_value = aData
        flag_DMACCLR        = &H1
    End Property

    Property Get read_DMACCLR
        read
        read_DMACCLR = read_DMACCLR_value
    End Property

    Property Let write_DMACCLR(aData)
        set_DMACCLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACCLR_mask = &Hffff
        if data_low > LONG_MAX then
            if DMACCLR_mask = mask then
                read_DMACCLR_value = data_low
            else
                read_DMACCLR_value = (data_low - H8000_0000) and DMACCLR_mask
            end If
        else
            read_DMACCLR_value = data_low and DMACCLR_mask
        end If

    End Sub

    Sub write
        If flag_DMACCLR = &H0 Then read
        If flag_DMACCLR = &H0 Then write_DMACCLR_value = get_DMACCLR

        regValue = leftShift((write_DMACCLR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACCLR_mask = &Hffff
        if data_low > LONG_MAX then
            if DMACCLR_mask = mask then
                read_DMACCLR_value = data_low
            else
                read_DMACCLR_value = (data_low - H8000_0000) and DMACCLR_mask
            end If
        else
            read_DMACCLR_value = data_low and DMACCLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACCLR_value = &H0
        flag_DMACCLR        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacitop2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACTC                                     [15:0]           get_DMACTC
''                                                             set_DMACTC
''                                                             read_DMACTC
''                                                             write_DMACTC
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacitop2
    Private write_DMACTC_value
    Private read_DMACTC_value
    Private flag_DMACTC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H508
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DMACTC
        get_DMACTC = read_DMACTC_value
    End Property

    Property Let set_DMACTC(aData)
        write_DMACTC_value = aData
        flag_DMACTC        = &H1
    End Property

    Property Get read_DMACTC
        read
        read_DMACTC = read_DMACTC_value
    End Property

    Property Let write_DMACTC(aData)
        set_DMACTC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACTC_mask = &Hffff
        if data_low > LONG_MAX then
            if DMACTC_mask = mask then
                read_DMACTC_value = data_low
            else
                read_DMACTC_value = (data_low - H8000_0000) and DMACTC_mask
            end If
        else
            read_DMACTC_value = data_low and DMACTC_mask
        end If

    End Sub

    Sub write
        If flag_DMACTC = &H0 Then read
        If flag_DMACTC = &H0 Then write_DMACTC_value = get_DMACTC

        regValue = leftShift((write_DMACTC_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACTC_mask = &Hffff
        if data_low > LONG_MAX then
            if DMACTC_mask = mask then
                read_DMACTC_value = data_low
            else
                read_DMACTC_value = (data_low - H8000_0000) and DMACTC_mask
            end If
        else
            read_DMACTC_value = data_low and DMACTC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACTC_value = &H0
        flag_DMACTC        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacitop3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' INTTC                                      [1:1]            get_INTTC
''                                                             set_INTTC
''                                                             read_INTTC
''                                                             write_INTTC
''---------------------------------------------------------------------------------
'' INTERR                                     [0:0]            get_INTERR
''                                                             set_INTERR
''                                                             read_INTERR
''                                                             write_INTERR
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacitop3
    Private write_INTTC_value
    Private read_INTTC_value
    Private flag_INTTC
    Private write_INTERR_value
    Private read_INTERR_value
    Private flag_INTERR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_INTTC
        get_INTTC = read_INTTC_value
    End Property

    Property Let set_INTTC(aData)
        write_INTTC_value = aData
        flag_INTTC        = &H1
    End Property

    Property Get read_INTTC
        read
        read_INTTC = read_INTTC_value
    End Property

    Property Let write_INTTC(aData)
        set_INTTC = aData
        write
    End Property

    Property Get get_INTERR
        get_INTERR = read_INTERR_value
    End Property

    Property Let set_INTERR(aData)
        write_INTERR_value = aData
        flag_INTERR        = &H1
    End Property

    Property Get read_INTERR
        read
        read_INTERR = read_INTERR_value
    End Property

    Property Let write_INTERR(aData)
        set_INTERR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_INTTC_value = rightShift(data_low, 1) and &H1
        INTERR_mask = &H1
        if data_low > LONG_MAX then
            if INTERR_mask = mask then
                read_INTERR_value = data_low
            else
                read_INTERR_value = (data_low - H8000_0000) and INTERR_mask
            end If
        else
            read_INTERR_value = data_low and INTERR_mask
        end If

    End Sub

    Sub write
        If flag_INTTC = &H0 or flag_INTERR = &H0 Then read
        If flag_INTTC = &H0 Then write_INTTC_value = get_INTTC
        If flag_INTERR = &H0 Then write_INTERR_value = get_INTERR

        regValue = leftShift((write_INTTC_value and &H1), 1) + leftShift((write_INTERR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_INTTC_value = rightShift(data_low, 1) and &H1
        INTERR_mask = &H1
        if data_low > LONG_MAX then
            if INTERR_mask = mask then
                read_INTERR_value = data_low
            else
                read_INTERR_value = (data_low - H8000_0000) and INTERR_mask
            end If
        else
            read_INTERR_value = data_low and INTERR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_INTTC_value = &H0
        flag_INTTC        = &H0
        write_INTERR_value = &H0
        flag_INTERR        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacperiphid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Partnumber0                                [7:0]            get_Partnumber0
''                                                             set_Partnumber0
''                                                             read_Partnumber0
''                                                             write_Partnumber0
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacperiphid0
    Private write_Partnumber0_value
    Private read_Partnumber0_value
    Private flag_Partnumber0

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

    Property Get get_Partnumber0
        get_Partnumber0 = read_Partnumber0_value
    End Property

    Property Let set_Partnumber0(aData)
        write_Partnumber0_value = aData
        flag_Partnumber0        = &H1
    End Property

    Property Get read_Partnumber0
        read
        read_Partnumber0 = read_Partnumber0_value
    End Property

    Property Let write_Partnumber0(aData)
        set_Partnumber0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Partnumber0_mask = &Hff
        if data_low > LONG_MAX then
            if Partnumber0_mask = mask then
                read_Partnumber0_value = data_low
            else
                read_Partnumber0_value = (data_low - H8000_0000) and Partnumber0_mask
            end If
        else
            read_Partnumber0_value = data_low and Partnumber0_mask
        end If

    End Sub

    Sub write
        If flag_Partnumber0 = &H0 Then read
        If flag_Partnumber0 = &H0 Then write_Partnumber0_value = get_Partnumber0

        regValue = leftShift((write_Partnumber0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Partnumber0_mask = &Hff
        if data_low > LONG_MAX then
            if Partnumber0_mask = mask then
                read_Partnumber0_value = data_low
            else
                read_Partnumber0_value = (data_low - H8000_0000) and Partnumber0_mask
            end If
        else
            read_Partnumber0_value = data_low and Partnumber0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Partnumber0_value = &H0
        flag_Partnumber0        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacperiphid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Designer0                                  [7:4]            get_Designer0
''                                                             set_Designer0
''                                                             read_Designer0
''                                                             write_Designer0
''---------------------------------------------------------------------------------
'' Partnumber1                                [3:0]            get_Partnumber1
''                                                             set_Partnumber1
''                                                             read_Partnumber1
''                                                             write_Partnumber1
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacperiphid1
    Private write_Designer0_value
    Private read_Designer0_value
    Private flag_Designer0
    Private write_Partnumber1_value
    Private read_Partnumber1_value
    Private flag_Partnumber1

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

    Property Get get_Designer0
        get_Designer0 = read_Designer0_value
    End Property

    Property Let set_Designer0(aData)
        write_Designer0_value = aData
        flag_Designer0        = &H1
    End Property

    Property Get read_Designer0
        read
        read_Designer0 = read_Designer0_value
    End Property

    Property Let write_Designer0(aData)
        set_Designer0 = aData
        write
    End Property

    Property Get get_Partnumber1
        get_Partnumber1 = read_Partnumber1_value
    End Property

    Property Let set_Partnumber1(aData)
        write_Partnumber1_value = aData
        flag_Partnumber1        = &H1
    End Property

    Property Get read_Partnumber1
        read
        read_Partnumber1 = read_Partnumber1_value
    End Property

    Property Let write_Partnumber1(aData)
        set_Partnumber1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        Partnumber1_mask = &Hf
        if data_low > LONG_MAX then
            if Partnumber1_mask = mask then
                read_Partnumber1_value = data_low
            else
                read_Partnumber1_value = (data_low - H8000_0000) and Partnumber1_mask
            end If
        else
            read_Partnumber1_value = data_low and Partnumber1_mask
        end If

    End Sub

    Sub write
        If flag_Designer0 = &H0 or flag_Partnumber1 = &H0 Then read
        If flag_Designer0 = &H0 Then write_Designer0_value = get_Designer0
        If flag_Partnumber1 = &H0 Then write_Partnumber1_value = get_Partnumber1

        regValue = leftShift((write_Designer0_value and &Hf), 4) + leftShift((write_Partnumber1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        Partnumber1_mask = &Hf
        if data_low > LONG_MAX then
            if Partnumber1_mask = mask then
                read_Partnumber1_value = data_low
            else
                read_Partnumber1_value = (data_low - H8000_0000) and Partnumber1_mask
            end If
        else
            read_Partnumber1_value = data_low and Partnumber1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Designer0_value = &H0
        flag_Designer0        = &H0
        write_Partnumber1_value = &H0
        flag_Partnumber1        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacperiphid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Revision                                   [7:4]            get_Revision
''                                                             set_Revision
''                                                             read_Revision
''                                                             write_Revision
''---------------------------------------------------------------------------------
'' Designer1                                  [3:0]            get_Designer1
''                                                             set_Designer1
''                                                             read_Designer1
''                                                             write_Designer1
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacperiphid2
    Private write_Revision_value
    Private read_Revision_value
    Private flag_Revision
    Private write_Designer1_value
    Private read_Designer1_value
    Private flag_Designer1

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

    Property Get get_Revision
        get_Revision = read_Revision_value
    End Property

    Property Let set_Revision(aData)
        write_Revision_value = aData
        flag_Revision        = &H1
    End Property

    Property Get read_Revision
        read
        read_Revision = read_Revision_value
    End Property

    Property Let write_Revision(aData)
        set_Revision = aData
        write
    End Property

    Property Get get_Designer1
        get_Designer1 = read_Designer1_value
    End Property

    Property Let set_Designer1(aData)
        write_Designer1_value = aData
        flag_Designer1        = &H1
    End Property

    Property Get read_Designer1
        read
        read_Designer1 = read_Designer1_value
    End Property

    Property Let write_Designer1(aData)
        set_Designer1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

    End Sub

    Sub write
        If flag_Revision = &H0 or flag_Designer1 = &H0 Then read
        If flag_Revision = &H0 Then write_Revision_value = get_Revision
        If flag_Designer1 = &H0 Then write_Designer1_value = get_Designer1

        regValue = leftShift((write_Revision_value and &Hf), 4) + leftShift((write_Designer1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Revision_value = &H0
        flag_Revision        = &H0
        write_Designer1_value = &H0
        flag_Designer1        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacperiphid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Configuration                              [7:0]            get_Configuration
''                                                             set_Configuration
''                                                             read_Configuration
''                                                             write_Configuration
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacperiphid3
    Private write_Configuration_value
    Private read_Configuration_value
    Private flag_Configuration

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

    Property Get get_Configuration
        get_Configuration = read_Configuration_value
    End Property

    Property Let set_Configuration(aData)
        write_Configuration_value = aData
        flag_Configuration        = &H1
    End Property

    Property Get read_Configuration
        read
        read_Configuration = read_Configuration_value
    End Property

    Property Let write_Configuration(aData)
        set_Configuration = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

    End Sub

    Sub write
        If flag_Configuration = &H0 Then read
        If flag_Configuration = &H0 Then write_Configuration_value = get_Configuration

        regValue = leftShift((write_Configuration_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Configuration_value = &H0
        flag_Configuration        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacpcellid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACPCellID0                               [7:0]            get_DMACPCellID0
''                                                             set_DMACPCellID0
''                                                             read_DMACPCellID0
''                                                             write_DMACPCellID0
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacpcellid0
    Private write_DMACPCellID0_value
    Private read_DMACPCellID0_value
    Private flag_DMACPCellID0

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

    Property Get get_DMACPCellID0
        get_DMACPCellID0 = read_DMACPCellID0_value
    End Property

    Property Let set_DMACPCellID0(aData)
        write_DMACPCellID0_value = aData
        flag_DMACPCellID0        = &H1
    End Property

    Property Get read_DMACPCellID0
        read
        read_DMACPCellID0 = read_DMACPCellID0_value
    End Property

    Property Let write_DMACPCellID0(aData)
        set_DMACPCellID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID0_mask = mask then
                read_DMACPCellID0_value = data_low
            else
                read_DMACPCellID0_value = (data_low - H8000_0000) and DMACPCellID0_mask
            end If
        else
            read_DMACPCellID0_value = data_low and DMACPCellID0_mask
        end If

    End Sub

    Sub write
        If flag_DMACPCellID0 = &H0 Then read
        If flag_DMACPCellID0 = &H0 Then write_DMACPCellID0_value = get_DMACPCellID0

        regValue = leftShift((write_DMACPCellID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID0_mask = mask then
                read_DMACPCellID0_value = data_low
            else
                read_DMACPCellID0_value = (data_low - H8000_0000) and DMACPCellID0_mask
            end If
        else
            read_DMACPCellID0_value = data_low and DMACPCellID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACPCellID0_value = &H0
        flag_DMACPCellID0        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacpcellid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACPCellID1                               [7:0]            get_DMACPCellID1
''                                                             set_DMACPCellID1
''                                                             read_DMACPCellID1
''                                                             write_DMACPCellID1
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacpcellid1
    Private write_DMACPCellID1_value
    Private read_DMACPCellID1_value
    Private flag_DMACPCellID1

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

    Property Get get_DMACPCellID1
        get_DMACPCellID1 = read_DMACPCellID1_value
    End Property

    Property Let set_DMACPCellID1(aData)
        write_DMACPCellID1_value = aData
        flag_DMACPCellID1        = &H1
    End Property

    Property Get read_DMACPCellID1
        read
        read_DMACPCellID1 = read_DMACPCellID1_value
    End Property

    Property Let write_DMACPCellID1(aData)
        set_DMACPCellID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID1_mask = mask then
                read_DMACPCellID1_value = data_low
            else
                read_DMACPCellID1_value = (data_low - H8000_0000) and DMACPCellID1_mask
            end If
        else
            read_DMACPCellID1_value = data_low and DMACPCellID1_mask
        end If

    End Sub

    Sub write
        If flag_DMACPCellID1 = &H0 Then read
        If flag_DMACPCellID1 = &H0 Then write_DMACPCellID1_value = get_DMACPCellID1

        regValue = leftShift((write_DMACPCellID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID1_mask = mask then
                read_DMACPCellID1_value = data_low
            else
                read_DMACPCellID1_value = (data_low - H8000_0000) and DMACPCellID1_mask
            end If
        else
            read_DMACPCellID1_value = data_low and DMACPCellID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACPCellID1_value = &H0
        flag_DMACPCellID1        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacpcellid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACPCellID2                               [7:0]            get_DMACPCellID2
''                                                             set_DMACPCellID2
''                                                             read_DMACPCellID2
''                                                             write_DMACPCellID2
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacpcellid2
    Private write_DMACPCellID2_value
    Private read_DMACPCellID2_value
    Private flag_DMACPCellID2

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

    Property Get get_DMACPCellID2
        get_DMACPCellID2 = read_DMACPCellID2_value
    End Property

    Property Let set_DMACPCellID2(aData)
        write_DMACPCellID2_value = aData
        flag_DMACPCellID2        = &H1
    End Property

    Property Get read_DMACPCellID2
        read
        read_DMACPCellID2 = read_DMACPCellID2_value
    End Property

    Property Let write_DMACPCellID2(aData)
        set_DMACPCellID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID2_mask = mask then
                read_DMACPCellID2_value = data_low
            else
                read_DMACPCellID2_value = (data_low - H8000_0000) and DMACPCellID2_mask
            end If
        else
            read_DMACPCellID2_value = data_low and DMACPCellID2_mask
        end If

    End Sub

    Sub write
        If flag_DMACPCellID2 = &H0 Then read
        If flag_DMACPCellID2 = &H0 Then write_DMACPCellID2_value = get_DMACPCellID2

        regValue = leftShift((write_DMACPCellID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID2_mask = mask then
                read_DMACPCellID2_value = data_low
            else
                read_DMACPCellID2_value = (data_low - H8000_0000) and DMACPCellID2_mask
            end If
        else
            read_DMACPCellID2_value = data_low and DMACPCellID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACPCellID2_value = &H0
        flag_DMACPCellID2        = &H0
    End Sub
End Class


'' @REGISTER : PL080_dmacpcellid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMACPCellID3                               [7:0]            get_DMACPCellID3
''                                                             set_DMACPCellID3
''                                                             read_DMACPCellID3
''                                                             write_DMACPCellID3
''---------------------------------------------------------------------------------
Class REGISTER_PL080_dmacpcellid3
    Private write_DMACPCellID3_value
    Private read_DMACPCellID3_value
    Private flag_DMACPCellID3

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

    Property Get get_DMACPCellID3
        get_DMACPCellID3 = read_DMACPCellID3_value
    End Property

    Property Let set_DMACPCellID3(aData)
        write_DMACPCellID3_value = aData
        flag_DMACPCellID3        = &H1
    End Property

    Property Get read_DMACPCellID3
        read
        read_DMACPCellID3 = read_DMACPCellID3_value
    End Property

    Property Let write_DMACPCellID3(aData)
        set_DMACPCellID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID3_mask = mask then
                read_DMACPCellID3_value = data_low
            else
                read_DMACPCellID3_value = (data_low - H8000_0000) and DMACPCellID3_mask
            end If
        else
            read_DMACPCellID3_value = data_low and DMACPCellID3_mask
        end If

    End Sub

    Sub write
        If flag_DMACPCellID3 = &H0 Then read
        If flag_DMACPCellID3 = &H0 Then write_DMACPCellID3_value = get_DMACPCellID3

        regValue = leftShift((write_DMACPCellID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DMACPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if DMACPCellID3_mask = mask then
                read_DMACPCellID3_value = data_low
            else
                read_DMACPCellID3_value = (data_low - H8000_0000) and DMACPCellID3_mask
            end If
        else
            read_DMACPCellID3_value = data_low and DMACPCellID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMACPCellID3_value = &H0
        flag_DMACPCellID3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PL080_INSTANCE

    Public dmacintstatus
    Public dmacinttcstatus
    Public dmacinttcclear
    Public dmacinterrorstatus
    Public dmacinterrclr
    Public dmacrawinttcstatus
    Public dmacrawinterrorstatus
    Public dmacenbldchns
    Public dmacsoftbreq
    Public dmacsoftsreq
    Public dmacsoftlbreq
    Public dmacsoftlsreq
    Public dmacconfiguration
    Public dmacsync
    Public dmacc0srcaddr
    Public dmacc0destaddr
    Public dmacc0lli
    Public dmacc0control
    Public dmacc0configuration
    Public dmacc1srcaddr
    Public dmacc1destaddr
    Public dmacc1lli
    Public dmacc1control
    Public dmacc1configuration
    Public dmacc2srcaddr
    Public dmacc2destaddr
    Public dmacc2lli
    Public dmacc2control
    Public dmacc2configuration
    Public dmacc3srcaddr
    Public dmacc3destaddr
    Public dmacc3lli
    Public dmacc3control
    Public dmacc3configuration
    Public dmacc4srcaddr
    Public dmacc4destaddr
    Public dmacc4lli
    Public dmacc4control
    Public dmacc4configuration
    Public dmacc5srcaddr
    Public dmacc5destaddr
    Public dmacc5lli
    Public dmacc5control
    Public dmacc5configuration
    Public dmacc6srcaddr
    Public dmacc6destaddr
    Public dmacc6lli
    Public dmacc6control
    Public dmacc6configuration
    Public dmacc7srcaddr
    Public dmacc7destaddr
    Public dmacc7lli
    Public dmacc7control
    Public dmacc7configuration
    Public dmacitcr
    Public dmacitop1
    Public dmacitop2
    Public dmacitop3
    Public dmacperiphid0
    Public dmacperiphid1
    Public dmacperiphid2
    Public dmacperiphid3
    Public dmacpcellid0
    Public dmacpcellid1
    Public dmacpcellid2
    Public dmacpcellid3


    Public default function Init(aBaseAddr)
        Set dmacintstatus = (New REGISTER_PL080_dmacintstatus)(aBaseAddr, 32)
        Set dmacinttcstatus = (New REGISTER_PL080_dmacinttcstatus)(aBaseAddr, 32)
        Set dmacinttcclear = (New REGISTER_PL080_dmacinttcclear)(aBaseAddr, 32)
        Set dmacinterrorstatus = (New REGISTER_PL080_dmacinterrorstatus)(aBaseAddr, 32)
        Set dmacinterrclr = (New REGISTER_PL080_dmacinterrclr)(aBaseAddr, 32)
        Set dmacrawinttcstatus = (New REGISTER_PL080_dmacrawinttcstatus)(aBaseAddr, 32)
        Set dmacrawinterrorstatus = (New REGISTER_PL080_dmacrawinterrorstatus)(aBaseAddr, 32)
        Set dmacenbldchns = (New REGISTER_PL080_dmacenbldchns)(aBaseAddr, 32)
        Set dmacsoftbreq = (New REGISTER_PL080_dmacsoftbreq)(aBaseAddr, 32)
        Set dmacsoftsreq = (New REGISTER_PL080_dmacsoftsreq)(aBaseAddr, 32)
        Set dmacsoftlbreq = (New REGISTER_PL080_dmacsoftlbreq)(aBaseAddr, 32)
        Set dmacsoftlsreq = (New REGISTER_PL080_dmacsoftlsreq)(aBaseAddr, 32)
        Set dmacconfiguration = (New REGISTER_PL080_dmacconfiguration)(aBaseAddr, 32)
        Set dmacsync = (New REGISTER_PL080_dmacsync)(aBaseAddr, 32)
        Set dmacc0srcaddr = (New REGISTER_PL080_dmacc0srcaddr)(aBaseAddr, 32)
        Set dmacc0destaddr = (New REGISTER_PL080_dmacc0destaddr)(aBaseAddr, 32)
        Set dmacc0lli = (New REGISTER_PL080_dmacc0lli)(aBaseAddr, 32)
        Set dmacc0control = (New REGISTER_PL080_dmacc0control)(aBaseAddr, 32)
        Set dmacc0configuration = (New REGISTER_PL080_dmacc0configuration)(aBaseAddr, 32)
        Set dmacc1srcaddr = (New REGISTER_PL080_dmacc1srcaddr)(aBaseAddr, 32)
        Set dmacc1destaddr = (New REGISTER_PL080_dmacc1destaddr)(aBaseAddr, 32)
        Set dmacc1lli = (New REGISTER_PL080_dmacc1lli)(aBaseAddr, 32)
        Set dmacc1control = (New REGISTER_PL080_dmacc1control)(aBaseAddr, 32)
        Set dmacc1configuration = (New REGISTER_PL080_dmacc1configuration)(aBaseAddr, 32)
        Set dmacc2srcaddr = (New REGISTER_PL080_dmacc2srcaddr)(aBaseAddr, 32)
        Set dmacc2destaddr = (New REGISTER_PL080_dmacc2destaddr)(aBaseAddr, 32)
        Set dmacc2lli = (New REGISTER_PL080_dmacc2lli)(aBaseAddr, 32)
        Set dmacc2control = (New REGISTER_PL080_dmacc2control)(aBaseAddr, 32)
        Set dmacc2configuration = (New REGISTER_PL080_dmacc2configuration)(aBaseAddr, 32)
        Set dmacc3srcaddr = (New REGISTER_PL080_dmacc3srcaddr)(aBaseAddr, 32)
        Set dmacc3destaddr = (New REGISTER_PL080_dmacc3destaddr)(aBaseAddr, 32)
        Set dmacc3lli = (New REGISTER_PL080_dmacc3lli)(aBaseAddr, 32)
        Set dmacc3control = (New REGISTER_PL080_dmacc3control)(aBaseAddr, 32)
        Set dmacc3configuration = (New REGISTER_PL080_dmacc3configuration)(aBaseAddr, 32)
        Set dmacc4srcaddr = (New REGISTER_PL080_dmacc4srcaddr)(aBaseAddr, 32)
        Set dmacc4destaddr = (New REGISTER_PL080_dmacc4destaddr)(aBaseAddr, 32)
        Set dmacc4lli = (New REGISTER_PL080_dmacc4lli)(aBaseAddr, 32)
        Set dmacc4control = (New REGISTER_PL080_dmacc4control)(aBaseAddr, 32)
        Set dmacc4configuration = (New REGISTER_PL080_dmacc4configuration)(aBaseAddr, 32)
        Set dmacc5srcaddr = (New REGISTER_PL080_dmacc5srcaddr)(aBaseAddr, 32)
        Set dmacc5destaddr = (New REGISTER_PL080_dmacc5destaddr)(aBaseAddr, 32)
        Set dmacc5lli = (New REGISTER_PL080_dmacc5lli)(aBaseAddr, 32)
        Set dmacc5control = (New REGISTER_PL080_dmacc5control)(aBaseAddr, 32)
        Set dmacc5configuration = (New REGISTER_PL080_dmacc5configuration)(aBaseAddr, 32)
        Set dmacc6srcaddr = (New REGISTER_PL080_dmacc6srcaddr)(aBaseAddr, 32)
        Set dmacc6destaddr = (New REGISTER_PL080_dmacc6destaddr)(aBaseAddr, 32)
        Set dmacc6lli = (New REGISTER_PL080_dmacc6lli)(aBaseAddr, 32)
        Set dmacc6control = (New REGISTER_PL080_dmacc6control)(aBaseAddr, 32)
        Set dmacc6configuration = (New REGISTER_PL080_dmacc6configuration)(aBaseAddr, 32)
        Set dmacc7srcaddr = (New REGISTER_PL080_dmacc7srcaddr)(aBaseAddr, 32)
        Set dmacc7destaddr = (New REGISTER_PL080_dmacc7destaddr)(aBaseAddr, 32)
        Set dmacc7lli = (New REGISTER_PL080_dmacc7lli)(aBaseAddr, 32)
        Set dmacc7control = (New REGISTER_PL080_dmacc7control)(aBaseAddr, 32)
        Set dmacc7configuration = (New REGISTER_PL080_dmacc7configuration)(aBaseAddr, 32)
        Set dmacitcr = (New REGISTER_PL080_dmacitcr)(aBaseAddr, 32)
        Set dmacitop1 = (New REGISTER_PL080_dmacitop1)(aBaseAddr, 32)
        Set dmacitop2 = (New REGISTER_PL080_dmacitop2)(aBaseAddr, 32)
        Set dmacitop3 = (New REGISTER_PL080_dmacitop3)(aBaseAddr, 32)
        Set dmacperiphid0 = (New REGISTER_PL080_dmacperiphid0)(aBaseAddr, 32)
        Set dmacperiphid1 = (New REGISTER_PL080_dmacperiphid1)(aBaseAddr, 32)
        Set dmacperiphid2 = (New REGISTER_PL080_dmacperiphid2)(aBaseAddr, 32)
        Set dmacperiphid3 = (New REGISTER_PL080_dmacperiphid3)(aBaseAddr, 32)
        Set dmacpcellid0 = (New REGISTER_PL080_dmacpcellid0)(aBaseAddr, 32)
        Set dmacpcellid1 = (New REGISTER_PL080_dmacpcellid1)(aBaseAddr, 32)
        Set dmacpcellid2 = (New REGISTER_PL080_dmacpcellid2)(aBaseAddr, 32)
        Set dmacpcellid3 = (New REGISTER_PL080_dmacpcellid3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PL080 = CreateObject("System.Collections.ArrayList")
PL080.Add ((New PL080_INSTANCE)(&H4c031000))


