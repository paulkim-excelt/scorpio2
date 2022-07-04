

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_pp_stat_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ITIC                                       [0:0]            get_ITIC
''                                                             set_ITIC
''                                                             read_ITIC
''                                                             write_ITIC
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_pp_stat_ctrl
    Private write_ITIC_value
    Private read_ITIC_value
    Private flag_ITIC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ITIC
        get_ITIC = read_ITIC_value
    End Property

    Property Let set_ITIC(aData)
        write_ITIC_value = aData
        flag_ITIC        = &H1
    End Property

    Property Get read_ITIC
        read
        read_ITIC = read_ITIC_value
    End Property

    Property Let write_ITIC(aData)
        set_ITIC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ITIC_mask = &H1
        if data_low > LONG_MAX then
            if ITIC_mask = mask then
                read_ITIC_value = data_low
            else
                read_ITIC_value = (data_low - H8000_0000) and ITIC_mask
            end If
        else
            read_ITIC_value = data_low and ITIC_mask
        end If

    End Sub

    Sub write
        If flag_ITIC = &H0 Then read
        If flag_ITIC = &H0 Then write_ITIC_value = get_ITIC

        regValue = leftShift((write_ITIC_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ITIC_mask = &H1
        if data_low > LONG_MAX then
            if ITIC_mask = mask then
                read_ITIC_value = data_low
            else
                read_ITIC_value = (data_low - H8000_0000) and ITIC_mask
            end If
        else
            read_ITIC_value = data_low and ITIC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ITIC_value = &H0
        flag_ITIC        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_SECF_MASK                               [9:0]            get_SA_SECF_MASK
''                                                             set_SA_SECF_MASK
''                                                             read_SA_SECF_MASK
''                                                             write_SA_SECF_MASK
''---------------------------------------------------------------------------------
'' error_mask                                 [31:17]          get_error_mask
''                                                             set_error_mask
''                                                             read_error_mask
''                                                             write_error_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail1
    Private write_SA_SECF_MASK_value
    Private read_SA_SECF_MASK_value
    Private flag_SA_SECF_MASK
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
        offset = &Hf124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_SECF_MASK
        get_SA_SECF_MASK = read_SA_SECF_MASK_value
    End Property

    Property Let set_SA_SECF_MASK(aData)
        write_SA_SECF_MASK_value = aData
        flag_SA_SECF_MASK        = &H1
    End Property

    Property Get read_SA_SECF_MASK
        read
        read_SA_SECF_MASK = read_SA_SECF_MASK_value
    End Property

    Property Let write_SA_SECF_MASK(aData)
        set_SA_SECF_MASK = aData
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
        SA_SECF_MASK_mask = &H3ff
        if data_low > LONG_MAX then
            if SA_SECF_MASK_mask = mask then
                read_SA_SECF_MASK_value = data_low
            else
                read_SA_SECF_MASK_value = (data_low - H8000_0000) and SA_SECF_MASK_mask
            end If
        else
            read_SA_SECF_MASK_value = data_low and SA_SECF_MASK_mask
        end If
        read_error_mask_value = rightShift(data_low, 17) and &H7fff

    End Sub

    Sub write
        If flag_SA_SECF_MASK = &H0 or flag_error_mask = &H0 Then read
        If flag_SA_SECF_MASK = &H0 Then write_SA_SECF_MASK_value = get_SA_SECF_MASK
        If flag_error_mask = &H0 Then write_error_mask_value = get_error_mask

        regValue = leftShift((write_SA_SECF_MASK_value and &H3ff), 0) + leftShift((write_error_mask_value and &H7fff), 17)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_SECF_MASK_mask = &H3ff
        if data_low > LONG_MAX then
            if SA_SECF_MASK_mask = mask then
                read_SA_SECF_MASK_value = data_low
            else
                read_SA_SECF_MASK_value = (data_low - H8000_0000) and SA_SECF_MASK_mask
            end If
        else
            read_SA_SECF_MASK_value = data_low and SA_SECF_MASK_mask
        end If
        read_error_mask_value = rightShift(data_low, 17) and &H7fff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_SECF_MASK_value = &H0
        flag_SA_SECF_MASK        = &H0
        write_error_mask_value = &H0
        flag_error_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SSM                                        [7:0]            get_SSM
''                                                             set_SSM
''                                                             read_SSM
''                                                             write_SSM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail2
    Private write_SSM_value
    Private read_SSM_value
    Private flag_SSM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SSM
        get_SSM = read_SSM_value
    End Property

    Property Let set_SSM(aData)
        write_SSM_value = aData
        flag_SSM        = &H1
    End Property

    Property Get read_SSM
        read
        read_SSM = read_SSM_value
    End Property

    Property Let write_SSM(aData)
        set_SSM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSM_mask = &Hff
        if data_low > LONG_MAX then
            if SSM_mask = mask then
                read_SSM_value = data_low
            else
                read_SSM_value = (data_low - H8000_0000) and SSM_mask
            end If
        else
            read_SSM_value = data_low and SSM_mask
        end If

    End Sub

    Sub write
        If flag_SSM = &H0 Then read
        If flag_SSM = &H0 Then write_SSM_value = get_SSM

        regValue = leftShift((write_SSM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SSM_mask = &Hff
        if data_low > LONG_MAX then
            if SSM_mask = mask then
                read_SSM_value = data_low
            else
                read_SSM_value = (data_low - H8000_0000) and SSM_mask
            end If
        else
            read_SSM_value = data_low and SSM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SSM_value = &H0
        flag_SSM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GSM                                        [2:0]            get_GSM
''                                                             set_GSM
''                                                             read_GSM
''                                                             write_GSM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail3
    Private write_GSM_value
    Private read_GSM_value
    Private flag_GSM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GSM
        get_GSM = read_GSM_value
    End Property

    Property Let set_GSM(aData)
        write_GSM_value = aData
        flag_GSM        = &H1
    End Property

    Property Get read_GSM
        read
        read_GSM = read_GSM_value
    End Property

    Property Let write_GSM(aData)
        set_GSM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GSM_mask = &H7
        if data_low > LONG_MAX then
            if GSM_mask = mask then
                read_GSM_value = data_low
            else
                read_GSM_value = (data_low - H8000_0000) and GSM_mask
            end If
        else
            read_GSM_value = data_low and GSM_mask
        end If

    End Sub

    Sub write
        If flag_GSM = &H0 Then read
        If flag_GSM = &H0 Then write_GSM_value = get_GSM

        regValue = leftShift((write_GSM_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GSM_mask = &H7
        if data_low > LONG_MAX then
            if GSM_mask = mask then
                read_GSM_value = data_low
            else
                read_GSM_value = (data_low - H8000_0000) and GSM_mask
            end If
        else
            read_GSM_value = data_low and GSM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GSM_value = &H0
        flag_GSM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_0
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
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_0
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
        offset = &Hf130
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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_1
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
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_1
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
        offset = &Hf134
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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_2
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
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_2
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
        offset = &Hf138
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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_debug_cntr
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
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_debug_cntr
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
        offset = &Hf13c
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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_dbg_pp_drop_enable
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
'' eg_drop_enable                             [17:16]          get_eg_drop_enable
''                                                             set_eg_drop_enable
''                                                             read_eg_drop_enable
''                                                             write_eg_drop_enable
''---------------------------------------------------------------------------------
'' gl_drop_enable                             [25:24]          get_gl_drop_enable
''                                                             set_gl_drop_enable
''                                                             read_gl_drop_enable
''                                                             write_gl_drop_enable
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_dbg_pp_drop_enable
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
        offset = &Hf140
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
        read_eg_drop_enable_value = rightShift(data_low, 16) and &H3
        read_gl_drop_enable_value = rightShift(data_low, 24) and &H3

    End Sub

    Sub write
        If flag_ig_drop_enable = &H0 or flag_eg_drop_enable = &H0 or flag_gl_drop_enable = &H0 Then read
        If flag_ig_drop_enable = &H0 Then write_ig_drop_enable_value = get_ig_drop_enable
        If flag_eg_drop_enable = &H0 Then write_eg_drop_enable_value = get_eg_drop_enable
        If flag_gl_drop_enable = &H0 Then write_gl_drop_enable_value = get_gl_drop_enable

        regValue = leftShift((write_ig_drop_enable_value and &H7), 0) + leftShift((write_eg_drop_enable_value and &H3), 16) + leftShift((write_gl_drop_enable_value and &H3), 24)
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
        read_eg_drop_enable_value = rightShift(data_low, 16) and &H3
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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_OPPE_dbg_pp_drop_status
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
'' eg_drop_flags                              [17:16]          get_eg_drop_flags
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
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_dbg_pp_drop_status
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
        offset = &Hf144
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
        read_eg_drop_flags_value = rightShift(data_low, 16) and &H3
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

        regValue = leftShift((write_ig_drop_flags_value and &H7), 0) + leftShift((write_eg_drop_flags_value and &H3), 16) + leftShift((write_oid_drop_operation_value and &H1), 24) + leftShift((write_transform_error_value and &H1), 25) + leftShift((write_res_out_value and &H7), 29)
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
        read_eg_drop_flags_value = rightShift(data_low, 16) and &H3
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




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE

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


    Public default function Init(aBaseAddr)
        Set pp_stat_ctrl = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_pp_stat_ctrl)(aBaseAddr, 32)
        Set count_secfail1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail1)(aBaseAddr, 32)
        Set count_secfail2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail2)(aBaseAddr, 32)
        Set count_secfail3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_count_secfail3)(aBaseAddr, 32)
        Set crypto_rslt_debug_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_0)(aBaseAddr, 32)
        Set crypto_rslt_debug_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_1)(aBaseAddr, 32)
        Set crypto_rslt_debug_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_rslt_debug_2)(aBaseAddr, 32)
        Set crypto_debug_cntr = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_crypto_debug_cntr)(aBaseAddr, 32)
        Set dbg_pp_drop_enable = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_dbg_pp_drop_enable)(aBaseAddr, 32)
        Set dbg_pp_drop_status = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_OPPE_dbg_pp_drop_status)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_OPPE = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_OPPE.Add ((New EIP165S_EIP_160S_I_32_BRCM_OPPE_INSTANCE)(&H4d510000))


