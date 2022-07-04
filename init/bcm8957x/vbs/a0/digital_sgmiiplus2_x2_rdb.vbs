

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


'' @REGISTER : DIGITAL_SGMIIPLUS2_X2_control1000x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' remote_loopback                            [10:10]          get_remote_loopback
''                                                             set_remote_loopback
''                                                             read_remote_loopback
''                                                             write_remote_loopback
''---------------------------------------------------------------------------------
'' comma_det_en                               [8:8]            get_comma_det_en
''                                                             set_comma_det_en
''                                                             read_comma_det_en
''                                                             write_comma_det_en
''---------------------------------------------------------------------------------
'' disable_pll_pwrdwn                         [6:6]            get_disable_pll_pwrdwn
''                                                             set_disable_pll_pwrdwn
''                                                             read_disable_pll_pwrdwn
''                                                             write_disable_pll_pwrdwn
''---------------------------------------------------------------------------------
'' sgmii_master_mode                          [5:5]            get_sgmii_master_mode
''                                                             set_sgmii_master_mode
''                                                             read_sgmii_master_mode
''                                                             write_sgmii_master_mode
''---------------------------------------------------------------------------------
'' fiber_mode_1000X                           [0:0]            get_fiber_mode_1000X
''                                                             set_fiber_mode_1000X
''                                                             read_fiber_mode_1000X
''                                                             write_fiber_mode_1000X
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUS2_X2_control1000x1
    Private write_remote_loopback_value
    Private read_remote_loopback_value
    Private flag_remote_loopback
    Private write_comma_det_en_value
    Private read_comma_det_en_value
    Private flag_comma_det_en
    Private write_disable_pll_pwrdwn_value
    Private read_disable_pll_pwrdwn_value
    Private flag_disable_pll_pwrdwn
    Private write_sgmii_master_mode_value
    Private read_sgmii_master_mode_value
    Private flag_sgmii_master_mode
    Private write_fiber_mode_1000X_value
    Private read_fiber_mode_1000X_value
    Private flag_fiber_mode_1000X

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

    Property Get get_remote_loopback
        get_remote_loopback = read_remote_loopback_value
    End Property

    Property Let set_remote_loopback(aData)
        write_remote_loopback_value = aData
        flag_remote_loopback        = &H1
    End Property

    Property Get read_remote_loopback
        read
        read_remote_loopback = read_remote_loopback_value
    End Property

    Property Let write_remote_loopback(aData)
        set_remote_loopback = aData
        write
    End Property

    Property Get get_comma_det_en
        get_comma_det_en = read_comma_det_en_value
    End Property

    Property Let set_comma_det_en(aData)
        write_comma_det_en_value = aData
        flag_comma_det_en        = &H1
    End Property

    Property Get read_comma_det_en
        read
        read_comma_det_en = read_comma_det_en_value
    End Property

    Property Let write_comma_det_en(aData)
        set_comma_det_en = aData
        write
    End Property

    Property Get get_disable_pll_pwrdwn
        get_disable_pll_pwrdwn = read_disable_pll_pwrdwn_value
    End Property

    Property Let set_disable_pll_pwrdwn(aData)
        write_disable_pll_pwrdwn_value = aData
        flag_disable_pll_pwrdwn        = &H1
    End Property

    Property Get read_disable_pll_pwrdwn
        read
        read_disable_pll_pwrdwn = read_disable_pll_pwrdwn_value
    End Property

    Property Let write_disable_pll_pwrdwn(aData)
        set_disable_pll_pwrdwn = aData
        write
    End Property

    Property Get get_sgmii_master_mode
        get_sgmii_master_mode = read_sgmii_master_mode_value
    End Property

    Property Let set_sgmii_master_mode(aData)
        write_sgmii_master_mode_value = aData
        flag_sgmii_master_mode        = &H1
    End Property

    Property Get read_sgmii_master_mode
        read
        read_sgmii_master_mode = read_sgmii_master_mode_value
    End Property

    Property Let write_sgmii_master_mode(aData)
        set_sgmii_master_mode = aData
        write
    End Property

    Property Get get_fiber_mode_1000X
        get_fiber_mode_1000X = read_fiber_mode_1000X_value
    End Property

    Property Let set_fiber_mode_1000X(aData)
        write_fiber_mode_1000X_value = aData
        flag_fiber_mode_1000X        = &H1
    End Property

    Property Get read_fiber_mode_1000X
        read
        read_fiber_mode_1000X = read_fiber_mode_1000X_value
    End Property

    Property Let write_fiber_mode_1000X(aData)
        set_fiber_mode_1000X = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_remote_loopback_value = rightShift(data_low, 10) and &H1
        read_comma_det_en_value = rightShift(data_low, 8) and &H1
        read_disable_pll_pwrdwn_value = rightShift(data_low, 6) and &H1
        read_sgmii_master_mode_value = rightShift(data_low, 5) and &H1
        fiber_mode_1000X_mask = &H1
        if data_low > LONG_MAX then
            if fiber_mode_1000X_mask = mask then
                read_fiber_mode_1000X_value = data_low
            else
                read_fiber_mode_1000X_value = (data_low - H8000_0000) and fiber_mode_1000X_mask
            end If
        else
            read_fiber_mode_1000X_value = data_low and fiber_mode_1000X_mask
        end If

    End Sub

    Sub write
        If flag_remote_loopback = &H0 or flag_comma_det_en = &H0 or flag_disable_pll_pwrdwn = &H0 or flag_sgmii_master_mode = &H0 or flag_fiber_mode_1000X = &H0 Then read
        If flag_remote_loopback = &H0 Then write_remote_loopback_value = get_remote_loopback
        If flag_comma_det_en = &H0 Then write_comma_det_en_value = get_comma_det_en
        If flag_disable_pll_pwrdwn = &H0 Then write_disable_pll_pwrdwn_value = get_disable_pll_pwrdwn
        If flag_sgmii_master_mode = &H0 Then write_sgmii_master_mode_value = get_sgmii_master_mode
        If flag_fiber_mode_1000X = &H0 Then write_fiber_mode_1000X_value = get_fiber_mode_1000X

        regValue = leftShift((write_remote_loopback_value and &H1), 10) + leftShift((write_comma_det_en_value and &H1), 8) + leftShift((write_disable_pll_pwrdwn_value and &H1), 6) + leftShift((write_sgmii_master_mode_value and &H1), 5) + leftShift((write_fiber_mode_1000X_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_remote_loopback_value = rightShift(data_low, 10) and &H1
        read_comma_det_en_value = rightShift(data_low, 8) and &H1
        read_disable_pll_pwrdwn_value = rightShift(data_low, 6) and &H1
        read_sgmii_master_mode_value = rightShift(data_low, 5) and &H1
        fiber_mode_1000X_mask = &H1
        if data_low > LONG_MAX then
            if fiber_mode_1000X_mask = mask then
                read_fiber_mode_1000X_value = data_low
            else
                read_fiber_mode_1000X_value = (data_low - H8000_0000) and fiber_mode_1000X_mask
            end If
        else
            read_fiber_mode_1000X_value = data_low and fiber_mode_1000X_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_remote_loopback_value = &H0
        flag_remote_loopback        = &H0
        write_comma_det_en_value = &H0
        flag_comma_det_en        = &H0
        write_disable_pll_pwrdwn_value = &H0
        flag_disable_pll_pwrdwn        = &H0
        write_sgmii_master_mode_value = &H0
        flag_sgmii_master_mode        = &H0
        write_fiber_mode_1000X_value = &H0
        flag_fiber_mode_1000X        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUS2_X2_control1000x2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' autoneg_fast_timers                        [6:6]            get_autoneg_fast_timers
''                                                             set_autoneg_fast_timers
''                                                             read_autoneg_fast_timers
''                                                             write_autoneg_fast_timers
''---------------------------------------------------------------------------------
'' filter_force_link                          [2:2]            get_filter_force_link
''                                                             set_filter_force_link
''                                                             read_filter_force_link
''                                                             write_filter_force_link
''---------------------------------------------------------------------------------
'' disable_false_link                         [1:1]            get_disable_false_link
''                                                             set_disable_false_link
''                                                             read_disable_false_link
''                                                             write_disable_false_link
''---------------------------------------------------------------------------------
'' enable_parallel_detection                  [0:0]            get_enable_parallel_detection
''                                                             set_enable_parallel_detection
''                                                             read_enable_parallel_detection
''                                                             write_enable_parallel_detection
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUS2_X2_control1000x2
    Private write_autoneg_fast_timers_value
    Private read_autoneg_fast_timers_value
    Private flag_autoneg_fast_timers
    Private write_filter_force_link_value
    Private read_filter_force_link_value
    Private flag_filter_force_link
    Private write_disable_false_link_value
    Private read_disable_false_link_value
    Private flag_disable_false_link
    Private write_enable_parallel_detection_value
    Private read_enable_parallel_detection_value
    Private flag_enable_parallel_detection

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

    Property Get get_autoneg_fast_timers
        get_autoneg_fast_timers = read_autoneg_fast_timers_value
    End Property

    Property Let set_autoneg_fast_timers(aData)
        write_autoneg_fast_timers_value = aData
        flag_autoneg_fast_timers        = &H1
    End Property

    Property Get read_autoneg_fast_timers
        read
        read_autoneg_fast_timers = read_autoneg_fast_timers_value
    End Property

    Property Let write_autoneg_fast_timers(aData)
        set_autoneg_fast_timers = aData
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

    Property Get get_disable_false_link
        get_disable_false_link = read_disable_false_link_value
    End Property

    Property Let set_disable_false_link(aData)
        write_disable_false_link_value = aData
        flag_disable_false_link        = &H1
    End Property

    Property Get read_disable_false_link
        read
        read_disable_false_link = read_disable_false_link_value
    End Property

    Property Let write_disable_false_link(aData)
        set_disable_false_link = aData
        write
    End Property

    Property Get get_enable_parallel_detection
        get_enable_parallel_detection = read_enable_parallel_detection_value
    End Property

    Property Let set_enable_parallel_detection(aData)
        write_enable_parallel_detection_value = aData
        flag_enable_parallel_detection        = &H1
    End Property

    Property Get read_enable_parallel_detection
        read
        read_enable_parallel_detection = read_enable_parallel_detection_value
    End Property

    Property Let write_enable_parallel_detection(aData)
        set_enable_parallel_detection = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_autoneg_fast_timers_value = rightShift(data_low, 6) and &H1
        read_filter_force_link_value = rightShift(data_low, 2) and &H1
        read_disable_false_link_value = rightShift(data_low, 1) and &H1
        enable_parallel_detection_mask = &H1
        if data_low > LONG_MAX then
            if enable_parallel_detection_mask = mask then
                read_enable_parallel_detection_value = data_low
            else
                read_enable_parallel_detection_value = (data_low - H8000_0000) and enable_parallel_detection_mask
            end If
        else
            read_enable_parallel_detection_value = data_low and enable_parallel_detection_mask
        end If

    End Sub

    Sub write
        If flag_autoneg_fast_timers = &H0 or flag_filter_force_link = &H0 or flag_disable_false_link = &H0 or flag_enable_parallel_detection = &H0 Then read
        If flag_autoneg_fast_timers = &H0 Then write_autoneg_fast_timers_value = get_autoneg_fast_timers
        If flag_filter_force_link = &H0 Then write_filter_force_link_value = get_filter_force_link
        If flag_disable_false_link = &H0 Then write_disable_false_link_value = get_disable_false_link
        If flag_enable_parallel_detection = &H0 Then write_enable_parallel_detection_value = get_enable_parallel_detection

        regValue = leftShift((write_autoneg_fast_timers_value and &H1), 6) + leftShift((write_filter_force_link_value and &H1), 2) + leftShift((write_disable_false_link_value and &H1), 1) + leftShift((write_enable_parallel_detection_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_autoneg_fast_timers_value = rightShift(data_low, 6) and &H1
        read_filter_force_link_value = rightShift(data_low, 2) and &H1
        read_disable_false_link_value = rightShift(data_low, 1) and &H1
        enable_parallel_detection_mask = &H1
        if data_low > LONG_MAX then
            if enable_parallel_detection_mask = mask then
                read_enable_parallel_detection_value = data_low
            else
                read_enable_parallel_detection_value = (data_low - H8000_0000) and enable_parallel_detection_mask
            end If
        else
            read_enable_parallel_detection_value = data_low and enable_parallel_detection_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_autoneg_fast_timers_value = &H0
        flag_autoneg_fast_timers        = &H0
        write_filter_force_link_value = &H0
        flag_filter_force_link        = &H0
        write_disable_false_link_value = &H0
        flag_disable_false_link        = &H0
        write_enable_parallel_detection_value = &H0
        flag_enable_parallel_detection        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUS2_X2_status1000x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' link_status_change                         [7:7]            get_link_status_change
''                                                             set_link_status_change
''                                                             read_link_status_change
''                                                             write_link_status_change
''---------------------------------------------------------------------------------
'' pause_resolution_rxside                    [6:6]            get_pause_resolution_rxside
''                                                             set_pause_resolution_rxside
''                                                             read_pause_resolution_rxside
''                                                             write_pause_resolution_rxside
''---------------------------------------------------------------------------------
'' pause_resolution_txside                    [5:5]            get_pause_resolution_txside
''                                                             set_pause_resolution_txside
''                                                             read_pause_resolution_txside
''                                                             write_pause_resolution_txside
''---------------------------------------------------------------------------------
'' speed_status                               [4:3]            get_speed_status
''                                                             set_speed_status
''                                                             read_speed_status
''                                                             write_speed_status
''---------------------------------------------------------------------------------
'' duplex_status                              [2:2]            get_duplex_status
''                                                             set_duplex_status
''                                                             read_duplex_status
''                                                             write_duplex_status
''---------------------------------------------------------------------------------
'' link_status                                [1:1]            get_link_status
''                                                             set_link_status
''                                                             read_link_status
''                                                             write_link_status
''---------------------------------------------------------------------------------
'' sgmii_mode                                 [0:0]            get_sgmii_mode
''                                                             set_sgmii_mode
''                                                             read_sgmii_mode
''                                                             write_sgmii_mode
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUS2_X2_status1000x1
    Private write_link_status_change_value
    Private read_link_status_change_value
    Private flag_link_status_change
    Private write_pause_resolution_rxside_value
    Private read_pause_resolution_rxside_value
    Private flag_pause_resolution_rxside
    Private write_pause_resolution_txside_value
    Private read_pause_resolution_txside_value
    Private flag_pause_resolution_txside
    Private write_speed_status_value
    Private read_speed_status_value
    Private flag_speed_status
    Private write_duplex_status_value
    Private read_duplex_status_value
    Private flag_duplex_status
    Private write_link_status_value
    Private read_link_status_value
    Private flag_link_status
    Private write_sgmii_mode_value
    Private read_sgmii_mode_value
    Private flag_sgmii_mode

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

    Property Get get_pause_resolution_rxside
        get_pause_resolution_rxside = read_pause_resolution_rxside_value
    End Property

    Property Let set_pause_resolution_rxside(aData)
        write_pause_resolution_rxside_value = aData
        flag_pause_resolution_rxside        = &H1
    End Property

    Property Get read_pause_resolution_rxside
        read
        read_pause_resolution_rxside = read_pause_resolution_rxside_value
    End Property

    Property Let write_pause_resolution_rxside(aData)
        set_pause_resolution_rxside = aData
        write
    End Property

    Property Get get_pause_resolution_txside
        get_pause_resolution_txside = read_pause_resolution_txside_value
    End Property

    Property Let set_pause_resolution_txside(aData)
        write_pause_resolution_txside_value = aData
        flag_pause_resolution_txside        = &H1
    End Property

    Property Get read_pause_resolution_txside
        read
        read_pause_resolution_txside = read_pause_resolution_txside_value
    End Property

    Property Let write_pause_resolution_txside(aData)
        set_pause_resolution_txside = aData
        write
    End Property

    Property Get get_speed_status
        get_speed_status = read_speed_status_value
    End Property

    Property Let set_speed_status(aData)
        write_speed_status_value = aData
        flag_speed_status        = &H1
    End Property

    Property Get read_speed_status
        read
        read_speed_status = read_speed_status_value
    End Property

    Property Let write_speed_status(aData)
        set_speed_status = aData
        write
    End Property

    Property Get get_duplex_status
        get_duplex_status = read_duplex_status_value
    End Property

    Property Let set_duplex_status(aData)
        write_duplex_status_value = aData
        flag_duplex_status        = &H1
    End Property

    Property Get read_duplex_status
        read
        read_duplex_status = read_duplex_status_value
    End Property

    Property Let write_duplex_status(aData)
        set_duplex_status = aData
        write
    End Property

    Property Get get_link_status
        get_link_status = read_link_status_value
    End Property

    Property Let set_link_status(aData)
        write_link_status_value = aData
        flag_link_status        = &H1
    End Property

    Property Get read_link_status
        read
        read_link_status = read_link_status_value
    End Property

    Property Let write_link_status(aData)
        set_link_status = aData
        write
    End Property

    Property Get get_sgmii_mode
        get_sgmii_mode = read_sgmii_mode_value
    End Property

    Property Let set_sgmii_mode(aData)
        write_sgmii_mode_value = aData
        flag_sgmii_mode        = &H1
    End Property

    Property Get read_sgmii_mode
        read
        read_sgmii_mode = read_sgmii_mode_value
    End Property

    Property Let write_sgmii_mode(aData)
        set_sgmii_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_link_status_change_value = rightShift(data_low, 7) and &H1
        read_pause_resolution_rxside_value = rightShift(data_low, 6) and &H1
        read_pause_resolution_txside_value = rightShift(data_low, 5) and &H1
        read_speed_status_value = rightShift(data_low, 3) and &H3
        read_duplex_status_value = rightShift(data_low, 2) and &H1
        read_link_status_value = rightShift(data_low, 1) and &H1
        sgmii_mode_mask = &H1
        if data_low > LONG_MAX then
            if sgmii_mode_mask = mask then
                read_sgmii_mode_value = data_low
            else
                read_sgmii_mode_value = (data_low - H8000_0000) and sgmii_mode_mask
            end If
        else
            read_sgmii_mode_value = data_low and sgmii_mode_mask
        end If

    End Sub

    Sub write
        If flag_link_status_change = &H0 or flag_pause_resolution_rxside = &H0 or flag_pause_resolution_txside = &H0 or flag_speed_status = &H0 or flag_duplex_status = &H0 or flag_link_status = &H0 or flag_sgmii_mode = &H0 Then read
        If flag_link_status_change = &H0 Then write_link_status_change_value = get_link_status_change
        If flag_pause_resolution_rxside = &H0 Then write_pause_resolution_rxside_value = get_pause_resolution_rxside
        If flag_pause_resolution_txside = &H0 Then write_pause_resolution_txside_value = get_pause_resolution_txside
        If flag_speed_status = &H0 Then write_speed_status_value = get_speed_status
        If flag_duplex_status = &H0 Then write_duplex_status_value = get_duplex_status
        If flag_link_status = &H0 Then write_link_status_value = get_link_status
        If flag_sgmii_mode = &H0 Then write_sgmii_mode_value = get_sgmii_mode

        regValue = leftShift((write_link_status_change_value and &H1), 7) + leftShift((write_pause_resolution_rxside_value and &H1), 6) + leftShift((write_pause_resolution_txside_value and &H1), 5) + leftShift((write_speed_status_value and &H3), 3) + leftShift((write_duplex_status_value and &H1), 2) + leftShift((write_link_status_value and &H1), 1) + leftShift((write_sgmii_mode_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_link_status_change_value = rightShift(data_low, 7) and &H1
        read_pause_resolution_rxside_value = rightShift(data_low, 6) and &H1
        read_pause_resolution_txside_value = rightShift(data_low, 5) and &H1
        read_speed_status_value = rightShift(data_low, 3) and &H3
        read_duplex_status_value = rightShift(data_low, 2) and &H1
        read_link_status_value = rightShift(data_low, 1) and &H1
        sgmii_mode_mask = &H1
        if data_low > LONG_MAX then
            if sgmii_mode_mask = mask then
                read_sgmii_mode_value = data_low
            else
                read_sgmii_mode_value = (data_low - H8000_0000) and sgmii_mode_mask
            end If
        else
            read_sgmii_mode_value = data_low and sgmii_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_link_status_change_value = &H0
        flag_link_status_change        = &H0
        write_pause_resolution_rxside_value = &H0
        flag_pause_resolution_rxside        = &H0
        write_pause_resolution_txside_value = &H0
        flag_pause_resolution_txside        = &H0
        write_speed_status_value = &H0
        flag_speed_status        = &H0
        write_duplex_status_value = &H0
        flag_duplex_status        = &H0
        write_link_status_value = &H0
        flag_link_status        = &H0
        write_sgmii_mode_value = &H0
        flag_sgmii_mode        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUS2_X2_misc1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' refclk_sel                                 [15:13]          get_refclk_sel
''                                                             set_refclk_sel
''                                                             read_refclk_sel
''                                                             write_refclk_sel
''---------------------------------------------------------------------------------
'' force_speed                                [4:0]            get_force_speed
''                                                             set_force_speed
''                                                             read_force_speed
''                                                             write_force_speed
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUS2_X2_misc1
    Private write_refclk_sel_value
    Private read_refclk_sel_value
    Private flag_refclk_sel
    Private write_force_speed_value
    Private read_force_speed_value
    Private flag_force_speed

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

    Property Get get_refclk_sel
        get_refclk_sel = read_refclk_sel_value
    End Property

    Property Let set_refclk_sel(aData)
        write_refclk_sel_value = aData
        flag_refclk_sel        = &H1
    End Property

    Property Get read_refclk_sel
        read
        read_refclk_sel = read_refclk_sel_value
    End Property

    Property Let write_refclk_sel(aData)
        set_refclk_sel = aData
        write
    End Property

    Property Get get_force_speed
        get_force_speed = read_force_speed_value
    End Property

    Property Let set_force_speed(aData)
        write_force_speed_value = aData
        flag_force_speed        = &H1
    End Property

    Property Get read_force_speed
        read
        read_force_speed = read_force_speed_value
    End Property

    Property Let write_force_speed(aData)
        set_force_speed = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_refclk_sel_value = rightShift(data_low, 13) and &H7
        force_speed_mask = &H1f
        if data_low > LONG_MAX then
            if force_speed_mask = mask then
                read_force_speed_value = data_low
            else
                read_force_speed_value = (data_low - H8000_0000) and force_speed_mask
            end If
        else
            read_force_speed_value = data_low and force_speed_mask
        end If

    End Sub

    Sub write
        If flag_refclk_sel = &H0 or flag_force_speed = &H0 Then read
        If flag_refclk_sel = &H0 Then write_refclk_sel_value = get_refclk_sel
        If flag_force_speed = &H0 Then write_force_speed_value = get_force_speed

        regValue = leftShift((write_refclk_sel_value and &H7), 13) + leftShift((write_force_speed_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_refclk_sel_value = rightShift(data_low, 13) and &H7
        force_speed_mask = &H1f
        if data_low > LONG_MAX then
            if force_speed_mask = mask then
                read_force_speed_value = data_low
            else
                read_force_speed_value = (data_low - H8000_0000) and force_speed_mask
            end If
        else
            read_force_speed_value = data_low and force_speed_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_refclk_sel_value = &H0
        flag_refclk_sel        = &H0
        write_force_speed_value = &H0
        flag_force_speed        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUS2_X2_misc2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxck_mii_gen_sel_val                       [13:13]          get_rxck_mii_gen_sel_val
''                                                             set_rxck_mii_gen_sel_val
''                                                             read_rxck_mii_gen_sel_val
''                                                             write_rxck_mii_gen_sel_val
''---------------------------------------------------------------------------------
'' clkSigdet_bypass                           [10:10]          get_clkSigdet_bypass
''                                                             set_clkSigdet_bypass
''                                                             read_clkSigdet_bypass
''                                                             write_clkSigdet_bypass
''---------------------------------------------------------------------------------
'' clk41_bypass                               [9:9]            get_clk41_bypass
''                                                             set_clk41_bypass
''                                                             read_clk41_bypass
''                                                             write_clk41_bypass
''---------------------------------------------------------------------------------
'' miiGmiiDly_en                              [8:8]            get_miiGmiiDly_en
''                                                             set_miiGmiiDly_en
''                                                             read_miiGmiiDly_en
''                                                             write_miiGmiiDly_en
''---------------------------------------------------------------------------------
'' miiGmiiMux_en                              [7:7]            get_miiGmiiMux_en
''                                                             set_miiGmiiMux_en
''                                                             read_miiGmiiMux_en
''                                                             write_miiGmiiMux_en
''---------------------------------------------------------------------------------
'' fifo_err_cya                               [4:4]            get_fifo_err_cya
''                                                             set_fifo_err_cya
''                                                             read_fifo_err_cya
''                                                             write_fifo_err_cya
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL_SGMIIPLUS2_X2_misc2
    Private write_rxck_mii_gen_sel_val_value
    Private read_rxck_mii_gen_sel_val_value
    Private flag_rxck_mii_gen_sel_val
    Private write_clkSigdet_bypass_value
    Private read_clkSigdet_bypass_value
    Private flag_clkSigdet_bypass
    Private write_clk41_bypass_value
    Private read_clk41_bypass_value
    Private flag_clk41_bypass
    Private write_miiGmiiDly_en_value
    Private read_miiGmiiDly_en_value
    Private flag_miiGmiiDly_en
    Private write_miiGmiiMux_en_value
    Private read_miiGmiiMux_en_value
    Private flag_miiGmiiMux_en
    Private write_fifo_err_cya_value
    Private read_fifo_err_cya_value
    Private flag_fifo_err_cya

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

    Property Get get_rxck_mii_gen_sel_val
        get_rxck_mii_gen_sel_val = read_rxck_mii_gen_sel_val_value
    End Property

    Property Let set_rxck_mii_gen_sel_val(aData)
        write_rxck_mii_gen_sel_val_value = aData
        flag_rxck_mii_gen_sel_val        = &H1
    End Property

    Property Get read_rxck_mii_gen_sel_val
        read
        read_rxck_mii_gen_sel_val = read_rxck_mii_gen_sel_val_value
    End Property

    Property Let write_rxck_mii_gen_sel_val(aData)
        set_rxck_mii_gen_sel_val = aData
        write
    End Property

    Property Get get_clkSigdet_bypass
        get_clkSigdet_bypass = read_clkSigdet_bypass_value
    End Property

    Property Let set_clkSigdet_bypass(aData)
        write_clkSigdet_bypass_value = aData
        flag_clkSigdet_bypass        = &H1
    End Property

    Property Get read_clkSigdet_bypass
        read
        read_clkSigdet_bypass = read_clkSigdet_bypass_value
    End Property

    Property Let write_clkSigdet_bypass(aData)
        set_clkSigdet_bypass = aData
        write
    End Property

    Property Get get_clk41_bypass
        get_clk41_bypass = read_clk41_bypass_value
    End Property

    Property Let set_clk41_bypass(aData)
        write_clk41_bypass_value = aData
        flag_clk41_bypass        = &H1
    End Property

    Property Get read_clk41_bypass
        read
        read_clk41_bypass = read_clk41_bypass_value
    End Property

    Property Let write_clk41_bypass(aData)
        set_clk41_bypass = aData
        write
    End Property

    Property Get get_miiGmiiDly_en
        get_miiGmiiDly_en = read_miiGmiiDly_en_value
    End Property

    Property Let set_miiGmiiDly_en(aData)
        write_miiGmiiDly_en_value = aData
        flag_miiGmiiDly_en        = &H1
    End Property

    Property Get read_miiGmiiDly_en
        read
        read_miiGmiiDly_en = read_miiGmiiDly_en_value
    End Property

    Property Let write_miiGmiiDly_en(aData)
        set_miiGmiiDly_en = aData
        write
    End Property

    Property Get get_miiGmiiMux_en
        get_miiGmiiMux_en = read_miiGmiiMux_en_value
    End Property

    Property Let set_miiGmiiMux_en(aData)
        write_miiGmiiMux_en_value = aData
        flag_miiGmiiMux_en        = &H1
    End Property

    Property Get read_miiGmiiMux_en
        read
        read_miiGmiiMux_en = read_miiGmiiMux_en_value
    End Property

    Property Let write_miiGmiiMux_en(aData)
        set_miiGmiiMux_en = aData
        write
    End Property

    Property Get get_fifo_err_cya
        get_fifo_err_cya = read_fifo_err_cya_value
    End Property

    Property Let set_fifo_err_cya(aData)
        write_fifo_err_cya_value = aData
        flag_fifo_err_cya        = &H1
    End Property

    Property Get read_fifo_err_cya
        read
        read_fifo_err_cya = read_fifo_err_cya_value
    End Property

    Property Let write_fifo_err_cya(aData)
        set_fifo_err_cya = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxck_mii_gen_sel_val_value = rightShift(data_low, 13) and &H1
        read_clkSigdet_bypass_value = rightShift(data_low, 10) and &H1
        read_clk41_bypass_value = rightShift(data_low, 9) and &H1
        read_miiGmiiDly_en_value = rightShift(data_low, 8) and &H1
        read_miiGmiiMux_en_value = rightShift(data_low, 7) and &H1
        read_fifo_err_cya_value = rightShift(data_low, 4) and &H1

    End Sub

    Sub write
        If flag_rxck_mii_gen_sel_val = &H0 or flag_clkSigdet_bypass = &H0 or flag_clk41_bypass = &H0 or flag_miiGmiiDly_en = &H0 or flag_miiGmiiMux_en = &H0 or flag_fifo_err_cya = &H0 Then read
        If flag_rxck_mii_gen_sel_val = &H0 Then write_rxck_mii_gen_sel_val_value = get_rxck_mii_gen_sel_val
        If flag_clkSigdet_bypass = &H0 Then write_clkSigdet_bypass_value = get_clkSigdet_bypass
        If flag_clk41_bypass = &H0 Then write_clk41_bypass_value = get_clk41_bypass
        If flag_miiGmiiDly_en = &H0 Then write_miiGmiiDly_en_value = get_miiGmiiDly_en
        If flag_miiGmiiMux_en = &H0 Then write_miiGmiiMux_en_value = get_miiGmiiMux_en
        If flag_fifo_err_cya = &H0 Then write_fifo_err_cya_value = get_fifo_err_cya

        regValue = leftShift((write_rxck_mii_gen_sel_val_value and &H1), 13) + leftShift((write_clkSigdet_bypass_value and &H1), 10) + leftShift((write_clk41_bypass_value and &H1), 9) + leftShift((write_miiGmiiDly_en_value and &H1), 8) + leftShift((write_miiGmiiMux_en_value and &H1), 7) + leftShift((write_fifo_err_cya_value and &H1), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxck_mii_gen_sel_val_value = rightShift(data_low, 13) and &H1
        read_clkSigdet_bypass_value = rightShift(data_low, 10) and &H1
        read_clk41_bypass_value = rightShift(data_low, 9) and &H1
        read_miiGmiiDly_en_value = rightShift(data_low, 8) and &H1
        read_miiGmiiMux_en_value = rightShift(data_low, 7) and &H1
        read_fifo_err_cya_value = rightShift(data_low, 4) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxck_mii_gen_sel_val_value = &H0
        flag_rxck_mii_gen_sel_val        = &H0
        write_clkSigdet_bypass_value = &H0
        flag_clkSigdet_bypass        = &H0
        write_clk41_bypass_value = &H0
        flag_clk41_bypass        = &H0
        write_miiGmiiDly_en_value = &H0
        flag_miiGmiiDly_en        = &H0
        write_miiGmiiMux_en_value = &H0
        flag_miiGmiiMux_en        = &H0
        write_fifo_err_cya_value = &H0
        flag_fifo_err_cya        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL_SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_DIGITAL_SGMIIPLUS2_X2_blockaddress
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

Class DIGITAL_SGMIIPLUS2_X2_INSTANCE

    Public control1000x1
    Public control1000x2
    Public status1000x1
    Public misc1
    Public misc2
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set control1000x1 = (New REGISTER_DIGITAL_SGMIIPLUS2_X2_control1000x1)(aBaseAddr, 16)
        Set control1000x2 = (New REGISTER_DIGITAL_SGMIIPLUS2_X2_control1000x2)(aBaseAddr, 16)
        Set status1000x1 = (New REGISTER_DIGITAL_SGMIIPLUS2_X2_status1000x1)(aBaseAddr, 16)
        Set misc1 = (New REGISTER_DIGITAL_SGMIIPLUS2_X2_misc1)(aBaseAddr, 16)
        Set misc2 = (New REGISTER_DIGITAL_SGMIIPLUS2_X2_misc2)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_DIGITAL_SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DIGITAL_SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
DIGITAL_SGMIIPLUS2_X2.Add ((New DIGITAL_SGMIIPLUS2_X2_INSTANCE)(&H4acd0600))
DIGITAL_SGMIIPLUS2_X2.Add ((New DIGITAL_SGMIIPLUS2_X2_INSTANCE)(&H4acf0600))


