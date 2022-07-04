

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_token_ctrl_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' token_location_available                   [2:2]            get_token_location_available
''                                                             set_token_location_available
''                                                             read_token_location_available
''                                                             write_token_location_available
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_token_ctrl_stat
    Private write_token_location_available_value
    Private read_token_location_available_value
    Private flag_token_location_available

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_token_location_available
        get_token_location_available = read_token_location_available_value
    End Property

    Property Let set_token_location_available(aData)
        write_token_location_available_value = aData
        flag_token_location_available        = &H1
    End Property

    Property Get read_token_location_available
        read
        read_token_location_available = read_token_location_available_value
    End Property

    Property Let write_token_location_available(aData)
        set_token_location_available = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_token_location_available_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_token_location_available = &H0 Then read
        If flag_token_location_available = &H0 Then write_token_location_available_value = get_token_location_available

        regValue = leftShift((write_token_location_available_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_token_location_available_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_token_location_available_value = &H0
        flag_token_location_available        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_prot_alg_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hash_only_null                             [0:0]            get_hash_only_null
''                                                             set_hash_only_null
''                                                             read_hash_only_null
''                                                             write_hash_only_null
''---------------------------------------------------------------------------------
'' encrypt_only                               [1:1]            get_encrypt_only
''                                                             set_encrypt_only
''                                                             read_encrypt_only
''                                                             write_encrypt_only
''---------------------------------------------------------------------------------
'' hash_encrypt                               [2:2]            get_hash_encrypt
''                                                             set_hash_encrypt
''                                                             read_hash_encrypt
''                                                             write_hash_encrypt
''---------------------------------------------------------------------------------
'' hash_decrypt                               [3:3]            get_hash_decrypt
''                                                             set_hash_decrypt
''                                                             read_hash_decrypt
''                                                             write_hash_decrypt
''---------------------------------------------------------------------------------
'' encrypt_hash                               [4:4]            get_encrypt_hash
''                                                             set_encrypt_hash
''                                                             read_encrypt_hash
''                                                             write_encrypt_hash
''---------------------------------------------------------------------------------
'' decrypt_hash                               [5:5]            get_decrypt_hash
''                                                             set_decrypt_hash
''                                                             read_decrypt_hash
''                                                             write_decrypt_hash
''---------------------------------------------------------------------------------
'' key_128_bit                                [6:6]            get_key_128_bit
''                                                             set_key_128_bit
''                                                             read_key_128_bit
''                                                             write_key_128_bit
''---------------------------------------------------------------------------------
'' key_256_bit                                [7:7]            get_key_256_bit
''                                                             set_key_256_bit
''                                                             read_key_256_bit
''                                                             write_key_256_bit
''---------------------------------------------------------------------------------
'' aes_ecb                                    [8:8]            get_aes_ecb
''                                                             set_aes_ecb
''                                                             read_aes_ecb
''                                                             write_aes_ecb
''---------------------------------------------------------------------------------
'' aes_cbc                                    [9:9]            get_aes_cbc
''                                                             set_aes_cbc
''                                                             read_aes_cbc
''                                                             write_aes_cbc
''---------------------------------------------------------------------------------
'' aes_ctr_icm                                [10:10]          get_aes_ctr_icm
''                                                             set_aes_ctr_icm
''                                                             read_aes_ctr_icm
''                                                             write_aes_ctr_icm
''---------------------------------------------------------------------------------
'' aes_ofb                                    [11:11]          get_aes_ofb
''                                                             set_aes_ofb
''                                                             read_aes_ofb
''                                                             write_aes_ofb
''---------------------------------------------------------------------------------
'' aes_cfb                                    [12:12]          get_aes_cfb
''                                                             set_aes_cfb
''                                                             read_aes_cfb
''                                                             write_aes_cfb
''---------------------------------------------------------------------------------
'' aes_xcbc_mac                               [30:30]          get_aes_xcbc_mac
''                                                             set_aes_xcbc_mac
''                                                             read_aes_xcbc_mac
''                                                             write_aes_xcbc_mac
''---------------------------------------------------------------------------------
'' gcm_hash                                   [31:31]          get_gcm_hash
''                                                             set_gcm_hash
''                                                             read_gcm_hash
''                                                             write_gcm_hash
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_prot_alg_en
    Private write_hash_only_null_value
    Private read_hash_only_null_value
    Private flag_hash_only_null
    Private write_encrypt_only_value
    Private read_encrypt_only_value
    Private flag_encrypt_only
    Private write_hash_encrypt_value
    Private read_hash_encrypt_value
    Private flag_hash_encrypt
    Private write_hash_decrypt_value
    Private read_hash_decrypt_value
    Private flag_hash_decrypt
    Private write_encrypt_hash_value
    Private read_encrypt_hash_value
    Private flag_encrypt_hash
    Private write_decrypt_hash_value
    Private read_decrypt_hash_value
    Private flag_decrypt_hash
    Private write_key_128_bit_value
    Private read_key_128_bit_value
    Private flag_key_128_bit
    Private write_key_256_bit_value
    Private read_key_256_bit_value
    Private flag_key_256_bit
    Private write_aes_ecb_value
    Private read_aes_ecb_value
    Private flag_aes_ecb
    Private write_aes_cbc_value
    Private read_aes_cbc_value
    Private flag_aes_cbc
    Private write_aes_ctr_icm_value
    Private read_aes_ctr_icm_value
    Private flag_aes_ctr_icm
    Private write_aes_ofb_value
    Private read_aes_ofb_value
    Private flag_aes_ofb
    Private write_aes_cfb_value
    Private read_aes_cfb_value
    Private flag_aes_cfb
    Private write_aes_xcbc_mac_value
    Private read_aes_xcbc_mac_value
    Private flag_aes_xcbc_mac
    Private write_gcm_hash_value
    Private read_gcm_hash_value
    Private flag_gcm_hash

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f404
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hash_only_null
        get_hash_only_null = read_hash_only_null_value
    End Property

    Property Let set_hash_only_null(aData)
        write_hash_only_null_value = aData
        flag_hash_only_null        = &H1
    End Property

    Property Get read_hash_only_null
        read
        read_hash_only_null = read_hash_only_null_value
    End Property

    Property Let write_hash_only_null(aData)
        set_hash_only_null = aData
        write
    End Property

    Property Get get_encrypt_only
        get_encrypt_only = read_encrypt_only_value
    End Property

    Property Let set_encrypt_only(aData)
        write_encrypt_only_value = aData
        flag_encrypt_only        = &H1
    End Property

    Property Get read_encrypt_only
        read
        read_encrypt_only = read_encrypt_only_value
    End Property

    Property Let write_encrypt_only(aData)
        set_encrypt_only = aData
        write
    End Property

    Property Get get_hash_encrypt
        get_hash_encrypt = read_hash_encrypt_value
    End Property

    Property Let set_hash_encrypt(aData)
        write_hash_encrypt_value = aData
        flag_hash_encrypt        = &H1
    End Property

    Property Get read_hash_encrypt
        read
        read_hash_encrypt = read_hash_encrypt_value
    End Property

    Property Let write_hash_encrypt(aData)
        set_hash_encrypt = aData
        write
    End Property

    Property Get get_hash_decrypt
        get_hash_decrypt = read_hash_decrypt_value
    End Property

    Property Let set_hash_decrypt(aData)
        write_hash_decrypt_value = aData
        flag_hash_decrypt        = &H1
    End Property

    Property Get read_hash_decrypt
        read
        read_hash_decrypt = read_hash_decrypt_value
    End Property

    Property Let write_hash_decrypt(aData)
        set_hash_decrypt = aData
        write
    End Property

    Property Get get_encrypt_hash
        get_encrypt_hash = read_encrypt_hash_value
    End Property

    Property Let set_encrypt_hash(aData)
        write_encrypt_hash_value = aData
        flag_encrypt_hash        = &H1
    End Property

    Property Get read_encrypt_hash
        read
        read_encrypt_hash = read_encrypt_hash_value
    End Property

    Property Let write_encrypt_hash(aData)
        set_encrypt_hash = aData
        write
    End Property

    Property Get get_decrypt_hash
        get_decrypt_hash = read_decrypt_hash_value
    End Property

    Property Let set_decrypt_hash(aData)
        write_decrypt_hash_value = aData
        flag_decrypt_hash        = &H1
    End Property

    Property Get read_decrypt_hash
        read
        read_decrypt_hash = read_decrypt_hash_value
    End Property

    Property Let write_decrypt_hash(aData)
        set_decrypt_hash = aData
        write
    End Property

    Property Get get_key_128_bit
        get_key_128_bit = read_key_128_bit_value
    End Property

    Property Let set_key_128_bit(aData)
        write_key_128_bit_value = aData
        flag_key_128_bit        = &H1
    End Property

    Property Get read_key_128_bit
        read
        read_key_128_bit = read_key_128_bit_value
    End Property

    Property Let write_key_128_bit(aData)
        set_key_128_bit = aData
        write
    End Property

    Property Get get_key_256_bit
        get_key_256_bit = read_key_256_bit_value
    End Property

    Property Let set_key_256_bit(aData)
        write_key_256_bit_value = aData
        flag_key_256_bit        = &H1
    End Property

    Property Get read_key_256_bit
        read
        read_key_256_bit = read_key_256_bit_value
    End Property

    Property Let write_key_256_bit(aData)
        set_key_256_bit = aData
        write
    End Property

    Property Get get_aes_ecb
        get_aes_ecb = read_aes_ecb_value
    End Property

    Property Let set_aes_ecb(aData)
        write_aes_ecb_value = aData
        flag_aes_ecb        = &H1
    End Property

    Property Get read_aes_ecb
        read
        read_aes_ecb = read_aes_ecb_value
    End Property

    Property Let write_aes_ecb(aData)
        set_aes_ecb = aData
        write
    End Property

    Property Get get_aes_cbc
        get_aes_cbc = read_aes_cbc_value
    End Property

    Property Let set_aes_cbc(aData)
        write_aes_cbc_value = aData
        flag_aes_cbc        = &H1
    End Property

    Property Get read_aes_cbc
        read
        read_aes_cbc = read_aes_cbc_value
    End Property

    Property Let write_aes_cbc(aData)
        set_aes_cbc = aData
        write
    End Property

    Property Get get_aes_ctr_icm
        get_aes_ctr_icm = read_aes_ctr_icm_value
    End Property

    Property Let set_aes_ctr_icm(aData)
        write_aes_ctr_icm_value = aData
        flag_aes_ctr_icm        = &H1
    End Property

    Property Get read_aes_ctr_icm
        read
        read_aes_ctr_icm = read_aes_ctr_icm_value
    End Property

    Property Let write_aes_ctr_icm(aData)
        set_aes_ctr_icm = aData
        write
    End Property

    Property Get get_aes_ofb
        get_aes_ofb = read_aes_ofb_value
    End Property

    Property Let set_aes_ofb(aData)
        write_aes_ofb_value = aData
        flag_aes_ofb        = &H1
    End Property

    Property Get read_aes_ofb
        read
        read_aes_ofb = read_aes_ofb_value
    End Property

    Property Let write_aes_ofb(aData)
        set_aes_ofb = aData
        write
    End Property

    Property Get get_aes_cfb
        get_aes_cfb = read_aes_cfb_value
    End Property

    Property Let set_aes_cfb(aData)
        write_aes_cfb_value = aData
        flag_aes_cfb        = &H1
    End Property

    Property Get read_aes_cfb
        read
        read_aes_cfb = read_aes_cfb_value
    End Property

    Property Let write_aes_cfb(aData)
        set_aes_cfb = aData
        write
    End Property

    Property Get get_aes_xcbc_mac
        get_aes_xcbc_mac = read_aes_xcbc_mac_value
    End Property

    Property Let set_aes_xcbc_mac(aData)
        write_aes_xcbc_mac_value = aData
        flag_aes_xcbc_mac        = &H1
    End Property

    Property Get read_aes_xcbc_mac
        read
        read_aes_xcbc_mac = read_aes_xcbc_mac_value
    End Property

    Property Let write_aes_xcbc_mac(aData)
        set_aes_xcbc_mac = aData
        write
    End Property

    Property Get get_gcm_hash
        get_gcm_hash = read_gcm_hash_value
    End Property

    Property Let set_gcm_hash(aData)
        write_gcm_hash_value = aData
        flag_gcm_hash        = &H1
    End Property

    Property Get read_gcm_hash
        read
        read_gcm_hash = read_gcm_hash_value
    End Property

    Property Let write_gcm_hash(aData)
        set_gcm_hash = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hash_only_null_mask = &H1
        if data_low > LONG_MAX then
            if hash_only_null_mask = mask then
                read_hash_only_null_value = data_low
            else
                read_hash_only_null_value = (data_low - H8000_0000) and hash_only_null_mask
            end If
        else
            read_hash_only_null_value = data_low and hash_only_null_mask
        end If
        read_encrypt_only_value = rightShift(data_low, 1) and &H1
        read_hash_encrypt_value = rightShift(data_low, 2) and &H1
        read_hash_decrypt_value = rightShift(data_low, 3) and &H1
        read_encrypt_hash_value = rightShift(data_low, 4) and &H1
        read_decrypt_hash_value = rightShift(data_low, 5) and &H1
        read_key_128_bit_value = rightShift(data_low, 6) and &H1
        read_key_256_bit_value = rightShift(data_low, 7) and &H1
        read_aes_ecb_value = rightShift(data_low, 8) and &H1
        read_aes_cbc_value = rightShift(data_low, 9) and &H1
        read_aes_ctr_icm_value = rightShift(data_low, 10) and &H1
        read_aes_ofb_value = rightShift(data_low, 11) and &H1
        read_aes_cfb_value = rightShift(data_low, 12) and &H1
        read_aes_xcbc_mac_value = rightShift(data_low, 30) and &H1
        read_gcm_hash_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_hash_only_null = &H0 or flag_encrypt_only = &H0 or flag_hash_encrypt = &H0 or flag_hash_decrypt = &H0 or flag_encrypt_hash = &H0 or flag_decrypt_hash = &H0 or flag_key_128_bit = &H0 or flag_key_256_bit = &H0 or flag_aes_ecb = &H0 or flag_aes_cbc = &H0 or flag_aes_ctr_icm = &H0 or flag_aes_ofb = &H0 or flag_aes_cfb = &H0 or flag_aes_xcbc_mac = &H0 or flag_gcm_hash = &H0 Then read
        If flag_hash_only_null = &H0 Then write_hash_only_null_value = get_hash_only_null
        If flag_encrypt_only = &H0 Then write_encrypt_only_value = get_encrypt_only
        If flag_hash_encrypt = &H0 Then write_hash_encrypt_value = get_hash_encrypt
        If flag_hash_decrypt = &H0 Then write_hash_decrypt_value = get_hash_decrypt
        If flag_encrypt_hash = &H0 Then write_encrypt_hash_value = get_encrypt_hash
        If flag_decrypt_hash = &H0 Then write_decrypt_hash_value = get_decrypt_hash
        If flag_key_128_bit = &H0 Then write_key_128_bit_value = get_key_128_bit
        If flag_key_256_bit = &H0 Then write_key_256_bit_value = get_key_256_bit
        If flag_aes_ecb = &H0 Then write_aes_ecb_value = get_aes_ecb
        If flag_aes_cbc = &H0 Then write_aes_cbc_value = get_aes_cbc
        If flag_aes_ctr_icm = &H0 Then write_aes_ctr_icm_value = get_aes_ctr_icm
        If flag_aes_ofb = &H0 Then write_aes_ofb_value = get_aes_ofb
        If flag_aes_cfb = &H0 Then write_aes_cfb_value = get_aes_cfb
        If flag_aes_xcbc_mac = &H0 Then write_aes_xcbc_mac_value = get_aes_xcbc_mac
        If flag_gcm_hash = &H0 Then write_gcm_hash_value = get_gcm_hash

        regValue = leftShift((write_hash_only_null_value and &H1), 0) + leftShift((write_encrypt_only_value and &H1), 1) + leftShift((write_hash_encrypt_value and &H1), 2) + leftShift((write_hash_decrypt_value and &H1), 3) + leftShift((write_encrypt_hash_value and &H1), 4) + leftShift((write_decrypt_hash_value and &H1), 5) + leftShift((write_key_128_bit_value and &H1), 6) + leftShift((write_key_256_bit_value and &H1), 7) + leftShift((write_aes_ecb_value and &H1), 8) + leftShift((write_aes_cbc_value and &H1), 9) + leftShift((write_aes_ctr_icm_value and &H1), 10) + leftShift((write_aes_ofb_value and &H1), 11) + leftShift((write_aes_cfb_value and &H1), 12) + leftShift((write_aes_xcbc_mac_value and &H1), 30) + leftShift((write_gcm_hash_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hash_only_null_mask = &H1
        if data_low > LONG_MAX then
            if hash_only_null_mask = mask then
                read_hash_only_null_value = data_low
            else
                read_hash_only_null_value = (data_low - H8000_0000) and hash_only_null_mask
            end If
        else
            read_hash_only_null_value = data_low and hash_only_null_mask
        end If
        read_encrypt_only_value = rightShift(data_low, 1) and &H1
        read_hash_encrypt_value = rightShift(data_low, 2) and &H1
        read_hash_decrypt_value = rightShift(data_low, 3) and &H1
        read_encrypt_hash_value = rightShift(data_low, 4) and &H1
        read_decrypt_hash_value = rightShift(data_low, 5) and &H1
        read_key_128_bit_value = rightShift(data_low, 6) and &H1
        read_key_256_bit_value = rightShift(data_low, 7) and &H1
        read_aes_ecb_value = rightShift(data_low, 8) and &H1
        read_aes_cbc_value = rightShift(data_low, 9) and &H1
        read_aes_ctr_icm_value = rightShift(data_low, 10) and &H1
        read_aes_ofb_value = rightShift(data_low, 11) and &H1
        read_aes_cfb_value = rightShift(data_low, 12) and &H1
        read_aes_xcbc_mac_value = rightShift(data_low, 30) and &H1
        read_gcm_hash_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hash_only_null_value = &H0
        flag_hash_only_null        = &H0
        write_encrypt_only_value = &H0
        flag_encrypt_only        = &H0
        write_hash_encrypt_value = &H0
        flag_hash_encrypt        = &H0
        write_hash_decrypt_value = &H0
        flag_hash_decrypt        = &H0
        write_encrypt_hash_value = &H0
        flag_encrypt_hash        = &H0
        write_decrypt_hash_value = &H0
        flag_decrypt_hash        = &H0
        write_key_128_bit_value = &H0
        flag_key_128_bit        = &H0
        write_key_256_bit_value = &H0
        flag_key_256_bit        = &H0
        write_aes_ecb_value = &H0
        flag_aes_ecb        = &H0
        write_aes_cbc_value = &H0
        flag_aes_cbc        = &H0
        write_aes_ctr_icm_value = &H0
        flag_aes_ctr_icm        = &H0
        write_aes_ofb_value = &H0
        flag_aes_ofb        = &H0
        write_aes_cfb_value = &H0
        flag_aes_cfb        = &H0
        write_aes_xcbc_mac_value = &H0
        flag_aes_xcbc_mac        = &H0
        write_gcm_hash_value = &H0
        flag_gcm_hash        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' context_size                               [4:0]            get_context_size
''                                                             set_context_size
''                                                             read_context_size
''                                                             write_context_size
''---------------------------------------------------------------------------------
'' address_mode                               [8:8]            get_address_mode
''                                                             set_address_mode
''                                                             read_address_mode
''                                                             write_address_mode
''---------------------------------------------------------------------------------
'' control_mode                               [9:9]            get_control_mode
''                                                             set_control_mode
''                                                             read_control_mode
''                                                             write_control_mode
''---------------------------------------------------------------------------------
'' pkt_num_thr_mode                           [10:10]          get_pkt_num_thr_mode
''                                                             set_pkt_num_thr_mode
''                                                             read_pkt_num_thr_mode
''                                                             write_pkt_num_thr_mode
''---------------------------------------------------------------------------------
'' macsec_ethertype                           [31:16]          get_macsec_ethertype
''                                                             set_macsec_ethertype
''                                                             read_macsec_ethertype
''                                                             write_macsec_ethertype
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_ctrl
    Private write_context_size_value
    Private read_context_size_value
    Private flag_context_size
    Private write_address_mode_value
    Private read_address_mode_value
    Private flag_address_mode
    Private write_control_mode_value
    Private read_control_mode_value
    Private flag_control_mode
    Private write_pkt_num_thr_mode_value
    Private read_pkt_num_thr_mode_value
    Private flag_pkt_num_thr_mode
    Private write_macsec_ethertype_value
    Private read_macsec_ethertype_value
    Private flag_macsec_ethertype

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_context_size
        get_context_size = read_context_size_value
    End Property

    Property Let set_context_size(aData)
        write_context_size_value = aData
        flag_context_size        = &H1
    End Property

    Property Get read_context_size
        read
        read_context_size = read_context_size_value
    End Property

    Property Let write_context_size(aData)
        set_context_size = aData
        write
    End Property

    Property Get get_address_mode
        get_address_mode = read_address_mode_value
    End Property

    Property Let set_address_mode(aData)
        write_address_mode_value = aData
        flag_address_mode        = &H1
    End Property

    Property Get read_address_mode
        read
        read_address_mode = read_address_mode_value
    End Property

    Property Let write_address_mode(aData)
        set_address_mode = aData
        write
    End Property

    Property Get get_control_mode
        get_control_mode = read_control_mode_value
    End Property

    Property Let set_control_mode(aData)
        write_control_mode_value = aData
        flag_control_mode        = &H1
    End Property

    Property Get read_control_mode
        read
        read_control_mode = read_control_mode_value
    End Property

    Property Let write_control_mode(aData)
        set_control_mode = aData
        write
    End Property

    Property Get get_pkt_num_thr_mode
        get_pkt_num_thr_mode = read_pkt_num_thr_mode_value
    End Property

    Property Let set_pkt_num_thr_mode(aData)
        write_pkt_num_thr_mode_value = aData
        flag_pkt_num_thr_mode        = &H1
    End Property

    Property Get read_pkt_num_thr_mode
        read
        read_pkt_num_thr_mode = read_pkt_num_thr_mode_value
    End Property

    Property Let write_pkt_num_thr_mode(aData)
        set_pkt_num_thr_mode = aData
        write
    End Property

    Property Get get_macsec_ethertype
        get_macsec_ethertype = read_macsec_ethertype_value
    End Property

    Property Let set_macsec_ethertype(aData)
        write_macsec_ethertype_value = aData
        flag_macsec_ethertype        = &H1
    End Property

    Property Get read_macsec_ethertype
        read
        read_macsec_ethertype = read_macsec_ethertype_value
    End Property

    Property Let write_macsec_ethertype(aData)
        set_macsec_ethertype = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        context_size_mask = &H1f
        if data_low > LONG_MAX then
            if context_size_mask = mask then
                read_context_size_value = data_low
            else
                read_context_size_value = (data_low - H8000_0000) and context_size_mask
            end If
        else
            read_context_size_value = data_low and context_size_mask
        end If
        read_address_mode_value = rightShift(data_low, 8) and &H1
        read_control_mode_value = rightShift(data_low, 9) and &H1
        read_pkt_num_thr_mode_value = rightShift(data_low, 10) and &H1
        read_macsec_ethertype_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_context_size = &H0 or flag_address_mode = &H0 or flag_control_mode = &H0 or flag_pkt_num_thr_mode = &H0 or flag_macsec_ethertype = &H0 Then read
        If flag_context_size = &H0 Then write_context_size_value = get_context_size
        If flag_address_mode = &H0 Then write_address_mode_value = get_address_mode
        If flag_control_mode = &H0 Then write_control_mode_value = get_control_mode
        If flag_pkt_num_thr_mode = &H0 Then write_pkt_num_thr_mode_value = get_pkt_num_thr_mode
        If flag_macsec_ethertype = &H0 Then write_macsec_ethertype_value = get_macsec_ethertype

        regValue = leftShift((write_context_size_value and &H1f), 0) + leftShift((write_address_mode_value and &H1), 8) + leftShift((write_control_mode_value and &H1), 9) + leftShift((write_pkt_num_thr_mode_value and &H1), 10) + leftShift((write_macsec_ethertype_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        context_size_mask = &H1f
        if data_low > LONG_MAX then
            if context_size_mask = mask then
                read_context_size_value = data_low
            else
                read_context_size_value = (data_low - H8000_0000) and context_size_mask
            end If
        else
            read_context_size_value = data_low and context_size_mask
        end If
        read_address_mode_value = rightShift(data_low, 8) and &H1
        read_control_mode_value = rightShift(data_low, 9) and &H1
        read_pkt_num_thr_mode_value = rightShift(data_low, 10) and &H1
        read_macsec_ethertype_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_context_size_value = &H0
        flag_context_size        = &H0
        write_address_mode_value = &H0
        flag_address_mode        = &H0
        write_control_mode_value = &H0
        flag_control_mode        = &H0
        write_pkt_num_thr_mode_value = &H0
        flag_pkt_num_thr_mode        = &H0
        write_macsec_ethertype_value = &H0
        flag_macsec_ethertype        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' error                                      [14:0]           get_error
''                                                             set_error
''                                                             read_error
''                                                             write_error
''---------------------------------------------------------------------------------
'' active_tokens                              [17:16]          get_active_tokens
''                                                             set_active_tokens
''                                                             read_active_tokens
''                                                             write_active_tokens
''---------------------------------------------------------------------------------
'' active_context                             [18:18]          get_active_context
''                                                             set_active_context
''                                                             read_active_context
''                                                             write_active_context
''---------------------------------------------------------------------------------
'' next_context                               [19:19]          get_next_context
''                                                             set_next_context
''                                                             read_next_context
''                                                             write_next_context
''---------------------------------------------------------------------------------
'' result_context                             [20:20]          get_result_context
''                                                             set_result_context
''                                                             read_result_context
''                                                             write_result_context
''---------------------------------------------------------------------------------
'' error_recovery                             [21:21]          get_error_recovery
''                                                             set_error_recovery
''                                                             read_error_recovery
''                                                             write_error_recovery
''---------------------------------------------------------------------------------
'' input_frame_current_state                  [31:28]          get_input_frame_current_state
''                                                             set_input_frame_current_state
''                                                             read_input_frame_current_state
''                                                             write_input_frame_current_state
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_stat
    Private write_error_value
    Private read_error_value
    Private flag_error
    Private write_active_tokens_value
    Private read_active_tokens_value
    Private flag_active_tokens
    Private write_active_context_value
    Private read_active_context_value
    Private flag_active_context
    Private write_next_context_value
    Private read_next_context_value
    Private flag_next_context
    Private write_result_context_value
    Private read_result_context_value
    Private flag_result_context
    Private write_error_recovery_value
    Private read_error_recovery_value
    Private flag_error_recovery
    Private write_input_frame_current_state_value
    Private read_input_frame_current_state_value
    Private flag_input_frame_current_state

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f40c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_error
        get_error = read_error_value
    End Property

    Property Let set_error(aData)
        write_error_value = aData
        flag_error        = &H1
    End Property

    Property Get read_error
        read
        read_error = read_error_value
    End Property

    Property Let write_error(aData)
        set_error = aData
        write
    End Property

    Property Get get_active_tokens
        get_active_tokens = read_active_tokens_value
    End Property

    Property Let set_active_tokens(aData)
        write_active_tokens_value = aData
        flag_active_tokens        = &H1
    End Property

    Property Get read_active_tokens
        read
        read_active_tokens = read_active_tokens_value
    End Property

    Property Let write_active_tokens(aData)
        set_active_tokens = aData
        write
    End Property

    Property Get get_active_context
        get_active_context = read_active_context_value
    End Property

    Property Let set_active_context(aData)
        write_active_context_value = aData
        flag_active_context        = &H1
    End Property

    Property Get read_active_context
        read
        read_active_context = read_active_context_value
    End Property

    Property Let write_active_context(aData)
        set_active_context = aData
        write
    End Property

    Property Get get_next_context
        get_next_context = read_next_context_value
    End Property

    Property Let set_next_context(aData)
        write_next_context_value = aData
        flag_next_context        = &H1
    End Property

    Property Get read_next_context
        read
        read_next_context = read_next_context_value
    End Property

    Property Let write_next_context(aData)
        set_next_context = aData
        write
    End Property

    Property Get get_result_context
        get_result_context = read_result_context_value
    End Property

    Property Let set_result_context(aData)
        write_result_context_value = aData
        flag_result_context        = &H1
    End Property

    Property Get read_result_context
        read
        read_result_context = read_result_context_value
    End Property

    Property Let write_result_context(aData)
        set_result_context = aData
        write
    End Property

    Property Get get_error_recovery
        get_error_recovery = read_error_recovery_value
    End Property

    Property Let set_error_recovery(aData)
        write_error_recovery_value = aData
        flag_error_recovery        = &H1
    End Property

    Property Get read_error_recovery
        read
        read_error_recovery = read_error_recovery_value
    End Property

    Property Let write_error_recovery(aData)
        set_error_recovery = aData
        write
    End Property

    Property Get get_input_frame_current_state
        get_input_frame_current_state = read_input_frame_current_state_value
    End Property

    Property Let set_input_frame_current_state(aData)
        write_input_frame_current_state_value = aData
        flag_input_frame_current_state        = &H1
    End Property

    Property Get read_input_frame_current_state
        read
        read_input_frame_current_state = read_input_frame_current_state_value
    End Property

    Property Let write_input_frame_current_state(aData)
        set_input_frame_current_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        error_mask = &H7fff
        if data_low > LONG_MAX then
            if error_mask = mask then
                read_error_value = data_low
            else
                read_error_value = (data_low - H8000_0000) and error_mask
            end If
        else
            read_error_value = data_low and error_mask
        end If
        read_active_tokens_value = rightShift(data_low, 16) and &H3
        read_active_context_value = rightShift(data_low, 18) and &H1
        read_next_context_value = rightShift(data_low, 19) and &H1
        read_result_context_value = rightShift(data_low, 20) and &H1
        read_error_recovery_value = rightShift(data_low, 21) and &H1
        read_input_frame_current_state_value = rightShift(data_low, 28) and &Hf

    End Sub

    Sub write
        If flag_error = &H0 or flag_active_tokens = &H0 or flag_active_context = &H0 or flag_next_context = &H0 or flag_result_context = &H0 or flag_error_recovery = &H0 or flag_input_frame_current_state = &H0 Then read
        If flag_error = &H0 Then write_error_value = get_error
        If flag_active_tokens = &H0 Then write_active_tokens_value = get_active_tokens
        If flag_active_context = &H0 Then write_active_context_value = get_active_context
        If flag_next_context = &H0 Then write_next_context_value = get_next_context
        If flag_result_context = &H0 Then write_result_context_value = get_result_context
        If flag_error_recovery = &H0 Then write_error_recovery_value = get_error_recovery
        If flag_input_frame_current_state = &H0 Then write_input_frame_current_state_value = get_input_frame_current_state

        regValue = leftShift((write_error_value and &H7fff), 0) + leftShift((write_active_tokens_value and &H3), 16) + leftShift((write_active_context_value and &H1), 18) + leftShift((write_next_context_value and &H1), 19) + leftShift((write_result_context_value and &H1), 20) + leftShift((write_error_recovery_value and &H1), 21) + leftShift((write_input_frame_current_state_value and &Hf), 28)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        error_mask = &H7fff
        if data_low > LONG_MAX then
            if error_mask = mask then
                read_error_value = data_low
            else
                read_error_value = (data_low - H8000_0000) and error_mask
            end If
        else
            read_error_value = data_low and error_mask
        end If
        read_active_tokens_value = rightShift(data_low, 16) and &H3
        read_active_context_value = rightShift(data_low, 18) and &H1
        read_next_context_value = rightShift(data_low, 19) and &H1
        read_result_context_value = rightShift(data_low, 20) and &H1
        read_error_recovery_value = rightShift(data_low, 21) and &H1
        read_input_frame_current_state_value = rightShift(data_low, 28) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_error_value = &H0
        flag_error        = &H0
        write_active_tokens_value = &H0
        flag_active_tokens        = &H0
        write_active_context_value = &H0
        flag_active_context        = &H0
        write_next_context_value = &H0
        flag_next_context        = &H0
        write_result_context_value = &H0
        flag_result_context        = &H0
        write_error_recovery_value = &H0
        flag_error_recovery        = &H0
        write_input_frame_current_state_value = &H0
        flag_input_frame_current_state        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_int_ctrl_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' input_error                                [0:0]            get_input_error
''                                                             set_input_error
''                                                             read_input_error
''                                                             write_input_error
''---------------------------------------------------------------------------------
'' output_error                               [1:1]            get_output_error
''                                                             set_output_error
''                                                             read_output_error
''                                                             write_output_error
''---------------------------------------------------------------------------------
'' processing_error                           [2:2]            get_processing_error
''                                                             set_processing_error
''                                                             read_processing_error
''                                                             write_processing_error
''---------------------------------------------------------------------------------
'' context_error                              [3:3]            get_context_error
''                                                             set_context_error
''                                                             read_context_error
''                                                             write_context_error
''---------------------------------------------------------------------------------
'' seqnum_threshold                           [4:4]            get_seqnum_threshold
''                                                             set_seqnum_threshold
''                                                             read_seqnum_threshold
''                                                             write_seqnum_threshold
''---------------------------------------------------------------------------------
'' seqnum_rollover                            [5:5]            get_seqnum_rollover
''                                                             set_seqnum_rollover
''                                                             read_seqnum_rollover
''                                                             write_seqnum_rollover
''---------------------------------------------------------------------------------
'' fatal_error                                [14:14]          get_fatal_error
''                                                             set_fatal_error
''                                                             read_fatal_error
''                                                             write_fatal_error
''---------------------------------------------------------------------------------
'' interrupt_out                              [15:15]          get_interrupt_out
''                                                             set_interrupt_out
''                                                             read_interrupt_out
''                                                             write_interrupt_out
''---------------------------------------------------------------------------------
'' input_error_en                             [16:16]          get_input_error_en
''                                                             set_input_error_en
''                                                             read_input_error_en
''                                                             write_input_error_en
''---------------------------------------------------------------------------------
'' output_error_en                            [17:17]          get_output_error_en
''                                                             set_output_error_en
''                                                             read_output_error_en
''                                                             write_output_error_en
''---------------------------------------------------------------------------------
'' processing_error_en                        [18:18]          get_processing_error_en
''                                                             set_processing_error_en
''                                                             read_processing_error_en
''                                                             write_processing_error_en
''---------------------------------------------------------------------------------
'' context_error_en                           [19:19]          get_context_error_en
''                                                             set_context_error_en
''                                                             read_context_error_en
''                                                             write_context_error_en
''---------------------------------------------------------------------------------
'' seqnum_threshold_en                        [20:20]          get_seqnum_threshold_en
''                                                             set_seqnum_threshold_en
''                                                             read_seqnum_threshold_en
''                                                             write_seqnum_threshold_en
''---------------------------------------------------------------------------------
'' seqnum_rollover_en                         [21:21]          get_seqnum_rollover_en
''                                                             set_seqnum_rollover_en
''                                                             read_seqnum_rollover_en
''                                                             write_seqnum_rollover_en
''---------------------------------------------------------------------------------
'' fatal_error_en                             [30:30]          get_fatal_error_en
''                                                             set_fatal_error_en
''                                                             read_fatal_error_en
''                                                             write_fatal_error_en
''---------------------------------------------------------------------------------
'' interrupt_out_en                           [31:31]          get_interrupt_out_en
''                                                             set_interrupt_out_en
''                                                             read_interrupt_out_en
''                                                             write_interrupt_out_en
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_int_ctrl_stat
    Private write_input_error_value
    Private read_input_error_value
    Private flag_input_error
    Private write_output_error_value
    Private read_output_error_value
    Private flag_output_error
    Private write_processing_error_value
    Private read_processing_error_value
    Private flag_processing_error
    Private write_context_error_value
    Private read_context_error_value
    Private flag_context_error
    Private write_seqnum_threshold_value
    Private read_seqnum_threshold_value
    Private flag_seqnum_threshold
    Private write_seqnum_rollover_value
    Private read_seqnum_rollover_value
    Private flag_seqnum_rollover
    Private write_fatal_error_value
    Private read_fatal_error_value
    Private flag_fatal_error
    Private write_interrupt_out_value
    Private read_interrupt_out_value
    Private flag_interrupt_out
    Private write_input_error_en_value
    Private read_input_error_en_value
    Private flag_input_error_en
    Private write_output_error_en_value
    Private read_output_error_en_value
    Private flag_output_error_en
    Private write_processing_error_en_value
    Private read_processing_error_en_value
    Private flag_processing_error_en
    Private write_context_error_en_value
    Private read_context_error_en_value
    Private flag_context_error_en
    Private write_seqnum_threshold_en_value
    Private read_seqnum_threshold_en_value
    Private flag_seqnum_threshold_en
    Private write_seqnum_rollover_en_value
    Private read_seqnum_rollover_en_value
    Private flag_seqnum_rollover_en
    Private write_fatal_error_en_value
    Private read_fatal_error_en_value
    Private flag_fatal_error_en
    Private write_interrupt_out_en_value
    Private read_interrupt_out_en_value
    Private flag_interrupt_out_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f410
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_input_error
        get_input_error = read_input_error_value
    End Property

    Property Let set_input_error(aData)
        write_input_error_value = aData
        flag_input_error        = &H1
    End Property

    Property Get read_input_error
        read
        read_input_error = read_input_error_value
    End Property

    Property Let write_input_error(aData)
        set_input_error = aData
        write
    End Property

    Property Get get_output_error
        get_output_error = read_output_error_value
    End Property

    Property Let set_output_error(aData)
        write_output_error_value = aData
        flag_output_error        = &H1
    End Property

    Property Get read_output_error
        read
        read_output_error = read_output_error_value
    End Property

    Property Let write_output_error(aData)
        set_output_error = aData
        write
    End Property

    Property Get get_processing_error
        get_processing_error = read_processing_error_value
    End Property

    Property Let set_processing_error(aData)
        write_processing_error_value = aData
        flag_processing_error        = &H1
    End Property

    Property Get read_processing_error
        read
        read_processing_error = read_processing_error_value
    End Property

    Property Let write_processing_error(aData)
        set_processing_error = aData
        write
    End Property

    Property Get get_context_error
        get_context_error = read_context_error_value
    End Property

    Property Let set_context_error(aData)
        write_context_error_value = aData
        flag_context_error        = &H1
    End Property

    Property Get read_context_error
        read
        read_context_error = read_context_error_value
    End Property

    Property Let write_context_error(aData)
        set_context_error = aData
        write
    End Property

    Property Get get_seqnum_threshold
        get_seqnum_threshold = read_seqnum_threshold_value
    End Property

    Property Let set_seqnum_threshold(aData)
        write_seqnum_threshold_value = aData
        flag_seqnum_threshold        = &H1
    End Property

    Property Get read_seqnum_threshold
        read
        read_seqnum_threshold = read_seqnum_threshold_value
    End Property

    Property Let write_seqnum_threshold(aData)
        set_seqnum_threshold = aData
        write
    End Property

    Property Get get_seqnum_rollover
        get_seqnum_rollover = read_seqnum_rollover_value
    End Property

    Property Let set_seqnum_rollover(aData)
        write_seqnum_rollover_value = aData
        flag_seqnum_rollover        = &H1
    End Property

    Property Get read_seqnum_rollover
        read
        read_seqnum_rollover = read_seqnum_rollover_value
    End Property

    Property Let write_seqnum_rollover(aData)
        set_seqnum_rollover = aData
        write
    End Property

    Property Get get_fatal_error
        get_fatal_error = read_fatal_error_value
    End Property

    Property Let set_fatal_error(aData)
        write_fatal_error_value = aData
        flag_fatal_error        = &H1
    End Property

    Property Get read_fatal_error
        read
        read_fatal_error = read_fatal_error_value
    End Property

    Property Let write_fatal_error(aData)
        set_fatal_error = aData
        write
    End Property

    Property Get get_interrupt_out
        get_interrupt_out = read_interrupt_out_value
    End Property

    Property Let set_interrupt_out(aData)
        write_interrupt_out_value = aData
        flag_interrupt_out        = &H1
    End Property

    Property Get read_interrupt_out
        read
        read_interrupt_out = read_interrupt_out_value
    End Property

    Property Let write_interrupt_out(aData)
        set_interrupt_out = aData
        write
    End Property

    Property Get get_input_error_en
        get_input_error_en = read_input_error_en_value
    End Property

    Property Let set_input_error_en(aData)
        write_input_error_en_value = aData
        flag_input_error_en        = &H1
    End Property

    Property Get read_input_error_en
        read
        read_input_error_en = read_input_error_en_value
    End Property

    Property Let write_input_error_en(aData)
        set_input_error_en = aData
        write
    End Property

    Property Get get_output_error_en
        get_output_error_en = read_output_error_en_value
    End Property

    Property Let set_output_error_en(aData)
        write_output_error_en_value = aData
        flag_output_error_en        = &H1
    End Property

    Property Get read_output_error_en
        read
        read_output_error_en = read_output_error_en_value
    End Property

    Property Let write_output_error_en(aData)
        set_output_error_en = aData
        write
    End Property

    Property Get get_processing_error_en
        get_processing_error_en = read_processing_error_en_value
    End Property

    Property Let set_processing_error_en(aData)
        write_processing_error_en_value = aData
        flag_processing_error_en        = &H1
    End Property

    Property Get read_processing_error_en
        read
        read_processing_error_en = read_processing_error_en_value
    End Property

    Property Let write_processing_error_en(aData)
        set_processing_error_en = aData
        write
    End Property

    Property Get get_context_error_en
        get_context_error_en = read_context_error_en_value
    End Property

    Property Let set_context_error_en(aData)
        write_context_error_en_value = aData
        flag_context_error_en        = &H1
    End Property

    Property Get read_context_error_en
        read
        read_context_error_en = read_context_error_en_value
    End Property

    Property Let write_context_error_en(aData)
        set_context_error_en = aData
        write
    End Property

    Property Get get_seqnum_threshold_en
        get_seqnum_threshold_en = read_seqnum_threshold_en_value
    End Property

    Property Let set_seqnum_threshold_en(aData)
        write_seqnum_threshold_en_value = aData
        flag_seqnum_threshold_en        = &H1
    End Property

    Property Get read_seqnum_threshold_en
        read
        read_seqnum_threshold_en = read_seqnum_threshold_en_value
    End Property

    Property Let write_seqnum_threshold_en(aData)
        set_seqnum_threshold_en = aData
        write
    End Property

    Property Get get_seqnum_rollover_en
        get_seqnum_rollover_en = read_seqnum_rollover_en_value
    End Property

    Property Let set_seqnum_rollover_en(aData)
        write_seqnum_rollover_en_value = aData
        flag_seqnum_rollover_en        = &H1
    End Property

    Property Get read_seqnum_rollover_en
        read
        read_seqnum_rollover_en = read_seqnum_rollover_en_value
    End Property

    Property Let write_seqnum_rollover_en(aData)
        set_seqnum_rollover_en = aData
        write
    End Property

    Property Get get_fatal_error_en
        get_fatal_error_en = read_fatal_error_en_value
    End Property

    Property Let set_fatal_error_en(aData)
        write_fatal_error_en_value = aData
        flag_fatal_error_en        = &H1
    End Property

    Property Get read_fatal_error_en
        read
        read_fatal_error_en = read_fatal_error_en_value
    End Property

    Property Let write_fatal_error_en(aData)
        set_fatal_error_en = aData
        write
    End Property

    Property Get get_interrupt_out_en
        get_interrupt_out_en = read_interrupt_out_en_value
    End Property

    Property Let set_interrupt_out_en(aData)
        write_interrupt_out_en_value = aData
        flag_interrupt_out_en        = &H1
    End Property

    Property Get read_interrupt_out_en
        read
        read_interrupt_out_en = read_interrupt_out_en_value
    End Property

    Property Let write_interrupt_out_en(aData)
        set_interrupt_out_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        input_error_mask = &H1
        if data_low > LONG_MAX then
            if input_error_mask = mask then
                read_input_error_value = data_low
            else
                read_input_error_value = (data_low - H8000_0000) and input_error_mask
            end If
        else
            read_input_error_value = data_low and input_error_mask
        end If
        read_output_error_value = rightShift(data_low, 1) and &H1
        read_processing_error_value = rightShift(data_low, 2) and &H1
        read_context_error_value = rightShift(data_low, 3) and &H1
        read_seqnum_threshold_value = rightShift(data_low, 4) and &H1
        read_seqnum_rollover_value = rightShift(data_low, 5) and &H1
        read_fatal_error_value = rightShift(data_low, 14) and &H1
        read_interrupt_out_value = rightShift(data_low, 15) and &H1
        read_input_error_en_value = rightShift(data_low, 16) and &H1
        read_output_error_en_value = rightShift(data_low, 17) and &H1
        read_processing_error_en_value = rightShift(data_low, 18) and &H1
        read_context_error_en_value = rightShift(data_low, 19) and &H1
        read_seqnum_threshold_en_value = rightShift(data_low, 20) and &H1
        read_seqnum_rollover_en_value = rightShift(data_low, 21) and &H1
        read_fatal_error_en_value = rightShift(data_low, 30) and &H1
        read_interrupt_out_en_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_input_error = &H0 or flag_output_error = &H0 or flag_processing_error = &H0 or flag_context_error = &H0 or flag_seqnum_threshold = &H0 or flag_seqnum_rollover = &H0 or flag_fatal_error = &H0 or flag_interrupt_out = &H0 or flag_input_error_en = &H0 or flag_output_error_en = &H0 or flag_processing_error_en = &H0 or flag_context_error_en = &H0 or flag_seqnum_threshold_en = &H0 or flag_seqnum_rollover_en = &H0 or flag_fatal_error_en = &H0 or flag_interrupt_out_en = &H0 Then read
        If flag_input_error = &H0 Then write_input_error_value = get_input_error
        If flag_output_error = &H0 Then write_output_error_value = get_output_error
        If flag_processing_error = &H0 Then write_processing_error_value = get_processing_error
        If flag_context_error = &H0 Then write_context_error_value = get_context_error
        If flag_seqnum_threshold = &H0 Then write_seqnum_threshold_value = get_seqnum_threshold
        If flag_seqnum_rollover = &H0 Then write_seqnum_rollover_value = get_seqnum_rollover
        If flag_fatal_error = &H0 Then write_fatal_error_value = get_fatal_error
        If flag_interrupt_out = &H0 Then write_interrupt_out_value = get_interrupt_out
        If flag_input_error_en = &H0 Then write_input_error_en_value = get_input_error_en
        If flag_output_error_en = &H0 Then write_output_error_en_value = get_output_error_en
        If flag_processing_error_en = &H0 Then write_processing_error_en_value = get_processing_error_en
        If flag_context_error_en = &H0 Then write_context_error_en_value = get_context_error_en
        If flag_seqnum_threshold_en = &H0 Then write_seqnum_threshold_en_value = get_seqnum_threshold_en
        If flag_seqnum_rollover_en = &H0 Then write_seqnum_rollover_en_value = get_seqnum_rollover_en
        If flag_fatal_error_en = &H0 Then write_fatal_error_en_value = get_fatal_error_en
        If flag_interrupt_out_en = &H0 Then write_interrupt_out_en_value = get_interrupt_out_en

        regValue = leftShift((write_input_error_value and &H1), 0) + leftShift((write_output_error_value and &H1), 1) + leftShift((write_processing_error_value and &H1), 2) + leftShift((write_context_error_value and &H1), 3) + leftShift((write_seqnum_threshold_value and &H1), 4) + leftShift((write_seqnum_rollover_value and &H1), 5) + leftShift((write_fatal_error_value and &H1), 14) + leftShift((write_interrupt_out_value and &H1), 15) + leftShift((write_input_error_en_value and &H1), 16) + leftShift((write_output_error_en_value and &H1), 17) + leftShift((write_processing_error_en_value and &H1), 18) + leftShift((write_context_error_en_value and &H1), 19) + leftShift((write_seqnum_threshold_en_value and &H1), 20) + leftShift((write_seqnum_rollover_en_value and &H1), 21) + leftShift((write_fatal_error_en_value and &H1), 30) + leftShift((write_interrupt_out_en_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        input_error_mask = &H1
        if data_low > LONG_MAX then
            if input_error_mask = mask then
                read_input_error_value = data_low
            else
                read_input_error_value = (data_low - H8000_0000) and input_error_mask
            end If
        else
            read_input_error_value = data_low and input_error_mask
        end If
        read_output_error_value = rightShift(data_low, 1) and &H1
        read_processing_error_value = rightShift(data_low, 2) and &H1
        read_context_error_value = rightShift(data_low, 3) and &H1
        read_seqnum_threshold_value = rightShift(data_low, 4) and &H1
        read_seqnum_rollover_value = rightShift(data_low, 5) and &H1
        read_fatal_error_value = rightShift(data_low, 14) and &H1
        read_interrupt_out_value = rightShift(data_low, 15) and &H1
        read_input_error_en_value = rightShift(data_low, 16) and &H1
        read_output_error_en_value = rightShift(data_low, 17) and &H1
        read_processing_error_en_value = rightShift(data_low, 18) and &H1
        read_context_error_en_value = rightShift(data_low, 19) and &H1
        read_seqnum_threshold_en_value = rightShift(data_low, 20) and &H1
        read_seqnum_rollover_en_value = rightShift(data_low, 21) and &H1
        read_fatal_error_en_value = rightShift(data_low, 30) and &H1
        read_interrupt_out_en_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_input_error_value = &H0
        flag_input_error        = &H0
        write_output_error_value = &H0
        flag_output_error        = &H0
        write_processing_error_value = &H0
        flag_processing_error        = &H0
        write_context_error_value = &H0
        flag_context_error        = &H0
        write_seqnum_threshold_value = &H0
        flag_seqnum_threshold        = &H0
        write_seqnum_rollover_value = &H0
        flag_seqnum_rollover        = &H0
        write_fatal_error_value = &H0
        flag_fatal_error        = &H0
        write_interrupt_out_value = &H0
        flag_interrupt_out        = &H0
        write_input_error_en_value = &H0
        flag_input_error_en        = &H0
        write_output_error_en_value = &H0
        flag_output_error_en        = &H0
        write_processing_error_en_value = &H0
        flag_processing_error_en        = &H0
        write_context_error_en_value = &H0
        flag_context_error_en        = &H0
        write_seqnum_threshold_en_value = &H0
        flag_seqnum_threshold_en        = &H0
        write_seqnum_rollover_en_value = &H0
        flag_seqnum_rollover_en        = &H0
        write_fatal_error_en_value = &H0
        flag_fatal_error_en        = &H0
        write_interrupt_out_en_value = &H0
        flag_interrupt_out_en        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_sw_interrupt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_interrupt                               [31:0]           get_sw_interrupt
''                                                             set_sw_interrupt
''                                                             read_sw_interrupt
''                                                             write_sw_interrupt
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_sw_interrupt
    Private write_sw_interrupt_value
    Private read_sw_interrupt_value
    Private flag_sw_interrupt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_interrupt
        get_sw_interrupt = read_sw_interrupt_value
    End Property

    Property Let set_sw_interrupt(aData)
        write_sw_interrupt_value = aData
        flag_sw_interrupt        = &H1
    End Property

    Property Get read_sw_interrupt
        read
        read_sw_interrupt = read_sw_interrupt_value
    End Property

    Property Let write_sw_interrupt(aData)
        set_sw_interrupt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_interrupt_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_interrupt_mask = mask then
                read_sw_interrupt_value = data_low
            else
                read_sw_interrupt_value = (data_low - H8000_0000) and sw_interrupt_mask
            end If
        else
            read_sw_interrupt_value = data_low and sw_interrupt_mask
        end If

    End Sub

    Sub write
        If flag_sw_interrupt = &H0 Then read
        If flag_sw_interrupt = &H0 Then write_sw_interrupt_value = get_sw_interrupt

        regValue = leftShift(write_sw_interrupt_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_interrupt_mask = &Hffffffff
        if data_low > LONG_MAX then
            if sw_interrupt_mask = mask then
                read_sw_interrupt_value = data_low
            else
                read_sw_interrupt_value = (data_low - H8000_0000) and sw_interrupt_mask
            end If
        else
            read_sw_interrupt_value = data_low and sw_interrupt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_interrupt_value = &H0
        flag_sw_interrupt        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dummy                                      [31:0]           get_dummy
''                                                             set_dummy
''                                                             read_dummy
''                                                             write_dummy
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold
    Private write_dummy_value
    Private read_dummy_value
    Private flag_dummy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f420
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dummy
        get_dummy = read_dummy_value
    End Property

    Property Let set_dummy(aData)
        write_dummy_value = aData
        flag_dummy        = &H1
    End Property

    Property Get read_dummy
        read
        read_dummy = read_dummy_value
    End Property

    Property Let write_dummy(aData)
        set_dummy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

    End Sub

    Sub write
        If flag_dummy = &H0 Then read
        If flag_dummy = &H0 Then write_dummy_value = get_dummy

        regValue = leftShift(write_dummy_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dummy_value = &H0
        flag_dummy        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold64_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dummy                                      [31:0]           get_dummy
''                                                             set_dummy
''                                                             read_dummy
''                                                             write_dummy
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold64_lo
    Private write_dummy_value
    Private read_dummy_value
    Private flag_dummy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f424
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dummy
        get_dummy = read_dummy_value
    End Property

    Property Let set_dummy(aData)
        write_dummy_value = aData
        flag_dummy        = &H1
    End Property

    Property Get read_dummy
        read
        read_dummy = read_dummy_value
    End Property

    Property Let write_dummy(aData)
        set_dummy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

    End Sub

    Sub write
        If flag_dummy = &H0 Then read
        If flag_dummy = &H0 Then write_dummy_value = get_dummy

        regValue = leftShift(write_dummy_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dummy_value = &H0
        flag_dummy        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold64_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dummy                                      [31:0]           get_dummy
''                                                             set_dummy
''                                                             read_dummy
''                                                             write_dummy
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold64_hi
    Private write_dummy_value
    Private read_dummy_value
    Private flag_dummy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f428
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dummy
        get_dummy = read_dummy_value
    End Property

    Property Let set_dummy(aData)
        write_dummy_value = aData
        flag_dummy        = &H1
    End Property

    Property Get read_dummy
        read
        read_dummy = read_dummy_value
    End Property

    Property Let write_dummy(aData)
        set_dummy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

    End Sub

    Sub write
        If flag_dummy = &H0 Then read
        If flag_dummy = &H0 Then write_dummy_value = get_dummy

        regValue = leftShift(write_dummy_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dummy_value = &H0
        flag_dummy        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_upd_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' block_context_updates                      [1:0]            get_block_context_updates
''                                                             set_block_context_updates
''                                                             read_block_context_updates
''                                                             write_block_context_updates
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_upd_ctrl
    Private write_block_context_updates_value
    Private read_block_context_updates_value
    Private flag_block_context_updates

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f430
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_block_context_updates
        get_block_context_updates = read_block_context_updates_value
    End Property

    Property Let set_block_context_updates(aData)
        write_block_context_updates_value = aData
        flag_block_context_updates        = &H1
    End Property

    Property Get read_block_context_updates
        read
        read_block_context_updates = read_block_context_updates_value
    End Property

    Property Let write_block_context_updates(aData)
        set_block_context_updates = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        block_context_updates_mask = &H3
        if data_low > LONG_MAX then
            if block_context_updates_mask = mask then
                read_block_context_updates_value = data_low
            else
                read_block_context_updates_value = (data_low - H8000_0000) and block_context_updates_mask
            end If
        else
            read_block_context_updates_value = data_low and block_context_updates_mask
        end If

    End Sub

    Sub write
        If flag_block_context_updates = &H0 Then read
        If flag_block_context_updates = &H0 Then write_block_context_updates_value = get_block_context_updates

        regValue = leftShift((write_block_context_updates_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        block_context_updates_mask = &H3
        if data_low > LONG_MAX then
            if block_context_updates_mask = mask then
                read_block_context_updates_value = data_low
            else
                read_block_context_updates_value = (data_low - H8000_0000) and block_context_updates_mask
            end If
        else
            read_block_context_updates_value = data_low and block_context_updates_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_block_context_updates_value = &H0
        flag_block_context_updates        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dummy                                      [31:0]           get_dummy
''                                                             set_dummy
''                                                             read_dummy
''                                                             write_dummy
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_lo
    Private write_dummy_value
    Private read_dummy_value
    Private flag_dummy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f480
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dummy
        get_dummy = read_dummy_value
    End Property

    Property Let set_dummy(aData)
        write_dummy_value = aData
        flag_dummy        = &H1
    End Property

    Property Get read_dummy
        read
        read_dummy = read_dummy_value
    End Property

    Property Let write_dummy(aData)
        set_dummy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

    End Sub

    Sub write
        If flag_dummy = &H0 Then read
        If flag_dummy = &H0 Then write_dummy_value = get_dummy

        regValue = leftShift(write_dummy_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dummy_value = &H0
        flag_dummy        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dummy                                      [31:0]           get_dummy
''                                                             set_dummy
''                                                             read_dummy
''                                                             write_dummy
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_hi
    Private write_dummy_value
    Private read_dummy_value
    Private flag_dummy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f484
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dummy
        get_dummy = read_dummy_value
    End Property

    Property Let set_dummy(aData)
        write_dummy_value = aData
        flag_dummy        = &H1
    End Property

    Property Get read_dummy
        read
        read_dummy = read_dummy_value
    End Property

    Property Let write_dummy(aData)
        set_dummy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

    End Sub

    Sub write
        If flag_dummy = &H0 Then read
        If flag_dummy = &H0 Then write_dummy_value = get_dummy

        regValue = leftShift(write_dummy_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dummy_value = &H0
        flag_dummy        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_ctx_id
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dummy                                      [31:0]           get_dummy
''                                                             set_dummy
''                                                             read_dummy
''                                                             write_dummy
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_ctx_id
    Private write_dummy_value
    Private read_dummy_value
    Private flag_dummy

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f488
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_dummy
        get_dummy = read_dummy_value
    End Property

    Property Let set_dummy(aData)
        write_dummy_value = aData
        flag_dummy        = &H1
    End Property

    Property Get read_dummy
        read
        read_dummy = read_dummy_value
    End Property

    Property Let write_dummy(aData)
        set_dummy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

    End Sub

    Sub write
        If flag_dummy = &H0 Then read
        If flag_dummy = &H0 Then write_dummy_value = get_dummy

        regValue = leftShift(write_dummy_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        dummy_mask = &Hffffffff
        if data_low > LONG_MAX then
            if dummy_mask = mask then
                read_dummy_value = data_low
            else
                read_dummy_value = (data_low - H8000_0000) and dummy_mask
            end If
        else
            read_dummy_value = data_low and dummy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dummy_value = &H0
        flag_dummy        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable_update                              [0:0]            get_enable_update
''                                                             set_enable_update
''                                                             read_enable_update
''                                                             write_enable_update
''---------------------------------------------------------------------------------
'' nextpn_written                             [1:1]            get_nextpn_written
''                                                             set_nextpn_written
''                                                             read_nextpn_written
''                                                             write_nextpn_written
''---------------------------------------------------------------------------------
'' sequence_number_size                       [2:2]            get_sequence_number_size
''                                                             set_sequence_number_size
''                                                             read_sequence_number_size
''                                                             write_sequence_number_size
''---------------------------------------------------------------------------------
'' nextpn_context_address                     [31:4]           get_nextpn_context_address
''                                                             set_nextpn_context_address
''                                                             read_nextpn_context_address
''                                                             write_nextpn_context_address
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_ctrl
    Private write_enable_update_value
    Private read_enable_update_value
    Private flag_enable_update
    Private write_nextpn_written_value
    Private read_nextpn_written_value
    Private flag_nextpn_written
    Private write_sequence_number_size_value
    Private read_sequence_number_size_value
    Private flag_sequence_number_size
    Private write_nextpn_context_address_value
    Private read_nextpn_context_address_value
    Private flag_nextpn_context_address

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f48c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable_update
        get_enable_update = read_enable_update_value
    End Property

    Property Let set_enable_update(aData)
        write_enable_update_value = aData
        flag_enable_update        = &H1
    End Property

    Property Get read_enable_update
        read
        read_enable_update = read_enable_update_value
    End Property

    Property Let write_enable_update(aData)
        set_enable_update = aData
        write
    End Property

    Property Get get_nextpn_written
        get_nextpn_written = read_nextpn_written_value
    End Property

    Property Let set_nextpn_written(aData)
        write_nextpn_written_value = aData
        flag_nextpn_written        = &H1
    End Property

    Property Get read_nextpn_written
        read
        read_nextpn_written = read_nextpn_written_value
    End Property

    Property Let write_nextpn_written(aData)
        set_nextpn_written = aData
        write
    End Property

    Property Get get_sequence_number_size
        get_sequence_number_size = read_sequence_number_size_value
    End Property

    Property Let set_sequence_number_size(aData)
        write_sequence_number_size_value = aData
        flag_sequence_number_size        = &H1
    End Property

    Property Get read_sequence_number_size
        read
        read_sequence_number_size = read_sequence_number_size_value
    End Property

    Property Let write_sequence_number_size(aData)
        set_sequence_number_size = aData
        write
    End Property

    Property Get get_nextpn_context_address
        get_nextpn_context_address = read_nextpn_context_address_value
    End Property

    Property Let set_nextpn_context_address(aData)
        write_nextpn_context_address_value = aData
        flag_nextpn_context_address        = &H1
    End Property

    Property Get read_nextpn_context_address
        read
        read_nextpn_context_address = read_nextpn_context_address_value
    End Property

    Property Let write_nextpn_context_address(aData)
        set_nextpn_context_address = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_update_mask = &H1
        if data_low > LONG_MAX then
            if enable_update_mask = mask then
                read_enable_update_value = data_low
            else
                read_enable_update_value = (data_low - H8000_0000) and enable_update_mask
            end If
        else
            read_enable_update_value = data_low and enable_update_mask
        end If
        read_nextpn_written_value = rightShift(data_low, 1) and &H1
        read_sequence_number_size_value = rightShift(data_low, 2) and &H1
        read_nextpn_context_address_value = rightShift(data_low, 4) and &Hfffffff

    End Sub

    Sub write
        If flag_enable_update = &H0 or flag_nextpn_written = &H0 or flag_sequence_number_size = &H0 or flag_nextpn_context_address = &H0 Then read
        If flag_enable_update = &H0 Then write_enable_update_value = get_enable_update
        If flag_nextpn_written = &H0 Then write_nextpn_written_value = get_nextpn_written
        If flag_sequence_number_size = &H0 Then write_sequence_number_size_value = get_sequence_number_size
        If flag_nextpn_context_address = &H0 Then write_nextpn_context_address_value = get_nextpn_context_address

        regValue = leftShift((write_enable_update_value and &H1), 0) + leftShift((write_nextpn_written_value and &H1), 1) + leftShift((write_sequence_number_size_value and &H1), 2) + leftShift((write_nextpn_context_address_value and &Hfffffff), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_update_mask = &H1
        if data_low > LONG_MAX then
            if enable_update_mask = mask then
                read_enable_update_value = data_low
            else
                read_enable_update_value = (data_low - H8000_0000) and enable_update_mask
            end If
        else
            read_enable_update_value = data_low and enable_update_mask
        end If
        read_nextpn_written_value = rightShift(data_low, 1) and &H1
        read_sequence_number_size_value = rightShift(data_low, 2) and &H1
        read_nextpn_context_address_value = rightShift(data_low, 4) and &Hfffffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_update_value = &H0
        flag_enable_update        = &H0
        write_nextpn_written_value = &H0
        flag_nextpn_written        = &H0
        write_sequence_number_size_value = &H0
        flag_sequence_number_size        = &H0
        write_nextpn_context_address_value = &H0
        flag_nextpn_context_address        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_update_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' update_threshold                           [7:0]            get_update_threshold
''                                                             set_update_threshold
''                                                             read_update_threshold
''                                                             write_update_threshold
''---------------------------------------------------------------------------------
'' threshold_en                               [31:31]          get_threshold_en
''                                                             set_threshold_en
''                                                             read_threshold_en
''                                                             write_threshold_en
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_update_ctrl
    Private write_update_threshold_value
    Private read_update_threshold_value
    Private flag_update_threshold
    Private write_threshold_en_value
    Private read_threshold_en_value
    Private flag_threshold_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f4c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_update_threshold
        get_update_threshold = read_update_threshold_value
    End Property

    Property Let set_update_threshold(aData)
        write_update_threshold_value = aData
        flag_update_threshold        = &H1
    End Property

    Property Get read_update_threshold
        read
        read_update_threshold = read_update_threshold_value
    End Property

    Property Let write_update_threshold(aData)
        set_update_threshold = aData
        write
    End Property

    Property Get get_threshold_en
        get_threshold_en = read_threshold_en_value
    End Property

    Property Let set_threshold_en(aData)
        write_threshold_en_value = aData
        flag_threshold_en        = &H1
    End Property

    Property Get read_threshold_en
        read
        read_threshold_en = read_threshold_en_value
    End Property

    Property Let write_threshold_en(aData)
        set_threshold_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        update_threshold_mask = &Hff
        if data_low > LONG_MAX then
            if update_threshold_mask = mask then
                read_update_threshold_value = data_low
            else
                read_update_threshold_value = (data_low - H8000_0000) and update_threshold_mask
            end If
        else
            read_update_threshold_value = data_low and update_threshold_mask
        end If
        read_threshold_en_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_update_threshold = &H0 or flag_threshold_en = &H0 Then read
        If flag_update_threshold = &H0 Then write_update_threshold_value = get_update_threshold
        If flag_threshold_en = &H0 Then write_threshold_en_value = get_threshold_en

        regValue = leftShift((write_update_threshold_value and &Hff), 0) + leftShift((write_threshold_en_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        update_threshold_mask = &Hff
        if data_low > LONG_MAX then
            if update_threshold_mask = mask then
                read_update_threshold_value = data_low
            else
                read_update_threshold_value = (data_low - H8000_0000) and update_threshold_mask
            end If
        else
            read_update_threshold_value = data_low and update_threshold_mask
        end If
        read_threshold_en_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_update_threshold_value = &H0
        flag_update_threshold        = &H0
        write_threshold_en_value = &H0
        flag_threshold_en        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' minor_version                              [3:0]            get_minor_version
''                                                             set_minor_version
''                                                             read_minor_version
''                                                             write_minor_version
''---------------------------------------------------------------------------------
'' major_version                              [7:4]            get_major_version
''                                                             set_major_version
''                                                             read_major_version
''                                                             write_major_version
''---------------------------------------------------------------------------------
'' fpga_solution                              [8:8]            get_fpga_solution
''                                                             set_fpga_solution
''                                                             read_fpga_solution
''                                                             write_fpga_solution
''---------------------------------------------------------------------------------
'' asic_aes_gf_sbox                           [9:9]            get_asic_aes_gf_sbox
''                                                             set_asic_aes_gf_sbox
''                                                             read_asic_aes_gf_sbox
''                                                             write_asic_aes_gf_sbox
''---------------------------------------------------------------------------------
'' asic_aes_lu_sbox                           [10:10]          get_asic_aes_lu_sbox
''                                                             set_asic_aes_lu_sbox
''                                                             read_asic_aes_lu_sbox
''                                                             write_asic_aes_lu_sbox
''---------------------------------------------------------------------------------
'' macsec_aes_only                            [11:11]          get_macsec_aes_only
''                                                             set_macsec_aes_only
''                                                             read_macsec_aes_only
''                                                             write_macsec_aes_only
''---------------------------------------------------------------------------------
'' aes                                        [12:12]          get_aes
''                                                             set_aes
''                                                             read_aes
''                                                             write_aes
''---------------------------------------------------------------------------------
'' aes_fb                                     [13:13]          get_aes_fb
''                                                             set_aes_fb
''                                                             read_aes_fb
''                                                             write_aes_fb
''---------------------------------------------------------------------------------
'' aes_speed                                  [17:14]          get_aes_speed
''                                                             set_aes_speed
''                                                             read_aes_speed
''                                                             write_aes_speed
''---------------------------------------------------------------------------------
'' aes192                                     [18:18]          get_aes192
''                                                             set_aes192
''                                                             read_aes192
''                                                             write_aes192
''---------------------------------------------------------------------------------
'' aes256                                     [19:19]          get_aes256
''                                                             set_aes256
''                                                             read_aes256
''                                                             write_aes256
''---------------------------------------------------------------------------------
'' eop_param_bits                             [24:20]          get_eop_param_bits
''                                                             set_eop_param_bits
''                                                             read_eop_param_bits
''                                                             write_eop_param_bits
''---------------------------------------------------------------------------------
'' ipsec                                      [25:25]          get_ipsec
''                                                             set_ipsec
''                                                             read_ipsec
''                                                             write_ipsec
''---------------------------------------------------------------------------------
'' hdr_extensions                             [26:26]          get_hdr_extensions
''                                                             set_hdr_extensions
''                                                             read_hdr_extensions
''                                                             write_hdr_extensions
''---------------------------------------------------------------------------------
'' ghash_available                            [30:30]          get_ghash_available
''                                                             set_ghash_available
''                                                             read_ghash_available
''                                                             write_ghash_available
''---------------------------------------------------------------------------------
'' ghash_speed                                [31:31]          get_ghash_speed
''                                                             set_ghash_speed
''                                                             read_ghash_speed
''                                                             write_ghash_speed
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_config
    Private write_minor_version_value
    Private read_minor_version_value
    Private flag_minor_version
    Private write_major_version_value
    Private read_major_version_value
    Private flag_major_version
    Private write_fpga_solution_value
    Private read_fpga_solution_value
    Private flag_fpga_solution
    Private write_asic_aes_gf_sbox_value
    Private read_asic_aes_gf_sbox_value
    Private flag_asic_aes_gf_sbox
    Private write_asic_aes_lu_sbox_value
    Private read_asic_aes_lu_sbox_value
    Private flag_asic_aes_lu_sbox
    Private write_macsec_aes_only_value
    Private read_macsec_aes_only_value
    Private flag_macsec_aes_only
    Private write_aes_value
    Private read_aes_value
    Private flag_aes
    Private write_aes_fb_value
    Private read_aes_fb_value
    Private flag_aes_fb
    Private write_aes_speed_value
    Private read_aes_speed_value
    Private flag_aes_speed
    Private write_aes192_value
    Private read_aes192_value
    Private flag_aes192
    Private write_aes256_value
    Private read_aes256_value
    Private flag_aes256
    Private write_eop_param_bits_value
    Private read_eop_param_bits_value
    Private flag_eop_param_bits
    Private write_ipsec_value
    Private read_ipsec_value
    Private flag_ipsec
    Private write_hdr_extensions_value
    Private read_hdr_extensions_value
    Private flag_hdr_extensions
    Private write_ghash_available_value
    Private read_ghash_available_value
    Private flag_ghash_available
    Private write_ghash_speed_value
    Private read_ghash_speed_value
    Private flag_ghash_speed

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f7f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_minor_version
        get_minor_version = read_minor_version_value
    End Property

    Property Let set_minor_version(aData)
        write_minor_version_value = aData
        flag_minor_version        = &H1
    End Property

    Property Get read_minor_version
        read
        read_minor_version = read_minor_version_value
    End Property

    Property Let write_minor_version(aData)
        set_minor_version = aData
        write
    End Property

    Property Get get_major_version
        get_major_version = read_major_version_value
    End Property

    Property Let set_major_version(aData)
        write_major_version_value = aData
        flag_major_version        = &H1
    End Property

    Property Get read_major_version
        read
        read_major_version = read_major_version_value
    End Property

    Property Let write_major_version(aData)
        set_major_version = aData
        write
    End Property

    Property Get get_fpga_solution
        get_fpga_solution = read_fpga_solution_value
    End Property

    Property Let set_fpga_solution(aData)
        write_fpga_solution_value = aData
        flag_fpga_solution        = &H1
    End Property

    Property Get read_fpga_solution
        read
        read_fpga_solution = read_fpga_solution_value
    End Property

    Property Let write_fpga_solution(aData)
        set_fpga_solution = aData
        write
    End Property

    Property Get get_asic_aes_gf_sbox
        get_asic_aes_gf_sbox = read_asic_aes_gf_sbox_value
    End Property

    Property Let set_asic_aes_gf_sbox(aData)
        write_asic_aes_gf_sbox_value = aData
        flag_asic_aes_gf_sbox        = &H1
    End Property

    Property Get read_asic_aes_gf_sbox
        read
        read_asic_aes_gf_sbox = read_asic_aes_gf_sbox_value
    End Property

    Property Let write_asic_aes_gf_sbox(aData)
        set_asic_aes_gf_sbox = aData
        write
    End Property

    Property Get get_asic_aes_lu_sbox
        get_asic_aes_lu_sbox = read_asic_aes_lu_sbox_value
    End Property

    Property Let set_asic_aes_lu_sbox(aData)
        write_asic_aes_lu_sbox_value = aData
        flag_asic_aes_lu_sbox        = &H1
    End Property

    Property Get read_asic_aes_lu_sbox
        read
        read_asic_aes_lu_sbox = read_asic_aes_lu_sbox_value
    End Property

    Property Let write_asic_aes_lu_sbox(aData)
        set_asic_aes_lu_sbox = aData
        write
    End Property

    Property Get get_macsec_aes_only
        get_macsec_aes_only = read_macsec_aes_only_value
    End Property

    Property Let set_macsec_aes_only(aData)
        write_macsec_aes_only_value = aData
        flag_macsec_aes_only        = &H1
    End Property

    Property Get read_macsec_aes_only
        read
        read_macsec_aes_only = read_macsec_aes_only_value
    End Property

    Property Let write_macsec_aes_only(aData)
        set_macsec_aes_only = aData
        write
    End Property

    Property Get get_aes
        get_aes = read_aes_value
    End Property

    Property Let set_aes(aData)
        write_aes_value = aData
        flag_aes        = &H1
    End Property

    Property Get read_aes
        read
        read_aes = read_aes_value
    End Property

    Property Let write_aes(aData)
        set_aes = aData
        write
    End Property

    Property Get get_aes_fb
        get_aes_fb = read_aes_fb_value
    End Property

    Property Let set_aes_fb(aData)
        write_aes_fb_value = aData
        flag_aes_fb        = &H1
    End Property

    Property Get read_aes_fb
        read
        read_aes_fb = read_aes_fb_value
    End Property

    Property Let write_aes_fb(aData)
        set_aes_fb = aData
        write
    End Property

    Property Get get_aes_speed
        get_aes_speed = read_aes_speed_value
    End Property

    Property Let set_aes_speed(aData)
        write_aes_speed_value = aData
        flag_aes_speed        = &H1
    End Property

    Property Get read_aes_speed
        read
        read_aes_speed = read_aes_speed_value
    End Property

    Property Let write_aes_speed(aData)
        set_aes_speed = aData
        write
    End Property

    Property Get get_aes192
        get_aes192 = read_aes192_value
    End Property

    Property Let set_aes192(aData)
        write_aes192_value = aData
        flag_aes192        = &H1
    End Property

    Property Get read_aes192
        read
        read_aes192 = read_aes192_value
    End Property

    Property Let write_aes192(aData)
        set_aes192 = aData
        write
    End Property

    Property Get get_aes256
        get_aes256 = read_aes256_value
    End Property

    Property Let set_aes256(aData)
        write_aes256_value = aData
        flag_aes256        = &H1
    End Property

    Property Get read_aes256
        read
        read_aes256 = read_aes256_value
    End Property

    Property Let write_aes256(aData)
        set_aes256 = aData
        write
    End Property

    Property Get get_eop_param_bits
        get_eop_param_bits = read_eop_param_bits_value
    End Property

    Property Let set_eop_param_bits(aData)
        write_eop_param_bits_value = aData
        flag_eop_param_bits        = &H1
    End Property

    Property Get read_eop_param_bits
        read
        read_eop_param_bits = read_eop_param_bits_value
    End Property

    Property Let write_eop_param_bits(aData)
        set_eop_param_bits = aData
        write
    End Property

    Property Get get_ipsec
        get_ipsec = read_ipsec_value
    End Property

    Property Let set_ipsec(aData)
        write_ipsec_value = aData
        flag_ipsec        = &H1
    End Property

    Property Get read_ipsec
        read
        read_ipsec = read_ipsec_value
    End Property

    Property Let write_ipsec(aData)
        set_ipsec = aData
        write
    End Property

    Property Get get_hdr_extensions
        get_hdr_extensions = read_hdr_extensions_value
    End Property

    Property Let set_hdr_extensions(aData)
        write_hdr_extensions_value = aData
        flag_hdr_extensions        = &H1
    End Property

    Property Get read_hdr_extensions
        read
        read_hdr_extensions = read_hdr_extensions_value
    End Property

    Property Let write_hdr_extensions(aData)
        set_hdr_extensions = aData
        write
    End Property

    Property Get get_ghash_available
        get_ghash_available = read_ghash_available_value
    End Property

    Property Let set_ghash_available(aData)
        write_ghash_available_value = aData
        flag_ghash_available        = &H1
    End Property

    Property Get read_ghash_available
        read
        read_ghash_available = read_ghash_available_value
    End Property

    Property Let write_ghash_available(aData)
        set_ghash_available = aData
        write
    End Property

    Property Get get_ghash_speed
        get_ghash_speed = read_ghash_speed_value
    End Property

    Property Let set_ghash_speed(aData)
        write_ghash_speed_value = aData
        flag_ghash_speed        = &H1
    End Property

    Property Get read_ghash_speed
        read
        read_ghash_speed = read_ghash_speed_value
    End Property

    Property Let write_ghash_speed(aData)
        set_ghash_speed = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        minor_version_mask = &Hf
        if data_low > LONG_MAX then
            if minor_version_mask = mask then
                read_minor_version_value = data_low
            else
                read_minor_version_value = (data_low - H8000_0000) and minor_version_mask
            end If
        else
            read_minor_version_value = data_low and minor_version_mask
        end If
        read_major_version_value = rightShift(data_low, 4) and &Hf
        read_fpga_solution_value = rightShift(data_low, 8) and &H1
        read_asic_aes_gf_sbox_value = rightShift(data_low, 9) and &H1
        read_asic_aes_lu_sbox_value = rightShift(data_low, 10) and &H1
        read_macsec_aes_only_value = rightShift(data_low, 11) and &H1
        read_aes_value = rightShift(data_low, 12) and &H1
        read_aes_fb_value = rightShift(data_low, 13) and &H1
        read_aes_speed_value = rightShift(data_low, 14) and &Hf
        read_aes192_value = rightShift(data_low, 18) and &H1
        read_aes256_value = rightShift(data_low, 19) and &H1
        read_eop_param_bits_value = rightShift(data_low, 20) and &H1f
        read_ipsec_value = rightShift(data_low, 25) and &H1
        read_hdr_extensions_value = rightShift(data_low, 26) and &H1
        read_ghash_available_value = rightShift(data_low, 30) and &H1
        read_ghash_speed_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_minor_version = &H0 or flag_major_version = &H0 or flag_fpga_solution = &H0 or flag_asic_aes_gf_sbox = &H0 or flag_asic_aes_lu_sbox = &H0 or flag_macsec_aes_only = &H0 or flag_aes = &H0 or flag_aes_fb = &H0 or flag_aes_speed = &H0 or flag_aes192 = &H0 or flag_aes256 = &H0 or flag_eop_param_bits = &H0 or flag_ipsec = &H0 or flag_hdr_extensions = &H0 or flag_ghash_available = &H0 or flag_ghash_speed = &H0 Then read
        If flag_minor_version = &H0 Then write_minor_version_value = get_minor_version
        If flag_major_version = &H0 Then write_major_version_value = get_major_version
        If flag_fpga_solution = &H0 Then write_fpga_solution_value = get_fpga_solution
        If flag_asic_aes_gf_sbox = &H0 Then write_asic_aes_gf_sbox_value = get_asic_aes_gf_sbox
        If flag_asic_aes_lu_sbox = &H0 Then write_asic_aes_lu_sbox_value = get_asic_aes_lu_sbox
        If flag_macsec_aes_only = &H0 Then write_macsec_aes_only_value = get_macsec_aes_only
        If flag_aes = &H0 Then write_aes_value = get_aes
        If flag_aes_fb = &H0 Then write_aes_fb_value = get_aes_fb
        If flag_aes_speed = &H0 Then write_aes_speed_value = get_aes_speed
        If flag_aes192 = &H0 Then write_aes192_value = get_aes192
        If flag_aes256 = &H0 Then write_aes256_value = get_aes256
        If flag_eop_param_bits = &H0 Then write_eop_param_bits_value = get_eop_param_bits
        If flag_ipsec = &H0 Then write_ipsec_value = get_ipsec
        If flag_hdr_extensions = &H0 Then write_hdr_extensions_value = get_hdr_extensions
        If flag_ghash_available = &H0 Then write_ghash_available_value = get_ghash_available
        If flag_ghash_speed = &H0 Then write_ghash_speed_value = get_ghash_speed

        regValue = leftShift((write_minor_version_value and &Hf), 0) + leftShift((write_major_version_value and &Hf), 4) + leftShift((write_fpga_solution_value and &H1), 8) + leftShift((write_asic_aes_gf_sbox_value and &H1), 9) + leftShift((write_asic_aes_lu_sbox_value and &H1), 10) + leftShift((write_macsec_aes_only_value and &H1), 11) + leftShift((write_aes_value and &H1), 12) + leftShift((write_aes_fb_value and &H1), 13) + leftShift((write_aes_speed_value and &Hf), 14) + leftShift((write_aes192_value and &H1), 18) + leftShift((write_aes256_value and &H1), 19) + leftShift((write_eop_param_bits_value and &H1f), 20) + leftShift((write_ipsec_value and &H1), 25) + leftShift((write_hdr_extensions_value and &H1), 26) + leftShift((write_ghash_available_value and &H1), 30) + leftShift((write_ghash_speed_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        minor_version_mask = &Hf
        if data_low > LONG_MAX then
            if minor_version_mask = mask then
                read_minor_version_value = data_low
            else
                read_minor_version_value = (data_low - H8000_0000) and minor_version_mask
            end If
        else
            read_minor_version_value = data_low and minor_version_mask
        end If
        read_major_version_value = rightShift(data_low, 4) and &Hf
        read_fpga_solution_value = rightShift(data_low, 8) and &H1
        read_asic_aes_gf_sbox_value = rightShift(data_low, 9) and &H1
        read_asic_aes_lu_sbox_value = rightShift(data_low, 10) and &H1
        read_macsec_aes_only_value = rightShift(data_low, 11) and &H1
        read_aes_value = rightShift(data_low, 12) and &H1
        read_aes_fb_value = rightShift(data_low, 13) and &H1
        read_aes_speed_value = rightShift(data_low, 14) and &Hf
        read_aes192_value = rightShift(data_low, 18) and &H1
        read_aes256_value = rightShift(data_low, 19) and &H1
        read_eop_param_bits_value = rightShift(data_low, 20) and &H1f
        read_ipsec_value = rightShift(data_low, 25) and &H1
        read_hdr_extensions_value = rightShift(data_low, 26) and &H1
        read_ghash_available_value = rightShift(data_low, 30) and &H1
        read_ghash_speed_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_minor_version_value = &H0
        flag_minor_version        = &H0
        write_major_version_value = &H0
        flag_major_version        = &H0
        write_fpga_solution_value = &H0
        flag_fpga_solution        = &H0
        write_asic_aes_gf_sbox_value = &H0
        flag_asic_aes_gf_sbox        = &H0
        write_asic_aes_lu_sbox_value = &H0
        flag_asic_aes_lu_sbox        = &H0
        write_macsec_aes_only_value = &H0
        flag_macsec_aes_only        = &H0
        write_aes_value = &H0
        flag_aes        = &H0
        write_aes_fb_value = &H0
        flag_aes_fb        = &H0
        write_aes_speed_value = &H0
        flag_aes_speed        = &H0
        write_aes192_value = &H0
        flag_aes192        = &H0
        write_aes256_value = &H0
        flag_aes256        = &H0
        write_eop_param_bits_value = &H0
        flag_eop_param_bits        = &H0
        write_ipsec_value = &H0
        flag_ipsec        = &H0
        write_hdr_extensions_value = &H0
        flag_hdr_extensions        = &H0
        write_ghash_available_value = &H0
        flag_ghash_available        = &H0
        write_ghash_speed_value = &H0
        flag_ghash_speed        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' eip_number                                 [7:0]            get_eip_number
''                                                             set_eip_number
''                                                             read_eip_number
''                                                             write_eip_number
''---------------------------------------------------------------------------------
'' eip_number_compl                           [15:8]           get_eip_number_compl
''                                                             set_eip_number_compl
''                                                             read_eip_number_compl
''                                                             write_eip_number_compl
''---------------------------------------------------------------------------------
'' patch_level                                [19:16]          get_patch_level
''                                                             set_patch_level
''                                                             read_patch_level
''                                                             write_patch_level
''---------------------------------------------------------------------------------
'' minor_version                              [23:20]          get_minor_version
''                                                             set_minor_version
''                                                             read_minor_version
''                                                             write_minor_version
''---------------------------------------------------------------------------------
'' major_version                              [27:24]          get_major_version
''                                                             set_major_version
''                                                             read_major_version
''                                                             write_major_version
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_version
    Private write_eip_number_value
    Private read_eip_number_value
    Private flag_eip_number
    Private write_eip_number_compl_value
    Private read_eip_number_compl_value
    Private flag_eip_number_compl
    Private write_patch_level_value
    Private read_patch_level_value
    Private flag_patch_level
    Private write_minor_version_value
    Private read_minor_version_value
    Private flag_minor_version
    Private write_major_version_value
    Private read_major_version_value
    Private flag_major_version

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f7fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_eip_number
        get_eip_number = read_eip_number_value
    End Property

    Property Let set_eip_number(aData)
        write_eip_number_value = aData
        flag_eip_number        = &H1
    End Property

    Property Get read_eip_number
        read
        read_eip_number = read_eip_number_value
    End Property

    Property Let write_eip_number(aData)
        set_eip_number = aData
        write
    End Property

    Property Get get_eip_number_compl
        get_eip_number_compl = read_eip_number_compl_value
    End Property

    Property Let set_eip_number_compl(aData)
        write_eip_number_compl_value = aData
        flag_eip_number_compl        = &H1
    End Property

    Property Get read_eip_number_compl
        read
        read_eip_number_compl = read_eip_number_compl_value
    End Property

    Property Let write_eip_number_compl(aData)
        set_eip_number_compl = aData
        write
    End Property

    Property Get get_patch_level
        get_patch_level = read_patch_level_value
    End Property

    Property Let set_patch_level(aData)
        write_patch_level_value = aData
        flag_patch_level        = &H1
    End Property

    Property Get read_patch_level
        read
        read_patch_level = read_patch_level_value
    End Property

    Property Let write_patch_level(aData)
        set_patch_level = aData
        write
    End Property

    Property Get get_minor_version
        get_minor_version = read_minor_version_value
    End Property

    Property Let set_minor_version(aData)
        write_minor_version_value = aData
        flag_minor_version        = &H1
    End Property

    Property Get read_minor_version
        read
        read_minor_version = read_minor_version_value
    End Property

    Property Let write_minor_version(aData)
        set_minor_version = aData
        write
    End Property

    Property Get get_major_version
        get_major_version = read_major_version_value
    End Property

    Property Let set_major_version(aData)
        write_major_version_value = aData
        flag_major_version        = &H1
    End Property

    Property Get read_major_version
        read
        read_major_version = read_major_version_value
    End Property

    Property Let write_major_version(aData)
        set_major_version = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        eip_number_mask = &Hff
        if data_low > LONG_MAX then
            if eip_number_mask = mask then
                read_eip_number_value = data_low
            else
                read_eip_number_value = (data_low - H8000_0000) and eip_number_mask
            end If
        else
            read_eip_number_value = data_low and eip_number_mask
        end If
        read_eip_number_compl_value = rightShift(data_low, 8) and &Hff
        read_patch_level_value = rightShift(data_low, 16) and &Hf
        read_minor_version_value = rightShift(data_low, 20) and &Hf
        read_major_version_value = rightShift(data_low, 24) and &Hf

    End Sub

    Sub write
        If flag_eip_number = &H0 or flag_eip_number_compl = &H0 or flag_patch_level = &H0 or flag_minor_version = &H0 or flag_major_version = &H0 Then read
        If flag_eip_number = &H0 Then write_eip_number_value = get_eip_number
        If flag_eip_number_compl = &H0 Then write_eip_number_compl_value = get_eip_number_compl
        If flag_patch_level = &H0 Then write_patch_level_value = get_patch_level
        If flag_minor_version = &H0 Then write_minor_version_value = get_minor_version
        If flag_major_version = &H0 Then write_major_version_value = get_major_version

        regValue = leftShift((write_eip_number_value and &Hff), 0) + leftShift((write_eip_number_compl_value and &Hff), 8) + leftShift((write_patch_level_value and &Hf), 16) + leftShift((write_minor_version_value and &Hf), 20) + leftShift((write_major_version_value and &Hf), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        eip_number_mask = &Hff
        if data_low > LONG_MAX then
            if eip_number_mask = mask then
                read_eip_number_value = data_low
            else
                read_eip_number_value = (data_low - H8000_0000) and eip_number_mask
            end If
        else
            read_eip_number_value = data_low and eip_number_mask
        end If
        read_eip_number_compl_value = rightShift(data_low, 8) and &Hff
        read_patch_level_value = rightShift(data_low, 16) and &Hf
        read_minor_version_value = rightShift(data_low, 20) and &Hf
        read_major_version_value = rightShift(data_low, 24) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_eip_number_value = &H0
        flag_eip_number        = &H0
        write_eip_number_compl_value = &H0
        flag_eip_number_compl        = &H0
        write_patch_level_value = &H0
        flag_patch_level        = &H0
        write_minor_version_value = &H0
        flag_minor_version        = &H0
        write_major_version_value = &H0
        flag_major_version        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE

    Public eip62_token_ctrl_stat
    Public eip62_prot_alg_en
    Public eip62_context_ctrl
    Public eip62_context_stat
    Public eip62_int_ctrl_stat
    Public eip62_sw_interrupt
    Public eip62_seq_num_threshold
    Public eip62_seq_num_threshold64_lo
    Public eip62_seq_num_threshold64_hi
    Public eip62_context_upd_ctrl
    Public eip62_nextpn_lo
    Public eip62_nextpn_hi
    Public eip62_nextpn_ctx_id
    Public eip62_nextpn_ctrl
    Public eip62_update_ctrl
    Public eip62_config
    Public eip62_version


    Public default function Init(aBaseAddr)
        Set eip62_token_ctrl_stat = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_token_ctrl_stat)(aBaseAddr, 32)
        Set eip62_prot_alg_en = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_prot_alg_en)(aBaseAddr, 32)
        Set eip62_context_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_ctrl)(aBaseAddr, 32)
        Set eip62_context_stat = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_stat)(aBaseAddr, 32)
        Set eip62_int_ctrl_stat = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_int_ctrl_stat)(aBaseAddr, 32)
        Set eip62_sw_interrupt = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_sw_interrupt)(aBaseAddr, 32)
        Set eip62_seq_num_threshold = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold)(aBaseAddr, 32)
        Set eip62_seq_num_threshold64_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold64_lo)(aBaseAddr, 32)
        Set eip62_seq_num_threshold64_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_seq_num_threshold64_hi)(aBaseAddr, 32)
        Set eip62_context_upd_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_context_upd_ctrl)(aBaseAddr, 32)
        Set eip62_nextpn_lo = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_lo)(aBaseAddr, 32)
        Set eip62_nextpn_hi = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_hi)(aBaseAddr, 32)
        Set eip62_nextpn_ctx_id = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_ctx_id)(aBaseAddr, 32)
        Set eip62_nextpn_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_nextpn_ctrl)(aBaseAddr, 32)
        Set eip62_update_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_update_ctrl)(aBaseAddr, 32)
        Set eip62_config = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_config)(aBaseAddr, 32)
        Set eip62_version = (New REGISTER_EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_eip62_version)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS.Add ((New EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS.Add ((New EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS.Add ((New EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS.Add ((New EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS.Add ((New EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS.Add ((New EIP165S_EIP165_EGEIP160_EIP62_EIP62_REGISTERS_INSTANCE)(&H4d510000))


