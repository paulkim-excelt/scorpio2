

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_0
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7000
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_0
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7004
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_1
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7008
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_1
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H700c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_2
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7010
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_2
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7014
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_3
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7018
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_3
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H701c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_4
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7020
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_4
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7024
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_5
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7028
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_5
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H702c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_6
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7030
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_6
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7034
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_7
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7038
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_7
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H703c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_8
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7040
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_8
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7044
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_9
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7048
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_9
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H704c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_10
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7050
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_10
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7054
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_11
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7058
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_11
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H705c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_12
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7060
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_12
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7064
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_13
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7068
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_13
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H706c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_14
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7070
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_14
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7074
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' flow_type                                  [1:0]            get_flow_type
''                                                             set_flow_type
''                                                             read_flow_type
''                                                             write_flow_type
''---------------------------------------------------------------------------------
'' dest_port                                  [3:2]            get_dest_port
''                                                             set_dest_port
''                                                             read_dest_port
''                                                             write_dest_port
''---------------------------------------------------------------------------------
'' drop_non_redir                             [4:4]            get_drop_non_redir
''                                                             set_drop_non_redir
''                                                             read_drop_non_redir
''                                                             write_drop_non_redir
''---------------------------------------------------------------------------------
'' flow_crypt_auth                            [5:5]            get_flow_crypt_auth
''                                                             set_flow_crypt_auth
''                                                             read_flow_crypt_auth
''                                                             write_flow_crypt_auth
''---------------------------------------------------------------------------------
'' drop_action                                [7:6]            get_drop_action
''                                                             set_drop_action
''                                                             read_drop_action
''                                                             write_drop_action
''---------------------------------------------------------------------------------
'' capt_reason                                [11:8]           get_capt_reason
''                                                             set_capt_reason
''                                                             read_capt_reason
''                                                             write_capt_reason
''---------------------------------------------------------------------------------
'' replay_protect                             [16:16]          get_replay_protect
''                                                             set_replay_protect
''                                                             read_replay_protect
''                                                             write_replay_protect
''---------------------------------------------------------------------------------
'' allow_tagged_data                          [17:17]          get_allow_tagged_data
''                                                             set_allow_tagged_data
''                                                             read_allow_tagged_data
''                                                             write_allow_tagged_data
''---------------------------------------------------------------------------------
'' allow_untagged_data                        [18:18]          get_allow_untagged_data
''                                                             set_allow_untagged_data
''                                                             read_allow_untagged_data
''                                                             write_allow_untagged_data
''---------------------------------------------------------------------------------
'' validate_frames_tagged                     [20:19]          get_validate_frames_tagged
''                                                             set_validate_frames_tagged
''                                                             read_validate_frames_tagged
''                                                             write_validate_frames_tagged
''---------------------------------------------------------------------------------
'' validate_frames_untagged                   [21:21]          get_validate_frames_untagged
''                                                             set_validate_frames_untagged
''                                                             read_validate_frames_untagged
''                                                             write_validate_frames_untagged
''---------------------------------------------------------------------------------
'' eompls_ctrl_word                           [22:22]          get_eompls_ctrl_word
''                                                             set_eompls_ctrl_word
''                                                             read_eompls_ctrl_word
''                                                             write_eompls_ctrl_word
''---------------------------------------------------------------------------------
'' eompls_subport                             [23:23]          get_eompls_subport
''                                                             set_eompls_subport
''                                                             read_eompls_subport
''                                                             write_eompls_subport
''---------------------------------------------------------------------------------
'' retain_icv                                 [24:24]          get_retain_icv
''                                                             set_retain_icv
''                                                             read_retain_icv
''                                                             write_retain_icv
''---------------------------------------------------------------------------------
'' retain_sectag                              [25:25]          get_retain_sectag
''                                                             set_retain_sectag
''                                                             read_retain_sectag
''                                                             write_retain_sectag
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_15
    Private write_flow_type_value
    Private read_flow_type_value
    Private flag_flow_type
    Private write_dest_port_value
    Private read_dest_port_value
    Private flag_dest_port
    Private write_drop_non_redir_value
    Private read_drop_non_redir_value
    Private flag_drop_non_redir
    Private write_flow_crypt_auth_value
    Private read_flow_crypt_auth_value
    Private flag_flow_crypt_auth
    Private write_drop_action_value
    Private read_drop_action_value
    Private flag_drop_action
    Private write_capt_reason_value
    Private read_capt_reason_value
    Private flag_capt_reason
    Private write_replay_protect_value
    Private read_replay_protect_value
    Private flag_replay_protect
    Private write_allow_tagged_data_value
    Private read_allow_tagged_data_value
    Private flag_allow_tagged_data
    Private write_allow_untagged_data_value
    Private read_allow_untagged_data_value
    Private flag_allow_untagged_data
    Private write_validate_frames_tagged_value
    Private read_validate_frames_tagged_value
    Private flag_validate_frames_tagged
    Private write_validate_frames_untagged_value
    Private read_validate_frames_untagged_value
    Private flag_validate_frames_untagged
    Private write_eompls_ctrl_word_value
    Private read_eompls_ctrl_word_value
    Private flag_eompls_ctrl_word
    Private write_eompls_subport_value
    Private read_eompls_subport_value
    Private flag_eompls_subport
    Private write_retain_icv_value
    Private read_retain_icv_value
    Private flag_retain_icv
    Private write_retain_sectag_value
    Private read_retain_sectag_value
    Private flag_retain_sectag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7078
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_flow_type
        get_flow_type = read_flow_type_value
    End Property

    Property Let set_flow_type(aData)
        write_flow_type_value = aData
        flag_flow_type        = &H1
    End Property

    Property Get read_flow_type
        read
        read_flow_type = read_flow_type_value
    End Property

    Property Let write_flow_type(aData)
        set_flow_type = aData
        write
    End Property

    Property Get get_dest_port
        get_dest_port = read_dest_port_value
    End Property

    Property Let set_dest_port(aData)
        write_dest_port_value = aData
        flag_dest_port        = &H1
    End Property

    Property Get read_dest_port
        read
        read_dest_port = read_dest_port_value
    End Property

    Property Let write_dest_port(aData)
        set_dest_port = aData
        write
    End Property

    Property Get get_drop_non_redir
        get_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let set_drop_non_redir(aData)
        write_drop_non_redir_value = aData
        flag_drop_non_redir        = &H1
    End Property

    Property Get read_drop_non_redir
        read
        read_drop_non_redir = read_drop_non_redir_value
    End Property

    Property Let write_drop_non_redir(aData)
        set_drop_non_redir = aData
        write
    End Property

    Property Get get_flow_crypt_auth
        get_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let set_flow_crypt_auth(aData)
        write_flow_crypt_auth_value = aData
        flag_flow_crypt_auth        = &H1
    End Property

    Property Get read_flow_crypt_auth
        read
        read_flow_crypt_auth = read_flow_crypt_auth_value
    End Property

    Property Let write_flow_crypt_auth(aData)
        set_flow_crypt_auth = aData
        write
    End Property

    Property Get get_drop_action
        get_drop_action = read_drop_action_value
    End Property

    Property Let set_drop_action(aData)
        write_drop_action_value = aData
        flag_drop_action        = &H1
    End Property

    Property Get read_drop_action
        read
        read_drop_action = read_drop_action_value
    End Property

    Property Let write_drop_action(aData)
        set_drop_action = aData
        write
    End Property

    Property Get get_capt_reason
        get_capt_reason = read_capt_reason_value
    End Property

    Property Let set_capt_reason(aData)
        write_capt_reason_value = aData
        flag_capt_reason        = &H1
    End Property

    Property Get read_capt_reason
        read
        read_capt_reason = read_capt_reason_value
    End Property

    Property Let write_capt_reason(aData)
        set_capt_reason = aData
        write
    End Property

    Property Get get_replay_protect
        get_replay_protect = read_replay_protect_value
    End Property

    Property Let set_replay_protect(aData)
        write_replay_protect_value = aData
        flag_replay_protect        = &H1
    End Property

    Property Get read_replay_protect
        read
        read_replay_protect = read_replay_protect_value
    End Property

    Property Let write_replay_protect(aData)
        set_replay_protect = aData
        write
    End Property

    Property Get get_allow_tagged_data
        get_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let set_allow_tagged_data(aData)
        write_allow_tagged_data_value = aData
        flag_allow_tagged_data        = &H1
    End Property

    Property Get read_allow_tagged_data
        read
        read_allow_tagged_data = read_allow_tagged_data_value
    End Property

    Property Let write_allow_tagged_data(aData)
        set_allow_tagged_data = aData
        write
    End Property

    Property Get get_allow_untagged_data
        get_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let set_allow_untagged_data(aData)
        write_allow_untagged_data_value = aData
        flag_allow_untagged_data        = &H1
    End Property

    Property Get read_allow_untagged_data
        read
        read_allow_untagged_data = read_allow_untagged_data_value
    End Property

    Property Let write_allow_untagged_data(aData)
        set_allow_untagged_data = aData
        write
    End Property

    Property Get get_validate_frames_tagged
        get_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let set_validate_frames_tagged(aData)
        write_validate_frames_tagged_value = aData
        flag_validate_frames_tagged        = &H1
    End Property

    Property Get read_validate_frames_tagged
        read
        read_validate_frames_tagged = read_validate_frames_tagged_value
    End Property

    Property Let write_validate_frames_tagged(aData)
        set_validate_frames_tagged = aData
        write
    End Property

    Property Get get_validate_frames_untagged
        get_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let set_validate_frames_untagged(aData)
        write_validate_frames_untagged_value = aData
        flag_validate_frames_untagged        = &H1
    End Property

    Property Get read_validate_frames_untagged
        read
        read_validate_frames_untagged = read_validate_frames_untagged_value
    End Property

    Property Let write_validate_frames_untagged(aData)
        set_validate_frames_untagged = aData
        write
    End Property

    Property Get get_eompls_ctrl_word
        get_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let set_eompls_ctrl_word(aData)
        write_eompls_ctrl_word_value = aData
        flag_eompls_ctrl_word        = &H1
    End Property

    Property Get read_eompls_ctrl_word
        read
        read_eompls_ctrl_word = read_eompls_ctrl_word_value
    End Property

    Property Let write_eompls_ctrl_word(aData)
        set_eompls_ctrl_word = aData
        write
    End Property

    Property Get get_eompls_subport
        get_eompls_subport = read_eompls_subport_value
    End Property

    Property Let set_eompls_subport(aData)
        write_eompls_subport_value = aData
        flag_eompls_subport        = &H1
    End Property

    Property Get read_eompls_subport
        read
        read_eompls_subport = read_eompls_subport_value
    End Property

    Property Let write_eompls_subport(aData)
        set_eompls_subport = aData
        write
    End Property

    Property Get get_retain_icv
        get_retain_icv = read_retain_icv_value
    End Property

    Property Let set_retain_icv(aData)
        write_retain_icv_value = aData
        flag_retain_icv        = &H1
    End Property

    Property Get read_retain_icv
        read
        read_retain_icv = read_retain_icv_value
    End Property

    Property Let write_retain_icv(aData)
        set_retain_icv = aData
        write
    End Property

    Property Get get_retain_sectag
        get_retain_sectag = read_retain_sectag_value
    End Property

    Property Let set_retain_sectag(aData)
        write_retain_sectag_value = aData
        flag_retain_sectag        = &H1
    End Property

    Property Get read_retain_sectag
        read
        read_retain_sectag = read_retain_sectag_value
    End Property

    Property Let write_retain_sectag(aData)
        set_retain_sectag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_flow_type = &H0 or flag_dest_port = &H0 or flag_drop_non_redir = &H0 or flag_flow_crypt_auth = &H0 or flag_drop_action = &H0 or flag_capt_reason = &H0 or flag_replay_protect = &H0 or flag_allow_tagged_data = &H0 or flag_allow_untagged_data = &H0 or flag_validate_frames_tagged = &H0 or flag_validate_frames_untagged = &H0 or flag_eompls_ctrl_word = &H0 or flag_eompls_subport = &H0 or flag_retain_icv = &H0 or flag_retain_sectag = &H0 Then read
        If flag_flow_type = &H0 Then write_flow_type_value = get_flow_type
        If flag_dest_port = &H0 Then write_dest_port_value = get_dest_port
        If flag_drop_non_redir = &H0 Then write_drop_non_redir_value = get_drop_non_redir
        If flag_flow_crypt_auth = &H0 Then write_flow_crypt_auth_value = get_flow_crypt_auth
        If flag_drop_action = &H0 Then write_drop_action_value = get_drop_action
        If flag_capt_reason = &H0 Then write_capt_reason_value = get_capt_reason
        If flag_replay_protect = &H0 Then write_replay_protect_value = get_replay_protect
        If flag_allow_tagged_data = &H0 Then write_allow_tagged_data_value = get_allow_tagged_data
        If flag_allow_untagged_data = &H0 Then write_allow_untagged_data_value = get_allow_untagged_data
        If flag_validate_frames_tagged = &H0 Then write_validate_frames_tagged_value = get_validate_frames_tagged
        If flag_validate_frames_untagged = &H0 Then write_validate_frames_untagged_value = get_validate_frames_untagged
        If flag_eompls_ctrl_word = &H0 Then write_eompls_ctrl_word_value = get_eompls_ctrl_word
        If flag_eompls_subport = &H0 Then write_eompls_subport_value = get_eompls_subport
        If flag_retain_icv = &H0 Then write_retain_icv_value = get_retain_icv
        If flag_retain_sectag = &H0 Then write_retain_sectag_value = get_retain_sectag

        regValue = leftShift((write_flow_type_value and &H3), 0) + leftShift((write_dest_port_value and &H3), 2) + leftShift((write_drop_non_redir_value and &H1), 4) + leftShift((write_flow_crypt_auth_value and &H1), 5) + leftShift((write_drop_action_value and &H3), 6) + leftShift((write_capt_reason_value and &Hf), 8) + leftShift((write_replay_protect_value and &H1), 16) + leftShift((write_allow_tagged_data_value and &H1), 17) + leftShift((write_allow_untagged_data_value and &H1), 18) + leftShift((write_validate_frames_tagged_value and &H3), 19) + leftShift((write_validate_frames_untagged_value and &H1), 21) + leftShift((write_eompls_ctrl_word_value and &H1), 22) + leftShift((write_eompls_subport_value and &H1), 23) + leftShift((write_retain_icv_value and &H1), 24) + leftShift((write_retain_sectag_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        flow_type_mask = &H3
        if data_low > LONG_MAX then
            if flow_type_mask = mask then
                read_flow_type_value = data_low
            else
                read_flow_type_value = (data_low - H8000_0000) and flow_type_mask
            end If
        else
            read_flow_type_value = data_low and flow_type_mask
        end If
        read_dest_port_value = rightShift(data_low, 2) and &H3
        read_drop_non_redir_value = rightShift(data_low, 4) and &H1
        read_flow_crypt_auth_value = rightShift(data_low, 5) and &H1
        read_drop_action_value = rightShift(data_low, 6) and &H3
        read_capt_reason_value = rightShift(data_low, 8) and &Hf
        read_replay_protect_value = rightShift(data_low, 16) and &H1
        read_allow_tagged_data_value = rightShift(data_low, 17) and &H1
        read_allow_untagged_data_value = rightShift(data_low, 18) and &H1
        read_validate_frames_tagged_value = rightShift(data_low, 19) and &H3
        read_validate_frames_untagged_value = rightShift(data_low, 21) and &H1
        read_eompls_ctrl_word_value = rightShift(data_low, 22) and &H1
        read_eompls_subport_value = rightShift(data_low, 23) and &H1
        read_retain_icv_value = rightShift(data_low, 24) and &H1
        read_retain_sectag_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_flow_type_value = &H0
        flag_flow_type        = &H0
        write_dest_port_value = &H0
        flag_dest_port        = &H0
        write_drop_non_redir_value = &H0
        flag_drop_non_redir        = &H0
        write_flow_crypt_auth_value = &H0
        flag_flow_crypt_auth        = &H0
        write_drop_action_value = &H0
        flag_drop_action        = &H0
        write_capt_reason_value = &H0
        flag_capt_reason        = &H0
        write_replay_protect_value = &H0
        flag_replay_protect        = &H0
        write_allow_tagged_data_value = &H0
        flag_allow_tagged_data        = &H0
        write_allow_untagged_data_value = &H0
        flag_allow_untagged_data        = &H0
        write_validate_frames_tagged_value = &H0
        flag_validate_frames_tagged        = &H0
        write_validate_frames_untagged_value = &H0
        flag_validate_frames_untagged        = &H0
        write_eompls_ctrl_word_value = &H0
        flag_eompls_ctrl_word        = &H0
        write_eompls_subport_value = &H0
        flag_eompls_subport        = &H0
        write_retain_icv_value = &H0
        flag_retain_icv        = &H0
        write_retain_sectag_value = &H0
        flag_retain_sectag        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_sectag_auth_start                      [5:0]            get_pre_sectag_auth_start
''                                                             set_pre_sectag_auth_start
''                                                             read_pre_sectag_auth_start
''                                                             write_pre_sectag_auth_start
''---------------------------------------------------------------------------------
'' pre_sectag_auth_len                        [13:8]           get_pre_sectag_auth_len
''                                                             set_pre_sectag_auth_len
''                                                             read_pre_sectag_auth_len
''                                                             write_pre_sectag_auth_len
''---------------------------------------------------------------------------------
'' sectag_offset                              [21:16]          get_sectag_offset
''                                                             set_sectag_offset
''                                                             read_sectag_offset
''                                                             write_sectag_offset
''---------------------------------------------------------------------------------
'' confidentiality_offset                     [31:24]          get_confidentiality_offset
''                                                             set_confidentiality_offset
''                                                             read_confidentiality_offset
''                                                             write_confidentiality_offset
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_15
    Private write_pre_sectag_auth_start_value
    Private read_pre_sectag_auth_start_value
    Private flag_pre_sectag_auth_start
    Private write_pre_sectag_auth_len_value
    Private read_pre_sectag_auth_len_value
    Private flag_pre_sectag_auth_len
    Private write_sectag_offset_value
    Private read_sectag_offset_value
    Private flag_sectag_offset
    Private write_confidentiality_offset_value
    Private read_confidentiality_offset_value
    Private flag_confidentiality_offset

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H707c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pre_sectag_auth_start
        get_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let set_pre_sectag_auth_start(aData)
        write_pre_sectag_auth_start_value = aData
        flag_pre_sectag_auth_start        = &H1
    End Property

    Property Get read_pre_sectag_auth_start
        read
        read_pre_sectag_auth_start = read_pre_sectag_auth_start_value
    End Property

    Property Let write_pre_sectag_auth_start(aData)
        set_pre_sectag_auth_start = aData
        write
    End Property

    Property Get get_pre_sectag_auth_len
        get_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let set_pre_sectag_auth_len(aData)
        write_pre_sectag_auth_len_value = aData
        flag_pre_sectag_auth_len        = &H1
    End Property

    Property Get read_pre_sectag_auth_len
        read
        read_pre_sectag_auth_len = read_pre_sectag_auth_len_value
    End Property

    Property Let write_pre_sectag_auth_len(aData)
        set_pre_sectag_auth_len = aData
        write
    End Property

    Property Get get_sectag_offset
        get_sectag_offset = read_sectag_offset_value
    End Property

    Property Let set_sectag_offset(aData)
        write_sectag_offset_value = aData
        flag_sectag_offset        = &H1
    End Property

    Property Get read_sectag_offset
        read
        read_sectag_offset = read_sectag_offset_value
    End Property

    Property Let write_sectag_offset(aData)
        set_sectag_offset = aData
        write
    End Property

    Property Get get_confidentiality_offset
        get_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let set_confidentiality_offset(aData)
        write_confidentiality_offset_value = aData
        flag_confidentiality_offset        = &H1
    End Property

    Property Get read_confidentiality_offset
        read
        read_confidentiality_offset = read_confidentiality_offset_value
    End Property

    Property Let write_confidentiality_offset(aData)
        set_confidentiality_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_pre_sectag_auth_start = &H0 or flag_pre_sectag_auth_len = &H0 or flag_sectag_offset = &H0 or flag_confidentiality_offset = &H0 Then read
        If flag_pre_sectag_auth_start = &H0 Then write_pre_sectag_auth_start_value = get_pre_sectag_auth_start
        If flag_pre_sectag_auth_len = &H0 Then write_pre_sectag_auth_len_value = get_pre_sectag_auth_len
        If flag_sectag_offset = &H0 Then write_sectag_offset_value = get_sectag_offset
        If flag_confidentiality_offset = &H0 Then write_confidentiality_offset_value = get_confidentiality_offset

        regValue = leftShift((write_pre_sectag_auth_start_value and &H3f), 0) + leftShift((write_pre_sectag_auth_len_value and &H3f), 8) + leftShift((write_sectag_offset_value and &H3f), 16) + leftShift((write_confidentiality_offset_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pre_sectag_auth_start_mask = &H3f
        if data_low > LONG_MAX then
            if pre_sectag_auth_start_mask = mask then
                read_pre_sectag_auth_start_value = data_low
            else
                read_pre_sectag_auth_start_value = (data_low - H8000_0000) and pre_sectag_auth_start_mask
            end If
        else
            read_pre_sectag_auth_start_value = data_low and pre_sectag_auth_start_mask
        end If
        read_pre_sectag_auth_len_value = rightShift(data_low, 8) and &H3f
        read_sectag_offset_value = rightShift(data_low, 16) and &H3f
        read_confidentiality_offset_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_sectag_auth_start_value = &H0
        flag_pre_sectag_auth_start        = &H0
        write_pre_sectag_auth_len_value = &H0
        flag_pre_sectag_auth_len        = &H0
        write_sectag_offset_value = &H0
        flag_sectag_offset        = &H0
        write_confidentiality_offset_value = &H0
        flag_confidentiality_offset        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE

    Public sam_flow_ctrl1_0
    Public sam_flow_ctrl2_0
    Public sam_flow_ctrl1_1
    Public sam_flow_ctrl2_1
    Public sam_flow_ctrl1_2
    Public sam_flow_ctrl2_2
    Public sam_flow_ctrl1_3
    Public sam_flow_ctrl2_3
    Public sam_flow_ctrl1_4
    Public sam_flow_ctrl2_4
    Public sam_flow_ctrl1_5
    Public sam_flow_ctrl2_5
    Public sam_flow_ctrl1_6
    Public sam_flow_ctrl2_6
    Public sam_flow_ctrl1_7
    Public sam_flow_ctrl2_7
    Public sam_flow_ctrl1_8
    Public sam_flow_ctrl2_8
    Public sam_flow_ctrl1_9
    Public sam_flow_ctrl2_9
    Public sam_flow_ctrl1_10
    Public sam_flow_ctrl2_10
    Public sam_flow_ctrl1_11
    Public sam_flow_ctrl2_11
    Public sam_flow_ctrl1_12
    Public sam_flow_ctrl2_12
    Public sam_flow_ctrl1_13
    Public sam_flow_ctrl2_13
    Public sam_flow_ctrl1_14
    Public sam_flow_ctrl2_14
    Public sam_flow_ctrl1_15
    Public sam_flow_ctrl2_15


    Public default function Init(aBaseAddr)
        Set sam_flow_ctrl1_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_0)(aBaseAddr, 32)
        Set sam_flow_ctrl2_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_0)(aBaseAddr, 32)
        Set sam_flow_ctrl1_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_1)(aBaseAddr, 32)
        Set sam_flow_ctrl2_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_1)(aBaseAddr, 32)
        Set sam_flow_ctrl1_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_2)(aBaseAddr, 32)
        Set sam_flow_ctrl2_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_2)(aBaseAddr, 32)
        Set sam_flow_ctrl1_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_3)(aBaseAddr, 32)
        Set sam_flow_ctrl2_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_3)(aBaseAddr, 32)
        Set sam_flow_ctrl1_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_4)(aBaseAddr, 32)
        Set sam_flow_ctrl2_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_4)(aBaseAddr, 32)
        Set sam_flow_ctrl1_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_5)(aBaseAddr, 32)
        Set sam_flow_ctrl2_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_5)(aBaseAddr, 32)
        Set sam_flow_ctrl1_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_6)(aBaseAddr, 32)
        Set sam_flow_ctrl2_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_6)(aBaseAddr, 32)
        Set sam_flow_ctrl1_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_7)(aBaseAddr, 32)
        Set sam_flow_ctrl2_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_7)(aBaseAddr, 32)
        Set sam_flow_ctrl1_8 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_8)(aBaseAddr, 32)
        Set sam_flow_ctrl2_8 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_8)(aBaseAddr, 32)
        Set sam_flow_ctrl1_9 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_9)(aBaseAddr, 32)
        Set sam_flow_ctrl2_9 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_9)(aBaseAddr, 32)
        Set sam_flow_ctrl1_10 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_10)(aBaseAddr, 32)
        Set sam_flow_ctrl2_10 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_10)(aBaseAddr, 32)
        Set sam_flow_ctrl1_11 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_11)(aBaseAddr, 32)
        Set sam_flow_ctrl2_11 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_11)(aBaseAddr, 32)
        Set sam_flow_ctrl1_12 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_12)(aBaseAddr, 32)
        Set sam_flow_ctrl2_12 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_12)(aBaseAddr, 32)
        Set sam_flow_ctrl1_13 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_13)(aBaseAddr, 32)
        Set sam_flow_ctrl2_13 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_13)(aBaseAddr, 32)
        Set sam_flow_ctrl1_14 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_14)(aBaseAddr, 32)
        Set sam_flow_ctrl2_14 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_14)(aBaseAddr, 32)
        Set sam_flow_ctrl1_15 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl1_15)(aBaseAddr, 32)
        Set sam_flow_ctrl2_15 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_sam_flow_ctrl2_15)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0 = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0.Add ((New EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0.Add ((New EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0.Add ((New EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0.Add ((New EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0.Add ((New EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0.Add ((New EIP165S_EIP_160S_I_32_BRCM_FLOW_CONTROL_PAGE0_INSTANCE)(&H4d510000))


