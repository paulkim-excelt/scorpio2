

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


'' @REGISTER : SPUM_APB_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pen_mode                                   [31:30]          get_pen_mode
''                                                             set_pen_mode
''                                                             read_pen_mode
''                                                             write_pen_mode
''---------------------------------------------------------------------------------
'' bd_suppress                                [19:19]          get_bd_suppress
''                                                             set_bd_suppress
''                                                             read_bd_suppress
''                                                             write_bd_suppress
''---------------------------------------------------------------------------------
'' cle_format_en                              [18:18]          get_cle_format_en
''                                                             set_cle_format_en
''                                                             read_cle_format_en
''                                                             write_cle_format_en
''---------------------------------------------------------------------------------
'' out_endian                                 [12:12]          get_out_endian
''                                                             set_out_endian
''                                                             read_out_endian
''                                                             write_out_endian
''---------------------------------------------------------------------------------
'' in_endian                                  [11:11]          get_in_endian
''                                                             set_in_endian
''                                                             read_in_endian
''                                                             write_in_endian
''---------------------------------------------------------------------------------
'' soft_rst                                   [1:1]            get_soft_rst
''                                                             set_soft_rst
''                                                             read_soft_rst
''                                                             write_soft_rst
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_ctrl
    Private write_pen_mode_value
    Private read_pen_mode_value
    Private flag_pen_mode
    Private write_bd_suppress_value
    Private read_bd_suppress_value
    Private flag_bd_suppress
    Private write_cle_format_en_value
    Private read_cle_format_en_value
    Private flag_cle_format_en
    Private write_out_endian_value
    Private read_out_endian_value
    Private flag_out_endian
    Private write_in_endian_value
    Private read_in_endian_value
    Private flag_in_endian
    Private write_soft_rst_value
    Private read_soft_rst_value
    Private flag_soft_rst

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

    Property Get get_pen_mode
        get_pen_mode = read_pen_mode_value
    End Property

    Property Let set_pen_mode(aData)
        write_pen_mode_value = aData
        flag_pen_mode        = &H1
    End Property

    Property Get read_pen_mode
        read
        read_pen_mode = read_pen_mode_value
    End Property

    Property Let write_pen_mode(aData)
        set_pen_mode = aData
        write
    End Property

    Property Get get_bd_suppress
        get_bd_suppress = read_bd_suppress_value
    End Property

    Property Let set_bd_suppress(aData)
        write_bd_suppress_value = aData
        flag_bd_suppress        = &H1
    End Property

    Property Get read_bd_suppress
        read
        read_bd_suppress = read_bd_suppress_value
    End Property

    Property Let write_bd_suppress(aData)
        set_bd_suppress = aData
        write
    End Property

    Property Get get_cle_format_en
        get_cle_format_en = read_cle_format_en_value
    End Property

    Property Let set_cle_format_en(aData)
        write_cle_format_en_value = aData
        flag_cle_format_en        = &H1
    End Property

    Property Get read_cle_format_en
        read
        read_cle_format_en = read_cle_format_en_value
    End Property

    Property Let write_cle_format_en(aData)
        set_cle_format_en = aData
        write
    End Property

    Property Get get_out_endian
        get_out_endian = read_out_endian_value
    End Property

    Property Let set_out_endian(aData)
        write_out_endian_value = aData
        flag_out_endian        = &H1
    End Property

    Property Get read_out_endian
        read
        read_out_endian = read_out_endian_value
    End Property

    Property Let write_out_endian(aData)
        set_out_endian = aData
        write
    End Property

    Property Get get_in_endian
        get_in_endian = read_in_endian_value
    End Property

    Property Let set_in_endian(aData)
        write_in_endian_value = aData
        flag_in_endian        = &H1
    End Property

    Property Get read_in_endian
        read
        read_in_endian = read_in_endian_value
    End Property

    Property Let write_in_endian(aData)
        set_in_endian = aData
        write
    End Property

    Property Get get_soft_rst
        get_soft_rst = read_soft_rst_value
    End Property

    Property Let set_soft_rst(aData)
        write_soft_rst_value = aData
        flag_soft_rst        = &H1
    End Property

    Property Get read_soft_rst
        read
        read_soft_rst = read_soft_rst_value
    End Property

    Property Let write_soft_rst(aData)
        set_soft_rst = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pen_mode_value = rightShift(data_low, 30) and &H3
        read_bd_suppress_value = rightShift(data_low, 19) and &H1
        read_cle_format_en_value = rightShift(data_low, 18) and &H1
        read_out_endian_value = rightShift(data_low, 12) and &H1
        read_in_endian_value = rightShift(data_low, 11) and &H1
        read_soft_rst_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_pen_mode = &H0 or flag_bd_suppress = &H0 or flag_cle_format_en = &H0 or flag_out_endian = &H0 or flag_in_endian = &H0 or flag_soft_rst = &H0 Then read
        If flag_pen_mode = &H0 Then write_pen_mode_value = get_pen_mode
        If flag_bd_suppress = &H0 Then write_bd_suppress_value = get_bd_suppress
        If flag_cle_format_en = &H0 Then write_cle_format_en_value = get_cle_format_en
        If flag_out_endian = &H0 Then write_out_endian_value = get_out_endian
        If flag_in_endian = &H0 Then write_in_endian_value = get_in_endian
        If flag_soft_rst = &H0 Then write_soft_rst_value = get_soft_rst

        regValue = leftShift((write_pen_mode_value and &H3), 30) + leftShift((write_bd_suppress_value and &H1), 19) + leftShift((write_cle_format_en_value and &H1), 18) + leftShift((write_out_endian_value and &H1), 12) + leftShift((write_in_endian_value and &H1), 11) + leftShift((write_soft_rst_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pen_mode_value = rightShift(data_low, 30) and &H3
        read_bd_suppress_value = rightShift(data_low, 19) and &H1
        read_cle_format_en_value = rightShift(data_low, 18) and &H1
        read_out_endian_value = rightShift(data_low, 12) and &H1
        read_in_endian_value = rightShift(data_low, 11) and &H1
        read_soft_rst_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pen_mode_value = &H0
        flag_pen_mode        = &H0
        write_bd_suppress_value = &H0
        flag_bd_suppress        = &H0
        write_cle_format_en_value = &H0
        flag_cle_format_en        = &H0
        write_out_endian_value = &H0
        flag_out_endian        = &H0
        write_in_endian_value = &H0
        flag_in_endian        = &H0
        write_soft_rst_value = &H0
        flag_soft_rst        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_kek_cs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' key_cache_err                              [31:31]          get_key_cache_err
''                                                             set_key_cache_err
''                                                             read_key_cache_err
''                                                             write_key_cache_err
''---------------------------------------------------------------------------------
'' key_cache_en                               [23:23]          get_key_cache_en
''                                                             set_key_cache_en
''                                                             read_key_cache_en
''                                                             write_key_cache_en
''---------------------------------------------------------------------------------
'' disable_dout                               [22:22]          get_disable_dout
''                                                             set_disable_dout
''                                                             read_disable_dout
''                                                             write_disable_dout
''---------------------------------------------------------------------------------
'' flush_key_cache                            [1:1]            get_flush_key_cache
''                                                             set_flush_key_cache
''                                                             read_flush_key_cache
''                                                             write_flush_key_cache
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_kek_cs
    Private write_key_cache_err_value
    Private read_key_cache_err_value
    Private flag_key_cache_err
    Private write_key_cache_en_value
    Private read_key_cache_en_value
    Private flag_key_cache_en
    Private write_disable_dout_value
    Private read_disable_dout_value
    Private flag_disable_dout
    Private write_flush_key_cache_value
    Private read_flush_key_cache_value
    Private flag_flush_key_cache

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

    Property Get get_key_cache_err
        get_key_cache_err = read_key_cache_err_value
    End Property

    Property Let set_key_cache_err(aData)
        write_key_cache_err_value = aData
        flag_key_cache_err        = &H1
    End Property

    Property Get read_key_cache_err
        read
        read_key_cache_err = read_key_cache_err_value
    End Property

    Property Let write_key_cache_err(aData)
        set_key_cache_err = aData
        write
    End Property

    Property Get get_key_cache_en
        get_key_cache_en = read_key_cache_en_value
    End Property

    Property Let set_key_cache_en(aData)
        write_key_cache_en_value = aData
        flag_key_cache_en        = &H1
    End Property

    Property Get read_key_cache_en
        read
        read_key_cache_en = read_key_cache_en_value
    End Property

    Property Let write_key_cache_en(aData)
        set_key_cache_en = aData
        write
    End Property

    Property Get get_disable_dout
        get_disable_dout = read_disable_dout_value
    End Property

    Property Let set_disable_dout(aData)
        write_disable_dout_value = aData
        flag_disable_dout        = &H1
    End Property

    Property Get read_disable_dout
        read
        read_disable_dout = read_disable_dout_value
    End Property

    Property Let write_disable_dout(aData)
        set_disable_dout = aData
        write
    End Property

    Property Get get_flush_key_cache
        get_flush_key_cache = read_flush_key_cache_value
    End Property

    Property Let set_flush_key_cache(aData)
        write_flush_key_cache_value = aData
        flag_flush_key_cache        = &H1
    End Property

    Property Get read_flush_key_cache
        read
        read_flush_key_cache = read_flush_key_cache_value
    End Property

    Property Let write_flush_key_cache(aData)
        set_flush_key_cache = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_key_cache_err_value = rightShift(data_low, 31) and &H1
        read_key_cache_en_value = rightShift(data_low, 23) and &H1
        read_disable_dout_value = rightShift(data_low, 22) and &H1
        read_flush_key_cache_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_key_cache_err = &H0 or flag_key_cache_en = &H0 or flag_disable_dout = &H0 or flag_flush_key_cache = &H0 Then read
        If flag_key_cache_err = &H0 Then write_key_cache_err_value = get_key_cache_err
        If flag_key_cache_en = &H0 Then write_key_cache_en_value = get_key_cache_en
        If flag_disable_dout = &H0 Then write_disable_dout_value = get_disable_dout
        If flag_flush_key_cache = &H0 Then write_flush_key_cache_value = get_flush_key_cache

        regValue = leftShift((write_key_cache_err_value and &H1), 31) + leftShift((write_key_cache_en_value and &H1), 23) + leftShift((write_disable_dout_value and &H1), 22) + leftShift((write_flush_key_cache_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_key_cache_err_value = rightShift(data_low, 31) and &H1
        read_key_cache_en_value = rightShift(data_low, 23) and &H1
        read_disable_dout_value = rightShift(data_low, 22) and &H1
        read_flush_key_cache_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_key_cache_err_value = &H0
        flag_key_cache_err        = &H0
        write_key_cache_en_value = &H0
        flag_key_cache_en        = &H0
        write_disable_dout_value = &H0
        flag_disable_dout        = &H0
        write_flush_key_cache_value = &H0
        flag_flush_key_cache        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' start                                      [31:31]          get_start
''                                                             set_start
''                                                             read_start
''                                                             write_start
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_ctrl
    Private write_start_value
    Private read_start_value
    Private flag_start

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H420
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_start
        get_start = read_start_value
    End Property

    Property Let set_start(aData)
        write_start_value = aData
        flag_start        = &H1
    End Property

    Property Get read_start
        read
        read_start = read_start_value
    End Property

    Property Let write_start(aData)
        set_start = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_start_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_start = &H0 Then read
        If flag_start = &H0 Then write_start_value = get_start

        regValue = leftShift((write_start_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_start_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_start_value = &H0
        flag_start        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_pkt_details
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' request_type                               [31:30]          get_request_type
''                                                             set_request_type
''                                                             read_request_type
''                                                             write_request_type
''---------------------------------------------------------------------------------
'' key_usage                                  [27:24]          get_key_usage
''                                                             set_key_usage
''                                                             read_key_usage
''                                                             write_key_usage
''---------------------------------------------------------------------------------
'' key_kind                                   [23:16]          get_key_kind
''                                                             set_key_kind
''                                                             read_key_kind
''                                                             write_key_kind
''---------------------------------------------------------------------------------
'' key_cache_entry_loc                        [15:8]           get_key_cache_entry_loc
''                                                             set_key_cache_entry_loc
''                                                             read_key_cache_entry_loc
''                                                             write_key_cache_entry_loc
''---------------------------------------------------------------------------------
'' keyloc                                     [7:0]            get_keyloc
''                                                             set_keyloc
''                                                             read_keyloc
''                                                             write_keyloc
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_pkt_details
    Private write_request_type_value
    Private read_request_type_value
    Private flag_request_type
    Private write_key_usage_value
    Private read_key_usage_value
    Private flag_key_usage
    Private write_key_kind_value
    Private read_key_kind_value
    Private flag_key_kind
    Private write_key_cache_entry_loc_value
    Private read_key_cache_entry_loc_value
    Private flag_key_cache_entry_loc
    Private write_keyloc_value
    Private read_keyloc_value
    Private flag_keyloc

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H430
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_request_type
        get_request_type = read_request_type_value
    End Property

    Property Let set_request_type(aData)
        write_request_type_value = aData
        flag_request_type        = &H1
    End Property

    Property Get read_request_type
        read
        read_request_type = read_request_type_value
    End Property

    Property Let write_request_type(aData)
        set_request_type = aData
        write
    End Property

    Property Get get_key_usage
        get_key_usage = read_key_usage_value
    End Property

    Property Let set_key_usage(aData)
        write_key_usage_value = aData
        flag_key_usage        = &H1
    End Property

    Property Get read_key_usage
        read
        read_key_usage = read_key_usage_value
    End Property

    Property Let write_key_usage(aData)
        set_key_usage = aData
        write
    End Property

    Property Get get_key_kind
        get_key_kind = read_key_kind_value
    End Property

    Property Let set_key_kind(aData)
        write_key_kind_value = aData
        flag_key_kind        = &H1
    End Property

    Property Get read_key_kind
        read
        read_key_kind = read_key_kind_value
    End Property

    Property Let write_key_kind(aData)
        set_key_kind = aData
        write
    End Property

    Property Get get_key_cache_entry_loc
        get_key_cache_entry_loc = read_key_cache_entry_loc_value
    End Property

    Property Let set_key_cache_entry_loc(aData)
        write_key_cache_entry_loc_value = aData
        flag_key_cache_entry_loc        = &H1
    End Property

    Property Get read_key_cache_entry_loc
        read
        read_key_cache_entry_loc = read_key_cache_entry_loc_value
    End Property

    Property Let write_key_cache_entry_loc(aData)
        set_key_cache_entry_loc = aData
        write
    End Property

    Property Get get_keyloc
        get_keyloc = read_keyloc_value
    End Property

    Property Let set_keyloc(aData)
        write_keyloc_value = aData
        flag_keyloc        = &H1
    End Property

    Property Get read_keyloc
        read
        read_keyloc = read_keyloc_value
    End Property

    Property Let write_keyloc(aData)
        set_keyloc = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_request_type_value = rightShift(data_low, 30) and &H3
        read_key_usage_value = rightShift(data_low, 24) and &Hf
        read_key_kind_value = rightShift(data_low, 16) and &Hff
        read_key_cache_entry_loc_value = rightShift(data_low, 8) and &Hff
        keyloc_mask = &Hff
        if data_low > LONG_MAX then
            if keyloc_mask = mask then
                read_keyloc_value = data_low
            else
                read_keyloc_value = (data_low - H8000_0000) and keyloc_mask
            end If
        else
            read_keyloc_value = data_low and keyloc_mask
        end If

    End Sub

    Sub write
        If flag_request_type = &H0 or flag_key_usage = &H0 or flag_key_kind = &H0 or flag_key_cache_entry_loc = &H0 or flag_keyloc = &H0 Then read
        If flag_request_type = &H0 Then write_request_type_value = get_request_type
        If flag_key_usage = &H0 Then write_key_usage_value = get_key_usage
        If flag_key_kind = &H0 Then write_key_kind_value = get_key_kind
        If flag_key_cache_entry_loc = &H0 Then write_key_cache_entry_loc_value = get_key_cache_entry_loc
        If flag_keyloc = &H0 Then write_keyloc_value = get_keyloc

        regValue = leftShift((write_request_type_value and &H3), 30) + leftShift((write_key_usage_value and &Hf), 24) + leftShift((write_key_kind_value and &Hff), 16) + leftShift((write_key_cache_entry_loc_value and &Hff), 8) + leftShift((write_keyloc_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_request_type_value = rightShift(data_low, 30) and &H3
        read_key_usage_value = rightShift(data_low, 24) and &Hf
        read_key_kind_value = rightShift(data_low, 16) and &Hff
        read_key_cache_entry_loc_value = rightShift(data_low, 8) and &Hff
        keyloc_mask = &Hff
        if data_low > LONG_MAX then
            if keyloc_mask = mask then
                read_keyloc_value = data_low
            else
                read_keyloc_value = (data_low - H8000_0000) and keyloc_mask
            end If
        else
            read_keyloc_value = data_low and keyloc_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_request_type_value = &H0
        flag_request_type        = &H0
        write_key_usage_value = &H0
        flag_key_usage        = &H0
        write_key_kind_value = &H0
        flag_key_kind        = &H0
        write_key_cache_entry_loc_value = &H0
        flag_key_cache_entry_loc        = &H0
        write_keyloc_value = &H0
        flag_keyloc        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' out_busy                                   [31:31]          get_out_busy
''                                                             set_out_busy
''                                                             read_out_busy
''                                                             write_out_busy
''---------------------------------------------------------------------------------
'' done                                       [30:30]          get_done
''                                                             set_done
''                                                             read_done
''                                                             write_done
''---------------------------------------------------------------------------------
'' timeout_err_flg                            [29:29]          get_timeout_err_flg
''                                                             set_timeout_err_flg
''                                                             read_timeout_err_flg
''                                                             write_timeout_err_flg
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_sts
    Private write_out_busy_value
    Private read_out_busy_value
    Private flag_out_busy
    Private write_done_value
    Private read_done_value
    Private flag_done
    Private write_timeout_err_flg_value
    Private read_timeout_err_flg_value
    Private flag_timeout_err_flg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H440
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_out_busy
        get_out_busy = read_out_busy_value
    End Property

    Property Let set_out_busy(aData)
        write_out_busy_value = aData
        flag_out_busy        = &H1
    End Property

    Property Get read_out_busy
        read
        read_out_busy = read_out_busy_value
    End Property

    Property Let write_out_busy(aData)
        set_out_busy = aData
        write
    End Property

    Property Get get_done
        get_done = read_done_value
    End Property

    Property Let set_done(aData)
        write_done_value = aData
        flag_done        = &H1
    End Property

    Property Get read_done
        read
        read_done = read_done_value
    End Property

    Property Let write_done(aData)
        set_done = aData
        write
    End Property

    Property Get get_timeout_err_flg
        get_timeout_err_flg = read_timeout_err_flg_value
    End Property

    Property Let set_timeout_err_flg(aData)
        write_timeout_err_flg_value = aData
        flag_timeout_err_flg        = &H1
    End Property

    Property Get read_timeout_err_flg
        read
        read_timeout_err_flg = read_timeout_err_flg_value
    End Property

    Property Let write_timeout_err_flg(aData)
        set_timeout_err_flg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_out_busy_value = rightShift(data_low, 31) and &H1
        read_done_value = rightShift(data_low, 30) and &H1
        read_timeout_err_flg_value = rightShift(data_low, 29) and &H1

    End Sub

    Sub write
        If flag_out_busy = &H0 or flag_done = &H0 or flag_timeout_err_flg = &H0 Then read
        If flag_out_busy = &H0 Then write_out_busy_value = get_out_busy
        If flag_done = &H0 Then write_done_value = get_done
        If flag_timeout_err_flg = &H0 Then write_timeout_err_flg_value = get_timeout_err_flg

        regValue = leftShift((write_out_busy_value and &H1), 31) + leftShift((write_done_value and &H1), 30) + leftShift((write_timeout_err_flg_value and &H1), 29)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_out_busy_value = rightShift(data_low, 31) and &H1
        read_done_value = rightShift(data_low, 30) and &H1
        read_timeout_err_flg_value = rightShift(data_low, 29) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_out_busy_value = &H0
        flag_out_busy        = &H0
        write_done_value = &H0
        flag_done        = &H0
        write_timeout_err_flg_value = &H0
        flag_timeout_err_flg        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_rslt_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rslt_size                                  [15:0]           get_rslt_size
''                                                             set_rslt_size
''                                                             read_rslt_size
''                                                             write_rslt_size
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_rslt_sts
    Private write_rslt_size_value
    Private read_rslt_size_value
    Private flag_rslt_size

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H450
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rslt_size
        get_rslt_size = read_rslt_size_value
    End Property

    Property Let set_rslt_size(aData)
        write_rslt_size_value = aData
        flag_rslt_size        = &H1
    End Property

    Property Get read_rslt_size
        read
        read_rslt_size = read_rslt_size_value
    End Property

    Property Let write_rslt_size(aData)
        set_rslt_size = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rslt_size_mask = &Hffff
        if data_low > LONG_MAX then
            if rslt_size_mask = mask then
                read_rslt_size_value = data_low
            else
                read_rslt_size_value = (data_low - H8000_0000) and rslt_size_mask
            end If
        else
            read_rslt_size_value = data_low and rslt_size_mask
        end If

    End Sub

    Sub write
        If flag_rslt_size = &H0 Then read
        If flag_rslt_size = &H0 Then write_rslt_size_value = get_rslt_size

        regValue = leftShift((write_rslt_size_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rslt_size_mask = &Hffff
        if data_low > LONG_MAX then
            if rslt_size_mask = mask then
                read_rslt_size_value = data_low
            else
                read_rslt_size_value = (data_low - H8000_0000) and rslt_size_mask
            end If
        else
            read_rslt_size_value = data_low and rslt_size_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rslt_size_value = &H0
        flag_rslt_size        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_err_sts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' kek_err_flg                                [17:17]          get_kek_err_flg
''                                                             set_kek_err_flg
''                                                             read_kek_err_flg
''                                                             write_kek_err_flg
''---------------------------------------------------------------------------------
'' kek_err_code                               [15:8]           get_kek_err_code
''                                                             set_kek_err_code
''                                                             read_kek_err_code
''                                                             write_kek_err_code
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_err_sts
    Private write_kek_err_flg_value
    Private read_kek_err_flg_value
    Private flag_kek_err_flg
    Private write_kek_err_code_value
    Private read_kek_err_code_value
    Private flag_kek_err_code

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H460
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_kek_err_flg
        get_kek_err_flg = read_kek_err_flg_value
    End Property

    Property Let set_kek_err_flg(aData)
        write_kek_err_flg_value = aData
        flag_kek_err_flg        = &H1
    End Property

    Property Get read_kek_err_flg
        read
        read_kek_err_flg = read_kek_err_flg_value
    End Property

    Property Let write_kek_err_flg(aData)
        set_kek_err_flg = aData
        write
    End Property

    Property Get get_kek_err_code
        get_kek_err_code = read_kek_err_code_value
    End Property

    Property Let set_kek_err_code(aData)
        write_kek_err_code_value = aData
        flag_kek_err_code        = &H1
    End Property

    Property Get read_kek_err_code
        read
        read_kek_err_code = read_kek_err_code_value
    End Property

    Property Let write_kek_err_code(aData)
        set_kek_err_code = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_kek_err_flg_value = rightShift(data_low, 17) and &H1
        read_kek_err_code_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_kek_err_flg = &H0 or flag_kek_err_code = &H0 Then read
        If flag_kek_err_flg = &H0 Then write_kek_err_flg_value = get_kek_err_flg
        If flag_kek_err_code = &H0 Then write_kek_err_code_value = get_kek_err_code

        regValue = leftShift((write_kek_err_flg_value and &H1), 17) + leftShift((write_kek_err_code_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_kek_err_flg_value = rightShift(data_low, 17) and &H1
        read_kek_err_code_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_kek_err_flg_value = &H0
        flag_kek_err_flg        = &H0
        write_kek_err_code_value = &H0
        flag_kek_err_code        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_timeout_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' timeout_dis                                [30:30]          get_timeout_dis
''                                                             set_timeout_dis
''                                                             read_timeout_dis
''                                                             write_timeout_dis
''---------------------------------------------------------------------------------
'' timeout_delay                              [15:0]           get_timeout_delay
''                                                             set_timeout_delay
''                                                             read_timeout_delay
''                                                             write_timeout_delay
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_timeout_en
    Private write_timeout_dis_value
    Private read_timeout_dis_value
    Private flag_timeout_dis
    Private write_timeout_delay_value
    Private read_timeout_delay_value
    Private flag_timeout_delay

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H470
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_timeout_dis
        get_timeout_dis = read_timeout_dis_value
    End Property

    Property Let set_timeout_dis(aData)
        write_timeout_dis_value = aData
        flag_timeout_dis        = &H1
    End Property

    Property Get read_timeout_dis
        read
        read_timeout_dis = read_timeout_dis_value
    End Property

    Property Let write_timeout_dis(aData)
        set_timeout_dis = aData
        write
    End Property

    Property Get get_timeout_delay
        get_timeout_delay = read_timeout_delay_value
    End Property

    Property Let set_timeout_delay(aData)
        write_timeout_delay_value = aData
        flag_timeout_delay        = &H1
    End Property

    Property Get read_timeout_delay
        read
        read_timeout_delay = read_timeout_delay_value
    End Property

    Property Let write_timeout_delay(aData)
        set_timeout_delay = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_timeout_dis_value = rightShift(data_low, 30) and &H1
        timeout_delay_mask = &Hffff
        if data_low > LONG_MAX then
            if timeout_delay_mask = mask then
                read_timeout_delay_value = data_low
            else
                read_timeout_delay_value = (data_low - H8000_0000) and timeout_delay_mask
            end If
        else
            read_timeout_delay_value = data_low and timeout_delay_mask
        end If

    End Sub

    Sub write
        If flag_timeout_dis = &H0 or flag_timeout_delay = &H0 Then read
        If flag_timeout_dis = &H0 Then write_timeout_dis_value = get_timeout_dis
        If flag_timeout_delay = &H0 Then write_timeout_delay_value = get_timeout_delay

        regValue = leftShift((write_timeout_dis_value and &H1), 30) + leftShift((write_timeout_delay_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_timeout_dis_value = rightShift(data_low, 30) and &H1
        timeout_delay_mask = &Hffff
        if data_low > LONG_MAX then
            if timeout_delay_mask = mask then
                read_timeout_delay_value = data_low
            else
                read_timeout_delay_value = (data_low - H8000_0000) and timeout_delay_mask
            end If
        else
            read_timeout_delay_value = data_low and timeout_delay_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_timeout_dis_value = &H0
        flag_timeout_dis        = &H0
        write_timeout_delay_value = &H0
        flag_timeout_delay        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_APB_spu2extkek_apb_buffer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' buffer_word                                [31:0]           get_buffer_word
''                                                             set_buffer_word
''                                                             read_buffer_word
''                                                             write_buffer_word
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_APB_spu2extkek_apb_buffer
    Private write_buffer_word_value
    Private read_buffer_word_value
    Private flag_buffer_word

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H480
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_buffer_word
        get_buffer_word = read_buffer_word_value
    End Property

    Property Let set_buffer_word(aData)
        write_buffer_word_value = aData
        flag_buffer_word        = &H1
    End Property

    Property Get read_buffer_word
        read
        read_buffer_word = read_buffer_word_value
    End Property

    Property Let write_buffer_word(aData)
        set_buffer_word = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        buffer_word_mask = &Hffffffff
        if data_low > LONG_MAX then
            if buffer_word_mask = mask then
                read_buffer_word_value = data_low
            else
                read_buffer_word_value = (data_low - H8000_0000) and buffer_word_mask
            end If
        else
            read_buffer_word_value = data_low and buffer_word_mask
        end If

    End Sub

    Sub write
        If flag_buffer_word = &H0 Then read
        If flag_buffer_word = &H0 Then write_buffer_word_value = get_buffer_word

        regValue = leftShift(write_buffer_word_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        buffer_word_mask = &Hffffffff
        if data_low > LONG_MAX then
            if buffer_word_mask = mask then
                read_buffer_word_value = data_low
            else
                read_buffer_word_value = (data_low - H8000_0000) and buffer_word_mask
            end If
        else
            read_buffer_word_value = data_low and buffer_word_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_buffer_word_value = &H0
        flag_buffer_word        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SPUM_APB_INSTANCE

    Public ctrl
    Public kek_cs
    Public spu2extkek_ctrl
    Public spu2extkek_pkt_details
    Public spu2extkek_sts
    Public spu2extkek_rslt_sts
    Public spu2extkek_err_sts
    Public spu2extkek_timeout_en
    Public spu2extkek_apb_buffer


    Public default function Init(aBaseAddr)
        Set ctrl = (New REGISTER_SPUM_APB_ctrl)(aBaseAddr, 32)
        Set kek_cs = (New REGISTER_SPUM_APB_kek_cs)(aBaseAddr, 32)
        Set spu2extkek_ctrl = (New REGISTER_SPUM_APB_spu2extkek_ctrl)(aBaseAddr, 32)
        Set spu2extkek_pkt_details = (New REGISTER_SPUM_APB_spu2extkek_pkt_details)(aBaseAddr, 32)
        Set spu2extkek_sts = (New REGISTER_SPUM_APB_spu2extkek_sts)(aBaseAddr, 32)
        Set spu2extkek_rslt_sts = (New REGISTER_SPUM_APB_spu2extkek_rslt_sts)(aBaseAddr, 32)
        Set spu2extkek_err_sts = (New REGISTER_SPUM_APB_spu2extkek_err_sts)(aBaseAddr, 32)
        Set spu2extkek_timeout_en = (New REGISTER_SPUM_APB_spu2extkek_timeout_en)(aBaseAddr, 32)
        Set spu2extkek_apb_buffer = (New REGISTER_SPUM_APB_spu2extkek_apb_buffer)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SPUM_APB = CreateObject("System.Collections.ArrayList")
SPUM_APB.Add ((New SPUM_APB_INSTANCE)(&H4c013000))


