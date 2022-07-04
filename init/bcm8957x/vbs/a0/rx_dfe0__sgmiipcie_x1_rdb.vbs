

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


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' status                                     [15:0]           get_status
''                                                             set_status
''                                                             read_status
''                                                             write_status
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_status
    Private write_status_value
    Private read_status_value
    Private flag_status

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

    Property Get get_status
        get_status = read_status_value
    End Property

    Property Let set_status(aData)
        write_status_value = aData
        flag_status        = &H1
    End Property

    Property Get read_status
        read
        read_status = read_status_value
    End Property

    Property Let write_status(aData)
        set_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status_mask = &Hffff
        if data_low > LONG_MAX then
            if status_mask = mask then
                read_status_value = data_low
            else
                read_status_value = (data_low - H8000_0000) and status_mask
            end If
        else
            read_status_value = data_low and status_mask
        end If

    End Sub

    Sub write
        If flag_status = &H0 Then read
        If flag_status = &H0 Then write_status_value = get_status

        regValue = leftShift((write_status_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status_mask = &Hffff
        if data_low > LONG_MAX then
            if status_mask = mask then
                read_status_value = data_low
            else
                read_status_value = (data_low - H8000_0000) and status_mask
            end If
        else
            read_status_value = data_low and status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_status_value = &H0
        flag_status        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SeqRestart_SM                              [15:15]          get_SeqRestart_SM
''                                                             set_SeqRestart_SM
''                                                             read_SeqRestart_SM
''                                                             write_SeqRestart_SM
''---------------------------------------------------------------------------------
'' fast_acq_en_r                              [14:14]          get_fast_acq_en_r
''                                                             set_fast_acq_en_r
''                                                             read_fast_acq_en_r
''                                                             write_fast_acq_en_r
''---------------------------------------------------------------------------------
'' fast_acq_en_force_r                        [13:13]          get_fast_acq_en_force_r
''                                                             set_fast_acq_en_force_r
''                                                             read_fast_acq_en_force_r
''                                                             write_fast_acq_en_force_r
''---------------------------------------------------------------------------------
'' sigDetected_en_SM                          [12:12]          get_sigDetected_en_SM
''                                                             set_sigDetected_en_SM
''                                                             read_sigDetected_en_SM
''                                                             write_sigDetected_en_SM
''---------------------------------------------------------------------------------
'' sigdetRestart_en_SM                        [11:11]          get_sigdetRestart_en_SM
''                                                             set_sigdetRestart_en_SM
''                                                             read_sigdetRestart_en_SM
''                                                             write_sigdetRestart_en_SM
''---------------------------------------------------------------------------------
'' sigdetMonitor_en_SM                        [10:10]          get_sigdetMonitor_en_SM
''                                                             set_sigdetMonitor_en_SM
''                                                             read_sigdetMonitor_en_SM
''                                                             write_sigdetMonitor_en_SM
''---------------------------------------------------------------------------------
'' override_sigdet_en_SM                      [9:9]            get_override_sigdet_en_SM
''                                                             set_override_sigdet_en_SM
''                                                             read_override_sigdet_en_SM
''                                                             write_override_sigdet_en_SM
''---------------------------------------------------------------------------------
'' override_sigdet_val_SM                     [8:8]            get_override_sigdet_val_SM
''                                                             set_override_sigdet_val_SM
''                                                             read_override_sigdet_val_SM
''                                                             write_override_sigdet_val_SM
''---------------------------------------------------------------------------------
'' sigdet_cnt_clr                             [7:7]            get_sigdet_cnt_clr
''                                                             set_sigdet_cnt_clr
''                                                             read_sigdet_cnt_clr
''                                                             write_sigdet_cnt_clr
''---------------------------------------------------------------------------------
'' phfreq_rst_dis_fst_SM                      [6:6]            get_phfreq_rst_dis_fst_SM
''                                                             set_phfreq_rst_dis_fst_SM
''                                                             read_phfreq_rst_dis_fst_SM
''                                                             write_phfreq_rst_dis_fst_SM
''---------------------------------------------------------------------------------
'' phfreq_rst_dis_nrml_SM                     [5:5]            get_phfreq_rst_dis_nrml_SM
''                                                             set_phfreq_rst_dis_nrml_SM
''                                                             read_phfreq_rst_dis_nrml_SM
''                                                             write_phfreq_rst_dis_nrml_SM
''---------------------------------------------------------------------------------
'' forceRxSeqDone_SM                          [4:4]            get_forceRxSeqDone_SM
''                                                             set_forceRxSeqDone_SM
''                                                             read_forceRxSeqDone_SM
''                                                             write_forceRxSeqDone_SM
''---------------------------------------------------------------------------------
'' sigdet_cnt_stky                            [3:3]            get_sigdet_cnt_stky
''                                                             set_sigdet_cnt_stky
''                                                             read_sigdet_cnt_stky
''                                                             write_sigdet_cnt_stky
''---------------------------------------------------------------------------------
'' StatusSel_SM                               [2:0]            get_StatusSel_SM
''                                                             set_StatusSel_SM
''                                                             read_StatusSel_SM
''                                                             write_StatusSel_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_control
    Private write_SeqRestart_SM_value
    Private read_SeqRestart_SM_value
    Private flag_SeqRestart_SM
    Private write_fast_acq_en_r_value
    Private read_fast_acq_en_r_value
    Private flag_fast_acq_en_r
    Private write_fast_acq_en_force_r_value
    Private read_fast_acq_en_force_r_value
    Private flag_fast_acq_en_force_r
    Private write_sigDetected_en_SM_value
    Private read_sigDetected_en_SM_value
    Private flag_sigDetected_en_SM
    Private write_sigdetRestart_en_SM_value
    Private read_sigdetRestart_en_SM_value
    Private flag_sigdetRestart_en_SM
    Private write_sigdetMonitor_en_SM_value
    Private read_sigdetMonitor_en_SM_value
    Private flag_sigdetMonitor_en_SM
    Private write_override_sigdet_en_SM_value
    Private read_override_sigdet_en_SM_value
    Private flag_override_sigdet_en_SM
    Private write_override_sigdet_val_SM_value
    Private read_override_sigdet_val_SM_value
    Private flag_override_sigdet_val_SM
    Private write_sigdet_cnt_clr_value
    Private read_sigdet_cnt_clr_value
    Private flag_sigdet_cnt_clr
    Private write_phfreq_rst_dis_fst_SM_value
    Private read_phfreq_rst_dis_fst_SM_value
    Private flag_phfreq_rst_dis_fst_SM
    Private write_phfreq_rst_dis_nrml_SM_value
    Private read_phfreq_rst_dis_nrml_SM_value
    Private flag_phfreq_rst_dis_nrml_SM
    Private write_forceRxSeqDone_SM_value
    Private read_forceRxSeqDone_SM_value
    Private flag_forceRxSeqDone_SM
    Private write_sigdet_cnt_stky_value
    Private read_sigdet_cnt_stky_value
    Private flag_sigdet_cnt_stky
    Private write_StatusSel_SM_value
    Private read_StatusSel_SM_value
    Private flag_StatusSel_SM

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

    Property Get get_SeqRestart_SM
        get_SeqRestart_SM = read_SeqRestart_SM_value
    End Property

    Property Let set_SeqRestart_SM(aData)
        write_SeqRestart_SM_value = aData
        flag_SeqRestart_SM        = &H1
    End Property

    Property Get read_SeqRestart_SM
        read
        read_SeqRestart_SM = read_SeqRestart_SM_value
    End Property

    Property Let write_SeqRestart_SM(aData)
        set_SeqRestart_SM = aData
        write
    End Property

    Property Get get_fast_acq_en_r
        get_fast_acq_en_r = read_fast_acq_en_r_value
    End Property

    Property Let set_fast_acq_en_r(aData)
        write_fast_acq_en_r_value = aData
        flag_fast_acq_en_r        = &H1
    End Property

    Property Get read_fast_acq_en_r
        read
        read_fast_acq_en_r = read_fast_acq_en_r_value
    End Property

    Property Let write_fast_acq_en_r(aData)
        set_fast_acq_en_r = aData
        write
    End Property

    Property Get get_fast_acq_en_force_r
        get_fast_acq_en_force_r = read_fast_acq_en_force_r_value
    End Property

    Property Let set_fast_acq_en_force_r(aData)
        write_fast_acq_en_force_r_value = aData
        flag_fast_acq_en_force_r        = &H1
    End Property

    Property Get read_fast_acq_en_force_r
        read
        read_fast_acq_en_force_r = read_fast_acq_en_force_r_value
    End Property

    Property Let write_fast_acq_en_force_r(aData)
        set_fast_acq_en_force_r = aData
        write
    End Property

    Property Get get_sigDetected_en_SM
        get_sigDetected_en_SM = read_sigDetected_en_SM_value
    End Property

    Property Let set_sigDetected_en_SM(aData)
        write_sigDetected_en_SM_value = aData
        flag_sigDetected_en_SM        = &H1
    End Property

    Property Get read_sigDetected_en_SM
        read
        read_sigDetected_en_SM = read_sigDetected_en_SM_value
    End Property

    Property Let write_sigDetected_en_SM(aData)
        set_sigDetected_en_SM = aData
        write
    End Property

    Property Get get_sigdetRestart_en_SM
        get_sigdetRestart_en_SM = read_sigdetRestart_en_SM_value
    End Property

    Property Let set_sigdetRestart_en_SM(aData)
        write_sigdetRestart_en_SM_value = aData
        flag_sigdetRestart_en_SM        = &H1
    End Property

    Property Get read_sigdetRestart_en_SM
        read
        read_sigdetRestart_en_SM = read_sigdetRestart_en_SM_value
    End Property

    Property Let write_sigdetRestart_en_SM(aData)
        set_sigdetRestart_en_SM = aData
        write
    End Property

    Property Get get_sigdetMonitor_en_SM
        get_sigdetMonitor_en_SM = read_sigdetMonitor_en_SM_value
    End Property

    Property Let set_sigdetMonitor_en_SM(aData)
        write_sigdetMonitor_en_SM_value = aData
        flag_sigdetMonitor_en_SM        = &H1
    End Property

    Property Get read_sigdetMonitor_en_SM
        read
        read_sigdetMonitor_en_SM = read_sigdetMonitor_en_SM_value
    End Property

    Property Let write_sigdetMonitor_en_SM(aData)
        set_sigdetMonitor_en_SM = aData
        write
    End Property

    Property Get get_override_sigdet_en_SM
        get_override_sigdet_en_SM = read_override_sigdet_en_SM_value
    End Property

    Property Let set_override_sigdet_en_SM(aData)
        write_override_sigdet_en_SM_value = aData
        flag_override_sigdet_en_SM        = &H1
    End Property

    Property Get read_override_sigdet_en_SM
        read
        read_override_sigdet_en_SM = read_override_sigdet_en_SM_value
    End Property

    Property Let write_override_sigdet_en_SM(aData)
        set_override_sigdet_en_SM = aData
        write
    End Property

    Property Get get_override_sigdet_val_SM
        get_override_sigdet_val_SM = read_override_sigdet_val_SM_value
    End Property

    Property Let set_override_sigdet_val_SM(aData)
        write_override_sigdet_val_SM_value = aData
        flag_override_sigdet_val_SM        = &H1
    End Property

    Property Get read_override_sigdet_val_SM
        read
        read_override_sigdet_val_SM = read_override_sigdet_val_SM_value
    End Property

    Property Let write_override_sigdet_val_SM(aData)
        set_override_sigdet_val_SM = aData
        write
    End Property

    Property Get get_sigdet_cnt_clr
        get_sigdet_cnt_clr = read_sigdet_cnt_clr_value
    End Property

    Property Let set_sigdet_cnt_clr(aData)
        write_sigdet_cnt_clr_value = aData
        flag_sigdet_cnt_clr        = &H1
    End Property

    Property Get read_sigdet_cnt_clr
        read
        read_sigdet_cnt_clr = read_sigdet_cnt_clr_value
    End Property

    Property Let write_sigdet_cnt_clr(aData)
        set_sigdet_cnt_clr = aData
        write
    End Property

    Property Get get_phfreq_rst_dis_fst_SM
        get_phfreq_rst_dis_fst_SM = read_phfreq_rst_dis_fst_SM_value
    End Property

    Property Let set_phfreq_rst_dis_fst_SM(aData)
        write_phfreq_rst_dis_fst_SM_value = aData
        flag_phfreq_rst_dis_fst_SM        = &H1
    End Property

    Property Get read_phfreq_rst_dis_fst_SM
        read
        read_phfreq_rst_dis_fst_SM = read_phfreq_rst_dis_fst_SM_value
    End Property

    Property Let write_phfreq_rst_dis_fst_SM(aData)
        set_phfreq_rst_dis_fst_SM = aData
        write
    End Property

    Property Get get_phfreq_rst_dis_nrml_SM
        get_phfreq_rst_dis_nrml_SM = read_phfreq_rst_dis_nrml_SM_value
    End Property

    Property Let set_phfreq_rst_dis_nrml_SM(aData)
        write_phfreq_rst_dis_nrml_SM_value = aData
        flag_phfreq_rst_dis_nrml_SM        = &H1
    End Property

    Property Get read_phfreq_rst_dis_nrml_SM
        read
        read_phfreq_rst_dis_nrml_SM = read_phfreq_rst_dis_nrml_SM_value
    End Property

    Property Let write_phfreq_rst_dis_nrml_SM(aData)
        set_phfreq_rst_dis_nrml_SM = aData
        write
    End Property

    Property Get get_forceRxSeqDone_SM
        get_forceRxSeqDone_SM = read_forceRxSeqDone_SM_value
    End Property

    Property Let set_forceRxSeqDone_SM(aData)
        write_forceRxSeqDone_SM_value = aData
        flag_forceRxSeqDone_SM        = &H1
    End Property

    Property Get read_forceRxSeqDone_SM
        read
        read_forceRxSeqDone_SM = read_forceRxSeqDone_SM_value
    End Property

    Property Let write_forceRxSeqDone_SM(aData)
        set_forceRxSeqDone_SM = aData
        write
    End Property

    Property Get get_sigdet_cnt_stky
        get_sigdet_cnt_stky = read_sigdet_cnt_stky_value
    End Property

    Property Let set_sigdet_cnt_stky(aData)
        write_sigdet_cnt_stky_value = aData
        flag_sigdet_cnt_stky        = &H1
    End Property

    Property Get read_sigdet_cnt_stky
        read
        read_sigdet_cnt_stky = read_sigdet_cnt_stky_value
    End Property

    Property Let write_sigdet_cnt_stky(aData)
        set_sigdet_cnt_stky = aData
        write
    End Property

    Property Get get_StatusSel_SM
        get_StatusSel_SM = read_StatusSel_SM_value
    End Property

    Property Let set_StatusSel_SM(aData)
        write_StatusSel_SM_value = aData
        flag_StatusSel_SM        = &H1
    End Property

    Property Get read_StatusSel_SM
        read
        read_StatusSel_SM = read_StatusSel_SM_value
    End Property

    Property Let write_StatusSel_SM(aData)
        set_StatusSel_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SeqRestart_SM_value = rightShift(data_low, 15) and &H1
        read_fast_acq_en_r_value = rightShift(data_low, 14) and &H1
        read_fast_acq_en_force_r_value = rightShift(data_low, 13) and &H1
        read_sigDetected_en_SM_value = rightShift(data_low, 12) and &H1
        read_sigdetRestart_en_SM_value = rightShift(data_low, 11) and &H1
        read_sigdetMonitor_en_SM_value = rightShift(data_low, 10) and &H1
        read_override_sigdet_en_SM_value = rightShift(data_low, 9) and &H1
        read_override_sigdet_val_SM_value = rightShift(data_low, 8) and &H1
        read_sigdet_cnt_clr_value = rightShift(data_low, 7) and &H1
        read_phfreq_rst_dis_fst_SM_value = rightShift(data_low, 6) and &H1
        read_phfreq_rst_dis_nrml_SM_value = rightShift(data_low, 5) and &H1
        read_forceRxSeqDone_SM_value = rightShift(data_low, 4) and &H1
        read_sigdet_cnt_stky_value = rightShift(data_low, 3) and &H1
        StatusSel_SM_mask = &H7
        if data_low > LONG_MAX then
            if StatusSel_SM_mask = mask then
                read_StatusSel_SM_value = data_low
            else
                read_StatusSel_SM_value = (data_low - H8000_0000) and StatusSel_SM_mask
            end If
        else
            read_StatusSel_SM_value = data_low and StatusSel_SM_mask
        end If

    End Sub

    Sub write
        If flag_SeqRestart_SM = &H0 or flag_fast_acq_en_r = &H0 or flag_fast_acq_en_force_r = &H0 or flag_sigDetected_en_SM = &H0 or flag_sigdetRestart_en_SM = &H0 or flag_sigdetMonitor_en_SM = &H0 or flag_override_sigdet_en_SM = &H0 or flag_override_sigdet_val_SM = &H0 or flag_sigdet_cnt_clr = &H0 or flag_phfreq_rst_dis_fst_SM = &H0 or flag_phfreq_rst_dis_nrml_SM = &H0 or flag_forceRxSeqDone_SM = &H0 or flag_sigdet_cnt_stky = &H0 or flag_StatusSel_SM = &H0 Then read
        If flag_SeqRestart_SM = &H0 Then write_SeqRestart_SM_value = get_SeqRestart_SM
        If flag_fast_acq_en_r = &H0 Then write_fast_acq_en_r_value = get_fast_acq_en_r
        If flag_fast_acq_en_force_r = &H0 Then write_fast_acq_en_force_r_value = get_fast_acq_en_force_r
        If flag_sigDetected_en_SM = &H0 Then write_sigDetected_en_SM_value = get_sigDetected_en_SM
        If flag_sigdetRestart_en_SM = &H0 Then write_sigdetRestart_en_SM_value = get_sigdetRestart_en_SM
        If flag_sigdetMonitor_en_SM = &H0 Then write_sigdetMonitor_en_SM_value = get_sigdetMonitor_en_SM
        If flag_override_sigdet_en_SM = &H0 Then write_override_sigdet_en_SM_value = get_override_sigdet_en_SM
        If flag_override_sigdet_val_SM = &H0 Then write_override_sigdet_val_SM_value = get_override_sigdet_val_SM
        If flag_sigdet_cnt_clr = &H0 Then write_sigdet_cnt_clr_value = get_sigdet_cnt_clr
        If flag_phfreq_rst_dis_fst_SM = &H0 Then write_phfreq_rst_dis_fst_SM_value = get_phfreq_rst_dis_fst_SM
        If flag_phfreq_rst_dis_nrml_SM = &H0 Then write_phfreq_rst_dis_nrml_SM_value = get_phfreq_rst_dis_nrml_SM
        If flag_forceRxSeqDone_SM = &H0 Then write_forceRxSeqDone_SM_value = get_forceRxSeqDone_SM
        If flag_sigdet_cnt_stky = &H0 Then write_sigdet_cnt_stky_value = get_sigdet_cnt_stky
        If flag_StatusSel_SM = &H0 Then write_StatusSel_SM_value = get_StatusSel_SM

        regValue = leftShift((write_SeqRestart_SM_value and &H1), 15) + leftShift((write_fast_acq_en_r_value and &H1), 14) + leftShift((write_fast_acq_en_force_r_value and &H1), 13) + leftShift((write_sigDetected_en_SM_value and &H1), 12) + leftShift((write_sigdetRestart_en_SM_value and &H1), 11) + leftShift((write_sigdetMonitor_en_SM_value and &H1), 10) + leftShift((write_override_sigdet_en_SM_value and &H1), 9) + leftShift((write_override_sigdet_val_SM_value and &H1), 8) + leftShift((write_sigdet_cnt_clr_value and &H1), 7) + leftShift((write_phfreq_rst_dis_fst_SM_value and &H1), 6) + leftShift((write_phfreq_rst_dis_nrml_SM_value and &H1), 5) + leftShift((write_forceRxSeqDone_SM_value and &H1), 4) + leftShift((write_sigdet_cnt_stky_value and &H1), 3) + leftShift((write_StatusSel_SM_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SeqRestart_SM_value = rightShift(data_low, 15) and &H1
        read_fast_acq_en_r_value = rightShift(data_low, 14) and &H1
        read_fast_acq_en_force_r_value = rightShift(data_low, 13) and &H1
        read_sigDetected_en_SM_value = rightShift(data_low, 12) and &H1
        read_sigdetRestart_en_SM_value = rightShift(data_low, 11) and &H1
        read_sigdetMonitor_en_SM_value = rightShift(data_low, 10) and &H1
        read_override_sigdet_en_SM_value = rightShift(data_low, 9) and &H1
        read_override_sigdet_val_SM_value = rightShift(data_low, 8) and &H1
        read_sigdet_cnt_clr_value = rightShift(data_low, 7) and &H1
        read_phfreq_rst_dis_fst_SM_value = rightShift(data_low, 6) and &H1
        read_phfreq_rst_dis_nrml_SM_value = rightShift(data_low, 5) and &H1
        read_forceRxSeqDone_SM_value = rightShift(data_low, 4) and &H1
        read_sigdet_cnt_stky_value = rightShift(data_low, 3) and &H1
        StatusSel_SM_mask = &H7
        if data_low > LONG_MAX then
            if StatusSel_SM_mask = mask then
                read_StatusSel_SM_value = data_low
            else
                read_StatusSel_SM_value = (data_low - H8000_0000) and StatusSel_SM_mask
            end If
        else
            read_StatusSel_SM_value = data_low and StatusSel_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SeqRestart_SM_value = &H0
        flag_SeqRestart_SM        = &H0
        write_fast_acq_en_r_value = &H0
        flag_fast_acq_en_r        = &H0
        write_fast_acq_en_force_r_value = &H0
        flag_fast_acq_en_force_r        = &H0
        write_sigDetected_en_SM_value = &H0
        flag_sigDetected_en_SM        = &H0
        write_sigdetRestart_en_SM_value = &H0
        flag_sigdetRestart_en_SM        = &H0
        write_sigdetMonitor_en_SM_value = &H0
        flag_sigdetMonitor_en_SM        = &H0
        write_override_sigdet_en_SM_value = &H0
        flag_override_sigdet_en_SM        = &H0
        write_override_sigdet_val_SM_value = &H0
        flag_override_sigdet_val_SM        = &H0
        write_sigdet_cnt_clr_value = &H0
        flag_sigdet_cnt_clr        = &H0
        write_phfreq_rst_dis_fst_SM_value = &H0
        flag_phfreq_rst_dis_fst_SM        = &H0
        write_phfreq_rst_dis_nrml_SM_value = &H0
        flag_phfreq_rst_dis_nrml_SM        = &H0
        write_forceRxSeqDone_SM_value = &H0
        flag_forceRxSeqDone_SM        = &H0
        write_sigdet_cnt_stky_value = &H0
        flag_sigdet_cnt_stky        = &H0
        write_StatusSel_SM_value = &H0
        flag_StatusSel_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_timer1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' forceDecodeOn_SM                           [14:14]          get_forceDecodeOn_SM
''                                                             set_forceDecodeOn_SM
''                                                             read_forceDecodeOn_SM
''                                                             write_forceDecodeOn_SM
''---------------------------------------------------------------------------------
'' phsacq_comclk_enable                       [13:13]          get_phsacq_comclk_enable
''                                                             set_phsacq_comclk_enable
''                                                             read_phsacq_comclk_enable
''                                                             write_phsacq_comclk_enable
''---------------------------------------------------------------------------------
'' phsacq_en_fst                              [12:12]          get_phsacq_en_fst
''                                                             set_phsacq_en_fst
''                                                             read_phsacq_en_fst
''                                                             write_phsacq_en_fst
''---------------------------------------------------------------------------------
'' phsacq_dir                                 [11:11]          get_phsacq_dir
''                                                             set_phsacq_dir
''                                                             read_phsacq_dir
''                                                             write_phsacq_dir
''---------------------------------------------------------------------------------
'' phsacq_freq_sel0                           [10:10]          get_phsacq_freq_sel0
''                                                             set_phsacq_freq_sel0
''                                                             read_phsacq_freq_sel0
''                                                             write_phsacq_freq_sel0
''---------------------------------------------------------------------------------
'' phsacq_freq_sel1                           [9:9]            get_phsacq_freq_sel1
''                                                             set_phsacq_freq_sel1
''                                                             read_phsacq_freq_sel1
''                                                             write_phsacq_freq_sel1
''---------------------------------------------------------------------------------
'' phsacq_step                                [8:8]            get_phsacq_step
''                                                             set_phsacq_step
''                                                             read_phsacq_step
''                                                             write_phsacq_step
''---------------------------------------------------------------------------------
'' phsacq_timeout                             [7:0]            get_phsacq_timeout
''                                                             set_phsacq_timeout
''                                                             read_phsacq_timeout
''                                                             write_phsacq_timeout
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_timer1
    Private write_forceDecodeOn_SM_value
    Private read_forceDecodeOn_SM_value
    Private flag_forceDecodeOn_SM
    Private write_phsacq_comclk_enable_value
    Private read_phsacq_comclk_enable_value
    Private flag_phsacq_comclk_enable
    Private write_phsacq_en_fst_value
    Private read_phsacq_en_fst_value
    Private flag_phsacq_en_fst
    Private write_phsacq_dir_value
    Private read_phsacq_dir_value
    Private flag_phsacq_dir
    Private write_phsacq_freq_sel0_value
    Private read_phsacq_freq_sel0_value
    Private flag_phsacq_freq_sel0
    Private write_phsacq_freq_sel1_value
    Private read_phsacq_freq_sel1_value
    Private flag_phsacq_freq_sel1
    Private write_phsacq_step_value
    Private read_phsacq_step_value
    Private flag_phsacq_step
    Private write_phsacq_timeout_value
    Private read_phsacq_timeout_value
    Private flag_phsacq_timeout

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

    Property Get get_forceDecodeOn_SM
        get_forceDecodeOn_SM = read_forceDecodeOn_SM_value
    End Property

    Property Let set_forceDecodeOn_SM(aData)
        write_forceDecodeOn_SM_value = aData
        flag_forceDecodeOn_SM        = &H1
    End Property

    Property Get read_forceDecodeOn_SM
        read
        read_forceDecodeOn_SM = read_forceDecodeOn_SM_value
    End Property

    Property Let write_forceDecodeOn_SM(aData)
        set_forceDecodeOn_SM = aData
        write
    End Property

    Property Get get_phsacq_comclk_enable
        get_phsacq_comclk_enable = read_phsacq_comclk_enable_value
    End Property

    Property Let set_phsacq_comclk_enable(aData)
        write_phsacq_comclk_enable_value = aData
        flag_phsacq_comclk_enable        = &H1
    End Property

    Property Get read_phsacq_comclk_enable
        read
        read_phsacq_comclk_enable = read_phsacq_comclk_enable_value
    End Property

    Property Let write_phsacq_comclk_enable(aData)
        set_phsacq_comclk_enable = aData
        write
    End Property

    Property Get get_phsacq_en_fst
        get_phsacq_en_fst = read_phsacq_en_fst_value
    End Property

    Property Let set_phsacq_en_fst(aData)
        write_phsacq_en_fst_value = aData
        flag_phsacq_en_fst        = &H1
    End Property

    Property Get read_phsacq_en_fst
        read
        read_phsacq_en_fst = read_phsacq_en_fst_value
    End Property

    Property Let write_phsacq_en_fst(aData)
        set_phsacq_en_fst = aData
        write
    End Property

    Property Get get_phsacq_dir
        get_phsacq_dir = read_phsacq_dir_value
    End Property

    Property Let set_phsacq_dir(aData)
        write_phsacq_dir_value = aData
        flag_phsacq_dir        = &H1
    End Property

    Property Get read_phsacq_dir
        read
        read_phsacq_dir = read_phsacq_dir_value
    End Property

    Property Let write_phsacq_dir(aData)
        set_phsacq_dir = aData
        write
    End Property

    Property Get get_phsacq_freq_sel0
        get_phsacq_freq_sel0 = read_phsacq_freq_sel0_value
    End Property

    Property Let set_phsacq_freq_sel0(aData)
        write_phsacq_freq_sel0_value = aData
        flag_phsacq_freq_sel0        = &H1
    End Property

    Property Get read_phsacq_freq_sel0
        read
        read_phsacq_freq_sel0 = read_phsacq_freq_sel0_value
    End Property

    Property Let write_phsacq_freq_sel0(aData)
        set_phsacq_freq_sel0 = aData
        write
    End Property

    Property Get get_phsacq_freq_sel1
        get_phsacq_freq_sel1 = read_phsacq_freq_sel1_value
    End Property

    Property Let set_phsacq_freq_sel1(aData)
        write_phsacq_freq_sel1_value = aData
        flag_phsacq_freq_sel1        = &H1
    End Property

    Property Get read_phsacq_freq_sel1
        read
        read_phsacq_freq_sel1 = read_phsacq_freq_sel1_value
    End Property

    Property Let write_phsacq_freq_sel1(aData)
        set_phsacq_freq_sel1 = aData
        write
    End Property

    Property Get get_phsacq_step
        get_phsacq_step = read_phsacq_step_value
    End Property

    Property Let set_phsacq_step(aData)
        write_phsacq_step_value = aData
        flag_phsacq_step        = &H1
    End Property

    Property Get read_phsacq_step
        read
        read_phsacq_step = read_phsacq_step_value
    End Property

    Property Let write_phsacq_step(aData)
        set_phsacq_step = aData
        write
    End Property

    Property Get get_phsacq_timeout
        get_phsacq_timeout = read_phsacq_timeout_value
    End Property

    Property Let set_phsacq_timeout(aData)
        write_phsacq_timeout_value = aData
        flag_phsacq_timeout        = &H1
    End Property

    Property Get read_phsacq_timeout
        read
        read_phsacq_timeout = read_phsacq_timeout_value
    End Property

    Property Let write_phsacq_timeout(aData)
        set_phsacq_timeout = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_forceDecodeOn_SM_value = rightShift(data_low, 14) and &H1
        read_phsacq_comclk_enable_value = rightShift(data_low, 13) and &H1
        read_phsacq_en_fst_value = rightShift(data_low, 12) and &H1
        read_phsacq_dir_value = rightShift(data_low, 11) and &H1
        read_phsacq_freq_sel0_value = rightShift(data_low, 10) and &H1
        read_phsacq_freq_sel1_value = rightShift(data_low, 9) and &H1
        read_phsacq_step_value = rightShift(data_low, 8) and &H1
        phsacq_timeout_mask = &Hff
        if data_low > LONG_MAX then
            if phsacq_timeout_mask = mask then
                read_phsacq_timeout_value = data_low
            else
                read_phsacq_timeout_value = (data_low - H8000_0000) and phsacq_timeout_mask
            end If
        else
            read_phsacq_timeout_value = data_low and phsacq_timeout_mask
        end If

    End Sub

    Sub write
        If flag_forceDecodeOn_SM = &H0 or flag_phsacq_comclk_enable = &H0 or flag_phsacq_en_fst = &H0 or flag_phsacq_dir = &H0 or flag_phsacq_freq_sel0 = &H0 or flag_phsacq_freq_sel1 = &H0 or flag_phsacq_step = &H0 or flag_phsacq_timeout = &H0 Then read
        If flag_forceDecodeOn_SM = &H0 Then write_forceDecodeOn_SM_value = get_forceDecodeOn_SM
        If flag_phsacq_comclk_enable = &H0 Then write_phsacq_comclk_enable_value = get_phsacq_comclk_enable
        If flag_phsacq_en_fst = &H0 Then write_phsacq_en_fst_value = get_phsacq_en_fst
        If flag_phsacq_dir = &H0 Then write_phsacq_dir_value = get_phsacq_dir
        If flag_phsacq_freq_sel0 = &H0 Then write_phsacq_freq_sel0_value = get_phsacq_freq_sel0
        If flag_phsacq_freq_sel1 = &H0 Then write_phsacq_freq_sel1_value = get_phsacq_freq_sel1
        If flag_phsacq_step = &H0 Then write_phsacq_step_value = get_phsacq_step
        If flag_phsacq_timeout = &H0 Then write_phsacq_timeout_value = get_phsacq_timeout

        regValue = leftShift((write_forceDecodeOn_SM_value and &H1), 14) + leftShift((write_phsacq_comclk_enable_value and &H1), 13) + leftShift((write_phsacq_en_fst_value and &H1), 12) + leftShift((write_phsacq_dir_value and &H1), 11) + leftShift((write_phsacq_freq_sel0_value and &H1), 10) + leftShift((write_phsacq_freq_sel1_value and &H1), 9) + leftShift((write_phsacq_step_value and &H1), 8) + leftShift((write_phsacq_timeout_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_forceDecodeOn_SM_value = rightShift(data_low, 14) and &H1
        read_phsacq_comclk_enable_value = rightShift(data_low, 13) and &H1
        read_phsacq_en_fst_value = rightShift(data_low, 12) and &H1
        read_phsacq_dir_value = rightShift(data_low, 11) and &H1
        read_phsacq_freq_sel0_value = rightShift(data_low, 10) and &H1
        read_phsacq_freq_sel1_value = rightShift(data_low, 9) and &H1
        read_phsacq_step_value = rightShift(data_low, 8) and &H1
        phsacq_timeout_mask = &Hff
        if data_low > LONG_MAX then
            if phsacq_timeout_mask = mask then
                read_phsacq_timeout_value = data_low
            else
                read_phsacq_timeout_value = (data_low - H8000_0000) and phsacq_timeout_mask
            end If
        else
            read_phsacq_timeout_value = data_low and phsacq_timeout_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_forceDecodeOn_SM_value = &H0
        flag_forceDecodeOn_SM        = &H0
        write_phsacq_comclk_enable_value = &H0
        flag_phsacq_comclk_enable        = &H0
        write_phsacq_en_fst_value = &H0
        flag_phsacq_en_fst        = &H0
        write_phsacq_dir_value = &H0
        flag_phsacq_dir        = &H0
        write_phsacq_freq_sel0_value = &H0
        flag_phsacq_freq_sel0        = &H0
        write_phsacq_freq_sel1_value = &H0
        flag_phsacq_freq_sel1        = &H0
        write_phsacq_step_value = &H0
        flag_phsacq_step        = &H0
        write_phsacq_timeout_value = &H0
        flag_phsacq_timeout        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_status2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' status2                                    [15:0]           get_status2
''                                                             set_status2
''                                                             read_status2
''                                                             write_status2
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_status2
    Private write_status2_value
    Private read_status2_value
    Private flag_status2

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

    Property Get get_status2
        get_status2 = read_status2_value
    End Property

    Property Let set_status2(aData)
        write_status2_value = aData
        flag_status2        = &H1
    End Property

    Property Get read_status2
        read
        read_status2 = read_status2_value
    End Property

    Property Let write_status2(aData)
        set_status2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status2_mask = &Hffff
        if data_low > LONG_MAX then
            if status2_mask = mask then
                read_status2_value = data_low
            else
                read_status2_value = (data_low - H8000_0000) and status2_mask
            end If
        else
            read_status2_value = data_low and status2_mask
        end If

    End Sub

    Sub write
        If flag_status2 = &H0 Then read
        If flag_status2 = &H0 Then write_status2_value = get_status2

        regValue = leftShift((write_status2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status2_mask = &Hffff
        if data_low > LONG_MAX then
            if status2_mask = mask then
                read_status2_value = data_low
            else
                read_status2_value = (data_low - H8000_0000) and status2_mask
            end If
        else
            read_status2_value = data_low and status2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_status2_value = &H0
        flag_status2        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_sigdet
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sigdetTime_SM                              [15:12]          get_sigdetTime_SM
''                                                             set_sigdetTime_SM
''                                                             read_sigdetTime_SM
''                                                             write_sigdetTime_SM
''---------------------------------------------------------------------------------
'' testMuxSelect_SM                           [11:8]           get_testMuxSelect_SM
''                                                             set_testMuxSelect_SM
''                                                             read_testMuxSelect_SM
''                                                             write_testMuxSelect_SM
''---------------------------------------------------------------------------------
'' tpctrl_SM0                                 [7:7]            get_tpctrl_SM0
''                                                             set_tpctrl_SM0
''                                                             read_tpctrl_SM0
''                                                             write_tpctrl_SM0
''---------------------------------------------------------------------------------
'' tpctrl_SM1                                 [6:4]            get_tpctrl_SM1
''                                                             set_tpctrl_SM1
''                                                             read_tpctrl_SM1
''                                                             write_tpctrl_SM1
''---------------------------------------------------------------------------------
'' StatusSel2_SM                              [2:0]            get_StatusSel2_SM
''                                                             set_StatusSel2_SM
''                                                             read_StatusSel2_SM
''                                                             write_StatusSel2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_sigdet
    Private write_sigdetTime_SM_value
    Private read_sigdetTime_SM_value
    Private flag_sigdetTime_SM
    Private write_testMuxSelect_SM_value
    Private read_testMuxSelect_SM_value
    Private flag_testMuxSelect_SM
    Private write_tpctrl_SM0_value
    Private read_tpctrl_SM0_value
    Private flag_tpctrl_SM0
    Private write_tpctrl_SM1_value
    Private read_tpctrl_SM1_value
    Private flag_tpctrl_SM1
    Private write_StatusSel2_SM_value
    Private read_StatusSel2_SM_value
    Private flag_StatusSel2_SM

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

    Property Get get_sigdetTime_SM
        get_sigdetTime_SM = read_sigdetTime_SM_value
    End Property

    Property Let set_sigdetTime_SM(aData)
        write_sigdetTime_SM_value = aData
        flag_sigdetTime_SM        = &H1
    End Property

    Property Get read_sigdetTime_SM
        read
        read_sigdetTime_SM = read_sigdetTime_SM_value
    End Property

    Property Let write_sigdetTime_SM(aData)
        set_sigdetTime_SM = aData
        write
    End Property

    Property Get get_testMuxSelect_SM
        get_testMuxSelect_SM = read_testMuxSelect_SM_value
    End Property

    Property Let set_testMuxSelect_SM(aData)
        write_testMuxSelect_SM_value = aData
        flag_testMuxSelect_SM        = &H1
    End Property

    Property Get read_testMuxSelect_SM
        read
        read_testMuxSelect_SM = read_testMuxSelect_SM_value
    End Property

    Property Let write_testMuxSelect_SM(aData)
        set_testMuxSelect_SM = aData
        write
    End Property

    Property Get get_tpctrl_SM0
        get_tpctrl_SM0 = read_tpctrl_SM0_value
    End Property

    Property Let set_tpctrl_SM0(aData)
        write_tpctrl_SM0_value = aData
        flag_tpctrl_SM0        = &H1
    End Property

    Property Get read_tpctrl_SM0
        read
        read_tpctrl_SM0 = read_tpctrl_SM0_value
    End Property

    Property Let write_tpctrl_SM0(aData)
        set_tpctrl_SM0 = aData
        write
    End Property

    Property Get get_tpctrl_SM1
        get_tpctrl_SM1 = read_tpctrl_SM1_value
    End Property

    Property Let set_tpctrl_SM1(aData)
        write_tpctrl_SM1_value = aData
        flag_tpctrl_SM1        = &H1
    End Property

    Property Get read_tpctrl_SM1
        read
        read_tpctrl_SM1 = read_tpctrl_SM1_value
    End Property

    Property Let write_tpctrl_SM1(aData)
        set_tpctrl_SM1 = aData
        write
    End Property

    Property Get get_StatusSel2_SM
        get_StatusSel2_SM = read_StatusSel2_SM_value
    End Property

    Property Let set_StatusSel2_SM(aData)
        write_StatusSel2_SM_value = aData
        flag_StatusSel2_SM        = &H1
    End Property

    Property Get read_StatusSel2_SM
        read
        read_StatusSel2_SM = read_StatusSel2_SM_value
    End Property

    Property Let write_StatusSel2_SM(aData)
        set_StatusSel2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdetTime_SM_value = rightShift(data_low, 12) and &Hf
        read_testMuxSelect_SM_value = rightShift(data_low, 8) and &Hf
        read_tpctrl_SM0_value = rightShift(data_low, 7) and &H1
        read_tpctrl_SM1_value = rightShift(data_low, 4) and &H7
        StatusSel2_SM_mask = &H7
        if data_low > LONG_MAX then
            if StatusSel2_SM_mask = mask then
                read_StatusSel2_SM_value = data_low
            else
                read_StatusSel2_SM_value = (data_low - H8000_0000) and StatusSel2_SM_mask
            end If
        else
            read_StatusSel2_SM_value = data_low and StatusSel2_SM_mask
        end If

    End Sub

    Sub write
        If flag_sigdetTime_SM = &H0 or flag_testMuxSelect_SM = &H0 or flag_tpctrl_SM0 = &H0 or flag_tpctrl_SM1 = &H0 or flag_StatusSel2_SM = &H0 Then read
        If flag_sigdetTime_SM = &H0 Then write_sigdetTime_SM_value = get_sigdetTime_SM
        If flag_testMuxSelect_SM = &H0 Then write_testMuxSelect_SM_value = get_testMuxSelect_SM
        If flag_tpctrl_SM0 = &H0 Then write_tpctrl_SM0_value = get_tpctrl_SM0
        If flag_tpctrl_SM1 = &H0 Then write_tpctrl_SM1_value = get_tpctrl_SM1
        If flag_StatusSel2_SM = &H0 Then write_StatusSel2_SM_value = get_StatusSel2_SM

        regValue = leftShift((write_sigdetTime_SM_value and &Hf), 12) + leftShift((write_testMuxSelect_SM_value and &Hf), 8) + leftShift((write_tpctrl_SM0_value and &H1), 7) + leftShift((write_tpctrl_SM1_value and &H7), 4) + leftShift((write_StatusSel2_SM_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdetTime_SM_value = rightShift(data_low, 12) and &Hf
        read_testMuxSelect_SM_value = rightShift(data_low, 8) and &Hf
        read_tpctrl_SM0_value = rightShift(data_low, 7) and &H1
        read_tpctrl_SM1_value = rightShift(data_low, 4) and &H7
        StatusSel2_SM_mask = &H7
        if data_low > LONG_MAX then
            if StatusSel2_SM_mask = mask then
                read_StatusSel2_SM_value = data_low
            else
                read_StatusSel2_SM_value = (data_low - H8000_0000) and StatusSel2_SM_mask
            end If
        else
            read_StatusSel2_SM_value = data_low and StatusSel2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sigdetTime_SM_value = &H0
        flag_sigdetTime_SM        = &H0
        write_testMuxSelect_SM_value = &H0
        flag_testMuxSelect_SM        = &H0
        write_tpctrl_SM0_value = &H0
        flag_tpctrl_SM0        = &H0
        write_tpctrl_SM1_value = &H0
        flag_tpctrl_SM1        = &H0
        write_StatusSel2_SM_value = &H0
        flag_StatusSel2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_cdr_phase
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' phase_freeze_en_SM                         [15:15]          get_phase_freeze_en_SM
''                                                             set_phase_freeze_en_SM
''                                                             read_phase_freeze_en_SM
''                                                             write_phase_freeze_en_SM
''---------------------------------------------------------------------------------
'' phase_freeze_val_SM                        [14:14]          get_phase_freeze_val_SM
''                                                             set_phase_freeze_val_SM
''                                                             read_phase_freeze_val_SM
''                                                             write_phase_freeze_val_SM
''---------------------------------------------------------------------------------
'' pi_phase_invert                            [11:11]          get_pi_phase_invert
''                                                             set_pi_phase_invert
''                                                             read_pi_phase_invert
''                                                             write_pi_phase_invert
''---------------------------------------------------------------------------------
'' pi_phase_rotate_ovrd                       [10:10]          get_pi_phase_rotate_ovrd
''                                                             set_pi_phase_rotate_ovrd
''                                                             read_pi_phase_rotate_ovrd
''                                                             write_pi_phase_rotate_ovrd
''---------------------------------------------------------------------------------
'' pi_clk90_offset_ovrd                       [9:9]            get_pi_clk90_offset_ovrd
''                                                             set_pi_clk90_offset_ovrd
''                                                             read_pi_clk90_offset_ovrd
''                                                             write_pi_clk90_offset_ovrd
''---------------------------------------------------------------------------------
'' phase_override_SM                          [8:8]            get_phase_override_SM
''                                                             set_phase_override_SM
''                                                             read_phase_override_SM
''                                                             write_phase_override_SM
''---------------------------------------------------------------------------------
'' phase_inc_SM                               [7:7]            get_phase_inc_SM
''                                                             set_phase_inc_SM
''                                                             read_phase_inc_SM
''                                                             write_phase_inc_SM
''---------------------------------------------------------------------------------
'' phase_dec_SM                               [6:6]            get_phase_dec_SM
''                                                             set_phase_dec_SM
''                                                             read_phase_dec_SM
''                                                             write_phase_dec_SM
''---------------------------------------------------------------------------------
'' phase_strobe_SM                            [5:5]            get_phase_strobe_SM
''                                                             set_phase_strobe_SM
''                                                             read_phase_strobe_SM
''                                                             write_phase_strobe_SM
''---------------------------------------------------------------------------------
'' phase_delta_SM                             [4:0]            get_phase_delta_SM
''                                                             set_phase_delta_SM
''                                                             read_phase_delta_SM
''                                                             write_phase_delta_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_cdr_phase
    Private write_phase_freeze_en_SM_value
    Private read_phase_freeze_en_SM_value
    Private flag_phase_freeze_en_SM
    Private write_phase_freeze_val_SM_value
    Private read_phase_freeze_val_SM_value
    Private flag_phase_freeze_val_SM
    Private write_pi_phase_invert_value
    Private read_pi_phase_invert_value
    Private flag_pi_phase_invert
    Private write_pi_phase_rotate_ovrd_value
    Private read_pi_phase_rotate_ovrd_value
    Private flag_pi_phase_rotate_ovrd
    Private write_pi_clk90_offset_ovrd_value
    Private read_pi_clk90_offset_ovrd_value
    Private flag_pi_clk90_offset_ovrd
    Private write_phase_override_SM_value
    Private read_phase_override_SM_value
    Private flag_phase_override_SM
    Private write_phase_inc_SM_value
    Private read_phase_inc_SM_value
    Private flag_phase_inc_SM
    Private write_phase_dec_SM_value
    Private read_phase_dec_SM_value
    Private flag_phase_dec_SM
    Private write_phase_strobe_SM_value
    Private read_phase_strobe_SM_value
    Private flag_phase_strobe_SM
    Private write_phase_delta_SM_value
    Private read_phase_delta_SM_value
    Private flag_phase_delta_SM

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

    Property Get get_phase_freeze_en_SM
        get_phase_freeze_en_SM = read_phase_freeze_en_SM_value
    End Property

    Property Let set_phase_freeze_en_SM(aData)
        write_phase_freeze_en_SM_value = aData
        flag_phase_freeze_en_SM        = &H1
    End Property

    Property Get read_phase_freeze_en_SM
        read
        read_phase_freeze_en_SM = read_phase_freeze_en_SM_value
    End Property

    Property Let write_phase_freeze_en_SM(aData)
        set_phase_freeze_en_SM = aData
        write
    End Property

    Property Get get_phase_freeze_val_SM
        get_phase_freeze_val_SM = read_phase_freeze_val_SM_value
    End Property

    Property Let set_phase_freeze_val_SM(aData)
        write_phase_freeze_val_SM_value = aData
        flag_phase_freeze_val_SM        = &H1
    End Property

    Property Get read_phase_freeze_val_SM
        read
        read_phase_freeze_val_SM = read_phase_freeze_val_SM_value
    End Property

    Property Let write_phase_freeze_val_SM(aData)
        set_phase_freeze_val_SM = aData
        write
    End Property

    Property Get get_pi_phase_invert
        get_pi_phase_invert = read_pi_phase_invert_value
    End Property

    Property Let set_pi_phase_invert(aData)
        write_pi_phase_invert_value = aData
        flag_pi_phase_invert        = &H1
    End Property

    Property Get read_pi_phase_invert
        read
        read_pi_phase_invert = read_pi_phase_invert_value
    End Property

    Property Let write_pi_phase_invert(aData)
        set_pi_phase_invert = aData
        write
    End Property

    Property Get get_pi_phase_rotate_ovrd
        get_pi_phase_rotate_ovrd = read_pi_phase_rotate_ovrd_value
    End Property

    Property Let set_pi_phase_rotate_ovrd(aData)
        write_pi_phase_rotate_ovrd_value = aData
        flag_pi_phase_rotate_ovrd        = &H1
    End Property

    Property Get read_pi_phase_rotate_ovrd
        read
        read_pi_phase_rotate_ovrd = read_pi_phase_rotate_ovrd_value
    End Property

    Property Let write_pi_phase_rotate_ovrd(aData)
        set_pi_phase_rotate_ovrd = aData
        write
    End Property

    Property Get get_pi_clk90_offset_ovrd
        get_pi_clk90_offset_ovrd = read_pi_clk90_offset_ovrd_value
    End Property

    Property Let set_pi_clk90_offset_ovrd(aData)
        write_pi_clk90_offset_ovrd_value = aData
        flag_pi_clk90_offset_ovrd        = &H1
    End Property

    Property Get read_pi_clk90_offset_ovrd
        read
        read_pi_clk90_offset_ovrd = read_pi_clk90_offset_ovrd_value
    End Property

    Property Let write_pi_clk90_offset_ovrd(aData)
        set_pi_clk90_offset_ovrd = aData
        write
    End Property

    Property Get get_phase_override_SM
        get_phase_override_SM = read_phase_override_SM_value
    End Property

    Property Let set_phase_override_SM(aData)
        write_phase_override_SM_value = aData
        flag_phase_override_SM        = &H1
    End Property

    Property Get read_phase_override_SM
        read
        read_phase_override_SM = read_phase_override_SM_value
    End Property

    Property Let write_phase_override_SM(aData)
        set_phase_override_SM = aData
        write
    End Property

    Property Get get_phase_inc_SM
        get_phase_inc_SM = read_phase_inc_SM_value
    End Property

    Property Let set_phase_inc_SM(aData)
        write_phase_inc_SM_value = aData
        flag_phase_inc_SM        = &H1
    End Property

    Property Get read_phase_inc_SM
        read
        read_phase_inc_SM = read_phase_inc_SM_value
    End Property

    Property Let write_phase_inc_SM(aData)
        set_phase_inc_SM = aData
        write
    End Property

    Property Get get_phase_dec_SM
        get_phase_dec_SM = read_phase_dec_SM_value
    End Property

    Property Let set_phase_dec_SM(aData)
        write_phase_dec_SM_value = aData
        flag_phase_dec_SM        = &H1
    End Property

    Property Get read_phase_dec_SM
        read
        read_phase_dec_SM = read_phase_dec_SM_value
    End Property

    Property Let write_phase_dec_SM(aData)
        set_phase_dec_SM = aData
        write
    End Property

    Property Get get_phase_strobe_SM
        get_phase_strobe_SM = read_phase_strobe_SM_value
    End Property

    Property Let set_phase_strobe_SM(aData)
        write_phase_strobe_SM_value = aData
        flag_phase_strobe_SM        = &H1
    End Property

    Property Get read_phase_strobe_SM
        read
        read_phase_strobe_SM = read_phase_strobe_SM_value
    End Property

    Property Let write_phase_strobe_SM(aData)
        set_phase_strobe_SM = aData
        write
    End Property

    Property Get get_phase_delta_SM
        get_phase_delta_SM = read_phase_delta_SM_value
    End Property

    Property Let set_phase_delta_SM(aData)
        write_phase_delta_SM_value = aData
        flag_phase_delta_SM        = &H1
    End Property

    Property Get read_phase_delta_SM
        read
        read_phase_delta_SM = read_phase_delta_SM_value
    End Property

    Property Let write_phase_delta_SM(aData)
        set_phase_delta_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_phase_freeze_en_SM_value = rightShift(data_low, 15) and &H1
        read_phase_freeze_val_SM_value = rightShift(data_low, 14) and &H1
        read_pi_phase_invert_value = rightShift(data_low, 11) and &H1
        read_pi_phase_rotate_ovrd_value = rightShift(data_low, 10) and &H1
        read_pi_clk90_offset_ovrd_value = rightShift(data_low, 9) and &H1
        read_phase_override_SM_value = rightShift(data_low, 8) and &H1
        read_phase_inc_SM_value = rightShift(data_low, 7) and &H1
        read_phase_dec_SM_value = rightShift(data_low, 6) and &H1
        read_phase_strobe_SM_value = rightShift(data_low, 5) and &H1
        phase_delta_SM_mask = &H1f
        if data_low > LONG_MAX then
            if phase_delta_SM_mask = mask then
                read_phase_delta_SM_value = data_low
            else
                read_phase_delta_SM_value = (data_low - H8000_0000) and phase_delta_SM_mask
            end If
        else
            read_phase_delta_SM_value = data_low and phase_delta_SM_mask
        end If

    End Sub

    Sub write
        If flag_phase_freeze_en_SM = &H0 or flag_phase_freeze_val_SM = &H0 or flag_pi_phase_invert = &H0 or flag_pi_phase_rotate_ovrd = &H0 or flag_pi_clk90_offset_ovrd = &H0 or flag_phase_override_SM = &H0 or flag_phase_inc_SM = &H0 or flag_phase_dec_SM = &H0 or flag_phase_strobe_SM = &H0 or flag_phase_delta_SM = &H0 Then read
        If flag_phase_freeze_en_SM = &H0 Then write_phase_freeze_en_SM_value = get_phase_freeze_en_SM
        If flag_phase_freeze_val_SM = &H0 Then write_phase_freeze_val_SM_value = get_phase_freeze_val_SM
        If flag_pi_phase_invert = &H0 Then write_pi_phase_invert_value = get_pi_phase_invert
        If flag_pi_phase_rotate_ovrd = &H0 Then write_pi_phase_rotate_ovrd_value = get_pi_phase_rotate_ovrd
        If flag_pi_clk90_offset_ovrd = &H0 Then write_pi_clk90_offset_ovrd_value = get_pi_clk90_offset_ovrd
        If flag_phase_override_SM = &H0 Then write_phase_override_SM_value = get_phase_override_SM
        If flag_phase_inc_SM = &H0 Then write_phase_inc_SM_value = get_phase_inc_SM
        If flag_phase_dec_SM = &H0 Then write_phase_dec_SM_value = get_phase_dec_SM
        If flag_phase_strobe_SM = &H0 Then write_phase_strobe_SM_value = get_phase_strobe_SM
        If flag_phase_delta_SM = &H0 Then write_phase_delta_SM_value = get_phase_delta_SM

        regValue = leftShift((write_phase_freeze_en_SM_value and &H1), 15) + leftShift((write_phase_freeze_val_SM_value and &H1), 14) + leftShift((write_pi_phase_invert_value and &H1), 11) + leftShift((write_pi_phase_rotate_ovrd_value and &H1), 10) + leftShift((write_pi_clk90_offset_ovrd_value and &H1), 9) + leftShift((write_phase_override_SM_value and &H1), 8) + leftShift((write_phase_inc_SM_value and &H1), 7) + leftShift((write_phase_dec_SM_value and &H1), 6) + leftShift((write_phase_strobe_SM_value and &H1), 5) + leftShift((write_phase_delta_SM_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_phase_freeze_en_SM_value = rightShift(data_low, 15) and &H1
        read_phase_freeze_val_SM_value = rightShift(data_low, 14) and &H1
        read_pi_phase_invert_value = rightShift(data_low, 11) and &H1
        read_pi_phase_rotate_ovrd_value = rightShift(data_low, 10) and &H1
        read_pi_clk90_offset_ovrd_value = rightShift(data_low, 9) and &H1
        read_phase_override_SM_value = rightShift(data_low, 8) and &H1
        read_phase_inc_SM_value = rightShift(data_low, 7) and &H1
        read_phase_dec_SM_value = rightShift(data_low, 6) and &H1
        read_phase_strobe_SM_value = rightShift(data_low, 5) and &H1
        phase_delta_SM_mask = &H1f
        if data_low > LONG_MAX then
            if phase_delta_SM_mask = mask then
                read_phase_delta_SM_value = data_low
            else
                read_phase_delta_SM_value = (data_low - H8000_0000) and phase_delta_SM_mask
            end If
        else
            read_phase_delta_SM_value = data_low and phase_delta_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_phase_freeze_en_SM_value = &H0
        flag_phase_freeze_en_SM        = &H0
        write_phase_freeze_val_SM_value = &H0
        flag_phase_freeze_val_SM        = &H0
        write_pi_phase_invert_value = &H0
        flag_pi_phase_invert        = &H0
        write_pi_phase_rotate_ovrd_value = &H0
        flag_pi_phase_rotate_ovrd        = &H0
        write_pi_clk90_offset_ovrd_value = &H0
        flag_pi_clk90_offset_ovrd        = &H0
        write_phase_override_SM_value = &H0
        flag_phase_override_SM        = &H0
        write_phase_inc_SM_value = &H0
        flag_phase_inc_SM        = &H0
        write_phase_dec_SM_value = &H0
        flag_phase_dec_SM        = &H0
        write_phase_strobe_SM_value = &H0
        flag_phase_strobe_SM        = &H0
        write_phase_delta_SM_value = &H0
        flag_phase_delta_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_cdr_freq
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdr_freq_upd_en_SM                         [15:15]          get_cdr_freq_upd_en_SM
''                                                             set_cdr_freq_upd_en_SM
''                                                             read_cdr_freq_upd_en_SM
''                                                             write_cdr_freq_upd_en_SM
''---------------------------------------------------------------------------------
'' cdr_freq_en_SM                             [14:14]          get_cdr_freq_en_SM
''                                                             set_cdr_freq_en_SM
''                                                             read_cdr_freq_en_SM
''                                                             write_cdr_freq_en_SM
''---------------------------------------------------------------------------------
'' cdr_phs_cntr_clr_SM                        [13:13]          get_cdr_phs_cntr_clr_SM
''                                                             set_cdr_phs_cntr_clr_SM
''                                                             read_cdr_phs_cntr_clr_SM
''                                                             write_cdr_phs_cntr_clr_SM
''---------------------------------------------------------------------------------
'' cdr_flip_peak_pol_SM                       [12:12]          get_cdr_flip_peak_pol_SM
''                                                             set_cdr_flip_peak_pol_SM
''                                                             read_cdr_flip_peak_pol_SM
''                                                             write_cdr_flip_peak_pol_SM
''---------------------------------------------------------------------------------
'' cdr_flip_zero_pol_SM                       [11:11]          get_cdr_flip_zero_pol_SM
''                                                             set_cdr_flip_zero_pol_SM
''                                                             read_cdr_flip_zero_pol_SM
''                                                             write_cdr_flip_zero_pol_SM
''---------------------------------------------------------------------------------
'' err_max_cnt_sel_SM                         [10:8]           get_err_max_cnt_sel_SM
''                                                             set_err_max_cnt_sel_SM
''                                                             read_err_max_cnt_sel_SM
''                                                             write_err_max_cnt_sel_SM
''---------------------------------------------------------------------------------
'' clear_err_cnt_SM                           [7:7]            get_clear_err_cnt_SM
''                                                             set_clear_err_cnt_SM
''                                                             read_clear_err_cnt_SM
''                                                             write_clear_err_cnt_SM
''---------------------------------------------------------------------------------
'' auto_clear_err_cnt_SM                      [6:6]            get_auto_clear_err_cnt_SM
''                                                             set_auto_clear_err_cnt_SM
''                                                             read_auto_clear_err_cnt_SM
''                                                             write_auto_clear_err_cnt_SM
''---------------------------------------------------------------------------------
'' freq_override_en_SM                        [5:5]            get_freq_override_en_SM
''                                                             set_freq_override_en_SM
''                                                             read_freq_override_en_SM
''                                                             write_freq_override_en_SM
''---------------------------------------------------------------------------------
'' freq_override_val_SM                       [4:0]            get_freq_override_val_SM
''                                                             set_freq_override_val_SM
''                                                             read_freq_override_val_SM
''                                                             write_freq_override_val_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_cdr_freq
    Private write_cdr_freq_upd_en_SM_value
    Private read_cdr_freq_upd_en_SM_value
    Private flag_cdr_freq_upd_en_SM
    Private write_cdr_freq_en_SM_value
    Private read_cdr_freq_en_SM_value
    Private flag_cdr_freq_en_SM
    Private write_cdr_phs_cntr_clr_SM_value
    Private read_cdr_phs_cntr_clr_SM_value
    Private flag_cdr_phs_cntr_clr_SM
    Private write_cdr_flip_peak_pol_SM_value
    Private read_cdr_flip_peak_pol_SM_value
    Private flag_cdr_flip_peak_pol_SM
    Private write_cdr_flip_zero_pol_SM_value
    Private read_cdr_flip_zero_pol_SM_value
    Private flag_cdr_flip_zero_pol_SM
    Private write_err_max_cnt_sel_SM_value
    Private read_err_max_cnt_sel_SM_value
    Private flag_err_max_cnt_sel_SM
    Private write_clear_err_cnt_SM_value
    Private read_clear_err_cnt_SM_value
    Private flag_clear_err_cnt_SM
    Private write_auto_clear_err_cnt_SM_value
    Private read_auto_clear_err_cnt_SM_value
    Private flag_auto_clear_err_cnt_SM
    Private write_freq_override_en_SM_value
    Private read_freq_override_en_SM_value
    Private flag_freq_override_en_SM
    Private write_freq_override_val_SM_value
    Private read_freq_override_val_SM_value
    Private flag_freq_override_val_SM

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

    Property Get get_cdr_freq_upd_en_SM
        get_cdr_freq_upd_en_SM = read_cdr_freq_upd_en_SM_value
    End Property

    Property Let set_cdr_freq_upd_en_SM(aData)
        write_cdr_freq_upd_en_SM_value = aData
        flag_cdr_freq_upd_en_SM        = &H1
    End Property

    Property Get read_cdr_freq_upd_en_SM
        read
        read_cdr_freq_upd_en_SM = read_cdr_freq_upd_en_SM_value
    End Property

    Property Let write_cdr_freq_upd_en_SM(aData)
        set_cdr_freq_upd_en_SM = aData
        write
    End Property

    Property Get get_cdr_freq_en_SM
        get_cdr_freq_en_SM = read_cdr_freq_en_SM_value
    End Property

    Property Let set_cdr_freq_en_SM(aData)
        write_cdr_freq_en_SM_value = aData
        flag_cdr_freq_en_SM        = &H1
    End Property

    Property Get read_cdr_freq_en_SM
        read
        read_cdr_freq_en_SM = read_cdr_freq_en_SM_value
    End Property

    Property Let write_cdr_freq_en_SM(aData)
        set_cdr_freq_en_SM = aData
        write
    End Property

    Property Get get_cdr_phs_cntr_clr_SM
        get_cdr_phs_cntr_clr_SM = read_cdr_phs_cntr_clr_SM_value
    End Property

    Property Let set_cdr_phs_cntr_clr_SM(aData)
        write_cdr_phs_cntr_clr_SM_value = aData
        flag_cdr_phs_cntr_clr_SM        = &H1
    End Property

    Property Get read_cdr_phs_cntr_clr_SM
        read
        read_cdr_phs_cntr_clr_SM = read_cdr_phs_cntr_clr_SM_value
    End Property

    Property Let write_cdr_phs_cntr_clr_SM(aData)
        set_cdr_phs_cntr_clr_SM = aData
        write
    End Property

    Property Get get_cdr_flip_peak_pol_SM
        get_cdr_flip_peak_pol_SM = read_cdr_flip_peak_pol_SM_value
    End Property

    Property Let set_cdr_flip_peak_pol_SM(aData)
        write_cdr_flip_peak_pol_SM_value = aData
        flag_cdr_flip_peak_pol_SM        = &H1
    End Property

    Property Get read_cdr_flip_peak_pol_SM
        read
        read_cdr_flip_peak_pol_SM = read_cdr_flip_peak_pol_SM_value
    End Property

    Property Let write_cdr_flip_peak_pol_SM(aData)
        set_cdr_flip_peak_pol_SM = aData
        write
    End Property

    Property Get get_cdr_flip_zero_pol_SM
        get_cdr_flip_zero_pol_SM = read_cdr_flip_zero_pol_SM_value
    End Property

    Property Let set_cdr_flip_zero_pol_SM(aData)
        write_cdr_flip_zero_pol_SM_value = aData
        flag_cdr_flip_zero_pol_SM        = &H1
    End Property

    Property Get read_cdr_flip_zero_pol_SM
        read
        read_cdr_flip_zero_pol_SM = read_cdr_flip_zero_pol_SM_value
    End Property

    Property Let write_cdr_flip_zero_pol_SM(aData)
        set_cdr_flip_zero_pol_SM = aData
        write
    End Property

    Property Get get_err_max_cnt_sel_SM
        get_err_max_cnt_sel_SM = read_err_max_cnt_sel_SM_value
    End Property

    Property Let set_err_max_cnt_sel_SM(aData)
        write_err_max_cnt_sel_SM_value = aData
        flag_err_max_cnt_sel_SM        = &H1
    End Property

    Property Get read_err_max_cnt_sel_SM
        read
        read_err_max_cnt_sel_SM = read_err_max_cnt_sel_SM_value
    End Property

    Property Let write_err_max_cnt_sel_SM(aData)
        set_err_max_cnt_sel_SM = aData
        write
    End Property

    Property Get get_clear_err_cnt_SM
        get_clear_err_cnt_SM = read_clear_err_cnt_SM_value
    End Property

    Property Let set_clear_err_cnt_SM(aData)
        write_clear_err_cnt_SM_value = aData
        flag_clear_err_cnt_SM        = &H1
    End Property

    Property Get read_clear_err_cnt_SM
        read
        read_clear_err_cnt_SM = read_clear_err_cnt_SM_value
    End Property

    Property Let write_clear_err_cnt_SM(aData)
        set_clear_err_cnt_SM = aData
        write
    End Property

    Property Get get_auto_clear_err_cnt_SM
        get_auto_clear_err_cnt_SM = read_auto_clear_err_cnt_SM_value
    End Property

    Property Let set_auto_clear_err_cnt_SM(aData)
        write_auto_clear_err_cnt_SM_value = aData
        flag_auto_clear_err_cnt_SM        = &H1
    End Property

    Property Get read_auto_clear_err_cnt_SM
        read
        read_auto_clear_err_cnt_SM = read_auto_clear_err_cnt_SM_value
    End Property

    Property Let write_auto_clear_err_cnt_SM(aData)
        set_auto_clear_err_cnt_SM = aData
        write
    End Property

    Property Get get_freq_override_en_SM
        get_freq_override_en_SM = read_freq_override_en_SM_value
    End Property

    Property Let set_freq_override_en_SM(aData)
        write_freq_override_en_SM_value = aData
        flag_freq_override_en_SM        = &H1
    End Property

    Property Get read_freq_override_en_SM
        read
        read_freq_override_en_SM = read_freq_override_en_SM_value
    End Property

    Property Let write_freq_override_en_SM(aData)
        set_freq_override_en_SM = aData
        write
    End Property

    Property Get get_freq_override_val_SM
        get_freq_override_val_SM = read_freq_override_val_SM_value
    End Property

    Property Let set_freq_override_val_SM(aData)
        write_freq_override_val_SM_value = aData
        flag_freq_override_val_SM        = &H1
    End Property

    Property Get read_freq_override_val_SM
        read
        read_freq_override_val_SM = read_freq_override_val_SM_value
    End Property

    Property Let write_freq_override_val_SM(aData)
        set_freq_override_val_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdr_freq_upd_en_SM_value = rightShift(data_low, 15) and &H1
        read_cdr_freq_en_SM_value = rightShift(data_low, 14) and &H1
        read_cdr_phs_cntr_clr_SM_value = rightShift(data_low, 13) and &H1
        read_cdr_flip_peak_pol_SM_value = rightShift(data_low, 12) and &H1
        read_cdr_flip_zero_pol_SM_value = rightShift(data_low, 11) and &H1
        read_err_max_cnt_sel_SM_value = rightShift(data_low, 8) and &H7
        read_clear_err_cnt_SM_value = rightShift(data_low, 7) and &H1
        read_auto_clear_err_cnt_SM_value = rightShift(data_low, 6) and &H1
        read_freq_override_en_SM_value = rightShift(data_low, 5) and &H1
        freq_override_val_SM_mask = &H1f
        if data_low > LONG_MAX then
            if freq_override_val_SM_mask = mask then
                read_freq_override_val_SM_value = data_low
            else
                read_freq_override_val_SM_value = (data_low - H8000_0000) and freq_override_val_SM_mask
            end If
        else
            read_freq_override_val_SM_value = data_low and freq_override_val_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdr_freq_upd_en_SM = &H0 or flag_cdr_freq_en_SM = &H0 or flag_cdr_phs_cntr_clr_SM = &H0 or flag_cdr_flip_peak_pol_SM = &H0 or flag_cdr_flip_zero_pol_SM = &H0 or flag_err_max_cnt_sel_SM = &H0 or flag_clear_err_cnt_SM = &H0 or flag_auto_clear_err_cnt_SM = &H0 or flag_freq_override_en_SM = &H0 or flag_freq_override_val_SM = &H0 Then read
        If flag_cdr_freq_upd_en_SM = &H0 Then write_cdr_freq_upd_en_SM_value = get_cdr_freq_upd_en_SM
        If flag_cdr_freq_en_SM = &H0 Then write_cdr_freq_en_SM_value = get_cdr_freq_en_SM
        If flag_cdr_phs_cntr_clr_SM = &H0 Then write_cdr_phs_cntr_clr_SM_value = get_cdr_phs_cntr_clr_SM
        If flag_cdr_flip_peak_pol_SM = &H0 Then write_cdr_flip_peak_pol_SM_value = get_cdr_flip_peak_pol_SM
        If flag_cdr_flip_zero_pol_SM = &H0 Then write_cdr_flip_zero_pol_SM_value = get_cdr_flip_zero_pol_SM
        If flag_err_max_cnt_sel_SM = &H0 Then write_err_max_cnt_sel_SM_value = get_err_max_cnt_sel_SM
        If flag_clear_err_cnt_SM = &H0 Then write_clear_err_cnt_SM_value = get_clear_err_cnt_SM
        If flag_auto_clear_err_cnt_SM = &H0 Then write_auto_clear_err_cnt_SM_value = get_auto_clear_err_cnt_SM
        If flag_freq_override_en_SM = &H0 Then write_freq_override_en_SM_value = get_freq_override_en_SM
        If flag_freq_override_val_SM = &H0 Then write_freq_override_val_SM_value = get_freq_override_val_SM

        regValue = leftShift((write_cdr_freq_upd_en_SM_value and &H1), 15) + leftShift((write_cdr_freq_en_SM_value and &H1), 14) + leftShift((write_cdr_phs_cntr_clr_SM_value and &H1), 13) + leftShift((write_cdr_flip_peak_pol_SM_value and &H1), 12) + leftShift((write_cdr_flip_zero_pol_SM_value and &H1), 11) + leftShift((write_err_max_cnt_sel_SM_value and &H7), 8) + leftShift((write_clear_err_cnt_SM_value and &H1), 7) + leftShift((write_auto_clear_err_cnt_SM_value and &H1), 6) + leftShift((write_freq_override_en_SM_value and &H1), 5) + leftShift((write_freq_override_val_SM_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdr_freq_upd_en_SM_value = rightShift(data_low, 15) and &H1
        read_cdr_freq_en_SM_value = rightShift(data_low, 14) and &H1
        read_cdr_phs_cntr_clr_SM_value = rightShift(data_low, 13) and &H1
        read_cdr_flip_peak_pol_SM_value = rightShift(data_low, 12) and &H1
        read_cdr_flip_zero_pol_SM_value = rightShift(data_low, 11) and &H1
        read_err_max_cnt_sel_SM_value = rightShift(data_low, 8) and &H7
        read_clear_err_cnt_SM_value = rightShift(data_low, 7) and &H1
        read_auto_clear_err_cnt_SM_value = rightShift(data_low, 6) and &H1
        read_freq_override_en_SM_value = rightShift(data_low, 5) and &H1
        freq_override_val_SM_mask = &H1f
        if data_low > LONG_MAX then
            if freq_override_val_SM_mask = mask then
                read_freq_override_val_SM_value = data_low
            else
                read_freq_override_val_SM_value = (data_low - H8000_0000) and freq_override_val_SM_mask
            end If
        else
            read_freq_override_val_SM_value = data_low and freq_override_val_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdr_freq_upd_en_SM_value = &H0
        flag_cdr_freq_upd_en_SM        = &H0
        write_cdr_freq_en_SM_value = &H0
        flag_cdr_freq_en_SM        = &H0
        write_cdr_phs_cntr_clr_SM_value = &H0
        flag_cdr_phs_cntr_clr_SM        = &H0
        write_cdr_flip_peak_pol_SM_value = &H0
        flag_cdr_flip_peak_pol_SM        = &H0
        write_cdr_flip_zero_pol_SM_value = &H0
        flag_cdr_flip_zero_pol_SM        = &H0
        write_err_max_cnt_sel_SM_value = &H0
        flag_err_max_cnt_sel_SM        = &H0
        write_clear_err_cnt_SM_value = &H0
        flag_clear_err_cnt_SM        = &H0
        write_auto_clear_err_cnt_SM_value = &H0
        flag_auto_clear_err_cnt_SM        = &H0
        write_freq_override_en_SM_value = &H0
        flag_freq_override_en_SM        = &H0
        write_freq_override_val_SM_value = &H0
        flag_freq_override_val_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_control1g
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_seed_ld_SM                            [15:15]          get_prbs_seed_ld_SM
''                                                             set_prbs_seed_ld_SM
''                                                             read_prbs_seed_ld_SM
''                                                             write_prbs_seed_ld_SM
''---------------------------------------------------------------------------------
'' packet_count_en_SM                         [14:14]          get_packet_count_en_SM
''                                                             set_packet_count_en_SM
''                                                             read_packet_count_en_SM
''                                                             write_packet_count_en_SM
''---------------------------------------------------------------------------------
'' RxErrDisparity_dis_SM                      [13:13]          get_RxErrDisparity_dis_SM
''                                                             set_RxErrDisparity_dis_SM
''                                                             read_RxErrDisparity_dis_SM
''                                                             write_RxErrDisparity_dis_SM
''---------------------------------------------------------------------------------
'' prbs_clr_dis_r                             [12:12]          get_prbs_clr_dis_r
''                                                             set_prbs_clr_dis_r
''                                                             read_prbs_clr_dis_r
''                                                             write_prbs_clr_dis_r
''---------------------------------------------------------------------------------
'' rxd_dec_sel_r                              [11:11]          get_rxd_dec_sel_r
''                                                             set_rxd_dec_sel_r
''                                                             read_rxd_dec_sel_r
''                                                             write_rxd_dec_sel_r
''---------------------------------------------------------------------------------
'' cgbad_tst_SM                               [10:10]          get_cgbad_tst_SM
''                                                             set_cgbad_tst_SM
''                                                             read_cgbad_tst_SM
''                                                             write_cgbad_tst_SM
''---------------------------------------------------------------------------------
'' Emon_en_r                                  [9:9]            get_Emon_en_r
''                                                             set_Emon_en_r
''                                                             read_Emon_en_r
''                                                             write_Emon_en_r
''---------------------------------------------------------------------------------
'' prbs_en_r                                  [8:8]            get_prbs_en_r
''                                                             set_prbs_en_r
''                                                             read_prbs_en_r
''                                                             write_prbs_en_r
''---------------------------------------------------------------------------------
'' cgbad_en_SM                                [7:7]            get_cgbad_en_SM
''                                                             set_cgbad_en_SM
''                                                             read_cgbad_en_SM
''                                                             write_cgbad_en_SM
''---------------------------------------------------------------------------------
'' fpat_md_SM                                 [6:6]            get_fpat_md_SM
''                                                             set_fpat_md_SM
''                                                             read_fpat_md_SM
''                                                             write_fpat_md_SM
''---------------------------------------------------------------------------------
'' useRxSeqDone_SM                            [5:5]            get_useRxSeqDone_SM
''                                                             set_useRxSeqDone_SM
''                                                             read_useRxSeqDone_SM
''                                                             write_useRxSeqDone_SM
''---------------------------------------------------------------------------------
'' useSigdet_SM                               [4:4]            get_useSigdet_SM
''                                                             set_useSigdet_SM
''                                                             read_useSigdet_SM
''                                                             write_useSigdet_SM
''---------------------------------------------------------------------------------
'' phase_sel_SM                               [3:3]            get_phase_sel_SM
''                                                             set_phase_sel_SM
''                                                             read_phase_sel_SM
''                                                             write_phase_sel_SM
''---------------------------------------------------------------------------------
'' commonClockMode_otf_SM                     [2:2]            get_commonClockMode_otf_SM
''                                                             set_commonClockMode_otf_SM
''                                                             read_commonClockMode_otf_SM
''                                                             write_commonClockMode_otf_SM
''---------------------------------------------------------------------------------
'' commonClockMode_force_SM                   [1:1]            get_commonClockMode_force_SM
''                                                             set_commonClockMode_force_SM
''                                                             read_commonClockMode_force_SM
''                                                             write_commonClockMode_force_SM
''---------------------------------------------------------------------------------
'' commonClockMode_r                          [0:0]            get_commonClockMode_r
''                                                             set_commonClockMode_r
''                                                             read_commonClockMode_r
''                                                             write_commonClockMode_r
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_control1g
    Private write_prbs_seed_ld_SM_value
    Private read_prbs_seed_ld_SM_value
    Private flag_prbs_seed_ld_SM
    Private write_packet_count_en_SM_value
    Private read_packet_count_en_SM_value
    Private flag_packet_count_en_SM
    Private write_RxErrDisparity_dis_SM_value
    Private read_RxErrDisparity_dis_SM_value
    Private flag_RxErrDisparity_dis_SM
    Private write_prbs_clr_dis_r_value
    Private read_prbs_clr_dis_r_value
    Private flag_prbs_clr_dis_r
    Private write_rxd_dec_sel_r_value
    Private read_rxd_dec_sel_r_value
    Private flag_rxd_dec_sel_r
    Private write_cgbad_tst_SM_value
    Private read_cgbad_tst_SM_value
    Private flag_cgbad_tst_SM
    Private write_Emon_en_r_value
    Private read_Emon_en_r_value
    Private flag_Emon_en_r
    Private write_prbs_en_r_value
    Private read_prbs_en_r_value
    Private flag_prbs_en_r
    Private write_cgbad_en_SM_value
    Private read_cgbad_en_SM_value
    Private flag_cgbad_en_SM
    Private write_fpat_md_SM_value
    Private read_fpat_md_SM_value
    Private flag_fpat_md_SM
    Private write_useRxSeqDone_SM_value
    Private read_useRxSeqDone_SM_value
    Private flag_useRxSeqDone_SM
    Private write_useSigdet_SM_value
    Private read_useSigdet_SM_value
    Private flag_useSigdet_SM
    Private write_phase_sel_SM_value
    Private read_phase_sel_SM_value
    Private flag_phase_sel_SM
    Private write_commonClockMode_otf_SM_value
    Private read_commonClockMode_otf_SM_value
    Private flag_commonClockMode_otf_SM
    Private write_commonClockMode_force_SM_value
    Private read_commonClockMode_force_SM_value
    Private flag_commonClockMode_force_SM
    Private write_commonClockMode_r_value
    Private read_commonClockMode_r_value
    Private flag_commonClockMode_r

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

    Property Get get_prbs_seed_ld_SM
        get_prbs_seed_ld_SM = read_prbs_seed_ld_SM_value
    End Property

    Property Let set_prbs_seed_ld_SM(aData)
        write_prbs_seed_ld_SM_value = aData
        flag_prbs_seed_ld_SM        = &H1
    End Property

    Property Get read_prbs_seed_ld_SM
        read
        read_prbs_seed_ld_SM = read_prbs_seed_ld_SM_value
    End Property

    Property Let write_prbs_seed_ld_SM(aData)
        set_prbs_seed_ld_SM = aData
        write
    End Property

    Property Get get_packet_count_en_SM
        get_packet_count_en_SM = read_packet_count_en_SM_value
    End Property

    Property Let set_packet_count_en_SM(aData)
        write_packet_count_en_SM_value = aData
        flag_packet_count_en_SM        = &H1
    End Property

    Property Get read_packet_count_en_SM
        read
        read_packet_count_en_SM = read_packet_count_en_SM_value
    End Property

    Property Let write_packet_count_en_SM(aData)
        set_packet_count_en_SM = aData
        write
    End Property

    Property Get get_RxErrDisparity_dis_SM
        get_RxErrDisparity_dis_SM = read_RxErrDisparity_dis_SM_value
    End Property

    Property Let set_RxErrDisparity_dis_SM(aData)
        write_RxErrDisparity_dis_SM_value = aData
        flag_RxErrDisparity_dis_SM        = &H1
    End Property

    Property Get read_RxErrDisparity_dis_SM
        read
        read_RxErrDisparity_dis_SM = read_RxErrDisparity_dis_SM_value
    End Property

    Property Let write_RxErrDisparity_dis_SM(aData)
        set_RxErrDisparity_dis_SM = aData
        write
    End Property

    Property Get get_prbs_clr_dis_r
        get_prbs_clr_dis_r = read_prbs_clr_dis_r_value
    End Property

    Property Let set_prbs_clr_dis_r(aData)
        write_prbs_clr_dis_r_value = aData
        flag_prbs_clr_dis_r        = &H1
    End Property

    Property Get read_prbs_clr_dis_r
        read
        read_prbs_clr_dis_r = read_prbs_clr_dis_r_value
    End Property

    Property Let write_prbs_clr_dis_r(aData)
        set_prbs_clr_dis_r = aData
        write
    End Property

    Property Get get_rxd_dec_sel_r
        get_rxd_dec_sel_r = read_rxd_dec_sel_r_value
    End Property

    Property Let set_rxd_dec_sel_r(aData)
        write_rxd_dec_sel_r_value = aData
        flag_rxd_dec_sel_r        = &H1
    End Property

    Property Get read_rxd_dec_sel_r
        read
        read_rxd_dec_sel_r = read_rxd_dec_sel_r_value
    End Property

    Property Let write_rxd_dec_sel_r(aData)
        set_rxd_dec_sel_r = aData
        write
    End Property

    Property Get get_cgbad_tst_SM
        get_cgbad_tst_SM = read_cgbad_tst_SM_value
    End Property

    Property Let set_cgbad_tst_SM(aData)
        write_cgbad_tst_SM_value = aData
        flag_cgbad_tst_SM        = &H1
    End Property

    Property Get read_cgbad_tst_SM
        read
        read_cgbad_tst_SM = read_cgbad_tst_SM_value
    End Property

    Property Let write_cgbad_tst_SM(aData)
        set_cgbad_tst_SM = aData
        write
    End Property

    Property Get get_Emon_en_r
        get_Emon_en_r = read_Emon_en_r_value
    End Property

    Property Let set_Emon_en_r(aData)
        write_Emon_en_r_value = aData
        flag_Emon_en_r        = &H1
    End Property

    Property Get read_Emon_en_r
        read
        read_Emon_en_r = read_Emon_en_r_value
    End Property

    Property Let write_Emon_en_r(aData)
        set_Emon_en_r = aData
        write
    End Property

    Property Get get_prbs_en_r
        get_prbs_en_r = read_prbs_en_r_value
    End Property

    Property Let set_prbs_en_r(aData)
        write_prbs_en_r_value = aData
        flag_prbs_en_r        = &H1
    End Property

    Property Get read_prbs_en_r
        read
        read_prbs_en_r = read_prbs_en_r_value
    End Property

    Property Let write_prbs_en_r(aData)
        set_prbs_en_r = aData
        write
    End Property

    Property Get get_cgbad_en_SM
        get_cgbad_en_SM = read_cgbad_en_SM_value
    End Property

    Property Let set_cgbad_en_SM(aData)
        write_cgbad_en_SM_value = aData
        flag_cgbad_en_SM        = &H1
    End Property

    Property Get read_cgbad_en_SM
        read
        read_cgbad_en_SM = read_cgbad_en_SM_value
    End Property

    Property Let write_cgbad_en_SM(aData)
        set_cgbad_en_SM = aData
        write
    End Property

    Property Get get_fpat_md_SM
        get_fpat_md_SM = read_fpat_md_SM_value
    End Property

    Property Let set_fpat_md_SM(aData)
        write_fpat_md_SM_value = aData
        flag_fpat_md_SM        = &H1
    End Property

    Property Get read_fpat_md_SM
        read
        read_fpat_md_SM = read_fpat_md_SM_value
    End Property

    Property Let write_fpat_md_SM(aData)
        set_fpat_md_SM = aData
        write
    End Property

    Property Get get_useRxSeqDone_SM
        get_useRxSeqDone_SM = read_useRxSeqDone_SM_value
    End Property

    Property Let set_useRxSeqDone_SM(aData)
        write_useRxSeqDone_SM_value = aData
        flag_useRxSeqDone_SM        = &H1
    End Property

    Property Get read_useRxSeqDone_SM
        read
        read_useRxSeqDone_SM = read_useRxSeqDone_SM_value
    End Property

    Property Let write_useRxSeqDone_SM(aData)
        set_useRxSeqDone_SM = aData
        write
    End Property

    Property Get get_useSigdet_SM
        get_useSigdet_SM = read_useSigdet_SM_value
    End Property

    Property Let set_useSigdet_SM(aData)
        write_useSigdet_SM_value = aData
        flag_useSigdet_SM        = &H1
    End Property

    Property Get read_useSigdet_SM
        read
        read_useSigdet_SM = read_useSigdet_SM_value
    End Property

    Property Let write_useSigdet_SM(aData)
        set_useSigdet_SM = aData
        write
    End Property

    Property Get get_phase_sel_SM
        get_phase_sel_SM = read_phase_sel_SM_value
    End Property

    Property Let set_phase_sel_SM(aData)
        write_phase_sel_SM_value = aData
        flag_phase_sel_SM        = &H1
    End Property

    Property Get read_phase_sel_SM
        read
        read_phase_sel_SM = read_phase_sel_SM_value
    End Property

    Property Let write_phase_sel_SM(aData)
        set_phase_sel_SM = aData
        write
    End Property

    Property Get get_commonClockMode_otf_SM
        get_commonClockMode_otf_SM = read_commonClockMode_otf_SM_value
    End Property

    Property Let set_commonClockMode_otf_SM(aData)
        write_commonClockMode_otf_SM_value = aData
        flag_commonClockMode_otf_SM        = &H1
    End Property

    Property Get read_commonClockMode_otf_SM
        read
        read_commonClockMode_otf_SM = read_commonClockMode_otf_SM_value
    End Property

    Property Let write_commonClockMode_otf_SM(aData)
        set_commonClockMode_otf_SM = aData
        write
    End Property

    Property Get get_commonClockMode_force_SM
        get_commonClockMode_force_SM = read_commonClockMode_force_SM_value
    End Property

    Property Let set_commonClockMode_force_SM(aData)
        write_commonClockMode_force_SM_value = aData
        flag_commonClockMode_force_SM        = &H1
    End Property

    Property Get read_commonClockMode_force_SM
        read
        read_commonClockMode_force_SM = read_commonClockMode_force_SM_value
    End Property

    Property Let write_commonClockMode_force_SM(aData)
        set_commonClockMode_force_SM = aData
        write
    End Property

    Property Get get_commonClockMode_r
        get_commonClockMode_r = read_commonClockMode_r_value
    End Property

    Property Let set_commonClockMode_r(aData)
        write_commonClockMode_r_value = aData
        flag_commonClockMode_r        = &H1
    End Property

    Property Get read_commonClockMode_r
        read
        read_commonClockMode_r = read_commonClockMode_r_value
    End Property

    Property Let write_commonClockMode_r(aData)
        set_commonClockMode_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_seed_ld_SM_value = rightShift(data_low, 15) and &H1
        read_packet_count_en_SM_value = rightShift(data_low, 14) and &H1
        read_RxErrDisparity_dis_SM_value = rightShift(data_low, 13) and &H1
        read_prbs_clr_dis_r_value = rightShift(data_low, 12) and &H1
        read_rxd_dec_sel_r_value = rightShift(data_low, 11) and &H1
        read_cgbad_tst_SM_value = rightShift(data_low, 10) and &H1
        read_Emon_en_r_value = rightShift(data_low, 9) and &H1
        read_prbs_en_r_value = rightShift(data_low, 8) and &H1
        read_cgbad_en_SM_value = rightShift(data_low, 7) and &H1
        read_fpat_md_SM_value = rightShift(data_low, 6) and &H1
        read_useRxSeqDone_SM_value = rightShift(data_low, 5) and &H1
        read_useSigdet_SM_value = rightShift(data_low, 4) and &H1
        read_phase_sel_SM_value = rightShift(data_low, 3) and &H1
        read_commonClockMode_otf_SM_value = rightShift(data_low, 2) and &H1
        read_commonClockMode_force_SM_value = rightShift(data_low, 1) and &H1
        commonClockMode_r_mask = &H1
        if data_low > LONG_MAX then
            if commonClockMode_r_mask = mask then
                read_commonClockMode_r_value = data_low
            else
                read_commonClockMode_r_value = (data_low - H8000_0000) and commonClockMode_r_mask
            end If
        else
            read_commonClockMode_r_value = data_low and commonClockMode_r_mask
        end If

    End Sub

    Sub write
        If flag_prbs_seed_ld_SM = &H0 or flag_packet_count_en_SM = &H0 or flag_RxErrDisparity_dis_SM = &H0 or flag_prbs_clr_dis_r = &H0 or flag_rxd_dec_sel_r = &H0 or flag_cgbad_tst_SM = &H0 or flag_Emon_en_r = &H0 or flag_prbs_en_r = &H0 or flag_cgbad_en_SM = &H0 or flag_fpat_md_SM = &H0 or flag_useRxSeqDone_SM = &H0 or flag_useSigdet_SM = &H0 or flag_phase_sel_SM = &H0 or flag_commonClockMode_otf_SM = &H0 or flag_commonClockMode_force_SM = &H0 or flag_commonClockMode_r = &H0 Then read
        If flag_prbs_seed_ld_SM = &H0 Then write_prbs_seed_ld_SM_value = get_prbs_seed_ld_SM
        If flag_packet_count_en_SM = &H0 Then write_packet_count_en_SM_value = get_packet_count_en_SM
        If flag_RxErrDisparity_dis_SM = &H0 Then write_RxErrDisparity_dis_SM_value = get_RxErrDisparity_dis_SM
        If flag_prbs_clr_dis_r = &H0 Then write_prbs_clr_dis_r_value = get_prbs_clr_dis_r
        If flag_rxd_dec_sel_r = &H0 Then write_rxd_dec_sel_r_value = get_rxd_dec_sel_r
        If flag_cgbad_tst_SM = &H0 Then write_cgbad_tst_SM_value = get_cgbad_tst_SM
        If flag_Emon_en_r = &H0 Then write_Emon_en_r_value = get_Emon_en_r
        If flag_prbs_en_r = &H0 Then write_prbs_en_r_value = get_prbs_en_r
        If flag_cgbad_en_SM = &H0 Then write_cgbad_en_SM_value = get_cgbad_en_SM
        If flag_fpat_md_SM = &H0 Then write_fpat_md_SM_value = get_fpat_md_SM
        If flag_useRxSeqDone_SM = &H0 Then write_useRxSeqDone_SM_value = get_useRxSeqDone_SM
        If flag_useSigdet_SM = &H0 Then write_useSigdet_SM_value = get_useSigdet_SM
        If flag_phase_sel_SM = &H0 Then write_phase_sel_SM_value = get_phase_sel_SM
        If flag_commonClockMode_otf_SM = &H0 Then write_commonClockMode_otf_SM_value = get_commonClockMode_otf_SM
        If flag_commonClockMode_force_SM = &H0 Then write_commonClockMode_force_SM_value = get_commonClockMode_force_SM
        If flag_commonClockMode_r = &H0 Then write_commonClockMode_r_value = get_commonClockMode_r

        regValue = leftShift((write_prbs_seed_ld_SM_value and &H1), 15) + leftShift((write_packet_count_en_SM_value and &H1), 14) + leftShift((write_RxErrDisparity_dis_SM_value and &H1), 13) + leftShift((write_prbs_clr_dis_r_value and &H1), 12) + leftShift((write_rxd_dec_sel_r_value and &H1), 11) + leftShift((write_cgbad_tst_SM_value and &H1), 10) + leftShift((write_Emon_en_r_value and &H1), 9) + leftShift((write_prbs_en_r_value and &H1), 8) + leftShift((write_cgbad_en_SM_value and &H1), 7) + leftShift((write_fpat_md_SM_value and &H1), 6) + leftShift((write_useRxSeqDone_SM_value and &H1), 5) + leftShift((write_useSigdet_SM_value and &H1), 4) + leftShift((write_phase_sel_SM_value and &H1), 3) + leftShift((write_commonClockMode_otf_SM_value and &H1), 2) + leftShift((write_commonClockMode_force_SM_value and &H1), 1) + leftShift((write_commonClockMode_r_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_seed_ld_SM_value = rightShift(data_low, 15) and &H1
        read_packet_count_en_SM_value = rightShift(data_low, 14) and &H1
        read_RxErrDisparity_dis_SM_value = rightShift(data_low, 13) and &H1
        read_prbs_clr_dis_r_value = rightShift(data_low, 12) and &H1
        read_rxd_dec_sel_r_value = rightShift(data_low, 11) and &H1
        read_cgbad_tst_SM_value = rightShift(data_low, 10) and &H1
        read_Emon_en_r_value = rightShift(data_low, 9) and &H1
        read_prbs_en_r_value = rightShift(data_low, 8) and &H1
        read_cgbad_en_SM_value = rightShift(data_low, 7) and &H1
        read_fpat_md_SM_value = rightShift(data_low, 6) and &H1
        read_useRxSeqDone_SM_value = rightShift(data_low, 5) and &H1
        read_useSigdet_SM_value = rightShift(data_low, 4) and &H1
        read_phase_sel_SM_value = rightShift(data_low, 3) and &H1
        read_commonClockMode_otf_SM_value = rightShift(data_low, 2) and &H1
        read_commonClockMode_force_SM_value = rightShift(data_low, 1) and &H1
        commonClockMode_r_mask = &H1
        if data_low > LONG_MAX then
            if commonClockMode_r_mask = mask then
                read_commonClockMode_r_value = data_low
            else
                read_commonClockMode_r_value = (data_low - H8000_0000) and commonClockMode_r_mask
            end If
        else
            read_commonClockMode_r_value = data_low and commonClockMode_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_seed_ld_SM_value = &H0
        flag_prbs_seed_ld_SM        = &H0
        write_packet_count_en_SM_value = &H0
        flag_packet_count_en_SM        = &H0
        write_RxErrDisparity_dis_SM_value = &H0
        flag_RxErrDisparity_dis_SM        = &H0
        write_prbs_clr_dis_r_value = &H0
        flag_prbs_clr_dis_r        = &H0
        write_rxd_dec_sel_r_value = &H0
        flag_rxd_dec_sel_r        = &H0
        write_cgbad_tst_SM_value = &H0
        flag_cgbad_tst_SM        = &H0
        write_Emon_en_r_value = &H0
        flag_Emon_en_r        = &H0
        write_prbs_en_r_value = &H0
        flag_prbs_en_r        = &H0
        write_cgbad_en_SM_value = &H0
        flag_cgbad_en_SM        = &H0
        write_fpat_md_SM_value = &H0
        flag_fpat_md_SM        = &H0
        write_useRxSeqDone_SM_value = &H0
        flag_useRxSeqDone_SM        = &H0
        write_useSigdet_SM_value = &H0
        flag_useSigdet_SM        = &H0
        write_phase_sel_SM_value = &H0
        flag_phase_sel_SM        = &H0
        write_commonClockMode_otf_SM_value = &H0
        flag_commonClockMode_otf_SM        = &H0
        write_commonClockMode_force_SM_value = &H0
        flag_commonClockMode_force_SM        = &H0
        write_commonClockMode_r_value = &H0
        flag_commonClockMode_r        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_control_pci
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_L0s_SM                                [15:15]          get_prbs_L0s_SM
''                                                             set_prbs_L0s_SM
''                                                             read_prbs_L0s_SM
''                                                             write_prbs_L0s_SM
''---------------------------------------------------------------------------------
'' comma_mask_force_r                         [14:14]          get_comma_mask_force_r
''                                                             set_comma_mask_force_r
''                                                             read_comma_mask_force_r
''                                                             write_comma_mask_force_r
''---------------------------------------------------------------------------------
'' comma_mask_r                               [13:13]          get_comma_mask_r
''                                                             set_comma_mask_r
''                                                             read_comma_mask_r
''                                                             write_comma_mask_r
''---------------------------------------------------------------------------------
'' statMuxRegDis                              [12:12]          get_statMuxRegDis
''                                                             set_statMuxRegDis
''                                                             read_statMuxRegDis
''                                                             write_statMuxRegDis
''---------------------------------------------------------------------------------
'' sync_status_force_r_SM                     [11:11]          get_sync_status_force_r_SM
''                                                             set_sync_status_force_r_SM
''                                                             read_sync_status_force_r_SM
''                                                             write_sync_status_force_r_SM
''---------------------------------------------------------------------------------
'' sync_status_force_r                        [10:10]          get_sync_status_force_r
''                                                             set_sync_status_force_r
''                                                             read_sync_status_force_r
''                                                             write_sync_status_force_r
''---------------------------------------------------------------------------------
'' comma_adj_en_force_ext_SM                  [9:9]            get_comma_adj_en_force_ext_SM
''                                                             set_comma_adj_en_force_ext_SM
''                                                             read_comma_adj_en_force_ext_SM
''                                                             write_comma_adj_en_force_ext_SM
''---------------------------------------------------------------------------------
'' comma_adj_en_force_sync_SM                 [8:8]            get_comma_adj_en_force_sync_SM
''                                                             set_comma_adj_en_force_sync_SM
''                                                             read_comma_adj_en_force_sync_SM
''                                                             write_comma_adj_en_force_sync_SM
''---------------------------------------------------------------------------------
'' comma_adj_en_force_r_SM                    [7:7]            get_comma_adj_en_force_r_SM
''                                                             set_comma_adj_en_force_r_SM
''                                                             read_comma_adj_en_force_r_SM
''                                                             write_comma_adj_en_force_r_SM
''---------------------------------------------------------------------------------
'' comma_adj_en_r                             [6:6]            get_comma_adj_en_r
''                                                             set_comma_adj_en_r
''                                                             read_comma_adj_en_r
''                                                             write_comma_adj_en_r
''---------------------------------------------------------------------------------
'' link_en_force_SM                           [5:5]            get_link_en_force_SM
''                                                             set_link_en_force_SM
''                                                             read_link_en_force_SM
''                                                             write_link_en_force_SM
''---------------------------------------------------------------------------------
'' link_en_r                                  [4:4]            get_link_en_r
''                                                             set_link_en_r
''                                                             read_link_en_r
''                                                             write_link_en_r
''---------------------------------------------------------------------------------
'' rx_polarity_force_SM                       [3:3]            get_rx_polarity_force_SM
''                                                             set_rx_polarity_force_SM
''                                                             read_rx_polarity_force_SM
''                                                             write_rx_polarity_force_SM
''---------------------------------------------------------------------------------
'' rx_polarity_r                              [2:2]            get_rx_polarity_r
''                                                             set_rx_polarity_r
''                                                             read_rx_polarity_r
''                                                             write_rx_polarity_r
''---------------------------------------------------------------------------------
'' rxd1g_dec_dis_force_SM                     [1:1]            get_rxd1g_dec_dis_force_SM
''                                                             set_rxd1g_dec_dis_force_SM
''                                                             read_rxd1g_dec_dis_force_SM
''                                                             write_rxd1g_dec_dis_force_SM
''---------------------------------------------------------------------------------
'' rxd1g_dec_dis_r                            [0:0]            get_rxd1g_dec_dis_r
''                                                             set_rxd1g_dec_dis_r
''                                                             read_rxd1g_dec_dis_r
''                                                             write_rxd1g_dec_dis_r
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_control_pci
    Private write_prbs_L0s_SM_value
    Private read_prbs_L0s_SM_value
    Private flag_prbs_L0s_SM
    Private write_comma_mask_force_r_value
    Private read_comma_mask_force_r_value
    Private flag_comma_mask_force_r
    Private write_comma_mask_r_value
    Private read_comma_mask_r_value
    Private flag_comma_mask_r
    Private write_statMuxRegDis_value
    Private read_statMuxRegDis_value
    Private flag_statMuxRegDis
    Private write_sync_status_force_r_SM_value
    Private read_sync_status_force_r_SM_value
    Private flag_sync_status_force_r_SM
    Private write_sync_status_force_r_value
    Private read_sync_status_force_r_value
    Private flag_sync_status_force_r
    Private write_comma_adj_en_force_ext_SM_value
    Private read_comma_adj_en_force_ext_SM_value
    Private flag_comma_adj_en_force_ext_SM
    Private write_comma_adj_en_force_sync_SM_value
    Private read_comma_adj_en_force_sync_SM_value
    Private flag_comma_adj_en_force_sync_SM
    Private write_comma_adj_en_force_r_SM_value
    Private read_comma_adj_en_force_r_SM_value
    Private flag_comma_adj_en_force_r_SM
    Private write_comma_adj_en_r_value
    Private read_comma_adj_en_r_value
    Private flag_comma_adj_en_r
    Private write_link_en_force_SM_value
    Private read_link_en_force_SM_value
    Private flag_link_en_force_SM
    Private write_link_en_r_value
    Private read_link_en_r_value
    Private flag_link_en_r
    Private write_rx_polarity_force_SM_value
    Private read_rx_polarity_force_SM_value
    Private flag_rx_polarity_force_SM
    Private write_rx_polarity_r_value
    Private read_rx_polarity_r_value
    Private flag_rx_polarity_r
    Private write_rxd1g_dec_dis_force_SM_value
    Private read_rxd1g_dec_dis_force_SM_value
    Private flag_rxd1g_dec_dis_force_SM
    Private write_rxd1g_dec_dis_r_value
    Private read_rxd1g_dec_dis_r_value
    Private flag_rxd1g_dec_dis_r

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

    Property Get get_prbs_L0s_SM
        get_prbs_L0s_SM = read_prbs_L0s_SM_value
    End Property

    Property Let set_prbs_L0s_SM(aData)
        write_prbs_L0s_SM_value = aData
        flag_prbs_L0s_SM        = &H1
    End Property

    Property Get read_prbs_L0s_SM
        read
        read_prbs_L0s_SM = read_prbs_L0s_SM_value
    End Property

    Property Let write_prbs_L0s_SM(aData)
        set_prbs_L0s_SM = aData
        write
    End Property

    Property Get get_comma_mask_force_r
        get_comma_mask_force_r = read_comma_mask_force_r_value
    End Property

    Property Let set_comma_mask_force_r(aData)
        write_comma_mask_force_r_value = aData
        flag_comma_mask_force_r        = &H1
    End Property

    Property Get read_comma_mask_force_r
        read
        read_comma_mask_force_r = read_comma_mask_force_r_value
    End Property

    Property Let write_comma_mask_force_r(aData)
        set_comma_mask_force_r = aData
        write
    End Property

    Property Get get_comma_mask_r
        get_comma_mask_r = read_comma_mask_r_value
    End Property

    Property Let set_comma_mask_r(aData)
        write_comma_mask_r_value = aData
        flag_comma_mask_r        = &H1
    End Property

    Property Get read_comma_mask_r
        read
        read_comma_mask_r = read_comma_mask_r_value
    End Property

    Property Let write_comma_mask_r(aData)
        set_comma_mask_r = aData
        write
    End Property

    Property Get get_statMuxRegDis
        get_statMuxRegDis = read_statMuxRegDis_value
    End Property

    Property Let set_statMuxRegDis(aData)
        write_statMuxRegDis_value = aData
        flag_statMuxRegDis        = &H1
    End Property

    Property Get read_statMuxRegDis
        read
        read_statMuxRegDis = read_statMuxRegDis_value
    End Property

    Property Let write_statMuxRegDis(aData)
        set_statMuxRegDis = aData
        write
    End Property

    Property Get get_sync_status_force_r_SM
        get_sync_status_force_r_SM = read_sync_status_force_r_SM_value
    End Property

    Property Let set_sync_status_force_r_SM(aData)
        write_sync_status_force_r_SM_value = aData
        flag_sync_status_force_r_SM        = &H1
    End Property

    Property Get read_sync_status_force_r_SM
        read
        read_sync_status_force_r_SM = read_sync_status_force_r_SM_value
    End Property

    Property Let write_sync_status_force_r_SM(aData)
        set_sync_status_force_r_SM = aData
        write
    End Property

    Property Get get_sync_status_force_r
        get_sync_status_force_r = read_sync_status_force_r_value
    End Property

    Property Let set_sync_status_force_r(aData)
        write_sync_status_force_r_value = aData
        flag_sync_status_force_r        = &H1
    End Property

    Property Get read_sync_status_force_r
        read
        read_sync_status_force_r = read_sync_status_force_r_value
    End Property

    Property Let write_sync_status_force_r(aData)
        set_sync_status_force_r = aData
        write
    End Property

    Property Get get_comma_adj_en_force_ext_SM
        get_comma_adj_en_force_ext_SM = read_comma_adj_en_force_ext_SM_value
    End Property

    Property Let set_comma_adj_en_force_ext_SM(aData)
        write_comma_adj_en_force_ext_SM_value = aData
        flag_comma_adj_en_force_ext_SM        = &H1
    End Property

    Property Get read_comma_adj_en_force_ext_SM
        read
        read_comma_adj_en_force_ext_SM = read_comma_adj_en_force_ext_SM_value
    End Property

    Property Let write_comma_adj_en_force_ext_SM(aData)
        set_comma_adj_en_force_ext_SM = aData
        write
    End Property

    Property Get get_comma_adj_en_force_sync_SM
        get_comma_adj_en_force_sync_SM = read_comma_adj_en_force_sync_SM_value
    End Property

    Property Let set_comma_adj_en_force_sync_SM(aData)
        write_comma_adj_en_force_sync_SM_value = aData
        flag_comma_adj_en_force_sync_SM        = &H1
    End Property

    Property Get read_comma_adj_en_force_sync_SM
        read
        read_comma_adj_en_force_sync_SM = read_comma_adj_en_force_sync_SM_value
    End Property

    Property Let write_comma_adj_en_force_sync_SM(aData)
        set_comma_adj_en_force_sync_SM = aData
        write
    End Property

    Property Get get_comma_adj_en_force_r_SM
        get_comma_adj_en_force_r_SM = read_comma_adj_en_force_r_SM_value
    End Property

    Property Let set_comma_adj_en_force_r_SM(aData)
        write_comma_adj_en_force_r_SM_value = aData
        flag_comma_adj_en_force_r_SM        = &H1
    End Property

    Property Get read_comma_adj_en_force_r_SM
        read
        read_comma_adj_en_force_r_SM = read_comma_adj_en_force_r_SM_value
    End Property

    Property Let write_comma_adj_en_force_r_SM(aData)
        set_comma_adj_en_force_r_SM = aData
        write
    End Property

    Property Get get_comma_adj_en_r
        get_comma_adj_en_r = read_comma_adj_en_r_value
    End Property

    Property Let set_comma_adj_en_r(aData)
        write_comma_adj_en_r_value = aData
        flag_comma_adj_en_r        = &H1
    End Property

    Property Get read_comma_adj_en_r
        read
        read_comma_adj_en_r = read_comma_adj_en_r_value
    End Property

    Property Let write_comma_adj_en_r(aData)
        set_comma_adj_en_r = aData
        write
    End Property

    Property Get get_link_en_force_SM
        get_link_en_force_SM = read_link_en_force_SM_value
    End Property

    Property Let set_link_en_force_SM(aData)
        write_link_en_force_SM_value = aData
        flag_link_en_force_SM        = &H1
    End Property

    Property Get read_link_en_force_SM
        read
        read_link_en_force_SM = read_link_en_force_SM_value
    End Property

    Property Let write_link_en_force_SM(aData)
        set_link_en_force_SM = aData
        write
    End Property

    Property Get get_link_en_r
        get_link_en_r = read_link_en_r_value
    End Property

    Property Let set_link_en_r(aData)
        write_link_en_r_value = aData
        flag_link_en_r        = &H1
    End Property

    Property Get read_link_en_r
        read
        read_link_en_r = read_link_en_r_value
    End Property

    Property Let write_link_en_r(aData)
        set_link_en_r = aData
        write
    End Property

    Property Get get_rx_polarity_force_SM
        get_rx_polarity_force_SM = read_rx_polarity_force_SM_value
    End Property

    Property Let set_rx_polarity_force_SM(aData)
        write_rx_polarity_force_SM_value = aData
        flag_rx_polarity_force_SM        = &H1
    End Property

    Property Get read_rx_polarity_force_SM
        read
        read_rx_polarity_force_SM = read_rx_polarity_force_SM_value
    End Property

    Property Let write_rx_polarity_force_SM(aData)
        set_rx_polarity_force_SM = aData
        write
    End Property

    Property Get get_rx_polarity_r
        get_rx_polarity_r = read_rx_polarity_r_value
    End Property

    Property Let set_rx_polarity_r(aData)
        write_rx_polarity_r_value = aData
        flag_rx_polarity_r        = &H1
    End Property

    Property Get read_rx_polarity_r
        read
        read_rx_polarity_r = read_rx_polarity_r_value
    End Property

    Property Let write_rx_polarity_r(aData)
        set_rx_polarity_r = aData
        write
    End Property

    Property Get get_rxd1g_dec_dis_force_SM
        get_rxd1g_dec_dis_force_SM = read_rxd1g_dec_dis_force_SM_value
    End Property

    Property Let set_rxd1g_dec_dis_force_SM(aData)
        write_rxd1g_dec_dis_force_SM_value = aData
        flag_rxd1g_dec_dis_force_SM        = &H1
    End Property

    Property Get read_rxd1g_dec_dis_force_SM
        read
        read_rxd1g_dec_dis_force_SM = read_rxd1g_dec_dis_force_SM_value
    End Property

    Property Let write_rxd1g_dec_dis_force_SM(aData)
        set_rxd1g_dec_dis_force_SM = aData
        write
    End Property

    Property Get get_rxd1g_dec_dis_r
        get_rxd1g_dec_dis_r = read_rxd1g_dec_dis_r_value
    End Property

    Property Let set_rxd1g_dec_dis_r(aData)
        write_rxd1g_dec_dis_r_value = aData
        flag_rxd1g_dec_dis_r        = &H1
    End Property

    Property Get read_rxd1g_dec_dis_r
        read
        read_rxd1g_dec_dis_r = read_rxd1g_dec_dis_r_value
    End Property

    Property Let write_rxd1g_dec_dis_r(aData)
        set_rxd1g_dec_dis_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_L0s_SM_value = rightShift(data_low, 15) and &H1
        read_comma_mask_force_r_value = rightShift(data_low, 14) and &H1
        read_comma_mask_r_value = rightShift(data_low, 13) and &H1
        read_statMuxRegDis_value = rightShift(data_low, 12) and &H1
        read_sync_status_force_r_SM_value = rightShift(data_low, 11) and &H1
        read_sync_status_force_r_value = rightShift(data_low, 10) and &H1
        read_comma_adj_en_force_ext_SM_value = rightShift(data_low, 9) and &H1
        read_comma_adj_en_force_sync_SM_value = rightShift(data_low, 8) and &H1
        read_comma_adj_en_force_r_SM_value = rightShift(data_low, 7) and &H1
        read_comma_adj_en_r_value = rightShift(data_low, 6) and &H1
        read_link_en_force_SM_value = rightShift(data_low, 5) and &H1
        read_link_en_r_value = rightShift(data_low, 4) and &H1
        read_rx_polarity_force_SM_value = rightShift(data_low, 3) and &H1
        read_rx_polarity_r_value = rightShift(data_low, 2) and &H1
        read_rxd1g_dec_dis_force_SM_value = rightShift(data_low, 1) and &H1
        rxd1g_dec_dis_r_mask = &H1
        if data_low > LONG_MAX then
            if rxd1g_dec_dis_r_mask = mask then
                read_rxd1g_dec_dis_r_value = data_low
            else
                read_rxd1g_dec_dis_r_value = (data_low - H8000_0000) and rxd1g_dec_dis_r_mask
            end If
        else
            read_rxd1g_dec_dis_r_value = data_low and rxd1g_dec_dis_r_mask
        end If

    End Sub

    Sub write
        If flag_prbs_L0s_SM = &H0 or flag_comma_mask_force_r = &H0 or flag_comma_mask_r = &H0 or flag_statMuxRegDis = &H0 or flag_sync_status_force_r_SM = &H0 or flag_sync_status_force_r = &H0 or flag_comma_adj_en_force_ext_SM = &H0 or flag_comma_adj_en_force_sync_SM = &H0 or flag_comma_adj_en_force_r_SM = &H0 or flag_comma_adj_en_r = &H0 or flag_link_en_force_SM = &H0 or flag_link_en_r = &H0 or flag_rx_polarity_force_SM = &H0 or flag_rx_polarity_r = &H0 or flag_rxd1g_dec_dis_force_SM = &H0 or flag_rxd1g_dec_dis_r = &H0 Then read
        If flag_prbs_L0s_SM = &H0 Then write_prbs_L0s_SM_value = get_prbs_L0s_SM
        If flag_comma_mask_force_r = &H0 Then write_comma_mask_force_r_value = get_comma_mask_force_r
        If flag_comma_mask_r = &H0 Then write_comma_mask_r_value = get_comma_mask_r
        If flag_statMuxRegDis = &H0 Then write_statMuxRegDis_value = get_statMuxRegDis
        If flag_sync_status_force_r_SM = &H0 Then write_sync_status_force_r_SM_value = get_sync_status_force_r_SM
        If flag_sync_status_force_r = &H0 Then write_sync_status_force_r_value = get_sync_status_force_r
        If flag_comma_adj_en_force_ext_SM = &H0 Then write_comma_adj_en_force_ext_SM_value = get_comma_adj_en_force_ext_SM
        If flag_comma_adj_en_force_sync_SM = &H0 Then write_comma_adj_en_force_sync_SM_value = get_comma_adj_en_force_sync_SM
        If flag_comma_adj_en_force_r_SM = &H0 Then write_comma_adj_en_force_r_SM_value = get_comma_adj_en_force_r_SM
        If flag_comma_adj_en_r = &H0 Then write_comma_adj_en_r_value = get_comma_adj_en_r
        If flag_link_en_force_SM = &H0 Then write_link_en_force_SM_value = get_link_en_force_SM
        If flag_link_en_r = &H0 Then write_link_en_r_value = get_link_en_r
        If flag_rx_polarity_force_SM = &H0 Then write_rx_polarity_force_SM_value = get_rx_polarity_force_SM
        If flag_rx_polarity_r = &H0 Then write_rx_polarity_r_value = get_rx_polarity_r
        If flag_rxd1g_dec_dis_force_SM = &H0 Then write_rxd1g_dec_dis_force_SM_value = get_rxd1g_dec_dis_force_SM
        If flag_rxd1g_dec_dis_r = &H0 Then write_rxd1g_dec_dis_r_value = get_rxd1g_dec_dis_r

        regValue = leftShift((write_prbs_L0s_SM_value and &H1), 15) + leftShift((write_comma_mask_force_r_value and &H1), 14) + leftShift((write_comma_mask_r_value and &H1), 13) + leftShift((write_statMuxRegDis_value and &H1), 12) + leftShift((write_sync_status_force_r_SM_value and &H1), 11) + leftShift((write_sync_status_force_r_value and &H1), 10) + leftShift((write_comma_adj_en_force_ext_SM_value and &H1), 9) + leftShift((write_comma_adj_en_force_sync_SM_value and &H1), 8) + leftShift((write_comma_adj_en_force_r_SM_value and &H1), 7) + leftShift((write_comma_adj_en_r_value and &H1), 6) + leftShift((write_link_en_force_SM_value and &H1), 5) + leftShift((write_link_en_r_value and &H1), 4) + leftShift((write_rx_polarity_force_SM_value and &H1), 3) + leftShift((write_rx_polarity_r_value and &H1), 2) + leftShift((write_rxd1g_dec_dis_force_SM_value and &H1), 1) + leftShift((write_rxd1g_dec_dis_r_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_L0s_SM_value = rightShift(data_low, 15) and &H1
        read_comma_mask_force_r_value = rightShift(data_low, 14) and &H1
        read_comma_mask_r_value = rightShift(data_low, 13) and &H1
        read_statMuxRegDis_value = rightShift(data_low, 12) and &H1
        read_sync_status_force_r_SM_value = rightShift(data_low, 11) and &H1
        read_sync_status_force_r_value = rightShift(data_low, 10) and &H1
        read_comma_adj_en_force_ext_SM_value = rightShift(data_low, 9) and &H1
        read_comma_adj_en_force_sync_SM_value = rightShift(data_low, 8) and &H1
        read_comma_adj_en_force_r_SM_value = rightShift(data_low, 7) and &H1
        read_comma_adj_en_r_value = rightShift(data_low, 6) and &H1
        read_link_en_force_SM_value = rightShift(data_low, 5) and &H1
        read_link_en_r_value = rightShift(data_low, 4) and &H1
        read_rx_polarity_force_SM_value = rightShift(data_low, 3) and &H1
        read_rx_polarity_r_value = rightShift(data_low, 2) and &H1
        read_rxd1g_dec_dis_force_SM_value = rightShift(data_low, 1) and &H1
        rxd1g_dec_dis_r_mask = &H1
        if data_low > LONG_MAX then
            if rxd1g_dec_dis_r_mask = mask then
                read_rxd1g_dec_dis_r_value = data_low
            else
                read_rxd1g_dec_dis_r_value = (data_low - H8000_0000) and rxd1g_dec_dis_r_mask
            end If
        else
            read_rxd1g_dec_dis_r_value = data_low and rxd1g_dec_dis_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_L0s_SM_value = &H0
        flag_prbs_L0s_SM        = &H0
        write_comma_mask_force_r_value = &H0
        flag_comma_mask_force_r        = &H0
        write_comma_mask_r_value = &H0
        flag_comma_mask_r        = &H0
        write_statMuxRegDis_value = &H0
        flag_statMuxRegDis        = &H0
        write_sync_status_force_r_SM_value = &H0
        flag_sync_status_force_r_SM        = &H0
        write_sync_status_force_r_value = &H0
        flag_sync_status_force_r        = &H0
        write_comma_adj_en_force_ext_SM_value = &H0
        flag_comma_adj_en_force_ext_SM        = &H0
        write_comma_adj_en_force_sync_SM_value = &H0
        flag_comma_adj_en_force_sync_SM        = &H0
        write_comma_adj_en_force_r_SM_value = &H0
        flag_comma_adj_en_force_r_SM        = &H0
        write_comma_adj_en_r_value = &H0
        flag_comma_adj_en_r        = &H0
        write_link_en_force_SM_value = &H0
        flag_link_en_force_SM        = &H0
        write_link_en_r_value = &H0
        flag_link_en_r        = &H0
        write_rx_polarity_force_SM_value = &H0
        flag_rx_polarity_force_SM        = &H0
        write_rx_polarity_r_value = &H0
        flag_rx_polarity_r        = &H0
        write_rxd1g_dec_dis_force_SM_value = &H0
        flag_rxd1g_dec_dis_force_SM        = &H0
        write_rxd1g_dec_dis_r_value = &H0
        flag_rxd1g_dec_dis_r        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ClrRxStatusLatched                         [15:15]          get_ClrRxStatusLatched
''                                                             set_ClrRxStatusLatched
''                                                             read_ClrRxStatusLatched
''                                                             write_ClrRxStatusLatched
''---------------------------------------------------------------------------------
'' mdio_EIOS_detect_17C_only                  [13:13]          get_mdio_EIOS_detect_17C_only
''                                                             set_mdio_EIOS_detect_17C_only
''                                                             read_mdio_EIOS_detect_17C_only
''                                                             write_mdio_EIOS_detect_17C_only
''---------------------------------------------------------------------------------
'' mdio_1st_EIOS_detect_sel                   [12:12]          get_mdio_1st_EIOS_detect_sel
''                                                             set_mdio_1st_EIOS_detect_sel
''                                                             read_mdio_1st_EIOS_detect_sel
''                                                             write_mdio_1st_EIOS_detect_sel
''---------------------------------------------------------------------------------
'' mdio_FiltBypass                            [11:11]          get_mdio_FiltBypass
''                                                             set_mdio_FiltBypass
''                                                             read_mdio_FiltBypass
''                                                             write_mdio_FiltBypass
''---------------------------------------------------------------------------------
'' mdio_FiltInGen1                            [10:10]          get_mdio_FiltInGen1
''                                                             set_mdio_FiltInGen1
''                                                             read_mdio_FiltInGen1
''                                                             write_mdio_FiltInGen1
''---------------------------------------------------------------------------------
'' mdio_FiltLatchSel                          [9:9]            get_mdio_FiltLatchSel
''                                                             set_mdio_FiltLatchSel
''                                                             read_mdio_FiltLatchSel
''                                                             write_mdio_FiltLatchSel
''---------------------------------------------------------------------------------
'' ckcmp_event_clr_dis                        [8:8]            get_ckcmp_event_clr_dis
''                                                             set_ckcmp_event_clr_dis
''                                                             read_ckcmp_event_clr_dis
''                                                             write_ckcmp_event_clr_dis
''---------------------------------------------------------------------------------
'' ckcmp_wr_event_sel                         [7:4]            get_ckcmp_wr_event_sel
''                                                             set_ckcmp_wr_event_sel
''                                                             read_ckcmp_wr_event_sel
''                                                             write_ckcmp_wr_event_sel
''---------------------------------------------------------------------------------
'' ckcmp_rd_event_sel                         [3:0]            get_ckcmp_rd_event_sel
''                                                             set_ckcmp_rd_event_sel
''                                                             read_ckcmp_rd_event_sel
''                                                             write_ckcmp_rd_event_sel
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_control2
    Private write_ClrRxStatusLatched_value
    Private read_ClrRxStatusLatched_value
    Private flag_ClrRxStatusLatched
    Private write_mdio_EIOS_detect_17C_only_value
    Private read_mdio_EIOS_detect_17C_only_value
    Private flag_mdio_EIOS_detect_17C_only
    Private write_mdio_1st_EIOS_detect_sel_value
    Private read_mdio_1st_EIOS_detect_sel_value
    Private flag_mdio_1st_EIOS_detect_sel
    Private write_mdio_FiltBypass_value
    Private read_mdio_FiltBypass_value
    Private flag_mdio_FiltBypass
    Private write_mdio_FiltInGen1_value
    Private read_mdio_FiltInGen1_value
    Private flag_mdio_FiltInGen1
    Private write_mdio_FiltLatchSel_value
    Private read_mdio_FiltLatchSel_value
    Private flag_mdio_FiltLatchSel
    Private write_ckcmp_event_clr_dis_value
    Private read_ckcmp_event_clr_dis_value
    Private flag_ckcmp_event_clr_dis
    Private write_ckcmp_wr_event_sel_value
    Private read_ckcmp_wr_event_sel_value
    Private flag_ckcmp_wr_event_sel
    Private write_ckcmp_rd_event_sel_value
    Private read_ckcmp_rd_event_sel_value
    Private flag_ckcmp_rd_event_sel

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

    Property Get get_ClrRxStatusLatched
        get_ClrRxStatusLatched = read_ClrRxStatusLatched_value
    End Property

    Property Let set_ClrRxStatusLatched(aData)
        write_ClrRxStatusLatched_value = aData
        flag_ClrRxStatusLatched        = &H1
    End Property

    Property Get read_ClrRxStatusLatched
        read
        read_ClrRxStatusLatched = read_ClrRxStatusLatched_value
    End Property

    Property Let write_ClrRxStatusLatched(aData)
        set_ClrRxStatusLatched = aData
        write
    End Property

    Property Get get_mdio_EIOS_detect_17C_only
        get_mdio_EIOS_detect_17C_only = read_mdio_EIOS_detect_17C_only_value
    End Property

    Property Let set_mdio_EIOS_detect_17C_only(aData)
        write_mdio_EIOS_detect_17C_only_value = aData
        flag_mdio_EIOS_detect_17C_only        = &H1
    End Property

    Property Get read_mdio_EIOS_detect_17C_only
        read
        read_mdio_EIOS_detect_17C_only = read_mdio_EIOS_detect_17C_only_value
    End Property

    Property Let write_mdio_EIOS_detect_17C_only(aData)
        set_mdio_EIOS_detect_17C_only = aData
        write
    End Property

    Property Get get_mdio_1st_EIOS_detect_sel
        get_mdio_1st_EIOS_detect_sel = read_mdio_1st_EIOS_detect_sel_value
    End Property

    Property Let set_mdio_1st_EIOS_detect_sel(aData)
        write_mdio_1st_EIOS_detect_sel_value = aData
        flag_mdio_1st_EIOS_detect_sel        = &H1
    End Property

    Property Get read_mdio_1st_EIOS_detect_sel
        read
        read_mdio_1st_EIOS_detect_sel = read_mdio_1st_EIOS_detect_sel_value
    End Property

    Property Let write_mdio_1st_EIOS_detect_sel(aData)
        set_mdio_1st_EIOS_detect_sel = aData
        write
    End Property

    Property Get get_mdio_FiltBypass
        get_mdio_FiltBypass = read_mdio_FiltBypass_value
    End Property

    Property Let set_mdio_FiltBypass(aData)
        write_mdio_FiltBypass_value = aData
        flag_mdio_FiltBypass        = &H1
    End Property

    Property Get read_mdio_FiltBypass
        read
        read_mdio_FiltBypass = read_mdio_FiltBypass_value
    End Property

    Property Let write_mdio_FiltBypass(aData)
        set_mdio_FiltBypass = aData
        write
    End Property

    Property Get get_mdio_FiltInGen1
        get_mdio_FiltInGen1 = read_mdio_FiltInGen1_value
    End Property

    Property Let set_mdio_FiltInGen1(aData)
        write_mdio_FiltInGen1_value = aData
        flag_mdio_FiltInGen1        = &H1
    End Property

    Property Get read_mdio_FiltInGen1
        read
        read_mdio_FiltInGen1 = read_mdio_FiltInGen1_value
    End Property

    Property Let write_mdio_FiltInGen1(aData)
        set_mdio_FiltInGen1 = aData
        write
    End Property

    Property Get get_mdio_FiltLatchSel
        get_mdio_FiltLatchSel = read_mdio_FiltLatchSel_value
    End Property

    Property Let set_mdio_FiltLatchSel(aData)
        write_mdio_FiltLatchSel_value = aData
        flag_mdio_FiltLatchSel        = &H1
    End Property

    Property Get read_mdio_FiltLatchSel
        read
        read_mdio_FiltLatchSel = read_mdio_FiltLatchSel_value
    End Property

    Property Let write_mdio_FiltLatchSel(aData)
        set_mdio_FiltLatchSel = aData
        write
    End Property

    Property Get get_ckcmp_event_clr_dis
        get_ckcmp_event_clr_dis = read_ckcmp_event_clr_dis_value
    End Property

    Property Let set_ckcmp_event_clr_dis(aData)
        write_ckcmp_event_clr_dis_value = aData
        flag_ckcmp_event_clr_dis        = &H1
    End Property

    Property Get read_ckcmp_event_clr_dis
        read
        read_ckcmp_event_clr_dis = read_ckcmp_event_clr_dis_value
    End Property

    Property Let write_ckcmp_event_clr_dis(aData)
        set_ckcmp_event_clr_dis = aData
        write
    End Property

    Property Get get_ckcmp_wr_event_sel
        get_ckcmp_wr_event_sel = read_ckcmp_wr_event_sel_value
    End Property

    Property Let set_ckcmp_wr_event_sel(aData)
        write_ckcmp_wr_event_sel_value = aData
        flag_ckcmp_wr_event_sel        = &H1
    End Property

    Property Get read_ckcmp_wr_event_sel
        read
        read_ckcmp_wr_event_sel = read_ckcmp_wr_event_sel_value
    End Property

    Property Let write_ckcmp_wr_event_sel(aData)
        set_ckcmp_wr_event_sel = aData
        write
    End Property

    Property Get get_ckcmp_rd_event_sel
        get_ckcmp_rd_event_sel = read_ckcmp_rd_event_sel_value
    End Property

    Property Let set_ckcmp_rd_event_sel(aData)
        write_ckcmp_rd_event_sel_value = aData
        flag_ckcmp_rd_event_sel        = &H1
    End Property

    Property Get read_ckcmp_rd_event_sel
        read
        read_ckcmp_rd_event_sel = read_ckcmp_rd_event_sel_value
    End Property

    Property Let write_ckcmp_rd_event_sel(aData)
        set_ckcmp_rd_event_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ClrRxStatusLatched_value = rightShift(data_low, 15) and &H1
        read_mdio_EIOS_detect_17C_only_value = rightShift(data_low, 13) and &H1
        read_mdio_1st_EIOS_detect_sel_value = rightShift(data_low, 12) and &H1
        read_mdio_FiltBypass_value = rightShift(data_low, 11) and &H1
        read_mdio_FiltInGen1_value = rightShift(data_low, 10) and &H1
        read_mdio_FiltLatchSel_value = rightShift(data_low, 9) and &H1
        read_ckcmp_event_clr_dis_value = rightShift(data_low, 8) and &H1
        read_ckcmp_wr_event_sel_value = rightShift(data_low, 4) and &Hf
        ckcmp_rd_event_sel_mask = &Hf
        if data_low > LONG_MAX then
            if ckcmp_rd_event_sel_mask = mask then
                read_ckcmp_rd_event_sel_value = data_low
            else
                read_ckcmp_rd_event_sel_value = (data_low - H8000_0000) and ckcmp_rd_event_sel_mask
            end If
        else
            read_ckcmp_rd_event_sel_value = data_low and ckcmp_rd_event_sel_mask
        end If

    End Sub

    Sub write
        If flag_ClrRxStatusLatched = &H0 or flag_mdio_EIOS_detect_17C_only = &H0 or flag_mdio_1st_EIOS_detect_sel = &H0 or flag_mdio_FiltBypass = &H0 or flag_mdio_FiltInGen1 = &H0 or flag_mdio_FiltLatchSel = &H0 or flag_ckcmp_event_clr_dis = &H0 or flag_ckcmp_wr_event_sel = &H0 or flag_ckcmp_rd_event_sel = &H0 Then read
        If flag_ClrRxStatusLatched = &H0 Then write_ClrRxStatusLatched_value = get_ClrRxStatusLatched
        If flag_mdio_EIOS_detect_17C_only = &H0 Then write_mdio_EIOS_detect_17C_only_value = get_mdio_EIOS_detect_17C_only
        If flag_mdio_1st_EIOS_detect_sel = &H0 Then write_mdio_1st_EIOS_detect_sel_value = get_mdio_1st_EIOS_detect_sel
        If flag_mdio_FiltBypass = &H0 Then write_mdio_FiltBypass_value = get_mdio_FiltBypass
        If flag_mdio_FiltInGen1 = &H0 Then write_mdio_FiltInGen1_value = get_mdio_FiltInGen1
        If flag_mdio_FiltLatchSel = &H0 Then write_mdio_FiltLatchSel_value = get_mdio_FiltLatchSel
        If flag_ckcmp_event_clr_dis = &H0 Then write_ckcmp_event_clr_dis_value = get_ckcmp_event_clr_dis
        If flag_ckcmp_wr_event_sel = &H0 Then write_ckcmp_wr_event_sel_value = get_ckcmp_wr_event_sel
        If flag_ckcmp_rd_event_sel = &H0 Then write_ckcmp_rd_event_sel_value = get_ckcmp_rd_event_sel

        regValue = leftShift((write_ClrRxStatusLatched_value and &H1), 15) + leftShift((write_mdio_EIOS_detect_17C_only_value and &H1), 13) + leftShift((write_mdio_1st_EIOS_detect_sel_value and &H1), 12) + leftShift((write_mdio_FiltBypass_value and &H1), 11) + leftShift((write_mdio_FiltInGen1_value and &H1), 10) + leftShift((write_mdio_FiltLatchSel_value and &H1), 9) + leftShift((write_ckcmp_event_clr_dis_value and &H1), 8) + leftShift((write_ckcmp_wr_event_sel_value and &Hf), 4) + leftShift((write_ckcmp_rd_event_sel_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ClrRxStatusLatched_value = rightShift(data_low, 15) and &H1
        read_mdio_EIOS_detect_17C_only_value = rightShift(data_low, 13) and &H1
        read_mdio_1st_EIOS_detect_sel_value = rightShift(data_low, 12) and &H1
        read_mdio_FiltBypass_value = rightShift(data_low, 11) and &H1
        read_mdio_FiltInGen1_value = rightShift(data_low, 10) and &H1
        read_mdio_FiltLatchSel_value = rightShift(data_low, 9) and &H1
        read_ckcmp_event_clr_dis_value = rightShift(data_low, 8) and &H1
        read_ckcmp_wr_event_sel_value = rightShift(data_low, 4) and &Hf
        ckcmp_rd_event_sel_mask = &Hf
        if data_low > LONG_MAX then
            if ckcmp_rd_event_sel_mask = mask then
                read_ckcmp_rd_event_sel_value = data_low
            else
                read_ckcmp_rd_event_sel_value = (data_low - H8000_0000) and ckcmp_rd_event_sel_mask
            end If
        else
            read_ckcmp_rd_event_sel_value = data_low and ckcmp_rd_event_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ClrRxStatusLatched_value = &H0
        flag_ClrRxStatusLatched        = &H0
        write_mdio_EIOS_detect_17C_only_value = &H0
        flag_mdio_EIOS_detect_17C_only        = &H0
        write_mdio_1st_EIOS_detect_sel_value = &H0
        flag_mdio_1st_EIOS_detect_sel        = &H0
        write_mdio_FiltBypass_value = &H0
        flag_mdio_FiltBypass        = &H0
        write_mdio_FiltInGen1_value = &H0
        flag_mdio_FiltInGen1        = &H0
        write_mdio_FiltLatchSel_value = &H0
        flag_mdio_FiltLatchSel        = &H0
        write_ckcmp_event_clr_dis_value = &H0
        flag_ckcmp_event_clr_dis        = &H0
        write_ckcmp_wr_event_sel_value = &H0
        flag_ckcmp_wr_event_sel        = &H0
        write_ckcmp_rd_event_sel_value = &H0
        flag_ckcmp_rd_event_sel        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE0__SGMIIPCIE_X1_rxstatuslatched
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RxStatusLatched                            [15:0]           get_RxStatusLatched
''                                                             set_RxStatusLatched
''                                                             read_RxStatusLatched
''                                                             write_RxStatusLatched
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE0__SGMIIPCIE_X1_rxstatuslatched
    Private write_RxStatusLatched_value
    Private read_RxStatusLatched_value
    Private flag_RxStatusLatched

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

    Property Get get_RxStatusLatched
        get_RxStatusLatched = read_RxStatusLatched_value
    End Property

    Property Let set_RxStatusLatched(aData)
        write_RxStatusLatched_value = aData
        flag_RxStatusLatched        = &H1
    End Property

    Property Get read_RxStatusLatched
        read
        read_RxStatusLatched = read_RxStatusLatched_value
    End Property

    Property Let write_RxStatusLatched(aData)
        set_RxStatusLatched = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RxStatusLatched_mask = &Hffff
        if data_low > LONG_MAX then
            if RxStatusLatched_mask = mask then
                read_RxStatusLatched_value = data_low
            else
                read_RxStatusLatched_value = (data_low - H8000_0000) and RxStatusLatched_mask
            end If
        else
            read_RxStatusLatched_value = data_low and RxStatusLatched_mask
        end If

    End Sub

    Sub write
        If flag_RxStatusLatched = &H0 Then read
        If flag_RxStatusLatched = &H0 Then write_RxStatusLatched_value = get_RxStatusLatched

        regValue = leftShift((write_RxStatusLatched_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RxStatusLatched_mask = &Hffff
        if data_low > LONG_MAX then
            if RxStatusLatched_mask = mask then
                read_RxStatusLatched_value = data_low
            else
                read_RxStatusLatched_value = (data_low - H8000_0000) and RxStatusLatched_mask
            end If
        else
            read_RxStatusLatched_value = data_low and RxStatusLatched_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RxStatusLatched_value = &H0
        flag_RxStatusLatched        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_DFE0__SGMIIPCIE_X1_INSTANCE

    Public status
    Public control
    Public timer1
    Public status2
    Public sigdet
    Public cdr_phase
    Public cdr_freq
    Public control1g
    Public control_pci
    Public control2
    Public rxstatuslatched


    Public default function Init(aBaseAddr)
        Set status = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_status)(aBaseAddr, 16)
        Set control = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_control)(aBaseAddr, 16)
        Set timer1 = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_timer1)(aBaseAddr, 16)
        Set status2 = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_status2)(aBaseAddr, 16)
        Set sigdet = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_sigdet)(aBaseAddr, 16)
        Set cdr_phase = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_cdr_phase)(aBaseAddr, 16)
        Set cdr_freq = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_cdr_freq)(aBaseAddr, 16)
        Set control1g = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_control1g)(aBaseAddr, 16)
        Set control_pci = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_control_pci)(aBaseAddr, 16)
        Set control2 = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_control2)(aBaseAddr, 16)
        Set rxstatuslatched = (New REGISTER_RX_DFE0__SGMIIPCIE_X1_rxstatuslatched)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_DFE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX_DFE0__SGMIIPCIE_X1.Add ((New RX_DFE0__SGMIIPCIE_X1_INSTANCE)(&H4adee000))


