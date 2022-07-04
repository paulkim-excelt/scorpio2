

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


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_pcs_control_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LPI_ENABLE                                 [2:2]            get_LPI_ENABLE
''                                                             set_LPI_ENABLE
''                                                             read_LPI_ENABLE
''                                                             write_LPI_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_pcs_control_0
    Private write_LPI_ENABLE_value
    Private read_LPI_ENABLE_value
    Private flag_LPI_ENABLE

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

    Property Get get_LPI_ENABLE
        get_LPI_ENABLE = read_LPI_ENABLE_value
    End Property

    Property Let set_LPI_ENABLE(aData)
        write_LPI_ENABLE_value = aData
        flag_LPI_ENABLE        = &H1
    End Property

    Property Get read_LPI_ENABLE
        read
        read_LPI_ENABLE = read_LPI_ENABLE_value
    End Property

    Property Let write_LPI_ENABLE(aData)
        set_LPI_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_ENABLE_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_LPI_ENABLE = &H0 Then read
        If flag_LPI_ENABLE = &H0 Then write_LPI_ENABLE_value = get_LPI_ENABLE

        regValue = leftShift((write_LPI_ENABLE_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_ENABLE_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LPI_ENABLE_value = &H0
        flag_LPI_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_fec_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fec_err_enable                             [13:13]          get_fec_err_enable
''                                                             set_fec_err_enable
''                                                             read_fec_err_enable
''                                                             write_fec_err_enable
''---------------------------------------------------------------------------------
'' error_en_ovr                               [12:12]          get_error_en_ovr
''                                                             set_error_en_ovr
''                                                             read_error_en_ovr
''                                                             write_error_en_ovr
''---------------------------------------------------------------------------------
'' error_en_ovr_val                           [11:11]          get_error_en_ovr_val
''                                                             set_error_en_ovr_val
''                                                             read_error_en_ovr_val
''                                                             write_error_en_ovr_val
''---------------------------------------------------------------------------------
'' dbg_enable                                 [10:10]          get_dbg_enable
''                                                             set_dbg_enable
''                                                             read_dbg_enable
''                                                             write_dbg_enable
''---------------------------------------------------------------------------------
'' fast_lock_en                               [9:9]            get_fast_lock_en
''                                                             set_fast_lock_en
''                                                             read_fast_lock_en
''                                                             write_fast_lock_en
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_fec_0
    Private write_fec_err_enable_value
    Private read_fec_err_enable_value
    Private flag_fec_err_enable
    Private write_error_en_ovr_value
    Private read_error_en_ovr_value
    Private flag_error_en_ovr
    Private write_error_en_ovr_val_value
    Private read_error_en_ovr_val_value
    Private flag_error_en_ovr_val
    Private write_dbg_enable_value
    Private read_dbg_enable_value
    Private flag_dbg_enable
    Private write_fast_lock_en_value
    Private read_fast_lock_en_value
    Private flag_fast_lock_en

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

    Property Get get_fec_err_enable
        get_fec_err_enable = read_fec_err_enable_value
    End Property

    Property Let set_fec_err_enable(aData)
        write_fec_err_enable_value = aData
        flag_fec_err_enable        = &H1
    End Property

    Property Get read_fec_err_enable
        read
        read_fec_err_enable = read_fec_err_enable_value
    End Property

    Property Let write_fec_err_enable(aData)
        set_fec_err_enable = aData
        write
    End Property

    Property Get get_error_en_ovr
        get_error_en_ovr = read_error_en_ovr_value
    End Property

    Property Let set_error_en_ovr(aData)
        write_error_en_ovr_value = aData
        flag_error_en_ovr        = &H1
    End Property

    Property Get read_error_en_ovr
        read
        read_error_en_ovr = read_error_en_ovr_value
    End Property

    Property Let write_error_en_ovr(aData)
        set_error_en_ovr = aData
        write
    End Property

    Property Get get_error_en_ovr_val
        get_error_en_ovr_val = read_error_en_ovr_val_value
    End Property

    Property Let set_error_en_ovr_val(aData)
        write_error_en_ovr_val_value = aData
        flag_error_en_ovr_val        = &H1
    End Property

    Property Get read_error_en_ovr_val
        read
        read_error_en_ovr_val = read_error_en_ovr_val_value
    End Property

    Property Let write_error_en_ovr_val(aData)
        set_error_en_ovr_val = aData
        write
    End Property

    Property Get get_dbg_enable
        get_dbg_enable = read_dbg_enable_value
    End Property

    Property Let set_dbg_enable(aData)
        write_dbg_enable_value = aData
        flag_dbg_enable        = &H1
    End Property

    Property Get read_dbg_enable
        read
        read_dbg_enable = read_dbg_enable_value
    End Property

    Property Let write_dbg_enable(aData)
        set_dbg_enable = aData
        write
    End Property

    Property Get get_fast_lock_en
        get_fast_lock_en = read_fast_lock_en_value
    End Property

    Property Let set_fast_lock_en(aData)
        write_fast_lock_en_value = aData
        flag_fast_lock_en        = &H1
    End Property

    Property Get read_fast_lock_en
        read
        read_fast_lock_en = read_fast_lock_en_value
    End Property

    Property Let write_fast_lock_en(aData)
        set_fast_lock_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fec_err_enable_value = rightShift(data_low, 13) and &H1
        read_error_en_ovr_value = rightShift(data_low, 12) and &H1
        read_error_en_ovr_val_value = rightShift(data_low, 11) and &H1
        read_dbg_enable_value = rightShift(data_low, 10) and &H1
        read_fast_lock_en_value = rightShift(data_low, 9) and &H1

    End Sub

    Sub write
        If flag_fec_err_enable = &H0 or flag_error_en_ovr = &H0 or flag_error_en_ovr_val = &H0 or flag_dbg_enable = &H0 or flag_fast_lock_en = &H0 Then read
        If flag_fec_err_enable = &H0 Then write_fec_err_enable_value = get_fec_err_enable
        If flag_error_en_ovr = &H0 Then write_error_en_ovr_value = get_error_en_ovr
        If flag_error_en_ovr_val = &H0 Then write_error_en_ovr_val_value = get_error_en_ovr_val
        If flag_dbg_enable = &H0 Then write_dbg_enable_value = get_dbg_enable
        If flag_fast_lock_en = &H0 Then write_fast_lock_en_value = get_fast_lock_en

        regValue = leftShift((write_fec_err_enable_value and &H1), 13) + leftShift((write_error_en_ovr_value and &H1), 12) + leftShift((write_error_en_ovr_val_value and &H1), 11) + leftShift((write_dbg_enable_value and &H1), 10) + leftShift((write_fast_lock_en_value and &H1), 9)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fec_err_enable_value = rightShift(data_low, 13) and &H1
        read_error_en_ovr_value = rightShift(data_low, 12) and &H1
        read_error_en_ovr_val_value = rightShift(data_low, 11) and &H1
        read_dbg_enable_value = rightShift(data_low, 10) and &H1
        read_fast_lock_en_value = rightShift(data_low, 9) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fec_err_enable_value = &H0
        flag_fec_err_enable        = &H0
        write_error_en_ovr_value = &H0
        flag_error_en_ovr        = &H0
        write_error_en_ovr_val_value = &H0
        flag_error_en_ovr_val        = &H0
        write_dbg_enable_value = &H0
        flag_dbg_enable        = &H0
        write_fast_lock_en_value = &H0
        flag_fast_lock_en        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_decode_control_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bypass_cl49rxsm                            [15:15]          get_bypass_cl49rxsm
''                                                             set_bypass_cl49rxsm
''                                                             read_bypass_cl49rxsm
''                                                             write_bypass_cl49rxsm
''---------------------------------------------------------------------------------
'' r_test_mode_cfg                            [14:14]          get_r_test_mode_cfg
''                                                             set_r_test_mode_cfg
''                                                             read_r_test_mode_cfg
''                                                             write_r_test_mode_cfg
''---------------------------------------------------------------------------------
'' HG2_MESSAGE_INVALID_CODE_ENABLE            [13:13]          get_HG2_MESSAGE_INVALID_CODE_ENABLE
''                                                             set_HG2_MESSAGE_INVALID_CODE_ENABLE
''                                                             read_HG2_MESSAGE_INVALID_CODE_ENABLE
''                                                             write_HG2_MESSAGE_INVALID_CODE_ENABLE
''---------------------------------------------------------------------------------
'' HG2_ENABLE                                 [12:12]          get_HG2_ENABLE
''                                                             set_HG2_ENABLE
''                                                             read_HG2_ENABLE
''                                                             write_HG2_ENABLE
''---------------------------------------------------------------------------------
'' disable_cl49_bermon                        [8:8]            get_disable_cl49_bermon
''                                                             set_disable_cl49_bermon
''                                                             read_disable_cl49_bermon
''                                                             write_disable_cl49_bermon
''---------------------------------------------------------------------------------
'' cl49_rx_li_enable                          [6:6]            get_cl49_rx_li_enable
''                                                             set_cl49_rx_li_enable
''                                                             read_cl49_rx_li_enable
''                                                             write_cl49_rx_li_enable
''---------------------------------------------------------------------------------
'' cl49_rx_lf_enable                          [5:5]            get_cl49_rx_lf_enable
''                                                             set_cl49_rx_lf_enable
''                                                             read_cl49_rx_lf_enable
''                                                             write_cl49_rx_lf_enable
''---------------------------------------------------------------------------------
'' cl49_rx_rf_enable                          [4:4]            get_cl49_rx_rf_enable
''                                                             set_cl49_rx_rf_enable
''                                                             read_cl49_rx_rf_enable
''                                                             write_cl49_rx_rf_enable
''---------------------------------------------------------------------------------
'' cl127_rx_align_fsm_reset                   [3:3]            get_cl127_rx_align_fsm_reset
''                                                             set_cl127_rx_align_fsm_reset
''                                                             read_cl127_rx_align_fsm_reset
''                                                             write_cl127_rx_align_fsm_reset
''---------------------------------------------------------------------------------
'' block_sync_mode                            [2:0]            get_block_sync_mode
''                                                             set_block_sync_mode
''                                                             read_block_sync_mode
''                                                             write_block_sync_mode
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_decode_control_0
    Private write_bypass_cl49rxsm_value
    Private read_bypass_cl49rxsm_value
    Private flag_bypass_cl49rxsm
    Private write_r_test_mode_cfg_value
    Private read_r_test_mode_cfg_value
    Private flag_r_test_mode_cfg
    Private write_HG2_MESSAGE_INVALID_CODE_ENABLE_value
    Private read_HG2_MESSAGE_INVALID_CODE_ENABLE_value
    Private flag_HG2_MESSAGE_INVALID_CODE_ENABLE
    Private write_HG2_ENABLE_value
    Private read_HG2_ENABLE_value
    Private flag_HG2_ENABLE
    Private write_disable_cl49_bermon_value
    Private read_disable_cl49_bermon_value
    Private flag_disable_cl49_bermon
    Private write_cl49_rx_li_enable_value
    Private read_cl49_rx_li_enable_value
    Private flag_cl49_rx_li_enable
    Private write_cl49_rx_lf_enable_value
    Private read_cl49_rx_lf_enable_value
    Private flag_cl49_rx_lf_enable
    Private write_cl49_rx_rf_enable_value
    Private read_cl49_rx_rf_enable_value
    Private flag_cl49_rx_rf_enable
    Private write_cl127_rx_align_fsm_reset_value
    Private read_cl127_rx_align_fsm_reset_value
    Private flag_cl127_rx_align_fsm_reset
    Private write_block_sync_mode_value
    Private read_block_sync_mode_value
    Private flag_block_sync_mode

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

    Property Get get_bypass_cl49rxsm
        get_bypass_cl49rxsm = read_bypass_cl49rxsm_value
    End Property

    Property Let set_bypass_cl49rxsm(aData)
        write_bypass_cl49rxsm_value = aData
        flag_bypass_cl49rxsm        = &H1
    End Property

    Property Get read_bypass_cl49rxsm
        read
        read_bypass_cl49rxsm = read_bypass_cl49rxsm_value
    End Property

    Property Let write_bypass_cl49rxsm(aData)
        set_bypass_cl49rxsm = aData
        write
    End Property

    Property Get get_r_test_mode_cfg
        get_r_test_mode_cfg = read_r_test_mode_cfg_value
    End Property

    Property Let set_r_test_mode_cfg(aData)
        write_r_test_mode_cfg_value = aData
        flag_r_test_mode_cfg        = &H1
    End Property

    Property Get read_r_test_mode_cfg
        read
        read_r_test_mode_cfg = read_r_test_mode_cfg_value
    End Property

    Property Let write_r_test_mode_cfg(aData)
        set_r_test_mode_cfg = aData
        write
    End Property

    Property Get get_HG2_MESSAGE_INVALID_CODE_ENABLE
        get_HG2_MESSAGE_INVALID_CODE_ENABLE = read_HG2_MESSAGE_INVALID_CODE_ENABLE_value
    End Property

    Property Let set_HG2_MESSAGE_INVALID_CODE_ENABLE(aData)
        write_HG2_MESSAGE_INVALID_CODE_ENABLE_value = aData
        flag_HG2_MESSAGE_INVALID_CODE_ENABLE        = &H1
    End Property

    Property Get read_HG2_MESSAGE_INVALID_CODE_ENABLE
        read
        read_HG2_MESSAGE_INVALID_CODE_ENABLE = read_HG2_MESSAGE_INVALID_CODE_ENABLE_value
    End Property

    Property Let write_HG2_MESSAGE_INVALID_CODE_ENABLE(aData)
        set_HG2_MESSAGE_INVALID_CODE_ENABLE = aData
        write
    End Property

    Property Get get_HG2_ENABLE
        get_HG2_ENABLE = read_HG2_ENABLE_value
    End Property

    Property Let set_HG2_ENABLE(aData)
        write_HG2_ENABLE_value = aData
        flag_HG2_ENABLE        = &H1
    End Property

    Property Get read_HG2_ENABLE
        read
        read_HG2_ENABLE = read_HG2_ENABLE_value
    End Property

    Property Let write_HG2_ENABLE(aData)
        set_HG2_ENABLE = aData
        write
    End Property

    Property Get get_disable_cl49_bermon
        get_disable_cl49_bermon = read_disable_cl49_bermon_value
    End Property

    Property Let set_disable_cl49_bermon(aData)
        write_disable_cl49_bermon_value = aData
        flag_disable_cl49_bermon        = &H1
    End Property

    Property Get read_disable_cl49_bermon
        read
        read_disable_cl49_bermon = read_disable_cl49_bermon_value
    End Property

    Property Let write_disable_cl49_bermon(aData)
        set_disable_cl49_bermon = aData
        write
    End Property

    Property Get get_cl49_rx_li_enable
        get_cl49_rx_li_enable = read_cl49_rx_li_enable_value
    End Property

    Property Let set_cl49_rx_li_enable(aData)
        write_cl49_rx_li_enable_value = aData
        flag_cl49_rx_li_enable        = &H1
    End Property

    Property Get read_cl49_rx_li_enable
        read
        read_cl49_rx_li_enable = read_cl49_rx_li_enable_value
    End Property

    Property Let write_cl49_rx_li_enable(aData)
        set_cl49_rx_li_enable = aData
        write
    End Property

    Property Get get_cl49_rx_lf_enable
        get_cl49_rx_lf_enable = read_cl49_rx_lf_enable_value
    End Property

    Property Let set_cl49_rx_lf_enable(aData)
        write_cl49_rx_lf_enable_value = aData
        flag_cl49_rx_lf_enable        = &H1
    End Property

    Property Get read_cl49_rx_lf_enable
        read
        read_cl49_rx_lf_enable = read_cl49_rx_lf_enable_value
    End Property

    Property Let write_cl49_rx_lf_enable(aData)
        set_cl49_rx_lf_enable = aData
        write
    End Property

    Property Get get_cl49_rx_rf_enable
        get_cl49_rx_rf_enable = read_cl49_rx_rf_enable_value
    End Property

    Property Let set_cl49_rx_rf_enable(aData)
        write_cl49_rx_rf_enable_value = aData
        flag_cl49_rx_rf_enable        = &H1
    End Property

    Property Get read_cl49_rx_rf_enable
        read
        read_cl49_rx_rf_enable = read_cl49_rx_rf_enable_value
    End Property

    Property Let write_cl49_rx_rf_enable(aData)
        set_cl49_rx_rf_enable = aData
        write
    End Property

    Property Get get_cl127_rx_align_fsm_reset
        get_cl127_rx_align_fsm_reset = read_cl127_rx_align_fsm_reset_value
    End Property

    Property Let set_cl127_rx_align_fsm_reset(aData)
        write_cl127_rx_align_fsm_reset_value = aData
        flag_cl127_rx_align_fsm_reset        = &H1
    End Property

    Property Get read_cl127_rx_align_fsm_reset
        read
        read_cl127_rx_align_fsm_reset = read_cl127_rx_align_fsm_reset_value
    End Property

    Property Let write_cl127_rx_align_fsm_reset(aData)
        set_cl127_rx_align_fsm_reset = aData
        write
    End Property

    Property Get get_block_sync_mode
        get_block_sync_mode = read_block_sync_mode_value
    End Property

    Property Let set_block_sync_mode(aData)
        write_block_sync_mode_value = aData
        flag_block_sync_mode        = &H1
    End Property

    Property Get read_block_sync_mode
        read
        read_block_sync_mode = read_block_sync_mode_value
    End Property

    Property Let write_block_sync_mode(aData)
        set_block_sync_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_cl49rxsm_value = rightShift(data_low, 15) and &H1
        read_r_test_mode_cfg_value = rightShift(data_low, 14) and &H1
        read_HG2_MESSAGE_INVALID_CODE_ENABLE_value = rightShift(data_low, 13) and &H1
        read_HG2_ENABLE_value = rightShift(data_low, 12) and &H1
        read_disable_cl49_bermon_value = rightShift(data_low, 8) and &H1
        read_cl49_rx_li_enable_value = rightShift(data_low, 6) and &H1
        read_cl49_rx_lf_enable_value = rightShift(data_low, 5) and &H1
        read_cl49_rx_rf_enable_value = rightShift(data_low, 4) and &H1
        read_cl127_rx_align_fsm_reset_value = rightShift(data_low, 3) and &H1
        block_sync_mode_mask = &H7
        if data_low > LONG_MAX then
            if block_sync_mode_mask = mask then
                read_block_sync_mode_value = data_low
            else
                read_block_sync_mode_value = (data_low - H8000_0000) and block_sync_mode_mask
            end If
        else
            read_block_sync_mode_value = data_low and block_sync_mode_mask
        end If

    End Sub

    Sub write
        If flag_bypass_cl49rxsm = &H0 or flag_r_test_mode_cfg = &H0 or flag_HG2_MESSAGE_INVALID_CODE_ENABLE = &H0 or flag_HG2_ENABLE = &H0 or flag_disable_cl49_bermon = &H0 or flag_cl49_rx_li_enable = &H0 or flag_cl49_rx_lf_enable = &H0 or flag_cl49_rx_rf_enable = &H0 or flag_cl127_rx_align_fsm_reset = &H0 or flag_block_sync_mode = &H0 Then read
        If flag_bypass_cl49rxsm = &H0 Then write_bypass_cl49rxsm_value = get_bypass_cl49rxsm
        If flag_r_test_mode_cfg = &H0 Then write_r_test_mode_cfg_value = get_r_test_mode_cfg
        If flag_HG2_MESSAGE_INVALID_CODE_ENABLE = &H0 Then write_HG2_MESSAGE_INVALID_CODE_ENABLE_value = get_HG2_MESSAGE_INVALID_CODE_ENABLE
        If flag_HG2_ENABLE = &H0 Then write_HG2_ENABLE_value = get_HG2_ENABLE
        If flag_disable_cl49_bermon = &H0 Then write_disable_cl49_bermon_value = get_disable_cl49_bermon
        If flag_cl49_rx_li_enable = &H0 Then write_cl49_rx_li_enable_value = get_cl49_rx_li_enable
        If flag_cl49_rx_lf_enable = &H0 Then write_cl49_rx_lf_enable_value = get_cl49_rx_lf_enable
        If flag_cl49_rx_rf_enable = &H0 Then write_cl49_rx_rf_enable_value = get_cl49_rx_rf_enable
        If flag_cl127_rx_align_fsm_reset = &H0 Then write_cl127_rx_align_fsm_reset_value = get_cl127_rx_align_fsm_reset
        If flag_block_sync_mode = &H0 Then write_block_sync_mode_value = get_block_sync_mode

        regValue = leftShift((write_bypass_cl49rxsm_value and &H1), 15) + leftShift((write_r_test_mode_cfg_value and &H1), 14) + leftShift((write_HG2_MESSAGE_INVALID_CODE_ENABLE_value and &H1), 13) + leftShift((write_HG2_ENABLE_value and &H1), 12) + leftShift((write_disable_cl49_bermon_value and &H1), 8) + leftShift((write_cl49_rx_li_enable_value and &H1), 6) + leftShift((write_cl49_rx_lf_enable_value and &H1), 5) + leftShift((write_cl49_rx_rf_enable_value and &H1), 4) + leftShift((write_cl127_rx_align_fsm_reset_value and &H1), 3) + leftShift((write_block_sync_mode_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_cl49rxsm_value = rightShift(data_low, 15) and &H1
        read_r_test_mode_cfg_value = rightShift(data_low, 14) and &H1
        read_HG2_MESSAGE_INVALID_CODE_ENABLE_value = rightShift(data_low, 13) and &H1
        read_HG2_ENABLE_value = rightShift(data_low, 12) and &H1
        read_disable_cl49_bermon_value = rightShift(data_low, 8) and &H1
        read_cl49_rx_li_enable_value = rightShift(data_low, 6) and &H1
        read_cl49_rx_lf_enable_value = rightShift(data_low, 5) and &H1
        read_cl49_rx_rf_enable_value = rightShift(data_low, 4) and &H1
        read_cl127_rx_align_fsm_reset_value = rightShift(data_low, 3) and &H1
        block_sync_mode_mask = &H7
        if data_low > LONG_MAX then
            if block_sync_mode_mask = mask then
                read_block_sync_mode_value = data_low
            else
                read_block_sync_mode_value = (data_low - H8000_0000) and block_sync_mode_mask
            end If
        else
            read_block_sync_mode_value = data_low and block_sync_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bypass_cl49rxsm_value = &H0
        flag_bypass_cl49rxsm        = &H0
        write_r_test_mode_cfg_value = &H0
        flag_r_test_mode_cfg        = &H0
        write_HG2_MESSAGE_INVALID_CODE_ENABLE_value = &H0
        flag_HG2_MESSAGE_INVALID_CODE_ENABLE        = &H0
        write_HG2_ENABLE_value = &H0
        flag_HG2_ENABLE        = &H0
        write_disable_cl49_bermon_value = &H0
        flag_disable_cl49_bermon        = &H0
        write_cl49_rx_li_enable_value = &H0
        flag_cl49_rx_li_enable        = &H0
        write_cl49_rx_lf_enable_value = &H0
        flag_cl49_rx_lf_enable        = &H0
        write_cl49_rx_rf_enable_value = &H0
        flag_cl49_rx_rf_enable        = &H0
        write_cl127_rx_align_fsm_reset_value = &H0
        flag_cl127_rx_align_fsm_reset        = &H0
        write_block_sync_mode_value = &H0
        flag_block_sync_mode        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_cl36_rx_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl36_BER_en                                [5:5]            get_cl36_BER_en
''                                                             set_cl36_BER_en
''                                                             read_cl36_BER_en
''                                                             write_cl36_BER_en
''---------------------------------------------------------------------------------
'' cl36_force_comma_align_enable              [3:3]            get_cl36_force_comma_align_enable
''                                                             set_cl36_force_comma_align_enable
''                                                             read_cl36_force_comma_align_enable
''                                                             write_cl36_force_comma_align_enable
''---------------------------------------------------------------------------------
'' disable_carrier_extend                     [2:2]            get_disable_carrier_extend
''                                                             set_disable_carrier_extend
''                                                             read_disable_carrier_extend
''                                                             write_disable_carrier_extend
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_cl36_rx_0
    Private write_cl36_BER_en_value
    Private read_cl36_BER_en_value
    Private flag_cl36_BER_en
    Private write_cl36_force_comma_align_enable_value
    Private read_cl36_force_comma_align_enable_value
    Private flag_cl36_force_comma_align_enable
    Private write_disable_carrier_extend_value
    Private read_disable_carrier_extend_value
    Private flag_disable_carrier_extend

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

    Property Get get_cl36_BER_en
        get_cl36_BER_en = read_cl36_BER_en_value
    End Property

    Property Let set_cl36_BER_en(aData)
        write_cl36_BER_en_value = aData
        flag_cl36_BER_en        = &H1
    End Property

    Property Get read_cl36_BER_en
        read
        read_cl36_BER_en = read_cl36_BER_en_value
    End Property

    Property Let write_cl36_BER_en(aData)
        set_cl36_BER_en = aData
        write
    End Property

    Property Get get_cl36_force_comma_align_enable
        get_cl36_force_comma_align_enable = read_cl36_force_comma_align_enable_value
    End Property

    Property Let set_cl36_force_comma_align_enable(aData)
        write_cl36_force_comma_align_enable_value = aData
        flag_cl36_force_comma_align_enable        = &H1
    End Property

    Property Get read_cl36_force_comma_align_enable
        read
        read_cl36_force_comma_align_enable = read_cl36_force_comma_align_enable_value
    End Property

    Property Let write_cl36_force_comma_align_enable(aData)
        set_cl36_force_comma_align_enable = aData
        write
    End Property

    Property Get get_disable_carrier_extend
        get_disable_carrier_extend = read_disable_carrier_extend_value
    End Property

    Property Let set_disable_carrier_extend(aData)
        write_disable_carrier_extend_value = aData
        flag_disable_carrier_extend        = &H1
    End Property

    Property Get read_disable_carrier_extend
        read
        read_disable_carrier_extend = read_disable_carrier_extend_value
    End Property

    Property Let write_disable_carrier_extend(aData)
        set_disable_carrier_extend = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl36_BER_en_value = rightShift(data_low, 5) and &H1
        read_cl36_force_comma_align_enable_value = rightShift(data_low, 3) and &H1
        read_disable_carrier_extend_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_cl36_BER_en = &H0 or flag_cl36_force_comma_align_enable = &H0 or flag_disable_carrier_extend = &H0 Then read
        If flag_cl36_BER_en = &H0 Then write_cl36_BER_en_value = get_cl36_BER_en
        If flag_cl36_force_comma_align_enable = &H0 Then write_cl36_force_comma_align_enable_value = get_cl36_force_comma_align_enable
        If flag_disable_carrier_extend = &H0 Then write_disable_carrier_extend_value = get_disable_carrier_extend

        regValue = leftShift((write_cl36_BER_en_value and &H1), 5) + leftShift((write_cl36_force_comma_align_enable_value and &H1), 3) + leftShift((write_disable_carrier_extend_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl36_BER_en_value = rightShift(data_low, 5) and &H1
        read_cl36_force_comma_align_enable_value = rightShift(data_low, 3) and &H1
        read_disable_carrier_extend_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl36_BER_en_value = &H0
        flag_cl36_BER_en        = &H0
        write_cl36_force_comma_align_enable_value = &H0
        flag_cl36_force_comma_align_enable        = &H0
        write_disable_carrier_extend_value = &H0
        flag_disable_carrier_extend        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_pma_control_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_gbox_DV_edge_cya                        [6:6]            get_rx_gbox_DV_edge_cya
''                                                             set_rx_gbox_DV_edge_cya
''                                                             read_rx_gbox_DV_edge_cya
''                                                             write_rx_gbox_DV_edge_cya
''---------------------------------------------------------------------------------
'' rx_fifo_watermark                          [5:4]            get_rx_fifo_watermark
''                                                             set_rx_fifo_watermark
''                                                             read_rx_fifo_watermark
''                                                             write_rx_fifo_watermark
''---------------------------------------------------------------------------------
'' rx_gbox_prst                               [3:3]            get_rx_gbox_prst
''                                                             set_rx_gbox_prst
''                                                             read_rx_gbox_prst
''                                                             write_rx_gbox_prst
''---------------------------------------------------------------------------------
'' rx_gbox_err_det_clr                        [2:2]            get_rx_gbox_err_det_clr
''                                                             set_rx_gbox_err_det_clr
''                                                             read_rx_gbox_err_det_clr
''                                                             write_rx_gbox_err_det_clr
''---------------------------------------------------------------------------------
'' rx_gbox_afrst_en                           [1:1]            get_rx_gbox_afrst_en
''                                                             set_rx_gbox_afrst_en
''                                                             read_rx_gbox_afrst_en
''                                                             write_rx_gbox_afrst_en
''---------------------------------------------------------------------------------
'' rstb_lane                                  [0:0]            get_rstb_lane
''                                                             set_rstb_lane
''                                                             read_rstb_lane
''                                                             write_rstb_lane
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_pma_control_0
    Private write_rx_gbox_DV_edge_cya_value
    Private read_rx_gbox_DV_edge_cya_value
    Private flag_rx_gbox_DV_edge_cya
    Private write_rx_fifo_watermark_value
    Private read_rx_fifo_watermark_value
    Private flag_rx_fifo_watermark
    Private write_rx_gbox_prst_value
    Private read_rx_gbox_prst_value
    Private flag_rx_gbox_prst
    Private write_rx_gbox_err_det_clr_value
    Private read_rx_gbox_err_det_clr_value
    Private flag_rx_gbox_err_det_clr
    Private write_rx_gbox_afrst_en_value
    Private read_rx_gbox_afrst_en_value
    Private flag_rx_gbox_afrst_en
    Private write_rstb_lane_value
    Private read_rstb_lane_value
    Private flag_rstb_lane

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

    Property Get get_rx_gbox_DV_edge_cya
        get_rx_gbox_DV_edge_cya = read_rx_gbox_DV_edge_cya_value
    End Property

    Property Let set_rx_gbox_DV_edge_cya(aData)
        write_rx_gbox_DV_edge_cya_value = aData
        flag_rx_gbox_DV_edge_cya        = &H1
    End Property

    Property Get read_rx_gbox_DV_edge_cya
        read
        read_rx_gbox_DV_edge_cya = read_rx_gbox_DV_edge_cya_value
    End Property

    Property Let write_rx_gbox_DV_edge_cya(aData)
        set_rx_gbox_DV_edge_cya = aData
        write
    End Property

    Property Get get_rx_fifo_watermark
        get_rx_fifo_watermark = read_rx_fifo_watermark_value
    End Property

    Property Let set_rx_fifo_watermark(aData)
        write_rx_fifo_watermark_value = aData
        flag_rx_fifo_watermark        = &H1
    End Property

    Property Get read_rx_fifo_watermark
        read
        read_rx_fifo_watermark = read_rx_fifo_watermark_value
    End Property

    Property Let write_rx_fifo_watermark(aData)
        set_rx_fifo_watermark = aData
        write
    End Property

    Property Get get_rx_gbox_prst
        get_rx_gbox_prst = read_rx_gbox_prst_value
    End Property

    Property Let set_rx_gbox_prst(aData)
        write_rx_gbox_prst_value = aData
        flag_rx_gbox_prst        = &H1
    End Property

    Property Get read_rx_gbox_prst
        read
        read_rx_gbox_prst = read_rx_gbox_prst_value
    End Property

    Property Let write_rx_gbox_prst(aData)
        set_rx_gbox_prst = aData
        write
    End Property

    Property Get get_rx_gbox_err_det_clr
        get_rx_gbox_err_det_clr = read_rx_gbox_err_det_clr_value
    End Property

    Property Let set_rx_gbox_err_det_clr(aData)
        write_rx_gbox_err_det_clr_value = aData
        flag_rx_gbox_err_det_clr        = &H1
    End Property

    Property Get read_rx_gbox_err_det_clr
        read
        read_rx_gbox_err_det_clr = read_rx_gbox_err_det_clr_value
    End Property

    Property Let write_rx_gbox_err_det_clr(aData)
        set_rx_gbox_err_det_clr = aData
        write
    End Property

    Property Get get_rx_gbox_afrst_en
        get_rx_gbox_afrst_en = read_rx_gbox_afrst_en_value
    End Property

    Property Let set_rx_gbox_afrst_en(aData)
        write_rx_gbox_afrst_en_value = aData
        flag_rx_gbox_afrst_en        = &H1
    End Property

    Property Get read_rx_gbox_afrst_en
        read
        read_rx_gbox_afrst_en = read_rx_gbox_afrst_en_value
    End Property

    Property Let write_rx_gbox_afrst_en(aData)
        set_rx_gbox_afrst_en = aData
        write
    End Property

    Property Get get_rstb_lane
        get_rstb_lane = read_rstb_lane_value
    End Property

    Property Let set_rstb_lane(aData)
        write_rstb_lane_value = aData
        flag_rstb_lane        = &H1
    End Property

    Property Get read_rstb_lane
        read
        read_rstb_lane = read_rstb_lane_value
    End Property

    Property Let write_rstb_lane(aData)
        set_rstb_lane = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_gbox_DV_edge_cya_value = rightShift(data_low, 6) and &H1
        read_rx_fifo_watermark_value = rightShift(data_low, 4) and &H3
        read_rx_gbox_prst_value = rightShift(data_low, 3) and &H1
        read_rx_gbox_err_det_clr_value = rightShift(data_low, 2) and &H1
        read_rx_gbox_afrst_en_value = rightShift(data_low, 1) and &H1
        rstb_lane_mask = &H1
        if data_low > LONG_MAX then
            if rstb_lane_mask = mask then
                read_rstb_lane_value = data_low
            else
                read_rstb_lane_value = (data_low - H8000_0000) and rstb_lane_mask
            end If
        else
            read_rstb_lane_value = data_low and rstb_lane_mask
        end If

    End Sub

    Sub write
        If flag_rx_gbox_DV_edge_cya = &H0 or flag_rx_fifo_watermark = &H0 or flag_rx_gbox_prst = &H0 or flag_rx_gbox_err_det_clr = &H0 or flag_rx_gbox_afrst_en = &H0 or flag_rstb_lane = &H0 Then read
        If flag_rx_gbox_DV_edge_cya = &H0 Then write_rx_gbox_DV_edge_cya_value = get_rx_gbox_DV_edge_cya
        If flag_rx_fifo_watermark = &H0 Then write_rx_fifo_watermark_value = get_rx_fifo_watermark
        If flag_rx_gbox_prst = &H0 Then write_rx_gbox_prst_value = get_rx_gbox_prst
        If flag_rx_gbox_err_det_clr = &H0 Then write_rx_gbox_err_det_clr_value = get_rx_gbox_err_det_clr
        If flag_rx_gbox_afrst_en = &H0 Then write_rx_gbox_afrst_en_value = get_rx_gbox_afrst_en
        If flag_rstb_lane = &H0 Then write_rstb_lane_value = get_rstb_lane

        regValue = leftShift((write_rx_gbox_DV_edge_cya_value and &H1), 6) + leftShift((write_rx_fifo_watermark_value and &H3), 4) + leftShift((write_rx_gbox_prst_value and &H1), 3) + leftShift((write_rx_gbox_err_det_clr_value and &H1), 2) + leftShift((write_rx_gbox_afrst_en_value and &H1), 1) + leftShift((write_rstb_lane_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_gbox_DV_edge_cya_value = rightShift(data_low, 6) and &H1
        read_rx_fifo_watermark_value = rightShift(data_low, 4) and &H3
        read_rx_gbox_prst_value = rightShift(data_low, 3) and &H1
        read_rx_gbox_err_det_clr_value = rightShift(data_low, 2) and &H1
        read_rx_gbox_afrst_en_value = rightShift(data_low, 1) and &H1
        rstb_lane_mask = &H1
        if data_low > LONG_MAX then
            if rstb_lane_mask = mask then
                read_rstb_lane_value = data_low
            else
                read_rstb_lane_value = (data_low - H8000_0000) and rstb_lane_mask
            end If
        else
            read_rstb_lane_value = data_low and rstb_lane_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_gbox_DV_edge_cya_value = &H0
        flag_rx_gbox_DV_edge_cya        = &H0
        write_rx_fifo_watermark_value = &H0
        flag_rx_fifo_watermark        = &H0
        write_rx_gbox_prst_value = &H0
        flag_rx_gbox_prst        = &H0
        write_rx_gbox_err_det_clr_value = &H0
        flag_rx_gbox_err_det_clr        = &H0
        write_rx_gbox_afrst_en_value = &H0
        flag_rx_gbox_afrst_en        = &H0
        write_rstb_lane_value = &H0
        flag_rstb_lane        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_link_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' latch_linkdown_enable                      [0:0]            get_latch_linkdown_enable
''                                                             set_latch_linkdown_enable
''                                                             read_latch_linkdown_enable
''                                                             write_latch_linkdown_enable
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_link_control
    Private write_latch_linkdown_enable_value
    Private read_latch_linkdown_enable_value
    Private flag_latch_linkdown_enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_latch_linkdown_enable
        get_latch_linkdown_enable = read_latch_linkdown_enable_value
    End Property

    Property Let set_latch_linkdown_enable(aData)
        write_latch_linkdown_enable_value = aData
        flag_latch_linkdown_enable        = &H1
    End Property

    Property Get read_latch_linkdown_enable
        read
        read_latch_linkdown_enable = read_latch_linkdown_enable_value
    End Property

    Property Let write_latch_linkdown_enable(aData)
        set_latch_linkdown_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        latch_linkdown_enable_mask = &H1
        if data_low > LONG_MAX then
            if latch_linkdown_enable_mask = mask then
                read_latch_linkdown_enable_value = data_low
            else
                read_latch_linkdown_enable_value = (data_low - H8000_0000) and latch_linkdown_enable_mask
            end If
        else
            read_latch_linkdown_enable_value = data_low and latch_linkdown_enable_mask
        end If

    End Sub

    Sub write
        If flag_latch_linkdown_enable = &H0 Then read
        If flag_latch_linkdown_enable = &H0 Then write_latch_linkdown_enable_value = get_latch_linkdown_enable

        regValue = leftShift((write_latch_linkdown_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        latch_linkdown_enable_mask = &H1
        if data_low > LONG_MAX then
            if latch_linkdown_enable_mask = mask then
                read_latch_linkdown_enable_value = data_low
            else
                read_latch_linkdown_enable_value = (data_low - H8000_0000) and latch_linkdown_enable_mask
            end If
        else
            read_latch_linkdown_enable_value = data_low and latch_linkdown_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_latch_linkdown_enable_value = &H0
        flag_latch_linkdown_enable        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_cl72_2_pmd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_tx_disable_en                           [1:1]            get_an_tx_disable_en
''                                                             set_an_tx_disable_en
''                                                             read_an_tx_disable_en
''                                                             write_an_tx_disable_en
''---------------------------------------------------------------------------------
'' cl72_rx_trained                            [0:0]            get_cl72_rx_trained
''                                                             set_cl72_rx_trained
''                                                             read_cl72_rx_trained
''                                                             write_cl72_rx_trained
''---------------------------------------------------------------------------------
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_cl72_2_pmd
    Private write_an_tx_disable_en_value
    Private read_an_tx_disable_en_value
    Private flag_an_tx_disable_en
    Private write_cl72_rx_trained_value
    Private read_cl72_rx_trained_value
    Private flag_cl72_rx_trained

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_an_tx_disable_en
        get_an_tx_disable_en = read_an_tx_disable_en_value
    End Property

    Property Let set_an_tx_disable_en(aData)
        write_an_tx_disable_en_value = aData
        flag_an_tx_disable_en        = &H1
    End Property

    Property Get read_an_tx_disable_en
        read
        read_an_tx_disable_en = read_an_tx_disable_en_value
    End Property

    Property Let write_an_tx_disable_en(aData)
        set_an_tx_disable_en = aData
        write
    End Property

    Property Get get_cl72_rx_trained
        get_cl72_rx_trained = read_cl72_rx_trained_value
    End Property

    Property Let set_cl72_rx_trained(aData)
        write_cl72_rx_trained_value = aData
        flag_cl72_rx_trained        = &H1
    End Property

    Property Get read_cl72_rx_trained
        read
        read_cl72_rx_trained = read_cl72_rx_trained_value
    End Property

    Property Let write_cl72_rx_trained(aData)
        set_cl72_rx_trained = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_tx_disable_en_value = rightShift(data_low, 1) and &H1
        cl72_rx_trained_mask = &H1
        if data_low > LONG_MAX then
            if cl72_rx_trained_mask = mask then
                read_cl72_rx_trained_value = data_low
            else
                read_cl72_rx_trained_value = (data_low - H8000_0000) and cl72_rx_trained_mask
            end If
        else
            read_cl72_rx_trained_value = data_low and cl72_rx_trained_mask
        end If

    End Sub

    Sub write
        If flag_an_tx_disable_en = &H0 or flag_cl72_rx_trained = &H0 Then read
        If flag_an_tx_disable_en = &H0 Then write_an_tx_disable_en_value = get_an_tx_disable_en
        If flag_cl72_rx_trained = &H0 Then write_cl72_rx_trained_value = get_cl72_rx_trained

        regValue = leftShift((write_an_tx_disable_en_value and &H1), 1) + leftShift((write_cl72_rx_trained_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_tx_disable_en_value = rightShift(data_low, 1) and &H1
        cl72_rx_trained_mask = &H1
        if data_low > LONG_MAX then
            if cl72_rx_trained_mask = mask then
                read_cl72_rx_trained_value = data_low
            else
                read_cl72_rx_trained_value = (data_low - H8000_0000) and cl72_rx_trained_mask
            end If
        else
            read_cl72_rx_trained_value = data_low and cl72_rx_trained_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_tx_disable_en_value = &H0
        flag_an_tx_disable_en        = &H0
        write_cl72_rx_trained_value = &H0
        flag_cl72_rx_trained        = &H0
    End Sub
End Class


'' @REGISTER : RX_X4_CONTROL0_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_blockaddress
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

Class RX_X4_CONTROL0_SGMIIPLUSR_X1_INSTANCE

    Public pcs_control_0
    Public fec_0
    Public decode_control_0
    Public cl36_rx_0
    Public pma_control_0
    Public link_control
    Public cl72_2_pmd
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set pcs_control_0 = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_pcs_control_0)(aBaseAddr, 16)
        Set fec_0 = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_fec_0)(aBaseAddr, 16)
        Set decode_control_0 = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_decode_control_0)(aBaseAddr, 16)
        Set cl36_rx_0 = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_cl36_rx_0)(aBaseAddr, 16)
        Set pma_control_0 = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_pma_control_0)(aBaseAddr, 16)
        Set link_control = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_link_control)(aBaseAddr, 16)
        Set cl72_2_pmd = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_cl72_2_pmd)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_X4_CONTROL0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_X4_CONTROL0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX_X4_CONTROL0_SGMIIPLUSR_X1.Add ((New RX_X4_CONTROL0_SGMIIPLUSR_X1_INSTANCE)(&H4aed88a0))


