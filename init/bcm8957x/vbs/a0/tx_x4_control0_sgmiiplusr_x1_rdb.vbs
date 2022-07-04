

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


'' @REGISTER : TX_X4_CONTROL0_SGMIIPLUSR_X1_encode_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HG2_CODEC                                  [12:12]          get_HG2_CODEC
''                                                             set_HG2_CODEC
''                                                             read_HG2_CODEC
''                                                             write_HG2_CODEC
''---------------------------------------------------------------------------------
'' HG2_MESSAGE_INVALID_CODE_ENABLE            [11:11]          get_HG2_MESSAGE_INVALID_CODE_ENABLE
''                                                             set_HG2_MESSAGE_INVALID_CODE_ENABLE
''                                                             read_HG2_MESSAGE_INVALID_CODE_ENABLE
''                                                             write_HG2_MESSAGE_INVALID_CODE_ENABLE
''---------------------------------------------------------------------------------
'' HG2_ENABLE                                 [10:10]          get_HG2_ENABLE
''                                                             set_HG2_ENABLE
''                                                             read_HG2_ENABLE
''                                                             write_HG2_ENABLE
''---------------------------------------------------------------------------------
'' cl49_bypass_txsm                           [9:9]            get_cl49_bypass_txsm
''                                                             set_cl49_bypass_txsm
''                                                             read_cl49_bypass_txsm
''                                                             write_cl49_bypass_txsm
''---------------------------------------------------------------------------------
'' cl49_tx_tl_mode                            [6:5]            get_cl49_tx_tl_mode
''                                                             set_cl49_tx_tl_mode
''                                                             read_cl49_tx_tl_mode
''                                                             write_cl49_tx_tl_mode
''---------------------------------------------------------------------------------
'' encodeMode                                 [4:2]            get_encodeMode
''                                                             set_encodeMode
''                                                             read_encodeMode
''                                                             write_encodeMode
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_encode_0
    Private write_HG2_CODEC_value
    Private read_HG2_CODEC_value
    Private flag_HG2_CODEC
    Private write_HG2_MESSAGE_INVALID_CODE_ENABLE_value
    Private read_HG2_MESSAGE_INVALID_CODE_ENABLE_value
    Private flag_HG2_MESSAGE_INVALID_CODE_ENABLE
    Private write_HG2_ENABLE_value
    Private read_HG2_ENABLE_value
    Private flag_HG2_ENABLE
    Private write_cl49_bypass_txsm_value
    Private read_cl49_bypass_txsm_value
    Private flag_cl49_bypass_txsm
    Private write_cl49_tx_tl_mode_value
    Private read_cl49_tx_tl_mode_value
    Private flag_cl49_tx_tl_mode
    Private write_encodeMode_value
    Private read_encodeMode_value
    Private flag_encodeMode

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

    Property Get get_HG2_CODEC
        get_HG2_CODEC = read_HG2_CODEC_value
    End Property

    Property Let set_HG2_CODEC(aData)
        write_HG2_CODEC_value = aData
        flag_HG2_CODEC        = &H1
    End Property

    Property Get read_HG2_CODEC
        read
        read_HG2_CODEC = read_HG2_CODEC_value
    End Property

    Property Let write_HG2_CODEC(aData)
        set_HG2_CODEC = aData
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

    Property Get get_cl49_bypass_txsm
        get_cl49_bypass_txsm = read_cl49_bypass_txsm_value
    End Property

    Property Let set_cl49_bypass_txsm(aData)
        write_cl49_bypass_txsm_value = aData
        flag_cl49_bypass_txsm        = &H1
    End Property

    Property Get read_cl49_bypass_txsm
        read
        read_cl49_bypass_txsm = read_cl49_bypass_txsm_value
    End Property

    Property Let write_cl49_bypass_txsm(aData)
        set_cl49_bypass_txsm = aData
        write
    End Property

    Property Get get_cl49_tx_tl_mode
        get_cl49_tx_tl_mode = read_cl49_tx_tl_mode_value
    End Property

    Property Let set_cl49_tx_tl_mode(aData)
        write_cl49_tx_tl_mode_value = aData
        flag_cl49_tx_tl_mode        = &H1
    End Property

    Property Get read_cl49_tx_tl_mode
        read
        read_cl49_tx_tl_mode = read_cl49_tx_tl_mode_value
    End Property

    Property Let write_cl49_tx_tl_mode(aData)
        set_cl49_tx_tl_mode = aData
        write
    End Property

    Property Get get_encodeMode
        get_encodeMode = read_encodeMode_value
    End Property

    Property Let set_encodeMode(aData)
        write_encodeMode_value = aData
        flag_encodeMode        = &H1
    End Property

    Property Get read_encodeMode
        read
        read_encodeMode = read_encodeMode_value
    End Property

    Property Let write_encodeMode(aData)
        set_encodeMode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HG2_CODEC_value = rightShift(data_low, 12) and &H1
        read_HG2_MESSAGE_INVALID_CODE_ENABLE_value = rightShift(data_low, 11) and &H1
        read_HG2_ENABLE_value = rightShift(data_low, 10) and &H1
        read_cl49_bypass_txsm_value = rightShift(data_low, 9) and &H1
        read_cl49_tx_tl_mode_value = rightShift(data_low, 5) and &H3
        read_encodeMode_value = rightShift(data_low, 2) and &H7

    End Sub

    Sub write
        If flag_HG2_CODEC = &H0 or flag_HG2_MESSAGE_INVALID_CODE_ENABLE = &H0 or flag_HG2_ENABLE = &H0 or flag_cl49_bypass_txsm = &H0 or flag_cl49_tx_tl_mode = &H0 or flag_encodeMode = &H0 Then read
        If flag_HG2_CODEC = &H0 Then write_HG2_CODEC_value = get_HG2_CODEC
        If flag_HG2_MESSAGE_INVALID_CODE_ENABLE = &H0 Then write_HG2_MESSAGE_INVALID_CODE_ENABLE_value = get_HG2_MESSAGE_INVALID_CODE_ENABLE
        If flag_HG2_ENABLE = &H0 Then write_HG2_ENABLE_value = get_HG2_ENABLE
        If flag_cl49_bypass_txsm = &H0 Then write_cl49_bypass_txsm_value = get_cl49_bypass_txsm
        If flag_cl49_tx_tl_mode = &H0 Then write_cl49_tx_tl_mode_value = get_cl49_tx_tl_mode
        If flag_encodeMode = &H0 Then write_encodeMode_value = get_encodeMode

        regValue = leftShift((write_HG2_CODEC_value and &H1), 12) + leftShift((write_HG2_MESSAGE_INVALID_CODE_ENABLE_value and &H1), 11) + leftShift((write_HG2_ENABLE_value and &H1), 10) + leftShift((write_cl49_bypass_txsm_value and &H1), 9) + leftShift((write_cl49_tx_tl_mode_value and &H3), 5) + leftShift((write_encodeMode_value and &H7), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HG2_CODEC_value = rightShift(data_low, 12) and &H1
        read_HG2_MESSAGE_INVALID_CODE_ENABLE_value = rightShift(data_low, 11) and &H1
        read_HG2_ENABLE_value = rightShift(data_low, 10) and &H1
        read_cl49_bypass_txsm_value = rightShift(data_low, 9) and &H1
        read_cl49_tx_tl_mode_value = rightShift(data_low, 5) and &H3
        read_encodeMode_value = rightShift(data_low, 2) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HG2_CODEC_value = &H0
        flag_HG2_CODEC        = &H0
        write_HG2_MESSAGE_INVALID_CODE_ENABLE_value = &H0
        flag_HG2_MESSAGE_INVALID_CODE_ENABLE        = &H0
        write_HG2_ENABLE_value = &H0
        flag_HG2_ENABLE        = &H0
        write_cl49_bypass_txsm_value = &H0
        flag_cl49_bypass_txsm        = &H0
        write_cl49_tx_tl_mode_value = &H0
        flag_cl49_tx_tl_mode        = &H0
        write_encodeMode_value = &H0
        flag_encodeMode        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_CONTROL0_SGMIIPLUSR_X1_encode_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' catch_all_8b10b_dis                        [9:9]            get_catch_all_8b10b_dis
''                                                             set_catch_all_8b10b_dis
''                                                             read_catch_all_8b10b_dis
''                                                             write_catch_all_8b10b_dis
''---------------------------------------------------------------------------------
'' prog_tl_en                                 [8:8]            get_prog_tl_en
''                                                             set_prog_tl_en
''                                                             read_prog_tl_en
''                                                             write_prog_tl_en
''---------------------------------------------------------------------------------
'' prog_tl_char                               [7:0]            get_prog_tl_char
''                                                             set_prog_tl_char
''                                                             read_prog_tl_char
''                                                             write_prog_tl_char
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_encode_1
    Private write_catch_all_8b10b_dis_value
    Private read_catch_all_8b10b_dis_value
    Private flag_catch_all_8b10b_dis
    Private write_prog_tl_en_value
    Private read_prog_tl_en_value
    Private flag_prog_tl_en
    Private write_prog_tl_char_value
    Private read_prog_tl_char_value
    Private flag_prog_tl_char

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

    Property Get get_catch_all_8b10b_dis
        get_catch_all_8b10b_dis = read_catch_all_8b10b_dis_value
    End Property

    Property Let set_catch_all_8b10b_dis(aData)
        write_catch_all_8b10b_dis_value = aData
        flag_catch_all_8b10b_dis        = &H1
    End Property

    Property Get read_catch_all_8b10b_dis
        read
        read_catch_all_8b10b_dis = read_catch_all_8b10b_dis_value
    End Property

    Property Let write_catch_all_8b10b_dis(aData)
        set_catch_all_8b10b_dis = aData
        write
    End Property

    Property Get get_prog_tl_en
        get_prog_tl_en = read_prog_tl_en_value
    End Property

    Property Let set_prog_tl_en(aData)
        write_prog_tl_en_value = aData
        flag_prog_tl_en        = &H1
    End Property

    Property Get read_prog_tl_en
        read
        read_prog_tl_en = read_prog_tl_en_value
    End Property

    Property Let write_prog_tl_en(aData)
        set_prog_tl_en = aData
        write
    End Property

    Property Get get_prog_tl_char
        get_prog_tl_char = read_prog_tl_char_value
    End Property

    Property Let set_prog_tl_char(aData)
        write_prog_tl_char_value = aData
        flag_prog_tl_char        = &H1
    End Property

    Property Get read_prog_tl_char
        read
        read_prog_tl_char = read_prog_tl_char_value
    End Property

    Property Let write_prog_tl_char(aData)
        set_prog_tl_char = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_catch_all_8b10b_dis_value = rightShift(data_low, 9) and &H1
        read_prog_tl_en_value = rightShift(data_low, 8) and &H1
        prog_tl_char_mask = &Hff
        if data_low > LONG_MAX then
            if prog_tl_char_mask = mask then
                read_prog_tl_char_value = data_low
            else
                read_prog_tl_char_value = (data_low - H8000_0000) and prog_tl_char_mask
            end If
        else
            read_prog_tl_char_value = data_low and prog_tl_char_mask
        end If

    End Sub

    Sub write
        If flag_catch_all_8b10b_dis = &H0 or flag_prog_tl_en = &H0 or flag_prog_tl_char = &H0 Then read
        If flag_catch_all_8b10b_dis = &H0 Then write_catch_all_8b10b_dis_value = get_catch_all_8b10b_dis
        If flag_prog_tl_en = &H0 Then write_prog_tl_en_value = get_prog_tl_en
        If flag_prog_tl_char = &H0 Then write_prog_tl_char_value = get_prog_tl_char

        regValue = leftShift((write_catch_all_8b10b_dis_value and &H1), 9) + leftShift((write_prog_tl_en_value and &H1), 8) + leftShift((write_prog_tl_char_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_catch_all_8b10b_dis_value = rightShift(data_low, 9) and &H1
        read_prog_tl_en_value = rightShift(data_low, 8) and &H1
        prog_tl_char_mask = &Hff
        if data_low > LONG_MAX then
            if prog_tl_char_mask = mask then
                read_prog_tl_char_value = data_low
            else
                read_prog_tl_char_value = (data_low - H8000_0000) and prog_tl_char_mask
            end If
        else
            read_prog_tl_char_value = data_low and prog_tl_char_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_catch_all_8b10b_dis_value = &H0
        flag_catch_all_8b10b_dis        = &H0
        write_prog_tl_en_value = &H0
        flag_prog_tl_en        = &H0
        write_prog_tl_char_value = &H0
        flag_prog_tl_char        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_CONTROL0_SGMIIPLUSR_X1_misc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scr_mode                                   [15:14]          get_scr_mode
''                                                             set_scr_mode
''                                                             read_scr_mode
''                                                             write_scr_mode
''---------------------------------------------------------------------------------
'' tx_gbox_prst                               [13:13]          get_tx_gbox_prst
''                                                             set_tx_gbox_prst
''                                                             read_tx_gbox_prst
''                                                             write_tx_gbox_prst
''---------------------------------------------------------------------------------
'' tx_gbox_err_det_clr                        [12:12]          get_tx_gbox_err_det_clr
''                                                             set_tx_gbox_err_det_clr
''                                                             read_tx_gbox_err_det_clr
''                                                             write_tx_gbox_err_det_clr
''---------------------------------------------------------------------------------
'' tx_gbox_afrst_en                           [11:11]          get_tx_gbox_afrst_en
''                                                             set_tx_gbox_afrst_en
''                                                             read_tx_gbox_afrst_en
''                                                             write_tx_gbox_afrst_en
''---------------------------------------------------------------------------------
'' fec_enable                                 [10:10]          get_fec_enable
''                                                             set_fec_enable
''                                                             read_fec_enable
''                                                             write_fec_enable
''---------------------------------------------------------------------------------
'' tx_gbox_errdet_sel                         [9:9]            get_tx_gbox_errdet_sel
''                                                             set_tx_gbox_errdet_sel
''                                                             read_tx_gbox_errdet_sel
''                                                             write_tx_gbox_errdet_sel
''---------------------------------------------------------------------------------
'' cl49_tx_li_enable                          [8:8]            get_cl49_tx_li_enable
''                                                             set_cl49_tx_li_enable
''                                                             read_cl49_tx_li_enable
''                                                             write_cl49_tx_li_enable
''---------------------------------------------------------------------------------
'' cl49_tx_lf_enable                          [7:7]            get_cl49_tx_lf_enable
''                                                             set_cl49_tx_lf_enable
''                                                             read_cl49_tx_lf_enable
''                                                             write_cl49_tx_lf_enable
''---------------------------------------------------------------------------------
'' cl49_tx_rf_enable                          [6:6]            get_cl49_tx_rf_enable
''                                                             set_cl49_tx_rf_enable
''                                                             read_cl49_tx_rf_enable
''                                                             write_cl49_tx_rf_enable
''---------------------------------------------------------------------------------
'' tx_fifo_watermark                          [3:2]            get_tx_fifo_watermark
''                                                             set_tx_fifo_watermark
''                                                             read_tx_fifo_watermark
''                                                             write_tx_fifo_watermark
''---------------------------------------------------------------------------------
'' rstb_tx_lane                               [1:1]            get_rstb_tx_lane
''                                                             set_rstb_tx_lane
''                                                             read_rstb_tx_lane
''                                                             write_rstb_tx_lane
''---------------------------------------------------------------------------------
'' enable_tx_lane                             [0:0]            get_enable_tx_lane
''                                                             set_enable_tx_lane
''                                                             read_enable_tx_lane
''                                                             write_enable_tx_lane
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_misc
    Private write_scr_mode_value
    Private read_scr_mode_value
    Private flag_scr_mode
    Private write_tx_gbox_prst_value
    Private read_tx_gbox_prst_value
    Private flag_tx_gbox_prst
    Private write_tx_gbox_err_det_clr_value
    Private read_tx_gbox_err_det_clr_value
    Private flag_tx_gbox_err_det_clr
    Private write_tx_gbox_afrst_en_value
    Private read_tx_gbox_afrst_en_value
    Private flag_tx_gbox_afrst_en
    Private write_fec_enable_value
    Private read_fec_enable_value
    Private flag_fec_enable
    Private write_tx_gbox_errdet_sel_value
    Private read_tx_gbox_errdet_sel_value
    Private flag_tx_gbox_errdet_sel
    Private write_cl49_tx_li_enable_value
    Private read_cl49_tx_li_enable_value
    Private flag_cl49_tx_li_enable
    Private write_cl49_tx_lf_enable_value
    Private read_cl49_tx_lf_enable_value
    Private flag_cl49_tx_lf_enable
    Private write_cl49_tx_rf_enable_value
    Private read_cl49_tx_rf_enable_value
    Private flag_cl49_tx_rf_enable
    Private write_tx_fifo_watermark_value
    Private read_tx_fifo_watermark_value
    Private flag_tx_fifo_watermark
    Private write_rstb_tx_lane_value
    Private read_rstb_tx_lane_value
    Private flag_rstb_tx_lane
    Private write_enable_tx_lane_value
    Private read_enable_tx_lane_value
    Private flag_enable_tx_lane

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

    Property Get get_scr_mode
        get_scr_mode = read_scr_mode_value
    End Property

    Property Let set_scr_mode(aData)
        write_scr_mode_value = aData
        flag_scr_mode        = &H1
    End Property

    Property Get read_scr_mode
        read
        read_scr_mode = read_scr_mode_value
    End Property

    Property Let write_scr_mode(aData)
        set_scr_mode = aData
        write
    End Property

    Property Get get_tx_gbox_prst
        get_tx_gbox_prst = read_tx_gbox_prst_value
    End Property

    Property Let set_tx_gbox_prst(aData)
        write_tx_gbox_prst_value = aData
        flag_tx_gbox_prst        = &H1
    End Property

    Property Get read_tx_gbox_prst
        read
        read_tx_gbox_prst = read_tx_gbox_prst_value
    End Property

    Property Let write_tx_gbox_prst(aData)
        set_tx_gbox_prst = aData
        write
    End Property

    Property Get get_tx_gbox_err_det_clr
        get_tx_gbox_err_det_clr = read_tx_gbox_err_det_clr_value
    End Property

    Property Let set_tx_gbox_err_det_clr(aData)
        write_tx_gbox_err_det_clr_value = aData
        flag_tx_gbox_err_det_clr        = &H1
    End Property

    Property Get read_tx_gbox_err_det_clr
        read
        read_tx_gbox_err_det_clr = read_tx_gbox_err_det_clr_value
    End Property

    Property Let write_tx_gbox_err_det_clr(aData)
        set_tx_gbox_err_det_clr = aData
        write
    End Property

    Property Get get_tx_gbox_afrst_en
        get_tx_gbox_afrst_en = read_tx_gbox_afrst_en_value
    End Property

    Property Let set_tx_gbox_afrst_en(aData)
        write_tx_gbox_afrst_en_value = aData
        flag_tx_gbox_afrst_en        = &H1
    End Property

    Property Get read_tx_gbox_afrst_en
        read
        read_tx_gbox_afrst_en = read_tx_gbox_afrst_en_value
    End Property

    Property Let write_tx_gbox_afrst_en(aData)
        set_tx_gbox_afrst_en = aData
        write
    End Property

    Property Get get_fec_enable
        get_fec_enable = read_fec_enable_value
    End Property

    Property Let set_fec_enable(aData)
        write_fec_enable_value = aData
        flag_fec_enable        = &H1
    End Property

    Property Get read_fec_enable
        read
        read_fec_enable = read_fec_enable_value
    End Property

    Property Let write_fec_enable(aData)
        set_fec_enable = aData
        write
    End Property

    Property Get get_tx_gbox_errdet_sel
        get_tx_gbox_errdet_sel = read_tx_gbox_errdet_sel_value
    End Property

    Property Let set_tx_gbox_errdet_sel(aData)
        write_tx_gbox_errdet_sel_value = aData
        flag_tx_gbox_errdet_sel        = &H1
    End Property

    Property Get read_tx_gbox_errdet_sel
        read
        read_tx_gbox_errdet_sel = read_tx_gbox_errdet_sel_value
    End Property

    Property Let write_tx_gbox_errdet_sel(aData)
        set_tx_gbox_errdet_sel = aData
        write
    End Property

    Property Get get_cl49_tx_li_enable
        get_cl49_tx_li_enable = read_cl49_tx_li_enable_value
    End Property

    Property Let set_cl49_tx_li_enable(aData)
        write_cl49_tx_li_enable_value = aData
        flag_cl49_tx_li_enable        = &H1
    End Property

    Property Get read_cl49_tx_li_enable
        read
        read_cl49_tx_li_enable = read_cl49_tx_li_enable_value
    End Property

    Property Let write_cl49_tx_li_enable(aData)
        set_cl49_tx_li_enable = aData
        write
    End Property

    Property Get get_cl49_tx_lf_enable
        get_cl49_tx_lf_enable = read_cl49_tx_lf_enable_value
    End Property

    Property Let set_cl49_tx_lf_enable(aData)
        write_cl49_tx_lf_enable_value = aData
        flag_cl49_tx_lf_enable        = &H1
    End Property

    Property Get read_cl49_tx_lf_enable
        read
        read_cl49_tx_lf_enable = read_cl49_tx_lf_enable_value
    End Property

    Property Let write_cl49_tx_lf_enable(aData)
        set_cl49_tx_lf_enable = aData
        write
    End Property

    Property Get get_cl49_tx_rf_enable
        get_cl49_tx_rf_enable = read_cl49_tx_rf_enable_value
    End Property

    Property Let set_cl49_tx_rf_enable(aData)
        write_cl49_tx_rf_enable_value = aData
        flag_cl49_tx_rf_enable        = &H1
    End Property

    Property Get read_cl49_tx_rf_enable
        read
        read_cl49_tx_rf_enable = read_cl49_tx_rf_enable_value
    End Property

    Property Let write_cl49_tx_rf_enable(aData)
        set_cl49_tx_rf_enable = aData
        write
    End Property

    Property Get get_tx_fifo_watermark
        get_tx_fifo_watermark = read_tx_fifo_watermark_value
    End Property

    Property Let set_tx_fifo_watermark(aData)
        write_tx_fifo_watermark_value = aData
        flag_tx_fifo_watermark        = &H1
    End Property

    Property Get read_tx_fifo_watermark
        read
        read_tx_fifo_watermark = read_tx_fifo_watermark_value
    End Property

    Property Let write_tx_fifo_watermark(aData)
        set_tx_fifo_watermark = aData
        write
    End Property

    Property Get get_rstb_tx_lane
        get_rstb_tx_lane = read_rstb_tx_lane_value
    End Property

    Property Let set_rstb_tx_lane(aData)
        write_rstb_tx_lane_value = aData
        flag_rstb_tx_lane        = &H1
    End Property

    Property Get read_rstb_tx_lane
        read
        read_rstb_tx_lane = read_rstb_tx_lane_value
    End Property

    Property Let write_rstb_tx_lane(aData)
        set_rstb_tx_lane = aData
        write
    End Property

    Property Get get_enable_tx_lane
        get_enable_tx_lane = read_enable_tx_lane_value
    End Property

    Property Let set_enable_tx_lane(aData)
        write_enable_tx_lane_value = aData
        flag_enable_tx_lane        = &H1
    End Property

    Property Get read_enable_tx_lane
        read
        read_enable_tx_lane = read_enable_tx_lane_value
    End Property

    Property Let write_enable_tx_lane(aData)
        set_enable_tx_lane = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_scr_mode_value = rightShift(data_low, 14) and &H3
        read_tx_gbox_prst_value = rightShift(data_low, 13) and &H1
        read_tx_gbox_err_det_clr_value = rightShift(data_low, 12) and &H1
        read_tx_gbox_afrst_en_value = rightShift(data_low, 11) and &H1
        read_fec_enable_value = rightShift(data_low, 10) and &H1
        read_tx_gbox_errdet_sel_value = rightShift(data_low, 9) and &H1
        read_cl49_tx_li_enable_value = rightShift(data_low, 8) and &H1
        read_cl49_tx_lf_enable_value = rightShift(data_low, 7) and &H1
        read_cl49_tx_rf_enable_value = rightShift(data_low, 6) and &H1
        read_tx_fifo_watermark_value = rightShift(data_low, 2) and &H3
        read_rstb_tx_lane_value = rightShift(data_low, 1) and &H1
        enable_tx_lane_mask = &H1
        if data_low > LONG_MAX then
            if enable_tx_lane_mask = mask then
                read_enable_tx_lane_value = data_low
            else
                read_enable_tx_lane_value = (data_low - H8000_0000) and enable_tx_lane_mask
            end If
        else
            read_enable_tx_lane_value = data_low and enable_tx_lane_mask
        end If

    End Sub

    Sub write
        If flag_scr_mode = &H0 or flag_tx_gbox_prst = &H0 or flag_tx_gbox_err_det_clr = &H0 or flag_tx_gbox_afrst_en = &H0 or flag_fec_enable = &H0 or flag_tx_gbox_errdet_sel = &H0 or flag_cl49_tx_li_enable = &H0 or flag_cl49_tx_lf_enable = &H0 or flag_cl49_tx_rf_enable = &H0 or flag_tx_fifo_watermark = &H0 or flag_rstb_tx_lane = &H0 or flag_enable_tx_lane = &H0 Then read
        If flag_scr_mode = &H0 Then write_scr_mode_value = get_scr_mode
        If flag_tx_gbox_prst = &H0 Then write_tx_gbox_prst_value = get_tx_gbox_prst
        If flag_tx_gbox_err_det_clr = &H0 Then write_tx_gbox_err_det_clr_value = get_tx_gbox_err_det_clr
        If flag_tx_gbox_afrst_en = &H0 Then write_tx_gbox_afrst_en_value = get_tx_gbox_afrst_en
        If flag_fec_enable = &H0 Then write_fec_enable_value = get_fec_enable
        If flag_tx_gbox_errdet_sel = &H0 Then write_tx_gbox_errdet_sel_value = get_tx_gbox_errdet_sel
        If flag_cl49_tx_li_enable = &H0 Then write_cl49_tx_li_enable_value = get_cl49_tx_li_enable
        If flag_cl49_tx_lf_enable = &H0 Then write_cl49_tx_lf_enable_value = get_cl49_tx_lf_enable
        If flag_cl49_tx_rf_enable = &H0 Then write_cl49_tx_rf_enable_value = get_cl49_tx_rf_enable
        If flag_tx_fifo_watermark = &H0 Then write_tx_fifo_watermark_value = get_tx_fifo_watermark
        If flag_rstb_tx_lane = &H0 Then write_rstb_tx_lane_value = get_rstb_tx_lane
        If flag_enable_tx_lane = &H0 Then write_enable_tx_lane_value = get_enable_tx_lane

        regValue = leftShift((write_scr_mode_value and &H3), 14) + leftShift((write_tx_gbox_prst_value and &H1), 13) + leftShift((write_tx_gbox_err_det_clr_value and &H1), 12) + leftShift((write_tx_gbox_afrst_en_value and &H1), 11) + leftShift((write_fec_enable_value and &H1), 10) + leftShift((write_tx_gbox_errdet_sel_value and &H1), 9) + leftShift((write_cl49_tx_li_enable_value and &H1), 8) + leftShift((write_cl49_tx_lf_enable_value and &H1), 7) + leftShift((write_cl49_tx_rf_enable_value and &H1), 6) + leftShift((write_tx_fifo_watermark_value and &H3), 2) + leftShift((write_rstb_tx_lane_value and &H1), 1) + leftShift((write_enable_tx_lane_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_scr_mode_value = rightShift(data_low, 14) and &H3
        read_tx_gbox_prst_value = rightShift(data_low, 13) and &H1
        read_tx_gbox_err_det_clr_value = rightShift(data_low, 12) and &H1
        read_tx_gbox_afrst_en_value = rightShift(data_low, 11) and &H1
        read_fec_enable_value = rightShift(data_low, 10) and &H1
        read_tx_gbox_errdet_sel_value = rightShift(data_low, 9) and &H1
        read_cl49_tx_li_enable_value = rightShift(data_low, 8) and &H1
        read_cl49_tx_lf_enable_value = rightShift(data_low, 7) and &H1
        read_cl49_tx_rf_enable_value = rightShift(data_low, 6) and &H1
        read_tx_fifo_watermark_value = rightShift(data_low, 2) and &H3
        read_rstb_tx_lane_value = rightShift(data_low, 1) and &H1
        enable_tx_lane_mask = &H1
        if data_low > LONG_MAX then
            if enable_tx_lane_mask = mask then
                read_enable_tx_lane_value = data_low
            else
                read_enable_tx_lane_value = (data_low - H8000_0000) and enable_tx_lane_mask
            end If
        else
            read_enable_tx_lane_value = data_low and enable_tx_lane_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scr_mode_value = &H0
        flag_scr_mode        = &H0
        write_tx_gbox_prst_value = &H0
        flag_tx_gbox_prst        = &H0
        write_tx_gbox_err_det_clr_value = &H0
        flag_tx_gbox_err_det_clr        = &H0
        write_tx_gbox_afrst_en_value = &H0
        flag_tx_gbox_afrst_en        = &H0
        write_fec_enable_value = &H0
        flag_fec_enable        = &H0
        write_tx_gbox_errdet_sel_value = &H0
        flag_tx_gbox_errdet_sel        = &H0
        write_cl49_tx_li_enable_value = &H0
        flag_cl49_tx_li_enable        = &H0
        write_cl49_tx_lf_enable_value = &H0
        flag_cl49_tx_lf_enable        = &H0
        write_cl49_tx_rf_enable_value = &H0
        flag_cl49_tx_rf_enable        = &H0
        write_tx_fifo_watermark_value = &H0
        flag_tx_fifo_watermark        = &H0
        write_rstb_tx_lane_value = &H0
        flag_rstb_tx_lane        = &H0
        write_enable_tx_lane_value = &H0
        flag_enable_tx_lane        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_CONTROL0_SGMIIPLUSR_X1_cl36_tx_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' disable_TRRR_tx                            [4:4]            get_disable_TRRR_tx
''                                                             set_disable_TRRR_tx
''                                                             read_disable_TRRR_tx
''                                                             write_disable_TRRR_tx
''---------------------------------------------------------------------------------
'' enable_sfd_detect                          [3:3]            get_enable_sfd_detect
''                                                             set_enable_sfd_detect
''                                                             read_enable_sfd_detect
''                                                             write_enable_sfd_detect
''---------------------------------------------------------------------------------
'' disable_packet_misalign                    [2:2]            get_disable_packet_misalign
''                                                             set_disable_packet_misalign
''                                                             read_disable_packet_misalign
''                                                             write_disable_packet_misalign
''---------------------------------------------------------------------------------
Class REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_cl36_tx_0
    Private write_disable_TRRR_tx_value
    Private read_disable_TRRR_tx_value
    Private flag_disable_TRRR_tx
    Private write_enable_sfd_detect_value
    Private read_enable_sfd_detect_value
    Private flag_enable_sfd_detect
    Private write_disable_packet_misalign_value
    Private read_disable_packet_misalign_value
    Private flag_disable_packet_misalign

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

    Property Get get_disable_TRRR_tx
        get_disable_TRRR_tx = read_disable_TRRR_tx_value
    End Property

    Property Let set_disable_TRRR_tx(aData)
        write_disable_TRRR_tx_value = aData
        flag_disable_TRRR_tx        = &H1
    End Property

    Property Get read_disable_TRRR_tx
        read
        read_disable_TRRR_tx = read_disable_TRRR_tx_value
    End Property

    Property Let write_disable_TRRR_tx(aData)
        set_disable_TRRR_tx = aData
        write
    End Property

    Property Get get_enable_sfd_detect
        get_enable_sfd_detect = read_enable_sfd_detect_value
    End Property

    Property Let set_enable_sfd_detect(aData)
        write_enable_sfd_detect_value = aData
        flag_enable_sfd_detect        = &H1
    End Property

    Property Get read_enable_sfd_detect
        read
        read_enable_sfd_detect = read_enable_sfd_detect_value
    End Property

    Property Let write_enable_sfd_detect(aData)
        set_enable_sfd_detect = aData
        write
    End Property

    Property Get get_disable_packet_misalign
        get_disable_packet_misalign = read_disable_packet_misalign_value
    End Property

    Property Let set_disable_packet_misalign(aData)
        write_disable_packet_misalign_value = aData
        flag_disable_packet_misalign        = &H1
    End Property

    Property Get read_disable_packet_misalign
        read
        read_disable_packet_misalign = read_disable_packet_misalign_value
    End Property

    Property Let write_disable_packet_misalign(aData)
        set_disable_packet_misalign = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_disable_TRRR_tx_value = rightShift(data_low, 4) and &H1
        read_enable_sfd_detect_value = rightShift(data_low, 3) and &H1
        read_disable_packet_misalign_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_disable_TRRR_tx = &H0 or flag_enable_sfd_detect = &H0 or flag_disable_packet_misalign = &H0 Then read
        If flag_disable_TRRR_tx = &H0 Then write_disable_TRRR_tx_value = get_disable_TRRR_tx
        If flag_enable_sfd_detect = &H0 Then write_enable_sfd_detect_value = get_enable_sfd_detect
        If flag_disable_packet_misalign = &H0 Then write_disable_packet_misalign_value = get_disable_packet_misalign

        regValue = leftShift((write_disable_TRRR_tx_value and &H1), 4) + leftShift((write_enable_sfd_detect_value and &H1), 3) + leftShift((write_disable_packet_misalign_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_disable_TRRR_tx_value = rightShift(data_low, 4) and &H1
        read_enable_sfd_detect_value = rightShift(data_low, 3) and &H1
        read_disable_packet_misalign_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_disable_TRRR_tx_value = &H0
        flag_disable_TRRR_tx        = &H0
        write_enable_sfd_detect_value = &H0
        flag_enable_sfd_detect        = &H0
        write_disable_packet_misalign_value = &H0
        flag_disable_packet_misalign        = &H0
    End Sub
End Class


'' @REGISTER : TX_X4_CONTROL0_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_blockaddress
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

Class TX_X4_CONTROL0_SGMIIPLUSR_X1_INSTANCE

    Public encode_0
    Public encode_1
    Public misc
    Public cl36_tx_0
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set encode_0 = (New REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_encode_0)(aBaseAddr, 16)
        Set encode_1 = (New REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_encode_1)(aBaseAddr, 16)
        Set misc = (New REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_misc)(aBaseAddr, 16)
        Set cl36_tx_0 = (New REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_cl36_tx_0)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_X4_CONTROL0_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_X4_CONTROL0_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_X4_CONTROL0_SGMIIPLUSR_X1.Add ((New TX_X4_CONTROL0_SGMIIPLUSR_X1_INSTANCE)(&H4aed8860))


