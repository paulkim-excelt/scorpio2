

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


'' @REGISTER : IO_mii1_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' clock_en_mii1                              [15:15]          get_clock_en_mii1
''                                                             set_clock_en_mii1
''                                                             read_clock_en_mii1
''                                                             write_clock_en_mii1
''---------------------------------------------------------------------------------
'' tx_pads_ind_mii1                           [14:14]          get_tx_pads_ind_mii1
''                                                             set_tx_pads_ind_mii1
''                                                             read_tx_pads_ind_mii1
''                                                             write_tx_pads_ind_mii1
''---------------------------------------------------------------------------------
'' txclk_pad_ind_mii1                         [13:13]          get_txclk_pad_ind_mii1
''                                                             set_txclk_pad_ind_mii1
''                                                             read_txclk_pad_ind_mii1
''                                                             write_txclk_pad_ind_mii1
''---------------------------------------------------------------------------------
'' src_mii1                                   [6:5]            get_src_mii1
''                                                             set_src_mii1
''                                                             read_src_mii1
''                                                             write_src_mii1
''---------------------------------------------------------------------------------
'' amp_enable_mii1                            [4:4]            get_amp_enable_mii1
''                                                             set_amp_enable_mii1
''                                                             read_amp_enable_mii1
''                                                             write_amp_enable_mii1
''---------------------------------------------------------------------------------
'' sel_mii1                                   [3:1]            get_sel_mii1
''                                                             set_sel_mii1
''                                                             read_sel_mii1
''                                                             write_sel_mii1
''---------------------------------------------------------------------------------
'' sel_gmii_mii1                              [0:0]            get_sel_gmii_mii1
''                                                             set_sel_gmii_mii1
''                                                             read_sel_gmii_mii1
''                                                             write_sel_gmii_mii1
''---------------------------------------------------------------------------------
Class REGISTER_IO_mii1_config
    Private write_clock_en_mii1_value
    Private read_clock_en_mii1_value
    Private flag_clock_en_mii1
    Private write_tx_pads_ind_mii1_value
    Private read_tx_pads_ind_mii1_value
    Private flag_tx_pads_ind_mii1
    Private write_txclk_pad_ind_mii1_value
    Private read_txclk_pad_ind_mii1_value
    Private flag_txclk_pad_ind_mii1
    Private write_src_mii1_value
    Private read_src_mii1_value
    Private flag_src_mii1
    Private write_amp_enable_mii1_value
    Private read_amp_enable_mii1_value
    Private flag_amp_enable_mii1
    Private write_sel_mii1_value
    Private read_sel_mii1_value
    Private flag_sel_mii1
    Private write_sel_gmii_mii1_value
    Private read_sel_gmii_mii1_value
    Private flag_sel_gmii_mii1

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

    Property Get get_clock_en_mii1
        get_clock_en_mii1 = read_clock_en_mii1_value
    End Property

    Property Let set_clock_en_mii1(aData)
        write_clock_en_mii1_value = aData
        flag_clock_en_mii1        = &H1
    End Property

    Property Get read_clock_en_mii1
        read
        read_clock_en_mii1 = read_clock_en_mii1_value
    End Property

    Property Let write_clock_en_mii1(aData)
        set_clock_en_mii1 = aData
        write
    End Property

    Property Get get_tx_pads_ind_mii1
        get_tx_pads_ind_mii1 = read_tx_pads_ind_mii1_value
    End Property

    Property Let set_tx_pads_ind_mii1(aData)
        write_tx_pads_ind_mii1_value = aData
        flag_tx_pads_ind_mii1        = &H1
    End Property

    Property Get read_tx_pads_ind_mii1
        read
        read_tx_pads_ind_mii1 = read_tx_pads_ind_mii1_value
    End Property

    Property Let write_tx_pads_ind_mii1(aData)
        set_tx_pads_ind_mii1 = aData
        write
    End Property

    Property Get get_txclk_pad_ind_mii1
        get_txclk_pad_ind_mii1 = read_txclk_pad_ind_mii1_value
    End Property

    Property Let set_txclk_pad_ind_mii1(aData)
        write_txclk_pad_ind_mii1_value = aData
        flag_txclk_pad_ind_mii1        = &H1
    End Property

    Property Get read_txclk_pad_ind_mii1
        read
        read_txclk_pad_ind_mii1 = read_txclk_pad_ind_mii1_value
    End Property

    Property Let write_txclk_pad_ind_mii1(aData)
        set_txclk_pad_ind_mii1 = aData
        write
    End Property

    Property Get get_src_mii1
        get_src_mii1 = read_src_mii1_value
    End Property

    Property Let set_src_mii1(aData)
        write_src_mii1_value = aData
        flag_src_mii1        = &H1
    End Property

    Property Get read_src_mii1
        read
        read_src_mii1 = read_src_mii1_value
    End Property

    Property Let write_src_mii1(aData)
        set_src_mii1 = aData
        write
    End Property

    Property Get get_amp_enable_mii1
        get_amp_enable_mii1 = read_amp_enable_mii1_value
    End Property

    Property Let set_amp_enable_mii1(aData)
        write_amp_enable_mii1_value = aData
        flag_amp_enable_mii1        = &H1
    End Property

    Property Get read_amp_enable_mii1
        read
        read_amp_enable_mii1 = read_amp_enable_mii1_value
    End Property

    Property Let write_amp_enable_mii1(aData)
        set_amp_enable_mii1 = aData
        write
    End Property

    Property Get get_sel_mii1
        get_sel_mii1 = read_sel_mii1_value
    End Property

    Property Let set_sel_mii1(aData)
        write_sel_mii1_value = aData
        flag_sel_mii1        = &H1
    End Property

    Property Get read_sel_mii1
        read
        read_sel_mii1 = read_sel_mii1_value
    End Property

    Property Let write_sel_mii1(aData)
        set_sel_mii1 = aData
        write
    End Property

    Property Get get_sel_gmii_mii1
        get_sel_gmii_mii1 = read_sel_gmii_mii1_value
    End Property

    Property Let set_sel_gmii_mii1(aData)
        write_sel_gmii_mii1_value = aData
        flag_sel_gmii_mii1        = &H1
    End Property

    Property Get read_sel_gmii_mii1
        read
        read_sel_gmii_mii1 = read_sel_gmii_mii1_value
    End Property

    Property Let write_sel_gmii_mii1(aData)
        set_sel_gmii_mii1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clock_en_mii1_value = rightShift(data_low, 15) and &H1
        read_tx_pads_ind_mii1_value = rightShift(data_low, 14) and &H1
        read_txclk_pad_ind_mii1_value = rightShift(data_low, 13) and &H1
        read_src_mii1_value = rightShift(data_low, 5) and &H3
        read_amp_enable_mii1_value = rightShift(data_low, 4) and &H1
        read_sel_mii1_value = rightShift(data_low, 1) and &H7
        sel_gmii_mii1_mask = &H1
        if data_low > LONG_MAX then
            if sel_gmii_mii1_mask = mask then
                read_sel_gmii_mii1_value = data_low
            else
                read_sel_gmii_mii1_value = (data_low - H8000_0000) and sel_gmii_mii1_mask
            end If
        else
            read_sel_gmii_mii1_value = data_low and sel_gmii_mii1_mask
        end If

    End Sub

    Sub write
        If flag_clock_en_mii1 = &H0 or flag_tx_pads_ind_mii1 = &H0 or flag_txclk_pad_ind_mii1 = &H0 or flag_src_mii1 = &H0 or flag_amp_enable_mii1 = &H0 or flag_sel_mii1 = &H0 or flag_sel_gmii_mii1 = &H0 Then read
        If flag_clock_en_mii1 = &H0 Then write_clock_en_mii1_value = get_clock_en_mii1
        If flag_tx_pads_ind_mii1 = &H0 Then write_tx_pads_ind_mii1_value = get_tx_pads_ind_mii1
        If flag_txclk_pad_ind_mii1 = &H0 Then write_txclk_pad_ind_mii1_value = get_txclk_pad_ind_mii1
        If flag_src_mii1 = &H0 Then write_src_mii1_value = get_src_mii1
        If flag_amp_enable_mii1 = &H0 Then write_amp_enable_mii1_value = get_amp_enable_mii1
        If flag_sel_mii1 = &H0 Then write_sel_mii1_value = get_sel_mii1
        If flag_sel_gmii_mii1 = &H0 Then write_sel_gmii_mii1_value = get_sel_gmii_mii1

        regValue = leftShift((write_clock_en_mii1_value and &H1), 15) + leftShift((write_tx_pads_ind_mii1_value and &H1), 14) + leftShift((write_txclk_pad_ind_mii1_value and &H1), 13) + leftShift((write_src_mii1_value and &H3), 5) + leftShift((write_amp_enable_mii1_value and &H1), 4) + leftShift((write_sel_mii1_value and &H7), 1) + leftShift((write_sel_gmii_mii1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clock_en_mii1_value = rightShift(data_low, 15) and &H1
        read_tx_pads_ind_mii1_value = rightShift(data_low, 14) and &H1
        read_txclk_pad_ind_mii1_value = rightShift(data_low, 13) and &H1
        read_src_mii1_value = rightShift(data_low, 5) and &H3
        read_amp_enable_mii1_value = rightShift(data_low, 4) and &H1
        read_sel_mii1_value = rightShift(data_low, 1) and &H7
        sel_gmii_mii1_mask = &H1
        if data_low > LONG_MAX then
            if sel_gmii_mii1_mask = mask then
                read_sel_gmii_mii1_value = data_low
            else
                read_sel_gmii_mii1_value = (data_low - H8000_0000) and sel_gmii_mii1_mask
            end If
        else
            read_sel_gmii_mii1_value = data_low and sel_gmii_mii1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_clock_en_mii1_value = &H0
        flag_clock_en_mii1        = &H0
        write_tx_pads_ind_mii1_value = &H0
        flag_tx_pads_ind_mii1        = &H0
        write_txclk_pad_ind_mii1_value = &H0
        flag_txclk_pad_ind_mii1        = &H0
        write_src_mii1_value = &H0
        flag_src_mii1        = &H0
        write_amp_enable_mii1_value = &H0
        flag_amp_enable_mii1        = &H0
        write_sel_mii1_value = &H0
        flag_sel_mii1        = &H0
        write_sel_gmii_mii1_value = &H0
        flag_sel_gmii_mii1        = &H0
    End Sub
End Class


'' @REGISTER : IO_mii2_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' clock_en_mii2                              [15:15]          get_clock_en_mii2
''                                                             set_clock_en_mii2
''                                                             read_clock_en_mii2
''                                                             write_clock_en_mii2
''---------------------------------------------------------------------------------
'' tx_pads_ind_mii2                           [14:14]          get_tx_pads_ind_mii2
''                                                             set_tx_pads_ind_mii2
''                                                             read_tx_pads_ind_mii2
''                                                             write_tx_pads_ind_mii2
''---------------------------------------------------------------------------------
'' txclk_pad_ind_mii2                         [13:13]          get_txclk_pad_ind_mii2
''                                                             set_txclk_pad_ind_mii2
''                                                             read_txclk_pad_ind_mii2
''                                                             write_txclk_pad_ind_mii2
''---------------------------------------------------------------------------------
'' src_mii2                                   [6:5]            get_src_mii2
''                                                             set_src_mii2
''                                                             read_src_mii2
''                                                             write_src_mii2
''---------------------------------------------------------------------------------
'' amp_enable_mii2                            [4:4]            get_amp_enable_mii2
''                                                             set_amp_enable_mii2
''                                                             read_amp_enable_mii2
''                                                             write_amp_enable_mii2
''---------------------------------------------------------------------------------
'' sel_mii2                                   [3:1]            get_sel_mii2
''                                                             set_sel_mii2
''                                                             read_sel_mii2
''                                                             write_sel_mii2
''---------------------------------------------------------------------------------
'' sel_gmii_mii2                              [0:0]            get_sel_gmii_mii2
''                                                             set_sel_gmii_mii2
''                                                             read_sel_gmii_mii2
''                                                             write_sel_gmii_mii2
''---------------------------------------------------------------------------------
Class REGISTER_IO_mii2_config
    Private write_clock_en_mii2_value
    Private read_clock_en_mii2_value
    Private flag_clock_en_mii2
    Private write_tx_pads_ind_mii2_value
    Private read_tx_pads_ind_mii2_value
    Private flag_tx_pads_ind_mii2
    Private write_txclk_pad_ind_mii2_value
    Private read_txclk_pad_ind_mii2_value
    Private flag_txclk_pad_ind_mii2
    Private write_src_mii2_value
    Private read_src_mii2_value
    Private flag_src_mii2
    Private write_amp_enable_mii2_value
    Private read_amp_enable_mii2_value
    Private flag_amp_enable_mii2
    Private write_sel_mii2_value
    Private read_sel_mii2_value
    Private flag_sel_mii2
    Private write_sel_gmii_mii2_value
    Private read_sel_gmii_mii2_value
    Private flag_sel_gmii_mii2

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

    Property Get get_clock_en_mii2
        get_clock_en_mii2 = read_clock_en_mii2_value
    End Property

    Property Let set_clock_en_mii2(aData)
        write_clock_en_mii2_value = aData
        flag_clock_en_mii2        = &H1
    End Property

    Property Get read_clock_en_mii2
        read
        read_clock_en_mii2 = read_clock_en_mii2_value
    End Property

    Property Let write_clock_en_mii2(aData)
        set_clock_en_mii2 = aData
        write
    End Property

    Property Get get_tx_pads_ind_mii2
        get_tx_pads_ind_mii2 = read_tx_pads_ind_mii2_value
    End Property

    Property Let set_tx_pads_ind_mii2(aData)
        write_tx_pads_ind_mii2_value = aData
        flag_tx_pads_ind_mii2        = &H1
    End Property

    Property Get read_tx_pads_ind_mii2
        read
        read_tx_pads_ind_mii2 = read_tx_pads_ind_mii2_value
    End Property

    Property Let write_tx_pads_ind_mii2(aData)
        set_tx_pads_ind_mii2 = aData
        write
    End Property

    Property Get get_txclk_pad_ind_mii2
        get_txclk_pad_ind_mii2 = read_txclk_pad_ind_mii2_value
    End Property

    Property Let set_txclk_pad_ind_mii2(aData)
        write_txclk_pad_ind_mii2_value = aData
        flag_txclk_pad_ind_mii2        = &H1
    End Property

    Property Get read_txclk_pad_ind_mii2
        read
        read_txclk_pad_ind_mii2 = read_txclk_pad_ind_mii2_value
    End Property

    Property Let write_txclk_pad_ind_mii2(aData)
        set_txclk_pad_ind_mii2 = aData
        write
    End Property

    Property Get get_src_mii2
        get_src_mii2 = read_src_mii2_value
    End Property

    Property Let set_src_mii2(aData)
        write_src_mii2_value = aData
        flag_src_mii2        = &H1
    End Property

    Property Get read_src_mii2
        read
        read_src_mii2 = read_src_mii2_value
    End Property

    Property Let write_src_mii2(aData)
        set_src_mii2 = aData
        write
    End Property

    Property Get get_amp_enable_mii2
        get_amp_enable_mii2 = read_amp_enable_mii2_value
    End Property

    Property Let set_amp_enable_mii2(aData)
        write_amp_enable_mii2_value = aData
        flag_amp_enable_mii2        = &H1
    End Property

    Property Get read_amp_enable_mii2
        read
        read_amp_enable_mii2 = read_amp_enable_mii2_value
    End Property

    Property Let write_amp_enable_mii2(aData)
        set_amp_enable_mii2 = aData
        write
    End Property

    Property Get get_sel_mii2
        get_sel_mii2 = read_sel_mii2_value
    End Property

    Property Let set_sel_mii2(aData)
        write_sel_mii2_value = aData
        flag_sel_mii2        = &H1
    End Property

    Property Get read_sel_mii2
        read
        read_sel_mii2 = read_sel_mii2_value
    End Property

    Property Let write_sel_mii2(aData)
        set_sel_mii2 = aData
        write
    End Property

    Property Get get_sel_gmii_mii2
        get_sel_gmii_mii2 = read_sel_gmii_mii2_value
    End Property

    Property Let set_sel_gmii_mii2(aData)
        write_sel_gmii_mii2_value = aData
        flag_sel_gmii_mii2        = &H1
    End Property

    Property Get read_sel_gmii_mii2
        read
        read_sel_gmii_mii2 = read_sel_gmii_mii2_value
    End Property

    Property Let write_sel_gmii_mii2(aData)
        set_sel_gmii_mii2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clock_en_mii2_value = rightShift(data_low, 15) and &H1
        read_tx_pads_ind_mii2_value = rightShift(data_low, 14) and &H1
        read_txclk_pad_ind_mii2_value = rightShift(data_low, 13) and &H1
        read_src_mii2_value = rightShift(data_low, 5) and &H3
        read_amp_enable_mii2_value = rightShift(data_low, 4) and &H1
        read_sel_mii2_value = rightShift(data_low, 1) and &H7
        sel_gmii_mii2_mask = &H1
        if data_low > LONG_MAX then
            if sel_gmii_mii2_mask = mask then
                read_sel_gmii_mii2_value = data_low
            else
                read_sel_gmii_mii2_value = (data_low - H8000_0000) and sel_gmii_mii2_mask
            end If
        else
            read_sel_gmii_mii2_value = data_low and sel_gmii_mii2_mask
        end If

    End Sub

    Sub write
        If flag_clock_en_mii2 = &H0 or flag_tx_pads_ind_mii2 = &H0 or flag_txclk_pad_ind_mii2 = &H0 or flag_src_mii2 = &H0 or flag_amp_enable_mii2 = &H0 or flag_sel_mii2 = &H0 or flag_sel_gmii_mii2 = &H0 Then read
        If flag_clock_en_mii2 = &H0 Then write_clock_en_mii2_value = get_clock_en_mii2
        If flag_tx_pads_ind_mii2 = &H0 Then write_tx_pads_ind_mii2_value = get_tx_pads_ind_mii2
        If flag_txclk_pad_ind_mii2 = &H0 Then write_txclk_pad_ind_mii2_value = get_txclk_pad_ind_mii2
        If flag_src_mii2 = &H0 Then write_src_mii2_value = get_src_mii2
        If flag_amp_enable_mii2 = &H0 Then write_amp_enable_mii2_value = get_amp_enable_mii2
        If flag_sel_mii2 = &H0 Then write_sel_mii2_value = get_sel_mii2
        If flag_sel_gmii_mii2 = &H0 Then write_sel_gmii_mii2_value = get_sel_gmii_mii2

        regValue = leftShift((write_clock_en_mii2_value and &H1), 15) + leftShift((write_tx_pads_ind_mii2_value and &H1), 14) + leftShift((write_txclk_pad_ind_mii2_value and &H1), 13) + leftShift((write_src_mii2_value and &H3), 5) + leftShift((write_amp_enable_mii2_value and &H1), 4) + leftShift((write_sel_mii2_value and &H7), 1) + leftShift((write_sel_gmii_mii2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clock_en_mii2_value = rightShift(data_low, 15) and &H1
        read_tx_pads_ind_mii2_value = rightShift(data_low, 14) and &H1
        read_txclk_pad_ind_mii2_value = rightShift(data_low, 13) and &H1
        read_src_mii2_value = rightShift(data_low, 5) and &H3
        read_amp_enable_mii2_value = rightShift(data_low, 4) and &H1
        read_sel_mii2_value = rightShift(data_low, 1) and &H7
        sel_gmii_mii2_mask = &H1
        if data_low > LONG_MAX then
            if sel_gmii_mii2_mask = mask then
                read_sel_gmii_mii2_value = data_low
            else
                read_sel_gmii_mii2_value = (data_low - H8000_0000) and sel_gmii_mii2_mask
            end If
        else
            read_sel_gmii_mii2_value = data_low and sel_gmii_mii2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_clock_en_mii2_value = &H0
        flag_clock_en_mii2        = &H0
        write_tx_pads_ind_mii2_value = &H0
        flag_tx_pads_ind_mii2        = &H0
        write_txclk_pad_ind_mii2_value = &H0
        flag_txclk_pad_ind_mii2        = &H0
        write_src_mii2_value = &H0
        flag_src_mii2        = &H0
        write_amp_enable_mii2_value = &H0
        flag_amp_enable_mii2        = &H0
        write_sel_mii2_value = &H0
        flag_sel_mii2        = &H0
        write_sel_gmii_mii2_value = &H0
        flag_sel_gmii_mii2        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_hysteresis
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' io_hys                                     [8:0]            get_io_hys
''                                                             set_io_hys
''                                                             read_io_hys
''                                                             write_io_hys
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_hysteresis
    Private write_io_hys_value
    Private read_io_hys_value
    Private flag_io_hys

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

    Property Get get_io_hys
        get_io_hys = read_io_hys_value
    End Property

    Property Let set_io_hys(aData)
        write_io_hys_value = aData
        flag_io_hys        = &H1
    End Property

    Property Get read_io_hys
        read
        read_io_hys = read_io_hys_value
    End Property

    Property Let write_io_hys(aData)
        set_io_hys = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        io_hys_mask = &H1ff
        if data_low > LONG_MAX then
            if io_hys_mask = mask then
                read_io_hys_value = data_low
            else
                read_io_hys_value = (data_low - H8000_0000) and io_hys_mask
            end If
        else
            read_io_hys_value = data_low and io_hys_mask
        end If

    End Sub

    Sub write
        If flag_io_hys = &H0 Then read
        If flag_io_hys = &H0 Then write_io_hys_value = get_io_hys

        regValue = leftShift((write_io_hys_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        io_hys_mask = &H1ff
        if data_low > LONG_MAX then
            if io_hys_mask = mask then
                read_io_hys_value = data_low
            else
                read_io_hys_value = (data_low - H8000_0000) and io_hys_mask
            end If
        else
            read_io_hys_value = data_low and io_hys_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_io_hys_value = &H0
        flag_io_hys        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_source
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' io_src                                     [8:0]            get_io_src
''                                                             set_io_src
''                                                             read_io_src
''                                                             write_io_src
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_source
    Private write_io_src_value
    Private read_io_src_value
    Private flag_io_src

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

    Property Get get_io_src
        get_io_src = read_io_src_value
    End Property

    Property Let set_io_src(aData)
        write_io_src_value = aData
        flag_io_src        = &H1
    End Property

    Property Get read_io_src
        read
        read_io_src = read_io_src_value
    End Property

    Property Let write_io_src(aData)
        set_io_src = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        io_src_mask = &H1ff
        if data_low > LONG_MAX then
            if io_src_mask = mask then
                read_io_src_value = data_low
            else
                read_io_src_value = (data_low - H8000_0000) and io_src_mask
            end If
        else
            read_io_src_value = data_low and io_src_mask
        end If

    End Sub

    Sub write
        If flag_io_src = &H0 Then read
        If flag_io_src = &H0 Then write_io_src_value = get_io_src

        regValue = leftShift((write_io_src_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        io_src_mask = &H1ff
        if data_low > LONG_MAX then
            if io_src_mask = mask then
                read_io_src_value = data_low
            else
                read_io_src_value = (data_low - H8000_0000) and io_src_mask
            end If
        else
            read_io_src_value = data_low and io_src_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_io_src_value = &H0
        flag_io_src        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_sel
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' io_sel_flash                               [14:12]          get_io_sel_flash
''                                                             set_io_sel_flash
''                                                             read_io_sel_flash
''                                                             write_io_sel_flash
''---------------------------------------------------------------------------------
'' io_sel_misc                                [11:9]           get_io_sel_misc
''                                                             set_io_sel_misc
''                                                             read_io_sel_misc
''                                                             write_io_sel_misc
''---------------------------------------------------------------------------------
'' io_sel_i2c                                 [8:6]            get_io_sel_i2c
''                                                             set_io_sel_i2c
''                                                             read_io_sel_i2c
''                                                             write_io_sel_i2c
''---------------------------------------------------------------------------------
'' io_sel_gpio                                [5:3]            get_io_sel_gpio
''                                                             set_io_sel_gpio
''                                                             read_io_sel_gpio
''                                                             write_io_sel_gpio
''---------------------------------------------------------------------------------
'' io_sel_spi_slv                             [2:0]            get_io_sel_spi_slv
''                                                             set_io_sel_spi_slv
''                                                             read_io_sel_spi_slv
''                                                             write_io_sel_spi_slv
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_sel
    Private write_io_sel_flash_value
    Private read_io_sel_flash_value
    Private flag_io_sel_flash
    Private write_io_sel_misc_value
    Private read_io_sel_misc_value
    Private flag_io_sel_misc
    Private write_io_sel_i2c_value
    Private read_io_sel_i2c_value
    Private flag_io_sel_i2c
    Private write_io_sel_gpio_value
    Private read_io_sel_gpio_value
    Private flag_io_sel_gpio
    Private write_io_sel_spi_slv_value
    Private read_io_sel_spi_slv_value
    Private flag_io_sel_spi_slv

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

    Property Get get_io_sel_flash
        get_io_sel_flash = read_io_sel_flash_value
    End Property

    Property Let set_io_sel_flash(aData)
        write_io_sel_flash_value = aData
        flag_io_sel_flash        = &H1
    End Property

    Property Get read_io_sel_flash
        read
        read_io_sel_flash = read_io_sel_flash_value
    End Property

    Property Let write_io_sel_flash(aData)
        set_io_sel_flash = aData
        write
    End Property

    Property Get get_io_sel_misc
        get_io_sel_misc = read_io_sel_misc_value
    End Property

    Property Let set_io_sel_misc(aData)
        write_io_sel_misc_value = aData
        flag_io_sel_misc        = &H1
    End Property

    Property Get read_io_sel_misc
        read
        read_io_sel_misc = read_io_sel_misc_value
    End Property

    Property Let write_io_sel_misc(aData)
        set_io_sel_misc = aData
        write
    End Property

    Property Get get_io_sel_i2c
        get_io_sel_i2c = read_io_sel_i2c_value
    End Property

    Property Let set_io_sel_i2c(aData)
        write_io_sel_i2c_value = aData
        flag_io_sel_i2c        = &H1
    End Property

    Property Get read_io_sel_i2c
        read
        read_io_sel_i2c = read_io_sel_i2c_value
    End Property

    Property Let write_io_sel_i2c(aData)
        set_io_sel_i2c = aData
        write
    End Property

    Property Get get_io_sel_gpio
        get_io_sel_gpio = read_io_sel_gpio_value
    End Property

    Property Let set_io_sel_gpio(aData)
        write_io_sel_gpio_value = aData
        flag_io_sel_gpio        = &H1
    End Property

    Property Get read_io_sel_gpio
        read
        read_io_sel_gpio = read_io_sel_gpio_value
    End Property

    Property Let write_io_sel_gpio(aData)
        set_io_sel_gpio = aData
        write
    End Property

    Property Get get_io_sel_spi_slv
        get_io_sel_spi_slv = read_io_sel_spi_slv_value
    End Property

    Property Let set_io_sel_spi_slv(aData)
        write_io_sel_spi_slv_value = aData
        flag_io_sel_spi_slv        = &H1
    End Property

    Property Get read_io_sel_spi_slv
        read
        read_io_sel_spi_slv = read_io_sel_spi_slv_value
    End Property

    Property Let write_io_sel_spi_slv(aData)
        set_io_sel_spi_slv = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_io_sel_flash_value = rightShift(data_low, 12) and &H7
        read_io_sel_misc_value = rightShift(data_low, 9) and &H7
        read_io_sel_i2c_value = rightShift(data_low, 6) and &H7
        read_io_sel_gpio_value = rightShift(data_low, 3) and &H7
        io_sel_spi_slv_mask = &H7
        if data_low > LONG_MAX then
            if io_sel_spi_slv_mask = mask then
                read_io_sel_spi_slv_value = data_low
            else
                read_io_sel_spi_slv_value = (data_low - H8000_0000) and io_sel_spi_slv_mask
            end If
        else
            read_io_sel_spi_slv_value = data_low and io_sel_spi_slv_mask
        end If

    End Sub

    Sub write
        If flag_io_sel_flash = &H0 or flag_io_sel_misc = &H0 or flag_io_sel_i2c = &H0 or flag_io_sel_gpio = &H0 or flag_io_sel_spi_slv = &H0 Then read
        If flag_io_sel_flash = &H0 Then write_io_sel_flash_value = get_io_sel_flash
        If flag_io_sel_misc = &H0 Then write_io_sel_misc_value = get_io_sel_misc
        If flag_io_sel_i2c = &H0 Then write_io_sel_i2c_value = get_io_sel_i2c
        If flag_io_sel_gpio = &H0 Then write_io_sel_gpio_value = get_io_sel_gpio
        If flag_io_sel_spi_slv = &H0 Then write_io_sel_spi_slv_value = get_io_sel_spi_slv

        regValue = leftShift((write_io_sel_flash_value and &H7), 12) + leftShift((write_io_sel_misc_value and &H7), 9) + leftShift((write_io_sel_i2c_value and &H7), 6) + leftShift((write_io_sel_gpio_value and &H7), 3) + leftShift((write_io_sel_spi_slv_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_io_sel_flash_value = rightShift(data_low, 12) and &H7
        read_io_sel_misc_value = rightShift(data_low, 9) and &H7
        read_io_sel_i2c_value = rightShift(data_low, 6) and &H7
        read_io_sel_gpio_value = rightShift(data_low, 3) and &H7
        io_sel_spi_slv_mask = &H7
        if data_low > LONG_MAX then
            if io_sel_spi_slv_mask = mask then
                read_io_sel_spi_slv_value = data_low
            else
                read_io_sel_spi_slv_value = (data_low - H8000_0000) and io_sel_spi_slv_mask
            end If
        else
            read_io_sel_spi_slv_value = data_low and io_sel_spi_slv_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_io_sel_flash_value = &H0
        flag_io_sel_flash        = &H0
        write_io_sel_misc_value = &H0
        flag_io_sel_misc        = &H0
        write_io_sel_i2c_value = &H0
        flag_io_sel_i2c        = &H0
        write_io_sel_gpio_value = &H0
        flag_io_sel_gpio        = &H0
        write_io_sel_spi_slv_value = &H0
        flag_io_sel_spi_slv        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_mii1_modehv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MII1_MODEHV                                [0:0]            get_MII1_MODEHV
''                                                             set_MII1_MODEHV
''                                                             read_MII1_MODEHV
''                                                             write_MII1_MODEHV
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_mii1_modehv
    Private write_MII1_MODEHV_value
    Private read_MII1_MODEHV_value
    Private flag_MII1_MODEHV

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

    Property Get get_MII1_MODEHV
        get_MII1_MODEHV = read_MII1_MODEHV_value
    End Property

    Property Let set_MII1_MODEHV(aData)
        write_MII1_MODEHV_value = aData
        flag_MII1_MODEHV        = &H1
    End Property

    Property Get read_MII1_MODEHV
        read
        read_MII1_MODEHV = read_MII1_MODEHV_value
    End Property

    Property Let write_MII1_MODEHV(aData)
        set_MII1_MODEHV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MII1_MODEHV_mask = &H1
        if data_low > LONG_MAX then
            if MII1_MODEHV_mask = mask then
                read_MII1_MODEHV_value = data_low
            else
                read_MII1_MODEHV_value = (data_low - H8000_0000) and MII1_MODEHV_mask
            end If
        else
            read_MII1_MODEHV_value = data_low and MII1_MODEHV_mask
        end If

    End Sub

    Sub write
        If flag_MII1_MODEHV = &H0 Then read
        If flag_MII1_MODEHV = &H0 Then write_MII1_MODEHV_value = get_MII1_MODEHV

        regValue = leftShift((write_MII1_MODEHV_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MII1_MODEHV_mask = &H1
        if data_low > LONG_MAX then
            if MII1_MODEHV_mask = mask then
                read_MII1_MODEHV_value = data_low
            else
                read_MII1_MODEHV_value = (data_low - H8000_0000) and MII1_MODEHV_mask
            end If
        else
            read_MII1_MODEHV_value = data_low and MII1_MODEHV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MII1_MODEHV_value = &H0
        flag_MII1_MODEHV        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_mii2_modehv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MII1_MODEHV                                [0:0]            get_MII1_MODEHV
''                                                             set_MII1_MODEHV
''                                                             read_MII1_MODEHV
''                                                             write_MII1_MODEHV
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_mii2_modehv
    Private write_MII1_MODEHV_value
    Private read_MII1_MODEHV_value
    Private flag_MII1_MODEHV

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

    Property Get get_MII1_MODEHV
        get_MII1_MODEHV = read_MII1_MODEHV_value
    End Property

    Property Let set_MII1_MODEHV(aData)
        write_MII1_MODEHV_value = aData
        flag_MII1_MODEHV        = &H1
    End Property

    Property Get read_MII1_MODEHV
        read
        read_MII1_MODEHV = read_MII1_MODEHV_value
    End Property

    Property Let write_MII1_MODEHV(aData)
        set_MII1_MODEHV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MII1_MODEHV_mask = &H1
        if data_low > LONG_MAX then
            if MII1_MODEHV_mask = mask then
                read_MII1_MODEHV_value = data_low
            else
                read_MII1_MODEHV_value = (data_low - H8000_0000) and MII1_MODEHV_mask
            end If
        else
            read_MII1_MODEHV_value = data_low and MII1_MODEHV_mask
        end If

    End Sub

    Sub write
        If flag_MII1_MODEHV = &H0 Then read
        If flag_MII1_MODEHV = &H0 Then write_MII1_MODEHV_value = get_MII1_MODEHV

        regValue = leftShift((write_MII1_MODEHV_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MII1_MODEHV_mask = &H1
        if data_low > LONG_MAX then
            if MII1_MODEHV_mask = mask then
                read_MII1_MODEHV_value = data_low
            else
                read_MII1_MODEHV_value = (data_low - H8000_0000) and MII1_MODEHV_mask
            end If
        else
            read_MII1_MODEHV_value = data_low and MII1_MODEHV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MII1_MODEHV_value = &H0
        flag_MII1_MODEHV        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_sel2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' io_sel_spi_slv                             [2:0]            get_io_sel_spi_slv
''                                                             set_io_sel_spi_slv
''                                                             read_io_sel_spi_slv
''                                                             write_io_sel_spi_slv
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_sel2
    Private write_io_sel_spi_slv_value
    Private read_io_sel_spi_slv_value
    Private flag_io_sel_spi_slv

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_io_sel_spi_slv
        get_io_sel_spi_slv = read_io_sel_spi_slv_value
    End Property

    Property Let set_io_sel_spi_slv(aData)
        write_io_sel_spi_slv_value = aData
        flag_io_sel_spi_slv        = &H1
    End Property

    Property Get read_io_sel_spi_slv
        read
        read_io_sel_spi_slv = read_io_sel_spi_slv_value
    End Property

    Property Let write_io_sel_spi_slv(aData)
        set_io_sel_spi_slv = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        io_sel_spi_slv_mask = &H7
        if data_low > LONG_MAX then
            if io_sel_spi_slv_mask = mask then
                read_io_sel_spi_slv_value = data_low
            else
                read_io_sel_spi_slv_value = (data_low - H8000_0000) and io_sel_spi_slv_mask
            end If
        else
            read_io_sel_spi_slv_value = data_low and io_sel_spi_slv_mask
        end If

    End Sub

    Sub write
        If flag_io_sel_spi_slv = &H0 Then read
        If flag_io_sel_spi_slv = &H0 Then write_io_sel_spi_slv_value = get_io_sel_spi_slv

        regValue = leftShift((write_io_sel_spi_slv_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        io_sel_spi_slv_mask = &H7
        if data_low > LONG_MAX then
            if io_sel_spi_slv_mask = mask then
                read_io_sel_spi_slv_value = data_low
            else
                read_io_sel_spi_slv_value = (data_low - H8000_0000) and io_sel_spi_slv_mask
            end If
        else
            read_io_sel_spi_slv_value = data_low and io_sel_spi_slv_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_io_sel_spi_slv_value = &H0
        flag_io_sel_spi_slv        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dis_imp                                    [15:15]          get_dis_imp
''                                                             set_dis_imp
''                                                             read_dis_imp
''                                                             write_dis_imp
''---------------------------------------------------------------------------------
'' rgmii_rx_characterization                  [5:5]            get_rgmii_rx_characterization
''                                                             set_rgmii_rx_characterization
''                                                             read_rgmii_rx_characterization
''                                                             write_rgmii_rx_characterization
''---------------------------------------------------------------------------------
'' rmii_clock_shortcut                        [4:4]            get_rmii_clock_shortcut
''                                                             set_rmii_clock_shortcut
''                                                             read_rmii_clock_shortcut
''                                                             write_rmii_clock_shortcut
''---------------------------------------------------------------------------------
'' rmii_clock_direction                       [3:3]            get_rmii_clock_direction
''                                                             set_rmii_clock_direction
''                                                             read_rmii_clock_direction
''                                                             write_rmii_clock_direction
''---------------------------------------------------------------------------------
'' rgmii1_ctl                                 [2:1]            get_rgmii1_ctl
''                                                             set_rgmii1_ctl
''                                                             read_rgmii1_ctl
''                                                             write_rgmii1_ctl
''---------------------------------------------------------------------------------
'' rgmii1_bypass_imp_2ns_del                  [0:0]            get_rgmii1_bypass_imp_2ns_del
''                                                             set_rgmii1_bypass_imp_2ns_del
''                                                             read_rgmii1_bypass_imp_2ns_del
''                                                             write_rgmii1_bypass_imp_2ns_del
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_ctl
    Private write_dis_imp_value
    Private read_dis_imp_value
    Private flag_dis_imp
    Private write_rgmii_rx_characterization_value
    Private read_rgmii_rx_characterization_value
    Private flag_rgmii_rx_characterization
    Private write_rmii_clock_shortcut_value
    Private read_rmii_clock_shortcut_value
    Private flag_rmii_clock_shortcut
    Private write_rmii_clock_direction_value
    Private read_rmii_clock_direction_value
    Private flag_rmii_clock_direction
    Private write_rgmii1_ctl_value
    Private read_rgmii1_ctl_value
    Private flag_rgmii1_ctl
    Private write_rgmii1_bypass_imp_2ns_del_value
    Private read_rgmii1_bypass_imp_2ns_del_value
    Private flag_rgmii1_bypass_imp_2ns_del

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

    Property Get get_dis_imp
        get_dis_imp = read_dis_imp_value
    End Property

    Property Let set_dis_imp(aData)
        write_dis_imp_value = aData
        flag_dis_imp        = &H1
    End Property

    Property Get read_dis_imp
        read
        read_dis_imp = read_dis_imp_value
    End Property

    Property Let write_dis_imp(aData)
        set_dis_imp = aData
        write
    End Property

    Property Get get_rgmii_rx_characterization
        get_rgmii_rx_characterization = read_rgmii_rx_characterization_value
    End Property

    Property Let set_rgmii_rx_characterization(aData)
        write_rgmii_rx_characterization_value = aData
        flag_rgmii_rx_characterization        = &H1
    End Property

    Property Get read_rgmii_rx_characterization
        read
        read_rgmii_rx_characterization = read_rgmii_rx_characterization_value
    End Property

    Property Let write_rgmii_rx_characterization(aData)
        set_rgmii_rx_characterization = aData
        write
    End Property

    Property Get get_rmii_clock_shortcut
        get_rmii_clock_shortcut = read_rmii_clock_shortcut_value
    End Property

    Property Let set_rmii_clock_shortcut(aData)
        write_rmii_clock_shortcut_value = aData
        flag_rmii_clock_shortcut        = &H1
    End Property

    Property Get read_rmii_clock_shortcut
        read
        read_rmii_clock_shortcut = read_rmii_clock_shortcut_value
    End Property

    Property Let write_rmii_clock_shortcut(aData)
        set_rmii_clock_shortcut = aData
        write
    End Property

    Property Get get_rmii_clock_direction
        get_rmii_clock_direction = read_rmii_clock_direction_value
    End Property

    Property Let set_rmii_clock_direction(aData)
        write_rmii_clock_direction_value = aData
        flag_rmii_clock_direction        = &H1
    End Property

    Property Get read_rmii_clock_direction
        read
        read_rmii_clock_direction = read_rmii_clock_direction_value
    End Property

    Property Let write_rmii_clock_direction(aData)
        set_rmii_clock_direction = aData
        write
    End Property

    Property Get get_rgmii1_ctl
        get_rgmii1_ctl = read_rgmii1_ctl_value
    End Property

    Property Let set_rgmii1_ctl(aData)
        write_rgmii1_ctl_value = aData
        flag_rgmii1_ctl        = &H1
    End Property

    Property Get read_rgmii1_ctl
        read
        read_rgmii1_ctl = read_rgmii1_ctl_value
    End Property

    Property Let write_rgmii1_ctl(aData)
        set_rgmii1_ctl = aData
        write
    End Property

    Property Get get_rgmii1_bypass_imp_2ns_del
        get_rgmii1_bypass_imp_2ns_del = read_rgmii1_bypass_imp_2ns_del_value
    End Property

    Property Let set_rgmii1_bypass_imp_2ns_del(aData)
        write_rgmii1_bypass_imp_2ns_del_value = aData
        flag_rgmii1_bypass_imp_2ns_del        = &H1
    End Property

    Property Get read_rgmii1_bypass_imp_2ns_del
        read
        read_rgmii1_bypass_imp_2ns_del = read_rgmii1_bypass_imp_2ns_del_value
    End Property

    Property Let write_rgmii1_bypass_imp_2ns_del(aData)
        set_rgmii1_bypass_imp_2ns_del = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_imp_value = rightShift(data_low, 15) and &H1
        read_rgmii_rx_characterization_value = rightShift(data_low, 5) and &H1
        read_rmii_clock_shortcut_value = rightShift(data_low, 4) and &H1
        read_rmii_clock_direction_value = rightShift(data_low, 3) and &H1
        read_rgmii1_ctl_value = rightShift(data_low, 1) and &H3
        rgmii1_bypass_imp_2ns_del_mask = &H1
        if data_low > LONG_MAX then
            if rgmii1_bypass_imp_2ns_del_mask = mask then
                read_rgmii1_bypass_imp_2ns_del_value = data_low
            else
                read_rgmii1_bypass_imp_2ns_del_value = (data_low - H8000_0000) and rgmii1_bypass_imp_2ns_del_mask
            end If
        else
            read_rgmii1_bypass_imp_2ns_del_value = data_low and rgmii1_bypass_imp_2ns_del_mask
        end If

    End Sub

    Sub write
        If flag_dis_imp = &H0 or flag_rgmii_rx_characterization = &H0 or flag_rmii_clock_shortcut = &H0 or flag_rmii_clock_direction = &H0 or flag_rgmii1_ctl = &H0 or flag_rgmii1_bypass_imp_2ns_del = &H0 Then read
        If flag_dis_imp = &H0 Then write_dis_imp_value = get_dis_imp
        If flag_rgmii_rx_characterization = &H0 Then write_rgmii_rx_characterization_value = get_rgmii_rx_characterization
        If flag_rmii_clock_shortcut = &H0 Then write_rmii_clock_shortcut_value = get_rmii_clock_shortcut
        If flag_rmii_clock_direction = &H0 Then write_rmii_clock_direction_value = get_rmii_clock_direction
        If flag_rgmii1_ctl = &H0 Then write_rgmii1_ctl_value = get_rgmii1_ctl
        If flag_rgmii1_bypass_imp_2ns_del = &H0 Then write_rgmii1_bypass_imp_2ns_del_value = get_rgmii1_bypass_imp_2ns_del

        regValue = leftShift((write_dis_imp_value and &H1), 15) + leftShift((write_rgmii_rx_characterization_value and &H1), 5) + leftShift((write_rmii_clock_shortcut_value and &H1), 4) + leftShift((write_rmii_clock_direction_value and &H1), 3) + leftShift((write_rgmii1_ctl_value and &H3), 1) + leftShift((write_rgmii1_bypass_imp_2ns_del_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_imp_value = rightShift(data_low, 15) and &H1
        read_rgmii_rx_characterization_value = rightShift(data_low, 5) and &H1
        read_rmii_clock_shortcut_value = rightShift(data_low, 4) and &H1
        read_rmii_clock_direction_value = rightShift(data_low, 3) and &H1
        read_rgmii1_ctl_value = rightShift(data_low, 1) and &H3
        rgmii1_bypass_imp_2ns_del_mask = &H1
        if data_low > LONG_MAX then
            if rgmii1_bypass_imp_2ns_del_mask = mask then
                read_rgmii1_bypass_imp_2ns_del_value = data_low
            else
                read_rgmii1_bypass_imp_2ns_del_value = (data_low - H8000_0000) and rgmii1_bypass_imp_2ns_del_mask
            end If
        else
            read_rgmii1_bypass_imp_2ns_del_value = data_low and rgmii1_bypass_imp_2ns_del_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dis_imp_value = &H0
        flag_dis_imp        = &H0
        write_rgmii_rx_characterization_value = &H0
        flag_rgmii_rx_characterization        = &H0
        write_rmii_clock_shortcut_value = &H0
        flag_rmii_clock_shortcut        = &H0
        write_rmii_clock_direction_value = &H0
        flag_rmii_clock_direction        = &H0
        write_rgmii1_ctl_value = &H0
        flag_rgmii1_ctl        = &H0
        write_rgmii1_bypass_imp_2ns_del_value = &H0
        flag_rgmii1_bypass_imp_2ns_del        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dis_imp                                    [15:15]          get_dis_imp
''                                                             set_dis_imp
''                                                             read_dis_imp
''                                                             write_dis_imp
''---------------------------------------------------------------------------------
'' rgmii_rx_characterization                  [5:5]            get_rgmii_rx_characterization
''                                                             set_rgmii_rx_characterization
''                                                             read_rgmii_rx_characterization
''                                                             write_rgmii_rx_characterization
''---------------------------------------------------------------------------------
'' rmii_clock_shortcut                        [4:4]            get_rmii_clock_shortcut
''                                                             set_rmii_clock_shortcut
''                                                             read_rmii_clock_shortcut
''                                                             write_rmii_clock_shortcut
''---------------------------------------------------------------------------------
'' rmii_clock_direction                       [3:3]            get_rmii_clock_direction
''                                                             set_rmii_clock_direction
''                                                             read_rmii_clock_direction
''                                                             write_rmii_clock_direction
''---------------------------------------------------------------------------------
'' rgmii2_ctl                                 [2:1]            get_rgmii2_ctl
''                                                             set_rgmii2_ctl
''                                                             read_rgmii2_ctl
''                                                             write_rgmii2_ctl
''---------------------------------------------------------------------------------
'' rgmii2_bypass_imp_2ns_del                  [0:0]            get_rgmii2_bypass_imp_2ns_del
''                                                             set_rgmii2_bypass_imp_2ns_del
''                                                             read_rgmii2_bypass_imp_2ns_del
''                                                             write_rgmii2_bypass_imp_2ns_del
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_ctl
    Private write_dis_imp_value
    Private read_dis_imp_value
    Private flag_dis_imp
    Private write_rgmii_rx_characterization_value
    Private read_rgmii_rx_characterization_value
    Private flag_rgmii_rx_characterization
    Private write_rmii_clock_shortcut_value
    Private read_rmii_clock_shortcut_value
    Private flag_rmii_clock_shortcut
    Private write_rmii_clock_direction_value
    Private read_rmii_clock_direction_value
    Private flag_rmii_clock_direction
    Private write_rgmii2_ctl_value
    Private read_rgmii2_ctl_value
    Private flag_rgmii2_ctl
    Private write_rgmii2_bypass_imp_2ns_del_value
    Private read_rgmii2_bypass_imp_2ns_del_value
    Private flag_rgmii2_bypass_imp_2ns_del

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dis_imp
        get_dis_imp = read_dis_imp_value
    End Property

    Property Let set_dis_imp(aData)
        write_dis_imp_value = aData
        flag_dis_imp        = &H1
    End Property

    Property Get read_dis_imp
        read
        read_dis_imp = read_dis_imp_value
    End Property

    Property Let write_dis_imp(aData)
        set_dis_imp = aData
        write
    End Property

    Property Get get_rgmii_rx_characterization
        get_rgmii_rx_characterization = read_rgmii_rx_characterization_value
    End Property

    Property Let set_rgmii_rx_characterization(aData)
        write_rgmii_rx_characterization_value = aData
        flag_rgmii_rx_characterization        = &H1
    End Property

    Property Get read_rgmii_rx_characterization
        read
        read_rgmii_rx_characterization = read_rgmii_rx_characterization_value
    End Property

    Property Let write_rgmii_rx_characterization(aData)
        set_rgmii_rx_characterization = aData
        write
    End Property

    Property Get get_rmii_clock_shortcut
        get_rmii_clock_shortcut = read_rmii_clock_shortcut_value
    End Property

    Property Let set_rmii_clock_shortcut(aData)
        write_rmii_clock_shortcut_value = aData
        flag_rmii_clock_shortcut        = &H1
    End Property

    Property Get read_rmii_clock_shortcut
        read
        read_rmii_clock_shortcut = read_rmii_clock_shortcut_value
    End Property

    Property Let write_rmii_clock_shortcut(aData)
        set_rmii_clock_shortcut = aData
        write
    End Property

    Property Get get_rmii_clock_direction
        get_rmii_clock_direction = read_rmii_clock_direction_value
    End Property

    Property Let set_rmii_clock_direction(aData)
        write_rmii_clock_direction_value = aData
        flag_rmii_clock_direction        = &H1
    End Property

    Property Get read_rmii_clock_direction
        read
        read_rmii_clock_direction = read_rmii_clock_direction_value
    End Property

    Property Let write_rmii_clock_direction(aData)
        set_rmii_clock_direction = aData
        write
    End Property

    Property Get get_rgmii2_ctl
        get_rgmii2_ctl = read_rgmii2_ctl_value
    End Property

    Property Let set_rgmii2_ctl(aData)
        write_rgmii2_ctl_value = aData
        flag_rgmii2_ctl        = &H1
    End Property

    Property Get read_rgmii2_ctl
        read
        read_rgmii2_ctl = read_rgmii2_ctl_value
    End Property

    Property Let write_rgmii2_ctl(aData)
        set_rgmii2_ctl = aData
        write
    End Property

    Property Get get_rgmii2_bypass_imp_2ns_del
        get_rgmii2_bypass_imp_2ns_del = read_rgmii2_bypass_imp_2ns_del_value
    End Property

    Property Let set_rgmii2_bypass_imp_2ns_del(aData)
        write_rgmii2_bypass_imp_2ns_del_value = aData
        flag_rgmii2_bypass_imp_2ns_del        = &H1
    End Property

    Property Get read_rgmii2_bypass_imp_2ns_del
        read
        read_rgmii2_bypass_imp_2ns_del = read_rgmii2_bypass_imp_2ns_del_value
    End Property

    Property Let write_rgmii2_bypass_imp_2ns_del(aData)
        set_rgmii2_bypass_imp_2ns_del = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_imp_value = rightShift(data_low, 15) and &H1
        read_rgmii_rx_characterization_value = rightShift(data_low, 5) and &H1
        read_rmii_clock_shortcut_value = rightShift(data_low, 4) and &H1
        read_rmii_clock_direction_value = rightShift(data_low, 3) and &H1
        read_rgmii2_ctl_value = rightShift(data_low, 1) and &H3
        rgmii2_bypass_imp_2ns_del_mask = &H1
        if data_low > LONG_MAX then
            if rgmii2_bypass_imp_2ns_del_mask = mask then
                read_rgmii2_bypass_imp_2ns_del_value = data_low
            else
                read_rgmii2_bypass_imp_2ns_del_value = (data_low - H8000_0000) and rgmii2_bypass_imp_2ns_del_mask
            end If
        else
            read_rgmii2_bypass_imp_2ns_del_value = data_low and rgmii2_bypass_imp_2ns_del_mask
        end If

    End Sub

    Sub write
        If flag_dis_imp = &H0 or flag_rgmii_rx_characterization = &H0 or flag_rmii_clock_shortcut = &H0 or flag_rmii_clock_direction = &H0 or flag_rgmii2_ctl = &H0 or flag_rgmii2_bypass_imp_2ns_del = &H0 Then read
        If flag_dis_imp = &H0 Then write_dis_imp_value = get_dis_imp
        If flag_rgmii_rx_characterization = &H0 Then write_rgmii_rx_characterization_value = get_rgmii_rx_characterization
        If flag_rmii_clock_shortcut = &H0 Then write_rmii_clock_shortcut_value = get_rmii_clock_shortcut
        If flag_rmii_clock_direction = &H0 Then write_rmii_clock_direction_value = get_rmii_clock_direction
        If flag_rgmii2_ctl = &H0 Then write_rgmii2_ctl_value = get_rgmii2_ctl
        If flag_rgmii2_bypass_imp_2ns_del = &H0 Then write_rgmii2_bypass_imp_2ns_del_value = get_rgmii2_bypass_imp_2ns_del

        regValue = leftShift((write_dis_imp_value and &H1), 15) + leftShift((write_rgmii_rx_characterization_value and &H1), 5) + leftShift((write_rmii_clock_shortcut_value and &H1), 4) + leftShift((write_rmii_clock_direction_value and &H1), 3) + leftShift((write_rgmii2_ctl_value and &H3), 1) + leftShift((write_rgmii2_bypass_imp_2ns_del_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_imp_value = rightShift(data_low, 15) and &H1
        read_rgmii_rx_characterization_value = rightShift(data_low, 5) and &H1
        read_rmii_clock_shortcut_value = rightShift(data_low, 4) and &H1
        read_rmii_clock_direction_value = rightShift(data_low, 3) and &H1
        read_rgmii2_ctl_value = rightShift(data_low, 1) and &H3
        rgmii2_bypass_imp_2ns_del_mask = &H1
        if data_low > LONG_MAX then
            if rgmii2_bypass_imp_2ns_del_mask = mask then
                read_rgmii2_bypass_imp_2ns_del_value = data_low
            else
                read_rgmii2_bypass_imp_2ns_del_value = (data_low - H8000_0000) and rgmii2_bypass_imp_2ns_del_mask
            end If
        else
            read_rgmii2_bypass_imp_2ns_del_value = data_low and rgmii2_bypass_imp_2ns_del_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dis_imp_value = &H0
        flag_dis_imp        = &H0
        write_rgmii_rx_characterization_value = &H0
        flag_rgmii_rx_characterization        = &H0
        write_rmii_clock_shortcut_value = &H0
        flag_rmii_clock_shortcut        = &H0
        write_rmii_clock_direction_value = &H0
        flag_rmii_clock_direction        = &H0
        write_rgmii2_ctl_value = &H0
        flag_rgmii2_ctl        = &H0
        write_rgmii2_bypass_imp_2ns_del_value = &H0
        flag_rgmii2_bypass_imp_2ns_del        = &H0
    End Sub
End Class


'' @REGISTER : IO_sgmii_rgmii_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sel_p5                                     [9:8]            get_sel_p5
''                                                             set_sel_p5
''                                                             read_sel_p5
''                                                             write_sel_p5
''---------------------------------------------------------------------------------
'' sel_p6p8_main                              [6:4]            get_sel_p6p8_main
''                                                             set_sel_p6p8_main
''                                                             read_sel_p6p8_main
''                                                             write_sel_p6p8_main
''---------------------------------------------------------------------------------
'' sel_p6p8_pcie                              [3:3]            get_sel_p6p8_pcie
''                                                             set_sel_p6p8_pcie
''                                                             read_sel_p6p8_pcie
''                                                             write_sel_p6p8_pcie
''---------------------------------------------------------------------------------
'' sel_p6p8_5gbr                              [2:2]            get_sel_p6p8_5gbr
''                                                             set_sel_p6p8_5gbr
''                                                             read_sel_p6p8_5gbr
''                                                             write_sel_p6p8_5gbr
''---------------------------------------------------------------------------------
'' sel_p3                                     [1:1]            get_sel_p3
''                                                             set_sel_p3
''                                                             read_sel_p3
''                                                             write_sel_p3
''---------------------------------------------------------------------------------
'' sel_p1                                     [0:0]            get_sel_p1
''                                                             set_sel_p1
''                                                             read_sel_p1
''                                                             write_sel_p1
''---------------------------------------------------------------------------------
Class REGISTER_IO_sgmii_rgmii_ctl
    Private write_sel_p5_value
    Private read_sel_p5_value
    Private flag_sel_p5
    Private write_sel_p6p8_main_value
    Private read_sel_p6p8_main_value
    Private flag_sel_p6p8_main
    Private write_sel_p6p8_pcie_value
    Private read_sel_p6p8_pcie_value
    Private flag_sel_p6p8_pcie
    Private write_sel_p6p8_5gbr_value
    Private read_sel_p6p8_5gbr_value
    Private flag_sel_p6p8_5gbr
    Private write_sel_p3_value
    Private read_sel_p3_value
    Private flag_sel_p3
    Private write_sel_p1_value
    Private read_sel_p1_value
    Private flag_sel_p1

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

    Property Get get_sel_p5
        get_sel_p5 = read_sel_p5_value
    End Property

    Property Let set_sel_p5(aData)
        write_sel_p5_value = aData
        flag_sel_p5        = &H1
    End Property

    Property Get read_sel_p5
        read
        read_sel_p5 = read_sel_p5_value
    End Property

    Property Let write_sel_p5(aData)
        set_sel_p5 = aData
        write
    End Property

    Property Get get_sel_p6p8_main
        get_sel_p6p8_main = read_sel_p6p8_main_value
    End Property

    Property Let set_sel_p6p8_main(aData)
        write_sel_p6p8_main_value = aData
        flag_sel_p6p8_main        = &H1
    End Property

    Property Get read_sel_p6p8_main
        read
        read_sel_p6p8_main = read_sel_p6p8_main_value
    End Property

    Property Let write_sel_p6p8_main(aData)
        set_sel_p6p8_main = aData
        write
    End Property

    Property Get get_sel_p6p8_pcie
        get_sel_p6p8_pcie = read_sel_p6p8_pcie_value
    End Property

    Property Let set_sel_p6p8_pcie(aData)
        write_sel_p6p8_pcie_value = aData
        flag_sel_p6p8_pcie        = &H1
    End Property

    Property Get read_sel_p6p8_pcie
        read
        read_sel_p6p8_pcie = read_sel_p6p8_pcie_value
    End Property

    Property Let write_sel_p6p8_pcie(aData)
        set_sel_p6p8_pcie = aData
        write
    End Property

    Property Get get_sel_p6p8_5gbr
        get_sel_p6p8_5gbr = read_sel_p6p8_5gbr_value
    End Property

    Property Let set_sel_p6p8_5gbr(aData)
        write_sel_p6p8_5gbr_value = aData
        flag_sel_p6p8_5gbr        = &H1
    End Property

    Property Get read_sel_p6p8_5gbr
        read
        read_sel_p6p8_5gbr = read_sel_p6p8_5gbr_value
    End Property

    Property Let write_sel_p6p8_5gbr(aData)
        set_sel_p6p8_5gbr = aData
        write
    End Property

    Property Get get_sel_p3
        get_sel_p3 = read_sel_p3_value
    End Property

    Property Let set_sel_p3(aData)
        write_sel_p3_value = aData
        flag_sel_p3        = &H1
    End Property

    Property Get read_sel_p3
        read
        read_sel_p3 = read_sel_p3_value
    End Property

    Property Let write_sel_p3(aData)
        set_sel_p3 = aData
        write
    End Property

    Property Get get_sel_p1
        get_sel_p1 = read_sel_p1_value
    End Property

    Property Let set_sel_p1(aData)
        write_sel_p1_value = aData
        flag_sel_p1        = &H1
    End Property

    Property Get read_sel_p1
        read
        read_sel_p1 = read_sel_p1_value
    End Property

    Property Let write_sel_p1(aData)
        set_sel_p1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sel_p5_value = rightShift(data_low, 8) and &H3
        read_sel_p6p8_main_value = rightShift(data_low, 4) and &H7
        read_sel_p6p8_pcie_value = rightShift(data_low, 3) and &H1
        read_sel_p6p8_5gbr_value = rightShift(data_low, 2) and &H1
        read_sel_p3_value = rightShift(data_low, 1) and &H1
        sel_p1_mask = &H1
        if data_low > LONG_MAX then
            if sel_p1_mask = mask then
                read_sel_p1_value = data_low
            else
                read_sel_p1_value = (data_low - H8000_0000) and sel_p1_mask
            end If
        else
            read_sel_p1_value = data_low and sel_p1_mask
        end If

    End Sub

    Sub write
        If flag_sel_p5 = &H0 or flag_sel_p6p8_main = &H0 or flag_sel_p6p8_pcie = &H0 or flag_sel_p6p8_5gbr = &H0 or flag_sel_p3 = &H0 or flag_sel_p1 = &H0 Then read
        If flag_sel_p5 = &H0 Then write_sel_p5_value = get_sel_p5
        If flag_sel_p6p8_main = &H0 Then write_sel_p6p8_main_value = get_sel_p6p8_main
        If flag_sel_p6p8_pcie = &H0 Then write_sel_p6p8_pcie_value = get_sel_p6p8_pcie
        If flag_sel_p6p8_5gbr = &H0 Then write_sel_p6p8_5gbr_value = get_sel_p6p8_5gbr
        If flag_sel_p3 = &H0 Then write_sel_p3_value = get_sel_p3
        If flag_sel_p1 = &H0 Then write_sel_p1_value = get_sel_p1

        regValue = leftShift((write_sel_p5_value and &H3), 8) + leftShift((write_sel_p6p8_main_value and &H7), 4) + leftShift((write_sel_p6p8_pcie_value and &H1), 3) + leftShift((write_sel_p6p8_5gbr_value and &H1), 2) + leftShift((write_sel_p3_value and &H1), 1) + leftShift((write_sel_p1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sel_p5_value = rightShift(data_low, 8) and &H3
        read_sel_p6p8_main_value = rightShift(data_low, 4) and &H7
        read_sel_p6p8_pcie_value = rightShift(data_low, 3) and &H1
        read_sel_p6p8_5gbr_value = rightShift(data_low, 2) and &H1
        read_sel_p3_value = rightShift(data_low, 1) and &H1
        sel_p1_mask = &H1
        if data_low > LONG_MAX then
            if sel_p1_mask = mask then
                read_sel_p1_value = data_low
            else
                read_sel_p1_value = (data_low - H8000_0000) and sel_p1_mask
            end If
        else
            read_sel_p1_value = data_low and sel_p1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sel_p5_value = &H0
        flag_sel_p5        = &H0
        write_sel_p6p8_main_value = &H0
        flag_sel_p6p8_main        = &H0
        write_sel_p6p8_pcie_value = &H0
        flag_sel_p6p8_pcie        = &H0
        write_sel_p6p8_5gbr_value = &H0
        flag_sel_p6p8_5gbr        = &H0
        write_sel_p3_value = &H0
        flag_sel_p3        = &H0
        write_sel_p1_value = &H0
        flag_sel_p1        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_gmii_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rgmii_rx_pause                             [4:4]            get_rgmii_rx_pause
''                                                             set_rgmii_rx_pause
''                                                             read_rgmii_rx_pause
''                                                             write_rgmii_rx_pause
''---------------------------------------------------------------------------------
'' rgmii_tx_pause                             [3:3]            get_rgmii_tx_pause
''                                                             set_rgmii_tx_pause
''                                                             read_rgmii_tx_pause
''                                                             write_rgmii_tx_pause
''---------------------------------------------------------------------------------
'' rgmii_link                                 [2:2]            get_rgmii_link
''                                                             set_rgmii_link
''                                                             read_rgmii_link
''                                                             write_rgmii_link
''---------------------------------------------------------------------------------
'' rgmii_spd                                  [1:0]            get_rgmii_spd
''                                                             set_rgmii_spd
''                                                             read_rgmii_spd
''                                                             write_rgmii_spd
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_gmii_ctl
    Private write_rgmii_rx_pause_value
    Private read_rgmii_rx_pause_value
    Private flag_rgmii_rx_pause
    Private write_rgmii_tx_pause_value
    Private read_rgmii_tx_pause_value
    Private flag_rgmii_tx_pause
    Private write_rgmii_link_value
    Private read_rgmii_link_value
    Private flag_rgmii_link
    Private write_rgmii_spd_value
    Private read_rgmii_spd_value
    Private flag_rgmii_spd

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rgmii_rx_pause
        get_rgmii_rx_pause = read_rgmii_rx_pause_value
    End Property

    Property Let set_rgmii_rx_pause(aData)
        write_rgmii_rx_pause_value = aData
        flag_rgmii_rx_pause        = &H1
    End Property

    Property Get read_rgmii_rx_pause
        read
        read_rgmii_rx_pause = read_rgmii_rx_pause_value
    End Property

    Property Let write_rgmii_rx_pause(aData)
        set_rgmii_rx_pause = aData
        write
    End Property

    Property Get get_rgmii_tx_pause
        get_rgmii_tx_pause = read_rgmii_tx_pause_value
    End Property

    Property Let set_rgmii_tx_pause(aData)
        write_rgmii_tx_pause_value = aData
        flag_rgmii_tx_pause        = &H1
    End Property

    Property Get read_rgmii_tx_pause
        read
        read_rgmii_tx_pause = read_rgmii_tx_pause_value
    End Property

    Property Let write_rgmii_tx_pause(aData)
        set_rgmii_tx_pause = aData
        write
    End Property

    Property Get get_rgmii_link
        get_rgmii_link = read_rgmii_link_value
    End Property

    Property Let set_rgmii_link(aData)
        write_rgmii_link_value = aData
        flag_rgmii_link        = &H1
    End Property

    Property Get read_rgmii_link
        read
        read_rgmii_link = read_rgmii_link_value
    End Property

    Property Let write_rgmii_link(aData)
        set_rgmii_link = aData
        write
    End Property

    Property Get get_rgmii_spd
        get_rgmii_spd = read_rgmii_spd_value
    End Property

    Property Let set_rgmii_spd(aData)
        write_rgmii_spd_value = aData
        flag_rgmii_spd        = &H1
    End Property

    Property Get read_rgmii_spd
        read
        read_rgmii_spd = read_rgmii_spd_value
    End Property

    Property Let write_rgmii_spd(aData)
        set_rgmii_spd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rgmii_rx_pause_value = rightShift(data_low, 4) and &H1
        read_rgmii_tx_pause_value = rightShift(data_low, 3) and &H1
        read_rgmii_link_value = rightShift(data_low, 2) and &H1
        rgmii_spd_mask = &H3
        if data_low > LONG_MAX then
            if rgmii_spd_mask = mask then
                read_rgmii_spd_value = data_low
            else
                read_rgmii_spd_value = (data_low - H8000_0000) and rgmii_spd_mask
            end If
        else
            read_rgmii_spd_value = data_low and rgmii_spd_mask
        end If

    End Sub

    Sub write
        If flag_rgmii_rx_pause = &H0 or flag_rgmii_tx_pause = &H0 or flag_rgmii_link = &H0 or flag_rgmii_spd = &H0 Then read
        If flag_rgmii_rx_pause = &H0 Then write_rgmii_rx_pause_value = get_rgmii_rx_pause
        If flag_rgmii_tx_pause = &H0 Then write_rgmii_tx_pause_value = get_rgmii_tx_pause
        If flag_rgmii_link = &H0 Then write_rgmii_link_value = get_rgmii_link
        If flag_rgmii_spd = &H0 Then write_rgmii_spd_value = get_rgmii_spd

        regValue = leftShift((write_rgmii_rx_pause_value and &H1), 4) + leftShift((write_rgmii_tx_pause_value and &H1), 3) + leftShift((write_rgmii_link_value and &H1), 2) + leftShift((write_rgmii_spd_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rgmii_rx_pause_value = rightShift(data_low, 4) and &H1
        read_rgmii_tx_pause_value = rightShift(data_low, 3) and &H1
        read_rgmii_link_value = rightShift(data_low, 2) and &H1
        rgmii_spd_mask = &H3
        if data_low > LONG_MAX then
            if rgmii_spd_mask = mask then
                read_rgmii_spd_value = data_low
            else
                read_rgmii_spd_value = (data_low - H8000_0000) and rgmii_spd_mask
            end If
        else
            read_rgmii_spd_value = data_low and rgmii_spd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rgmii_rx_pause_value = &H0
        flag_rgmii_rx_pause        = &H0
        write_rgmii_tx_pause_value = &H0
        flag_rgmii_tx_pause        = &H0
        write_rgmii_link_value = &H0
        flag_rgmii_link        = &H0
        write_rgmii_spd_value = &H0
        flag_rgmii_spd        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_gmii_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rgmii_rx_pause                             [4:4]            get_rgmii_rx_pause
''                                                             set_rgmii_rx_pause
''                                                             read_rgmii_rx_pause
''                                                             write_rgmii_rx_pause
''---------------------------------------------------------------------------------
'' rgmii_tx_pause                             [3:3]            get_rgmii_tx_pause
''                                                             set_rgmii_tx_pause
''                                                             read_rgmii_tx_pause
''                                                             write_rgmii_tx_pause
''---------------------------------------------------------------------------------
'' rgmii_link                                 [2:2]            get_rgmii_link
''                                                             set_rgmii_link
''                                                             read_rgmii_link
''                                                             write_rgmii_link
''---------------------------------------------------------------------------------
'' rgmii_spd                                  [1:0]            get_rgmii_spd
''                                                             set_rgmii_spd
''                                                             read_rgmii_spd
''                                                             write_rgmii_spd
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_gmii_ctl
    Private write_rgmii_rx_pause_value
    Private read_rgmii_rx_pause_value
    Private flag_rgmii_rx_pause
    Private write_rgmii_tx_pause_value
    Private read_rgmii_tx_pause_value
    Private flag_rgmii_tx_pause
    Private write_rgmii_link_value
    Private read_rgmii_link_value
    Private flag_rgmii_link
    Private write_rgmii_spd_value
    Private read_rgmii_spd_value
    Private flag_rgmii_spd

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

    Property Get get_rgmii_rx_pause
        get_rgmii_rx_pause = read_rgmii_rx_pause_value
    End Property

    Property Let set_rgmii_rx_pause(aData)
        write_rgmii_rx_pause_value = aData
        flag_rgmii_rx_pause        = &H1
    End Property

    Property Get read_rgmii_rx_pause
        read
        read_rgmii_rx_pause = read_rgmii_rx_pause_value
    End Property

    Property Let write_rgmii_rx_pause(aData)
        set_rgmii_rx_pause = aData
        write
    End Property

    Property Get get_rgmii_tx_pause
        get_rgmii_tx_pause = read_rgmii_tx_pause_value
    End Property

    Property Let set_rgmii_tx_pause(aData)
        write_rgmii_tx_pause_value = aData
        flag_rgmii_tx_pause        = &H1
    End Property

    Property Get read_rgmii_tx_pause
        read
        read_rgmii_tx_pause = read_rgmii_tx_pause_value
    End Property

    Property Let write_rgmii_tx_pause(aData)
        set_rgmii_tx_pause = aData
        write
    End Property

    Property Get get_rgmii_link
        get_rgmii_link = read_rgmii_link_value
    End Property

    Property Let set_rgmii_link(aData)
        write_rgmii_link_value = aData
        flag_rgmii_link        = &H1
    End Property

    Property Get read_rgmii_link
        read
        read_rgmii_link = read_rgmii_link_value
    End Property

    Property Let write_rgmii_link(aData)
        set_rgmii_link = aData
        write
    End Property

    Property Get get_rgmii_spd
        get_rgmii_spd = read_rgmii_spd_value
    End Property

    Property Let set_rgmii_spd(aData)
        write_rgmii_spd_value = aData
        flag_rgmii_spd        = &H1
    End Property

    Property Get read_rgmii_spd
        read
        read_rgmii_spd = read_rgmii_spd_value
    End Property

    Property Let write_rgmii_spd(aData)
        set_rgmii_spd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rgmii_rx_pause_value = rightShift(data_low, 4) and &H1
        read_rgmii_tx_pause_value = rightShift(data_low, 3) and &H1
        read_rgmii_link_value = rightShift(data_low, 2) and &H1
        rgmii_spd_mask = &H3
        if data_low > LONG_MAX then
            if rgmii_spd_mask = mask then
                read_rgmii_spd_value = data_low
            else
                read_rgmii_spd_value = (data_low - H8000_0000) and rgmii_spd_mask
            end If
        else
            read_rgmii_spd_value = data_low and rgmii_spd_mask
        end If

    End Sub

    Sub write
        If flag_rgmii_rx_pause = &H0 or flag_rgmii_tx_pause = &H0 or flag_rgmii_link = &H0 or flag_rgmii_spd = &H0 Then read
        If flag_rgmii_rx_pause = &H0 Then write_rgmii_rx_pause_value = get_rgmii_rx_pause
        If flag_rgmii_tx_pause = &H0 Then write_rgmii_tx_pause_value = get_rgmii_tx_pause
        If flag_rgmii_link = &H0 Then write_rgmii_link_value = get_rgmii_link
        If flag_rgmii_spd = &H0 Then write_rgmii_spd_value = get_rgmii_spd

        regValue = leftShift((write_rgmii_rx_pause_value and &H1), 4) + leftShift((write_rgmii_tx_pause_value and &H1), 3) + leftShift((write_rgmii_link_value and &H1), 2) + leftShift((write_rgmii_spd_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rgmii_rx_pause_value = rightShift(data_low, 4) and &H1
        read_rgmii_tx_pause_value = rightShift(data_low, 3) and &H1
        read_rgmii_link_value = rightShift(data_low, 2) and &H1
        rgmii_spd_mask = &H3
        if data_low > LONG_MAX then
            if rgmii_spd_mask = mask then
                read_rgmii_spd_value = data_low
            else
                read_rgmii_spd_value = (data_low - H8000_0000) and rgmii_spd_mask
            end If
        else
            read_rgmii_spd_value = data_low and rgmii_spd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rgmii_rx_pause_value = &H0
        flag_rgmii_rx_pause        = &H0
        write_rgmii_tx_pause_value = &H0
        flag_rgmii_tx_pause        = &H0
        write_rgmii_link_value = &H0
        flag_rgmii_link        = &H0
        write_rgmii_spd_value = &H0
        flag_rgmii_spd        = &H0
    End Sub
End Class


'' @REGISTER : IO_cpu_gmii_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' gmii3_lpbk_sel                             [11:11]          get_gmii3_lpbk_sel
''                                                             set_gmii3_lpbk_sel
''                                                             read_gmii3_lpbk_sel
''                                                             write_gmii3_lpbk_sel
''---------------------------------------------------------------------------------
'' gmii2_lpbk_sel                             [10:10]          get_gmii2_lpbk_sel
''                                                             set_gmii2_lpbk_sel
''                                                             read_gmii2_lpbk_sel
''                                                             write_gmii2_lpbk_sel
''---------------------------------------------------------------------------------
'' gmii1_lpbk_sel                             [9:9]            get_gmii1_lpbk_sel
''                                                             set_gmii1_lpbk_sel
''                                                             read_gmii1_lpbk_sel
''                                                             write_gmii1_lpbk_sel
''---------------------------------------------------------------------------------
'' cpu_lpbk_sel                               [8:8]            get_cpu_lpbk_sel
''                                                             set_cpu_lpbk_sel
''                                                             read_cpu_lpbk_sel
''                                                             write_cpu_lpbk_sel
''---------------------------------------------------------------------------------
'' cpu_rx_pause                               [4:4]            get_cpu_rx_pause
''                                                             set_cpu_rx_pause
''                                                             read_cpu_rx_pause
''                                                             write_cpu_rx_pause
''---------------------------------------------------------------------------------
'' cpu_tx_pause                               [3:3]            get_cpu_tx_pause
''                                                             set_cpu_tx_pause
''                                                             read_cpu_tx_pause
''                                                             write_cpu_tx_pause
''---------------------------------------------------------------------------------
'' cpu_link                                   [2:2]            get_cpu_link
''                                                             set_cpu_link
''                                                             read_cpu_link
''                                                             write_cpu_link
''---------------------------------------------------------------------------------
'' cpu_spd                                    [1:0]            get_cpu_spd
''                                                             set_cpu_spd
''                                                             read_cpu_spd
''                                                             write_cpu_spd
''---------------------------------------------------------------------------------
Class REGISTER_IO_cpu_gmii_ctl
    Private write_gmii3_lpbk_sel_value
    Private read_gmii3_lpbk_sel_value
    Private flag_gmii3_lpbk_sel
    Private write_gmii2_lpbk_sel_value
    Private read_gmii2_lpbk_sel_value
    Private flag_gmii2_lpbk_sel
    Private write_gmii1_lpbk_sel_value
    Private read_gmii1_lpbk_sel_value
    Private flag_gmii1_lpbk_sel
    Private write_cpu_lpbk_sel_value
    Private read_cpu_lpbk_sel_value
    Private flag_cpu_lpbk_sel
    Private write_cpu_rx_pause_value
    Private read_cpu_rx_pause_value
    Private flag_cpu_rx_pause
    Private write_cpu_tx_pause_value
    Private read_cpu_tx_pause_value
    Private flag_cpu_tx_pause
    Private write_cpu_link_value
    Private read_cpu_link_value
    Private flag_cpu_link
    Private write_cpu_spd_value
    Private read_cpu_spd_value
    Private flag_cpu_spd

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_gmii3_lpbk_sel
        get_gmii3_lpbk_sel = read_gmii3_lpbk_sel_value
    End Property

    Property Let set_gmii3_lpbk_sel(aData)
        write_gmii3_lpbk_sel_value = aData
        flag_gmii3_lpbk_sel        = &H1
    End Property

    Property Get read_gmii3_lpbk_sel
        read
        read_gmii3_lpbk_sel = read_gmii3_lpbk_sel_value
    End Property

    Property Let write_gmii3_lpbk_sel(aData)
        set_gmii3_lpbk_sel = aData
        write
    End Property

    Property Get get_gmii2_lpbk_sel
        get_gmii2_lpbk_sel = read_gmii2_lpbk_sel_value
    End Property

    Property Let set_gmii2_lpbk_sel(aData)
        write_gmii2_lpbk_sel_value = aData
        flag_gmii2_lpbk_sel        = &H1
    End Property

    Property Get read_gmii2_lpbk_sel
        read
        read_gmii2_lpbk_sel = read_gmii2_lpbk_sel_value
    End Property

    Property Let write_gmii2_lpbk_sel(aData)
        set_gmii2_lpbk_sel = aData
        write
    End Property

    Property Get get_gmii1_lpbk_sel
        get_gmii1_lpbk_sel = read_gmii1_lpbk_sel_value
    End Property

    Property Let set_gmii1_lpbk_sel(aData)
        write_gmii1_lpbk_sel_value = aData
        flag_gmii1_lpbk_sel        = &H1
    End Property

    Property Get read_gmii1_lpbk_sel
        read
        read_gmii1_lpbk_sel = read_gmii1_lpbk_sel_value
    End Property

    Property Let write_gmii1_lpbk_sel(aData)
        set_gmii1_lpbk_sel = aData
        write
    End Property

    Property Get get_cpu_lpbk_sel
        get_cpu_lpbk_sel = read_cpu_lpbk_sel_value
    End Property

    Property Let set_cpu_lpbk_sel(aData)
        write_cpu_lpbk_sel_value = aData
        flag_cpu_lpbk_sel        = &H1
    End Property

    Property Get read_cpu_lpbk_sel
        read
        read_cpu_lpbk_sel = read_cpu_lpbk_sel_value
    End Property

    Property Let write_cpu_lpbk_sel(aData)
        set_cpu_lpbk_sel = aData
        write
    End Property

    Property Get get_cpu_rx_pause
        get_cpu_rx_pause = read_cpu_rx_pause_value
    End Property

    Property Let set_cpu_rx_pause(aData)
        write_cpu_rx_pause_value = aData
        flag_cpu_rx_pause        = &H1
    End Property

    Property Get read_cpu_rx_pause
        read
        read_cpu_rx_pause = read_cpu_rx_pause_value
    End Property

    Property Let write_cpu_rx_pause(aData)
        set_cpu_rx_pause = aData
        write
    End Property

    Property Get get_cpu_tx_pause
        get_cpu_tx_pause = read_cpu_tx_pause_value
    End Property

    Property Let set_cpu_tx_pause(aData)
        write_cpu_tx_pause_value = aData
        flag_cpu_tx_pause        = &H1
    End Property

    Property Get read_cpu_tx_pause
        read
        read_cpu_tx_pause = read_cpu_tx_pause_value
    End Property

    Property Let write_cpu_tx_pause(aData)
        set_cpu_tx_pause = aData
        write
    End Property

    Property Get get_cpu_link
        get_cpu_link = read_cpu_link_value
    End Property

    Property Let set_cpu_link(aData)
        write_cpu_link_value = aData
        flag_cpu_link        = &H1
    End Property

    Property Get read_cpu_link
        read
        read_cpu_link = read_cpu_link_value
    End Property

    Property Let write_cpu_link(aData)
        set_cpu_link = aData
        write
    End Property

    Property Get get_cpu_spd
        get_cpu_spd = read_cpu_spd_value
    End Property

    Property Let set_cpu_spd(aData)
        write_cpu_spd_value = aData
        flag_cpu_spd        = &H1
    End Property

    Property Get read_cpu_spd
        read
        read_cpu_spd = read_cpu_spd_value
    End Property

    Property Let write_cpu_spd(aData)
        set_cpu_spd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_gmii3_lpbk_sel_value = rightShift(data_low, 11) and &H1
        read_gmii2_lpbk_sel_value = rightShift(data_low, 10) and &H1
        read_gmii1_lpbk_sel_value = rightShift(data_low, 9) and &H1
        read_cpu_lpbk_sel_value = rightShift(data_low, 8) and &H1
        read_cpu_rx_pause_value = rightShift(data_low, 4) and &H1
        read_cpu_tx_pause_value = rightShift(data_low, 3) and &H1
        read_cpu_link_value = rightShift(data_low, 2) and &H1
        cpu_spd_mask = &H3
        if data_low > LONG_MAX then
            if cpu_spd_mask = mask then
                read_cpu_spd_value = data_low
            else
                read_cpu_spd_value = (data_low - H8000_0000) and cpu_spd_mask
            end If
        else
            read_cpu_spd_value = data_low and cpu_spd_mask
        end If

    End Sub

    Sub write
        If flag_gmii3_lpbk_sel = &H0 or flag_gmii2_lpbk_sel = &H0 or flag_gmii1_lpbk_sel = &H0 or flag_cpu_lpbk_sel = &H0 or flag_cpu_rx_pause = &H0 or flag_cpu_tx_pause = &H0 or flag_cpu_link = &H0 or flag_cpu_spd = &H0 Then read
        If flag_gmii3_lpbk_sel = &H0 Then write_gmii3_lpbk_sel_value = get_gmii3_lpbk_sel
        If flag_gmii2_lpbk_sel = &H0 Then write_gmii2_lpbk_sel_value = get_gmii2_lpbk_sel
        If flag_gmii1_lpbk_sel = &H0 Then write_gmii1_lpbk_sel_value = get_gmii1_lpbk_sel
        If flag_cpu_lpbk_sel = &H0 Then write_cpu_lpbk_sel_value = get_cpu_lpbk_sel
        If flag_cpu_rx_pause = &H0 Then write_cpu_rx_pause_value = get_cpu_rx_pause
        If flag_cpu_tx_pause = &H0 Then write_cpu_tx_pause_value = get_cpu_tx_pause
        If flag_cpu_link = &H0 Then write_cpu_link_value = get_cpu_link
        If flag_cpu_spd = &H0 Then write_cpu_spd_value = get_cpu_spd

        regValue = leftShift((write_gmii3_lpbk_sel_value and &H1), 11) + leftShift((write_gmii2_lpbk_sel_value and &H1), 10) + leftShift((write_gmii1_lpbk_sel_value and &H1), 9) + leftShift((write_cpu_lpbk_sel_value and &H1), 8) + leftShift((write_cpu_rx_pause_value and &H1), 4) + leftShift((write_cpu_tx_pause_value and &H1), 3) + leftShift((write_cpu_link_value and &H1), 2) + leftShift((write_cpu_spd_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_gmii3_lpbk_sel_value = rightShift(data_low, 11) and &H1
        read_gmii2_lpbk_sel_value = rightShift(data_low, 10) and &H1
        read_gmii1_lpbk_sel_value = rightShift(data_low, 9) and &H1
        read_cpu_lpbk_sel_value = rightShift(data_low, 8) and &H1
        read_cpu_rx_pause_value = rightShift(data_low, 4) and &H1
        read_cpu_tx_pause_value = rightShift(data_low, 3) and &H1
        read_cpu_link_value = rightShift(data_low, 2) and &H1
        cpu_spd_mask = &H3
        if data_low > LONG_MAX then
            if cpu_spd_mask = mask then
                read_cpu_spd_value = data_low
            else
                read_cpu_spd_value = (data_low - H8000_0000) and cpu_spd_mask
            end If
        else
            read_cpu_spd_value = data_low and cpu_spd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_gmii3_lpbk_sel_value = &H0
        flag_gmii3_lpbk_sel        = &H0
        write_gmii2_lpbk_sel_value = &H0
        flag_gmii2_lpbk_sel        = &H0
        write_gmii1_lpbk_sel_value = &H0
        flag_gmii1_lpbk_sel        = &H0
        write_cpu_lpbk_sel_value = &H0
        flag_cpu_lpbk_sel        = &H0
        write_cpu_rx_pause_value = &H0
        flag_cpu_rx_pause        = &H0
        write_cpu_tx_pause_value = &H0
        flag_cpu_tx_pause        = &H0
        write_cpu_link_value = &H0
        flag_cpu_link        = &H0
        write_cpu_spd_value = &H0
        flag_cpu_spd        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_rx_char_pattern_exp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pattern_exp                                [9:0]            get_pattern_exp
''                                                             set_pattern_exp
''                                                             read_pattern_exp
''                                                             write_pattern_exp
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_rx_char_pattern_exp
    Private write_pattern_exp_value
    Private read_pattern_exp_value
    Private flag_pattern_exp

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

    Property Get get_pattern_exp
        get_pattern_exp = read_pattern_exp_value
    End Property

    Property Let set_pattern_exp(aData)
        write_pattern_exp_value = aData
        flag_pattern_exp        = &H1
    End Property

    Property Get read_pattern_exp
        read
        read_pattern_exp = read_pattern_exp_value
    End Property

    Property Let write_pattern_exp(aData)
        set_pattern_exp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_exp_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_exp_mask = mask then
                read_pattern_exp_value = data_low
            else
                read_pattern_exp_value = (data_low - H8000_0000) and pattern_exp_mask
            end If
        else
            read_pattern_exp_value = data_low and pattern_exp_mask
        end If

    End Sub

    Sub write
        If flag_pattern_exp = &H0 Then read
        If flag_pattern_exp = &H0 Then write_pattern_exp_value = get_pattern_exp

        regValue = leftShift((write_pattern_exp_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_exp_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_exp_mask = mask then
                read_pattern_exp_value = data_low
            else
                read_pattern_exp_value = (data_low - H8000_0000) and pattern_exp_mask
            end If
        else
            read_pattern_exp_value = data_low and pattern_exp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pattern_exp_value = &H0
        flag_pattern_exp        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_rx_char_pattern_got
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pattern_got                                [9:0]            get_pattern_got
''                                                             set_pattern_got
''                                                             read_pattern_got
''                                                             write_pattern_got
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_rx_char_pattern_got
    Private write_pattern_got_value
    Private read_pattern_got_value
    Private flag_pattern_got

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pattern_got
        get_pattern_got = read_pattern_got_value
    End Property

    Property Let set_pattern_got(aData)
        write_pattern_got_value = aData
        flag_pattern_got        = &H1
    End Property

    Property Get read_pattern_got
        read
        read_pattern_got = read_pattern_got_value
    End Property

    Property Let write_pattern_got(aData)
        set_pattern_got = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_got_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_got_mask = mask then
                read_pattern_got_value = data_low
            else
                read_pattern_got_value = (data_low - H8000_0000) and pattern_got_mask
            end If
        else
            read_pattern_got_value = data_low and pattern_got_mask
        end If

    End Sub

    Sub write
        If flag_pattern_got = &H0 Then read
        If flag_pattern_got = &H0 Then write_pattern_got_value = get_pattern_got

        regValue = leftShift((write_pattern_got_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_got_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_got_mask = mask then
                read_pattern_got_value = data_low
            else
                read_pattern_got_value = (data_low - H8000_0000) and pattern_got_mask
            end If
        else
            read_pattern_got_value = data_low and pattern_got_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pattern_got_value = &H0
        flag_pattern_got        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_rx_char_pattern_exp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pattern_exp                                [9:0]            get_pattern_exp
''                                                             set_pattern_exp
''                                                             read_pattern_exp
''                                                             write_pattern_exp
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_rx_char_pattern_exp
    Private write_pattern_exp_value
    Private read_pattern_exp_value
    Private flag_pattern_exp

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

    Property Get get_pattern_exp
        get_pattern_exp = read_pattern_exp_value
    End Property

    Property Let set_pattern_exp(aData)
        write_pattern_exp_value = aData
        flag_pattern_exp        = &H1
    End Property

    Property Get read_pattern_exp
        read
        read_pattern_exp = read_pattern_exp_value
    End Property

    Property Let write_pattern_exp(aData)
        set_pattern_exp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_exp_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_exp_mask = mask then
                read_pattern_exp_value = data_low
            else
                read_pattern_exp_value = (data_low - H8000_0000) and pattern_exp_mask
            end If
        else
            read_pattern_exp_value = data_low and pattern_exp_mask
        end If

    End Sub

    Sub write
        If flag_pattern_exp = &H0 Then read
        If flag_pattern_exp = &H0 Then write_pattern_exp_value = get_pattern_exp

        regValue = leftShift((write_pattern_exp_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_exp_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_exp_mask = mask then
                read_pattern_exp_value = data_low
            else
                read_pattern_exp_value = (data_low - H8000_0000) and pattern_exp_mask
            end If
        else
            read_pattern_exp_value = data_low and pattern_exp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pattern_exp_value = &H0
        flag_pattern_exp        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_rx_char_pattern_got
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pattern_got                                [9:0]            get_pattern_got
''                                                             set_pattern_got
''                                                             read_pattern_got
''                                                             write_pattern_got
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_rx_char_pattern_got
    Private write_pattern_got_value
    Private read_pattern_got_value
    Private flag_pattern_got

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pattern_got
        get_pattern_got = read_pattern_got_value
    End Property

    Property Let set_pattern_got(aData)
        write_pattern_got_value = aData
        flag_pattern_got        = &H1
    End Property

    Property Get read_pattern_got
        read
        read_pattern_got = read_pattern_got_value
    End Property

    Property Let write_pattern_got(aData)
        set_pattern_got = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_got_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_got_mask = mask then
                read_pattern_got_value = data_low
            else
                read_pattern_got_value = (data_low - H8000_0000) and pattern_got_mask
            end If
        else
            read_pattern_got_value = data_low and pattern_got_mask
        end If

    End Sub

    Sub write
        If flag_pattern_got = &H0 Then read
        If flag_pattern_got = &H0 Then write_pattern_got_value = get_pattern_got

        regValue = leftShift((write_pattern_got_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_got_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_got_mask = mask then
                read_pattern_got_value = data_low
            else
                read_pattern_got_value = (data_low - H8000_0000) and pattern_got_mask
            end If
        else
            read_pattern_got_value = data_low and pattern_got_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pattern_got_value = &H0
        flag_pattern_got        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_rx_char_pattern_exp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pattern_exp                                [9:0]            get_pattern_exp
''                                                             set_pattern_exp
''                                                             read_pattern_exp
''                                                             write_pattern_exp
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_rx_char_pattern_exp
    Private write_pattern_exp_value
    Private read_pattern_exp_value
    Private flag_pattern_exp

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

    Property Get get_pattern_exp
        get_pattern_exp = read_pattern_exp_value
    End Property

    Property Let set_pattern_exp(aData)
        write_pattern_exp_value = aData
        flag_pattern_exp        = &H1
    End Property

    Property Get read_pattern_exp
        read
        read_pattern_exp = read_pattern_exp_value
    End Property

    Property Let write_pattern_exp(aData)
        set_pattern_exp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_exp_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_exp_mask = mask then
                read_pattern_exp_value = data_low
            else
                read_pattern_exp_value = (data_low - H8000_0000) and pattern_exp_mask
            end If
        else
            read_pattern_exp_value = data_low and pattern_exp_mask
        end If

    End Sub

    Sub write
        If flag_pattern_exp = &H0 Then read
        If flag_pattern_exp = &H0 Then write_pattern_exp_value = get_pattern_exp

        regValue = leftShift((write_pattern_exp_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_exp_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_exp_mask = mask then
                read_pattern_exp_value = data_low
            else
                read_pattern_exp_value = (data_low - H8000_0000) and pattern_exp_mask
            end If
        else
            read_pattern_exp_value = data_low and pattern_exp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pattern_exp_value = &H0
        flag_pattern_exp        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_rx_char_pattern_got
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pattern_got                                [9:0]            get_pattern_got
''                                                             set_pattern_got
''                                                             read_pattern_got
''                                                             write_pattern_got
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_rx_char_pattern_got
    Private write_pattern_got_value
    Private read_pattern_got_value
    Private flag_pattern_got

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pattern_got
        get_pattern_got = read_pattern_got_value
    End Property

    Property Let set_pattern_got(aData)
        write_pattern_got_value = aData
        flag_pattern_got        = &H1
    End Property

    Property Get read_pattern_got
        read
        read_pattern_got = read_pattern_got_value
    End Property

    Property Let write_pattern_got(aData)
        set_pattern_got = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_got_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_got_mask = mask then
                read_pattern_got_value = data_low
            else
                read_pattern_got_value = (data_low - H8000_0000) and pattern_got_mask
            end If
        else
            read_pattern_got_value = data_low and pattern_got_mask
        end If

    End Sub

    Sub write
        If flag_pattern_got = &H0 Then read
        If flag_pattern_got = &H0 Then write_pattern_got_value = get_pattern_got

        regValue = leftShift((write_pattern_got_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pattern_got_mask = &H3ff
        if data_low > LONG_MAX then
            if pattern_got_mask = mask then
                read_pattern_got_value = data_low
            else
                read_pattern_got_value = (data_low - H8000_0000) and pattern_got_mask
            end If
        else
            read_pattern_got_value = data_low and pattern_got_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pattern_got_value = &H0
        flag_pattern_got        = &H0
    End Sub
End Class


'' @REGISTER : IO_straps_raw
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SFT_DEBUG_MODE_B                           [15:15]          get_SFT_DEBUG_MODE_B
''                                                             set_SFT_DEBUG_MODE_B
''                                                             read_SFT_DEBUG_MODE_B
''                                                             write_SFT_DEBUG_MODE_B
''---------------------------------------------------------------------------------
'' TC10_GO2STNDBY                             [14:14]          get_TC10_GO2STNDBY
''                                                             set_TC10_GO2STNDBY
''                                                             read_TC10_GO2STNDBY
''                                                             write_TC10_GO2STNDBY
''---------------------------------------------------------------------------------
'' TC10_DISABLE                               [13:13]          get_TC10_DISABLE
''                                                             set_TC10_DISABLE
''                                                             read_TC10_DISABLE
''                                                             write_TC10_DISABLE
''---------------------------------------------------------------------------------
'' PHYADDR4                                   [12:12]          get_PHYADDR4
''                                                             set_PHYADDR4
''                                                             read_PHYADDR4
''                                                             write_PHYADDR4
''---------------------------------------------------------------------------------
'' PHYADDR3                                   [11:11]          get_PHYADDR3
''                                                             set_PHYADDR3
''                                                             read_PHYADDR3
''                                                             write_PHYADDR3
''---------------------------------------------------------------------------------
'' MII2_MODE_2                                [10:10]          get_MII2_MODE_2
''                                                             set_MII2_MODE_2
''                                                             read_MII2_MODE_2
''                                                             write_MII2_MODE_2
''---------------------------------------------------------------------------------
'' MII1_MODE_2                                [9:9]            get_MII1_MODE_2
''                                                             set_MII1_MODE_2
''                                                             read_MII1_MODE_2
''                                                             write_MII1_MODE_2
''---------------------------------------------------------------------------------
'' HW_FWDG_EN                                 [8:8]            get_HW_FWDG_EN
''                                                             set_HW_FWDG_EN
''                                                             read_HW_FWDG_EN
''                                                             write_HW_FWDG_EN
''---------------------------------------------------------------------------------
'' MII2_MODE_1                                [7:7]            get_MII2_MODE_1
''                                                             set_MII2_MODE_1
''                                                             read_MII2_MODE_1
''                                                             write_MII2_MODE_1
''---------------------------------------------------------------------------------
'' MII2_MODE_0                                [6:6]            get_MII2_MODE_0
''                                                             set_MII2_MODE_0
''                                                             read_MII2_MODE_0
''                                                             write_MII2_MODE_0
''---------------------------------------------------------------------------------
'' MII1_MODE_1                                [5:5]            get_MII1_MODE_1
''                                                             set_MII1_MODE_1
''                                                             read_MII1_MODE_1
''                                                             write_MII1_MODE_1
''---------------------------------------------------------------------------------
'' MII1_MODE_0                                [4:4]            get_MII1_MODE_0
''                                                             set_MII1_MODE_0
''                                                             read_MII1_MODE_0
''                                                             write_MII1_MODE_0
''---------------------------------------------------------------------------------
'' SUPER_ISOLATE_STRAP                        [3:3]            get_SUPER_ISOLATE_STRAP
''                                                             set_SUPER_ISOLATE_STRAP
''                                                             read_SUPER_ISOLATE_STRAP
''                                                             write_SUPER_ISOLATE_STRAP
''---------------------------------------------------------------------------------
'' SFT_FORCE_DWNLD_STRAP                      [2:2]            get_SFT_FORCE_DWNLD_STRAP
''                                                             set_SFT_FORCE_DWNLD_STRAP
''                                                             read_SFT_FORCE_DWNLD_STRAP
''                                                             write_SFT_FORCE_DWNLD_STRAP
''---------------------------------------------------------------------------------
'' BRPHY_MS_STRAP                             [1:1]            get_BRPHY_MS_STRAP
''                                                             set_BRPHY_MS_STRAP
''                                                             read_BRPHY_MS_STRAP
''                                                             write_BRPHY_MS_STRAP
''---------------------------------------------------------------------------------
'' STRAP_EN_EXTCLKB                           [0:0]            get_STRAP_EN_EXTCLKB
''                                                             set_STRAP_EN_EXTCLKB
''                                                             read_STRAP_EN_EXTCLKB
''                                                             write_STRAP_EN_EXTCLKB
''---------------------------------------------------------------------------------
Class REGISTER_IO_straps_raw
    Private write_SFT_DEBUG_MODE_B_value
    Private read_SFT_DEBUG_MODE_B_value
    Private flag_SFT_DEBUG_MODE_B
    Private write_TC10_GO2STNDBY_value
    Private read_TC10_GO2STNDBY_value
    Private flag_TC10_GO2STNDBY
    Private write_TC10_DISABLE_value
    Private read_TC10_DISABLE_value
    Private flag_TC10_DISABLE
    Private write_PHYADDR4_value
    Private read_PHYADDR4_value
    Private flag_PHYADDR4
    Private write_PHYADDR3_value
    Private read_PHYADDR3_value
    Private flag_PHYADDR3
    Private write_MII2_MODE_2_value
    Private read_MII2_MODE_2_value
    Private flag_MII2_MODE_2
    Private write_MII1_MODE_2_value
    Private read_MII1_MODE_2_value
    Private flag_MII1_MODE_2
    Private write_HW_FWDG_EN_value
    Private read_HW_FWDG_EN_value
    Private flag_HW_FWDG_EN
    Private write_MII2_MODE_1_value
    Private read_MII2_MODE_1_value
    Private flag_MII2_MODE_1
    Private write_MII2_MODE_0_value
    Private read_MII2_MODE_0_value
    Private flag_MII2_MODE_0
    Private write_MII1_MODE_1_value
    Private read_MII1_MODE_1_value
    Private flag_MII1_MODE_1
    Private write_MII1_MODE_0_value
    Private read_MII1_MODE_0_value
    Private flag_MII1_MODE_0
    Private write_SUPER_ISOLATE_STRAP_value
    Private read_SUPER_ISOLATE_STRAP_value
    Private flag_SUPER_ISOLATE_STRAP
    Private write_SFT_FORCE_DWNLD_STRAP_value
    Private read_SFT_FORCE_DWNLD_STRAP_value
    Private flag_SFT_FORCE_DWNLD_STRAP
    Private write_BRPHY_MS_STRAP_value
    Private read_BRPHY_MS_STRAP_value
    Private flag_BRPHY_MS_STRAP
    Private write_STRAP_EN_EXTCLKB_value
    Private read_STRAP_EN_EXTCLKB_value
    Private flag_STRAP_EN_EXTCLKB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SFT_DEBUG_MODE_B
        get_SFT_DEBUG_MODE_B = read_SFT_DEBUG_MODE_B_value
    End Property

    Property Let set_SFT_DEBUG_MODE_B(aData)
        write_SFT_DEBUG_MODE_B_value = aData
        flag_SFT_DEBUG_MODE_B        = &H1
    End Property

    Property Get read_SFT_DEBUG_MODE_B
        read
        read_SFT_DEBUG_MODE_B = read_SFT_DEBUG_MODE_B_value
    End Property

    Property Let write_SFT_DEBUG_MODE_B(aData)
        set_SFT_DEBUG_MODE_B = aData
        write
    End Property

    Property Get get_TC10_GO2STNDBY
        get_TC10_GO2STNDBY = read_TC10_GO2STNDBY_value
    End Property

    Property Let set_TC10_GO2STNDBY(aData)
        write_TC10_GO2STNDBY_value = aData
        flag_TC10_GO2STNDBY        = &H1
    End Property

    Property Get read_TC10_GO2STNDBY
        read
        read_TC10_GO2STNDBY = read_TC10_GO2STNDBY_value
    End Property

    Property Let write_TC10_GO2STNDBY(aData)
        set_TC10_GO2STNDBY = aData
        write
    End Property

    Property Get get_TC10_DISABLE
        get_TC10_DISABLE = read_TC10_DISABLE_value
    End Property

    Property Let set_TC10_DISABLE(aData)
        write_TC10_DISABLE_value = aData
        flag_TC10_DISABLE        = &H1
    End Property

    Property Get read_TC10_DISABLE
        read
        read_TC10_DISABLE = read_TC10_DISABLE_value
    End Property

    Property Let write_TC10_DISABLE(aData)
        set_TC10_DISABLE = aData
        write
    End Property

    Property Get get_PHYADDR4
        get_PHYADDR4 = read_PHYADDR4_value
    End Property

    Property Let set_PHYADDR4(aData)
        write_PHYADDR4_value = aData
        flag_PHYADDR4        = &H1
    End Property

    Property Get read_PHYADDR4
        read
        read_PHYADDR4 = read_PHYADDR4_value
    End Property

    Property Let write_PHYADDR4(aData)
        set_PHYADDR4 = aData
        write
    End Property

    Property Get get_PHYADDR3
        get_PHYADDR3 = read_PHYADDR3_value
    End Property

    Property Let set_PHYADDR3(aData)
        write_PHYADDR3_value = aData
        flag_PHYADDR3        = &H1
    End Property

    Property Get read_PHYADDR3
        read
        read_PHYADDR3 = read_PHYADDR3_value
    End Property

    Property Let write_PHYADDR3(aData)
        set_PHYADDR3 = aData
        write
    End Property

    Property Get get_MII2_MODE_2
        get_MII2_MODE_2 = read_MII2_MODE_2_value
    End Property

    Property Let set_MII2_MODE_2(aData)
        write_MII2_MODE_2_value = aData
        flag_MII2_MODE_2        = &H1
    End Property

    Property Get read_MII2_MODE_2
        read
        read_MII2_MODE_2 = read_MII2_MODE_2_value
    End Property

    Property Let write_MII2_MODE_2(aData)
        set_MII2_MODE_2 = aData
        write
    End Property

    Property Get get_MII1_MODE_2
        get_MII1_MODE_2 = read_MII1_MODE_2_value
    End Property

    Property Let set_MII1_MODE_2(aData)
        write_MII1_MODE_2_value = aData
        flag_MII1_MODE_2        = &H1
    End Property

    Property Get read_MII1_MODE_2
        read
        read_MII1_MODE_2 = read_MII1_MODE_2_value
    End Property

    Property Let write_MII1_MODE_2(aData)
        set_MII1_MODE_2 = aData
        write
    End Property

    Property Get get_HW_FWDG_EN
        get_HW_FWDG_EN = read_HW_FWDG_EN_value
    End Property

    Property Let set_HW_FWDG_EN(aData)
        write_HW_FWDG_EN_value = aData
        flag_HW_FWDG_EN        = &H1
    End Property

    Property Get read_HW_FWDG_EN
        read
        read_HW_FWDG_EN = read_HW_FWDG_EN_value
    End Property

    Property Let write_HW_FWDG_EN(aData)
        set_HW_FWDG_EN = aData
        write
    End Property

    Property Get get_MII2_MODE_1
        get_MII2_MODE_1 = read_MII2_MODE_1_value
    End Property

    Property Let set_MII2_MODE_1(aData)
        write_MII2_MODE_1_value = aData
        flag_MII2_MODE_1        = &H1
    End Property

    Property Get read_MII2_MODE_1
        read
        read_MII2_MODE_1 = read_MII2_MODE_1_value
    End Property

    Property Let write_MII2_MODE_1(aData)
        set_MII2_MODE_1 = aData
        write
    End Property

    Property Get get_MII2_MODE_0
        get_MII2_MODE_0 = read_MII2_MODE_0_value
    End Property

    Property Let set_MII2_MODE_0(aData)
        write_MII2_MODE_0_value = aData
        flag_MII2_MODE_0        = &H1
    End Property

    Property Get read_MII2_MODE_0
        read
        read_MII2_MODE_0 = read_MII2_MODE_0_value
    End Property

    Property Let write_MII2_MODE_0(aData)
        set_MII2_MODE_0 = aData
        write
    End Property

    Property Get get_MII1_MODE_1
        get_MII1_MODE_1 = read_MII1_MODE_1_value
    End Property

    Property Let set_MII1_MODE_1(aData)
        write_MII1_MODE_1_value = aData
        flag_MII1_MODE_1        = &H1
    End Property

    Property Get read_MII1_MODE_1
        read
        read_MII1_MODE_1 = read_MII1_MODE_1_value
    End Property

    Property Let write_MII1_MODE_1(aData)
        set_MII1_MODE_1 = aData
        write
    End Property

    Property Get get_MII1_MODE_0
        get_MII1_MODE_0 = read_MII1_MODE_0_value
    End Property

    Property Let set_MII1_MODE_0(aData)
        write_MII1_MODE_0_value = aData
        flag_MII1_MODE_0        = &H1
    End Property

    Property Get read_MII1_MODE_0
        read
        read_MII1_MODE_0 = read_MII1_MODE_0_value
    End Property

    Property Let write_MII1_MODE_0(aData)
        set_MII1_MODE_0 = aData
        write
    End Property

    Property Get get_SUPER_ISOLATE_STRAP
        get_SUPER_ISOLATE_STRAP = read_SUPER_ISOLATE_STRAP_value
    End Property

    Property Let set_SUPER_ISOLATE_STRAP(aData)
        write_SUPER_ISOLATE_STRAP_value = aData
        flag_SUPER_ISOLATE_STRAP        = &H1
    End Property

    Property Get read_SUPER_ISOLATE_STRAP
        read
        read_SUPER_ISOLATE_STRAP = read_SUPER_ISOLATE_STRAP_value
    End Property

    Property Let write_SUPER_ISOLATE_STRAP(aData)
        set_SUPER_ISOLATE_STRAP = aData
        write
    End Property

    Property Get get_SFT_FORCE_DWNLD_STRAP
        get_SFT_FORCE_DWNLD_STRAP = read_SFT_FORCE_DWNLD_STRAP_value
    End Property

    Property Let set_SFT_FORCE_DWNLD_STRAP(aData)
        write_SFT_FORCE_DWNLD_STRAP_value = aData
        flag_SFT_FORCE_DWNLD_STRAP        = &H1
    End Property

    Property Get read_SFT_FORCE_DWNLD_STRAP
        read
        read_SFT_FORCE_DWNLD_STRAP = read_SFT_FORCE_DWNLD_STRAP_value
    End Property

    Property Let write_SFT_FORCE_DWNLD_STRAP(aData)
        set_SFT_FORCE_DWNLD_STRAP = aData
        write
    End Property

    Property Get get_BRPHY_MS_STRAP
        get_BRPHY_MS_STRAP = read_BRPHY_MS_STRAP_value
    End Property

    Property Let set_BRPHY_MS_STRAP(aData)
        write_BRPHY_MS_STRAP_value = aData
        flag_BRPHY_MS_STRAP        = &H1
    End Property

    Property Get read_BRPHY_MS_STRAP
        read
        read_BRPHY_MS_STRAP = read_BRPHY_MS_STRAP_value
    End Property

    Property Let write_BRPHY_MS_STRAP(aData)
        set_BRPHY_MS_STRAP = aData
        write
    End Property

    Property Get get_STRAP_EN_EXTCLKB
        get_STRAP_EN_EXTCLKB = read_STRAP_EN_EXTCLKB_value
    End Property

    Property Let set_STRAP_EN_EXTCLKB(aData)
        write_STRAP_EN_EXTCLKB_value = aData
        flag_STRAP_EN_EXTCLKB        = &H1
    End Property

    Property Get read_STRAP_EN_EXTCLKB
        read
        read_STRAP_EN_EXTCLKB = read_STRAP_EN_EXTCLKB_value
    End Property

    Property Let write_STRAP_EN_EXTCLKB(aData)
        set_STRAP_EN_EXTCLKB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SFT_DEBUG_MODE_B_value = rightShift(data_low, 15) and &H1
        read_TC10_GO2STNDBY_value = rightShift(data_low, 14) and &H1
        read_TC10_DISABLE_value = rightShift(data_low, 13) and &H1
        read_PHYADDR4_value = rightShift(data_low, 12) and &H1
        read_PHYADDR3_value = rightShift(data_low, 11) and &H1
        read_MII2_MODE_2_value = rightShift(data_low, 10) and &H1
        read_MII1_MODE_2_value = rightShift(data_low, 9) and &H1
        read_HW_FWDG_EN_value = rightShift(data_low, 8) and &H1
        read_MII2_MODE_1_value = rightShift(data_low, 7) and &H1
        read_MII2_MODE_0_value = rightShift(data_low, 6) and &H1
        read_MII1_MODE_1_value = rightShift(data_low, 5) and &H1
        read_MII1_MODE_0_value = rightShift(data_low, 4) and &H1
        read_SUPER_ISOLATE_STRAP_value = rightShift(data_low, 3) and &H1
        read_SFT_FORCE_DWNLD_STRAP_value = rightShift(data_low, 2) and &H1
        read_BRPHY_MS_STRAP_value = rightShift(data_low, 1) and &H1
        STRAP_EN_EXTCLKB_mask = &H1
        if data_low > LONG_MAX then
            if STRAP_EN_EXTCLKB_mask = mask then
                read_STRAP_EN_EXTCLKB_value = data_low
            else
                read_STRAP_EN_EXTCLKB_value = (data_low - H8000_0000) and STRAP_EN_EXTCLKB_mask
            end If
        else
            read_STRAP_EN_EXTCLKB_value = data_low and STRAP_EN_EXTCLKB_mask
        end If

    End Sub

    Sub write
        If flag_SFT_DEBUG_MODE_B = &H0 or flag_TC10_GO2STNDBY = &H0 or flag_TC10_DISABLE = &H0 or flag_PHYADDR4 = &H0 or flag_PHYADDR3 = &H0 or flag_MII2_MODE_2 = &H0 or flag_MII1_MODE_2 = &H0 or flag_HW_FWDG_EN = &H0 or flag_MII2_MODE_1 = &H0 or flag_MII2_MODE_0 = &H0 or flag_MII1_MODE_1 = &H0 or flag_MII1_MODE_0 = &H0 or flag_SUPER_ISOLATE_STRAP = &H0 or flag_SFT_FORCE_DWNLD_STRAP = &H0 or flag_BRPHY_MS_STRAP = &H0 or flag_STRAP_EN_EXTCLKB = &H0 Then read
        If flag_SFT_DEBUG_MODE_B = &H0 Then write_SFT_DEBUG_MODE_B_value = get_SFT_DEBUG_MODE_B
        If flag_TC10_GO2STNDBY = &H0 Then write_TC10_GO2STNDBY_value = get_TC10_GO2STNDBY
        If flag_TC10_DISABLE = &H0 Then write_TC10_DISABLE_value = get_TC10_DISABLE
        If flag_PHYADDR4 = &H0 Then write_PHYADDR4_value = get_PHYADDR4
        If flag_PHYADDR3 = &H0 Then write_PHYADDR3_value = get_PHYADDR3
        If flag_MII2_MODE_2 = &H0 Then write_MII2_MODE_2_value = get_MII2_MODE_2
        If flag_MII1_MODE_2 = &H0 Then write_MII1_MODE_2_value = get_MII1_MODE_2
        If flag_HW_FWDG_EN = &H0 Then write_HW_FWDG_EN_value = get_HW_FWDG_EN
        If flag_MII2_MODE_1 = &H0 Then write_MII2_MODE_1_value = get_MII2_MODE_1
        If flag_MII2_MODE_0 = &H0 Then write_MII2_MODE_0_value = get_MII2_MODE_0
        If flag_MII1_MODE_1 = &H0 Then write_MII1_MODE_1_value = get_MII1_MODE_1
        If flag_MII1_MODE_0 = &H0 Then write_MII1_MODE_0_value = get_MII1_MODE_0
        If flag_SUPER_ISOLATE_STRAP = &H0 Then write_SUPER_ISOLATE_STRAP_value = get_SUPER_ISOLATE_STRAP
        If flag_SFT_FORCE_DWNLD_STRAP = &H0 Then write_SFT_FORCE_DWNLD_STRAP_value = get_SFT_FORCE_DWNLD_STRAP
        If flag_BRPHY_MS_STRAP = &H0 Then write_BRPHY_MS_STRAP_value = get_BRPHY_MS_STRAP
        If flag_STRAP_EN_EXTCLKB = &H0 Then write_STRAP_EN_EXTCLKB_value = get_STRAP_EN_EXTCLKB

        regValue = leftShift((write_SFT_DEBUG_MODE_B_value and &H1), 15) + leftShift((write_TC10_GO2STNDBY_value and &H1), 14) + leftShift((write_TC10_DISABLE_value and &H1), 13) + leftShift((write_PHYADDR4_value and &H1), 12) + leftShift((write_PHYADDR3_value and &H1), 11) + leftShift((write_MII2_MODE_2_value and &H1), 10) + leftShift((write_MII1_MODE_2_value and &H1), 9) + leftShift((write_HW_FWDG_EN_value and &H1), 8) + leftShift((write_MII2_MODE_1_value and &H1), 7) + leftShift((write_MII2_MODE_0_value and &H1), 6) + leftShift((write_MII1_MODE_1_value and &H1), 5) + leftShift((write_MII1_MODE_0_value and &H1), 4) + leftShift((write_SUPER_ISOLATE_STRAP_value and &H1), 3) + leftShift((write_SFT_FORCE_DWNLD_STRAP_value and &H1), 2) + leftShift((write_BRPHY_MS_STRAP_value and &H1), 1) + leftShift((write_STRAP_EN_EXTCLKB_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SFT_DEBUG_MODE_B_value = rightShift(data_low, 15) and &H1
        read_TC10_GO2STNDBY_value = rightShift(data_low, 14) and &H1
        read_TC10_DISABLE_value = rightShift(data_low, 13) and &H1
        read_PHYADDR4_value = rightShift(data_low, 12) and &H1
        read_PHYADDR3_value = rightShift(data_low, 11) and &H1
        read_MII2_MODE_2_value = rightShift(data_low, 10) and &H1
        read_MII1_MODE_2_value = rightShift(data_low, 9) and &H1
        read_HW_FWDG_EN_value = rightShift(data_low, 8) and &H1
        read_MII2_MODE_1_value = rightShift(data_low, 7) and &H1
        read_MII2_MODE_0_value = rightShift(data_low, 6) and &H1
        read_MII1_MODE_1_value = rightShift(data_low, 5) and &H1
        read_MII1_MODE_0_value = rightShift(data_low, 4) and &H1
        read_SUPER_ISOLATE_STRAP_value = rightShift(data_low, 3) and &H1
        read_SFT_FORCE_DWNLD_STRAP_value = rightShift(data_low, 2) and &H1
        read_BRPHY_MS_STRAP_value = rightShift(data_low, 1) and &H1
        STRAP_EN_EXTCLKB_mask = &H1
        if data_low > LONG_MAX then
            if STRAP_EN_EXTCLKB_mask = mask then
                read_STRAP_EN_EXTCLKB_value = data_low
            else
                read_STRAP_EN_EXTCLKB_value = (data_low - H8000_0000) and STRAP_EN_EXTCLKB_mask
            end If
        else
            read_STRAP_EN_EXTCLKB_value = data_low and STRAP_EN_EXTCLKB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SFT_DEBUG_MODE_B_value = &H0
        flag_SFT_DEBUG_MODE_B        = &H0
        write_TC10_GO2STNDBY_value = &H0
        flag_TC10_GO2STNDBY        = &H0
        write_TC10_DISABLE_value = &H0
        flag_TC10_DISABLE        = &H0
        write_PHYADDR4_value = &H0
        flag_PHYADDR4        = &H0
        write_PHYADDR3_value = &H0
        flag_PHYADDR3        = &H0
        write_MII2_MODE_2_value = &H0
        flag_MII2_MODE_2        = &H0
        write_MII1_MODE_2_value = &H0
        flag_MII1_MODE_2        = &H0
        write_HW_FWDG_EN_value = &H0
        flag_HW_FWDG_EN        = &H0
        write_MII2_MODE_1_value = &H0
        flag_MII2_MODE_1        = &H0
        write_MII2_MODE_0_value = &H0
        flag_MII2_MODE_0        = &H0
        write_MII1_MODE_1_value = &H0
        flag_MII1_MODE_1        = &H0
        write_MII1_MODE_0_value = &H0
        flag_MII1_MODE_0        = &H0
        write_SUPER_ISOLATE_STRAP_value = &H0
        flag_SUPER_ISOLATE_STRAP        = &H0
        write_SFT_FORCE_DWNLD_STRAP_value = &H0
        flag_SFT_FORCE_DWNLD_STRAP        = &H0
        write_BRPHY_MS_STRAP_value = &H0
        flag_BRPHY_MS_STRAP        = &H0
        write_STRAP_EN_EXTCLKB_value = &H0
        flag_STRAP_EN_EXTCLKB        = &H0
    End Sub
End Class


'' @REGISTER : IO_straps_ov
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SFT_DEBUG_MODE_B                           [15:15]          get_SFT_DEBUG_MODE_B
''                                                             set_SFT_DEBUG_MODE_B
''                                                             read_SFT_DEBUG_MODE_B
''                                                             write_SFT_DEBUG_MODE_B
''---------------------------------------------------------------------------------
'' TC10_GO2STNDBY                             [14:14]          get_TC10_GO2STNDBY
''                                                             set_TC10_GO2STNDBY
''                                                             read_TC10_GO2STNDBY
''                                                             write_TC10_GO2STNDBY
''---------------------------------------------------------------------------------
'' TC10_DISABLE                               [13:13]          get_TC10_DISABLE
''                                                             set_TC10_DISABLE
''                                                             read_TC10_DISABLE
''                                                             write_TC10_DISABLE
''---------------------------------------------------------------------------------
'' PHYADDR4                                   [12:12]          get_PHYADDR4
''                                                             set_PHYADDR4
''                                                             read_PHYADDR4
''                                                             write_PHYADDR4
''---------------------------------------------------------------------------------
'' PHYADDR3                                   [11:11]          get_PHYADDR3
''                                                             set_PHYADDR3
''                                                             read_PHYADDR3
''                                                             write_PHYADDR3
''---------------------------------------------------------------------------------
'' MII2_MODE_2                                [10:10]          get_MII2_MODE_2
''                                                             set_MII2_MODE_2
''                                                             read_MII2_MODE_2
''                                                             write_MII2_MODE_2
''---------------------------------------------------------------------------------
'' MII1_MODE_2                                [9:9]            get_MII1_MODE_2
''                                                             set_MII1_MODE_2
''                                                             read_MII1_MODE_2
''                                                             write_MII1_MODE_2
''---------------------------------------------------------------------------------
'' HW_FWDG_EN                                 [8:8]            get_HW_FWDG_EN
''                                                             set_HW_FWDG_EN
''                                                             read_HW_FWDG_EN
''                                                             write_HW_FWDG_EN
''---------------------------------------------------------------------------------
'' MII2_MODE_1                                [7:7]            get_MII2_MODE_1
''                                                             set_MII2_MODE_1
''                                                             read_MII2_MODE_1
''                                                             write_MII2_MODE_1
''---------------------------------------------------------------------------------
'' MII2_MODE_0                                [6:6]            get_MII2_MODE_0
''                                                             set_MII2_MODE_0
''                                                             read_MII2_MODE_0
''                                                             write_MII2_MODE_0
''---------------------------------------------------------------------------------
'' MII1_MODE_1                                [5:5]            get_MII1_MODE_1
''                                                             set_MII1_MODE_1
''                                                             read_MII1_MODE_1
''                                                             write_MII1_MODE_1
''---------------------------------------------------------------------------------
'' MII1_MODE_0                                [4:4]            get_MII1_MODE_0
''                                                             set_MII1_MODE_0
''                                                             read_MII1_MODE_0
''                                                             write_MII1_MODE_0
''---------------------------------------------------------------------------------
'' SUPER_ISOLATE_STRAP                        [3:3]            get_SUPER_ISOLATE_STRAP
''                                                             set_SUPER_ISOLATE_STRAP
''                                                             read_SUPER_ISOLATE_STRAP
''                                                             write_SUPER_ISOLATE_STRAP
''---------------------------------------------------------------------------------
'' SFT_FORCE_DWNLD_STRAP                      [2:2]            get_SFT_FORCE_DWNLD_STRAP
''                                                             set_SFT_FORCE_DWNLD_STRAP
''                                                             read_SFT_FORCE_DWNLD_STRAP
''                                                             write_SFT_FORCE_DWNLD_STRAP
''---------------------------------------------------------------------------------
'' BRPHY_MS_STRAP                             [1:1]            get_BRPHY_MS_STRAP
''                                                             set_BRPHY_MS_STRAP
''                                                             read_BRPHY_MS_STRAP
''                                                             write_BRPHY_MS_STRAP
''---------------------------------------------------------------------------------
'' STRAP_EN_EXTCLKB                           [0:0]            get_STRAP_EN_EXTCLKB
''                                                             set_STRAP_EN_EXTCLKB
''                                                             read_STRAP_EN_EXTCLKB
''                                                             write_STRAP_EN_EXTCLKB
''---------------------------------------------------------------------------------
Class REGISTER_IO_straps_ov
    Private write_SFT_DEBUG_MODE_B_value
    Private read_SFT_DEBUG_MODE_B_value
    Private flag_SFT_DEBUG_MODE_B
    Private write_TC10_GO2STNDBY_value
    Private read_TC10_GO2STNDBY_value
    Private flag_TC10_GO2STNDBY
    Private write_TC10_DISABLE_value
    Private read_TC10_DISABLE_value
    Private flag_TC10_DISABLE
    Private write_PHYADDR4_value
    Private read_PHYADDR4_value
    Private flag_PHYADDR4
    Private write_PHYADDR3_value
    Private read_PHYADDR3_value
    Private flag_PHYADDR3
    Private write_MII2_MODE_2_value
    Private read_MII2_MODE_2_value
    Private flag_MII2_MODE_2
    Private write_MII1_MODE_2_value
    Private read_MII1_MODE_2_value
    Private flag_MII1_MODE_2
    Private write_HW_FWDG_EN_value
    Private read_HW_FWDG_EN_value
    Private flag_HW_FWDG_EN
    Private write_MII2_MODE_1_value
    Private read_MII2_MODE_1_value
    Private flag_MII2_MODE_1
    Private write_MII2_MODE_0_value
    Private read_MII2_MODE_0_value
    Private flag_MII2_MODE_0
    Private write_MII1_MODE_1_value
    Private read_MII1_MODE_1_value
    Private flag_MII1_MODE_1
    Private write_MII1_MODE_0_value
    Private read_MII1_MODE_0_value
    Private flag_MII1_MODE_0
    Private write_SUPER_ISOLATE_STRAP_value
    Private read_SUPER_ISOLATE_STRAP_value
    Private flag_SUPER_ISOLATE_STRAP
    Private write_SFT_FORCE_DWNLD_STRAP_value
    Private read_SFT_FORCE_DWNLD_STRAP_value
    Private flag_SFT_FORCE_DWNLD_STRAP
    Private write_BRPHY_MS_STRAP_value
    Private read_BRPHY_MS_STRAP_value
    Private flag_BRPHY_MS_STRAP
    Private write_STRAP_EN_EXTCLKB_value
    Private read_STRAP_EN_EXTCLKB_value
    Private flag_STRAP_EN_EXTCLKB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H42
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SFT_DEBUG_MODE_B
        get_SFT_DEBUG_MODE_B = read_SFT_DEBUG_MODE_B_value
    End Property

    Property Let set_SFT_DEBUG_MODE_B(aData)
        write_SFT_DEBUG_MODE_B_value = aData
        flag_SFT_DEBUG_MODE_B        = &H1
    End Property

    Property Get read_SFT_DEBUG_MODE_B
        read
        read_SFT_DEBUG_MODE_B = read_SFT_DEBUG_MODE_B_value
    End Property

    Property Let write_SFT_DEBUG_MODE_B(aData)
        set_SFT_DEBUG_MODE_B = aData
        write
    End Property

    Property Get get_TC10_GO2STNDBY
        get_TC10_GO2STNDBY = read_TC10_GO2STNDBY_value
    End Property

    Property Let set_TC10_GO2STNDBY(aData)
        write_TC10_GO2STNDBY_value = aData
        flag_TC10_GO2STNDBY        = &H1
    End Property

    Property Get read_TC10_GO2STNDBY
        read
        read_TC10_GO2STNDBY = read_TC10_GO2STNDBY_value
    End Property

    Property Let write_TC10_GO2STNDBY(aData)
        set_TC10_GO2STNDBY = aData
        write
    End Property

    Property Get get_TC10_DISABLE
        get_TC10_DISABLE = read_TC10_DISABLE_value
    End Property

    Property Let set_TC10_DISABLE(aData)
        write_TC10_DISABLE_value = aData
        flag_TC10_DISABLE        = &H1
    End Property

    Property Get read_TC10_DISABLE
        read
        read_TC10_DISABLE = read_TC10_DISABLE_value
    End Property

    Property Let write_TC10_DISABLE(aData)
        set_TC10_DISABLE = aData
        write
    End Property

    Property Get get_PHYADDR4
        get_PHYADDR4 = read_PHYADDR4_value
    End Property

    Property Let set_PHYADDR4(aData)
        write_PHYADDR4_value = aData
        flag_PHYADDR4        = &H1
    End Property

    Property Get read_PHYADDR4
        read
        read_PHYADDR4 = read_PHYADDR4_value
    End Property

    Property Let write_PHYADDR4(aData)
        set_PHYADDR4 = aData
        write
    End Property

    Property Get get_PHYADDR3
        get_PHYADDR3 = read_PHYADDR3_value
    End Property

    Property Let set_PHYADDR3(aData)
        write_PHYADDR3_value = aData
        flag_PHYADDR3        = &H1
    End Property

    Property Get read_PHYADDR3
        read
        read_PHYADDR3 = read_PHYADDR3_value
    End Property

    Property Let write_PHYADDR3(aData)
        set_PHYADDR3 = aData
        write
    End Property

    Property Get get_MII2_MODE_2
        get_MII2_MODE_2 = read_MII2_MODE_2_value
    End Property

    Property Let set_MII2_MODE_2(aData)
        write_MII2_MODE_2_value = aData
        flag_MII2_MODE_2        = &H1
    End Property

    Property Get read_MII2_MODE_2
        read
        read_MII2_MODE_2 = read_MII2_MODE_2_value
    End Property

    Property Let write_MII2_MODE_2(aData)
        set_MII2_MODE_2 = aData
        write
    End Property

    Property Get get_MII1_MODE_2
        get_MII1_MODE_2 = read_MII1_MODE_2_value
    End Property

    Property Let set_MII1_MODE_2(aData)
        write_MII1_MODE_2_value = aData
        flag_MII1_MODE_2        = &H1
    End Property

    Property Get read_MII1_MODE_2
        read
        read_MII1_MODE_2 = read_MII1_MODE_2_value
    End Property

    Property Let write_MII1_MODE_2(aData)
        set_MII1_MODE_2 = aData
        write
    End Property

    Property Get get_HW_FWDG_EN
        get_HW_FWDG_EN = read_HW_FWDG_EN_value
    End Property

    Property Let set_HW_FWDG_EN(aData)
        write_HW_FWDG_EN_value = aData
        flag_HW_FWDG_EN        = &H1
    End Property

    Property Get read_HW_FWDG_EN
        read
        read_HW_FWDG_EN = read_HW_FWDG_EN_value
    End Property

    Property Let write_HW_FWDG_EN(aData)
        set_HW_FWDG_EN = aData
        write
    End Property

    Property Get get_MII2_MODE_1
        get_MII2_MODE_1 = read_MII2_MODE_1_value
    End Property

    Property Let set_MII2_MODE_1(aData)
        write_MII2_MODE_1_value = aData
        flag_MII2_MODE_1        = &H1
    End Property

    Property Get read_MII2_MODE_1
        read
        read_MII2_MODE_1 = read_MII2_MODE_1_value
    End Property

    Property Let write_MII2_MODE_1(aData)
        set_MII2_MODE_1 = aData
        write
    End Property

    Property Get get_MII2_MODE_0
        get_MII2_MODE_0 = read_MII2_MODE_0_value
    End Property

    Property Let set_MII2_MODE_0(aData)
        write_MII2_MODE_0_value = aData
        flag_MII2_MODE_0        = &H1
    End Property

    Property Get read_MII2_MODE_0
        read
        read_MII2_MODE_0 = read_MII2_MODE_0_value
    End Property

    Property Let write_MII2_MODE_0(aData)
        set_MII2_MODE_0 = aData
        write
    End Property

    Property Get get_MII1_MODE_1
        get_MII1_MODE_1 = read_MII1_MODE_1_value
    End Property

    Property Let set_MII1_MODE_1(aData)
        write_MII1_MODE_1_value = aData
        flag_MII1_MODE_1        = &H1
    End Property

    Property Get read_MII1_MODE_1
        read
        read_MII1_MODE_1 = read_MII1_MODE_1_value
    End Property

    Property Let write_MII1_MODE_1(aData)
        set_MII1_MODE_1 = aData
        write
    End Property

    Property Get get_MII1_MODE_0
        get_MII1_MODE_0 = read_MII1_MODE_0_value
    End Property

    Property Let set_MII1_MODE_0(aData)
        write_MII1_MODE_0_value = aData
        flag_MII1_MODE_0        = &H1
    End Property

    Property Get read_MII1_MODE_0
        read
        read_MII1_MODE_0 = read_MII1_MODE_0_value
    End Property

    Property Let write_MII1_MODE_0(aData)
        set_MII1_MODE_0 = aData
        write
    End Property

    Property Get get_SUPER_ISOLATE_STRAP
        get_SUPER_ISOLATE_STRAP = read_SUPER_ISOLATE_STRAP_value
    End Property

    Property Let set_SUPER_ISOLATE_STRAP(aData)
        write_SUPER_ISOLATE_STRAP_value = aData
        flag_SUPER_ISOLATE_STRAP        = &H1
    End Property

    Property Get read_SUPER_ISOLATE_STRAP
        read
        read_SUPER_ISOLATE_STRAP = read_SUPER_ISOLATE_STRAP_value
    End Property

    Property Let write_SUPER_ISOLATE_STRAP(aData)
        set_SUPER_ISOLATE_STRAP = aData
        write
    End Property

    Property Get get_SFT_FORCE_DWNLD_STRAP
        get_SFT_FORCE_DWNLD_STRAP = read_SFT_FORCE_DWNLD_STRAP_value
    End Property

    Property Let set_SFT_FORCE_DWNLD_STRAP(aData)
        write_SFT_FORCE_DWNLD_STRAP_value = aData
        flag_SFT_FORCE_DWNLD_STRAP        = &H1
    End Property

    Property Get read_SFT_FORCE_DWNLD_STRAP
        read
        read_SFT_FORCE_DWNLD_STRAP = read_SFT_FORCE_DWNLD_STRAP_value
    End Property

    Property Let write_SFT_FORCE_DWNLD_STRAP(aData)
        set_SFT_FORCE_DWNLD_STRAP = aData
        write
    End Property

    Property Get get_BRPHY_MS_STRAP
        get_BRPHY_MS_STRAP = read_BRPHY_MS_STRAP_value
    End Property

    Property Let set_BRPHY_MS_STRAP(aData)
        write_BRPHY_MS_STRAP_value = aData
        flag_BRPHY_MS_STRAP        = &H1
    End Property

    Property Get read_BRPHY_MS_STRAP
        read
        read_BRPHY_MS_STRAP = read_BRPHY_MS_STRAP_value
    End Property

    Property Let write_BRPHY_MS_STRAP(aData)
        set_BRPHY_MS_STRAP = aData
        write
    End Property

    Property Get get_STRAP_EN_EXTCLKB
        get_STRAP_EN_EXTCLKB = read_STRAP_EN_EXTCLKB_value
    End Property

    Property Let set_STRAP_EN_EXTCLKB(aData)
        write_STRAP_EN_EXTCLKB_value = aData
        flag_STRAP_EN_EXTCLKB        = &H1
    End Property

    Property Get read_STRAP_EN_EXTCLKB
        read
        read_STRAP_EN_EXTCLKB = read_STRAP_EN_EXTCLKB_value
    End Property

    Property Let write_STRAP_EN_EXTCLKB(aData)
        set_STRAP_EN_EXTCLKB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SFT_DEBUG_MODE_B_value = rightShift(data_low, 15) and &H1
        read_TC10_GO2STNDBY_value = rightShift(data_low, 14) and &H1
        read_TC10_DISABLE_value = rightShift(data_low, 13) and &H1
        read_PHYADDR4_value = rightShift(data_low, 12) and &H1
        read_PHYADDR3_value = rightShift(data_low, 11) and &H1
        read_MII2_MODE_2_value = rightShift(data_low, 10) and &H1
        read_MII1_MODE_2_value = rightShift(data_low, 9) and &H1
        read_HW_FWDG_EN_value = rightShift(data_low, 8) and &H1
        read_MII2_MODE_1_value = rightShift(data_low, 7) and &H1
        read_MII2_MODE_0_value = rightShift(data_low, 6) and &H1
        read_MII1_MODE_1_value = rightShift(data_low, 5) and &H1
        read_MII1_MODE_0_value = rightShift(data_low, 4) and &H1
        read_SUPER_ISOLATE_STRAP_value = rightShift(data_low, 3) and &H1
        read_SFT_FORCE_DWNLD_STRAP_value = rightShift(data_low, 2) and &H1
        read_BRPHY_MS_STRAP_value = rightShift(data_low, 1) and &H1
        STRAP_EN_EXTCLKB_mask = &H1
        if data_low > LONG_MAX then
            if STRAP_EN_EXTCLKB_mask = mask then
                read_STRAP_EN_EXTCLKB_value = data_low
            else
                read_STRAP_EN_EXTCLKB_value = (data_low - H8000_0000) and STRAP_EN_EXTCLKB_mask
            end If
        else
            read_STRAP_EN_EXTCLKB_value = data_low and STRAP_EN_EXTCLKB_mask
        end If

    End Sub

    Sub write
        If flag_SFT_DEBUG_MODE_B = &H0 or flag_TC10_GO2STNDBY = &H0 or flag_TC10_DISABLE = &H0 or flag_PHYADDR4 = &H0 or flag_PHYADDR3 = &H0 or flag_MII2_MODE_2 = &H0 or flag_MII1_MODE_2 = &H0 or flag_HW_FWDG_EN = &H0 or flag_MII2_MODE_1 = &H0 or flag_MII2_MODE_0 = &H0 or flag_MII1_MODE_1 = &H0 or flag_MII1_MODE_0 = &H0 or flag_SUPER_ISOLATE_STRAP = &H0 or flag_SFT_FORCE_DWNLD_STRAP = &H0 or flag_BRPHY_MS_STRAP = &H0 or flag_STRAP_EN_EXTCLKB = &H0 Then read
        If flag_SFT_DEBUG_MODE_B = &H0 Then write_SFT_DEBUG_MODE_B_value = get_SFT_DEBUG_MODE_B
        If flag_TC10_GO2STNDBY = &H0 Then write_TC10_GO2STNDBY_value = get_TC10_GO2STNDBY
        If flag_TC10_DISABLE = &H0 Then write_TC10_DISABLE_value = get_TC10_DISABLE
        If flag_PHYADDR4 = &H0 Then write_PHYADDR4_value = get_PHYADDR4
        If flag_PHYADDR3 = &H0 Then write_PHYADDR3_value = get_PHYADDR3
        If flag_MII2_MODE_2 = &H0 Then write_MII2_MODE_2_value = get_MII2_MODE_2
        If flag_MII1_MODE_2 = &H0 Then write_MII1_MODE_2_value = get_MII1_MODE_2
        If flag_HW_FWDG_EN = &H0 Then write_HW_FWDG_EN_value = get_HW_FWDG_EN
        If flag_MII2_MODE_1 = &H0 Then write_MII2_MODE_1_value = get_MII2_MODE_1
        If flag_MII2_MODE_0 = &H0 Then write_MII2_MODE_0_value = get_MII2_MODE_0
        If flag_MII1_MODE_1 = &H0 Then write_MII1_MODE_1_value = get_MII1_MODE_1
        If flag_MII1_MODE_0 = &H0 Then write_MII1_MODE_0_value = get_MII1_MODE_0
        If flag_SUPER_ISOLATE_STRAP = &H0 Then write_SUPER_ISOLATE_STRAP_value = get_SUPER_ISOLATE_STRAP
        If flag_SFT_FORCE_DWNLD_STRAP = &H0 Then write_SFT_FORCE_DWNLD_STRAP_value = get_SFT_FORCE_DWNLD_STRAP
        If flag_BRPHY_MS_STRAP = &H0 Then write_BRPHY_MS_STRAP_value = get_BRPHY_MS_STRAP
        If flag_STRAP_EN_EXTCLKB = &H0 Then write_STRAP_EN_EXTCLKB_value = get_STRAP_EN_EXTCLKB

        regValue = leftShift((write_SFT_DEBUG_MODE_B_value and &H1), 15) + leftShift((write_TC10_GO2STNDBY_value and &H1), 14) + leftShift((write_TC10_DISABLE_value and &H1), 13) + leftShift((write_PHYADDR4_value and &H1), 12) + leftShift((write_PHYADDR3_value and &H1), 11) + leftShift((write_MII2_MODE_2_value and &H1), 10) + leftShift((write_MII1_MODE_2_value and &H1), 9) + leftShift((write_HW_FWDG_EN_value and &H1), 8) + leftShift((write_MII2_MODE_1_value and &H1), 7) + leftShift((write_MII2_MODE_0_value and &H1), 6) + leftShift((write_MII1_MODE_1_value and &H1), 5) + leftShift((write_MII1_MODE_0_value and &H1), 4) + leftShift((write_SUPER_ISOLATE_STRAP_value and &H1), 3) + leftShift((write_SFT_FORCE_DWNLD_STRAP_value and &H1), 2) + leftShift((write_BRPHY_MS_STRAP_value and &H1), 1) + leftShift((write_STRAP_EN_EXTCLKB_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SFT_DEBUG_MODE_B_value = rightShift(data_low, 15) and &H1
        read_TC10_GO2STNDBY_value = rightShift(data_low, 14) and &H1
        read_TC10_DISABLE_value = rightShift(data_low, 13) and &H1
        read_PHYADDR4_value = rightShift(data_low, 12) and &H1
        read_PHYADDR3_value = rightShift(data_low, 11) and &H1
        read_MII2_MODE_2_value = rightShift(data_low, 10) and &H1
        read_MII1_MODE_2_value = rightShift(data_low, 9) and &H1
        read_HW_FWDG_EN_value = rightShift(data_low, 8) and &H1
        read_MII2_MODE_1_value = rightShift(data_low, 7) and &H1
        read_MII2_MODE_0_value = rightShift(data_low, 6) and &H1
        read_MII1_MODE_1_value = rightShift(data_low, 5) and &H1
        read_MII1_MODE_0_value = rightShift(data_low, 4) and &H1
        read_SUPER_ISOLATE_STRAP_value = rightShift(data_low, 3) and &H1
        read_SFT_FORCE_DWNLD_STRAP_value = rightShift(data_low, 2) and &H1
        read_BRPHY_MS_STRAP_value = rightShift(data_low, 1) and &H1
        STRAP_EN_EXTCLKB_mask = &H1
        if data_low > LONG_MAX then
            if STRAP_EN_EXTCLKB_mask = mask then
                read_STRAP_EN_EXTCLKB_value = data_low
            else
                read_STRAP_EN_EXTCLKB_value = (data_low - H8000_0000) and STRAP_EN_EXTCLKB_mask
            end If
        else
            read_STRAP_EN_EXTCLKB_value = data_low and STRAP_EN_EXTCLKB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SFT_DEBUG_MODE_B_value = &H0
        flag_SFT_DEBUG_MODE_B        = &H0
        write_TC10_GO2STNDBY_value = &H0
        flag_TC10_GO2STNDBY        = &H0
        write_TC10_DISABLE_value = &H0
        flag_TC10_DISABLE        = &H0
        write_PHYADDR4_value = &H0
        flag_PHYADDR4        = &H0
        write_PHYADDR3_value = &H0
        flag_PHYADDR3        = &H0
        write_MII2_MODE_2_value = &H0
        flag_MII2_MODE_2        = &H0
        write_MII1_MODE_2_value = &H0
        flag_MII1_MODE_2        = &H0
        write_HW_FWDG_EN_value = &H0
        flag_HW_FWDG_EN        = &H0
        write_MII2_MODE_1_value = &H0
        flag_MII2_MODE_1        = &H0
        write_MII2_MODE_0_value = &H0
        flag_MII2_MODE_0        = &H0
        write_MII1_MODE_1_value = &H0
        flag_MII1_MODE_1        = &H0
        write_MII1_MODE_0_value = &H0
        flag_MII1_MODE_0        = &H0
        write_SUPER_ISOLATE_STRAP_value = &H0
        flag_SUPER_ISOLATE_STRAP        = &H0
        write_SFT_FORCE_DWNLD_STRAP_value = &H0
        flag_SFT_FORCE_DWNLD_STRAP        = &H0
        write_BRPHY_MS_STRAP_value = &H0
        flag_BRPHY_MS_STRAP        = &H0
        write_STRAP_EN_EXTCLKB_value = &H0
        flag_STRAP_EN_EXTCLKB        = &H0
    End Sub
End Class


'' @REGISTER : IO_straps_raw2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRPHY_1G_ANEN                              [5:5]            get_BRPHY_1G_ANEN
''                                                             set_BRPHY_1G_ANEN
''                                                             read_BRPHY_1G_ANEN
''                                                             write_BRPHY_1G_ANEN
''---------------------------------------------------------------------------------
'' BRPHY_1G_SPEED                             [4:4]            get_BRPHY_1G_SPEED
''                                                             set_BRPHY_1G_SPEED
''                                                             read_BRPHY_1G_SPEED
''                                                             write_BRPHY_1G_SPEED
''---------------------------------------------------------------------------------
'' BRPHY_1G_MS                                [3:3]            get_BRPHY_1G_MS
''                                                             set_BRPHY_1G_MS
''                                                             read_BRPHY_1G_MS
''                                                             write_BRPHY_1G_MS
''---------------------------------------------------------------------------------
'' MII3_MODE_2                                [2:2]            get_MII3_MODE_2
''                                                             set_MII3_MODE_2
''                                                             read_MII3_MODE_2
''                                                             write_MII3_MODE_2
''---------------------------------------------------------------------------------
'' MII3_MODE_1                                [1:1]            get_MII3_MODE_1
''                                                             set_MII3_MODE_1
''                                                             read_MII3_MODE_1
''                                                             write_MII3_MODE_1
''---------------------------------------------------------------------------------
'' MII3_MODE_0                                [0:0]            get_MII3_MODE_0
''                                                             set_MII3_MODE_0
''                                                             read_MII3_MODE_0
''                                                             write_MII3_MODE_0
''---------------------------------------------------------------------------------
Class REGISTER_IO_straps_raw2
    Private write_BRPHY_1G_ANEN_value
    Private read_BRPHY_1G_ANEN_value
    Private flag_BRPHY_1G_ANEN
    Private write_BRPHY_1G_SPEED_value
    Private read_BRPHY_1G_SPEED_value
    Private flag_BRPHY_1G_SPEED
    Private write_BRPHY_1G_MS_value
    Private read_BRPHY_1G_MS_value
    Private flag_BRPHY_1G_MS
    Private write_MII3_MODE_2_value
    Private read_MII3_MODE_2_value
    Private flag_MII3_MODE_2
    Private write_MII3_MODE_1_value
    Private read_MII3_MODE_1_value
    Private flag_MII3_MODE_1
    Private write_MII3_MODE_0_value
    Private read_MII3_MODE_0_value
    Private flag_MII3_MODE_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BRPHY_1G_ANEN
        get_BRPHY_1G_ANEN = read_BRPHY_1G_ANEN_value
    End Property

    Property Let set_BRPHY_1G_ANEN(aData)
        write_BRPHY_1G_ANEN_value = aData
        flag_BRPHY_1G_ANEN        = &H1
    End Property

    Property Get read_BRPHY_1G_ANEN
        read
        read_BRPHY_1G_ANEN = read_BRPHY_1G_ANEN_value
    End Property

    Property Let write_BRPHY_1G_ANEN(aData)
        set_BRPHY_1G_ANEN = aData
        write
    End Property

    Property Get get_BRPHY_1G_SPEED
        get_BRPHY_1G_SPEED = read_BRPHY_1G_SPEED_value
    End Property

    Property Let set_BRPHY_1G_SPEED(aData)
        write_BRPHY_1G_SPEED_value = aData
        flag_BRPHY_1G_SPEED        = &H1
    End Property

    Property Get read_BRPHY_1G_SPEED
        read
        read_BRPHY_1G_SPEED = read_BRPHY_1G_SPEED_value
    End Property

    Property Let write_BRPHY_1G_SPEED(aData)
        set_BRPHY_1G_SPEED = aData
        write
    End Property

    Property Get get_BRPHY_1G_MS
        get_BRPHY_1G_MS = read_BRPHY_1G_MS_value
    End Property

    Property Let set_BRPHY_1G_MS(aData)
        write_BRPHY_1G_MS_value = aData
        flag_BRPHY_1G_MS        = &H1
    End Property

    Property Get read_BRPHY_1G_MS
        read
        read_BRPHY_1G_MS = read_BRPHY_1G_MS_value
    End Property

    Property Let write_BRPHY_1G_MS(aData)
        set_BRPHY_1G_MS = aData
        write
    End Property

    Property Get get_MII3_MODE_2
        get_MII3_MODE_2 = read_MII3_MODE_2_value
    End Property

    Property Let set_MII3_MODE_2(aData)
        write_MII3_MODE_2_value = aData
        flag_MII3_MODE_2        = &H1
    End Property

    Property Get read_MII3_MODE_2
        read
        read_MII3_MODE_2 = read_MII3_MODE_2_value
    End Property

    Property Let write_MII3_MODE_2(aData)
        set_MII3_MODE_2 = aData
        write
    End Property

    Property Get get_MII3_MODE_1
        get_MII3_MODE_1 = read_MII3_MODE_1_value
    End Property

    Property Let set_MII3_MODE_1(aData)
        write_MII3_MODE_1_value = aData
        flag_MII3_MODE_1        = &H1
    End Property

    Property Get read_MII3_MODE_1
        read
        read_MII3_MODE_1 = read_MII3_MODE_1_value
    End Property

    Property Let write_MII3_MODE_1(aData)
        set_MII3_MODE_1 = aData
        write
    End Property

    Property Get get_MII3_MODE_0
        get_MII3_MODE_0 = read_MII3_MODE_0_value
    End Property

    Property Let set_MII3_MODE_0(aData)
        write_MII3_MODE_0_value = aData
        flag_MII3_MODE_0        = &H1
    End Property

    Property Get read_MII3_MODE_0
        read
        read_MII3_MODE_0 = read_MII3_MODE_0_value
    End Property

    Property Let write_MII3_MODE_0(aData)
        set_MII3_MODE_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRPHY_1G_ANEN_value = rightShift(data_low, 5) and &H1
        read_BRPHY_1G_SPEED_value = rightShift(data_low, 4) and &H1
        read_BRPHY_1G_MS_value = rightShift(data_low, 3) and &H1
        read_MII3_MODE_2_value = rightShift(data_low, 2) and &H1
        read_MII3_MODE_1_value = rightShift(data_low, 1) and &H1
        MII3_MODE_0_mask = &H1
        if data_low > LONG_MAX then
            if MII3_MODE_0_mask = mask then
                read_MII3_MODE_0_value = data_low
            else
                read_MII3_MODE_0_value = (data_low - H8000_0000) and MII3_MODE_0_mask
            end If
        else
            read_MII3_MODE_0_value = data_low and MII3_MODE_0_mask
        end If

    End Sub

    Sub write
        If flag_BRPHY_1G_ANEN = &H0 or flag_BRPHY_1G_SPEED = &H0 or flag_BRPHY_1G_MS = &H0 or flag_MII3_MODE_2 = &H0 or flag_MII3_MODE_1 = &H0 or flag_MII3_MODE_0 = &H0 Then read
        If flag_BRPHY_1G_ANEN = &H0 Then write_BRPHY_1G_ANEN_value = get_BRPHY_1G_ANEN
        If flag_BRPHY_1G_SPEED = &H0 Then write_BRPHY_1G_SPEED_value = get_BRPHY_1G_SPEED
        If flag_BRPHY_1G_MS = &H0 Then write_BRPHY_1G_MS_value = get_BRPHY_1G_MS
        If flag_MII3_MODE_2 = &H0 Then write_MII3_MODE_2_value = get_MII3_MODE_2
        If flag_MII3_MODE_1 = &H0 Then write_MII3_MODE_1_value = get_MII3_MODE_1
        If flag_MII3_MODE_0 = &H0 Then write_MII3_MODE_0_value = get_MII3_MODE_0

        regValue = leftShift((write_BRPHY_1G_ANEN_value and &H1), 5) + leftShift((write_BRPHY_1G_SPEED_value and &H1), 4) + leftShift((write_BRPHY_1G_MS_value and &H1), 3) + leftShift((write_MII3_MODE_2_value and &H1), 2) + leftShift((write_MII3_MODE_1_value and &H1), 1) + leftShift((write_MII3_MODE_0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRPHY_1G_ANEN_value = rightShift(data_low, 5) and &H1
        read_BRPHY_1G_SPEED_value = rightShift(data_low, 4) and &H1
        read_BRPHY_1G_MS_value = rightShift(data_low, 3) and &H1
        read_MII3_MODE_2_value = rightShift(data_low, 2) and &H1
        read_MII3_MODE_1_value = rightShift(data_low, 1) and &H1
        MII3_MODE_0_mask = &H1
        if data_low > LONG_MAX then
            if MII3_MODE_0_mask = mask then
                read_MII3_MODE_0_value = data_low
            else
                read_MII3_MODE_0_value = (data_low - H8000_0000) and MII3_MODE_0_mask
            end If
        else
            read_MII3_MODE_0_value = data_low and MII3_MODE_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRPHY_1G_ANEN_value = &H0
        flag_BRPHY_1G_ANEN        = &H0
        write_BRPHY_1G_SPEED_value = &H0
        flag_BRPHY_1G_SPEED        = &H0
        write_BRPHY_1G_MS_value = &H0
        flag_BRPHY_1G_MS        = &H0
        write_MII3_MODE_2_value = &H0
        flag_MII3_MODE_2        = &H0
        write_MII3_MODE_1_value = &H0
        flag_MII3_MODE_1        = &H0
        write_MII3_MODE_0_value = &H0
        flag_MII3_MODE_0        = &H0
    End Sub
End Class


'' @REGISTER : IO_straps_ov2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRPHY_1G_ANEN                              [5:5]            get_BRPHY_1G_ANEN
''                                                             set_BRPHY_1G_ANEN
''                                                             read_BRPHY_1G_ANEN
''                                                             write_BRPHY_1G_ANEN
''---------------------------------------------------------------------------------
'' BRPHY_1G_SPEED                             [4:4]            get_BRPHY_1G_SPEED
''                                                             set_BRPHY_1G_SPEED
''                                                             read_BRPHY_1G_SPEED
''                                                             write_BRPHY_1G_SPEED
''---------------------------------------------------------------------------------
'' BRPHY_1G_MS                                [3:3]            get_BRPHY_1G_MS
''                                                             set_BRPHY_1G_MS
''                                                             read_BRPHY_1G_MS
''                                                             write_BRPHY_1G_MS
''---------------------------------------------------------------------------------
'' MII3_MODE_2                                [2:2]            get_MII3_MODE_2
''                                                             set_MII3_MODE_2
''                                                             read_MII3_MODE_2
''                                                             write_MII3_MODE_2
''---------------------------------------------------------------------------------
'' MII3_MODE_1                                [1:1]            get_MII3_MODE_1
''                                                             set_MII3_MODE_1
''                                                             read_MII3_MODE_1
''                                                             write_MII3_MODE_1
''---------------------------------------------------------------------------------
'' MII3_MODE_0                                [0:0]            get_MII3_MODE_0
''                                                             set_MII3_MODE_0
''                                                             read_MII3_MODE_0
''                                                             write_MII3_MODE_0
''---------------------------------------------------------------------------------
Class REGISTER_IO_straps_ov2
    Private write_BRPHY_1G_ANEN_value
    Private read_BRPHY_1G_ANEN_value
    Private flag_BRPHY_1G_ANEN
    Private write_BRPHY_1G_SPEED_value
    Private read_BRPHY_1G_SPEED_value
    Private flag_BRPHY_1G_SPEED
    Private write_BRPHY_1G_MS_value
    Private read_BRPHY_1G_MS_value
    Private flag_BRPHY_1G_MS
    Private write_MII3_MODE_2_value
    Private read_MII3_MODE_2_value
    Private flag_MII3_MODE_2
    Private write_MII3_MODE_1_value
    Private read_MII3_MODE_1_value
    Private flag_MII3_MODE_1
    Private write_MII3_MODE_0_value
    Private read_MII3_MODE_0_value
    Private flag_MII3_MODE_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H46
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BRPHY_1G_ANEN
        get_BRPHY_1G_ANEN = read_BRPHY_1G_ANEN_value
    End Property

    Property Let set_BRPHY_1G_ANEN(aData)
        write_BRPHY_1G_ANEN_value = aData
        flag_BRPHY_1G_ANEN        = &H1
    End Property

    Property Get read_BRPHY_1G_ANEN
        read
        read_BRPHY_1G_ANEN = read_BRPHY_1G_ANEN_value
    End Property

    Property Let write_BRPHY_1G_ANEN(aData)
        set_BRPHY_1G_ANEN = aData
        write
    End Property

    Property Get get_BRPHY_1G_SPEED
        get_BRPHY_1G_SPEED = read_BRPHY_1G_SPEED_value
    End Property

    Property Let set_BRPHY_1G_SPEED(aData)
        write_BRPHY_1G_SPEED_value = aData
        flag_BRPHY_1G_SPEED        = &H1
    End Property

    Property Get read_BRPHY_1G_SPEED
        read
        read_BRPHY_1G_SPEED = read_BRPHY_1G_SPEED_value
    End Property

    Property Let write_BRPHY_1G_SPEED(aData)
        set_BRPHY_1G_SPEED = aData
        write
    End Property

    Property Get get_BRPHY_1G_MS
        get_BRPHY_1G_MS = read_BRPHY_1G_MS_value
    End Property

    Property Let set_BRPHY_1G_MS(aData)
        write_BRPHY_1G_MS_value = aData
        flag_BRPHY_1G_MS        = &H1
    End Property

    Property Get read_BRPHY_1G_MS
        read
        read_BRPHY_1G_MS = read_BRPHY_1G_MS_value
    End Property

    Property Let write_BRPHY_1G_MS(aData)
        set_BRPHY_1G_MS = aData
        write
    End Property

    Property Get get_MII3_MODE_2
        get_MII3_MODE_2 = read_MII3_MODE_2_value
    End Property

    Property Let set_MII3_MODE_2(aData)
        write_MII3_MODE_2_value = aData
        flag_MII3_MODE_2        = &H1
    End Property

    Property Get read_MII3_MODE_2
        read
        read_MII3_MODE_2 = read_MII3_MODE_2_value
    End Property

    Property Let write_MII3_MODE_2(aData)
        set_MII3_MODE_2 = aData
        write
    End Property

    Property Get get_MII3_MODE_1
        get_MII3_MODE_1 = read_MII3_MODE_1_value
    End Property

    Property Let set_MII3_MODE_1(aData)
        write_MII3_MODE_1_value = aData
        flag_MII3_MODE_1        = &H1
    End Property

    Property Get read_MII3_MODE_1
        read
        read_MII3_MODE_1 = read_MII3_MODE_1_value
    End Property

    Property Let write_MII3_MODE_1(aData)
        set_MII3_MODE_1 = aData
        write
    End Property

    Property Get get_MII3_MODE_0
        get_MII3_MODE_0 = read_MII3_MODE_0_value
    End Property

    Property Let set_MII3_MODE_0(aData)
        write_MII3_MODE_0_value = aData
        flag_MII3_MODE_0        = &H1
    End Property

    Property Get read_MII3_MODE_0
        read
        read_MII3_MODE_0 = read_MII3_MODE_0_value
    End Property

    Property Let write_MII3_MODE_0(aData)
        set_MII3_MODE_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRPHY_1G_ANEN_value = rightShift(data_low, 5) and &H1
        read_BRPHY_1G_SPEED_value = rightShift(data_low, 4) and &H1
        read_BRPHY_1G_MS_value = rightShift(data_low, 3) and &H1
        read_MII3_MODE_2_value = rightShift(data_low, 2) and &H1
        read_MII3_MODE_1_value = rightShift(data_low, 1) and &H1
        MII3_MODE_0_mask = &H1
        if data_low > LONG_MAX then
            if MII3_MODE_0_mask = mask then
                read_MII3_MODE_0_value = data_low
            else
                read_MII3_MODE_0_value = (data_low - H8000_0000) and MII3_MODE_0_mask
            end If
        else
            read_MII3_MODE_0_value = data_low and MII3_MODE_0_mask
        end If

    End Sub

    Sub write
        If flag_BRPHY_1G_ANEN = &H0 or flag_BRPHY_1G_SPEED = &H0 or flag_BRPHY_1G_MS = &H0 or flag_MII3_MODE_2 = &H0 or flag_MII3_MODE_1 = &H0 or flag_MII3_MODE_0 = &H0 Then read
        If flag_BRPHY_1G_ANEN = &H0 Then write_BRPHY_1G_ANEN_value = get_BRPHY_1G_ANEN
        If flag_BRPHY_1G_SPEED = &H0 Then write_BRPHY_1G_SPEED_value = get_BRPHY_1G_SPEED
        If flag_BRPHY_1G_MS = &H0 Then write_BRPHY_1G_MS_value = get_BRPHY_1G_MS
        If flag_MII3_MODE_2 = &H0 Then write_MII3_MODE_2_value = get_MII3_MODE_2
        If flag_MII3_MODE_1 = &H0 Then write_MII3_MODE_1_value = get_MII3_MODE_1
        If flag_MII3_MODE_0 = &H0 Then write_MII3_MODE_0_value = get_MII3_MODE_0

        regValue = leftShift((write_BRPHY_1G_ANEN_value and &H1), 5) + leftShift((write_BRPHY_1G_SPEED_value and &H1), 4) + leftShift((write_BRPHY_1G_MS_value and &H1), 3) + leftShift((write_MII3_MODE_2_value and &H1), 2) + leftShift((write_MII3_MODE_1_value and &H1), 1) + leftShift((write_MII3_MODE_0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRPHY_1G_ANEN_value = rightShift(data_low, 5) and &H1
        read_BRPHY_1G_SPEED_value = rightShift(data_low, 4) and &H1
        read_BRPHY_1G_MS_value = rightShift(data_low, 3) and &H1
        read_MII3_MODE_2_value = rightShift(data_low, 2) and &H1
        read_MII3_MODE_1_value = rightShift(data_low, 1) and &H1
        MII3_MODE_0_mask = &H1
        if data_low > LONG_MAX then
            if MII3_MODE_0_mask = mask then
                read_MII3_MODE_0_value = data_low
            else
                read_MII3_MODE_0_value = (data_low - H8000_0000) and MII3_MODE_0_mask
            end If
        else
            read_MII3_MODE_0_value = data_low and MII3_MODE_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRPHY_1G_ANEN_value = &H0
        flag_BRPHY_1G_ANEN        = &H0
        write_BRPHY_1G_SPEED_value = &H0
        flag_BRPHY_1G_SPEED        = &H0
        write_BRPHY_1G_MS_value = &H0
        flag_BRPHY_1G_MS        = &H0
        write_MII3_MODE_2_value = &H0
        flag_MII3_MODE_2        = &H0
        write_MII3_MODE_1_value = &H0
        flag_MII3_MODE_1        = &H0
        write_MII3_MODE_0_value = &H0
        flag_MII3_MODE_0        = &H0
    End Sub
End Class


'' @REGISTER : IO_strap_test
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' input_mode_strap_test                      [8:8]            get_input_mode_strap_test
''                                                             set_input_mode_strap_test
''                                                             read_input_mode_strap_test
''                                                             write_input_mode_strap_test
''---------------------------------------------------------------------------------
'' strap_test_val_latched                     [6:4]            get_strap_test_val_latched
''                                                             set_strap_test_val_latched
''                                                             read_strap_test_val_latched
''                                                             write_strap_test_val_latched
''---------------------------------------------------------------------------------
'' strap_test_val                             [2:0]            get_strap_test_val
''                                                             set_strap_test_val
''                                                             read_strap_test_val
''                                                             write_strap_test_val
''---------------------------------------------------------------------------------
Class REGISTER_IO_strap_test
    Private write_input_mode_strap_test_value
    Private read_input_mode_strap_test_value
    Private flag_input_mode_strap_test
    Private write_strap_test_val_latched_value
    Private read_strap_test_val_latched_value
    Private flag_strap_test_val_latched
    Private write_strap_test_val_value
    Private read_strap_test_val_value
    Private flag_strap_test_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_input_mode_strap_test
        get_input_mode_strap_test = read_input_mode_strap_test_value
    End Property

    Property Let set_input_mode_strap_test(aData)
        write_input_mode_strap_test_value = aData
        flag_input_mode_strap_test        = &H1
    End Property

    Property Get read_input_mode_strap_test
        read
        read_input_mode_strap_test = read_input_mode_strap_test_value
    End Property

    Property Let write_input_mode_strap_test(aData)
        set_input_mode_strap_test = aData
        write
    End Property

    Property Get get_strap_test_val_latched
        get_strap_test_val_latched = read_strap_test_val_latched_value
    End Property

    Property Let set_strap_test_val_latched(aData)
        write_strap_test_val_latched_value = aData
        flag_strap_test_val_latched        = &H1
    End Property

    Property Get read_strap_test_val_latched
        read
        read_strap_test_val_latched = read_strap_test_val_latched_value
    End Property

    Property Let write_strap_test_val_latched(aData)
        set_strap_test_val_latched = aData
        write
    End Property

    Property Get get_strap_test_val
        get_strap_test_val = read_strap_test_val_value
    End Property

    Property Let set_strap_test_val(aData)
        write_strap_test_val_value = aData
        flag_strap_test_val        = &H1
    End Property

    Property Get read_strap_test_val
        read
        read_strap_test_val = read_strap_test_val_value
    End Property

    Property Let write_strap_test_val(aData)
        set_strap_test_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_input_mode_strap_test_value = rightShift(data_low, 8) and &H1
        read_strap_test_val_latched_value = rightShift(data_low, 4) and &H7
        strap_test_val_mask = &H7
        if data_low > LONG_MAX then
            if strap_test_val_mask = mask then
                read_strap_test_val_value = data_low
            else
                read_strap_test_val_value = (data_low - H8000_0000) and strap_test_val_mask
            end If
        else
            read_strap_test_val_value = data_low and strap_test_val_mask
        end If

    End Sub

    Sub write
        If flag_input_mode_strap_test = &H0 or flag_strap_test_val_latched = &H0 or flag_strap_test_val = &H0 Then read
        If flag_input_mode_strap_test = &H0 Then write_input_mode_strap_test_value = get_input_mode_strap_test
        If flag_strap_test_val_latched = &H0 Then write_strap_test_val_latched_value = get_strap_test_val_latched
        If flag_strap_test_val = &H0 Then write_strap_test_val_value = get_strap_test_val

        regValue = leftShift((write_input_mode_strap_test_value and &H1), 8) + leftShift((write_strap_test_val_latched_value and &H7), 4) + leftShift((write_strap_test_val_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_input_mode_strap_test_value = rightShift(data_low, 8) and &H1
        read_strap_test_val_latched_value = rightShift(data_low, 4) and &H7
        strap_test_val_mask = &H7
        if data_low > LONG_MAX then
            if strap_test_val_mask = mask then
                read_strap_test_val_value = data_low
            else
                read_strap_test_val_value = (data_low - H8000_0000) and strap_test_val_mask
            end If
        else
            read_strap_test_val_value = data_low and strap_test_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_input_mode_strap_test_value = &H0
        flag_input_mode_strap_test        = &H0
        write_strap_test_val_latched_value = &H0
        flag_strap_test_val_latched        = &H0
        write_strap_test_val_value = &H0
        flag_strap_test_val        = &H0
    End Sub
End Class


'' @REGISTER : IO_sw_rxc_inv_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_rxc_inv_ctl                             [15:0]           get_sw_rxc_inv_ctl
''                                                             set_sw_rxc_inv_ctl
''                                                             read_sw_rxc_inv_ctl
''                                                             write_sw_rxc_inv_ctl
''---------------------------------------------------------------------------------
Class REGISTER_IO_sw_rxc_inv_ctl
    Private write_sw_rxc_inv_ctl_value
    Private read_sw_rxc_inv_ctl_value
    Private flag_sw_rxc_inv_ctl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_rxc_inv_ctl
        get_sw_rxc_inv_ctl = read_sw_rxc_inv_ctl_value
    End Property

    Property Let set_sw_rxc_inv_ctl(aData)
        write_sw_rxc_inv_ctl_value = aData
        flag_sw_rxc_inv_ctl        = &H1
    End Property

    Property Get read_sw_rxc_inv_ctl
        read
        read_sw_rxc_inv_ctl = read_sw_rxc_inv_ctl_value
    End Property

    Property Let write_sw_rxc_inv_ctl(aData)
        set_sw_rxc_inv_ctl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_rxc_inv_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if sw_rxc_inv_ctl_mask = mask then
                read_sw_rxc_inv_ctl_value = data_low
            else
                read_sw_rxc_inv_ctl_value = (data_low - H8000_0000) and sw_rxc_inv_ctl_mask
            end If
        else
            read_sw_rxc_inv_ctl_value = data_low and sw_rxc_inv_ctl_mask
        end If

    End Sub

    Sub write
        If flag_sw_rxc_inv_ctl = &H0 Then read
        If flag_sw_rxc_inv_ctl = &H0 Then write_sw_rxc_inv_ctl_value = get_sw_rxc_inv_ctl

        regValue = leftShift((write_sw_rxc_inv_ctl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_rxc_inv_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if sw_rxc_inv_ctl_mask = mask then
                read_sw_rxc_inv_ctl_value = data_low
            else
                read_sw_rxc_inv_ctl_value = (data_low - H8000_0000) and sw_rxc_inv_ctl_mask
            end If
        else
            read_sw_rxc_inv_ctl_value = data_low and sw_rxc_inv_ctl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_rxc_inv_ctl_value = &H0
        flag_sw_rxc_inv_ctl        = &H0
    End Sub
End Class


'' @REGISTER : IO_sw_tx_pipeline_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_tx_pipeline_en                          [8:0]            get_sw_tx_pipeline_en
''                                                             set_sw_tx_pipeline_en
''                                                             read_sw_tx_pipeline_en
''                                                             write_sw_tx_pipeline_en
''---------------------------------------------------------------------------------
Class REGISTER_IO_sw_tx_pipeline_ctl
    Private write_sw_tx_pipeline_en_value
    Private read_sw_tx_pipeline_en_value
    Private flag_sw_tx_pipeline_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_tx_pipeline_en
        get_sw_tx_pipeline_en = read_sw_tx_pipeline_en_value
    End Property

    Property Let set_sw_tx_pipeline_en(aData)
        write_sw_tx_pipeline_en_value = aData
        flag_sw_tx_pipeline_en        = &H1
    End Property

    Property Get read_sw_tx_pipeline_en
        read
        read_sw_tx_pipeline_en = read_sw_tx_pipeline_en_value
    End Property

    Property Let write_sw_tx_pipeline_en(aData)
        set_sw_tx_pipeline_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_tx_pipeline_en_mask = &H1ff
        if data_low > LONG_MAX then
            if sw_tx_pipeline_en_mask = mask then
                read_sw_tx_pipeline_en_value = data_low
            else
                read_sw_tx_pipeline_en_value = (data_low - H8000_0000) and sw_tx_pipeline_en_mask
            end If
        else
            read_sw_tx_pipeline_en_value = data_low and sw_tx_pipeline_en_mask
        end If

    End Sub

    Sub write
        If flag_sw_tx_pipeline_en = &H0 Then read
        If flag_sw_tx_pipeline_en = &H0 Then write_sw_tx_pipeline_en_value = get_sw_tx_pipeline_en

        regValue = leftShift((write_sw_tx_pipeline_en_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_tx_pipeline_en_mask = &H1ff
        if data_low > LONG_MAX then
            if sw_tx_pipeline_en_mask = mask then
                read_sw_tx_pipeline_en_value = data_low
            else
                read_sw_tx_pipeline_en_value = (data_low - H8000_0000) and sw_tx_pipeline_en_mask
            end If
        else
            read_sw_tx_pipeline_en_value = data_low and sw_tx_pipeline_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_tx_pipeline_en_value = &H0
        flag_sw_tx_pipeline_en        = &H0
    End Sub
End Class


'' @REGISTER : IO_sw_rx_pipeline_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_rx_pipeline_en                          [8:0]            get_sw_rx_pipeline_en
''                                                             set_sw_rx_pipeline_en
''                                                             read_sw_rx_pipeline_en
''                                                             write_sw_rx_pipeline_en
''---------------------------------------------------------------------------------
Class REGISTER_IO_sw_rx_pipeline_ctl
    Private write_sw_rx_pipeline_en_value
    Private read_sw_rx_pipeline_en_value
    Private flag_sw_rx_pipeline_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_rx_pipeline_en
        get_sw_rx_pipeline_en = read_sw_rx_pipeline_en_value
    End Property

    Property Let set_sw_rx_pipeline_en(aData)
        write_sw_rx_pipeline_en_value = aData
        flag_sw_rx_pipeline_en        = &H1
    End Property

    Property Get read_sw_rx_pipeline_en
        read
        read_sw_rx_pipeline_en = read_sw_rx_pipeline_en_value
    End Property

    Property Let write_sw_rx_pipeline_en(aData)
        set_sw_rx_pipeline_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_rx_pipeline_en_mask = &H1ff
        if data_low > LONG_MAX then
            if sw_rx_pipeline_en_mask = mask then
                read_sw_rx_pipeline_en_value = data_low
            else
                read_sw_rx_pipeline_en_value = (data_low - H8000_0000) and sw_rx_pipeline_en_mask
            end If
        else
            read_sw_rx_pipeline_en_value = data_low and sw_rx_pipeline_en_mask
        end If

    End Sub

    Sub write
        If flag_sw_rx_pipeline_en = &H0 Then read
        If flag_sw_rx_pipeline_en = &H0 Then write_sw_rx_pipeline_en_value = get_sw_rx_pipeline_en

        regValue = leftShift((write_sw_rx_pipeline_en_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_rx_pipeline_en_mask = &H1ff
        if data_low > LONG_MAX then
            if sw_rx_pipeline_en_mask = mask then
                read_sw_rx_pipeline_en_value = data_low
            else
                read_sw_rx_pipeline_en_value = (data_low - H8000_0000) and sw_rx_pipeline_en_mask
            end If
        else
            read_sw_rx_pipeline_en_value = data_low and sw_rx_pipeline_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_rx_pipeline_en_value = &H0
        flag_sw_rx_pipeline_en        = &H0
    End Sub
End Class


'' @REGISTER : IO_sw_ovrd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ovrd_rx_pause_sel                          [11:11]          get_ovrd_rx_pause_sel
''                                                             set_ovrd_rx_pause_sel
''                                                             read_ovrd_rx_pause_sel
''                                                             write_ovrd_rx_pause_sel
''---------------------------------------------------------------------------------
'' ovrd_tx_pause_sel                          [10:10]          get_ovrd_tx_pause_sel
''                                                             set_ovrd_tx_pause_sel
''                                                             read_ovrd_tx_pause_sel
''                                                             write_ovrd_tx_pause_sel
''---------------------------------------------------------------------------------
'' ovrd_link_sel                              [9:9]            get_ovrd_link_sel
''                                                             set_ovrd_link_sel
''                                                             read_ovrd_link_sel
''                                                             write_ovrd_link_sel
''---------------------------------------------------------------------------------
'' ovrd_spd_sel                               [8:8]            get_ovrd_spd_sel
''                                                             set_ovrd_spd_sel
''                                                             read_ovrd_spd_sel
''                                                             write_ovrd_spd_sel
''---------------------------------------------------------------------------------
'' ovrd_rx_pause_val                          [4:4]            get_ovrd_rx_pause_val
''                                                             set_ovrd_rx_pause_val
''                                                             read_ovrd_rx_pause_val
''                                                             write_ovrd_rx_pause_val
''---------------------------------------------------------------------------------
'' ovrd_tx_pause_val                          [3:3]            get_ovrd_tx_pause_val
''                                                             set_ovrd_tx_pause_val
''                                                             read_ovrd_tx_pause_val
''                                                             write_ovrd_tx_pause_val
''---------------------------------------------------------------------------------
'' ovrd_link_val                              [2:2]            get_ovrd_link_val
''                                                             set_ovrd_link_val
''                                                             read_ovrd_link_val
''                                                             write_ovrd_link_val
''---------------------------------------------------------------------------------
'' ovrd_spd_val                               [1:0]            get_ovrd_spd_val
''                                                             set_ovrd_spd_val
''                                                             read_ovrd_spd_val
''                                                             write_ovrd_spd_val
''---------------------------------------------------------------------------------
Class REGISTER_IO_sw_ovrd
    Private write_ovrd_rx_pause_sel_value
    Private read_ovrd_rx_pause_sel_value
    Private flag_ovrd_rx_pause_sel
    Private write_ovrd_tx_pause_sel_value
    Private read_ovrd_tx_pause_sel_value
    Private flag_ovrd_tx_pause_sel
    Private write_ovrd_link_sel_value
    Private read_ovrd_link_sel_value
    Private flag_ovrd_link_sel
    Private write_ovrd_spd_sel_value
    Private read_ovrd_spd_sel_value
    Private flag_ovrd_spd_sel
    Private write_ovrd_rx_pause_val_value
    Private read_ovrd_rx_pause_val_value
    Private flag_ovrd_rx_pause_val
    Private write_ovrd_tx_pause_val_value
    Private read_ovrd_tx_pause_val_value
    Private flag_ovrd_tx_pause_val
    Private write_ovrd_link_val_value
    Private read_ovrd_link_val_value
    Private flag_ovrd_link_val
    Private write_ovrd_spd_val_value
    Private read_ovrd_spd_val_value
    Private flag_ovrd_spd_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ovrd_rx_pause_sel
        get_ovrd_rx_pause_sel = read_ovrd_rx_pause_sel_value
    End Property

    Property Let set_ovrd_rx_pause_sel(aData)
        write_ovrd_rx_pause_sel_value = aData
        flag_ovrd_rx_pause_sel        = &H1
    End Property

    Property Get read_ovrd_rx_pause_sel
        read
        read_ovrd_rx_pause_sel = read_ovrd_rx_pause_sel_value
    End Property

    Property Let write_ovrd_rx_pause_sel(aData)
        set_ovrd_rx_pause_sel = aData
        write
    End Property

    Property Get get_ovrd_tx_pause_sel
        get_ovrd_tx_pause_sel = read_ovrd_tx_pause_sel_value
    End Property

    Property Let set_ovrd_tx_pause_sel(aData)
        write_ovrd_tx_pause_sel_value = aData
        flag_ovrd_tx_pause_sel        = &H1
    End Property

    Property Get read_ovrd_tx_pause_sel
        read
        read_ovrd_tx_pause_sel = read_ovrd_tx_pause_sel_value
    End Property

    Property Let write_ovrd_tx_pause_sel(aData)
        set_ovrd_tx_pause_sel = aData
        write
    End Property

    Property Get get_ovrd_link_sel
        get_ovrd_link_sel = read_ovrd_link_sel_value
    End Property

    Property Let set_ovrd_link_sel(aData)
        write_ovrd_link_sel_value = aData
        flag_ovrd_link_sel        = &H1
    End Property

    Property Get read_ovrd_link_sel
        read
        read_ovrd_link_sel = read_ovrd_link_sel_value
    End Property

    Property Let write_ovrd_link_sel(aData)
        set_ovrd_link_sel = aData
        write
    End Property

    Property Get get_ovrd_spd_sel
        get_ovrd_spd_sel = read_ovrd_spd_sel_value
    End Property

    Property Let set_ovrd_spd_sel(aData)
        write_ovrd_spd_sel_value = aData
        flag_ovrd_spd_sel        = &H1
    End Property

    Property Get read_ovrd_spd_sel
        read
        read_ovrd_spd_sel = read_ovrd_spd_sel_value
    End Property

    Property Let write_ovrd_spd_sel(aData)
        set_ovrd_spd_sel = aData
        write
    End Property

    Property Get get_ovrd_rx_pause_val
        get_ovrd_rx_pause_val = read_ovrd_rx_pause_val_value
    End Property

    Property Let set_ovrd_rx_pause_val(aData)
        write_ovrd_rx_pause_val_value = aData
        flag_ovrd_rx_pause_val        = &H1
    End Property

    Property Get read_ovrd_rx_pause_val
        read
        read_ovrd_rx_pause_val = read_ovrd_rx_pause_val_value
    End Property

    Property Let write_ovrd_rx_pause_val(aData)
        set_ovrd_rx_pause_val = aData
        write
    End Property

    Property Get get_ovrd_tx_pause_val
        get_ovrd_tx_pause_val = read_ovrd_tx_pause_val_value
    End Property

    Property Let set_ovrd_tx_pause_val(aData)
        write_ovrd_tx_pause_val_value = aData
        flag_ovrd_tx_pause_val        = &H1
    End Property

    Property Get read_ovrd_tx_pause_val
        read
        read_ovrd_tx_pause_val = read_ovrd_tx_pause_val_value
    End Property

    Property Let write_ovrd_tx_pause_val(aData)
        set_ovrd_tx_pause_val = aData
        write
    End Property

    Property Get get_ovrd_link_val
        get_ovrd_link_val = read_ovrd_link_val_value
    End Property

    Property Let set_ovrd_link_val(aData)
        write_ovrd_link_val_value = aData
        flag_ovrd_link_val        = &H1
    End Property

    Property Get read_ovrd_link_val
        read
        read_ovrd_link_val = read_ovrd_link_val_value
    End Property

    Property Let write_ovrd_link_val(aData)
        set_ovrd_link_val = aData
        write
    End Property

    Property Get get_ovrd_spd_val
        get_ovrd_spd_val = read_ovrd_spd_val_value
    End Property

    Property Let set_ovrd_spd_val(aData)
        write_ovrd_spd_val_value = aData
        flag_ovrd_spd_val        = &H1
    End Property

    Property Get read_ovrd_spd_val
        read
        read_ovrd_spd_val = read_ovrd_spd_val_value
    End Property

    Property Let write_ovrd_spd_val(aData)
        set_ovrd_spd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ovrd_rx_pause_sel_value = rightShift(data_low, 11) and &H1
        read_ovrd_tx_pause_sel_value = rightShift(data_low, 10) and &H1
        read_ovrd_link_sel_value = rightShift(data_low, 9) and &H1
        read_ovrd_spd_sel_value = rightShift(data_low, 8) and &H1
        read_ovrd_rx_pause_val_value = rightShift(data_low, 4) and &H1
        read_ovrd_tx_pause_val_value = rightShift(data_low, 3) and &H1
        read_ovrd_link_val_value = rightShift(data_low, 2) and &H1
        ovrd_spd_val_mask = &H3
        if data_low > LONG_MAX then
            if ovrd_spd_val_mask = mask then
                read_ovrd_spd_val_value = data_low
            else
                read_ovrd_spd_val_value = (data_low - H8000_0000) and ovrd_spd_val_mask
            end If
        else
            read_ovrd_spd_val_value = data_low and ovrd_spd_val_mask
        end If

    End Sub

    Sub write
        If flag_ovrd_rx_pause_sel = &H0 or flag_ovrd_tx_pause_sel = &H0 or flag_ovrd_link_sel = &H0 or flag_ovrd_spd_sel = &H0 or flag_ovrd_rx_pause_val = &H0 or flag_ovrd_tx_pause_val = &H0 or flag_ovrd_link_val = &H0 or flag_ovrd_spd_val = &H0 Then read
        If flag_ovrd_rx_pause_sel = &H0 Then write_ovrd_rx_pause_sel_value = get_ovrd_rx_pause_sel
        If flag_ovrd_tx_pause_sel = &H0 Then write_ovrd_tx_pause_sel_value = get_ovrd_tx_pause_sel
        If flag_ovrd_link_sel = &H0 Then write_ovrd_link_sel_value = get_ovrd_link_sel
        If flag_ovrd_spd_sel = &H0 Then write_ovrd_spd_sel_value = get_ovrd_spd_sel
        If flag_ovrd_rx_pause_val = &H0 Then write_ovrd_rx_pause_val_value = get_ovrd_rx_pause_val
        If flag_ovrd_tx_pause_val = &H0 Then write_ovrd_tx_pause_val_value = get_ovrd_tx_pause_val
        If flag_ovrd_link_val = &H0 Then write_ovrd_link_val_value = get_ovrd_link_val
        If flag_ovrd_spd_val = &H0 Then write_ovrd_spd_val_value = get_ovrd_spd_val

        regValue = leftShift((write_ovrd_rx_pause_sel_value and &H1), 11) + leftShift((write_ovrd_tx_pause_sel_value and &H1), 10) + leftShift((write_ovrd_link_sel_value and &H1), 9) + leftShift((write_ovrd_spd_sel_value and &H1), 8) + leftShift((write_ovrd_rx_pause_val_value and &H1), 4) + leftShift((write_ovrd_tx_pause_val_value and &H1), 3) + leftShift((write_ovrd_link_val_value and &H1), 2) + leftShift((write_ovrd_spd_val_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ovrd_rx_pause_sel_value = rightShift(data_low, 11) and &H1
        read_ovrd_tx_pause_sel_value = rightShift(data_low, 10) and &H1
        read_ovrd_link_sel_value = rightShift(data_low, 9) and &H1
        read_ovrd_spd_sel_value = rightShift(data_low, 8) and &H1
        read_ovrd_rx_pause_val_value = rightShift(data_low, 4) and &H1
        read_ovrd_tx_pause_val_value = rightShift(data_low, 3) and &H1
        read_ovrd_link_val_value = rightShift(data_low, 2) and &H1
        ovrd_spd_val_mask = &H3
        if data_low > LONG_MAX then
            if ovrd_spd_val_mask = mask then
                read_ovrd_spd_val_value = data_low
            else
                read_ovrd_spd_val_value = (data_low - H8000_0000) and ovrd_spd_val_mask
            end If
        else
            read_ovrd_spd_val_value = data_low and ovrd_spd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ovrd_rx_pause_sel_value = &H0
        flag_ovrd_rx_pause_sel        = &H0
        write_ovrd_tx_pause_sel_value = &H0
        flag_ovrd_tx_pause_sel        = &H0
        write_ovrd_link_sel_value = &H0
        flag_ovrd_link_sel        = &H0
        write_ovrd_spd_sel_value = &H0
        flag_ovrd_spd_sel        = &H0
        write_ovrd_rx_pause_val_value = &H0
        flag_ovrd_rx_pause_val        = &H0
        write_ovrd_tx_pause_val_value = &H0
        flag_ovrd_tx_pause_val        = &H0
        write_ovrd_link_val_value = &H0
        flag_ovrd_link_val        = &H0
        write_ovrd_spd_val_value = &H0
        flag_ovrd_spd_val        = &H0
    End Sub
End Class


'' @REGISTER : IO_test_bus_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ovstb                                      [15:15]          get_ovstb
''                                                             set_ovstb
''                                                             read_ovstb
''                                                             write_ovstb
''---------------------------------------------------------------------------------
'' burnin_clk_on_ledclk_en                    [14:14]          get_burnin_clk_on_ledclk_en
''                                                             set_burnin_clk_on_ledclk_en
''                                                             read_burnin_clk_on_ledclk_en
''                                                             write_burnin_clk_on_ledclk_en
''---------------------------------------------------------------------------------
'' Unused                                     [5:4]            get_Unused
''                                                             set_Unused
''                                                             read_Unused
''                                                             write_Unused
''---------------------------------------------------------------------------------
'' select_test_bus                            [3:0]            get_select_test_bus
''                                                             set_select_test_bus
''                                                             read_select_test_bus
''                                                             write_select_test_bus
''---------------------------------------------------------------------------------
Class REGISTER_IO_test_bus_select
    Private write_ovstb_value
    Private read_ovstb_value
    Private flag_ovstb
    Private write_burnin_clk_on_ledclk_en_value
    Private read_burnin_clk_on_ledclk_en_value
    Private flag_burnin_clk_on_ledclk_en
    Private write_Unused_value
    Private read_Unused_value
    Private flag_Unused
    Private write_select_test_bus_value
    Private read_select_test_bus_value
    Private flag_select_test_bus

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H70
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ovstb
        get_ovstb = read_ovstb_value
    End Property

    Property Let set_ovstb(aData)
        write_ovstb_value = aData
        flag_ovstb        = &H1
    End Property

    Property Get read_ovstb
        read
        read_ovstb = read_ovstb_value
    End Property

    Property Let write_ovstb(aData)
        set_ovstb = aData
        write
    End Property

    Property Get get_burnin_clk_on_ledclk_en
        get_burnin_clk_on_ledclk_en = read_burnin_clk_on_ledclk_en_value
    End Property

    Property Let set_burnin_clk_on_ledclk_en(aData)
        write_burnin_clk_on_ledclk_en_value = aData
        flag_burnin_clk_on_ledclk_en        = &H1
    End Property

    Property Get read_burnin_clk_on_ledclk_en
        read
        read_burnin_clk_on_ledclk_en = read_burnin_clk_on_ledclk_en_value
    End Property

    Property Let write_burnin_clk_on_ledclk_en(aData)
        set_burnin_clk_on_ledclk_en = aData
        write
    End Property

    Property Get get_Unused
        get_Unused = read_Unused_value
    End Property

    Property Let set_Unused(aData)
        write_Unused_value = aData
        flag_Unused        = &H1
    End Property

    Property Get read_Unused
        read
        read_Unused = read_Unused_value
    End Property

    Property Let write_Unused(aData)
        set_Unused = aData
        write
    End Property

    Property Get get_select_test_bus
        get_select_test_bus = read_select_test_bus_value
    End Property

    Property Let set_select_test_bus(aData)
        write_select_test_bus_value = aData
        flag_select_test_bus        = &H1
    End Property

    Property Get read_select_test_bus
        read
        read_select_test_bus = read_select_test_bus_value
    End Property

    Property Let write_select_test_bus(aData)
        set_select_test_bus = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ovstb_value = rightShift(data_low, 15) and &H1
        read_burnin_clk_on_ledclk_en_value = rightShift(data_low, 14) and &H1
        read_Unused_value = rightShift(data_low, 4) and &H3
        select_test_bus_mask = &Hf
        if data_low > LONG_MAX then
            if select_test_bus_mask = mask then
                read_select_test_bus_value = data_low
            else
                read_select_test_bus_value = (data_low - H8000_0000) and select_test_bus_mask
            end If
        else
            read_select_test_bus_value = data_low and select_test_bus_mask
        end If

    End Sub

    Sub write
        If flag_ovstb = &H0 or flag_burnin_clk_on_ledclk_en = &H0 or flag_Unused = &H0 or flag_select_test_bus = &H0 Then read
        If flag_ovstb = &H0 Then write_ovstb_value = get_ovstb
        If flag_burnin_clk_on_ledclk_en = &H0 Then write_burnin_clk_on_ledclk_en_value = get_burnin_clk_on_ledclk_en
        If flag_Unused = &H0 Then write_Unused_value = get_Unused
        If flag_select_test_bus = &H0 Then write_select_test_bus_value = get_select_test_bus

        regValue = leftShift((write_ovstb_value and &H1), 15) + leftShift((write_burnin_clk_on_ledclk_en_value and &H1), 14) + leftShift((write_Unused_value and &H3), 4) + leftShift((write_select_test_bus_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ovstb_value = rightShift(data_low, 15) and &H1
        read_burnin_clk_on_ledclk_en_value = rightShift(data_low, 14) and &H1
        read_Unused_value = rightShift(data_low, 4) and &H3
        select_test_bus_mask = &Hf
        if data_low > LONG_MAX then
            if select_test_bus_mask = mask then
                read_select_test_bus_value = data_low
            else
                read_select_test_bus_value = (data_low - H8000_0000) and select_test_bus_mask
            end If
        else
            read_select_test_bus_value = data_low and select_test_bus_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ovstb_value = &H0
        flag_ovstb        = &H0
        write_burnin_clk_on_ledclk_en_value = &H0
        flag_burnin_clk_on_ledclk_en        = &H0
        write_Unused_value = &H0
        flag_Unused        = &H0
        write_select_test_bus_value = &H0
        flag_select_test_bus        = &H0
    End Sub
End Class


'' @REGISTER : IO_p1588_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' p1588_sync_out_oeb                         [2:2]            get_p1588_sync_out_oeb
''                                                             set_p1588_sync_out_oeb
''                                                             read_p1588_sync_out_oeb
''                                                             write_p1588_sync_out_oeb
''---------------------------------------------------------------------------------
'' p1588_sync_out_sel                         [1:0]            get_p1588_sync_out_sel
''                                                             set_p1588_sync_out_sel
''                                                             read_p1588_sync_out_sel
''                                                             write_p1588_sync_out_sel
''---------------------------------------------------------------------------------
Class REGISTER_IO_p1588_config
    Private write_p1588_sync_out_oeb_value
    Private read_p1588_sync_out_oeb_value
    Private flag_p1588_sync_out_oeb
    Private write_p1588_sync_out_sel_value
    Private read_p1588_sync_out_sel_value
    Private flag_p1588_sync_out_sel

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H72
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_p1588_sync_out_oeb
        get_p1588_sync_out_oeb = read_p1588_sync_out_oeb_value
    End Property

    Property Let set_p1588_sync_out_oeb(aData)
        write_p1588_sync_out_oeb_value = aData
        flag_p1588_sync_out_oeb        = &H1
    End Property

    Property Get read_p1588_sync_out_oeb
        read
        read_p1588_sync_out_oeb = read_p1588_sync_out_oeb_value
    End Property

    Property Let write_p1588_sync_out_oeb(aData)
        set_p1588_sync_out_oeb = aData
        write
    End Property

    Property Get get_p1588_sync_out_sel
        get_p1588_sync_out_sel = read_p1588_sync_out_sel_value
    End Property

    Property Let set_p1588_sync_out_sel(aData)
        write_p1588_sync_out_sel_value = aData
        flag_p1588_sync_out_sel        = &H1
    End Property

    Property Get read_p1588_sync_out_sel
        read
        read_p1588_sync_out_sel = read_p1588_sync_out_sel_value
    End Property

    Property Let write_p1588_sync_out_sel(aData)
        set_p1588_sync_out_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_p1588_sync_out_oeb_value = rightShift(data_low, 2) and &H1
        p1588_sync_out_sel_mask = &H3
        if data_low > LONG_MAX then
            if p1588_sync_out_sel_mask = mask then
                read_p1588_sync_out_sel_value = data_low
            else
                read_p1588_sync_out_sel_value = (data_low - H8000_0000) and p1588_sync_out_sel_mask
            end If
        else
            read_p1588_sync_out_sel_value = data_low and p1588_sync_out_sel_mask
        end If

    End Sub

    Sub write
        If flag_p1588_sync_out_oeb = &H0 or flag_p1588_sync_out_sel = &H0 Then read
        If flag_p1588_sync_out_oeb = &H0 Then write_p1588_sync_out_oeb_value = get_p1588_sync_out_oeb
        If flag_p1588_sync_out_sel = &H0 Then write_p1588_sync_out_sel_value = get_p1588_sync_out_sel

        regValue = leftShift((write_p1588_sync_out_oeb_value and &H1), 2) + leftShift((write_p1588_sync_out_sel_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_p1588_sync_out_oeb_value = rightShift(data_low, 2) and &H1
        p1588_sync_out_sel_mask = &H3
        if data_low > LONG_MAX then
            if p1588_sync_out_sel_mask = mask then
                read_p1588_sync_out_sel_value = data_low
            else
                read_p1588_sync_out_sel_value = (data_low - H8000_0000) and p1588_sync_out_sel_mask
            end If
        else
            read_p1588_sync_out_sel_value = data_low and p1588_sync_out_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_p1588_sync_out_oeb_value = &H0
        flag_p1588_sync_out_oeb        = &H0
        write_p1588_sync_out_sel_value = &H0
        flag_p1588_sync_out_sel        = &H0
    End Sub
End Class


'' @REGISTER : IO_p1588_sync_gen
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' io_sync_in1                                [3:3]            get_io_sync_in1
''                                                             set_io_sync_in1
''                                                             read_io_sync_in1
''                                                             write_io_sync_in1
''---------------------------------------------------------------------------------
'' io_sync_in0                                [2:2]            get_io_sync_in0
''                                                             set_io_sync_in0
''                                                             read_io_sync_in0
''                                                             write_io_sync_in0
''---------------------------------------------------------------------------------
'' brphy_sync_in1                             [1:1]            get_brphy_sync_in1
''                                                             set_brphy_sync_in1
''                                                             read_brphy_sync_in1
''                                                             write_brphy_sync_in1
''---------------------------------------------------------------------------------
'' brphy_sync_in0                             [0:0]            get_brphy_sync_in0
''                                                             set_brphy_sync_in0
''                                                             read_brphy_sync_in0
''                                                             write_brphy_sync_in0
''---------------------------------------------------------------------------------
Class REGISTER_IO_p1588_sync_gen
    Private write_io_sync_in1_value
    Private read_io_sync_in1_value
    Private flag_io_sync_in1
    Private write_io_sync_in0_value
    Private read_io_sync_in0_value
    Private flag_io_sync_in0
    Private write_brphy_sync_in1_value
    Private read_brphy_sync_in1_value
    Private flag_brphy_sync_in1
    Private write_brphy_sync_in0_value
    Private read_brphy_sync_in0_value
    Private flag_brphy_sync_in0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H74
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_io_sync_in1
        get_io_sync_in1 = read_io_sync_in1_value
    End Property

    Property Let set_io_sync_in1(aData)
        write_io_sync_in1_value = aData
        flag_io_sync_in1        = &H1
    End Property

    Property Get read_io_sync_in1
        read
        read_io_sync_in1 = read_io_sync_in1_value
    End Property

    Property Let write_io_sync_in1(aData)
        set_io_sync_in1 = aData
        write
    End Property

    Property Get get_io_sync_in0
        get_io_sync_in0 = read_io_sync_in0_value
    End Property

    Property Let set_io_sync_in0(aData)
        write_io_sync_in0_value = aData
        flag_io_sync_in0        = &H1
    End Property

    Property Get read_io_sync_in0
        read
        read_io_sync_in0 = read_io_sync_in0_value
    End Property

    Property Let write_io_sync_in0(aData)
        set_io_sync_in0 = aData
        write
    End Property

    Property Get get_brphy_sync_in1
        get_brphy_sync_in1 = read_brphy_sync_in1_value
    End Property

    Property Let set_brphy_sync_in1(aData)
        write_brphy_sync_in1_value = aData
        flag_brphy_sync_in1        = &H1
    End Property

    Property Get read_brphy_sync_in1
        read
        read_brphy_sync_in1 = read_brphy_sync_in1_value
    End Property

    Property Let write_brphy_sync_in1(aData)
        set_brphy_sync_in1 = aData
        write
    End Property

    Property Get get_brphy_sync_in0
        get_brphy_sync_in0 = read_brphy_sync_in0_value
    End Property

    Property Let set_brphy_sync_in0(aData)
        write_brphy_sync_in0_value = aData
        flag_brphy_sync_in0        = &H1
    End Property

    Property Get read_brphy_sync_in0
        read
        read_brphy_sync_in0 = read_brphy_sync_in0_value
    End Property

    Property Let write_brphy_sync_in0(aData)
        set_brphy_sync_in0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_io_sync_in1_value = rightShift(data_low, 3) and &H1
        read_io_sync_in0_value = rightShift(data_low, 2) and &H1
        read_brphy_sync_in1_value = rightShift(data_low, 1) and &H1
        brphy_sync_in0_mask = &H1
        if data_low > LONG_MAX then
            if brphy_sync_in0_mask = mask then
                read_brphy_sync_in0_value = data_low
            else
                read_brphy_sync_in0_value = (data_low - H8000_0000) and brphy_sync_in0_mask
            end If
        else
            read_brphy_sync_in0_value = data_low and brphy_sync_in0_mask
        end If

    End Sub

    Sub write
        If flag_io_sync_in1 = &H0 or flag_io_sync_in0 = &H0 or flag_brphy_sync_in1 = &H0 or flag_brphy_sync_in0 = &H0 Then read
        If flag_io_sync_in1 = &H0 Then write_io_sync_in1_value = get_io_sync_in1
        If flag_io_sync_in0 = &H0 Then write_io_sync_in0_value = get_io_sync_in0
        If flag_brphy_sync_in1 = &H0 Then write_brphy_sync_in1_value = get_brphy_sync_in1
        If flag_brphy_sync_in0 = &H0 Then write_brphy_sync_in0_value = get_brphy_sync_in0

        regValue = leftShift((write_io_sync_in1_value and &H1), 3) + leftShift((write_io_sync_in0_value and &H1), 2) + leftShift((write_brphy_sync_in1_value and &H1), 1) + leftShift((write_brphy_sync_in0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_io_sync_in1_value = rightShift(data_low, 3) and &H1
        read_io_sync_in0_value = rightShift(data_low, 2) and &H1
        read_brphy_sync_in1_value = rightShift(data_low, 1) and &H1
        brphy_sync_in0_mask = &H1
        if data_low > LONG_MAX then
            if brphy_sync_in0_mask = mask then
                read_brphy_sync_in0_value = data_low
            else
                read_brphy_sync_in0_value = (data_low - H8000_0000) and brphy_sync_in0_mask
            end If
        else
            read_brphy_sync_in0_value = data_low and brphy_sync_in0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_io_sync_in1_value = &H0
        flag_io_sync_in1        = &H0
        write_io_sync_in0_value = &H0
        flag_io_sync_in0        = &H0
        write_brphy_sync_in1_value = &H0
        flag_brphy_sync_in1        = &H0
        write_brphy_sync_in0_value = &H0
        flag_brphy_sync_in0        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IO_CTL                                     [15:0]           get_IO_CTL
''                                                             set_IO_CTL
''                                                             read_IO_CTL
''                                                             write_IO_CTL
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_ctl
    Private write_IO_CTL_value
    Private read_IO_CTL_value
    Private flag_IO_CTL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H76
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IO_CTL
        get_IO_CTL = read_IO_CTL_value
    End Property

    Property Let set_IO_CTL(aData)
        write_IO_CTL_value = aData
        flag_IO_CTL        = &H1
    End Property

    Property Get read_IO_CTL
        read
        read_IO_CTL = read_IO_CTL_value
    End Property

    Property Let write_IO_CTL(aData)
        set_IO_CTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IO_CTL_mask = &Hffff
        if data_low > LONG_MAX then
            if IO_CTL_mask = mask then
                read_IO_CTL_value = data_low
            else
                read_IO_CTL_value = (data_low - H8000_0000) and IO_CTL_mask
            end If
        else
            read_IO_CTL_value = data_low and IO_CTL_mask
        end If

    End Sub

    Sub write
        If flag_IO_CTL = &H0 Then read
        If flag_IO_CTL = &H0 Then write_IO_CTL_value = get_IO_CTL

        regValue = leftShift((write_IO_CTL_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IO_CTL_mask = &Hffff
        if data_low > LONG_MAX then
            if IO_CTL_mask = mask then
                read_IO_CTL_value = data_low
            else
                read_IO_CTL_value = (data_low - H8000_0000) and IO_CTL_mask
            end If
        else
            read_IO_CTL_value = data_low and IO_CTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IO_CTL_value = &H0
        flag_IO_CTL        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_fifo_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fifo_ctl                                   [15:0]           get_fifo_ctl
''                                                             set_fifo_ctl
''                                                             read_fifo_ctl
''                                                             write_fifo_ctl
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_fifo_ctl
    Private write_fifo_ctl_value
    Private read_fifo_ctl_value
    Private flag_fifo_ctl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fifo_ctl
        get_fifo_ctl = read_fifo_ctl_value
    End Property

    Property Let set_fifo_ctl(aData)
        write_fifo_ctl_value = aData
        flag_fifo_ctl        = &H1
    End Property

    Property Get read_fifo_ctl
        read
        read_fifo_ctl = read_fifo_ctl_value
    End Property

    Property Let write_fifo_ctl(aData)
        set_fifo_ctl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fifo_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if fifo_ctl_mask = mask then
                read_fifo_ctl_value = data_low
            else
                read_fifo_ctl_value = (data_low - H8000_0000) and fifo_ctl_mask
            end If
        else
            read_fifo_ctl_value = data_low and fifo_ctl_mask
        end If

    End Sub

    Sub write
        If flag_fifo_ctl = &H0 Then read
        If flag_fifo_ctl = &H0 Then write_fifo_ctl_value = get_fifo_ctl

        regValue = leftShift((write_fifo_ctl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fifo_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if fifo_ctl_mask = mask then
                read_fifo_ctl_value = data_low
            else
                read_fifo_ctl_value = (data_low - H8000_0000) and fifo_ctl_mask
            end If
        else
            read_fifo_ctl_value = data_low and fifo_ctl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fifo_ctl_value = &H0
        flag_fifo_ctl        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_fifo_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fifo_ctl                                   [15:0]           get_fifo_ctl
''                                                             set_fifo_ctl
''                                                             read_fifo_ctl
''                                                             write_fifo_ctl
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_fifo_ctl
    Private write_fifo_ctl_value
    Private read_fifo_ctl_value
    Private flag_fifo_ctl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fifo_ctl
        get_fifo_ctl = read_fifo_ctl_value
    End Property

    Property Let set_fifo_ctl(aData)
        write_fifo_ctl_value = aData
        flag_fifo_ctl        = &H1
    End Property

    Property Get read_fifo_ctl
        read
        read_fifo_ctl = read_fifo_ctl_value
    End Property

    Property Let write_fifo_ctl(aData)
        set_fifo_ctl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fifo_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if fifo_ctl_mask = mask then
                read_fifo_ctl_value = data_low
            else
                read_fifo_ctl_value = (data_low - H8000_0000) and fifo_ctl_mask
            end If
        else
            read_fifo_ctl_value = data_low and fifo_ctl_mask
        end If

    End Sub

    Sub write
        If flag_fifo_ctl = &H0 Then read
        If flag_fifo_ctl = &H0 Then write_fifo_ctl_value = get_fifo_ctl

        regValue = leftShift((write_fifo_ctl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fifo_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if fifo_ctl_mask = mask then
                read_fifo_ctl_value = data_low
            else
                read_fifo_ctl_value = (data_low - H8000_0000) and fifo_ctl_mask
            end If
        else
            read_fifo_ctl_value = data_low and fifo_ctl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fifo_ctl_value = &H0
        flag_fifo_ctl        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_dll_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dll_ctrl                                   [15:0]           get_dll_ctrl
''                                                             set_dll_ctrl
''                                                             read_dll_ctrl
''                                                             write_dll_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_dll_ctrl
    Private write_dll_ctrl_value
    Private read_dll_ctrl_value
    Private flag_dll_ctrl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dll_ctrl
        get_dll_ctrl = read_dll_ctrl_value
    End Property

    Property Let set_dll_ctrl(aData)
        write_dll_ctrl_value = aData
        flag_dll_ctrl        = &H1
    End Property

    Property Get read_dll_ctrl
        read
        read_dll_ctrl = read_dll_ctrl_value
    End Property

    Property Let write_dll_ctrl(aData)
        set_dll_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_ctrl_mask = mask then
                read_dll_ctrl_value = data_low
            else
                read_dll_ctrl_value = (data_low - H8000_0000) and dll_ctrl_mask
            end If
        else
            read_dll_ctrl_value = data_low and dll_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_dll_ctrl = &H0 Then read
        If flag_dll_ctrl = &H0 Then write_dll_ctrl_value = get_dll_ctrl

        regValue = leftShift((write_dll_ctrl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_ctrl_mask = mask then
                read_dll_ctrl_value = data_low
            else
                read_dll_ctrl_value = (data_low - H8000_0000) and dll_ctrl_mask
            end If
        else
            read_dll_ctrl_value = data_low and dll_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dll_ctrl_value = &H0
        flag_dll_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii1_dll_cfg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dll_cfg                                    [15:0]           get_dll_cfg
''                                                             set_dll_cfg
''                                                             read_dll_cfg
''                                                             write_dll_cfg
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii1_dll_cfg
    Private write_dll_cfg_value
    Private read_dll_cfg_value
    Private flag_dll_cfg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dll_cfg
        get_dll_cfg = read_dll_cfg_value
    End Property

    Property Let set_dll_cfg(aData)
        write_dll_cfg_value = aData
        flag_dll_cfg        = &H1
    End Property

    Property Get read_dll_cfg
        read
        read_dll_cfg = read_dll_cfg_value
    End Property

    Property Let write_dll_cfg(aData)
        set_dll_cfg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_cfg_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_cfg_mask = mask then
                read_dll_cfg_value = data_low
            else
                read_dll_cfg_value = (data_low - H8000_0000) and dll_cfg_mask
            end If
        else
            read_dll_cfg_value = data_low and dll_cfg_mask
        end If

    End Sub

    Sub write
        If flag_dll_cfg = &H0 Then read
        If flag_dll_cfg = &H0 Then write_dll_cfg_value = get_dll_cfg

        regValue = leftShift((write_dll_cfg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_cfg_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_cfg_mask = mask then
                read_dll_cfg_value = data_low
            else
                read_dll_cfg_value = (data_low - H8000_0000) and dll_cfg_mask
            end If
        else
            read_dll_cfg_value = data_low and dll_cfg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dll_cfg_value = &H0
        flag_dll_cfg        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_dll_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dll_ctrl                                   [15:0]           get_dll_ctrl
''                                                             set_dll_ctrl
''                                                             read_dll_ctrl
''                                                             write_dll_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_dll_ctrl
    Private write_dll_ctrl_value
    Private read_dll_ctrl_value
    Private flag_dll_ctrl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dll_ctrl
        get_dll_ctrl = read_dll_ctrl_value
    End Property

    Property Let set_dll_ctrl(aData)
        write_dll_ctrl_value = aData
        flag_dll_ctrl        = &H1
    End Property

    Property Get read_dll_ctrl
        read
        read_dll_ctrl = read_dll_ctrl_value
    End Property

    Property Let write_dll_ctrl(aData)
        set_dll_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_ctrl_mask = mask then
                read_dll_ctrl_value = data_low
            else
                read_dll_ctrl_value = (data_low - H8000_0000) and dll_ctrl_mask
            end If
        else
            read_dll_ctrl_value = data_low and dll_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_dll_ctrl = &H0 Then read
        If flag_dll_ctrl = &H0 Then write_dll_ctrl_value = get_dll_ctrl

        regValue = leftShift((write_dll_ctrl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_ctrl_mask = mask then
                read_dll_ctrl_value = data_low
            else
                read_dll_ctrl_value = (data_low - H8000_0000) and dll_ctrl_mask
            end If
        else
            read_dll_ctrl_value = data_low and dll_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dll_ctrl_value = &H0
        flag_dll_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii2_dll_cfg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dll_cfg                                    [15:0]           get_dll_cfg
''                                                             set_dll_cfg
''                                                             read_dll_cfg
''                                                             write_dll_cfg
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii2_dll_cfg
    Private write_dll_cfg_value
    Private read_dll_cfg_value
    Private flag_dll_cfg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H82
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dll_cfg
        get_dll_cfg = read_dll_cfg_value
    End Property

    Property Let set_dll_cfg(aData)
        write_dll_cfg_value = aData
        flag_dll_cfg        = &H1
    End Property

    Property Get read_dll_cfg
        read
        read_dll_cfg = read_dll_cfg_value
    End Property

    Property Let write_dll_cfg(aData)
        set_dll_cfg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_cfg_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_cfg_mask = mask then
                read_dll_cfg_value = data_low
            else
                read_dll_cfg_value = (data_low - H8000_0000) and dll_cfg_mask
            end If
        else
            read_dll_cfg_value = data_low and dll_cfg_mask
        end If

    End Sub

    Sub write
        If flag_dll_cfg = &H0 Then read
        If flag_dll_cfg = &H0 Then write_dll_cfg_value = get_dll_cfg

        regValue = leftShift((write_dll_cfg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_cfg_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_cfg_mask = mask then
                read_dll_cfg_value = data_low
            else
                read_dll_cfg_value = (data_low - H8000_0000) and dll_cfg_mask
            end If
        else
            read_dll_cfg_value = data_low and dll_cfg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dll_cfg_value = &H0
        flag_dll_cfg        = &H0
    End Sub
End Class


'' @REGISTER : IO_mii3_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' clock_en_mii3                              [15:15]          get_clock_en_mii3
''                                                             set_clock_en_mii3
''                                                             read_clock_en_mii3
''                                                             write_clock_en_mii3
''---------------------------------------------------------------------------------
'' tx_pads_ind_mii3                           [14:14]          get_tx_pads_ind_mii3
''                                                             set_tx_pads_ind_mii3
''                                                             read_tx_pads_ind_mii3
''                                                             write_tx_pads_ind_mii3
''---------------------------------------------------------------------------------
'' txclk_pad_ind_mii3                         [13:13]          get_txclk_pad_ind_mii3
''                                                             set_txclk_pad_ind_mii3
''                                                             read_txclk_pad_ind_mii3
''                                                             write_txclk_pad_ind_mii3
''---------------------------------------------------------------------------------
'' src_mii3                                   [6:5]            get_src_mii3
''                                                             set_src_mii3
''                                                             read_src_mii3
''                                                             write_src_mii3
''---------------------------------------------------------------------------------
'' amp_enable_mii3                            [4:4]            get_amp_enable_mii3
''                                                             set_amp_enable_mii3
''                                                             read_amp_enable_mii3
''                                                             write_amp_enable_mii3
''---------------------------------------------------------------------------------
'' sel_mii3                                   [3:1]            get_sel_mii3
''                                                             set_sel_mii3
''                                                             read_sel_mii3
''                                                             write_sel_mii3
''---------------------------------------------------------------------------------
'' sel_gmii_mii3                              [0:0]            get_sel_gmii_mii3
''                                                             set_sel_gmii_mii3
''                                                             read_sel_gmii_mii3
''                                                             write_sel_gmii_mii3
''---------------------------------------------------------------------------------
Class REGISTER_IO_mii3_config
    Private write_clock_en_mii3_value
    Private read_clock_en_mii3_value
    Private flag_clock_en_mii3
    Private write_tx_pads_ind_mii3_value
    Private read_tx_pads_ind_mii3_value
    Private flag_tx_pads_ind_mii3
    Private write_txclk_pad_ind_mii3_value
    Private read_txclk_pad_ind_mii3_value
    Private flag_txclk_pad_ind_mii3
    Private write_src_mii3_value
    Private read_src_mii3_value
    Private flag_src_mii3
    Private write_amp_enable_mii3_value
    Private read_amp_enable_mii3_value
    Private flag_amp_enable_mii3
    Private write_sel_mii3_value
    Private read_sel_mii3_value
    Private flag_sel_mii3
    Private write_sel_gmii_mii3_value
    Private read_sel_gmii_mii3_value
    Private flag_sel_gmii_mii3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_clock_en_mii3
        get_clock_en_mii3 = read_clock_en_mii3_value
    End Property

    Property Let set_clock_en_mii3(aData)
        write_clock_en_mii3_value = aData
        flag_clock_en_mii3        = &H1
    End Property

    Property Get read_clock_en_mii3
        read
        read_clock_en_mii3 = read_clock_en_mii3_value
    End Property

    Property Let write_clock_en_mii3(aData)
        set_clock_en_mii3 = aData
        write
    End Property

    Property Get get_tx_pads_ind_mii3
        get_tx_pads_ind_mii3 = read_tx_pads_ind_mii3_value
    End Property

    Property Let set_tx_pads_ind_mii3(aData)
        write_tx_pads_ind_mii3_value = aData
        flag_tx_pads_ind_mii3        = &H1
    End Property

    Property Get read_tx_pads_ind_mii3
        read
        read_tx_pads_ind_mii3 = read_tx_pads_ind_mii3_value
    End Property

    Property Let write_tx_pads_ind_mii3(aData)
        set_tx_pads_ind_mii3 = aData
        write
    End Property

    Property Get get_txclk_pad_ind_mii3
        get_txclk_pad_ind_mii3 = read_txclk_pad_ind_mii3_value
    End Property

    Property Let set_txclk_pad_ind_mii3(aData)
        write_txclk_pad_ind_mii3_value = aData
        flag_txclk_pad_ind_mii3        = &H1
    End Property

    Property Get read_txclk_pad_ind_mii3
        read
        read_txclk_pad_ind_mii3 = read_txclk_pad_ind_mii3_value
    End Property

    Property Let write_txclk_pad_ind_mii3(aData)
        set_txclk_pad_ind_mii3 = aData
        write
    End Property

    Property Get get_src_mii3
        get_src_mii3 = read_src_mii3_value
    End Property

    Property Let set_src_mii3(aData)
        write_src_mii3_value = aData
        flag_src_mii3        = &H1
    End Property

    Property Get read_src_mii3
        read
        read_src_mii3 = read_src_mii3_value
    End Property

    Property Let write_src_mii3(aData)
        set_src_mii3 = aData
        write
    End Property

    Property Get get_amp_enable_mii3
        get_amp_enable_mii3 = read_amp_enable_mii3_value
    End Property

    Property Let set_amp_enable_mii3(aData)
        write_amp_enable_mii3_value = aData
        flag_amp_enable_mii3        = &H1
    End Property

    Property Get read_amp_enable_mii3
        read
        read_amp_enable_mii3 = read_amp_enable_mii3_value
    End Property

    Property Let write_amp_enable_mii3(aData)
        set_amp_enable_mii3 = aData
        write
    End Property

    Property Get get_sel_mii3
        get_sel_mii3 = read_sel_mii3_value
    End Property

    Property Let set_sel_mii3(aData)
        write_sel_mii3_value = aData
        flag_sel_mii3        = &H1
    End Property

    Property Get read_sel_mii3
        read
        read_sel_mii3 = read_sel_mii3_value
    End Property

    Property Let write_sel_mii3(aData)
        set_sel_mii3 = aData
        write
    End Property

    Property Get get_sel_gmii_mii3
        get_sel_gmii_mii3 = read_sel_gmii_mii3_value
    End Property

    Property Let set_sel_gmii_mii3(aData)
        write_sel_gmii_mii3_value = aData
        flag_sel_gmii_mii3        = &H1
    End Property

    Property Get read_sel_gmii_mii3
        read
        read_sel_gmii_mii3 = read_sel_gmii_mii3_value
    End Property

    Property Let write_sel_gmii_mii3(aData)
        set_sel_gmii_mii3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clock_en_mii3_value = rightShift(data_low, 15) and &H1
        read_tx_pads_ind_mii3_value = rightShift(data_low, 14) and &H1
        read_txclk_pad_ind_mii3_value = rightShift(data_low, 13) and &H1
        read_src_mii3_value = rightShift(data_low, 5) and &H3
        read_amp_enable_mii3_value = rightShift(data_low, 4) and &H1
        read_sel_mii3_value = rightShift(data_low, 1) and &H7
        sel_gmii_mii3_mask = &H1
        if data_low > LONG_MAX then
            if sel_gmii_mii3_mask = mask then
                read_sel_gmii_mii3_value = data_low
            else
                read_sel_gmii_mii3_value = (data_low - H8000_0000) and sel_gmii_mii3_mask
            end If
        else
            read_sel_gmii_mii3_value = data_low and sel_gmii_mii3_mask
        end If

    End Sub

    Sub write
        If flag_clock_en_mii3 = &H0 or flag_tx_pads_ind_mii3 = &H0 or flag_txclk_pad_ind_mii3 = &H0 or flag_src_mii3 = &H0 or flag_amp_enable_mii3 = &H0 or flag_sel_mii3 = &H0 or flag_sel_gmii_mii3 = &H0 Then read
        If flag_clock_en_mii3 = &H0 Then write_clock_en_mii3_value = get_clock_en_mii3
        If flag_tx_pads_ind_mii3 = &H0 Then write_tx_pads_ind_mii3_value = get_tx_pads_ind_mii3
        If flag_txclk_pad_ind_mii3 = &H0 Then write_txclk_pad_ind_mii3_value = get_txclk_pad_ind_mii3
        If flag_src_mii3 = &H0 Then write_src_mii3_value = get_src_mii3
        If flag_amp_enable_mii3 = &H0 Then write_amp_enable_mii3_value = get_amp_enable_mii3
        If flag_sel_mii3 = &H0 Then write_sel_mii3_value = get_sel_mii3
        If flag_sel_gmii_mii3 = &H0 Then write_sel_gmii_mii3_value = get_sel_gmii_mii3

        regValue = leftShift((write_clock_en_mii3_value and &H1), 15) + leftShift((write_tx_pads_ind_mii3_value and &H1), 14) + leftShift((write_txclk_pad_ind_mii3_value and &H1), 13) + leftShift((write_src_mii3_value and &H3), 5) + leftShift((write_amp_enable_mii3_value and &H1), 4) + leftShift((write_sel_mii3_value and &H7), 1) + leftShift((write_sel_gmii_mii3_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clock_en_mii3_value = rightShift(data_low, 15) and &H1
        read_tx_pads_ind_mii3_value = rightShift(data_low, 14) and &H1
        read_txclk_pad_ind_mii3_value = rightShift(data_low, 13) and &H1
        read_src_mii3_value = rightShift(data_low, 5) and &H3
        read_amp_enable_mii3_value = rightShift(data_low, 4) and &H1
        read_sel_mii3_value = rightShift(data_low, 1) and &H7
        sel_gmii_mii3_mask = &H1
        if data_low > LONG_MAX then
            if sel_gmii_mii3_mask = mask then
                read_sel_gmii_mii3_value = data_low
            else
                read_sel_gmii_mii3_value = (data_low - H8000_0000) and sel_gmii_mii3_mask
            end If
        else
            read_sel_gmii_mii3_value = data_low and sel_gmii_mii3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_clock_en_mii3_value = &H0
        flag_clock_en_mii3        = &H0
        write_tx_pads_ind_mii3_value = &H0
        flag_tx_pads_ind_mii3        = &H0
        write_txclk_pad_ind_mii3_value = &H0
        flag_txclk_pad_ind_mii3        = &H0
        write_src_mii3_value = &H0
        flag_src_mii3        = &H0
        write_amp_enable_mii3_value = &H0
        flag_amp_enable_mii3        = &H0
        write_sel_mii3_value = &H0
        flag_sel_mii3        = &H0
        write_sel_gmii_mii3_value = &H0
        flag_sel_gmii_mii3        = &H0
    End Sub
End Class


'' @REGISTER : IO_io_mii3_modehv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MII3_MODEHV                                [0:0]            get_MII3_MODEHV
''                                                             set_MII3_MODEHV
''                                                             read_MII3_MODEHV
''                                                             write_MII3_MODEHV
''---------------------------------------------------------------------------------
Class REGISTER_IO_io_mii3_modehv
    Private write_MII3_MODEHV_value
    Private read_MII3_MODEHV_value
    Private flag_MII3_MODEHV

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H86
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MII3_MODEHV
        get_MII3_MODEHV = read_MII3_MODEHV_value
    End Property

    Property Let set_MII3_MODEHV(aData)
        write_MII3_MODEHV_value = aData
        flag_MII3_MODEHV        = &H1
    End Property

    Property Get read_MII3_MODEHV
        read
        read_MII3_MODEHV = read_MII3_MODEHV_value
    End Property

    Property Let write_MII3_MODEHV(aData)
        set_MII3_MODEHV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MII3_MODEHV_mask = &H1
        if data_low > LONG_MAX then
            if MII3_MODEHV_mask = mask then
                read_MII3_MODEHV_value = data_low
            else
                read_MII3_MODEHV_value = (data_low - H8000_0000) and MII3_MODEHV_mask
            end If
        else
            read_MII3_MODEHV_value = data_low and MII3_MODEHV_mask
        end If

    End Sub

    Sub write
        If flag_MII3_MODEHV = &H0 Then read
        If flag_MII3_MODEHV = &H0 Then write_MII3_MODEHV_value = get_MII3_MODEHV

        regValue = leftShift((write_MII3_MODEHV_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MII3_MODEHV_mask = &H1
        if data_low > LONG_MAX then
            if MII3_MODEHV_mask = mask then
                read_MII3_MODEHV_value = data_low
            else
                read_MII3_MODEHV_value = (data_low - H8000_0000) and MII3_MODEHV_mask
            end If
        else
            read_MII3_MODEHV_value = data_low and MII3_MODEHV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MII3_MODEHV_value = &H0
        flag_MII3_MODEHV        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dis_imp                                    [15:15]          get_dis_imp
''                                                             set_dis_imp
''                                                             read_dis_imp
''                                                             write_dis_imp
''---------------------------------------------------------------------------------
'' rgmii_rx_characterization                  [5:5]            get_rgmii_rx_characterization
''                                                             set_rgmii_rx_characterization
''                                                             read_rgmii_rx_characterization
''                                                             write_rgmii_rx_characterization
''---------------------------------------------------------------------------------
'' rmii_clock_shortcut                        [4:4]            get_rmii_clock_shortcut
''                                                             set_rmii_clock_shortcut
''                                                             read_rmii_clock_shortcut
''                                                             write_rmii_clock_shortcut
''---------------------------------------------------------------------------------
'' rmii_clock_direction                       [3:3]            get_rmii_clock_direction
''                                                             set_rmii_clock_direction
''                                                             read_rmii_clock_direction
''                                                             write_rmii_clock_direction
''---------------------------------------------------------------------------------
'' rgmii3_ctl                                 [2:1]            get_rgmii3_ctl
''                                                             set_rgmii3_ctl
''                                                             read_rgmii3_ctl
''                                                             write_rgmii3_ctl
''---------------------------------------------------------------------------------
'' rgmii3_bypass_imp_2ns_del                  [0:0]            get_rgmii3_bypass_imp_2ns_del
''                                                             set_rgmii3_bypass_imp_2ns_del
''                                                             read_rgmii3_bypass_imp_2ns_del
''                                                             write_rgmii3_bypass_imp_2ns_del
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_ctl
    Private write_dis_imp_value
    Private read_dis_imp_value
    Private flag_dis_imp
    Private write_rgmii_rx_characterization_value
    Private read_rgmii_rx_characterization_value
    Private flag_rgmii_rx_characterization
    Private write_rmii_clock_shortcut_value
    Private read_rmii_clock_shortcut_value
    Private flag_rmii_clock_shortcut
    Private write_rmii_clock_direction_value
    Private read_rmii_clock_direction_value
    Private flag_rmii_clock_direction
    Private write_rgmii3_ctl_value
    Private read_rgmii3_ctl_value
    Private flag_rgmii3_ctl
    Private write_rgmii3_bypass_imp_2ns_del_value
    Private read_rgmii3_bypass_imp_2ns_del_value
    Private flag_rgmii3_bypass_imp_2ns_del

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dis_imp
        get_dis_imp = read_dis_imp_value
    End Property

    Property Let set_dis_imp(aData)
        write_dis_imp_value = aData
        flag_dis_imp        = &H1
    End Property

    Property Get read_dis_imp
        read
        read_dis_imp = read_dis_imp_value
    End Property

    Property Let write_dis_imp(aData)
        set_dis_imp = aData
        write
    End Property

    Property Get get_rgmii_rx_characterization
        get_rgmii_rx_characterization = read_rgmii_rx_characterization_value
    End Property

    Property Let set_rgmii_rx_characterization(aData)
        write_rgmii_rx_characterization_value = aData
        flag_rgmii_rx_characterization        = &H1
    End Property

    Property Get read_rgmii_rx_characterization
        read
        read_rgmii_rx_characterization = read_rgmii_rx_characterization_value
    End Property

    Property Let write_rgmii_rx_characterization(aData)
        set_rgmii_rx_characterization = aData
        write
    End Property

    Property Get get_rmii_clock_shortcut
        get_rmii_clock_shortcut = read_rmii_clock_shortcut_value
    End Property

    Property Let set_rmii_clock_shortcut(aData)
        write_rmii_clock_shortcut_value = aData
        flag_rmii_clock_shortcut        = &H1
    End Property

    Property Get read_rmii_clock_shortcut
        read
        read_rmii_clock_shortcut = read_rmii_clock_shortcut_value
    End Property

    Property Let write_rmii_clock_shortcut(aData)
        set_rmii_clock_shortcut = aData
        write
    End Property

    Property Get get_rmii_clock_direction
        get_rmii_clock_direction = read_rmii_clock_direction_value
    End Property

    Property Let set_rmii_clock_direction(aData)
        write_rmii_clock_direction_value = aData
        flag_rmii_clock_direction        = &H1
    End Property

    Property Get read_rmii_clock_direction
        read
        read_rmii_clock_direction = read_rmii_clock_direction_value
    End Property

    Property Let write_rmii_clock_direction(aData)
        set_rmii_clock_direction = aData
        write
    End Property

    Property Get get_rgmii3_ctl
        get_rgmii3_ctl = read_rgmii3_ctl_value
    End Property

    Property Let set_rgmii3_ctl(aData)
        write_rgmii3_ctl_value = aData
        flag_rgmii3_ctl        = &H1
    End Property

    Property Get read_rgmii3_ctl
        read
        read_rgmii3_ctl = read_rgmii3_ctl_value
    End Property

    Property Let write_rgmii3_ctl(aData)
        set_rgmii3_ctl = aData
        write
    End Property

    Property Get get_rgmii3_bypass_imp_2ns_del
        get_rgmii3_bypass_imp_2ns_del = read_rgmii3_bypass_imp_2ns_del_value
    End Property

    Property Let set_rgmii3_bypass_imp_2ns_del(aData)
        write_rgmii3_bypass_imp_2ns_del_value = aData
        flag_rgmii3_bypass_imp_2ns_del        = &H1
    End Property

    Property Get read_rgmii3_bypass_imp_2ns_del
        read
        read_rgmii3_bypass_imp_2ns_del = read_rgmii3_bypass_imp_2ns_del_value
    End Property

    Property Let write_rgmii3_bypass_imp_2ns_del(aData)
        set_rgmii3_bypass_imp_2ns_del = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_imp_value = rightShift(data_low, 15) and &H1
        read_rgmii_rx_characterization_value = rightShift(data_low, 5) and &H1
        read_rmii_clock_shortcut_value = rightShift(data_low, 4) and &H1
        read_rmii_clock_direction_value = rightShift(data_low, 3) and &H1
        read_rgmii3_ctl_value = rightShift(data_low, 1) and &H3
        rgmii3_bypass_imp_2ns_del_mask = &H1
        if data_low > LONG_MAX then
            if rgmii3_bypass_imp_2ns_del_mask = mask then
                read_rgmii3_bypass_imp_2ns_del_value = data_low
            else
                read_rgmii3_bypass_imp_2ns_del_value = (data_low - H8000_0000) and rgmii3_bypass_imp_2ns_del_mask
            end If
        else
            read_rgmii3_bypass_imp_2ns_del_value = data_low and rgmii3_bypass_imp_2ns_del_mask
        end If

    End Sub

    Sub write
        If flag_dis_imp = &H0 or flag_rgmii_rx_characterization = &H0 or flag_rmii_clock_shortcut = &H0 or flag_rmii_clock_direction = &H0 or flag_rgmii3_ctl = &H0 or flag_rgmii3_bypass_imp_2ns_del = &H0 Then read
        If flag_dis_imp = &H0 Then write_dis_imp_value = get_dis_imp
        If flag_rgmii_rx_characterization = &H0 Then write_rgmii_rx_characterization_value = get_rgmii_rx_characterization
        If flag_rmii_clock_shortcut = &H0 Then write_rmii_clock_shortcut_value = get_rmii_clock_shortcut
        If flag_rmii_clock_direction = &H0 Then write_rmii_clock_direction_value = get_rmii_clock_direction
        If flag_rgmii3_ctl = &H0 Then write_rgmii3_ctl_value = get_rgmii3_ctl
        If flag_rgmii3_bypass_imp_2ns_del = &H0 Then write_rgmii3_bypass_imp_2ns_del_value = get_rgmii3_bypass_imp_2ns_del

        regValue = leftShift((write_dis_imp_value and &H1), 15) + leftShift((write_rgmii_rx_characterization_value and &H1), 5) + leftShift((write_rmii_clock_shortcut_value and &H1), 4) + leftShift((write_rmii_clock_direction_value and &H1), 3) + leftShift((write_rgmii3_ctl_value and &H3), 1) + leftShift((write_rgmii3_bypass_imp_2ns_del_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_imp_value = rightShift(data_low, 15) and &H1
        read_rgmii_rx_characterization_value = rightShift(data_low, 5) and &H1
        read_rmii_clock_shortcut_value = rightShift(data_low, 4) and &H1
        read_rmii_clock_direction_value = rightShift(data_low, 3) and &H1
        read_rgmii3_ctl_value = rightShift(data_low, 1) and &H3
        rgmii3_bypass_imp_2ns_del_mask = &H1
        if data_low > LONG_MAX then
            if rgmii3_bypass_imp_2ns_del_mask = mask then
                read_rgmii3_bypass_imp_2ns_del_value = data_low
            else
                read_rgmii3_bypass_imp_2ns_del_value = (data_low - H8000_0000) and rgmii3_bypass_imp_2ns_del_mask
            end If
        else
            read_rgmii3_bypass_imp_2ns_del_value = data_low and rgmii3_bypass_imp_2ns_del_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dis_imp_value = &H0
        flag_dis_imp        = &H0
        write_rgmii_rx_characterization_value = &H0
        flag_rgmii_rx_characterization        = &H0
        write_rmii_clock_shortcut_value = &H0
        flag_rmii_clock_shortcut        = &H0
        write_rmii_clock_direction_value = &H0
        flag_rmii_clock_direction        = &H0
        write_rgmii3_ctl_value = &H0
        flag_rgmii3_ctl        = &H0
        write_rgmii3_bypass_imp_2ns_del_value = &H0
        flag_rgmii3_bypass_imp_2ns_del        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_gmii_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rgmii_rx_pause                             [4:4]            get_rgmii_rx_pause
''                                                             set_rgmii_rx_pause
''                                                             read_rgmii_rx_pause
''                                                             write_rgmii_rx_pause
''---------------------------------------------------------------------------------
'' rgmii_tx_pause                             [3:3]            get_rgmii_tx_pause
''                                                             set_rgmii_tx_pause
''                                                             read_rgmii_tx_pause
''                                                             write_rgmii_tx_pause
''---------------------------------------------------------------------------------
'' rgmii_link                                 [2:2]            get_rgmii_link
''                                                             set_rgmii_link
''                                                             read_rgmii_link
''                                                             write_rgmii_link
''---------------------------------------------------------------------------------
'' rgmii_spd                                  [1:0]            get_rgmii_spd
''                                                             set_rgmii_spd
''                                                             read_rgmii_spd
''                                                             write_rgmii_spd
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_gmii_ctl
    Private write_rgmii_rx_pause_value
    Private read_rgmii_rx_pause_value
    Private flag_rgmii_rx_pause
    Private write_rgmii_tx_pause_value
    Private read_rgmii_tx_pause_value
    Private flag_rgmii_tx_pause
    Private write_rgmii_link_value
    Private read_rgmii_link_value
    Private flag_rgmii_link
    Private write_rgmii_spd_value
    Private read_rgmii_spd_value
    Private flag_rgmii_spd

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rgmii_rx_pause
        get_rgmii_rx_pause = read_rgmii_rx_pause_value
    End Property

    Property Let set_rgmii_rx_pause(aData)
        write_rgmii_rx_pause_value = aData
        flag_rgmii_rx_pause        = &H1
    End Property

    Property Get read_rgmii_rx_pause
        read
        read_rgmii_rx_pause = read_rgmii_rx_pause_value
    End Property

    Property Let write_rgmii_rx_pause(aData)
        set_rgmii_rx_pause = aData
        write
    End Property

    Property Get get_rgmii_tx_pause
        get_rgmii_tx_pause = read_rgmii_tx_pause_value
    End Property

    Property Let set_rgmii_tx_pause(aData)
        write_rgmii_tx_pause_value = aData
        flag_rgmii_tx_pause        = &H1
    End Property

    Property Get read_rgmii_tx_pause
        read
        read_rgmii_tx_pause = read_rgmii_tx_pause_value
    End Property

    Property Let write_rgmii_tx_pause(aData)
        set_rgmii_tx_pause = aData
        write
    End Property

    Property Get get_rgmii_link
        get_rgmii_link = read_rgmii_link_value
    End Property

    Property Let set_rgmii_link(aData)
        write_rgmii_link_value = aData
        flag_rgmii_link        = &H1
    End Property

    Property Get read_rgmii_link
        read
        read_rgmii_link = read_rgmii_link_value
    End Property

    Property Let write_rgmii_link(aData)
        set_rgmii_link = aData
        write
    End Property

    Property Get get_rgmii_spd
        get_rgmii_spd = read_rgmii_spd_value
    End Property

    Property Let set_rgmii_spd(aData)
        write_rgmii_spd_value = aData
        flag_rgmii_spd        = &H1
    End Property

    Property Get read_rgmii_spd
        read
        read_rgmii_spd = read_rgmii_spd_value
    End Property

    Property Let write_rgmii_spd(aData)
        set_rgmii_spd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rgmii_rx_pause_value = rightShift(data_low, 4) and &H1
        read_rgmii_tx_pause_value = rightShift(data_low, 3) and &H1
        read_rgmii_link_value = rightShift(data_low, 2) and &H1
        rgmii_spd_mask = &H3
        if data_low > LONG_MAX then
            if rgmii_spd_mask = mask then
                read_rgmii_spd_value = data_low
            else
                read_rgmii_spd_value = (data_low - H8000_0000) and rgmii_spd_mask
            end If
        else
            read_rgmii_spd_value = data_low and rgmii_spd_mask
        end If

    End Sub

    Sub write
        If flag_rgmii_rx_pause = &H0 or flag_rgmii_tx_pause = &H0 or flag_rgmii_link = &H0 or flag_rgmii_spd = &H0 Then read
        If flag_rgmii_rx_pause = &H0 Then write_rgmii_rx_pause_value = get_rgmii_rx_pause
        If flag_rgmii_tx_pause = &H0 Then write_rgmii_tx_pause_value = get_rgmii_tx_pause
        If flag_rgmii_link = &H0 Then write_rgmii_link_value = get_rgmii_link
        If flag_rgmii_spd = &H0 Then write_rgmii_spd_value = get_rgmii_spd

        regValue = leftShift((write_rgmii_rx_pause_value and &H1), 4) + leftShift((write_rgmii_tx_pause_value and &H1), 3) + leftShift((write_rgmii_link_value and &H1), 2) + leftShift((write_rgmii_spd_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rgmii_rx_pause_value = rightShift(data_low, 4) and &H1
        read_rgmii_tx_pause_value = rightShift(data_low, 3) and &H1
        read_rgmii_link_value = rightShift(data_low, 2) and &H1
        rgmii_spd_mask = &H3
        if data_low > LONG_MAX then
            if rgmii_spd_mask = mask then
                read_rgmii_spd_value = data_low
            else
                read_rgmii_spd_value = (data_low - H8000_0000) and rgmii_spd_mask
            end If
        else
            read_rgmii_spd_value = data_low and rgmii_spd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rgmii_rx_pause_value = &H0
        flag_rgmii_rx_pause        = &H0
        write_rgmii_tx_pause_value = &H0
        flag_rgmii_tx_pause        = &H0
        write_rgmii_link_value = &H0
        flag_rgmii_link        = &H0
        write_rgmii_spd_value = &H0
        flag_rgmii_spd        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_fifo_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fifo_ctl                                   [15:0]           get_fifo_ctl
''                                                             set_fifo_ctl
''                                                             read_fifo_ctl
''                                                             write_fifo_ctl
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_fifo_ctl
    Private write_fifo_ctl_value
    Private read_fifo_ctl_value
    Private flag_fifo_ctl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fifo_ctl
        get_fifo_ctl = read_fifo_ctl_value
    End Property

    Property Let set_fifo_ctl(aData)
        write_fifo_ctl_value = aData
        flag_fifo_ctl        = &H1
    End Property

    Property Get read_fifo_ctl
        read
        read_fifo_ctl = read_fifo_ctl_value
    End Property

    Property Let write_fifo_ctl(aData)
        set_fifo_ctl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fifo_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if fifo_ctl_mask = mask then
                read_fifo_ctl_value = data_low
            else
                read_fifo_ctl_value = (data_low - H8000_0000) and fifo_ctl_mask
            end If
        else
            read_fifo_ctl_value = data_low and fifo_ctl_mask
        end If

    End Sub

    Sub write
        If flag_fifo_ctl = &H0 Then read
        If flag_fifo_ctl = &H0 Then write_fifo_ctl_value = get_fifo_ctl

        regValue = leftShift((write_fifo_ctl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fifo_ctl_mask = &Hffff
        if data_low > LONG_MAX then
            if fifo_ctl_mask = mask then
                read_fifo_ctl_value = data_low
            else
                read_fifo_ctl_value = (data_low - H8000_0000) and fifo_ctl_mask
            end If
        else
            read_fifo_ctl_value = data_low and fifo_ctl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fifo_ctl_value = &H0
        flag_fifo_ctl        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_dll_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dll_ctrl                                   [15:0]           get_dll_ctrl
''                                                             set_dll_ctrl
''                                                             read_dll_ctrl
''                                                             write_dll_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_dll_ctrl
    Private write_dll_ctrl_value
    Private read_dll_ctrl_value
    Private flag_dll_ctrl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dll_ctrl
        get_dll_ctrl = read_dll_ctrl_value
    End Property

    Property Let set_dll_ctrl(aData)
        write_dll_ctrl_value = aData
        flag_dll_ctrl        = &H1
    End Property

    Property Get read_dll_ctrl
        read
        read_dll_ctrl = read_dll_ctrl_value
    End Property

    Property Let write_dll_ctrl(aData)
        set_dll_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_ctrl_mask = mask then
                read_dll_ctrl_value = data_low
            else
                read_dll_ctrl_value = (data_low - H8000_0000) and dll_ctrl_mask
            end If
        else
            read_dll_ctrl_value = data_low and dll_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_dll_ctrl = &H0 Then read
        If flag_dll_ctrl = &H0 Then write_dll_ctrl_value = get_dll_ctrl

        regValue = leftShift((write_dll_ctrl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_ctrl_mask = mask then
                read_dll_ctrl_value = data_low
            else
                read_dll_ctrl_value = (data_low - H8000_0000) and dll_ctrl_mask
            end If
        else
            read_dll_ctrl_value = data_low and dll_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dll_ctrl_value = &H0
        flag_dll_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : IO_rgmii3_dll_cfg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dll_cfg                                    [15:0]           get_dll_cfg
''                                                             set_dll_cfg
''                                                             read_dll_cfg
''                                                             write_dll_cfg
''---------------------------------------------------------------------------------
Class REGISTER_IO_rgmii3_dll_cfg
    Private write_dll_cfg_value
    Private read_dll_cfg_value
    Private flag_dll_cfg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dll_cfg
        get_dll_cfg = read_dll_cfg_value
    End Property

    Property Let set_dll_cfg(aData)
        write_dll_cfg_value = aData
        flag_dll_cfg        = &H1
    End Property

    Property Get read_dll_cfg
        read
        read_dll_cfg = read_dll_cfg_value
    End Property

    Property Let write_dll_cfg(aData)
        set_dll_cfg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_cfg_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_cfg_mask = mask then
                read_dll_cfg_value = data_low
            else
                read_dll_cfg_value = (data_low - H8000_0000) and dll_cfg_mask
            end If
        else
            read_dll_cfg_value = data_low and dll_cfg_mask
        end If

    End Sub

    Sub write
        If flag_dll_cfg = &H0 Then read
        If flag_dll_cfg = &H0 Then write_dll_cfg_value = get_dll_cfg

        regValue = leftShift((write_dll_cfg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dll_cfg_mask = &Hffff
        if data_low > LONG_MAX then
            if dll_cfg_mask = mask then
                read_dll_cfg_value = data_low
            else
                read_dll_cfg_value = (data_low - H8000_0000) and dll_cfg_mask
            end If
        else
            read_dll_cfg_value = data_low and dll_cfg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dll_cfg_value = &H0
        flag_dll_cfg        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_rxfifo_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_ENABLE                        [15:15]          get_XGMII_RXFIFO_ENABLE
''                                                             set_XGMII_RXFIFO_ENABLE
''                                                             read_XGMII_RXFIFO_ENABLE
''                                                             write_XGMII_RXFIFO_ENABLE
''---------------------------------------------------------------------------------
'' RXFIFO_RF_RAM_TM_NOT_USED                  [6:3]            get_RXFIFO_RF_RAM_TM_NOT_USED
''                                                             set_RXFIFO_RF_RAM_TM_NOT_USED
''                                                             read_RXFIFO_RF_RAM_TM_NOT_USED
''                                                             write_RXFIFO_RF_RAM_TM_NOT_USED
''---------------------------------------------------------------------------------
'' XGMII_RX_CLK_COMP_DIS                      [2:2]            get_XGMII_RX_CLK_COMP_DIS
''                                                             set_XGMII_RX_CLK_COMP_DIS
''                                                             read_XGMII_RX_CLK_COMP_DIS
''                                                             write_XGMII_RX_CLK_COMP_DIS
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_B2B_DEL_EN                    [1:1]            get_XGMII_RXFIFO_B2B_DEL_EN
''                                                             set_XGMII_RXFIFO_B2B_DEL_EN
''                                                             read_XGMII_RXFIFO_B2B_DEL_EN
''                                                             write_XGMII_RXFIFO_B2B_DEL_EN
''---------------------------------------------------------------------------------
'' XGMII_RX_CLK_COMP_CNT_SAT_TEST             [0:0]            get_XGMII_RX_CLK_COMP_CNT_SAT_TEST
''                                                             set_XGMII_RX_CLK_COMP_CNT_SAT_TEST
''                                                             read_XGMII_RX_CLK_COMP_CNT_SAT_TEST
''                                                             write_XGMII_RX_CLK_COMP_CNT_SAT_TEST
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_rxfifo_ctl
    Private write_XGMII_RXFIFO_ENABLE_value
    Private read_XGMII_RXFIFO_ENABLE_value
    Private flag_XGMII_RXFIFO_ENABLE
    Private write_RXFIFO_RF_RAM_TM_NOT_USED_value
    Private read_RXFIFO_RF_RAM_TM_NOT_USED_value
    Private flag_RXFIFO_RF_RAM_TM_NOT_USED
    Private write_XGMII_RX_CLK_COMP_DIS_value
    Private read_XGMII_RX_CLK_COMP_DIS_value
    Private flag_XGMII_RX_CLK_COMP_DIS
    Private write_XGMII_RXFIFO_B2B_DEL_EN_value
    Private read_XGMII_RXFIFO_B2B_DEL_EN_value
    Private flag_XGMII_RXFIFO_B2B_DEL_EN
    Private write_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value
    Private read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value
    Private flag_XGMII_RX_CLK_COMP_CNT_SAT_TEST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H92
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_RXFIFO_ENABLE
        get_XGMII_RXFIFO_ENABLE = read_XGMII_RXFIFO_ENABLE_value
    End Property

    Property Let set_XGMII_RXFIFO_ENABLE(aData)
        write_XGMII_RXFIFO_ENABLE_value = aData
        flag_XGMII_RXFIFO_ENABLE        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_ENABLE
        read
        read_XGMII_RXFIFO_ENABLE = read_XGMII_RXFIFO_ENABLE_value
    End Property

    Property Let write_XGMII_RXFIFO_ENABLE(aData)
        set_XGMII_RXFIFO_ENABLE = aData
        write
    End Property

    Property Get get_RXFIFO_RF_RAM_TM_NOT_USED
        get_RXFIFO_RF_RAM_TM_NOT_USED = read_RXFIFO_RF_RAM_TM_NOT_USED_value
    End Property

    Property Let set_RXFIFO_RF_RAM_TM_NOT_USED(aData)
        write_RXFIFO_RF_RAM_TM_NOT_USED_value = aData
        flag_RXFIFO_RF_RAM_TM_NOT_USED        = &H1
    End Property

    Property Get read_RXFIFO_RF_RAM_TM_NOT_USED
        read
        read_RXFIFO_RF_RAM_TM_NOT_USED = read_RXFIFO_RF_RAM_TM_NOT_USED_value
    End Property

    Property Let write_RXFIFO_RF_RAM_TM_NOT_USED(aData)
        set_RXFIFO_RF_RAM_TM_NOT_USED = aData
        write
    End Property

    Property Get get_XGMII_RX_CLK_COMP_DIS
        get_XGMII_RX_CLK_COMP_DIS = read_XGMII_RX_CLK_COMP_DIS_value
    End Property

    Property Let set_XGMII_RX_CLK_COMP_DIS(aData)
        write_XGMII_RX_CLK_COMP_DIS_value = aData
        flag_XGMII_RX_CLK_COMP_DIS        = &H1
    End Property

    Property Get read_XGMII_RX_CLK_COMP_DIS
        read
        read_XGMII_RX_CLK_COMP_DIS = read_XGMII_RX_CLK_COMP_DIS_value
    End Property

    Property Let write_XGMII_RX_CLK_COMP_DIS(aData)
        set_XGMII_RX_CLK_COMP_DIS = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_B2B_DEL_EN
        get_XGMII_RXFIFO_B2B_DEL_EN = read_XGMII_RXFIFO_B2B_DEL_EN_value
    End Property

    Property Let set_XGMII_RXFIFO_B2B_DEL_EN(aData)
        write_XGMII_RXFIFO_B2B_DEL_EN_value = aData
        flag_XGMII_RXFIFO_B2B_DEL_EN        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_B2B_DEL_EN
        read
        read_XGMII_RXFIFO_B2B_DEL_EN = read_XGMII_RXFIFO_B2B_DEL_EN_value
    End Property

    Property Let write_XGMII_RXFIFO_B2B_DEL_EN(aData)
        set_XGMII_RXFIFO_B2B_DEL_EN = aData
        write
    End Property

    Property Get get_XGMII_RX_CLK_COMP_CNT_SAT_TEST
        get_XGMII_RX_CLK_COMP_CNT_SAT_TEST = read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value
    End Property

    Property Let set_XGMII_RX_CLK_COMP_CNT_SAT_TEST(aData)
        write_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = aData
        flag_XGMII_RX_CLK_COMP_CNT_SAT_TEST        = &H1
    End Property

    Property Get read_XGMII_RX_CLK_COMP_CNT_SAT_TEST
        read
        read_XGMII_RX_CLK_COMP_CNT_SAT_TEST = read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value
    End Property

    Property Let write_XGMII_RX_CLK_COMP_CNT_SAT_TEST(aData)
        set_XGMII_RX_CLK_COMP_CNT_SAT_TEST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_ENABLE_value = rightShift(data_low, 15) and &H1
        read_RXFIFO_RF_RAM_TM_NOT_USED_value = rightShift(data_low, 3) and &Hf
        read_XGMII_RX_CLK_COMP_DIS_value = rightShift(data_low, 2) and &H1
        read_XGMII_RXFIFO_B2B_DEL_EN_value = rightShift(data_low, 1) and &H1
        XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask = mask then
                read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = data_low
            else
                read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = (data_low - H8000_0000) and XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask
            end If
        else
            read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = data_low and XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_RXFIFO_ENABLE = &H0 or flag_RXFIFO_RF_RAM_TM_NOT_USED = &H0 or flag_XGMII_RX_CLK_COMP_DIS = &H0 or flag_XGMII_RXFIFO_B2B_DEL_EN = &H0 or flag_XGMII_RX_CLK_COMP_CNT_SAT_TEST = &H0 Then read
        If flag_XGMII_RXFIFO_ENABLE = &H0 Then write_XGMII_RXFIFO_ENABLE_value = get_XGMII_RXFIFO_ENABLE
        If flag_RXFIFO_RF_RAM_TM_NOT_USED = &H0 Then write_RXFIFO_RF_RAM_TM_NOT_USED_value = get_RXFIFO_RF_RAM_TM_NOT_USED
        If flag_XGMII_RX_CLK_COMP_DIS = &H0 Then write_XGMII_RX_CLK_COMP_DIS_value = get_XGMII_RX_CLK_COMP_DIS
        If flag_XGMII_RXFIFO_B2B_DEL_EN = &H0 Then write_XGMII_RXFIFO_B2B_DEL_EN_value = get_XGMII_RXFIFO_B2B_DEL_EN
        If flag_XGMII_RX_CLK_COMP_CNT_SAT_TEST = &H0 Then write_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = get_XGMII_RX_CLK_COMP_CNT_SAT_TEST

        regValue = leftShift((write_XGMII_RXFIFO_ENABLE_value and &H1), 15) + leftShift((write_RXFIFO_RF_RAM_TM_NOT_USED_value and &Hf), 3) + leftShift((write_XGMII_RX_CLK_COMP_DIS_value and &H1), 2) + leftShift((write_XGMII_RXFIFO_B2B_DEL_EN_value and &H1), 1) + leftShift((write_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_ENABLE_value = rightShift(data_low, 15) and &H1
        read_RXFIFO_RF_RAM_TM_NOT_USED_value = rightShift(data_low, 3) and &Hf
        read_XGMII_RX_CLK_COMP_DIS_value = rightShift(data_low, 2) and &H1
        read_XGMII_RXFIFO_B2B_DEL_EN_value = rightShift(data_low, 1) and &H1
        XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask = mask then
                read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = data_low
            else
                read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = (data_low - H8000_0000) and XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask
            end If
        else
            read_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = data_low and XGMII_RX_CLK_COMP_CNT_SAT_TEST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_RXFIFO_ENABLE_value = &H0
        flag_XGMII_RXFIFO_ENABLE        = &H0
        write_RXFIFO_RF_RAM_TM_NOT_USED_value = &H0
        flag_RXFIFO_RF_RAM_TM_NOT_USED        = &H0
        write_XGMII_RX_CLK_COMP_DIS_value = &H0
        flag_XGMII_RX_CLK_COMP_DIS        = &H0
        write_XGMII_RXFIFO_B2B_DEL_EN_value = &H0
        flag_XGMII_RXFIFO_B2B_DEL_EN        = &H0
        write_XGMII_RX_CLK_COMP_CNT_SAT_TEST_value = &H0
        flag_XGMII_RX_CLK_COMP_CNT_SAT_TEST        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_rxfifo_trshd_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_ALMOST_FULL_TRSHD             [15:12]          get_XGMII_RXFIFO_ALMOST_FULL_TRSHD
''                                                             set_XGMII_RXFIFO_ALMOST_FULL_TRSHD
''                                                             read_XGMII_RXFIFO_ALMOST_FULL_TRSHD
''                                                             write_XGMII_RXFIFO_ALMOST_FULL_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_ALMOST_EMPTY_TRSHD            [11:10]          get_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
''                                                             set_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
''                                                             read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
''                                                             write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_DEL_TRSHD                     [9:6]            get_XGMII_RXFIFO_DEL_TRSHD
''                                                             set_XGMII_RXFIFO_DEL_TRSHD
''                                                             read_XGMII_RXFIFO_DEL_TRSHD
''                                                             write_XGMII_RXFIFO_DEL_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_INST_TRSHD                    [5:3]            get_XGMII_RXFIFO_INST_TRSHD
''                                                             set_XGMII_RXFIFO_INST_TRSHD
''                                                             read_XGMII_RXFIFO_INST_TRSHD
''                                                             write_XGMII_RXFIFO_INST_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_STRD_TRSHD                    [2:0]            get_XGMII_RXFIFO_STRD_TRSHD
''                                                             set_XGMII_RXFIFO_STRD_TRSHD
''                                                             read_XGMII_RXFIFO_STRD_TRSHD
''                                                             write_XGMII_RXFIFO_STRD_TRSHD
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_rxfifo_trshd_ctl
    Private write_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value
    Private read_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value
    Private flag_XGMII_RXFIFO_ALMOST_FULL_TRSHD
    Private write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value
    Private read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value
    Private flag_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
    Private write_XGMII_RXFIFO_DEL_TRSHD_value
    Private read_XGMII_RXFIFO_DEL_TRSHD_value
    Private flag_XGMII_RXFIFO_DEL_TRSHD
    Private write_XGMII_RXFIFO_INST_TRSHD_value
    Private read_XGMII_RXFIFO_INST_TRSHD_value
    Private flag_XGMII_RXFIFO_INST_TRSHD
    Private write_XGMII_RXFIFO_STRD_TRSHD_value
    Private read_XGMII_RXFIFO_STRD_TRSHD_value
    Private flag_XGMII_RXFIFO_STRD_TRSHD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_RXFIFO_ALMOST_FULL_TRSHD
        get_XGMII_RXFIFO_ALMOST_FULL_TRSHD = read_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value
    End Property

    Property Let set_XGMII_RXFIFO_ALMOST_FULL_TRSHD(aData)
        write_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value = aData
        flag_XGMII_RXFIFO_ALMOST_FULL_TRSHD        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_ALMOST_FULL_TRSHD
        read
        read_XGMII_RXFIFO_ALMOST_FULL_TRSHD = read_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value
    End Property

    Property Let write_XGMII_RXFIFO_ALMOST_FULL_TRSHD(aData)
        set_XGMII_RXFIFO_ALMOST_FULL_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
        get_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD = read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value
    End Property

    Property Let set_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD(aData)
        write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value = aData
        flag_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
        read
        read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD = read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value
    End Property

    Property Let write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD(aData)
        set_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_DEL_TRSHD
        get_XGMII_RXFIFO_DEL_TRSHD = read_XGMII_RXFIFO_DEL_TRSHD_value
    End Property

    Property Let set_XGMII_RXFIFO_DEL_TRSHD(aData)
        write_XGMII_RXFIFO_DEL_TRSHD_value = aData
        flag_XGMII_RXFIFO_DEL_TRSHD        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_DEL_TRSHD
        read
        read_XGMII_RXFIFO_DEL_TRSHD = read_XGMII_RXFIFO_DEL_TRSHD_value
    End Property

    Property Let write_XGMII_RXFIFO_DEL_TRSHD(aData)
        set_XGMII_RXFIFO_DEL_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_INST_TRSHD
        get_XGMII_RXFIFO_INST_TRSHD = read_XGMII_RXFIFO_INST_TRSHD_value
    End Property

    Property Let set_XGMII_RXFIFO_INST_TRSHD(aData)
        write_XGMII_RXFIFO_INST_TRSHD_value = aData
        flag_XGMII_RXFIFO_INST_TRSHD        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_INST_TRSHD
        read
        read_XGMII_RXFIFO_INST_TRSHD = read_XGMII_RXFIFO_INST_TRSHD_value
    End Property

    Property Let write_XGMII_RXFIFO_INST_TRSHD(aData)
        set_XGMII_RXFIFO_INST_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_STRD_TRSHD
        get_XGMII_RXFIFO_STRD_TRSHD = read_XGMII_RXFIFO_STRD_TRSHD_value
    End Property

    Property Let set_XGMII_RXFIFO_STRD_TRSHD(aData)
        write_XGMII_RXFIFO_STRD_TRSHD_value = aData
        flag_XGMII_RXFIFO_STRD_TRSHD        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_STRD_TRSHD
        read
        read_XGMII_RXFIFO_STRD_TRSHD = read_XGMII_RXFIFO_STRD_TRSHD_value
    End Property

    Property Let write_XGMII_RXFIFO_STRD_TRSHD(aData)
        set_XGMII_RXFIFO_STRD_TRSHD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value = rightShift(data_low, 12) and &Hf
        read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value = rightShift(data_low, 10) and &H3
        read_XGMII_RXFIFO_DEL_TRSHD_value = rightShift(data_low, 6) and &Hf
        read_XGMII_RXFIFO_INST_TRSHD_value = rightShift(data_low, 3) and &H7
        XGMII_RXFIFO_STRD_TRSHD_mask = &H7
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_STRD_TRSHD_mask = mask then
                read_XGMII_RXFIFO_STRD_TRSHD_value = data_low
            else
                read_XGMII_RXFIFO_STRD_TRSHD_value = (data_low - H8000_0000) and XGMII_RXFIFO_STRD_TRSHD_mask
            end If
        else
            read_XGMII_RXFIFO_STRD_TRSHD_value = data_low and XGMII_RXFIFO_STRD_TRSHD_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_RXFIFO_ALMOST_FULL_TRSHD = &H0 or flag_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD = &H0 or flag_XGMII_RXFIFO_DEL_TRSHD = &H0 or flag_XGMII_RXFIFO_INST_TRSHD = &H0 or flag_XGMII_RXFIFO_STRD_TRSHD = &H0 Then read
        If flag_XGMII_RXFIFO_ALMOST_FULL_TRSHD = &H0 Then write_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value = get_XGMII_RXFIFO_ALMOST_FULL_TRSHD
        If flag_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD = &H0 Then write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value = get_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD
        If flag_XGMII_RXFIFO_DEL_TRSHD = &H0 Then write_XGMII_RXFIFO_DEL_TRSHD_value = get_XGMII_RXFIFO_DEL_TRSHD
        If flag_XGMII_RXFIFO_INST_TRSHD = &H0 Then write_XGMII_RXFIFO_INST_TRSHD_value = get_XGMII_RXFIFO_INST_TRSHD
        If flag_XGMII_RXFIFO_STRD_TRSHD = &H0 Then write_XGMII_RXFIFO_STRD_TRSHD_value = get_XGMII_RXFIFO_STRD_TRSHD

        regValue = leftShift((write_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value and &Hf), 12) + leftShift((write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value and &H3), 10) + leftShift((write_XGMII_RXFIFO_DEL_TRSHD_value and &Hf), 6) + leftShift((write_XGMII_RXFIFO_INST_TRSHD_value and &H7), 3) + leftShift((write_XGMII_RXFIFO_STRD_TRSHD_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value = rightShift(data_low, 12) and &Hf
        read_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value = rightShift(data_low, 10) and &H3
        read_XGMII_RXFIFO_DEL_TRSHD_value = rightShift(data_low, 6) and &Hf
        read_XGMII_RXFIFO_INST_TRSHD_value = rightShift(data_low, 3) and &H7
        XGMII_RXFIFO_STRD_TRSHD_mask = &H7
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_STRD_TRSHD_mask = mask then
                read_XGMII_RXFIFO_STRD_TRSHD_value = data_low
            else
                read_XGMII_RXFIFO_STRD_TRSHD_value = (data_low - H8000_0000) and XGMII_RXFIFO_STRD_TRSHD_mask
            end If
        else
            read_XGMII_RXFIFO_STRD_TRSHD_value = data_low and XGMII_RXFIFO_STRD_TRSHD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_RXFIFO_ALMOST_FULL_TRSHD_value = &H0
        flag_XGMII_RXFIFO_ALMOST_FULL_TRSHD        = &H0
        write_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD_value = &H0
        flag_XGMII_RXFIFO_ALMOST_EMPTY_TRSHD        = &H0
        write_XGMII_RXFIFO_DEL_TRSHD_value = &H0
        flag_XGMII_RXFIFO_DEL_TRSHD        = &H0
        write_XGMII_RXFIFO_INST_TRSHD_value = &H0
        flag_XGMII_RXFIFO_INST_TRSHD        = &H0
        write_XGMII_RXFIFO_STRD_TRSHD_value = &H0
        flag_XGMII_RXFIFO_STRD_TRSHD        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_rxfifo_delete_cnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_DELETE_CNT_LAT                [15:15]          get_XGMII_RXFIFO_DELETE_CNT_LAT
''                                                             set_XGMII_RXFIFO_DELETE_CNT_LAT
''                                                             read_XGMII_RXFIFO_DELETE_CNT_LAT
''                                                             write_XGMII_RXFIFO_DELETE_CNT_LAT
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_DELETE_CNT                    [14:0]           get_XGMII_RXFIFO_DELETE_CNT
''                                                             set_XGMII_RXFIFO_DELETE_CNT
''                                                             read_XGMII_RXFIFO_DELETE_CNT
''                                                             write_XGMII_RXFIFO_DELETE_CNT
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_rxfifo_delete_cnt
    Private write_XGMII_RXFIFO_DELETE_CNT_LAT_value
    Private read_XGMII_RXFIFO_DELETE_CNT_LAT_value
    Private flag_XGMII_RXFIFO_DELETE_CNT_LAT
    Private write_XGMII_RXFIFO_DELETE_CNT_value
    Private read_XGMII_RXFIFO_DELETE_CNT_value
    Private flag_XGMII_RXFIFO_DELETE_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H96
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_RXFIFO_DELETE_CNT_LAT
        get_XGMII_RXFIFO_DELETE_CNT_LAT = read_XGMII_RXFIFO_DELETE_CNT_LAT_value
    End Property

    Property Let set_XGMII_RXFIFO_DELETE_CNT_LAT(aData)
        write_XGMII_RXFIFO_DELETE_CNT_LAT_value = aData
        flag_XGMII_RXFIFO_DELETE_CNT_LAT        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_DELETE_CNT_LAT
        read
        read_XGMII_RXFIFO_DELETE_CNT_LAT = read_XGMII_RXFIFO_DELETE_CNT_LAT_value
    End Property

    Property Let write_XGMII_RXFIFO_DELETE_CNT_LAT(aData)
        set_XGMII_RXFIFO_DELETE_CNT_LAT = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_DELETE_CNT
        get_XGMII_RXFIFO_DELETE_CNT = read_XGMII_RXFIFO_DELETE_CNT_value
    End Property

    Property Let set_XGMII_RXFIFO_DELETE_CNT(aData)
        write_XGMII_RXFIFO_DELETE_CNT_value = aData
        flag_XGMII_RXFIFO_DELETE_CNT        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_DELETE_CNT
        read
        read_XGMII_RXFIFO_DELETE_CNT = read_XGMII_RXFIFO_DELETE_CNT_value
    End Property

    Property Let write_XGMII_RXFIFO_DELETE_CNT(aData)
        set_XGMII_RXFIFO_DELETE_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_DELETE_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_RXFIFO_DELETE_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_DELETE_CNT_mask = mask then
                read_XGMII_RXFIFO_DELETE_CNT_value = data_low
            else
                read_XGMII_RXFIFO_DELETE_CNT_value = (data_low - H8000_0000) and XGMII_RXFIFO_DELETE_CNT_mask
            end If
        else
            read_XGMII_RXFIFO_DELETE_CNT_value = data_low and XGMII_RXFIFO_DELETE_CNT_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_RXFIFO_DELETE_CNT_LAT = &H0 or flag_XGMII_RXFIFO_DELETE_CNT = &H0 Then read
        If flag_XGMII_RXFIFO_DELETE_CNT_LAT = &H0 Then write_XGMII_RXFIFO_DELETE_CNT_LAT_value = get_XGMII_RXFIFO_DELETE_CNT_LAT
        If flag_XGMII_RXFIFO_DELETE_CNT = &H0 Then write_XGMII_RXFIFO_DELETE_CNT_value = get_XGMII_RXFIFO_DELETE_CNT

        regValue = leftShift((write_XGMII_RXFIFO_DELETE_CNT_LAT_value and &H1), 15) + leftShift((write_XGMII_RXFIFO_DELETE_CNT_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_DELETE_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_RXFIFO_DELETE_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_DELETE_CNT_mask = mask then
                read_XGMII_RXFIFO_DELETE_CNT_value = data_low
            else
                read_XGMII_RXFIFO_DELETE_CNT_value = (data_low - H8000_0000) and XGMII_RXFIFO_DELETE_CNT_mask
            end If
        else
            read_XGMII_RXFIFO_DELETE_CNT_value = data_low and XGMII_RXFIFO_DELETE_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_RXFIFO_DELETE_CNT_LAT_value = &H0
        flag_XGMII_RXFIFO_DELETE_CNT_LAT        = &H0
        write_XGMII_RXFIFO_DELETE_CNT_value = &H0
        flag_XGMII_RXFIFO_DELETE_CNT        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_rxfifo_insert_cnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_INSERT_CNT_LAT                [15:15]          get_XGMII_RXFIFO_INSERT_CNT_LAT
''                                                             set_XGMII_RXFIFO_INSERT_CNT_LAT
''                                                             read_XGMII_RXFIFO_INSERT_CNT_LAT
''                                                             write_XGMII_RXFIFO_INSERT_CNT_LAT
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_INSERT_CNT                    [14:0]           get_XGMII_RXFIFO_INSERT_CNT
''                                                             set_XGMII_RXFIFO_INSERT_CNT
''                                                             read_XGMII_RXFIFO_INSERT_CNT
''                                                             write_XGMII_RXFIFO_INSERT_CNT
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_rxfifo_insert_cnt
    Private write_XGMII_RXFIFO_INSERT_CNT_LAT_value
    Private read_XGMII_RXFIFO_INSERT_CNT_LAT_value
    Private flag_XGMII_RXFIFO_INSERT_CNT_LAT
    Private write_XGMII_RXFIFO_INSERT_CNT_value
    Private read_XGMII_RXFIFO_INSERT_CNT_value
    Private flag_XGMII_RXFIFO_INSERT_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_RXFIFO_INSERT_CNT_LAT
        get_XGMII_RXFIFO_INSERT_CNT_LAT = read_XGMII_RXFIFO_INSERT_CNT_LAT_value
    End Property

    Property Let set_XGMII_RXFIFO_INSERT_CNT_LAT(aData)
        write_XGMII_RXFIFO_INSERT_CNT_LAT_value = aData
        flag_XGMII_RXFIFO_INSERT_CNT_LAT        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_INSERT_CNT_LAT
        read
        read_XGMII_RXFIFO_INSERT_CNT_LAT = read_XGMII_RXFIFO_INSERT_CNT_LAT_value
    End Property

    Property Let write_XGMII_RXFIFO_INSERT_CNT_LAT(aData)
        set_XGMII_RXFIFO_INSERT_CNT_LAT = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_INSERT_CNT
        get_XGMII_RXFIFO_INSERT_CNT = read_XGMII_RXFIFO_INSERT_CNT_value
    End Property

    Property Let set_XGMII_RXFIFO_INSERT_CNT(aData)
        write_XGMII_RXFIFO_INSERT_CNT_value = aData
        flag_XGMII_RXFIFO_INSERT_CNT        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_INSERT_CNT
        read
        read_XGMII_RXFIFO_INSERT_CNT = read_XGMII_RXFIFO_INSERT_CNT_value
    End Property

    Property Let write_XGMII_RXFIFO_INSERT_CNT(aData)
        set_XGMII_RXFIFO_INSERT_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_INSERT_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_RXFIFO_INSERT_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_INSERT_CNT_mask = mask then
                read_XGMII_RXFIFO_INSERT_CNT_value = data_low
            else
                read_XGMII_RXFIFO_INSERT_CNT_value = (data_low - H8000_0000) and XGMII_RXFIFO_INSERT_CNT_mask
            end If
        else
            read_XGMII_RXFIFO_INSERT_CNT_value = data_low and XGMII_RXFIFO_INSERT_CNT_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_RXFIFO_INSERT_CNT_LAT = &H0 or flag_XGMII_RXFIFO_INSERT_CNT = &H0 Then read
        If flag_XGMII_RXFIFO_INSERT_CNT_LAT = &H0 Then write_XGMII_RXFIFO_INSERT_CNT_LAT_value = get_XGMII_RXFIFO_INSERT_CNT_LAT
        If flag_XGMII_RXFIFO_INSERT_CNT = &H0 Then write_XGMII_RXFIFO_INSERT_CNT_value = get_XGMII_RXFIFO_INSERT_CNT

        regValue = leftShift((write_XGMII_RXFIFO_INSERT_CNT_LAT_value and &H1), 15) + leftShift((write_XGMII_RXFIFO_INSERT_CNT_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_INSERT_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_RXFIFO_INSERT_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_INSERT_CNT_mask = mask then
                read_XGMII_RXFIFO_INSERT_CNT_value = data_low
            else
                read_XGMII_RXFIFO_INSERT_CNT_value = (data_low - H8000_0000) and XGMII_RXFIFO_INSERT_CNT_mask
            end If
        else
            read_XGMII_RXFIFO_INSERT_CNT_value = data_low and XGMII_RXFIFO_INSERT_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_RXFIFO_INSERT_CNT_LAT_value = &H0
        flag_XGMII_RXFIFO_INSERT_CNT_LAT        = &H0
        write_XGMII_RXFIFO_INSERT_CNT_value = &H0
        flag_XGMII_RXFIFO_INSERT_CNT        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_rxfifo_lh_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_STS_LATCH                     [12:12]          get_XGMII_RXFIFO_STS_LATCH
''                                                             set_XGMII_RXFIFO_STS_LATCH
''                                                             read_XGMII_RXFIFO_STS_LATCH
''                                                             write_XGMII_RXFIFO_STS_LATCH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_INSERT_EVNT_LH                [11:11]          get_XGMII_RXFIFO_INSERT_EVNT_LH
''                                                             set_XGMII_RXFIFO_INSERT_EVNT_LH
''                                                             read_XGMII_RXFIFO_INSERT_EVNT_LH
''                                                             write_XGMII_RXFIFO_INSERT_EVNT_LH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_DELETE_EVNT_LH                [10:10]          get_XGMII_RXFIFO_DELETE_EVNT_LH
''                                                             set_XGMII_RXFIFO_DELETE_EVNT_LH
''                                                             read_XGMII_RXFIFO_DELETE_EVNT_LH
''                                                             write_XGMII_RXFIFO_DELETE_EVNT_LH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_FULL_LH                       [9:9]            get_XGMII_RXFIFO_FULL_LH
''                                                             set_XGMII_RXFIFO_FULL_LH
''                                                             read_XGMII_RXFIFO_FULL_LH
''                                                             write_XGMII_RXFIFO_FULL_LH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_EMPTY_LH                      [8:8]            get_XGMII_RXFIFO_EMPTY_LH
''                                                             set_XGMII_RXFIFO_EMPTY_LH
''                                                             read_XGMII_RXFIFO_EMPTY_LH
''                                                             write_XGMII_RXFIFO_EMPTY_LH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_ALMOST_FULL_LH                [7:7]            get_XGMII_RXFIFO_ALMOST_FULL_LH
''                                                             set_XGMII_RXFIFO_ALMOST_FULL_LH
''                                                             read_XGMII_RXFIFO_ALMOST_FULL_LH
''                                                             write_XGMII_RXFIFO_ALMOST_FULL_LH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_ALMOST_EMPTY_LH               [6:6]            get_XGMII_RXFIFO_ALMOST_EMPTY_LH
''                                                             set_XGMII_RXFIFO_ALMOST_EMPTY_LH
''                                                             read_XGMII_RXFIFO_ALMOST_EMPTY_LH
''                                                             write_XGMII_RXFIFO_ALMOST_EMPTY_LH
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_RD_ERR                        [5:5]            get_XGMII_RXFIFO_RD_ERR
''                                                             set_XGMII_RXFIFO_RD_ERR
''                                                             read_XGMII_RXFIFO_RD_ERR
''                                                             write_XGMII_RXFIFO_RD_ERR
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_RD_RF                         [4:4]            get_XGMII_RXFIFO_RD_RF
''                                                             set_XGMII_RXFIFO_RD_RF
''                                                             read_XGMII_RXFIFO_RD_RF
''                                                             write_XGMII_RXFIFO_RD_RF
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_RD_LF                         [3:3]            get_XGMII_RXFIFO_RD_LF
''                                                             set_XGMII_RXFIFO_RD_LF
''                                                             read_XGMII_RXFIFO_RD_LF
''                                                             write_XGMII_RXFIFO_RD_LF
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_WR_ERR                        [2:2]            get_XGMII_RXFIFO_WR_ERR
''                                                             set_XGMII_RXFIFO_WR_ERR
''                                                             read_XGMII_RXFIFO_WR_ERR
''                                                             write_XGMII_RXFIFO_WR_ERR
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_WR_RF                         [1:1]            get_XGMII_RXFIFO_WR_RF
''                                                             set_XGMII_RXFIFO_WR_RF
''                                                             read_XGMII_RXFIFO_WR_RF
''                                                             write_XGMII_RXFIFO_WR_RF
''---------------------------------------------------------------------------------
'' XGMII_RXFIFO_WR_LF                         [0:0]            get_XGMII_RXFIFO_WR_LF
''                                                             set_XGMII_RXFIFO_WR_LF
''                                                             read_XGMII_RXFIFO_WR_LF
''                                                             write_XGMII_RXFIFO_WR_LF
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_rxfifo_lh_sts
    Private write_XGMII_RXFIFO_STS_LATCH_value
    Private read_XGMII_RXFIFO_STS_LATCH_value
    Private flag_XGMII_RXFIFO_STS_LATCH
    Private write_XGMII_RXFIFO_INSERT_EVNT_LH_value
    Private read_XGMII_RXFIFO_INSERT_EVNT_LH_value
    Private flag_XGMII_RXFIFO_INSERT_EVNT_LH
    Private write_XGMII_RXFIFO_DELETE_EVNT_LH_value
    Private read_XGMII_RXFIFO_DELETE_EVNT_LH_value
    Private flag_XGMII_RXFIFO_DELETE_EVNT_LH
    Private write_XGMII_RXFIFO_FULL_LH_value
    Private read_XGMII_RXFIFO_FULL_LH_value
    Private flag_XGMII_RXFIFO_FULL_LH
    Private write_XGMII_RXFIFO_EMPTY_LH_value
    Private read_XGMII_RXFIFO_EMPTY_LH_value
    Private flag_XGMII_RXFIFO_EMPTY_LH
    Private write_XGMII_RXFIFO_ALMOST_FULL_LH_value
    Private read_XGMII_RXFIFO_ALMOST_FULL_LH_value
    Private flag_XGMII_RXFIFO_ALMOST_FULL_LH
    Private write_XGMII_RXFIFO_ALMOST_EMPTY_LH_value
    Private read_XGMII_RXFIFO_ALMOST_EMPTY_LH_value
    Private flag_XGMII_RXFIFO_ALMOST_EMPTY_LH
    Private write_XGMII_RXFIFO_RD_ERR_value
    Private read_XGMII_RXFIFO_RD_ERR_value
    Private flag_XGMII_RXFIFO_RD_ERR
    Private write_XGMII_RXFIFO_RD_RF_value
    Private read_XGMII_RXFIFO_RD_RF_value
    Private flag_XGMII_RXFIFO_RD_RF
    Private write_XGMII_RXFIFO_RD_LF_value
    Private read_XGMII_RXFIFO_RD_LF_value
    Private flag_XGMII_RXFIFO_RD_LF
    Private write_XGMII_RXFIFO_WR_ERR_value
    Private read_XGMII_RXFIFO_WR_ERR_value
    Private flag_XGMII_RXFIFO_WR_ERR
    Private write_XGMII_RXFIFO_WR_RF_value
    Private read_XGMII_RXFIFO_WR_RF_value
    Private flag_XGMII_RXFIFO_WR_RF
    Private write_XGMII_RXFIFO_WR_LF_value
    Private read_XGMII_RXFIFO_WR_LF_value
    Private flag_XGMII_RXFIFO_WR_LF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_RXFIFO_STS_LATCH
        get_XGMII_RXFIFO_STS_LATCH = read_XGMII_RXFIFO_STS_LATCH_value
    End Property

    Property Let set_XGMII_RXFIFO_STS_LATCH(aData)
        write_XGMII_RXFIFO_STS_LATCH_value = aData
        flag_XGMII_RXFIFO_STS_LATCH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_STS_LATCH
        read
        read_XGMII_RXFIFO_STS_LATCH = read_XGMII_RXFIFO_STS_LATCH_value
    End Property

    Property Let write_XGMII_RXFIFO_STS_LATCH(aData)
        set_XGMII_RXFIFO_STS_LATCH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_INSERT_EVNT_LH
        get_XGMII_RXFIFO_INSERT_EVNT_LH = read_XGMII_RXFIFO_INSERT_EVNT_LH_value
    End Property

    Property Let set_XGMII_RXFIFO_INSERT_EVNT_LH(aData)
        write_XGMII_RXFIFO_INSERT_EVNT_LH_value = aData
        flag_XGMII_RXFIFO_INSERT_EVNT_LH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_INSERT_EVNT_LH
        read
        read_XGMII_RXFIFO_INSERT_EVNT_LH = read_XGMII_RXFIFO_INSERT_EVNT_LH_value
    End Property

    Property Let write_XGMII_RXFIFO_INSERT_EVNT_LH(aData)
        set_XGMII_RXFIFO_INSERT_EVNT_LH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_DELETE_EVNT_LH
        get_XGMII_RXFIFO_DELETE_EVNT_LH = read_XGMII_RXFIFO_DELETE_EVNT_LH_value
    End Property

    Property Let set_XGMII_RXFIFO_DELETE_EVNT_LH(aData)
        write_XGMII_RXFIFO_DELETE_EVNT_LH_value = aData
        flag_XGMII_RXFIFO_DELETE_EVNT_LH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_DELETE_EVNT_LH
        read
        read_XGMII_RXFIFO_DELETE_EVNT_LH = read_XGMII_RXFIFO_DELETE_EVNT_LH_value
    End Property

    Property Let write_XGMII_RXFIFO_DELETE_EVNT_LH(aData)
        set_XGMII_RXFIFO_DELETE_EVNT_LH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_FULL_LH
        get_XGMII_RXFIFO_FULL_LH = read_XGMII_RXFIFO_FULL_LH_value
    End Property

    Property Let set_XGMII_RXFIFO_FULL_LH(aData)
        write_XGMII_RXFIFO_FULL_LH_value = aData
        flag_XGMII_RXFIFO_FULL_LH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_FULL_LH
        read
        read_XGMII_RXFIFO_FULL_LH = read_XGMII_RXFIFO_FULL_LH_value
    End Property

    Property Let write_XGMII_RXFIFO_FULL_LH(aData)
        set_XGMII_RXFIFO_FULL_LH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_EMPTY_LH
        get_XGMII_RXFIFO_EMPTY_LH = read_XGMII_RXFIFO_EMPTY_LH_value
    End Property

    Property Let set_XGMII_RXFIFO_EMPTY_LH(aData)
        write_XGMII_RXFIFO_EMPTY_LH_value = aData
        flag_XGMII_RXFIFO_EMPTY_LH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_EMPTY_LH
        read
        read_XGMII_RXFIFO_EMPTY_LH = read_XGMII_RXFIFO_EMPTY_LH_value
    End Property

    Property Let write_XGMII_RXFIFO_EMPTY_LH(aData)
        set_XGMII_RXFIFO_EMPTY_LH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_ALMOST_FULL_LH
        get_XGMII_RXFIFO_ALMOST_FULL_LH = read_XGMII_RXFIFO_ALMOST_FULL_LH_value
    End Property

    Property Let set_XGMII_RXFIFO_ALMOST_FULL_LH(aData)
        write_XGMII_RXFIFO_ALMOST_FULL_LH_value = aData
        flag_XGMII_RXFIFO_ALMOST_FULL_LH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_ALMOST_FULL_LH
        read
        read_XGMII_RXFIFO_ALMOST_FULL_LH = read_XGMII_RXFIFO_ALMOST_FULL_LH_value
    End Property

    Property Let write_XGMII_RXFIFO_ALMOST_FULL_LH(aData)
        set_XGMII_RXFIFO_ALMOST_FULL_LH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_ALMOST_EMPTY_LH
        get_XGMII_RXFIFO_ALMOST_EMPTY_LH = read_XGMII_RXFIFO_ALMOST_EMPTY_LH_value
    End Property

    Property Let set_XGMII_RXFIFO_ALMOST_EMPTY_LH(aData)
        write_XGMII_RXFIFO_ALMOST_EMPTY_LH_value = aData
        flag_XGMII_RXFIFO_ALMOST_EMPTY_LH        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_ALMOST_EMPTY_LH
        read
        read_XGMII_RXFIFO_ALMOST_EMPTY_LH = read_XGMII_RXFIFO_ALMOST_EMPTY_LH_value
    End Property

    Property Let write_XGMII_RXFIFO_ALMOST_EMPTY_LH(aData)
        set_XGMII_RXFIFO_ALMOST_EMPTY_LH = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_RD_ERR
        get_XGMII_RXFIFO_RD_ERR = read_XGMII_RXFIFO_RD_ERR_value
    End Property

    Property Let set_XGMII_RXFIFO_RD_ERR(aData)
        write_XGMII_RXFIFO_RD_ERR_value = aData
        flag_XGMII_RXFIFO_RD_ERR        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_RD_ERR
        read
        read_XGMII_RXFIFO_RD_ERR = read_XGMII_RXFIFO_RD_ERR_value
    End Property

    Property Let write_XGMII_RXFIFO_RD_ERR(aData)
        set_XGMII_RXFIFO_RD_ERR = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_RD_RF
        get_XGMII_RXFIFO_RD_RF = read_XGMII_RXFIFO_RD_RF_value
    End Property

    Property Let set_XGMII_RXFIFO_RD_RF(aData)
        write_XGMII_RXFIFO_RD_RF_value = aData
        flag_XGMII_RXFIFO_RD_RF        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_RD_RF
        read
        read_XGMII_RXFIFO_RD_RF = read_XGMII_RXFIFO_RD_RF_value
    End Property

    Property Let write_XGMII_RXFIFO_RD_RF(aData)
        set_XGMII_RXFIFO_RD_RF = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_RD_LF
        get_XGMII_RXFIFO_RD_LF = read_XGMII_RXFIFO_RD_LF_value
    End Property

    Property Let set_XGMII_RXFIFO_RD_LF(aData)
        write_XGMII_RXFIFO_RD_LF_value = aData
        flag_XGMII_RXFIFO_RD_LF        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_RD_LF
        read
        read_XGMII_RXFIFO_RD_LF = read_XGMII_RXFIFO_RD_LF_value
    End Property

    Property Let write_XGMII_RXFIFO_RD_LF(aData)
        set_XGMII_RXFIFO_RD_LF = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_WR_ERR
        get_XGMII_RXFIFO_WR_ERR = read_XGMII_RXFIFO_WR_ERR_value
    End Property

    Property Let set_XGMII_RXFIFO_WR_ERR(aData)
        write_XGMII_RXFIFO_WR_ERR_value = aData
        flag_XGMII_RXFIFO_WR_ERR        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_WR_ERR
        read
        read_XGMII_RXFIFO_WR_ERR = read_XGMII_RXFIFO_WR_ERR_value
    End Property

    Property Let write_XGMII_RXFIFO_WR_ERR(aData)
        set_XGMII_RXFIFO_WR_ERR = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_WR_RF
        get_XGMII_RXFIFO_WR_RF = read_XGMII_RXFIFO_WR_RF_value
    End Property

    Property Let set_XGMII_RXFIFO_WR_RF(aData)
        write_XGMII_RXFIFO_WR_RF_value = aData
        flag_XGMII_RXFIFO_WR_RF        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_WR_RF
        read
        read_XGMII_RXFIFO_WR_RF = read_XGMII_RXFIFO_WR_RF_value
    End Property

    Property Let write_XGMII_RXFIFO_WR_RF(aData)
        set_XGMII_RXFIFO_WR_RF = aData
        write
    End Property

    Property Get get_XGMII_RXFIFO_WR_LF
        get_XGMII_RXFIFO_WR_LF = read_XGMII_RXFIFO_WR_LF_value
    End Property

    Property Let set_XGMII_RXFIFO_WR_LF(aData)
        write_XGMII_RXFIFO_WR_LF_value = aData
        flag_XGMII_RXFIFO_WR_LF        = &H1
    End Property

    Property Get read_XGMII_RXFIFO_WR_LF
        read
        read_XGMII_RXFIFO_WR_LF = read_XGMII_RXFIFO_WR_LF_value
    End Property

    Property Let write_XGMII_RXFIFO_WR_LF(aData)
        set_XGMII_RXFIFO_WR_LF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_STS_LATCH_value = rightShift(data_low, 12) and &H1
        read_XGMII_RXFIFO_INSERT_EVNT_LH_value = rightShift(data_low, 11) and &H1
        read_XGMII_RXFIFO_DELETE_EVNT_LH_value = rightShift(data_low, 10) and &H1
        read_XGMII_RXFIFO_FULL_LH_value = rightShift(data_low, 9) and &H1
        read_XGMII_RXFIFO_EMPTY_LH_value = rightShift(data_low, 8) and &H1
        read_XGMII_RXFIFO_ALMOST_FULL_LH_value = rightShift(data_low, 7) and &H1
        read_XGMII_RXFIFO_ALMOST_EMPTY_LH_value = rightShift(data_low, 6) and &H1
        read_XGMII_RXFIFO_RD_ERR_value = rightShift(data_low, 5) and &H1
        read_XGMII_RXFIFO_RD_RF_value = rightShift(data_low, 4) and &H1
        read_XGMII_RXFIFO_RD_LF_value = rightShift(data_low, 3) and &H1
        read_XGMII_RXFIFO_WR_ERR_value = rightShift(data_low, 2) and &H1
        read_XGMII_RXFIFO_WR_RF_value = rightShift(data_low, 1) and &H1
        XGMII_RXFIFO_WR_LF_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_WR_LF_mask = mask then
                read_XGMII_RXFIFO_WR_LF_value = data_low
            else
                read_XGMII_RXFIFO_WR_LF_value = (data_low - H8000_0000) and XGMII_RXFIFO_WR_LF_mask
            end If
        else
            read_XGMII_RXFIFO_WR_LF_value = data_low and XGMII_RXFIFO_WR_LF_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_RXFIFO_STS_LATCH = &H0 or flag_XGMII_RXFIFO_INSERT_EVNT_LH = &H0 or flag_XGMII_RXFIFO_DELETE_EVNT_LH = &H0 or flag_XGMII_RXFIFO_FULL_LH = &H0 or flag_XGMII_RXFIFO_EMPTY_LH = &H0 or flag_XGMII_RXFIFO_ALMOST_FULL_LH = &H0 or flag_XGMII_RXFIFO_ALMOST_EMPTY_LH = &H0 or flag_XGMII_RXFIFO_RD_ERR = &H0 or flag_XGMII_RXFIFO_RD_RF = &H0 or flag_XGMII_RXFIFO_RD_LF = &H0 or flag_XGMII_RXFIFO_WR_ERR = &H0 or flag_XGMII_RXFIFO_WR_RF = &H0 or flag_XGMII_RXFIFO_WR_LF = &H0 Then read
        If flag_XGMII_RXFIFO_STS_LATCH = &H0 Then write_XGMII_RXFIFO_STS_LATCH_value = get_XGMII_RXFIFO_STS_LATCH
        If flag_XGMII_RXFIFO_INSERT_EVNT_LH = &H0 Then write_XGMII_RXFIFO_INSERT_EVNT_LH_value = get_XGMII_RXFIFO_INSERT_EVNT_LH
        If flag_XGMII_RXFIFO_DELETE_EVNT_LH = &H0 Then write_XGMII_RXFIFO_DELETE_EVNT_LH_value = get_XGMII_RXFIFO_DELETE_EVNT_LH
        If flag_XGMII_RXFIFO_FULL_LH = &H0 Then write_XGMII_RXFIFO_FULL_LH_value = get_XGMII_RXFIFO_FULL_LH
        If flag_XGMII_RXFIFO_EMPTY_LH = &H0 Then write_XGMII_RXFIFO_EMPTY_LH_value = get_XGMII_RXFIFO_EMPTY_LH
        If flag_XGMII_RXFIFO_ALMOST_FULL_LH = &H0 Then write_XGMII_RXFIFO_ALMOST_FULL_LH_value = get_XGMII_RXFIFO_ALMOST_FULL_LH
        If flag_XGMII_RXFIFO_ALMOST_EMPTY_LH = &H0 Then write_XGMII_RXFIFO_ALMOST_EMPTY_LH_value = get_XGMII_RXFIFO_ALMOST_EMPTY_LH
        If flag_XGMII_RXFIFO_RD_ERR = &H0 Then write_XGMII_RXFIFO_RD_ERR_value = get_XGMII_RXFIFO_RD_ERR
        If flag_XGMII_RXFIFO_RD_RF = &H0 Then write_XGMII_RXFIFO_RD_RF_value = get_XGMII_RXFIFO_RD_RF
        If flag_XGMII_RXFIFO_RD_LF = &H0 Then write_XGMII_RXFIFO_RD_LF_value = get_XGMII_RXFIFO_RD_LF
        If flag_XGMII_RXFIFO_WR_ERR = &H0 Then write_XGMII_RXFIFO_WR_ERR_value = get_XGMII_RXFIFO_WR_ERR
        If flag_XGMII_RXFIFO_WR_RF = &H0 Then write_XGMII_RXFIFO_WR_RF_value = get_XGMII_RXFIFO_WR_RF
        If flag_XGMII_RXFIFO_WR_LF = &H0 Then write_XGMII_RXFIFO_WR_LF_value = get_XGMII_RXFIFO_WR_LF

        regValue = leftShift((write_XGMII_RXFIFO_STS_LATCH_value and &H1), 12) + leftShift((write_XGMII_RXFIFO_INSERT_EVNT_LH_value and &H1), 11) + leftShift((write_XGMII_RXFIFO_DELETE_EVNT_LH_value and &H1), 10) + leftShift((write_XGMII_RXFIFO_FULL_LH_value and &H1), 9) + leftShift((write_XGMII_RXFIFO_EMPTY_LH_value and &H1), 8) + leftShift((write_XGMII_RXFIFO_ALMOST_FULL_LH_value and &H1), 7) + leftShift((write_XGMII_RXFIFO_ALMOST_EMPTY_LH_value and &H1), 6) + leftShift((write_XGMII_RXFIFO_RD_ERR_value and &H1), 5) + leftShift((write_XGMII_RXFIFO_RD_RF_value and &H1), 4) + leftShift((write_XGMII_RXFIFO_RD_LF_value and &H1), 3) + leftShift((write_XGMII_RXFIFO_WR_ERR_value and &H1), 2) + leftShift((write_XGMII_RXFIFO_WR_RF_value and &H1), 1) + leftShift((write_XGMII_RXFIFO_WR_LF_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_RXFIFO_STS_LATCH_value = rightShift(data_low, 12) and &H1
        read_XGMII_RXFIFO_INSERT_EVNT_LH_value = rightShift(data_low, 11) and &H1
        read_XGMII_RXFIFO_DELETE_EVNT_LH_value = rightShift(data_low, 10) and &H1
        read_XGMII_RXFIFO_FULL_LH_value = rightShift(data_low, 9) and &H1
        read_XGMII_RXFIFO_EMPTY_LH_value = rightShift(data_low, 8) and &H1
        read_XGMII_RXFIFO_ALMOST_FULL_LH_value = rightShift(data_low, 7) and &H1
        read_XGMII_RXFIFO_ALMOST_EMPTY_LH_value = rightShift(data_low, 6) and &H1
        read_XGMII_RXFIFO_RD_ERR_value = rightShift(data_low, 5) and &H1
        read_XGMII_RXFIFO_RD_RF_value = rightShift(data_low, 4) and &H1
        read_XGMII_RXFIFO_RD_LF_value = rightShift(data_low, 3) and &H1
        read_XGMII_RXFIFO_WR_ERR_value = rightShift(data_low, 2) and &H1
        read_XGMII_RXFIFO_WR_RF_value = rightShift(data_low, 1) and &H1
        XGMII_RXFIFO_WR_LF_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_RXFIFO_WR_LF_mask = mask then
                read_XGMII_RXFIFO_WR_LF_value = data_low
            else
                read_XGMII_RXFIFO_WR_LF_value = (data_low - H8000_0000) and XGMII_RXFIFO_WR_LF_mask
            end If
        else
            read_XGMII_RXFIFO_WR_LF_value = data_low and XGMII_RXFIFO_WR_LF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_RXFIFO_STS_LATCH_value = &H0
        flag_XGMII_RXFIFO_STS_LATCH        = &H0
        write_XGMII_RXFIFO_INSERT_EVNT_LH_value = &H0
        flag_XGMII_RXFIFO_INSERT_EVNT_LH        = &H0
        write_XGMII_RXFIFO_DELETE_EVNT_LH_value = &H0
        flag_XGMII_RXFIFO_DELETE_EVNT_LH        = &H0
        write_XGMII_RXFIFO_FULL_LH_value = &H0
        flag_XGMII_RXFIFO_FULL_LH        = &H0
        write_XGMII_RXFIFO_EMPTY_LH_value = &H0
        flag_XGMII_RXFIFO_EMPTY_LH        = &H0
        write_XGMII_RXFIFO_ALMOST_FULL_LH_value = &H0
        flag_XGMII_RXFIFO_ALMOST_FULL_LH        = &H0
        write_XGMII_RXFIFO_ALMOST_EMPTY_LH_value = &H0
        flag_XGMII_RXFIFO_ALMOST_EMPTY_LH        = &H0
        write_XGMII_RXFIFO_RD_ERR_value = &H0
        flag_XGMII_RXFIFO_RD_ERR        = &H0
        write_XGMII_RXFIFO_RD_RF_value = &H0
        flag_XGMII_RXFIFO_RD_RF        = &H0
        write_XGMII_RXFIFO_RD_LF_value = &H0
        flag_XGMII_RXFIFO_RD_LF        = &H0
        write_XGMII_RXFIFO_WR_ERR_value = &H0
        flag_XGMII_RXFIFO_WR_ERR        = &H0
        write_XGMII_RXFIFO_WR_RF_value = &H0
        flag_XGMII_RXFIFO_WR_RF        = &H0
        write_XGMII_RXFIFO_WR_LF_value = &H0
        flag_XGMII_RXFIFO_WR_LF        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_txfifo_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_ENABLE                        [15:15]          get_XGMII_TXFIFO_ENABLE
''                                                             set_XGMII_TXFIFO_ENABLE
''                                                             read_XGMII_TXFIFO_ENABLE
''                                                             write_XGMII_TXFIFO_ENABLE
''---------------------------------------------------------------------------------
'' TXFIFO_RF_RAM_TM_NOT_USED                  [6:3]            get_TXFIFO_RF_RAM_TM_NOT_USED
''                                                             set_TXFIFO_RF_RAM_TM_NOT_USED
''                                                             read_TXFIFO_RF_RAM_TM_NOT_USED
''                                                             write_TXFIFO_RF_RAM_TM_NOT_USED
''---------------------------------------------------------------------------------
'' XGMII_TX_CLK_COMP_DIS                      [2:2]            get_XGMII_TX_CLK_COMP_DIS
''                                                             set_XGMII_TX_CLK_COMP_DIS
''                                                             read_XGMII_TX_CLK_COMP_DIS
''                                                             write_XGMII_TX_CLK_COMP_DIS
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_B2B_DEL_EN                    [1:1]            get_XGMII_TXFIFO_B2B_DEL_EN
''                                                             set_XGMII_TXFIFO_B2B_DEL_EN
''                                                             read_XGMII_TXFIFO_B2B_DEL_EN
''                                                             write_XGMII_TXFIFO_B2B_DEL_EN
''---------------------------------------------------------------------------------
'' XGMII_TX_CLK_COMP_CNT_SAT_TEST             [0:0]            get_XGMII_TX_CLK_COMP_CNT_SAT_TEST
''                                                             set_XGMII_TX_CLK_COMP_CNT_SAT_TEST
''                                                             read_XGMII_TX_CLK_COMP_CNT_SAT_TEST
''                                                             write_XGMII_TX_CLK_COMP_CNT_SAT_TEST
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_txfifo_ctl
    Private write_XGMII_TXFIFO_ENABLE_value
    Private read_XGMII_TXFIFO_ENABLE_value
    Private flag_XGMII_TXFIFO_ENABLE
    Private write_TXFIFO_RF_RAM_TM_NOT_USED_value
    Private read_TXFIFO_RF_RAM_TM_NOT_USED_value
    Private flag_TXFIFO_RF_RAM_TM_NOT_USED
    Private write_XGMII_TX_CLK_COMP_DIS_value
    Private read_XGMII_TX_CLK_COMP_DIS_value
    Private flag_XGMII_TX_CLK_COMP_DIS
    Private write_XGMII_TXFIFO_B2B_DEL_EN_value
    Private read_XGMII_TXFIFO_B2B_DEL_EN_value
    Private flag_XGMII_TXFIFO_B2B_DEL_EN
    Private write_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value
    Private read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value
    Private flag_XGMII_TX_CLK_COMP_CNT_SAT_TEST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_TXFIFO_ENABLE
        get_XGMII_TXFIFO_ENABLE = read_XGMII_TXFIFO_ENABLE_value
    End Property

    Property Let set_XGMII_TXFIFO_ENABLE(aData)
        write_XGMII_TXFIFO_ENABLE_value = aData
        flag_XGMII_TXFIFO_ENABLE        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_ENABLE
        read
        read_XGMII_TXFIFO_ENABLE = read_XGMII_TXFIFO_ENABLE_value
    End Property

    Property Let write_XGMII_TXFIFO_ENABLE(aData)
        set_XGMII_TXFIFO_ENABLE = aData
        write
    End Property

    Property Get get_TXFIFO_RF_RAM_TM_NOT_USED
        get_TXFIFO_RF_RAM_TM_NOT_USED = read_TXFIFO_RF_RAM_TM_NOT_USED_value
    End Property

    Property Let set_TXFIFO_RF_RAM_TM_NOT_USED(aData)
        write_TXFIFO_RF_RAM_TM_NOT_USED_value = aData
        flag_TXFIFO_RF_RAM_TM_NOT_USED        = &H1
    End Property

    Property Get read_TXFIFO_RF_RAM_TM_NOT_USED
        read
        read_TXFIFO_RF_RAM_TM_NOT_USED = read_TXFIFO_RF_RAM_TM_NOT_USED_value
    End Property

    Property Let write_TXFIFO_RF_RAM_TM_NOT_USED(aData)
        set_TXFIFO_RF_RAM_TM_NOT_USED = aData
        write
    End Property

    Property Get get_XGMII_TX_CLK_COMP_DIS
        get_XGMII_TX_CLK_COMP_DIS = read_XGMII_TX_CLK_COMP_DIS_value
    End Property

    Property Let set_XGMII_TX_CLK_COMP_DIS(aData)
        write_XGMII_TX_CLK_COMP_DIS_value = aData
        flag_XGMII_TX_CLK_COMP_DIS        = &H1
    End Property

    Property Get read_XGMII_TX_CLK_COMP_DIS
        read
        read_XGMII_TX_CLK_COMP_DIS = read_XGMII_TX_CLK_COMP_DIS_value
    End Property

    Property Let write_XGMII_TX_CLK_COMP_DIS(aData)
        set_XGMII_TX_CLK_COMP_DIS = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_B2B_DEL_EN
        get_XGMII_TXFIFO_B2B_DEL_EN = read_XGMII_TXFIFO_B2B_DEL_EN_value
    End Property

    Property Let set_XGMII_TXFIFO_B2B_DEL_EN(aData)
        write_XGMII_TXFIFO_B2B_DEL_EN_value = aData
        flag_XGMII_TXFIFO_B2B_DEL_EN        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_B2B_DEL_EN
        read
        read_XGMII_TXFIFO_B2B_DEL_EN = read_XGMII_TXFIFO_B2B_DEL_EN_value
    End Property

    Property Let write_XGMII_TXFIFO_B2B_DEL_EN(aData)
        set_XGMII_TXFIFO_B2B_DEL_EN = aData
        write
    End Property

    Property Get get_XGMII_TX_CLK_COMP_CNT_SAT_TEST
        get_XGMII_TX_CLK_COMP_CNT_SAT_TEST = read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value
    End Property

    Property Let set_XGMII_TX_CLK_COMP_CNT_SAT_TEST(aData)
        write_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = aData
        flag_XGMII_TX_CLK_COMP_CNT_SAT_TEST        = &H1
    End Property

    Property Get read_XGMII_TX_CLK_COMP_CNT_SAT_TEST
        read
        read_XGMII_TX_CLK_COMP_CNT_SAT_TEST = read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value
    End Property

    Property Let write_XGMII_TX_CLK_COMP_CNT_SAT_TEST(aData)
        set_XGMII_TX_CLK_COMP_CNT_SAT_TEST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_ENABLE_value = rightShift(data_low, 15) and &H1
        read_TXFIFO_RF_RAM_TM_NOT_USED_value = rightShift(data_low, 3) and &Hf
        read_XGMII_TX_CLK_COMP_DIS_value = rightShift(data_low, 2) and &H1
        read_XGMII_TXFIFO_B2B_DEL_EN_value = rightShift(data_low, 1) and &H1
        XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask = mask then
                read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = data_low
            else
                read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = (data_low - H8000_0000) and XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask
            end If
        else
            read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = data_low and XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_TXFIFO_ENABLE = &H0 or flag_TXFIFO_RF_RAM_TM_NOT_USED = &H0 or flag_XGMII_TX_CLK_COMP_DIS = &H0 or flag_XGMII_TXFIFO_B2B_DEL_EN = &H0 or flag_XGMII_TX_CLK_COMP_CNT_SAT_TEST = &H0 Then read
        If flag_XGMII_TXFIFO_ENABLE = &H0 Then write_XGMII_TXFIFO_ENABLE_value = get_XGMII_TXFIFO_ENABLE
        If flag_TXFIFO_RF_RAM_TM_NOT_USED = &H0 Then write_TXFIFO_RF_RAM_TM_NOT_USED_value = get_TXFIFO_RF_RAM_TM_NOT_USED
        If flag_XGMII_TX_CLK_COMP_DIS = &H0 Then write_XGMII_TX_CLK_COMP_DIS_value = get_XGMII_TX_CLK_COMP_DIS
        If flag_XGMII_TXFIFO_B2B_DEL_EN = &H0 Then write_XGMII_TXFIFO_B2B_DEL_EN_value = get_XGMII_TXFIFO_B2B_DEL_EN
        If flag_XGMII_TX_CLK_COMP_CNT_SAT_TEST = &H0 Then write_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = get_XGMII_TX_CLK_COMP_CNT_SAT_TEST

        regValue = leftShift((write_XGMII_TXFIFO_ENABLE_value and &H1), 15) + leftShift((write_TXFIFO_RF_RAM_TM_NOT_USED_value and &Hf), 3) + leftShift((write_XGMII_TX_CLK_COMP_DIS_value and &H1), 2) + leftShift((write_XGMII_TXFIFO_B2B_DEL_EN_value and &H1), 1) + leftShift((write_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_ENABLE_value = rightShift(data_low, 15) and &H1
        read_TXFIFO_RF_RAM_TM_NOT_USED_value = rightShift(data_low, 3) and &Hf
        read_XGMII_TX_CLK_COMP_DIS_value = rightShift(data_low, 2) and &H1
        read_XGMII_TXFIFO_B2B_DEL_EN_value = rightShift(data_low, 1) and &H1
        XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask = mask then
                read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = data_low
            else
                read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = (data_low - H8000_0000) and XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask
            end If
        else
            read_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = data_low and XGMII_TX_CLK_COMP_CNT_SAT_TEST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_TXFIFO_ENABLE_value = &H0
        flag_XGMII_TXFIFO_ENABLE        = &H0
        write_TXFIFO_RF_RAM_TM_NOT_USED_value = &H0
        flag_TXFIFO_RF_RAM_TM_NOT_USED        = &H0
        write_XGMII_TX_CLK_COMP_DIS_value = &H0
        flag_XGMII_TX_CLK_COMP_DIS        = &H0
        write_XGMII_TXFIFO_B2B_DEL_EN_value = &H0
        flag_XGMII_TXFIFO_B2B_DEL_EN        = &H0
        write_XGMII_TX_CLK_COMP_CNT_SAT_TEST_value = &H0
        flag_XGMII_TX_CLK_COMP_CNT_SAT_TEST        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_txfifo_trshd_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_ALMOST_FULL_TRSHD             [15:12]          get_XGMII_TXFIFO_ALMOST_FULL_TRSHD
''                                                             set_XGMII_TXFIFO_ALMOST_FULL_TRSHD
''                                                             read_XGMII_TXFIFO_ALMOST_FULL_TRSHD
''                                                             write_XGMII_TXFIFO_ALMOST_FULL_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_ALMOST_EMPTY_TRSHD            [11:10]          get_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
''                                                             set_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
''                                                             read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
''                                                             write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_DEL_TRSHD                     [9:6]            get_XGMII_TXFIFO_DEL_TRSHD
''                                                             set_XGMII_TXFIFO_DEL_TRSHD
''                                                             read_XGMII_TXFIFO_DEL_TRSHD
''                                                             write_XGMII_TXFIFO_DEL_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_INST_TRSHD                    [5:3]            get_XGMII_TXFIFO_INST_TRSHD
''                                                             set_XGMII_TXFIFO_INST_TRSHD
''                                                             read_XGMII_TXFIFO_INST_TRSHD
''                                                             write_XGMII_TXFIFO_INST_TRSHD
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_STRD_TRSHD                    [2:0]            get_XGMII_TXFIFO_STRD_TRSHD
''                                                             set_XGMII_TXFIFO_STRD_TRSHD
''                                                             read_XGMII_TXFIFO_STRD_TRSHD
''                                                             write_XGMII_TXFIFO_STRD_TRSHD
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_txfifo_trshd_ctl
    Private write_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value
    Private read_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value
    Private flag_XGMII_TXFIFO_ALMOST_FULL_TRSHD
    Private write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value
    Private read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value
    Private flag_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
    Private write_XGMII_TXFIFO_DEL_TRSHD_value
    Private read_XGMII_TXFIFO_DEL_TRSHD_value
    Private flag_XGMII_TXFIFO_DEL_TRSHD
    Private write_XGMII_TXFIFO_INST_TRSHD_value
    Private read_XGMII_TXFIFO_INST_TRSHD_value
    Private flag_XGMII_TXFIFO_INST_TRSHD
    Private write_XGMII_TXFIFO_STRD_TRSHD_value
    Private read_XGMII_TXFIFO_STRD_TRSHD_value
    Private flag_XGMII_TXFIFO_STRD_TRSHD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_TXFIFO_ALMOST_FULL_TRSHD
        get_XGMII_TXFIFO_ALMOST_FULL_TRSHD = read_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value
    End Property

    Property Let set_XGMII_TXFIFO_ALMOST_FULL_TRSHD(aData)
        write_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value = aData
        flag_XGMII_TXFIFO_ALMOST_FULL_TRSHD        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_ALMOST_FULL_TRSHD
        read
        read_XGMII_TXFIFO_ALMOST_FULL_TRSHD = read_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value
    End Property

    Property Let write_XGMII_TXFIFO_ALMOST_FULL_TRSHD(aData)
        set_XGMII_TXFIFO_ALMOST_FULL_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
        get_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD = read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value
    End Property

    Property Let set_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD(aData)
        write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value = aData
        flag_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
        read
        read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD = read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value
    End Property

    Property Let write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD(aData)
        set_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_DEL_TRSHD
        get_XGMII_TXFIFO_DEL_TRSHD = read_XGMII_TXFIFO_DEL_TRSHD_value
    End Property

    Property Let set_XGMII_TXFIFO_DEL_TRSHD(aData)
        write_XGMII_TXFIFO_DEL_TRSHD_value = aData
        flag_XGMII_TXFIFO_DEL_TRSHD        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_DEL_TRSHD
        read
        read_XGMII_TXFIFO_DEL_TRSHD = read_XGMII_TXFIFO_DEL_TRSHD_value
    End Property

    Property Let write_XGMII_TXFIFO_DEL_TRSHD(aData)
        set_XGMII_TXFIFO_DEL_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_INST_TRSHD
        get_XGMII_TXFIFO_INST_TRSHD = read_XGMII_TXFIFO_INST_TRSHD_value
    End Property

    Property Let set_XGMII_TXFIFO_INST_TRSHD(aData)
        write_XGMII_TXFIFO_INST_TRSHD_value = aData
        flag_XGMII_TXFIFO_INST_TRSHD        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_INST_TRSHD
        read
        read_XGMII_TXFIFO_INST_TRSHD = read_XGMII_TXFIFO_INST_TRSHD_value
    End Property

    Property Let write_XGMII_TXFIFO_INST_TRSHD(aData)
        set_XGMII_TXFIFO_INST_TRSHD = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_STRD_TRSHD
        get_XGMII_TXFIFO_STRD_TRSHD = read_XGMII_TXFIFO_STRD_TRSHD_value
    End Property

    Property Let set_XGMII_TXFIFO_STRD_TRSHD(aData)
        write_XGMII_TXFIFO_STRD_TRSHD_value = aData
        flag_XGMII_TXFIFO_STRD_TRSHD        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_STRD_TRSHD
        read
        read_XGMII_TXFIFO_STRD_TRSHD = read_XGMII_TXFIFO_STRD_TRSHD_value
    End Property

    Property Let write_XGMII_TXFIFO_STRD_TRSHD(aData)
        set_XGMII_TXFIFO_STRD_TRSHD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value = rightShift(data_low, 12) and &Hf
        read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value = rightShift(data_low, 10) and &H3
        read_XGMII_TXFIFO_DEL_TRSHD_value = rightShift(data_low, 6) and &Hf
        read_XGMII_TXFIFO_INST_TRSHD_value = rightShift(data_low, 3) and &H7
        XGMII_TXFIFO_STRD_TRSHD_mask = &H7
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_STRD_TRSHD_mask = mask then
                read_XGMII_TXFIFO_STRD_TRSHD_value = data_low
            else
                read_XGMII_TXFIFO_STRD_TRSHD_value = (data_low - H8000_0000) and XGMII_TXFIFO_STRD_TRSHD_mask
            end If
        else
            read_XGMII_TXFIFO_STRD_TRSHD_value = data_low and XGMII_TXFIFO_STRD_TRSHD_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_TXFIFO_ALMOST_FULL_TRSHD = &H0 or flag_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD = &H0 or flag_XGMII_TXFIFO_DEL_TRSHD = &H0 or flag_XGMII_TXFIFO_INST_TRSHD = &H0 or flag_XGMII_TXFIFO_STRD_TRSHD = &H0 Then read
        If flag_XGMII_TXFIFO_ALMOST_FULL_TRSHD = &H0 Then write_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value = get_XGMII_TXFIFO_ALMOST_FULL_TRSHD
        If flag_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD = &H0 Then write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value = get_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD
        If flag_XGMII_TXFIFO_DEL_TRSHD = &H0 Then write_XGMII_TXFIFO_DEL_TRSHD_value = get_XGMII_TXFIFO_DEL_TRSHD
        If flag_XGMII_TXFIFO_INST_TRSHD = &H0 Then write_XGMII_TXFIFO_INST_TRSHD_value = get_XGMII_TXFIFO_INST_TRSHD
        If flag_XGMII_TXFIFO_STRD_TRSHD = &H0 Then write_XGMII_TXFIFO_STRD_TRSHD_value = get_XGMII_TXFIFO_STRD_TRSHD

        regValue = leftShift((write_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value and &Hf), 12) + leftShift((write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value and &H3), 10) + leftShift((write_XGMII_TXFIFO_DEL_TRSHD_value and &Hf), 6) + leftShift((write_XGMII_TXFIFO_INST_TRSHD_value and &H7), 3) + leftShift((write_XGMII_TXFIFO_STRD_TRSHD_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value = rightShift(data_low, 12) and &Hf
        read_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value = rightShift(data_low, 10) and &H3
        read_XGMII_TXFIFO_DEL_TRSHD_value = rightShift(data_low, 6) and &Hf
        read_XGMII_TXFIFO_INST_TRSHD_value = rightShift(data_low, 3) and &H7
        XGMII_TXFIFO_STRD_TRSHD_mask = &H7
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_STRD_TRSHD_mask = mask then
                read_XGMII_TXFIFO_STRD_TRSHD_value = data_low
            else
                read_XGMII_TXFIFO_STRD_TRSHD_value = (data_low - H8000_0000) and XGMII_TXFIFO_STRD_TRSHD_mask
            end If
        else
            read_XGMII_TXFIFO_STRD_TRSHD_value = data_low and XGMII_TXFIFO_STRD_TRSHD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_TXFIFO_ALMOST_FULL_TRSHD_value = &H0
        flag_XGMII_TXFIFO_ALMOST_FULL_TRSHD        = &H0
        write_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD_value = &H0
        flag_XGMII_TXFIFO_ALMOST_EMPTY_TRSHD        = &H0
        write_XGMII_TXFIFO_DEL_TRSHD_value = &H0
        flag_XGMII_TXFIFO_DEL_TRSHD        = &H0
        write_XGMII_TXFIFO_INST_TRSHD_value = &H0
        flag_XGMII_TXFIFO_INST_TRSHD        = &H0
        write_XGMII_TXFIFO_STRD_TRSHD_value = &H0
        flag_XGMII_TXFIFO_STRD_TRSHD        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_txfifo_delete_cnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_DELETE_CNT_LAT                [15:15]          get_XGMII_TXFIFO_DELETE_CNT_LAT
''                                                             set_XGMII_TXFIFO_DELETE_CNT_LAT
''                                                             read_XGMII_TXFIFO_DELETE_CNT_LAT
''                                                             write_XGMII_TXFIFO_DELETE_CNT_LAT
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_DELETE_CNT                    [14:0]           get_XGMII_TXFIFO_DELETE_CNT
''                                                             set_XGMII_TXFIFO_DELETE_CNT
''                                                             read_XGMII_TXFIFO_DELETE_CNT
''                                                             write_XGMII_TXFIFO_DELETE_CNT
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_txfifo_delete_cnt
    Private write_XGMII_TXFIFO_DELETE_CNT_LAT_value
    Private read_XGMII_TXFIFO_DELETE_CNT_LAT_value
    Private flag_XGMII_TXFIFO_DELETE_CNT_LAT
    Private write_XGMII_TXFIFO_DELETE_CNT_value
    Private read_XGMII_TXFIFO_DELETE_CNT_value
    Private flag_XGMII_TXFIFO_DELETE_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_TXFIFO_DELETE_CNT_LAT
        get_XGMII_TXFIFO_DELETE_CNT_LAT = read_XGMII_TXFIFO_DELETE_CNT_LAT_value
    End Property

    Property Let set_XGMII_TXFIFO_DELETE_CNT_LAT(aData)
        write_XGMII_TXFIFO_DELETE_CNT_LAT_value = aData
        flag_XGMII_TXFIFO_DELETE_CNT_LAT        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_DELETE_CNT_LAT
        read
        read_XGMII_TXFIFO_DELETE_CNT_LAT = read_XGMII_TXFIFO_DELETE_CNT_LAT_value
    End Property

    Property Let write_XGMII_TXFIFO_DELETE_CNT_LAT(aData)
        set_XGMII_TXFIFO_DELETE_CNT_LAT = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_DELETE_CNT
        get_XGMII_TXFIFO_DELETE_CNT = read_XGMII_TXFIFO_DELETE_CNT_value
    End Property

    Property Let set_XGMII_TXFIFO_DELETE_CNT(aData)
        write_XGMII_TXFIFO_DELETE_CNT_value = aData
        flag_XGMII_TXFIFO_DELETE_CNT        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_DELETE_CNT
        read
        read_XGMII_TXFIFO_DELETE_CNT = read_XGMII_TXFIFO_DELETE_CNT_value
    End Property

    Property Let write_XGMII_TXFIFO_DELETE_CNT(aData)
        set_XGMII_TXFIFO_DELETE_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_DELETE_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_TXFIFO_DELETE_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_DELETE_CNT_mask = mask then
                read_XGMII_TXFIFO_DELETE_CNT_value = data_low
            else
                read_XGMII_TXFIFO_DELETE_CNT_value = (data_low - H8000_0000) and XGMII_TXFIFO_DELETE_CNT_mask
            end If
        else
            read_XGMII_TXFIFO_DELETE_CNT_value = data_low and XGMII_TXFIFO_DELETE_CNT_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_TXFIFO_DELETE_CNT_LAT = &H0 or flag_XGMII_TXFIFO_DELETE_CNT = &H0 Then read
        If flag_XGMII_TXFIFO_DELETE_CNT_LAT = &H0 Then write_XGMII_TXFIFO_DELETE_CNT_LAT_value = get_XGMII_TXFIFO_DELETE_CNT_LAT
        If flag_XGMII_TXFIFO_DELETE_CNT = &H0 Then write_XGMII_TXFIFO_DELETE_CNT_value = get_XGMII_TXFIFO_DELETE_CNT

        regValue = leftShift((write_XGMII_TXFIFO_DELETE_CNT_LAT_value and &H1), 15) + leftShift((write_XGMII_TXFIFO_DELETE_CNT_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_DELETE_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_TXFIFO_DELETE_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_DELETE_CNT_mask = mask then
                read_XGMII_TXFIFO_DELETE_CNT_value = data_low
            else
                read_XGMII_TXFIFO_DELETE_CNT_value = (data_low - H8000_0000) and XGMII_TXFIFO_DELETE_CNT_mask
            end If
        else
            read_XGMII_TXFIFO_DELETE_CNT_value = data_low and XGMII_TXFIFO_DELETE_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_TXFIFO_DELETE_CNT_LAT_value = &H0
        flag_XGMII_TXFIFO_DELETE_CNT_LAT        = &H0
        write_XGMII_TXFIFO_DELETE_CNT_value = &H0
        flag_XGMII_TXFIFO_DELETE_CNT        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_txfifo_insert_cnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_INSERT_CNT_LAT                [15:15]          get_XGMII_TXFIFO_INSERT_CNT_LAT
''                                                             set_XGMII_TXFIFO_INSERT_CNT_LAT
''                                                             read_XGMII_TXFIFO_INSERT_CNT_LAT
''                                                             write_XGMII_TXFIFO_INSERT_CNT_LAT
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_INSERT_CNT                    [14:0]           get_XGMII_TXFIFO_INSERT_CNT
''                                                             set_XGMII_TXFIFO_INSERT_CNT
''                                                             read_XGMII_TXFIFO_INSERT_CNT
''                                                             write_XGMII_TXFIFO_INSERT_CNT
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_txfifo_insert_cnt
    Private write_XGMII_TXFIFO_INSERT_CNT_LAT_value
    Private read_XGMII_TXFIFO_INSERT_CNT_LAT_value
    Private flag_XGMII_TXFIFO_INSERT_CNT_LAT
    Private write_XGMII_TXFIFO_INSERT_CNT_value
    Private read_XGMII_TXFIFO_INSERT_CNT_value
    Private flag_XGMII_TXFIFO_INSERT_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_TXFIFO_INSERT_CNT_LAT
        get_XGMII_TXFIFO_INSERT_CNT_LAT = read_XGMII_TXFIFO_INSERT_CNT_LAT_value
    End Property

    Property Let set_XGMII_TXFIFO_INSERT_CNT_LAT(aData)
        write_XGMII_TXFIFO_INSERT_CNT_LAT_value = aData
        flag_XGMII_TXFIFO_INSERT_CNT_LAT        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_INSERT_CNT_LAT
        read
        read_XGMII_TXFIFO_INSERT_CNT_LAT = read_XGMII_TXFIFO_INSERT_CNT_LAT_value
    End Property

    Property Let write_XGMII_TXFIFO_INSERT_CNT_LAT(aData)
        set_XGMII_TXFIFO_INSERT_CNT_LAT = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_INSERT_CNT
        get_XGMII_TXFIFO_INSERT_CNT = read_XGMII_TXFIFO_INSERT_CNT_value
    End Property

    Property Let set_XGMII_TXFIFO_INSERT_CNT(aData)
        write_XGMII_TXFIFO_INSERT_CNT_value = aData
        flag_XGMII_TXFIFO_INSERT_CNT        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_INSERT_CNT
        read
        read_XGMII_TXFIFO_INSERT_CNT = read_XGMII_TXFIFO_INSERT_CNT_value
    End Property

    Property Let write_XGMII_TXFIFO_INSERT_CNT(aData)
        set_XGMII_TXFIFO_INSERT_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_INSERT_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_TXFIFO_INSERT_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_INSERT_CNT_mask = mask then
                read_XGMII_TXFIFO_INSERT_CNT_value = data_low
            else
                read_XGMII_TXFIFO_INSERT_CNT_value = (data_low - H8000_0000) and XGMII_TXFIFO_INSERT_CNT_mask
            end If
        else
            read_XGMII_TXFIFO_INSERT_CNT_value = data_low and XGMII_TXFIFO_INSERT_CNT_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_TXFIFO_INSERT_CNT_LAT = &H0 or flag_XGMII_TXFIFO_INSERT_CNT = &H0 Then read
        If flag_XGMII_TXFIFO_INSERT_CNT_LAT = &H0 Then write_XGMII_TXFIFO_INSERT_CNT_LAT_value = get_XGMII_TXFIFO_INSERT_CNT_LAT
        If flag_XGMII_TXFIFO_INSERT_CNT = &H0 Then write_XGMII_TXFIFO_INSERT_CNT_value = get_XGMII_TXFIFO_INSERT_CNT

        regValue = leftShift((write_XGMII_TXFIFO_INSERT_CNT_LAT_value and &H1), 15) + leftShift((write_XGMII_TXFIFO_INSERT_CNT_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_INSERT_CNT_LAT_value = rightShift(data_low, 15) and &H1
        XGMII_TXFIFO_INSERT_CNT_mask = &H7fff
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_INSERT_CNT_mask = mask then
                read_XGMII_TXFIFO_INSERT_CNT_value = data_low
            else
                read_XGMII_TXFIFO_INSERT_CNT_value = (data_low - H8000_0000) and XGMII_TXFIFO_INSERT_CNT_mask
            end If
        else
            read_XGMII_TXFIFO_INSERT_CNT_value = data_low and XGMII_TXFIFO_INSERT_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_TXFIFO_INSERT_CNT_LAT_value = &H0
        flag_XGMII_TXFIFO_INSERT_CNT_LAT        = &H0
        write_XGMII_TXFIFO_INSERT_CNT_value = &H0
        flag_XGMII_TXFIFO_INSERT_CNT        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmii_txfifo_lh_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_STS_LATCH                     [12:12]          get_XGMII_TXFIFO_STS_LATCH
''                                                             set_XGMII_TXFIFO_STS_LATCH
''                                                             read_XGMII_TXFIFO_STS_LATCH
''                                                             write_XGMII_TXFIFO_STS_LATCH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_INSERT_EVNT_LH                [11:11]          get_XGMII_TXFIFO_INSERT_EVNT_LH
''                                                             set_XGMII_TXFIFO_INSERT_EVNT_LH
''                                                             read_XGMII_TXFIFO_INSERT_EVNT_LH
''                                                             write_XGMII_TXFIFO_INSERT_EVNT_LH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_DELETE_EVNT_LH                [10:10]          get_XGMII_TXFIFO_DELETE_EVNT_LH
''                                                             set_XGMII_TXFIFO_DELETE_EVNT_LH
''                                                             read_XGMII_TXFIFO_DELETE_EVNT_LH
''                                                             write_XGMII_TXFIFO_DELETE_EVNT_LH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_FULL_LH                       [9:9]            get_XGMII_TXFIFO_FULL_LH
''                                                             set_XGMII_TXFIFO_FULL_LH
''                                                             read_XGMII_TXFIFO_FULL_LH
''                                                             write_XGMII_TXFIFO_FULL_LH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_EMPTY_LH                      [8:8]            get_XGMII_TXFIFO_EMPTY_LH
''                                                             set_XGMII_TXFIFO_EMPTY_LH
''                                                             read_XGMII_TXFIFO_EMPTY_LH
''                                                             write_XGMII_TXFIFO_EMPTY_LH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_ALMOST_FULL_LH                [7:7]            get_XGMII_TXFIFO_ALMOST_FULL_LH
''                                                             set_XGMII_TXFIFO_ALMOST_FULL_LH
''                                                             read_XGMII_TXFIFO_ALMOST_FULL_LH
''                                                             write_XGMII_TXFIFO_ALMOST_FULL_LH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_ALMOST_EMPTY_LH               [6:6]            get_XGMII_TXFIFO_ALMOST_EMPTY_LH
''                                                             set_XGMII_TXFIFO_ALMOST_EMPTY_LH
''                                                             read_XGMII_TXFIFO_ALMOST_EMPTY_LH
''                                                             write_XGMII_TXFIFO_ALMOST_EMPTY_LH
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_RD_ERR                        [5:5]            get_XGMII_TXFIFO_RD_ERR
''                                                             set_XGMII_TXFIFO_RD_ERR
''                                                             read_XGMII_TXFIFO_RD_ERR
''                                                             write_XGMII_TXFIFO_RD_ERR
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_RD_RF                         [4:4]            get_XGMII_TXFIFO_RD_RF
''                                                             set_XGMII_TXFIFO_RD_RF
''                                                             read_XGMII_TXFIFO_RD_RF
''                                                             write_XGMII_TXFIFO_RD_RF
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_RD_LF                         [3:3]            get_XGMII_TXFIFO_RD_LF
''                                                             set_XGMII_TXFIFO_RD_LF
''                                                             read_XGMII_TXFIFO_RD_LF
''                                                             write_XGMII_TXFIFO_RD_LF
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_WR_ERR                        [2:2]            get_XGMII_TXFIFO_WR_ERR
''                                                             set_XGMII_TXFIFO_WR_ERR
''                                                             read_XGMII_TXFIFO_WR_ERR
''                                                             write_XGMII_TXFIFO_WR_ERR
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_WR_RF                         [1:1]            get_XGMII_TXFIFO_WR_RF
''                                                             set_XGMII_TXFIFO_WR_RF
''                                                             read_XGMII_TXFIFO_WR_RF
''                                                             write_XGMII_TXFIFO_WR_RF
''---------------------------------------------------------------------------------
'' XGMII_TXFIFO_WR_LF                         [0:0]            get_XGMII_TXFIFO_WR_LF
''                                                             set_XGMII_TXFIFO_WR_LF
''                                                             read_XGMII_TXFIFO_WR_LF
''                                                             write_XGMII_TXFIFO_WR_LF
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmii_txfifo_lh_sts
    Private write_XGMII_TXFIFO_STS_LATCH_value
    Private read_XGMII_TXFIFO_STS_LATCH_value
    Private flag_XGMII_TXFIFO_STS_LATCH
    Private write_XGMII_TXFIFO_INSERT_EVNT_LH_value
    Private read_XGMII_TXFIFO_INSERT_EVNT_LH_value
    Private flag_XGMII_TXFIFO_INSERT_EVNT_LH
    Private write_XGMII_TXFIFO_DELETE_EVNT_LH_value
    Private read_XGMII_TXFIFO_DELETE_EVNT_LH_value
    Private flag_XGMII_TXFIFO_DELETE_EVNT_LH
    Private write_XGMII_TXFIFO_FULL_LH_value
    Private read_XGMII_TXFIFO_FULL_LH_value
    Private flag_XGMII_TXFIFO_FULL_LH
    Private write_XGMII_TXFIFO_EMPTY_LH_value
    Private read_XGMII_TXFIFO_EMPTY_LH_value
    Private flag_XGMII_TXFIFO_EMPTY_LH
    Private write_XGMII_TXFIFO_ALMOST_FULL_LH_value
    Private read_XGMII_TXFIFO_ALMOST_FULL_LH_value
    Private flag_XGMII_TXFIFO_ALMOST_FULL_LH
    Private write_XGMII_TXFIFO_ALMOST_EMPTY_LH_value
    Private read_XGMII_TXFIFO_ALMOST_EMPTY_LH_value
    Private flag_XGMII_TXFIFO_ALMOST_EMPTY_LH
    Private write_XGMII_TXFIFO_RD_ERR_value
    Private read_XGMII_TXFIFO_RD_ERR_value
    Private flag_XGMII_TXFIFO_RD_ERR
    Private write_XGMII_TXFIFO_RD_RF_value
    Private read_XGMII_TXFIFO_RD_RF_value
    Private flag_XGMII_TXFIFO_RD_RF
    Private write_XGMII_TXFIFO_RD_LF_value
    Private read_XGMII_TXFIFO_RD_LF_value
    Private flag_XGMII_TXFIFO_RD_LF
    Private write_XGMII_TXFIFO_WR_ERR_value
    Private read_XGMII_TXFIFO_WR_ERR_value
    Private flag_XGMII_TXFIFO_WR_ERR
    Private write_XGMII_TXFIFO_WR_RF_value
    Private read_XGMII_TXFIFO_WR_RF_value
    Private flag_XGMII_TXFIFO_WR_RF
    Private write_XGMII_TXFIFO_WR_LF_value
    Private read_XGMII_TXFIFO_WR_LF_value
    Private flag_XGMII_TXFIFO_WR_LF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_XGMII_TXFIFO_STS_LATCH
        get_XGMII_TXFIFO_STS_LATCH = read_XGMII_TXFIFO_STS_LATCH_value
    End Property

    Property Let set_XGMII_TXFIFO_STS_LATCH(aData)
        write_XGMII_TXFIFO_STS_LATCH_value = aData
        flag_XGMII_TXFIFO_STS_LATCH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_STS_LATCH
        read
        read_XGMII_TXFIFO_STS_LATCH = read_XGMII_TXFIFO_STS_LATCH_value
    End Property

    Property Let write_XGMII_TXFIFO_STS_LATCH(aData)
        set_XGMII_TXFIFO_STS_LATCH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_INSERT_EVNT_LH
        get_XGMII_TXFIFO_INSERT_EVNT_LH = read_XGMII_TXFIFO_INSERT_EVNT_LH_value
    End Property

    Property Let set_XGMII_TXFIFO_INSERT_EVNT_LH(aData)
        write_XGMII_TXFIFO_INSERT_EVNT_LH_value = aData
        flag_XGMII_TXFIFO_INSERT_EVNT_LH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_INSERT_EVNT_LH
        read
        read_XGMII_TXFIFO_INSERT_EVNT_LH = read_XGMII_TXFIFO_INSERT_EVNT_LH_value
    End Property

    Property Let write_XGMII_TXFIFO_INSERT_EVNT_LH(aData)
        set_XGMII_TXFIFO_INSERT_EVNT_LH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_DELETE_EVNT_LH
        get_XGMII_TXFIFO_DELETE_EVNT_LH = read_XGMII_TXFIFO_DELETE_EVNT_LH_value
    End Property

    Property Let set_XGMII_TXFIFO_DELETE_EVNT_LH(aData)
        write_XGMII_TXFIFO_DELETE_EVNT_LH_value = aData
        flag_XGMII_TXFIFO_DELETE_EVNT_LH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_DELETE_EVNT_LH
        read
        read_XGMII_TXFIFO_DELETE_EVNT_LH = read_XGMII_TXFIFO_DELETE_EVNT_LH_value
    End Property

    Property Let write_XGMII_TXFIFO_DELETE_EVNT_LH(aData)
        set_XGMII_TXFIFO_DELETE_EVNT_LH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_FULL_LH
        get_XGMII_TXFIFO_FULL_LH = read_XGMII_TXFIFO_FULL_LH_value
    End Property

    Property Let set_XGMII_TXFIFO_FULL_LH(aData)
        write_XGMII_TXFIFO_FULL_LH_value = aData
        flag_XGMII_TXFIFO_FULL_LH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_FULL_LH
        read
        read_XGMII_TXFIFO_FULL_LH = read_XGMII_TXFIFO_FULL_LH_value
    End Property

    Property Let write_XGMII_TXFIFO_FULL_LH(aData)
        set_XGMII_TXFIFO_FULL_LH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_EMPTY_LH
        get_XGMII_TXFIFO_EMPTY_LH = read_XGMII_TXFIFO_EMPTY_LH_value
    End Property

    Property Let set_XGMII_TXFIFO_EMPTY_LH(aData)
        write_XGMII_TXFIFO_EMPTY_LH_value = aData
        flag_XGMII_TXFIFO_EMPTY_LH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_EMPTY_LH
        read
        read_XGMII_TXFIFO_EMPTY_LH = read_XGMII_TXFIFO_EMPTY_LH_value
    End Property

    Property Let write_XGMII_TXFIFO_EMPTY_LH(aData)
        set_XGMII_TXFIFO_EMPTY_LH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_ALMOST_FULL_LH
        get_XGMII_TXFIFO_ALMOST_FULL_LH = read_XGMII_TXFIFO_ALMOST_FULL_LH_value
    End Property

    Property Let set_XGMII_TXFIFO_ALMOST_FULL_LH(aData)
        write_XGMII_TXFIFO_ALMOST_FULL_LH_value = aData
        flag_XGMII_TXFIFO_ALMOST_FULL_LH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_ALMOST_FULL_LH
        read
        read_XGMII_TXFIFO_ALMOST_FULL_LH = read_XGMII_TXFIFO_ALMOST_FULL_LH_value
    End Property

    Property Let write_XGMII_TXFIFO_ALMOST_FULL_LH(aData)
        set_XGMII_TXFIFO_ALMOST_FULL_LH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_ALMOST_EMPTY_LH
        get_XGMII_TXFIFO_ALMOST_EMPTY_LH = read_XGMII_TXFIFO_ALMOST_EMPTY_LH_value
    End Property

    Property Let set_XGMII_TXFIFO_ALMOST_EMPTY_LH(aData)
        write_XGMII_TXFIFO_ALMOST_EMPTY_LH_value = aData
        flag_XGMII_TXFIFO_ALMOST_EMPTY_LH        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_ALMOST_EMPTY_LH
        read
        read_XGMII_TXFIFO_ALMOST_EMPTY_LH = read_XGMII_TXFIFO_ALMOST_EMPTY_LH_value
    End Property

    Property Let write_XGMII_TXFIFO_ALMOST_EMPTY_LH(aData)
        set_XGMII_TXFIFO_ALMOST_EMPTY_LH = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_RD_ERR
        get_XGMII_TXFIFO_RD_ERR = read_XGMII_TXFIFO_RD_ERR_value
    End Property

    Property Let set_XGMII_TXFIFO_RD_ERR(aData)
        write_XGMII_TXFIFO_RD_ERR_value = aData
        flag_XGMII_TXFIFO_RD_ERR        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_RD_ERR
        read
        read_XGMII_TXFIFO_RD_ERR = read_XGMII_TXFIFO_RD_ERR_value
    End Property

    Property Let write_XGMII_TXFIFO_RD_ERR(aData)
        set_XGMII_TXFIFO_RD_ERR = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_RD_RF
        get_XGMII_TXFIFO_RD_RF = read_XGMII_TXFIFO_RD_RF_value
    End Property

    Property Let set_XGMII_TXFIFO_RD_RF(aData)
        write_XGMII_TXFIFO_RD_RF_value = aData
        flag_XGMII_TXFIFO_RD_RF        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_RD_RF
        read
        read_XGMII_TXFIFO_RD_RF = read_XGMII_TXFIFO_RD_RF_value
    End Property

    Property Let write_XGMII_TXFIFO_RD_RF(aData)
        set_XGMII_TXFIFO_RD_RF = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_RD_LF
        get_XGMII_TXFIFO_RD_LF = read_XGMII_TXFIFO_RD_LF_value
    End Property

    Property Let set_XGMII_TXFIFO_RD_LF(aData)
        write_XGMII_TXFIFO_RD_LF_value = aData
        flag_XGMII_TXFIFO_RD_LF        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_RD_LF
        read
        read_XGMII_TXFIFO_RD_LF = read_XGMII_TXFIFO_RD_LF_value
    End Property

    Property Let write_XGMII_TXFIFO_RD_LF(aData)
        set_XGMII_TXFIFO_RD_LF = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_WR_ERR
        get_XGMII_TXFIFO_WR_ERR = read_XGMII_TXFIFO_WR_ERR_value
    End Property

    Property Let set_XGMII_TXFIFO_WR_ERR(aData)
        write_XGMII_TXFIFO_WR_ERR_value = aData
        flag_XGMII_TXFIFO_WR_ERR        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_WR_ERR
        read
        read_XGMII_TXFIFO_WR_ERR = read_XGMII_TXFIFO_WR_ERR_value
    End Property

    Property Let write_XGMII_TXFIFO_WR_ERR(aData)
        set_XGMII_TXFIFO_WR_ERR = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_WR_RF
        get_XGMII_TXFIFO_WR_RF = read_XGMII_TXFIFO_WR_RF_value
    End Property

    Property Let set_XGMII_TXFIFO_WR_RF(aData)
        write_XGMII_TXFIFO_WR_RF_value = aData
        flag_XGMII_TXFIFO_WR_RF        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_WR_RF
        read
        read_XGMII_TXFIFO_WR_RF = read_XGMII_TXFIFO_WR_RF_value
    End Property

    Property Let write_XGMII_TXFIFO_WR_RF(aData)
        set_XGMII_TXFIFO_WR_RF = aData
        write
    End Property

    Property Get get_XGMII_TXFIFO_WR_LF
        get_XGMII_TXFIFO_WR_LF = read_XGMII_TXFIFO_WR_LF_value
    End Property

    Property Let set_XGMII_TXFIFO_WR_LF(aData)
        write_XGMII_TXFIFO_WR_LF_value = aData
        flag_XGMII_TXFIFO_WR_LF        = &H1
    End Property

    Property Get read_XGMII_TXFIFO_WR_LF
        read
        read_XGMII_TXFIFO_WR_LF = read_XGMII_TXFIFO_WR_LF_value
    End Property

    Property Let write_XGMII_TXFIFO_WR_LF(aData)
        set_XGMII_TXFIFO_WR_LF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_STS_LATCH_value = rightShift(data_low, 12) and &H1
        read_XGMII_TXFIFO_INSERT_EVNT_LH_value = rightShift(data_low, 11) and &H1
        read_XGMII_TXFIFO_DELETE_EVNT_LH_value = rightShift(data_low, 10) and &H1
        read_XGMII_TXFIFO_FULL_LH_value = rightShift(data_low, 9) and &H1
        read_XGMII_TXFIFO_EMPTY_LH_value = rightShift(data_low, 8) and &H1
        read_XGMII_TXFIFO_ALMOST_FULL_LH_value = rightShift(data_low, 7) and &H1
        read_XGMII_TXFIFO_ALMOST_EMPTY_LH_value = rightShift(data_low, 6) and &H1
        read_XGMII_TXFIFO_RD_ERR_value = rightShift(data_low, 5) and &H1
        read_XGMII_TXFIFO_RD_RF_value = rightShift(data_low, 4) and &H1
        read_XGMII_TXFIFO_RD_LF_value = rightShift(data_low, 3) and &H1
        read_XGMII_TXFIFO_WR_ERR_value = rightShift(data_low, 2) and &H1
        read_XGMII_TXFIFO_WR_RF_value = rightShift(data_low, 1) and &H1
        XGMII_TXFIFO_WR_LF_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_WR_LF_mask = mask then
                read_XGMII_TXFIFO_WR_LF_value = data_low
            else
                read_XGMII_TXFIFO_WR_LF_value = (data_low - H8000_0000) and XGMII_TXFIFO_WR_LF_mask
            end If
        else
            read_XGMII_TXFIFO_WR_LF_value = data_low and XGMII_TXFIFO_WR_LF_mask
        end If

    End Sub

    Sub write
        If flag_XGMII_TXFIFO_STS_LATCH = &H0 or flag_XGMII_TXFIFO_INSERT_EVNT_LH = &H0 or flag_XGMII_TXFIFO_DELETE_EVNT_LH = &H0 or flag_XGMII_TXFIFO_FULL_LH = &H0 or flag_XGMII_TXFIFO_EMPTY_LH = &H0 or flag_XGMII_TXFIFO_ALMOST_FULL_LH = &H0 or flag_XGMII_TXFIFO_ALMOST_EMPTY_LH = &H0 or flag_XGMII_TXFIFO_RD_ERR = &H0 or flag_XGMII_TXFIFO_RD_RF = &H0 or flag_XGMII_TXFIFO_RD_LF = &H0 or flag_XGMII_TXFIFO_WR_ERR = &H0 or flag_XGMII_TXFIFO_WR_RF = &H0 or flag_XGMII_TXFIFO_WR_LF = &H0 Then read
        If flag_XGMII_TXFIFO_STS_LATCH = &H0 Then write_XGMII_TXFIFO_STS_LATCH_value = get_XGMII_TXFIFO_STS_LATCH
        If flag_XGMII_TXFIFO_INSERT_EVNT_LH = &H0 Then write_XGMII_TXFIFO_INSERT_EVNT_LH_value = get_XGMII_TXFIFO_INSERT_EVNT_LH
        If flag_XGMII_TXFIFO_DELETE_EVNT_LH = &H0 Then write_XGMII_TXFIFO_DELETE_EVNT_LH_value = get_XGMII_TXFIFO_DELETE_EVNT_LH
        If flag_XGMII_TXFIFO_FULL_LH = &H0 Then write_XGMII_TXFIFO_FULL_LH_value = get_XGMII_TXFIFO_FULL_LH
        If flag_XGMII_TXFIFO_EMPTY_LH = &H0 Then write_XGMII_TXFIFO_EMPTY_LH_value = get_XGMII_TXFIFO_EMPTY_LH
        If flag_XGMII_TXFIFO_ALMOST_FULL_LH = &H0 Then write_XGMII_TXFIFO_ALMOST_FULL_LH_value = get_XGMII_TXFIFO_ALMOST_FULL_LH
        If flag_XGMII_TXFIFO_ALMOST_EMPTY_LH = &H0 Then write_XGMII_TXFIFO_ALMOST_EMPTY_LH_value = get_XGMII_TXFIFO_ALMOST_EMPTY_LH
        If flag_XGMII_TXFIFO_RD_ERR = &H0 Then write_XGMII_TXFIFO_RD_ERR_value = get_XGMII_TXFIFO_RD_ERR
        If flag_XGMII_TXFIFO_RD_RF = &H0 Then write_XGMII_TXFIFO_RD_RF_value = get_XGMII_TXFIFO_RD_RF
        If flag_XGMII_TXFIFO_RD_LF = &H0 Then write_XGMII_TXFIFO_RD_LF_value = get_XGMII_TXFIFO_RD_LF
        If flag_XGMII_TXFIFO_WR_ERR = &H0 Then write_XGMII_TXFIFO_WR_ERR_value = get_XGMII_TXFIFO_WR_ERR
        If flag_XGMII_TXFIFO_WR_RF = &H0 Then write_XGMII_TXFIFO_WR_RF_value = get_XGMII_TXFIFO_WR_RF
        If flag_XGMII_TXFIFO_WR_LF = &H0 Then write_XGMII_TXFIFO_WR_LF_value = get_XGMII_TXFIFO_WR_LF

        regValue = leftShift((write_XGMII_TXFIFO_STS_LATCH_value and &H1), 12) + leftShift((write_XGMII_TXFIFO_INSERT_EVNT_LH_value and &H1), 11) + leftShift((write_XGMII_TXFIFO_DELETE_EVNT_LH_value and &H1), 10) + leftShift((write_XGMII_TXFIFO_FULL_LH_value and &H1), 9) + leftShift((write_XGMII_TXFIFO_EMPTY_LH_value and &H1), 8) + leftShift((write_XGMII_TXFIFO_ALMOST_FULL_LH_value and &H1), 7) + leftShift((write_XGMII_TXFIFO_ALMOST_EMPTY_LH_value and &H1), 6) + leftShift((write_XGMII_TXFIFO_RD_ERR_value and &H1), 5) + leftShift((write_XGMII_TXFIFO_RD_RF_value and &H1), 4) + leftShift((write_XGMII_TXFIFO_RD_LF_value and &H1), 3) + leftShift((write_XGMII_TXFIFO_WR_ERR_value and &H1), 2) + leftShift((write_XGMII_TXFIFO_WR_RF_value and &H1), 1) + leftShift((write_XGMII_TXFIFO_WR_LF_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XGMII_TXFIFO_STS_LATCH_value = rightShift(data_low, 12) and &H1
        read_XGMII_TXFIFO_INSERT_EVNT_LH_value = rightShift(data_low, 11) and &H1
        read_XGMII_TXFIFO_DELETE_EVNT_LH_value = rightShift(data_low, 10) and &H1
        read_XGMII_TXFIFO_FULL_LH_value = rightShift(data_low, 9) and &H1
        read_XGMII_TXFIFO_EMPTY_LH_value = rightShift(data_low, 8) and &H1
        read_XGMII_TXFIFO_ALMOST_FULL_LH_value = rightShift(data_low, 7) and &H1
        read_XGMII_TXFIFO_ALMOST_EMPTY_LH_value = rightShift(data_low, 6) and &H1
        read_XGMII_TXFIFO_RD_ERR_value = rightShift(data_low, 5) and &H1
        read_XGMII_TXFIFO_RD_RF_value = rightShift(data_low, 4) and &H1
        read_XGMII_TXFIFO_RD_LF_value = rightShift(data_low, 3) and &H1
        read_XGMII_TXFIFO_WR_ERR_value = rightShift(data_low, 2) and &H1
        read_XGMII_TXFIFO_WR_RF_value = rightShift(data_low, 1) and &H1
        XGMII_TXFIFO_WR_LF_mask = &H1
        if data_low > LONG_MAX then
            if XGMII_TXFIFO_WR_LF_mask = mask then
                read_XGMII_TXFIFO_WR_LF_value = data_low
            else
                read_XGMII_TXFIFO_WR_LF_value = (data_low - H8000_0000) and XGMII_TXFIFO_WR_LF_mask
            end If
        else
            read_XGMII_TXFIFO_WR_LF_value = data_low and XGMII_TXFIFO_WR_LF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGMII_TXFIFO_STS_LATCH_value = &H0
        flag_XGMII_TXFIFO_STS_LATCH        = &H0
        write_XGMII_TXFIFO_INSERT_EVNT_LH_value = &H0
        flag_XGMII_TXFIFO_INSERT_EVNT_LH        = &H0
        write_XGMII_TXFIFO_DELETE_EVNT_LH_value = &H0
        flag_XGMII_TXFIFO_DELETE_EVNT_LH        = &H0
        write_XGMII_TXFIFO_FULL_LH_value = &H0
        flag_XGMII_TXFIFO_FULL_LH        = &H0
        write_XGMII_TXFIFO_EMPTY_LH_value = &H0
        flag_XGMII_TXFIFO_EMPTY_LH        = &H0
        write_XGMII_TXFIFO_ALMOST_FULL_LH_value = &H0
        flag_XGMII_TXFIFO_ALMOST_FULL_LH        = &H0
        write_XGMII_TXFIFO_ALMOST_EMPTY_LH_value = &H0
        flag_XGMII_TXFIFO_ALMOST_EMPTY_LH        = &H0
        write_XGMII_TXFIFO_RD_ERR_value = &H0
        flag_XGMII_TXFIFO_RD_ERR        = &H0
        write_XGMII_TXFIFO_RD_RF_value = &H0
        flag_XGMII_TXFIFO_RD_RF        = &H0
        write_XGMII_TXFIFO_RD_LF_value = &H0
        flag_XGMII_TXFIFO_RD_LF        = &H0
        write_XGMII_TXFIFO_WR_ERR_value = &H0
        flag_XGMII_TXFIFO_WR_ERR        = &H0
        write_XGMII_TXFIFO_WR_RF_value = &H0
        flag_XGMII_TXFIFO_WR_RF        = &H0
        write_XGMII_TXFIFO_WR_LF_value = &H0
        flag_XGMII_TXFIFO_WR_LF        = &H0
    End Sub
End Class


'' @REGISTER : IO_xgmiigmii_cnvt_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sft_reset_n                                [2:2]            get_sft_reset_n
''                                                             set_sft_reset_n
''                                                             read_sft_reset_n
''                                                             write_sft_reset_n
''---------------------------------------------------------------------------------
'' conv_en                                    [1:1]            get_conv_en
''                                                             set_conv_en
''                                                             read_conv_en
''                                                             write_conv_en
''---------------------------------------------------------------------------------
'' lpi_feature_en                             [0:0]            get_lpi_feature_en
''                                                             set_lpi_feature_en
''                                                             read_lpi_feature_en
''                                                             write_lpi_feature_en
''---------------------------------------------------------------------------------
Class REGISTER_IO_xgmiigmii_cnvt_ctl
    Private write_sft_reset_n_value
    Private read_sft_reset_n_value
    Private flag_sft_reset_n
    Private write_conv_en_value
    Private read_conv_en_value
    Private flag_conv_en
    Private write_lpi_feature_en_value
    Private read_lpi_feature_en_value
    Private flag_lpi_feature_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sft_reset_n
        get_sft_reset_n = read_sft_reset_n_value
    End Property

    Property Let set_sft_reset_n(aData)
        write_sft_reset_n_value = aData
        flag_sft_reset_n        = &H1
    End Property

    Property Get read_sft_reset_n
        read
        read_sft_reset_n = read_sft_reset_n_value
    End Property

    Property Let write_sft_reset_n(aData)
        set_sft_reset_n = aData
        write
    End Property

    Property Get get_conv_en
        get_conv_en = read_conv_en_value
    End Property

    Property Let set_conv_en(aData)
        write_conv_en_value = aData
        flag_conv_en        = &H1
    End Property

    Property Get read_conv_en
        read
        read_conv_en = read_conv_en_value
    End Property

    Property Let write_conv_en(aData)
        set_conv_en = aData
        write
    End Property

    Property Get get_lpi_feature_en
        get_lpi_feature_en = read_lpi_feature_en_value
    End Property

    Property Let set_lpi_feature_en(aData)
        write_lpi_feature_en_value = aData
        flag_lpi_feature_en        = &H1
    End Property

    Property Get read_lpi_feature_en
        read
        read_lpi_feature_en = read_lpi_feature_en_value
    End Property

    Property Let write_lpi_feature_en(aData)
        set_lpi_feature_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sft_reset_n_value = rightShift(data_low, 2) and &H1
        read_conv_en_value = rightShift(data_low, 1) and &H1
        lpi_feature_en_mask = &H1
        if data_low > LONG_MAX then
            if lpi_feature_en_mask = mask then
                read_lpi_feature_en_value = data_low
            else
                read_lpi_feature_en_value = (data_low - H8000_0000) and lpi_feature_en_mask
            end If
        else
            read_lpi_feature_en_value = data_low and lpi_feature_en_mask
        end If

    End Sub

    Sub write
        If flag_sft_reset_n = &H0 or flag_conv_en = &H0 or flag_lpi_feature_en = &H0 Then read
        If flag_sft_reset_n = &H0 Then write_sft_reset_n_value = get_sft_reset_n
        If flag_conv_en = &H0 Then write_conv_en_value = get_conv_en
        If flag_lpi_feature_en = &H0 Then write_lpi_feature_en_value = get_lpi_feature_en

        regValue = leftShift((write_sft_reset_n_value and &H1), 2) + leftShift((write_conv_en_value and &H1), 1) + leftShift((write_lpi_feature_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sft_reset_n_value = rightShift(data_low, 2) and &H1
        read_conv_en_value = rightShift(data_low, 1) and &H1
        lpi_feature_en_mask = &H1
        if data_low > LONG_MAX then
            if lpi_feature_en_mask = mask then
                read_lpi_feature_en_value = data_low
            else
                read_lpi_feature_en_value = (data_low - H8000_0000) and lpi_feature_en_mask
            end If
        else
            read_lpi_feature_en_value = data_low and lpi_feature_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sft_reset_n_value = &H0
        flag_sft_reset_n        = &H0
        write_conv_en_value = &H0
        flag_conv_en        = &H0
        write_lpi_feature_en_value = &H0
        flag_lpi_feature_en        = &H0
    End Sub
End Class


'' @REGISTER : IO_bootrom_strap
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BOOTROM_BYPASS                             [0:0]            get_BOOTROM_BYPASS
''                                                             set_BOOTROM_BYPASS
''                                                             read_BOOTROM_BYPASS
''                                                             write_BOOTROM_BYPASS
''---------------------------------------------------------------------------------
Class REGISTER_IO_bootrom_strap
    Private write_BOOTROM_BYPASS_value
    Private read_BOOTROM_BYPASS_value
    Private flag_BOOTROM_BYPASS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BOOTROM_BYPASS
        get_BOOTROM_BYPASS = read_BOOTROM_BYPASS_value
    End Property

    Property Let set_BOOTROM_BYPASS(aData)
        write_BOOTROM_BYPASS_value = aData
        flag_BOOTROM_BYPASS        = &H1
    End Property

    Property Get read_BOOTROM_BYPASS
        read
        read_BOOTROM_BYPASS = read_BOOTROM_BYPASS_value
    End Property

    Property Let write_BOOTROM_BYPASS(aData)
        set_BOOTROM_BYPASS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BOOTROM_BYPASS_mask = &H1
        if data_low > LONG_MAX then
            if BOOTROM_BYPASS_mask = mask then
                read_BOOTROM_BYPASS_value = data_low
            else
                read_BOOTROM_BYPASS_value = (data_low - H8000_0000) and BOOTROM_BYPASS_mask
            end If
        else
            read_BOOTROM_BYPASS_value = data_low and BOOTROM_BYPASS_mask
        end If

    End Sub

    Sub write
        If flag_BOOTROM_BYPASS = &H0 Then read
        If flag_BOOTROM_BYPASS = &H0 Then write_BOOTROM_BYPASS_value = get_BOOTROM_BYPASS

        regValue = leftShift((write_BOOTROM_BYPASS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BOOTROM_BYPASS_mask = &H1
        if data_low > LONG_MAX then
            if BOOTROM_BYPASS_mask = mask then
                read_BOOTROM_BYPASS_value = data_low
            else
                read_BOOTROM_BYPASS_value = (data_low - H8000_0000) and BOOTROM_BYPASS_mask
            end If
        else
            read_BOOTROM_BYPASS_value = data_low and BOOTROM_BYPASS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BOOTROM_BYPASS_value = &H0
        flag_BOOTROM_BYPASS        = &H0
    End Sub
End Class


'' @REGISTER : IO_spim_sck_in_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:5]           get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' sck_in_sel                                 [4:4]            get_sck_in_sel
''                                                             set_sck_in_sel
''                                                             read_sck_in_sel
''                                                             write_sck_in_sel
''---------------------------------------------------------------------------------
'' sck_bypass                                 [3:3]            get_sck_bypass
''                                                             set_sck_bypass
''                                                             read_sck_bypass
''                                                             write_sck_bypass
''---------------------------------------------------------------------------------
'' sck_in_dly_sel                             [2:0]            get_sck_in_dly_sel
''                                                             set_sck_in_dly_sel
''                                                             read_sck_in_dly_sel
''                                                             write_sck_in_dly_sel
''---------------------------------------------------------------------------------
Class REGISTER_IO_spim_sck_in_ctl
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_sck_in_sel_value
    Private read_sck_in_sel_value
    Private flag_sck_in_sel
    Private write_sck_bypass_value
    Private read_sck_bypass_value
    Private flag_sck_bypass
    Private write_sck_in_dly_sel_value
    Private read_sck_in_dly_sel_value
    Private flag_sck_in_dly_sel

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

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_sck_in_sel
        get_sck_in_sel = read_sck_in_sel_value
    End Property

    Property Let set_sck_in_sel(aData)
        write_sck_in_sel_value = aData
        flag_sck_in_sel        = &H1
    End Property

    Property Get read_sck_in_sel
        read
        read_sck_in_sel = read_sck_in_sel_value
    End Property

    Property Let write_sck_in_sel(aData)
        set_sck_in_sel = aData
        write
    End Property

    Property Get get_sck_bypass
        get_sck_bypass = read_sck_bypass_value
    End Property

    Property Let set_sck_bypass(aData)
        write_sck_bypass_value = aData
        flag_sck_bypass        = &H1
    End Property

    Property Get read_sck_bypass
        read
        read_sck_bypass = read_sck_bypass_value
    End Property

    Property Let write_sck_bypass(aData)
        set_sck_bypass = aData
        write
    End Property

    Property Get get_sck_in_dly_sel
        get_sck_in_dly_sel = read_sck_in_dly_sel_value
    End Property

    Property Let set_sck_in_dly_sel(aData)
        write_sck_in_dly_sel_value = aData
        flag_sck_in_dly_sel        = &H1
    End Property

    Property Get read_sck_in_dly_sel
        read
        read_sck_in_dly_sel = read_sck_in_dly_sel_value
    End Property

    Property Let write_sck_in_dly_sel(aData)
        set_sck_in_dly_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 5) and &H7ff
        read_sck_in_sel_value = rightShift(data_low, 4) and &H1
        read_sck_bypass_value = rightShift(data_low, 3) and &H1
        sck_in_dly_sel_mask = &H7
        if data_low > LONG_MAX then
            if sck_in_dly_sel_mask = mask then
                read_sck_in_dly_sel_value = data_low
            else
                read_sck_in_dly_sel_value = (data_low - H8000_0000) and sck_in_dly_sel_mask
            end If
        else
            read_sck_in_dly_sel_value = data_low and sck_in_dly_sel_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_sck_in_sel = &H0 or flag_sck_bypass = &H0 or flag_sck_in_dly_sel = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_sck_in_sel = &H0 Then write_sck_in_sel_value = get_sck_in_sel
        If flag_sck_bypass = &H0 Then write_sck_bypass_value = get_sck_bypass
        If flag_sck_in_dly_sel = &H0 Then write_sck_in_dly_sel_value = get_sck_in_dly_sel

        regValue = leftShift((write_spare_value and &H7ff), 5) + leftShift((write_sck_in_sel_value and &H1), 4) + leftShift((write_sck_bypass_value and &H1), 3) + leftShift((write_sck_in_dly_sel_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 5) and &H7ff
        read_sck_in_sel_value = rightShift(data_low, 4) and &H1
        read_sck_bypass_value = rightShift(data_low, 3) and &H1
        sck_in_dly_sel_mask = &H7
        if data_low > LONG_MAX then
            if sck_in_dly_sel_mask = mask then
                read_sck_in_dly_sel_value = data_low
            else
                read_sck_in_dly_sel_value = (data_low - H8000_0000) and sck_in_dly_sel_mask
            end If
        else
            read_sck_in_dly_sel_value = data_low and sck_in_dly_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_sck_in_sel_value = &H0
        flag_sck_in_sel        = &H0
        write_sck_bypass_value = &H0
        flag_sck_bypass        = &H0
        write_sck_in_dly_sel_value = &H0
        flag_sck_in_dly_sel        = &H0
    End Sub
End Class


'' @REGISTER : IO_ioff
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IOFF                                       [15:0]           get_IOFF
''                                                             set_IOFF
''                                                             read_IOFF
''                                                             write_IOFF
''---------------------------------------------------------------------------------
Class REGISTER_IO_ioff
    Private write_IOFF_value
    Private read_IOFF_value
    Private flag_IOFF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IOFF
        get_IOFF = read_IOFF_value
    End Property

    Property Let set_IOFF(aData)
        write_IOFF_value = aData
        flag_IOFF        = &H1
    End Property

    Property Get read_IOFF
        read
        read_IOFF = read_IOFF_value
    End Property

    Property Let write_IOFF(aData)
        set_IOFF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IOFF_mask = &Hffff
        if data_low > LONG_MAX then
            if IOFF_mask = mask then
                read_IOFF_value = data_low
            else
                read_IOFF_value = (data_low - H8000_0000) and IOFF_mask
            end If
        else
            read_IOFF_value = data_low and IOFF_mask
        end If

    End Sub

    Sub write
        If flag_IOFF = &H0 Then read
        If flag_IOFF = &H0 Then write_IOFF_value = get_IOFF

        regValue = leftShift((write_IOFF_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IOFF_mask = &Hffff
        if data_low > LONG_MAX then
            if IOFF_mask = mask then
                read_IOFF_value = data_low
            else
                read_IOFF_value = (data_low - H8000_0000) and IOFF_mask
            end If
        else
            read_IOFF_value = data_low and IOFF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IOFF_value = &H0
        flag_IOFF        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class IO_INSTANCE

    Public mii1_config
    Public mii2_config
    Public io_hysteresis
    Public io_source
    Public io_sel
    Public io_mii1_modehv
    Public io_mii2_modehv
    Public io_sel2
    Public rgmii1_ctl
    Public rgmii2_ctl
    Public sgmii_rgmii_ctl
    Public rgmii1_gmii_ctl
    Public rgmii2_gmii_ctl
    Public cpu_gmii_ctl
    Public rgmii1_rx_char_pattern_exp
    Public rgmii1_rx_char_pattern_got
    Public rgmii2_rx_char_pattern_exp
    Public rgmii2_rx_char_pattern_got
    Public rgmii3_rx_char_pattern_exp
    Public rgmii3_rx_char_pattern_got
    Public straps_raw
    Public straps_ov
    Public straps_raw2
    Public straps_ov2
    Public strap_test
    Public sw_rxc_inv_ctl
    Public sw_tx_pipeline_ctl
    Public sw_rx_pipeline_ctl
    Public sw_ovrd
    Public test_bus_select
    Public p1588_config
    Public p1588_sync_gen
    Public io_ctl
    Public rgmii1_fifo_ctl
    Public rgmii2_fifo_ctl
    Public rgmii1_dll_ctrl
    Public rgmii1_dll_cfg
    Public rgmii2_dll_ctrl
    Public rgmii2_dll_cfg
    Public mii3_config
    Public io_mii3_modehv
    Public rgmii3_ctl
    Public rgmii3_gmii_ctl
    Public rgmii3_fifo_ctl
    Public rgmii3_dll_ctrl
    Public rgmii3_dll_cfg
    Public xgmii_rxfifo_ctl
    Public xgmii_rxfifo_trshd_ctl
    Public xgmii_rxfifo_delete_cnt
    Public xgmii_rxfifo_insert_cnt
    Public xgmii_rxfifo_lh_sts
    Public xgmii_txfifo_ctl
    Public xgmii_txfifo_trshd_ctl
    Public xgmii_txfifo_delete_cnt
    Public xgmii_txfifo_insert_cnt
    Public xgmii_txfifo_lh_sts
    Public xgmiigmii_cnvt_ctl
    Public bootrom_strap
    Public spim_sck_in_ctl
    Public ioff


    Public default function Init(aBaseAddr)
        Set mii1_config = (New REGISTER_IO_mii1_config)(aBaseAddr, 16)
        Set mii2_config = (New REGISTER_IO_mii2_config)(aBaseAddr, 16)
        Set io_hysteresis = (New REGISTER_IO_io_hysteresis)(aBaseAddr, 16)
        Set io_source = (New REGISTER_IO_io_source)(aBaseAddr, 16)
        Set io_sel = (New REGISTER_IO_io_sel)(aBaseAddr, 16)
        Set io_mii1_modehv = (New REGISTER_IO_io_mii1_modehv)(aBaseAddr, 16)
        Set io_mii2_modehv = (New REGISTER_IO_io_mii2_modehv)(aBaseAddr, 16)
        Set io_sel2 = (New REGISTER_IO_io_sel2)(aBaseAddr, 16)
        Set rgmii1_ctl = (New REGISTER_IO_rgmii1_ctl)(aBaseAddr, 16)
        Set rgmii2_ctl = (New REGISTER_IO_rgmii2_ctl)(aBaseAddr, 16)
        Set sgmii_rgmii_ctl = (New REGISTER_IO_sgmii_rgmii_ctl)(aBaseAddr, 16)
        Set rgmii1_gmii_ctl = (New REGISTER_IO_rgmii1_gmii_ctl)(aBaseAddr, 16)
        Set rgmii2_gmii_ctl = (New REGISTER_IO_rgmii2_gmii_ctl)(aBaseAddr, 16)
        Set cpu_gmii_ctl = (New REGISTER_IO_cpu_gmii_ctl)(aBaseAddr, 16)
        Set rgmii1_rx_char_pattern_exp = (New REGISTER_IO_rgmii1_rx_char_pattern_exp)(aBaseAddr, 16)
        Set rgmii1_rx_char_pattern_got = (New REGISTER_IO_rgmii1_rx_char_pattern_got)(aBaseAddr, 16)
        Set rgmii2_rx_char_pattern_exp = (New REGISTER_IO_rgmii2_rx_char_pattern_exp)(aBaseAddr, 16)
        Set rgmii2_rx_char_pattern_got = (New REGISTER_IO_rgmii2_rx_char_pattern_got)(aBaseAddr, 16)
        Set rgmii3_rx_char_pattern_exp = (New REGISTER_IO_rgmii3_rx_char_pattern_exp)(aBaseAddr, 16)
        Set rgmii3_rx_char_pattern_got = (New REGISTER_IO_rgmii3_rx_char_pattern_got)(aBaseAddr, 16)
        Set straps_raw = (New REGISTER_IO_straps_raw)(aBaseAddr, 16)
        Set straps_ov = (New REGISTER_IO_straps_ov)(aBaseAddr, 16)
        Set straps_raw2 = (New REGISTER_IO_straps_raw2)(aBaseAddr, 16)
        Set straps_ov2 = (New REGISTER_IO_straps_ov2)(aBaseAddr, 16)
        Set strap_test = (New REGISTER_IO_strap_test)(aBaseAddr, 16)
        Set sw_rxc_inv_ctl = (New REGISTER_IO_sw_rxc_inv_ctl)(aBaseAddr, 16)
        Set sw_tx_pipeline_ctl = (New REGISTER_IO_sw_tx_pipeline_ctl)(aBaseAddr, 16)
        Set sw_rx_pipeline_ctl = (New REGISTER_IO_sw_rx_pipeline_ctl)(aBaseAddr, 16)
        Set sw_ovrd = (New REGISTER_IO_sw_ovrd)(aBaseAddr, 16)
        Set test_bus_select = (New REGISTER_IO_test_bus_select)(aBaseAddr, 16)
        Set p1588_config = (New REGISTER_IO_p1588_config)(aBaseAddr, 16)
        Set p1588_sync_gen = (New REGISTER_IO_p1588_sync_gen)(aBaseAddr, 16)
        Set io_ctl = (New REGISTER_IO_io_ctl)(aBaseAddr, 16)
        Set rgmii1_fifo_ctl = (New REGISTER_IO_rgmii1_fifo_ctl)(aBaseAddr, 16)
        Set rgmii2_fifo_ctl = (New REGISTER_IO_rgmii2_fifo_ctl)(aBaseAddr, 16)
        Set rgmii1_dll_ctrl = (New REGISTER_IO_rgmii1_dll_ctrl)(aBaseAddr, 16)
        Set rgmii1_dll_cfg = (New REGISTER_IO_rgmii1_dll_cfg)(aBaseAddr, 16)
        Set rgmii2_dll_ctrl = (New REGISTER_IO_rgmii2_dll_ctrl)(aBaseAddr, 16)
        Set rgmii2_dll_cfg = (New REGISTER_IO_rgmii2_dll_cfg)(aBaseAddr, 16)
        Set mii3_config = (New REGISTER_IO_mii3_config)(aBaseAddr, 16)
        Set io_mii3_modehv = (New REGISTER_IO_io_mii3_modehv)(aBaseAddr, 16)
        Set rgmii3_ctl = (New REGISTER_IO_rgmii3_ctl)(aBaseAddr, 16)
        Set rgmii3_gmii_ctl = (New REGISTER_IO_rgmii3_gmii_ctl)(aBaseAddr, 16)
        Set rgmii3_fifo_ctl = (New REGISTER_IO_rgmii3_fifo_ctl)(aBaseAddr, 16)
        Set rgmii3_dll_ctrl = (New REGISTER_IO_rgmii3_dll_ctrl)(aBaseAddr, 16)
        Set rgmii3_dll_cfg = (New REGISTER_IO_rgmii3_dll_cfg)(aBaseAddr, 16)
        Set xgmii_rxfifo_ctl = (New REGISTER_IO_xgmii_rxfifo_ctl)(aBaseAddr, 16)
        Set xgmii_rxfifo_trshd_ctl = (New REGISTER_IO_xgmii_rxfifo_trshd_ctl)(aBaseAddr, 16)
        Set xgmii_rxfifo_delete_cnt = (New REGISTER_IO_xgmii_rxfifo_delete_cnt)(aBaseAddr, 16)
        Set xgmii_rxfifo_insert_cnt = (New REGISTER_IO_xgmii_rxfifo_insert_cnt)(aBaseAddr, 16)
        Set xgmii_rxfifo_lh_sts = (New REGISTER_IO_xgmii_rxfifo_lh_sts)(aBaseAddr, 16)
        Set xgmii_txfifo_ctl = (New REGISTER_IO_xgmii_txfifo_ctl)(aBaseAddr, 16)
        Set xgmii_txfifo_trshd_ctl = (New REGISTER_IO_xgmii_txfifo_trshd_ctl)(aBaseAddr, 16)
        Set xgmii_txfifo_delete_cnt = (New REGISTER_IO_xgmii_txfifo_delete_cnt)(aBaseAddr, 16)
        Set xgmii_txfifo_insert_cnt = (New REGISTER_IO_xgmii_txfifo_insert_cnt)(aBaseAddr, 16)
        Set xgmii_txfifo_lh_sts = (New REGISTER_IO_xgmii_txfifo_lh_sts)(aBaseAddr, 16)
        Set xgmiigmii_cnvt_ctl = (New REGISTER_IO_xgmiigmii_cnvt_ctl)(aBaseAddr, 16)
        Set bootrom_strap = (New REGISTER_IO_bootrom_strap)(aBaseAddr, 16)
        Set spim_sck_in_ctl = (New REGISTER_IO_spim_sck_in_ctl)(aBaseAddr, 16)
        Set ioff = (New REGISTER_IO_ioff)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set IO = CreateObject("System.Collections.ArrayList")
IO.Add ((New IO_INSTANCE)(&H4a840000))


