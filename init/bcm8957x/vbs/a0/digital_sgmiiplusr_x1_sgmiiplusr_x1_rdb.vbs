

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


'' @REGISTER : DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_control1000x2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' disable_extend_fdx_only                    [15:15]          get_disable_extend_fdx_only
''                                                             set_disable_extend_fdx_only
''                                                             read_disable_extend_fdx_only
''                                                             write_disable_extend_fdx_only
''---------------------------------------------------------------------------------
'' clear_ber_counter                          [14:14]          get_clear_ber_counter
''                                                             set_clear_ber_counter
''                                                             read_clear_ber_counter
''                                                             write_clear_ber_counter
''---------------------------------------------------------------------------------
'' disable_TRRR_generation                    [8:8]            get_disable_TRRR_generation
''                                                             set_disable_TRRR_generation
''                                                             read_disable_TRRR_generation
''                                                             write_disable_TRRR_generation
''---------------------------------------------------------------------------------
'' disable_carrier_extend                     [7:7]            get_disable_carrier_extend
''                                                             set_disable_carrier_extend
''                                                             read_disable_carrier_extend
''                                                             write_disable_carrier_extend
''---------------------------------------------------------------------------------
'' DRFR1                                      [4:4]            get_DRFR1
''                                                             set_DRFR1
''                                                             read_DRFR1
''                                                             write_DRFR1
''---------------------------------------------------------------------------------
'' enable_autoneg_err_timer                   [3:3]            get_enable_autoneg_err_timer
''                                                             set_enable_autoneg_err_timer
''                                                             read_enable_autoneg_err_timer
''                                                             write_enable_autoneg_err_timer
''---------------------------------------------------------------------------------
'' filter_force_link                          [2:2]            get_filter_force_link
''                                                             set_filter_force_link
''                                                             read_filter_force_link
''                                                             write_filter_force_link
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_control1000x2
    Private write_disable_extend_fdx_only_value
    Private read_disable_extend_fdx_only_value
    Private flag_disable_extend_fdx_only
    Private write_clear_ber_counter_value
    Private read_clear_ber_counter_value
    Private flag_clear_ber_counter
    Private write_disable_TRRR_generation_value
    Private read_disable_TRRR_generation_value
    Private flag_disable_TRRR_generation
    Private write_disable_carrier_extend_value
    Private read_disable_carrier_extend_value
    Private flag_disable_carrier_extend
    Private write_DRFR1_value
    Private read_DRFR1_value
    Private flag_DRFR1
    Private write_enable_autoneg_err_timer_value
    Private read_enable_autoneg_err_timer_value
    Private flag_enable_autoneg_err_timer
    Private write_filter_force_link_value
    Private read_filter_force_link_value
    Private flag_filter_force_link

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

    Property Get get_disable_extend_fdx_only
        get_disable_extend_fdx_only = read_disable_extend_fdx_only_value
    End Property

    Property Let set_disable_extend_fdx_only(aData)
        write_disable_extend_fdx_only_value = aData
        flag_disable_extend_fdx_only        = &H1
    End Property

    Property Get read_disable_extend_fdx_only
        read
        read_disable_extend_fdx_only = read_disable_extend_fdx_only_value
    End Property

    Property Let write_disable_extend_fdx_only(aData)
        set_disable_extend_fdx_only = aData
        write
    End Property

    Property Get get_clear_ber_counter
        get_clear_ber_counter = read_clear_ber_counter_value
    End Property

    Property Let set_clear_ber_counter(aData)
        write_clear_ber_counter_value = aData
        flag_clear_ber_counter        = &H1
    End Property

    Property Get read_clear_ber_counter
        read
        read_clear_ber_counter = read_clear_ber_counter_value
    End Property

    Property Let write_clear_ber_counter(aData)
        set_clear_ber_counter = aData
        write
    End Property

    Property Get get_disable_TRRR_generation
        get_disable_TRRR_generation = read_disable_TRRR_generation_value
    End Property

    Property Let set_disable_TRRR_generation(aData)
        write_disable_TRRR_generation_value = aData
        flag_disable_TRRR_generation        = &H1
    End Property

    Property Get read_disable_TRRR_generation
        read
        read_disable_TRRR_generation = read_disable_TRRR_generation_value
    End Property

    Property Let write_disable_TRRR_generation(aData)
        set_disable_TRRR_generation = aData
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

    Property Get get_DRFR1
        get_DRFR1 = read_DRFR1_value
    End Property

    Property Let set_DRFR1(aData)
        write_DRFR1_value = aData
        flag_DRFR1        = &H1
    End Property

    Property Get read_DRFR1
        read
        read_DRFR1 = read_DRFR1_value
    End Property

    Property Let write_DRFR1(aData)
        set_DRFR1 = aData
        write
    End Property

    Property Get get_enable_autoneg_err_timer
        get_enable_autoneg_err_timer = read_enable_autoneg_err_timer_value
    End Property

    Property Let set_enable_autoneg_err_timer(aData)
        write_enable_autoneg_err_timer_value = aData
        flag_enable_autoneg_err_timer        = &H1
    End Property

    Property Get read_enable_autoneg_err_timer
        read
        read_enable_autoneg_err_timer = read_enable_autoneg_err_timer_value
    End Property

    Property Let write_enable_autoneg_err_timer(aData)
        set_enable_autoneg_err_timer = aData
        write
    End Property

    Property Get get_filter_force_link
        get_filter_force_link = read_filter_force_link_value
    End Property

    Property Let set_filter_force_link(aData)
        write_filter_force_link_value = aData
        flag_filter_force_link        = &H1
    End Property

    Property Get read_filter_force_link
        read
        read_filter_force_link = read_filter_force_link_value
    End Property

    Property Let write_filter_force_link(aData)
        set_filter_force_link = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_disable_extend_fdx_only_value = rightShift(data_low, 15) and &H1
        read_clear_ber_counter_value = rightShift(data_low, 14) and &H1
        read_disable_TRRR_generation_value = rightShift(data_low, 8) and &H1
        read_disable_carrier_extend_value = rightShift(data_low, 7) and &H1
        read_DRFR1_value = rightShift(data_low, 4) and &H1
        read_enable_autoneg_err_timer_value = rightShift(data_low, 3) and &H1
        read_filter_force_link_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_disable_extend_fdx_only = &H0 or flag_clear_ber_counter = &H0 or flag_disable_TRRR_generation = &H0 or flag_disable_carrier_extend = &H0 or flag_DRFR1 = &H0 or flag_enable_autoneg_err_timer = &H0 or flag_filter_force_link = &H0 Then read
        If flag_disable_extend_fdx_only = &H0 Then write_disable_extend_fdx_only_value = get_disable_extend_fdx_only
        If flag_clear_ber_counter = &H0 Then write_clear_ber_counter_value = get_clear_ber_counter
        If flag_disable_TRRR_generation = &H0 Then write_disable_TRRR_generation_value = get_disable_TRRR_generation
        If flag_disable_carrier_extend = &H0 Then write_disable_carrier_extend_value = get_disable_carrier_extend
        If flag_DRFR1 = &H0 Then write_DRFR1_value = get_DRFR1
        If flag_enable_autoneg_err_timer = &H0 Then write_enable_autoneg_err_timer_value = get_enable_autoneg_err_timer
        If flag_filter_force_link = &H0 Then write_filter_force_link_value = get_filter_force_link

        regValue = leftShift((write_disable_extend_fdx_only_value and &H1), 15) + leftShift((write_clear_ber_counter_value and &H1), 14) + leftShift((write_disable_TRRR_generation_value and &H1), 8) + leftShift((write_disable_carrier_extend_value and &H1), 7) + leftShift((write_DRFR1_value and &H1), 4) + leftShift((write_enable_autoneg_err_timer_value and &H1), 3) + leftShift((write_filter_force_link_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_disable_extend_fdx_only_value = rightShift(data_low, 15) and &H1
        read_clear_ber_counter_value = rightShift(data_low, 14) and &H1
        read_disable_TRRR_generation_value = rightShift(data_low, 8) and &H1
        read_disable_carrier_extend_value = rightShift(data_low, 7) and &H1
        read_DRFR1_value = rightShift(data_low, 4) and &H1
        read_enable_autoneg_err_timer_value = rightShift(data_low, 3) and &H1
        read_filter_force_link_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_disable_extend_fdx_only_value = &H0
        flag_disable_extend_fdx_only        = &H0
        write_clear_ber_counter_value = &H0
        flag_clear_ber_counter        = &H0
        write_disable_TRRR_generation_value = &H0
        flag_disable_TRRR_generation        = &H0
        write_disable_carrier_extend_value = &H0
        flag_disable_carrier_extend        = &H0
        write_DRFR1_value = &H0
        flag_DRFR1        = &H0
        write_enable_autoneg_err_timer_value = &H0
        flag_enable_autoneg_err_timer        = &H0
        write_filter_force_link_value = &H0
        flag_filter_force_link        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_status1000x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_err_detected                            [11:11]          get_tx_err_detected
''                                                             set_tx_err_detected
''                                                             read_tx_err_detected
''                                                             write_tx_err_detected
''---------------------------------------------------------------------------------
'' rx_err_detected                            [10:10]          get_rx_err_detected
''                                                             set_rx_err_detected
''                                                             read_rx_err_detected
''                                                             write_rx_err_detected
''---------------------------------------------------------------------------------
'' link_status_change                         [7:7]            get_link_status_change
''                                                             set_link_status_change
''                                                             read_link_status_change
''                                                             write_link_status_change
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_status1000x1
    Private write_tx_err_detected_value
    Private read_tx_err_detected_value
    Private flag_tx_err_detected
    Private write_rx_err_detected_value
    Private read_rx_err_detected_value
    Private flag_rx_err_detected
    Private write_link_status_change_value
    Private read_link_status_change_value
    Private flag_link_status_change

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

    Property Get get_tx_err_detected
        get_tx_err_detected = read_tx_err_detected_value
    End Property

    Property Let set_tx_err_detected(aData)
        write_tx_err_detected_value = aData
        flag_tx_err_detected        = &H1
    End Property

    Property Get read_tx_err_detected
        read
        read_tx_err_detected = read_tx_err_detected_value
    End Property

    Property Let write_tx_err_detected(aData)
        set_tx_err_detected = aData
        write
    End Property

    Property Get get_rx_err_detected
        get_rx_err_detected = read_rx_err_detected_value
    End Property

    Property Let set_rx_err_detected(aData)
        write_rx_err_detected_value = aData
        flag_rx_err_detected        = &H1
    End Property

    Property Get read_rx_err_detected
        read
        read_rx_err_detected = read_rx_err_detected_value
    End Property

    Property Let write_rx_err_detected(aData)
        set_rx_err_detected = aData
        write
    End Property

    Property Get get_link_status_change
        get_link_status_change = read_link_status_change_value
    End Property

    Property Let set_link_status_change(aData)
        write_link_status_change_value = aData
        flag_link_status_change        = &H1
    End Property

    Property Get read_link_status_change
        read
        read_link_status_change = read_link_status_change_value
    End Property

    Property Let write_link_status_change(aData)
        set_link_status_change = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_err_detected_value = rightShift(data_low, 11) and &H1
        read_rx_err_detected_value = rightShift(data_low, 10) and &H1
        read_link_status_change_value = rightShift(data_low, 7) and &H1

    End Sub

    Sub write
        If flag_tx_err_detected = &H0 or flag_rx_err_detected = &H0 or flag_link_status_change = &H0 Then read
        If flag_tx_err_detected = &H0 Then write_tx_err_detected_value = get_tx_err_detected
        If flag_rx_err_detected = &H0 Then write_rx_err_detected_value = get_rx_err_detected
        If flag_link_status_change = &H0 Then write_link_status_change_value = get_link_status_change

        regValue = leftShift((write_tx_err_detected_value and &H1), 11) + leftShift((write_rx_err_detected_value and &H1), 10) + leftShift((write_link_status_change_value and &H1), 7)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_err_detected_value = rightShift(data_low, 11) and &H1
        read_rx_err_detected_value = rightShift(data_low, 10) and &H1
        read_link_status_change_value = rightShift(data_low, 7) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_err_detected_value = &H0
        flag_tx_err_detected        = &H0
        write_rx_err_detected_value = &H0
        flag_rx_err_detected        = &H0
        write_link_status_change_value = &H0
        flag_link_status_change        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_spare
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [7:0]            get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_spare
    Private write_spare_value
    Private read_spare_value
    Private flag_spare

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

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_mask = &Hff
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare

        regValue = leftShift((write_spare_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_mask = &Hff
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_miscdigcontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' force_ieee_SpeedSel_en                     [15:15]          get_force_ieee_SpeedSel_en
''                                                             set_force_ieee_SpeedSel_en
''                                                             read_force_ieee_SpeedSel_en
''                                                             write_force_ieee_SpeedSel_en
''---------------------------------------------------------------------------------
'' force_ieee_cl22_SpeedSel_en                [14:14]          get_force_ieee_cl22_SpeedSel_en
''                                                             set_force_ieee_cl22_SpeedSel_en
''                                                             read_force_ieee_cl22_SpeedSel_en
''                                                             write_force_ieee_cl22_SpeedSel_en
''---------------------------------------------------------------------------------
'' use_ieee_reg_ctrl_sel                      [13:12]          get_use_ieee_reg_ctrl_sel
''                                                             set_use_ieee_reg_ctrl_sel
''                                                             read_use_ieee_reg_ctrl_sel
''                                                             write_use_ieee_reg_ctrl_sel
''---------------------------------------------------------------------------------
'' credit_sw_en                               [11:11]          get_credit_sw_en
''                                                             set_credit_sw_en
''                                                             read_credit_sw_en
''                                                             write_credit_sw_en
''---------------------------------------------------------------------------------
'' replication_cnt                            [10:10]          get_replication_cnt
''                                                             set_replication_cnt
''                                                             read_replication_cnt
''                                                             write_replication_cnt
''---------------------------------------------------------------------------------
'' sgmii_spd_switch                           [9:9]            get_sgmii_spd_switch
''                                                             set_sgmii_spd_switch
''                                                             read_sgmii_spd_switch
''                                                             write_sgmii_spd_switch
''---------------------------------------------------------------------------------
'' pcs_creditenable                           [8:8]            get_pcs_creditenable
''                                                             set_pcs_creditenable
''                                                             read_pcs_creditenable
''                                                             write_pcs_creditenable
''---------------------------------------------------------------------------------
'' mac_creditenable                           [7:7]            get_mac_creditenable
''                                                             set_mac_creditenable
''                                                             read_mac_creditenable
''                                                             write_mac_creditenable
''---------------------------------------------------------------------------------
'' SW_actual_speed_force_en                   [6:6]            get_SW_actual_speed_force_en
''                                                             set_SW_actual_speed_force_en
''                                                             read_SW_actual_speed_force_en
''                                                             write_SW_actual_speed_force_en
''---------------------------------------------------------------------------------
'' SW_actual_speed                            [5:0]            get_SW_actual_speed
''                                                             set_SW_actual_speed
''                                                             read_SW_actual_speed
''                                                             write_SW_actual_speed
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_miscdigcontrol
    Private write_force_ieee_SpeedSel_en_value
    Private read_force_ieee_SpeedSel_en_value
    Private flag_force_ieee_SpeedSel_en
    Private write_force_ieee_cl22_SpeedSel_en_value
    Private read_force_ieee_cl22_SpeedSel_en_value
    Private flag_force_ieee_cl22_SpeedSel_en
    Private write_use_ieee_reg_ctrl_sel_value
    Private read_use_ieee_reg_ctrl_sel_value
    Private flag_use_ieee_reg_ctrl_sel
    Private write_credit_sw_en_value
    Private read_credit_sw_en_value
    Private flag_credit_sw_en
    Private write_replication_cnt_value
    Private read_replication_cnt_value
    Private flag_replication_cnt
    Private write_sgmii_spd_switch_value
    Private read_sgmii_spd_switch_value
    Private flag_sgmii_spd_switch
    Private write_pcs_creditenable_value
    Private read_pcs_creditenable_value
    Private flag_pcs_creditenable
    Private write_mac_creditenable_value
    Private read_mac_creditenable_value
    Private flag_mac_creditenable
    Private write_SW_actual_speed_force_en_value
    Private read_SW_actual_speed_force_en_value
    Private flag_SW_actual_speed_force_en
    Private write_SW_actual_speed_value
    Private read_SW_actual_speed_value
    Private flag_SW_actual_speed

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

    Property Get get_force_ieee_SpeedSel_en
        get_force_ieee_SpeedSel_en = read_force_ieee_SpeedSel_en_value
    End Property

    Property Let set_force_ieee_SpeedSel_en(aData)
        write_force_ieee_SpeedSel_en_value = aData
        flag_force_ieee_SpeedSel_en        = &H1
    End Property

    Property Get read_force_ieee_SpeedSel_en
        read
        read_force_ieee_SpeedSel_en = read_force_ieee_SpeedSel_en_value
    End Property

    Property Let write_force_ieee_SpeedSel_en(aData)
        set_force_ieee_SpeedSel_en = aData
        write
    End Property

    Property Get get_force_ieee_cl22_SpeedSel_en
        get_force_ieee_cl22_SpeedSel_en = read_force_ieee_cl22_SpeedSel_en_value
    End Property

    Property Let set_force_ieee_cl22_SpeedSel_en(aData)
        write_force_ieee_cl22_SpeedSel_en_value = aData
        flag_force_ieee_cl22_SpeedSel_en        = &H1
    End Property

    Property Get read_force_ieee_cl22_SpeedSel_en
        read
        read_force_ieee_cl22_SpeedSel_en = read_force_ieee_cl22_SpeedSel_en_value
    End Property

    Property Let write_force_ieee_cl22_SpeedSel_en(aData)
        set_force_ieee_cl22_SpeedSel_en = aData
        write
    End Property

    Property Get get_use_ieee_reg_ctrl_sel
        get_use_ieee_reg_ctrl_sel = read_use_ieee_reg_ctrl_sel_value
    End Property

    Property Let set_use_ieee_reg_ctrl_sel(aData)
        write_use_ieee_reg_ctrl_sel_value = aData
        flag_use_ieee_reg_ctrl_sel        = &H1
    End Property

    Property Get read_use_ieee_reg_ctrl_sel
        read
        read_use_ieee_reg_ctrl_sel = read_use_ieee_reg_ctrl_sel_value
    End Property

    Property Let write_use_ieee_reg_ctrl_sel(aData)
        set_use_ieee_reg_ctrl_sel = aData
        write
    End Property

    Property Get get_credit_sw_en
        get_credit_sw_en = read_credit_sw_en_value
    End Property

    Property Let set_credit_sw_en(aData)
        write_credit_sw_en_value = aData
        flag_credit_sw_en        = &H1
    End Property

    Property Get read_credit_sw_en
        read
        read_credit_sw_en = read_credit_sw_en_value
    End Property

    Property Let write_credit_sw_en(aData)
        set_credit_sw_en = aData
        write
    End Property

    Property Get get_replication_cnt
        get_replication_cnt = read_replication_cnt_value
    End Property

    Property Let set_replication_cnt(aData)
        write_replication_cnt_value = aData
        flag_replication_cnt        = &H1
    End Property

    Property Get read_replication_cnt
        read
        read_replication_cnt = read_replication_cnt_value
    End Property

    Property Let write_replication_cnt(aData)
        set_replication_cnt = aData
        write
    End Property

    Property Get get_sgmii_spd_switch
        get_sgmii_spd_switch = read_sgmii_spd_switch_value
    End Property

    Property Let set_sgmii_spd_switch(aData)
        write_sgmii_spd_switch_value = aData
        flag_sgmii_spd_switch        = &H1
    End Property

    Property Get read_sgmii_spd_switch
        read
        read_sgmii_spd_switch = read_sgmii_spd_switch_value
    End Property

    Property Let write_sgmii_spd_switch(aData)
        set_sgmii_spd_switch = aData
        write
    End Property

    Property Get get_pcs_creditenable
        get_pcs_creditenable = read_pcs_creditenable_value
    End Property

    Property Let set_pcs_creditenable(aData)
        write_pcs_creditenable_value = aData
        flag_pcs_creditenable        = &H1
    End Property

    Property Get read_pcs_creditenable
        read
        read_pcs_creditenable = read_pcs_creditenable_value
    End Property

    Property Let write_pcs_creditenable(aData)
        set_pcs_creditenable = aData
        write
    End Property

    Property Get get_mac_creditenable
        get_mac_creditenable = read_mac_creditenable_value
    End Property

    Property Let set_mac_creditenable(aData)
        write_mac_creditenable_value = aData
        flag_mac_creditenable        = &H1
    End Property

    Property Get read_mac_creditenable
        read
        read_mac_creditenable = read_mac_creditenable_value
    End Property

    Property Let write_mac_creditenable(aData)
        set_mac_creditenable = aData
        write
    End Property

    Property Get get_SW_actual_speed_force_en
        get_SW_actual_speed_force_en = read_SW_actual_speed_force_en_value
    End Property

    Property Let set_SW_actual_speed_force_en(aData)
        write_SW_actual_speed_force_en_value = aData
        flag_SW_actual_speed_force_en        = &H1
    End Property

    Property Get read_SW_actual_speed_force_en
        read
        read_SW_actual_speed_force_en = read_SW_actual_speed_force_en_value
    End Property

    Property Let write_SW_actual_speed_force_en(aData)
        set_SW_actual_speed_force_en = aData
        write
    End Property

    Property Get get_SW_actual_speed
        get_SW_actual_speed = read_SW_actual_speed_value
    End Property

    Property Let set_SW_actual_speed(aData)
        write_SW_actual_speed_value = aData
        flag_SW_actual_speed        = &H1
    End Property

    Property Get read_SW_actual_speed
        read
        read_SW_actual_speed = read_SW_actual_speed_value
    End Property

    Property Let write_SW_actual_speed(aData)
        set_SW_actual_speed = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_force_ieee_SpeedSel_en_value = rightShift(data_low, 15) and &H1
        read_force_ieee_cl22_SpeedSel_en_value = rightShift(data_low, 14) and &H1
        read_use_ieee_reg_ctrl_sel_value = rightShift(data_low, 12) and &H3
        read_credit_sw_en_value = rightShift(data_low, 11) and &H1
        read_replication_cnt_value = rightShift(data_low, 10) and &H1
        read_sgmii_spd_switch_value = rightShift(data_low, 9) and &H1
        read_pcs_creditenable_value = rightShift(data_low, 8) and &H1
        read_mac_creditenable_value = rightShift(data_low, 7) and &H1
        read_SW_actual_speed_force_en_value = rightShift(data_low, 6) and &H1
        SW_actual_speed_mask = &H3f
        if data_low > LONG_MAX then
            if SW_actual_speed_mask = mask then
                read_SW_actual_speed_value = data_low
            else
                read_SW_actual_speed_value = (data_low - H8000_0000) and SW_actual_speed_mask
            end If
        else
            read_SW_actual_speed_value = data_low and SW_actual_speed_mask
        end If

    End Sub

    Sub write
        If flag_force_ieee_SpeedSel_en = &H0 or flag_force_ieee_cl22_SpeedSel_en = &H0 or flag_use_ieee_reg_ctrl_sel = &H0 or flag_credit_sw_en = &H0 or flag_replication_cnt = &H0 or flag_sgmii_spd_switch = &H0 or flag_pcs_creditenable = &H0 or flag_mac_creditenable = &H0 or flag_SW_actual_speed_force_en = &H0 or flag_SW_actual_speed = &H0 Then read
        If flag_force_ieee_SpeedSel_en = &H0 Then write_force_ieee_SpeedSel_en_value = get_force_ieee_SpeedSel_en
        If flag_force_ieee_cl22_SpeedSel_en = &H0 Then write_force_ieee_cl22_SpeedSel_en_value = get_force_ieee_cl22_SpeedSel_en
        If flag_use_ieee_reg_ctrl_sel = &H0 Then write_use_ieee_reg_ctrl_sel_value = get_use_ieee_reg_ctrl_sel
        If flag_credit_sw_en = &H0 Then write_credit_sw_en_value = get_credit_sw_en
        If flag_replication_cnt = &H0 Then write_replication_cnt_value = get_replication_cnt
        If flag_sgmii_spd_switch = &H0 Then write_sgmii_spd_switch_value = get_sgmii_spd_switch
        If flag_pcs_creditenable = &H0 Then write_pcs_creditenable_value = get_pcs_creditenable
        If flag_mac_creditenable = &H0 Then write_mac_creditenable_value = get_mac_creditenable
        If flag_SW_actual_speed_force_en = &H0 Then write_SW_actual_speed_force_en_value = get_SW_actual_speed_force_en
        If flag_SW_actual_speed = &H0 Then write_SW_actual_speed_value = get_SW_actual_speed

        regValue = leftShift((write_force_ieee_SpeedSel_en_value and &H1), 15) + leftShift((write_force_ieee_cl22_SpeedSel_en_value and &H1), 14) + leftShift((write_use_ieee_reg_ctrl_sel_value and &H3), 12) + leftShift((write_credit_sw_en_value and &H1), 11) + leftShift((write_replication_cnt_value and &H1), 10) + leftShift((write_sgmii_spd_switch_value and &H1), 9) + leftShift((write_pcs_creditenable_value and &H1), 8) + leftShift((write_mac_creditenable_value and &H1), 7) + leftShift((write_SW_actual_speed_force_en_value and &H1), 6) + leftShift((write_SW_actual_speed_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_force_ieee_SpeedSel_en_value = rightShift(data_low, 15) and &H1
        read_force_ieee_cl22_SpeedSel_en_value = rightShift(data_low, 14) and &H1
        read_use_ieee_reg_ctrl_sel_value = rightShift(data_low, 12) and &H3
        read_credit_sw_en_value = rightShift(data_low, 11) and &H1
        read_replication_cnt_value = rightShift(data_low, 10) and &H1
        read_sgmii_spd_switch_value = rightShift(data_low, 9) and &H1
        read_pcs_creditenable_value = rightShift(data_low, 8) and &H1
        read_mac_creditenable_value = rightShift(data_low, 7) and &H1
        read_SW_actual_speed_force_en_value = rightShift(data_low, 6) and &H1
        SW_actual_speed_mask = &H3f
        if data_low > LONG_MAX then
            if SW_actual_speed_mask = mask then
                read_SW_actual_speed_value = data_low
            else
                read_SW_actual_speed_value = (data_low - H8000_0000) and SW_actual_speed_mask
            end If
        else
            read_SW_actual_speed_value = data_low and SW_actual_speed_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_force_ieee_SpeedSel_en_value = &H0
        flag_force_ieee_SpeedSel_en        = &H0
        write_force_ieee_cl22_SpeedSel_en_value = &H0
        flag_force_ieee_cl22_SpeedSel_en        = &H0
        write_use_ieee_reg_ctrl_sel_value = &H0
        flag_use_ieee_reg_ctrl_sel        = &H0
        write_credit_sw_en_value = &H0
        flag_credit_sw_en        = &H0
        write_replication_cnt_value = &H0
        flag_replication_cnt        = &H0
        write_sgmii_spd_switch_value = &H0
        flag_sgmii_spd_switch        = &H0
        write_pcs_creditenable_value = &H0
        flag_pcs_creditenable        = &H0
        write_mac_creditenable_value = &H0
        flag_mac_creditenable        = &H0
        write_SW_actual_speed_force_en_value = &H0
        flag_SW_actual_speed_force_en        = &H0
        write_SW_actual_speed_value = &H0
        flag_SW_actual_speed        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_blockaddress
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

Class DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_INSTANCE

    Public control1000x2
    Public status1000x1
    Public spare
    Public miscdigcontrol
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set control1000x2 = (New REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_control1000x2)(aBaseAddr, 16)
        Set status1000x1 = (New REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_status1000x1)(aBaseAddr, 16)
        Set spare = (New REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_spare)(aBaseAddr, 16)
        Set miscdigcontrol = (New REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_miscdigcontrol)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1.Add ((New DIGITAL_SGMIIPLUSR_X1_SGMIIPLUSR_X1_INSTANCE)(&H4aed8600))


