

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


'' @REGISTER : IEEE_CL22_SGMIIPCIE_X1_miicntl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rst_hw                                     [15:15]          get_rst_hw
''                                                             set_rst_hw
''                                                             read_rst_hw
''                                                             write_rst_hw
''---------------------------------------------------------------------------------
'' gloopback                                  [14:14]          get_gloopback
''                                                             set_gloopback
''                                                             read_gloopback
''                                                             write_gloopback
''---------------------------------------------------------------------------------
'' manual_speed0                              [13:13]          get_manual_speed0
''                                                             set_manual_speed0
''                                                             read_manual_speed0
''                                                             write_manual_speed0
''---------------------------------------------------------------------------------
'' autoneg_enable                             [12:12]          get_autoneg_enable
''                                                             set_autoneg_enable
''                                                             read_autoneg_enable
''                                                             write_autoneg_enable
''---------------------------------------------------------------------------------
'' pwrdwn_sw                                  [11:11]          get_pwrdwn_sw
''                                                             set_pwrdwn_sw
''                                                             read_pwrdwn_sw
''                                                             write_pwrdwn_sw
''---------------------------------------------------------------------------------
'' restart_autoneg                            [9:9]            get_restart_autoneg
''                                                             set_restart_autoneg
''                                                             read_restart_autoneg
''                                                             write_restart_autoneg
''---------------------------------------------------------------------------------
'' duplex                                     [8:8]            get_duplex
''                                                             set_duplex
''                                                             read_duplex
''                                                             write_duplex
''---------------------------------------------------------------------------------
'' collision_test_en                          [7:7]            get_collision_test_en
''                                                             set_collision_test_en
''                                                             read_collision_test_en
''                                                             write_collision_test_en
''---------------------------------------------------------------------------------
'' manual_speed1                              [6:6]            get_manual_speed1
''                                                             set_manual_speed1
''                                                             read_manual_speed1
''                                                             write_manual_speed1
''---------------------------------------------------------------------------------
Class REGISTER_IEEE_CL22_SGMIIPCIE_X1_miicntl
    Private write_rst_hw_value
    Private read_rst_hw_value
    Private flag_rst_hw
    Private write_gloopback_value
    Private read_gloopback_value
    Private flag_gloopback
    Private write_manual_speed0_value
    Private read_manual_speed0_value
    Private flag_manual_speed0
    Private write_autoneg_enable_value
    Private read_autoneg_enable_value
    Private flag_autoneg_enable
    Private write_pwrdwn_sw_value
    Private read_pwrdwn_sw_value
    Private flag_pwrdwn_sw
    Private write_restart_autoneg_value
    Private read_restart_autoneg_value
    Private flag_restart_autoneg
    Private write_duplex_value
    Private read_duplex_value
    Private flag_duplex
    Private write_collision_test_en_value
    Private read_collision_test_en_value
    Private flag_collision_test_en
    Private write_manual_speed1_value
    Private read_manual_speed1_value
    Private flag_manual_speed1

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

    Property Get get_rst_hw
        get_rst_hw = read_rst_hw_value
    End Property

    Property Let set_rst_hw(aData)
        write_rst_hw_value = aData
        flag_rst_hw        = &H1
    End Property

    Property Get read_rst_hw
        read
        read_rst_hw = read_rst_hw_value
    End Property

    Property Let write_rst_hw(aData)
        set_rst_hw = aData
        write
    End Property

    Property Get get_gloopback
        get_gloopback = read_gloopback_value
    End Property

    Property Let set_gloopback(aData)
        write_gloopback_value = aData
        flag_gloopback        = &H1
    End Property

    Property Get read_gloopback
        read
        read_gloopback = read_gloopback_value
    End Property

    Property Let write_gloopback(aData)
        set_gloopback = aData
        write
    End Property

    Property Get get_manual_speed0
        get_manual_speed0 = read_manual_speed0_value
    End Property

    Property Let set_manual_speed0(aData)
        write_manual_speed0_value = aData
        flag_manual_speed0        = &H1
    End Property

    Property Get read_manual_speed0
        read
        read_manual_speed0 = read_manual_speed0_value
    End Property

    Property Let write_manual_speed0(aData)
        set_manual_speed0 = aData
        write
    End Property

    Property Get get_autoneg_enable
        get_autoneg_enable = read_autoneg_enable_value
    End Property

    Property Let set_autoneg_enable(aData)
        write_autoneg_enable_value = aData
        flag_autoneg_enable        = &H1
    End Property

    Property Get read_autoneg_enable
        read
        read_autoneg_enable = read_autoneg_enable_value
    End Property

    Property Let write_autoneg_enable(aData)
        set_autoneg_enable = aData
        write
    End Property

    Property Get get_pwrdwn_sw
        get_pwrdwn_sw = read_pwrdwn_sw_value
    End Property

    Property Let set_pwrdwn_sw(aData)
        write_pwrdwn_sw_value = aData
        flag_pwrdwn_sw        = &H1
    End Property

    Property Get read_pwrdwn_sw
        read
        read_pwrdwn_sw = read_pwrdwn_sw_value
    End Property

    Property Let write_pwrdwn_sw(aData)
        set_pwrdwn_sw = aData
        write
    End Property

    Property Get get_restart_autoneg
        get_restart_autoneg = read_restart_autoneg_value
    End Property

    Property Let set_restart_autoneg(aData)
        write_restart_autoneg_value = aData
        flag_restart_autoneg        = &H1
    End Property

    Property Get read_restart_autoneg
        read
        read_restart_autoneg = read_restart_autoneg_value
    End Property

    Property Let write_restart_autoneg(aData)
        set_restart_autoneg = aData
        write
    End Property

    Property Get get_duplex
        get_duplex = read_duplex_value
    End Property

    Property Let set_duplex(aData)
        write_duplex_value = aData
        flag_duplex        = &H1
    End Property

    Property Get read_duplex
        read
        read_duplex = read_duplex_value
    End Property

    Property Let write_duplex(aData)
        set_duplex = aData
        write
    End Property

    Property Get get_collision_test_en
        get_collision_test_en = read_collision_test_en_value
    End Property

    Property Let set_collision_test_en(aData)
        write_collision_test_en_value = aData
        flag_collision_test_en        = &H1
    End Property

    Property Get read_collision_test_en
        read
        read_collision_test_en = read_collision_test_en_value
    End Property

    Property Let write_collision_test_en(aData)
        set_collision_test_en = aData
        write
    End Property

    Property Get get_manual_speed1
        get_manual_speed1 = read_manual_speed1_value
    End Property

    Property Let set_manual_speed1(aData)
        write_manual_speed1_value = aData
        flag_manual_speed1        = &H1
    End Property

    Property Get read_manual_speed1
        read
        read_manual_speed1 = read_manual_speed1_value
    End Property

    Property Let write_manual_speed1(aData)
        set_manual_speed1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rst_hw_value = rightShift(data_low, 15) and &H1
        read_gloopback_value = rightShift(data_low, 14) and &H1
        read_manual_speed0_value = rightShift(data_low, 13) and &H1
        read_autoneg_enable_value = rightShift(data_low, 12) and &H1
        read_pwrdwn_sw_value = rightShift(data_low, 11) and &H1
        read_restart_autoneg_value = rightShift(data_low, 9) and &H1
        read_duplex_value = rightShift(data_low, 8) and &H1
        read_collision_test_en_value = rightShift(data_low, 7) and &H1
        read_manual_speed1_value = rightShift(data_low, 6) and &H1

    End Sub

    Sub write
        If flag_rst_hw = &H0 or flag_gloopback = &H0 or flag_manual_speed0 = &H0 or flag_autoneg_enable = &H0 or flag_pwrdwn_sw = &H0 or flag_restart_autoneg = &H0 or flag_duplex = &H0 or flag_collision_test_en = &H0 or flag_manual_speed1 = &H0 Then read
        If flag_rst_hw = &H0 Then write_rst_hw_value = get_rst_hw
        If flag_gloopback = &H0 Then write_gloopback_value = get_gloopback
        If flag_manual_speed0 = &H0 Then write_manual_speed0_value = get_manual_speed0
        If flag_autoneg_enable = &H0 Then write_autoneg_enable_value = get_autoneg_enable
        If flag_pwrdwn_sw = &H0 Then write_pwrdwn_sw_value = get_pwrdwn_sw
        If flag_restart_autoneg = &H0 Then write_restart_autoneg_value = get_restart_autoneg
        If flag_duplex = &H0 Then write_duplex_value = get_duplex
        If flag_collision_test_en = &H0 Then write_collision_test_en_value = get_collision_test_en
        If flag_manual_speed1 = &H0 Then write_manual_speed1_value = get_manual_speed1

        regValue = leftShift((write_rst_hw_value and &H1), 15) + leftShift((write_gloopback_value and &H1), 14) + leftShift((write_manual_speed0_value and &H1), 13) + leftShift((write_autoneg_enable_value and &H1), 12) + leftShift((write_pwrdwn_sw_value and &H1), 11) + leftShift((write_restart_autoneg_value and &H1), 9) + leftShift((write_duplex_value and &H1), 8) + leftShift((write_collision_test_en_value and &H1), 7) + leftShift((write_manual_speed1_value and &H1), 6)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rst_hw_value = rightShift(data_low, 15) and &H1
        read_gloopback_value = rightShift(data_low, 14) and &H1
        read_manual_speed0_value = rightShift(data_low, 13) and &H1
        read_autoneg_enable_value = rightShift(data_low, 12) and &H1
        read_pwrdwn_sw_value = rightShift(data_low, 11) and &H1
        read_restart_autoneg_value = rightShift(data_low, 9) and &H1
        read_duplex_value = rightShift(data_low, 8) and &H1
        read_collision_test_en_value = rightShift(data_low, 7) and &H1
        read_manual_speed1_value = rightShift(data_low, 6) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rst_hw_value = &H0
        flag_rst_hw        = &H0
        write_gloopback_value = &H0
        flag_gloopback        = &H0
        write_manual_speed0_value = &H0
        flag_manual_speed0        = &H0
        write_autoneg_enable_value = &H0
        flag_autoneg_enable        = &H0
        write_pwrdwn_sw_value = &H0
        flag_pwrdwn_sw        = &H0
        write_restart_autoneg_value = &H0
        flag_restart_autoneg        = &H0
        write_duplex_value = &H0
        flag_duplex        = &H0
        write_collision_test_en_value = &H0
        flag_collision_test_en        = &H0
        write_manual_speed1_value = &H0
        flag_manual_speed1        = &H0
    End Sub
