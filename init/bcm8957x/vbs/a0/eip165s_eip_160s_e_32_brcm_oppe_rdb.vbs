

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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_sa_pn_thr_summary1
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
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_sa_pn_thr_summary1
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
        offset = &H1f000
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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_pp_stat_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' if_tags_in_clear                           [0:0]            get_if_tags_in_clear
''                                                             set_if_tags_in_clear
''                                                             read_if_tags_in_clear
''                                                             write_if_tags_in_clear
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_pp_stat_ctrl
    Private write_if_tags_in_clear_value
    Private read_if_tags_in_clear_value
    Private flag_if_tags_in_clear

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_if_tags_in_clear
        get_if_tags_in_clear = read_if_tags_in_clear_value
    End Property

    Property Let set_if_tags_in_clear(aData)
        write_if_tags_in_clear_value = aData
        flag_if_tags_in_clear        = &H1
    End Property

    Property Get read_if_tags_in_clear
        read
        read_if_tags_in_clear = read_if_tags_in_clear_value
    End Property

    Property Let write_if_tags_in_clear(aData)
        set_if_tags_in_clear = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        if_tags_in_clear_mask = &H1
        if data_low > LONG_MAX then
            if if_tags_in_clear_mask = mask then
                read_if_tags_in_clear_value = data_low
            else
                read_if_tags_in_clear_value = (data_low - H8000_0000) and if_tags_in_clear_mask
            end If
        else
            read_if_tags_in_clear_value = data_low and if_tags_in_clear_mask
        end If

    End Sub

    Sub write
        If flag_if_tags_in_clear = &H0 Then read
        If flag_if_tags_in_clear = &H0 Then write_if_tags_in_clear_value = get_if_tags_in_clear

        regValue = leftShift((write_if_tags_in_clear_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        if_tags_in_clear_mask = &H1
        if data_low > LONG_MAX then
            if if_tags_in_clear_mask = mask then
                read_if_tags_in_clear_value = data_low
            else
                read_if_tags_in_clear_value = (data_low - H8000_0000) and if_tags_in_clear_mask
            end If
        else
            read_if_tags_in_clear_value = data_low and if_tags_in_clear_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_if_tags_in_clear_value = &H0
        flag_if_tags_in_clear        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_secfail_mask                            [3:0]            get_sa_secfail_mask
''                                                             set_sa_secfail_mask
''                                                             read_sa_secfail_mask
''                                                             write_sa_secfail_mask
''---------------------------------------------------------------------------------
'' error_mask                                 [31:17]          get_error_mask
''                                                             set_error_mask
''                                                             read_error_mask
''                                                             write_error_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail1
    Private write_sa_secfail_mask_value
    Private read_sa_secfail_mask_value
    Private flag_sa_secfail_mask
    Private write_error_mask_value
    Private read_error_mask_value
    Private flag_error_mask

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_secfail_mask
        get_sa_secfail_mask = read_sa_secfail_mask_value
    End Property

    Property Let set_sa_secfail_mask(aData)
        write_sa_secfail_mask_value = aData
        flag_sa_secfail_mask        = &H1
    End Property

    Property Get read_sa_secfail_mask
        read
        read_sa_secfail_mask = read_sa_secfail_mask_value
    End Property

    Property Let write_sa_secfail_mask(aData)
        set_sa_secfail_mask = aData
        write
    End Property

    Property Get get_error_mask
        get_error_mask = read_error_mask_value
    End Property

    Property Let set_error_mask(aData)
        write_error_mask_value = aData
        flag_error_mask        = &H1
    End Property

    Property Get read_error_mask
        read
        read_error_mask = read_error_mask_value
    End Property

    Property Let write_error_mask(aData)
        set_error_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_secfail_mask_mask = &Hf
        if data_low > LONG_MAX then
            if sa_secfail_mask_mask = mask then
                read_sa_secfail_mask_value = data_low
            else
                read_sa_secfail_mask_value = (data_low - H8000_0000) and sa_secfail_mask_mask
            end If
        else
            read_sa_secfail_mask_value = data_low and sa_secfail_mask_mask
        end If
        read_error_mask_value = rightShift(data_low, 17) and &H7fff

    End Sub

    Sub write
        If flag_sa_secfail_mask = &H0 or flag_error_mask = &H0 Then read
        If flag_sa_secfail_mask = &H0 Then write_sa_secfail_mask_value = get_sa_secfail_mask
        If flag_error_mask = &H0 Then write_error_mask_value = get_error_mask

        regValue = leftShift((write_sa_secfail_mask_value and &Hf), 0) + leftShift((write_error_mask_value and &H7fff), 17)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_secfail_mask_mask = &Hf
        if data_low > LONG_MAX then
            if sa_secfail_mask_mask = mask then
                read_sa_secfail_mask_value = data_low
            else
                read_sa_secfail_mask_value = (data_low - H8000_0000) and sa_secfail_mask_mask
            end If
        else
            read_sa_secfail_mask_value = data_low and sa_secfail_mask_mask
        end If
        read_error_mask_value = rightShift(data_low, 17) and &H7fff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_secfail_mask_value = &H0
        flag_sa_secfail_mask        = &H0
        write_error_mask_value = &H0
        flag_error_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' secy_secfail_mask                          [2:0]            get_secy_secfail_mask
''                                                             set_secy_secfail_mask
''                                                             read_secy_secfail_mask
''                                                             write_secy_secfail_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail2
    Private write_secy_secfail_mask_value
    Private read_secy_secfail_mask_value
    Private flag_secy_secfail_mask

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_secy_secfail_mask
        get_secy_secfail_mask = read_secy_secfail_mask_value
    End Property

    Property Let set_secy_secfail_mask(aData)
        write_secy_secfail_mask_value = aData
        flag_secy_secfail_mask        = &H1
    End Property

    Property Get read_secy_secfail_mask
        read
        read_secy_secfail_mask = read_secy_secfail_mask_value
    End Property

    Property Let write_secy_secfail_mask(aData)
        set_secy_secfail_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        secy_secfail_mask_mask = &H7
        if data_low > LONG_MAX then
            if secy_secfail_mask_mask = mask then
                read_secy_secfail_mask_value = data_low
            else
                read_secy_secfail_mask_value = (data_low - H8000_0000) and secy_secfail_mask_mask
            end If
        else
            read_secy_secfail_mask_value = data_low and secy_secfail_mask_mask
        end If

    End Sub

    Sub write
        If flag_secy_secfail_mask = &H0 Then read
        If flag_secy_secfail_mask = &H0 Then write_secy_secfail_mask_value = get_secy_secfail_mask

        regValue = leftShift((write_secy_secfail_mask_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        secy_secfail_mask_mask = &H7
        if data_low > LONG_MAX then
            if secy_secfail_mask_mask = mask then
                read_secy_secfail_mask_value = data_low
            else
                read_secy_secfail_mask_value = (data_low - H8000_0000) and secy_secfail_mask_mask
            end If
        else
            read_secy_secfail_mask_value = data_low and secy_secfail_mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_secy_secfail_mask_value = &H0
        flag_secy_secfail_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' global_secfail_mask                        [2:0]            get_global_secfail_mask
''                                                             set_global_secfail_mask
''                                                             read_global_secfail_mask
''                                                             write_global_secfail_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail3
    Private write_global_secfail_mask_value
    Private read_global_secfail_mask_value
    Private flag_global_secfail_mask

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_global_secfail_mask
        get_global_secfail_mask = read_global_secfail_mask_value
    End Property

    Property Let set_global_secfail_mask(aData)
        write_global_secfail_mask_value = aData
        flag_global_secfail_mask        = &H1
    End Property

    Property Get read_global_secfail_mask
        read
        read_global_secfail_mask = read_global_secfail_mask_value
    End Property

    Property Let write_global_secfail_mask(aData)
        set_global_secfail_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        global_secfail_mask_mask = &H7
        if data_low > LONG_MAX then
            if global_secfail_mask_mask = mask then
                read_global_secfail_mask_value = data_low
            else
                read_global_secfail_mask_value = (data_low - H8000_0000) and global_secfail_mask_mask
            end If
        else
            read_global_secfail_mask_value = data_low and global_secfail_mask_mask
        end If

    End Sub

    Sub write
        If flag_global_secfail_mask = &H0 Then read
        If flag_global_secfail_mask = &H0 Then write_global_secfail_mask_value = get_global_secfail_mask

        regValue = leftShift((write_global_secfail_mask_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        global_secfail_mask_mask = &H7
        if data_low > LONG_MAX then
            if global_secfail_mask_mask = mask then
                read_global_secfail_mask_value = data_low
            else
                read_global_secfail_mask_value = (data_low - H8000_0000) and global_secfail_mask_mask
            end If
        else
            read_global_secfail_mask_value = data_low and global_secfail_mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_global_secfail_mask_value = &H0
        flag_global_secfail_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' result_token_words                         [31:0]           get_result_token_words
''                                                             set_result_token_words
''                                                             read_result_token_words
''                                                             write_result_token_words
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_0
    Private write_result_token_words_value
    Private read_result_token_words_value
    Private flag_result_token_words

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_result_token_words
        get_result_token_words = read_result_token_words_value
    End Property

    Property Let set_result_token_words(aData)
        write_result_token_words_value = aData
        flag_result_token_words        = &H1
    End Property

    Property Get read_result_token_words
        read
        read_result_token_words = read_result_token_words_value
    End Property

    Property Let write_result_token_words(aData)
        set_result_token_words = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        result_token_words_mask = &Hffffffff
        if data_low > LONG_MAX then
            if result_token_words_mask = mask then
                read_result_token_words_value = data_low
            else
                read_result_token_words_value = (data_low - H8000_0000) and result_token_words_mask
            end If
        else
            read_result_token_words_value = data_low and result_token_words_mask
        end If

    End Sub

    Sub write
        If flag_result_token_words = &H0 Then read
        If flag_result_token_words = &H0 Then write_result_token_words_value = get_result_token_words

        regValue = leftShift(write_result_token_words_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        result_token_words_mask = &Hffffffff
        if data_low > LONG_MAX then
            if result_token_words_mask = mask then
                read_result_token_words_value = data_low
            else
                read_result_token_words_value = (data_low - H8000_0000) and result_token_words_mask
            end If
        else
            read_result_token_words_value = data_low and result_token_words_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_result_token_words_value = &H0
        flag_result_token_words        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' result_token_words                         [31:0]           get_result_token_words
''                                                             set_result_token_words
''                                                             read_result_token_words
''                                                             write_result_token_words
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_1
    Private write_result_token_words_value
    Private read_result_token_words_value
    Private flag_result_token_words

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f134
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_result_token_words
        get_result_token_words = read_result_token_words_value
    End Property

    Property Let set_result_token_words(aData)
        write_result_token_words_value = aData
        flag_result_token_words        = &H1
    End Property

    Property Get read_result_token_words
        read
        read_result_token_words = read_result_token_words_value
    End Property

    Property Let write_result_token_words(aData)
        set_result_token_words = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        result_token_words_mask = &Hffffffff
        if data_low > LONG_MAX then
            if result_token_words_mask = mask then
                read_result_token_words_value = data_low
            else
                read_result_token_words_value = (data_low - H8000_0000) and result_token_words_mask
            end If
        else
            read_result_token_words_value = data_low and result_token_words_mask
        end If

    End Sub

    Sub write
        If flag_result_token_words = &H0 Then read
        If flag_result_token_words = &H0 Then write_result_token_words_value = get_result_token_words

        regValue = leftShift(write_result_token_words_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        result_token_words_mask = &Hffffffff
        if data_low > LONG_MAX then
            if result_token_words_mask = mask then
                read_result_token_words_value = data_low
            else
                read_result_token_words_value = (data_low - H8000_0000) and result_token_words_mask
            end If
        else
            read_result_token_words_value = data_low and result_token_words_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_result_token_words_value = &H0
        flag_result_token_words        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' result_token_words                         [31:0]           get_result_token_words
''                                                             set_result_token_words
''                                                             read_result_token_words
''                                                             write_result_token_words
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_2
    Private write_result_token_words_value
    Private read_result_token_words_value
    Private flag_result_token_words

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f138
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_result_token_words
        get_result_token_words = read_result_token_words_value
    End Property

    Property Let set_result_token_words(aData)
        write_result_token_words_value = aData
        flag_result_token_words        = &H1
    End Property

    Property Get read_result_token_words
        read
        read_result_token_words = read_result_token_words_value
    End Property

    Property Let write_result_token_words(aData)
        set_result_token_words = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        result_token_words_mask = &Hffffffff
        if data_low > LONG_MAX then
            if result_token_words_mask = mask then
                read_result_token_words_value = data_low
            else
                read_result_token_words_value = (data_low - H8000_0000) and result_token_words_mask
            end If
        else
            read_result_token_words_value = data_low and result_token_words_mask
        end If

    End Sub

    Sub write
        If flag_result_token_words = &H0 Then read
        If flag_result_token_words = &H0 Then write_result_token_words_value = get_result_token_words

        regValue = leftShift(write_result_token_words_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        result_token_words_mask = &Hffffffff
        if data_low > LONG_MAX then
            if result_token_words_mask = mask then
                read_result_token_words_value = data_low
            else
                read_result_token_words_value = (data_low - H8000_0000) and result_token_words_mask
            end If
        else
            read_result_token_words_value = data_low and result_token_words_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_result_token_words_value = &H0
        flag_result_token_words        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_debug_cntr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' packet_count                               [31:0]           get_packet_count
''                                                             set_packet_count
''                                                             read_packet_count
''                                                             write_packet_count
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_debug_cntr
    Private write_packet_count_value
    Private read_packet_count_value
    Private flag_packet_count

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f13c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_packet_count
        get_packet_count = read_packet_count_value
    End Property

    Property Let set_packet_count(aData)
        write_packet_count_value = aData
        flag_packet_count        = &H1
    End Property

    Property Get read_packet_count
        read
        read_packet_count = read_packet_count_value
    End Property

    Property Let write_packet_count(aData)
        set_packet_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        packet_count_mask = &Hffffffff
        if data_low > LONG_MAX then
            if packet_count_mask = mask then
                read_packet_count_value = data_low
            else
                read_packet_count_value = (data_low - H8000_0000) and packet_count_mask
            end If
        else
            read_packet_count_value = data_low and packet_count_mask
        end If

    End Sub

    Sub write
        If flag_packet_count = &H0 Then read
        If flag_packet_count = &H0 Then write_packet_count_value = get_packet_count

        regValue = leftShift(write_packet_count_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        packet_count_mask = &Hffffffff
        if data_low > LONG_MAX then
            if packet_count_mask = mask then
                read_packet_count_value = data_low
            else
                read_packet_count_value = (data_low - H8000_0000) and packet_count_mask
            end If
        else
            read_packet_count_value = data_low and packet_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_packet_count_value = &H0
        flag_packet_count        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_dbg_pp_drop_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ig_drop_enable                             [2:0]            get_ig_drop_enable
''                                                             set_ig_drop_enable
''                                                             read_ig_drop_enable
''                                                             write_ig_drop_enable
''---------------------------------------------------------------------------------
'' eg_drop_enable                             [18:16]          get_eg_drop_enable
''                                                             set_eg_drop_enable
''                                                             read_eg_drop_enable
''                                                             write_eg_drop_enable
''---------------------------------------------------------------------------------
'' gl_drop_enable                             [25:24]          get_gl_drop_enable
''                                                             set_gl_drop_enable
''                                                             read_gl_drop_enable
''                                                             write_gl_drop_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_dbg_pp_drop_enable
    Private write_ig_drop_enable_value
    Private read_ig_drop_enable_value
    Private flag_ig_drop_enable
    Private write_eg_drop_enable_value
    Private read_eg_drop_enable_value
    Private flag_eg_drop_enable
    Private write_gl_drop_enable_value
    Private read_gl_drop_enable_value
    Private flag_gl_drop_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f140
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ig_drop_enable
        get_ig_drop_enable = read_ig_drop_enable_value
    End Property

    Property Let set_ig_drop_enable(aData)
        write_ig_drop_enable_value = aData
        flag_ig_drop_enable        = &H1
    End Property

    Property Get read_ig_drop_enable
        read
        read_ig_drop_enable = read_ig_drop_enable_value
    End Property

    Property Let write_ig_drop_enable(aData)
        set_ig_drop_enable = aData
        write
    End Property

    Property Get get_eg_drop_enable
        get_eg_drop_enable = read_eg_drop_enable_value
    End Property

    Property Let set_eg_drop_enable(aData)
        write_eg_drop_enable_value = aData
        flag_eg_drop_enable        = &H1
    End Property

    Property Get read_eg_drop_enable
        read
        read_eg_drop_enable = read_eg_drop_enable_value
    End Property

    Property Let write_eg_drop_enable(aData)
        set_eg_drop_enable = aData
        write
    End Property

    Property Get get_gl_drop_enable
        get_gl_drop_enable = read_gl_drop_enable_value
    End Property

    Property Let set_gl_drop_enable(aData)
        write_gl_drop_enable_value = aData
        flag_gl_drop_enable        = &H1
    End Property

    Property Get read_gl_drop_enable
        read
        read_gl_drop_enable = read_gl_drop_enable_value
    End Property

    Property Let write_gl_drop_enable(aData)
        set_gl_drop_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_drop_enable_mask = &H7
        if data_low > LONG_MAX then
            if ig_drop_enable_mask = mask then
                read_ig_drop_enable_value = data_low
            else
                read_ig_drop_enable_value = (data_low - H8000_0000) and ig_drop_enable_mask
            end If
        else
            read_ig_drop_enable_value = data_low and ig_drop_enable_mask
        end If
        read_eg_drop_enable_value = rightShift(data_low, 16) and &H7
        read_gl_drop_enable_value = rightShift(data_low, 24) and &H3

    End Sub

    Sub write
        If flag_ig_drop_enable = &H0 or flag_eg_drop_enable = &H0 or flag_gl_drop_enable = &H0 Then read
        If flag_ig_drop_enable = &H0 Then write_ig_drop_enable_value = get_ig_drop_enable
        If flag_eg_drop_enable = &H0 Then write_eg_drop_enable_value = get_eg_drop_enable
        If flag_gl_drop_enable = &H0 Then write_gl_drop_enable_value = get_gl_drop_enable

        regValue = leftShift((write_ig_drop_enable_value and &H7), 0) + leftShift((write_eg_drop_enable_value and &H7), 16) + leftShift((write_gl_drop_enable_value and &H3), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_drop_enable_mask = &H7
        if data_low > LONG_MAX then
            if ig_drop_enable_mask = mask then
                read_ig_drop_enable_value = data_low
            else
                read_ig_drop_enable_value = (data_low - H8000_0000) and ig_drop_enable_mask
            end If
        else
            read_ig_drop_enable_value = data_low and ig_drop_enable_mask
        end If
        read_eg_drop_enable_value = rightShift(data_low, 16) and &H7
        read_gl_drop_enable_value = rightShift(data_low, 24) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ig_drop_enable_value = &H0
        flag_ig_drop_enable        = &H0
        write_eg_drop_enable_value = &H0
        flag_eg_drop_enable        = &H0
        write_gl_drop_enable_value = &H0
        flag_gl_drop_enable        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_dbg_pp_drop_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ig_drop_flags                              [2:0]            get_ig_drop_flags
''                                                             set_ig_drop_flags
''                                                             read_ig_drop_flags
''                                                             write_ig_drop_flags
''---------------------------------------------------------------------------------
'' eg_drop_flags                              [18:16]          get_eg_drop_flags
''                                                             set_eg_drop_flags
''                                                             read_eg_drop_flags
''                                                             write_eg_drop_flags
''---------------------------------------------------------------------------------
'' oid_drop_operation                         [24:24]          get_oid_drop_operation
''                                                             set_oid_drop_operation
''                                                             read_oid_drop_operation
''                                                             write_oid_drop_operation
''---------------------------------------------------------------------------------
'' transform_error                            [25:25]          get_transform_error
''                                                             set_transform_error
''                                                             read_transform_error
''                                                             write_transform_error
''---------------------------------------------------------------------------------
'' res_out                                    [31:29]          get_res_out
''                                                             set_res_out
''                                                             read_res_out
''                                                             write_res_out
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_dbg_pp_drop_status
    Private write_ig_drop_flags_value
    Private read_ig_drop_flags_value
    Private flag_ig_drop_flags
    Private write_eg_drop_flags_value
    Private read_eg_drop_flags_value
    Private flag_eg_drop_flags
    Private write_oid_drop_operation_value
    Private read_oid_drop_operation_value
    Private flag_oid_drop_operation
    Private write_transform_error_value
    Private read_transform_error_value
    Private flag_transform_error
    Private write_res_out_value
    Private read_res_out_value
    Private flag_res_out

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f144
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ig_drop_flags
        get_ig_drop_flags = read_ig_drop_flags_value
    End Property

    Property Let set_ig_drop_flags(aData)
        write_ig_drop_flags_value = aData
        flag_ig_drop_flags        = &H1
    End Property

    Property Get read_ig_drop_flags
        read
        read_ig_drop_flags = read_ig_drop_flags_value
    End Property

    Property Let write_ig_drop_flags(aData)
        set_ig_drop_flags = aData
        write
    End Property

    Property Get get_eg_drop_flags
        get_eg_drop_flags = read_eg_drop_flags_value
    End Property

    Property Let set_eg_drop_flags(aData)
        write_eg_drop_flags_value = aData
        flag_eg_drop_flags        = &H1
    End Property

    Property Get read_eg_drop_flags
        read
        read_eg_drop_flags = read_eg_drop_flags_value
    End Property

    Property Let write_eg_drop_flags(aData)
        set_eg_drop_flags = aData
        write
    End Property

    Property Get get_oid_drop_operation
        get_oid_drop_operation = read_oid_drop_operation_value
    End Property

    Property Let set_oid_drop_operation(aData)
        write_oid_drop_operation_value = aData
        flag_oid_drop_operation        = &H1
    End Property

    Property Get read_oid_drop_operation
        read
        read_oid_drop_operation = read_oid_drop_operation_value
    End Property

    Property Let write_oid_drop_operation(aData)
        set_oid_drop_operation = aData
        write
    End Property

    Property Get get_transform_error
        get_transform_error = read_transform_error_value
    End Property

    Property Let set_transform_error(aData)
        write_transform_error_value = aData
        flag_transform_error        = &H1
    End Property

    Property Get read_transform_error
        read
        read_transform_error = read_transform_error_value
    End Property

    Property Let write_transform_error(aData)
        set_transform_error = aData
        write
    End Property

    Property Get get_res_out
        get_res_out = read_res_out_value
    End Property

    Property Let set_res_out(aData)
        write_res_out_value = aData
        flag_res_out        = &H1
    End Property

    Property Get read_res_out
        read
        read_res_out = read_res_out_value
    End Property

    Property Let write_res_out(aData)
        set_res_out = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_drop_flags_mask = &H7
        if data_low > LONG_MAX then
            if ig_drop_flags_mask = mask then
                read_ig_drop_flags_value = data_low
            else
                read_ig_drop_flags_value = (data_low - H8000_0000) and ig_drop_flags_mask
            end If
        else
            read_ig_drop_flags_value = data_low and ig_drop_flags_mask
        end If
        read_eg_drop_flags_value = rightShift(data_low, 16) and &H7
        read_oid_drop_operation_value = rightShift(data_low, 24) and &H1
        read_transform_error_value = rightShift(data_low, 25) and &H1
        read_res_out_value = rightShift(data_low, 29) and &H7

    End Sub

    Sub write
        If flag_ig_drop_flags = &H0 or flag_eg_drop_flags = &H0 or flag_oid_drop_operation = &H0 or flag_transform_error = &H0 or flag_res_out = &H0 Then read
        If flag_ig_drop_flags = &H0 Then write_ig_drop_flags_value = get_ig_drop_flags
        If flag_eg_drop_flags = &H0 Then write_eg_drop_flags_value = get_eg_drop_flags
        If flag_oid_drop_operation = &H0 Then write_oid_drop_operation_value = get_oid_drop_operation
        If flag_transform_error = &H0 Then write_transform_error_value = get_transform_error
        If flag_res_out = &H0 Then write_res_out_value = get_res_out

        regValue = leftShift((write_ig_drop_flags_value and &H7), 0) + leftShift((write_eg_drop_flags_value and &H7), 16) + leftShift((write_oid_drop_operation_value and &H1), 24) + leftShift((write_transform_error_value and &H1), 25) + leftShift((write_res_out_value and &H7), 29)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_drop_flags_mask = &H7
        if data_low > LONG_MAX then
            if ig_drop_flags_mask = mask then
                read_ig_drop_flags_value = data_low
            else
                read_ig_drop_flags_value = (data_low - H8000_0000) and ig_drop_flags_mask
            end If
        else
            read_ig_drop_flags_value = data_low and ig_drop_flags_mask
        end If
        read_eg_drop_flags_value = rightShift(data_low, 16) and &H7
        read_oid_drop_operation_value = rightShift(data_low, 24) and &H1
        read_transform_error_value = rightShift(data_low, 25) and &H1
        read_res_out_value = rightShift(data_low, 29) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ig_drop_flags_value = &H0
        flag_ig_drop_flags        = &H0
        write_eg_drop_flags_value = &H0
        flag_eg_drop_flags        = &H0
        write_oid_drop_operation_value = &H0
        flag_oid_drop_operation        = &H0
        write_transform_error_value = &H0
        flag_transform_error        = &H0
        write_res_out_value = &H0
        flag_res_out        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu0
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu1
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu2
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu3
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu4
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu5
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu6
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu7
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f21c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu8
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f220
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu9
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f224
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu10
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f228
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu11
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f22c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu12
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f230
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu13
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f234
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu14
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f238
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mtu_compare                                [14:0]           get_mtu_compare
''                                                             set_mtu_compare
''                                                             read_mtu_compare
''                                                             write_mtu_compare
''---------------------------------------------------------------------------------
'' mtu_comp_drop                              [15:15]          get_mtu_comp_drop
''                                                             set_mtu_comp_drop
''                                                             read_mtu_comp_drop
''                                                             write_mtu_comp_drop
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu15
    Private write_mtu_compare_value
    Private read_mtu_compare_value
    Private flag_mtu_compare
    Private write_mtu_comp_drop_value
    Private read_mtu_comp_drop_value
    Private flag_mtu_comp_drop

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f23c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mtu_compare
        get_mtu_compare = read_mtu_compare_value
    End Property

    Property Let set_mtu_compare(aData)
        write_mtu_compare_value = aData
        flag_mtu_compare        = &H1
    End Property

    Property Get read_mtu_compare
        read
        read_mtu_compare = read_mtu_compare_value
    End Property

    Property Let write_mtu_compare(aData)
        set_mtu_compare = aData
        write
    End Property

    Property Get get_mtu_comp_drop
        get_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let set_mtu_comp_drop(aData)
        write_mtu_comp_drop_value = aData
        flag_mtu_comp_drop        = &H1
    End Property

    Property Get read_mtu_comp_drop
        read
        read_mtu_comp_drop = read_mtu_comp_drop_value
    End Property

    Property Let write_mtu_comp_drop(aData)
        set_mtu_comp_drop = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_mtu_compare = &H0 or flag_mtu_comp_drop = &H0 Then read
        If flag_mtu_compare = &H0 Then write_mtu_compare_value = get_mtu_compare
        If flag_mtu_comp_drop = &H0 Then write_mtu_comp_drop_value = get_mtu_comp_drop

        regValue = leftShift((write_mtu_compare_value and &H7fff), 0) + leftShift((write_mtu_comp_drop_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mtu_compare_mask = &H7fff
        if data_low > LONG_MAX then
            if mtu_compare_mask = mask then
                read_mtu_compare_value = data_low
            else
                read_mtu_compare_value = (data_low - H8000_0000) and mtu_compare_mask
            end If
        else
            read_mtu_compare_value = data_low and mtu_compare_mask
        end If
        read_mtu_comp_drop_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mtu_compare_value = &H0
        flag_mtu_compare        = &H0
        write_mtu_comp_drop_value = &H0
        flag_mtu_comp_drop        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE

    Public sa_pn_thr_summary1
    Public pp_stat_ctrl
    Public count_secfail1
    Public count_secfail2
    Public count_secfail3
    Public crypto_rslt_debug_0
    Public crypto_rslt_debug_1
    Public crypto_rslt_debug_2
    Public crypto_debug_cntr
    Public dbg_pp_drop_enable
    Public dbg_pp_drop_status
    Public mtu0
    Public mtu1
    Public mtu2
    Public mtu3
    Public mtu4
    Public mtu5
    Public mtu6
    Public mtu7
    Public mtu8
    Public mtu9
    Public mtu10
    Public mtu11
    Public mtu12
    Public mtu13
    Public mtu14
    Public mtu15


    Public default function Init(aBaseAddr)
        Set sa_pn_thr_summary1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_sa_pn_thr_summary1)(aBaseAddr, 32)
        Set pp_stat_ctrl = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_pp_stat_ctrl)(aBaseAddr, 32)
        Set count_secfail1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail1)(aBaseAddr, 32)
        Set count_secfail2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail2)(aBaseAddr, 32)
        Set count_secfail3 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_count_secfail3)(aBaseAddr, 32)
        Set crypto_rslt_debug_0 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_0)(aBaseAddr, 32)
        Set crypto_rslt_debug_1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_1)(aBaseAddr, 32)
        Set crypto_rslt_debug_2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_rslt_debug_2)(aBaseAddr, 32)
        Set crypto_debug_cntr = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_crypto_debug_cntr)(aBaseAddr, 32)
        Set dbg_pp_drop_enable = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_dbg_pp_drop_enable)(aBaseAddr, 32)
        Set dbg_pp_drop_status = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_dbg_pp_drop_status)(aBaseAddr, 32)
        Set mtu0 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu0)(aBaseAddr, 32)
        Set mtu1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu1)(aBaseAddr, 32)
        Set mtu2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu2)(aBaseAddr, 32)
        Set mtu3 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu3)(aBaseAddr, 32)
        Set mtu4 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu4)(aBaseAddr, 32)
        Set mtu5 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu5)(aBaseAddr, 32)
        Set mtu6 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu6)(aBaseAddr, 32)
        Set mtu7 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu7)(aBaseAddr, 32)
        Set mtu8 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu8)(aBaseAddr, 32)
        Set mtu9 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu9)(aBaseAddr, 32)
        Set mtu10 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu10)(aBaseAddr, 32)
        Set mtu11 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu11)(aBaseAddr, 32)
        Set mtu12 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu12)(aBaseAddr, 32)
        Set mtu13 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu13)(aBaseAddr, 32)
        Set mtu14 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu14)(aBaseAddr, 32)
        Set mtu15 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_OPPE_mtu15)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_E_32_BRCM_OPPE = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_E_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_E_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_E_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_E_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_E_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_E_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_E_32_BRCM_OPPE_INSTANCE)(&H4d510000))


