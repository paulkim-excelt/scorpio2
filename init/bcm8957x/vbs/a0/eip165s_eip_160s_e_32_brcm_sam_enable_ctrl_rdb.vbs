

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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_enable1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable_31_0                                [31:0]           get_enable_31_0
''                                                             set_enable_31_0
''                                                             read_enable_31_0
''                                                             write_enable_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_enable1
    Private write_enable_31_0_value
    Private read_enable_31_0_value
    Private flag_enable_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16000
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable_31_0
        get_enable_31_0 = read_enable_31_0_value
    End Property

    Property Let set_enable_31_0(aData)
        write_enable_31_0_value = aData
        flag_enable_31_0        = &H1
    End Property

    Property Get read_enable_31_0
        read
        read_enable_31_0 = read_enable_31_0_value
    End Property

    Property Let write_enable_31_0(aData)
        set_enable_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if enable_31_0_mask = mask then
                read_enable_31_0_value = data_low
            else
                read_enable_31_0_value = (data_low - H8000_0000) and enable_31_0_mask
            end If
        else
            read_enable_31_0_value = data_low and enable_31_0_mask
        end If

    End Sub

    Sub write
        If flag_enable_31_0 = &H0 Then read
        If flag_enable_31_0 = &H0 Then write_enable_31_0_value = get_enable_31_0

        regValue = leftShift(write_enable_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if enable_31_0_mask = mask then
                read_enable_31_0_value = data_low
            else
                read_enable_31_0_value = (data_low - H8000_0000) and enable_31_0_mask
            end If
        else
            read_enable_31_0_value = data_low and enable_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_31_0_value = &H0
        flag_enable_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_toggle1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' toggle_31_0                                [31:0]           get_toggle_31_0
''                                                             set_toggle_31_0
''                                                             read_toggle_31_0
''                                                             write_toggle_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_toggle1
    Private write_toggle_31_0_value
    Private read_toggle_31_0_value
    Private flag_toggle_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16040
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_toggle_31_0
        get_toggle_31_0 = read_toggle_31_0_value
    End Property

    Property Let set_toggle_31_0(aData)
        write_toggle_31_0_value = aData
        flag_toggle_31_0        = &H1
    End Property

    Property Get read_toggle_31_0
        read
        read_toggle_31_0 = read_toggle_31_0_value
    End Property

    Property Let write_toggle_31_0(aData)
        set_toggle_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        toggle_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if toggle_31_0_mask = mask then
                read_toggle_31_0_value = data_low
            else
                read_toggle_31_0_value = (data_low - H8000_0000) and toggle_31_0_mask
            end If
        else
            read_toggle_31_0_value = data_low and toggle_31_0_mask
        end If

    End Sub

    Sub write
        If flag_toggle_31_0 = &H0 Then read
        If flag_toggle_31_0 = &H0 Then write_toggle_31_0_value = get_toggle_31_0

        regValue = leftShift(write_toggle_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        toggle_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if toggle_31_0_mask = mask then
                read_toggle_31_0_value = data_low
            else
                read_toggle_31_0_value = (data_low - H8000_0000) and toggle_31_0_mask
            end If
        else
            read_toggle_31_0_value = data_low and toggle_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_toggle_31_0_value = &H0
        flag_toggle_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_set1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' set_31_0                                   [31:0]           get_set_31_0
''                                                             set_set_31_0
''                                                             read_set_31_0
''                                                             write_set_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_set1
    Private write_set_31_0_value
    Private read_set_31_0_value
    Private flag_set_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16080
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_set_31_0
        get_set_31_0 = read_set_31_0_value
    End Property

    Property Let set_set_31_0(aData)
        write_set_31_0_value = aData
        flag_set_31_0        = &H1
    End Property

    Property Get read_set_31_0
        read
        read_set_31_0 = read_set_31_0_value
    End Property

    Property Let write_set_31_0(aData)
        set_set_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        set_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if set_31_0_mask = mask then
                read_set_31_0_value = data_low
            else
                read_set_31_0_value = (data_low - H8000_0000) and set_31_0_mask
            end If
        else
            read_set_31_0_value = data_low and set_31_0_mask
        end If

    End Sub

    Sub write
        If flag_set_31_0 = &H0 Then read
        If flag_set_31_0 = &H0 Then write_set_31_0_value = get_set_31_0

        regValue = leftShift(write_set_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        set_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if set_31_0_mask = mask then
                read_set_31_0_value = data_low
            else
                read_set_31_0_value = (data_low - H8000_0000) and set_31_0_mask
            end If
        else
            read_set_31_0_value = data_low and set_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_set_31_0_value = &H0
        flag_set_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_clear1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' clear_31_0                                 [31:0]           get_clear_31_0
''                                                             set_clear_31_0
''                                                             read_clear_31_0
''                                                             write_clear_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_clear1
    Private write_clear_31_0_value
    Private read_clear_31_0_value
    Private flag_clear_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H160c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_clear_31_0
        get_clear_31_0 = read_clear_31_0_value
    End Property

    Property Let set_clear_31_0(aData)
        write_clear_31_0_value = aData
        flag_clear_31_0        = &H1
    End Property

    Property Get read_clear_31_0
        read
        read_clear_31_0 = read_clear_31_0_value
    End Property

    Property Let write_clear_31_0(aData)
        set_clear_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        clear_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if clear_31_0_mask = mask then
                read_clear_31_0_value = data_low
            else
                read_clear_31_0_value = (data_low - H8000_0000) and clear_31_0_mask
            end If
        else
            read_clear_31_0_value = data_low and clear_31_0_mask
        end If

    End Sub

    Sub write
        If flag_clear_31_0 = &H0 Then read
        If flag_clear_31_0 = &H0 Then write_clear_31_0_value = get_clear_31_0

        regValue = leftShift(write_clear_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        clear_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if clear_31_0_mask = mask then
                read_clear_31_0_value = data_low
            else
                read_clear_31_0_value = (data_low - H8000_0000) and clear_31_0_mask
            end If
        else
            read_clear_31_0_value = data_low and clear_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_clear_31_0_value = &H0
        flag_clear_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_enable_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sam_index_set                              [4:0]            get_sam_index_set
''                                                             set_sam_index_set
''                                                             read_sam_index_set
''                                                             write_sam_index_set
''---------------------------------------------------------------------------------
'' set_enable                                 [14:14]          get_set_enable
''                                                             set_set_enable
''                                                             read_set_enable
''                                                             write_set_enable
''---------------------------------------------------------------------------------
'' set_all                                    [15:15]          get_set_all
''                                                             set_set_all
''                                                             read_set_all
''                                                             write_set_all
''---------------------------------------------------------------------------------
'' sam_index_clear                            [20:16]          get_sam_index_clear
''                                                             set_sam_index_clear
''                                                             read_sam_index_clear
''                                                             write_sam_index_clear
''---------------------------------------------------------------------------------
'' clear_enable                               [30:30]          get_clear_enable
''                                                             set_clear_enable
''                                                             read_clear_enable
''                                                             write_clear_enable
''---------------------------------------------------------------------------------
'' clear_all                                  [31:31]          get_clear_all
''                                                             set_clear_all
''                                                             read_clear_all
''                                                             write_clear_all
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_enable_ctrl
    Private write_sam_index_set_value
    Private read_sam_index_set_value
    Private flag_sam_index_set
    Private write_set_enable_value
    Private read_set_enable_value
    Private flag_set_enable
    Private write_set_all_value
    Private read_set_all_value
    Private flag_set_all
    Private write_sam_index_clear_value
    Private read_sam_index_clear_value
    Private flag_sam_index_clear
    Private write_clear_enable_value
    Private read_clear_enable_value
    Private flag_clear_enable
    Private write_clear_all_value
    Private read_clear_all_value
    Private flag_clear_all

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sam_index_set
        get_sam_index_set = read_sam_index_set_value
    End Property

    Property Let set_sam_index_set(aData)
        write_sam_index_set_value = aData
        flag_sam_index_set        = &H1
    End Property

    Property Get read_sam_index_set
        read
        read_sam_index_set = read_sam_index_set_value
    End Property

    Property Let write_sam_index_set(aData)
        set_sam_index_set = aData
        write
    End Property

    Property Get get_set_enable
        get_set_enable = read_set_enable_value
    End Property

    Property Let set_set_enable(aData)
        write_set_enable_value = aData
        flag_set_enable        = &H1
    End Property

    Property Get read_set_enable
        read
        read_set_enable = read_set_enable_value
    End Property

    Property Let write_set_enable(aData)
        set_set_enable = aData
        write
    End Property

    Property Get get_set_all
        get_set_all = read_set_all_value
    End Property

    Property Let set_set_all(aData)
        write_set_all_value = aData
        flag_set_all        = &H1
    End Property

    Property Get read_set_all
        read
        read_set_all = read_set_all_value
    End Property

    Property Let write_set_all(aData)
        set_set_all = aData
        write
    End Property

    Property Get get_sam_index_clear
        get_sam_index_clear = read_sam_index_clear_value
    End Property

    Property Let set_sam_index_clear(aData)
        write_sam_index_clear_value = aData
        flag_sam_index_clear        = &H1
    End Property

    Property Get read_sam_index_clear
        read
        read_sam_index_clear = read_sam_index_clear_value
    End Property

    Property Let write_sam_index_clear(aData)
        set_sam_index_clear = aData
        write
    End Property

    Property Get get_clear_enable
        get_clear_enable = read_clear_enable_value
    End Property

    Property Let set_clear_enable(aData)
        write_clear_enable_value = aData
        flag_clear_enable        = &H1
    End Property

    Property Get read_clear_enable
        read
        read_clear_enable = read_clear_enable_value
    End Property

    Property Let write_clear_enable(aData)
        set_clear_enable = aData
        write
    End Property

    Property Get get_clear_all
        get_clear_all = read_clear_all_value
    End Property

    Property Let set_clear_all(aData)
        write_clear_all_value = aData
        flag_clear_all        = &H1
    End Property

    Property Get read_clear_all
        read
        read_clear_all = read_clear_all_value
    End Property

    Property Let write_clear_all(aData)
        set_clear_all = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sam_index_set_mask = &H1f
        if data_low > LONG_MAX then
            if sam_index_set_mask = mask then
                read_sam_index_set_value = data_low
            else
                read_sam_index_set_value = (data_low - H8000_0000) and sam_index_set_mask
            end If
        else
            read_sam_index_set_value = data_low and sam_index_set_mask
        end If
        read_set_enable_value = rightShift(data_low, 14) and &H1
        read_set_all_value = rightShift(data_low, 15) and &H1
        read_sam_index_clear_value = rightShift(data_low, 16) and &H1f
        read_clear_enable_value = rightShift(data_low, 30) and &H1
        read_clear_all_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_sam_index_set = &H0 or flag_set_enable = &H0 or flag_set_all = &H0 or flag_sam_index_clear = &H0 or flag_clear_enable = &H0 or flag_clear_all = &H0 Then read
        If flag_sam_index_set = &H0 Then write_sam_index_set_value = get_sam_index_set
        If flag_set_enable = &H0 Then write_set_enable_value = get_set_enable
        If flag_set_all = &H0 Then write_set_all_value = get_set_all
        If flag_sam_index_clear = &H0 Then write_sam_index_clear_value = get_sam_index_clear
        If flag_clear_enable = &H0 Then write_clear_enable_value = get_clear_enable
        If flag_clear_all = &H0 Then write_clear_all_value = get_clear_all

        regValue = leftShift((write_sam_index_set_value and &H1f), 0) + leftShift((write_set_enable_value and &H1), 14) + leftShift((write_set_all_value and &H1), 15) + leftShift((write_sam_index_clear_value and &H1f), 16) + leftShift((write_clear_enable_value and &H1), 30) + leftShift((write_clear_all_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sam_index_set_mask = &H1f
        if data_low > LONG_MAX then
            if sam_index_set_mask = mask then
                read_sam_index_set_value = data_low
            else
                read_sam_index_set_value = (data_low - H8000_0000) and sam_index_set_mask
            end If
        else
            read_sam_index_set_value = data_low and sam_index_set_mask
        end If
        read_set_enable_value = rightShift(data_low, 14) and &H1
        read_set_all_value = rightShift(data_low, 15) and &H1
        read_sam_index_clear_value = rightShift(data_low, 16) and &H1f
        read_clear_enable_value = rightShift(data_low, 30) and &H1
        read_clear_all_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sam_index_set_value = &H0
        flag_sam_index_set        = &H0
        write_set_enable_value = &H0
        flag_set_enable        = &H0
        write_set_all_value = &H0
        flag_set_all        = &H0
        write_sam_index_clear_value = &H0
        flag_sam_index_clear        = &H0
        write_clear_enable_value = &H0
        flag_clear_enable        = &H0
        write_clear_all_value = &H0
        flag_clear_all        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_in_flight
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' unsafe                                     [5:0]            get_unsafe
''                                                             set_unsafe
''                                                             read_unsafe
''                                                             write_unsafe
''---------------------------------------------------------------------------------
'' in_flight                                  [13:8]           get_in_flight
''                                                             set_in_flight
''                                                             read_in_flight
''                                                             write_in_flight
''---------------------------------------------------------------------------------
'' load_unsafe                                [31:31]          get_load_unsafe
''                                                             set_load_unsafe
''                                                             read_load_unsafe
''                                                             write_load_unsafe
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_in_flight
    Private write_unsafe_value
    Private read_unsafe_value
    Private flag_unsafe
    Private write_in_flight_value
    Private read_in_flight_value
    Private flag_in_flight
    Private write_load_unsafe_value
    Private read_load_unsafe_value
    Private flag_load_unsafe

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_unsafe
        get_unsafe = read_unsafe_value
    End Property

    Property Let set_unsafe(aData)
        write_unsafe_value = aData
        flag_unsafe        = &H1
    End Property

    Property Get read_unsafe
        read
        read_unsafe = read_unsafe_value
    End Property

    Property Let write_unsafe(aData)
        set_unsafe = aData
        write
    End Property

    Property Get get_in_flight
        get_in_flight = read_in_flight_value
    End Property

    Property Let set_in_flight(aData)
        write_in_flight_value = aData
        flag_in_flight        = &H1
    End Property

    Property Get read_in_flight
        read
        read_in_flight = read_in_flight_value
    End Property

    Property Let write_in_flight(aData)
        set_in_flight = aData
        write
    End Property

    Property Get get_load_unsafe
        get_load_unsafe = read_load_unsafe_value
    End Property

    Property Let set_load_unsafe(aData)
        write_load_unsafe_value = aData
        flag_load_unsafe        = &H1
    End Property

    Property Get read_load_unsafe
        read
        read_load_unsafe = read_load_unsafe_value
    End Property

    Property Let write_load_unsafe(aData)
        set_load_unsafe = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        unsafe_mask = &H3f
        if data_low > LONG_MAX then
            if unsafe_mask = mask then
                read_unsafe_value = data_low
            else
                read_unsafe_value = (data_low - H8000_0000) and unsafe_mask
            end If
        else
            read_unsafe_value = data_low and unsafe_mask
        end If
        read_in_flight_value = rightShift(data_low, 8) and &H3f
        read_load_unsafe_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_unsafe = &H0 or flag_in_flight = &H0 or flag_load_unsafe = &H0 Then read
        If flag_unsafe = &H0 Then write_unsafe_value = get_unsafe
        If flag_in_flight = &H0 Then write_in_flight_value = get_in_flight
        If flag_load_unsafe = &H0 Then write_load_unsafe_value = get_load_unsafe

        regValue = leftShift((write_unsafe_value and &H3f), 0) + leftShift((write_in_flight_value and &H3f), 8) + leftShift((write_load_unsafe_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        unsafe_mask = &H3f
        if data_low > LONG_MAX then
            if unsafe_mask = mask then
                read_unsafe_value = data_low
            else
                read_unsafe_value = (data_low - H8000_0000) and unsafe_mask
            end If
        else
            read_unsafe_value = data_low and unsafe_mask
        end If
        read_in_flight_value = rightShift(data_low, 8) and &H3f
        read_load_unsafe_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_unsafe_value = &H0
        flag_unsafe        = &H0
        write_in_flight_value = &H0
        flag_in_flight        = &H0
        write_load_unsafe_value = &H0
        flag_load_unsafe        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE

    Public sam_entry_enable1
    Public sam_entry_toggle1
    Public sam_entry_set1
    Public sam_entry_clear1
    Public sam_entry_enable_ctrl
    Public sam_in_flight


    Public default function Init(aBaseAddr)
        Set sam_entry_enable1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_enable1)(aBaseAddr, 32)
        Set sam_entry_toggle1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_toggle1)(aBaseAddr, 32)
        Set sam_entry_set1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_set1)(aBaseAddr, 32)
        Set sam_entry_clear1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_clear1)(aBaseAddr, 32)
        Set sam_entry_enable_ctrl = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_entry_enable_ctrl)(aBaseAddr, 32)
        Set sam_in_flight = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_sam_in_flight)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL.Add ((New EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL.Add ((New EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL.Add ((New EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL.Add ((New EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL.Add ((New EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL.Add ((New EIP165S_EIP_160S_E_32_BRCM_SAM_ENABLE_CTRL_INSTANCE)(&H4d510000))


