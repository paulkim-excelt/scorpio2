

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


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_enables_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_setup_enable                            [14:14]          get_an_setup_enable
''                                                             set_an_setup_enable
''                                                             read_an_setup_enable
''                                                             write_an_setup_enable
''---------------------------------------------------------------------------------
'' num_advertised_lanes                       [13:12]          get_num_advertised_lanes
''                                                             set_num_advertised_lanes
''                                                             read_num_advertised_lanes
''                                                             write_num_advertised_lanes
''---------------------------------------------------------------------------------
'' cl37_bam_enable                            [11:11]          get_cl37_bam_enable
''                                                             set_cl37_bam_enable
''                                                             read_cl37_bam_enable
''                                                             write_cl37_bam_enable
''---------------------------------------------------------------------------------
'' cl73_bam_enable                            [10:10]          get_cl73_bam_enable
''                                                             set_cl73_bam_enable
''                                                             read_cl73_bam_enable
''                                                             write_cl73_bam_enable
''---------------------------------------------------------------------------------
'' cl73_hpam_enable                           [9:9]            get_cl73_hpam_enable
''                                                             set_cl73_hpam_enable
''                                                             read_cl73_hpam_enable
''                                                             write_cl73_hpam_enable
''---------------------------------------------------------------------------------
'' cl73_enable                                [8:8]            get_cl73_enable
''                                                             set_cl73_enable
''                                                             read_cl73_enable
''                                                             write_cl73_enable
''---------------------------------------------------------------------------------
'' cl37_sgmii_enable                          [7:7]            get_cl37_sgmii_enable
''                                                             set_cl37_sgmii_enable
''                                                             read_cl37_sgmii_enable
''                                                             write_cl37_sgmii_enable
''---------------------------------------------------------------------------------
'' cl37_enable                                [6:6]            get_cl37_enable
''                                                             set_cl37_enable
''                                                             read_cl37_enable
''                                                             write_cl37_enable
''---------------------------------------------------------------------------------
'' cl37_bam_to_sgmii_auto_enable              [5:5]            get_cl37_bam_to_sgmii_auto_enable
''                                                             set_cl37_bam_to_sgmii_auto_enable
''                                                             read_cl37_bam_to_sgmii_auto_enable
''                                                             write_cl37_bam_to_sgmii_auto_enable
''---------------------------------------------------------------------------------
'' sgmii_to_cl37_auto_enable                  [4:4]            get_sgmii_to_cl37_auto_enable
''                                                             set_sgmii_to_cl37_auto_enable
''                                                             read_sgmii_to_cl37_auto_enable
''                                                             write_sgmii_to_cl37_auto_enable
''---------------------------------------------------------------------------------
'' cl73_bam_to_hpam_auto_enable               [3:3]            get_cl73_bam_to_hpam_auto_enable
''                                                             set_cl73_bam_to_hpam_auto_enable
''                                                             read_cl73_bam_to_hpam_auto_enable
''                                                             write_cl73_bam_to_hpam_auto_enable
''---------------------------------------------------------------------------------
'' hpam_to_cl73_auto_enable                   [2:2]            get_hpam_to_cl73_auto_enable
''                                                             set_hpam_to_cl73_auto_enable
''                                                             read_hpam_to_cl73_auto_enable
''                                                             write_hpam_to_cl73_auto_enable
''---------------------------------------------------------------------------------
'' cl37_an_restart                            [1:1]            get_cl37_an_restart
''                                                             set_cl37_an_restart
''                                                             read_cl37_an_restart
''                                                             write_cl37_an_restart
''---------------------------------------------------------------------------------
'' cl73_an_restart                            [0:0]            get_cl73_an_restart
''                                                             set_cl73_an_restart
''                                                             read_cl73_an_restart
''                                                             write_cl73_an_restart
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_enables_sgmiiplusr_x1
    Private write_an_setup_enable_value
    Private read_an_setup_enable_value
    Private flag_an_setup_enable
    Private write_num_advertised_lanes_value
    Private read_num_advertised_lanes_value
    Private flag_num_advertised_lanes
    Private write_cl37_bam_enable_value
    Private read_cl37_bam_enable_value
    Private flag_cl37_bam_enable
    Private write_cl73_bam_enable_value
    Private read_cl73_bam_enable_value
    Private flag_cl73_bam_enable
    Private write_cl73_hpam_enable_value
    Private read_cl73_hpam_enable_value
    Private flag_cl73_hpam_enable
    Private write_cl73_enable_value
    Private read_cl73_enable_value
    Private flag_cl73_enable
    Private write_cl37_sgmii_enable_value
    Private read_cl37_sgmii_enable_value
    Private flag_cl37_sgmii_enable
    Private write_cl37_enable_value
    Private read_cl37_enable_value
    Private flag_cl37_enable
    Private write_cl37_bam_to_sgmii_auto_enable_value
    Private read_cl37_bam_to_sgmii_auto_enable_value
    Private flag_cl37_bam_to_sgmii_auto_enable
    Private write_sgmii_to_cl37_auto_enable_value
    Private read_sgmii_to_cl37_auto_enable_value
    Private flag_sgmii_to_cl37_auto_enable
    Private write_cl73_bam_to_hpam_auto_enable_value
    Private read_cl73_bam_to_hpam_auto_enable_value
    Private flag_cl73_bam_to_hpam_auto_enable
    Private write_hpam_to_cl73_auto_enable_value
    Private read_hpam_to_cl73_auto_enable_value
    Private flag_hpam_to_cl73_auto_enable
    Private write_cl37_an_restart_value
    Private read_cl37_an_restart_value
    Private flag_cl37_an_restart
    Private write_cl73_an_restart_value
    Private read_cl73_an_restart_value
    Private flag_cl73_an_restart

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

    Property Get get_an_setup_enable
        get_an_setup_enable = read_an_setup_enable_value
    End Property

    Property Let set_an_setup_enable(aData)
        write_an_setup_enable_value = aData
        flag_an_setup_enable        = &H1
    End Property

    Property Get read_an_setup_enable
        read
        read_an_setup_enable = read_an_setup_enable_value
    End Property

    Property Let write_an_setup_enable(aData)
        set_an_setup_enable = aData
        write
    End Property

    Property Get get_num_advertised_lanes
        get_num_advertised_lanes = read_num_advertised_lanes_value
    End Property

    Property Let set_num_advertised_lanes(aData)
        write_num_advertised_lanes_value = aData
        flag_num_advertised_lanes        = &H1
    End Property

    Property Get read_num_advertised_lanes
        read
        read_num_advertised_lanes = read_num_advertised_lanes_value
    End Property

    Property Let write_num_advertised_lanes(aData)
        set_num_advertised_lanes = aData
        write
    End Property

    Property Get get_cl37_bam_enable
        get_cl37_bam_enable = read_cl37_bam_enable_value
    End Property

    Property Let set_cl37_bam_enable(aData)
        write_cl37_bam_enable_value = aData
        flag_cl37_bam_enable        = &H1
    End Property

    Property Get read_cl37_bam_enable
        read
        read_cl37_bam_enable = read_cl37_bam_enable_value
    End Property

    Property Let write_cl37_bam_enable(aData)
        set_cl37_bam_enable = aData
        write
    End Property

    Property Get get_cl73_bam_enable
        get_cl73_bam_enable = read_cl73_bam_enable_value
    End Property

    Property Let set_cl73_bam_enable(aData)
        write_cl73_bam_enable_value = aData
        flag_cl73_bam_enable        = &H1
    End Property

    Property Get read_cl73_bam_enable
        read
        read_cl73_bam_enable = read_cl73_bam_enable_value
    End Property

    Property Let write_cl73_bam_enable(aData)
        set_cl73_bam_enable = aData
        write
    End Property

    Property Get get_cl73_hpam_enable
        get_cl73_hpam_enable = read_cl73_hpam_enable_value
    End Property

    Property Let set_cl73_hpam_enable(aData)
        write_cl73_hpam_enable_value = aData
        flag_cl73_hpam_enable        = &H1
    End Property

    Property Get read_cl73_hpam_enable
        read
        read_cl73_hpam_enable = read_cl73_hpam_enable_value
    End Property

    Property Let write_cl73_hpam_enable(aData)
        set_cl73_hpam_enable = aData
        write
    End Property

    Property Get get_cl73_enable
        get_cl73_enable = read_cl73_enable_value
    End Property

    Property Let set_cl73_enable(aData)
        write_cl73_enable_value = aData
        flag_cl73_enable        = &H1
    End Property

    Property Get read_cl73_enable
        read
        read_cl73_enable = read_cl73_enable_value
    End Property

    Property Let write_cl73_enable(aData)
        set_cl73_enable = aData
        write
    End Property

    Property Get get_cl37_sgmii_enable
        get_cl37_sgmii_enable = read_cl37_sgmii_enable_value
    End Property

    Property Let set_cl37_sgmii_enable(aData)
        write_cl37_sgmii_enable_value = aData
        flag_cl37_sgmii_enable        = &H1
    End Property

    Property Get read_cl37_sgmii_enable
        read
        read_cl37_sgmii_enable = read_cl37_sgmii_enable_value
    End Property

    Property Let write_cl37_sgmii_enable(aData)
        set_cl37_sgmii_enable = aData
        write
    End Property

    Property Get get_cl37_enable
        get_cl37_enable = read_cl37_enable_value
    End Property

    Property Let set_cl37_enable(aData)
        write_cl37_enable_value = aData
        flag_cl37_enable        = &H1
    End Property

    Property Get read_cl37_enable
        read
        read_cl37_enable = read_cl37_enable_value
    End Property

    Property Let write_cl37_enable(aData)
        set_cl37_enable = aData
        write
    End Property

    Property Get get_cl37_bam_to_sgmii_auto_enable
        get_cl37_bam_to_sgmii_auto_enable = read_cl37_bam_to_sgmii_auto_enable_value
    End Property

    Property Let set_cl37_bam_to_sgmii_auto_enable(aData)
        write_cl37_bam_to_sgmii_auto_enable_value = aData
        flag_cl37_bam_to_sgmii_auto_enable        = &H1
    End Property

    Property Get read_cl37_bam_to_sgmii_auto_enable
        read
        read_cl37_bam_to_sgmii_auto_enable = read_cl37_bam_to_sgmii_auto_enable_value
    End Property

    Property Let write_cl37_bam_to_sgmii_auto_enable(aData)
        set_cl37_bam_to_sgmii_auto_enable = aData
        write
    End Property

    Property Get get_sgmii_to_cl37_auto_enable
        get_sgmii_to_cl37_auto_enable = read_sgmii_to_cl37_auto_enable_value
    End Property

    Property Let set_sgmii_to_cl37_auto_enable(aData)
        write_sgmii_to_cl37_auto_enable_value = aData
        flag_sgmii_to_cl37_auto_enable        = &H1
    End Property

    Property Get read_sgmii_to_cl37_auto_enable
        read
        read_sgmii_to_cl37_auto_enable = read_sgmii_to_cl37_auto_enable_value
    End Property

    Property Let write_sgmii_to_cl37_auto_enable(aData)
        set_sgmii_to_cl37_auto_enable = aData
        write
    End Property

    Property Get get_cl73_bam_to_hpam_auto_enable
        get_cl73_bam_to_hpam_auto_enable = read_cl73_bam_to_hpam_auto_enable_value
    End Property

    Property Let set_cl73_bam_to_hpam_auto_enable(aData)
        write_cl73_bam_to_hpam_auto_enable_value = aData
        flag_cl73_bam_to_hpam_auto_enable        = &H1
    End Property

    Property Get read_cl73_bam_to_hpam_auto_enable
        read
        read_cl73_bam_to_hpam_auto_enable = read_cl73_bam_to_hpam_auto_enable_value
    End Property

    Property Let write_cl73_bam_to_hpam_auto_enable(aData)
        set_cl73_bam_to_hpam_auto_enable = aData
        write
    End Property

    Property Get get_hpam_to_cl73_auto_enable
        get_hpam_to_cl73_auto_enable = read_hpam_to_cl73_auto_enable_value
    End Property

    Property Let set_hpam_to_cl73_auto_enable(aData)
        write_hpam_to_cl73_auto_enable_value = aData
        flag_hpam_to_cl73_auto_enable        = &H1
    End Property

    Property Get read_hpam_to_cl73_auto_enable
        read
        read_hpam_to_cl73_auto_enable = read_hpam_to_cl73_auto_enable_value
    End Property

    Property Let write_hpam_to_cl73_auto_enable(aData)
        set_hpam_to_cl73_auto_enable = aData
        write
    End Property

    Property Get get_cl37_an_restart
        get_cl37_an_restart = read_cl37_an_restart_value
    End Property

    Property Let set_cl37_an_restart(aData)
        write_cl37_an_restart_value = aData
        flag_cl37_an_restart        = &H1
    End Property

    Property Get read_cl37_an_restart
        read
        read_cl37_an_restart = read_cl37_an_restart_value
    End Property

    Property Let write_cl37_an_restart(aData)
        set_cl37_an_restart = aData
        write
    End Property

    Property Get get_cl73_an_restart
        get_cl73_an_restart = read_cl73_an_restart_value
    End Property

    Property Let set_cl73_an_restart(aData)
        write_cl73_an_restart_value = aData
        flag_cl73_an_restart        = &H1
    End Property

    Property Get read_cl73_an_restart
        read
        read_cl73_an_restart = read_cl73_an_restart_value
    End Property

    Property Let write_cl73_an_restart(aData)
        set_cl73_an_restart = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_setup_enable_value = rightShift(data_low, 14) and &H1
        read_num_advertised_lanes_value = rightShift(data_low, 12) and &H3
        read_cl37_bam_enable_value = rightShift(data_low, 11) and &H1
        read_cl73_bam_enable_value = rightShift(data_low, 10) and &H1
        read_cl73_hpam_enable_value = rightShift(data_low, 9) and &H1
        read_cl73_enable_value = rightShift(data_low, 8) and &H1
        read_cl37_sgmii_enable_value = rightShift(data_low, 7) and &H1
        read_cl37_enable_value = rightShift(data_low, 6) and &H1
        read_cl37_bam_to_sgmii_auto_enable_value = rightShift(data_low, 5) and &H1
        read_sgmii_to_cl37_auto_enable_value = rightShift(data_low, 4) and &H1
        read_cl73_bam_to_hpam_auto_enable_value = rightShift(data_low, 3) and &H1
        read_hpam_to_cl73_auto_enable_value = rightShift(data_low, 2) and &H1
        read_cl37_an_restart_value = rightShift(data_low, 1) and &H1
        cl73_an_restart_mask = &H1
        if data_low > LONG_MAX then
            if cl73_an_restart_mask = mask then
                read_cl73_an_restart_value = data_low
            else
                read_cl73_an_restart_value = (data_low - H8000_0000) and cl73_an_restart_mask
            end If
        else
            read_cl73_an_restart_value = data_low and cl73_an_restart_mask
        end If

    End Sub

    Sub write
        If flag_an_setup_enable = &H0 or flag_num_advertised_lanes = &H0 or flag_cl37_bam_enable = &H0 or flag_cl73_bam_enable = &H0 or flag_cl73_hpam_enable = &H0 or flag_cl73_enable = &H0 or flag_cl37_sgmii_enable = &H0 or flag_cl37_enable = &H0 or flag_cl37_bam_to_sgmii_auto_enable = &H0 or flag_sgmii_to_cl37_auto_enable = &H0 or flag_cl73_bam_to_hpam_auto_enable = &H0 or flag_hpam_to_cl73_auto_enable = &H0 or flag_cl37_an_restart = &H0 or flag_cl73_an_restart = &H0 Then read
        If flag_an_setup_enable = &H0 Then write_an_setup_enable_value = get_an_setup_enable
        If flag_num_advertised_lanes = &H0 Then write_num_advertised_lanes_value = get_num_advertised_lanes
        If flag_cl37_bam_enable = &H0 Then write_cl37_bam_enable_value = get_cl37_bam_enable
        If flag_cl73_bam_enable = &H0 Then write_cl73_bam_enable_value = get_cl73_bam_enable
        If flag_cl73_hpam_enable = &H0 Then write_cl73_hpam_enable_value = get_cl73_hpam_enable
        If flag_cl73_enable = &H0 Then write_cl73_enable_value = get_cl73_enable
        If flag_cl37_sgmii_enable = &H0 Then write_cl37_sgmii_enable_value = get_cl37_sgmii_enable
        If flag_cl37_enable = &H0 Then write_cl37_enable_value = get_cl37_enable
        If flag_cl37_bam_to_sgmii_auto_enable = &H0 Then write_cl37_bam_to_sgmii_auto_enable_value = get_cl37_bam_to_sgmii_auto_enable
        If flag_sgmii_to_cl37_auto_enable = &H0 Then write_sgmii_to_cl37_auto_enable_value = get_sgmii_to_cl37_auto_enable
        If flag_cl73_bam_to_hpam_auto_enable = &H0 Then write_cl73_bam_to_hpam_auto_enable_value = get_cl73_bam_to_hpam_auto_enable
        If flag_hpam_to_cl73_auto_enable = &H0 Then write_hpam_to_cl73_auto_enable_value = get_hpam_to_cl73_auto_enable
        If flag_cl37_an_restart = &H0 Then write_cl37_an_restart_value = get_cl37_an_restart
        If flag_cl73_an_restart = &H0 Then write_cl73_an_restart_value = get_cl73_an_restart

        regValue = leftShift((write_an_setup_enable_value and &H1), 14) + leftShift((write_num_advertised_lanes_value and &H3), 12) + leftShift((write_cl37_bam_enable_value and &H1), 11) + leftShift((write_cl73_bam_enable_value and &H1), 10) + leftShift((write_cl73_hpam_enable_value and &H1), 9) + leftShift((write_cl73_enable_value and &H1), 8) + leftShift((write_cl37_sgmii_enable_value and &H1), 7) + leftShift((write_cl37_enable_value and &H1), 6) + leftShift((write_cl37_bam_to_sgmii_auto_enable_value and &H1), 5) + leftShift((write_sgmii_to_cl37_auto_enable_value and &H1), 4) + leftShift((write_cl73_bam_to_hpam_auto_enable_value and &H1), 3) + leftShift((write_hpam_to_cl73_auto_enable_value and &H1), 2) + leftShift((write_cl37_an_restart_value and &H1), 1) + leftShift((write_cl73_an_restart_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_setup_enable_value = rightShift(data_low, 14) and &H1
        read_num_advertised_lanes_value = rightShift(data_low, 12) and &H3
        read_cl37_bam_enable_value = rightShift(data_low, 11) and &H1
        read_cl73_bam_enable_value = rightShift(data_low, 10) and &H1
        read_cl73_hpam_enable_value = rightShift(data_low, 9) and &H1
        read_cl73_enable_value = rightShift(data_low, 8) and &H1
        read_cl37_sgmii_enable_value = rightShift(data_low, 7) and &H1
        read_cl37_enable_value = rightShift(data_low, 6) and &H1
        read_cl37_bam_to_sgmii_auto_enable_value = rightShift(data_low, 5) and &H1
        read_sgmii_to_cl37_auto_enable_value = rightShift(data_low, 4) and &H1
        read_cl73_bam_to_hpam_auto_enable_value = rightShift(data_low, 3) and &H1
        read_hpam_to_cl73_auto_enable_value = rightShift(data_low, 2) and &H1
        read_cl37_an_restart_value = rightShift(data_low, 1) and &H1
        cl73_an_restart_mask = &H1
        if data_low > LONG_MAX then
            if cl73_an_restart_mask = mask then
                read_cl73_an_restart_value = data_low
            else
                read_cl73_an_restart_value = (data_low - H8000_0000) and cl73_an_restart_mask
            end If
        else
            read_cl73_an_restart_value = data_low and cl73_an_restart_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_setup_enable_value = &H0
        flag_an_setup_enable        = &H0
        write_num_advertised_lanes_value = &H0
        flag_num_advertised_lanes        = &H0
        write_cl37_bam_enable_value = &H0
        flag_cl37_bam_enable        = &H0
        write_cl73_bam_enable_value = &H0
        flag_cl73_bam_enable        = &H0
        write_cl73_hpam_enable_value = &H0
        flag_cl73_hpam_enable        = &H0
        write_cl73_enable_value = &H0
        flag_cl73_enable        = &H0
        write_cl37_sgmii_enable_value = &H0
        flag_cl37_sgmii_enable        = &H0
        write_cl37_enable_value = &H0
        flag_cl37_enable        = &H0
        write_cl37_bam_to_sgmii_auto_enable_value = &H0
        flag_cl37_bam_to_sgmii_auto_enable        = &H0
        write_sgmii_to_cl37_auto_enable_value = &H0
        flag_sgmii_to_cl37_auto_enable        = &H0
        write_cl73_bam_to_hpam_auto_enable_value = &H0
        flag_cl73_bam_to_hpam_auto_enable        = &H0
        write_hpam_to_cl73_auto_enable_value = &H0
        flag_hpam_to_cl73_auto_enable        = &H0
        write_cl37_an_restart_value = &H0
        flag_cl37_an_restart        = &H0
        write_cl73_an_restart_value = &H0
        flag_cl73_an_restart        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl37_base_abilities_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_master_mode                          [9:9]            get_sgmii_master_mode
''                                                             set_sgmii_master_mode
''                                                             read_sgmii_master_mode
''                                                             write_sgmii_master_mode
''---------------------------------------------------------------------------------
'' cl37_next_page                             [8:8]            get_cl37_next_page
''                                                             set_cl37_next_page
''                                                             read_cl37_next_page
''                                                             write_cl37_next_page
''---------------------------------------------------------------------------------
'' cl37_pause                                 [7:6]            get_cl37_pause
''                                                             set_cl37_pause
''                                                             read_cl37_pause
''                                                             write_cl37_pause
''---------------------------------------------------------------------------------
'' cl37_half_duplex                           [5:5]            get_cl37_half_duplex
''                                                             set_cl37_half_duplex
''                                                             read_cl37_half_duplex
''                                                             write_cl37_half_duplex
''---------------------------------------------------------------------------------
'' cl37_full_duplex                           [4:4]            get_cl37_full_duplex
''                                                             set_cl37_full_duplex
''                                                             read_cl37_full_duplex
''                                                             write_cl37_full_duplex
''---------------------------------------------------------------------------------
'' sgmii_full_duplex                          [2:2]            get_sgmii_full_duplex
''                                                             set_sgmii_full_duplex
''                                                             read_sgmii_full_duplex
''                                                             write_sgmii_full_duplex
''---------------------------------------------------------------------------------
'' sgmii_speed                                [1:0]            get_sgmii_speed
''                                                             set_sgmii_speed
''                                                             read_sgmii_speed
''                                                             write_sgmii_speed
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl37_base_abilities_sgmiiplusr_x1
    Private write_sgmii_master_mode_value
    Private read_sgmii_master_mode_value
    Private flag_sgmii_master_mode
    Private write_cl37_next_page_value
    Private read_cl37_next_page_value
    Private flag_cl37_next_page
    Private write_cl37_pause_value
    Private read_cl37_pause_value
    Private flag_cl37_pause
    Private write_cl37_half_duplex_value
    Private read_cl37_half_duplex_value
    Private flag_cl37_half_duplex
    Private write_cl37_full_duplex_value
    Private read_cl37_full_duplex_value
    Private flag_cl37_full_duplex
    Private write_sgmii_full_duplex_value
    Private read_sgmii_full_duplex_value
    Private flag_sgmii_full_duplex
    Private write_sgmii_speed_value
    Private read_sgmii_speed_value
    Private flag_sgmii_speed

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

    Property Get get_cl37_next_page
        get_cl37_next_page = read_cl37_next_page_value
    End Property

    Property Let set_cl37_next_page(aData)
        write_cl37_next_page_value = aData
        flag_cl37_next_page        = &H1
    End Property

    Property Get read_cl37_next_page
        read
        read_cl37_next_page = read_cl37_next_page_value
    End Property

    Property Let write_cl37_next_page(aData)
        set_cl37_next_page = aData
        write
    End Property

    Property Get get_cl37_pause
        get_cl37_pause = read_cl37_pause_value
    End Property

    Property Let set_cl37_pause(aData)
        write_cl37_pause_value = aData
        flag_cl37_pause        = &H1
    End Property

    Property Get read_cl37_pause
        read
        read_cl37_pause = read_cl37_pause_value
    End Property

    Property Let write_cl37_pause(aData)
        set_cl37_pause = aData
        write
    End Property

    Property Get get_cl37_half_duplex
        get_cl37_half_duplex = read_cl37_half_duplex_value
    End Property

    Property Let set_cl37_half_duplex(aData)
        write_cl37_half_duplex_value = aData
        flag_cl37_half_duplex        = &H1
    End Property

    Property Get read_cl37_half_duplex
        read
        read_cl37_half_duplex = read_cl37_half_duplex_value
    End Property

    Property Let write_cl37_half_duplex(aData)
        set_cl37_half_duplex = aData
        write
    End Property

    Property Get get_cl37_full_duplex
        get_cl37_full_duplex = read_cl37_full_duplex_value
    End Property

    Property Let set_cl37_full_duplex(aData)
        write_cl37_full_duplex_value = aData
        flag_cl37_full_duplex        = &H1
    End Property

    Property Get read_cl37_full_duplex
        read
        read_cl37_full_duplex = read_cl37_full_duplex_value
    End Property

    Property Let write_cl37_full_duplex(aData)
        set_cl37_full_duplex = aData
        write
    End Property

    Property Get get_sgmii_full_duplex
        get_sgmii_full_duplex = read_sgmii_full_duplex_value
    End Property

    Property Let set_sgmii_full_duplex(aData)
        write_sgmii_full_duplex_value = aData
        flag_sgmii_full_duplex        = &H1
    End Property

    Property Get read_sgmii_full_duplex
        read
        read_sgmii_full_duplex = read_sgmii_full_duplex_value
    End Property

    Property Let write_sgmii_full_duplex(aData)
        set_sgmii_full_duplex = aData
        write
    End Property

    Property Get get_sgmii_speed
        get_sgmii_speed = read_sgmii_speed_value
    End Property

    Property Let set_sgmii_speed(aData)
        write_sgmii_speed_value = aData
        flag_sgmii_speed        = &H1
    End Property

    Property Get read_sgmii_speed
        read
        read_sgmii_speed = read_sgmii_speed_value
    End Property

    Property Let write_sgmii_speed(aData)
        set_sgmii_speed = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_master_mode_value = rightShift(data_low, 9) and &H1
        read_cl37_next_page_value = rightShift(data_low, 8) and &H1
        read_cl37_pause_value = rightShift(data_low, 6) and &H3
        read_cl37_half_duplex_value = rightShift(data_low, 5) and &H1
        read_cl37_full_duplex_value = rightShift(data_low, 4) and &H1
        read_sgmii_full_duplex_value = rightShift(data_low, 2) and &H1
        sgmii_speed_mask = &H3
        if data_low > LONG_MAX then
            if sgmii_speed_mask = mask then
                read_sgmii_speed_value = data_low
            else
                read_sgmii_speed_value = (data_low - H8000_0000) and sgmii_speed_mask
            end If
        else
            read_sgmii_speed_value = data_low and sgmii_speed_mask
        end If

    End Sub

    Sub write
        If flag_sgmii_master_mode = &H0 or flag_cl37_next_page = &H0 or flag_cl37_pause = &H0 or flag_cl37_half_duplex = &H0 or flag_cl37_full_duplex = &H0 or flag_sgmii_full_duplex = &H0 or flag_sgmii_speed = &H0 Then read
        If flag_sgmii_master_mode = &H0 Then write_sgmii_master_mode_value = get_sgmii_master_mode
        If flag_cl37_next_page = &H0 Then write_cl37_next_page_value = get_cl37_next_page
        If flag_cl37_pause = &H0 Then write_cl37_pause_value = get_cl37_pause
        If flag_cl37_half_duplex = &H0 Then write_cl37_half_duplex_value = get_cl37_half_duplex
        If flag_cl37_full_duplex = &H0 Then write_cl37_full_duplex_value = get_cl37_full_duplex
        If flag_sgmii_full_duplex = &H0 Then write_sgmii_full_duplex_value = get_sgmii_full_duplex
        If flag_sgmii_speed = &H0 Then write_sgmii_speed_value = get_sgmii_speed

        regValue = leftShift((write_sgmii_master_mode_value and &H1), 9) + leftShift((write_cl37_next_page_value and &H1), 8) + leftShift((write_cl37_pause_value and &H3), 6) + leftShift((write_cl37_half_duplex_value and &H1), 5) + leftShift((write_cl37_full_duplex_value and &H1), 4) + leftShift((write_sgmii_full_duplex_value and &H1), 2) + leftShift((write_sgmii_speed_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_master_mode_value = rightShift(data_low, 9) and &H1
        read_cl37_next_page_value = rightShift(data_low, 8) and &H1
        read_cl37_pause_value = rightShift(data_low, 6) and &H3
        read_cl37_half_duplex_value = rightShift(data_low, 5) and &H1
        read_cl37_full_duplex_value = rightShift(data_low, 4) and &H1
        read_sgmii_full_duplex_value = rightShift(data_low, 2) and &H1
        sgmii_speed_mask = &H3
        if data_low > LONG_MAX then
            if sgmii_speed_mask = mask then
                read_sgmii_speed_value = data_low
            else
                read_sgmii_speed_value = (data_low - H8000_0000) and sgmii_speed_mask
            end If
        else
            read_sgmii_speed_value = data_low and sgmii_speed_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_master_mode_value = &H0
        flag_sgmii_master_mode        = &H0
        write_cl37_next_page_value = &H0
        flag_cl37_next_page        = &H0
        write_cl37_pause_value = &H0
        flag_cl37_pause        = &H0
        write_cl37_half_duplex_value = &H0
        flag_cl37_half_duplex        = &H0
        write_cl37_full_duplex_value = &H0
        flag_cl37_full_duplex        = &H0
        write_sgmii_full_duplex_value = &H0
        flag_sgmii_full_duplex        = &H0
        write_sgmii_speed_value = &H0
        flag_sgmii_speed        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl37_bam_abilities_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl37_bam_code                              [11:3]           get_cl37_bam_code
''                                                             set_cl37_bam_code
''                                                             read_cl37_bam_code
''                                                             write_cl37_bam_code
''---------------------------------------------------------------------------------
'' over1g_ability                             [2:2]            get_over1g_ability
''                                                             set_over1g_ability
''                                                             read_over1g_ability
''                                                             write_over1g_ability
''---------------------------------------------------------------------------------
'' over1g_page_count                          [1:0]            get_over1g_page_count
''                                                             set_over1g_page_count
''                                                             read_over1g_page_count
''                                                             write_over1g_page_count
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl37_bam_abilities_sgmiiplusr_x1
    Private write_cl37_bam_code_value
    Private read_cl37_bam_code_value
    Private flag_cl37_bam_code
    Private write_over1g_ability_value
    Private read_over1g_ability_value
    Private flag_over1g_ability
    Private write_over1g_page_count_value
    Private read_over1g_page_count_value
    Private flag_over1g_page_count

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

    Property Get get_cl37_bam_code
        get_cl37_bam_code = read_cl37_bam_code_value
    End Property

    Property Let set_cl37_bam_code(aData)
        write_cl37_bam_code_value = aData
        flag_cl37_bam_code        = &H1
    End Property

    Property Get read_cl37_bam_code
        read
        read_cl37_bam_code = read_cl37_bam_code_value
    End Property

    Property Let write_cl37_bam_code(aData)
        set_cl37_bam_code = aData
        write
    End Property

    Property Get get_over1g_ability
        get_over1g_ability = read_over1g_ability_value
    End Property

    Property Let set_over1g_ability(aData)
        write_over1g_ability_value = aData
        flag_over1g_ability        = &H1
    End Property

    Property Get read_over1g_ability
        read
        read_over1g_ability = read_over1g_ability_value
    End Property

    Property Let write_over1g_ability(aData)
        set_over1g_ability = aData
        write
    End Property

    Property Get get_over1g_page_count
        get_over1g_page_count = read_over1g_page_count_value
    End Property

    Property Let set_over1g_page_count(aData)
        write_over1g_page_count_value = aData
        flag_over1g_page_count        = &H1
    End Property

    Property Get read_over1g_page_count
        read
        read_over1g_page_count = read_over1g_page_count_value
    End Property

    Property Let write_over1g_page_count(aData)
        set_over1g_page_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl37_bam_code_value = rightShift(data_low, 3) and &H1ff
        read_over1g_ability_value = rightShift(data_low, 2) and &H1
        over1g_page_count_mask = &H3
        if data_low > LONG_MAX then
            if over1g_page_count_mask = mask then
                read_over1g_page_count_value = data_low
            else
                read_over1g_page_count_value = (data_low - H8000_0000) and over1g_page_count_mask
            end If
        else
            read_over1g_page_count_value = data_low and over1g_page_count_mask
        end If

    End Sub

    Sub write
        If flag_cl37_bam_code = &H0 or flag_over1g_ability = &H0 or flag_over1g_page_count = &H0 Then read
        If flag_cl37_bam_code = &H0 Then write_cl37_bam_code_value = get_cl37_bam_code
        If flag_over1g_ability = &H0 Then write_over1g_ability_value = get_over1g_ability
        If flag_over1g_page_count = &H0 Then write_over1g_page_count_value = get_over1g_page_count

        regValue = leftShift((write_cl37_bam_code_value and &H1ff), 3) + leftShift((write_over1g_ability_value and &H1), 2) + leftShift((write_over1g_page_count_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl37_bam_code_value = rightShift(data_low, 3) and &H1ff
        read_over1g_ability_value = rightShift(data_low, 2) and &H1
        over1g_page_count_mask = &H3
        if data_low > LONG_MAX then
            if over1g_page_count_mask = mask then
                read_over1g_page_count_value = data_low
            else
                read_over1g_page_count_value = (data_low - H8000_0000) and over1g_page_count_mask
            end If
        else
            read_over1g_page_count_value = data_low and over1g_page_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl37_bam_code_value = &H0
        flag_cl37_bam_code        = &H0
        write_over1g_ability_value = &H0
        flag_over1g_ability        = &H0
        write_over1g_page_count_value = &H0
        flag_over1g_page_count        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_over1g_abilities_1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HG2                                        [15:15]          get_HG2
''                                                             set_HG2
''                                                             read_HG2
''                                                             write_HG2
''---------------------------------------------------------------------------------
'' FEC                                        [14:14]          get_FEC
''                                                             set_FEC
''                                                             read_FEC
''                                                             write_FEC
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_over1g_abilities_1_sgmiiplusr_x1
    Private write_HG2_value
    Private read_HG2_value
    Private flag_HG2
    Private write_FEC_value
    Private read_FEC_value
    Private flag_FEC

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

    Property Get get_HG2
        get_HG2 = read_HG2_value
    End Property

    Property Let set_HG2(aData)
        write_HG2_value = aData
        flag_HG2        = &H1
    End Property

    Property Get read_HG2
        read
        read_HG2 = read_HG2_value
    End Property

    Property Let write_HG2(aData)
        set_HG2 = aData
        write
    End Property

    Property Get get_FEC
        get_FEC = read_FEC_value
    End Property

    Property Let set_FEC(aData)
        write_FEC_value = aData
        flag_FEC        = &H1
    End Property

    Property Get read_FEC
        read
        read_FEC = read_FEC_value
    End Property

    Property Let write_FEC(aData)
        set_FEC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HG2_value = rightShift(data_low, 15) and &H1
        read_FEC_value = rightShift(data_low, 14) and &H1

    End Sub

    Sub write
        If flag_HG2 = &H0 or flag_FEC = &H0 Then read
        If flag_HG2 = &H0 Then write_HG2_value = get_HG2
        If flag_FEC = &H0 Then write_FEC_value = get_FEC

        regValue = leftShift((write_HG2_value and &H1), 15) + leftShift((write_FEC_value and &H1), 14)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HG2_value = rightShift(data_low, 15) and &H1
        read_FEC_value = rightShift(data_low, 14) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HG2_value = &H0
        flag_HG2        = &H0
        write_FEC_value = &H0
        flag_FEC        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_over1g_abilities_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BAM_2p5GBASE_X                             [0:0]            get_BAM_2p5GBASE_X
''                                                             set_BAM_2p5GBASE_X
''                                                             read_BAM_2p5GBASE_X
''                                                             write_BAM_2p5GBASE_X
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_over1g_abilities_0_sgmiiplusr_x1
    Private write_BAM_2p5GBASE_X_value
    Private read_BAM_2p5GBASE_X_value
    Private flag_BAM_2p5GBASE_X

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

    Property Get get_BAM_2p5GBASE_X
        get_BAM_2p5GBASE_X = read_BAM_2p5GBASE_X_value
    End Property

    Property Let set_BAM_2p5GBASE_X(aData)
        write_BAM_2p5GBASE_X_value = aData
        flag_BAM_2p5GBASE_X        = &H1
    End Property

    Property Get read_BAM_2p5GBASE_X
        read
        read_BAM_2p5GBASE_X = read_BAM_2p5GBASE_X_value
    End Property

    Property Let write_BAM_2p5GBASE_X(aData)
        set_BAM_2p5GBASE_X = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BAM_2p5GBASE_X_mask = &H1
        if data_low > LONG_MAX then
            if BAM_2p5GBASE_X_mask = mask then
                read_BAM_2p5GBASE_X_value = data_low
            else
                read_BAM_2p5GBASE_X_value = (data_low - H8000_0000) and BAM_2p5GBASE_X_mask
            end If
        else
            read_BAM_2p5GBASE_X_value = data_low and BAM_2p5GBASE_X_mask
        end If

    End Sub

    Sub write
        If flag_BAM_2p5GBASE_X = &H0 Then read
        If flag_BAM_2p5GBASE_X = &H0 Then write_BAM_2p5GBASE_X_value = get_BAM_2p5GBASE_X

        regValue = leftShift((write_BAM_2p5GBASE_X_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BAM_2p5GBASE_X_mask = &H1
        if data_low > LONG_MAX then
            if BAM_2p5GBASE_X_mask = mask then
                read_BAM_2p5GBASE_X_value = data_low
            else
                read_BAM_2p5GBASE_X_value = (data_low - H8000_0000) and BAM_2p5GBASE_X_mask
            end If
        else
            read_BAM_2p5GBASE_X_value = data_low and BAM_2p5GBASE_X_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BAM_2p5GBASE_X_value = &H0
        flag_BAM_2p5GBASE_X        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_base_abilities_1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl73_nonce_match_over                      [11:11]          get_cl73_nonce_match_over
''                                                             set_cl73_nonce_match_over
''                                                             read_cl73_nonce_match_over
''                                                             write_cl73_nonce_match_over
''---------------------------------------------------------------------------------
'' cl73_nonce_match_val                       [10:10]          get_cl73_nonce_match_val
''                                                             set_cl73_nonce_match_val
''                                                             read_cl73_nonce_match_val
''                                                             write_cl73_nonce_match_val
''---------------------------------------------------------------------------------
'' transmit_nonce                             [9:5]            get_transmit_nonce
''                                                             set_transmit_nonce
''                                                             read_transmit_nonce
''                                                             write_transmit_nonce
''---------------------------------------------------------------------------------
'' base_selector                              [4:0]            get_base_selector
''                                                             set_base_selector
''                                                             read_base_selector
''                                                             write_base_selector
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_base_abilities_1_sgmiiplusr_x1
    Private write_cl73_nonce_match_over_value
    Private read_cl73_nonce_match_over_value
    Private flag_cl73_nonce_match_over
    Private write_cl73_nonce_match_val_value
    Private read_cl73_nonce_match_val_value
    Private flag_cl73_nonce_match_val
    Private write_transmit_nonce_value
    Private read_transmit_nonce_value
    Private flag_transmit_nonce
    Private write_base_selector_value
    Private read_base_selector_value
    Private flag_base_selector

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

    Property Get get_cl73_nonce_match_over
        get_cl73_nonce_match_over = read_cl73_nonce_match_over_value
    End Property

    Property Let set_cl73_nonce_match_over(aData)
        write_cl73_nonce_match_over_value = aData
        flag_cl73_nonce_match_over        = &H1
    End Property

    Property Get read_cl73_nonce_match_over
        read
        read_cl73_nonce_match_over = read_cl73_nonce_match_over_value
    End Property

    Property Let write_cl73_nonce_match_over(aData)
        set_cl73_nonce_match_over = aData
        write
    End Property

    Property Get get_cl73_nonce_match_val
        get_cl73_nonce_match_val = read_cl73_nonce_match_val_value
    End Property

    Property Let set_cl73_nonce_match_val(aData)
        write_cl73_nonce_match_val_value = aData
        flag_cl73_nonce_match_val        = &H1
    End Property

    Property Get read_cl73_nonce_match_val
        read
        read_cl73_nonce_match_val = read_cl73_nonce_match_val_value
    End Property

    Property Let write_cl73_nonce_match_val(aData)
        set_cl73_nonce_match_val = aData
        write
    End Property

    Property Get get_transmit_nonce
        get_transmit_nonce = read_transmit_nonce_value
    End Property

    Property Let set_transmit_nonce(aData)
        write_transmit_nonce_value = aData
        flag_transmit_nonce        = &H1
    End Property

    Property Get read_transmit_nonce
        read
        read_transmit_nonce = read_transmit_nonce_value
    End Property

    Property Let write_transmit_nonce(aData)
        set_transmit_nonce = aData
        write
    End Property

    Property Get get_base_selector
        get_base_selector = read_base_selector_value
    End Property

    Property Let set_base_selector(aData)
        write_base_selector_value = aData
        flag_base_selector        = &H1
    End Property

    Property Get read_base_selector
        read
        read_base_selector = read_base_selector_value
    End Property

    Property Let write_base_selector(aData)
        set_base_selector = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_nonce_match_over_value = rightShift(data_low, 11) and &H1
        read_cl73_nonce_match_val_value = rightShift(data_low, 10) and &H1
        read_transmit_nonce_value = rightShift(data_low, 5) and &H1f
        base_selector_mask = &H1f
        if data_low > LONG_MAX then
            if base_selector_mask = mask then
                read_base_selector_value = data_low
            else
                read_base_selector_value = (data_low - H8000_0000) and base_selector_mask
            end If
        else
            read_base_selector_value = data_low and base_selector_mask
        end If

    End Sub

    Sub write
        If flag_cl73_nonce_match_over = &H0 or flag_cl73_nonce_match_val = &H0 or flag_transmit_nonce = &H0 or flag_base_selector = &H0 Then read
        If flag_cl73_nonce_match_over = &H0 Then write_cl73_nonce_match_over_value = get_cl73_nonce_match_over
        If flag_cl73_nonce_match_val = &H0 Then write_cl73_nonce_match_val_value = get_cl73_nonce_match_val
        If flag_transmit_nonce = &H0 Then write_transmit_nonce_value = get_transmit_nonce
        If flag_base_selector = &H0 Then write_base_selector_value = get_base_selector

        regValue = leftShift((write_cl73_nonce_match_over_value and &H1), 11) + leftShift((write_cl73_nonce_match_val_value and &H1), 10) + leftShift((write_transmit_nonce_value and &H1f), 5) + leftShift((write_base_selector_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_nonce_match_over_value = rightShift(data_low, 11) and &H1
        read_cl73_nonce_match_val_value = rightShift(data_low, 10) and &H1
        read_transmit_nonce_value = rightShift(data_low, 5) and &H1f
        base_selector_mask = &H1f
        if data_low > LONG_MAX then
            if base_selector_mask = mask then
                read_base_selector_value = data_low
            else
                read_base_selector_value = (data_low - H8000_0000) and base_selector_mask
            end If
        else
            read_base_selector_value = data_low and base_selector_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl73_nonce_match_over_value = &H0
        flag_cl73_nonce_match_over        = &H0
        write_cl73_nonce_match_val_value = &H0
        flag_cl73_nonce_match_val        = &H0
        write_transmit_nonce_value = &H0
        flag_transmit_nonce        = &H0
        write_base_selector_value = &H0
        flag_base_selector        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_base_abilities_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl73_remote_fault                          [11:11]          get_cl73_remote_fault
''                                                             set_cl73_remote_fault
''                                                             read_cl73_remote_fault
''                                                             write_cl73_remote_fault
''---------------------------------------------------------------------------------
'' next_page                                  [10:10]          get_next_page
''                                                             set_next_page
''                                                             read_next_page
''                                                             write_next_page
''---------------------------------------------------------------------------------
'' fec                                        [9:8]            get_fec
''                                                             set_fec
''                                                             read_fec
''                                                             write_fec
''---------------------------------------------------------------------------------
'' cl73_pause                                 [7:6]            get_cl73_pause
''                                                             set_cl73_pause
''                                                             read_cl73_pause
''                                                             write_cl73_pause
''---------------------------------------------------------------------------------
'' BASE_1000BASE_KX                           [5:5]            get_BASE_1000BASE_KX
''                                                             set_BASE_1000BASE_KX
''                                                             read_BASE_1000BASE_KX
''                                                             write_BASE_1000BASE_KX
''---------------------------------------------------------------------------------
'' BASE_10GBASE_KR                            [3:3]            get_BASE_10GBASE_KR
''                                                             set_BASE_10GBASE_KR
''                                                             read_BASE_10GBASE_KR
''                                                             write_BASE_10GBASE_KR
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_base_abilities_0_sgmiiplusr_x1
    Private write_cl73_remote_fault_value
    Private read_cl73_remote_fault_value
    Private flag_cl73_remote_fault
    Private write_next_page_value
    Private read_next_page_value
    Private flag_next_page
    Private write_fec_value
    Private read_fec_value
    Private flag_fec
    Private write_cl73_pause_value
    Private read_cl73_pause_value
    Private flag_cl73_pause
    Private write_BASE_1000BASE_KX_value
    Private read_BASE_1000BASE_KX_value
    Private flag_BASE_1000BASE_KX
    Private write_BASE_10GBASE_KR_value
    Private read_BASE_10GBASE_KR_value
    Private flag_BASE_10GBASE_KR

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

    Property Get get_cl73_remote_fault
        get_cl73_remote_fault = read_cl73_remote_fault_value
    End Property

    Property Let set_cl73_remote_fault(aData)
        write_cl73_remote_fault_value = aData
        flag_cl73_remote_fault        = &H1
    End Property

    Property Get read_cl73_remote_fault
        read
        read_cl73_remote_fault = read_cl73_remote_fault_value
    End Property

    Property Let write_cl73_remote_fault(aData)
        set_cl73_remote_fault = aData
        write
    End Property

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

    Property Get get_fec
        get_fec = read_fec_value
    End Property

    Property Let set_fec(aData)
        write_fec_value = aData
        flag_fec        = &H1
    End Property

    Property Get read_fec
        read
        read_fec = read_fec_value
    End Property

    Property Let write_fec(aData)
        set_fec = aData
        write
    End Property

    Property Get get_cl73_pause
        get_cl73_pause = read_cl73_pause_value
    End Property

    Property Let set_cl73_pause(aData)
        write_cl73_pause_value = aData
        flag_cl73_pause        = &H1
    End Property

    Property Get read_cl73_pause
        read
        read_cl73_pause = read_cl73_pause_value
    End Property

    Property Let write_cl73_pause(aData)
        set_cl73_pause = aData
        write
    End Property

    Property Get get_BASE_1000BASE_KX
        get_BASE_1000BASE_KX = read_BASE_1000BASE_KX_value
    End Property

    Property Let set_BASE_1000BASE_KX(aData)
        write_BASE_1000BASE_KX_value = aData
        flag_BASE_1000BASE_KX        = &H1
    End Property

    Property Get read_BASE_1000BASE_KX
        read
        read_BASE_1000BASE_KX = read_BASE_1000BASE_KX_value
    End Property

    Property Let write_BASE_1000BASE_KX(aData)
        set_BASE_1000BASE_KX = aData
        write
    End Property

    Property Get get_BASE_10GBASE_KR
        get_BASE_10GBASE_KR = read_BASE_10GBASE_KR_value
    End Property

    Property Let set_BASE_10GBASE_KR(aData)
        write_BASE_10GBASE_KR_value = aData
        flag_BASE_10GBASE_KR        = &H1
    End Property

    Property Get read_BASE_10GBASE_KR
        read
        read_BASE_10GBASE_KR = read_BASE_10GBASE_KR_value
    End Property

    Property Let write_BASE_10GBASE_KR(aData)
        set_BASE_10GBASE_KR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_remote_fault_value = rightShift(data_low, 11) and &H1
        read_next_page_value = rightShift(data_low, 10) and &H1
        read_fec_value = rightShift(data_low, 8) and &H3
        read_cl73_pause_value = rightShift(data_low, 6) and &H3
        read_BASE_1000BASE_KX_value = rightShift(data_low, 5) and &H1
        read_BASE_10GBASE_KR_value = rightShift(data_low, 3) and &H1

    End Sub

    Sub write
        If flag_cl73_remote_fault = &H0 or flag_next_page = &H0 or flag_fec = &H0 or flag_cl73_pause = &H0 or flag_BASE_1000BASE_KX = &H0 or flag_BASE_10GBASE_KR = &H0 Then read
        If flag_cl73_remote_fault = &H0 Then write_cl73_remote_fault_value = get_cl73_remote_fault
        If flag_next_page = &H0 Then write_next_page_value = get_next_page
        If flag_fec = &H0 Then write_fec_value = get_fec
        If flag_cl73_pause = &H0 Then write_cl73_pause_value = get_cl73_pause
        If flag_BASE_1000BASE_KX = &H0 Then write_BASE_1000BASE_KX_value = get_BASE_1000BASE_KX
        If flag_BASE_10GBASE_KR = &H0 Then write_BASE_10GBASE_KR_value = get_BASE_10GBASE_KR

        regValue = leftShift((write_cl73_remote_fault_value and &H1), 11) + leftShift((write_next_page_value and &H1), 10) + leftShift((write_fec_value and &H3), 8) + leftShift((write_cl73_pause_value and &H3), 6) + leftShift((write_BASE_1000BASE_KX_value and &H1), 5) + leftShift((write_BASE_10GBASE_KR_value and &H1), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_remote_fault_value = rightShift(data_low, 11) and &H1
        read_next_page_value = rightShift(data_low, 10) and &H1
        read_fec_value = rightShift(data_low, 8) and &H3
        read_cl73_pause_value = rightShift(data_low, 6) and &H3
        read_BASE_1000BASE_KX_value = rightShift(data_low, 5) and &H1
        read_BASE_10GBASE_KR_value = rightShift(data_low, 3) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl73_remote_fault_value = &H0
        flag_cl73_remote_fault        = &H0
        write_next_page_value = &H0
        flag_next_page        = &H0
        write_fec_value = &H0
        flag_fec        = &H0
        write_cl73_pause_value = &H0
        flag_cl73_pause        = &H0
        write_BASE_1000BASE_KX_value = &H0
        flag_BASE_1000BASE_KX        = &H0
        write_BASE_10GBASE_KR_value = &H0
        flag_BASE_10GBASE_KR        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_bam_abilities_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cl73_bam_code                              [10:2]           get_cl73_bam_code
''                                                             set_cl73_bam_code
''                                                             read_cl73_bam_code
''                                                             write_cl73_bam_code
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_bam_abilities_sgmiiplusr_x1
    Private write_cl73_bam_code_value
    Private read_cl73_bam_code_value
    Private flag_cl73_bam_code

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

    Property Get get_cl73_bam_code
        get_cl73_bam_code = read_cl73_bam_code_value
    End Property

    Property Let set_cl73_bam_code(aData)
        write_cl73_bam_code_value = aData
        flag_cl73_bam_code        = &H1
    End Property

    Property Get read_cl73_bam_code
        read
        read_cl73_bam_code = read_cl73_bam_code_value
    End Property

    Property Let write_cl73_bam_code(aData)
        set_cl73_bam_code = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_bam_code_value = rightShift(data_low, 2) and &H1ff

    End Sub

    Sub write
        If flag_cl73_bam_code = &H0 Then read
        If flag_cl73_bam_code = &H0 Then write_cl73_bam_code_value = get_cl73_bam_code

        regValue = leftShift((write_cl73_bam_code_value and &H1ff), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cl73_bam_code_value = rightShift(data_low, 2) and &H1ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cl73_bam_code_value = &H0
        flag_cl73_bam_code        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_controls_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OUI_CONTROL                                [15:10]          get_OUI_CONTROL
''                                                             set_OUI_CONTROL
''                                                             read_OUI_CONTROL
''                                                             write_OUI_CONTROL
''---------------------------------------------------------------------------------
'' an_fail_count_limit                        [9:6]            get_an_fail_count_limit
''                                                             set_an_fail_count_limit
''                                                             read_an_fail_count_limit
''                                                             write_an_fail_count_limit
''---------------------------------------------------------------------------------
'' linkFailTimerQual_en                       [5:5]            get_linkFailTimerQual_en
''                                                             set_linkFailTimerQual_en
''                                                             read_linkFailTimerQual_en
''                                                             write_linkFailTimerQual_en
''---------------------------------------------------------------------------------
'' linkFailTimer_dis                          [4:4]            get_linkFailTimer_dis
''                                                             set_linkFailTimer_dis
''                                                             read_linkFailTimer_dis
''                                                             write_linkFailTimer_dis
''---------------------------------------------------------------------------------
'' an_good_check_trap                         [3:3]            get_an_good_check_trap
''                                                             set_an_good_check_trap
''                                                             read_an_good_check_trap
''                                                             write_an_good_check_trap
''---------------------------------------------------------------------------------
'' an_good_trap                               [2:2]            get_an_good_trap
''                                                             set_an_good_trap
''                                                             read_an_good_trap
''                                                             write_an_good_trap
''---------------------------------------------------------------------------------
'' pd_KX_en                                   [1:1]            get_pd_KX_en
''                                                             set_pd_KX_en
''                                                             read_pd_KX_en
''                                                             write_pd_KX_en
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_controls_sgmiiplusr_x1
    Private write_OUI_CONTROL_value
    Private read_OUI_CONTROL_value
    Private flag_OUI_CONTROL
    Private write_an_fail_count_limit_value
    Private read_an_fail_count_limit_value
    Private flag_an_fail_count_limit
    Private write_linkFailTimerQual_en_value
    Private read_linkFailTimerQual_en_value
    Private flag_linkFailTimerQual_en
    Private write_linkFailTimer_dis_value
    Private read_linkFailTimer_dis_value
    Private flag_linkFailTimer_dis
    Private write_an_good_check_trap_value
    Private read_an_good_check_trap_value
    Private flag_an_good_check_trap
    Private write_an_good_trap_value
    Private read_an_good_trap_value
    Private flag_an_good_trap
    Private write_pd_KX_en_value
    Private read_pd_KX_en_value
    Private flag_pd_KX_en

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

    Property Get get_OUI_CONTROL
        get_OUI_CONTROL = read_OUI_CONTROL_value
    End Property

    Property Let set_OUI_CONTROL(aData)
        write_OUI_CONTROL_value = aData
        flag_OUI_CONTROL        = &H1
    End Property

    Property Get read_OUI_CONTROL
        read
        read_OUI_CONTROL = read_OUI_CONTROL_value
    End Property

    Property Let write_OUI_CONTROL(aData)
        set_OUI_CONTROL = aData
        write
    End Property

    Property Get get_an_fail_count_limit
        get_an_fail_count_limit = read_an_fail_count_limit_value
    End Property

    Property Let set_an_fail_count_limit(aData)
        write_an_fail_count_limit_value = aData
        flag_an_fail_count_limit        = &H1
    End Property

    Property Get read_an_fail_count_limit
        read
        read_an_fail_count_limit = read_an_fail_count_limit_value
    End Property

    Property Let write_an_fail_count_limit(aData)
        set_an_fail_count_limit = aData
        write
    End Property

    Property Get get_linkFailTimerQual_en
        get_linkFailTimerQual_en = read_linkFailTimerQual_en_value
    End Property

    Property Let set_linkFailTimerQual_en(aData)
        write_linkFailTimerQual_en_value = aData
        flag_linkFailTimerQual_en        = &H1
    End Property

    Property Get read_linkFailTimerQual_en
        read
        read_linkFailTimerQual_en = read_linkFailTimerQual_en_value
    End Property

    Property Let write_linkFailTimerQual_en(aData)
        set_linkFailTimerQual_en = aData
        write
    End Property

    Property Get get_linkFailTimer_dis
        get_linkFailTimer_dis = read_linkFailTimer_dis_value
    End Property

    Property Let set_linkFailTimer_dis(aData)
        write_linkFailTimer_dis_value = aData
        flag_linkFailTimer_dis        = &H1
    End Property

    Property Get read_linkFailTimer_dis
        read
        read_linkFailTimer_dis = read_linkFailTimer_dis_value
    End Property

    Property Let write_linkFailTimer_dis(aData)
        set_linkFailTimer_dis = aData
        write
    End Property

    Property Get get_an_good_check_trap
        get_an_good_check_trap = read_an_good_check_trap_value
    End Property

    Property Let set_an_good_check_trap(aData)
        write_an_good_check_trap_value = aData
        flag_an_good_check_trap        = &H1
    End Property

    Property Get read_an_good_check_trap
        read
        read_an_good_check_trap = read_an_good_check_trap_value
    End Property

    Property Let write_an_good_check_trap(aData)
        set_an_good_check_trap = aData
        write
    End Property

    Property Get get_an_good_trap
        get_an_good_trap = read_an_good_trap_value
    End Property

    Property Let set_an_good_trap(aData)
        write_an_good_trap_value = aData
        flag_an_good_trap        = &H1
    End Property

    Property Get read_an_good_trap
        read
        read_an_good_trap = read_an_good_trap_value
    End Property

    Property Let write_an_good_trap(aData)
        set_an_good_trap = aData
        write
    End Property

    Property Get get_pd_KX_en
        get_pd_KX_en = read_pd_KX_en_value
    End Property

    Property Let set_pd_KX_en(aData)
        write_pd_KX_en_value = aData
        flag_pd_KX_en        = &H1
    End Property

    Property Get read_pd_KX_en
        read
        read_pd_KX_en = read_pd_KX_en_value
    End Property

    Property Let write_pd_KX_en(aData)
        set_pd_KX_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OUI_CONTROL_value = rightShift(data_low, 10) and &H3f
        read_an_fail_count_limit_value = rightShift(data_low, 6) and &Hf
        read_linkFailTimerQual_en_value = rightShift(data_low, 5) and &H1
        read_linkFailTimer_dis_value = rightShift(data_low, 4) and &H1
        read_an_good_check_trap_value = rightShift(data_low, 3) and &H1
        read_an_good_trap_value = rightShift(data_low, 2) and &H1
        read_pd_KX_en_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_OUI_CONTROL = &H0 or flag_an_fail_count_limit = &H0 or flag_linkFailTimerQual_en = &H0 or flag_linkFailTimer_dis = &H0 or flag_an_good_check_trap = &H0 or flag_an_good_trap = &H0 or flag_pd_KX_en = &H0 Then read
        If flag_OUI_CONTROL = &H0 Then write_OUI_CONTROL_value = get_OUI_CONTROL
        If flag_an_fail_count_limit = &H0 Then write_an_fail_count_limit_value = get_an_fail_count_limit
        If flag_linkFailTimerQual_en = &H0 Then write_linkFailTimerQual_en_value = get_linkFailTimerQual_en
        If flag_linkFailTimer_dis = &H0 Then write_linkFailTimer_dis_value = get_linkFailTimer_dis
        If flag_an_good_check_trap = &H0 Then write_an_good_check_trap_value = get_an_good_check_trap
        If flag_an_good_trap = &H0 Then write_an_good_trap_value = get_an_good_trap
        If flag_pd_KX_en = &H0 Then write_pd_KX_en_value = get_pd_KX_en

        regValue = leftShift((write_OUI_CONTROL_value and &H3f), 10) + leftShift((write_an_fail_count_limit_value and &Hf), 6) + leftShift((write_linkFailTimerQual_en_value and &H1), 5) + leftShift((write_linkFailTimer_dis_value and &H1), 4) + leftShift((write_an_good_check_trap_value and &H1), 3) + leftShift((write_an_good_trap_value and &H1), 2) + leftShift((write_pd_KX_en_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OUI_CONTROL_value = rightShift(data_low, 10) and &H3f
        read_an_fail_count_limit_value = rightShift(data_low, 6) and &Hf
        read_linkFailTimerQual_en_value = rightShift(data_low, 5) and &H1
        read_linkFailTimer_dis_value = rightShift(data_low, 4) and &H1
        read_an_good_check_trap_value = rightShift(data_low, 3) and &H1
        read_an_good_trap_value = rightShift(data_low, 2) and &H1
        read_pd_KX_en_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OUI_CONTROL_value = &H0
        flag_OUI_CONTROL        = &H0
        write_an_fail_count_limit_value = &H0
        flag_an_fail_count_limit        = &H0
        write_linkFailTimerQual_en_value = &H0
        flag_linkFailTimerQual_en        = &H0
        write_linkFailTimer_dis_value = &H0
        flag_linkFailTimer_dis        = &H0
        write_an_good_check_trap_value = &H0
        flag_an_good_check_trap        = &H0
        write_an_good_trap_value = &H0
        flag_an_good_trap        = &H0
        write_pd_KX_en_value = &H0
        flag_pd_KX_en        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_pmd_ln_mode_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AX4APLORO                                  [9:9]            get_AX4APLORO
''                                                             set_AX4APLORO
''                                                             read_AX4APLORO
''                                                             write_AX4APLORO
''---------------------------------------------------------------------------------
'' PLMSX1O1                                   [8:8]            get_PLMSX1O1
''                                                             set_PLMSX1O1
''                                                             read_PLMSX1O1
''                                                             write_PLMSX1O1
''---------------------------------------------------------------------------------
'' pmd_ln_mode_SGMIIPLUSR_X1                  [7:0]            get_pmd_ln_mode_SGMIIPLUSR_X1
''                                                             set_pmd_ln_mode_SGMIIPLUSR_X1
''                                                             read_pmd_ln_mode_SGMIIPLUSR_X1
''                                                             write_pmd_ln_mode_SGMIIPLUSR_X1
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_pmd_ln_mode_sgmiiplusr_x1
    Private write_AX4APLORO_value
    Private read_AX4APLORO_value
    Private flag_AX4APLORO
    Private write_PLMSX1O1_value
    Private read_PLMSX1O1_value
    Private flag_PLMSX1O1
    Private write_pmd_ln_mode_SGMIIPLUSR_X1_value
    Private read_pmd_ln_mode_SGMIIPLUSR_X1_value
    Private flag_pmd_ln_mode_SGMIIPLUSR_X1

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

    Property Get get_AX4APLORO
        get_AX4APLORO = read_AX4APLORO_value
    End Property

    Property Let set_AX4APLORO(aData)
        write_AX4APLORO_value = aData
        flag_AX4APLORO        = &H1
    End Property

    Property Get read_AX4APLORO
        read
        read_AX4APLORO = read_AX4APLORO_value
    End Property

    Property Let write_AX4APLORO(aData)
        set_AX4APLORO = aData
        write
    End Property

    Property Get get_PLMSX1O1
        get_PLMSX1O1 = read_PLMSX1O1_value
    End Property

    Property Let set_PLMSX1O1(aData)
        write_PLMSX1O1_value = aData
        flag_PLMSX1O1        = &H1
    End Property

    Property Get read_PLMSX1O1
        read
        read_PLMSX1O1 = read_PLMSX1O1_value
    End Property

    Property Let write_PLMSX1O1(aData)
        set_PLMSX1O1 = aData
        write
    End Property

    Property Get get_pmd_ln_mode_SGMIIPLUSR_X1
        get_pmd_ln_mode_SGMIIPLUSR_X1 = read_pmd_ln_mode_SGMIIPLUSR_X1_value
    End Property

    Property Let set_pmd_ln_mode_SGMIIPLUSR_X1(aData)
        write_pmd_ln_mode_SGMIIPLUSR_X1_value = aData
        flag_pmd_ln_mode_SGMIIPLUSR_X1        = &H1
    End Property

    Property Get read_pmd_ln_mode_SGMIIPLUSR_X1
        read
        read_pmd_ln_mode_SGMIIPLUSR_X1 = read_pmd_ln_mode_SGMIIPLUSR_X1_value
    End Property

    Property Let write_pmd_ln_mode_SGMIIPLUSR_X1(aData)
        set_pmd_ln_mode_SGMIIPLUSR_X1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AX4APLORO_value = rightShift(data_low, 9) and &H1
        read_PLMSX1O1_value = rightShift(data_low, 8) and &H1
        pmd_ln_mode_SGMIIPLUSR_X1_mask = &Hff
        if data_low > LONG_MAX then
            if pmd_ln_mode_SGMIIPLUSR_X1_mask = mask then
                read_pmd_ln_mode_SGMIIPLUSR_X1_value = data_low
            else
                read_pmd_ln_mode_SGMIIPLUSR_X1_value = (data_low - H8000_0000) and pmd_ln_mode_SGMIIPLUSR_X1_mask
            end If
        else
            read_pmd_ln_mode_SGMIIPLUSR_X1_value = data_low and pmd_ln_mode_SGMIIPLUSR_X1_mask
        end If

    End Sub

    Sub write
        If flag_AX4APLORO = &H0 or flag_PLMSX1O1 = &H0 or flag_pmd_ln_mode_SGMIIPLUSR_X1 = &H0 Then read
        If flag_AX4APLORO = &H0 Then write_AX4APLORO_value = get_AX4APLORO
        If flag_PLMSX1O1 = &H0 Then write_PLMSX1O1_value = get_PLMSX1O1
        If flag_pmd_ln_mode_SGMIIPLUSR_X1 = &H0 Then write_pmd_ln_mode_SGMIIPLUSR_X1_value = get_pmd_ln_mode_SGMIIPLUSR_X1

        regValue = leftShift((write_AX4APLORO_value and &H1), 9) + leftShift((write_PLMSX1O1_value and &H1), 8) + leftShift((write_pmd_ln_mode_SGMIIPLUSR_X1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AX4APLORO_value = rightShift(data_low, 9) and &H1
        read_PLMSX1O1_value = rightShift(data_low, 8) and &H1
        pmd_ln_mode_SGMIIPLUSR_X1_mask = &Hff
        if data_low > LONG_MAX then
            if pmd_ln_mode_SGMIIPLUSR_X1_mask = mask then
                read_pmd_ln_mode_SGMIIPLUSR_X1_value = data_low
            else
                read_pmd_ln_mode_SGMIIPLUSR_X1_value = (data_low - H8000_0000) and pmd_ln_mode_SGMIIPLUSR_X1_mask
            end If
        else
            read_pmd_ln_mode_SGMIIPLUSR_X1_value = data_low and pmd_ln_mode_SGMIIPLUSR_X1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AX4APLORO_value = &H0
        flag_AX4APLORO        = &H0
        write_PLMSX1O1_value = &H0
        flag_PLMSX1O1        = &H0
        write_pmd_ln_mode_SGMIIPLUSR_X1_value = &H0
        flag_pmd_ln_mode_SGMIIPLUSR_X1        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_ABILITIES_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_blockaddress
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

Class AN_X4_ABILITIES_SGMIIPLUSR_X1_INSTANCE

    Public enables_sgmiiplusr_x1
    Public local_device_cl37_base_abilities_sgmiiplusr_x1
    Public local_device_cl37_bam_abilities_sgmiiplusr_x1
    Public local_device_over1g_abilities_1_sgmiiplusr_x1
    Public local_device_over1g_abilities_0_sgmiiplusr_x1
    Public local_device_cl73_base_abilities_1_sgmiiplusr_x1
    Public local_device_cl73_base_abilities_0_sgmiiplusr_x1
    Public local_device_cl73_bam_abilities_sgmiiplusr_x1
    Public controls_sgmiiplusr_x1
    Public pmd_ln_mode_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set enables_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_enables_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_cl37_base_abilities_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl37_base_abilities_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_cl37_bam_abilities_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl37_bam_abilities_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_over1g_abilities_1_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_over1g_abilities_1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_over1g_abilities_0_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_over1g_abilities_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_cl73_base_abilities_1_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_base_abilities_1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_cl73_base_abilities_0_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_base_abilities_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set local_device_cl73_bam_abilities_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_local_device_cl73_bam_abilities_sgmiiplusr_x1)(aBaseAddr, 16)
        Set controls_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_controls_sgmiiplusr_x1)(aBaseAddr, 16)
        Set pmd_ln_mode_sgmiiplusr_x1 = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_pmd_ln_mode_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_AN_X4_ABILITIES_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AN_X4_ABILITIES_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
AN_X4_ABILITIES_SGMIIPLUSR_X1.Add ((New AN_X4_ABILITIES_SGMIIPLUSR_X1_INSTANCE)(&H4aed8900))


