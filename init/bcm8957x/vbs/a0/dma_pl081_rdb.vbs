

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


'' @REGISTER : DMA_PL081_dmacintstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntStatus                                  [1:0]            get_IntStatus
''                                                             set_IntStatus
''                                                             read_IntStatus
''                                                             write_IntStatus
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacintstatus
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
        IntStatus_mask = &H3
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

        regValue = leftShift((write_IntStatus_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntStatus_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacinttcstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntTCStatus                                [1:0]            get_IntTCStatus
''                                                             set_IntTCStatus
''                                                             read_IntTCStatus
''                                                             write_IntTCStatus
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacinttcstatus
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
        IntTCStatus_mask = &H3
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

        regValue = leftShift((write_IntTCStatus_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntTCStatus_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacinttcclear
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntTCClear                                 [1:0]            get_IntTCClear
''                                                             set_IntTCClear
''                                                             read_IntTCClear
''                                                             write_IntTCClear
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacinttcclear
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
        IntTCClear_mask = &H3
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

        regValue = leftShift((write_IntTCClear_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntTCClear_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacinterrorstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntErrorStatus                             [1:0]            get_IntErrorStatus
''                                                             set_IntErrorStatus
''                                                             read_IntErrorStatus
''                                                             write_IntErrorStatus
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacinterrorstatus
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
        IntErrorStatus_mask = &H3
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

        regValue = leftShift((write_IntErrorStatus_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntErrorStatus_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacinterrclr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IntErrClr                                  [1:0]            get_IntErrClr
''                                                             set_IntErrClr
''                                                             read_IntErrClr
''                                                             write_IntErrClr
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacinterrclr
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
        IntErrClr_mask = &H3
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

        regValue = leftShift((write_IntErrClr_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IntErrClr_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacrawinttcstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RawIntTCStatus                             [1:0]            get_RawIntTCStatus
''                                                             set_RawIntTCStatus
''                                                             read_RawIntTCStatus
''                                                             write_RawIntTCStatus
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacrawinttcstatus
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
        RawIntTCStatus_mask = &H3
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

        regValue = leftShift((write_RawIntTCStatus_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RawIntTCStatus_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacrawinterrorstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RawIntErrorStatus                          [1:0]            get_RawIntErrorStatus
''                                                             set_RawIntErrorStatus
''                                                             read_RawIntErrorStatus
''                                                             write_RawIntErrorStatus
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacrawinterrorstatus
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
        RawIntErrorStatus_mask = &H3
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

        regValue = leftShift((write_RawIntErrorStatus_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RawIntErrorStatus_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacenbldchns
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EnabledChannels                            [1:0]            get_EnabledChannels
''                                                             set_EnabledChannels
''                                                             read_EnabledChannels
''                                                             write_EnabledChannels
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacenbldchns
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
        EnabledChannels_mask = &H3
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

        regValue = leftShift((write_EnabledChannels_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EnabledChannels_mask = &H3
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


'' @REGISTER : DMA_PL081_dmacsoftbreq
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
Class REGISTER_DMA_PL081_dmacsoftbreq
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


'' @REGISTER : DMA_PL081_dmacsoftsreq
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
Class REGISTER_DMA_PL081_dmacsoftsreq
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


'' @REGISTER : DMA_PL081_dmacsoftlbreq
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
Class REGISTER_DMA_PL081_dmacsoftlbreq
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


'' @REGISTER : DMA_PL081_dmacsoftlsreq
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
Class REGISTER_DMA_PL081_dmacsoftlsreq
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


'' @REGISTER : DMA_PL081_dmacconfiguration
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
Class REGISTER_DMA_PL081_dmacconfiguration
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


'' @REGISTER : DMA_PL081_dmacsync
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
Class REGISTER_DMA_PL081_dmacsync
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


'' @REGISTER : DMA_PL081_dmacc0srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C0SrcAddr                                  [31:0]           get_C0SrcAddr
''                                                             set_C0SrcAddr
''                                                             read_C0SrcAddr
''                                                             write_C0SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc0srcaddr
    Private write_C0SrcAddr_value
    Private read_C0SrcAddr_value
    Private flag_C0SrcAddr

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

    Property Get get_C0SrcAddr
        get_C0SrcAddr = read_C0SrcAddr_value
    End Property

    Property Let set_C0SrcAddr(aData)
        write_C0SrcAddr_value = aData
        flag_C0SrcAddr        = &H1
    End Property

    Property Get read_C0SrcAddr
        read
        read_C0SrcAddr = read_C0SrcAddr_value
    End Property

    Property Let write_C0SrcAddr(aData)
        set_C0SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C0SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C0SrcAddr_mask = mask then
                read_C0SrcAddr_value = data_low
            else
                read_C0SrcAddr_value = (data_low - H8000_0000) and C0SrcAddr_mask
            end If
        else
            read_C0SrcAddr_value = data_low and C0SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_C0SrcAddr = &H0 Then read
        If flag_C0SrcAddr = &H0 Then write_C0SrcAddr_value = get_C0SrcAddr

        regValue = leftShift(write_C0SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C0SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C0SrcAddr_mask = mask then
                read_C0SrcAddr_value = data_low
            else
                read_C0SrcAddr_value = (data_low - H8000_0000) and C0SrcAddr_mask
            end If
        else
            read_C0SrcAddr_value = data_low and C0SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C0SrcAddr_value = &H0
        flag_C0SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc0destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C0DestAddr                                 [31:0]           get_C0DestAddr
''                                                             set_C0DestAddr
''                                                             read_C0DestAddr
''                                                             write_C0DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc0destaddr
    Private write_C0DestAddr_value
    Private read_C0DestAddr_value
    Private flag_C0DestAddr

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

    Property Get get_C0DestAddr
        get_C0DestAddr = read_C0DestAddr_value
    End Property

    Property Let set_C0DestAddr(aData)
        write_C0DestAddr_value = aData
        flag_C0DestAddr        = &H1
    End Property

    Property Get read_C0DestAddr
        read
        read_C0DestAddr = read_C0DestAddr_value
    End Property

    Property Let write_C0DestAddr(aData)
        set_C0DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C0DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C0DestAddr_mask = mask then
                read_C0DestAddr_value = data_low
            else
                read_C0DestAddr_value = (data_low - H8000_0000) and C0DestAddr_mask
            end If
        else
            read_C0DestAddr_value = data_low and C0DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_C0DestAddr = &H0 Then read
        If flag_C0DestAddr = &H0 Then write_C0DestAddr_value = get_C0DestAddr

        regValue = leftShift(write_C0DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C0DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C0DestAddr_mask = mask then
                read_C0DestAddr_value = data_low
            else
                read_C0DestAddr_value = (data_low - H8000_0000) and C0DestAddr_mask
            end If
        else
            read_C0DestAddr_value = data_low and C0DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C0DestAddr_value = &H0
        flag_C0DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc0lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C0LLI                                      [31:2]           get_C0LLI
''                                                             set_C0LLI
''                                                             read_C0LLI
''                                                             write_C0LLI
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc0lli
    Private write_C0LLI_value
    Private read_C0LLI_value
    Private flag_C0LLI

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

    Property Get get_C0LLI
        get_C0LLI = read_C0LLI_value
    End Property

    Property Let set_C0LLI(aData)
        write_C0LLI_value = aData
        flag_C0LLI        = &H1
    End Property

    Property Get read_C0LLI
        read
        read_C0LLI = read_C0LLI_value
    End Property

    Property Let write_C0LLI(aData)
        set_C0LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C0LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_C0LLI = &H0 Then read
        If flag_C0LLI = &H0 Then write_C0LLI_value = get_C0LLI

        regValue = leftShift((write_C0LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C0LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C0LLI_value = &H0
        flag_C0LLI        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc0control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C0I                                        [31:31]          get_C0I
''                                                             set_C0I
''                                                             read_C0I
''                                                             write_C0I
''---------------------------------------------------------------------------------
'' C0Prot                                     [30:28]          get_C0Prot
''                                                             set_C0Prot
''                                                             read_C0Prot
''                                                             write_C0Prot
''---------------------------------------------------------------------------------
'' C0DestInc                                  [27:27]          get_C0DestInc
''                                                             set_C0DestInc
''                                                             read_C0DestInc
''                                                             write_C0DestInc
''---------------------------------------------------------------------------------
'' C0SrcInc                                   [26:26]          get_C0SrcInc
''                                                             set_C0SrcInc
''                                                             read_C0SrcInc
''                                                             write_C0SrcInc
''---------------------------------------------------------------------------------
'' C0DestWidth                                [23:21]          get_C0DestWidth
''                                                             set_C0DestWidth
''                                                             read_C0DestWidth
''                                                             write_C0DestWidth
''---------------------------------------------------------------------------------
'' C0SrcWidth                                 [20:18]          get_C0SrcWidth
''                                                             set_C0SrcWidth
''                                                             read_C0SrcWidth
''                                                             write_C0SrcWidth
''---------------------------------------------------------------------------------
'' C0DestBurstSize                            [17:15]          get_C0DestBurstSize
''                                                             set_C0DestBurstSize
''                                                             read_C0DestBurstSize
''                                                             write_C0DestBurstSize
''---------------------------------------------------------------------------------
'' C0SrcBurstSize                             [14:12]          get_C0SrcBurstSize
''                                                             set_C0SrcBurstSize
''                                                             read_C0SrcBurstSize
''                                                             write_C0SrcBurstSize
''---------------------------------------------------------------------------------
'' C0TransferSize                             [11:0]           get_C0TransferSize
''                                                             set_C0TransferSize
''                                                             read_C0TransferSize
''                                                             write_C0TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc0control
    Private write_C0I_value
    Private read_C0I_value
    Private flag_C0I
    Private write_C0Prot_value
    Private read_C0Prot_value
    Private flag_C0Prot
    Private write_C0DestInc_value
    Private read_C0DestInc_value
    Private flag_C0DestInc
    Private write_C0SrcInc_value
    Private read_C0SrcInc_value
    Private flag_C0SrcInc
    Private write_C0DestWidth_value
    Private read_C0DestWidth_value
    Private flag_C0DestWidth
    Private write_C0SrcWidth_value
    Private read_C0SrcWidth_value
    Private flag_C0SrcWidth
    Private write_C0DestBurstSize_value
    Private read_C0DestBurstSize_value
    Private flag_C0DestBurstSize
    Private write_C0SrcBurstSize_value
    Private read_C0SrcBurstSize_value
    Private flag_C0SrcBurstSize
    Private write_C0TransferSize_value
    Private read_C0TransferSize_value
    Private flag_C0TransferSize

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

    Property Get get_C0I
        get_C0I = read_C0I_value
    End Property

    Property Let set_C0I(aData)
        write_C0I_value = aData
        flag_C0I        = &H1
    End Property

    Property Get read_C0I
        read
        read_C0I = read_C0I_value
    End Property

    Property Let write_C0I(aData)
        set_C0I = aData
        write
    End Property

    Property Get get_C0Prot
        get_C0Prot = read_C0Prot_value
    End Property

    Property Let set_C0Prot(aData)
        write_C0Prot_value = aData
        flag_C0Prot        = &H1
    End Property

    Property Get read_C0Prot
        read
        read_C0Prot = read_C0Prot_value
    End Property

    Property Let write_C0Prot(aData)
        set_C0Prot = aData
        write
    End Property

    Property Get get_C0DestInc
        get_C0DestInc = read_C0DestInc_value
    End Property

    Property Let set_C0DestInc(aData)
        write_C0DestInc_value = aData
        flag_C0DestInc        = &H1
    End Property

    Property Get read_C0DestInc
        read
        read_C0DestInc = read_C0DestInc_value
    End Property

    Property Let write_C0DestInc(aData)
        set_C0DestInc = aData
        write
    End Property

    Property Get get_C0SrcInc
        get_C0SrcInc = read_C0SrcInc_value
    End Property

    Property Let set_C0SrcInc(aData)
        write_C0SrcInc_value = aData
        flag_C0SrcInc        = &H1
    End Property

    Property Get read_C0SrcInc
        read
        read_C0SrcInc = read_C0SrcInc_value
    End Property

    Property Let write_C0SrcInc(aData)
        set_C0SrcInc = aData
        write
    End Property

    Property Get get_C0DestWidth
        get_C0DestWidth = read_C0DestWidth_value
    End Property

    Property Let set_C0DestWidth(aData)
        write_C0DestWidth_value = aData
        flag_C0DestWidth        = &H1
    End Property

    Property Get read_C0DestWidth
        read
        read_C0DestWidth = read_C0DestWidth_value
    End Property

    Property Let write_C0DestWidth(aData)
        set_C0DestWidth = aData
        write
    End Property

    Property Get get_C0SrcWidth
        get_C0SrcWidth = read_C0SrcWidth_value
    End Property

    Property Let set_C0SrcWidth(aData)
        write_C0SrcWidth_value = aData
        flag_C0SrcWidth        = &H1
    End Property

    Property Get read_C0SrcWidth
        read
        read_C0SrcWidth = read_C0SrcWidth_value
    End Property

    Property Let write_C0SrcWidth(aData)
        set_C0SrcWidth = aData
        write
    End Property

    Property Get get_C0DestBurstSize
        get_C0DestBurstSize = read_C0DestBurstSize_value
    End Property

    Property Let set_C0DestBurstSize(aData)
        write_C0DestBurstSize_value = aData
        flag_C0DestBurstSize        = &H1
    End Property

    Property Get read_C0DestBurstSize
        read
        read_C0DestBurstSize = read_C0DestBurstSize_value
    End Property

    Property Let write_C0DestBurstSize(aData)
        set_C0DestBurstSize = aData
        write
    End Property

    Property Get get_C0SrcBurstSize
        get_C0SrcBurstSize = read_C0SrcBurstSize_value
    End Property

    Property Let set_C0SrcBurstSize(aData)
        write_C0SrcBurstSize_value = aData
        flag_C0SrcBurstSize        = &H1
    End Property

    Property Get read_C0SrcBurstSize
        read
        read_C0SrcBurstSize = read_C0SrcBurstSize_value
    End Property

    Property Let write_C0SrcBurstSize(aData)
        set_C0SrcBurstSize = aData
        write
    End Property

    Property Get get_C0TransferSize
        get_C0TransferSize = read_C0TransferSize_value
    End Property

    Property Let set_C0TransferSize(aData)
        write_C0TransferSize_value = aData
        flag_C0TransferSize        = &H1
    End Property

    Property Get read_C0TransferSize
        read
        read_C0TransferSize = read_C0TransferSize_value
    End Property

    Property Let write_C0TransferSize(aData)
        set_C0TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C0I_value = rightShift(data_low, 31) and &H1
        read_C0Prot_value = rightShift(data_low, 28) and &H7
        read_C0DestInc_value = rightShift(data_low, 27) and &H1
        read_C0SrcInc_value = rightShift(data_low, 26) and &H1
        read_C0DestWidth_value = rightShift(data_low, 21) and &H7
        read_C0SrcWidth_value = rightShift(data_low, 18) and &H7
        read_C0DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_C0SrcBurstSize_value = rightShift(data_low, 12) and &H7
        C0TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if C0TransferSize_mask = mask then
                read_C0TransferSize_value = data_low
            else
                read_C0TransferSize_value = (data_low - H8000_0000) and C0TransferSize_mask
            end If
        else
            read_C0TransferSize_value = data_low and C0TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_C0I = &H0 or flag_C0Prot = &H0 or flag_C0DestInc = &H0 or flag_C0SrcInc = &H0 or flag_C0DestWidth = &H0 or flag_C0SrcWidth = &H0 or flag_C0DestBurstSize = &H0 or flag_C0SrcBurstSize = &H0 or flag_C0TransferSize = &H0 Then read
        If flag_C0I = &H0 Then write_C0I_value = get_C0I
        If flag_C0Prot = &H0 Then write_C0Prot_value = get_C0Prot
        If flag_C0DestInc = &H0 Then write_C0DestInc_value = get_C0DestInc
        If flag_C0SrcInc = &H0 Then write_C0SrcInc_value = get_C0SrcInc
        If flag_C0DestWidth = &H0 Then write_C0DestWidth_value = get_C0DestWidth
        If flag_C0SrcWidth = &H0 Then write_C0SrcWidth_value = get_C0SrcWidth
        If flag_C0DestBurstSize = &H0 Then write_C0DestBurstSize_value = get_C0DestBurstSize
        If flag_C0SrcBurstSize = &H0 Then write_C0SrcBurstSize_value = get_C0SrcBurstSize
        If flag_C0TransferSize = &H0 Then write_C0TransferSize_value = get_C0TransferSize

        regValue = leftShift((write_C0I_value and &H1), 31) + leftShift((write_C0Prot_value and &H7), 28) + leftShift((write_C0DestInc_value and &H1), 27) + leftShift((write_C0SrcInc_value and &H1), 26) + leftShift((write_C0DestWidth_value and &H7), 21) + leftShift((write_C0SrcWidth_value and &H7), 18) + leftShift((write_C0DestBurstSize_value and &H7), 15) + leftShift((write_C0SrcBurstSize_value and &H7), 12) + leftShift((write_C0TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C0I_value = rightShift(data_low, 31) and &H1
        read_C0Prot_value = rightShift(data_low, 28) and &H7
        read_C0DestInc_value = rightShift(data_low, 27) and &H1
        read_C0SrcInc_value = rightShift(data_low, 26) and &H1
        read_C0DestWidth_value = rightShift(data_low, 21) and &H7
        read_C0SrcWidth_value = rightShift(data_low, 18) and &H7
        read_C0DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_C0SrcBurstSize_value = rightShift(data_low, 12) and &H7
        C0TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if C0TransferSize_mask = mask then
                read_C0TransferSize_value = data_low
            else
                read_C0TransferSize_value = (data_low - H8000_0000) and C0TransferSize_mask
            end If
        else
            read_C0TransferSize_value = data_low and C0TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C0I_value = &H0
        flag_C0I        = &H0
        write_C0Prot_value = &H0
        flag_C0Prot        = &H0
        write_C0DestInc_value = &H0
        flag_C0DestInc        = &H0
        write_C0SrcInc_value = &H0
        flag_C0SrcInc        = &H0
        write_C0DestWidth_value = &H0
        flag_C0DestWidth        = &H0
        write_C0SrcWidth_value = &H0
        flag_C0SrcWidth        = &H0
        write_C0DestBurstSize_value = &H0
        flag_C0DestBurstSize        = &H0
        write_C0SrcBurstSize_value = &H0
        flag_C0SrcBurstSize        = &H0
        write_C0TransferSize_value = &H0
        flag_C0TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc0configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C0Halt                                     [18:18]          get_C0Halt
''                                                             set_C0Halt
''                                                             read_C0Halt
''                                                             write_C0Halt
''---------------------------------------------------------------------------------
'' C0Active                                   [17:17]          get_C0Active
''                                                             set_C0Active
''                                                             read_C0Active
''                                                             write_C0Active
''---------------------------------------------------------------------------------
'' C0Lock                                     [16:16]          get_C0Lock
''                                                             set_C0Lock
''                                                             read_C0Lock
''                                                             write_C0Lock
''---------------------------------------------------------------------------------
'' C0IntTCMask                                [15:15]          get_C0IntTCMask
''                                                             set_C0IntTCMask
''                                                             read_C0IntTCMask
''                                                             write_C0IntTCMask
''---------------------------------------------------------------------------------
'' C0IntErrorMask                             [14:14]          get_C0IntErrorMask
''                                                             set_C0IntErrorMask
''                                                             read_C0IntErrorMask
''                                                             write_C0IntErrorMask
''---------------------------------------------------------------------------------
'' C0FlowCntrl                                [13:11]          get_C0FlowCntrl
''                                                             set_C0FlowCntrl
''                                                             read_C0FlowCntrl
''                                                             write_C0FlowCntrl
''---------------------------------------------------------------------------------
'' C0DestPeripheral                           [9:6]            get_C0DestPeripheral
''                                                             set_C0DestPeripheral
''                                                             read_C0DestPeripheral
''                                                             write_C0DestPeripheral
''---------------------------------------------------------------------------------
'' C0SrcPeripheral                            [4:1]            get_C0SrcPeripheral
''                                                             set_C0SrcPeripheral
''                                                             read_C0SrcPeripheral
''                                                             write_C0SrcPeripheral
''---------------------------------------------------------------------------------
'' C0Enable                                   [0:0]            get_C0Enable
''                                                             set_C0Enable
''                                                             read_C0Enable
''                                                             write_C0Enable
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc0configuration
    Private write_C0Halt_value
    Private read_C0Halt_value
    Private flag_C0Halt
    Private write_C0Active_value
    Private read_C0Active_value
    Private flag_C0Active
    Private write_C0Lock_value
    Private read_C0Lock_value
    Private flag_C0Lock
    Private write_C0IntTCMask_value
    Private read_C0IntTCMask_value
    Private flag_C0IntTCMask
    Private write_C0IntErrorMask_value
    Private read_C0IntErrorMask_value
    Private flag_C0IntErrorMask
    Private write_C0FlowCntrl_value
    Private read_C0FlowCntrl_value
    Private flag_C0FlowCntrl
    Private write_C0DestPeripheral_value
    Private read_C0DestPeripheral_value
    Private flag_C0DestPeripheral
    Private write_C0SrcPeripheral_value
    Private read_C0SrcPeripheral_value
    Private flag_C0SrcPeripheral
    Private write_C0Enable_value
    Private read_C0Enable_value
    Private flag_C0Enable

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

    Property Get get_C0Halt
        get_C0Halt = read_C0Halt_value
    End Property

    Property Let set_C0Halt(aData)
        write_C0Halt_value = aData
        flag_C0Halt        = &H1
    End Property

    Property Get read_C0Halt
        read
        read_C0Halt = read_C0Halt_value
    End Property

    Property Let write_C0Halt(aData)
        set_C0Halt = aData
        write
    End Property

    Property Get get_C0Active
        get_C0Active = read_C0Active_value
    End Property

    Property Let set_C0Active(aData)
        write_C0Active_value = aData
        flag_C0Active        = &H1
    End Property

    Property Get read_C0Active
        read
        read_C0Active = read_C0Active_value
    End Property

    Property Let write_C0Active(aData)
        set_C0Active = aData
        write
    End Property

    Property Get get_C0Lock
        get_C0Lock = read_C0Lock_value
    End Property

    Property Let set_C0Lock(aData)
        write_C0Lock_value = aData
        flag_C0Lock        = &H1
    End Property

    Property Get read_C0Lock
        read
        read_C0Lock = read_C0Lock_value
    End Property

    Property Let write_C0Lock(aData)
        set_C0Lock = aData
        write
    End Property

    Property Get get_C0IntTCMask
        get_C0IntTCMask = read_C0IntTCMask_value
    End Property

    Property Let set_C0IntTCMask(aData)
        write_C0IntTCMask_value = aData
        flag_C0IntTCMask        = &H1
    End Property

    Property Get read_C0IntTCMask
        read
        read_C0IntTCMask = read_C0IntTCMask_value
    End Property

    Property Let write_C0IntTCMask(aData)
        set_C0IntTCMask = aData
        write
    End Property

    Property Get get_C0IntErrorMask
        get_C0IntErrorMask = read_C0IntErrorMask_value
    End Property

    Property Let set_C0IntErrorMask(aData)
        write_C0IntErrorMask_value = aData
        flag_C0IntErrorMask        = &H1
    End Property

    Property Get read_C0IntErrorMask
        read
        read_C0IntErrorMask = read_C0IntErrorMask_value
    End Property

    Property Let write_C0IntErrorMask(aData)
        set_C0IntErrorMask = aData
        write
    End Property

    Property Get get_C0FlowCntrl
        get_C0FlowCntrl = read_C0FlowCntrl_value
    End Property

    Property Let set_C0FlowCntrl(aData)
        write_C0FlowCntrl_value = aData
        flag_C0FlowCntrl        = &H1
    End Property

    Property Get read_C0FlowCntrl
        read
        read_C0FlowCntrl = read_C0FlowCntrl_value
    End Property

    Property Let write_C0FlowCntrl(aData)
        set_C0FlowCntrl = aData
        write
    End Property

    Property Get get_C0DestPeripheral
        get_C0DestPeripheral = read_C0DestPeripheral_value
    End Property

    Property Let set_C0DestPeripheral(aData)
        write_C0DestPeripheral_value = aData
        flag_C0DestPeripheral        = &H1
    End Property

    Property Get read_C0DestPeripheral
        read
        read_C0DestPeripheral = read_C0DestPeripheral_value
    End Property

    Property Let write_C0DestPeripheral(aData)
        set_C0DestPeripheral = aData
        write
    End Property

    Property Get get_C0SrcPeripheral
        get_C0SrcPeripheral = read_C0SrcPeripheral_value
    End Property

    Property Let set_C0SrcPeripheral(aData)
        write_C0SrcPeripheral_value = aData
        flag_C0SrcPeripheral        = &H1
    End Property

    Property Get read_C0SrcPeripheral
        read
        read_C0SrcPeripheral = read_C0SrcPeripheral_value
    End Property

    Property Let write_C0SrcPeripheral(aData)
        set_C0SrcPeripheral = aData
        write
    End Property

    Property Get get_C0Enable
        get_C0Enable = read_C0Enable_value
    End Property

    Property Let set_C0Enable(aData)
        write_C0Enable_value = aData
        flag_C0Enable        = &H1
    End Property

    Property Get read_C0Enable
        read
        read_C0Enable = read_C0Enable_value
    End Property

    Property Let write_C0Enable(aData)
        set_C0Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C0Halt_value = rightShift(data_low, 18) and &H1
        read_C0Active_value = rightShift(data_low, 17) and &H1
        read_C0Lock_value = rightShift(data_low, 16) and &H1
        read_C0IntTCMask_value = rightShift(data_low, 15) and &H1
        read_C0IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_C0FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_C0DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_C0SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        C0Enable_mask = &H1
        if data_low > LONG_MAX then
            if C0Enable_mask = mask then
                read_C0Enable_value = data_low
            else
                read_C0Enable_value = (data_low - H8000_0000) and C0Enable_mask
            end If
        else
            read_C0Enable_value = data_low and C0Enable_mask
        end If

    End Sub

    Sub write
        If flag_C0Halt = &H0 or flag_C0Active = &H0 or flag_C0Lock = &H0 or flag_C0IntTCMask = &H0 or flag_C0IntErrorMask = &H0 or flag_C0FlowCntrl = &H0 or flag_C0DestPeripheral = &H0 or flag_C0SrcPeripheral = &H0 or flag_C0Enable = &H0 Then read
        If flag_C0Halt = &H0 Then write_C0Halt_value = get_C0Halt
        If flag_C0Active = &H0 Then write_C0Active_value = get_C0Active
        If flag_C0Lock = &H0 Then write_C0Lock_value = get_C0Lock
        If flag_C0IntTCMask = &H0 Then write_C0IntTCMask_value = get_C0IntTCMask
        If flag_C0IntErrorMask = &H0 Then write_C0IntErrorMask_value = get_C0IntErrorMask
        If flag_C0FlowCntrl = &H0 Then write_C0FlowCntrl_value = get_C0FlowCntrl
        If flag_C0DestPeripheral = &H0 Then write_C0DestPeripheral_value = get_C0DestPeripheral
        If flag_C0SrcPeripheral = &H0 Then write_C0SrcPeripheral_value = get_C0SrcPeripheral
        If flag_C0Enable = &H0 Then write_C0Enable_value = get_C0Enable

        regValue = leftShift((write_C0Halt_value and &H1), 18) + leftShift((write_C0Active_value and &H1), 17) + leftShift((write_C0Lock_value and &H1), 16) + leftShift((write_C0IntTCMask_value and &H1), 15) + leftShift((write_C0IntErrorMask_value and &H1), 14) + leftShift((write_C0FlowCntrl_value and &H7), 11) + leftShift((write_C0DestPeripheral_value and &Hf), 6) + leftShift((write_C0SrcPeripheral_value and &Hf), 1) + leftShift((write_C0Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C0Halt_value = rightShift(data_low, 18) and &H1
        read_C0Active_value = rightShift(data_low, 17) and &H1
        read_C0Lock_value = rightShift(data_low, 16) and &H1
        read_C0IntTCMask_value = rightShift(data_low, 15) and &H1
        read_C0IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_C0FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_C0DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_C0SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        C0Enable_mask = &H1
        if data_low > LONG_MAX then
            if C0Enable_mask = mask then
                read_C0Enable_value = data_low
            else
                read_C0Enable_value = (data_low - H8000_0000) and C0Enable_mask
            end If
        else
            read_C0Enable_value = data_low and C0Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C0Halt_value = &H0
        flag_C0Halt        = &H0
        write_C0Active_value = &H0
        flag_C0Active        = &H0
        write_C0Lock_value = &H0
        flag_C0Lock        = &H0
        write_C0IntTCMask_value = &H0
        flag_C0IntTCMask        = &H0
        write_C0IntErrorMask_value = &H0
        flag_C0IntErrorMask        = &H0
        write_C0FlowCntrl_value = &H0
        flag_C0FlowCntrl        = &H0
        write_C0DestPeripheral_value = &H0
        flag_C0DestPeripheral        = &H0
        write_C0SrcPeripheral_value = &H0
        flag_C0SrcPeripheral        = &H0
        write_C0Enable_value = &H0
        flag_C0Enable        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc1srcaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C1SrcAddr                                  [31:0]           get_C1SrcAddr
''                                                             set_C1SrcAddr
''                                                             read_C1SrcAddr
''                                                             write_C1SrcAddr
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc1srcaddr
    Private write_C1SrcAddr_value
    Private read_C1SrcAddr_value
    Private flag_C1SrcAddr

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

    Property Get get_C1SrcAddr
        get_C1SrcAddr = read_C1SrcAddr_value
    End Property

    Property Let set_C1SrcAddr(aData)
        write_C1SrcAddr_value = aData
        flag_C1SrcAddr        = &H1
    End Property

    Property Get read_C1SrcAddr
        read
        read_C1SrcAddr = read_C1SrcAddr_value
    End Property

    Property Let write_C1SrcAddr(aData)
        set_C1SrcAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C1SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C1SrcAddr_mask = mask then
                read_C1SrcAddr_value = data_low
            else
                read_C1SrcAddr_value = (data_low - H8000_0000) and C1SrcAddr_mask
            end If
        else
            read_C1SrcAddr_value = data_low and C1SrcAddr_mask
        end If

    End Sub

    Sub write
        If flag_C1SrcAddr = &H0 Then read
        If flag_C1SrcAddr = &H0 Then write_C1SrcAddr_value = get_C1SrcAddr

        regValue = leftShift(write_C1SrcAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C1SrcAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C1SrcAddr_mask = mask then
                read_C1SrcAddr_value = data_low
            else
                read_C1SrcAddr_value = (data_low - H8000_0000) and C1SrcAddr_mask
            end If
        else
            read_C1SrcAddr_value = data_low and C1SrcAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C1SrcAddr_value = &H0
        flag_C1SrcAddr        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc1destaddr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C1DestAddr                                 [31:0]           get_C1DestAddr
''                                                             set_C1DestAddr
''                                                             read_C1DestAddr
''                                                             write_C1DestAddr
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc1destaddr
    Private write_C1DestAddr_value
    Private read_C1DestAddr_value
    Private flag_C1DestAddr

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

    Property Get get_C1DestAddr
        get_C1DestAddr = read_C1DestAddr_value
    End Property

    Property Let set_C1DestAddr(aData)
        write_C1DestAddr_value = aData
        flag_C1DestAddr        = &H1
    End Property

    Property Get read_C1DestAddr
        read
        read_C1DestAddr = read_C1DestAddr_value
    End Property

    Property Let write_C1DestAddr(aData)
        set_C1DestAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C1DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C1DestAddr_mask = mask then
                read_C1DestAddr_value = data_low
            else
                read_C1DestAddr_value = (data_low - H8000_0000) and C1DestAddr_mask
            end If
        else
            read_C1DestAddr_value = data_low and C1DestAddr_mask
        end If

    End Sub

    Sub write
        If flag_C1DestAddr = &H0 Then read
        If flag_C1DestAddr = &H0 Then write_C1DestAddr_value = get_C1DestAddr

        regValue = leftShift(write_C1DestAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        C1DestAddr_mask = &Hffffffff
        if data_low > LONG_MAX then
            if C1DestAddr_mask = mask then
                read_C1DestAddr_value = data_low
            else
                read_C1DestAddr_value = (data_low - H8000_0000) and C1DestAddr_mask
            end If
        else
            read_C1DestAddr_value = data_low and C1DestAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C1DestAddr_value = &H0
        flag_C1DestAddr        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc1lli
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C1LLI                                      [31:2]           get_C1LLI
''                                                             set_C1LLI
''                                                             read_C1LLI
''                                                             write_C1LLI
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc1lli
    Private write_C1LLI_value
    Private read_C1LLI_value
    Private flag_C1LLI

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

    Property Get get_C1LLI
        get_C1LLI = read_C1LLI_value
    End Property

    Property Let set_C1LLI(aData)
        write_C1LLI_value = aData
        flag_C1LLI        = &H1
    End Property

    Property Get read_C1LLI
        read
        read_C1LLI = read_C1LLI_value
    End Property

    Property Let write_C1LLI(aData)
        set_C1LLI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C1LLI_value = rightShift(data_low, 2) and &H3fffffff

    End Sub

    Sub write
        If flag_C1LLI = &H0 Then read
        If flag_C1LLI = &H0 Then write_C1LLI_value = get_C1LLI

        regValue = leftShift((write_C1LLI_value and &H3fffffff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C1LLI_value = rightShift(data_low, 2) and &H3fffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C1LLI_value = &H0
        flag_C1LLI        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc1control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C1I                                        [31:31]          get_C1I
''                                                             set_C1I
''                                                             read_C1I
''                                                             write_C1I
''---------------------------------------------------------------------------------
'' C1Prot                                     [30:28]          get_C1Prot
''                                                             set_C1Prot
''                                                             read_C1Prot
''                                                             write_C1Prot
''---------------------------------------------------------------------------------
'' C1DestInc                                  [27:27]          get_C1DestInc
''                                                             set_C1DestInc
''                                                             read_C1DestInc
''                                                             write_C1DestInc
''---------------------------------------------------------------------------------
'' C1SrcInc                                   [26:26]          get_C1SrcInc
''                                                             set_C1SrcInc
''                                                             read_C1SrcInc
''                                                             write_C1SrcInc
''---------------------------------------------------------------------------------
'' C1DestWidth                                [23:21]          get_C1DestWidth
''                                                             set_C1DestWidth
''                                                             read_C1DestWidth
''                                                             write_C1DestWidth
''---------------------------------------------------------------------------------
'' C1SrcWidth                                 [20:18]          get_C1SrcWidth
''                                                             set_C1SrcWidth
''                                                             read_C1SrcWidth
''                                                             write_C1SrcWidth
''---------------------------------------------------------------------------------
'' C1DestBurstSize                            [17:15]          get_C1DestBurstSize
''                                                             set_C1DestBurstSize
''                                                             read_C1DestBurstSize
''                                                             write_C1DestBurstSize
''---------------------------------------------------------------------------------
'' C1SrcBurstSize                             [14:12]          get_C1SrcBurstSize
''                                                             set_C1SrcBurstSize
''                                                             read_C1SrcBurstSize
''                                                             write_C1SrcBurstSize
''---------------------------------------------------------------------------------
'' C1TransferSize                             [11:0]           get_C1TransferSize
''                                                             set_C1TransferSize
''                                                             read_C1TransferSize
''                                                             write_C1TransferSize
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc1control
    Private write_C1I_value
    Private read_C1I_value
    Private flag_C1I
    Private write_C1Prot_value
    Private read_C1Prot_value
    Private flag_C1Prot
    Private write_C1DestInc_value
    Private read_C1DestInc_value
    Private flag_C1DestInc
    Private write_C1SrcInc_value
    Private read_C1SrcInc_value
    Private flag_C1SrcInc
    Private write_C1DestWidth_value
    Private read_C1DestWidth_value
    Private flag_C1DestWidth
    Private write_C1SrcWidth_value
    Private read_C1SrcWidth_value
    Private flag_C1SrcWidth
    Private write_C1DestBurstSize_value
    Private read_C1DestBurstSize_value
    Private flag_C1DestBurstSize
    Private write_C1SrcBurstSize_value
    Private read_C1SrcBurstSize_value
    Private flag_C1SrcBurstSize
    Private write_C1TransferSize_value
    Private read_C1TransferSize_value
    Private flag_C1TransferSize

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

    Property Get get_C1I
        get_C1I = read_C1I_value
    End Property

    Property Let set_C1I(aData)
        write_C1I_value = aData
        flag_C1I        = &H1
    End Property

    Property Get read_C1I
        read
        read_C1I = read_C1I_value
    End Property

    Property Let write_C1I(aData)
        set_C1I = aData
        write
    End Property

    Property Get get_C1Prot
        get_C1Prot = read_C1Prot_value
    End Property

    Property Let set_C1Prot(aData)
        write_C1Prot_value = aData
        flag_C1Prot        = &H1
    End Property

    Property Get read_C1Prot
        read
        read_C1Prot = read_C1Prot_value
    End Property

    Property Let write_C1Prot(aData)
        set_C1Prot = aData
        write
    End Property

    Property Get get_C1DestInc
        get_C1DestInc = read_C1DestInc_value
    End Property

    Property Let set_C1DestInc(aData)
        write_C1DestInc_value = aData
        flag_C1DestInc        = &H1
    End Property

    Property Get read_C1DestInc
        read
        read_C1DestInc = read_C1DestInc_value
    End Property

    Property Let write_C1DestInc(aData)
        set_C1DestInc = aData
        write
    End Property

    Property Get get_C1SrcInc
        get_C1SrcInc = read_C1SrcInc_value
    End Property

    Property Let set_C1SrcInc(aData)
        write_C1SrcInc_value = aData
        flag_C1SrcInc        = &H1
    End Property

    Property Get read_C1SrcInc
        read
        read_C1SrcInc = read_C1SrcInc_value
    End Property

    Property Let write_C1SrcInc(aData)
        set_C1SrcInc = aData
        write
    End Property

    Property Get get_C1DestWidth
        get_C1DestWidth = read_C1DestWidth_value
    End Property

    Property Let set_C1DestWidth(aData)
        write_C1DestWidth_value = aData
        flag_C1DestWidth        = &H1
    End Property

    Property Get read_C1DestWidth
        read
        read_C1DestWidth = read_C1DestWidth_value
    End Property

    Property Let write_C1DestWidth(aData)
        set_C1DestWidth = aData
        write
    End Property

    Property Get get_C1SrcWidth
        get_C1SrcWidth = read_C1SrcWidth_value
    End Property

    Property Let set_C1SrcWidth(aData)
        write_C1SrcWidth_value = aData
        flag_C1SrcWidth        = &H1
    End Property

    Property Get read_C1SrcWidth
        read
        read_C1SrcWidth = read_C1SrcWidth_value
    End Property

    Property Let write_C1SrcWidth(aData)
        set_C1SrcWidth = aData
        write
    End Property

    Property Get get_C1DestBurstSize
        get_C1DestBurstSize = read_C1DestBurstSize_value
    End Property

    Property Let set_C1DestBurstSize(aData)
        write_C1DestBurstSize_value = aData
        flag_C1DestBurstSize        = &H1
    End Property

    Property Get read_C1DestBurstSize
        read
        read_C1DestBurstSize = read_C1DestBurstSize_value
    End Property

    Property Let write_C1DestBurstSize(aData)
        set_C1DestBurstSize = aData
        write
    End Property

    Property Get get_C1SrcBurstSize
        get_C1SrcBurstSize = read_C1SrcBurstSize_value
    End Property

    Property Let set_C1SrcBurstSize(aData)
        write_C1SrcBurstSize_value = aData
        flag_C1SrcBurstSize        = &H1
    End Property

    Property Get read_C1SrcBurstSize
        read
        read_C1SrcBurstSize = read_C1SrcBurstSize_value
    End Property

    Property Let write_C1SrcBurstSize(aData)
        set_C1SrcBurstSize = aData
        write
    End Property

    Property Get get_C1TransferSize
        get_C1TransferSize = read_C1TransferSize_value
    End Property

    Property Let set_C1TransferSize(aData)
        write_C1TransferSize_value = aData
        flag_C1TransferSize        = &H1
    End Property

    Property Get read_C1TransferSize
        read
        read_C1TransferSize = read_C1TransferSize_value
    End Property

    Property Let write_C1TransferSize(aData)
        set_C1TransferSize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C1I_value = rightShift(data_low, 31) and &H1
        read_C1Prot_value = rightShift(data_low, 28) and &H7
        read_C1DestInc_value = rightShift(data_low, 27) and &H1
        read_C1SrcInc_value = rightShift(data_low, 26) and &H1
        read_C1DestWidth_value = rightShift(data_low, 21) and &H7
        read_C1SrcWidth_value = rightShift(data_low, 18) and &H7
        read_C1DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_C1SrcBurstSize_value = rightShift(data_low, 12) and &H7
        C1TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if C1TransferSize_mask = mask then
                read_C1TransferSize_value = data_low
            else
                read_C1TransferSize_value = (data_low - H8000_0000) and C1TransferSize_mask
            end If
        else
            read_C1TransferSize_value = data_low and C1TransferSize_mask
        end If

    End Sub

    Sub write
        If flag_C1I = &H0 or flag_C1Prot = &H0 or flag_C1DestInc = &H0 or flag_C1SrcInc = &H0 or flag_C1DestWidth = &H0 or flag_C1SrcWidth = &H0 or flag_C1DestBurstSize = &H0 or flag_C1SrcBurstSize = &H0 or flag_C1TransferSize = &H0 Then read
        If flag_C1I = &H0 Then write_C1I_value = get_C1I
        If flag_C1Prot = &H0 Then write_C1Prot_value = get_C1Prot
        If flag_C1DestInc = &H0 Then write_C1DestInc_value = get_C1DestInc
        If flag_C1SrcInc = &H0 Then write_C1SrcInc_value = get_C1SrcInc
        If flag_C1DestWidth = &H0 Then write_C1DestWidth_value = get_C1DestWidth
        If flag_C1SrcWidth = &H0 Then write_C1SrcWidth_value = get_C1SrcWidth
        If flag_C1DestBurstSize = &H0 Then write_C1DestBurstSize_value = get_C1DestBurstSize
        If flag_C1SrcBurstSize = &H0 Then write_C1SrcBurstSize_value = get_C1SrcBurstSize
        If flag_C1TransferSize = &H0 Then write_C1TransferSize_value = get_C1TransferSize

        regValue = leftShift((write_C1I_value and &H1), 31) + leftShift((write_C1Prot_value and &H7), 28) + leftShift((write_C1DestInc_value and &H1), 27) + leftShift((write_C1SrcInc_value and &H1), 26) + leftShift((write_C1DestWidth_value and &H7), 21) + leftShift((write_C1SrcWidth_value and &H7), 18) + leftShift((write_C1DestBurstSize_value and &H7), 15) + leftShift((write_C1SrcBurstSize_value and &H7), 12) + leftShift((write_C1TransferSize_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C1I_value = rightShift(data_low, 31) and &H1
        read_C1Prot_value = rightShift(data_low, 28) and &H7
        read_C1DestInc_value = rightShift(data_low, 27) and &H1
        read_C1SrcInc_value = rightShift(data_low, 26) and &H1
        read_C1DestWidth_value = rightShift(data_low, 21) and &H7
        read_C1SrcWidth_value = rightShift(data_low, 18) and &H7
        read_C1DestBurstSize_value = rightShift(data_low, 15) and &H7
        read_C1SrcBurstSize_value = rightShift(data_low, 12) and &H7
        C1TransferSize_mask = &Hfff
        if data_low > LONG_MAX then
            if C1TransferSize_mask = mask then
                read_C1TransferSize_value = data_low
            else
                read_C1TransferSize_value = (data_low - H8000_0000) and C1TransferSize_mask
            end If
        else
            read_C1TransferSize_value = data_low and C1TransferSize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C1I_value = &H0
        flag_C1I        = &H0
        write_C1Prot_value = &H0
        flag_C1Prot        = &H0
        write_C1DestInc_value = &H0
        flag_C1DestInc        = &H0
        write_C1SrcInc_value = &H0
        flag_C1SrcInc        = &H0
        write_C1DestWidth_value = &H0
        flag_C1DestWidth        = &H0
        write_C1SrcWidth_value = &H0
        flag_C1SrcWidth        = &H0
        write_C1DestBurstSize_value = &H0
        flag_C1DestBurstSize        = &H0
        write_C1SrcBurstSize_value = &H0
        flag_C1SrcBurstSize        = &H0
        write_C1TransferSize_value = &H0
        flag_C1TransferSize        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacc1configuration
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' C1Halt                                     [18:18]          get_C1Halt
''                                                             set_C1Halt
''                                                             read_C1Halt
''                                                             write_C1Halt
''---------------------------------------------------------------------------------
'' C1Active                                   [17:17]          get_C1Active
''                                                             set_C1Active
''                                                             read_C1Active
''                                                             write_C1Active
''---------------------------------------------------------------------------------
'' C1Lock                                     [16:16]          get_C1Lock
''                                                             set_C1Lock
''                                                             read_C1Lock
''                                                             write_C1Lock
''---------------------------------------------------------------------------------
'' C1IntTCMask                                [15:15]          get_C1IntTCMask
''                                                             set_C1IntTCMask
''                                                             read_C1IntTCMask
''                                                             write_C1IntTCMask
''---------------------------------------------------------------------------------
'' C1IntErrorMask                             [14:14]          get_C1IntErrorMask
''                                                             set_C1IntErrorMask
''                                                             read_C1IntErrorMask
''                                                             write_C1IntErrorMask
''---------------------------------------------------------------------------------
'' C1FlowCntrl                                [13:11]          get_C1FlowCntrl
''                                                             set_C1FlowCntrl
''                                                             read_C1FlowCntrl
''                                                             write_C1FlowCntrl
''---------------------------------------------------------------------------------
'' C1DestPeripheral                           [9:6]            get_C1DestPeripheral
''                                                             set_C1DestPeripheral
''                                                             read_C1DestPeripheral
''                                                             write_C1DestPeripheral
''---------------------------------------------------------------------------------
'' C1SrcPeripheral                            [4:1]            get_C1SrcPeripheral
''                                                             set_C1SrcPeripheral
''                                                             read_C1SrcPeripheral
''                                                             write_C1SrcPeripheral
''---------------------------------------------------------------------------------
'' C1Enable                                   [0:0]            get_C1Enable
''                                                             set_C1Enable
''                                                             read_C1Enable
''                                                             write_C1Enable
''---------------------------------------------------------------------------------
Class REGISTER_DMA_PL081_dmacc1configuration
    Private write_C1Halt_value
    Private read_C1Halt_value
    Private flag_C1Halt
    Private write_C1Active_value
    Private read_C1Active_value
    Private flag_C1Active
    Private write_C1Lock_value
    Private read_C1Lock_value
    Private flag_C1Lock
    Private write_C1IntTCMask_value
    Private read_C1IntTCMask_value
    Private flag_C1IntTCMask
    Private write_C1IntErrorMask_value
    Private read_C1IntErrorMask_value
    Private flag_C1IntErrorMask
    Private write_C1FlowCntrl_value
    Private read_C1FlowCntrl_value
    Private flag_C1FlowCntrl
    Private write_C1DestPeripheral_value
    Private read_C1DestPeripheral_value
    Private flag_C1DestPeripheral
    Private write_C1SrcPeripheral_value
    Private read_C1SrcPeripheral_value
    Private flag_C1SrcPeripheral
    Private write_C1Enable_value
    Private read_C1Enable_value
    Private flag_C1Enable

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

    Property Get get_C1Halt
        get_C1Halt = read_C1Halt_value
    End Property

    Property Let set_C1Halt(aData)
        write_C1Halt_value = aData
        flag_C1Halt        = &H1
    End Property

    Property Get read_C1Halt
        read
        read_C1Halt = read_C1Halt_value
    End Property

    Property Let write_C1Halt(aData)
        set_C1Halt = aData
        write
    End Property

    Property Get get_C1Active
        get_C1Active = read_C1Active_value
    End Property

    Property Let set_C1Active(aData)
        write_C1Active_value = aData
        flag_C1Active        = &H1
    End Property

    Property Get read_C1Active
        read
        read_C1Active = read_C1Active_value
    End Property

    Property Let write_C1Active(aData)
        set_C1Active = aData
        write
    End Property

    Property Get get_C1Lock
        get_C1Lock = read_C1Lock_value
    End Property

    Property Let set_C1Lock(aData)
        write_C1Lock_value = aData
        flag_C1Lock        = &H1
    End Property

    Property Get read_C1Lock
        read
        read_C1Lock = read_C1Lock_value
    End Property

    Property Let write_C1Lock(aData)
        set_C1Lock = aData
        write
    End Property

    Property Get get_C1IntTCMask
        get_C1IntTCMask = read_C1IntTCMask_value
    End Property

    Property Let set_C1IntTCMask(aData)
        write_C1IntTCMask_value = aData
        flag_C1IntTCMask        = &H1
    End Property

    Property Get read_C1IntTCMask
        read
        read_C1IntTCMask = read_C1IntTCMask_value
    End Property

    Property Let write_C1IntTCMask(aData)
        set_C1IntTCMask = aData
        write
    End Property

    Property Get get_C1IntErrorMask
        get_C1IntErrorMask = read_C1IntErrorMask_value
    End Property

    Property Let set_C1IntErrorMask(aData)
        write_C1IntErrorMask_value = aData
        flag_C1IntErrorMask        = &H1
    End Property

    Property Get read_C1IntErrorMask
        read
        read_C1IntErrorMask = read_C1IntErrorMask_value
    End Property

    Property Let write_C1IntErrorMask(aData)
        set_C1IntErrorMask = aData
        write
    End Property

    Property Get get_C1FlowCntrl
        get_C1FlowCntrl = read_C1FlowCntrl_value
    End Property

    Property Let set_C1FlowCntrl(aData)
        write_C1FlowCntrl_value = aData
        flag_C1FlowCntrl        = &H1
    End Property

    Property Get read_C1FlowCntrl
        read
        read_C1FlowCntrl = read_C1FlowCntrl_value
    End Property

    Property Let write_C1FlowCntrl(aData)
        set_C1FlowCntrl = aData
        write
    End Property

    Property Get get_C1DestPeripheral
        get_C1DestPeripheral = read_C1DestPeripheral_value
    End Property

    Property Let set_C1DestPeripheral(aData)
        write_C1DestPeripheral_value = aData
        flag_C1DestPeripheral        = &H1
    End Property

    Property Get read_C1DestPeripheral
        read
        read_C1DestPeripheral = read_C1DestPeripheral_value
    End Property

    Property Let write_C1DestPeripheral(aData)
        set_C1DestPeripheral = aData
        write
    End Property

    Property Get get_C1SrcPeripheral
        get_C1SrcPeripheral = read_C1SrcPeripheral_value
    End Property

    Property Let set_C1SrcPeripheral(aData)
        write_C1SrcPeripheral_value = aData
        flag_C1SrcPeripheral        = &H1
    End Property

    Property Get read_C1SrcPeripheral
        read
        read_C1SrcPeripheral = read_C1SrcPeripheral_value
    End Property

    Property Let write_C1SrcPeripheral(aData)
        set_C1SrcPeripheral = aData
        write
    End Property

    Property Get get_C1Enable
        get_C1Enable = read_C1Enable_value
    End Property

    Property Let set_C1Enable(aData)
        write_C1Enable_value = aData
        flag_C1Enable        = &H1
    End Property

    Property Get read_C1Enable
        read
        read_C1Enable = read_C1Enable_value
    End Property

    Property Let write_C1Enable(aData)
        set_C1Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C1Halt_value = rightShift(data_low, 18) and &H1
        read_C1Active_value = rightShift(data_low, 17) and &H1
        read_C1Lock_value = rightShift(data_low, 16) and &H1
        read_C1IntTCMask_value = rightShift(data_low, 15) and &H1
        read_C1IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_C1FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_C1DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_C1SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        C1Enable_mask = &H1
        if data_low > LONG_MAX then
            if C1Enable_mask = mask then
                read_C1Enable_value = data_low
            else
                read_C1Enable_value = (data_low - H8000_0000) and C1Enable_mask
            end If
        else
            read_C1Enable_value = data_low and C1Enable_mask
        end If

    End Sub

    Sub write
        If flag_C1Halt = &H0 or flag_C1Active = &H0 or flag_C1Lock = &H0 or flag_C1IntTCMask = &H0 or flag_C1IntErrorMask = &H0 or flag_C1FlowCntrl = &H0 or flag_C1DestPeripheral = &H0 or flag_C1SrcPeripheral = &H0 or flag_C1Enable = &H0 Then read
        If flag_C1Halt = &H0 Then write_C1Halt_value = get_C1Halt
        If flag_C1Active = &H0 Then write_C1Active_value = get_C1Active
        If flag_C1Lock = &H0 Then write_C1Lock_value = get_C1Lock
        If flag_C1IntTCMask = &H0 Then write_C1IntTCMask_value = get_C1IntTCMask
        If flag_C1IntErrorMask = &H0 Then write_C1IntErrorMask_value = get_C1IntErrorMask
        If flag_C1FlowCntrl = &H0 Then write_C1FlowCntrl_value = get_C1FlowCntrl
        If flag_C1DestPeripheral = &H0 Then write_C1DestPeripheral_value = get_C1DestPeripheral
        If flag_C1SrcPeripheral = &H0 Then write_C1SrcPeripheral_value = get_C1SrcPeripheral
        If flag_C1Enable = &H0 Then write_C1Enable_value = get_C1Enable

        regValue = leftShift((write_C1Halt_value and &H1), 18) + leftShift((write_C1Active_value and &H1), 17) + leftShift((write_C1Lock_value and &H1), 16) + leftShift((write_C1IntTCMask_value and &H1), 15) + leftShift((write_C1IntErrorMask_value and &H1), 14) + leftShift((write_C1FlowCntrl_value and &H7), 11) + leftShift((write_C1DestPeripheral_value and &Hf), 6) + leftShift((write_C1SrcPeripheral_value and &Hf), 1) + leftShift((write_C1Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_C1Halt_value = rightShift(data_low, 18) and &H1
        read_C1Active_value = rightShift(data_low, 17) and &H1
        read_C1Lock_value = rightShift(data_low, 16) and &H1
        read_C1IntTCMask_value = rightShift(data_low, 15) and &H1
        read_C1IntErrorMask_value = rightShift(data_low, 14) and &H1
        read_C1FlowCntrl_value = rightShift(data_low, 11) and &H7
        read_C1DestPeripheral_value = rightShift(data_low, 6) and &Hf
        read_C1SrcPeripheral_value = rightShift(data_low, 1) and &Hf
        C1Enable_mask = &H1
        if data_low > LONG_MAX then
            if C1Enable_mask = mask then
                read_C1Enable_value = data_low
            else
                read_C1Enable_value = (data_low - H8000_0000) and C1Enable_mask
            end If
        else
            read_C1Enable_value = data_low and C1Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_C1Halt_value = &H0
        flag_C1Halt        = &H0
        write_C1Active_value = &H0
        flag_C1Active        = &H0
        write_C1Lock_value = &H0
        flag_C1Lock        = &H0
        write_C1IntTCMask_value = &H0
        flag_C1IntTCMask        = &H0
        write_C1IntErrorMask_value = &H0
        flag_C1IntErrorMask        = &H0
        write_C1FlowCntrl_value = &H0
        flag_C1FlowCntrl        = &H0
        write_C1DestPeripheral_value = &H0
        flag_C1DestPeripheral        = &H0
        write_C1SrcPeripheral_value = &H0
        flag_C1SrcPeripheral        = &H0
        write_C1Enable_value = &H0
        flag_C1Enable        = &H0
    End Sub
End Class


'' @REGISTER : DMA_PL081_dmacitcr
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
Class REGISTER_DMA_PL081_dmacitcr
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


'' @REGISTER : DMA_PL081_dmacitop1
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
Class REGISTER_DMA_PL081_dmacitop1
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


'' @REGISTER : DMA_PL081_dmacitop2
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
Class REGISTER_DMA_PL081_dmacitop2
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


'' @REGISTER : DMA_PL081_dmacitop3
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
Class REGISTER_DMA_PL081_dmacitop3
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


'' @REGISTER : DMA_PL081_dmacperiphid0
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
Class REGISTER_DMA_PL081_dmacperiphid0
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


'' @REGISTER : DMA_PL081_dmacperiphid1
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
Class REGISTER_DMA_PL081_dmacperiphid1
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


'' @REGISTER : DMA_PL081_dmacperiphid2
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
Class REGISTER_DMA_PL081_dmacperiphid2
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


'' @REGISTER : DMA_PL081_dmacperiphid3
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
Class REGISTER_DMA_PL081_dmacperiphid3
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


'' @REGISTER : DMA_PL081_dmacpcellid0
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
Class REGISTER_DMA_PL081_dmacpcellid0
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


'' @REGISTER : DMA_PL081_dmacpcellid1
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
Class REGISTER_DMA_PL081_dmacpcellid1
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


'' @REGISTER : DMA_PL081_dmacpcellid2
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
Class REGISTER_DMA_PL081_dmacpcellid2
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


'' @REGISTER : DMA_PL081_dmacpcellid3
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
Class REGISTER_DMA_PL081_dmacpcellid3
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

Class DMA_PL081_INSTANCE

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
        Set dmacintstatus = (New REGISTER_DMA_PL081_dmacintstatus)(aBaseAddr, 32)
        Set dmacinttcstatus = (New REGISTER_DMA_PL081_dmacinttcstatus)(aBaseAddr, 32)
        Set dmacinttcclear = (New REGISTER_DMA_PL081_dmacinttcclear)(aBaseAddr, 32)
        Set dmacinterrorstatus = (New REGISTER_DMA_PL081_dmacinterrorstatus)(aBaseAddr, 32)
        Set dmacinterrclr = (New REGISTER_DMA_PL081_dmacinterrclr)(aBaseAddr, 32)
        Set dmacrawinttcstatus = (New REGISTER_DMA_PL081_dmacrawinttcstatus)(aBaseAddr, 32)
        Set dmacrawinterrorstatus = (New REGISTER_DMA_PL081_dmacrawinterrorstatus)(aBaseAddr, 32)
        Set dmacenbldchns = (New REGISTER_DMA_PL081_dmacenbldchns)(aBaseAddr, 32)
        Set dmacsoftbreq = (New REGISTER_DMA_PL081_dmacsoftbreq)(aBaseAddr, 32)
        Set dmacsoftsreq = (New REGISTER_DMA_PL081_dmacsoftsreq)(aBaseAddr, 32)
        Set dmacsoftlbreq = (New REGISTER_DMA_PL081_dmacsoftlbreq)(aBaseAddr, 32)
        Set dmacsoftlsreq = (New REGISTER_DMA_PL081_dmacsoftlsreq)(aBaseAddr, 32)
        Set dmacconfiguration = (New REGISTER_DMA_PL081_dmacconfiguration)(aBaseAddr, 32)
        Set dmacsync = (New REGISTER_DMA_PL081_dmacsync)(aBaseAddr, 32)
        Set dmacc0srcaddr = (New REGISTER_DMA_PL081_dmacc0srcaddr)(aBaseAddr, 32)
        Set dmacc0destaddr = (New REGISTER_DMA_PL081_dmacc0destaddr)(aBaseAddr, 32)
        Set dmacc0lli = (New REGISTER_DMA_PL081_dmacc0lli)(aBaseAddr, 32)
        Set dmacc0control = (New REGISTER_DMA_PL081_dmacc0control)(aBaseAddr, 32)
        Set dmacc0configuration = (New REGISTER_DMA_PL081_dmacc0configuration)(aBaseAddr, 32)
        Set dmacc1srcaddr = (New REGISTER_DMA_PL081_dmacc1srcaddr)(aBaseAddr, 32)
        Set dmacc1destaddr = (New REGISTER_DMA_PL081_dmacc1destaddr)(aBaseAddr, 32)
        Set dmacc1lli = (New REGISTER_DMA_PL081_dmacc1lli)(aBaseAddr, 32)
        Set dmacc1control = (New REGISTER_DMA_PL081_dmacc1control)(aBaseAddr, 32)
        Set dmacc1configuration = (New REGISTER_DMA_PL081_dmacc1configuration)(aBaseAddr, 32)
        Set dmacitcr = (New REGISTER_DMA_PL081_dmacitcr)(aBaseAddr, 32)
        Set dmacitop1 = (New REGISTER_DMA_PL081_dmacitop1)(aBaseAddr, 32)
        Set dmacitop2 = (New REGISTER_DMA_PL081_dmacitop2)(aBaseAddr, 32)
        Set dmacitop3 = (New REGISTER_DMA_PL081_dmacitop3)(aBaseAddr, 32)
        Set dmacperiphid0 = (New REGISTER_DMA_PL081_dmacperiphid0)(aBaseAddr, 32)
        Set dmacperiphid1 = (New REGISTER_DMA_PL081_dmacperiphid1)(aBaseAddr, 32)
        Set dmacperiphid2 = (New REGISTER_DMA_PL081_dmacperiphid2)(aBaseAddr, 32)
        Set dmacperiphid3 = (New REGISTER_DMA_PL081_dmacperiphid3)(aBaseAddr, 32)
        Set dmacpcellid0 = (New REGISTER_DMA_PL081_dmacpcellid0)(aBaseAddr, 32)
        Set dmacpcellid1 = (New REGISTER_DMA_PL081_dmacpcellid1)(aBaseAddr, 32)
        Set dmacpcellid2 = (New REGISTER_DMA_PL081_dmacpcellid2)(aBaseAddr, 32)
        Set dmacpcellid3 = (New REGISTER_DMA_PL081_dmacpcellid3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DMA_PL081 = CreateObject("System.Collections.ArrayList")
DMA_PL081.Add ((New DMA_PL081_INSTANCE)(&H4b180000))