End Class


'' @REGISTER : IEEE_CL22_SGMIIPCIE_X1_miistat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' s100BASE_T4_capable                        [15:15]          get_s100BASE_T4_capable
''                                                             set_s100BASE_T4_capable
''                                                             read_s100BASE_T4_capable
''                                                             write_s100BASE_T4_capable
''---------------------------------------------------------------------------------
'' s100BASE_X_FULL_Duplex_capable             [14:14]          get_s100BASE_X_FULL_Duplex_capable
''                                                             set_s100BASE_X_FULL_Duplex_capable
''                                                             read_s100BASE_X_FULL_Duplex_capable
''                                                             write_s100BASE_X_FULL_Duplex_capable
''---------------------------------------------------------------------------------
'' s100BASE_X_HALF_Duplex_capable             [13:13]          get_s100BASE_X_HALF_Duplex_capable
''                                                             set_s100BASE_X_HALF_Duplex_capable
''                                                             read_s100BASE_X_HALF_Duplex_capable
''                                                             write_s100BASE_X_HALF_Duplex_capable
''---------------------------------------------------------------------------------
'' s10BASE_T_FULL_Duplex_capable              [12:12]          get_s10BASE_T_FULL_Duplex_capable
''                                                             set_s10BASE_T_FULL_Duplex_capable
''                                                             read_s10BASE_T_FULL_Duplex_capable
''                                                             write_s10BASE_T_FULL_Duplex_capable
''---------------------------------------------------------------------------------
'' s10BASE_T_HALF_Duplex_capable              [11:11]          get_s10BASE_T_HALF_Duplex_capable
''                                                             set_s10BASE_T_HALF_Duplex_capable
''                                                             read_s10BASE_T_HALF_Duplex_capable
''                                                             write_s10BASE_T_HALF_Duplex_capable
''---------------------------------------------------------------------------------
'' s100BASE_T2_FULL_Duplex_capable            [10:10]          get_s100BASE_T2_FULL_Duplex_capable
''                                                             set_s100BASE_T2_FULL_Duplex_capable
''                                                             read_s100BASE_T2_FULL_Duplex_capable
''                                                             write_s100BASE_T2_FULL_Duplex_capable
''---------------------------------------------------------------------------------
'' s100BASE_T2_HALF_Duplex_capable            [9:9]            get_s100BASE_T2_HALF_Duplex_capable
''                                                             set_s100BASE_T2_HALF_Duplex_capable
''                                                             read_s100BASE_T2_HALF_Duplex_capable
''                                                             write_s100BASE_T2_HALF_Duplex_capable
''---------------------------------------------------------------------------------
'' extended_status                            [8:8]            get_extended_status
''                                                             set_extended_status
''                                                             read_extended_status
''                                                             write_extended_status
''---------------------------------------------------------------------------------
'' mf_preamble_supression                     [6:6]            get_mf_preamble_supression
''                                                             set_mf_preamble_supression
''                                                             read_mf_preamble_supression
''                                                             write_mf_preamble_supression
''---------------------------------------------------------------------------------
'' autoneg_complete                           [5:5]            get_autoneg_complete
''                                                             set_autoneg_complete
''                                                             read_autoneg_complete
''                                                             write_autoneg_complete
''---------------------------------------------------------------------------------
'' remote_fault_stat                          [4:4]            get_remote_fault_stat
''                                                             set_remote_fault_stat
''                                                             read_remote_fault_stat
''                                                             write_remote_fault_stat
''---------------------------------------------------------------------------------
'' autoneg_ability                            [3:3]            get_autoneg_ability
''                                                             set_autoneg_ability
''                                                             read_autoneg_ability
''                                                             write_autoneg_ability
''---------------------------------------------------------------------------------
'' link_status                                [2:2]            get_link_status
''                                                             set_link_status
''                                                             read_link_status
''                                                             write_link_status
''---------------------------------------------------------------------------------
'' jabber_detect                              [1:1]            get_jabber_detect
''                                                             set_jabber_detect
''                                                             read_jabber_detect
''                                                             write_jabber_detect
''---------------------------------------------------------------------------------
'' extended_capability                        [0:0]            get_extended_capability
''                                                             set_extended_capability
''                                                             read_extended_capability
''                                                             write_extended_capability
''---------------------------------------------------------------------------------
Class REGISTER_IEEE_CL22_SGMIIPCIE_X1_miistat
    Private write_s100BASE_T4_capable_value
    Private read_s100BASE_T4_capable_value
    Private flag_s100BASE_T4_capable
    Private write_s100BASE_X_FULL_Duplex_capable_value
    Private read_s100BASE_X_FULL_Duplex_capable_value
    Private flag_s100BASE_X_FULL_Duplex_capable
    Private write_s100BASE_X_HALF_Duplex_capable_value
    Private read_s100BASE_X_HALF_Duplex_capable_value
    Private flag_s100BASE_X_HALF_Duplex_capable
    Private write_s10BASE_T_FULL_Duplex_capable_value
    Private read_s10BASE_T_FULL_Duplex_capable_value
    Private flag_s10BASE_T_FULL_Duplex_capable
    Private write_s10BASE_T_HALF_Duplex_capable_value
    Private read_s10BASE_T_HALF_Duplex_capable_value
    Private flag_s10BASE_T_HALF_Duplex_capable
    Private write_s100BASE_T2_FULL_Duplex_capable_value
    Private read_s100BASE_T2_FULL_Duplex_capable_value
    Private flag_s100BASE_T2_FULL_Duplex_capable
    Private write_s100BASE_T2_HALF_Duplex_capable_value
    Private read_s100BASE_T2_HALF_Duplex_capable_value
    Private flag_s100BASE_T2_HALF_Duplex_capable
    Private write_extended_status_value
    Private read_extended_status_value
    Private flag_extended_status
    Private write_mf_preamble_supression_value
    Private read_mf_preamble_supression_value
    Private flag_mf_preamble_supression
    Private write_autoneg_complete_value
    Private read_autoneg_complete_value
    Private flag_autoneg_complete
    Private write_remote_fault_stat_value
    Private read_remote_fault_stat_value
    Private flag_remote_fault_stat
    Private write_autoneg_ability_value
    Private read_autoneg_ability_value
    Private flag_autoneg_ability
    Private write_link_status_value
    Private read_link_status_value
    Private flag_link_status
    Private write_jabber_detect_value
    Private read_jabber_detect_value
    Private flag_jabber_detect
    Private write_extended_capability_value
    Private read_extended_capability_value
    Private flag_extended_capability

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

    Property Get get_s100BASE_T4_capable
        get_s100BASE_T4_capable = read_s100BASE_T4_capable_value
    End Property

    Property Let set_s100BASE_T4_capable(aData)
        write_s100BASE_T4_capable_value = aData
        flag_s100BASE_T4_capable        = &H1
    End Property

    Property Get read_s100BASE_T4_capable
        read
        read_s100BASE_T4_capable = read_s100BASE_T4_capable_value
    End Property

    Property Let write_s100BASE_T4_capable(aData)
        set_s100BASE_T4_capable = aData
        write
    End Property

    Property Get get_s100BASE_X_FULL_Duplex_capable
        get_s100BASE_X_FULL_Duplex_capable = read_s100BASE_X_FULL_Duplex_capable_value
    End Property

    Property Let set_s100BASE_X_FULL_Duplex_capable(aData)
        write_s100BASE_X_FULL_Duplex_capable_value = aData
        flag_s100BASE_X_FULL_Duplex_capable        = &H1
    End Property

    Property Get read_s100BASE_X_FULL_Duplex_capable
        read
        read_s100BASE_X_FULL_Duplex_capable = read_s100BASE_X_FULL_Duplex_capable_value
    End Property

    Property Let write_s100BASE_X_FULL_Duplex_capable(aData)
        set_s100BASE_X_FULL_Duplex_capable = aData
        write
    End Property

    Property Get get_s100BASE_X_HALF_Duplex_capable
        get_s100BASE_X_HALF_Duplex_capable = read_s100BASE_X_HALF_Duplex_capable_value
    End Property

    Property Let set_s100BASE_X_HALF_Duplex_capable(aData)
        write_s100BASE_X_HALF_Duplex_capable_value = aData
        flag_s100BASE_X_HALF_Duplex_capable        = &H1
    End Property

    Property Get read_s100BASE_X_HALF_Duplex_capable
        read
        read_s100BASE_X_HALF_Duplex_capable = read_s100BASE_X_HALF_Duplex_capable_value
    End Property

    Property Let write_s100BASE_X_HALF_Duplex_capable(aData)
        set_s100BASE_X_HALF_Duplex_capable = aData
        write
    End Property

    Property Get get_s10BASE_T_FULL_Duplex_capable
        get_s10BASE_T_FULL_Duplex_capable = read_s10BASE_T_FULL_Duplex_capable_value
    End Property

    Property Let set_s10BASE_T_FULL_Duplex_capable(aData)
        write_s10BASE_T_FULL_Duplex_capable_value = aData
        flag_s10BASE_T_FULL_Duplex_capable        = &H1
    End Property

    Property Get read_s10BASE_T_FULL_Duplex_capable
        read
        read_s10BASE_T_FULL_Duplex_capable = read_s10BASE_T_FULL_Duplex_capable_value
    End Property

    Property Let write_s10BASE_T_FULL_Duplex_capable(aData)
        set_s10BASE_T_FULL_Duplex_capable = aData
        write
    End Property

    Property Get get_s10BASE_T_HALF_Duplex_capable
        get_s10BASE_T_HALF_Duplex_capable = read_s10BASE_T_HALF_Duplex_capable_value
    End Property

    Property Let set_s10BASE_T_HALF_Duplex_capable(aData)
        write_s10BASE_T_HALF_Duplex_capable_value = aData
        flag_s10BASE_T_HALF_Duplex_capable        = &H1
    End Property

    Property Get read_s10BASE_T_HALF_Duplex_capable
        read
        read_s10BASE_T_HALF_Duplex_capable = read_s10BASE_T_HALF_Duplex_capable_value
    End Property

    Property Let write_s10BASE_T_HALF_Duplex_capable(aData)
        set_s10BASE_T_HALF_Duplex_capable = aData
        write
    End Property

    Property Get get_s100BASE_T2_FULL_Duplex_capable
        get_s100BASE_T2_FULL_Duplex_capable = read_s100BASE_T2_FULL_Duplex_capable_value
    End Property

    Property Let set_s100BASE_T2_FULL_Duplex_capable(aData)
        write_s100BASE_T2_FULL_Duplex_capable_value = aData
        flag_s100BASE_T2_FULL_Duplex_capable        = &H1
    End Property

    Property Get read_s100BASE_T2_FULL_Duplex_capable
        read
        read_s100BASE_T2_FULL_Duplex_capable = read_s100BASE_T2_FULL_Duplex_capable_value
    End Property

    Property Let write_s100BASE_T2_FULL_Duplex_capable(aData)
        set_s100BASE_T2_FULL_Duplex_capable = aData
        write
    End Property

    Property Get get_s100BASE_T2_HALF_Duplex_capable
        get_s100BASE_T2_HALF_Duplex_capable = read_s100BASE_T2_HALF_Duplex_capable_value
    End Property

    Property Let set_s100BASE_T2_HALF_Duplex_capable(aData)
        write_s100BASE_T2_HALF_Duplex_capable_value = aData
        flag_s100BASE_T2_HALF_Duplex_capable        = &H1
    End Property

    Property Get read_s100BASE_T2_HALF_Duplex_capable
        read
        read_s100BASE_T2_HALF_Duplex_capable = read_s100BASE_T2_HALF_Duplex_capable_value
    End Property

    Property Let write_s100BASE_T2_HALF_Duplex_capable(aData)
        set_s100BASE_T2_HALF_Duplex_capable = aData
        write
    End Property

    Property Get get_extended_status
        get_extended_status = read_extended_status_value
    End Property

    Property Let set_extended_status(aData)
        write_extended_status_value = aData
        flag_extended_status        = &H1
    End Property

    Property Get read_extended_status
        read
        read_extended_status = read_extended_status_value
    End Property

    Property Let write_extended_status(aData)
        set_extended_status = aData
        write
    End Property

    Property Get get_mf_preamble_supression
        get_mf_preamble_supression = read_mf_preamble_supression_value
    End Property

    Property Let set_mf_preamble_supression(aData)
        write_mf_preamble_supression_value = aData
        flag_mf_preamble_supression        = &H1
    End Property

    Property Get read_mf_preamble_supression
        read
        read_mf_preamble_supression = read_mf_preamble_supression_value
    End Property

    Property Let write_mf_preamble_supression(aData)
        set_mf_preamble_supression = aData
        write
    End Property

    Property Get get_autoneg_complete
        get_autoneg_complete = read_autoneg_complete_value
    End Property

    Property Let set_autoneg_complete(aData)
        write_autoneg_complete_value = aData
        flag_autoneg_complete        = &H1
    End Property

    Property Get read_autoneg_complete
        read
        read_autoneg_complete = read_autoneg_complete_value
    End Property

    Property Let write_autoneg_complete(aData)
        set_autoneg_complete = aData
        write
    End Property

    Property Get get_remote_fault_stat
        get_remote_fault_stat = read_remote_fault_stat_value
    End Property

    Property Let set_remote_fault_stat(aData)
        write_remote_fault_stat_value = aData
        flag_remote_fault_stat        = &H1
    End Property

    Property Get read_remote_fault_stat
        read
        read_remote_fault_stat = read_remote_fault_stat_value
    End Property

    Property Let write_remote_fault_stat(aData)
        set_remote_fault_stat = aData
        write
    End Property

    Property Get get_autoneg_ability
        get_autoneg_ability = read_autoneg_ability_value
    End Property

    Property Let set_autoneg_ability(aData)
        write_autoneg_ability_value = aData
        flag_autoneg_ability        = &H1
    End Property

    Property Get read_autoneg_ability
        read
        read_autoneg_ability = read_autoneg_ability_value
    End Property

    Property Let write_autoneg_ability(aData)
        set_autoneg_ability = aData
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

    Property Get get_jabber_detect
        get_jabber_detect = read_jabber_detect_value
    End Property

    Property Let set_jabber_detect(aData)
        write_jabber_detect_value = aData
        flag_jabber_detect        = &H1
    End Property

    Property Get read_jabber_detect
        read
        read_jabber_detect = read_jabber_detect_value
    End Property

    Property Let write_jabber_detect(aData)
        set_jabber_detect = aData
        write
    End Property

    Property Get get_extended_capability
        get_extended_capability = read_extended_capability_value
    End Property

    Property Let set_extended_capability(aData)
        write_extended_capability_value = aData
        flag_extended_capability        = &H1
    End Property

    Property Get read_extended_capability
        read
        read_extended_capability = read_extended_capability_value
    End Property

    Property Let write_extended_capability(aData)
        set_extended_capability = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_s100BASE_T4_capable_value = rightShift(data_low, 15) and &H1
        read_s100BASE_X_FULL_Duplex_capable_value = rightShift(data_low, 14) and &H1
        read_s100BASE_X_HALF_Duplex_capable_value = rightShift(data_low, 13) and &H1
        read_s10BASE_T_FULL_Duplex_capable_value = rightShift(data_low, 12) and &H1
        read_s10BASE_T_HALF_Duplex_capable_value = rightShift(data_low, 11) and &H1
        read_s100BASE_T2_FULL_Duplex_capable_value = rightShift(data_low, 10) and &H1
        read_s100BASE_T2_HALF_Duplex_capable_value = rightShift(data_low, 9) and &H1
        read_extended_status_value = rightShift(data_low, 8) and &H1
        read_mf_preamble_supression_value = rightShift(data_low, 6) and &H1
        read_autoneg_complete_value = rightShift(data_low, 5) and &H1
        read_remote_fault_stat_value = rightShift(data_low, 4) and &H1
        read_autoneg_ability_value = rightShift(data_low, 3) and &H1
        read_link_status_value = rightShift(data_low, 2) and &H1
        read_jabber_detect_value = rightShift(data_low, 1) and &H1
        extended_capability_mask = &H1
        if data_low > LONG_MAX then
            if extended_capability_mask = mask then
                read_extended_capability_value = data_low
            else
                read_extended_capability_value = (data_low - H8000_0000) and extended_capability_mask
            end If
        else
            read_extended_capability_value = data_low and extended_capability_mask
        end If

    End Sub

    Sub write
        If flag_s100BASE_T4_capable = &H0 or flag_s100BASE_X_FULL_Duplex_capable = &H0 or flag_s100BASE_X_HALF_Duplex_capable = &H0 or flag_s10BASE_T_FULL_Duplex_capable = &H0 or flag_s10BASE_T_HALF_Duplex_capable = &H0 or flag_s100BASE_T2_FULL_Duplex_capable = &H0 or flag_s100BASE_T2_HALF_Duplex_capable = &H0 or flag_extended_status = &H0 or flag_mf_preamble_supression = &H0 or flag_autoneg_complete = &H0 or flag_remote_fault_stat = &H0 or flag_autoneg_ability = &H0 or flag_link_status = &H0 or flag_jabber_detect = &H0 or flag_extended_capability = &H0 Then read
        If flag_s100BASE_T4_capable = &H0 Then write_s100BASE_T4_capable_value = get_s100BASE_T4_capable
        If flag_s100BASE_X_FULL_Duplex_capable = &H0 Then write_s100BASE_X_FULL_Duplex_capable_value = get_s100BASE_X_FULL_Duplex_capable
        If flag_s100BASE_X_HALF_Duplex_capable = &H0 Then write_s100BASE_X_HALF_Duplex_capable_value = get_s100BASE_X_HALF_Duplex_capable
        If flag_s10BASE_T_FULL_Duplex_capable = &H0 Then write_s10BASE_T_FULL_Duplex_capable_value = get_s10BASE_T_FULL_Duplex_capable
        If flag_s10BASE_T_HALF_Duplex_capable = &H0 Then write_s10BASE_T_HALF_Duplex_capable_value = get_s10BASE_T_HALF_Duplex_capable
        If flag_s100BASE_T2_FULL_Duplex_capable = &H0 Then write_s100BASE_T2_FULL_Duplex_capable_value = get_s100BASE_T2_FULL_Duplex_capable
        If flag_s100BASE_T2_HALF_Duplex_capable = &H0 Then write_s100BASE_T2_HALF_Duplex_capable_value = get_s100BASE_T2_HALF_Duplex_capable
        If flag_extended_status = &H0 Then write_extended_status_value = get_extended_status
        If flag_mf_preamble_supression = &H0 Then write_mf_preamble_supression_value = get_mf_preamble_supression
        If flag_autoneg_complete = &H0 Then write_autoneg_complete_value = get_autoneg_complete
        If flag_remote_fault_stat = &H0 Then write_remote_fault_stat_value = get_remote_fault_stat
        If flag_autoneg_ability = &H0 Then write_autoneg_ability_value = get_autoneg_ability
        If flag_link_status = &H0 Then write_link_status_value = get_link_status
        If flag_jabber_detect = &H0 Then write_jabber_detect_value = get_jabber_detect
        If flag_extended_capability = &H0 Then write_extended_capability_value = get_extended_capability

        regValue = leftShift((write_s100BASE_T4_capable_value and &H1), 15) + leftShift((write_s100BASE_X_FULL_Duplex_capable_value and &H1), 14) + leftShift((write_s100BASE_X_HALF_Duplex_capable_value and &H1), 13) + leftShift((write_s10BASE_T_FULL_Duplex_capable_value and &H1), 12) + leftShift((write_s10BASE_T_HALF_Duplex_capable_value and &H1), 11) + leftShift((write_s100BASE_T2_FULL_Duplex_capable_value and &H1), 10) + leftShift((write_s100BASE_T2_HALF_Duplex_capable_value and &H1), 9) + leftShift((write_extended_status_value and &H1), 8) + leftShift((write_mf_preamble_supression_value and &H1), 6) + leftShift((write_autoneg_complete_value and &H1), 5) + leftShift((write_remote_fault_stat_value and &H1), 4) + leftShift((write_autoneg_ability_value and &H1), 3) + leftShift((write_link_status_value and &H1), 2) + leftShift((write_jabber_detect_value and &H1), 1) + leftShift((write_extended_capability_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_s100BASE_T4_capable_value = rightShift(data_low, 15) and &H1
        read_s100BASE_X_FULL_Duplex_capable_value = rightShift(data_low, 14) and &H1
        read_s100BASE_X_HALF_Duplex_capable_value = rightShift(data_low, 13) and &H1
        read_s10BASE_T_FULL_Duplex_capable_value = rightShift(data_low, 12) and &H1
        read_s10BASE_T_HALF_Duplex_capable_value = rightShift(data_low, 11) and &H1
        read_s100BASE_T2_FULL_Duplex_capable_value = rightShift(data_low, 10) and &H1
        read_s100BASE_T2_HALF_Duplex_capable_value = rightShift(data_low, 9) and &H1
        read_extended_status_value = rightShift(data_low, 8) and &H1
        read_mf_preamble_supression_value = rightShift(data_low, 6) and &H1
        read_autoneg_complete_value = rightShift(data_low, 5) and &H1
        read_remote_fault_stat_value = rightShift(data_low, 4) and &H1
        read_autoneg_ability_value = rightShift(data_low, 3) and &H1
        read_link_status_value = rightShift(data_low, 2) and &H1
        read_jabber_detect_value = rightShift(data_low, 1) and &H1
        extended_capability_mask = &H1
        if data_low > LONG_MAX then
            if extended_capability_mask = mask then
                read_extended_capability_value = data_low
            else
                read_extended_capability_value = (data_low - H8000_0000) and extended_capability_mask
            end If
        else
            read_extended_capability_value = data_low and extended_capability_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_s100BASE_T4_capable_value = &H0
        flag_s100BASE_T4_capable        = &H0
        write_s100BASE_X_FULL_Duplex_capable_value = &H0
        flag_s100BASE_X_FULL_Duplex_capable        = &H0
        write_s100BASE_X_HALF_Duplex_capable_value = &H0
        flag_s100BASE_X_HALF_Duplex_capable        = &H0
        write_s10BASE_T_FULL_Duplex_capable_value = &H0
        flag_s10BASE_T_FULL_Duplex_capable        = &H0
        write_s10BASE_T_HALF_Duplex_capable_value = &H0
        flag_s10BASE_T_HALF_Duplex_capable        = &H0
        write_s100BASE_T2_FULL_Duplex_capable_value = &H0
        flag_s100BASE_T2_FULL_Duplex_capable        = &H0
        write_s100BASE_T2_HALF_Duplex_capable_value = &H0
        flag_s100BASE_T2_HALF_Duplex_capable        = &H0
        write_extended_status_value = &H0
        flag_extended_status        = &H0
        write_mf_preamble_supression_value = &H0
        flag_mf_preamble_supression        = &H0
        write_autoneg_complete_value = &H0
        flag_autoneg_complete        = &H0
        write_remote_fault_stat_value = &H0
        flag_remote_fault_stat        = &H0
        write_autoneg_ability_value = &H0
        flag_autoneg_ability        = &H0
        write_link_status_value = &H0
        flag_link_status        = &H0
        write_jabber_detect_value = &H0
        flag_jabber_detect        = &H0
        write_extended_capability_value = &H0
        flag_extended_capability        = &H0
    End Sub
End Class


'' @REGISTER : IEEE_CL22_SGMIIPCIE_X1_autonegadv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' next_page                                  [15:15]          get_next_page
''                                                             set_next_page
''                                                             read_next_page
''                                                             write_next_page
''---------------------------------------------------------------------------------
'' remote_fault                               [13:12]          get_remote_fault
''                                                             set_remote_fault
''                                                             read_remote_fault
''                                                             write_remote_fault
''---------------------------------------------------------------------------------
'' pause                                      [8:7]            get_pause
''                                                             set_pause
''                                                             read_pause
''                                                             write_pause
''---------------------------------------------------------------------------------
'' half_duplex                                [6:6]            get_half_duplex
''                                                             set_half_duplex
''                                                             read_half_duplex
''                                                             write_half_duplex
''---------------------------------------------------------------------------------
'' full_duplex                                [5:5]            get_full_duplex
''                                                             set_full_duplex
''                                                             read_full_duplex
''                                                             write_full_duplex
''---------------------------------------------------------------------------------
Class REGISTER_IEEE_CL22_SGMIIPCIE_X1_autonegadv
    Private write_next_page_value
    Private read_next_page_value
    Private flag_next_page
    Private write_remote_fault_value
    Private read_remote_fault_value
    Private flag_remote_fault
    Private write_pause_value
    Private read_pause_value
    Private flag_pause
    Private write_half_duplex_value
    Private read_half_duplex_value
    Private flag_half_duplex
    Private write_full_duplex_value
    Private read_full_duplex_value
    Private flag_full_duplex

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

    Property Get get_next_page
        get_next_page = read_next_page_value
    End Property

    Property Let set_next_page(aData)
        write_next_page_value = aData
        flag_next_page        = &H1
    End Property

    Property Get read_next_page
        read
        read_next_page = read_next_page_value
    End Property

    Property Let write_next_page(aData)
        set_next_page = aData
        write
    End Property

    Property Get get_remote_fault
        get_remote_fault = read_remote_fault_value
    End Property

    Property Let set_remote_fault(aData)
        write_remote_fault_value = aData
        flag_remote_fault        = &H1
    End Property

    Property Get read_remote_fault
        read
        read_remote_fault = read_remote_fault_value
    End Property

    Property Let write_remote_fault(aData)
        set_remote_fault = aData
        write
    End Property

    Property Get get_pause
        get_pause = read_pause_value
    End Property

    Property Let set_pause(aData)
        write_pause_value = aData
        flag_pause        = &H1
    End Property

    Property Get read_pause
        read
        read_pause = read_pause_value
    End Property

    Property Let write_pause(aData)
        set_pause = aData
        write
    End Property

    Property Get get_half_duplex
        get_half_duplex = read_half_duplex_value
    End Property

    Property Let set_half_duplex(aData)
        write_half_duplex_value = aData
        flag_half_duplex        = &H1
    End Property

    Property Get read_half_duplex
        read
        read_half_duplex = read_half_duplex_value
    End Property

    Property Let write_half_duplex(aData)
        set_half_duplex = aData
        write
    End Property

    Property Get get_full_duplex
        get_full_duplex = read_full_duplex_value
    End Property

    Property Let set_full_duplex(aData)
        write_full_duplex_value = aData
        flag_full_duplex        = &H1
    End Property

    Property Get read_full_duplex
        read
        read_full_duplex = read_full_duplex_value
    End Property

    Property Let write_full_duplex(aData)
        set_full_duplex = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_next_page_value = rightShift(data_low, 15) and &H1
        read_remote_fault_value = rightShift(data_low, 12) and &H3
        read_pause_value = rightShift(data_low, 7) and &H3
        read_half_duplex_value = rightShift(data_low, 6) and &H1
        read_full_duplex_value = rightShift(data_low, 5) and &H1

    End Sub

    Sub write
        If flag_next_page = &H0 or flag_remote_fault = &H0 or flag_pause = &H0 or flag_half_duplex = &H0 or flag_full_duplex = &H0 Then read
        If flag_next_page = &H0 Then write_next_page_value = get_next_page
        If flag_remote_fault = &H0 Then write_remote_fault_value = get_remote_fault
        If flag_pause = &H0 Then write_pause_value = get_pause
        If flag_half_duplex = &H0 Then write_half_duplex_value = get_half_duplex
        If flag_full_duplex = &H0 Then write_full_duplex_value = get_full_duplex

        regValue = leftShift((write_next_page_value and &H1), 15) + leftShift((write_remote_fault_value and &H3), 12) + leftShift((write_pause_value and &H3), 7) + leftShift((write_half_duplex_value and &H1), 6) + leftShift((write_full_duplex_value and &H1), 5)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_next_page_value = rightShift(data_low, 15) and &H1
        read_remote_fault_value = rightShift(data_low, 12) and &H3
        read_pause_value = rightShift(data_low, 7) and &H3
        read_half_duplex_value = rightShift(data_low, 6) and &H1
        read_full_duplex_value = rightShift(data_low, 5) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_next_page_value = &H0
        flag_next_page        = &H0
        write_remote_fault_value = &H0
        flag_remote_fault        = &H0
        write_pause_value = &H0
        flag_pause        = &H0
        write_half_duplex_value = &H0
        flag_half_duplex        = &H0
        write_full_duplex_value = &H0
        flag_full_duplex        = &H0
    End Sub
End Class


'' @REGISTER : IEEE_CL22_SGMIIPCIE_X1_autoneglpabil
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mr_lp_adv_ability                          [15:0]           get_mr_lp_adv_ability
''                                                             set_mr_lp_adv_ability
''                                                             read_mr_lp_adv_ability
''                                                             write_mr_lp_adv_ability
''---------------------------------------------------------------------------------
Class REGISTER_IEEE_CL22_SGMIIPCIE_X1_autoneglpabil
    Private write_mr_lp_adv_ability_value
    Private read_mr_lp_adv_ability_value
    Private flag_mr_lp_adv_ability

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

    Property Get get_mr_lp_adv_ability
        get_mr_lp_adv_ability = read_mr_lp_adv_ability_value
    End Property

    Property Let set_mr_lp_adv_ability(aData)
        write_mr_lp_adv_ability_value = aData
        flag_mr_lp_adv_ability        = &H1
    End Property

    Property Get read_mr_lp_adv_ability
        read
        read_mr_lp_adv_ability = read_mr_lp_adv_ability_value
    End Property

    Property Let write_mr_lp_adv_ability(aData)
        set_mr_lp_adv_ability = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mr_lp_adv_ability_mask = &Hffff
        if data_low > LONG_MAX then
            if mr_lp_adv_ability_mask = mask then
                read_mr_lp_adv_ability_value = data_low
            else
                read_mr_lp_adv_ability_value = (data_low - H8000_0000) and mr_lp_adv_ability_mask
            end If
        else
            read_mr_lp_adv_ability_value = data_low and mr_lp_adv_ability_mask
        end If

    End Sub

    Sub write
        If flag_mr_lp_adv_ability = &H0 Then read
        If flag_mr_lp_adv_ability = &H0 Then write_mr_lp_adv_ability_value = get_mr_lp_adv_ability

        regValue = leftShift((write_mr_lp_adv_ability_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mr_lp_adv_ability_mask = &Hffff
        if data_low > LONG_MAX then
            if mr_lp_adv_ability_mask = mask then
                read_mr_lp_adv_ability_value = data_low
            else
                read_mr_lp_adv_ability_value = (data_low - H8000_0000) and mr_lp_adv_ability_mask
            end If
        else
            read_mr_lp_adv_ability_value = data_low and mr_lp_adv_ability_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mr_lp_adv_ability_value = &H0
        flag_mr_lp_adv_ability        = &H0
    End Sub
End Class


'' @REGISTER : IEEE_CL22_SGMIIPCIE_X1_mmd_accesscontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' increment_ctrl                             [15:14]          get_increment_ctrl
''                                                             set_increment_ctrl
''                                                             read_increment_ctrl
''                                                             write_increment_ctrl
''---------------------------------------------------------------------------------
'' devad                                      [4:0]            get_devad
''                                                             set_devad
''                                                             read_devad
''                                                             write_devad
''---------------------------------------------------------------------------------
Class REGISTER_IEEE_CL22_SGMIIPCIE_X1_mmd_accesscontrol
    Private write_increment_ctrl_value
    Private read_increment_ctrl_value
    Private flag_increment_ctrl
    Private write_devad_value
    Private read_devad_value
    Private flag_devad

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

    Property Get get_increment_ctrl
        get_increment_ctrl = read_increment_ctrl_value
    End Property

    Property Let set_increment_ctrl(aData)
        write_increment_ctrl_value = aData
        flag_increment_ctrl        = &H1
    End Property

    Property Get read_increment_ctrl
        read
        read_increment_ctrl = read_increment_ctrl_value
    End Property

    Property Let write_increment_ctrl(aData)
        set_increment_ctrl = aData
        write
    End Property

    Property Get get_devad
        get_devad = read_devad_value
    End Property

    Property Let set_devad(aData)
        write_devad_value = aData
        flag_devad        = &H1
    End Property

    Property Get read_devad
        read
        read_devad = read_devad_value
    End Property

    Property Let write_devad(aData)
        set_devad = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_increment_ctrl_value = rightShift(data_low, 14) and &H3
        devad_mask = &H1f
        if data_low > LONG_MAX then
            if devad_mask = mask then
                read_devad_value = data_low
            else
                read_devad_value = (data_low - H8000_0000) and devad_mask
            end If
        else
            read_devad_value = data_low and devad_mask
        end If

    End Sub

    Sub write
        If flag_increment_ctrl = &H0 or flag_devad = &H0 Then read
        If flag_increment_ctrl = &H0 Then write_increment_ctrl_value = get_increment_ctrl
        If flag_devad = &H0 Then write_devad_value = get_devad

        regValue = leftShift((write_increment_ctrl_value and &H3), 14) + leftShift((write_devad_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_increment_ctrl_value = rightShift(data_low, 14) and &H3
        devad_mask = &H1f
        if data_low > LONG_MAX then
            if devad_mask = mask then
                read_devad_value = data_low
            else
                read_devad_value = (data_low - H8000_0000) and devad_mask
            end If
        else
            read_devad_value = data_low and devad_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_increment_ctrl_value = &H0
        flag_increment_ctrl        = &H0
        write_devad_value = &H0
        flag_devad        = &H0
    End Sub
End Class


'' @REGISTER : IEEE_CL22_SGMIIPCIE_X1_mmd_accessad
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' addrdata                                   [15:0]           get_addrdata
''                                                             set_addrdata
''                                                             read_addrdata
''                                                             write_addrdata
''---------------------------------------------------------------------------------
Class REGISTER_IEEE_CL22_SGMIIPCIE_X1_mmd_accessad
    Private write_addrdata_value
    Private read_addrdata_value
    Private flag_addrdata

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_addrdata
        get_addrdata = read_addrdata_value
    End Property

    Property Let set_addrdata(aData)
        write_addrdata_value = aData
        flag_addrdata        = &H1
    End Property

    Property Get read_addrdata
        read
        read_addrdata = read_addrdata_value
    End Property

    Property Let write_addrdata(aData)
        set_addrdata = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        addrdata_mask = &Hffff
        if data_low > LONG_MAX then
            if addrdata_mask = mask then
                read_addrdata_value = data_low
            else
                read_addrdata_value = (data_low - H8000_0000) and addrdata_mask
            end If
        else
            read_addrdata_value = data_low and addrdata_mask
        end If

    End Sub

    Sub write
        If flag_addrdata = &H0 Then read
        If flag_addrdata = &H0 Then write_addrdata_value = get_addrdata

        regValue = leftShift((write_addrdata_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        addrdata_mask = &Hffff
        if data_low > LONG_MAX then
            if addrdata_mask = mask then
                read_addrdata_value = data_low
            else
                read_addrdata_value = (data_low - H8000_0000) and addrdata_mask
            end If
        else
            read_addrdata_value = data_low and addrdata_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_addrdata_value = &H0
        flag_addrdata        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class IEEE_CL22_SGMIIPCIE_X1_INSTANCE

    Public miicntl
    Public miistat
    Public autonegadv
    Public autoneglpabil
    Public mmd_accesscontrol
    Public mmd_accessad


    Public default function Init(aBaseAddr)
        Set miicntl = (New REGISTER_IEEE_CL22_SGMIIPCIE_X1_miicntl)(aBaseAddr, 16)
        Set miistat = (New REGISTER_IEEE_CL22_SGMIIPCIE_X1_miistat)(aBaseAddr, 16)
        Set autonegadv = (New REGISTER_IEEE_CL22_SGMIIPCIE_X1_autonegadv)(aBaseAddr, 16)
        Set autoneglpabil = (New REGISTER_IEEE_CL22_SGMIIPCIE_X1_autoneglpabil)(aBaseAddr, 16)
        Set mmd_accesscontrol = (New REGISTER_IEEE_CL22_SGMIIPCIE_X1_mmd_accesscontrol)(aBaseAddr, 16)
        Set mmd_accessad = (New REGISTER_IEEE_CL22_SGMIIPCIE_X1_mmd_accessad)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set IEEE_CL22_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
IEEE_CL22_SGMIIPCIE_X1.Add ((New IEEE_CL22_SGMIIPCIE_X1_INSTANCE)(&H4ad00000))


