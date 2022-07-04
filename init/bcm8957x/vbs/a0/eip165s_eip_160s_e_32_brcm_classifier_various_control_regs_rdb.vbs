

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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_cp_tag
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' map_tbl                                    [23:0]           get_map_tbl
''                                                             set_map_tbl
''                                                             read_map_tbl
''                                                             write_map_tbl
''---------------------------------------------------------------------------------
'' def_up                                     [26:24]          get_def_up
''                                                             set_def_up
''                                                             read_def_up
''                                                             write_def_up
''---------------------------------------------------------------------------------
'' stag_up_en                                 [27:27]          get_stag_up_en
''                                                             set_stag_up_en
''                                                             read_stag_up_en
''                                                             write_stag_up_en
''---------------------------------------------------------------------------------
'' qtag_up_en                                 [28:28]          get_qtag_up_en
''                                                             set_qtag_up_en
''                                                             read_qtag_up_en
''                                                             write_qtag_up_en
''---------------------------------------------------------------------------------
'' parse_qinq                                 [29:29]          get_parse_qinq
''                                                             set_parse_qinq
''                                                             read_parse_qinq
''                                                             write_parse_qinq
''---------------------------------------------------------------------------------
'' parse_stag                                 [30:30]          get_parse_stag
''                                                             set_parse_stag
''                                                             read_parse_stag
''                                                             write_parse_stag
''---------------------------------------------------------------------------------
'' parse_qtag                                 [31:31]          get_parse_qtag
''                                                             set_parse_qtag
''                                                             read_parse_qtag
''                                                             write_parse_qtag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_cp_tag
    Private write_map_tbl_value
    Private read_map_tbl_value
    Private flag_map_tbl
    Private write_def_up_value
    Private read_def_up_value
    Private flag_def_up
    Private write_stag_up_en_value
    Private read_stag_up_en_value
    Private flag_stag_up_en
    Private write_qtag_up_en_value
    Private read_qtag_up_en_value
    Private flag_qtag_up_en
    Private write_parse_qinq_value
    Private read_parse_qinq_value
    Private flag_parse_qinq
    Private write_parse_stag_value
    Private read_parse_stag_value
    Private flag_parse_stag
    Private write_parse_qtag_value
    Private read_parse_qtag_value
    Private flag_parse_qtag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17900
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_map_tbl
        get_map_tbl = read_map_tbl_value
    End Property

    Property Let set_map_tbl(aData)
        write_map_tbl_value = aData
        flag_map_tbl        = &H1
    End Property

    Property Get read_map_tbl
        read
        read_map_tbl = read_map_tbl_value
    End Property

    Property Let write_map_tbl(aData)
        set_map_tbl = aData
        write
    End Property

    Property Get get_def_up
        get_def_up = read_def_up_value
    End Property

    Property Let set_def_up(aData)
        write_def_up_value = aData
        flag_def_up        = &H1
    End Property

    Property Get read_def_up
        read
        read_def_up = read_def_up_value
    End Property

    Property Let write_def_up(aData)
        set_def_up = aData
        write
    End Property

    Property Get get_stag_up_en
        get_stag_up_en = read_stag_up_en_value
    End Property

    Property Let set_stag_up_en(aData)
        write_stag_up_en_value = aData
        flag_stag_up_en        = &H1
    End Property

    Property Get read_stag_up_en
        read
        read_stag_up_en = read_stag_up_en_value
    End Property

    Property Let write_stag_up_en(aData)
        set_stag_up_en = aData
        write
    End Property

    Property Get get_qtag_up_en
        get_qtag_up_en = read_qtag_up_en_value
    End Property

    Property Let set_qtag_up_en(aData)
        write_qtag_up_en_value = aData
        flag_qtag_up_en        = &H1
    End Property

    Property Get read_qtag_up_en
        read
        read_qtag_up_en = read_qtag_up_en_value
    End Property

    Property Let write_qtag_up_en(aData)
        set_qtag_up_en = aData
        write
    End Property

    Property Get get_parse_qinq
        get_parse_qinq = read_parse_qinq_value
    End Property

    Property Let set_parse_qinq(aData)
        write_parse_qinq_value = aData
        flag_parse_qinq        = &H1
    End Property

    Property Get read_parse_qinq
        read
        read_parse_qinq = read_parse_qinq_value
    End Property

    Property Let write_parse_qinq(aData)
        set_parse_qinq = aData
        write
    End Property

    Property Get get_parse_stag
        get_parse_stag = read_parse_stag_value
    End Property

    Property Let set_parse_stag(aData)
        write_parse_stag_value = aData
        flag_parse_stag        = &H1
    End Property

    Property Get read_parse_stag
        read
        read_parse_stag = read_parse_stag_value
    End Property

    Property Let write_parse_stag(aData)
        set_parse_stag = aData
        write
    End Property

    Property Get get_parse_qtag
        get_parse_qtag = read_parse_qtag_value
    End Property

    Property Let set_parse_qtag(aData)
        write_parse_qtag_value = aData
        flag_parse_qtag        = &H1
    End Property

    Property Get read_parse_qtag
        read
        read_parse_qtag = read_parse_qtag_value
    End Property

    Property Let write_parse_qtag(aData)
        set_parse_qtag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        map_tbl_mask = &Hffffff
        if data_low > LONG_MAX then
            if map_tbl_mask = mask then
                read_map_tbl_value = data_low
            else
                read_map_tbl_value = (data_low - H8000_0000) and map_tbl_mask
            end If
        else
            read_map_tbl_value = data_low and map_tbl_mask
        end If
        read_def_up_value = rightShift(data_low, 24) and &H7
        read_stag_up_en_value = rightShift(data_low, 27) and &H1
        read_qtag_up_en_value = rightShift(data_low, 28) and &H1
        read_parse_qinq_value = rightShift(data_low, 29) and &H1
        read_parse_stag_value = rightShift(data_low, 30) and &H1
        read_parse_qtag_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_map_tbl = &H0 or flag_def_up = &H0 or flag_stag_up_en = &H0 or flag_qtag_up_en = &H0 or flag_parse_qinq = &H0 or flag_parse_stag = &H0 or flag_parse_qtag = &H0 Then read
        If flag_map_tbl = &H0 Then write_map_tbl_value = get_map_tbl
        If flag_def_up = &H0 Then write_def_up_value = get_def_up
        If flag_stag_up_en = &H0 Then write_stag_up_en_value = get_stag_up_en
        If flag_qtag_up_en = &H0 Then write_qtag_up_en_value = get_qtag_up_en
        If flag_parse_qinq = &H0 Then write_parse_qinq_value = get_parse_qinq
        If flag_parse_stag = &H0 Then write_parse_stag_value = get_parse_stag
        If flag_parse_qtag = &H0 Then write_parse_qtag_value = get_parse_qtag

        regValue = leftShift((write_map_tbl_value and &Hffffff), 0) + leftShift((write_def_up_value and &H7), 24) + leftShift((write_stag_up_en_value and &H1), 27) + leftShift((write_qtag_up_en_value and &H1), 28) + leftShift((write_parse_qinq_value and &H1), 29) + leftShift((write_parse_stag_value and &H1), 30) + leftShift((write_parse_qtag_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        map_tbl_mask = &Hffffff
        if data_low > LONG_MAX then
            if map_tbl_mask = mask then
                read_map_tbl_value = data_low
            else
                read_map_tbl_value = (data_low - H8000_0000) and map_tbl_mask
            end If
        else
            read_map_tbl_value = data_low and map_tbl_mask
        end If
        read_def_up_value = rightShift(data_low, 24) and &H7
        read_stag_up_en_value = rightShift(data_low, 27) and &H1
        read_qtag_up_en_value = rightShift(data_low, 28) and &H1
        read_parse_qinq_value = rightShift(data_low, 29) and &H1
        read_parse_stag_value = rightShift(data_low, 30) and &H1
        read_parse_qtag_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_map_tbl_value = &H0
        flag_map_tbl        = &H0
        write_def_up_value = &H0
        flag_def_up        = &H0
        write_stag_up_en_value = &H0
        flag_stag_up_en        = &H0
        write_qtag_up_en_value = &H0
        flag_qtag_up_en        = &H0
        write_parse_qinq_value = &H0
        flag_parse_qinq        = &H0
        write_parse_stag_value = &H0
        flag_parse_stag        = &H0
        write_parse_qtag_value = &H0
        flag_parse_qtag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_pp_tags
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' qtag_value                                 [15:0]           get_qtag_value
''                                                             set_qtag_value
''                                                             read_qtag_value
''                                                             write_qtag_value
''---------------------------------------------------------------------------------
'' stag_value                                 [31:16]          get_stag_value
''                                                             set_stag_value
''                                                             read_stag_value
''                                                             write_stag_value
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_pp_tags
    Private write_qtag_value_value
    Private read_qtag_value_value
    Private flag_qtag_value
    Private write_stag_value_value
    Private read_stag_value_value
    Private flag_stag_value

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17904
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_qtag_value
        get_qtag_value = read_qtag_value_value
    End Property

    Property Let set_qtag_value(aData)
        write_qtag_value_value = aData
        flag_qtag_value        = &H1
    End Property

    Property Get read_qtag_value
        read
        read_qtag_value = read_qtag_value_value
    End Property

    Property Let write_qtag_value(aData)
        set_qtag_value = aData
        write
    End Property

    Property Get get_stag_value
        get_stag_value = read_stag_value_value
    End Property

    Property Let set_stag_value(aData)
        write_stag_value_value = aData
        flag_stag_value        = &H1
    End Property

    Property Get read_stag_value
        read
        read_stag_value = read_stag_value_value
    End Property

    Property Let write_stag_value(aData)
        set_stag_value = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        qtag_value_mask = &Hffff
        if data_low > LONG_MAX then
            if qtag_value_mask = mask then
                read_qtag_value_value = data_low
            else
                read_qtag_value_value = (data_low - H8000_0000) and qtag_value_mask
            end If
        else
            read_qtag_value_value = data_low and qtag_value_mask
        end If
        read_stag_value_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_qtag_value = &H0 or flag_stag_value = &H0 Then read
        If flag_qtag_value = &H0 Then write_qtag_value_value = get_qtag_value
        If flag_stag_value = &H0 Then write_stag_value_value = get_stag_value

        regValue = leftShift((write_qtag_value_value and &Hffff), 0) + leftShift((write_stag_value_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        qtag_value_mask = &Hffff
        if data_low > LONG_MAX then
            if qtag_value_mask = mask then
                read_qtag_value_value = data_low
            else
                read_qtag_value_value = (data_low - H8000_0000) and qtag_value_mask
            end If
        else
            read_qtag_value_value = data_low and qtag_value_mask
        end If
        read_stag_value_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_qtag_value_value = &H0
        flag_qtag_value        = &H0
        write_stag_value_value = &H0
        flag_stag_value        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_pp_tags2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' stag_value2                                [15:0]           get_stag_value2
''                                                             set_stag_value2
''                                                             read_stag_value2
''                                                             write_stag_value2
''---------------------------------------------------------------------------------
'' stag_value3                                [31:16]          get_stag_value3
''                                                             set_stag_value3
''                                                             read_stag_value3
''                                                             write_stag_value3
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_pp_tags2
    Private write_stag_value2_value
    Private read_stag_value2_value
    Private flag_stag_value2
    Private write_stag_value3_value
    Private read_stag_value3_value
    Private flag_stag_value3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17908
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_stag_value2
        get_stag_value2 = read_stag_value2_value
    End Property

    Property Let set_stag_value2(aData)
        write_stag_value2_value = aData
        flag_stag_value2        = &H1
    End Property

    Property Get read_stag_value2
        read
        read_stag_value2 = read_stag_value2_value
    End Property

    Property Let write_stag_value2(aData)
        set_stag_value2 = aData
        write
    End Property

    Property Get get_stag_value3
        get_stag_value3 = read_stag_value3_value
    End Property

    Property Let set_stag_value3(aData)
        write_stag_value3_value = aData
        flag_stag_value3        = &H1
    End Property

    Property Get read_stag_value3
        read
        read_stag_value3 = read_stag_value3_value
    End Property

    Property Let write_stag_value3(aData)
        set_stag_value3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        stag_value2_mask = &Hffff
        if data_low > LONG_MAX then
            if stag_value2_mask = mask then
                read_stag_value2_value = data_low
            else
                read_stag_value2_value = (data_low - H8000_0000) and stag_value2_mask
            end If
        else
            read_stag_value2_value = data_low and stag_value2_mask
        end If
        read_stag_value3_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_stag_value2 = &H0 or flag_stag_value3 = &H0 Then read
        If flag_stag_value2 = &H0 Then write_stag_value2_value = get_stag_value2
        If flag_stag_value3 = &H0 Then write_stag_value3_value = get_stag_value3

        regValue = leftShift((write_stag_value2_value and &Hffff), 0) + leftShift((write_stag_value3_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        stag_value2_mask = &Hffff
        if data_low > LONG_MAX then
            if stag_value2_mask = mask then
                read_stag_value2_value = data_low
            else
                read_stag_value2_value = (data_low - H8000_0000) and stag_value2_mask
            end If
        else
            read_stag_value2_value = data_low and stag_value2_mask
        end If
        read_stag_value3_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_stag_value2_value = &H0
        flag_stag_value2        = &H0
        write_stag_value3_value = &H0
        flag_stag_value3        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_cp_tag2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' map_tbl2                                   [23:0]           get_map_tbl2
''                                                             set_map_tbl2
''                                                             read_map_tbl2
''                                                             write_map_tbl2
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_cp_tag2
    Private write_map_tbl2_value
    Private read_map_tbl2_value
    Private flag_map_tbl2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1790c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_map_tbl2
        get_map_tbl2 = read_map_tbl2_value
    End Property

    Property Let set_map_tbl2(aData)
        write_map_tbl2_value = aData
        flag_map_tbl2        = &H1
    End Property

    Property Get read_map_tbl2
        read
        read_map_tbl2 = read_map_tbl2_value
    End Property

    Property Let write_map_tbl2(aData)
        set_map_tbl2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        map_tbl2_mask = &Hffffff
        if data_low > LONG_MAX then
            if map_tbl2_mask = mask then
                read_map_tbl2_value = data_low
            else
                read_map_tbl2_value = (data_low - H8000_0000) and map_tbl2_mask
            end If
        else
            read_map_tbl2_value = data_low and map_tbl2_mask
        end If

    End Sub

    Sub write
        If flag_map_tbl2 = &H0 Then read
        If flag_map_tbl2 = &H0 Then write_map_tbl2_value = get_map_tbl2

        regValue = leftShift((write_map_tbl2_value and &Hffffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        map_tbl2_mask = &Hffffff
        if data_low > LONG_MAX then
            if map_tbl2_mask = mask then
                read_map_tbl2_value = data_low
            else
                read_map_tbl2_value = (data_low - H8000_0000) and map_tbl2_mask
            end If
        else
            read_map_tbl2_value = data_low and map_tbl2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_map_tbl2_value = &H0
        flag_map_tbl2        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_pbb_etype
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' btag_etype                                 [15:0]           get_btag_etype
''                                                             set_btag_etype
''                                                             read_btag_etype
''                                                             write_btag_etype
''---------------------------------------------------------------------------------
'' itag_etype                                 [31:16]          get_itag_etype
''                                                             set_itag_etype
''                                                             read_itag_etype
''                                                             write_itag_etype
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_pbb_etype
    Private write_btag_etype_value
    Private read_btag_etype_value
    Private flag_btag_etype
    Private write_itag_etype_value
    Private read_itag_etype_value
    Private flag_itag_etype

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17910
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_btag_etype
        get_btag_etype = read_btag_etype_value
    End Property

    Property Let set_btag_etype(aData)
        write_btag_etype_value = aData
        flag_btag_etype        = &H1
    End Property

    Property Get read_btag_etype
        read
        read_btag_etype = read_btag_etype_value
    End Property

    Property Let write_btag_etype(aData)
        set_btag_etype = aData
        write
    End Property

    Property Get get_itag_etype
        get_itag_etype = read_itag_etype_value
    End Property

    Property Let set_itag_etype(aData)
        write_itag_etype_value = aData
        flag_itag_etype        = &H1
    End Property

    Property Get read_itag_etype
        read
        read_itag_etype = read_itag_etype_value
    End Property

    Property Let write_itag_etype(aData)
        set_itag_etype = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        btag_etype_mask = &Hffff
        if data_low > LONG_MAX then
            if btag_etype_mask = mask then
                read_btag_etype_value = data_low
            else
                read_btag_etype_value = (data_low - H8000_0000) and btag_etype_mask
            end If
        else
            read_btag_etype_value = data_low and btag_etype_mask
        end If
        read_itag_etype_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_btag_etype = &H0 or flag_itag_etype = &H0 Then read
        If flag_btag_etype = &H0 Then write_btag_etype_value = get_btag_etype
        If flag_itag_etype = &H0 Then write_itag_etype_value = get_itag_etype

        regValue = leftShift((write_btag_etype_value and &Hffff), 0) + leftShift((write_itag_etype_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        btag_etype_mask = &Hffff
        if data_low > LONG_MAX then
            if btag_etype_mask = mask then
                read_btag_etype_value = data_low
            else
                read_btag_etype_value = (data_low - H8000_0000) and btag_etype_mask
            end If
        else
            read_btag_etype_value = data_low and btag_etype_mask
        end If
        read_itag_etype_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_btag_etype_value = &H0
        flag_btag_etype        = &H0
        write_itag_etype_value = &H0
        flag_itag_etype        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_pbb_enb_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' parse_pbb                                  [24:24]          get_parse_pbb
''                                                             set_parse_pbb
''                                                             read_parse_pbb
''                                                             write_parse_pbb
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_pbb_enb_select
    Private write_parse_pbb_value
    Private read_parse_pbb_value
    Private flag_parse_pbb

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17914
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_parse_pbb
        get_parse_pbb = read_parse_pbb_value
    End Property

    Property Let set_parse_pbb(aData)
        write_parse_pbb_value = aData
        flag_parse_pbb        = &H1
    End Property

    Property Get read_parse_pbb
        read
        read_parse_pbb = read_parse_pbb_value
    End Property

    Property Let write_parse_pbb(aData)
        set_parse_pbb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_parse_pbb_value = rightShift(data_low, 24) and &H1

    End Sub

    Sub write
        If flag_parse_pbb = &H0 Then read
        If flag_parse_pbb = &H0 Then write_parse_pbb_value = get_parse_pbb

        regValue = leftShift((write_parse_pbb_value and &H1), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_parse_pbb_value = rightShift(data_low, 24) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_parse_pbb_value = &H0
        flag_parse_pbb        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_st_vlan_etype
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' special_tpid                               [15:0]           get_special_tpid
''                                                             set_special_tpid
''                                                             read_special_tpid
''                                                             write_special_tpid
''---------------------------------------------------------------------------------
'' parse_st_vlan                              [31:31]          get_parse_st_vlan
''                                                             set_parse_st_vlan
''                                                             read_parse_st_vlan
''                                                             write_parse_st_vlan
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_st_vlan_etype
    Private write_special_tpid_value
    Private read_special_tpid_value
    Private flag_special_tpid
    Private write_parse_st_vlan_value
    Private read_parse_st_vlan_value
    Private flag_parse_st_vlan

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17918
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_special_tpid
        get_special_tpid = read_special_tpid_value
    End Property

    Property Let set_special_tpid(aData)
        write_special_tpid_value = aData
        flag_special_tpid        = &H1
    End Property

    Property Get read_special_tpid
        read
        read_special_tpid = read_special_tpid_value
    End Property

    Property Let write_special_tpid(aData)
        set_special_tpid = aData
        write
    End Property

    Property Get get_parse_st_vlan
        get_parse_st_vlan = read_parse_st_vlan_value
    End Property

    Property Let set_parse_st_vlan(aData)
        write_parse_st_vlan_value = aData
        flag_parse_st_vlan        = &H1
    End Property

    Property Get read_parse_st_vlan
        read
        read_parse_st_vlan = read_parse_st_vlan_value
    End Property

    Property Let write_parse_st_vlan(aData)
        set_parse_st_vlan = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        special_tpid_mask = &Hffff
        if data_low > LONG_MAX then
            if special_tpid_mask = mask then
                read_special_tpid_value = data_low
            else
                read_special_tpid_value = (data_low - H8000_0000) and special_tpid_mask
            end If
        else
            read_special_tpid_value = data_low and special_tpid_mask
        end If
        read_parse_st_vlan_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_special_tpid = &H0 or flag_parse_st_vlan = &H0 Then read
        If flag_special_tpid = &H0 Then write_special_tpid_value = get_special_tpid
        If flag_parse_st_vlan = &H0 Then write_parse_st_vlan_value = get_parse_st_vlan

        regValue = leftShift((write_special_tpid_value and &Hffff), 0) + leftShift((write_parse_st_vlan_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        special_tpid_mask = &Hffff
        if data_low > LONG_MAX then
            if special_tpid_mask = mask then
                read_special_tpid_value = data_low
            else
                read_special_tpid_value = (data_low - H8000_0000) and special_tpid_mask
            end If
        else
            read_special_tpid_value = data_low and special_tpid_mask
        end If
        read_parse_st_vlan_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_special_tpid_value = &H0
        flag_special_tpid        = &H0
        write_parse_st_vlan_value = &H0
        flag_parse_st_vlan        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_egress_hdr_etype
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' egress_hdr_etype                           [15:0]           get_egress_hdr_etype
''                                                             set_egress_hdr_etype
''                                                             read_egress_hdr_etype
''                                                             write_egress_hdr_etype
''---------------------------------------------------------------------------------
'' enable                                     [31:31]          get_enable
''                                                             set_enable
''                                                             read_enable
''                                                             write_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_egress_hdr_etype
    Private write_egress_hdr_etype_value
    Private read_egress_hdr_etype_value
    Private flag_egress_hdr_etype
    Private write_enable_value
    Private read_enable_value
    Private flag_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1791c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_egress_hdr_etype
        get_egress_hdr_etype = read_egress_hdr_etype_value
    End Property

    Property Let set_egress_hdr_etype(aData)
        write_egress_hdr_etype_value = aData
        flag_egress_hdr_etype        = &H1
    End Property

    Property Get read_egress_hdr_etype
        read
        read_egress_hdr_etype = read_egress_hdr_etype_value
    End Property

    Property Let write_egress_hdr_etype(aData)
        set_egress_hdr_etype = aData
        write
    End Property

    Property Get get_enable
        get_enable = read_enable_value
    End Property

    Property Let set_enable(aData)
        write_enable_value = aData
        flag_enable        = &H1
    End Property

    Property Get read_enable
        read
        read_enable = read_enable_value
    End Property

    Property Let write_enable(aData)
        set_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        egress_hdr_etype_mask = &Hffff
        if data_low > LONG_MAX then
            if egress_hdr_etype_mask = mask then
                read_egress_hdr_etype_value = data_low
            else
                read_egress_hdr_etype_value = (data_low - H8000_0000) and egress_hdr_etype_mask
            end If
        else
            read_egress_hdr_etype_value = data_low and egress_hdr_etype_mask
        end If
        read_enable_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_egress_hdr_etype = &H0 or flag_enable = &H0 Then read
        If flag_egress_hdr_etype = &H0 Then write_egress_hdr_etype_value = get_egress_hdr_etype
        If flag_enable = &H0 Then write_enable_value = get_enable

        regValue = leftShift((write_egress_hdr_etype_value and &Hffff), 0) + leftShift((write_enable_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        egress_hdr_etype_mask = &Hffff
        if data_low > LONG_MAX then
            if egress_hdr_etype_mask = mask then
                read_egress_hdr_etype_value = data_low
            else
                read_egress_hdr_etype_value = (data_low - H8000_0000) and egress_hdr_etype_mask
            end If
        else
            read_egress_hdr_etype_value = data_low and egress_hdr_etype_mask
        end If
        read_enable_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_egress_hdr_etype_value = &H0
        flag_egress_hdr_etype        = &H0
        write_enable_value = &H0
        flag_enable        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_etype1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mpls_etype1                                [15:0]           get_mpls_etype1
''                                                             set_mpls_etype1
''                                                             read_mpls_etype1
''                                                             write_mpls_etype1
''---------------------------------------------------------------------------------
'' mpls_etype2                                [31:16]          get_mpls_etype2
''                                                             set_mpls_etype2
''                                                             read_mpls_etype2
''                                                             write_mpls_etype2
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_etype1
    Private write_mpls_etype1_value
    Private read_mpls_etype1_value
    Private flag_mpls_etype1
    Private write_mpls_etype2_value
    Private read_mpls_etype2_value
    Private flag_mpls_etype2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17920
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mpls_etype1
        get_mpls_etype1 = read_mpls_etype1_value
    End Property

    Property Let set_mpls_etype1(aData)
        write_mpls_etype1_value = aData
        flag_mpls_etype1        = &H1
    End Property

    Property Get read_mpls_etype1
        read
        read_mpls_etype1 = read_mpls_etype1_value
    End Property

    Property Let write_mpls_etype1(aData)
        set_mpls_etype1 = aData
        write
    End Property

    Property Get get_mpls_etype2
        get_mpls_etype2 = read_mpls_etype2_value
    End Property

    Property Let set_mpls_etype2(aData)
        write_mpls_etype2_value = aData
        flag_mpls_etype2        = &H1
    End Property

    Property Get read_mpls_etype2
        read
        read_mpls_etype2 = read_mpls_etype2_value
    End Property

    Property Let write_mpls_etype2(aData)
        set_mpls_etype2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mpls_etype1_mask = &Hffff
        if data_low > LONG_MAX then
            if mpls_etype1_mask = mask then
                read_mpls_etype1_value = data_low
            else
                read_mpls_etype1_value = (data_low - H8000_0000) and mpls_etype1_mask
            end If
        else
            read_mpls_etype1_value = data_low and mpls_etype1_mask
        end If
        read_mpls_etype2_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mpls_etype1 = &H0 or flag_mpls_etype2 = &H0 Then read
        If flag_mpls_etype1 = &H0 Then write_mpls_etype1_value = get_mpls_etype1
        If flag_mpls_etype2 = &H0 Then write_mpls_etype2_value = get_mpls_etype2

        regValue = leftShift((write_mpls_etype1_value and &Hffff), 0) + leftShift((write_mpls_etype2_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mpls_etype1_mask = &Hffff
        if data_low > LONG_MAX then
            if mpls_etype1_mask = mask then
                read_mpls_etype1_value = data_low
            else
                read_mpls_etype1_value = (data_low - H8000_0000) and mpls_etype1_mask
            end If
        else
            read_mpls_etype1_value = data_low and mpls_etype1_mask
        end If
        read_mpls_etype2_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mpls_etype1_value = &H0
        flag_mpls_etype1        = &H0
        write_mpls_etype2_value = &H0
        flag_mpls_etype2        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_etype2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mpls_etype3                                [15:0]           get_mpls_etype3
''                                                             set_mpls_etype3
''                                                             read_mpls_etype3
''                                                             write_mpls_etype3
''---------------------------------------------------------------------------------
'' mpls_etype4                                [31:16]          get_mpls_etype4
''                                                             set_mpls_etype4
''                                                             read_mpls_etype4
''                                                             write_mpls_etype4
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_etype2
    Private write_mpls_etype3_value
    Private read_mpls_etype3_value
    Private flag_mpls_etype3
    Private write_mpls_etype4_value
    Private read_mpls_etype4_value
    Private flag_mpls_etype4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17924
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mpls_etype3
        get_mpls_etype3 = read_mpls_etype3_value
    End Property

    Property Let set_mpls_etype3(aData)
        write_mpls_etype3_value = aData
        flag_mpls_etype3        = &H1
    End Property

    Property Get read_mpls_etype3
        read
        read_mpls_etype3 = read_mpls_etype3_value
    End Property

    Property Let write_mpls_etype3(aData)
        set_mpls_etype3 = aData
        write
    End Property

    Property Get get_mpls_etype4
        get_mpls_etype4 = read_mpls_etype4_value
    End Property

    Property Let set_mpls_etype4(aData)
        write_mpls_etype4_value = aData
        flag_mpls_etype4        = &H1
    End Property

    Property Get read_mpls_etype4
        read
        read_mpls_etype4 = read_mpls_etype4_value
    End Property

    Property Let write_mpls_etype4(aData)
        set_mpls_etype4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mpls_etype3_mask = &Hffff
        if data_low > LONG_MAX then
            if mpls_etype3_mask = mask then
                read_mpls_etype3_value = data_low
            else
                read_mpls_etype3_value = (data_low - H8000_0000) and mpls_etype3_mask
            end If
        else
            read_mpls_etype3_value = data_low and mpls_etype3_mask
        end If
        read_mpls_etype4_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mpls_etype3 = &H0 or flag_mpls_etype4 = &H0 Then read
        If flag_mpls_etype3 = &H0 Then write_mpls_etype3_value = get_mpls_etype3
        If flag_mpls_etype4 = &H0 Then write_mpls_etype4_value = get_mpls_etype4

        regValue = leftShift((write_mpls_etype3_value and &Hffff), 0) + leftShift((write_mpls_etype4_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mpls_etype3_mask = &Hffff
        if data_low > LONG_MAX then
            if mpls_etype3_mask = mask then
                read_mpls_etype3_value = data_low
            else
                read_mpls_etype3_value = (data_low - H8000_0000) and mpls_etype3_mask
            end If
        else
            read_mpls_etype3_value = data_low and mpls_etype3_mask
        end If
        read_mpls_etype4_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mpls_etype3_value = &H0
        flag_mpls_etype3        = &H0
        write_mpls_etype4_value = &H0
        flag_mpls_etype4        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_enb_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mpls3_select1                              [1:0]            get_mpls3_select1
''                                                             set_mpls3_select1
''                                                             read_mpls3_select1
''                                                             write_mpls3_select1
''---------------------------------------------------------------------------------
'' mpls3_select2                              [3:2]            get_mpls3_select2
''                                                             set_mpls3_select2
''                                                             read_mpls3_select2
''                                                             write_mpls3_select2
''---------------------------------------------------------------------------------
'' mpls4_select1                              [5:4]            get_mpls4_select1
''                                                             set_mpls4_select1
''                                                             read_mpls4_select1
''                                                             write_mpls4_select1
''---------------------------------------------------------------------------------
'' mpls4_select2                              [7:6]            get_mpls4_select2
''                                                             set_mpls4_select2
''                                                             read_mpls4_select2
''                                                             write_mpls4_select2
''---------------------------------------------------------------------------------
'' mpls5_select1                              [10:8]           get_mpls5_select1
''                                                             set_mpls5_select1
''                                                             read_mpls5_select1
''                                                             write_mpls5_select1
''---------------------------------------------------------------------------------
'' mpls5_select2                              [13:11]          get_mpls5_select2
''                                                             set_mpls5_select2
''                                                             read_mpls5_select2
''                                                             write_mpls5_select2
''---------------------------------------------------------------------------------
'' bmpls_parse_gt5lbl                         [15:15]          get_bmpls_parse_gt5lbl
''                                                             set_bmpls_parse_gt5lbl
''                                                             read_bmpls_parse_gt5lbl
''                                                             write_bmpls_parse_gt5lbl
''---------------------------------------------------------------------------------
'' parse_mpls1                                [24:24]          get_parse_mpls1
''                                                             set_parse_mpls1
''                                                             read_parse_mpls1
''                                                             write_parse_mpls1
''---------------------------------------------------------------------------------
'' parse_mpls2                                [25:25]          get_parse_mpls2
''                                                             set_parse_mpls2
''                                                             read_parse_mpls2
''                                                             write_parse_mpls2
''---------------------------------------------------------------------------------
'' parse_mpls3                                [26:26]          get_parse_mpls3
''                                                             set_parse_mpls3
''                                                             read_parse_mpls3
''                                                             write_parse_mpls3
''---------------------------------------------------------------------------------
'' parse_mpls4                                [27:27]          get_parse_mpls4
''                                                             set_parse_mpls4
''                                                             read_parse_mpls4
''                                                             write_parse_mpls4
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_enb_select
    Private write_mpls3_select1_value
    Private read_mpls3_select1_value
    Private flag_mpls3_select1
    Private write_mpls3_select2_value
    Private read_mpls3_select2_value
    Private flag_mpls3_select2
    Private write_mpls4_select1_value
    Private read_mpls4_select1_value
    Private flag_mpls4_select1
    Private write_mpls4_select2_value
    Private read_mpls4_select2_value
    Private flag_mpls4_select2
    Private write_mpls5_select1_value
    Private read_mpls5_select1_value
    Private flag_mpls5_select1
    Private write_mpls5_select2_value
    Private read_mpls5_select2_value
    Private flag_mpls5_select2
    Private write_bmpls_parse_gt5lbl_value
    Private read_bmpls_parse_gt5lbl_value
    Private flag_bmpls_parse_gt5lbl
    Private write_parse_mpls1_value
    Private read_parse_mpls1_value
    Private flag_parse_mpls1
    Private write_parse_mpls2_value
    Private read_parse_mpls2_value
    Private flag_parse_mpls2
    Private write_parse_mpls3_value
    Private read_parse_mpls3_value
    Private flag_parse_mpls3
    Private write_parse_mpls4_value
    Private read_parse_mpls4_value
    Private flag_parse_mpls4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1792c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mpls3_select1
        get_mpls3_select1 = read_mpls3_select1_value
    End Property

    Property Let set_mpls3_select1(aData)
        write_mpls3_select1_value = aData
        flag_mpls3_select1        = &H1
    End Property

    Property Get read_mpls3_select1
        read
        read_mpls3_select1 = read_mpls3_select1_value
    End Property

    Property Let write_mpls3_select1(aData)
        set_mpls3_select1 = aData
        write
    End Property

    Property Get get_mpls3_select2
        get_mpls3_select2 = read_mpls3_select2_value
    End Property

    Property Let set_mpls3_select2(aData)
        write_mpls3_select2_value = aData
        flag_mpls3_select2        = &H1
    End Property

    Property Get read_mpls3_select2
        read
        read_mpls3_select2 = read_mpls3_select2_value
    End Property

    Property Let write_mpls3_select2(aData)
        set_mpls3_select2 = aData
        write
    End Property

    Property Get get_mpls4_select1
        get_mpls4_select1 = read_mpls4_select1_value
    End Property

    Property Let set_mpls4_select1(aData)
        write_mpls4_select1_value = aData
        flag_mpls4_select1        = &H1
    End Property

    Property Get read_mpls4_select1
        read
        read_mpls4_select1 = read_mpls4_select1_value
    End Property

    Property Let write_mpls4_select1(aData)
        set_mpls4_select1 = aData
        write
    End Property

    Property Get get_mpls4_select2
        get_mpls4_select2 = read_mpls4_select2_value
    End Property

    Property Let set_mpls4_select2(aData)
        write_mpls4_select2_value = aData
        flag_mpls4_select2        = &H1
    End Property

    Property Get read_mpls4_select2
        read
        read_mpls4_select2 = read_mpls4_select2_value
    End Property

    Property Let write_mpls4_select2(aData)
        set_mpls4_select2 = aData
        write
    End Property

    Property Get get_mpls5_select1
        get_mpls5_select1 = read_mpls5_select1_value
    End Property

    Property Let set_mpls5_select1(aData)
        write_mpls5_select1_value = aData
        flag_mpls5_select1        = &H1
    End Property

    Property Get read_mpls5_select1
        read
        read_mpls5_select1 = read_mpls5_select1_value
    End Property

    Property Let write_mpls5_select1(aData)
        set_mpls5_select1 = aData
        write
    End Property

    Property Get get_mpls5_select2
        get_mpls5_select2 = read_mpls5_select2_value
    End Property

    Property Let set_mpls5_select2(aData)
        write_mpls5_select2_value = aData
        flag_mpls5_select2        = &H1
    End Property

    Property Get read_mpls5_select2
        read
        read_mpls5_select2 = read_mpls5_select2_value
    End Property

    Property Let write_mpls5_select2(aData)
        set_mpls5_select2 = aData
        write
    End Property

    Property Get get_bmpls_parse_gt5lbl
        get_bmpls_parse_gt5lbl = read_bmpls_parse_gt5lbl_value
    End Property

    Property Let set_bmpls_parse_gt5lbl(aData)
        write_bmpls_parse_gt5lbl_value = aData
        flag_bmpls_parse_gt5lbl        = &H1
    End Property

    Property Get read_bmpls_parse_gt5lbl
        read
        read_bmpls_parse_gt5lbl = read_bmpls_parse_gt5lbl_value
    End Property

    Property Let write_bmpls_parse_gt5lbl(aData)
        set_bmpls_parse_gt5lbl = aData
        write
    End Property

    Property Get get_parse_mpls1
        get_parse_mpls1 = read_parse_mpls1_value
    End Property

    Property Let set_parse_mpls1(aData)
        write_parse_mpls1_value = aData
        flag_parse_mpls1        = &H1
    End Property

    Property Get read_parse_mpls1
        read
        read_parse_mpls1 = read_parse_mpls1_value
    End Property

    Property Let write_parse_mpls1(aData)
        set_parse_mpls1 = aData
        write
    End Property

    Property Get get_parse_mpls2
        get_parse_mpls2 = read_parse_mpls2_value
    End Property

    Property Let set_parse_mpls2(aData)
        write_parse_mpls2_value = aData
        flag_parse_mpls2        = &H1
    End Property

    Property Get read_parse_mpls2
        read
        read_parse_mpls2 = read_parse_mpls2_value
    End Property

    Property Let write_parse_mpls2(aData)
        set_parse_mpls2 = aData
        write
    End Property

    Property Get get_parse_mpls3
        get_parse_mpls3 = read_parse_mpls3_value
    End Property

    Property Let set_parse_mpls3(aData)
        write_parse_mpls3_value = aData
        flag_parse_mpls3        = &H1
    End Property

    Property Get read_parse_mpls3
        read
        read_parse_mpls3 = read_parse_mpls3_value
    End Property

    Property Let write_parse_mpls3(aData)
        set_parse_mpls3 = aData
        write
    End Property

    Property Get get_parse_mpls4
        get_parse_mpls4 = read_parse_mpls4_value
    End Property

    Property Let set_parse_mpls4(aData)
        write_parse_mpls4_value = aData
        flag_parse_mpls4        = &H1
    End Property

    Property Get read_parse_mpls4
        read
        read_parse_mpls4 = read_parse_mpls4_value
    End Property

    Property Let write_parse_mpls4(aData)
        set_parse_mpls4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mpls3_select1_mask = &H3
        if data_low > LONG_MAX then
            if mpls3_select1_mask = mask then
                read_mpls3_select1_value = data_low
            else
                read_mpls3_select1_value = (data_low - H8000_0000) and mpls3_select1_mask
            end If
        else
            read_mpls3_select1_value = data_low and mpls3_select1_mask
        end If
        read_mpls3_select2_value = rightShift(data_low, 2) and &H3
        read_mpls4_select1_value = rightShift(data_low, 4) and &H3
        read_mpls4_select2_value = rightShift(data_low, 6) and &H3
        read_mpls5_select1_value = rightShift(data_low, 8) and &H7
        read_mpls5_select2_value = rightShift(data_low, 11) and &H7
        read_bmpls_parse_gt5lbl_value = rightShift(data_low, 15) and &H1
        read_parse_mpls1_value = rightShift(data_low, 24) and &H1
        read_parse_mpls2_value = rightShift(data_low, 25) and &H1
        read_parse_mpls3_value = rightShift(data_low, 26) and &H1
        read_parse_mpls4_value = rightShift(data_low, 27) and &H1

    End Sub

    Sub write
        If flag_mpls3_select1 = &H0 or flag_mpls3_select2 = &H0 or flag_mpls4_select1 = &H0 or flag_mpls4_select2 = &H0 or flag_mpls5_select1 = &H0 or flag_mpls5_select2 = &H0 or flag_bmpls_parse_gt5lbl = &H0 or flag_parse_mpls1 = &H0 or flag_parse_mpls2 = &H0 or flag_parse_mpls3 = &H0 or flag_parse_mpls4 = &H0 Then read
        If flag_mpls3_select1 = &H0 Then write_mpls3_select1_value = get_mpls3_select1
        If flag_mpls3_select2 = &H0 Then write_mpls3_select2_value = get_mpls3_select2
        If flag_mpls4_select1 = &H0 Then write_mpls4_select1_value = get_mpls4_select1
        If flag_mpls4_select2 = &H0 Then write_mpls4_select2_value = get_mpls4_select2
        If flag_mpls5_select1 = &H0 Then write_mpls5_select1_value = get_mpls5_select1
        If flag_mpls5_select2 = &H0 Then write_mpls5_select2_value = get_mpls5_select2
        If flag_bmpls_parse_gt5lbl = &H0 Then write_bmpls_parse_gt5lbl_value = get_bmpls_parse_gt5lbl
        If flag_parse_mpls1 = &H0 Then write_parse_mpls1_value = get_parse_mpls1
        If flag_parse_mpls2 = &H0 Then write_parse_mpls2_value = get_parse_mpls2
        If flag_parse_mpls3 = &H0 Then write_parse_mpls3_value = get_parse_mpls3
        If flag_parse_mpls4 = &H0 Then write_parse_mpls4_value = get_parse_mpls4

        regValue = leftShift((write_mpls3_select1_value and &H3), 0) + leftShift((write_mpls3_select2_value and &H3), 2) + leftShift((write_mpls4_select1_value and &H3), 4) + leftShift((write_mpls4_select2_value and &H3), 6) + leftShift((write_mpls5_select1_value and &H7), 8) + leftShift((write_mpls5_select2_value and &H7), 11) + leftShift((write_bmpls_parse_gt5lbl_value and &H1), 15) + leftShift((write_parse_mpls1_value and &H1), 24) + leftShift((write_parse_mpls2_value and &H1), 25) + leftShift((write_parse_mpls3_value and &H1), 26) + leftShift((write_parse_mpls4_value and &H1), 27)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mpls3_select1_mask = &H3
        if data_low > LONG_MAX then
            if mpls3_select1_mask = mask then
                read_mpls3_select1_value = data_low
            else
                read_mpls3_select1_value = (data_low - H8000_0000) and mpls3_select1_mask
            end If
        else
            read_mpls3_select1_value = data_low and mpls3_select1_mask
        end If
        read_mpls3_select2_value = rightShift(data_low, 2) and &H3
        read_mpls4_select1_value = rightShift(data_low, 4) and &H3
        read_mpls4_select2_value = rightShift(data_low, 6) and &H3
        read_mpls5_select1_value = rightShift(data_low, 8) and &H7
        read_mpls5_select2_value = rightShift(data_low, 11) and &H7
        read_bmpls_parse_gt5lbl_value = rightShift(data_low, 15) and &H1
        read_parse_mpls1_value = rightShift(data_low, 24) and &H1
        read_parse_mpls2_value = rightShift(data_low, 25) and &H1
        read_parse_mpls3_value = rightShift(data_low, 26) and &H1
        read_parse_mpls4_value = rightShift(data_low, 27) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mpls3_select1_value = &H0
        flag_mpls3_select1        = &H0
        write_mpls3_select2_value = &H0
        flag_mpls3_select2        = &H0
        write_mpls4_select1_value = &H0
        flag_mpls4_select1        = &H0
        write_mpls4_select2_value = &H0
        flag_mpls4_select2        = &H0
        write_mpls5_select1_value = &H0
        flag_mpls5_select1        = &H0
        write_mpls5_select2_value = &H0
        flag_mpls5_select2        = &H0
        write_bmpls_parse_gt5lbl_value = &H0
        flag_bmpls_parse_gt5lbl        = &H0
        write_parse_mpls1_value = &H0
        flag_parse_mpls1        = &H0
        write_parse_mpls2_value = &H0
        flag_parse_mpls2        = &H0
        write_parse_mpls3_value = &H0
        flag_parse_mpls3        = &H0
        write_parse_mpls4_value = &H0
        flag_parse_mpls4        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_cp_etype_max_len
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' etype_max_len                              [15:0]           get_etype_max_len
''                                                             set_etype_max_len
''                                                             read_etype_max_len
''                                                             write_etype_max_len
''---------------------------------------------------------------------------------
'' enable                                     [31:31]          get_enable
''                                                             set_enable
''                                                             read_enable
''                                                             write_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_cp_etype_max_len
    Private write_etype_max_len_value
    Private read_etype_max_len_value
    Private flag_etype_max_len
    Private write_enable_value
    Private read_enable_value
    Private flag_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17930
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_etype_max_len
        get_etype_max_len = read_etype_max_len_value
    End Property

    Property Let set_etype_max_len(aData)
        write_etype_max_len_value = aData
        flag_etype_max_len        = &H1
    End Property

    Property Get read_etype_max_len
        read
        read_etype_max_len = read_etype_max_len_value
    End Property

    Property Let write_etype_max_len(aData)
        set_etype_max_len = aData
        write
    End Property

    Property Get get_enable
        get_enable = read_enable_value
    End Property

    Property Let set_enable(aData)
        write_enable_value = aData
        flag_enable        = &H1
    End Property

    Property Get read_enable
        read
        read_enable = read_enable_value
    End Property

    Property Let write_enable(aData)
        set_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        etype_max_len_mask = &Hffff
        if data_low > LONG_MAX then
            if etype_max_len_mask = mask then
                read_etype_max_len_value = data_low
            else
                read_etype_max_len_value = (data_low - H8000_0000) and etype_max_len_mask
            end If
        else
            read_etype_max_len_value = data_low and etype_max_len_mask
        end If
        read_enable_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_etype_max_len = &H0 or flag_enable = &H0 Then read
        If flag_etype_max_len = &H0 Then write_etype_max_len_value = get_etype_max_len
        If flag_enable = &H0 Then write_enable_value = get_enable

        regValue = leftShift((write_etype_max_len_value and &Hffff), 0) + leftShift((write_enable_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        etype_max_len_mask = &Hffff
        if data_low > LONG_MAX then
            if etype_max_len_mask = mask then
                read_etype_max_len_value = data_low
            else
                read_etype_max_len_value = (data_low - H8000_0000) and etype_max_len_mask
            end If
        else
            read_etype_max_len_value = data_low and etype_max_len_mask
        end If
        read_enable_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_etype_max_len_value = &H0
        flag_etype_max_len        = &H0
        write_enable_value = &H0
        flag_enable        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_cp_etype_jumbo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' etype_jumbo                                [15:0]           get_etype_jumbo
''                                                             set_etype_jumbo
''                                                             read_etype_jumbo
''                                                             write_etype_jumbo
''---------------------------------------------------------------------------------
'' enable                                     [31:31]          get_enable
''                                                             set_enable
''                                                             read_enable
''                                                             write_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_cp_etype_jumbo
    Private write_etype_jumbo_value
    Private read_etype_jumbo_value
    Private flag_etype_jumbo
    Private write_enable_value
    Private read_enable_value
    Private flag_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17934
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_etype_jumbo
        get_etype_jumbo = read_etype_jumbo_value
    End Property

    Property Let set_etype_jumbo(aData)
        write_etype_jumbo_value = aData
        flag_etype_jumbo        = &H1
    End Property

    Property Get read_etype_jumbo
        read
        read_etype_jumbo = read_etype_jumbo_value
    End Property

    Property Let write_etype_jumbo(aData)
        set_etype_jumbo = aData
        write
    End Property

    Property Get get_enable
        get_enable = read_enable_value
    End Property

    Property Let set_enable(aData)
        write_enable_value = aData
        flag_enable        = &H1
    End Property

    Property Get read_enable
        read
        read_enable = read_enable_value
    End Property

    Property Let write_enable(aData)
        set_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        etype_jumbo_mask = &Hffff
        if data_low > LONG_MAX then
            if etype_jumbo_mask = mask then
                read_etype_jumbo_value = data_low
            else
                read_etype_jumbo_value = (data_low - H8000_0000) and etype_jumbo_mask
            end If
        else
            read_etype_jumbo_value = data_low and etype_jumbo_mask
        end If
        read_enable_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_etype_jumbo = &H0 or flag_enable = &H0 Then read
        If flag_etype_jumbo = &H0 Then write_etype_jumbo_value = get_etype_jumbo
        If flag_enable = &H0 Then write_enable_value = get_enable

        regValue = leftShift((write_etype_jumbo_value and &Hffff), 0) + leftShift((write_enable_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        etype_jumbo_mask = &Hffff
        if data_low > LONG_MAX then
            if etype_jumbo_mask = mask then
                read_etype_jumbo_value = data_low
            else
                read_etype_jumbo_value = (data_low - H8000_0000) and etype_jumbo_mask
            end If
        else
            read_etype_jumbo_value = data_low and etype_jumbo_mask
        end If
        read_enable_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_etype_jumbo_value = &H0
        flag_etype_jumbo        = &H0
        write_enable_value = &H0
        flag_enable        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_llc_snap_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' snap_value                                 [23:0]           get_snap_value
''                                                             set_snap_value
''                                                             read_snap_value
''                                                             write_snap_value
''---------------------------------------------------------------------------------
'' force_snap_eth                             [29:29]          get_force_snap_eth
''                                                             set_force_snap_eth
''                                                             read_force_snap_eth
''                                                             write_force_snap_eth
''---------------------------------------------------------------------------------
'' parse_snap_eth                             [30:30]          get_parse_snap_eth
''                                                             set_parse_snap_eth
''                                                             read_parse_snap_eth
''                                                             write_parse_snap_eth
''---------------------------------------------------------------------------------
'' parse_snap                                 [31:31]          get_parse_snap
''                                                             set_parse_snap
''                                                             read_parse_snap
''                                                             write_parse_snap
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_llc_snap_value
    Private write_snap_value_value
    Private read_snap_value_value
    Private flag_snap_value
    Private write_force_snap_eth_value
    Private read_force_snap_eth_value
    Private flag_force_snap_eth
    Private write_parse_snap_eth_value
    Private read_parse_snap_eth_value
    Private flag_parse_snap_eth
    Private write_parse_snap_value
    Private read_parse_snap_value
    Private flag_parse_snap

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17938
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_snap_value
        get_snap_value = read_snap_value_value
    End Property

    Property Let set_snap_value(aData)
        write_snap_value_value = aData
        flag_snap_value        = &H1
    End Property

    Property Get read_snap_value
        read
        read_snap_value = read_snap_value_value
    End Property

    Property Let write_snap_value(aData)
        set_snap_value = aData
        write
    End Property

    Property Get get_force_snap_eth
        get_force_snap_eth = read_force_snap_eth_value
    End Property

    Property Let set_force_snap_eth(aData)
        write_force_snap_eth_value = aData
        flag_force_snap_eth        = &H1
    End Property

    Property Get read_force_snap_eth
        read
        read_force_snap_eth = read_force_snap_eth_value
    End Property

    Property Let write_force_snap_eth(aData)
        set_force_snap_eth = aData
        write
    End Property

    Property Get get_parse_snap_eth
        get_parse_snap_eth = read_parse_snap_eth_value
    End Property

    Property Let set_parse_snap_eth(aData)
        write_parse_snap_eth_value = aData
        flag_parse_snap_eth        = &H1
    End Property

    Property Get read_parse_snap_eth
        read
        read_parse_snap_eth = read_parse_snap_eth_value
    End Property

    Property Let write_parse_snap_eth(aData)
        set_parse_snap_eth = aData
        write
    End Property

    Property Get get_parse_snap
        get_parse_snap = read_parse_snap_value
    End Property

    Property Let set_parse_snap(aData)
        write_parse_snap_value = aData
        flag_parse_snap        = &H1
    End Property

    Property Get read_parse_snap
        read
        read_parse_snap = read_parse_snap_value
    End Property

    Property Let write_parse_snap(aData)
        set_parse_snap = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        snap_value_mask = &Hffffff
        if data_low > LONG_MAX then
            if snap_value_mask = mask then
                read_snap_value_value = data_low
            else
                read_snap_value_value = (data_low - H8000_0000) and snap_value_mask
            end If
        else
            read_snap_value_value = data_low and snap_value_mask
        end If
        read_force_snap_eth_value = rightShift(data_low, 29) and &H1
        read_parse_snap_eth_value = rightShift(data_low, 30) and &H1
        read_parse_snap_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_snap_value = &H0 or flag_force_snap_eth = &H0 or flag_parse_snap_eth = &H0 or flag_parse_snap = &H0 Then read
        If flag_snap_value = &H0 Then write_snap_value_value = get_snap_value
        If flag_force_snap_eth = &H0 Then write_force_snap_eth_value = get_force_snap_eth
        If flag_parse_snap_eth = &H0 Then write_parse_snap_eth_value = get_parse_snap_eth
        If flag_parse_snap = &H0 Then write_parse_snap_value = get_parse_snap

        regValue = leftShift((write_snap_value_value and &Hffffff), 0) + leftShift((write_force_snap_eth_value and &H1), 29) + leftShift((write_parse_snap_eth_value and &H1), 30) + leftShift((write_parse_snap_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        snap_value_mask = &Hffffff
        if data_low > LONG_MAX then
            if snap_value_mask = mask then
                read_snap_value_value = data_low
            else
                read_snap_value_value = (data_low - H8000_0000) and snap_value_mask
            end If
        else
            read_snap_value_value = data_low and snap_value_mask
        end If
        read_force_snap_eth_value = rightShift(data_low, 29) and &H1
        read_parse_snap_eth_value = rightShift(data_low, 30) and &H1
        read_parse_snap_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_snap_value_value = &H0
        flag_snap_value        = &H0
        write_force_snap_eth_value = &H0
        flag_force_snap_eth        = &H0
        write_parse_snap_eth_value = &H0
        flag_parse_snap_eth        = &H0
        write_parse_snap_value = &H0
        flag_parse_snap        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_llc_snap_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' snap_mask                                  [23:0]           get_snap_mask
''                                                             set_snap_mask
''                                                             read_snap_mask
''                                                             write_snap_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_llc_snap_mask
    Private write_snap_mask_value
    Private read_snap_mask_value
    Private flag_snap_mask

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1793c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_snap_mask
        get_snap_mask = read_snap_mask_value
    End Property

    Property Let set_snap_mask(aData)
        write_snap_mask_value = aData
        flag_snap_mask        = &H1
    End Property

    Property Get read_snap_mask
        read
        read_snap_mask = read_snap_mask_value
    End Property

    Property Let write_snap_mask(aData)
        set_snap_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        snap_mask_mask = &Hffffff
        if data_low > LONG_MAX then
            if snap_mask_mask = mask then
                read_snap_mask_value = data_low
            else
                read_snap_mask_value = (data_low - H8000_0000) and snap_mask_mask
            end If
        else
            read_snap_mask_value = data_low and snap_mask_mask
        end If

    End Sub

    Sub write
        If flag_snap_mask = &H0 Then read
        If flag_snap_mask = &H0 Then write_snap_mask_value = get_snap_mask

        regValue = leftShift((write_snap_mask_value and &Hffffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        snap_mask_mask = &Hffffff
        if data_low > LONG_MAX then
            if snap_mask_mask = mask then
                read_snap_mask_value = data_low
            else
                read_snap_mask_value = (data_low - H8000_0000) and snap_mask_mask
            end If
        else
            read_snap_mask_value = data_low and snap_mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_snap_mask_value = &H0
        flag_snap_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_params
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_etype                                 [0:0]            get_comp_etype
''                                                             set_comp_etype
''                                                             read_comp_etype
''                                                             write_comp_etype
''---------------------------------------------------------------------------------
'' check_v                                    [1:1]            get_check_v
''                                                             set_check_v
''                                                             read_check_v
''                                                             write_check_v
''---------------------------------------------------------------------------------
'' check_kay                                  [2:2]            get_check_kay
''                                                             set_check_kay
''                                                             read_check_kay
''                                                             write_check_kay
''---------------------------------------------------------------------------------
'' check_c_e                                  [3:3]            get_check_c_e
''                                                             set_check_c_e
''                                                             read_check_c_e
''                                                             write_check_c_e
''---------------------------------------------------------------------------------
'' check_sc                                   [4:4]            get_check_sc
''                                                             set_check_sc
''                                                             read_check_sc
''                                                             write_check_sc
''---------------------------------------------------------------------------------
'' check_sl                                   [5:5]            get_check_sl
''                                                             set_check_sl
''                                                             read_check_sl
''                                                             write_check_sl
''---------------------------------------------------------------------------------
'' check_pn                                   [6:6]            get_check_pn
''                                                             set_check_pn
''                                                             read_check_pn
''                                                             write_check_pn
''---------------------------------------------------------------------------------
'' check_sl_ext                               [7:7]            get_check_sl_ext
''                                                             set_check_sl_ext
''                                                             read_check_sl_ext
''                                                             write_check_sl_ext
''---------------------------------------------------------------------------------
'' msec_tag_value                             [31:16]          get_msec_tag_value
''                                                             set_msec_tag_value
''                                                             read_msec_tag_value
''                                                             write_msec_tag_value
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_params
    Private write_comp_etype_value
    Private read_comp_etype_value
    Private flag_comp_etype
    Private write_check_v_value
    Private read_check_v_value
    Private flag_check_v
    Private write_check_kay_value
    Private read_check_kay_value
    Private flag_check_kay
    Private write_check_c_e_value
    Private read_check_c_e_value
    Private flag_check_c_e
    Private write_check_sc_value
    Private read_check_sc_value
    Private flag_check_sc
    Private write_check_sl_value
    Private read_check_sl_value
    Private flag_check_sl
    Private write_check_pn_value
    Private read_check_pn_value
    Private flag_check_pn
    Private write_check_sl_ext_value
    Private read_check_sl_ext_value
    Private flag_check_sl_ext
    Private write_msec_tag_value_value
    Private read_msec_tag_value_value
    Private flag_msec_tag_value

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17940
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_comp_etype
        get_comp_etype = read_comp_etype_value
    End Property

    Property Let set_comp_etype(aData)
        write_comp_etype_value = aData
        flag_comp_etype        = &H1
    End Property

    Property Get read_comp_etype
        read
        read_comp_etype = read_comp_etype_value
    End Property

    Property Let write_comp_etype(aData)
        set_comp_etype = aData
        write
    End Property

    Property Get get_check_v
        get_check_v = read_check_v_value
    End Property

    Property Let set_check_v(aData)
        write_check_v_value = aData
        flag_check_v        = &H1
    End Property

    Property Get read_check_v
        read
        read_check_v = read_check_v_value
    End Property

    Property Let write_check_v(aData)
        set_check_v = aData
        write
    End Property

    Property Get get_check_kay
        get_check_kay = read_check_kay_value
    End Property

    Property Let set_check_kay(aData)
        write_check_kay_value = aData
        flag_check_kay        = &H1
    End Property

    Property Get read_check_kay
        read
        read_check_kay = read_check_kay_value
    End Property

    Property Let write_check_kay(aData)
        set_check_kay = aData
        write
    End Property

    Property Get get_check_c_e
        get_check_c_e = read_check_c_e_value
    End Property

    Property Let set_check_c_e(aData)
        write_check_c_e_value = aData
        flag_check_c_e        = &H1
    End Property

    Property Get read_check_c_e
        read
        read_check_c_e = read_check_c_e_value
    End Property

    Property Let write_check_c_e(aData)
        set_check_c_e = aData
        write
    End Property

    Property Get get_check_sc
        get_check_sc = read_check_sc_value
    End Property

    Property Let set_check_sc(aData)
        write_check_sc_value = aData
        flag_check_sc        = &H1
    End Property

    Property Get read_check_sc
        read
        read_check_sc = read_check_sc_value
    End Property

    Property Let write_check_sc(aData)
        set_check_sc = aData
        write
    End Property

    Property Get get_check_sl
        get_check_sl = read_check_sl_value
    End Property

    Property Let set_check_sl(aData)
        write_check_sl_value = aData
        flag_check_sl        = &H1
    End Property

    Property Get read_check_sl
        read
        read_check_sl = read_check_sl_value
    End Property

    Property Let write_check_sl(aData)
        set_check_sl = aData
        write
    End Property

    Property Get get_check_pn
        get_check_pn = read_check_pn_value
    End Property

    Property Let set_check_pn(aData)
        write_check_pn_value = aData
        flag_check_pn        = &H1
    End Property

    Property Get read_check_pn
        read
        read_check_pn = read_check_pn_value
    End Property

    Property Let write_check_pn(aData)
        set_check_pn = aData
        write
    End Property

    Property Get get_check_sl_ext
        get_check_sl_ext = read_check_sl_ext_value
    End Property

    Property Let set_check_sl_ext(aData)
        write_check_sl_ext_value = aData
        flag_check_sl_ext        = &H1
    End Property

    Property Get read_check_sl_ext
        read
        read_check_sl_ext = read_check_sl_ext_value
    End Property

    Property Let write_check_sl_ext(aData)
        set_check_sl_ext = aData
        write
    End Property

    Property Get get_msec_tag_value
        get_msec_tag_value = read_msec_tag_value_value
    End Property

    Property Let set_msec_tag_value(aData)
        write_msec_tag_value_value = aData
        flag_msec_tag_value        = &H1
    End Property

    Property Get read_msec_tag_value
        read
        read_msec_tag_value = read_msec_tag_value_value
    End Property

    Property Let write_msec_tag_value(aData)
        set_msec_tag_value = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_etype_mask = &H1
        if data_low > LONG_MAX then
            if comp_etype_mask = mask then
                read_comp_etype_value = data_low
            else
                read_comp_etype_value = (data_low - H8000_0000) and comp_etype_mask
            end If
        else
            read_comp_etype_value = data_low and comp_etype_mask
        end If
        read_check_v_value = rightShift(data_low, 1) and &H1
        read_check_kay_value = rightShift(data_low, 2) and &H1
        read_check_c_e_value = rightShift(data_low, 3) and &H1
        read_check_sc_value = rightShift(data_low, 4) and &H1
        read_check_sl_value = rightShift(data_low, 5) and &H1
        read_check_pn_value = rightShift(data_low, 6) and &H1
        read_check_sl_ext_value = rightShift(data_low, 7) and &H1
        read_msec_tag_value_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_comp_etype = &H0 or flag_check_v = &H0 or flag_check_kay = &H0 or flag_check_c_e = &H0 or flag_check_sc = &H0 or flag_check_sl = &H0 or flag_check_pn = &H0 or flag_check_sl_ext = &H0 or flag_msec_tag_value = &H0 Then read
        If flag_comp_etype = &H0 Then write_comp_etype_value = get_comp_etype
        If flag_check_v = &H0 Then write_check_v_value = get_check_v
        If flag_check_kay = &H0 Then write_check_kay_value = get_check_kay
        If flag_check_c_e = &H0 Then write_check_c_e_value = get_check_c_e
        If flag_check_sc = &H0 Then write_check_sc_value = get_check_sc
        If flag_check_sl = &H0 Then write_check_sl_value = get_check_sl
        If flag_check_pn = &H0 Then write_check_pn_value = get_check_pn
        If flag_check_sl_ext = &H0 Then write_check_sl_ext_value = get_check_sl_ext
        If flag_msec_tag_value = &H0 Then write_msec_tag_value_value = get_msec_tag_value

        regValue = leftShift((write_comp_etype_value and &H1), 0) + leftShift((write_check_v_value and &H1), 1) + leftShift((write_check_kay_value and &H1), 2) + leftShift((write_check_c_e_value and &H1), 3) + leftShift((write_check_sc_value and &H1), 4) + leftShift((write_check_sl_value and &H1), 5) + leftShift((write_check_pn_value and &H1), 6) + leftShift((write_check_sl_ext_value and &H1), 7) + leftShift((write_msec_tag_value_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_etype_mask = &H1
        if data_low > LONG_MAX then
            if comp_etype_mask = mask then
                read_comp_etype_value = data_low
            else
                read_comp_etype_value = (data_low - H8000_0000) and comp_etype_mask
            end If
        else
            read_comp_etype_value = data_low and comp_etype_mask
        end If
        read_check_v_value = rightShift(data_low, 1) and &H1
        read_check_kay_value = rightShift(data_low, 2) and &H1
        read_check_c_e_value = rightShift(data_low, 3) and &H1
        read_check_sc_value = rightShift(data_low, 4) and &H1
        read_check_sl_value = rightShift(data_low, 5) and &H1
        read_check_pn_value = rightShift(data_low, 6) and &H1
        read_check_sl_ext_value = rightShift(data_low, 7) and &H1
        read_msec_tag_value_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_etype_value = &H0
        flag_comp_etype        = &H0
        write_check_v_value = &H0
        flag_check_v        = &H0
        write_check_kay_value = &H0
        flag_check_kay        = &H0
        write_check_c_e_value = &H0
        flag_check_c_e        = &H0
        write_check_sc_value = &H0
        flag_check_sc        = &H0
        write_check_sl_value = &H0
        flag_check_sl        = &H0
        write_check_pn_value = &H0
        flag_check_pn        = &H0
        write_check_sl_ext_value = &H0
        flag_check_sl_ext        = &H0
        write_msec_tag_value_value = &H0
        flag_msec_tag_value        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_ncp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type0                                 [0:0]            get_flow_type0
''                                                             set_flow_type0
''                                                             read_flow_type0
''                                                             write_flow_type0
''---------------------------------------------------------------------------------
'' dest_port0                                 [3:2]            get_dest_port0
''                                                             set_dest_port0
''                                                             read_dest_port0
''                                                             write_dest_port0
''---------------------------------------------------------------------------------
'' drop_non_redir0                            [4:4]            get_drop_non_redir0
''                                                             set_drop_non_redir0
''                                                             read_drop_non_redir0
''                                                             write_drop_non_redir0
''---------------------------------------------------------------------------------
'' drop_action0                               [7:6]            get_drop_action0
''                                                             set_drop_action0
''                                                             read_drop_action0
''                                                             write_drop_action0
''---------------------------------------------------------------------------------
'' flow_type1                                 [8:8]            get_flow_type1
''                                                             set_flow_type1
''                                                             read_flow_type1
''                                                             write_flow_type1
''---------------------------------------------------------------------------------
'' dest_port1                                 [11:10]          get_dest_port1
''                                                             set_dest_port1
''                                                             read_dest_port1
''                                                             write_dest_port1
''---------------------------------------------------------------------------------
'' drop_non_redir1                            [12:12]          get_drop_non_redir1
''                                                             set_drop_non_redir1
''                                                             read_drop_non_redir1
''                                                             write_drop_non_redir1
''---------------------------------------------------------------------------------
'' drop_action1                               [15:14]          get_drop_action1
''                                                             set_drop_action1
''                                                             read_drop_action1
''                                                             write_drop_action1
''---------------------------------------------------------------------------------
'' flow_type2                                 [16:16]          get_flow_type2
''                                                             set_flow_type2
''                                                             read_flow_type2
''                                                             write_flow_type2
''---------------------------------------------------------------------------------
'' dest_port2                                 [19:18]          get_dest_port2
''                                                             set_dest_port2
''                                                             read_dest_port2
''                                                             write_dest_port2
''---------------------------------------------------------------------------------
'' drop_non_redir2                            [20:20]          get_drop_non_redir2
''                                                             set_drop_non_redir2
''                                                             read_drop_non_redir2
''                                                             write_drop_non_redir2
''---------------------------------------------------------------------------------
'' drop_action2                               [23:22]          get_drop_action2
''                                                             set_drop_action2
''                                                             read_drop_action2
''                                                             write_drop_action2
''---------------------------------------------------------------------------------
'' flow_type3                                 [24:24]          get_flow_type3
''                                                             set_flow_type3
''                                                             read_flow_type3
''                                                             write_flow_type3
''---------------------------------------------------------------------------------
'' dest_port3                                 [27:26]          get_dest_port3
''                                                             set_dest_port3
''                                                             read_dest_port3
''                                                             write_dest_port3
''---------------------------------------------------------------------------------
'' drop_non_redir3                            [28:28]          get_drop_non_redir3
''                                                             set_drop_non_redir3
''                                                             read_drop_non_redir3
''                                                             write_drop_non_redir3
''---------------------------------------------------------------------------------
'' drop_action3                               [31:30]          get_drop_action3
''                                                             set_drop_action3
''                                                             read_drop_action3
''                                                             write_drop_action3
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_ncp
    Private write_flow_type0_value
    Private read_flow_type0_value
    Private flag_flow_type0
    Private write_dest_port0_value
    Private read_dest_port0_value
    Private flag_dest_port0
    Private write_drop_non_redir0_value
    Private read_drop_non_redir0_value
    Private flag_drop_non_redir0
    Private write_drop_action0_value
    Private read_drop_action0_value
    Private flag_drop_action0
    Private write_flow_type1_value
    Private read_flow_type1_value
    Private flag_flow_type1
    Private write_dest_port1_value
    Private read_dest_port1_value
    Private flag_dest_port1
    Private write_drop_non_redir1_value
    Private read_drop_non_redir1_value
    Private flag_drop_non_redir1
    Private write_drop_action1_value
    Private read_drop_action1_value
    Private flag_drop_action1
    Private write_flow_type2_value
    Private read_flow_type2_value
    Private flag_flow_type2
    Private write_dest_port2_value
    Private read_dest_port2_value
    Private flag_dest_port2
    Private write_drop_non_redir2_value
    Private read_drop_non_redir2_value
    Private flag_drop_non_redir2
    Private write_drop_action2_value
    Private read_drop_action2_value
    Private flag_drop_action2
    Private write_flow_type3_value
    Private read_flow_type3_value
    Private flag_flow_type3
    Private write_dest_port3_value
    Private read_dest_port3_value
    Private flag_dest_port3
    Private write_drop_non_redir3_value
    Private read_drop_non_redir3_value
    Private flag_drop_non_redir3
    Private write_drop_action3_value
    Private read_drop_action3_value
    Private flag_drop_action3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17944
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type0
        get_flow_type0 = read_flow_type0_value
    End Property

    Property Let set_flow_type0(aData)
        write_flow_type0_value = aData
        flag_flow_type0        = &H1
    End Property

    Property Get read_flow_type0
        read
        read_flow_type0 = read_flow_type0_value
    End Property

    Property Let write_flow_type0(aData)
        set_flow_type0 = aData
        write
    End Property

    Property Get get_dest_port0
        get_dest_port0 = read_dest_port0_value
    End Property

    Property Let set_dest_port0(aData)
        write_dest_port0_value = aData
        flag_dest_port0        = &H1
    End Property

    Property Get read_dest_port0
        read
        read_dest_port0 = read_dest_port0_value
    End Property

    Property Let write_dest_port0(aData)
        set_dest_port0 = aData
        write
    End Property

    Property Get get_drop_non_redir0
        get_drop_non_redir0 = read_drop_non_redir0_value
    End Property

    Property Let set_drop_non_redir0(aData)
        write_drop_non_redir0_value = aData
        flag_drop_non_redir0        = &H1
    End Property

    Property Get read_drop_non_redir0
        read
        read_drop_non_redir0 = read_drop_non_redir0_value
    End Property

    Property Let write_drop_non_redir0(aData)
        set_drop_non_redir0 = aData
        write
    End Property

    Property Get get_drop_action0
        get_drop_action0 = read_drop_action0_value
    End Property

    Property Let set_drop_action0(aData)
        write_drop_action0_value = aData
        flag_drop_action0        = &H1
    End Property

    Property Get read_drop_action0
        read
        read_drop_action0 = read_drop_action0_value
    End Property

    Property Let write_drop_action0(aData)
        set_drop_action0 = aData
        write
    End Property

    Property Get get_flow_type1
        get_flow_type1 = read_flow_type1_value
    End Property

    Property Let set_flow_type1(aData)
        write_flow_type1_value = aData
        flag_flow_type1        = &H1
    End Property

    Property Get read_flow_type1
        read
        read_flow_type1 = read_flow_type1_value
    End Property

    Property Let write_flow_type1(aData)
        set_flow_type1 = aData
        write
    End Property

    Property Get get_dest_port1
        get_dest_port1 = read_dest_port1_value
    End Property

    Property Let set_dest_port1(aData)
        write_dest_port1_value = aData
        flag_dest_port1        = &H1
    End Property

    Property Get read_dest_port1
        read
        read_dest_port1 = read_dest_port1_value
    End Property

    Property Let write_dest_port1(aData)
        set_dest_port1 = aData
        write
    End Property

    Property Get get_drop_non_redir1
        get_drop_non_redir1 = read_drop_non_redir1_value
    End Property

    Property Let set_drop_non_redir1(aData)
        write_drop_non_redir1_value = aData
        flag_drop_non_redir1        = &H1
    End Property

    Property Get read_drop_non_redir1
        read
        read_drop_non_redir1 = read_drop_non_redir1_value
    End Property

    Property Let write_drop_non_redir1(aData)
        set_drop_non_redir1 = aData
        write
    End Property

    Property Get get_drop_action1
        get_drop_action1 = read_drop_action1_value
    End Property

    Property Let set_drop_action1(aData)
        write_drop_action1_value = aData
        flag_drop_action1        = &H1
    End Property

    Property Get read_drop_action1
        read
        read_drop_action1 = read_drop_action1_value
    End Property

    Property Let write_drop_action1(aData)
        set_drop_action1 = aData
        write
    End Property

    Property Get get_flow_type2
        get_flow_type2 = read_flow_type2_value
    End Property

    Property Let set_flow_type2(aData)
        write_flow_type2_value = aData
        flag_flow_type2        = &H1
    End Property

    Property Get read_flow_type2
        read
        read_flow_type2 = read_flow_type2_value
    End Property

    Property Let write_flow_type2(aData)
        set_flow_type2 = aData
        write
    End Property

    Property Get get_dest_port2
        get_dest_port2 = read_dest_port2_value
    End Property

    Property Let set_dest_port2(aData)
        write_dest_port2_value = aData
        flag_dest_port2        = &H1
    End Property

    Property Get read_dest_port2
        read
        read_dest_port2 = read_dest_port2_value
    End Property

    Property Let write_dest_port2(aData)
        set_dest_port2 = aData
        write
    End Property

    Property Get get_drop_non_redir2
        get_drop_non_redir2 = read_drop_non_redir2_value
    End Property

    Property Let set_drop_non_redir2(aData)
        write_drop_non_redir2_value = aData
        flag_drop_non_redir2        = &H1
    End Property

    Property Get read_drop_non_redir2
        read
        read_drop_non_redir2 = read_drop_non_redir2_value
    End Property

    Property Let write_drop_non_redir2(aData)
        set_drop_non_redir2 = aData
        write
    End Property

    Property Get get_drop_action2
        get_drop_action2 = read_drop_action2_value
    End Property

    Property Let set_drop_action2(aData)
        write_drop_action2_value = aData
        flag_drop_action2        = &H1
    End Property

    Property Get read_drop_action2
        read
        read_drop_action2 = read_drop_action2_value
    End Property

    Property Let write_drop_action2(aData)
        set_drop_action2 = aData
        write
    End Property

    Property Get get_flow_type3
        get_flow_type3 = read_flow_type3_value
    End Property

    Property Let set_flow_type3(aData)
        write_flow_type3_value = aData
        flag_flow_type3        = &H1
    End Property

    Property Get read_flow_type3
        read
        read_flow_type3 = read_flow_type3_value
    End Property

    Property Let write_flow_type3(aData)
        set_flow_type3 = aData
        write
    End Property

    Property Get get_dest_port3
        get_dest_port3 = read_dest_port3_value
    End Property

    Property Let set_dest_port3(aData)
        write_dest_port3_value = aData
        flag_dest_port3        = &H1
    End Property

    Property Get read_dest_port3
        read
        read_dest_port3 = read_dest_port3_value
    End Property

    Property Let write_dest_port3(aData)
        set_dest_port3 = aData
        write
    End Property

    Property Get get_drop_non_redir3
        get_drop_non_redir3 = read_drop_non_redir3_value
    End Property

    Property Let set_drop_non_redir3(aData)
        write_drop_non_redir3_value = aData
        flag_drop_non_redir3        = &H1
    End Property

    Property Get read_drop_non_redir3
        read
        read_drop_non_redir3 = read_drop_non_redir3_value
    End Property

    Property Let write_drop_non_redir3(aData)
        set_drop_non_redir3 = aData
        write
    End Property

    Property Get get_drop_action3
        get_drop_action3 = read_drop_action3_value
    End Property

    Property Let set_drop_action3(aData)
        write_drop_action3_value = aData
        flag_drop_action3        = &H1
    End Property

    Property Get read_drop_action3
        read
        read_drop_action3 = read_drop_action3_value
    End Property

    Property Let write_drop_action3(aData)
        set_drop_action3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type0_mask = &H1
        if data_low > LONG_MAX then
            if flow_type0_mask = mask then
                read_flow_type0_value = data_low
            else
                read_flow_type0_value = (data_low - H8000_0000) and flow_type0_mask
            end If
        else
            read_flow_type0_value = data_low and flow_type0_mask
        end If
        read_dest_port0_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir0_value = rightShift(data_low, 4) and &H1
        read_drop_action0_value = rightShift(data_low, 6) and &H3
        read_flow_type1_value = rightShift(data_low, 8) and &H1
        read_dest_port1_value = rightShift(data_low, 10) and &H3
        read_drop_non_redir1_value = rightShift(data_low, 12) and &H1
        read_drop_action1_value = rightShift(data_low, 14) and &H3
        read_flow_type2_value = rightShift(data_low, 16) and &H1
        read_dest_port2_value = rightShift(data_low, 18) and &H3
        read_drop_non_redir2_value = rightShift(data_low, 20) and &H1
        read_drop_action2_value = rightShift(data_low, 22) and &H3
        read_flow_type3_value = rightShift(data_low, 24) and &H1
        read_dest_port3_value = rightShift(data_low, 26) and &H3
        read_drop_non_redir3_value = rightShift(data_low, 28) and &H1
        read_drop_action3_value = rightShift(data_low, 30) and &H3

    End Sub

    Sub write
        If flag_flow_type0 = &H0 or flag_dest_port0 = &H0 or flag_drop_non_redir0 = &H0 or flag_drop_action0 = &H0 or flag_flow_type1 = &H0 or flag_dest_port1 = &H0 or flag_drop_non_redir1 = &H0 or flag_drop_action1 = &H0 or flag_flow_type2 = &H0 or flag_dest_port2 = &H0 or flag_drop_non_redir2 = &H0 or flag_drop_action2 = &H0 or flag_flow_type3 = &H0 or flag_dest_port3 = &H0 or flag_drop_non_redir3 = &H0 or flag_drop_action3 = &H0 Then read
        If flag_flow_type0 = &H0 Then write_flow_type0_value = get_flow_type0
        If flag_dest_port0 = &H0 Then write_dest_port0_value = get_dest_port0
        If flag_drop_non_redir0 = &H0 Then write_drop_non_redir0_value = get_drop_non_redir0
        If flag_drop_action0 = &H0 Then write_drop_action0_value = get_drop_action0
        If flag_flow_type1 = &H0 Then write_flow_type1_value = get_flow_type1
        If flag_dest_port1 = &H0 Then write_dest_port1_value = get_dest_port1
        If flag_drop_non_redir1 = &H0 Then write_drop_non_redir1_value = get_drop_non_redir1
        If flag_drop_action1 = &H0 Then write_drop_action1_value = get_drop_action1
        If flag_flow_type2 = &H0 Then write_flow_type2_value = get_flow_type2
        If flag_dest_port2 = &H0 Then write_dest_port2_value = get_dest_port2
        If flag_drop_non_redir2 = &H0 Then write_drop_non_redir2_value = get_drop_non_redir2
        If flag_drop_action2 = &H0 Then write_drop_action2_value = get_drop_action2
        If flag_flow_type3 = &H0 Then write_flow_type3_value = get_flow_type3
        If flag_dest_port3 = &H0 Then write_dest_port3_value = get_dest_port3
        If flag_drop_non_redir3 = &H0 Then write_drop_non_redir3_value = get_drop_non_redir3
        If flag_drop_action3 = &H0 Then write_drop_action3_value = get_drop_action3

        regValue = leftShift((write_flow_type0_value and &H1), 0) + leftShift((write_dest_port0_value and &H3), 2) + leftShift((write_drop_non_redir0_value and &H1), 4) + leftShift((write_drop_action0_value and &H3), 6) + leftShift((write_flow_type1_value and &H1), 8) + leftShift((write_dest_port1_value and &H3), 10) + leftShift((write_drop_non_redir1_value and &H1), 12) + leftShift((write_drop_action1_value and &H3), 14) + leftShift((write_flow_type2_value and &H1), 16) + leftShift((write_dest_port2_value and &H3), 18) + leftShift((write_drop_non_redir2_value and &H1), 20) + leftShift((write_drop_action2_value and &H3), 22) + leftShift((write_flow_type3_value and &H1), 24) + leftShift((write_dest_port3_value and &H3), 26) + leftShift((write_drop_non_redir3_value and &H1), 28) + leftShift((write_drop_action3_value and &H3), 30)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type0_mask = &H1
        if data_low > LONG_MAX then
            if flow_type0_mask = mask then
                read_flow_type0_value = data_low
            else
                read_flow_type0_value = (data_low - H8000_0000) and flow_type0_mask
            end If
        else
            read_flow_type0_value = data_low and flow_type0_mask
        end If
        read_dest_port0_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir0_value = rightShift(data_low, 4) and &H1
        read_drop_action0_value = rightShift(data_low, 6) and &H3
        read_flow_type1_value = rightShift(data_low, 8) and &H1
        read_dest_port1_value = rightShift(data_low, 10) and &H3
        read_drop_non_redir1_value = rightShift(data_low, 12) and &H1
        read_drop_action1_value = rightShift(data_low, 14) and &H3
        read_flow_type2_value = rightShift(data_low, 16) and &H1
        read_dest_port2_value = rightShift(data_low, 18) and &H3
        read_drop_non_redir2_value = rightShift(data_low, 20) and &H1
        read_drop_action2_value = rightShift(data_low, 22) and &H3
        read_flow_type3_value = rightShift(data_low, 24) and &H1
        read_dest_port3_value = rightShift(data_low, 26) and &H3
        read_drop_non_redir3_value = rightShift(data_low, 28) and &H1
        read_drop_action3_value = rightShift(data_low, 30) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type0_value = &H0
        flag_flow_type0        = &H0
        write_dest_port0_value = &H0
        flag_dest_port0        = &H0
        write_drop_non_redir0_value = &H0
        flag_drop_non_redir0        = &H0
        write_drop_action0_value = &H0
        flag_drop_action0        = &H0
        write_flow_type1_value = &H0
        flag_flow_type1        = &H0
        write_dest_port1_value = &H0
        flag_dest_port1        = &H0
        write_drop_non_redir1_value = &H0
        flag_drop_non_redir1        = &H0
        write_drop_action1_value = &H0
        flag_drop_action1        = &H0
        write_flow_type2_value = &H0
        flag_flow_type2        = &H0
        write_dest_port2_value = &H0
        flag_dest_port2        = &H0
        write_drop_non_redir2_value = &H0
        flag_drop_non_redir2        = &H0
        write_drop_action2_value = &H0
        flag_drop_action2        = &H0
        write_flow_type3_value = &H0
        flag_flow_type3        = &H0
        write_dest_port3_value = &H0
        flag_dest_port3        = &H0
        write_drop_non_redir3_value = &H0
        flag_drop_non_redir3        = &H0
        write_drop_action3_value = &H0
        flag_drop_action3        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_cp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type0                                 [0:0]            get_flow_type0
''                                                             set_flow_type0
''                                                             read_flow_type0
''                                                             write_flow_type0
''---------------------------------------------------------------------------------
'' dest_port0                                 [3:2]            get_dest_port0
''                                                             set_dest_port0
''                                                             read_dest_port0
''                                                             write_dest_port0
''---------------------------------------------------------------------------------
'' drop_non_redir0                            [4:4]            get_drop_non_redir0
''                                                             set_drop_non_redir0
''                                                             read_drop_non_redir0
''                                                             write_drop_non_redir0
''---------------------------------------------------------------------------------
'' drop_action0                               [7:6]            get_drop_action0
''                                                             set_drop_action0
''                                                             read_drop_action0
''                                                             write_drop_action0
''---------------------------------------------------------------------------------
'' flow_type1                                 [8:8]            get_flow_type1
''                                                             set_flow_type1
''                                                             read_flow_type1
''                                                             write_flow_type1
''---------------------------------------------------------------------------------
'' dest_port1                                 [11:10]          get_dest_port1
''                                                             set_dest_port1
''                                                             read_dest_port1
''                                                             write_dest_port1
''---------------------------------------------------------------------------------
'' drop_non_redir1                            [12:12]          get_drop_non_redir1
''                                                             set_drop_non_redir1
''                                                             read_drop_non_redir1
''                                                             write_drop_non_redir1
''---------------------------------------------------------------------------------
'' drop_action1                               [15:14]          get_drop_action1
''                                                             set_drop_action1
''                                                             read_drop_action1
''                                                             write_drop_action1
''---------------------------------------------------------------------------------
'' flow_type2                                 [16:16]          get_flow_type2
''                                                             set_flow_type2
''                                                             read_flow_type2
''                                                             write_flow_type2
''---------------------------------------------------------------------------------
'' dest_port2                                 [19:18]          get_dest_port2
''                                                             set_dest_port2
''                                                             read_dest_port2
''                                                             write_dest_port2
''---------------------------------------------------------------------------------
'' drop_non_redir2                            [20:20]          get_drop_non_redir2
''                                                             set_drop_non_redir2
''                                                             read_drop_non_redir2
''                                                             write_drop_non_redir2
''---------------------------------------------------------------------------------
'' drop_action2                               [23:22]          get_drop_action2
''                                                             set_drop_action2
''                                                             read_drop_action2
''                                                             write_drop_action2
''---------------------------------------------------------------------------------
'' flow_type3                                 [24:24]          get_flow_type3
''                                                             set_flow_type3
''                                                             read_flow_type3
''                                                             write_flow_type3
''---------------------------------------------------------------------------------
'' dest_port3                                 [27:26]          get_dest_port3
''                                                             set_dest_port3
''                                                             read_dest_port3
''                                                             write_dest_port3
''---------------------------------------------------------------------------------
'' drop_non_redir3                            [28:28]          get_drop_non_redir3
''                                                             set_drop_non_redir3
''                                                             read_drop_non_redir3
''                                                             write_drop_non_redir3
''---------------------------------------------------------------------------------
'' drop_action3                               [31:30]          get_drop_action3
''                                                             set_drop_action3
''                                                             read_drop_action3
''                                                             write_drop_action3
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_cp
    Private write_flow_type0_value
    Private read_flow_type0_value
    Private flag_flow_type0
    Private write_dest_port0_value
    Private read_dest_port0_value
    Private flag_dest_port0
    Private write_drop_non_redir0_value
    Private read_drop_non_redir0_value
    Private flag_drop_non_redir0
    Private write_drop_action0_value
    Private read_drop_action0_value
    Private flag_drop_action0
    Private write_flow_type1_value
    Private read_flow_type1_value
    Private flag_flow_type1
    Private write_dest_port1_value
    Private read_dest_port1_value
    Private flag_dest_port1
    Private write_drop_non_redir1_value
    Private read_drop_non_redir1_value
    Private flag_drop_non_redir1
    Private write_drop_action1_value
    Private read_drop_action1_value
    Private flag_drop_action1
    Private write_flow_type2_value
    Private read_flow_type2_value
    Private flag_flow_type2
    Private write_dest_port2_value
    Private read_dest_port2_value
    Private flag_dest_port2
    Private write_drop_non_redir2_value
    Private read_drop_non_redir2_value
    Private flag_drop_non_redir2
    Private write_drop_action2_value
    Private read_drop_action2_value
    Private flag_drop_action2
    Private write_flow_type3_value
    Private read_flow_type3_value
    Private flag_flow_type3
    Private write_dest_port3_value
    Private read_dest_port3_value
    Private flag_dest_port3
    Private write_drop_non_redir3_value
    Private read_drop_non_redir3_value
    Private flag_drop_non_redir3
    Private write_drop_action3_value
    Private read_drop_action3_value
    Private flag_drop_action3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17948
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type0
        get_flow_type0 = read_flow_type0_value
    End Property

    Property Let set_flow_type0(aData)
        write_flow_type0_value = aData
        flag_flow_type0        = &H1
    End Property

    Property Get read_flow_type0
        read
        read_flow_type0 = read_flow_type0_value
    End Property

    Property Let write_flow_type0(aData)
        set_flow_type0 = aData
        write
    End Property

    Property Get get_dest_port0
        get_dest_port0 = read_dest_port0_value
    End Property

    Property Let set_dest_port0(aData)
        write_dest_port0_value = aData
        flag_dest_port0        = &H1
    End Property

    Property Get read_dest_port0
        read
        read_dest_port0 = read_dest_port0_value
    End Property

    Property Let write_dest_port0(aData)
        set_dest_port0 = aData
        write
    End Property

    Property Get get_drop_non_redir0
        get_drop_non_redir0 = read_drop_non_redir0_value
    End Property

    Property Let set_drop_non_redir0(aData)
        write_drop_non_redir0_value = aData
        flag_drop_non_redir0        = &H1
    End Property

    Property Get read_drop_non_redir0
        read
        read_drop_non_redir0 = read_drop_non_redir0_value
    End Property

    Property Let write_drop_non_redir0(aData)
        set_drop_non_redir0 = aData
        write
    End Property

    Property Get get_drop_action0
        get_drop_action0 = read_drop_action0_value
    End Property

    Property Let set_drop_action0(aData)
        write_drop_action0_value = aData
        flag_drop_action0        = &H1
    End Property

    Property Get read_drop_action0
        read
        read_drop_action0 = read_drop_action0_value
    End Property

    Property Let write_drop_action0(aData)
        set_drop_action0 = aData
        write
    End Property

    Property Get get_flow_type1
        get_flow_type1 = read_flow_type1_value
    End Property

    Property Let set_flow_type1(aData)
        write_flow_type1_value = aData
        flag_flow_type1        = &H1
    End Property

    Property Get read_flow_type1
        read
        read_flow_type1 = read_flow_type1_value
    End Property

    Property Let write_flow_type1(aData)
        set_flow_type1 = aData
        write
    End Property

    Property Get get_dest_port1
        get_dest_port1 = read_dest_port1_value
    End Property

    Property Let set_dest_port1(aData)
        write_dest_port1_value = aData
        flag_dest_port1        = &H1
    End Property

    Property Get read_dest_port1
        read
        read_dest_port1 = read_dest_port1_value
    End Property

    Property Let write_dest_port1(aData)
        set_dest_port1 = aData
        write
    End Property

    Property Get get_drop_non_redir1
        get_drop_non_redir1 = read_drop_non_redir1_value
    End Property

    Property Let set_drop_non_redir1(aData)
        write_drop_non_redir1_value = aData
        flag_drop_non_redir1        = &H1
    End Property

    Property Get read_drop_non_redir1
        read
        read_drop_non_redir1 = read_drop_non_redir1_value
    End Property

    Property Let write_drop_non_redir1(aData)
        set_drop_non_redir1 = aData
        write
    End Property

    Property Get get_drop_action1
        get_drop_action1 = read_drop_action1_value
    End Property

    Property Let set_drop_action1(aData)
        write_drop_action1_value = aData
        flag_drop_action1        = &H1
    End Property

    Property Get read_drop_action1
        read
        read_drop_action1 = read_drop_action1_value
    End Property

    Property Let write_drop_action1(aData)
        set_drop_action1 = aData
        write
    End Property

    Property Get get_flow_type2
        get_flow_type2 = read_flow_type2_value
    End Property

    Property Let set_flow_type2(aData)
        write_flow_type2_value = aData
        flag_flow_type2        = &H1
    End Property

    Property Get read_flow_type2
        read
        read_flow_type2 = read_flow_type2_value
    End Property

    Property Let write_flow_type2(aData)
        set_flow_type2 = aData
        write
    End Property

    Property Get get_dest_port2
        get_dest_port2 = read_dest_port2_value
    End Property

    Property Let set_dest_port2(aData)
        write_dest_port2_value = aData
        flag_dest_port2        = &H1
    End Property

    Property Get read_dest_port2
        read
        read_dest_port2 = read_dest_port2_value
    End Property

    Property Let write_dest_port2(aData)
        set_dest_port2 = aData
        write
    End Property

    Property Get get_drop_non_redir2
        get_drop_non_redir2 = read_drop_non_redir2_value
    End Property

    Property Let set_drop_non_redir2(aData)
        write_drop_non_redir2_value = aData
        flag_drop_non_redir2        = &H1
    End Property

    Property Get read_drop_non_redir2
        read
        read_drop_non_redir2 = read_drop_non_redir2_value
    End Property

    Property Let write_drop_non_redir2(aData)
        set_drop_non_redir2 = aData
        write
    End Property

    Property Get get_drop_action2
        get_drop_action2 = read_drop_action2_value
    End Property

    Property Let set_drop_action2(aData)
        write_drop_action2_value = aData
        flag_drop_action2        = &H1
    End Property

    Property Get read_drop_action2
        read
        read_drop_action2 = read_drop_action2_value
    End Property

    Property Let write_drop_action2(aData)
        set_drop_action2 = aData
        write
    End Property

    Property Get get_flow_type3
        get_flow_type3 = read_flow_type3_value
    End Property

    Property Let set_flow_type3(aData)
        write_flow_type3_value = aData
        flag_flow_type3        = &H1
    End Property

    Property Get read_flow_type3
        read
        read_flow_type3 = read_flow_type3_value
    End Property

    Property Let write_flow_type3(aData)
        set_flow_type3 = aData
        write
    End Property

    Property Get get_dest_port3
        get_dest_port3 = read_dest_port3_value
    End Property

    Property Let set_dest_port3(aData)
        write_dest_port3_value = aData
        flag_dest_port3        = &H1
    End Property

    Property Get read_dest_port3
        read
        read_dest_port3 = read_dest_port3_value
    End Property

    Property Let write_dest_port3(aData)
        set_dest_port3 = aData
        write
    End Property

    Property Get get_drop_non_redir3
        get_drop_non_redir3 = read_drop_non_redir3_value
    End Property

    Property Let set_drop_non_redir3(aData)
        write_drop_non_redir3_value = aData
        flag_drop_non_redir3        = &H1
    End Property

    Property Get read_drop_non_redir3
        read
        read_drop_non_redir3 = read_drop_non_redir3_value
    End Property

    Property Let write_drop_non_redir3(aData)
        set_drop_non_redir3 = aData
        write
    End Property

    Property Get get_drop_action3
        get_drop_action3 = read_drop_action3_value
    End Property

    Property Let set_drop_action3(aData)
        write_drop_action3_value = aData
        flag_drop_action3        = &H1
    End Property

    Property Get read_drop_action3
        read
        read_drop_action3 = read_drop_action3_value
    End Property

    Property Let write_drop_action3(aData)
        set_drop_action3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type0_mask = &H1
        if data_low > LONG_MAX then
            if flow_type0_mask = mask then
                read_flow_type0_value = data_low
            else
                read_flow_type0_value = (data_low - H8000_0000) and flow_type0_mask
            end If
        else
            read_flow_type0_value = data_low and flow_type0_mask
        end If
        read_dest_port0_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir0_value = rightShift(data_low, 4) and &H1
        read_drop_action0_value = rightShift(data_low, 6) and &H3
        read_flow_type1_value = rightShift(data_low, 8) and &H1
        read_dest_port1_value = rightShift(data_low, 10) and &H3
        read_drop_non_redir1_value = rightShift(data_low, 12) and &H1
        read_drop_action1_value = rightShift(data_low, 14) and &H3
        read_flow_type2_value = rightShift(data_low, 16) and &H1
        read_dest_port2_value = rightShift(data_low, 18) and &H3
        read_drop_non_redir2_value = rightShift(data_low, 20) and &H1
        read_drop_action2_value = rightShift(data_low, 22) and &H3
        read_flow_type3_value = rightShift(data_low, 24) and &H1
        read_dest_port3_value = rightShift(data_low, 26) and &H3
        read_drop_non_redir3_value = rightShift(data_low, 28) and &H1
        read_drop_action3_value = rightShift(data_low, 30) and &H3

    End Sub

    Sub write
        If flag_flow_type0 = &H0 or flag_dest_port0 = &H0 or flag_drop_non_redir0 = &H0 or flag_drop_action0 = &H0 or flag_flow_type1 = &H0 or flag_dest_port1 = &H0 or flag_drop_non_redir1 = &H0 or flag_drop_action1 = &H0 or flag_flow_type2 = &H0 or flag_dest_port2 = &H0 or flag_drop_non_redir2 = &H0 or flag_drop_action2 = &H0 or flag_flow_type3 = &H0 or flag_dest_port3 = &H0 or flag_drop_non_redir3 = &H0 or flag_drop_action3 = &H0 Then read
        If flag_flow_type0 = &H0 Then write_flow_type0_value = get_flow_type0
        If flag_dest_port0 = &H0 Then write_dest_port0_value = get_dest_port0
        If flag_drop_non_redir0 = &H0 Then write_drop_non_redir0_value = get_drop_non_redir0
        If flag_drop_action0 = &H0 Then write_drop_action0_value = get_drop_action0
        If flag_flow_type1 = &H0 Then write_flow_type1_value = get_flow_type1
        If flag_dest_port1 = &H0 Then write_dest_port1_value = get_dest_port1
        If flag_drop_non_redir1 = &H0 Then write_drop_non_redir1_value = get_drop_non_redir1
        If flag_drop_action1 = &H0 Then write_drop_action1_value = get_drop_action1
        If flag_flow_type2 = &H0 Then write_flow_type2_value = get_flow_type2
        If flag_dest_port2 = &H0 Then write_dest_port2_value = get_dest_port2
        If flag_drop_non_redir2 = &H0 Then write_drop_non_redir2_value = get_drop_non_redir2
        If flag_drop_action2 = &H0 Then write_drop_action2_value = get_drop_action2
        If flag_flow_type3 = &H0 Then write_flow_type3_value = get_flow_type3
        If flag_dest_port3 = &H0 Then write_dest_port3_value = get_dest_port3
        If flag_drop_non_redir3 = &H0 Then write_drop_non_redir3_value = get_drop_non_redir3
        If flag_drop_action3 = &H0 Then write_drop_action3_value = get_drop_action3

        regValue = leftShift((write_flow_type0_value and &H1), 0) + leftShift((write_dest_port0_value and &H3), 2) + leftShift((write_drop_non_redir0_value and &H1), 4) + leftShift((write_drop_action0_value and &H3), 6) + leftShift((write_flow_type1_value and &H1), 8) + leftShift((write_dest_port1_value and &H3), 10) + leftShift((write_drop_non_redir1_value and &H1), 12) + leftShift((write_drop_action1_value and &H3), 14) + leftShift((write_flow_type2_value and &H1), 16) + leftShift((write_dest_port2_value and &H3), 18) + leftShift((write_drop_non_redir2_value and &H1), 20) + leftShift((write_drop_action2_value and &H3), 22) + leftShift((write_flow_type3_value and &H1), 24) + leftShift((write_dest_port3_value and &H3), 26) + leftShift((write_drop_non_redir3_value and &H1), 28) + leftShift((write_drop_action3_value and &H3), 30)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type0_mask = &H1
        if data_low > LONG_MAX then
            if flow_type0_mask = mask then
                read_flow_type0_value = data_low
            else
                read_flow_type0_value = (data_low - H8000_0000) and flow_type0_mask
            end If
        else
            read_flow_type0_value = data_low and flow_type0_mask
        end If
        read_dest_port0_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir0_value = rightShift(data_low, 4) and &H1
        read_drop_action0_value = rightShift(data_low, 6) and &H3
        read_flow_type1_value = rightShift(data_low, 8) and &H1
        read_dest_port1_value = rightShift(data_low, 10) and &H3
        read_drop_non_redir1_value = rightShift(data_low, 12) and &H1
        read_drop_action1_value = rightShift(data_low, 14) and &H3
        read_flow_type2_value = rightShift(data_low, 16) and &H1
        read_dest_port2_value = rightShift(data_low, 18) and &H3
        read_drop_non_redir2_value = rightShift(data_low, 20) and &H1
        read_drop_action2_value = rightShift(data_low, 22) and &H3
        read_flow_type3_value = rightShift(data_low, 24) and &H1
        read_dest_port3_value = rightShift(data_low, 26) and &H3
        read_drop_non_redir3_value = rightShift(data_low, 28) and &H1
        read_drop_action3_value = rightShift(data_low, 30) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type0_value = &H0
        flag_flow_type0        = &H0
        write_dest_port0_value = &H0
        flag_dest_port0        = &H0
        write_drop_non_redir0_value = &H0
        flag_drop_non_redir0        = &H0
        write_drop_action0_value = &H0
        flag_drop_action0        = &H0
        write_flow_type1_value = &H0
        flag_flow_type1        = &H0
        write_dest_port1_value = &H0
        flag_dest_port1        = &H0
        write_drop_non_redir1_value = &H0
        flag_drop_non_redir1        = &H0
        write_drop_action1_value = &H0
        flag_drop_action1        = &H0
        write_flow_type2_value = &H0
        flag_flow_type2        = &H0
        write_dest_port2_value = &H0
        flag_dest_port2        = &H0
        write_drop_non_redir2_value = &H0
        flag_drop_non_redir2        = &H0
        write_drop_action2_value = &H0
        flag_drop_action2        = &H0
        write_flow_type3_value = &H0
        flag_flow_type3        = &H0
        write_dest_port3_value = &H0
        flag_dest_port3        = &H0
        write_drop_non_redir3_value = &H0
        flag_drop_non_redir3        = &H0
        write_drop_action3_value = &H0
        flag_drop_action3        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_capt_reason
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ncp_ut_capt_reason                         [3:0]            get_ncp_ut_capt_reason
''                                                             set_ncp_ut_capt_reason
''                                                             read_ncp_ut_capt_reason
''                                                             write_ncp_ut_capt_reason
''---------------------------------------------------------------------------------
'' ncp_vt_capt_reason                         [7:4]            get_ncp_vt_capt_reason
''                                                             set_ncp_vt_capt_reason
''                                                             read_ncp_vt_capt_reason
''                                                             write_ncp_vt_capt_reason
''---------------------------------------------------------------------------------
'' ncp_bt_capt_reason                         [11:8]           get_ncp_bt_capt_reason
''                                                             set_ncp_bt_capt_reason
''                                                             read_ncp_bt_capt_reason
''                                                             write_ncp_bt_capt_reason
''---------------------------------------------------------------------------------
'' ncp_kay_capt_reason                        [15:12]          get_ncp_kay_capt_reason
''                                                             set_ncp_kay_capt_reason
''                                                             read_ncp_kay_capt_reason
''                                                             write_ncp_kay_capt_reason
''---------------------------------------------------------------------------------
'' cp_ut_capt_reason                          [19:16]          get_cp_ut_capt_reason
''                                                             set_cp_ut_capt_reason
''                                                             read_cp_ut_capt_reason
''                                                             write_cp_ut_capt_reason
''---------------------------------------------------------------------------------
'' cp_vt_capt_reason                          [23:20]          get_cp_vt_capt_reason
''                                                             set_cp_vt_capt_reason
''                                                             read_cp_vt_capt_reason
''                                                             write_cp_vt_capt_reason
''---------------------------------------------------------------------------------
'' cp_bt_capt_reason                          [27:24]          get_cp_bt_capt_reason
''                                                             set_cp_bt_capt_reason
''                                                             read_cp_bt_capt_reason
''                                                             write_cp_bt_capt_reason
''---------------------------------------------------------------------------------
'' cp_kay_capt_reason                         [31:28]          get_cp_kay_capt_reason
''                                                             set_cp_kay_capt_reason
''                                                             read_cp_kay_capt_reason
''                                                             write_cp_kay_capt_reason
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_capt_reason
    Private write_ncp_ut_capt_reason_value
    Private read_ncp_ut_capt_reason_value
    Private flag_ncp_ut_capt_reason
    Private write_ncp_vt_capt_reason_value
    Private read_ncp_vt_capt_reason_value
    Private flag_ncp_vt_capt_reason
    Private write_ncp_bt_capt_reason_value
    Private read_ncp_bt_capt_reason_value
    Private flag_ncp_bt_capt_reason
    Private write_ncp_kay_capt_reason_value
    Private read_ncp_kay_capt_reason_value
    Private flag_ncp_kay_capt_reason
    Private write_cp_ut_capt_reason_value
    Private read_cp_ut_capt_reason_value
    Private flag_cp_ut_capt_reason
    Private write_cp_vt_capt_reason_value
    Private read_cp_vt_capt_reason_value
    Private flag_cp_vt_capt_reason
    Private write_cp_bt_capt_reason_value
    Private read_cp_bt_capt_reason_value
    Private flag_cp_bt_capt_reason
    Private write_cp_kay_capt_reason_value
    Private read_cp_kay_capt_reason_value
    Private flag_cp_kay_capt_reason

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1794c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ncp_ut_capt_reason
        get_ncp_ut_capt_reason = read_ncp_ut_capt_reason_value
    End Property

    Property Let set_ncp_ut_capt_reason(aData)
        write_ncp_ut_capt_reason_value = aData
        flag_ncp_ut_capt_reason        = &H1
    End Property

    Property Get read_ncp_ut_capt_reason
        read
        read_ncp_ut_capt_reason = read_ncp_ut_capt_reason_value
    End Property

    Property Let write_ncp_ut_capt_reason(aData)
        set_ncp_ut_capt_reason = aData
        write
    End Property

    Property Get get_ncp_vt_capt_reason
        get_ncp_vt_capt_reason = read_ncp_vt_capt_reason_value
    End Property

    Property Let set_ncp_vt_capt_reason(aData)
        write_ncp_vt_capt_reason_value = aData
        flag_ncp_vt_capt_reason        = &H1
    End Property

    Property Get read_ncp_vt_capt_reason
        read
        read_ncp_vt_capt_reason = read_ncp_vt_capt_reason_value
    End Property

    Property Let write_ncp_vt_capt_reason(aData)
        set_ncp_vt_capt_reason = aData
        write
    End Property

    Property Get get_ncp_bt_capt_reason
        get_ncp_bt_capt_reason = read_ncp_bt_capt_reason_value
    End Property

    Property Let set_ncp_bt_capt_reason(aData)
        write_ncp_bt_capt_reason_value = aData
        flag_ncp_bt_capt_reason        = &H1
    End Property

    Property Get read_ncp_bt_capt_reason
        read
        read_ncp_bt_capt_reason = read_ncp_bt_capt_reason_value
    End Property

    Property Let write_ncp_bt_capt_reason(aData)
        set_ncp_bt_capt_reason = aData
        write
    End Property

    Property Get get_ncp_kay_capt_reason
        get_ncp_kay_capt_reason = read_ncp_kay_capt_reason_value
    End Property

    Property Let set_ncp_kay_capt_reason(aData)
        write_ncp_kay_capt_reason_value = aData
        flag_ncp_kay_capt_reason        = &H1
    End Property

    Property Get read_ncp_kay_capt_reason
        read
        read_ncp_kay_capt_reason = read_ncp_kay_capt_reason_value
    End Property

    Property Let write_ncp_kay_capt_reason(aData)
        set_ncp_kay_capt_reason = aData
        write
    End Property

    Property Get get_cp_ut_capt_reason
        get_cp_ut_capt_reason = read_cp_ut_capt_reason_value
    End Property

    Property Let set_cp_ut_capt_reason(aData)
        write_cp_ut_capt_reason_value = aData
        flag_cp_ut_capt_reason        = &H1
    End Property

    Property Get read_cp_ut_capt_reason
        read
        read_cp_ut_capt_reason = read_cp_ut_capt_reason_value
    End Property

    Property Let write_cp_ut_capt_reason(aData)
        set_cp_ut_capt_reason = aData
        write
    End Property

    Property Get get_cp_vt_capt_reason
        get_cp_vt_capt_reason = read_cp_vt_capt_reason_value
    End Property

    Property Let set_cp_vt_capt_reason(aData)
        write_cp_vt_capt_reason_value = aData
        flag_cp_vt_capt_reason        = &H1
    End Property

    Property Get read_cp_vt_capt_reason
        read
        read_cp_vt_capt_reason = read_cp_vt_capt_reason_value
    End Property

    Property Let write_cp_vt_capt_reason(aData)
        set_cp_vt_capt_reason = aData
        write
    End Property

    Property Get get_cp_bt_capt_reason
        get_cp_bt_capt_reason = read_cp_bt_capt_reason_value
    End Property

    Property Let set_cp_bt_capt_reason(aData)
        write_cp_bt_capt_reason_value = aData
        flag_cp_bt_capt_reason        = &H1
    End Property

    Property Get read_cp_bt_capt_reason
        read
        read_cp_bt_capt_reason = read_cp_bt_capt_reason_value
    End Property

    Property Let write_cp_bt_capt_reason(aData)
        set_cp_bt_capt_reason = aData
        write
    End Property

    Property Get get_cp_kay_capt_reason
        get_cp_kay_capt_reason = read_cp_kay_capt_reason_value
    End Property

    Property Let set_cp_kay_capt_reason(aData)
        write_cp_kay_capt_reason_value = aData
        flag_cp_kay_capt_reason        = &H1
    End Property

    Property Get read_cp_kay_capt_reason
        read
        read_cp_kay_capt_reason = read_cp_kay_capt_reason_value
    End Property

    Property Let write_cp_kay_capt_reason(aData)
        set_cp_kay_capt_reason = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ncp_ut_capt_reason_mask = &Hf
        if data_low > LONG_MAX then
            if ncp_ut_capt_reason_mask = mask then
                read_ncp_ut_capt_reason_value = data_low
            else
                read_ncp_ut_capt_reason_value = (data_low - H8000_0000) and ncp_ut_capt_reason_mask
            end If
        else
            read_ncp_ut_capt_reason_value = data_low and ncp_ut_capt_reason_mask
        end If
        read_ncp_vt_capt_reason_value = rightShift(data_low, 4) and &Hf
        read_ncp_bt_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_ncp_kay_capt_reason_value = rightShift(data_low, 12) and &Hf
        read_cp_ut_capt_reason_value = rightShift(data_low, 16) and &Hf
        read_cp_vt_capt_reason_value = rightShift(data_low, 20) and &Hf
        read_cp_bt_capt_reason_value = rightShift(data_low, 24) and &Hf
        read_cp_kay_capt_reason_value = rightShift(data_low, 28) and &Hf

    End Sub

    Sub write
        If flag_ncp_ut_capt_reason = &H0 or flag_ncp_vt_capt_reason = &H0 or flag_ncp_bt_capt_reason = &H0 or flag_ncp_kay_capt_reason = &H0 or flag_cp_ut_capt_reason = &H0 or flag_cp_vt_capt_reason = &H0 or flag_cp_bt_capt_reason = &H0 or flag_cp_kay_capt_reason = &H0 Then read
        If flag_ncp_ut_capt_reason = &H0 Then write_ncp_ut_capt_reason_value = get_ncp_ut_capt_reason
        If flag_ncp_vt_capt_reason = &H0 Then write_ncp_vt_capt_reason_value = get_ncp_vt_capt_reason
        If flag_ncp_bt_capt_reason = &H0 Then write_ncp_bt_capt_reason_value = get_ncp_bt_capt_reason
        If flag_ncp_kay_capt_reason = &H0 Then write_ncp_kay_capt_reason_value = get_ncp_kay_capt_reason
        If flag_cp_ut_capt_reason = &H0 Then write_cp_ut_capt_reason_value = get_cp_ut_capt_reason
        If flag_cp_vt_capt_reason = &H0 Then write_cp_vt_capt_reason_value = get_cp_vt_capt_reason
        If flag_cp_bt_capt_reason = &H0 Then write_cp_bt_capt_reason_value = get_cp_bt_capt_reason
        If flag_cp_kay_capt_reason = &H0 Then write_cp_kay_capt_reason_value = get_cp_kay_capt_reason

        regValue = leftShift((write_ncp_ut_capt_reason_value and &Hf), 0) + leftShift((write_ncp_vt_capt_reason_value and &Hf), 4) + leftShift((write_ncp_bt_capt_reason_value and &Hf), 8) + leftShift((write_ncp_kay_capt_reason_value and &Hf), 12) + leftShift((write_cp_ut_capt_reason_value and &Hf), 16) + leftShift((write_cp_vt_capt_reason_value and &Hf), 20) + leftShift((write_cp_bt_capt_reason_value and &Hf), 24) + leftShift((write_cp_kay_capt_reason_value and &Hf), 28)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ncp_ut_capt_reason_mask = &Hf
        if data_low > LONG_MAX then
            if ncp_ut_capt_reason_mask = mask then
                read_ncp_ut_capt_reason_value = data_low
            else
                read_ncp_ut_capt_reason_value = (data_low - H8000_0000) and ncp_ut_capt_reason_mask
            end If
        else
            read_ncp_ut_capt_reason_value = data_low and ncp_ut_capt_reason_mask
        end If
        read_ncp_vt_capt_reason_value = rightShift(data_low, 4) and &Hf
        read_ncp_bt_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_ncp_kay_capt_reason_value = rightShift(data_low, 12) and &Hf
        read_cp_ut_capt_reason_value = rightShift(data_low, 16) and &Hf
        read_cp_vt_capt_reason_value = rightShift(data_low, 20) and &Hf
        read_cp_bt_capt_reason_value = rightShift(data_low, 24) and &Hf
        read_cp_kay_capt_reason_value = rightShift(data_low, 28) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ncp_ut_capt_reason_value = &H0
        flag_ncp_ut_capt_reason        = &H0
        write_ncp_vt_capt_reason_value = &H0
        flag_ncp_vt_capt_reason        = &H0
        write_ncp_bt_capt_reason_value = &H0
        flag_ncp_bt_capt_reason        = &H0
        write_ncp_kay_capt_reason_value = &H0
        flag_ncp_kay_capt_reason        = &H0
        write_cp_ut_capt_reason_value = &H0
        flag_cp_ut_capt_reason        = &H0
        write_cp_vt_capt_reason_value = &H0
        flag_cp_vt_capt_reason        = &H0
        write_cp_bt_capt_reason_value = &H0
        flag_cp_bt_capt_reason        = &H0
        write_cp_kay_capt_reason_value = &H0
        flag_cp_kay_capt_reason        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_dyn_latency_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mc_dyn_latency_words                       [4:0]            get_mc_dyn_latency_words
''                                                             set_mc_dyn_latency_words
''                                                             read_mc_dyn_latency_words
''                                                             write_mc_dyn_latency_words
''---------------------------------------------------------------------------------
'' dyn_lat_enable                             [31:31]          get_dyn_lat_enable
''                                                             set_dyn_lat_enable
''                                                             read_dyn_lat_enable
''                                                             write_dyn_lat_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_dyn_latency_control
    Private write_mc_dyn_latency_words_value
    Private read_mc_dyn_latency_words_value
    Private flag_mc_dyn_latency_words
    Private write_dyn_lat_enable_value
    Private read_dyn_lat_enable_value
    Private flag_dyn_lat_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17978
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mc_dyn_latency_words
        get_mc_dyn_latency_words = read_mc_dyn_latency_words_value
    End Property

    Property Let set_mc_dyn_latency_words(aData)
        write_mc_dyn_latency_words_value = aData
        flag_mc_dyn_latency_words        = &H1
    End Property

    Property Get read_mc_dyn_latency_words
        read
        read_mc_dyn_latency_words = read_mc_dyn_latency_words_value
    End Property

    Property Let write_mc_dyn_latency_words(aData)
        set_mc_dyn_latency_words = aData
        write
    End Property

    Property Get get_dyn_lat_enable
        get_dyn_lat_enable = read_dyn_lat_enable_value
    End Property

    Property Let set_dyn_lat_enable(aData)
        write_dyn_lat_enable_value = aData
        flag_dyn_lat_enable        = &H1
    End Property

    Property Get read_dyn_lat_enable
        read
        read_dyn_lat_enable = read_dyn_lat_enable_value
    End Property

    Property Let write_dyn_lat_enable(aData)
        set_dyn_lat_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mc_dyn_latency_words_mask = &H1f
        if data_low > LONG_MAX then
            if mc_dyn_latency_words_mask = mask then
                read_mc_dyn_latency_words_value = data_low
            else
                read_mc_dyn_latency_words_value = (data_low - H8000_0000) and mc_dyn_latency_words_mask
            end If
        else
            read_mc_dyn_latency_words_value = data_low and mc_dyn_latency_words_mask
        end If
        read_dyn_lat_enable_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_mc_dyn_latency_words = &H0 or flag_dyn_lat_enable = &H0 Then read
        If flag_mc_dyn_latency_words = &H0 Then write_mc_dyn_latency_words_value = get_mc_dyn_latency_words
        If flag_dyn_lat_enable = &H0 Then write_dyn_lat_enable_value = get_dyn_lat_enable

        regValue = leftShift((write_mc_dyn_latency_words_value and &H1f), 0) + leftShift((write_dyn_lat_enable_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mc_dyn_latency_words_mask = &H1f
        if data_low > LONG_MAX then
            if mc_dyn_latency_words_mask = mask then
                read_mc_dyn_latency_words_value = data_low
            else
                read_mc_dyn_latency_words_value = (data_low - H8000_0000) and mc_dyn_latency_words_mask
            end If
        else
            read_mc_dyn_latency_words_value = data_low and mc_dyn_latency_words_mask
        end If
        read_dyn_lat_enable_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mc_dyn_latency_words_value = &H0
        flag_mc_dyn_latency_words        = &H0
        write_dyn_lat_enable_value = &H0
        flag_dyn_lat_enable        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_misc_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mc_latency_fix                             [7:0]            get_mc_latency_fix
''                                                             set_mc_latency_fix
''                                                             read_mc_latency_fix
''                                                             write_mc_latency_fix
''---------------------------------------------------------------------------------
'' static_bypass                              [8:8]            get_static_bypass
''                                                             set_static_bypass
''                                                             read_static_bypass
''                                                             write_static_bypass
''---------------------------------------------------------------------------------
'' nm_macsec_en                               [9:9]            get_nm_macsec_en
''                                                             set_nm_macsec_en
''                                                             read_nm_macsec_en
''                                                             write_nm_macsec_en
''---------------------------------------------------------------------------------
'' validate_frames                            [11:10]          get_validate_frames
''                                                             set_validate_frames
''                                                             read_validate_frames
''                                                             write_validate_frames
''---------------------------------------------------------------------------------
'' bypass_noclass                             [12:12]          get_bypass_noclass
''                                                             set_bypass_noclass
''                                                             read_bypass_noclass
''                                                             write_bypass_noclass
''---------------------------------------------------------------------------------
'' drop_on_pkterr                             [14:14]          get_drop_on_pkterr
''                                                             set_drop_on_pkterr
''                                                             read_drop_on_pkterr
''                                                             write_drop_on_pkterr
''---------------------------------------------------------------------------------
'' drop_on_crcerr                             [15:15]          get_drop_on_crcerr
''                                                             set_drop_on_crcerr
''                                                             read_drop_on_crcerr
''                                                             write_drop_on_crcerr
''---------------------------------------------------------------------------------
'' err_drop_action                            [17:16]          get_err_drop_action
''                                                             set_err_drop_action
''                                                             read_err_drop_action
''                                                             write_err_drop_action
''---------------------------------------------------------------------------------
'' err_dest_port                              [19:18]          get_err_dest_port
''                                                             set_err_dest_port
''                                                             read_err_dest_port
''                                                             write_err_dest_port
''---------------------------------------------------------------------------------
'' err_capt_reason                            [21:20]          get_err_capt_reason
''                                                             set_err_capt_reason
''                                                             read_err_capt_reason
''                                                             write_err_capt_reason
''---------------------------------------------------------------------------------
'' xform_rec_size                             [25:24]          get_xform_rec_size
''                                                             set_xform_rec_size
''                                                             read_xform_rec_size
''                                                             write_xform_rec_size
''---------------------------------------------------------------------------------
'' mc_latency_fix_hi                          [31:26]          get_mc_latency_fix_hi
''                                                             set_mc_latency_fix_hi
''                                                             read_mc_latency_fix_hi
''                                                             write_mc_latency_fix_hi
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_misc_control
    Private write_mc_latency_fix_value
    Private read_mc_latency_fix_value
    Private flag_mc_latency_fix
    Private write_static_bypass_value
    Private read_static_bypass_value
    Private flag_static_bypass
    Private write_nm_macsec_en_value
    Private read_nm_macsec_en_value
    Private flag_nm_macsec_en
    Private write_validate_frames_value
    Private read_validate_frames_value
    Private flag_validate_frames
    Private write_bypass_noclass_value
    Private read_bypass_noclass_value
    Private flag_bypass_noclass
    Private write_drop_on_pkterr_value
    Private read_drop_on_pkterr_value
    Private flag_drop_on_pkterr
    Private write_drop_on_crcerr_value
    Private read_drop_on_crcerr_value
    Private flag_drop_on_crcerr
    Private write_err_drop_action_value
    Private read_err_drop_action_value
    Private flag_err_drop_action
    Private write_err_dest_port_value
    Private read_err_dest_port_value
    Private flag_err_dest_port
    Private write_err_capt_reason_value
    Private read_err_capt_reason_value
    Private flag_err_capt_reason
    Private write_xform_rec_size_value
    Private read_xform_rec_size_value
    Private flag_xform_rec_size
    Private write_mc_latency_fix_hi_value
    Private read_mc_latency_fix_hi_value
    Private flag_mc_latency_fix_hi

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1797c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mc_latency_fix
        get_mc_latency_fix = read_mc_latency_fix_value
    End Property

    Property Let set_mc_latency_fix(aData)
        write_mc_latency_fix_value = aData
        flag_mc_latency_fix        = &H1
    End Property

    Property Get read_mc_latency_fix
        read
        read_mc_latency_fix = read_mc_latency_fix_value
    End Property

    Property Let write_mc_latency_fix(aData)
        set_mc_latency_fix = aData
        write
    End Property

    Property Get get_static_bypass
        get_static_bypass = read_static_bypass_value
    End Property

    Property Let set_static_bypass(aData)
        write_static_bypass_value = aData
        flag_static_bypass        = &H1
    End Property

    Property Get read_static_bypass
        read
        read_static_bypass = read_static_bypass_value
    End Property

    Property Let write_static_bypass(aData)
        set_static_bypass = aData
        write
    End Property

    Property Get get_nm_macsec_en
        get_nm_macsec_en = read_nm_macsec_en_value
    End Property

    Property Let set_nm_macsec_en(aData)
        write_nm_macsec_en_value = aData
        flag_nm_macsec_en        = &H1
    End Property

    Property Get read_nm_macsec_en
        read
        read_nm_macsec_en = read_nm_macsec_en_value
    End Property

    Property Let write_nm_macsec_en(aData)
        set_nm_macsec_en = aData
        write
    End Property

    Property Get get_validate_frames
        get_validate_frames = read_validate_frames_value
    End Property

    Property Let set_validate_frames(aData)
        write_validate_frames_value = aData
        flag_validate_frames        = &H1
    End Property

    Property Get read_validate_frames
        read
        read_validate_frames = read_validate_frames_value
    End Property

    Property Let write_validate_frames(aData)
        set_validate_frames = aData
        write
    End Property

    Property Get get_bypass_noclass
        get_bypass_noclass = read_bypass_noclass_value
    End Property

    Property Let set_bypass_noclass(aData)
        write_bypass_noclass_value = aData
        flag_bypass_noclass        = &H1
    End Property

    Property Get read_bypass_noclass
        read
        read_bypass_noclass = read_bypass_noclass_value
    End Property

    Property Let write_bypass_noclass(aData)
        set_bypass_noclass = aData
        write
    End Property

    Property Get get_drop_on_pkterr
        get_drop_on_pkterr = read_drop_on_pkterr_value
    End Property

    Property Let set_drop_on_pkterr(aData)
        write_drop_on_pkterr_value = aData
        flag_drop_on_pkterr        = &H1
    End Property

    Property Get read_drop_on_pkterr
        read
        read_drop_on_pkterr = read_drop_on_pkterr_value
    End Property

    Property Let write_drop_on_pkterr(aData)
        set_drop_on_pkterr = aData
        write
    End Property

    Property Get get_drop_on_crcerr
        get_drop_on_crcerr = read_drop_on_crcerr_value
    End Property

    Property Let set_drop_on_crcerr(aData)
        write_drop_on_crcerr_value = aData
        flag_drop_on_crcerr        = &H1
    End Property

    Property Get read_drop_on_crcerr
        read
        read_drop_on_crcerr = read_drop_on_crcerr_value
    End Property

    Property Let write_drop_on_crcerr(aData)
        set_drop_on_crcerr = aData
        write
    End Property

    Property Get get_err_drop_action
        get_err_drop_action = read_err_drop_action_value
    End Property

    Property Let set_err_drop_action(aData)
        write_err_drop_action_value = aData
        flag_err_drop_action        = &H1
    End Property

    Property Get read_err_drop_action
        read
        read_err_drop_action = read_err_drop_action_value
    End Property

    Property Let write_err_drop_action(aData)
        set_err_drop_action = aData
        write
    End Property

    Property Get get_err_dest_port
        get_err_dest_port = read_err_dest_port_value
    End Property

    Property Let set_err_dest_port(aData)
        write_err_dest_port_value = aData
        flag_err_dest_port        = &H1
    End Property

    Property Get read_err_dest_port
        read
        read_err_dest_port = read_err_dest_port_value
    End Property

    Property Let write_err_dest_port(aData)
        set_err_dest_port = aData
        write
    End Property

    Property Get get_err_capt_reason
        get_err_capt_reason = read_err_capt_reason_value
    End Property

    Property Let set_err_capt_reason(aData)
        write_err_capt_reason_value = aData
        flag_err_capt_reason        = &H1
    End Property

    Property Get read_err_capt_reason
        read
        read_err_capt_reason = read_err_capt_reason_value
    End Property

    Property Let write_err_capt_reason(aData)
        set_err_capt_reason = aData
        write
    End Property

    Property Get get_xform_rec_size
        get_xform_rec_size = read_xform_rec_size_value
    End Property

    Property Let set_xform_rec_size(aData)
        write_xform_rec_size_value = aData
        flag_xform_rec_size        = &H1
    End Property

    Property Get read_xform_rec_size
        read
        read_xform_rec_size = read_xform_rec_size_value
    End Property

    Property Let write_xform_rec_size(aData)
        set_xform_rec_size = aData
        write
    End Property

    Property Get get_mc_latency_fix_hi
        get_mc_latency_fix_hi = read_mc_latency_fix_hi_value
    End Property

    Property Let set_mc_latency_fix_hi(aData)
        write_mc_latency_fix_hi_value = aData
        flag_mc_latency_fix_hi        = &H1
    End Property

    Property Get read_mc_latency_fix_hi
        read
        read_mc_latency_fix_hi = read_mc_latency_fix_hi_value
    End Property

    Property Let write_mc_latency_fix_hi(aData)
        set_mc_latency_fix_hi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mc_latency_fix_mask = &Hff
        if data_low > LONG_MAX then
            if mc_latency_fix_mask = mask then
                read_mc_latency_fix_value = data_low
            else
                read_mc_latency_fix_value = (data_low - H8000_0000) and mc_latency_fix_mask
            end If
        else
            read_mc_latency_fix_value = data_low and mc_latency_fix_mask
        end If
        read_static_bypass_value = rightShift(data_low, 8) and &H1
        read_nm_macsec_en_value = rightShift(data_low, 9) and &H1
        read_validate_frames_value = rightShift(data_low, 10) and &H3
        read_bypass_noclass_value = rightShift(data_low, 12) and &H1
        read_drop_on_pkterr_value = rightShift(data_low, 14) and &H1
        read_drop_on_crcerr_value = rightShift(data_low, 15) and &H1
        read_err_drop_action_value = rightShift(data_low, 16) and &H3
        read_err_dest_port_value = rightShift(data_low, 18) and &H3
        read_err_capt_reason_value = rightShift(data_low, 20) and &H3
        read_xform_rec_size_value = rightShift(data_low, 24) and &H3
        read_mc_latency_fix_hi_value = rightShift(data_low, 26) and &H3f

    End Sub

    Sub write
        If flag_mc_latency_fix = &H0 or flag_static_bypass = &H0 or flag_nm_macsec_en = &H0 or flag_validate_frames = &H0 or flag_bypass_noclass = &H0 or flag_drop_on_pkterr = &H0 or flag_drop_on_crcerr = &H0 or flag_err_drop_action = &H0 or flag_err_dest_port = &H0 or flag_err_capt_reason = &H0 or flag_xform_rec_size = &H0 or flag_mc_latency_fix_hi = &H0 Then read
        If flag_mc_latency_fix = &H0 Then write_mc_latency_fix_value = get_mc_latency_fix
        If flag_static_bypass = &H0 Then write_static_bypass_value = get_static_bypass
        If flag_nm_macsec_en = &H0 Then write_nm_macsec_en_value = get_nm_macsec_en
        If flag_validate_frames = &H0 Then write_validate_frames_value = get_validate_frames
        If flag_bypass_noclass = &H0 Then write_bypass_noclass_value = get_bypass_noclass
        If flag_drop_on_pkterr = &H0 Then write_drop_on_pkterr_value = get_drop_on_pkterr
        If flag_drop_on_crcerr = &H0 Then write_drop_on_crcerr_value = get_drop_on_crcerr
        If flag_err_drop_action = &H0 Then write_err_drop_action_value = get_err_drop_action
        If flag_err_dest_port = &H0 Then write_err_dest_port_value = get_err_dest_port
        If flag_err_capt_reason = &H0 Then write_err_capt_reason_value = get_err_capt_reason
        If flag_xform_rec_size = &H0 Then write_xform_rec_size_value = get_xform_rec_size
        If flag_mc_latency_fix_hi = &H0 Then write_mc_latency_fix_hi_value = get_mc_latency_fix_hi

        regValue = leftShift((write_mc_latency_fix_value and &Hff), 0) + leftShift((write_static_bypass_value and &H1), 8) + leftShift((write_nm_macsec_en_value and &H1), 9) + leftShift((write_validate_frames_value and &H3), 10) + leftShift((write_bypass_noclass_value and &H1), 12) + leftShift((write_drop_on_pkterr_value and &H1), 14) + leftShift((write_drop_on_crcerr_value and &H1), 15) + leftShift((write_err_drop_action_value and &H3), 16) + leftShift((write_err_dest_port_value and &H3), 18) + leftShift((write_err_capt_reason_value and &H3), 20) + leftShift((write_xform_rec_size_value and &H3), 24) + leftShift((write_mc_latency_fix_hi_value and &H3f), 26)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mc_latency_fix_mask = &Hff
        if data_low > LONG_MAX then
            if mc_latency_fix_mask = mask then
                read_mc_latency_fix_value = data_low
            else
                read_mc_latency_fix_value = (data_low - H8000_0000) and mc_latency_fix_mask
            end If
        else
            read_mc_latency_fix_value = data_low and mc_latency_fix_mask
        end If
        read_static_bypass_value = rightShift(data_low, 8) and &H1
        read_nm_macsec_en_value = rightShift(data_low, 9) and &H1
        read_validate_frames_value = rightShift(data_low, 10) and &H3
        read_bypass_noclass_value = rightShift(data_low, 12) and &H1
        read_drop_on_pkterr_value = rightShift(data_low, 14) and &H1
        read_drop_on_crcerr_value = rightShift(data_low, 15) and &H1
        read_err_drop_action_value = rightShift(data_low, 16) and &H3
        read_err_dest_port_value = rightShift(data_low, 18) and &H3
        read_err_capt_reason_value = rightShift(data_low, 20) and &H3
        read_xform_rec_size_value = rightShift(data_low, 24) and &H3
        read_mc_latency_fix_hi_value = rightShift(data_low, 26) and &H3f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mc_latency_fix_value = &H0
        flag_mc_latency_fix        = &H0
        write_static_bypass_value = &H0
        flag_static_bypass        = &H0
        write_nm_macsec_en_value = &H0
        flag_nm_macsec_en        = &H0
        write_validate_frames_value = &H0
        flag_validate_frames        = &H0
        write_bypass_noclass_value = &H0
        flag_bypass_noclass        = &H0
        write_drop_on_pkterr_value = &H0
        flag_drop_on_pkterr        = &H0
        write_drop_on_crcerr_value = &H0
        flag_drop_on_crcerr        = &H0
        write_err_drop_action_value = &H0
        flag_err_drop_action        = &H0
        write_err_dest_port_value = &H0
        flag_err_dest_port        = &H0
        write_err_capt_reason_value = &H0
        flag_err_capt_reason        = &H0
        write_xform_rec_size_value = &H0
        flag_xform_rec_size        = &H0
        write_mc_latency_fix_hi_value = &H0
        flag_mc_latency_fix_hi        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_crypt_auth_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bypass_len                                 [7:0]            get_bypass_len
''                                                             set_bypass_len
''                                                             read_bypass_len
''                                                             write_bypass_len
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_crypt_auth_ctrl
    Private write_bypass_len_value
    Private read_bypass_len_value
    Private flag_bypass_len

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17984
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_bypass_len
        get_bypass_len = read_bypass_len_value
    End Property

    Property Let set_bypass_len(aData)
        write_bypass_len_value = aData
        flag_bypass_len        = &H1
    End Property

    Property Get read_bypass_len
        read
        read_bypass_len = read_bypass_len_value
    End Property

    Property Let write_bypass_len(aData)
        set_bypass_len = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bypass_len_mask = &Hff
        if data_low > LONG_MAX then
            if bypass_len_mask = mask then
                read_bypass_len_value = data_low
            else
                read_bypass_len_value = (data_low - H8000_0000) and bypass_len_mask
            end If
        else
            read_bypass_len_value = data_low and bypass_len_mask
        end If

    End Sub

    Sub write
        If flag_bypass_len = &H0 Then read
        If flag_bypass_len = &H0 Then write_bypass_len_value = get_bypass_len

        regValue = leftShift((write_bypass_len_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bypass_len_mask = &Hff
        if data_low > LONG_MAX then
            if bypass_len_mask = mask then
                read_bypass_len_value = data_low
            else
                read_bypass_len_value = (data_low - H8000_0000) and bypass_len_mask
            end If
        else
            read_bypass_len_value = data_low and bypass_len_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bypass_len_value = &H0
        flag_bypass_len        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sa_exp_summary1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_31_0                                    [31:0]           get_sa_31_0
''                                                             set_sa_31_0
''                                                             read_sa_31_0
''                                                             write_sa_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sa_exp_summary1
    Private write_sa_31_0_value
    Private read_sa_31_0_value
    Private flag_sa_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17a00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_31_0
        get_sa_31_0 = read_sa_31_0_value
    End Property

    Property Let set_sa_31_0(aData)
        write_sa_31_0_value = aData
        flag_sa_31_0        = &H1
    End Property

    Property Get read_sa_31_0
        read
        read_sa_31_0 = read_sa_31_0_value
    End Property

    Property Let write_sa_31_0(aData)
        set_sa_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sa_31_0_mask = mask then
                read_sa_31_0_value = data_low
            else
                read_sa_31_0_value = (data_low - H8000_0000) and sa_31_0_mask
            end If
        else
            read_sa_31_0_value = data_low and sa_31_0_mask
        end If

    End Sub

    Sub write
        If flag_sa_31_0 = &H0 Then read
        If flag_sa_31_0 = &H0 Then write_sa_31_0_value = get_sa_31_0

        regValue = leftShift(write_sa_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sa_31_0_mask = mask then
                read_sa_31_0_value = data_low
            else
                read_sa_31_0_value = (data_low - H8000_0000) and sa_31_0_mask
            end If
        else
            read_sa_31_0_value = data_low and sa_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_31_0_value = &H0
        flag_sa_31_0        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE

    Public sam_cp_tag
    Public sam_pp_tags
    Public sam_pp_tags2
    Public sam_cp_tag2
    Public pbb_etype
    Public pbb_enb_select
    Public st_vlan_etype
    Public egress_hdr_etype
    Public mpls_etype1
    Public mpls_etype2
    Public mpls_enb_select
    Public cp_etype_max_len
    Public cp_etype_jumbo
    Public llc_snap_value
    Public llc_snap_mask
    Public sam_nm_params
    Public sam_nm_flow_ncp
    Public sam_nm_flow_cp
    Public sam_nm_flow_capt_reason
    Public dyn_latency_control
    Public misc_control
    Public crypt_auth_ctrl
    Public sa_exp_summary1


    Public default function Init(aBaseAddr)
        Set sam_cp_tag = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_cp_tag)(aBaseAddr, 32)
        Set sam_pp_tags = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_pp_tags)(aBaseAddr, 32)
        Set sam_pp_tags2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_pp_tags2)(aBaseAddr, 32)
        Set sam_cp_tag2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_cp_tag2)(aBaseAddr, 32)
        Set pbb_etype = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_pbb_etype)(aBaseAddr, 32)
        Set pbb_enb_select = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_pbb_enb_select)(aBaseAddr, 32)
        Set st_vlan_etype = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_st_vlan_etype)(aBaseAddr, 32)
        Set egress_hdr_etype = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_egress_hdr_etype)(aBaseAddr, 32)
        Set mpls_etype1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_etype1)(aBaseAddr, 32)
        Set mpls_etype2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_etype2)(aBaseAddr, 32)
        Set mpls_enb_select = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_mpls_enb_select)(aBaseAddr, 32)
        Set cp_etype_max_len = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_cp_etype_max_len)(aBaseAddr, 32)
        Set cp_etype_jumbo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_cp_etype_jumbo)(aBaseAddr, 32)
        Set llc_snap_value = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_llc_snap_value)(aBaseAddr, 32)
        Set llc_snap_mask = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_llc_snap_mask)(aBaseAddr, 32)
        Set sam_nm_params = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_params)(aBaseAddr, 32)
        Set sam_nm_flow_ncp = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_ncp)(aBaseAddr, 32)
        Set sam_nm_flow_cp = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_cp)(aBaseAddr, 32)
        Set sam_nm_flow_capt_reason = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sam_nm_flow_capt_reason)(aBaseAddr, 32)
        Set dyn_latency_control = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_dyn_latency_control)(aBaseAddr, 32)
        Set misc_control = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_misc_control)(aBaseAddr, 32)
        Set crypt_auth_ctrl = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_crypt_auth_ctrl)(aBaseAddr, 32)
        Set sa_exp_summary1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_sa_exp_summary1)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_VARIOUS_CONTROL_REGS_INSTANCE)(&H4d510000))


