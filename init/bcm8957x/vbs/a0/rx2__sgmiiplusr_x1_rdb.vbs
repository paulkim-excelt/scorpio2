

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


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxseq0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeTrckNrml_SM                     [15:8]           get_cdrLockTimeTrckNrml_SM
''                                                             set_cdrLockTimeTrckNrml_SM
''                                                             read_cdrLockTimeTrckNrml_SM
''                                                             write_cdrLockTimeTrckNrml_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeAcq_S1_SM                       [7:0]            get_cdrLockTimeAcq_S1_SM
''                                                             set_cdrLockTimeAcq_S1_SM
''                                                             read_cdrLockTimeAcq_S1_SM
''                                                             write_cdrLockTimeAcq_S1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_rxseq0
    Private write_cdrLockTimeTrckNrml_SM_value
    Private read_cdrLockTimeTrckNrml_SM_value
    Private flag_cdrLockTimeTrckNrml_SM
    Private write_cdrLockTimeAcq_S1_SM_value
    Private read_cdrLockTimeAcq_S1_SM_value
    Private flag_cdrLockTimeAcq_S1_SM

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

    Property Get get_cdrLockTimeTrckNrml_SM
        get_cdrLockTimeTrckNrml_SM = read_cdrLockTimeTrckNrml_SM_value
    End Property

    Property Let set_cdrLockTimeTrckNrml_SM(aData)
        write_cdrLockTimeTrckNrml_SM_value = aData
        flag_cdrLockTimeTrckNrml_SM        = &H1
    End Property

    Property Get read_cdrLockTimeTrckNrml_SM
        read
        read_cdrLockTimeTrckNrml_SM = read_cdrLockTimeTrckNrml_SM_value
    End Property

    Property Let write_cdrLockTimeTrckNrml_SM(aData)
        set_cdrLockTimeTrckNrml_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeAcq_S1_SM
        get_cdrLockTimeAcq_S1_SM = read_cdrLockTimeAcq_S1_SM_value
    End Property

    Property Let set_cdrLockTimeAcq_S1_SM(aData)
        write_cdrLockTimeAcq_S1_SM_value = aData
        flag_cdrLockTimeAcq_S1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcq_S1_SM
        read
        read_cdrLockTimeAcq_S1_SM = read_cdrLockTimeAcq_S1_SM_value
    End Property

    Property Let write_cdrLockTimeAcq_S1_SM(aData)
        set_cdrLockTimeAcq_S1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeTrckNrml_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcq_S1_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcq_S1_SM_mask = mask then
                read_cdrLockTimeAcq_S1_SM_value = data_low
            else
                read_cdrLockTimeAcq_S1_SM_value = (data_low - H8000_0000) and cdrLockTimeAcq_S1_SM_mask
            end If
        else
            read_cdrLockTimeAcq_S1_SM_value = data_low and cdrLockTimeAcq_S1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeTrckNrml_SM = &H0 or flag_cdrLockTimeAcq_S1_SM = &H0 Then read
        If flag_cdrLockTimeTrckNrml_SM = &H0 Then write_cdrLockTimeTrckNrml_SM_value = get_cdrLockTimeTrckNrml_SM
        If flag_cdrLockTimeAcq_S1_SM = &H0 Then write_cdrLockTimeAcq_S1_SM_value = get_cdrLockTimeAcq_S1_SM

        regValue = leftShift((write_cdrLockTimeTrckNrml_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeAcq_S1_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeTrckNrml_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcq_S1_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcq_S1_SM_mask = mask then
                read_cdrLockTimeAcq_S1_SM_value = data_low
            else
                read_cdrLockTimeAcq_S1_SM_value = (data_low - H8000_0000) and cdrLockTimeAcq_S1_SM_mask
            end If
        else
            read_cdrLockTimeAcq_S1_SM_value = data_low and cdrLockTimeAcq_S1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeTrckNrml_SM_value = &H0
        flag_cdrLockTimeTrckNrml_SM        = &H0
        write_cdrLockTimeAcq_S1_SM_value = &H0
        flag_cdrLockTimeAcq_S1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxseq1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcq_S2_SM                       [15:8]           get_cdrLockTimeAcq_S2_SM
''                                                             set_cdrLockTimeAcq_S2_SM
''                                                             read_cdrLockTimeAcq_S2_SM
''                                                             write_cdrLockTimeAcq_S2_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeAcq_S3_SM                       [7:0]            get_cdrLockTimeAcq_S3_SM
''                                                             set_cdrLockTimeAcq_S3_SM
''                                                             read_cdrLockTimeAcq_S3_SM
''                                                             write_cdrLockTimeAcq_S3_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_rxseq1
    Private write_cdrLockTimeAcq_S2_SM_value
    Private read_cdrLockTimeAcq_S2_SM_value
    Private flag_cdrLockTimeAcq_S2_SM
    Private write_cdrLockTimeAcq_S3_SM_value
    Private read_cdrLockTimeAcq_S3_SM_value
    Private flag_cdrLockTimeAcq_S3_SM

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

    Property Get get_cdrLockTimeAcq_S2_SM
        get_cdrLockTimeAcq_S2_SM = read_cdrLockTimeAcq_S2_SM_value
    End Property

    Property Let set_cdrLockTimeAcq_S2_SM(aData)
        write_cdrLockTimeAcq_S2_SM_value = aData
        flag_cdrLockTimeAcq_S2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcq_S2_SM
        read
        read_cdrLockTimeAcq_S2_SM = read_cdrLockTimeAcq_S2_SM_value
    End Property

    Property Let write_cdrLockTimeAcq_S2_SM(aData)
        set_cdrLockTimeAcq_S2_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeAcq_S3_SM
        get_cdrLockTimeAcq_S3_SM = read_cdrLockTimeAcq_S3_SM_value
    End Property

    Property Let set_cdrLockTimeAcq_S3_SM(aData)
        write_cdrLockTimeAcq_S3_SM_value = aData
        flag_cdrLockTimeAcq_S3_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcq_S3_SM
        read
        read_cdrLockTimeAcq_S3_SM = read_cdrLockTimeAcq_S3_SM_value
    End Property

    Property Let write_cdrLockTimeAcq_S3_SM(aData)
        set_cdrLockTimeAcq_S3_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcq_S2_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcq_S3_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcq_S3_SM_mask = mask then
                read_cdrLockTimeAcq_S3_SM_value = data_low
            else
                read_cdrLockTimeAcq_S3_SM_value = (data_low - H8000_0000) and cdrLockTimeAcq_S3_SM_mask
            end If
        else
            read_cdrLockTimeAcq_S3_SM_value = data_low and cdrLockTimeAcq_S3_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcq_S2_SM = &H0 or flag_cdrLockTimeAcq_S3_SM = &H0 Then read
        If flag_cdrLockTimeAcq_S2_SM = &H0 Then write_cdrLockTimeAcq_S2_SM_value = get_cdrLockTimeAcq_S2_SM
        If flag_cdrLockTimeAcq_S3_SM = &H0 Then write_cdrLockTimeAcq_S3_SM_value = get_cdrLockTimeAcq_S3_SM

        regValue = leftShift((write_cdrLockTimeAcq_S2_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeAcq_S3_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcq_S2_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcq_S3_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcq_S3_SM_mask = mask then
                read_cdrLockTimeAcq_S3_SM_value = data_low
            else
                read_cdrLockTimeAcq_S3_SM_value = (data_low - H8000_0000) and cdrLockTimeAcq_S3_SM_mask
            end If
        else
            read_cdrLockTimeAcq_S3_SM_value = data_low and cdrLockTimeAcq_S3_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcq_S2_SM_value = &H0
        flag_cdrLockTimeAcq_S2_SM        = &H0
        write_cdrLockTimeAcq_S3_SM_value = &H0
        flag_cdrLockTimeAcq_S3_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxcdr0
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
'' em_phase_shift_360_ovrd_val                [11:11]          get_em_phase_shift_360_ovrd_val
''                                                             set_em_phase_shift_360_ovrd_val
''                                                             read_em_phase_shift_360_ovrd_val
''                                                             write_em_phase_shift_360_ovrd_val
''---------------------------------------------------------------------------------
'' em_phase_shift_360_ovrd                    [10:10]          get_em_phase_shift_360_ovrd
''                                                             set_em_phase_shift_360_ovrd
''                                                             read_em_phase_shift_360_ovrd
''                                                             write_em_phase_shift_360_ovrd
''---------------------------------------------------------------------------------
'' rx_interp_ctrl_cap                         [9:9]            get_rx_interp_ctrl_cap
''                                                             set_rx_interp_ctrl_cap
''                                                             read_rx_interp_ctrl_cap
''                                                             write_rx_interp_ctrl_cap
''---------------------------------------------------------------------------------
'' rx_interp_status_sel                       [8:6]            get_rx_interp_status_sel
''                                                             set_rx_interp_status_sel
''                                                             read_rx_interp_status_sel
''                                                             write_rx_interp_status_sel
''---------------------------------------------------------------------------------
'' pi_clk90_offset_override                   [5:5]            get_pi_clk90_offset_override
''                                                             set_pi_clk90_offset_override
''                                                             read_pi_clk90_offset_override
''                                                             write_pi_clk90_offset_override
''---------------------------------------------------------------------------------
'' pi_phase_rotate_override                   [4:4]            get_pi_phase_rotate_override
''                                                             set_pi_phase_rotate_override
''                                                             read_pi_phase_rotate_override
''                                                             write_pi_phase_rotate_override
''---------------------------------------------------------------------------------
'' mdio_em_err_cnt_clr                        [3:3]            get_mdio_em_err_cnt_clr
''                                                             set_mdio_em_err_cnt_clr
''                                                             read_mdio_em_err_cnt_clr
''                                                             write_mdio_em_err_cnt_clr
''---------------------------------------------------------------------------------
'' mdio_em_err_cnt_frz                        [2:2]            get_mdio_em_err_cnt_frz
''                                                             set_mdio_em_err_cnt_frz
''                                                             read_mdio_em_err_cnt_frz
''                                                             write_mdio_em_err_cnt_frz
''---------------------------------------------------------------------------------
'' mdio_em_pwrdn                              [1:1]            get_mdio_em_pwrdn
''                                                             set_mdio_em_pwrdn
''                                                             read_mdio_em_pwrdn
''                                                             write_mdio_em_pwrdn
''---------------------------------------------------------------------------------
'' pi_phase_invert                            [0:0]            get_pi_phase_invert
''                                                             set_pi_phase_invert
''                                                             read_pi_phase_invert
''                                                             write_pi_phase_invert
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_rxcdr0
    Private write_sigdetTime_SM_value
    Private read_sigdetTime_SM_value
    Private flag_sigdetTime_SM
    Private write_em_phase_shift_360_ovrd_val_value
    Private read_em_phase_shift_360_ovrd_val_value
    Private flag_em_phase_shift_360_ovrd_val
    Private write_em_phase_shift_360_ovrd_value
    Private read_em_phase_shift_360_ovrd_value
    Private flag_em_phase_shift_360_ovrd
    Private write_rx_interp_ctrl_cap_value
    Private read_rx_interp_ctrl_cap_value
    Private flag_rx_interp_ctrl_cap
    Private write_rx_interp_status_sel_value
    Private read_rx_interp_status_sel_value
    Private flag_rx_interp_status_sel
    Private write_pi_clk90_offset_override_value
    Private read_pi_clk90_offset_override_value
    Private flag_pi_clk90_offset_override
    Private write_pi_phase_rotate_override_value
    Private read_pi_phase_rotate_override_value
    Private flag_pi_phase_rotate_override
    Private write_mdio_em_err_cnt_clr_value
    Private read_mdio_em_err_cnt_clr_value
    Private flag_mdio_em_err_cnt_clr
    Private write_mdio_em_err_cnt_frz_value
    Private read_mdio_em_err_cnt_frz_value
    Private flag_mdio_em_err_cnt_frz
    Private write_mdio_em_pwrdn_value
    Private read_mdio_em_pwrdn_value
    Private flag_mdio_em_pwrdn
    Private write_pi_phase_invert_value
    Private read_pi_phase_invert_value
    Private flag_pi_phase_invert

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

    Property Get get_em_phase_shift_360_ovrd_val
        get_em_phase_shift_360_ovrd_val = read_em_phase_shift_360_ovrd_val_value
    End Property

    Property Let set_em_phase_shift_360_ovrd_val(aData)
        write_em_phase_shift_360_ovrd_val_value = aData
        flag_em_phase_shift_360_ovrd_val        = &H1
    End Property

    Property Get read_em_phase_shift_360_ovrd_val
        read
        read_em_phase_shift_360_ovrd_val = read_em_phase_shift_360_ovrd_val_value
    End Property

    Property Let write_em_phase_shift_360_ovrd_val(aData)
        set_em_phase_shift_360_ovrd_val = aData
        write
    End Property

    Property Get get_em_phase_shift_360_ovrd
        get_em_phase_shift_360_ovrd = read_em_phase_shift_360_ovrd_value
    End Property

    Property Let set_em_phase_shift_360_ovrd(aData)
        write_em_phase_shift_360_ovrd_value = aData
        flag_em_phase_shift_360_ovrd        = &H1
    End Property

    Property Get read_em_phase_shift_360_ovrd
        read
        read_em_phase_shift_360_ovrd = read_em_phase_shift_360_ovrd_value
    End Property

    Property Let write_em_phase_shift_360_ovrd(aData)
        set_em_phase_shift_360_ovrd = aData
        write
    End Property

    Property Get get_rx_interp_ctrl_cap
        get_rx_interp_ctrl_cap = read_rx_interp_ctrl_cap_value
    End Property

    Property Let set_rx_interp_ctrl_cap(aData)
        write_rx_interp_ctrl_cap_value = aData
        flag_rx_interp_ctrl_cap        = &H1
    End Property

    Property Get read_rx_interp_ctrl_cap
        read
        read_rx_interp_ctrl_cap = read_rx_interp_ctrl_cap_value
    End Property

    Property Let write_rx_interp_ctrl_cap(aData)
        set_rx_interp_ctrl_cap = aData
        write
    End Property

    Property Get get_rx_interp_status_sel
        get_rx_interp_status_sel = read_rx_interp_status_sel_value
    End Property

    Property Let set_rx_interp_status_sel(aData)
        write_rx_interp_status_sel_value = aData
        flag_rx_interp_status_sel        = &H1
    End Property

    Property Get read_rx_interp_status_sel
        read
        read_rx_interp_status_sel = read_rx_interp_status_sel_value
    End Property

    Property Let write_rx_interp_status_sel(aData)
        set_rx_interp_status_sel = aData
        write
    End Property

    Property Get get_pi_clk90_offset_override
        get_pi_clk90_offset_override = read_pi_clk90_offset_override_value
    End Property

    Property Let set_pi_clk90_offset_override(aData)
        write_pi_clk90_offset_override_value = aData
        flag_pi_clk90_offset_override        = &H1
    End Property

    Property Get read_pi_clk90_offset_override
        read
        read_pi_clk90_offset_override = read_pi_clk90_offset_override_value
    End Property

    Property Let write_pi_clk90_offset_override(aData)
        set_pi_clk90_offset_override = aData
        write
    End Property

    Property Get get_pi_phase_rotate_override
        get_pi_phase_rotate_override = read_pi_phase_rotate_override_value
    End Property

    Property Let set_pi_phase_rotate_override(aData)
        write_pi_phase_rotate_override_value = aData
        flag_pi_phase_rotate_override        = &H1
    End Property

    Property Get read_pi_phase_rotate_override
        read
        read_pi_phase_rotate_override = read_pi_phase_rotate_override_value
    End Property

    Property Let write_pi_phase_rotate_override(aData)
        set_pi_phase_rotate_override = aData
        write
    End Property

    Property Get get_mdio_em_err_cnt_clr
        get_mdio_em_err_cnt_clr = read_mdio_em_err_cnt_clr_value
    End Property

    Property Let set_mdio_em_err_cnt_clr(aData)
        write_mdio_em_err_cnt_clr_value = aData
        flag_mdio_em_err_cnt_clr        = &H1
    End Property

    Property Get read_mdio_em_err_cnt_clr
        read
        read_mdio_em_err_cnt_clr = read_mdio_em_err_cnt_clr_value
    End Property

    Property Let write_mdio_em_err_cnt_clr(aData)
        set_mdio_em_err_cnt_clr = aData
        write
    End Property

    Property Get get_mdio_em_err_cnt_frz
        get_mdio_em_err_cnt_frz = read_mdio_em_err_cnt_frz_value
    End Property

    Property Let set_mdio_em_err_cnt_frz(aData)
        write_mdio_em_err_cnt_frz_value = aData
        flag_mdio_em_err_cnt_frz        = &H1
    End Property

    Property Get read_mdio_em_err_cnt_frz
        read
        read_mdio_em_err_cnt_frz = read_mdio_em_err_cnt_frz_value
    End Property

    Property Let write_mdio_em_err_cnt_frz(aData)
        set_mdio_em_err_cnt_frz = aData
        write
    End Property

    Property Get get_mdio_em_pwrdn
        get_mdio_em_pwrdn = read_mdio_em_pwrdn_value
    End Property

    Property Let set_mdio_em_pwrdn(aData)
        write_mdio_em_pwrdn_value = aData
        flag_mdio_em_pwrdn        = &H1
    End Property

    Property Get read_mdio_em_pwrdn
        read
        read_mdio_em_pwrdn = read_mdio_em_pwrdn_value
    End Property

    Property Let write_mdio_em_pwrdn(aData)
        set_mdio_em_pwrdn = aData
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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdetTime_SM_value = rightShift(data_low, 12) and &Hf
        read_em_phase_shift_360_ovrd_val_value = rightShift(data_low, 11) and &H1
        read_em_phase_shift_360_ovrd_value = rightShift(data_low, 10) and &H1
        read_rx_interp_ctrl_cap_value = rightShift(data_low, 9) and &H1
        read_rx_interp_status_sel_value = rightShift(data_low, 6) and &H7
        read_pi_clk90_offset_override_value = rightShift(data_low, 5) and &H1
        read_pi_phase_rotate_override_value = rightShift(data_low, 4) and &H1
        read_mdio_em_err_cnt_clr_value = rightShift(data_low, 3) and &H1
        read_mdio_em_err_cnt_frz_value = rightShift(data_low, 2) and &H1
        read_mdio_em_pwrdn_value = rightShift(data_low, 1) and &H1
        pi_phase_invert_mask = &H1
        if data_low > LONG_MAX then
            if pi_phase_invert_mask = mask then
                read_pi_phase_invert_value = data_low
            else
                read_pi_phase_invert_value = (data_low - H8000_0000) and pi_phase_invert_mask
            end If
        else
            read_pi_phase_invert_value = data_low and pi_phase_invert_mask
        end If

    End Sub

    Sub write
        If flag_sigdetTime_SM = &H0 or flag_em_phase_shift_360_ovrd_val = &H0 or flag_em_phase_shift_360_ovrd = &H0 or flag_rx_interp_ctrl_cap = &H0 or flag_rx_interp_status_sel = &H0 or flag_pi_clk90_offset_override = &H0 or flag_pi_phase_rotate_override = &H0 or flag_mdio_em_err_cnt_clr = &H0 or flag_mdio_em_err_cnt_frz = &H0 or flag_mdio_em_pwrdn = &H0 or flag_pi_phase_invert = &H0 Then read
        If flag_sigdetTime_SM = &H0 Then write_sigdetTime_SM_value = get_sigdetTime_SM
        If flag_em_phase_shift_360_ovrd_val = &H0 Then write_em_phase_shift_360_ovrd_val_value = get_em_phase_shift_360_ovrd_val
        If flag_em_phase_shift_360_ovrd = &H0 Then write_em_phase_shift_360_ovrd_value = get_em_phase_shift_360_ovrd
        If flag_rx_interp_ctrl_cap = &H0 Then write_rx_interp_ctrl_cap_value = get_rx_interp_ctrl_cap
        If flag_rx_interp_status_sel = &H0 Then write_rx_interp_status_sel_value = get_rx_interp_status_sel
        If flag_pi_clk90_offset_override = &H0 Then write_pi_clk90_offset_override_value = get_pi_clk90_offset_override
        If flag_pi_phase_rotate_override = &H0 Then write_pi_phase_rotate_override_value = get_pi_phase_rotate_override
        If flag_mdio_em_err_cnt_clr = &H0 Then write_mdio_em_err_cnt_clr_value = get_mdio_em_err_cnt_clr
        If flag_mdio_em_err_cnt_frz = &H0 Then write_mdio_em_err_cnt_frz_value = get_mdio_em_err_cnt_frz
        If flag_mdio_em_pwrdn = &H0 Then write_mdio_em_pwrdn_value = get_mdio_em_pwrdn
        If flag_pi_phase_invert = &H0 Then write_pi_phase_invert_value = get_pi_phase_invert

        regValue = leftShift((write_sigdetTime_SM_value and &Hf), 12) + leftShift((write_em_phase_shift_360_ovrd_val_value and &H1), 11) + leftShift((write_em_phase_shift_360_ovrd_value and &H1), 10) + leftShift((write_rx_interp_ctrl_cap_value and &H1), 9) + leftShift((write_rx_interp_status_sel_value and &H7), 6) + leftShift((write_pi_clk90_offset_override_value and &H1), 5) + leftShift((write_pi_phase_rotate_override_value and &H1), 4) + leftShift((write_mdio_em_err_cnt_clr_value and &H1), 3) + leftShift((write_mdio_em_err_cnt_frz_value and &H1), 2) + leftShift((write_mdio_em_pwrdn_value and &H1), 1) + leftShift((write_pi_phase_invert_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdetTime_SM_value = rightShift(data_low, 12) and &Hf
        read_em_phase_shift_360_ovrd_val_value = rightShift(data_low, 11) and &H1
        read_em_phase_shift_360_ovrd_value = rightShift(data_low, 10) and &H1
        read_rx_interp_ctrl_cap_value = rightShift(data_low, 9) and &H1
        read_rx_interp_status_sel_value = rightShift(data_low, 6) and &H7
        read_pi_clk90_offset_override_value = rightShift(data_low, 5) and &H1
        read_pi_phase_rotate_override_value = rightShift(data_low, 4) and &H1
        read_mdio_em_err_cnt_clr_value = rightShift(data_low, 3) and &H1
        read_mdio_em_err_cnt_frz_value = rightShift(data_low, 2) and &H1
        read_mdio_em_pwrdn_value = rightShift(data_low, 1) and &H1
        pi_phase_invert_mask = &H1
        if data_low > LONG_MAX then
            if pi_phase_invert_mask = mask then
                read_pi_phase_invert_value = data_low
            else
                read_pi_phase_invert_value = (data_low - H8000_0000) and pi_phase_invert_mask
            end If
        else
            read_pi_phase_invert_value = data_low and pi_phase_invert_mask
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
        write_em_phase_shift_360_ovrd_val_value = &H0
        flag_em_phase_shift_360_ovrd_val        = &H0
        write_em_phase_shift_360_ovrd_value = &H0
        flag_em_phase_shift_360_ovrd        = &H0
        write_rx_interp_ctrl_cap_value = &H0
        flag_rx_interp_ctrl_cap        = &H0
        write_rx_interp_status_sel_value = &H0
        flag_rx_interp_status_sel        = &H0
        write_pi_clk90_offset_override_value = &H0
        flag_pi_clk90_offset_override        = &H0
        write_pi_phase_rotate_override_value = &H0
        flag_pi_phase_rotate_override        = &H0
        write_mdio_em_err_cnt_clr_value = &H0
        flag_mdio_em_err_cnt_clr        = &H0
        write_mdio_em_err_cnt_frz_value = &H0
        flag_mdio_em_err_cnt_frz        = &H0
        write_mdio_em_pwrdn_value = &H0
        flag_mdio_em_pwrdn        = &H0
        write_pi_phase_invert_value = &H0
        flag_pi_phase_invert        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxcdr1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' step_two                                   [12:11]          get_step_two
''                                                             set_step_two
''                                                             read_step_two
''                                                             write_step_two
''---------------------------------------------------------------------------------
'' step_one                                   [10:9]           get_step_one
''                                                             set_step_one
''                                                             read_step_one
''                                                             write_step_one
''---------------------------------------------------------------------------------
'' flip_zero_polarity                         [8:8]            get_flip_zero_polarity
''                                                             set_flip_zero_polarity
''                                                             read_flip_zero_polarity
''                                                             write_flip_zero_polarity
''---------------------------------------------------------------------------------
'' flip_peak_polarity                         [7:7]            get_flip_peak_polarity
''                                                             set_flip_peak_polarity
''                                                             read_flip_peak_polarity
''                                                             write_flip_peak_polarity
''---------------------------------------------------------------------------------
'' rising_edge                                [6:6]            get_rising_edge
''                                                             set_rising_edge
''                                                             read_rising_edge
''                                                             write_rising_edge
''---------------------------------------------------------------------------------
'' falling_edge                               [5:5]            get_falling_edge
''                                                             set_falling_edge
''                                                             read_falling_edge
''                                                             write_falling_edge
''---------------------------------------------------------------------------------
'' freq_upd_en                                [4:4]            get_freq_upd_en
''                                                             set_freq_upd_en
''                                                             read_freq_upd_en
''                                                             write_freq_upd_en
''---------------------------------------------------------------------------------
'' phase_delta                                [3:3]            get_phase_delta
''                                                             set_phase_delta
''                                                             read_phase_delta
''                                                             write_phase_delta
''---------------------------------------------------------------------------------
'' phs_counter_clr                            [2:2]            get_phs_counter_clr
''                                                             set_phs_counter_clr
''                                                             read_phs_counter_clr
''                                                             write_phs_counter_clr
''---------------------------------------------------------------------------------
'' phase_sat_ctrl                             [1:0]            get_phase_sat_ctrl
''                                                             set_phase_sat_ctrl
''                                                             read_phase_sat_ctrl
''                                                             write_phase_sat_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_rxcdr1
    Private write_step_two_value
    Private read_step_two_value
    Private flag_step_two
    Private write_step_one_value
    Private read_step_one_value
    Private flag_step_one
    Private write_flip_zero_polarity_value
    Private read_flip_zero_polarity_value
    Private flag_flip_zero_polarity
    Private write_flip_peak_polarity_value
    Private read_flip_peak_polarity_value
    Private flag_flip_peak_polarity
    Private write_rising_edge_value
    Private read_rising_edge_value
    Private flag_rising_edge
    Private write_falling_edge_value
    Private read_falling_edge_value
    Private flag_falling_edge
    Private write_freq_upd_en_value
    Private read_freq_upd_en_value
    Private flag_freq_upd_en
    Private write_phase_delta_value
    Private read_phase_delta_value
    Private flag_phase_delta
    Private write_phs_counter_clr_value
    Private read_phs_counter_clr_value
    Private flag_phs_counter_clr
    Private write_phase_sat_ctrl_value
    Private read_phase_sat_ctrl_value
    Private flag_phase_sat_ctrl

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

    Property Get get_step_two
        get_step_two = read_step_two_value
    End Property

    Property Let set_step_two(aData)
        write_step_two_value = aData
        flag_step_two        = &H1
    End Property

    Property Get read_step_two
        read
        read_step_two = read_step_two_value
    End Property

    Property Let write_step_two(aData)
        set_step_two = aData
        write
    End Property

    Property Get get_step_one
        get_step_one = read_step_one_value
    End Property

    Property Let set_step_one(aData)
        write_step_one_value = aData
        flag_step_one        = &H1
    End Property

    Property Get read_step_one
        read
        read_step_one = read_step_one_value
    End Property

    Property Let write_step_one(aData)
        set_step_one = aData
        write
    End Property

    Property Get get_flip_zero_polarity
        get_flip_zero_polarity = read_flip_zero_polarity_value
    End Property

    Property Let set_flip_zero_polarity(aData)
        write_flip_zero_polarity_value = aData
        flag_flip_zero_polarity        = &H1
    End Property

    Property Get read_flip_zero_polarity
        read
        read_flip_zero_polarity = read_flip_zero_polarity_value
    End Property

    Property Let write_flip_zero_polarity(aData)
        set_flip_zero_polarity = aData
        write
    End Property

    Property Get get_flip_peak_polarity
        get_flip_peak_polarity = read_flip_peak_polarity_value
    End Property

    Property Let set_flip_peak_polarity(aData)
        write_flip_peak_polarity_value = aData
        flag_flip_peak_polarity        = &H1
    End Property

    Property Get read_flip_peak_polarity
        read
        read_flip_peak_polarity = read_flip_peak_polarity_value
    End Property

    Property Let write_flip_peak_polarity(aData)
        set_flip_peak_polarity = aData
        write
    End Property

    Property Get get_rising_edge
        get_rising_edge = read_rising_edge_value
    End Property

    Property Let set_rising_edge(aData)
        write_rising_edge_value = aData
        flag_rising_edge        = &H1
    End Property

    Property Get read_rising_edge
        read
        read_rising_edge = read_rising_edge_value
    End Property

    Property Let write_rising_edge(aData)
        set_rising_edge = aData
        write
    End Property

    Property Get get_falling_edge
        get_falling_edge = read_falling_edge_value
    End Property

    Property Let set_falling_edge(aData)
        write_falling_edge_value = aData
        flag_falling_edge        = &H1
    End Property

    Property Get read_falling_edge
        read
        read_falling_edge = read_falling_edge_value
    End Property

    Property Let write_falling_edge(aData)
        set_falling_edge = aData
        write
    End Property

    Property Get get_freq_upd_en
        get_freq_upd_en = read_freq_upd_en_value
    End Property

    Property Let set_freq_upd_en(aData)
        write_freq_upd_en_value = aData
        flag_freq_upd_en        = &H1
    End Property

    Property Get read_freq_upd_en
        read
        read_freq_upd_en = read_freq_upd_en_value
    End Property

    Property Let write_freq_upd_en(aData)
        set_freq_upd_en = aData
        write
    End Property

    Property Get get_phase_delta
        get_phase_delta = read_phase_delta_value
    End Property

    Property Let set_phase_delta(aData)
        write_phase_delta_value = aData
        flag_phase_delta        = &H1
    End Property

    Property Get read_phase_delta
        read
        read_phase_delta = read_phase_delta_value
    End Property

    Property Let write_phase_delta(aData)
        set_phase_delta = aData
        write
    End Property

    Property Get get_phs_counter_clr
        get_phs_counter_clr = read_phs_counter_clr_value
    End Property

    Property Let set_phs_counter_clr(aData)
        write_phs_counter_clr_value = aData
        flag_phs_counter_clr        = &H1
    End Property

    Property Get read_phs_counter_clr
        read
        read_phs_counter_clr = read_phs_counter_clr_value
    End Property

    Property Let write_phs_counter_clr(aData)
        set_phs_counter_clr = aData
        write
    End Property

    Property Get get_phase_sat_ctrl
        get_phase_sat_ctrl = read_phase_sat_ctrl_value
    End Property

    Property Let set_phase_sat_ctrl(aData)
        write_phase_sat_ctrl_value = aData
        flag_phase_sat_ctrl        = &H1
    End Property

    Property Get read_phase_sat_ctrl
        read
        read_phase_sat_ctrl = read_phase_sat_ctrl_value
    End Property

    Property Let write_phase_sat_ctrl(aData)
        set_phase_sat_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_step_two_value = rightShift(data_low, 11) and &H3
        read_step_one_value = rightShift(data_low, 9) and &H3
        read_flip_zero_polarity_value = rightShift(data_low, 8) and &H1
        read_flip_peak_polarity_value = rightShift(data_low, 7) and &H1
        read_rising_edge_value = rightShift(data_low, 6) and &H1
        read_falling_edge_value = rightShift(data_low, 5) and &H1
        read_freq_upd_en_value = rightShift(data_low, 4) and &H1
        read_phase_delta_value = rightShift(data_low, 3) and &H1
        read_phs_counter_clr_value = rightShift(data_low, 2) and &H1
        phase_sat_ctrl_mask = &H3
        if data_low > LONG_MAX then
            if phase_sat_ctrl_mask = mask then
                read_phase_sat_ctrl_value = data_low
            else
                read_phase_sat_ctrl_value = (data_low - H8000_0000) and phase_sat_ctrl_mask
            end If
        else
            read_phase_sat_ctrl_value = data_low and phase_sat_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_step_two = &H0 or flag_step_one = &H0 or flag_flip_zero_polarity = &H0 or flag_flip_peak_polarity = &H0 or flag_rising_edge = &H0 or flag_falling_edge = &H0 or flag_freq_upd_en = &H0 or flag_phase_delta = &H0 or flag_phs_counter_clr = &H0 or flag_phase_sat_ctrl = &H0 Then read
        If flag_step_two = &H0 Then write_step_two_value = get_step_two
        If flag_step_one = &H0 Then write_step_one_value = get_step_one
        If flag_flip_zero_polarity = &H0 Then write_flip_zero_polarity_value = get_flip_zero_polarity
        If flag_flip_peak_polarity = &H0 Then write_flip_peak_polarity_value = get_flip_peak_polarity
        If flag_rising_edge = &H0 Then write_rising_edge_value = get_rising_edge
        If flag_falling_edge = &H0 Then write_falling_edge_value = get_falling_edge
        If flag_freq_upd_en = &H0 Then write_freq_upd_en_value = get_freq_upd_en
        If flag_phase_delta = &H0 Then write_phase_delta_value = get_phase_delta
        If flag_phs_counter_clr = &H0 Then write_phs_counter_clr_value = get_phs_counter_clr
        If flag_phase_sat_ctrl = &H0 Then write_phase_sat_ctrl_value = get_phase_sat_ctrl

        regValue = leftShift((write_step_two_value and &H3), 11) + leftShift((write_step_one_value and &H3), 9) + leftShift((write_flip_zero_polarity_value and &H1), 8) + leftShift((write_flip_peak_polarity_value and &H1), 7) + leftShift((write_rising_edge_value and &H1), 6) + leftShift((write_falling_edge_value and &H1), 5) + leftShift((write_freq_upd_en_value and &H1), 4) + leftShift((write_phase_delta_value and &H1), 3) + leftShift((write_phs_counter_clr_value and &H1), 2) + leftShift((write_phase_sat_ctrl_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_step_two_value = rightShift(data_low, 11) and &H3
        read_step_one_value = rightShift(data_low, 9) and &H3
        read_flip_zero_polarity_value = rightShift(data_low, 8) and &H1
        read_flip_peak_polarity_value = rightShift(data_low, 7) and &H1
        read_rising_edge_value = rightShift(data_low, 6) and &H1
        read_falling_edge_value = rightShift(data_low, 5) and &H1
        read_freq_upd_en_value = rightShift(data_low, 4) and &H1
        read_phase_delta_value = rightShift(data_low, 3) and &H1
        read_phs_counter_clr_value = rightShift(data_low, 2) and &H1
        phase_sat_ctrl_mask = &H3
        if data_low > LONG_MAX then
            if phase_sat_ctrl_mask = mask then
                read_phase_sat_ctrl_value = data_low
            else
                read_phase_sat_ctrl_value = (data_low - H8000_0000) and phase_sat_ctrl_mask
            end If
        else
            read_phase_sat_ctrl_value = data_low and phase_sat_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_step_two_value = &H0
        flag_step_two        = &H0
        write_step_one_value = &H0
        flag_step_one        = &H0
        write_flip_zero_polarity_value = &H0
        flag_flip_zero_polarity        = &H0
        write_flip_peak_polarity_value = &H0
        flag_flip_peak_polarity        = &H0
        write_rising_edge_value = &H0
        flag_rising_edge        = &H0
        write_falling_edge_value = &H0
        flag_falling_edge        = &H0
        write_freq_upd_en_value = &H0
        flag_freq_upd_en        = &H0
        write_phase_delta_value = &H0
        flag_phase_delta        = &H0
        write_phs_counter_clr_value = &H0
        flag_phs_counter_clr        = &H0
        write_phase_sat_ctrl_value = &H0
        flag_phase_sat_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxcdr2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' phsacq_enable                              [13:13]          get_phsacq_enable
''                                                             set_phsacq_enable
''                                                             read_phsacq_enable
''                                                             write_phsacq_enable
''---------------------------------------------------------------------------------
'' rate_select                                [12:12]          get_rate_select
''                                                             set_rate_select
''                                                             read_rate_select
''                                                             write_rate_select
''---------------------------------------------------------------------------------
'' phsacq_dir                                 [11:11]          get_phsacq_dir
''                                                             set_phsacq_dir
''                                                             read_phsacq_dir
''                                                             write_phsacq_dir
''---------------------------------------------------------------------------------
'' phsacq_freq_sel                            [9:9]            get_phsacq_freq_sel
''                                                             set_phsacq_freq_sel
''                                                             read_phsacq_freq_sel
''                                                             write_phsacq_freq_sel
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
Class REGISTER_RX2__SGMIIPLUSR_X1_rxcdr2
    Private write_phsacq_enable_value
    Private read_phsacq_enable_value
    Private flag_phsacq_enable
    Private write_rate_select_value
    Private read_rate_select_value
    Private flag_rate_select
    Private write_phsacq_dir_value
    Private read_phsacq_dir_value
    Private flag_phsacq_dir
    Private write_phsacq_freq_sel_value
    Private read_phsacq_freq_sel_value
    Private flag_phsacq_freq_sel
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

    Property Get get_phsacq_enable
        get_phsacq_enable = read_phsacq_enable_value
    End Property

    Property Let set_phsacq_enable(aData)
        write_phsacq_enable_value = aData
        flag_phsacq_enable        = &H1
    End Property

    Property Get read_phsacq_enable
        read
        read_phsacq_enable = read_phsacq_enable_value
    End Property

    Property Let write_phsacq_enable(aData)
        set_phsacq_enable = aData
        write
    End Property

    Property Get get_rate_select
        get_rate_select = read_rate_select_value
    End Property

    Property Let set_rate_select(aData)
        write_rate_select_value = aData
        flag_rate_select        = &H1
    End Property

    Property Get read_rate_select
        read
        read_rate_select = read_rate_select_value
    End Property

    Property Let write_rate_select(aData)
        set_rate_select = aData
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

    Property Get get_phsacq_freq_sel
        get_phsacq_freq_sel = read_phsacq_freq_sel_value
    End Property

    Property Let set_phsacq_freq_sel(aData)
        write_phsacq_freq_sel_value = aData
        flag_phsacq_freq_sel        = &H1
    End Property

    Property Get read_phsacq_freq_sel
        read
        read_phsacq_freq_sel = read_phsacq_freq_sel_value
    End Property

    Property Let write_phsacq_freq_sel(aData)
        set_phsacq_freq_sel = aData
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
        read_phsacq_enable_value = rightShift(data_low, 13) and &H1
        read_rate_select_value = rightShift(data_low, 12) and &H1
        read_phsacq_dir_value = rightShift(data_low, 11) and &H1
        read_phsacq_freq_sel_value = rightShift(data_low, 9) and &H1
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
        If flag_phsacq_enable = &H0 or flag_rate_select = &H0 or flag_phsacq_dir = &H0 or flag_phsacq_freq_sel = &H0 or flag_phsacq_step = &H0 or flag_phsacq_timeout = &H0 Then read
        If flag_phsacq_enable = &H0 Then write_phsacq_enable_value = get_phsacq_enable
        If flag_rate_select = &H0 Then write_rate_select_value = get_rate_select
        If flag_phsacq_dir = &H0 Then write_phsacq_dir_value = get_phsacq_dir
        If flag_phsacq_freq_sel = &H0 Then write_phsacq_freq_sel_value = get_phsacq_freq_sel
        If flag_phsacq_step = &H0 Then write_phsacq_step_value = get_phsacq_step
        If flag_phsacq_timeout = &H0 Then write_phsacq_timeout_value = get_phsacq_timeout

        regValue = leftShift((write_phsacq_enable_value and &H1), 13) + leftShift((write_rate_select_value and &H1), 12) + leftShift((write_phsacq_dir_value and &H1), 11) + leftShift((write_phsacq_freq_sel_value and &H1), 9) + leftShift((write_phsacq_step_value and &H1), 8) + leftShift((write_phsacq_timeout_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_phsacq_enable_value = rightShift(data_low, 13) and &H1
        read_rate_select_value = rightShift(data_low, 12) and &H1
        read_phsacq_dir_value = rightShift(data_low, 11) and &H1
        read_phsacq_freq_sel_value = rightShift(data_low, 9) and &H1
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
        write_phsacq_enable_value = &H0
        flag_phsacq_enable        = &H0
        write_rate_select_value = &H0
        flag_rate_select        = &H0
        write_phsacq_dir_value = &H0
        flag_phsacq_dir        = &H0
        write_phsacq_freq_sel_value = &H0
        flag_phsacq_freq_sel        = &H0
        write_phsacq_step_value = &H0
        flag_phsacq_step        = &H0
        write_phsacq_timeout_value = &H0
        flag_phsacq_timeout        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxcdr3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' phase_step                                 [12:11]          get_phase_step
''                                                             set_phase_step
''                                                             read_phase_step
''                                                             write_phase_step
''---------------------------------------------------------------------------------
'' phase_frz_1                                [10:10]          get_phase_frz_1
''                                                             set_phase_frz_1
''                                                             read_phase_frz_1
''                                                             write_phase_frz_1
''---------------------------------------------------------------------------------
'' phase_frz_1_en                             [9:9]            get_phase_frz_1_en
''                                                             set_phase_frz_1_en
''                                                             read_phase_frz_1_en
''                                                             write_phase_frz_1_en
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
Class REGISTER_RX2__SGMIIPLUSR_X1_rxcdr3
    Private write_phase_step_value
    Private read_phase_step_value
    Private flag_phase_step
    Private write_phase_frz_1_value
    Private read_phase_frz_1_value
    Private flag_phase_frz_1
    Private write_phase_frz_1_en_value
    Private read_phase_frz_1_en_value
    Private flag_phase_frz_1_en
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

    Property Get get_phase_step
        get_phase_step = read_phase_step_value
    End Property

    Property Let set_phase_step(aData)
        write_phase_step_value = aData
        flag_phase_step        = &H1
    End Property

    Property Get read_phase_step
        read
        read_phase_step = read_phase_step_value
    End Property

    Property Let write_phase_step(aData)
        set_phase_step = aData
        write
    End Property

    Property Get get_phase_frz_1
        get_phase_frz_1 = read_phase_frz_1_value
    End Property

    Property Let set_phase_frz_1(aData)
        write_phase_frz_1_value = aData
        flag_phase_frz_1        = &H1
    End Property

    Property Get read_phase_frz_1
        read
        read_phase_frz_1 = read_phase_frz_1_value
    End Property

    Property Let write_phase_frz_1(aData)
        set_phase_frz_1 = aData
        write
    End Property

    Property Get get_phase_frz_1_en
        get_phase_frz_1_en = read_phase_frz_1_en_value
    End Property

    Property Let set_phase_frz_1_en(aData)
        write_phase_frz_1_en_value = aData
        flag_phase_frz_1_en        = &H1
    End Property

    Property Get read_phase_frz_1_en
        read
        read_phase_frz_1_en = read_phase_frz_1_en_value
    End Property

    Property Let write_phase_frz_1_en(aData)
        set_phase_frz_1_en = aData
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
        read_phase_step_value = rightShift(data_low, 11) and &H3
        read_phase_frz_1_value = rightShift(data_low, 10) and &H1
        read_phase_frz_1_en_value = rightShift(data_low, 9) and &H1
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
        If flag_phase_step = &H0 or flag_phase_frz_1 = &H0 or flag_phase_frz_1_en = &H0 or flag_phase_override_SM = &H0 or flag_phase_inc_SM = &H0 or flag_phase_dec_SM = &H0 or flag_phase_strobe_SM = &H0 or flag_phase_delta_SM = &H0 Then read
        If flag_phase_step = &H0 Then write_phase_step_value = get_phase_step
        If flag_phase_frz_1 = &H0 Then write_phase_frz_1_value = get_phase_frz_1
        If flag_phase_frz_1_en = &H0 Then write_phase_frz_1_en_value = get_phase_frz_1_en
        If flag_phase_override_SM = &H0 Then write_phase_override_SM_value = get_phase_override_SM
        If flag_phase_inc_SM = &H0 Then write_phase_inc_SM_value = get_phase_inc_SM
        If flag_phase_dec_SM = &H0 Then write_phase_dec_SM_value = get_phase_dec_SM
        If flag_phase_strobe_SM = &H0 Then write_phase_strobe_SM_value = get_phase_strobe_SM
        If flag_phase_delta_SM = &H0 Then write_phase_delta_SM_value = get_phase_delta_SM

        regValue = leftShift((write_phase_step_value and &H3), 11) + leftShift((write_phase_frz_1_value and &H1), 10) + leftShift((write_phase_frz_1_en_value and &H1), 9) + leftShift((write_phase_override_SM_value and &H1), 8) + leftShift((write_phase_inc_SM_value and &H1), 7) + leftShift((write_phase_dec_SM_value and &H1), 6) + leftShift((write_phase_strobe_SM_value and &H1), 5) + leftShift((write_phase_delta_SM_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_phase_step_value = rightShift(data_low, 11) and &H3
        read_phase_frz_1_value = rightShift(data_low, 10) and &H1
        read_phase_frz_1_en_value = rightShift(data_low, 9) and &H1
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
        write_phase_step_value = &H0
        flag_phase_step        = &H0
        write_phase_frz_1_value = &H0
        flag_phase_frz_1        = &H0
        write_phase_frz_1_en_value = &H0
        flag_phase_frz_1_en        = &H0
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


'' @REGISTER : RX2__SGMIIPLUSR_X1_rxcdr4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bwsel_integ                                [15:12]          get_bwsel_integ
''                                                             set_bwsel_integ
''                                                             read_bwsel_integ
''                                                             write_bwsel_integ
''---------------------------------------------------------------------------------
'' bwsel_prop                                 [11:8]           get_bwsel_prop
''                                                             set_bwsel_prop
''                                                             read_bwsel_prop
''                                                             write_bwsel_prop
''---------------------------------------------------------------------------------
'' integ_clr                                  [7:7]            get_integ_clr
''                                                             set_integ_clr
''                                                             read_integ_clr
''                                                             write_integ_clr
''---------------------------------------------------------------------------------
'' freq_en                                    [6:6]            get_freq_en
''                                                             set_freq_en
''                                                             read_freq_en
''                                                             write_freq_en
''---------------------------------------------------------------------------------
'' freq_override_en                           [5:5]            get_freq_override_en
''                                                             set_freq_override_en
''                                                             read_freq_override_en
''                                                             write_freq_override_en
''---------------------------------------------------------------------------------
'' freq_override_val                          [4:0]            get_freq_override_val
''                                                             set_freq_override_val
''                                                             read_freq_override_val
''                                                             write_freq_override_val
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_rxcdr4
    Private write_bwsel_integ_value
    Private read_bwsel_integ_value
    Private flag_bwsel_integ
    Private write_bwsel_prop_value
    Private read_bwsel_prop_value
    Private flag_bwsel_prop
    Private write_integ_clr_value
    Private read_integ_clr_value
    Private flag_integ_clr
    Private write_freq_en_value
    Private read_freq_en_value
    Private flag_freq_en
    Private write_freq_override_en_value
    Private read_freq_override_en_value
    Private flag_freq_override_en
    Private write_freq_override_val_value
    Private read_freq_override_val_value
    Private flag_freq_override_val

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

    Property Get get_bwsel_integ
        get_bwsel_integ = read_bwsel_integ_value
    End Property

    Property Let set_bwsel_integ(aData)
        write_bwsel_integ_value = aData
        flag_bwsel_integ        = &H1
    End Property

    Property Get read_bwsel_integ
        read
        read_bwsel_integ = read_bwsel_integ_value
    End Property

    Property Let write_bwsel_integ(aData)
        set_bwsel_integ = aData
        write
    End Property

    Property Get get_bwsel_prop
        get_bwsel_prop = read_bwsel_prop_value
    End Property

    Property Let set_bwsel_prop(aData)
        write_bwsel_prop_value = aData
        flag_bwsel_prop        = &H1
    End Property

    Property Get read_bwsel_prop
        read
        read_bwsel_prop = read_bwsel_prop_value
    End Property

    Property Let write_bwsel_prop(aData)
        set_bwsel_prop = aData
        write
    End Property

    Property Get get_integ_clr
        get_integ_clr = read_integ_clr_value
    End Property

    Property Let set_integ_clr(aData)
        write_integ_clr_value = aData
        flag_integ_clr        = &H1
    End Property

    Property Get read_integ_clr
        read
        read_integ_clr = read_integ_clr_value
    End Property

    Property Let write_integ_clr(aData)
        set_integ_clr = aData
        write
    End Property

    Property Get get_freq_en
        get_freq_en = read_freq_en_value
    End Property

    Property Let set_freq_en(aData)
        write_freq_en_value = aData
        flag_freq_en        = &H1
    End Property

    Property Get read_freq_en
        read
        read_freq_en = read_freq_en_value
    End Property

    Property Let write_freq_en(aData)
        set_freq_en = aData
        write
    End Property

    Property Get get_freq_override_en
        get_freq_override_en = read_freq_override_en_value
    End Property

    Property Let set_freq_override_en(aData)
        write_freq_override_en_value = aData
        flag_freq_override_en        = &H1
    End Property

    Property Get read_freq_override_en
        read
        read_freq_override_en = read_freq_override_en_value
    End Property

    Property Let write_freq_override_en(aData)
        set_freq_override_en = aData
        write
    End Property

    Property Get get_freq_override_val
        get_freq_override_val = read_freq_override_val_value
    End Property

    Property Let set_freq_override_val(aData)
        write_freq_override_val_value = aData
        flag_freq_override_val        = &H1
    End Property

    Property Get read_freq_override_val
        read
        read_freq_override_val = read_freq_override_val_value
    End Property

    Property Let write_freq_override_val(aData)
        set_freq_override_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bwsel_integ_value = rightShift(data_low, 12) and &Hf
        read_bwsel_prop_value = rightShift(data_low, 8) and &Hf
        read_integ_clr_value = rightShift(data_low, 7) and &H1
        read_freq_en_value = rightShift(data_low, 6) and &H1
        read_freq_override_en_value = rightShift(data_low, 5) and &H1
        freq_override_val_mask = &H1f
        if data_low > LONG_MAX then
            if freq_override_val_mask = mask then
                read_freq_override_val_value = data_low
            else
                read_freq_override_val_value = (data_low - H8000_0000) and freq_override_val_mask
            end If
        else
            read_freq_override_val_value = data_low and freq_override_val_mask
        end If

    End Sub

    Sub write
        If flag_bwsel_integ = &H0 or flag_bwsel_prop = &H0 or flag_integ_clr = &H0 or flag_freq_en = &H0 or flag_freq_override_en = &H0 or flag_freq_override_val = &H0 Then read
        If flag_bwsel_integ = &H0 Then write_bwsel_integ_value = get_bwsel_integ
        If flag_bwsel_prop = &H0 Then write_bwsel_prop_value = get_bwsel_prop
        If flag_integ_clr = &H0 Then write_integ_clr_value = get_integ_clr
        If flag_freq_en = &H0 Then write_freq_en_value = get_freq_en
        If flag_freq_override_en = &H0 Then write_freq_override_en_value = get_freq_override_en
        If flag_freq_override_val = &H0 Then write_freq_override_val_value = get_freq_override_val

        regValue = leftShift((write_bwsel_integ_value and &Hf), 12) + leftShift((write_bwsel_prop_value and &Hf), 8) + leftShift((write_integ_clr_value and &H1), 7) + leftShift((write_freq_en_value and &H1), 6) + leftShift((write_freq_override_en_value and &H1), 5) + leftShift((write_freq_override_val_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bwsel_integ_value = rightShift(data_low, 12) and &Hf
        read_bwsel_prop_value = rightShift(data_low, 8) and &Hf
        read_integ_clr_value = rightShift(data_low, 7) and &H1
        read_freq_en_value = rightShift(data_low, 6) and &H1
        read_freq_override_en_value = rightShift(data_low, 5) and &H1
        freq_override_val_mask = &H1f
        if data_low > LONG_MAX then
            if freq_override_val_mask = mask then
                read_freq_override_val_value = data_low
            else
                read_freq_override_val_value = (data_low - H8000_0000) and freq_override_val_mask
            end If
        else
            read_freq_override_val_value = data_low and freq_override_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bwsel_integ_value = &H0
        flag_bwsel_integ        = &H0
        write_bwsel_prop_value = &H0
        flag_bwsel_prop        = &H0
        write_integ_clr_value = &H0
        flag_integ_clr        = &H0
        write_freq_en_value = &H0
        flag_freq_en        = &H0
        write_freq_override_en_value = &H0
        flag_freq_override_en        = &H0
        write_freq_override_val_value = &H0
        flag_freq_override_val        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_lmtoff                                  [9:4]            get_rx_lmtoff
''                                                             set_rx_lmtoff
''                                                             read_rx_lmtoff
''                                                             write_rx_lmtoff
''---------------------------------------------------------------------------------
'' rx_slicer_cal_done                         [3:3]            get_rx_slicer_cal_done
''                                                             set_rx_slicer_cal_done
''                                                             read_rx_slicer_cal_done
''                                                             write_rx_slicer_cal_done
''---------------------------------------------------------------------------------
'' rx_sloff0_invalid                          [2:2]            get_rx_sloff0_invalid
''                                                             set_rx_sloff0_invalid
''                                                             read_rx_sloff0_invalid
''                                                             write_rx_sloff0_invalid
''---------------------------------------------------------------------------------
'' rx_sloff1_invalid                          [1:1]            get_rx_sloff1_invalid
''                                                             set_rx_sloff1_invalid
''                                                             read_rx_sloff1_invalid
''                                                             write_rx_sloff1_invalid
''---------------------------------------------------------------------------------
'' rx_sloff2_invalid                          [0:0]            get_rx_sloff2_invalid
''                                                             set_rx_sloff2_invalid
''                                                             read_rx_sloff2_invalid
''                                                             write_rx_sloff2_invalid
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status0
    Private write_rx_lmtoff_value
    Private read_rx_lmtoff_value
    Private flag_rx_lmtoff
    Private write_rx_slicer_cal_done_value
    Private read_rx_slicer_cal_done_value
    Private flag_rx_slicer_cal_done
    Private write_rx_sloff0_invalid_value
    Private read_rx_sloff0_invalid_value
    Private flag_rx_sloff0_invalid
    Private write_rx_sloff1_invalid_value
    Private read_rx_sloff1_invalid_value
    Private flag_rx_sloff1_invalid
    Private write_rx_sloff2_invalid_value
    Private read_rx_sloff2_invalid_value
    Private flag_rx_sloff2_invalid

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

    Property Get get_rx_lmtoff
        get_rx_lmtoff = read_rx_lmtoff_value
    End Property

    Property Let set_rx_lmtoff(aData)
        write_rx_lmtoff_value = aData
        flag_rx_lmtoff        = &H1
    End Property

    Property Get read_rx_lmtoff
        read
        read_rx_lmtoff = read_rx_lmtoff_value
    End Property

    Property Let write_rx_lmtoff(aData)
        set_rx_lmtoff = aData
        write
    End Property

    Property Get get_rx_slicer_cal_done
        get_rx_slicer_cal_done = read_rx_slicer_cal_done_value
    End Property

    Property Let set_rx_slicer_cal_done(aData)
        write_rx_slicer_cal_done_value = aData
        flag_rx_slicer_cal_done        = &H1
    End Property

    Property Get read_rx_slicer_cal_done
        read
        read_rx_slicer_cal_done = read_rx_slicer_cal_done_value
    End Property

    Property Let write_rx_slicer_cal_done(aData)
        set_rx_slicer_cal_done = aData
        write
    End Property

    Property Get get_rx_sloff0_invalid
        get_rx_sloff0_invalid = read_rx_sloff0_invalid_value
    End Property

    Property Let set_rx_sloff0_invalid(aData)
        write_rx_sloff0_invalid_value = aData
        flag_rx_sloff0_invalid        = &H1
    End Property

    Property Get read_rx_sloff0_invalid
        read
        read_rx_sloff0_invalid = read_rx_sloff0_invalid_value
    End Property

    Property Let write_rx_sloff0_invalid(aData)
        set_rx_sloff0_invalid = aData
        write
    End Property

    Property Get get_rx_sloff1_invalid
        get_rx_sloff1_invalid = read_rx_sloff1_invalid_value
    End Property

    Property Let set_rx_sloff1_invalid(aData)
        write_rx_sloff1_invalid_value = aData
        flag_rx_sloff1_invalid        = &H1
    End Property

    Property Get read_rx_sloff1_invalid
        read
        read_rx_sloff1_invalid = read_rx_sloff1_invalid_value
    End Property

    Property Let write_rx_sloff1_invalid(aData)
        set_rx_sloff1_invalid = aData
        write
    End Property

    Property Get get_rx_sloff2_invalid
        get_rx_sloff2_invalid = read_rx_sloff2_invalid_value
    End Property

    Property Let set_rx_sloff2_invalid(aData)
        write_rx_sloff2_invalid_value = aData
        flag_rx_sloff2_invalid        = &H1
    End Property

    Property Get read_rx_sloff2_invalid
        read
        read_rx_sloff2_invalid = read_rx_sloff2_invalid_value
    End Property

    Property Let write_rx_sloff2_invalid(aData)
        set_rx_sloff2_invalid = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lmtoff_value = rightShift(data_low, 4) and &H3f
        read_rx_slicer_cal_done_value = rightShift(data_low, 3) and &H1
        read_rx_sloff0_invalid_value = rightShift(data_low, 2) and &H1
        read_rx_sloff1_invalid_value = rightShift(data_low, 1) and &H1
        rx_sloff2_invalid_mask = &H1
        if data_low > LONG_MAX then
            if rx_sloff2_invalid_mask = mask then
                read_rx_sloff2_invalid_value = data_low
            else
                read_rx_sloff2_invalid_value = (data_low - H8000_0000) and rx_sloff2_invalid_mask
            end If
        else
            read_rx_sloff2_invalid_value = data_low and rx_sloff2_invalid_mask
        end If

    End Sub

    Sub write
        If flag_rx_lmtoff = &H0 or flag_rx_slicer_cal_done = &H0 or flag_rx_sloff0_invalid = &H0 or flag_rx_sloff1_invalid = &H0 or flag_rx_sloff2_invalid = &H0 Then read
        If flag_rx_lmtoff = &H0 Then write_rx_lmtoff_value = get_rx_lmtoff
        If flag_rx_slicer_cal_done = &H0 Then write_rx_slicer_cal_done_value = get_rx_slicer_cal_done
        If flag_rx_sloff0_invalid = &H0 Then write_rx_sloff0_invalid_value = get_rx_sloff0_invalid
        If flag_rx_sloff1_invalid = &H0 Then write_rx_sloff1_invalid_value = get_rx_sloff1_invalid
        If flag_rx_sloff2_invalid = &H0 Then write_rx_sloff2_invalid_value = get_rx_sloff2_invalid

        regValue = leftShift((write_rx_lmtoff_value and &H3f), 4) + leftShift((write_rx_slicer_cal_done_value and &H1), 3) + leftShift((write_rx_sloff0_invalid_value and &H1), 2) + leftShift((write_rx_sloff1_invalid_value and &H1), 1) + leftShift((write_rx_sloff2_invalid_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lmtoff_value = rightShift(data_low, 4) and &H3f
        read_rx_slicer_cal_done_value = rightShift(data_low, 3) and &H1
        read_rx_sloff0_invalid_value = rightShift(data_low, 2) and &H1
        read_rx_sloff1_invalid_value = rightShift(data_low, 1) and &H1
        rx_sloff2_invalid_mask = &H1
        if data_low > LONG_MAX then
            if rx_sloff2_invalid_mask = mask then
                read_rx_sloff2_invalid_value = data_low
            else
                read_rx_sloff2_invalid_value = (data_low - H8000_0000) and rx_sloff2_invalid_mask
            end If
        else
            read_rx_sloff2_invalid_value = data_low and rx_sloff2_invalid_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_lmtoff_value = &H0
        flag_rx_lmtoff        = &H0
        write_rx_slicer_cal_done_value = &H0
        flag_rx_slicer_cal_done        = &H0
        write_rx_sloff0_invalid_value = &H0
        flag_rx_sloff0_invalid        = &H0
        write_rx_sloff1_invalid_value = &H0
        flag_rx_sloff1_invalid        = &H0
        write_rx_sloff2_invalid_value = &H0
        flag_rx_sloff2_invalid        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' up_sloffx_val                              [14:11]          get_up_sloffx_val
''                                                             set_up_sloffx_val
''                                                             read_up_sloffx_val
''                                                             write_up_sloffx_val
''---------------------------------------------------------------------------------
'' dn_sloffx_val                              [10:7]           get_dn_sloffx_val
''                                                             set_dn_sloffx_val
''                                                             read_dn_sloffx_val
''                                                             write_dn_sloffx_val
''---------------------------------------------------------------------------------
'' sloffx_val                                 [6:3]            get_sloffx_val
''                                                             set_sloffx_val
''                                                             read_sloffx_val
''                                                             write_sloffx_val
''---------------------------------------------------------------------------------
'' slcal_state                                [2:0]            get_slcal_state
''                                                             set_slcal_state
''                                                             read_slcal_state
''                                                             write_slcal_state
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status1
    Private write_up_sloffx_val_value
    Private read_up_sloffx_val_value
    Private flag_up_sloffx_val
    Private write_dn_sloffx_val_value
    Private read_dn_sloffx_val_value
    Private flag_dn_sloffx_val
    Private write_sloffx_val_value
    Private read_sloffx_val_value
    Private flag_sloffx_val
    Private write_slcal_state_value
    Private read_slcal_state_value
    Private flag_slcal_state

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

    Property Get get_up_sloffx_val
        get_up_sloffx_val = read_up_sloffx_val_value
    End Property

    Property Let set_up_sloffx_val(aData)
        write_up_sloffx_val_value = aData
        flag_up_sloffx_val        = &H1
    End Property

    Property Get read_up_sloffx_val
        read
        read_up_sloffx_val = read_up_sloffx_val_value
    End Property

    Property Let write_up_sloffx_val(aData)
        set_up_sloffx_val = aData
        write
    End Property

    Property Get get_dn_sloffx_val
        get_dn_sloffx_val = read_dn_sloffx_val_value
    End Property

    Property Let set_dn_sloffx_val(aData)
        write_dn_sloffx_val_value = aData
        flag_dn_sloffx_val        = &H1
    End Property

    Property Get read_dn_sloffx_val
        read
        read_dn_sloffx_val = read_dn_sloffx_val_value
    End Property

    Property Let write_dn_sloffx_val(aData)
        set_dn_sloffx_val = aData
        write
    End Property

    Property Get get_sloffx_val
        get_sloffx_val = read_sloffx_val_value
    End Property

    Property Let set_sloffx_val(aData)
        write_sloffx_val_value = aData
        flag_sloffx_val        = &H1
    End Property

    Property Get read_sloffx_val
        read
        read_sloffx_val = read_sloffx_val_value
    End Property

    Property Let write_sloffx_val(aData)
        set_sloffx_val = aData
        write
    End Property

    Property Get get_slcal_state
        get_slcal_state = read_slcal_state_value
    End Property

    Property Let set_slcal_state(aData)
        write_slcal_state_value = aData
        flag_slcal_state        = &H1
    End Property

    Property Get read_slcal_state
        read
        read_slcal_state = read_slcal_state_value
    End Property

    Property Let write_slcal_state(aData)
        set_slcal_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_up_sloffx_val_value = rightShift(data_low, 11) and &Hf
        read_dn_sloffx_val_value = rightShift(data_low, 7) and &Hf
        read_sloffx_val_value = rightShift(data_low, 3) and &Hf
        slcal_state_mask = &H7
        if data_low > LONG_MAX then
            if slcal_state_mask = mask then
                read_slcal_state_value = data_low
            else
                read_slcal_state_value = (data_low - H8000_0000) and slcal_state_mask
            end If
        else
            read_slcal_state_value = data_low and slcal_state_mask
        end If

    End Sub

    Sub write
        If flag_up_sloffx_val = &H0 or flag_dn_sloffx_val = &H0 or flag_sloffx_val = &H0 or flag_slcal_state = &H0 Then read
        If flag_up_sloffx_val = &H0 Then write_up_sloffx_val_value = get_up_sloffx_val
        If flag_dn_sloffx_val = &H0 Then write_dn_sloffx_val_value = get_dn_sloffx_val
        If flag_sloffx_val = &H0 Then write_sloffx_val_value = get_sloffx_val
        If flag_slcal_state = &H0 Then write_slcal_state_value = get_slcal_state

        regValue = leftShift((write_up_sloffx_val_value and &Hf), 11) + leftShift((write_dn_sloffx_val_value and &Hf), 7) + leftShift((write_sloffx_val_value and &Hf), 3) + leftShift((write_slcal_state_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_up_sloffx_val_value = rightShift(data_low, 11) and &Hf
        read_dn_sloffx_val_value = rightShift(data_low, 7) and &Hf
        read_sloffx_val_value = rightShift(data_low, 3) and &Hf
        slcal_state_mask = &H7
        if data_low > LONG_MAX then
            if slcal_state_mask = mask then
                read_slcal_state_value = data_low
            else
                read_slcal_state_value = (data_low - H8000_0000) and slcal_state_mask
            end If
        else
            read_slcal_state_value = data_low and slcal_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_up_sloffx_val_value = &H0
        flag_up_sloffx_val        = &H0
        write_dn_sloffx_val_value = &H0
        flag_dn_sloffx_val        = &H0
        write_sloffx_val_value = &H0
        flag_sloffx_val        = &H0
        write_slcal_state_value = &H0
        flag_slcal_state        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_acc                                 [15:0]           get_lmtcal_acc
''                                                             set_lmtcal_acc
''                                                             read_lmtcal_acc
''                                                             write_lmtcal_acc
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status2
    Private write_lmtcal_acc_value
    Private read_lmtcal_acc_value
    Private flag_lmtcal_acc

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

    Property Get get_lmtcal_acc
        get_lmtcal_acc = read_lmtcal_acc_value
    End Property

    Property Let set_lmtcal_acc(aData)
        write_lmtcal_acc_value = aData
        flag_lmtcal_acc        = &H1
    End Property

    Property Get read_lmtcal_acc
        read
        read_lmtcal_acc = read_lmtcal_acc_value
    End Property

    Property Let write_lmtcal_acc(aData)
        set_lmtcal_acc = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lmtcal_acc_mask = &Hffff
        if data_low > LONG_MAX then
            if lmtcal_acc_mask = mask then
                read_lmtcal_acc_value = data_low
            else
                read_lmtcal_acc_value = (data_low - H8000_0000) and lmtcal_acc_mask
            end If
        else
            read_lmtcal_acc_value = data_low and lmtcal_acc_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_acc = &H0 Then read
        If flag_lmtcal_acc = &H0 Then write_lmtcal_acc_value = get_lmtcal_acc

        regValue = leftShift((write_lmtcal_acc_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lmtcal_acc_mask = &Hffff
        if data_low > LONG_MAX then
            if lmtcal_acc_mask = mask then
                read_lmtcal_acc_value = data_low
            else
                read_lmtcal_acc_value = (data_low - H8000_0000) and lmtcal_acc_mask
            end If
        else
            read_lmtcal_acc_value = data_low and lmtcal_acc_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_acc_value = &H0
        flag_lmtcal_acc        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lmtcal_state                               [10:8]           get_lmtcal_state
''                                                             set_lmtcal_state
''                                                             read_lmtcal_state
''                                                             write_lmtcal_state
''---------------------------------------------------------------------------------
'' rx_LA_cal_done                             [7:7]            get_rx_LA_cal_done
''                                                             set_rx_LA_cal_done
''                                                             read_rx_LA_cal_done
''                                                             write_rx_LA_cal_done
''---------------------------------------------------------------------------------
'' lmtcal_valid                               [6:6]            get_lmtcal_valid
''                                                             set_lmtcal_valid
''                                                             read_lmtcal_valid
''                                                             write_lmtcal_valid
''---------------------------------------------------------------------------------
'' lmtcal_adj_cnt                             [5:1]            get_lmtcal_adj_cnt
''                                                             set_lmtcal_adj_cnt
''                                                             read_lmtcal_adj_cnt
''                                                             write_lmtcal_adj_cnt
''---------------------------------------------------------------------------------
'' recal_ind                                  [0:0]            get_recal_ind
''                                                             set_recal_ind
''                                                             read_recal_ind
''                                                             write_recal_ind
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status3
    Private write_lmtcal_state_value
    Private read_lmtcal_state_value
    Private flag_lmtcal_state
    Private write_rx_LA_cal_done_value
    Private read_rx_LA_cal_done_value
    Private flag_rx_LA_cal_done
    Private write_lmtcal_valid_value
    Private read_lmtcal_valid_value
    Private flag_lmtcal_valid
    Private write_lmtcal_adj_cnt_value
    Private read_lmtcal_adj_cnt_value
    Private flag_lmtcal_adj_cnt
    Private write_recal_ind_value
    Private read_recal_ind_value
    Private flag_recal_ind

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

    Property Get get_lmtcal_state
        get_lmtcal_state = read_lmtcal_state_value
    End Property

    Property Let set_lmtcal_state(aData)
        write_lmtcal_state_value = aData
        flag_lmtcal_state        = &H1
    End Property

    Property Get read_lmtcal_state
        read
        read_lmtcal_state = read_lmtcal_state_value
    End Property

    Property Let write_lmtcal_state(aData)
        set_lmtcal_state = aData
        write
    End Property

    Property Get get_rx_LA_cal_done
        get_rx_LA_cal_done = read_rx_LA_cal_done_value
    End Property

    Property Let set_rx_LA_cal_done(aData)
        write_rx_LA_cal_done_value = aData
        flag_rx_LA_cal_done        = &H1
    End Property

    Property Get read_rx_LA_cal_done
        read
        read_rx_LA_cal_done = read_rx_LA_cal_done_value
    End Property

    Property Let write_rx_LA_cal_done(aData)
        set_rx_LA_cal_done = aData
        write
    End Property

    Property Get get_lmtcal_valid
        get_lmtcal_valid = read_lmtcal_valid_value
    End Property

    Property Let set_lmtcal_valid(aData)
        write_lmtcal_valid_value = aData
        flag_lmtcal_valid        = &H1
    End Property

    Property Get read_lmtcal_valid
        read
        read_lmtcal_valid = read_lmtcal_valid_value
    End Property

    Property Let write_lmtcal_valid(aData)
        set_lmtcal_valid = aData
        write
    End Property

    Property Get get_lmtcal_adj_cnt
        get_lmtcal_adj_cnt = read_lmtcal_adj_cnt_value
    End Property

    Property Let set_lmtcal_adj_cnt(aData)
        write_lmtcal_adj_cnt_value = aData
        flag_lmtcal_adj_cnt        = &H1
    End Property

    Property Get read_lmtcal_adj_cnt
        read
        read_lmtcal_adj_cnt = read_lmtcal_adj_cnt_value
    End Property

    Property Let write_lmtcal_adj_cnt(aData)
        set_lmtcal_adj_cnt = aData
        write
    End Property

    Property Get get_recal_ind
        get_recal_ind = read_recal_ind_value
    End Property

    Property Let set_recal_ind(aData)
        write_recal_ind_value = aData
        flag_recal_ind        = &H1
    End Property

    Property Get read_recal_ind
        read
        read_recal_ind = read_recal_ind_value
    End Property

    Property Let write_recal_ind(aData)
        set_recal_ind = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_state_value = rightShift(data_low, 8) and &H7
        read_rx_LA_cal_done_value = rightShift(data_low, 7) and &H1
        read_lmtcal_valid_value = rightShift(data_low, 6) and &H1
        read_lmtcal_adj_cnt_value = rightShift(data_low, 1) and &H1f
        recal_ind_mask = &H1
        if data_low > LONG_MAX then
            if recal_ind_mask = mask then
                read_recal_ind_value = data_low
            else
                read_recal_ind_value = (data_low - H8000_0000) and recal_ind_mask
            end If
        else
            read_recal_ind_value = data_low and recal_ind_mask
        end If

    End Sub

    Sub write
        If flag_lmtcal_state = &H0 or flag_rx_LA_cal_done = &H0 or flag_lmtcal_valid = &H0 or flag_lmtcal_adj_cnt = &H0 or flag_recal_ind = &H0 Then read
        If flag_lmtcal_state = &H0 Then write_lmtcal_state_value = get_lmtcal_state
        If flag_rx_LA_cal_done = &H0 Then write_rx_LA_cal_done_value = get_rx_LA_cal_done
        If flag_lmtcal_valid = &H0 Then write_lmtcal_valid_value = get_lmtcal_valid
        If flag_lmtcal_adj_cnt = &H0 Then write_lmtcal_adj_cnt_value = get_lmtcal_adj_cnt
        If flag_recal_ind = &H0 Then write_recal_ind_value = get_recal_ind

        regValue = leftShift((write_lmtcal_state_value and &H7), 8) + leftShift((write_rx_LA_cal_done_value and &H1), 7) + leftShift((write_lmtcal_valid_value and &H1), 6) + leftShift((write_lmtcal_adj_cnt_value and &H1f), 1) + leftShift((write_recal_ind_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_lmtcal_state_value = rightShift(data_low, 8) and &H7
        read_rx_LA_cal_done_value = rightShift(data_low, 7) and &H1
        read_lmtcal_valid_value = rightShift(data_low, 6) and &H1
        read_lmtcal_adj_cnt_value = rightShift(data_low, 1) and &H1f
        recal_ind_mask = &H1
        if data_low > LONG_MAX then
            if recal_ind_mask = mask then
                read_recal_ind_value = data_low
            else
                read_recal_ind_value = (data_low - H8000_0000) and recal_ind_mask
            end If
        else
            read_recal_ind_value = data_low and recal_ind_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lmtcal_state_value = &H0
        flag_lmtcal_state        = &H0
        write_rx_LA_cal_done_value = &H0
        flag_rx_LA_cal_done        = &H0
        write_lmtcal_valid_value = &H0
        flag_lmtcal_valid        = &H0
        write_lmtcal_adj_cnt_value = &H0
        flag_lmtcal_adj_cnt        = &H0
        write_recal_ind_value = &H0
        flag_recal_ind        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' em_err_cnt_H                               [15:0]           get_em_err_cnt_H
''                                                             set_em_err_cnt_H
''                                                             read_em_err_cnt_H
''                                                             write_em_err_cnt_H
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status4
    Private write_em_err_cnt_H_value
    Private read_em_err_cnt_H_value
    Private flag_em_err_cnt_H

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_em_err_cnt_H
        get_em_err_cnt_H = read_em_err_cnt_H_value
    End Property

    Property Let set_em_err_cnt_H(aData)
        write_em_err_cnt_H_value = aData
        flag_em_err_cnt_H        = &H1
    End Property

    Property Get read_em_err_cnt_H
        read
        read_em_err_cnt_H = read_em_err_cnt_H_value
    End Property

    Property Let write_em_err_cnt_H(aData)
        set_em_err_cnt_H = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        em_err_cnt_H_mask = &Hffff
        if data_low > LONG_MAX then
            if em_err_cnt_H_mask = mask then
                read_em_err_cnt_H_value = data_low
            else
                read_em_err_cnt_H_value = (data_low - H8000_0000) and em_err_cnt_H_mask
            end If
        else
            read_em_err_cnt_H_value = data_low and em_err_cnt_H_mask
        end If

    End Sub

    Sub write
        If flag_em_err_cnt_H = &H0 Then read
        If flag_em_err_cnt_H = &H0 Then write_em_err_cnt_H_value = get_em_err_cnt_H

        regValue = leftShift((write_em_err_cnt_H_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        em_err_cnt_H_mask = &Hffff
        if data_low > LONG_MAX then
            if em_err_cnt_H_mask = mask then
                read_em_err_cnt_H_value = data_low
            else
                read_em_err_cnt_H_value = (data_low - H8000_0000) and em_err_cnt_H_mask
            end If
        else
            read_em_err_cnt_H_value = data_low and em_err_cnt_H_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_em_err_cnt_H_value = &H0
        flag_em_err_cnt_H        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' em_err_cnt_L                               [15:0]           get_em_err_cnt_L
''                                                             set_em_err_cnt_L
''                                                             read_em_err_cnt_L
''                                                             write_em_err_cnt_L
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status5
    Private write_em_err_cnt_L_value
    Private read_em_err_cnt_L_value
    Private flag_em_err_cnt_L

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_em_err_cnt_L
        get_em_err_cnt_L = read_em_err_cnt_L_value
    End Property

    Property Let set_em_err_cnt_L(aData)
        write_em_err_cnt_L_value = aData
        flag_em_err_cnt_L        = &H1
    End Property

    Property Get read_em_err_cnt_L
        read
        read_em_err_cnt_L = read_em_err_cnt_L_value
    End Property

    Property Let write_em_err_cnt_L(aData)
        set_em_err_cnt_L = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        em_err_cnt_L_mask = &Hffff
        if data_low > LONG_MAX then
            if em_err_cnt_L_mask = mask then
                read_em_err_cnt_L_value = data_low
            else
                read_em_err_cnt_L_value = (data_low - H8000_0000) and em_err_cnt_L_mask
            end If
        else
            read_em_err_cnt_L_value = data_low and em_err_cnt_L_mask
        end If

    End Sub

    Sub write
        If flag_em_err_cnt_L = &H0 Then read
        If flag_em_err_cnt_L = &H0 Then write_em_err_cnt_L_value = get_em_err_cnt_L

        regValue = leftShift((write_em_err_cnt_L_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        em_err_cnt_L_mask = &Hffff
        if data_low > LONG_MAX then
            if em_err_cnt_L_mask = mask then
                read_em_err_cnt_L_value = data_low
            else
                read_em_err_cnt_L_value = (data_low - H8000_0000) and em_err_cnt_L_mask
            end If
        else
            read_em_err_cnt_L_value = data_low and em_err_cnt_L_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_em_err_cnt_L_value = &H0
        flag_em_err_cnt_L        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_status6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_phs_interp_status                       [15:0]           get_rx_phs_interp_status
''                                                             set_rx_phs_interp_status
''                                                             read_rx_phs_interp_status
''                                                             write_rx_phs_interp_status
''---------------------------------------------------------------------------------
Class REGISTER_RX2__SGMIIPLUSR_X1_status6
    Private write_rx_phs_interp_status_value
    Private read_rx_phs_interp_status_value
    Private flag_rx_phs_interp_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_phs_interp_status
        get_rx_phs_interp_status = read_rx_phs_interp_status_value
    End Property

    Property Let set_rx_phs_interp_status(aData)
        write_rx_phs_interp_status_value = aData
        flag_rx_phs_interp_status        = &H1
    End Property

    Property Get read_rx_phs_interp_status
        read
        read_rx_phs_interp_status = read_rx_phs_interp_status_value
    End Property

    Property Let write_rx_phs_interp_status(aData)
        set_rx_phs_interp_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_phs_interp_status_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_phs_interp_status_mask = mask then
                read_rx_phs_interp_status_value = data_low
            else
                read_rx_phs_interp_status_value = (data_low - H8000_0000) and rx_phs_interp_status_mask
            end If
        else
            read_rx_phs_interp_status_value = data_low and rx_phs_interp_status_mask
        end If

    End Sub

    Sub write
        If flag_rx_phs_interp_status = &H0 Then read
        If flag_rx_phs_interp_status = &H0 Then write_rx_phs_interp_status_value = get_rx_phs_interp_status

        regValue = leftShift((write_rx_phs_interp_status_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_phs_interp_status_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_phs_interp_status_mask = mask then
                read_rx_phs_interp_status_value = data_low
            else
                read_rx_phs_interp_status_value = (data_low - H8000_0000) and rx_phs_interp_status_mask
            end If
        else
            read_rx_phs_interp_status_value = data_low and rx_phs_interp_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_phs_interp_status_value = &H0
        flag_rx_phs_interp_status        = &H0
    End Sub
End Class


'' @REGISTER : RX2__SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_RX2__SGMIIPLUSR_X1_blockaddress
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

Class RX2__SGMIIPLUSR_X1_INSTANCE

    Public rxseq0
    Public rxseq1
    Public rxcdr0
    Public rxcdr1
    Public rxcdr2
    Public rxcdr3
    Public rxcdr4
    Public status0
    Public status1
    Public status2
    Public status3
    Public status4
    Public status5
    Public status6
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set rxseq0 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxseq0)(aBaseAddr, 16)
        Set rxseq1 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxseq1)(aBaseAddr, 16)
        Set rxcdr0 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxcdr0)(aBaseAddr, 16)
        Set rxcdr1 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxcdr1)(aBaseAddr, 16)
        Set rxcdr2 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxcdr2)(aBaseAddr, 16)
        Set rxcdr3 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxcdr3)(aBaseAddr, 16)
        Set rxcdr4 = (New REGISTER_RX2__SGMIIPLUSR_X1_rxcdr4)(aBaseAddr, 16)
        Set status0 = (New REGISTER_RX2__SGMIIPLUSR_X1_status0)(aBaseAddr, 16)
        Set status1 = (New REGISTER_RX2__SGMIIPLUSR_X1_status1)(aBaseAddr, 16)
        Set status2 = (New REGISTER_RX2__SGMIIPLUSR_X1_status2)(aBaseAddr, 16)
        Set status3 = (New REGISTER_RX2__SGMIIPLUSR_X1_status3)(aBaseAddr, 16)
        Set status4 = (New REGISTER_RX2__SGMIIPLUSR_X1_status4)(aBaseAddr, 16)
        Set status5 = (New REGISTER_RX2__SGMIIPLUSR_X1_status5)(aBaseAddr, 16)
        Set status6 = (New REGISTER_RX2__SGMIIPLUSR_X1_status6)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX2__SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX2__SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
RX2__SGMIIPLUSR_X1.Add ((New RX2__SGMIIPLUSR_X1_INSTANCE)(&H4ae508e0))


