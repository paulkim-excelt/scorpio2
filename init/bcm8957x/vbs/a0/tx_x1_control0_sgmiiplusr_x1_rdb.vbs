

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


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl49
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' os_mode_cl49_1g                            [15:12]          get_os_mode_cl49_1g
''                                                             set_os_mode_cl49_1g
''                                                             read_os_mode_cl49_1g
''                                                             write_os_mode_cl49_1g
''---------------------------------------------------------------------------------
'' os_mode_cl49_2p5g                          [11:8]           get_os_mode_cl49_2p5g
''                                                             set_os_mode_cl49_2p5g
''                                                             read_os_mode_cl49_2p5g
''                                                             write_os_mode_cl49_2p5g
''---------------------------------------------------------------------------------
'' os_mode_cl49_5g                            [7:4]            get_os_mode_cl49_5g
''                                                             set_os_mode_cl49_5g
''                                                             read_os_mode_cl49_5g
''                                                             write_os_mode_cl49_5g
''---------------------------------------------------------------------------------
'' os_mode_cl49                               [3:0]            get_os_mode_cl49
''                                                             set_os_mode_cl49
''                                                             read_os_mode_cl49
''                                                             write_os_mode_cl49
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl49
    Private write_os_mode_cl49_1g_value
    Private read_os_mode_cl49_1g_value
    Private flag_os_mode_cl49_1g
    Private write_os_mode_cl49_2p5g_value
    Private read_os_mode_cl49_2p5g_value
    Private flag_os_mode_cl49_2p5g
    Private write_os_mode_cl49_5g_value
    Private read_os_mode_cl49_5g_value
    Private flag_os_mode_cl49_5g
    Private write_os_mode_cl49_value
    Private read_os_mode_cl49_value
    Private flag_os_mode_cl49

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

    Property Get get_os_mode_cl49_1g
        get_os_mode_cl49_1g = read_os_mode_cl49_1g_value
    End Property

    Property Let set_os_mode_cl49_1g(aData)
        write_os_mode_cl49_1g_value = aData
        flag_os_mode_cl49_1g        = &H1
    End Property

    Property Get read_os_mode_cl49_1g
        read
        read_os_mode_cl49_1g = read_os_mode_cl49_1g_value
    End Property

    Property Let write_os_mode_cl49_1g(aData)
        set_os_mode_cl49_1g = aData
        write
    End Property

    Property Get get_os_mode_cl49_2p5g
        get_os_mode_cl49_2p5g = read_os_mode_cl49_2p5g_value
    End Property

    Property Let set_os_mode_cl49_2p5g(aData)
        write_os_mode_cl49_2p5g_value = aData
        flag_os_mode_cl49_2p5g        = &H1
    End Property

    Property Get read_os_mode_cl49_2p5g
        read
        read_os_mode_cl49_2p5g = read_os_mode_cl49_2p5g_value
    End Property

    Property Let write_os_mode_cl49_2p5g(aData)
        set_os_mode_cl49_2p5g = aData
        write
    End Property

    Property Get get_os_mode_cl49_5g
        get_os_mode_cl49_5g = read_os_mode_cl49_5g_value
    End Property

    Property Let set_os_mode_cl49_5g(aData)
        write_os_mode_cl49_5g_value = aData
        flag_os_mode_cl49_5g        = &H1
    End Property

    Property Get read_os_mode_cl49_5g
        read
        read_os_mode_cl49_5g = read_os_mode_cl49_5g_value
    End Property

    Property Let write_os_mode_cl49_5g(aData)
        set_os_mode_cl49_5g = aData
        write
    End Property

    Property Get get_os_mode_cl49
        get_os_mode_cl49 = read_os_mode_cl49_value
    End Property

    Property Let set_os_mode_cl49(aData)
        write_os_mode_cl49_value = aData
        flag_os_mode_cl49        = &H1
    End Property

    Property Get read_os_mode_cl49
        read
        read_os_mode_cl49 = read_os_mode_cl49_value
    End Property

    Property Let write_os_mode_cl49(aData)
        set_os_mode_cl49 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_os_mode_cl49_1g_value = rightShift(data_low, 12) and &Hf
        read_os_mode_cl49_2p5g_value = rightShift(data_low, 8) and &Hf
        read_os_mode_cl49_5g_value = rightShift(data_low, 4) and &Hf
        os_mode_cl49_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_cl49_mask = mask then
                read_os_mode_cl49_value = data_low
            else
                read_os_mode_cl49_value = (data_low - H8000_0000) and os_mode_cl49_mask
            end If
        else
            read_os_mode_cl49_value = data_low and os_mode_cl49_mask
        end If

    End Sub

    Sub write
        If flag_os_mode_cl49_1g = &H0 or flag_os_mode_cl49_2p5g = &H0 or flag_os_mode_cl49_5g = &H0 or flag_os_mode_cl49 = &H0 Then read
        If flag_os_mode_cl49_1g = &H0 Then write_os_mode_cl49_1g_value = get_os_mode_cl49_1g
        If flag_os_mode_cl49_2p5g = &H0 Then write_os_mode_cl49_2p5g_value = get_os_mode_cl49_2p5g
        If flag_os_mode_cl49_5g = &H0 Then write_os_mode_cl49_5g_value = get_os_mode_cl49_5g
        If flag_os_mode_cl49 = &H0 Then write_os_mode_cl49_value = get_os_mode_cl49

        regValue = leftShift((write_os_mode_cl49_1g_value and &Hf), 12) + leftShift((write_os_mode_cl49_2p5g_value and &Hf), 8) + leftShift((write_os_mode_cl49_5g_value and &Hf), 4) + leftShift((write_os_mode_cl49_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_os_mode_cl49_1g_value = rightShift(data_low, 12) and &Hf
        read_os_mode_cl49_2p5g_value = rightShift(data_low, 8) and &Hf
        read_os_mode_cl49_5g_value = rightShift(data_low, 4) and &Hf
        os_mode_cl49_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_cl49_mask = mask then
                read_os_mode_cl49_value = data_low
            else
                read_os_mode_cl49_value = (data_low - H8000_0000) and os_mode_cl49_mask
            end If
        else
            read_os_mode_cl49_value = data_low and os_mode_cl49_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_os_mode_cl49_1g_value = &H0
        flag_os_mode_cl49_1g        = &H0
        write_os_mode_cl49_2p5g_value = &H0
        flag_os_mode_cl49_2p5g        = &H0
        write_os_mode_cl49_5g_value = &H0
        flag_os_mode_cl49_5g        = &H0
        write_os_mode_cl49_value = &H0
        flag_os_mode_cl49        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl36
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' os_mode_cl36_2500m                         [15:12]          get_os_mode_cl36_2500m
''                                                             set_os_mode_cl36_2500m
''                                                             read_os_mode_cl36_2500m
''                                                             write_os_mode_cl36_2500m
''---------------------------------------------------------------------------------
'' os_mode_cl36_1000m                         [11:8]           get_os_mode_cl36_1000m
''                                                             set_os_mode_cl36_1000m
''                                                             read_os_mode_cl36_1000m
''                                                             write_os_mode_cl36_1000m
''---------------------------------------------------------------------------------
'' os_mode_cl36_100m                          [7:4]            get_os_mode_cl36_100m
''                                                             set_os_mode_cl36_100m
''                                                             read_os_mode_cl36_100m
''                                                             write_os_mode_cl36_100m
''---------------------------------------------------------------------------------
'' os_mode_cl36_10m                           [3:0]            get_os_mode_cl36_10m
''                                                             set_os_mode_cl36_10m
''                                                             read_os_mode_cl36_10m
''                                                             write_os_mode_cl36_10m
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl36
    Private write_os_mode_cl36_2500m_value
    Private read_os_mode_cl36_2500m_value
    Private flag_os_mode_cl36_2500m
    Private write_os_mode_cl36_1000m_value
    Private read_os_mode_cl36_1000m_value
    Private flag_os_mode_cl36_1000m
    Private write_os_mode_cl36_100m_value
    Private read_os_mode_cl36_100m_value
    Private flag_os_mode_cl36_100m
    Private write_os_mode_cl36_10m_value
    Private read_os_mode_cl36_10m_value
    Private flag_os_mode_cl36_10m

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_os_mode_cl36_2500m
        get_os_mode_cl36_2500m = read_os_mode_cl36_2500m_value
    End Property

    Property Let set_os_mode_cl36_2500m(aData)
        write_os_mode_cl36_2500m_value = aData
        flag_os_mode_cl36_2500m        = &H1
    End Property

    Property Get read_os_mode_cl36_2500m
        read
        read_os_mode_cl36_2500m = read_os_mode_cl36_2500m_value
    End Property

    Property Let write_os_mode_cl36_2500m(aData)
        set_os_mode_cl36_2500m = aData
        write
    End Property

    Property Get get_os_mode_cl36_1000m
        get_os_mode_cl36_1000m = read_os_mode_cl36_1000m_value
    End Property

    Property Let set_os_mode_cl36_1000m(aData)
        write_os_mode_cl36_1000m_value = aData
        flag_os_mode_cl36_1000m        = &H1
    End Property

    Property Get read_os_mode_cl36_1000m
        read
        read_os_mode_cl36_1000m = read_os_mode_cl36_1000m_value
    End Property

    Property Let write_os_mode_cl36_1000m(aData)
        set_os_mode_cl36_1000m = aData
        write
    End Property

    Property Get get_os_mode_cl36_100m
        get_os_mode_cl36_100m = read_os_mode_cl36_100m_value
    End Property

    Property Let set_os_mode_cl36_100m(aData)
        write_os_mode_cl36_100m_value = aData
        flag_os_mode_cl36_100m        = &H1
    End Property

    Property Get read_os_mode_cl36_100m
        read
        read_os_mode_cl36_100m = read_os_mode_cl36_100m_value
    End Property

    Property Let write_os_mode_cl36_100m(aData)
        set_os_mode_cl36_100m = aData
        write
    End Property

    Property Get get_os_mode_cl36_10m
        get_os_mode_cl36_10m = read_os_mode_cl36_10m_value
    End Property

    Property Let set_os_mode_cl36_10m(aData)
        write_os_mode_cl36_10m_value = aData
        flag_os_mode_cl36_10m        = &H1
    End Property

    Property Get read_os_mode_cl36_10m
        read
        read_os_mode_cl36_10m = read_os_mode_cl36_10m_value
    End Property

    Property Let write_os_mode_cl36_10m(aData)
        set_os_mode_cl36_10m = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_os_mode_cl36_2500m_value = rightShift(data_low, 12) and &Hf
        read_os_mode_cl36_1000m_value = rightShift(data_low, 8) and &Hf
        read_os_mode_cl36_100m_value = rightShift(data_low, 4) and &Hf
        os_mode_cl36_10m_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_cl36_10m_mask = mask then
                read_os_mode_cl36_10m_value = data_low
            else
                read_os_mode_cl36_10m_value = (data_low - H8000_0000) and os_mode_cl36_10m_mask
            end If
        else
            read_os_mode_cl36_10m_value = data_low and os_mode_cl36_10m_mask
        end If

    End Sub

    Sub write
        If flag_os_mode_cl36_2500m = &H0 or flag_os_mode_cl36_1000m = &H0 or flag_os_mode_cl36_100m = &H0 or flag_os_mode_cl36_10m = &H0 Then read
        If flag_os_mode_cl36_2500m = &H0 Then write_os_mode_cl36_2500m_value = get_os_mode_cl36_2500m
        If flag_os_mode_cl36_1000m = &H0 Then write_os_mode_cl36_1000m_value = get_os_mode_cl36_1000m
        If flag_os_mode_cl36_100m = &H0 Then write_os_mode_cl36_100m_value = get_os_mode_cl36_100m
        If flag_os_mode_cl36_10m = &H0 Then write_os_mode_cl36_10m_value = get_os_mode_cl36_10m

        regValue = leftShift((write_os_mode_cl36_2500m_value and &Hf), 12) + leftShift((write_os_mode_cl36_1000m_value and &Hf), 8) + leftShift((write_os_mode_cl36_100m_value and &Hf), 4) + leftShift((write_os_mode_cl36_10m_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_os_mode_cl36_2500m_value = rightShift(data_low, 12) and &Hf
        read_os_mode_cl36_1000m_value = rightShift(data_low, 8) and &Hf
        read_os_mode_cl36_100m_value = rightShift(data_low, 4) and &Hf
        os_mode_cl36_10m_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_cl36_10m_mask = mask then
                read_os_mode_cl36_10m_value = data_low
            else
                read_os_mode_cl36_10m_value = (data_low - H8000_0000) and os_mode_cl36_10m_mask
            end If
        else
            read_os_mode_cl36_10m_value = data_low and os_mode_cl36_10m_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_os_mode_cl36_2500m_value = &H0
        flag_os_mode_cl36_2500m        = &H0
        write_os_mode_cl36_1000m_value = &H0
        flag_os_mode_cl36_1000m        = &H0
        write_os_mode_cl36_100m_value = &H0
        flag_os_mode_cl36_100m        = &H0
        write_os_mode_cl36_10m_value = &H0
        flag_os_mode_cl36_10m        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_osr_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' osr_mode_cl73                              [15:12]          get_osr_mode_cl73
''                                                             set_osr_mode_cl73
''                                                             read_osr_mode_cl73
''                                                             write_osr_mode_cl73
''---------------------------------------------------------------------------------
'' osr_mode_cl36                              [11:8]           get_osr_mode_cl36
''                                                             set_osr_mode_cl36
''                                                             read_osr_mode_cl36
''                                                             write_osr_mode_cl36
''---------------------------------------------------------------------------------
'' osr_mode_cl36_2p5                          [7:4]            get_osr_mode_cl36_2p5
''                                                             set_osr_mode_cl36_2p5
''                                                             read_osr_mode_cl36_2p5
''                                                             write_osr_mode_cl36_2p5
''---------------------------------------------------------------------------------
'' osr_mode_cl49                              [3:0]            get_osr_mode_cl49
''                                                             set_osr_mode_cl49
''                                                             read_osr_mode_cl49
''                                                             write_osr_mode_cl49
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_osr_mode
    Private write_osr_mode_cl73_value
    Private read_osr_mode_cl73_value
    Private flag_osr_mode_cl73
    Private write_osr_mode_cl36_value
    Private read_osr_mode_cl36_value
    Private flag_osr_mode_cl36
    Private write_osr_mode_cl36_2p5_value
    Private read_osr_mode_cl36_2p5_value
    Private flag_osr_mode_cl36_2p5
    Private write_osr_mode_cl49_value
    Private read_osr_mode_cl49_value
    Private flag_osr_mode_cl49

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

    Property Get get_osr_mode_cl73
        get_osr_mode_cl73 = read_osr_mode_cl73_value
    End Property

    Property Let set_osr_mode_cl73(aData)
        write_osr_mode_cl73_value = aData
        flag_osr_mode_cl73        = &H1
    End Property

    Property Get read_osr_mode_cl73
        read
        read_osr_mode_cl73 = read_osr_mode_cl73_value
    End Property

    Property Let write_osr_mode_cl73(aData)
        set_osr_mode_cl73 = aData
        write
    End Property

    Property Get get_osr_mode_cl36
        get_osr_mode_cl36 = read_osr_mode_cl36_value
    End Property

    Property Let set_osr_mode_cl36(aData)
        write_osr_mode_cl36_value = aData
        flag_osr_mode_cl36        = &H1
    End Property

    Property Get read_osr_mode_cl36
        read
        read_osr_mode_cl36 = read_osr_mode_cl36_value
    End Property

    Property Let write_osr_mode_cl36(aData)
        set_osr_mode_cl36 = aData
        write
    End Property

    Property Get get_osr_mode_cl36_2p5
        get_osr_mode_cl36_2p5 = read_osr_mode_cl36_2p5_value
    End Property

    Property Let set_osr_mode_cl36_2p5(aData)
        write_osr_mode_cl36_2p5_value = aData
        flag_osr_mode_cl36_2p5        = &H1
    End Property

    Property Get read_osr_mode_cl36_2p5
        read
        read_osr_mode_cl36_2p5 = read_osr_mode_cl36_2p5_value
    End Property

    Property Let write_osr_mode_cl36_2p5(aData)
        set_osr_mode_cl36_2p5 = aData
        write
    End Property

    Property Get get_osr_mode_cl49
        get_osr_mode_cl49 = read_osr_mode_cl49_value
    End Property

    Property Let set_osr_mode_cl49(aData)
        write_osr_mode_cl49_value = aData
        flag_osr_mode_cl49        = &H1
    End Property

    Property Get read_osr_mode_cl49
        read
        read_osr_mode_cl49 = read_osr_mode_cl49_value
    End Property

    Property Let write_osr_mode_cl49(aData)
        set_osr_mode_cl49 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_osr_mode_cl73_value = rightShift(data_low, 12) and &Hf
        read_osr_mode_cl36_value = rightShift(data_low, 8) and &Hf
        read_osr_mode_cl36_2p5_value = rightShift(data_low, 4) and &Hf
        osr_mode_cl49_mask = &Hf
        if data_low > LONG_MAX then
            if osr_mode_cl49_mask = mask then
                read_osr_mode_cl49_value = data_low
            else
                read_osr_mode_cl49_value = (data_low - H8000_0000) and osr_mode_cl49_mask
            end If
        else
            read_osr_mode_cl49_value = data_low and osr_mode_cl49_mask
        end If

    End Sub

    Sub write
        If flag_osr_mode_cl73 = &H0 or flag_osr_mode_cl36 = &H0 or flag_osr_mode_cl36_2p5 = &H0 or flag_osr_mode_cl49 = &H0 Then read
        If flag_osr_mode_cl73 = &H0 Then write_osr_mode_cl73_value = get_osr_mode_cl73
        If flag_osr_mode_cl36 = &H0 Then write_osr_mode_cl36_value = get_osr_mode_cl36
        If flag_osr_mode_cl36_2p5 = &H0 Then write_osr_mode_cl36_2p5_value = get_osr_mode_cl36_2p5
        If flag_osr_mode_cl49 = &H0 Then write_osr_mode_cl49_value = get_osr_mode_cl49

        regValue = leftShift((write_osr_mode_cl73_value and &Hf), 12) + leftShift((write_osr_mode_cl36_value and &Hf), 8) + leftShift((write_osr_mode_cl36_2p5_value and &Hf), 4) + leftShift((write_osr_mode_cl49_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_osr_mode_cl73_value = rightShift(data_low, 12) and &Hf
        read_osr_mode_cl36_value = rightShift(data_low, 8) and &Hf
        read_osr_mode_cl36_2p5_value = rightShift(data_low, 4) and &Hf
        osr_mode_cl49_mask = &Hf
        if data_low > LONG_MAX then
            if osr_mode_cl49_mask = mask then
                read_osr_mode_cl49_value = data_low
            else
                read_osr_mode_cl49_value = (data_low - H8000_0000) and osr_mode_cl49_mask
            end If
        else
            read_osr_mode_cl49_value = data_low and osr_mode_cl49_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_osr_mode_cl73_value = &H0
        flag_osr_mode_cl73        = &H0
        write_osr_mode_cl36_value = &H0
        flag_osr_mode_cl36        = &H0
        write_osr_mode_cl36_2p5_value = &H0
        flag_osr_mode_cl36_2p5        = &H0
        write_osr_mode_cl49_value = &H0
        flag_osr_mode_cl49        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_enc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENCODE_MODE_CL127                          [11:9]           get_ENCODE_MODE_CL127
''                                                             set_ENCODE_MODE_CL127
''                                                             read_ENCODE_MODE_CL127
''                                                             write_ENCODE_MODE_CL127
''---------------------------------------------------------------------------------
'' ENCODE_MODE_CUSTOM                         [8:6]            get_ENCODE_MODE_CUSTOM
''                                                             set_ENCODE_MODE_CUSTOM
''                                                             read_ENCODE_MODE_CUSTOM
''                                                             write_ENCODE_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' ENCODE_MODE_CL49                           [5:3]            get_ENCODE_MODE_CL49
''                                                             set_ENCODE_MODE_CL49
''                                                             read_ENCODE_MODE_CL49
''                                                             write_ENCODE_MODE_CL49
''---------------------------------------------------------------------------------
'' ENCODE_MODE_CL36                           [2:0]            get_ENCODE_MODE_CL36
''                                                             set_ENCODE_MODE_CL36
''                                                             read_ENCODE_MODE_CL36
''                                                             write_ENCODE_MODE_CL36
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_enc
    Private write_ENCODE_MODE_CL127_value
    Private read_ENCODE_MODE_CL127_value
    Private flag_ENCODE_MODE_CL127
    Private write_ENCODE_MODE_CUSTOM_value
    Private read_ENCODE_MODE_CUSTOM_value
    Private flag_ENCODE_MODE_CUSTOM
    Private write_ENCODE_MODE_CL49_value
    Private read_ENCODE_MODE_CL49_value
    Private flag_ENCODE_MODE_CL49
    Private write_ENCODE_MODE_CL36_value
    Private read_ENCODE_MODE_CL36_value
    Private flag_ENCODE_MODE_CL36

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ENCODE_MODE_CL127
        get_ENCODE_MODE_CL127 = read_ENCODE_MODE_CL127_value
    End Property

    Property Let set_ENCODE_MODE_CL127(aData)
        write_ENCODE_MODE_CL127_value = aData
        flag_ENCODE_MODE_CL127        = &H1
    End Property

    Property Get read_ENCODE_MODE_CL127
        read
        read_ENCODE_MODE_CL127 = read_ENCODE_MODE_CL127_value
    End Property

    Property Let write_ENCODE_MODE_CL127(aData)
        set_ENCODE_MODE_CL127 = aData
        write
    End Property

    Property Get get_ENCODE_MODE_CUSTOM
        get_ENCODE_MODE_CUSTOM = read_ENCODE_MODE_CUSTOM_value
    End Property

    Property Let set_ENCODE_MODE_CUSTOM(aData)
        write_ENCODE_MODE_CUSTOM_value = aData
        flag_ENCODE_MODE_CUSTOM        = &H1
    End Property

    Property Get read_ENCODE_MODE_CUSTOM
        read
        read_ENCODE_MODE_CUSTOM = read_ENCODE_MODE_CUSTOM_value
    End Property

    Property Let write_ENCODE_MODE_CUSTOM(aData)
        set_ENCODE_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_ENCODE_MODE_CL49
        get_ENCODE_MODE_CL49 = read_ENCODE_MODE_CL49_value
    End Property

    Property Let set_ENCODE_MODE_CL49(aData)
        write_ENCODE_MODE_CL49_value = aData
        flag_ENCODE_MODE_CL49        = &H1
    End Property

    Property Get read_ENCODE_MODE_CL49
        read
        read_ENCODE_MODE_CL49 = read_ENCODE_MODE_CL49_value
    End Property

    Property Let write_ENCODE_MODE_CL49(aData)
        set_ENCODE_MODE_CL49 = aData
        write
    End Property

    Property Get get_ENCODE_MODE_CL36
        get_ENCODE_MODE_CL36 = read_ENCODE_MODE_CL36_value
    End Property

    Property Let set_ENCODE_MODE_CL36(aData)
        write_ENCODE_MODE_CL36_value = aData
        flag_ENCODE_MODE_CL36        = &H1
    End Property

    Property Get read_ENCODE_MODE_CL36
        read
        read_ENCODE_MODE_CL36 = read_ENCODE_MODE_CL36_value
    End Property

    Property Let write_ENCODE_MODE_CL36(aData)
        set_ENCODE_MODE_CL36 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENCODE_MODE_CL127_value = rightShift(data_low, 9) and &H7
        read_ENCODE_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_ENCODE_MODE_CL49_value = rightShift(data_low, 3) and &H7
        ENCODE_MODE_CL36_mask = &H7
        if data_low > LONG_MAX then
            if ENCODE_MODE_CL36_mask = mask then
                read_ENCODE_MODE_CL36_value = data_low
            else
                read_ENCODE_MODE_CL36_value = (data_low - H8000_0000) and ENCODE_MODE_CL36_mask
            end If
        else
            read_ENCODE_MODE_CL36_value = data_low and ENCODE_MODE_CL36_mask
        end If

    End Sub

    Sub write
        If flag_ENCODE_MODE_CL127 = &H0 or flag_ENCODE_MODE_CUSTOM = &H0 or flag_ENCODE_MODE_CL49 = &H0 or flag_ENCODE_MODE_CL36 = &H0 Then read
        If flag_ENCODE_MODE_CL127 = &H0 Then write_ENCODE_MODE_CL127_value = get_ENCODE_MODE_CL127
        If flag_ENCODE_MODE_CUSTOM = &H0 Then write_ENCODE_MODE_CUSTOM_value = get_ENCODE_MODE_CUSTOM
        If flag_ENCODE_MODE_CL49 = &H0 Then write_ENCODE_MODE_CL49_value = get_ENCODE_MODE_CL49
        If flag_ENCODE_MODE_CL36 = &H0 Then write_ENCODE_MODE_CL36_value = get_ENCODE_MODE_CL36

        regValue = leftShift((write_ENCODE_MODE_CL127_value and &H7), 9) + leftShift((write_ENCODE_MODE_CUSTOM_value and &H7), 6) + leftShift((write_ENCODE_MODE_CL49_value and &H7), 3) + leftShift((write_ENCODE_MODE_CL36_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENCODE_MODE_CL127_value = rightShift(data_low, 9) and &H7
        read_ENCODE_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_ENCODE_MODE_CL49_value = rightShift(data_low, 3) and &H7
        ENCODE_MODE_CL36_mask = &H7
        if data_low > LONG_MAX then
            if ENCODE_MODE_CL36_mask = mask then
                read_ENCODE_MODE_CL36_value = data_low
            else
                read_ENCODE_MODE_CL36_value = (data_low - H8000_0000) and ENCODE_MODE_CL36_mask
            end If
        else
            read_ENCODE_MODE_CL36_value = data_low and ENCODE_MODE_CL36_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENCODE_MODE_CL127_value = &H0
        flag_ENCODE_MODE_CL127        = &H0
        write_ENCODE_MODE_CUSTOM_value = &H0
        flag_ENCODE_MODE_CUSTOM        = &H0
        write_ENCODE_MODE_CL49_value = &H0
        flag_ENCODE_MODE_CL49        = &H0
        write_ENCODE_MODE_CL36_value = &H0
        flag_ENCODE_MODE_CL36        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_scr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' T_SCR_MODE_CUSTOM                          [5:4]            get_T_SCR_MODE_CUSTOM
''                                                             set_T_SCR_MODE_CUSTOM
''                                                             read_T_SCR_MODE_CUSTOM
''                                                             write_T_SCR_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' T_SCR_MODE_64B                             [3:2]            get_T_SCR_MODE_64B
''                                                             set_T_SCR_MODE_64B
''                                                             read_T_SCR_MODE_64B
''                                                             write_T_SCR_MODE_64B
''---------------------------------------------------------------------------------
'' T_SCR_MODE_BYPASS                          [1:0]            get_T_SCR_MODE_BYPASS
''                                                             set_T_SCR_MODE_BYPASS
''                                                             read_T_SCR_MODE_BYPASS
''                                                             write_T_SCR_MODE_BYPASS
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_scr
    Private write_T_SCR_MODE_CUSTOM_value
    Private read_T_SCR_MODE_CUSTOM_value
    Private flag_T_SCR_MODE_CUSTOM
    Private write_T_SCR_MODE_64B_value
    Private read_T_SCR_MODE_64B_value
    Private flag_T_SCR_MODE_64B
    Private write_T_SCR_MODE_BYPASS_value
    Private read_T_SCR_MODE_BYPASS_value
    Private flag_T_SCR_MODE_BYPASS

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

    Property Get get_T_SCR_MODE_CUSTOM
        get_T_SCR_MODE_CUSTOM = read_T_SCR_MODE_CUSTOM_value
    End Property

    Property Let set_T_SCR_MODE_CUSTOM(aData)
        write_T_SCR_MODE_CUSTOM_value = aData
        flag_T_SCR_MODE_CUSTOM        = &H1
    End Property

    Property Get read_T_SCR_MODE_CUSTOM
        read
        read_T_SCR_MODE_CUSTOM = read_T_SCR_MODE_CUSTOM_value
    End Property

    Property Let write_T_SCR_MODE_CUSTOM(aData)
        set_T_SCR_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_T_SCR_MODE_64B
        get_T_SCR_MODE_64B = read_T_SCR_MODE_64B_value
    End Property

    Property Let set_T_SCR_MODE_64B(aData)
        write_T_SCR_MODE_64B_value = aData
        flag_T_SCR_MODE_64B        = &H1
    End Property

    Property Get read_T_SCR_MODE_64B
        read
        read_T_SCR_MODE_64B = read_T_SCR_MODE_64B_value
    End Property

    Property Let write_T_SCR_MODE_64B(aData)
        set_T_SCR_MODE_64B = aData
        write
    End Property

    Property Get get_T_SCR_MODE_BYPASS
        get_T_SCR_MODE_BYPASS = read_T_SCR_MODE_BYPASS_value
    End Property

    Property Let set_T_SCR_MODE_BYPASS(aData)
        write_T_SCR_MODE_BYPASS_value = aData
        flag_T_SCR_MODE_BYPASS        = &H1
    End Property

    Property Get read_T_SCR_MODE_BYPASS
        read
        read_T_SCR_MODE_BYPASS = read_T_SCR_MODE_BYPASS_value
    End Property

    Property Let write_T_SCR_MODE_BYPASS(aData)
        set_T_SCR_MODE_BYPASS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_T_SCR_MODE_CUSTOM_value = rightShift(data_low, 4) and &H3
        read_T_SCR_MODE_64B_value = rightShift(data_low, 2) and &H3
        T_SCR_MODE_BYPASS_mask = &H3
        if data_low > LONG_MAX then
            if T_SCR_MODE_BYPASS_mask = mask then
                read_T_SCR_MODE_BYPASS_value = data_low
            else
                read_T_SCR_MODE_BYPASS_value = (data_low - H8000_0000) and T_SCR_MODE_BYPASS_mask
            end If
        else
            read_T_SCR_MODE_BYPASS_value = data_low and T_SCR_MODE_BYPASS_mask
        end If

    End Sub

    Sub write
        If flag_T_SCR_MODE_CUSTOM = &H0 or flag_T_SCR_MODE_64B = &H0 or flag_T_SCR_MODE_BYPASS = &H0 Then read
        If flag_T_SCR_MODE_CUSTOM = &H0 Then write_T_SCR_MODE_CUSTOM_value = get_T_SCR_MODE_CUSTOM
        If flag_T_SCR_MODE_64B = &H0 Then write_T_SCR_MODE_64B_value = get_T_SCR_MODE_64B
        If flag_T_SCR_MODE_BYPASS = &H0 Then write_T_SCR_MODE_BYPASS_value = get_T_SCR_MODE_BYPASS

        regValue = leftShift((write_T_SCR_MODE_CUSTOM_value and &H3), 4) + leftShift((write_T_SCR_MODE_64B_value and &H3), 2) + leftShift((write_T_SCR_MODE_BYPASS_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_T_SCR_MODE_CUSTOM_value = rightShift(data_low, 4) and &H3
        read_T_SCR_MODE_64B_value = rightShift(data_low, 2) and &H3
        T_SCR_MODE_BYPASS_mask = &H3
        if data_low > LONG_MAX then
            if T_SCR_MODE_BYPASS_mask = mask then
                read_T_SCR_MODE_BYPASS_value = data_low
            else
                read_T_SCR_MODE_BYPASS_value = (data_low - H8000_0000) and T_SCR_MODE_BYPASS_mask
            end If
        else
            read_T_SCR_MODE_BYPASS_value = data_low and T_SCR_MODE_BYPASS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_T_SCR_MODE_CUSTOM_value = &H0
        flag_T_SCR_MODE_CUSTOM        = &H0
        write_T_SCR_MODE_64B_value = &H0
        flag_T_SCR_MODE_64B        = &H0
        write_T_SCR_MODE_BYPASS_value = &H0
        flag_T_SCR_MODE_BYPASS        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl36_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' os_mode_cl36_5                             [3:0]            get_os_mode_cl36_5
''                                                             set_os_mode_cl36_5
''                                                             read_os_mode_cl36_5
''                                                             write_os_mode_cl36_5
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl36_2
    Private write_os_mode_cl36_5_value
    Private read_os_mode_cl36_5_value
    Private flag_os_mode_cl36_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_os_mode_cl36_5
        get_os_mode_cl36_5 = read_os_mode_cl36_5_value
    End Property

    Property Let set_os_mode_cl36_5(aData)
        write_os_mode_cl36_5_value = aData
        flag_os_mode_cl36_5        = &H1
    End Property

    Property Get read_os_mode_cl36_5
        read
        read_os_mode_cl36_5 = read_os_mode_cl36_5_value
    End Property

    Property Let write_os_mode_cl36_5(aData)
        set_os_mode_cl36_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        os_mode_cl36_5_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_cl36_5_mask = mask then
                read_os_mode_cl36_5_value = data_low
            else
                read_os_mode_cl36_5_value = (data_low - H8000_0000) and os_mode_cl36_5_mask
            end If
        else
            read_os_mode_cl36_5_value = data_low and os_mode_cl36_5_mask
        end If

    End Sub

    Sub write
        If flag_os_mode_cl36_5 = &H0 Then read
        If flag_os_mode_cl36_5 = &H0 Then write_os_mode_cl36_5_value = get_os_mode_cl36_5

        regValue = leftShift((write_os_mode_cl36_5_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        os_mode_cl36_5_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_cl36_5_mask = mask then
                read_os_mode_cl36_5_value = data_low
            else
                read_os_mode_cl36_5_value = (data_low - H8000_0000) and os_mode_cl36_5_mask
            end If
        else
            read_os_mode_cl36_5_value = data_low and os_mode_cl36_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_os_mode_cl36_5_value = &H0
        flag_os_mode_cl36_5        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_osr_mode_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' osr_mode_cl49_1g                           [15:12]          get_osr_mode_cl49_1g
''                                                             set_osr_mode_cl49_1g
''                                                             read_osr_mode_cl49_1g
''                                                             write_osr_mode_cl49_1g
''---------------------------------------------------------------------------------
'' osr_mode_cl49_2p5g                         [11:8]           get_osr_mode_cl49_2p5g
''                                                             set_osr_mode_cl49_2p5g
''                                                             read_osr_mode_cl49_2p5g
''                                                             write_osr_mode_cl49_2p5g
''---------------------------------------------------------------------------------
'' osr_mode_cl49_5g                           [7:4]            get_osr_mode_cl49_5g
''                                                             set_osr_mode_cl49_5g
''                                                             read_osr_mode_cl49_5g
''                                                             write_osr_mode_cl49_5g
''---------------------------------------------------------------------------------
'' osr_mode_cl36_5                            [3:0]            get_osr_mode_cl36_5
''                                                             set_osr_mode_cl36_5
''                                                             read_osr_mode_cl36_5
''                                                             write_osr_mode_cl36_5
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_osr_mode_2
    Private write_osr_mode_cl49_1g_value
    Private read_osr_mode_cl49_1g_value
    Private flag_osr_mode_cl49_1g
    Private write_osr_mode_cl49_2p5g_value
    Private read_osr_mode_cl49_2p5g_value
    Private flag_osr_mode_cl49_2p5g
    Private write_osr_mode_cl49_5g_value
    Private read_osr_mode_cl49_5g_value
    Private flag_osr_mode_cl49_5g
    Private write_osr_mode_cl36_5_value
    Private read_osr_mode_cl36_5_value
    Private flag_osr_mode_cl36_5

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

    Property Get get_osr_mode_cl49_1g
        get_osr_mode_cl49_1g = read_osr_mode_cl49_1g_value
    End Property

    Property Let set_osr_mode_cl49_1g(aData)
        write_osr_mode_cl49_1g_value = aData
        flag_osr_mode_cl49_1g        = &H1
    End Property

    Property Get read_osr_mode_cl49_1g
        read
        read_osr_mode_cl49_1g = read_osr_mode_cl49_1g_value
    End Property

    Property Let write_osr_mode_cl49_1g(aData)
        set_osr_mode_cl49_1g = aData
        write
    End Property

    Property Get get_osr_mode_cl49_2p5g
        get_osr_mode_cl49_2p5g = read_osr_mode_cl49_2p5g_value
    End Property

    Property Let set_osr_mode_cl49_2p5g(aData)
        write_osr_mode_cl49_2p5g_value = aData
        flag_osr_mode_cl49_2p5g        = &H1
    End Property

    Property Get read_osr_mode_cl49_2p5g
        read
        read_osr_mode_cl49_2p5g = read_osr_mode_cl49_2p5g_value
    End Property

    Property Let write_osr_mode_cl49_2p5g(aData)
        set_osr_mode_cl49_2p5g = aData
        write
    End Property

    Property Get get_osr_mode_cl49_5g
        get_osr_mode_cl49_5g = read_osr_mode_cl49_5g_value
    End Property

    Property Let set_osr_mode_cl49_5g(aData)
        write_osr_mode_cl49_5g_value = aData
        flag_osr_mode_cl49_5g        = &H1
    End Property

    Property Get read_osr_mode_cl49_5g
        read
        read_osr_mode_cl49_5g = read_osr_mode_cl49_5g_value
    End Property

    Property Let write_osr_mode_cl49_5g(aData)
        set_osr_mode_cl49_5g = aData
        write
    End Property

    Property Get get_osr_mode_cl36_5
        get_osr_mode_cl36_5 = read_osr_mode_cl36_5_value
    End Property

    Property Let set_osr_mode_cl36_5(aData)
        write_osr_mode_cl36_5_value = aData
        flag_osr_mode_cl36_5        = &H1
    End Property

    Property Get read_osr_mode_cl36_5
        read
        read_osr_mode_cl36_5 = read_osr_mode_cl36_5_value
    End Property

    Property Let write_osr_mode_cl36_5(aData)
        set_osr_mode_cl36_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_osr_mode_cl49_1g_value = rightShift(data_low, 12) and &Hf
        read_osr_mode_cl49_2p5g_value = rightShift(data_low, 8) and &Hf
        read_osr_mode_cl49_5g_value = rightShift(data_low, 4) and &Hf
        osr_mode_cl36_5_mask = &Hf
        if data_low > LONG_MAX then
            if osr_mode_cl36_5_mask = mask then
                read_osr_mode_cl36_5_value = data_low
            else
                read_osr_mode_cl36_5_value = (data_low - H8000_0000) and osr_mode_cl36_5_mask
            end If
        else
            read_osr_mode_cl36_5_value = data_low and osr_mode_cl36_5_mask
        end If

    End Sub

    Sub write
        If flag_osr_mode_cl49_1g = &H0 or flag_osr_mode_cl49_2p5g = &H0 or flag_osr_mode_cl49_5g = &H0 or flag_osr_mode_cl36_5 = &H0 Then read
        If flag_osr_mode_cl49_1g = &H0 Then write_osr_mode_cl49_1g_value = get_osr_mode_cl49_1g
        If flag_osr_mode_cl49_2p5g = &H0 Then write_osr_mode_cl49_2p5g_value = get_osr_mode_cl49_2p5g
        If flag_osr_mode_cl49_5g = &H0 Then write_osr_mode_cl49_5g_value = get_osr_mode_cl49_5g
        If flag_osr_mode_cl36_5 = &H0 Then write_osr_mode_cl36_5_value = get_osr_mode_cl36_5

        regValue = leftShift((write_osr_mode_cl49_1g_value and &Hf), 12) + leftShift((write_osr_mode_cl49_2p5g_value and &Hf), 8) + leftShift((write_osr_mode_cl49_5g_value and &Hf), 4) + leftShift((write_osr_mode_cl36_5_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_osr_mode_cl49_1g_value = rightShift(data_low, 12) and &Hf
        read_osr_mode_cl49_2p5g_value = rightShift(data_low, 8) and &Hf
        read_osr_mode_cl49_5g_value = rightShift(data_low, 4) and &Hf
        osr_mode_cl36_5_mask = &Hf
        if data_low > LONG_MAX then
            if osr_mode_cl36_5_mask = mask then
                read_osr_mode_cl36_5_value = data_low
            else
                read_osr_mode_cl36_5_value = (data_low - H8000_0000) and osr_mode_cl36_5_mask
            end If
        else
            read_osr_mode_cl36_5_value = data_low and osr_mode_cl36_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_osr_mode_cl49_1g_value = &H0
        flag_osr_mode_cl49_1g        = &H0
        write_osr_mode_cl49_2p5g_value = &H0
        flag_osr_mode_cl49_2p5g        = &H0
        write_osr_mode_cl49_5g_value = &H0
        flag_osr_mode_cl49_5g        = &H0
        write_osr_mode_cl36_5_value = &H0
        flag_osr_mode_cl36_5        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CONTROL0_SGMIIPLUSR_X1_blockaddress
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BlockAddress                               [14:4]           get_BlockAddress
''                                                             set_BlockAddress
''                                                             read_BlockAddress
''                                                             write_BlockAddress
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_blockaddress
    Private write_BlockAddress_value
    Private read_BlockAddress_value
    Private flag_BlockAddress

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BlockAddress
        get_BlockAddress = read_BlockAddress_value
    End Property

    Property Let set_BlockAddress(aData)
        write_BlockAddress_value = aData
        flag_BlockAddress        = &H1
    End Property

    Property Get read_BlockAddress
        read
        read_BlockAddress = read_BlockAddress_value
    End Property

    Property Let write_BlockAddress(aData)
        set_BlockAddress = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

    End Sub

    Sub write
        If flag_BlockAddress = &H0 Then read
        If flag_BlockAddress = &H0 Then write_BlockAddress_value = get_BlockAddress

        regValue = leftShift((write_BlockAddress_value and &H7ff), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BlockAddress_value = &H0
        flag_BlockAddress        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TX_X1_CONTROL0_SGMIIPLUSR_X1_INSTANCE

    Public os_mode_cl49
    Public os_mode_cl36
    Public pmd_osr_mode
    Public enc
    Public scr
    Public os_mode_cl36_2
    Public pmd_osr_mode_2
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set os_mode_cl49 = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl49)(aBaseAddr, 16)
        Set os_mode_cl36 = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl36)(aBaseAddr, 16)
        Set pmd_osr_mode = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_osr_mode)(aBaseAddr, 16)
        Set enc = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_enc)(aBaseAddr, 16)
        Set scr = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_scr)(aBaseAddr, 16)
        Set os_mode_cl36_2 = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_os_mode_cl36_2)(aBaseAddr, 16)
        Set pmd_osr_mode_2 = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_osr_mode_2)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_X1_CONTROL0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_X1_CONTROL0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_X1_CONTROL0_SGMIIPLUSR_X1.Add ((New TX_X1_CONTROL0_SGMIIPLUSR_X1_INSTANCE)(&H4aed2400))


