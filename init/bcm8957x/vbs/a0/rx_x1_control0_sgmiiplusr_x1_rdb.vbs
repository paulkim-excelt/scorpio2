

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


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_descr1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DESCR1_MODE_CUSTOM                         [3:2]            get_DESCR1_MODE_CUSTOM
''                                                             set_DESCR1_MODE_CUSTOM
''                                                             read_DESCR1_MODE_CUSTOM
''                                                             write_DESCR1_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' DESCR1_MODE_BYPASS                         [1:0]            get_DESCR1_MODE_BYPASS
''                                                             set_DESCR1_MODE_BYPASS
''                                                             read_DESCR1_MODE_BYPASS
''                                                             write_DESCR1_MODE_BYPASS
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_descr1
    Private write_DESCR1_MODE_CUSTOM_value
    Private read_DESCR1_MODE_CUSTOM_value
    Private flag_DESCR1_MODE_CUSTOM
    Private write_DESCR1_MODE_BYPASS_value
    Private read_DESCR1_MODE_BYPASS_value
    Private flag_DESCR1_MODE_BYPASS

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

    Property Get get_DESCR1_MODE_CUSTOM
        get_DESCR1_MODE_CUSTOM = read_DESCR1_MODE_CUSTOM_value
    End Property

    Property Let set_DESCR1_MODE_CUSTOM(aData)
        write_DESCR1_MODE_CUSTOM_value = aData
        flag_DESCR1_MODE_CUSTOM        = &H1
    End Property

    Property Get read_DESCR1_MODE_CUSTOM
        read
        read_DESCR1_MODE_CUSTOM = read_DESCR1_MODE_CUSTOM_value
    End Property

    Property Let write_DESCR1_MODE_CUSTOM(aData)
        set_DESCR1_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_DESCR1_MODE_BYPASS
        get_DESCR1_MODE_BYPASS = read_DESCR1_MODE_BYPASS_value
    End Property

    Property Let set_DESCR1_MODE_BYPASS(aData)
        write_DESCR1_MODE_BYPASS_value = aData
        flag_DESCR1_MODE_BYPASS        = &H1
    End Property

    Property Get read_DESCR1_MODE_BYPASS
        read
        read_DESCR1_MODE_BYPASS = read_DESCR1_MODE_BYPASS_value
    End Property

    Property Let write_DESCR1_MODE_BYPASS(aData)
        set_DESCR1_MODE_BYPASS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DESCR1_MODE_CUSTOM_value = rightShift(data_low, 2) and &H3
        DESCR1_MODE_BYPASS_mask = &H3
        if data_low > LONG_MAX then
            if DESCR1_MODE_BYPASS_mask = mask then
                read_DESCR1_MODE_BYPASS_value = data_low
            else
                read_DESCR1_MODE_BYPASS_value = (data_low - H8000_0000) and DESCR1_MODE_BYPASS_mask
            end If
        else
            read_DESCR1_MODE_BYPASS_value = data_low and DESCR1_MODE_BYPASS_mask
        end If

    End Sub

    Sub write
        If flag_DESCR1_MODE_CUSTOM = &H0 or flag_DESCR1_MODE_BYPASS = &H0 Then read
        If flag_DESCR1_MODE_CUSTOM = &H0 Then write_DESCR1_MODE_CUSTOM_value = get_DESCR1_MODE_CUSTOM
        If flag_DESCR1_MODE_BYPASS = &H0 Then write_DESCR1_MODE_BYPASS_value = get_DESCR1_MODE_BYPASS

        regValue = leftShift((write_DESCR1_MODE_CUSTOM_value and &H3), 2) + leftShift((write_DESCR1_MODE_BYPASS_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DESCR1_MODE_CUSTOM_value = rightShift(data_low, 2) and &H3
        DESCR1_MODE_BYPASS_mask = &H3
        if data_low > LONG_MAX then
            if DESCR1_MODE_BYPASS_mask = mask then
                read_DESCR1_MODE_BYPASS_value = data_low
            else
                read_DESCR1_MODE_BYPASS_value = (data_low - H8000_0000) and DESCR1_MODE_BYPASS_mask
            end If
        else
            read_DESCR1_MODE_BYPASS_value = data_low and DESCR1_MODE_BYPASS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DESCR1_MODE_CUSTOM_value = &H0
        flag_DESCR1_MODE_CUSTOM        = &H0
        write_DESCR1_MODE_BYPASS_value = &H0
        flag_DESCR1_MODE_BYPASS        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_fec_sync
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLOCKSYNC_MODE_CUSTOM                      [11:9]           get_BLOCKSYNC_MODE_CUSTOM
''                                                             set_BLOCKSYNC_MODE_CUSTOM
''                                                             read_BLOCKSYNC_MODE_CUSTOM
''                                                             write_BLOCKSYNC_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' BLOCKSYNC_MODE_FEC                         [8:6]            get_BLOCKSYNC_MODE_FEC
''                                                             set_BLOCKSYNC_MODE_FEC
''                                                             read_BLOCKSYNC_MODE_FEC
''                                                             write_BLOCKSYNC_MODE_FEC
''---------------------------------------------------------------------------------
'' BLOCKSYNC_MODE_CL49                        [5:3]            get_BLOCKSYNC_MODE_CL49
''                                                             set_BLOCKSYNC_MODE_CL49
''                                                             read_BLOCKSYNC_MODE_CL49
''                                                             write_BLOCKSYNC_MODE_CL49
''---------------------------------------------------------------------------------
'' BLOCKSYNC_MODE_8B10B                       [2:0]            get_BLOCKSYNC_MODE_8B10B
''                                                             set_BLOCKSYNC_MODE_8B10B
''                                                             read_BLOCKSYNC_MODE_8B10B
''                                                             write_BLOCKSYNC_MODE_8B10B
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_fec_sync
    Private write_BLOCKSYNC_MODE_CUSTOM_value
    Private read_BLOCKSYNC_MODE_CUSTOM_value
    Private flag_BLOCKSYNC_MODE_CUSTOM
    Private write_BLOCKSYNC_MODE_FEC_value
    Private read_BLOCKSYNC_MODE_FEC_value
    Private flag_BLOCKSYNC_MODE_FEC
    Private write_BLOCKSYNC_MODE_CL49_value
    Private read_BLOCKSYNC_MODE_CL49_value
    Private flag_BLOCKSYNC_MODE_CL49
    Private write_BLOCKSYNC_MODE_8B10B_value
    Private read_BLOCKSYNC_MODE_8B10B_value
    Private flag_BLOCKSYNC_MODE_8B10B

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

    Property Get get_BLOCKSYNC_MODE_CUSTOM
        get_BLOCKSYNC_MODE_CUSTOM = read_BLOCKSYNC_MODE_CUSTOM_value
    End Property

    Property Let set_BLOCKSYNC_MODE_CUSTOM(aData)
        write_BLOCKSYNC_MODE_CUSTOM_value = aData
        flag_BLOCKSYNC_MODE_CUSTOM        = &H1
    End Property

    Property Get read_BLOCKSYNC_MODE_CUSTOM
        read
        read_BLOCKSYNC_MODE_CUSTOM = read_BLOCKSYNC_MODE_CUSTOM_value
    End Property

    Property Let write_BLOCKSYNC_MODE_CUSTOM(aData)
        set_BLOCKSYNC_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_BLOCKSYNC_MODE_FEC
        get_BLOCKSYNC_MODE_FEC = read_BLOCKSYNC_MODE_FEC_value
    End Property

    Property Let set_BLOCKSYNC_MODE_FEC(aData)
        write_BLOCKSYNC_MODE_FEC_value = aData
        flag_BLOCKSYNC_MODE_FEC        = &H1
    End Property

    Property Get read_BLOCKSYNC_MODE_FEC
        read
        read_BLOCKSYNC_MODE_FEC = read_BLOCKSYNC_MODE_FEC_value
    End Property

    Property Let write_BLOCKSYNC_MODE_FEC(aData)
        set_BLOCKSYNC_MODE_FEC = aData
        write
    End Property

    Property Get get_BLOCKSYNC_MODE_CL49
        get_BLOCKSYNC_MODE_CL49 = read_BLOCKSYNC_MODE_CL49_value
    End Property

    Property Let set_BLOCKSYNC_MODE_CL49(aData)
        write_BLOCKSYNC_MODE_CL49_value = aData
        flag_BLOCKSYNC_MODE_CL49        = &H1
    End Property

    Property Get read_BLOCKSYNC_MODE_CL49
        read
        read_BLOCKSYNC_MODE_CL49 = read_BLOCKSYNC_MODE_CL49_value
    End Property

    Property Let write_BLOCKSYNC_MODE_CL49(aData)
        set_BLOCKSYNC_MODE_CL49 = aData
        write
    End Property

    Property Get get_BLOCKSYNC_MODE_8B10B
        get_BLOCKSYNC_MODE_8B10B = read_BLOCKSYNC_MODE_8B10B_value
    End Property

    Property Let set_BLOCKSYNC_MODE_8B10B(aData)
        write_BLOCKSYNC_MODE_8B10B_value = aData
        flag_BLOCKSYNC_MODE_8B10B        = &H1
    End Property

    Property Get read_BLOCKSYNC_MODE_8B10B
        read
        read_BLOCKSYNC_MODE_8B10B = read_BLOCKSYNC_MODE_8B10B_value
    End Property

    Property Let write_BLOCKSYNC_MODE_8B10B(aData)
        set_BLOCKSYNC_MODE_8B10B = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BLOCKSYNC_MODE_CUSTOM_value = rightShift(data_low, 9) and &H7
        read_BLOCKSYNC_MODE_FEC_value = rightShift(data_low, 6) and &H7
        read_BLOCKSYNC_MODE_CL49_value = rightShift(data_low, 3) and &H7
        BLOCKSYNC_MODE_8B10B_mask = &H7
        if data_low > LONG_MAX then
            if BLOCKSYNC_MODE_8B10B_mask = mask then
                read_BLOCKSYNC_MODE_8B10B_value = data_low
            else
                read_BLOCKSYNC_MODE_8B10B_value = (data_low - H8000_0000) and BLOCKSYNC_MODE_8B10B_mask
            end If
        else
            read_BLOCKSYNC_MODE_8B10B_value = data_low and BLOCKSYNC_MODE_8B10B_mask
        end If

    End Sub

    Sub write
        If flag_BLOCKSYNC_MODE_CUSTOM = &H0 or flag_BLOCKSYNC_MODE_FEC = &H0 or flag_BLOCKSYNC_MODE_CL49 = &H0 or flag_BLOCKSYNC_MODE_8B10B = &H0 Then read
        If flag_BLOCKSYNC_MODE_CUSTOM = &H0 Then write_BLOCKSYNC_MODE_CUSTOM_value = get_BLOCKSYNC_MODE_CUSTOM
        If flag_BLOCKSYNC_MODE_FEC = &H0 Then write_BLOCKSYNC_MODE_FEC_value = get_BLOCKSYNC_MODE_FEC
        If flag_BLOCKSYNC_MODE_CL49 = &H0 Then write_BLOCKSYNC_MODE_CL49_value = get_BLOCKSYNC_MODE_CL49
        If flag_BLOCKSYNC_MODE_8B10B = &H0 Then write_BLOCKSYNC_MODE_8B10B_value = get_BLOCKSYNC_MODE_8B10B

        regValue = leftShift((write_BLOCKSYNC_MODE_CUSTOM_value and &H7), 9) + leftShift((write_BLOCKSYNC_MODE_FEC_value and &H7), 6) + leftShift((write_BLOCKSYNC_MODE_CL49_value and &H7), 3) + leftShift((write_BLOCKSYNC_MODE_8B10B_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BLOCKSYNC_MODE_CUSTOM_value = rightShift(data_low, 9) and &H7
        read_BLOCKSYNC_MODE_FEC_value = rightShift(data_low, 6) and &H7
        read_BLOCKSYNC_MODE_CL49_value = rightShift(data_low, 3) and &H7
        BLOCKSYNC_MODE_8B10B_mask = &H7
        if data_low > LONG_MAX then
            if BLOCKSYNC_MODE_8B10B_mask = mask then
                read_BLOCKSYNC_MODE_8B10B_value = data_low
            else
                read_BLOCKSYNC_MODE_8B10B_value = (data_low - H8000_0000) and BLOCKSYNC_MODE_8B10B_mask
            end If
        else
            read_BLOCKSYNC_MODE_8B10B_value = data_low and BLOCKSYNC_MODE_8B10B_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLOCKSYNC_MODE_CUSTOM_value = &H0
        flag_BLOCKSYNC_MODE_CUSTOM        = &H0
        write_BLOCKSYNC_MODE_FEC_value = &H0
        flag_BLOCKSYNC_MODE_FEC        = &H0
        write_BLOCKSYNC_MODE_CL49_value = &H0
        flag_BLOCKSYNC_MODE_CL49        = &H0
        write_BLOCKSYNC_MODE_8B10B_value = &H0
        flag_BLOCKSYNC_MODE_8B10B        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_dec1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DECODER_MODE_CUSTOM                        [8:6]            get_DECODER_MODE_CUSTOM
''                                                             set_DECODER_MODE_CUSTOM
''                                                             read_DECODER_MODE_CUSTOM
''                                                             write_DECODER_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' DECODER_MODE_CL49                          [5:3]            get_DECODER_MODE_CL49
''                                                             set_DECODER_MODE_CL49
''                                                             read_DECODER_MODE_CL49
''                                                             write_DECODER_MODE_CL49
''---------------------------------------------------------------------------------
'' DECODER_MODE_CL36                          [2:0]            get_DECODER_MODE_CL36
''                                                             set_DECODER_MODE_CL36
''                                                             read_DECODER_MODE_CL36
''                                                             write_DECODER_MODE_CL36
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_dec1
    Private write_DECODER_MODE_CUSTOM_value
    Private read_DECODER_MODE_CUSTOM_value
    Private flag_DECODER_MODE_CUSTOM
    Private write_DECODER_MODE_CL49_value
    Private read_DECODER_MODE_CL49_value
    Private flag_DECODER_MODE_CL49
    Private write_DECODER_MODE_CL36_value
    Private read_DECODER_MODE_CL36_value
    Private flag_DECODER_MODE_CL36

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

    Property Get get_DECODER_MODE_CUSTOM
        get_DECODER_MODE_CUSTOM = read_DECODER_MODE_CUSTOM_value
    End Property

    Property Let set_DECODER_MODE_CUSTOM(aData)
        write_DECODER_MODE_CUSTOM_value = aData
        flag_DECODER_MODE_CUSTOM        = &H1
    End Property

    Property Get read_DECODER_MODE_CUSTOM
        read
        read_DECODER_MODE_CUSTOM = read_DECODER_MODE_CUSTOM_value
    End Property

    Property Let write_DECODER_MODE_CUSTOM(aData)
        set_DECODER_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_DECODER_MODE_CL49
        get_DECODER_MODE_CL49 = read_DECODER_MODE_CL49_value
    End Property

    Property Let set_DECODER_MODE_CL49(aData)
        write_DECODER_MODE_CL49_value = aData
        flag_DECODER_MODE_CL49        = &H1
    End Property

    Property Get read_DECODER_MODE_CL49
        read
        read_DECODER_MODE_CL49 = read_DECODER_MODE_CL49_value
    End Property

    Property Let write_DECODER_MODE_CL49(aData)
        set_DECODER_MODE_CL49 = aData
        write
    End Property

    Property Get get_DECODER_MODE_CL36
        get_DECODER_MODE_CL36 = read_DECODER_MODE_CL36_value
    End Property

    Property Let set_DECODER_MODE_CL36(aData)
        write_DECODER_MODE_CL36_value = aData
        flag_DECODER_MODE_CL36        = &H1
    End Property

    Property Get read_DECODER_MODE_CL36
        read
        read_DECODER_MODE_CL36 = read_DECODER_MODE_CL36_value
    End Property

    Property Let write_DECODER_MODE_CL36(aData)
        set_DECODER_MODE_CL36 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DECODER_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_DECODER_MODE_CL49_value = rightShift(data_low, 3) and &H7
        DECODER_MODE_CL36_mask = &H7
        if data_low > LONG_MAX then
            if DECODER_MODE_CL36_mask = mask then
                read_DECODER_MODE_CL36_value = data_low
            else
                read_DECODER_MODE_CL36_value = (data_low - H8000_0000) and DECODER_MODE_CL36_mask
            end If
        else
            read_DECODER_MODE_CL36_value = data_low and DECODER_MODE_CL36_mask
        end If

    End Sub

    Sub write
        If flag_DECODER_MODE_CUSTOM = &H0 or flag_DECODER_MODE_CL49 = &H0 or flag_DECODER_MODE_CL36 = &H0 Then read
        If flag_DECODER_MODE_CUSTOM = &H0 Then write_DECODER_MODE_CUSTOM_value = get_DECODER_MODE_CUSTOM
        If flag_DECODER_MODE_CL49 = &H0 Then write_DECODER_MODE_CL49_value = get_DECODER_MODE_CL49
        If flag_DECODER_MODE_CL36 = &H0 Then write_DECODER_MODE_CL36_value = get_DECODER_MODE_CL36

        regValue = leftShift((write_DECODER_MODE_CUSTOM_value and &H7), 6) + leftShift((write_DECODER_MODE_CL49_value and &H7), 3) + leftShift((write_DECODER_MODE_CL36_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DECODER_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_DECODER_MODE_CL49_value = rightShift(data_low, 3) and &H7
        DECODER_MODE_CL36_mask = &H7
        if data_low > LONG_MAX then
            if DECODER_MODE_CL36_mask = mask then
                read_DECODER_MODE_CL36_value = data_low
            else
                read_DECODER_MODE_CL36_value = (data_low - H8000_0000) and DECODER_MODE_CL36_mask
            end If
        else
            read_DECODER_MODE_CL36_value = data_low and DECODER_MODE_CL36_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DECODER_MODE_CUSTOM_value = &H0
        flag_DECODER_MODE_CUSTOM        = &H0
        write_DECODER_MODE_CL49_value = &H0
        flag_DECODER_MODE_CL49        = &H0
        write_DECODER_MODE_CL36_value = &H0
        flag_DECODER_MODE_CL36        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_deskew
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DESKEW_MODE_CUSTOM                         [8:6]            get_DESKEW_MODE_CUSTOM
''                                                             set_DESKEW_MODE_CUSTOM
''                                                             read_DESKEW_MODE_CUSTOM
''                                                             write_DESKEW_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' DESKEW_MODE_BYPASS                         [5:3]            get_DESKEW_MODE_BYPASS
''                                                             set_DESKEW_MODE_BYPASS
''                                                             read_DESKEW_MODE_BYPASS
''                                                             write_DESKEW_MODE_BYPASS
''---------------------------------------------------------------------------------
'' DESKEW_MODE_CL36_10B                       [2:0]            get_DESKEW_MODE_CL36_10B
''                                                             set_DESKEW_MODE_CL36_10B
''                                                             read_DESKEW_MODE_CL36_10B
''                                                             write_DESKEW_MODE_CL36_10B
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_deskew
    Private write_DESKEW_MODE_CUSTOM_value
    Private read_DESKEW_MODE_CUSTOM_value
    Private flag_DESKEW_MODE_CUSTOM
    Private write_DESKEW_MODE_BYPASS_value
    Private read_DESKEW_MODE_BYPASS_value
    Private flag_DESKEW_MODE_BYPASS
    Private write_DESKEW_MODE_CL36_10B_value
    Private read_DESKEW_MODE_CL36_10B_value
    Private flag_DESKEW_MODE_CL36_10B

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

    Property Get get_DESKEW_MODE_CUSTOM
        get_DESKEW_MODE_CUSTOM = read_DESKEW_MODE_CUSTOM_value
    End Property

    Property Let set_DESKEW_MODE_CUSTOM(aData)
        write_DESKEW_MODE_CUSTOM_value = aData
        flag_DESKEW_MODE_CUSTOM        = &H1
    End Property

    Property Get read_DESKEW_MODE_CUSTOM
        read
        read_DESKEW_MODE_CUSTOM = read_DESKEW_MODE_CUSTOM_value
    End Property

    Property Let write_DESKEW_MODE_CUSTOM(aData)
        set_DESKEW_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_DESKEW_MODE_BYPASS
        get_DESKEW_MODE_BYPASS = read_DESKEW_MODE_BYPASS_value
    End Property

    Property Let set_DESKEW_MODE_BYPASS(aData)
        write_DESKEW_MODE_BYPASS_value = aData
        flag_DESKEW_MODE_BYPASS        = &H1
    End Property

    Property Get read_DESKEW_MODE_BYPASS
        read
        read_DESKEW_MODE_BYPASS = read_DESKEW_MODE_BYPASS_value
    End Property

    Property Let write_DESKEW_MODE_BYPASS(aData)
        set_DESKEW_MODE_BYPASS = aData
        write
    End Property

    Property Get get_DESKEW_MODE_CL36_10B
        get_DESKEW_MODE_CL36_10B = read_DESKEW_MODE_CL36_10B_value
    End Property

    Property Let set_DESKEW_MODE_CL36_10B(aData)
        write_DESKEW_MODE_CL36_10B_value = aData
        flag_DESKEW_MODE_CL36_10B        = &H1
    End Property

    Property Get read_DESKEW_MODE_CL36_10B
        read
        read_DESKEW_MODE_CL36_10B = read_DESKEW_MODE_CL36_10B_value
    End Property

    Property Let write_DESKEW_MODE_CL36_10B(aData)
        set_DESKEW_MODE_CL36_10B = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DESKEW_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_DESKEW_MODE_BYPASS_value = rightShift(data_low, 3) and &H7
        DESKEW_MODE_CL36_10B_mask = &H7
        if data_low > LONG_MAX then
            if DESKEW_MODE_CL36_10B_mask = mask then
                read_DESKEW_MODE_CL36_10B_value = data_low
            else
                read_DESKEW_MODE_CL36_10B_value = (data_low - H8000_0000) and DESKEW_MODE_CL36_10B_mask
            end If
        else
            read_DESKEW_MODE_CL36_10B_value = data_low and DESKEW_MODE_CL36_10B_mask
        end If

    End Sub

    Sub write
        If flag_DESKEW_MODE_CUSTOM = &H0 or flag_DESKEW_MODE_BYPASS = &H0 or flag_DESKEW_MODE_CL36_10B = &H0 Then read
        If flag_DESKEW_MODE_CUSTOM = &H0 Then write_DESKEW_MODE_CUSTOM_value = get_DESKEW_MODE_CUSTOM
        If flag_DESKEW_MODE_BYPASS = &H0 Then write_DESKEW_MODE_BYPASS_value = get_DESKEW_MODE_BYPASS
        If flag_DESKEW_MODE_CL36_10B = &H0 Then write_DESKEW_MODE_CL36_10B_value = get_DESKEW_MODE_CL36_10B

        regValue = leftShift((write_DESKEW_MODE_CUSTOM_value and &H7), 6) + leftShift((write_DESKEW_MODE_BYPASS_value and &H7), 3) + leftShift((write_DESKEW_MODE_CL36_10B_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DESKEW_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_DESKEW_MODE_BYPASS_value = rightShift(data_low, 3) and &H7
        DESKEW_MODE_CL36_10B_mask = &H7
        if data_low > LONG_MAX then
            if DESKEW_MODE_CL36_10B_mask = mask then
                read_DESKEW_MODE_CL36_10B_value = data_low
            else
                read_DESKEW_MODE_CL36_10B_value = (data_low - H8000_0000) and DESKEW_MODE_CL36_10B_mask
            end If
        else
            read_DESKEW_MODE_CL36_10B_value = data_low and DESKEW_MODE_CL36_10B_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DESKEW_MODE_CUSTOM_value = &H0
        flag_DESKEW_MODE_CUSTOM        = &H0
        write_DESKEW_MODE_BYPASS_value = &H0
        flag_DESKEW_MODE_BYPASS        = &H0
        write_DESKEW_MODE_CL36_10B_value = &H0
        flag_DESKEW_MODE_CL36_10B        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_reorder
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' idle_force_link_down                       [5:5]            get_idle_force_link_down
''                                                             set_idle_force_link_down
''                                                             read_idle_force_link_down
''                                                             write_idle_force_link_down
''---------------------------------------------------------------------------------
'' force_tx_till_link                         [4:4]            get_force_tx_till_link
''                                                             set_force_tx_till_link
''                                                             read_force_tx_till_link
''                                                             write_force_tx_till_link
''---------------------------------------------------------------------------------
'' force_tx_till_pmdlock                      [3:3]            get_force_tx_till_pmdlock
''                                                             set_force_tx_till_pmdlock
''                                                             read_force_tx_till_pmdlock
''                                                             write_force_tx_till_pmdlock
''---------------------------------------------------------------------------------
'' REORDER_MODE_CUSTOM                        [2:2]            get_REORDER_MODE_CUSTOM
''                                                             set_REORDER_MODE_CUSTOM
''                                                             read_REORDER_MODE_CUSTOM
''                                                             write_REORDER_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' REORDER_MODE_NONE                          [1:1]            get_REORDER_MODE_NONE
''                                                             set_REORDER_MODE_NONE
''                                                             read_REORDER_MODE_NONE
''                                                             write_REORDER_MODE_NONE
''---------------------------------------------------------------------------------
'' REORDER_MODE_CL36                          [0:0]            get_REORDER_MODE_CL36
''                                                             set_REORDER_MODE_CL36
''                                                             read_REORDER_MODE_CL36
''                                                             write_REORDER_MODE_CL36
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_reorder
    Private write_idle_force_link_down_value
    Private read_idle_force_link_down_value
    Private flag_idle_force_link_down
    Private write_force_tx_till_link_value
    Private read_force_tx_till_link_value
    Private flag_force_tx_till_link
    Private write_force_tx_till_pmdlock_value
    Private read_force_tx_till_pmdlock_value
    Private flag_force_tx_till_pmdlock
    Private write_REORDER_MODE_CUSTOM_value
    Private read_REORDER_MODE_CUSTOM_value
    Private flag_REORDER_MODE_CUSTOM
    Private write_REORDER_MODE_NONE_value
    Private read_REORDER_MODE_NONE_value
    Private flag_REORDER_MODE_NONE
    Private write_REORDER_MODE_CL36_value
    Private read_REORDER_MODE_CL36_value
    Private flag_REORDER_MODE_CL36

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

    Property Get get_idle_force_link_down
        get_idle_force_link_down = read_idle_force_link_down_value
    End Property

    Property Let set_idle_force_link_down(aData)
        write_idle_force_link_down_value = aData
        flag_idle_force_link_down        = &H1
    End Property

    Property Get read_idle_force_link_down
        read
        read_idle_force_link_down = read_idle_force_link_down_value
    End Property

    Property Let write_idle_force_link_down(aData)
        set_idle_force_link_down = aData
        write
    End Property

    Property Get get_force_tx_till_link
        get_force_tx_till_link = read_force_tx_till_link_value
    End Property

    Property Let set_force_tx_till_link(aData)
        write_force_tx_till_link_value = aData
        flag_force_tx_till_link        = &H1
    End Property

    Property Get read_force_tx_till_link
        read
        read_force_tx_till_link = read_force_tx_till_link_value
    End Property

    Property Let write_force_tx_till_link(aData)
        set_force_tx_till_link = aData
        write
    End Property

    Property Get get_force_tx_till_pmdlock
        get_force_tx_till_pmdlock = read_force_tx_till_pmdlock_value
    End Property

    Property Let set_force_tx_till_pmdlock(aData)
        write_force_tx_till_pmdlock_value = aData
        flag_force_tx_till_pmdlock        = &H1
    End Property

    Property Get read_force_tx_till_pmdlock
        read
        read_force_tx_till_pmdlock = read_force_tx_till_pmdlock_value
    End Property

    Property Let write_force_tx_till_pmdlock(aData)
        set_force_tx_till_pmdlock = aData
        write
    End Property

    Property Get get_REORDER_MODE_CUSTOM
        get_REORDER_MODE_CUSTOM = read_REORDER_MODE_CUSTOM_value
    End Property

    Property Let set_REORDER_MODE_CUSTOM(aData)
        write_REORDER_MODE_CUSTOM_value = aData
        flag_REORDER_MODE_CUSTOM        = &H1
    End Property

    Property Get read_REORDER_MODE_CUSTOM
        read
        read_REORDER_MODE_CUSTOM = read_REORDER_MODE_CUSTOM_value
    End Property

    Property Let write_REORDER_MODE_CUSTOM(aData)
        set_REORDER_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_REORDER_MODE_NONE
        get_REORDER_MODE_NONE = read_REORDER_MODE_NONE_value
    End Property

    Property Let set_REORDER_MODE_NONE(aData)
        write_REORDER_MODE_NONE_value = aData
        flag_REORDER_MODE_NONE        = &H1
    End Property

    Property Get read_REORDER_MODE_NONE
        read
        read_REORDER_MODE_NONE = read_REORDER_MODE_NONE_value
    End Property

    Property Let write_REORDER_MODE_NONE(aData)
        set_REORDER_MODE_NONE = aData
        write
    End Property

    Property Get get_REORDER_MODE_CL36
        get_REORDER_MODE_CL36 = read_REORDER_MODE_CL36_value
    End Property

    Property Let set_REORDER_MODE_CL36(aData)
        write_REORDER_MODE_CL36_value = aData
        flag_REORDER_MODE_CL36        = &H1
    End Property

    Property Get read_REORDER_MODE_CL36
        read
        read_REORDER_MODE_CL36 = read_REORDER_MODE_CL36_value
    End Property

    Property Let write_REORDER_MODE_CL36(aData)
        set_REORDER_MODE_CL36 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_idle_force_link_down_value = rightShift(data_low, 5) and &H1
        read_force_tx_till_link_value = rightShift(data_low, 4) and &H1
        read_force_tx_till_pmdlock_value = rightShift(data_low, 3) and &H1
        read_REORDER_MODE_CUSTOM_value = rightShift(data_low, 2) and &H1
        read_REORDER_MODE_NONE_value = rightShift(data_low, 1) and &H1
        REORDER_MODE_CL36_mask = &H1
        if data_low > LONG_MAX then
            if REORDER_MODE_CL36_mask = mask then
                read_REORDER_MODE_CL36_value = data_low
            else
                read_REORDER_MODE_CL36_value = (data_low - H8000_0000) and REORDER_MODE_CL36_mask
            end If
        else
            read_REORDER_MODE_CL36_value = data_low and REORDER_MODE_CL36_mask
        end If

    End Sub

    Sub write
        If flag_idle_force_link_down = &H0 or flag_force_tx_till_link = &H0 or flag_force_tx_till_pmdlock = &H0 or flag_REORDER_MODE_CUSTOM = &H0 or flag_REORDER_MODE_NONE = &H0 or flag_REORDER_MODE_CL36 = &H0 Then read
        If flag_idle_force_link_down = &H0 Then write_idle_force_link_down_value = get_idle_force_link_down
        If flag_force_tx_till_link = &H0 Then write_force_tx_till_link_value = get_force_tx_till_link
        If flag_force_tx_till_pmdlock = &H0 Then write_force_tx_till_pmdlock_value = get_force_tx_till_pmdlock
        If flag_REORDER_MODE_CUSTOM = &H0 Then write_REORDER_MODE_CUSTOM_value = get_REORDER_MODE_CUSTOM
        If flag_REORDER_MODE_NONE = &H0 Then write_REORDER_MODE_NONE_value = get_REORDER_MODE_NONE
        If flag_REORDER_MODE_CL36 = &H0 Then write_REORDER_MODE_CL36_value = get_REORDER_MODE_CL36

        regValue = leftShift((write_idle_force_link_down_value and &H1), 5) + leftShift((write_force_tx_till_link_value and &H1), 4) + leftShift((write_force_tx_till_pmdlock_value and &H1), 3) + leftShift((write_REORDER_MODE_CUSTOM_value and &H1), 2) + leftShift((write_REORDER_MODE_NONE_value and &H1), 1) + leftShift((write_REORDER_MODE_CL36_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_idle_force_link_down_value = rightShift(data_low, 5) and &H1
        read_force_tx_till_link_value = rightShift(data_low, 4) and &H1
        read_force_tx_till_pmdlock_value = rightShift(data_low, 3) and &H1
        read_REORDER_MODE_CUSTOM_value = rightShift(data_low, 2) and &H1
        read_REORDER_MODE_NONE_value = rightShift(data_low, 1) and &H1
        REORDER_MODE_CL36_mask = &H1
        if data_low > LONG_MAX then
            if REORDER_MODE_CL36_mask = mask then
                read_REORDER_MODE_CL36_value = data_low
            else
                read_REORDER_MODE_CL36_value = (data_low - H8000_0000) and REORDER_MODE_CL36_mask
            end If
        else
            read_REORDER_MODE_CL36_value = data_low and REORDER_MODE_CL36_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_idle_force_link_down_value = &H0
        flag_idle_force_link_down        = &H0
        write_force_tx_till_link_value = &H0
        flag_force_tx_till_link        = &H0
        write_force_tx_till_pmdlock_value = &H0
        flag_force_tx_till_pmdlock        = &H0
        write_REORDER_MODE_CUSTOM_value = &H0
        flag_REORDER_MODE_CUSTOM        = &H0
        write_REORDER_MODE_NONE_value = &H0
        flag_REORDER_MODE_NONE        = &H0
        write_REORDER_MODE_CL36_value = &H0
        flag_REORDER_MODE_CL36        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_desc2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D2BDN                                      [14:13]          get_D2BDN
''                                                             set_D2BDN
''                                                             read_D2BDN
''                                                             write_D2BDN
''---------------------------------------------------------------------------------
'' D2BD100                                    [12:11]          get_D2BD100
''                                                             set_D2BD100
''                                                             read_D2BD100
''                                                             write_D2BD100
''---------------------------------------------------------------------------------
'' D2BD10                                     [10:9]           get_D2BD10
''                                                             set_D2BD10
''                                                             read_D2BD10
''                                                             write_D2BD10
''---------------------------------------------------------------------------------
'' DESC2_MODE_CUSTOM                          [8:6]            get_DESC2_MODE_CUSTOM
''                                                             set_DESC2_MODE_CUSTOM
''                                                             read_DESC2_MODE_CUSTOM
''                                                             write_DESC2_MODE_CUSTOM
''---------------------------------------------------------------------------------
'' DESC2_MODE_CL49                            [5:3]            get_DESC2_MODE_CL49
''                                                             set_DESC2_MODE_CL49
''                                                             read_DESC2_MODE_CL49
''                                                             write_DESC2_MODE_CL49
''---------------------------------------------------------------------------------
'' DESC2_MODE_CL36                            [2:0]            get_DESC2_MODE_CL36
''                                                             set_DESC2_MODE_CL36
''                                                             read_DESC2_MODE_CL36
''                                                             write_DESC2_MODE_CL36
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_desc2
    Private write_D2BDN_value
    Private read_D2BDN_value
    Private flag_D2BDN
    Private write_D2BD100_value
    Private read_D2BD100_value
    Private flag_D2BD100
    Private write_D2BD10_value
    Private read_D2BD10_value
    Private flag_D2BD10
    Private write_DESC2_MODE_CUSTOM_value
    Private read_DESC2_MODE_CUSTOM_value
    Private flag_DESC2_MODE_CUSTOM
    Private write_DESC2_MODE_CL49_value
    Private read_DESC2_MODE_CL49_value
    Private flag_DESC2_MODE_CL49
    Private write_DESC2_MODE_CL36_value
    Private read_DESC2_MODE_CL36_value
    Private flag_DESC2_MODE_CL36

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

    Property Get get_D2BDN
        get_D2BDN = read_D2BDN_value
    End Property

    Property Let set_D2BDN(aData)
        write_D2BDN_value = aData
        flag_D2BDN        = &H1
    End Property

    Property Get read_D2BDN
        read
        read_D2BDN = read_D2BDN_value
    End Property

    Property Let write_D2BDN(aData)
        set_D2BDN = aData
        write
    End Property

    Property Get get_D2BD100
        get_D2BD100 = read_D2BD100_value
    End Property

    Property Let set_D2BD100(aData)
        write_D2BD100_value = aData
        flag_D2BD100        = &H1
    End Property

    Property Get read_D2BD100
        read
        read_D2BD100 = read_D2BD100_value
    End Property

    Property Let write_D2BD100(aData)
        set_D2BD100 = aData
        write
    End Property

    Property Get get_D2BD10
        get_D2BD10 = read_D2BD10_value
    End Property

    Property Let set_D2BD10(aData)
        write_D2BD10_value = aData
        flag_D2BD10        = &H1
    End Property

    Property Get read_D2BD10
        read
        read_D2BD10 = read_D2BD10_value
    End Property

    Property Let write_D2BD10(aData)
        set_D2BD10 = aData
        write
    End Property

    Property Get get_DESC2_MODE_CUSTOM
        get_DESC2_MODE_CUSTOM = read_DESC2_MODE_CUSTOM_value
    End Property

    Property Let set_DESC2_MODE_CUSTOM(aData)
        write_DESC2_MODE_CUSTOM_value = aData
        flag_DESC2_MODE_CUSTOM        = &H1
    End Property

    Property Get read_DESC2_MODE_CUSTOM
        read
        read_DESC2_MODE_CUSTOM = read_DESC2_MODE_CUSTOM_value
    End Property

    Property Let write_DESC2_MODE_CUSTOM(aData)
        set_DESC2_MODE_CUSTOM = aData
        write
    End Property

    Property Get get_DESC2_MODE_CL49
        get_DESC2_MODE_CL49 = read_DESC2_MODE_CL49_value
    End Property

    Property Let set_DESC2_MODE_CL49(aData)
        write_DESC2_MODE_CL49_value = aData
        flag_DESC2_MODE_CL49        = &H1
    End Property

    Property Get read_DESC2_MODE_CL49
        read
        read_DESC2_MODE_CL49 = read_DESC2_MODE_CL49_value
    End Property

    Property Let write_DESC2_MODE_CL49(aData)
        set_DESC2_MODE_CL49 = aData
        write
    End Property

    Property Get get_DESC2_MODE_CL36
        get_DESC2_MODE_CL36 = read_DESC2_MODE_CL36_value
    End Property

    Property Let set_DESC2_MODE_CL36(aData)
        write_DESC2_MODE_CL36_value = aData
        flag_DESC2_MODE_CL36        = &H1
    End Property

    Property Get read_DESC2_MODE_CL36
        read
        read_DESC2_MODE_CL36 = read_DESC2_MODE_CL36_value
    End Property

    Property Let write_DESC2_MODE_CL36(aData)
        set_DESC2_MODE_CL36 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_D2BDN_value = rightShift(data_low, 13) and &H3
        read_D2BD100_value = rightShift(data_low, 11) and &H3
        read_D2BD10_value = rightShift(data_low, 9) and &H3
        read_DESC2_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_DESC2_MODE_CL49_value = rightShift(data_low, 3) and &H7
        DESC2_MODE_CL36_mask = &H7
        if data_low > LONG_MAX then
            if DESC2_MODE_CL36_mask = mask then
                read_DESC2_MODE_CL36_value = data_low
            else
                read_DESC2_MODE_CL36_value = (data_low - H8000_0000) and DESC2_MODE_CL36_mask
            end If
        else
            read_DESC2_MODE_CL36_value = data_low and DESC2_MODE_CL36_mask
        end If

    End Sub

    Sub write
        If flag_D2BDN = &H0 or flag_D2BD100 = &H0 or flag_D2BD10 = &H0 or flag_DESC2_MODE_CUSTOM = &H0 or flag_DESC2_MODE_CL49 = &H0 or flag_DESC2_MODE_CL36 = &H0 Then read
        If flag_D2BDN = &H0 Then write_D2BDN_value = get_D2BDN
        If flag_D2BD100 = &H0 Then write_D2BD100_value = get_D2BD100
        If flag_D2BD10 = &H0 Then write_D2BD10_value = get_D2BD10
        If flag_DESC2_MODE_CUSTOM = &H0 Then write_DESC2_MODE_CUSTOM_value = get_DESC2_MODE_CUSTOM
        If flag_DESC2_MODE_CL49 = &H0 Then write_DESC2_MODE_CL49_value = get_DESC2_MODE_CL49
        If flag_DESC2_MODE_CL36 = &H0 Then write_DESC2_MODE_CL36_value = get_DESC2_MODE_CL36

        regValue = leftShift((write_D2BDN_value and &H3), 13) + leftShift((write_D2BD100_value and &H3), 11) + leftShift((write_D2BD10_value and &H3), 9) + leftShift((write_DESC2_MODE_CUSTOM_value and &H7), 6) + leftShift((write_DESC2_MODE_CL49_value and &H7), 3) + leftShift((write_DESC2_MODE_CL36_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_D2BDN_value = rightShift(data_low, 13) and &H3
        read_D2BD100_value = rightShift(data_low, 11) and &H3
        read_D2BD10_value = rightShift(data_low, 9) and &H3
        read_DESC2_MODE_CUSTOM_value = rightShift(data_low, 6) and &H7
        read_DESC2_MODE_CL49_value = rightShift(data_low, 3) and &H7
        DESC2_MODE_CL36_mask = &H7
        if data_low > LONG_MAX then
            if DESC2_MODE_CL36_mask = mask then
                read_DESC2_MODE_CL36_value = data_low
            else
                read_DESC2_MODE_CL36_value = (data_low - H8000_0000) and DESC2_MODE_CL36_mask
            end If
        else
            read_DESC2_MODE_CL36_value = data_low and DESC2_MODE_CL36_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D2BDN_value = &H0
        flag_D2BDN        = &H0
        write_D2BD100_value = &H0
        flag_D2BD100        = &H0
        write_D2BD10_value = &H0
        flag_D2BD10        = &H0
        write_DESC2_MODE_CUSTOM_value = &H0
        flag_DESC2_MODE_CUSTOM        = &H0
        write_DESC2_MODE_CL49_value = &H0
        flag_DESC2_MODE_CL49        = &H0
        write_DESC2_MODE_CL36_value = &H0
        flag_DESC2_MODE_CL36        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_decode_control_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SET_BER_WINDOW_512                         [15:15]          get_SET_BER_WINDOW_512
''                                                             set_SET_BER_WINDOW_512
''                                                             read_SET_BER_WINDOW_512
''                                                             write_SET_BER_WINDOW_512
''---------------------------------------------------------------------------------
'' CL49_BER_LIMIT                             [7:2]            get_CL49_BER_LIMIT
''                                                             set_CL49_BER_LIMIT
''                                                             read_CL49_BER_LIMIT
''                                                             write_CL49_BER_LIMIT
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_decode_control_1
    Private write_SET_BER_WINDOW_512_value
    Private read_SET_BER_WINDOW_512_value
    Private flag_SET_BER_WINDOW_512
    Private write_CL49_BER_LIMIT_value
    Private read_CL49_BER_LIMIT_value
    Private flag_CL49_BER_LIMIT

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

    Property Get get_SET_BER_WINDOW_512
        get_SET_BER_WINDOW_512 = read_SET_BER_WINDOW_512_value
    End Property

    Property Let set_SET_BER_WINDOW_512(aData)
        write_SET_BER_WINDOW_512_value = aData
        flag_SET_BER_WINDOW_512        = &H1
    End Property

    Property Get read_SET_BER_WINDOW_512
        read
        read_SET_BER_WINDOW_512 = read_SET_BER_WINDOW_512_value
    End Property

    Property Let write_SET_BER_WINDOW_512(aData)
        set_SET_BER_WINDOW_512 = aData
        write
    End Property

    Property Get get_CL49_BER_LIMIT
        get_CL49_BER_LIMIT = read_CL49_BER_LIMIT_value
    End Property

    Property Let set_CL49_BER_LIMIT(aData)
        write_CL49_BER_LIMIT_value = aData
        flag_CL49_BER_LIMIT        = &H1
    End Property

    Property Get read_CL49_BER_LIMIT
        read
        read_CL49_BER_LIMIT = read_CL49_BER_LIMIT_value
    End Property

    Property Let write_CL49_BER_LIMIT(aData)
        set_CL49_BER_LIMIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SET_BER_WINDOW_512_value = rightShift(data_low, 15) and &H1
        read_CL49_BER_LIMIT_value = rightShift(data_low, 2) and &H3f

    End Sub

    Sub write
        If flag_SET_BER_WINDOW_512 = &H0 or flag_CL49_BER_LIMIT = &H0 Then read
        If flag_SET_BER_WINDOW_512 = &H0 Then write_SET_BER_WINDOW_512_value = get_SET_BER_WINDOW_512
        If flag_CL49_BER_LIMIT = &H0 Then write_CL49_BER_LIMIT_value = get_CL49_BER_LIMIT

        regValue = leftShift((write_SET_BER_WINDOW_512_value and &H1), 15) + leftShift((write_CL49_BER_LIMIT_value and &H3f), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SET_BER_WINDOW_512_value = rightShift(data_low, 15) and &H1
        read_CL49_BER_LIMIT_value = rightShift(data_low, 2) and &H3f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SET_BER_WINDOW_512_value = &H0
        flag_SET_BER_WINDOW_512        = &H0
        write_CL49_BER_LIMIT_value = &H0
        flag_CL49_BER_LIMIT        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_shcnt_cl49
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl49_valid_sh_cnt                          [15:8]           get_cl49_valid_sh_cnt
''                                                             set_cl49_valid_sh_cnt
''                                                             read_cl49_valid_sh_cnt
''                                                             write_cl49_valid_sh_cnt
''---------------------------------------------------------------------------------
'' cl49_invalid_sh_cnt                        [7:0]            get_cl49_invalid_sh_cnt
''                                                             set_cl49_invalid_sh_cnt
''                                                             read_cl49_invalid_sh_cnt
''                                                             write_cl49_invalid_sh_cnt
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_shcnt_cl49
    Private write_cl49_valid_sh_cnt_value
    Private read_cl49_valid_sh_cnt_value
    Private flag_cl49_valid_sh_cnt
    Private write_cl49_invalid_sh_cnt_value
    Private read_cl49_invalid_sh_cnt_value
    Private flag_cl49_invalid_sh_cnt

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

    Property Get get_cl49_valid_sh_cnt
        get_cl49_valid_sh_cnt = read_cl49_valid_sh_cnt_value
    End Property

    Property Let set_cl49_valid_sh_cnt(aData)
        write_cl49_valid_sh_cnt_value = aData
        flag_cl49_valid_sh_cnt        = &H1
    End Property

    Property Get read_cl49_valid_sh_cnt
        read
        read_cl49_valid_sh_cnt = read_cl49_valid_sh_cnt_value
    End Property

    Property Let write_cl49_valid_sh_cnt(aData)
        set_cl49_valid_sh_cnt = aData
        write
    End Property

    Property Get get_cl49_invalid_sh_cnt
        get_cl49_invalid_sh_cnt = read_cl49_invalid_sh_cnt_value
    End Property

    Property Let set_cl49_invalid_sh_cnt(aData)
        write_cl49_invalid_sh_cnt_value = aData
        flag_cl49_invalid_sh_cnt        = &H1
    End Property

    Property Get read_cl49_invalid_sh_cnt
        read
        read_cl49_invalid_sh_cnt = read_cl49_invalid_sh_cnt_value
    End Property

    Property Let write_cl49_invalid_sh_cnt(aData)
        set_cl49_invalid_sh_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl49_valid_sh_cnt_value = rightShift(data_low, 8) and &Hff
        cl49_invalid_sh_cnt_mask = &Hff
        if data_low > LONG_MAX then
            if cl49_invalid_sh_cnt_mask = mask then
                read_cl49_invalid_sh_cnt_value = data_low
            else
                read_cl49_invalid_sh_cnt_value = (data_low - H8000_0000) and cl49_invalid_sh_cnt_mask
            end If
        else
            read_cl49_invalid_sh_cnt_value = data_low and cl49_invalid_sh_cnt_mask
        end If

    End Sub

    Sub write
        If flag_cl49_valid_sh_cnt = &H0 or flag_cl49_invalid_sh_cnt = &H0 Then read
        If flag_cl49_valid_sh_cnt = &H0 Then write_cl49_valid_sh_cnt_value = get_cl49_valid_sh_cnt
        If flag_cl49_invalid_sh_cnt = &H0 Then write_cl49_invalid_sh_cnt_value = get_cl49_invalid_sh_cnt

        regValue = leftShift((write_cl49_valid_sh_cnt_value and &Hff), 8) + leftShift((write_cl49_invalid_sh_cnt_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl49_valid_sh_cnt_value = rightShift(data_low, 8) and &Hff
        cl49_invalid_sh_cnt_mask = &Hff
        if data_low > LONG_MAX then
            if cl49_invalid_sh_cnt_mask = mask then
                read_cl49_invalid_sh_cnt_value = data_low
            else
                read_cl49_invalid_sh_cnt_value = (data_low - H8000_0000) and cl49_invalid_sh_cnt_mask
            end If
        else
            read_cl49_invalid_sh_cnt_value = data_low and cl49_invalid_sh_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl49_valid_sh_cnt_value = &H0
        flag_cl49_valid_sh_cnt        = &H0
        write_cl49_invalid_sh_cnt_value = &H0
        flag_cl49_invalid_sh_cnt        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_rx_lock_delay
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' frc_rx_slot_zero                           [8:8]            get_frc_rx_slot_zero
''                                                             set_frc_rx_slot_zero
''                                                             read_frc_rx_slot_zero
''                                                             write_frc_rx_slot_zero
''---------------------------------------------------------------------------------
'' pmd_rx_lock_delay_cnt                      [7:0]            get_pmd_rx_lock_delay_cnt
''                                                             set_pmd_rx_lock_delay_cnt
''                                                             read_pmd_rx_lock_delay_cnt
''                                                             write_pmd_rx_lock_delay_cnt
''---------------------------------------------------------------------------------
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_rx_lock_delay
    Private write_frc_rx_slot_zero_value
    Private read_frc_rx_slot_zero_value
    Private flag_frc_rx_slot_zero
    Private write_pmd_rx_lock_delay_cnt_value
    Private read_pmd_rx_lock_delay_cnt_value
    Private flag_pmd_rx_lock_delay_cnt

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

    Property Get get_frc_rx_slot_zero
        get_frc_rx_slot_zero = read_frc_rx_slot_zero_value
    End Property

    Property Let set_frc_rx_slot_zero(aData)
        write_frc_rx_slot_zero_value = aData
        flag_frc_rx_slot_zero        = &H1
    End Property

    Property Get read_frc_rx_slot_zero
        read
        read_frc_rx_slot_zero = read_frc_rx_slot_zero_value
    End Property

    Property Let write_frc_rx_slot_zero(aData)
        set_frc_rx_slot_zero = aData
        write
    End Property

    Property Get get_pmd_rx_lock_delay_cnt
        get_pmd_rx_lock_delay_cnt = read_pmd_rx_lock_delay_cnt_value
    End Property

    Property Let set_pmd_rx_lock_delay_cnt(aData)
        write_pmd_rx_lock_delay_cnt_value = aData
        flag_pmd_rx_lock_delay_cnt        = &H1
    End Property

    Property Get read_pmd_rx_lock_delay_cnt
        read
        read_pmd_rx_lock_delay_cnt = read_pmd_rx_lock_delay_cnt_value
    End Property

    Property Let write_pmd_rx_lock_delay_cnt(aData)
        set_pmd_rx_lock_delay_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_frc_rx_slot_zero_value = rightShift(data_low, 8) and &H1
        pmd_rx_lock_delay_cnt_mask = &Hff
        if data_low > LONG_MAX then
            if pmd_rx_lock_delay_cnt_mask = mask then
                read_pmd_rx_lock_delay_cnt_value = data_low
            else
                read_pmd_rx_lock_delay_cnt_value = (data_low - H8000_0000) and pmd_rx_lock_delay_cnt_mask
            end If
        else
            read_pmd_rx_lock_delay_cnt_value = data_low and pmd_rx_lock_delay_cnt_mask
        end If

    End Sub

    Sub write
        If flag_frc_rx_slot_zero = &H0 or flag_pmd_rx_lock_delay_cnt = &H0 Then read
        If flag_frc_rx_slot_zero = &H0 Then write_frc_rx_slot_zero_value = get_frc_rx_slot_zero
        If flag_pmd_rx_lock_delay_cnt = &H0 Then write_pmd_rx_lock_delay_cnt_value = get_pmd_rx_lock_delay_cnt

        regValue = leftShift((write_frc_rx_slot_zero_value and &H1), 8) + leftShift((write_pmd_rx_lock_delay_cnt_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_frc_rx_slot_zero_value = rightShift(data_low, 8) and &H1
        pmd_rx_lock_delay_cnt_mask = &Hff
        if data_low > LONG_MAX then
            if pmd_rx_lock_delay_cnt_mask = mask then
                read_pmd_rx_lock_delay_cnt_value = data_low
            else
                read_pmd_rx_lock_delay_cnt_value = (data_low - H8000_0000) and pmd_rx_lock_delay_cnt_mask
            end If
        else
            read_pmd_rx_lock_delay_cnt_value = data_low and pmd_rx_lock_delay_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_frc_rx_slot_zero_value = &H0
        flag_frc_rx_slot_zero        = &H0
        write_pmd_rx_lock_delay_cnt_value = &H0
        flag_pmd_rx_lock_delay_cnt        = &H0
    End Sub
End Class


'' @REGISTER : RX_X1_CONTROL0_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_blockaddress
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

Class RX_X1_CONTROL0_SGMIIPLUSR_X1_INSTANCE

    Public descr1
    Public fec_sync
    Public dec1
    Public deskew
    Public reorder
    Public desc2
    Public decode_control_1
    Public shcnt_cl49
    Public pmd_rx_lock_delay
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set descr1 = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_descr1)(aBaseAddr, 16)
        Set fec_sync = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_fec_sync)(aBaseAddr, 16)
        Set dec1 = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_dec1)(aBaseAddr, 16)
        Set deskew = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_deskew)(aBaseAddr, 16)
        Set reorder = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_reorder)(aBaseAddr, 16)
        Set desc2 = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_desc2)(aBaseAddr, 16)
        Set decode_control_1 = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_decode_control_1)(aBaseAddr, 16)
        Set shcnt_cl49 = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_shcnt_cl49)(aBaseAddr, 16)
        Set pmd_rx_lock_delay = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_pmd_rx_lock_delay)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_X1_CONTROL0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_X1_CONTROL0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX_X1_CONTROL0_SGMIIPLUSR_X1.Add ((New RX_X1_CONTROL0_SGMIIPLUSR_X1_INSTANCE)(&H4aed2440))


