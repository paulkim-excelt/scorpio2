

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


'' @REGISTER : TX_AFE_PMD__SGMIIPLUS2_X2_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Fix_10units_en                             [15:15]          get_Fix_10units_en
''                                                             set_Fix_10units_en
''                                                             read_Fix_10units_en
''                                                             write_Fix_10units_en
''---------------------------------------------------------------------------------
'' Quarter_unit_en                            [14:14]          get_Quarter_unit_en
''                                                             set_Quarter_unit_en
''                                                             read_Quarter_unit_en
''                                                             write_Quarter_unit_en
''---------------------------------------------------------------------------------
'' main_control                               [13:8]           get_main_control
''                                                             set_main_control
''                                                             read_main_control
''                                                             write_main_control
''---------------------------------------------------------------------------------
'' rxdetect_th                                [6:5]            get_rxdetect_th
''                                                             set_rxdetect_th
''                                                             read_rxdetect_th
''                                                             write_rxdetect_th
''---------------------------------------------------------------------------------
'' idle_ena                                   [4:4]            get_idle_ena
''                                                             set_idle_ena
''                                                             read_idle_ena
''                                                             write_idle_ena
''---------------------------------------------------------------------------------
'' Testsel                                    [1:1]            get_Testsel
''                                                             set_Testsel
''                                                             read_Testsel
''                                                             write_Testsel
''---------------------------------------------------------------------------------
'' tx_pwrdn                                   [0:0]            get_tx_pwrdn
''                                                             set_tx_pwrdn
''                                                             read_tx_pwrdn
''                                                             write_tx_pwrdn
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control0
    Private write_Fix_10units_en_value
    Private read_Fix_10units_en_value
    Private flag_Fix_10units_en
    Private write_Quarter_unit_en_value
    Private read_Quarter_unit_en_value
    Private flag_Quarter_unit_en
    Private write_main_control_value
    Private read_main_control_value
    Private flag_main_control
    Private write_rxdetect_th_value
    Private read_rxdetect_th_value
    Private flag_rxdetect_th
    Private write_idle_ena_value
    Private read_idle_ena_value
    Private flag_idle_ena
    Private write_Testsel_value
    Private read_Testsel_value
    Private flag_Testsel
    Private write_tx_pwrdn_value
    Private read_tx_pwrdn_value
    Private flag_tx_pwrdn

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

    Property Get get_Fix_10units_en
        get_Fix_10units_en = read_Fix_10units_en_value
    End Property

    Property Let set_Fix_10units_en(aData)
        write_Fix_10units_en_value = aData
        flag_Fix_10units_en        = &H1
    End Property

    Property Get read_Fix_10units_en
        read
        read_Fix_10units_en = read_Fix_10units_en_value
    End Property

    Property Let write_Fix_10units_en(aData)
        set_Fix_10units_en = aData
        write
    End Property

    Property Get get_Quarter_unit_en
        get_Quarter_unit_en = read_Quarter_unit_en_value
    End Property

    Property Let set_Quarter_unit_en(aData)
        write_Quarter_unit_en_value = aData
        flag_Quarter_unit_en        = &H1
    End Property

    Property Get read_Quarter_unit_en
        read
        read_Quarter_unit_en = read_Quarter_unit_en_value
    End Property

    Property Let write_Quarter_unit_en(aData)
        set_Quarter_unit_en = aData
        write
    End Property

    Property Get get_main_control
        get_main_control = read_main_control_value
    End Property

    Property Let set_main_control(aData)
        write_main_control_value = aData
        flag_main_control        = &H1
    End Property

    Property Get read_main_control
        read
        read_main_control = read_main_control_value
    End Property

    Property Let write_main_control(aData)
        set_main_control = aData
        write
    End Property

    Property Get get_rxdetect_th
        get_rxdetect_th = read_rxdetect_th_value
    End Property

    Property Let set_rxdetect_th(aData)
        write_rxdetect_th_value = aData
        flag_rxdetect_th        = &H1
    End Property

    Property Get read_rxdetect_th
        read
        read_rxdetect_th = read_rxdetect_th_value
    End Property

    Property Let write_rxdetect_th(aData)
        set_rxdetect_th = aData
        write
    End Property

    Property Get get_idle_ena
        get_idle_ena = read_idle_ena_value
    End Property

    Property Let set_idle_ena(aData)
        write_idle_ena_value = aData
        flag_idle_ena        = &H1
    End Property

    Property Get read_idle_ena
        read
        read_idle_ena = read_idle_ena_value
    End Property

    Property Let write_idle_ena(aData)
        set_idle_ena = aData
        write
    End Property

    Property Get get_Testsel
        get_Testsel = read_Testsel_value
    End Property

    Property Let set_Testsel(aData)
        write_Testsel_value = aData
        flag_Testsel        = &H1
    End Property

    Property Get read_Testsel
        read
        read_Testsel = read_Testsel_value
    End Property

    Property Let write_Testsel(aData)
        set_Testsel = aData
        write
    End Property

    Property Get get_tx_pwrdn
        get_tx_pwrdn = read_tx_pwrdn_value
    End Property

    Property Let set_tx_pwrdn(aData)
        write_tx_pwrdn_value = aData
        flag_tx_pwrdn        = &H1
    End Property

    Property Get read_tx_pwrdn
        read
        read_tx_pwrdn = read_tx_pwrdn_value
    End Property

    Property Let write_tx_pwrdn(aData)
        set_tx_pwrdn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Fix_10units_en_value = rightShift(data_low, 15) and &H1
        read_Quarter_unit_en_value = rightShift(data_low, 14) and &H1
        read_main_control_value = rightShift(data_low, 8) and &H3f
        read_rxdetect_th_value = rightShift(data_low, 5) and &H3
        read_idle_ena_value = rightShift(data_low, 4) and &H1
        read_Testsel_value = rightShift(data_low, 1) and &H1
        tx_pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if tx_pwrdn_mask = mask then
                read_tx_pwrdn_value = data_low
            else
                read_tx_pwrdn_value = (data_low - H8000_0000) and tx_pwrdn_mask
            end If
        else
            read_tx_pwrdn_value = data_low and tx_pwrdn_mask
        end If

    End Sub

    Sub write
        If flag_Fix_10units_en = &H0 or flag_Quarter_unit_en = &H0 or flag_main_control = &H0 or flag_rxdetect_th = &H0 or flag_idle_ena = &H0 or flag_Testsel = &H0 or flag_tx_pwrdn = &H0 Then read
        If flag_Fix_10units_en = &H0 Then write_Fix_10units_en_value = get_Fix_10units_en
        If flag_Quarter_unit_en = &H0 Then write_Quarter_unit_en_value = get_Quarter_unit_en
        If flag_main_control = &H0 Then write_main_control_value = get_main_control
        If flag_rxdetect_th = &H0 Then write_rxdetect_th_value = get_rxdetect_th
        If flag_idle_ena = &H0 Then write_idle_ena_value = get_idle_ena
        If flag_Testsel = &H0 Then write_Testsel_value = get_Testsel
        If flag_tx_pwrdn = &H0 Then write_tx_pwrdn_value = get_tx_pwrdn

        regValue = leftShift((write_Fix_10units_en_value and &H1), 15) + leftShift((write_Quarter_unit_en_value and &H1), 14) + leftShift((write_main_control_value and &H3f), 8) + leftShift((write_rxdetect_th_value and &H3), 5) + leftShift((write_idle_ena_value and &H1), 4) + leftShift((write_Testsel_value and &H1), 1) + leftShift((write_tx_pwrdn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Fix_10units_en_value = rightShift(data_low, 15) and &H1
        read_Quarter_unit_en_value = rightShift(data_low, 14) and &H1
        read_main_control_value = rightShift(data_low, 8) and &H3f
        read_rxdetect_th_value = rightShift(data_low, 5) and &H3
        read_idle_ena_value = rightShift(data_low, 4) and &H1
        read_Testsel_value = rightShift(data_low, 1) and &H1
        tx_pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if tx_pwrdn_mask = mask then
                read_tx_pwrdn_value = data_low
            else
                read_tx_pwrdn_value = (data_low - H8000_0000) and tx_pwrdn_mask
            end If
        else
            read_tx_pwrdn_value = data_low and tx_pwrdn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Fix_10units_en_value = &H0
        flag_Fix_10units_en        = &H0
        write_Quarter_unit_en_value = &H0
        flag_Quarter_unit_en        = &H0
        write_main_control_value = &H0
        flag_main_control        = &H0
        write_rxdetect_th_value = &H0
        flag_rxdetect_th        = &H0
        write_idle_ena_value = &H0
        flag_idle_ena        = &H0
        write_Testsel_value = &H0
        flag_Testsel        = &H0
        write_tx_pwrdn_value = &H0
        flag_tx_pwrdn        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE_PMD__SGMIIPLUS2_X2_control1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Slew_rate_control                          [15:14]          get_Slew_rate_control
''                                                             set_Slew_rate_control
''                                                             read_Slew_rate_control
''                                                             write_Slew_rate_control
''---------------------------------------------------------------------------------
'' Post_enable                                [12:12]          get_Post_enable
''                                                             set_Post_enable
''                                                             read_Post_enable
''                                                             write_Post_enable
''---------------------------------------------------------------------------------
'' Post_control                               [11:6]           get_Post_control
''                                                             set_Post_control
''                                                             read_Post_control
''                                                             write_Post_control
''---------------------------------------------------------------------------------
'' Pwd_lvl2pi                                 [4:4]            get_Pwd_lvl2pi
''                                                             set_Pwd_lvl2pi
''                                                             read_Pwd_lvl2pi
''                                                             write_Pwd_lvl2pi
''---------------------------------------------------------------------------------
'' PI_bw_sel                                  [3:3]            get_PI_bw_sel
''                                                             set_PI_bw_sel
''                                                             read_PI_bw_sel
''                                                             write_PI_bw_sel
''---------------------------------------------------------------------------------
'' Const_Impedance                            [2:2]            get_Const_Impedance
''                                                             set_Const_Impedance
''                                                             read_Const_Impedance
''                                                             write_Const_Impedance
''---------------------------------------------------------------------------------
'' Amp_mode                                   [1:1]            get_Amp_mode
''                                                             set_Amp_mode
''                                                             read_Amp_mode
''                                                             write_Amp_mode
''---------------------------------------------------------------------------------
'' Vdd1p0_enb                                 [0:0]            get_Vdd1p0_enb
''                                                             set_Vdd1p0_enb
''                                                             read_Vdd1p0_enb
''                                                             write_Vdd1p0_enb
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control1
    Private write_Slew_rate_control_value
    Private read_Slew_rate_control_value
    Private flag_Slew_rate_control
    Private write_Post_enable_value
    Private read_Post_enable_value
    Private flag_Post_enable
    Private write_Post_control_value
    Private read_Post_control_value
    Private flag_Post_control
    Private write_Pwd_lvl2pi_value
    Private read_Pwd_lvl2pi_value
    Private flag_Pwd_lvl2pi
    Private write_PI_bw_sel_value
    Private read_PI_bw_sel_value
    Private flag_PI_bw_sel
    Private write_Const_Impedance_value
    Private read_Const_Impedance_value
    Private flag_Const_Impedance
    Private write_Amp_mode_value
    Private read_Amp_mode_value
    Private flag_Amp_mode
    Private write_Vdd1p0_enb_value
    Private read_Vdd1p0_enb_value
    Private flag_Vdd1p0_enb

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

    Property Get get_Slew_rate_control
        get_Slew_rate_control = read_Slew_rate_control_value
    End Property

    Property Let set_Slew_rate_control(aData)
        write_Slew_rate_control_value = aData
        flag_Slew_rate_control        = &H1
    End Property

    Property Get read_Slew_rate_control
        read
        read_Slew_rate_control = read_Slew_rate_control_value
    End Property

    Property Let write_Slew_rate_control(aData)
        set_Slew_rate_control = aData
        write
    End Property

    Property Get get_Post_enable
        get_Post_enable = read_Post_enable_value
    End Property

    Property Let set_Post_enable(aData)
        write_Post_enable_value = aData
        flag_Post_enable        = &H1
    End Property

    Property Get read_Post_enable
        read
        read_Post_enable = read_Post_enable_value
    End Property

    Property Let write_Post_enable(aData)
        set_Post_enable = aData
        write
    End Property

    Property Get get_Post_control
        get_Post_control = read_Post_control_value
    End Property

    Property Let set_Post_control(aData)
        write_Post_control_value = aData
        flag_Post_control        = &H1
    End Property

    Property Get read_Post_control
        read
        read_Post_control = read_Post_control_value
    End Property

    Property Let write_Post_control(aData)
        set_Post_control = aData
        write
    End Property

    Property Get get_Pwd_lvl2pi
        get_Pwd_lvl2pi = read_Pwd_lvl2pi_value
    End Property

    Property Let set_Pwd_lvl2pi(aData)
        write_Pwd_lvl2pi_value = aData
        flag_Pwd_lvl2pi        = &H1
    End Property

    Property Get read_Pwd_lvl2pi
        read
        read_Pwd_lvl2pi = read_Pwd_lvl2pi_value
    End Property

    Property Let write_Pwd_lvl2pi(aData)
        set_Pwd_lvl2pi = aData
        write
    End Property

    Property Get get_PI_bw_sel
        get_PI_bw_sel = read_PI_bw_sel_value
    End Property

    Property Let set_PI_bw_sel(aData)
        write_PI_bw_sel_value = aData
        flag_PI_bw_sel        = &H1
    End Property

    Property Get read_PI_bw_sel
        read
        read_PI_bw_sel = read_PI_bw_sel_value
    End Property

    Property Let write_PI_bw_sel(aData)
        set_PI_bw_sel = aData
        write
    End Property

    Property Get get_Const_Impedance
        get_Const_Impedance = read_Const_Impedance_value
    End Property

    Property Let set_Const_Impedance(aData)
        write_Const_Impedance_value = aData
        flag_Const_Impedance        = &H1
    End Property

    Property Get read_Const_Impedance
        read
        read_Const_Impedance = read_Const_Impedance_value
    End Property

    Property Let write_Const_Impedance(aData)
        set_Const_Impedance = aData
        write
    End Property

    Property Get get_Amp_mode
        get_Amp_mode = read_Amp_mode_value
    End Property

    Property Let set_Amp_mode(aData)
        write_Amp_mode_value = aData
        flag_Amp_mode        = &H1
    End Property

    Property Get read_Amp_mode
        read
        read_Amp_mode = read_Amp_mode_value
    End Property

    Property Let write_Amp_mode(aData)
        set_Amp_mode = aData
        write
    End Property

    Property Get get_Vdd1p0_enb
        get_Vdd1p0_enb = read_Vdd1p0_enb_value
    End Property

    Property Let set_Vdd1p0_enb(aData)
        write_Vdd1p0_enb_value = aData
        flag_Vdd1p0_enb        = &H1
    End Property

    Property Get read_Vdd1p0_enb
        read
        read_Vdd1p0_enb = read_Vdd1p0_enb_value
    End Property

    Property Let write_Vdd1p0_enb(aData)
        set_Vdd1p0_enb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Slew_rate_control_value = rightShift(data_low, 14) and &H3
        read_Post_enable_value = rightShift(data_low, 12) and &H1
        read_Post_control_value = rightShift(data_low, 6) and &H3f
        read_Pwd_lvl2pi_value = rightShift(data_low, 4) and &H1
        read_PI_bw_sel_value = rightShift(data_low, 3) and &H1
        read_Const_Impedance_value = rightShift(data_low, 2) and &H1
        read_Amp_mode_value = rightShift(data_low, 1) and &H1
        Vdd1p0_enb_mask = &H1
        if data_low > LONG_MAX then
            if Vdd1p0_enb_mask = mask then
                read_Vdd1p0_enb_value = data_low
            else
                read_Vdd1p0_enb_value = (data_low - H8000_0000) and Vdd1p0_enb_mask
            end If
        else
            read_Vdd1p0_enb_value = data_low and Vdd1p0_enb_mask
        end If

    End Sub

    Sub write
        If flag_Slew_rate_control = &H0 or flag_Post_enable = &H0 or flag_Post_control = &H0 or flag_Pwd_lvl2pi = &H0 or flag_PI_bw_sel = &H0 or flag_Const_Impedance = &H0 or flag_Amp_mode = &H0 or flag_Vdd1p0_enb = &H0 Then read
        If flag_Slew_rate_control = &H0 Then write_Slew_rate_control_value = get_Slew_rate_control
        If flag_Post_enable = &H0 Then write_Post_enable_value = get_Post_enable
        If flag_Post_control = &H0 Then write_Post_control_value = get_Post_control
        If flag_Pwd_lvl2pi = &H0 Then write_Pwd_lvl2pi_value = get_Pwd_lvl2pi
        If flag_PI_bw_sel = &H0 Then write_PI_bw_sel_value = get_PI_bw_sel
        If flag_Const_Impedance = &H0 Then write_Const_Impedance_value = get_Const_Impedance
        If flag_Amp_mode = &H0 Then write_Amp_mode_value = get_Amp_mode
        If flag_Vdd1p0_enb = &H0 Then write_Vdd1p0_enb_value = get_Vdd1p0_enb

        regValue = leftShift((write_Slew_rate_control_value and &H3), 14) + leftShift((write_Post_enable_value and &H1), 12) + leftShift((write_Post_control_value and &H3f), 6) + leftShift((write_Pwd_lvl2pi_value and &H1), 4) + leftShift((write_PI_bw_sel_value and &H1), 3) + leftShift((write_Const_Impedance_value and &H1), 2) + leftShift((write_Amp_mode_value and &H1), 1) + leftShift((write_Vdd1p0_enb_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Slew_rate_control_value = rightShift(data_low, 14) and &H3
        read_Post_enable_value = rightShift(data_low, 12) and &H1
        read_Post_control_value = rightShift(data_low, 6) and &H3f
        read_Pwd_lvl2pi_value = rightShift(data_low, 4) and &H1
        read_PI_bw_sel_value = rightShift(data_low, 3) and &H1
        read_Const_Impedance_value = rightShift(data_low, 2) and &H1
        read_Amp_mode_value = rightShift(data_low, 1) and &H1
        Vdd1p0_enb_mask = &H1
        if data_low > LONG_MAX then
            if Vdd1p0_enb_mask = mask then
                read_Vdd1p0_enb_value = data_low
            else
                read_Vdd1p0_enb_value = (data_low - H8000_0000) and Vdd1p0_enb_mask
            end If
        else
            read_Vdd1p0_enb_value = data_low and Vdd1p0_enb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Slew_rate_control_value = &H0
        flag_Slew_rate_control        = &H0
        write_Post_enable_value = &H0
        flag_Post_enable        = &H0
        write_Post_control_value = &H0
        flag_Post_control        = &H0
        write_Pwd_lvl2pi_value = &H0
        flag_Pwd_lvl2pi        = &H0
        write_PI_bw_sel_value = &H0
        flag_PI_bw_sel        = &H0
        write_Const_Impedance_value = &H0
        flag_Const_Impedance        = &H0
        write_Amp_mode_value = &H0
        flag_Amp_mode        = &H0
        write_Vdd1p0_enb_value = &H0
        flag_Vdd1p0_enb        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE_PMD__SGMIIPLUS2_X2_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' leakage_test                               [15:15]          get_leakage_test
''                                                             set_leakage_test
''                                                             read_leakage_test
''                                                             write_leakage_test
''---------------------------------------------------------------------------------
'' Vdd_noise_cncl_en                          [14:14]          get_Vdd_noise_cncl_en
''                                                             set_Vdd_noise_cncl_en
''                                                             read_Vdd_noise_cncl_en
''                                                             write_Vdd_noise_cncl_en
''---------------------------------------------------------------------------------
'' Noise_cncl_bias                            [13:10]          get_Noise_cncl_bias
''                                                             set_Noise_cncl_bias
''                                                             read_Noise_cncl_bias
''                                                             write_Noise_cncl_bias
''---------------------------------------------------------------------------------
'' Vdd_noise_shape                            [9:7]            get_Vdd_noise_shape
''                                                             set_Vdd_noise_shape
''                                                             read_Vdd_noise_shape
''                                                             write_Vdd_noise_shape
''---------------------------------------------------------------------------------
'' tx_pon                                     [6:3]            get_tx_pon
''                                                             set_tx_pon
''                                                             read_tx_pon
''                                                             write_tx_pon
''---------------------------------------------------------------------------------
'' ticksel                                    [2:1]            get_ticksel
''                                                             set_ticksel
''                                                             read_ticksel
''                                                             write_ticksel
''---------------------------------------------------------------------------------
'' testck_en                                  [0:0]            get_testck_en
''                                                             set_testck_en
''                                                             read_testck_en
''                                                             write_testck_en
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control2
    Private write_leakage_test_value
    Private read_leakage_test_value
    Private flag_leakage_test
    Private write_Vdd_noise_cncl_en_value
    Private read_Vdd_noise_cncl_en_value
    Private flag_Vdd_noise_cncl_en
    Private write_Noise_cncl_bias_value
    Private read_Noise_cncl_bias_value
    Private flag_Noise_cncl_bias
    Private write_Vdd_noise_shape_value
    Private read_Vdd_noise_shape_value
    Private flag_Vdd_noise_shape
    Private write_tx_pon_value
    Private read_tx_pon_value
    Private flag_tx_pon
    Private write_ticksel_value
    Private read_ticksel_value
    Private flag_ticksel
    Private write_testck_en_value
    Private read_testck_en_value
    Private flag_testck_en

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

    Property Get get_leakage_test
        get_leakage_test = read_leakage_test_value
    End Property

    Property Let set_leakage_test(aData)
        write_leakage_test_value = aData
        flag_leakage_test        = &H1
    End Property

    Property Get read_leakage_test
        read
        read_leakage_test = read_leakage_test_value
    End Property

    Property Let write_leakage_test(aData)
        set_leakage_test = aData
        write
    End Property

    Property Get get_Vdd_noise_cncl_en
        get_Vdd_noise_cncl_en = read_Vdd_noise_cncl_en_value
    End Property

    Property Let set_Vdd_noise_cncl_en(aData)
        write_Vdd_noise_cncl_en_value = aData
        flag_Vdd_noise_cncl_en        = &H1
    End Property

    Property Get read_Vdd_noise_cncl_en
        read
        read_Vdd_noise_cncl_en = read_Vdd_noise_cncl_en_value
    End Property

    Property Let write_Vdd_noise_cncl_en(aData)
        set_Vdd_noise_cncl_en = aData
        write
    End Property

    Property Get get_Noise_cncl_bias
        get_Noise_cncl_bias = read_Noise_cncl_bias_value
    End Property

    Property Let set_Noise_cncl_bias(aData)
        write_Noise_cncl_bias_value = aData
        flag_Noise_cncl_bias        = &H1
    End Property

    Property Get read_Noise_cncl_bias
        read
        read_Noise_cncl_bias = read_Noise_cncl_bias_value
    End Property

    Property Let write_Noise_cncl_bias(aData)
        set_Noise_cncl_bias = aData
        write
    End Property

    Property Get get_Vdd_noise_shape
        get_Vdd_noise_shape = read_Vdd_noise_shape_value
    End Property

    Property Let set_Vdd_noise_shape(aData)
        write_Vdd_noise_shape_value = aData
        flag_Vdd_noise_shape        = &H1
    End Property

    Property Get read_Vdd_noise_shape
        read
        read_Vdd_noise_shape = read_Vdd_noise_shape_value
    End Property

    Property Let write_Vdd_noise_shape(aData)
        set_Vdd_noise_shape = aData
        write
    End Property

    Property Get get_tx_pon
        get_tx_pon = read_tx_pon_value
    End Property

    Property Let set_tx_pon(aData)
        write_tx_pon_value = aData
        flag_tx_pon        = &H1
    End Property

    Property Get read_tx_pon
        read
        read_tx_pon = read_tx_pon_value
    End Property

    Property Let write_tx_pon(aData)
        set_tx_pon = aData
        write
    End Property

    Property Get get_ticksel
        get_ticksel = read_ticksel_value
    End Property

    Property Let set_ticksel(aData)
        write_ticksel_value = aData
        flag_ticksel        = &H1
    End Property

    Property Get read_ticksel
        read
        read_ticksel = read_ticksel_value
    End Property

    Property Let write_ticksel(aData)
        set_ticksel = aData
        write
    End Property

    Property Get get_testck_en
        get_testck_en = read_testck_en_value
    End Property

    Property Let set_testck_en(aData)
        write_testck_en_value = aData
        flag_testck_en        = &H1
    End Property

    Property Get read_testck_en
        read
        read_testck_en = read_testck_en_value
    End Property

    Property Let write_testck_en(aData)
        set_testck_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_leakage_test_value = rightShift(data_low, 15) and &H1
        read_Vdd_noise_cncl_en_value = rightShift(data_low, 14) and &H1
        read_Noise_cncl_bias_value = rightShift(data_low, 10) and &Hf
        read_Vdd_noise_shape_value = rightShift(data_low, 7) and &H7
        read_tx_pon_value = rightShift(data_low, 3) and &Hf
        read_ticksel_value = rightShift(data_low, 1) and &H3
        testck_en_mask = &H1
        if data_low > LONG_MAX then
            if testck_en_mask = mask then
                read_testck_en_value = data_low
            else
                read_testck_en_value = (data_low - H8000_0000) and testck_en_mask
            end If
        else
            read_testck_en_value = data_low and testck_en_mask
        end If

    End Sub

    Sub write
        If flag_leakage_test = &H0 or flag_Vdd_noise_cncl_en = &H0 or flag_Noise_cncl_bias = &H0 or flag_Vdd_noise_shape = &H0 or flag_tx_pon = &H0 or flag_ticksel = &H0 or flag_testck_en = &H0 Then read
        If flag_leakage_test = &H0 Then write_leakage_test_value = get_leakage_test
        If flag_Vdd_noise_cncl_en = &H0 Then write_Vdd_noise_cncl_en_value = get_Vdd_noise_cncl_en
        If flag_Noise_cncl_bias = &H0 Then write_Noise_cncl_bias_value = get_Noise_cncl_bias
        If flag_Vdd_noise_shape = &H0 Then write_Vdd_noise_shape_value = get_Vdd_noise_shape
        If flag_tx_pon = &H0 Then write_tx_pon_value = get_tx_pon
        If flag_ticksel = &H0 Then write_ticksel_value = get_ticksel
        If flag_testck_en = &H0 Then write_testck_en_value = get_testck_en

        regValue = leftShift((write_leakage_test_value and &H1), 15) + leftShift((write_Vdd_noise_cncl_en_value and &H1), 14) + leftShift((write_Noise_cncl_bias_value and &Hf), 10) + leftShift((write_Vdd_noise_shape_value and &H7), 7) + leftShift((write_tx_pon_value and &Hf), 3) + leftShift((write_ticksel_value and &H3), 1) + leftShift((write_testck_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_leakage_test_value = rightShift(data_low, 15) and &H1
        read_Vdd_noise_cncl_en_value = rightShift(data_low, 14) and &H1
        read_Noise_cncl_bias_value = rightShift(data_low, 10) and &Hf
        read_Vdd_noise_shape_value = rightShift(data_low, 7) and &H7
        read_tx_pon_value = rightShift(data_low, 3) and &Hf
        read_ticksel_value = rightShift(data_low, 1) and &H3
        testck_en_mask = &H1
        if data_low > LONG_MAX then
            if testck_en_mask = mask then
                read_testck_en_value = data_low
            else
                read_testck_en_value = (data_low - H8000_0000) and testck_en_mask
            end If
        else
            read_testck_en_value = data_low and testck_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_leakage_test_value = &H0
        flag_leakage_test        = &H0
        write_Vdd_noise_cncl_en_value = &H0
        flag_Vdd_noise_cncl_en        = &H0
        write_Noise_cncl_bias_value = &H0
        flag_Noise_cncl_bias        = &H0
        write_Vdd_noise_shape_value = &H0
        flag_Vdd_noise_shape        = &H0
        write_tx_pon_value = &H0
        flag_tx_pon        = &H0
        write_ticksel_value = &H0
        flag_ticksel        = &H0
        write_testck_en_value = &H0
        flag_testck_en        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE_PMD__SGMIIPLUS2_X2_control3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' main_lfps_control                          [4:0]            get_main_lfps_control
''                                                             set_main_lfps_control
''                                                             read_main_lfps_control
''                                                             write_main_lfps_control
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control3
    Private write_main_lfps_control_value
    Private read_main_lfps_control_value
    Private flag_main_lfps_control

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

    Property Get get_main_lfps_control
        get_main_lfps_control = read_main_lfps_control_value
    End Property

    Property Let set_main_lfps_control(aData)
        write_main_lfps_control_value = aData
        flag_main_lfps_control        = &H1
    End Property

    Property Get read_main_lfps_control
        read
        read_main_lfps_control = read_main_lfps_control_value
    End Property

    Property Let write_main_lfps_control(aData)
        set_main_lfps_control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        main_lfps_control_mask = &H1f
        if data_low > LONG_MAX then
            if main_lfps_control_mask = mask then
                read_main_lfps_control_value = data_low
            else
                read_main_lfps_control_value = (data_low - H8000_0000) and main_lfps_control_mask
            end If
        else
            read_main_lfps_control_value = data_low and main_lfps_control_mask
        end If

    End Sub

    Sub write
        If flag_main_lfps_control = &H0 Then read
        If flag_main_lfps_control = &H0 Then write_main_lfps_control_value = get_main_lfps_control

        regValue = leftShift((write_main_lfps_control_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        main_lfps_control_mask = &H1f
        if data_low > LONG_MAX then
            if main_lfps_control_mask = mask then
                read_main_lfps_control_value = data_low
            else
                read_main_lfps_control_value = (data_low - H8000_0000) and main_lfps_control_mask
            end If
        else
            read_main_lfps_control_value = data_low and main_lfps_control_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_main_lfps_control_value = &H0
        flag_main_lfps_control        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE_PMD__SGMIIPLUS2_X2_interp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_rateselect                              [7:7]            get_tx_rateselect
''                                                             set_tx_rateselect
''                                                             read_tx_rateselect
''                                                             write_tx_rateselect
''---------------------------------------------------------------------------------
'' interp_ctrl_quadrant                       [6:5]            get_interp_ctrl_quadrant
''                                                             set_interp_ctrl_quadrant
''                                                             read_interp_ctrl_quadrant
''                                                             write_interp_ctrl_quadrant
''---------------------------------------------------------------------------------
'' interp_ctrl_phs                            [4:0]            get_interp_ctrl_phs
''                                                             set_interp_ctrl_phs
''                                                             read_interp_ctrl_phs
''                                                             write_interp_ctrl_phs
''---------------------------------------------------------------------------------
Class REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_interp
    Private write_tx_rateselect_value
    Private read_tx_rateselect_value
    Private flag_tx_rateselect
    Private write_interp_ctrl_quadrant_value
    Private read_interp_ctrl_quadrant_value
    Private flag_interp_ctrl_quadrant
    Private write_interp_ctrl_phs_value
    Private read_interp_ctrl_phs_value
    Private flag_interp_ctrl_phs

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

    Property Get get_tx_rateselect
        get_tx_rateselect = read_tx_rateselect_value
    End Property

    Property Let set_tx_rateselect(aData)
        write_tx_rateselect_value = aData
        flag_tx_rateselect        = &H1
    End Property

    Property Get read_tx_rateselect
        read
        read_tx_rateselect = read_tx_rateselect_value
    End Property

    Property Let write_tx_rateselect(aData)
        set_tx_rateselect = aData
        write
    End Property

    Property Get get_interp_ctrl_quadrant
        get_interp_ctrl_quadrant = read_interp_ctrl_quadrant_value
    End Property

    Property Let set_interp_ctrl_quadrant(aData)
        write_interp_ctrl_quadrant_value = aData
        flag_interp_ctrl_quadrant        = &H1
    End Property

    Property Get read_interp_ctrl_quadrant
        read
        read_interp_ctrl_quadrant = read_interp_ctrl_quadrant_value
    End Property

    Property Let write_interp_ctrl_quadrant(aData)
        set_interp_ctrl_quadrant = aData
        write
    End Property

    Property Get get_interp_ctrl_phs
        get_interp_ctrl_phs = read_interp_ctrl_phs_value
    End Property

    Property Let set_interp_ctrl_phs(aData)
        write_interp_ctrl_phs_value = aData
        flag_interp_ctrl_phs        = &H1
    End Property

    Property Get read_interp_ctrl_phs
        read
        read_interp_ctrl_phs = read_interp_ctrl_phs_value
    End Property

    Property Let write_interp_ctrl_phs(aData)
        set_interp_ctrl_phs = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_rateselect_value = rightShift(data_low, 7) and &H1
        read_interp_ctrl_quadrant_value = rightShift(data_low, 5) and &H3
        interp_ctrl_phs_mask = &H1f
        if data_low > LONG_MAX then
            if interp_ctrl_phs_mask = mask then
                read_interp_ctrl_phs_value = data_low
            else
                read_interp_ctrl_phs_value = (data_low - H8000_0000) and interp_ctrl_phs_mask
            end If
        else
            read_interp_ctrl_phs_value = data_low and interp_ctrl_phs_mask
        end If

    End Sub

    Sub write
        If flag_tx_rateselect = &H0 or flag_interp_ctrl_quadrant = &H0 or flag_interp_ctrl_phs = &H0 Then read
        If flag_tx_rateselect = &H0 Then write_tx_rateselect_value = get_tx_rateselect
        If flag_interp_ctrl_quadrant = &H0 Then write_interp_ctrl_quadrant_value = get_interp_ctrl_quadrant
        If flag_interp_ctrl_phs = &H0 Then write_interp_ctrl_phs_value = get_interp_ctrl_phs

        regValue = leftShift((write_tx_rateselect_value and &H1), 7) + leftShift((write_interp_ctrl_quadrant_value and &H3), 5) + leftShift((write_interp_ctrl_phs_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_rateselect_value = rightShift(data_low, 7) and &H1
        read_interp_ctrl_quadrant_value = rightShift(data_low, 5) and &H3
        interp_ctrl_phs_mask = &H1f
        if data_low > LONG_MAX then
            if interp_ctrl_phs_mask = mask then
                read_interp_ctrl_phs_value = data_low
            else
                read_interp_ctrl_phs_value = (data_low - H8000_0000) and interp_ctrl_phs_mask
            end If
        else
            read_interp_ctrl_phs_value = data_low and interp_ctrl_phs_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_rateselect_value = &H0
        flag_tx_rateselect        = &H0
        write_interp_ctrl_quadrant_value = &H0
        flag_interp_ctrl_quadrant        = &H0
        write_interp_ctrl_phs_value = &H0
        flag_interp_ctrl_phs        = &H0
    End Sub
End Class


'' @REGISTER : TX_AFE_PMD__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_blockaddress
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

Class TX_AFE_PMD__SGMIIPLUS2_X2_INSTANCE

    Public control0
    Public control1
    Public control2
    Public control3
    Public interp
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set control0 = (New REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control0)(aBaseAddr, 16)
        Set control1 = (New REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control1)(aBaseAddr, 16)
        Set control2 = (New REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control2)(aBaseAddr, 16)
        Set control3 = (New REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_control3)(aBaseAddr, 16)
        Set interp = (New REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_interp)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_AFE_PMD__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_AFE_PMD__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
TX_AFE_PMD__SGMIIPLUS2_X2.Add ((New TX_AFE_PMD__SGMIIPLUS2_X2_INSTANCE)(&H4ac500c0))
TX_AFE_PMD__SGMIIPLUS2_X2.Add ((New TX_AFE_PMD__SGMIIPLUS2_X2_INSTANCE)(&H4ac700c0))


