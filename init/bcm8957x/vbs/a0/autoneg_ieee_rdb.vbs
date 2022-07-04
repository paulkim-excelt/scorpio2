

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


'' @REGISTER : AUTONEG_IEEE_teng_an_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSTR_SLV_CONFIG_FAULT                      [15:15]          get_MSTR_SLV_CONFIG_FAULT
''                                                             set_MSTR_SLV_CONFIG_FAULT
''                                                             read_MSTR_SLV_CONFIG_FAULT
''                                                             write_MSTR_SLV_CONFIG_FAULT
''---------------------------------------------------------------------------------
'' MSTR_SLV_CONFIG_RES                        [14:14]          get_MSTR_SLV_CONFIG_RES
''                                                             set_MSTR_SLV_CONFIG_RES
''                                                             read_MSTR_SLV_CONFIG_RES
''                                                             write_MSTR_SLV_CONFIG_RES
''---------------------------------------------------------------------------------
'' LOCAL_RCVR_STAT                            [13:13]          get_LOCAL_RCVR_STAT
''                                                             set_LOCAL_RCVR_STAT
''                                                             read_LOCAL_RCVR_STAT
''                                                             write_LOCAL_RCVR_STAT
''---------------------------------------------------------------------------------
'' REMOTE_RCVR_STAT                           [12:12]          get_REMOTE_RCVR_STAT
''                                                             set_REMOTE_RCVR_STAT
''                                                             read_REMOTE_RCVR_STAT
''                                                             write_REMOTE_RCVR_STAT
''---------------------------------------------------------------------------------
'' LP_PHY_10GBASE_T_ABLE                      [11:11]          get_LP_PHY_10GBASE_T_ABLE
''                                                             set_LP_PHY_10GBASE_T_ABLE
''                                                             read_LP_PHY_10GBASE_T_ABLE
''                                                             write_LP_PHY_10GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LP_LOOP_TIMING_ABLE                        [10:10]          get_LP_LOOP_TIMING_ABLE
''                                                             set_LP_LOOP_TIMING_ABLE
''                                                             read_LP_LOOP_TIMING_ABLE
''                                                             write_LP_LOOP_TIMING_ABLE
''---------------------------------------------------------------------------------
'' LP_PMA_TRAIN_RST_REQ                       [9:9]            get_LP_PMA_TRAIN_RST_REQ
''                                                             set_LP_PMA_TRAIN_RST_REQ
''                                                             read_LP_PMA_TRAIN_RST_REQ
''                                                             write_LP_PMA_TRAIN_RST_REQ
''---------------------------------------------------------------------------------
'' LP_PHY_5GBASE_T_ABLE                       [6:6]            get_LP_PHY_5GBASE_T_ABLE
''                                                             set_LP_PHY_5GBASE_T_ABLE
''                                                             read_LP_PHY_5GBASE_T_ABLE
''                                                             write_LP_PHY_5GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LP_PHY_2P5GBASE_T_ABLE                     [5:5]            get_LP_PHY_2P5GBASE_T_ABLE
''                                                             set_LP_PHY_2P5GBASE_T_ABLE
''                                                             read_LP_PHY_2P5GBASE_T_ABLE
''                                                             write_LP_PHY_2P5GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LFRC5                                      [4:4]            get_LFRC5
''                                                             set_LFRC5
''                                                             read_LFRC5
''                                                             write_LFRC5
''---------------------------------------------------------------------------------
'' LFRC251                                    [3:3]            get_LFRC251
''                                                             set_LFRC251
''                                                             read_LFRC251
''                                                             write_LFRC251
''---------------------------------------------------------------------------------
'' LFRC101                                    [1:1]            get_LFRC101
''                                                             set_LFRC101
''                                                             read_LFRC101
''                                                             write_LFRC101
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_teng_an_stat
    Private write_MSTR_SLV_CONFIG_FAULT_value
    Private read_MSTR_SLV_CONFIG_FAULT_value
    Private flag_MSTR_SLV_CONFIG_FAULT
    Private write_MSTR_SLV_CONFIG_RES_value
    Private read_MSTR_SLV_CONFIG_RES_value
    Private flag_MSTR_SLV_CONFIG_RES
    Private write_LOCAL_RCVR_STAT_value
    Private read_LOCAL_RCVR_STAT_value
    Private flag_LOCAL_RCVR_STAT
    Private write_REMOTE_RCVR_STAT_value
    Private read_REMOTE_RCVR_STAT_value
    Private flag_REMOTE_RCVR_STAT
    Private write_LP_PHY_10GBASE_T_ABLE_value
    Private read_LP_PHY_10GBASE_T_ABLE_value
    Private flag_LP_PHY_10GBASE_T_ABLE
    Private write_LP_LOOP_TIMING_ABLE_value
    Private read_LP_LOOP_TIMING_ABLE_value
    Private flag_LP_LOOP_TIMING_ABLE
    Private write_LP_PMA_TRAIN_RST_REQ_value
    Private read_LP_PMA_TRAIN_RST_REQ_value
    Private flag_LP_PMA_TRAIN_RST_REQ
    Private write_LP_PHY_5GBASE_T_ABLE_value
    Private read_LP_PHY_5GBASE_T_ABLE_value
    Private flag_LP_PHY_5GBASE_T_ABLE
    Private write_LP_PHY_2P5GBASE_T_ABLE_value
    Private read_LP_PHY_2P5GBASE_T_ABLE_value
    Private flag_LP_PHY_2P5GBASE_T_ABLE
    Private write_LFRC5_value
    Private read_LFRC5_value
    Private flag_LFRC5
    Private write_LFRC251_value
    Private read_LFRC251_value
    Private flag_LFRC251
    Private write_LFRC101_value
    Private read_LFRC101_value
    Private flag_LFRC101

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H42
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSTR_SLV_CONFIG_FAULT
        get_MSTR_SLV_CONFIG_FAULT = read_MSTR_SLV_CONFIG_FAULT_value
    End Property

    Property Let set_MSTR_SLV_CONFIG_FAULT(aData)
        write_MSTR_SLV_CONFIG_FAULT_value = aData
        flag_MSTR_SLV_CONFIG_FAULT        = &H1
    End Property

    Property Get read_MSTR_SLV_CONFIG_FAULT
        read
        read_MSTR_SLV_CONFIG_FAULT = read_MSTR_SLV_CONFIG_FAULT_value
    End Property

    Property Let write_MSTR_SLV_CONFIG_FAULT(aData)
        set_MSTR_SLV_CONFIG_FAULT = aData
        write
    End Property

    Property Get get_MSTR_SLV_CONFIG_RES
        get_MSTR_SLV_CONFIG_RES = read_MSTR_SLV_CONFIG_RES_value
    End Property

    Property Let set_MSTR_SLV_CONFIG_RES(aData)
        write_MSTR_SLV_CONFIG_RES_value = aData
        flag_MSTR_SLV_CONFIG_RES        = &H1
    End Property

    Property Get read_MSTR_SLV_CONFIG_RES
        read
        read_MSTR_SLV_CONFIG_RES = read_MSTR_SLV_CONFIG_RES_value
    End Property

    Property Let write_MSTR_SLV_CONFIG_RES(aData)
        set_MSTR_SLV_CONFIG_RES = aData
        write
    End Property

    Property Get get_LOCAL_RCVR_STAT
        get_LOCAL_RCVR_STAT = read_LOCAL_RCVR_STAT_value
    End Property

    Property Let set_LOCAL_RCVR_STAT(aData)
        write_LOCAL_RCVR_STAT_value = aData
        flag_LOCAL_RCVR_STAT        = &H1
    End Property

    Property Get read_LOCAL_RCVR_STAT
        read
        read_LOCAL_RCVR_STAT = read_LOCAL_RCVR_STAT_value
    End Property

    Property Let write_LOCAL_RCVR_STAT(aData)
        set_LOCAL_RCVR_STAT = aData
        write
    End Property

    Property Get get_REMOTE_RCVR_STAT
        get_REMOTE_RCVR_STAT = read_REMOTE_RCVR_STAT_value
    End Property

    Property Let set_REMOTE_RCVR_STAT(aData)
        write_REMOTE_RCVR_STAT_value = aData
        flag_REMOTE_RCVR_STAT        = &H1
    End Property

    Property Get read_REMOTE_RCVR_STAT
        read
        read_REMOTE_RCVR_STAT = read_REMOTE_RCVR_STAT_value
    End Property

    Property Let write_REMOTE_RCVR_STAT(aData)
        set_REMOTE_RCVR_STAT = aData
        write
    End Property

    Property Get get_LP_PHY_10GBASE_T_ABLE
        get_LP_PHY_10GBASE_T_ABLE = read_LP_PHY_10GBASE_T_ABLE_value
    End Property

    Property Let set_LP_PHY_10GBASE_T_ABLE(aData)
        write_LP_PHY_10GBASE_T_ABLE_value = aData
        flag_LP_PHY_10GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LP_PHY_10GBASE_T_ABLE
        read
        read_LP_PHY_10GBASE_T_ABLE = read_LP_PHY_10GBASE_T_ABLE_value
    End Property

    Property Let write_LP_PHY_10GBASE_T_ABLE(aData)
        set_LP_PHY_10GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LP_LOOP_TIMING_ABLE
        get_LP_LOOP_TIMING_ABLE = read_LP_LOOP_TIMING_ABLE_value
    End Property

    Property Let set_LP_LOOP_TIMING_ABLE(aData)
        write_LP_LOOP_TIMING_ABLE_value = aData
        flag_LP_LOOP_TIMING_ABLE        = &H1
    End Property

    Property Get read_LP_LOOP_TIMING_ABLE
        read
        read_LP_LOOP_TIMING_ABLE = read_LP_LOOP_TIMING_ABLE_value
    End Property

    Property Let write_LP_LOOP_TIMING_ABLE(aData)
        set_LP_LOOP_TIMING_ABLE = aData
        write
    End Property

    Property Get get_LP_PMA_TRAIN_RST_REQ
        get_LP_PMA_TRAIN_RST_REQ = read_LP_PMA_TRAIN_RST_REQ_value
    End Property

    Property Let set_LP_PMA_TRAIN_RST_REQ(aData)
        write_LP_PMA_TRAIN_RST_REQ_value = aData
        flag_LP_PMA_TRAIN_RST_REQ        = &H1
    End Property

    Property Get read_LP_PMA_TRAIN_RST_REQ
        read
        read_LP_PMA_TRAIN_RST_REQ = read_LP_PMA_TRAIN_RST_REQ_value
    End Property

    Property Let write_LP_PMA_TRAIN_RST_REQ(aData)
        set_LP_PMA_TRAIN_RST_REQ = aData
        write
    End Property

    Property Get get_LP_PHY_5GBASE_T_ABLE
        get_LP_PHY_5GBASE_T_ABLE = read_LP_PHY_5GBASE_T_ABLE_value
    End Property

    Property Let set_LP_PHY_5GBASE_T_ABLE(aData)
        write_LP_PHY_5GBASE_T_ABLE_value = aData
        flag_LP_PHY_5GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LP_PHY_5GBASE_T_ABLE
        read
        read_LP_PHY_5GBASE_T_ABLE = read_LP_PHY_5GBASE_T_ABLE_value
    End Property

    Property Let write_LP_PHY_5GBASE_T_ABLE(aData)
        set_LP_PHY_5GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LP_PHY_2P5GBASE_T_ABLE
        get_LP_PHY_2P5GBASE_T_ABLE = read_LP_PHY_2P5GBASE_T_ABLE_value
    End Property

    Property Let set_LP_PHY_2P5GBASE_T_ABLE(aData)
        write_LP_PHY_2P5GBASE_T_ABLE_value = aData
        flag_LP_PHY_2P5GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LP_PHY_2P5GBASE_T_ABLE
        read
        read_LP_PHY_2P5GBASE_T_ABLE = read_LP_PHY_2P5GBASE_T_ABLE_value
    End Property

    Property Let write_LP_PHY_2P5GBASE_T_ABLE(aData)
        set_LP_PHY_2P5GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LFRC5
        get_LFRC5 = read_LFRC5_value
    End Property

    Property Let set_LFRC5(aData)
        write_LFRC5_value = aData
        flag_LFRC5        = &H1
    End Property

    Property Get read_LFRC5
        read
        read_LFRC5 = read_LFRC5_value
    End Property

    Property Let write_LFRC5(aData)
        set_LFRC5 = aData
        write
    End Property

    Property Get get_LFRC251
        get_LFRC251 = read_LFRC251_value
    End Property

    Property Let set_LFRC251(aData)
        write_LFRC251_value = aData
        flag_LFRC251        = &H1
    End Property

    Property Get read_LFRC251
        read
        read_LFRC251 = read_LFRC251_value
    End Property

    Property Let write_LFRC251(aData)
        set_LFRC251 = aData
        write
    End Property

    Property Get get_LFRC101
        get_LFRC101 = read_LFRC101_value
    End Property

    Property Let set_LFRC101(aData)
        write_LFRC101_value = aData
        flag_LFRC101        = &H1
    End Property

    Property Get read_LFRC101
        read
        read_LFRC101 = read_LFRC101_value
    End Property

    Property Let write_LFRC101(aData)
        set_LFRC101 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSTR_SLV_CONFIG_FAULT_value = rightShift(data_low, 15) and &H1
        read_MSTR_SLV_CONFIG_RES_value = rightShift(data_low, 14) and &H1
        read_LOCAL_RCVR_STAT_value = rightShift(data_low, 13) and &H1
        read_REMOTE_RCVR_STAT_value = rightShift(data_low, 12) and &H1
        read_LP_PHY_10GBASE_T_ABLE_value = rightShift(data_low, 11) and &H1
        read_LP_LOOP_TIMING_ABLE_value = rightShift(data_low, 10) and &H1
        read_LP_PMA_TRAIN_RST_REQ_value = rightShift(data_low, 9) and &H1
        read_LP_PHY_5GBASE_T_ABLE_value = rightShift(data_low, 6) and &H1
        read_LP_PHY_2P5GBASE_T_ABLE_value = rightShift(data_low, 5) and &H1
        read_LFRC5_value = rightShift(data_low, 4) and &H1
        read_LFRC251_value = rightShift(data_low, 3) and &H1
        read_LFRC101_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_MSTR_SLV_CONFIG_FAULT = &H0 or flag_MSTR_SLV_CONFIG_RES = &H0 or flag_LOCAL_RCVR_STAT = &H0 or flag_REMOTE_RCVR_STAT = &H0 or flag_LP_PHY_10GBASE_T_ABLE = &H0 or flag_LP_LOOP_TIMING_ABLE = &H0 or flag_LP_PMA_TRAIN_RST_REQ = &H0 or flag_LP_PHY_5GBASE_T_ABLE = &H0 or flag_LP_PHY_2P5GBASE_T_ABLE = &H0 or flag_LFRC5 = &H0 or flag_LFRC251 = &H0 or flag_LFRC101 = &H0 Then read
        If flag_MSTR_SLV_CONFIG_FAULT = &H0 Then write_MSTR_SLV_CONFIG_FAULT_value = get_MSTR_SLV_CONFIG_FAULT
        If flag_MSTR_SLV_CONFIG_RES = &H0 Then write_MSTR_SLV_CONFIG_RES_value = get_MSTR_SLV_CONFIG_RES
        If flag_LOCAL_RCVR_STAT = &H0 Then write_LOCAL_RCVR_STAT_value = get_LOCAL_RCVR_STAT
        If flag_REMOTE_RCVR_STAT = &H0 Then write_REMOTE_RCVR_STAT_value = get_REMOTE_RCVR_STAT
        If flag_LP_PHY_10GBASE_T_ABLE = &H0 Then write_LP_PHY_10GBASE_T_ABLE_value = get_LP_PHY_10GBASE_T_ABLE
        If flag_LP_LOOP_TIMING_ABLE = &H0 Then write_LP_LOOP_TIMING_ABLE_value = get_LP_LOOP_TIMING_ABLE
        If flag_LP_PMA_TRAIN_RST_REQ = &H0 Then write_LP_PMA_TRAIN_RST_REQ_value = get_LP_PMA_TRAIN_RST_REQ
        If flag_LP_PHY_5GBASE_T_ABLE = &H0 Then write_LP_PHY_5GBASE_T_ABLE_value = get_LP_PHY_5GBASE_T_ABLE
        If flag_LP_PHY_2P5GBASE_T_ABLE = &H0 Then write_LP_PHY_2P5GBASE_T_ABLE_value = get_LP_PHY_2P5GBASE_T_ABLE
        If flag_LFRC5 = &H0 Then write_LFRC5_value = get_LFRC5
        If flag_LFRC251 = &H0 Then write_LFRC251_value = get_LFRC251
        If flag_LFRC101 = &H0 Then write_LFRC101_value = get_LFRC101

        regValue = leftShift((write_MSTR_SLV_CONFIG_FAULT_value and &H1), 15) + leftShift((write_MSTR_SLV_CONFIG_RES_value and &H1), 14) + leftShift((write_LOCAL_RCVR_STAT_value and &H1), 13) + leftShift((write_REMOTE_RCVR_STAT_value and &H1), 12) + leftShift((write_LP_PHY_10GBASE_T_ABLE_value and &H1), 11) + leftShift((write_LP_LOOP_TIMING_ABLE_value and &H1), 10) + leftShift((write_LP_PMA_TRAIN_RST_REQ_value and &H1), 9) + leftShift((write_LP_PHY_5GBASE_T_ABLE_value and &H1), 6) + leftShift((write_LP_PHY_2P5GBASE_T_ABLE_value and &H1), 5) + leftShift((write_LFRC5_value and &H1), 4) + leftShift((write_LFRC251_value and &H1), 3) + leftShift((write_LFRC101_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSTR_SLV_CONFIG_FAULT_value = rightShift(data_low, 15) and &H1
        read_MSTR_SLV_CONFIG_RES_value = rightShift(data_low, 14) and &H1
        read_LOCAL_RCVR_STAT_value = rightShift(data_low, 13) and &H1
        read_REMOTE_RCVR_STAT_value = rightShift(data_low, 12) and &H1
        read_LP_PHY_10GBASE_T_ABLE_value = rightShift(data_low, 11) and &H1
        read_LP_LOOP_TIMING_ABLE_value = rightShift(data_low, 10) and &H1
        read_LP_PMA_TRAIN_RST_REQ_value = rightShift(data_low, 9) and &H1
        read_LP_PHY_5GBASE_T_ABLE_value = rightShift(data_low, 6) and &H1
        read_LP_PHY_2P5GBASE_T_ABLE_value = rightShift(data_low, 5) and &H1
        read_LFRC5_value = rightShift(data_low, 4) and &H1
        read_LFRC251_value = rightShift(data_low, 3) and &H1
        read_LFRC101_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSTR_SLV_CONFIG_FAULT_value = &H0
        flag_MSTR_SLV_CONFIG_FAULT        = &H0
        write_MSTR_SLV_CONFIG_RES_value = &H0
        flag_MSTR_SLV_CONFIG_RES        = &H0
        write_LOCAL_RCVR_STAT_value = &H0
        flag_LOCAL_RCVR_STAT        = &H0
        write_REMOTE_RCVR_STAT_value = &H0
        flag_REMOTE_RCVR_STAT        = &H0
        write_LP_PHY_10GBASE_T_ABLE_value = &H0
        flag_LP_PHY_10GBASE_T_ABLE        = &H0
        write_LP_LOOP_TIMING_ABLE_value = &H0
        flag_LP_LOOP_TIMING_ABLE        = &H0
        write_LP_PMA_TRAIN_RST_REQ_value = &H0
        flag_LP_PMA_TRAIN_RST_REQ        = &H0
        write_LP_PHY_5GBASE_T_ABLE_value = &H0
        flag_LP_PHY_5GBASE_T_ABLE        = &H0
        write_LP_PHY_2P5GBASE_T_ABLE_value = &H0
        flag_LP_PHY_2P5GBASE_T_ABLE        = &H0
        write_LFRC5_value = &H0
        flag_LFRC5        = &H0
        write_LFRC251_value = &H0
        flag_LFRC251        = &H0
        write_LFRC101_value = &H0
        flag_LFRC101        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_baset1_an_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_RESET                              [15:15]          get_AUTONEG_RESET
''                                                             set_AUTONEG_RESET
''                                                             read_AUTONEG_RESET
''                                                             write_AUTONEG_RESET
''---------------------------------------------------------------------------------
'' AUTONEG_ENABLE                             [12:12]          get_AUTONEG_ENABLE
''                                                             set_AUTONEG_ENABLE
''                                                             read_AUTONEG_ENABLE
''                                                             write_AUTONEG_ENABLE
''---------------------------------------------------------------------------------
'' RESTART_AUTO_NEGOTIATION                   [9:9]            get_RESTART_AUTO_NEGOTIATION
''                                                             set_RESTART_AUTO_NEGOTIATION
''                                                             read_RESTART_AUTO_NEGOTIATION
''                                                             write_RESTART_AUTO_NEGOTIATION
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_baset1_an_control
    Private write_AUTONEG_RESET_value
    Private read_AUTONEG_RESET_value
    Private flag_AUTONEG_RESET
    Private write_AUTONEG_ENABLE_value
    Private read_AUTONEG_ENABLE_value
    Private flag_AUTONEG_ENABLE
    Private write_RESTART_AUTO_NEGOTIATION_value
    Private read_RESTART_AUTO_NEGOTIATION_value
    Private flag_RESTART_AUTO_NEGOTIATION

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AUTONEG_RESET
        get_AUTONEG_RESET = read_AUTONEG_RESET_value
    End Property

    Property Let set_AUTONEG_RESET(aData)
        write_AUTONEG_RESET_value = aData
        flag_AUTONEG_RESET        = &H1
    End Property

    Property Get read_AUTONEG_RESET
        read
        read_AUTONEG_RESET = read_AUTONEG_RESET_value
    End Property

    Property Let write_AUTONEG_RESET(aData)
        set_AUTONEG_RESET = aData
        write
    End Property

    Property Get get_AUTONEG_ENABLE
        get_AUTONEG_ENABLE = read_AUTONEG_ENABLE_value
    End Property

    Property Let set_AUTONEG_ENABLE(aData)
        write_AUTONEG_ENABLE_value = aData
        flag_AUTONEG_ENABLE        = &H1
    End Property

    Property Get read_AUTONEG_ENABLE
        read
        read_AUTONEG_ENABLE = read_AUTONEG_ENABLE_value
    End Property

    Property Let write_AUTONEG_ENABLE(aData)
        set_AUTONEG_ENABLE = aData
        write
    End Property

    Property Get get_RESTART_AUTO_NEGOTIATION
        get_RESTART_AUTO_NEGOTIATION = read_RESTART_AUTO_NEGOTIATION_value
    End Property

    Property Let set_RESTART_AUTO_NEGOTIATION(aData)
        write_RESTART_AUTO_NEGOTIATION_value = aData
        flag_RESTART_AUTO_NEGOTIATION        = &H1
    End Property

    Property Get read_RESTART_AUTO_NEGOTIATION
        read
        read_RESTART_AUTO_NEGOTIATION = read_RESTART_AUTO_NEGOTIATION_value
    End Property

    Property Let write_RESTART_AUTO_NEGOTIATION(aData)
        set_RESTART_AUTO_NEGOTIATION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_RESET_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_ENABLE_value = rightShift(data_low, 12) and &H1
        read_RESTART_AUTO_NEGOTIATION_value = rightShift(data_low, 9) and &H1

    End Sub

    Sub write
        If flag_AUTONEG_RESET = &H0 or flag_AUTONEG_ENABLE = &H0 or flag_RESTART_AUTO_NEGOTIATION = &H0 Then read
        If flag_AUTONEG_RESET = &H0 Then write_AUTONEG_RESET_value = get_AUTONEG_RESET
        If flag_AUTONEG_ENABLE = &H0 Then write_AUTONEG_ENABLE_value = get_AUTONEG_ENABLE
        If flag_RESTART_AUTO_NEGOTIATION = &H0 Then write_RESTART_AUTO_NEGOTIATION_value = get_RESTART_AUTO_NEGOTIATION

        regValue = leftShift((write_AUTONEG_RESET_value and &H1), 15) + leftShift((write_AUTONEG_ENABLE_value and &H1), 12) + leftShift((write_RESTART_AUTO_NEGOTIATION_value and &H1), 9)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_RESET_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_ENABLE_value = rightShift(data_low, 12) and &H1
        read_RESTART_AUTO_NEGOTIATION_value = rightShift(data_low, 9) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_RESET_value = &H0
        flag_AUTONEG_RESET        = &H0
        write_AUTONEG_ENABLE_value = &H0
        flag_AUTONEG_ENABLE        = &H0
        write_RESTART_AUTO_NEGOTIATION_value = &H0
        flag_RESTART_AUTO_NEGOTIATION        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_baset1_an_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PAGE_RECEIVED                              [6:6]            get_PAGE_RECEIVED
''                                                             set_PAGE_RECEIVED
''                                                             read_PAGE_RECEIVED
''                                                             write_PAGE_RECEIVED
''---------------------------------------------------------------------------------
'' AUTONEG_COMPLETE                           [5:5]            get_AUTONEG_COMPLETE
''                                                             set_AUTONEG_COMPLETE
''                                                             read_AUTONEG_COMPLETE
''                                                             write_AUTONEG_COMPLETE
''---------------------------------------------------------------------------------
'' REMOTE_FAULT                               [4:4]            get_REMOTE_FAULT
''                                                             set_REMOTE_FAULT
''                                                             read_REMOTE_FAULT
''                                                             write_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' AUTONEG_ABILITY                            [3:3]            get_AUTONEG_ABILITY
''                                                             set_AUTONEG_ABILITY
''                                                             read_AUTONEG_ABILITY
''                                                             write_AUTONEG_ABILITY
''---------------------------------------------------------------------------------
'' LINK_STATUS                                [2:2]            get_LINK_STATUS
''                                                             set_LINK_STATUS
''                                                             read_LINK_STATUS
''                                                             write_LINK_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_baset1_an_status
    Private write_PAGE_RECEIVED_value
    Private read_PAGE_RECEIVED_value
    Private flag_PAGE_RECEIVED
    Private write_AUTONEG_COMPLETE_value
    Private read_AUTONEG_COMPLETE_value
    Private flag_AUTONEG_COMPLETE
    Private write_REMOTE_FAULT_value
    Private read_REMOTE_FAULT_value
    Private flag_REMOTE_FAULT
    Private write_AUTONEG_ABILITY_value
    Private read_AUTONEG_ABILITY_value
    Private flag_AUTONEG_ABILITY
    Private write_LINK_STATUS_value
    Private read_LINK_STATUS_value
    Private flag_LINK_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H402
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PAGE_RECEIVED
        get_PAGE_RECEIVED = read_PAGE_RECEIVED_value
    End Property

    Property Let set_PAGE_RECEIVED(aData)
        write_PAGE_RECEIVED_value = aData
        flag_PAGE_RECEIVED        = &H1
    End Property

    Property Get read_PAGE_RECEIVED
        read
        read_PAGE_RECEIVED = read_PAGE_RECEIVED_value
    End Property

    Property Let write_PAGE_RECEIVED(aData)
        set_PAGE_RECEIVED = aData
        write
    End Property

    Property Get get_AUTONEG_COMPLETE
        get_AUTONEG_COMPLETE = read_AUTONEG_COMPLETE_value
    End Property

    Property Let set_AUTONEG_COMPLETE(aData)
        write_AUTONEG_COMPLETE_value = aData
        flag_AUTONEG_COMPLETE        = &H1
    End Property

    Property Get read_AUTONEG_COMPLETE
        read
        read_AUTONEG_COMPLETE = read_AUTONEG_COMPLETE_value
    End Property

    Property Let write_AUTONEG_COMPLETE(aData)
        set_AUTONEG_COMPLETE = aData
        write
    End Property

    Property Get get_REMOTE_FAULT
        get_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let set_REMOTE_FAULT(aData)
        write_REMOTE_FAULT_value = aData
        flag_REMOTE_FAULT        = &H1
    End Property

    Property Get read_REMOTE_FAULT
        read
        read_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let write_REMOTE_FAULT(aData)
        set_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_AUTONEG_ABILITY
        get_AUTONEG_ABILITY = read_AUTONEG_ABILITY_value
    End Property

    Property Let set_AUTONEG_ABILITY(aData)
        write_AUTONEG_ABILITY_value = aData
        flag_AUTONEG_ABILITY        = &H1
    End Property

    Property Get read_AUTONEG_ABILITY
        read
        read_AUTONEG_ABILITY = read_AUTONEG_ABILITY_value
    End Property

    Property Let write_AUTONEG_ABILITY(aData)
        set_AUTONEG_ABILITY = aData
        write
    End Property

    Property Get get_LINK_STATUS
        get_LINK_STATUS = read_LINK_STATUS_value
    End Property

    Property Let set_LINK_STATUS(aData)
        write_LINK_STATUS_value = aData
        flag_LINK_STATUS        = &H1
    End Property

    Property Get read_LINK_STATUS
        read
        read_LINK_STATUS = read_LINK_STATUS_value
    End Property

    Property Let write_LINK_STATUS(aData)
        set_LINK_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAGE_RECEIVED_value = rightShift(data_low, 6) and &H1
        read_AUTONEG_COMPLETE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 4) and &H1
        read_AUTONEG_ABILITY_value = rightShift(data_low, 3) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_PAGE_RECEIVED = &H0 or flag_AUTONEG_COMPLETE = &H0 or flag_REMOTE_FAULT = &H0 or flag_AUTONEG_ABILITY = &H0 or flag_LINK_STATUS = &H0 Then read
        If flag_PAGE_RECEIVED = &H0 Then write_PAGE_RECEIVED_value = get_PAGE_RECEIVED
        If flag_AUTONEG_COMPLETE = &H0 Then write_AUTONEG_COMPLETE_value = get_AUTONEG_COMPLETE
        If flag_REMOTE_FAULT = &H0 Then write_REMOTE_FAULT_value = get_REMOTE_FAULT
        If flag_AUTONEG_ABILITY = &H0 Then write_AUTONEG_ABILITY_value = get_AUTONEG_ABILITY
        If flag_LINK_STATUS = &H0 Then write_LINK_STATUS_value = get_LINK_STATUS

        regValue = leftShift((write_PAGE_RECEIVED_value and &H1), 6) + leftShift((write_AUTONEG_COMPLETE_value and &H1), 5) + leftShift((write_REMOTE_FAULT_value and &H1), 4) + leftShift((write_AUTONEG_ABILITY_value and &H1), 3) + leftShift((write_LINK_STATUS_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAGE_RECEIVED_value = rightShift(data_low, 6) and &H1
        read_AUTONEG_COMPLETE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 4) and &H1
        read_AUTONEG_ABILITY_value = rightShift(data_low, 3) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PAGE_RECEIVED_value = &H0
        flag_PAGE_RECEIVED        = &H0
        write_AUTONEG_COMPLETE_value = &H0
        flag_AUTONEG_COMPLETE        = &H0
        write_REMOTE_FAULT_value = &H0
        flag_REMOTE_FAULT        = &H0
        write_AUTONEG_ABILITY_value = &H0
        flag_AUTONEG_ABILITY        = &H0
        write_LINK_STATUS_value = &H0
        flag_LINK_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_advertisement_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NEXT_PAGE                                  [15:15]          get_NEXT_PAGE
''                                                             set_NEXT_PAGE
''                                                             read_NEXT_PAGE
''                                                             write_NEXT_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE                                [14:14]          get_ACKNOWLEDGE
''                                                             set_ACKNOWLEDGE
''                                                             read_ACKNOWLEDGE
''                                                             write_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' REMOTE_FAULT                               [13:13]          get_REMOTE_FAULT
''                                                             set_REMOTE_FAULT
''                                                             read_REMOTE_FAULT
''                                                             write_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' FORCE_MASTER_SLAVE                         [12:12]          get_FORCE_MASTER_SLAVE
''                                                             set_FORCE_MASTER_SLAVE
''                                                             read_FORCE_MASTER_SLAVE
''                                                             write_FORCE_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' PAUSE_CAPABILITIES                         [11:10]          get_PAUSE_CAPABILITIES
''                                                             set_PAUSE_CAPABILITIES
''                                                             read_PAUSE_CAPABILITIES
''                                                             write_PAUSE_CAPABILITIES
''---------------------------------------------------------------------------------
'' ECHOED_NONCE_FIELD                         [9:5]            get_ECHOED_NONCE_FIELD
''                                                             set_ECHOED_NONCE_FIELD
''                                                             read_ECHOED_NONCE_FIELD
''                                                             write_ECHOED_NONCE_FIELD
''---------------------------------------------------------------------------------
'' SELECTOR_FIELD                             [4:0]            get_SELECTOR_FIELD
''                                                             set_SELECTOR_FIELD
''                                                             read_SELECTOR_FIELD
''                                                             write_SELECTOR_FIELD
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_advertisement_reg0
    Private write_NEXT_PAGE_value
    Private read_NEXT_PAGE_value
    Private flag_NEXT_PAGE
    Private write_ACKNOWLEDGE_value
    Private read_ACKNOWLEDGE_value
    Private flag_ACKNOWLEDGE
    Private write_REMOTE_FAULT_value
    Private read_REMOTE_FAULT_value
    Private flag_REMOTE_FAULT
    Private write_FORCE_MASTER_SLAVE_value
    Private read_FORCE_MASTER_SLAVE_value
    Private flag_FORCE_MASTER_SLAVE
    Private write_PAUSE_CAPABILITIES_value
    Private read_PAUSE_CAPABILITIES_value
    Private flag_PAUSE_CAPABILITIES
    Private write_ECHOED_NONCE_FIELD_value
    Private read_ECHOED_NONCE_FIELD_value
    Private flag_ECHOED_NONCE_FIELD
    Private write_SELECTOR_FIELD_value
    Private read_SELECTOR_FIELD_value
    Private flag_SELECTOR_FIELD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H404
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NEXT_PAGE
        get_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let set_NEXT_PAGE(aData)
        write_NEXT_PAGE_value = aData
        flag_NEXT_PAGE        = &H1
    End Property

    Property Get read_NEXT_PAGE
        read
        read_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let write_NEXT_PAGE(aData)
        set_NEXT_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE
        get_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let set_ACKNOWLEDGE(aData)
        write_ACKNOWLEDGE_value = aData
        flag_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_ACKNOWLEDGE
        read
        read_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let write_ACKNOWLEDGE(aData)
        set_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_REMOTE_FAULT
        get_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let set_REMOTE_FAULT(aData)
        write_REMOTE_FAULT_value = aData
        flag_REMOTE_FAULT        = &H1
    End Property

    Property Get read_REMOTE_FAULT
        read
        read_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let write_REMOTE_FAULT(aData)
        set_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_FORCE_MASTER_SLAVE
        get_FORCE_MASTER_SLAVE = read_FORCE_MASTER_SLAVE_value
    End Property

    Property Let set_FORCE_MASTER_SLAVE(aData)
        write_FORCE_MASTER_SLAVE_value = aData
        flag_FORCE_MASTER_SLAVE        = &H1
    End Property

    Property Get read_FORCE_MASTER_SLAVE
        read
        read_FORCE_MASTER_SLAVE = read_FORCE_MASTER_SLAVE_value
    End Property

    Property Let write_FORCE_MASTER_SLAVE(aData)
        set_FORCE_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_PAUSE_CAPABILITIES
        get_PAUSE_CAPABILITIES = read_PAUSE_CAPABILITIES_value
    End Property

    Property Let set_PAUSE_CAPABILITIES(aData)
        write_PAUSE_CAPABILITIES_value = aData
        flag_PAUSE_CAPABILITIES        = &H1
    End Property

    Property Get read_PAUSE_CAPABILITIES
        read
        read_PAUSE_CAPABILITIES = read_PAUSE_CAPABILITIES_value
    End Property

    Property Let write_PAUSE_CAPABILITIES(aData)
        set_PAUSE_CAPABILITIES = aData
        write
    End Property

    Property Get get_ECHOED_NONCE_FIELD
        get_ECHOED_NONCE_FIELD = read_ECHOED_NONCE_FIELD_value
    End Property

    Property Let set_ECHOED_NONCE_FIELD(aData)
        write_ECHOED_NONCE_FIELD_value = aData
        flag_ECHOED_NONCE_FIELD        = &H1
    End Property

    Property Get read_ECHOED_NONCE_FIELD
        read
        read_ECHOED_NONCE_FIELD = read_ECHOED_NONCE_FIELD_value
    End Property

    Property Let write_ECHOED_NONCE_FIELD(aData)
        set_ECHOED_NONCE_FIELD = aData
        write
    End Property

    Property Get get_SELECTOR_FIELD
        get_SELECTOR_FIELD = read_SELECTOR_FIELD_value
    End Property

    Property Let set_SELECTOR_FIELD(aData)
        write_SELECTOR_FIELD_value = aData
        flag_SELECTOR_FIELD        = &H1
    End Property

    Property Get read_SELECTOR_FIELD
        read
        read_SELECTOR_FIELD = read_SELECTOR_FIELD_value
    End Property

    Property Let write_SELECTOR_FIELD(aData)
        set_SELECTOR_FIELD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_FORCE_MASTER_SLAVE_value = rightShift(data_low, 12) and &H1
        read_PAUSE_CAPABILITIES_value = rightShift(data_low, 10) and &H3
        read_ECHOED_NONCE_FIELD_value = rightShift(data_low, 5) and &H1f
        SELECTOR_FIELD_mask = &H1f
        if data_low > LONG_MAX then
            if SELECTOR_FIELD_mask = mask then
                read_SELECTOR_FIELD_value = data_low
            else
                read_SELECTOR_FIELD_value = (data_low - H8000_0000) and SELECTOR_FIELD_mask
            end If
        else
            read_SELECTOR_FIELD_value = data_low and SELECTOR_FIELD_mask
        end If

    End Sub

    Sub write
        If flag_NEXT_PAGE = &H0 or flag_ACKNOWLEDGE = &H0 or flag_REMOTE_FAULT = &H0 or flag_FORCE_MASTER_SLAVE = &H0 or flag_PAUSE_CAPABILITIES = &H0 or flag_ECHOED_NONCE_FIELD = &H0 or flag_SELECTOR_FIELD = &H0 Then read
        If flag_NEXT_PAGE = &H0 Then write_NEXT_PAGE_value = get_NEXT_PAGE
        If flag_ACKNOWLEDGE = &H0 Then write_ACKNOWLEDGE_value = get_ACKNOWLEDGE
        If flag_REMOTE_FAULT = &H0 Then write_REMOTE_FAULT_value = get_REMOTE_FAULT
        If flag_FORCE_MASTER_SLAVE = &H0 Then write_FORCE_MASTER_SLAVE_value = get_FORCE_MASTER_SLAVE
        If flag_PAUSE_CAPABILITIES = &H0 Then write_PAUSE_CAPABILITIES_value = get_PAUSE_CAPABILITIES
        If flag_ECHOED_NONCE_FIELD = &H0 Then write_ECHOED_NONCE_FIELD_value = get_ECHOED_NONCE_FIELD
        If flag_SELECTOR_FIELD = &H0 Then write_SELECTOR_FIELD_value = get_SELECTOR_FIELD

        regValue = leftShift((write_NEXT_PAGE_value and &H1), 15) + leftShift((write_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_REMOTE_FAULT_value and &H1), 13) + leftShift((write_FORCE_MASTER_SLAVE_value and &H1), 12) + leftShift((write_PAUSE_CAPABILITIES_value and &H3), 10) + leftShift((write_ECHOED_NONCE_FIELD_value and &H1f), 5) + leftShift((write_SELECTOR_FIELD_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_FORCE_MASTER_SLAVE_value = rightShift(data_low, 12) and &H1
        read_PAUSE_CAPABILITIES_value = rightShift(data_low, 10) and &H3
        read_ECHOED_NONCE_FIELD_value = rightShift(data_low, 5) and &H1f
        SELECTOR_FIELD_mask = &H1f
        if data_low > LONG_MAX then
            if SELECTOR_FIELD_mask = mask then
                read_SELECTOR_FIELD_value = data_low
            else
                read_SELECTOR_FIELD_value = (data_low - H8000_0000) and SELECTOR_FIELD_mask
            end If
        else
            read_SELECTOR_FIELD_value = data_low and SELECTOR_FIELD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NEXT_PAGE_value = &H0
        flag_NEXT_PAGE        = &H0
        write_ACKNOWLEDGE_value = &H0
        flag_ACKNOWLEDGE        = &H0
        write_REMOTE_FAULT_value = &H0
        flag_REMOTE_FAULT        = &H0
        write_FORCE_MASTER_SLAVE_value = &H0
        flag_FORCE_MASTER_SLAVE        = &H0
        write_PAUSE_CAPABILITIES_value = &H0
        flag_PAUSE_CAPABILITIES        = &H0
        write_ECHOED_NONCE_FIELD_value = &H0
        flag_ECHOED_NONCE_FIELD        = &H0
        write_SELECTOR_FIELD_value = &H0
        flag_SELECTOR_FIELD        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_advertisement_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D31_D24                                    [15:8]           get_D31_D24
''                                                             set_D31_D24
''                                                             read_D31_D24
''                                                             write_D31_D24
''---------------------------------------------------------------------------------
'' ADVERISE_1000BASE_T1                       [7:7]            get_ADVERISE_1000BASE_T1
''                                                             set_ADVERISE_1000BASE_T1
''                                                             read_ADVERISE_1000BASE_T1
''                                                             write_ADVERISE_1000BASE_T1
''---------------------------------------------------------------------------------
'' D22                                        [6:6]            get_D22
''                                                             set_D22
''                                                             read_D22
''                                                             write_D22
''---------------------------------------------------------------------------------
'' ADVERISE_100BASE_T1                        [5:5]            get_ADVERISE_100BASE_T1
''                                                             set_ADVERISE_100BASE_T1
''                                                             read_ADVERISE_100BASE_T1
''                                                             write_ADVERISE_100BASE_T1
''---------------------------------------------------------------------------------
'' MASTER_SLAVE                               [4:4]            get_MASTER_SLAVE
''                                                             set_MASTER_SLAVE
''                                                             read_MASTER_SLAVE
''                                                             write_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' TRANSMITTED_NONCE_FIELD                    [3:0]            get_TRANSMITTED_NONCE_FIELD
''                                                             set_TRANSMITTED_NONCE_FIELD
''                                                             read_TRANSMITTED_NONCE_FIELD
''                                                             write_TRANSMITTED_NONCE_FIELD
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_advertisement_reg1
    Private write_D31_D24_value
    Private read_D31_D24_value
    Private flag_D31_D24
    Private write_ADVERISE_1000BASE_T1_value
    Private read_ADVERISE_1000BASE_T1_value
    Private flag_ADVERISE_1000BASE_T1
    Private write_D22_value
    Private read_D22_value
    Private flag_D22
    Private write_ADVERISE_100BASE_T1_value
    Private read_ADVERISE_100BASE_T1_value
    Private flag_ADVERISE_100BASE_T1
    Private write_MASTER_SLAVE_value
    Private read_MASTER_SLAVE_value
    Private flag_MASTER_SLAVE
    Private write_TRANSMITTED_NONCE_FIELD_value
    Private read_TRANSMITTED_NONCE_FIELD_value
    Private flag_TRANSMITTED_NONCE_FIELD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H406
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D31_D24
        get_D31_D24 = read_D31_D24_value
    End Property

    Property Let set_D31_D24(aData)
        write_D31_D24_value = aData
        flag_D31_D24        = &H1
    End Property

    Property Get read_D31_D24
        read
        read_D31_D24 = read_D31_D24_value
    End Property

    Property Let write_D31_D24(aData)
        set_D31_D24 = aData
        write
    End Property

    Property Get get_ADVERISE_1000BASE_T1
        get_ADVERISE_1000BASE_T1 = read_ADVERISE_1000BASE_T1_value
    End Property

    Property Let set_ADVERISE_1000BASE_T1(aData)
        write_ADVERISE_1000BASE_T1_value = aData
        flag_ADVERISE_1000BASE_T1        = &H1
    End Property

    Property Get read_ADVERISE_1000BASE_T1
        read
        read_ADVERISE_1000BASE_T1 = read_ADVERISE_1000BASE_T1_value
    End Property

    Property Let write_ADVERISE_1000BASE_T1(aData)
        set_ADVERISE_1000BASE_T1 = aData
        write
    End Property

    Property Get get_D22
        get_D22 = read_D22_value
    End Property

    Property Let set_D22(aData)
        write_D22_value = aData
        flag_D22        = &H1
    End Property

    Property Get read_D22
        read
        read_D22 = read_D22_value
    End Property

    Property Let write_D22(aData)
        set_D22 = aData
        write
    End Property

    Property Get get_ADVERISE_100BASE_T1
        get_ADVERISE_100BASE_T1 = read_ADVERISE_100BASE_T1_value
    End Property

    Property Let set_ADVERISE_100BASE_T1(aData)
        write_ADVERISE_100BASE_T1_value = aData
        flag_ADVERISE_100BASE_T1        = &H1
    End Property

    Property Get read_ADVERISE_100BASE_T1
        read
        read_ADVERISE_100BASE_T1 = read_ADVERISE_100BASE_T1_value
    End Property

    Property Let write_ADVERISE_100BASE_T1(aData)
        set_ADVERISE_100BASE_T1 = aData
        write
    End Property

    Property Get get_MASTER_SLAVE
        get_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let set_MASTER_SLAVE(aData)
        write_MASTER_SLAVE_value = aData
        flag_MASTER_SLAVE        = &H1
    End Property

    Property Get read_MASTER_SLAVE
        read
        read_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let write_MASTER_SLAVE(aData)
        set_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_TRANSMITTED_NONCE_FIELD
        get_TRANSMITTED_NONCE_FIELD = read_TRANSMITTED_NONCE_FIELD_value
    End Property

    Property Let set_TRANSMITTED_NONCE_FIELD(aData)
        write_TRANSMITTED_NONCE_FIELD_value = aData
        flag_TRANSMITTED_NONCE_FIELD        = &H1
    End Property

    Property Get read_TRANSMITTED_NONCE_FIELD
        read
        read_TRANSMITTED_NONCE_FIELD = read_TRANSMITTED_NONCE_FIELD_value
    End Property

    Property Let write_TRANSMITTED_NONCE_FIELD(aData)
        set_TRANSMITTED_NONCE_FIELD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_D31_D24_value = rightShift(data_low, 8) and &Hff
        read_ADVERISE_1000BASE_T1_value = rightShift(data_low, 7) and &H1
        read_D22_value = rightShift(data_low, 6) and &H1
        read_ADVERISE_100BASE_T1_value = rightShift(data_low, 5) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 4) and &H1
        TRANSMITTED_NONCE_FIELD_mask = &Hf
        if data_low > LONG_MAX then
            if TRANSMITTED_NONCE_FIELD_mask = mask then
                read_TRANSMITTED_NONCE_FIELD_value = data_low
            else
                read_TRANSMITTED_NONCE_FIELD_value = (data_low - H8000_0000) and TRANSMITTED_NONCE_FIELD_mask
            end If
        else
            read_TRANSMITTED_NONCE_FIELD_value = data_low and TRANSMITTED_NONCE_FIELD_mask
        end If

    End Sub

    Sub write
        If flag_D31_D24 = &H0 or flag_ADVERISE_1000BASE_T1 = &H0 or flag_D22 = &H0 or flag_ADVERISE_100BASE_T1 = &H0 or flag_MASTER_SLAVE = &H0 or flag_TRANSMITTED_NONCE_FIELD = &H0 Then read
        If flag_D31_D24 = &H0 Then write_D31_D24_value = get_D31_D24
        If flag_ADVERISE_1000BASE_T1 = &H0 Then write_ADVERISE_1000BASE_T1_value = get_ADVERISE_1000BASE_T1
        If flag_D22 = &H0 Then write_D22_value = get_D22
        If flag_ADVERISE_100BASE_T1 = &H0 Then write_ADVERISE_100BASE_T1_value = get_ADVERISE_100BASE_T1
        If flag_MASTER_SLAVE = &H0 Then write_MASTER_SLAVE_value = get_MASTER_SLAVE
        If flag_TRANSMITTED_NONCE_FIELD = &H0 Then write_TRANSMITTED_NONCE_FIELD_value = get_TRANSMITTED_NONCE_FIELD

        regValue = leftShift((write_D31_D24_value and &Hff), 8) + leftShift((write_ADVERISE_1000BASE_T1_value and &H1), 7) + leftShift((write_D22_value and &H1), 6) + leftShift((write_ADVERISE_100BASE_T1_value and &H1), 5) + leftShift((write_MASTER_SLAVE_value and &H1), 4) + leftShift((write_TRANSMITTED_NONCE_FIELD_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_D31_D24_value = rightShift(data_low, 8) and &Hff
        read_ADVERISE_1000BASE_T1_value = rightShift(data_low, 7) and &H1
        read_D22_value = rightShift(data_low, 6) and &H1
        read_ADVERISE_100BASE_T1_value = rightShift(data_low, 5) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 4) and &H1
        TRANSMITTED_NONCE_FIELD_mask = &Hf
        if data_low > LONG_MAX then
            if TRANSMITTED_NONCE_FIELD_mask = mask then
                read_TRANSMITTED_NONCE_FIELD_value = data_low
            else
                read_TRANSMITTED_NONCE_FIELD_value = (data_low - H8000_0000) and TRANSMITTED_NONCE_FIELD_mask
            end If
        else
            read_TRANSMITTED_NONCE_FIELD_value = data_low and TRANSMITTED_NONCE_FIELD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D31_D24_value = &H0
        flag_D31_D24        = &H0
        write_ADVERISE_1000BASE_T1_value = &H0
        flag_ADVERISE_1000BASE_T1        = &H0
        write_D22_value = &H0
        flag_D22        = &H0
        write_ADVERISE_100BASE_T1_value = &H0
        flag_ADVERISE_100BASE_T1        = &H0
        write_MASTER_SLAVE_value = &H0
        flag_MASTER_SLAVE        = &H0
        write_TRANSMITTED_NONCE_FIELD_value = &H0
        flag_TRANSMITTED_NONCE_FIELD        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_advertisement_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D47_D32                                    [15:0]           get_D47_D32
''                                                             set_D47_D32
''                                                             read_D47_D32
''                                                             write_D47_D32
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_advertisement_reg2
    Private write_D47_D32_value
    Private read_D47_D32_value
    Private flag_D47_D32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D47_D32
        get_D47_D32 = read_D47_D32_value
    End Property

    Property Let set_D47_D32(aData)
        write_D47_D32_value = aData
        flag_D47_D32        = &H1
    End Property

    Property Get read_D47_D32
        read
        read_D47_D32 = read_D47_D32_value
    End Property

    Property Let write_D47_D32(aData)
        set_D47_D32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

    End Sub

    Sub write
        If flag_D47_D32 = &H0 Then read
        If flag_D47_D32 = &H0 Then write_D47_D32_value = get_D47_D32

        regValue = leftShift((write_D47_D32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D47_D32_value = &H0
        flag_D47_D32        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D15_D0                                     [15:0]           get_D15_D0
''                                                             set_D15_D0
''                                                             read_D15_D0
''                                                             write_D15_D0
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg0
    Private write_D15_D0_value
    Private read_D15_D0_value
    Private flag_D15_D0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D15_D0
        get_D15_D0 = read_D15_D0_value
    End Property

    Property Let set_D15_D0(aData)
        write_D15_D0_value = aData
        flag_D15_D0        = &H1
    End Property

    Property Get read_D15_D0
        read
        read_D15_D0 = read_D15_D0_value
    End Property

    Property Let write_D15_D0(aData)
        set_D15_D0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D15_D0_mask = &Hffff
        if data_low > LONG_MAX then
            if D15_D0_mask = mask then
                read_D15_D0_value = data_low
            else
                read_D15_D0_value = (data_low - H8000_0000) and D15_D0_mask
            end If
        else
            read_D15_D0_value = data_low and D15_D0_mask
        end If

    End Sub

    Sub write
        If flag_D15_D0 = &H0 Then read
        If flag_D15_D0 = &H0 Then write_D15_D0_value = get_D15_D0

        regValue = leftShift((write_D15_D0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D15_D0_mask = &Hffff
        if data_low > LONG_MAX then
            if D15_D0_mask = mask then
                read_D15_D0_value = data_low
            else
                read_D15_D0_value = (data_low - H8000_0000) and D15_D0_mask
            end If
        else
            read_D15_D0_value = data_low and D15_D0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D15_D0_value = &H0
        flag_D15_D0        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D31_D16                                    [15:0]           get_D31_D16
''                                                             set_D31_D16
''                                                             read_D31_D16
''                                                             write_D31_D16
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg1
    Private write_D31_D16_value
    Private read_D31_D16_value
    Private flag_D31_D16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D31_D16
        get_D31_D16 = read_D31_D16_value
    End Property

    Property Let set_D31_D16(aData)
        write_D31_D16_value = aData
        flag_D31_D16        = &H1
    End Property

    Property Get read_D31_D16
        read
        read_D31_D16 = read_D31_D16_value
    End Property

    Property Let write_D31_D16(aData)
        set_D31_D16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D31_D16_mask = &Hffff
        if data_low > LONG_MAX then
            if D31_D16_mask = mask then
                read_D31_D16_value = data_low
            else
                read_D31_D16_value = (data_low - H8000_0000) and D31_D16_mask
            end If
        else
            read_D31_D16_value = data_low and D31_D16_mask
        end If

    End Sub

    Sub write
        If flag_D31_D16 = &H0 Then read
        If flag_D31_D16 = &H0 Then write_D31_D16_value = get_D31_D16

        regValue = leftShift((write_D31_D16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D31_D16_mask = &Hffff
        if data_low > LONG_MAX then
            if D31_D16_mask = mask then
                read_D31_D16_value = data_low
            else
                read_D31_D16_value = (data_low - H8000_0000) and D31_D16_mask
            end If
        else
            read_D31_D16_value = data_low and D31_D16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D31_D16_value = &H0
        flag_D31_D16        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D47_D32                                    [15:0]           get_D47_D32
''                                                             set_D47_D32
''                                                             read_D47_D32
''                                                             write_D47_D32
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg2
    Private write_D47_D32_value
    Private read_D47_D32_value
    Private flag_D47_D32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D47_D32
        get_D47_D32 = read_D47_D32_value
    End Property

    Property Let set_D47_D32(aData)
        write_D47_D32_value = aData
        flag_D47_D32        = &H1
    End Property

    Property Get read_D47_D32
        read
        read_D47_D32 = read_D47_D32_value
    End Property

    Property Let write_D47_D32(aData)
        set_D47_D32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

    End Sub

    Sub write
        If flag_D47_D32 = &H0 Then read
        If flag_D47_D32 = &H0 Then write_D47_D32_value = get_D47_D32

        regValue = leftShift((write_D47_D32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D47_D32_value = &H0
        flag_D47_D32        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_next_page_transmit_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NEXT_PAGE                                  [15:15]          get_NEXT_PAGE
''                                                             set_NEXT_PAGE
''                                                             read_NEXT_PAGE
''                                                             write_NEXT_PAGE
''---------------------------------------------------------------------------------
'' MESSAGE_PAGE                               [13:13]          get_MESSAGE_PAGE
''                                                             set_MESSAGE_PAGE
''                                                             read_MESSAGE_PAGE
''                                                             write_MESSAGE_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE2                               [12:12]          get_ACKNOWLEDGE2
''                                                             set_ACKNOWLEDGE2
''                                                             read_ACKNOWLEDGE2
''                                                             write_ACKNOWLEDGE2
''---------------------------------------------------------------------------------
'' TOGGLE                                     [11:11]          get_TOGGLE
''                                                             set_TOGGLE
''                                                             read_TOGGLE
''                                                             write_TOGGLE
''---------------------------------------------------------------------------------
'' MUCF                                       [10:0]           get_MUCF
''                                                             set_MUCF
''                                                             read_MUCF
''                                                             write_MUCF
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_next_page_transmit_reg0
    Private write_NEXT_PAGE_value
    Private read_NEXT_PAGE_value
    Private flag_NEXT_PAGE
    Private write_MESSAGE_PAGE_value
    Private read_MESSAGE_PAGE_value
    Private flag_MESSAGE_PAGE
    Private write_ACKNOWLEDGE2_value
    Private read_ACKNOWLEDGE2_value
    Private flag_ACKNOWLEDGE2
    Private write_TOGGLE_value
    Private read_TOGGLE_value
    Private flag_TOGGLE
    Private write_MUCF_value
    Private read_MUCF_value
    Private flag_MUCF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H410
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NEXT_PAGE
        get_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let set_NEXT_PAGE(aData)
        write_NEXT_PAGE_value = aData
        flag_NEXT_PAGE        = &H1
    End Property

    Property Get read_NEXT_PAGE
        read
        read_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let write_NEXT_PAGE(aData)
        set_NEXT_PAGE = aData
        write
    End Property

    Property Get get_MESSAGE_PAGE
        get_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let set_MESSAGE_PAGE(aData)
        write_MESSAGE_PAGE_value = aData
        flag_MESSAGE_PAGE        = &H1
    End Property

    Property Get read_MESSAGE_PAGE
        read
        read_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let write_MESSAGE_PAGE(aData)
        set_MESSAGE_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE2
        get_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let set_ACKNOWLEDGE2(aData)
        write_ACKNOWLEDGE2_value = aData
        flag_ACKNOWLEDGE2        = &H1
    End Property

    Property Get read_ACKNOWLEDGE2
        read
        read_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let write_ACKNOWLEDGE2(aData)
        set_ACKNOWLEDGE2 = aData
        write
    End Property

    Property Get get_TOGGLE
        get_TOGGLE = read_TOGGLE_value
    End Property

    Property Let set_TOGGLE(aData)
        write_TOGGLE_value = aData
        flag_TOGGLE        = &H1
    End Property

    Property Get read_TOGGLE
        read
        read_TOGGLE = read_TOGGLE_value
    End Property

    Property Let write_TOGGLE(aData)
        set_TOGGLE = aData
        write
    End Property

    Property Get get_MUCF
        get_MUCF = read_MUCF_value
    End Property

    Property Let set_MUCF(aData)
        write_MUCF_value = aData
        flag_MUCF        = &H1
    End Property

    Property Get read_MUCF
        read
        read_MUCF = read_MUCF_value
    End Property

    Property Let write_MUCF(aData)
        set_MUCF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MUCF_mask = &H7ff
        if data_low > LONG_MAX then
            if MUCF_mask = mask then
                read_MUCF_value = data_low
            else
                read_MUCF_value = (data_low - H8000_0000) and MUCF_mask
            end If
        else
            read_MUCF_value = data_low and MUCF_mask
        end If

    End Sub

    Sub write
        If flag_NEXT_PAGE = &H0 or flag_MESSAGE_PAGE = &H0 or flag_ACKNOWLEDGE2 = &H0 or flag_TOGGLE = &H0 or flag_MUCF = &H0 Then read
        If flag_NEXT_PAGE = &H0 Then write_NEXT_PAGE_value = get_NEXT_PAGE
        If flag_MESSAGE_PAGE = &H0 Then write_MESSAGE_PAGE_value = get_MESSAGE_PAGE
        If flag_ACKNOWLEDGE2 = &H0 Then write_ACKNOWLEDGE2_value = get_ACKNOWLEDGE2
        If flag_TOGGLE = &H0 Then write_TOGGLE_value = get_TOGGLE
        If flag_MUCF = &H0 Then write_MUCF_value = get_MUCF

        regValue = leftShift((write_NEXT_PAGE_value and &H1), 15) + leftShift((write_MESSAGE_PAGE_value and &H1), 13) + leftShift((write_ACKNOWLEDGE2_value and &H1), 12) + leftShift((write_TOGGLE_value and &H1), 11) + leftShift((write_MUCF_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MUCF_mask = &H7ff
        if data_low > LONG_MAX then
            if MUCF_mask = mask then
                read_MUCF_value = data_low
            else
                read_MUCF_value = (data_low - H8000_0000) and MUCF_mask
            end If
        else
            read_MUCF_value = data_low and MUCF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NEXT_PAGE_value = &H0
        flag_NEXT_PAGE        = &H0
        write_MESSAGE_PAGE_value = &H0
        flag_MESSAGE_PAGE        = &H0
        write_ACKNOWLEDGE2_value = &H0
        flag_ACKNOWLEDGE2        = &H0
        write_TOGGLE_value = &H0
        flag_TOGGLE        = &H0
        write_MUCF_value = &H0
        flag_MUCF        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_next_page_transmit_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_1                   [15:0]           get_UNFORMATTED_CODE_FIELD_1
''                                                             set_UNFORMATTED_CODE_FIELD_1
''                                                             read_UNFORMATTED_CODE_FIELD_1
''                                                             write_UNFORMATTED_CODE_FIELD_1
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_next_page_transmit_reg1
    Private write_UNFORMATTED_CODE_FIELD_1_value
    Private read_UNFORMATTED_CODE_FIELD_1_value
    Private flag_UNFORMATTED_CODE_FIELD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H412
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_1
        get_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_1(aData)
        write_UNFORMATTED_CODE_FIELD_1_value = aData
        flag_UNFORMATTED_CODE_FIELD_1        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_1
        read
        read_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_1(aData)
        set_UNFORMATTED_CODE_FIELD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then write_UNFORMATTED_CODE_FIELD_1_value = get_UNFORMATTED_CODE_FIELD_1

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_1_value = &H0
        flag_UNFORMATTED_CODE_FIELD_1        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_next_page_transmit_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_2                   [15:0]           get_UNFORMATTED_CODE_FIELD_2
''                                                             set_UNFORMATTED_CODE_FIELD_2
''                                                             read_UNFORMATTED_CODE_FIELD_2
''                                                             write_UNFORMATTED_CODE_FIELD_2
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_next_page_transmit_reg2
    Private write_UNFORMATTED_CODE_FIELD_2_value
    Private read_UNFORMATTED_CODE_FIELD_2_value
    Private flag_UNFORMATTED_CODE_FIELD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_2
        get_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_2(aData)
        write_UNFORMATTED_CODE_FIELD_2_value = aData
        flag_UNFORMATTED_CODE_FIELD_2        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_2
        read
        read_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_2(aData)
        set_UNFORMATTED_CODE_FIELD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then write_UNFORMATTED_CODE_FIELD_2_value = get_UNFORMATTED_CODE_FIELD_2

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_2_value = &H0
        flag_UNFORMATTED_CODE_FIELD_2        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NEXT_PAGE                                  [15:15]          get_NEXT_PAGE
''                                                             set_NEXT_PAGE
''                                                             read_NEXT_PAGE
''                                                             write_NEXT_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE                                [14:14]          get_ACKNOWLEDGE
''                                                             set_ACKNOWLEDGE
''                                                             read_ACKNOWLEDGE
''                                                             write_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' MESSAGE_PAGE                               [13:13]          get_MESSAGE_PAGE
''                                                             set_MESSAGE_PAGE
''                                                             read_MESSAGE_PAGE
''                                                             write_MESSAGE_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE2                               [12:12]          get_ACKNOWLEDGE2
''                                                             set_ACKNOWLEDGE2
''                                                             read_ACKNOWLEDGE2
''                                                             write_ACKNOWLEDGE2
''---------------------------------------------------------------------------------
'' TOGGLE                                     [11:11]          get_TOGGLE
''                                                             set_TOGGLE
''                                                             read_TOGGLE
''                                                             write_TOGGLE
''---------------------------------------------------------------------------------
'' MUCF1                                      [10:0]           get_MUCF1
''                                                             set_MUCF1
''                                                             read_MUCF1
''                                                             write_MUCF1
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg0
    Private write_NEXT_PAGE_value
    Private read_NEXT_PAGE_value
    Private flag_NEXT_PAGE
    Private write_ACKNOWLEDGE_value
    Private read_ACKNOWLEDGE_value
    Private flag_ACKNOWLEDGE
    Private write_MESSAGE_PAGE_value
    Private read_MESSAGE_PAGE_value
    Private flag_MESSAGE_PAGE
    Private write_ACKNOWLEDGE2_value
    Private read_ACKNOWLEDGE2_value
    Private flag_ACKNOWLEDGE2
    Private write_TOGGLE_value
    Private read_TOGGLE_value
    Private flag_TOGGLE
    Private write_MUCF1_value
    Private read_MUCF1_value
    Private flag_MUCF1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H416
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NEXT_PAGE
        get_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let set_NEXT_PAGE(aData)
        write_NEXT_PAGE_value = aData
        flag_NEXT_PAGE        = &H1
    End Property

    Property Get read_NEXT_PAGE
        read
        read_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let write_NEXT_PAGE(aData)
        set_NEXT_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE
        get_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let set_ACKNOWLEDGE(aData)
        write_ACKNOWLEDGE_value = aData
        flag_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_ACKNOWLEDGE
        read
        read_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let write_ACKNOWLEDGE(aData)
        set_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_MESSAGE_PAGE
        get_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let set_MESSAGE_PAGE(aData)
        write_MESSAGE_PAGE_value = aData
        flag_MESSAGE_PAGE        = &H1
    End Property

    Property Get read_MESSAGE_PAGE
        read
        read_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let write_MESSAGE_PAGE(aData)
        set_MESSAGE_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE2
        get_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let set_ACKNOWLEDGE2(aData)
        write_ACKNOWLEDGE2_value = aData
        flag_ACKNOWLEDGE2        = &H1
    End Property

    Property Get read_ACKNOWLEDGE2
        read
        read_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let write_ACKNOWLEDGE2(aData)
        set_ACKNOWLEDGE2 = aData
        write
    End Property

    Property Get get_TOGGLE
        get_TOGGLE = read_TOGGLE_value
    End Property

    Property Let set_TOGGLE(aData)
        write_TOGGLE_value = aData
        flag_TOGGLE        = &H1
    End Property

    Property Get read_TOGGLE
        read
        read_TOGGLE = read_TOGGLE_value
    End Property

    Property Let write_TOGGLE(aData)
        set_TOGGLE = aData
        write
    End Property

    Property Get get_MUCF1
        get_MUCF1 = read_MUCF1_value
    End Property

    Property Let set_MUCF1(aData)
        write_MUCF1_value = aData
        flag_MUCF1        = &H1
    End Property

    Property Get read_MUCF1
        read
        read_MUCF1 = read_MUCF1_value
    End Property

    Property Let write_MUCF1(aData)
        set_MUCF1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MUCF1_mask = &H7ff
        if data_low > LONG_MAX then
            if MUCF1_mask = mask then
                read_MUCF1_value = data_low
            else
                read_MUCF1_value = (data_low - H8000_0000) and MUCF1_mask
            end If
        else
            read_MUCF1_value = data_low and MUCF1_mask
        end If

    End Sub

    Sub write
        If flag_NEXT_PAGE = &H0 or flag_ACKNOWLEDGE = &H0 or flag_MESSAGE_PAGE = &H0 or flag_ACKNOWLEDGE2 = &H0 or flag_TOGGLE = &H0 or flag_MUCF1 = &H0 Then read
        If flag_NEXT_PAGE = &H0 Then write_NEXT_PAGE_value = get_NEXT_PAGE
        If flag_ACKNOWLEDGE = &H0 Then write_ACKNOWLEDGE_value = get_ACKNOWLEDGE
        If flag_MESSAGE_PAGE = &H0 Then write_MESSAGE_PAGE_value = get_MESSAGE_PAGE
        If flag_ACKNOWLEDGE2 = &H0 Then write_ACKNOWLEDGE2_value = get_ACKNOWLEDGE2
        If flag_TOGGLE = &H0 Then write_TOGGLE_value = get_TOGGLE
        If flag_MUCF1 = &H0 Then write_MUCF1_value = get_MUCF1

        regValue = leftShift((write_NEXT_PAGE_value and &H1), 15) + leftShift((write_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_MESSAGE_PAGE_value and &H1), 13) + leftShift((write_ACKNOWLEDGE2_value and &H1), 12) + leftShift((write_TOGGLE_value and &H1), 11) + leftShift((write_MUCF1_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MUCF1_mask = &H7ff
        if data_low > LONG_MAX then
            if MUCF1_mask = mask then
                read_MUCF1_value = data_low
            else
                read_MUCF1_value = (data_low - H8000_0000) and MUCF1_mask
            end If
        else
            read_MUCF1_value = data_low and MUCF1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NEXT_PAGE_value = &H0
        flag_NEXT_PAGE        = &H0
        write_ACKNOWLEDGE_value = &H0
        flag_ACKNOWLEDGE        = &H0
        write_MESSAGE_PAGE_value = &H0
        flag_MESSAGE_PAGE        = &H0
        write_ACKNOWLEDGE2_value = &H0
        flag_ACKNOWLEDGE2        = &H0
        write_TOGGLE_value = &H0
        flag_TOGGLE        = &H0
        write_MUCF1_value = &H0
        flag_MUCF1        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_1                   [15:0]           get_UNFORMATTED_CODE_FIELD_1
''                                                             set_UNFORMATTED_CODE_FIELD_1
''                                                             read_UNFORMATTED_CODE_FIELD_1
''                                                             write_UNFORMATTED_CODE_FIELD_1
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg1
    Private write_UNFORMATTED_CODE_FIELD_1_value
    Private read_UNFORMATTED_CODE_FIELD_1_value
    Private flag_UNFORMATTED_CODE_FIELD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H418
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_1
        get_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_1(aData)
        write_UNFORMATTED_CODE_FIELD_1_value = aData
        flag_UNFORMATTED_CODE_FIELD_1        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_1
        read
        read_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_1(aData)
        set_UNFORMATTED_CODE_FIELD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then write_UNFORMATTED_CODE_FIELD_1_value = get_UNFORMATTED_CODE_FIELD_1

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_1_value = &H0
        flag_UNFORMATTED_CODE_FIELD_1        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_2                   [15:0]           get_UNFORMATTED_CODE_FIELD_2
''                                                             set_UNFORMATTED_CODE_FIELD_2
''                                                             read_UNFORMATTED_CODE_FIELD_2
''                                                             write_UNFORMATTED_CODE_FIELD_2
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg2
    Private write_UNFORMATTED_CODE_FIELD_2_value
    Private read_UNFORMATTED_CODE_FIELD_2_value
    Private flag_UNFORMATTED_CODE_FIELD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H41a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_2
        get_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_2(aData)
        write_UNFORMATTED_CODE_FIELD_2_value = aData
        flag_UNFORMATTED_CODE_FIELD_2        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_2
        read
        read_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_2(aData)
        set_UNFORMATTED_CODE_FIELD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then write_UNFORMATTED_CODE_FIELD_2_value = get_UNFORMATTED_CODE_FIELD_2

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_2_value = &H0
        flag_UNFORMATTED_CODE_FIELD_2        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_ENABLE                   [15:15]          get_AUTONEG_WIRESPEED_ENABLE
''                                                             set_AUTONEG_WIRESPEED_ENABLE
''                                                             read_AUTONEG_WIRESPEED_ENABLE
''                                                             write_AUTONEG_WIRESPEED_ENABLE
''---------------------------------------------------------------------------------
'' AUTONEG_TEST_REG0_BIT_14                   [14:14]          get_AUTONEG_TEST_REG0_BIT_14
''                                                             set_AUTONEG_TEST_REG0_BIT_14
''                                                             read_AUTONEG_TEST_REG0_BIT_14
''                                                             write_AUTONEG_TEST_REG0_BIT_14
''---------------------------------------------------------------------------------
'' ADIDIACA                                   [13:13]          get_ADIDIACA
''                                                             set_ADIDIACA
''                                                             read_ADIDIACA
''                                                             write_ADIDIACA
''---------------------------------------------------------------------------------
'' ALFIDF                                     [12:12]          get_ALFIDF
''                                                             set_ALFIDF
''                                                             read_ALFIDF
''                                                             write_ALFIDF
''---------------------------------------------------------------------------------
'' AUTONEG_MESSAGE_5_ENABLE                   [11:11]          get_AUTONEG_MESSAGE_5_ENABLE
''                                                             set_AUTONEG_MESSAGE_5_ENABLE
''                                                             read_AUTONEG_MESSAGE_5_ENABLE
''                                                             write_AUTONEG_MESSAGE_5_ENABLE
''---------------------------------------------------------------------------------
'' ADRWCA                                     [10:10]          get_ADRWCA
''                                                             set_ADRWCA
''                                                             read_ADRWCA
''                                                             write_ADRWCA
''---------------------------------------------------------------------------------
'' ABLTM                                      [9:8]            get_ABLTM
''                                                             set_ABLTM
''                                                             read_ABLTM
''                                                             write_ABLTM
''---------------------------------------------------------------------------------
'' ALFITM                                     [7:4]            get_ALFITM
''                                                             set_ALFITM
''                                                             read_ALFITM
''                                                             write_ALFITM
''---------------------------------------------------------------------------------
'' ALFITF                                     [3:3]            get_ALFITF
''                                                             set_ALFITF
''                                                             read_ALFITF
''                                                             write_ALFITF
''---------------------------------------------------------------------------------
'' AWAN                                       [2:0]            get_AWAN
''                                                             set_AWAN
''                                                             read_AWAN
''                                                             write_AWAN
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg0
    Private write_AUTONEG_WIRESPEED_ENABLE_value
    Private read_AUTONEG_WIRESPEED_ENABLE_value
    Private flag_AUTONEG_WIRESPEED_ENABLE
    Private write_AUTONEG_TEST_REG0_BIT_14_value
    Private read_AUTONEG_TEST_REG0_BIT_14_value
    Private flag_AUTONEG_TEST_REG0_BIT_14
    Private write_ADIDIACA_value
    Private read_ADIDIACA_value
    Private flag_ADIDIACA
    Private write_ALFIDF_value
    Private read_ALFIDF_value
    Private flag_ALFIDF
    Private write_AUTONEG_MESSAGE_5_ENABLE_value
    Private read_AUTONEG_MESSAGE_5_ENABLE_value
    Private flag_AUTONEG_MESSAGE_5_ENABLE
    Private write_ADRWCA_value
    Private read_ADRWCA_value
    Private flag_ADRWCA
    Private write_ABLTM_value
    Private read_ABLTM_value
    Private flag_ABLTM
    Private write_ALFITM_value
    Private read_ALFITM_value
    Private flag_ALFITM
    Private write_ALFITF_value
    Private read_ALFITF_value
    Private flag_ALFITF
    Private write_AWAN_value
    Private read_AWAN_value
    Private flag_AWAN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AUTONEG_WIRESPEED_ENABLE
        get_AUTONEG_WIRESPEED_ENABLE = read_AUTONEG_WIRESPEED_ENABLE_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_ENABLE(aData)
        write_AUTONEG_WIRESPEED_ENABLE_value = aData
        flag_AUTONEG_WIRESPEED_ENABLE        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_ENABLE
        read
        read_AUTONEG_WIRESPEED_ENABLE = read_AUTONEG_WIRESPEED_ENABLE_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_ENABLE(aData)
        set_AUTONEG_WIRESPEED_ENABLE = aData
        write
    End Property

    Property Get get_AUTONEG_TEST_REG0_BIT_14
        get_AUTONEG_TEST_REG0_BIT_14 = read_AUTONEG_TEST_REG0_BIT_14_value
    End Property

    Property Let set_AUTONEG_TEST_REG0_BIT_14(aData)
        write_AUTONEG_TEST_REG0_BIT_14_value = aData
        flag_AUTONEG_TEST_REG0_BIT_14        = &H1
    End Property

    Property Get read_AUTONEG_TEST_REG0_BIT_14
        read
        read_AUTONEG_TEST_REG0_BIT_14 = read_AUTONEG_TEST_REG0_BIT_14_value
    End Property

    Property Let write_AUTONEG_TEST_REG0_BIT_14(aData)
        set_AUTONEG_TEST_REG0_BIT_14 = aData
        write
    End Property

    Property Get get_ADIDIACA
        get_ADIDIACA = read_ADIDIACA_value
    End Property

    Property Let set_ADIDIACA(aData)
        write_ADIDIACA_value = aData
        flag_ADIDIACA        = &H1
    End Property

    Property Get read_ADIDIACA
        read
        read_ADIDIACA = read_ADIDIACA_value
    End Property

    Property Let write_ADIDIACA(aData)
        set_ADIDIACA = aData
        write
    End Property

    Property Get get_ALFIDF
        get_ALFIDF = read_ALFIDF_value
    End Property

    Property Let set_ALFIDF(aData)
        write_ALFIDF_value = aData
        flag_ALFIDF        = &H1
    End Property

    Property Get read_ALFIDF
        read
        read_ALFIDF = read_ALFIDF_value
    End Property

    Property Let write_ALFIDF(aData)
        set_ALFIDF = aData
        write
    End Property

    Property Get get_AUTONEG_MESSAGE_5_ENABLE
        get_AUTONEG_MESSAGE_5_ENABLE = read_AUTONEG_MESSAGE_5_ENABLE_value
    End Property

    Property Let set_AUTONEG_MESSAGE_5_ENABLE(aData)
        write_AUTONEG_MESSAGE_5_ENABLE_value = aData
        flag_AUTONEG_MESSAGE_5_ENABLE        = &H1
    End Property

    Property Get read_AUTONEG_MESSAGE_5_ENABLE
        read
        read_AUTONEG_MESSAGE_5_ENABLE = read_AUTONEG_MESSAGE_5_ENABLE_value
    End Property

    Property Let write_AUTONEG_MESSAGE_5_ENABLE(aData)
        set_AUTONEG_MESSAGE_5_ENABLE = aData
        write
    End Property

    Property Get get_ADRWCA
        get_ADRWCA = read_ADRWCA_value
    End Property

    Property Let set_ADRWCA(aData)
        write_ADRWCA_value = aData
        flag_ADRWCA        = &H1
    End Property

    Property Get read_ADRWCA
        read
        read_ADRWCA = read_ADRWCA_value
    End Property

    Property Let write_ADRWCA(aData)
        set_ADRWCA = aData
        write
    End Property

    Property Get get_ABLTM
        get_ABLTM = read_ABLTM_value
    End Property

    Property Let set_ABLTM(aData)
        write_ABLTM_value = aData
        flag_ABLTM        = &H1
    End Property

    Property Get read_ABLTM
        read
        read_ABLTM = read_ABLTM_value
    End Property

    Property Let write_ABLTM(aData)
        set_ABLTM = aData
        write
    End Property

    Property Get get_ALFITM
        get_ALFITM = read_ALFITM_value
    End Property

    Property Let set_ALFITM(aData)
        write_ALFITM_value = aData
        flag_ALFITM        = &H1
    End Property

    Property Get read_ALFITM
        read
        read_ALFITM = read_ALFITM_value
    End Property

    Property Let write_ALFITM(aData)
        set_ALFITM = aData
        write
    End Property

    Property Get get_ALFITF
        get_ALFITF = read_ALFITF_value
    End Property

    Property Let set_ALFITF(aData)
        write_ALFITF_value = aData
        flag_ALFITF        = &H1
    End Property

    Property Get read_ALFITF
        read
        read_ALFITF = read_ALFITF_value
    End Property

    Property Let write_ALFITF(aData)
        set_ALFITF = aData
        write
    End Property

    Property Get get_AWAN
        get_AWAN = read_AWAN_value
    End Property

    Property Let set_AWAN(aData)
        write_AWAN_value = aData
        flag_AWAN        = &H1
    End Property

    Property Get read_AWAN
        read
        read_AWAN = read_AWAN_value
    End Property

    Property Let write_AWAN(aData)
        set_AWAN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_WIRESPEED_ENABLE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_TEST_REG0_BIT_14_value = rightShift(data_low, 14) and &H1
        read_ADIDIACA_value = rightShift(data_low, 13) and &H1
        read_ALFIDF_value = rightShift(data_low, 12) and &H1
        read_AUTONEG_MESSAGE_5_ENABLE_value = rightShift(data_low, 11) and &H1
        read_ADRWCA_value = rightShift(data_low, 10) and &H1
        read_ABLTM_value = rightShift(data_low, 8) and &H3
        read_ALFITM_value = rightShift(data_low, 4) and &Hf
        read_ALFITF_value = rightShift(data_low, 3) and &H1
        AWAN_mask = &H7
        if data_low > LONG_MAX then
            if AWAN_mask = mask then
                read_AWAN_value = data_low
            else
                read_AWAN_value = (data_low - H8000_0000) and AWAN_mask
            end If
        else
            read_AWAN_value = data_low and AWAN_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_WIRESPEED_ENABLE = &H0 or flag_AUTONEG_TEST_REG0_BIT_14 = &H0 or flag_ADIDIACA = &H0 or flag_ALFIDF = &H0 or flag_AUTONEG_MESSAGE_5_ENABLE = &H0 or flag_ADRWCA = &H0 or flag_ABLTM = &H0 or flag_ALFITM = &H0 or flag_ALFITF = &H0 or flag_AWAN = &H0 Then read
        If flag_AUTONEG_WIRESPEED_ENABLE = &H0 Then write_AUTONEG_WIRESPEED_ENABLE_value = get_AUTONEG_WIRESPEED_ENABLE
        If flag_AUTONEG_TEST_REG0_BIT_14 = &H0 Then write_AUTONEG_TEST_REG0_BIT_14_value = get_AUTONEG_TEST_REG0_BIT_14
        If flag_ADIDIACA = &H0 Then write_ADIDIACA_value = get_ADIDIACA
        If flag_ALFIDF = &H0 Then write_ALFIDF_value = get_ALFIDF
        If flag_AUTONEG_MESSAGE_5_ENABLE = &H0 Then write_AUTONEG_MESSAGE_5_ENABLE_value = get_AUTONEG_MESSAGE_5_ENABLE
        If flag_ADRWCA = &H0 Then write_ADRWCA_value = get_ADRWCA
        If flag_ABLTM = &H0 Then write_ABLTM_value = get_ABLTM
        If flag_ALFITM = &H0 Then write_ALFITM_value = get_ALFITM
        If flag_ALFITF = &H0 Then write_ALFITF_value = get_ALFITF
        If flag_AWAN = &H0 Then write_AWAN_value = get_AWAN

        regValue = leftShift((write_AUTONEG_WIRESPEED_ENABLE_value and &H1), 15) + leftShift((write_AUTONEG_TEST_REG0_BIT_14_value and &H1), 14) + leftShift((write_ADIDIACA_value and &H1), 13) + leftShift((write_ALFIDF_value and &H1), 12) + leftShift((write_AUTONEG_MESSAGE_5_ENABLE_value and &H1), 11) + leftShift((write_ADRWCA_value and &H1), 10) + leftShift((write_ABLTM_value and &H3), 8) + leftShift((write_ALFITM_value and &Hf), 4) + leftShift((write_ALFITF_value and &H1), 3) + leftShift((write_AWAN_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_WIRESPEED_ENABLE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_TEST_REG0_BIT_14_value = rightShift(data_low, 14) and &H1
        read_ADIDIACA_value = rightShift(data_low, 13) and &H1
        read_ALFIDF_value = rightShift(data_low, 12) and &H1
        read_AUTONEG_MESSAGE_5_ENABLE_value = rightShift(data_low, 11) and &H1
        read_ADRWCA_value = rightShift(data_low, 10) and &H1
        read_ABLTM_value = rightShift(data_low, 8) and &H3
        read_ALFITM_value = rightShift(data_low, 4) and &Hf
        read_ALFITF_value = rightShift(data_low, 3) and &H1
        AWAN_mask = &H7
        if data_low > LONG_MAX then
            if AWAN_mask = mask then
                read_AWAN_value = data_low
            else
                read_AWAN_value = (data_low - H8000_0000) and AWAN_mask
            end If
        else
            read_AWAN_value = data_low and AWAN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_WIRESPEED_ENABLE_value = &H0
        flag_AUTONEG_WIRESPEED_ENABLE        = &H0
        write_AUTONEG_TEST_REG0_BIT_14_value = &H0
        flag_AUTONEG_TEST_REG0_BIT_14        = &H0
        write_ADIDIACA_value = &H0
        flag_ADIDIACA        = &H0
        write_ALFIDF_value = &H0
        flag_ALFIDF        = &H0
        write_AUTONEG_MESSAGE_5_ENABLE_value = &H0
        flag_AUTONEG_MESSAGE_5_ENABLE        = &H0
        write_ADRWCA_value = &H0
        flag_ADRWCA        = &H0
        write_ABLTM_value = &H0
        flag_ABLTM        = &H0
        write_ALFITM_value = &H0
        flag_ALFITM        = &H0
        write_ALFITF_value = &H0
        flag_ALFITF        = &H0
        write_AWAN_value = &H0
        flag_AWAN        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_RESOLUTION                   [15:15]          get_AUTONEG_FORCE_RESOLUTION
''                                                             set_AUTONEG_FORCE_RESOLUTION
''                                                             read_AUTONEG_FORCE_RESOLUTION
''                                                             write_AUTONEG_FORCE_RESOLUTION
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_MASTER_SLAVE                 [14:14]          get_AUTONEG_FORCE_MASTER_SLAVE
''                                                             set_AUTONEG_FORCE_MASTER_SLAVE
''                                                             read_AUTONEG_FORCE_MASTER_SLAVE
''                                                             write_AUTONEG_FORCE_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' AFCF                                       [13:13]          get_AFCF
''                                                             set_AFCF
''                                                             read_AFCF
''                                                             write_AFCF
''---------------------------------------------------------------------------------
'' AFLC10001                                  [12:12]          get_AFLC10001
''                                                             set_AFLC10001
''                                                             read_AFLC10001
''                                                             write_AFLC10001
''---------------------------------------------------------------------------------
'' AFLC1001                                   [11:11]          get_AFLC1001
''                                                             set_AFLC1001
''                                                             read_AFLC1001
''                                                             write_AFLC1001
''---------------------------------------------------------------------------------
'' OVERRIDE_MS_RESOLUTION_FAULT               [10:10]          get_OVERRIDE_MS_RESOLUTION_FAULT
''                                                             set_OVERRIDE_MS_RESOLUTION_FAULT
''                                                             read_OVERRIDE_MS_RESOLUTION_FAULT
''                                                             write_OVERRIDE_MS_RESOLUTION_FAULT
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_POLARITY_VALUE             [9:9]            get_OVERRIDE_RANDOM_POLARITY_VALUE
''                                                             set_OVERRIDE_RANDOM_POLARITY_VALUE
''                                                             read_OVERRIDE_RANDOM_POLARITY_VALUE
''                                                             write_OVERRIDE_RANDOM_POLARITY_VALUE
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_POLARITY                   [8:8]            get_OVERRIDE_RANDOM_POLARITY
''                                                             set_OVERRIDE_RANDOM_POLARITY
''                                                             read_OVERRIDE_RANDOM_POLARITY
''                                                             write_OVERRIDE_RANDOM_POLARITY
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_SEED_VALUE                 [7:4]            get_OVERRIDE_RANDOM_SEED_VALUE
''                                                             set_OVERRIDE_RANDOM_SEED_VALUE
''                                                             read_OVERRIDE_RANDOM_SEED_VALUE
''                                                             write_OVERRIDE_RANDOM_SEED_VALUE
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_SEED                       [3:3]            get_OVERRIDE_RANDOM_SEED
''                                                             set_OVERRIDE_RANDOM_SEED
''                                                             read_OVERRIDE_RANDOM_SEED
''                                                             write_OVERRIDE_RANDOM_SEED
''---------------------------------------------------------------------------------
'' ACCELERATE_LEGACY_TIMER                    [2:2]            get_ACCELERATE_LEGACY_TIMER
''                                                             set_ACCELERATE_LEGACY_TIMER
''                                                             read_ACCELERATE_LEGACY_TIMER
''                                                             write_ACCELERATE_LEGACY_TIMER
''---------------------------------------------------------------------------------
'' ALFIT                                      [1:1]            get_ALFIT
''                                                             set_ALFIT
''                                                             read_ALFIT
''                                                             write_ALFIT
''---------------------------------------------------------------------------------
'' ACCELERATE_BREAK_LINK_TIMER                [0:0]            get_ACCELERATE_BREAK_LINK_TIMER
''                                                             set_ACCELERATE_BREAK_LINK_TIMER
''                                                             read_ACCELERATE_BREAK_LINK_TIMER
''                                                             write_ACCELERATE_BREAK_LINK_TIMER
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg1
    Private write_AUTONEG_FORCE_RESOLUTION_value
    Private read_AUTONEG_FORCE_RESOLUTION_value
    Private flag_AUTONEG_FORCE_RESOLUTION
    Private write_AUTONEG_FORCE_MASTER_SLAVE_value
    Private read_AUTONEG_FORCE_MASTER_SLAVE_value
    Private flag_AUTONEG_FORCE_MASTER_SLAVE
    Private write_AFCF_value
    Private read_AFCF_value
    Private flag_AFCF
    Private write_AFLC10001_value
    Private read_AFLC10001_value
    Private flag_AFLC10001
    Private write_AFLC1001_value
    Private read_AFLC1001_value
    Private flag_AFLC1001
    Private write_OVERRIDE_MS_RESOLUTION_FAULT_value
    Private read_OVERRIDE_MS_RESOLUTION_FAULT_value
    Private flag_OVERRIDE_MS_RESOLUTION_FAULT
    Private write_OVERRIDE_RANDOM_POLARITY_VALUE_value
    Private read_OVERRIDE_RANDOM_POLARITY_VALUE_value
    Private flag_OVERRIDE_RANDOM_POLARITY_VALUE
    Private write_OVERRIDE_RANDOM_POLARITY_value
    Private read_OVERRIDE_RANDOM_POLARITY_value
    Private flag_OVERRIDE_RANDOM_POLARITY
    Private write_OVERRIDE_RANDOM_SEED_VALUE_value
    Private read_OVERRIDE_RANDOM_SEED_VALUE_value
    Private flag_OVERRIDE_RANDOM_SEED_VALUE
    Private write_OVERRIDE_RANDOM_SEED_value
    Private read_OVERRIDE_RANDOM_SEED_value
    Private flag_OVERRIDE_RANDOM_SEED
    Private write_ACCELERATE_LEGACY_TIMER_value
    Private read_ACCELERATE_LEGACY_TIMER_value
    Private flag_ACCELERATE_LEGACY_TIMER
    Private write_ALFIT_value
    Private read_ALFIT_value
    Private flag_ALFIT
    Private write_ACCELERATE_BREAK_LINK_TIMER_value
    Private read_ACCELERATE_BREAK_LINK_TIMER_value
    Private flag_ACCELERATE_BREAK_LINK_TIMER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10102
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AUTONEG_FORCE_RESOLUTION
        get_AUTONEG_FORCE_RESOLUTION = read_AUTONEG_FORCE_RESOLUTION_value
    End Property

    Property Let set_AUTONEG_FORCE_RESOLUTION(aData)
        write_AUTONEG_FORCE_RESOLUTION_value = aData
        flag_AUTONEG_FORCE_RESOLUTION        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_RESOLUTION
        read
        read_AUTONEG_FORCE_RESOLUTION = read_AUTONEG_FORCE_RESOLUTION_value
    End Property

    Property Let write_AUTONEG_FORCE_RESOLUTION(aData)
        set_AUTONEG_FORCE_RESOLUTION = aData
        write
    End Property

    Property Get get_AUTONEG_FORCE_MASTER_SLAVE
        get_AUTONEG_FORCE_MASTER_SLAVE = read_AUTONEG_FORCE_MASTER_SLAVE_value
    End Property

    Property Let set_AUTONEG_FORCE_MASTER_SLAVE(aData)
        write_AUTONEG_FORCE_MASTER_SLAVE_value = aData
        flag_AUTONEG_FORCE_MASTER_SLAVE        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_MASTER_SLAVE
        read
        read_AUTONEG_FORCE_MASTER_SLAVE = read_AUTONEG_FORCE_MASTER_SLAVE_value
    End Property

    Property Let write_AUTONEG_FORCE_MASTER_SLAVE(aData)
        set_AUTONEG_FORCE_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_AFCF
        get_AFCF = read_AFCF_value
    End Property

    Property Let set_AFCF(aData)
        write_AFCF_value = aData
        flag_AFCF        = &H1
    End Property

    Property Get read_AFCF
        read
        read_AFCF = read_AFCF_value
    End Property

    Property Let write_AFCF(aData)
        set_AFCF = aData
        write
    End Property

    Property Get get_AFLC10001
        get_AFLC10001 = read_AFLC10001_value
    End Property

    Property Let set_AFLC10001(aData)
        write_AFLC10001_value = aData
        flag_AFLC10001        = &H1
    End Property

    Property Get read_AFLC10001
        read
        read_AFLC10001 = read_AFLC10001_value
    End Property

    Property Let write_AFLC10001(aData)
        set_AFLC10001 = aData
        write
    End Property

    Property Get get_AFLC1001
        get_AFLC1001 = read_AFLC1001_value
    End Property

    Property Let set_AFLC1001(aData)
        write_AFLC1001_value = aData
        flag_AFLC1001        = &H1
    End Property

    Property Get read_AFLC1001
        read
        read_AFLC1001 = read_AFLC1001_value
    End Property

    Property Let write_AFLC1001(aData)
        set_AFLC1001 = aData
        write
    End Property

    Property Get get_OVERRIDE_MS_RESOLUTION_FAULT
        get_OVERRIDE_MS_RESOLUTION_FAULT = read_OVERRIDE_MS_RESOLUTION_FAULT_value
    End Property

    Property Let set_OVERRIDE_MS_RESOLUTION_FAULT(aData)
        write_OVERRIDE_MS_RESOLUTION_FAULT_value = aData
        flag_OVERRIDE_MS_RESOLUTION_FAULT        = &H1
    End Property

    Property Get read_OVERRIDE_MS_RESOLUTION_FAULT
        read
        read_OVERRIDE_MS_RESOLUTION_FAULT = read_OVERRIDE_MS_RESOLUTION_FAULT_value
    End Property

    Property Let write_OVERRIDE_MS_RESOLUTION_FAULT(aData)
        set_OVERRIDE_MS_RESOLUTION_FAULT = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_POLARITY_VALUE
        get_OVERRIDE_RANDOM_POLARITY_VALUE = read_OVERRIDE_RANDOM_POLARITY_VALUE_value
    End Property

    Property Let set_OVERRIDE_RANDOM_POLARITY_VALUE(aData)
        write_OVERRIDE_RANDOM_POLARITY_VALUE_value = aData
        flag_OVERRIDE_RANDOM_POLARITY_VALUE        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_POLARITY_VALUE
        read
        read_OVERRIDE_RANDOM_POLARITY_VALUE = read_OVERRIDE_RANDOM_POLARITY_VALUE_value
    End Property

    Property Let write_OVERRIDE_RANDOM_POLARITY_VALUE(aData)
        set_OVERRIDE_RANDOM_POLARITY_VALUE = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_POLARITY
        get_OVERRIDE_RANDOM_POLARITY = read_OVERRIDE_RANDOM_POLARITY_value
    End Property

    Property Let set_OVERRIDE_RANDOM_POLARITY(aData)
        write_OVERRIDE_RANDOM_POLARITY_value = aData
        flag_OVERRIDE_RANDOM_POLARITY        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_POLARITY
        read
        read_OVERRIDE_RANDOM_POLARITY = read_OVERRIDE_RANDOM_POLARITY_value
    End Property

    Property Let write_OVERRIDE_RANDOM_POLARITY(aData)
        set_OVERRIDE_RANDOM_POLARITY = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_SEED_VALUE
        get_OVERRIDE_RANDOM_SEED_VALUE = read_OVERRIDE_RANDOM_SEED_VALUE_value
    End Property

    Property Let set_OVERRIDE_RANDOM_SEED_VALUE(aData)
        write_OVERRIDE_RANDOM_SEED_VALUE_value = aData
        flag_OVERRIDE_RANDOM_SEED_VALUE        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_SEED_VALUE
        read
        read_OVERRIDE_RANDOM_SEED_VALUE = read_OVERRIDE_RANDOM_SEED_VALUE_value
    End Property

    Property Let write_OVERRIDE_RANDOM_SEED_VALUE(aData)
        set_OVERRIDE_RANDOM_SEED_VALUE = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_SEED
        get_OVERRIDE_RANDOM_SEED = read_OVERRIDE_RANDOM_SEED_value
    End Property

    Property Let set_OVERRIDE_RANDOM_SEED(aData)
        write_OVERRIDE_RANDOM_SEED_value = aData
        flag_OVERRIDE_RANDOM_SEED        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_SEED
        read
        read_OVERRIDE_RANDOM_SEED = read_OVERRIDE_RANDOM_SEED_value
    End Property

    Property Let write_OVERRIDE_RANDOM_SEED(aData)
        set_OVERRIDE_RANDOM_SEED = aData
        write
    End Property

    Property Get get_ACCELERATE_LEGACY_TIMER
        get_ACCELERATE_LEGACY_TIMER = read_ACCELERATE_LEGACY_TIMER_value
    End Property

    Property Let set_ACCELERATE_LEGACY_TIMER(aData)
        write_ACCELERATE_LEGACY_TIMER_value = aData
        flag_ACCELERATE_LEGACY_TIMER        = &H1
    End Property

    Property Get read_ACCELERATE_LEGACY_TIMER
        read
        read_ACCELERATE_LEGACY_TIMER = read_ACCELERATE_LEGACY_TIMER_value
    End Property

    Property Let write_ACCELERATE_LEGACY_TIMER(aData)
        set_ACCELERATE_LEGACY_TIMER = aData
        write
    End Property

    Property Get get_ALFIT
        get_ALFIT = read_ALFIT_value
    End Property

    Property Let set_ALFIT(aData)
        write_ALFIT_value = aData
        flag_ALFIT        = &H1
    End Property

    Property Get read_ALFIT
        read
        read_ALFIT = read_ALFIT_value
    End Property

    Property Let write_ALFIT(aData)
        set_ALFIT = aData
        write
    End Property

    Property Get get_ACCELERATE_BREAK_LINK_TIMER
        get_ACCELERATE_BREAK_LINK_TIMER = read_ACCELERATE_BREAK_LINK_TIMER_value
    End Property

    Property Let set_ACCELERATE_BREAK_LINK_TIMER(aData)
        write_ACCELERATE_BREAK_LINK_TIMER_value = aData
        flag_ACCELERATE_BREAK_LINK_TIMER        = &H1
    End Property

    Property Get read_ACCELERATE_BREAK_LINK_TIMER
        read
        read_ACCELERATE_BREAK_LINK_TIMER = read_ACCELERATE_BREAK_LINK_TIMER_value
    End Property

    Property Let write_ACCELERATE_BREAK_LINK_TIMER(aData)
        set_ACCELERATE_BREAK_LINK_TIMER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_FORCE_RESOLUTION_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_FORCE_MASTER_SLAVE_value = rightShift(data_low, 14) and &H1
        read_AFCF_value = rightShift(data_low, 13) and &H1
        read_AFLC10001_value = rightShift(data_low, 12) and &H1
        read_AFLC1001_value = rightShift(data_low, 11) and &H1
        read_OVERRIDE_MS_RESOLUTION_FAULT_value = rightShift(data_low, 10) and &H1
        read_OVERRIDE_RANDOM_POLARITY_VALUE_value = rightShift(data_low, 9) and &H1
        read_OVERRIDE_RANDOM_POLARITY_value = rightShift(data_low, 8) and &H1
        read_OVERRIDE_RANDOM_SEED_VALUE_value = rightShift(data_low, 4) and &Hf
        read_OVERRIDE_RANDOM_SEED_value = rightShift(data_low, 3) and &H1
        read_ACCELERATE_LEGACY_TIMER_value = rightShift(data_low, 2) and &H1
        read_ALFIT_value = rightShift(data_low, 1) and &H1
        ACCELERATE_BREAK_LINK_TIMER_mask = &H1
        if data_low > LONG_MAX then
            if ACCELERATE_BREAK_LINK_TIMER_mask = mask then
                read_ACCELERATE_BREAK_LINK_TIMER_value = data_low
            else
                read_ACCELERATE_BREAK_LINK_TIMER_value = (data_low - H8000_0000) and ACCELERATE_BREAK_LINK_TIMER_mask
            end If
        else
            read_ACCELERATE_BREAK_LINK_TIMER_value = data_low and ACCELERATE_BREAK_LINK_TIMER_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_FORCE_RESOLUTION = &H0 or flag_AUTONEG_FORCE_MASTER_SLAVE = &H0 or flag_AFCF = &H0 or flag_AFLC10001 = &H0 or flag_AFLC1001 = &H0 or flag_OVERRIDE_MS_RESOLUTION_FAULT = &H0 or flag_OVERRIDE_RANDOM_POLARITY_VALUE = &H0 or flag_OVERRIDE_RANDOM_POLARITY = &H0 or flag_OVERRIDE_RANDOM_SEED_VALUE = &H0 or flag_OVERRIDE_RANDOM_SEED = &H0 or flag_ACCELERATE_LEGACY_TIMER = &H0 or flag_ALFIT = &H0 or flag_ACCELERATE_BREAK_LINK_TIMER = &H0 Then read
        If flag_AUTONEG_FORCE_RESOLUTION = &H0 Then write_AUTONEG_FORCE_RESOLUTION_value = get_AUTONEG_FORCE_RESOLUTION
        If flag_AUTONEG_FORCE_MASTER_SLAVE = &H0 Then write_AUTONEG_FORCE_MASTER_SLAVE_value = get_AUTONEG_FORCE_MASTER_SLAVE
        If flag_AFCF = &H0 Then write_AFCF_value = get_AFCF
        If flag_AFLC10001 = &H0 Then write_AFLC10001_value = get_AFLC10001
        If flag_AFLC1001 = &H0 Then write_AFLC1001_value = get_AFLC1001
        If flag_OVERRIDE_MS_RESOLUTION_FAULT = &H0 Then write_OVERRIDE_MS_RESOLUTION_FAULT_value = get_OVERRIDE_MS_RESOLUTION_FAULT
        If flag_OVERRIDE_RANDOM_POLARITY_VALUE = &H0 Then write_OVERRIDE_RANDOM_POLARITY_VALUE_value = get_OVERRIDE_RANDOM_POLARITY_VALUE
        If flag_OVERRIDE_RANDOM_POLARITY = &H0 Then write_OVERRIDE_RANDOM_POLARITY_value = get_OVERRIDE_RANDOM_POLARITY
        If flag_OVERRIDE_RANDOM_SEED_VALUE = &H0 Then write_OVERRIDE_RANDOM_SEED_VALUE_value = get_OVERRIDE_RANDOM_SEED_VALUE
        If flag_OVERRIDE_RANDOM_SEED = &H0 Then write_OVERRIDE_RANDOM_SEED_value = get_OVERRIDE_RANDOM_SEED
        If flag_ACCELERATE_LEGACY_TIMER = &H0 Then write_ACCELERATE_LEGACY_TIMER_value = get_ACCELERATE_LEGACY_TIMER
        If flag_ALFIT = &H0 Then write_ALFIT_value = get_ALFIT
        If flag_ACCELERATE_BREAK_LINK_TIMER = &H0 Then write_ACCELERATE_BREAK_LINK_TIMER_value = get_ACCELERATE_BREAK_LINK_TIMER

        regValue = leftShift((write_AUTONEG_FORCE_RESOLUTION_value and &H1), 15) + leftShift((write_AUTONEG_FORCE_MASTER_SLAVE_value and &H1), 14) + leftShift((write_AFCF_value and &H1), 13) + leftShift((write_AFLC10001_value and &H1), 12) + leftShift((write_AFLC1001_value and &H1), 11) + leftShift((write_OVERRIDE_MS_RESOLUTION_FAULT_value and &H1), 10) + leftShift((write_OVERRIDE_RANDOM_POLARITY_VALUE_value and &H1), 9) + leftShift((write_OVERRIDE_RANDOM_POLARITY_value and &H1), 8) + leftShift((write_OVERRIDE_RANDOM_SEED_VALUE_value and &Hf), 4) + leftShift((write_OVERRIDE_RANDOM_SEED_value and &H1), 3) + leftShift((write_ACCELERATE_LEGACY_TIMER_value and &H1), 2) + leftShift((write_ALFIT_value and &H1), 1) + leftShift((write_ACCELERATE_BREAK_LINK_TIMER_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_FORCE_RESOLUTION_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_FORCE_MASTER_SLAVE_value = rightShift(data_low, 14) and &H1
        read_AFCF_value = rightShift(data_low, 13) and &H1
        read_AFLC10001_value = rightShift(data_low, 12) and &H1
        read_AFLC1001_value = rightShift(data_low, 11) and &H1
        read_OVERRIDE_MS_RESOLUTION_FAULT_value = rightShift(data_low, 10) and &H1
        read_OVERRIDE_RANDOM_POLARITY_VALUE_value = rightShift(data_low, 9) and &H1
        read_OVERRIDE_RANDOM_POLARITY_value = rightShift(data_low, 8) and &H1
        read_OVERRIDE_RANDOM_SEED_VALUE_value = rightShift(data_low, 4) and &Hf
        read_OVERRIDE_RANDOM_SEED_value = rightShift(data_low, 3) and &H1
        read_ACCELERATE_LEGACY_TIMER_value = rightShift(data_low, 2) and &H1
        read_ALFIT_value = rightShift(data_low, 1) and &H1
        ACCELERATE_BREAK_LINK_TIMER_mask = &H1
        if data_low > LONG_MAX then
            if ACCELERATE_BREAK_LINK_TIMER_mask = mask then
                read_ACCELERATE_BREAK_LINK_TIMER_value = data_low
            else
                read_ACCELERATE_BREAK_LINK_TIMER_value = (data_low - H8000_0000) and ACCELERATE_BREAK_LINK_TIMER_mask
            end If
        else
            read_ACCELERATE_BREAK_LINK_TIMER_value = data_low and ACCELERATE_BREAK_LINK_TIMER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_FORCE_RESOLUTION_value = &H0
        flag_AUTONEG_FORCE_RESOLUTION        = &H0
        write_AUTONEG_FORCE_MASTER_SLAVE_value = &H0
        flag_AUTONEG_FORCE_MASTER_SLAVE        = &H0
        write_AFCF_value = &H0
        flag_AFCF        = &H0
        write_AFLC10001_value = &H0
        flag_AFLC10001        = &H0
        write_AFLC1001_value = &H0
        flag_AFLC1001        = &H0
        write_OVERRIDE_MS_RESOLUTION_FAULT_value = &H0
        flag_OVERRIDE_MS_RESOLUTION_FAULT        = &H0
        write_OVERRIDE_RANDOM_POLARITY_VALUE_value = &H0
        flag_OVERRIDE_RANDOM_POLARITY_VALUE        = &H0
        write_OVERRIDE_RANDOM_POLARITY_value = &H0
        flag_OVERRIDE_RANDOM_POLARITY        = &H0
        write_OVERRIDE_RANDOM_SEED_VALUE_value = &H0
        flag_OVERRIDE_RANDOM_SEED_VALUE        = &H0
        write_OVERRIDE_RANDOM_SEED_value = &H0
        flag_OVERRIDE_RANDOM_SEED        = &H0
        write_ACCELERATE_LEGACY_TIMER_value = &H0
        flag_ACCELERATE_LEGACY_TIMER        = &H0
        write_ALFIT_value = &H0
        flag_ALFIT        = &H0
        write_ACCELERATE_BREAK_LINK_TIMER_value = &H0
        flag_ACCELERATE_BREAK_LINK_TIMER        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MR_AUTONEG_COMPLETE                        [15:15]          get_MR_AUTONEG_COMPLETE
''                                                             set_MR_AUTONEG_COMPLETE
''                                                             read_MR_AUTONEG_COMPLETE
''                                                             write_MR_AUTONEG_COMPLETE
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_COUNT                    [14:12]          get_AUTONEG_WIRESPEED_COUNT
''                                                             set_AUTONEG_WIRESPEED_COUNT
''                                                             read_AUTONEG_WIRESPEED_COUNT
''                                                             write_AUTONEG_WIRESPEED_COUNT
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_DOWNGRADE                [11:11]          get_AUTONEG_WIRESPEED_DOWNGRADE
''                                                             set_AUTONEG_WIRESPEED_DOWNGRADE
''                                                             read_AUTONEG_WIRESPEED_DOWNGRADE
''                                                             write_AUTONEG_WIRESPEED_DOWNGRADE
''---------------------------------------------------------------------------------
'' AUTONEG_LINK_GOOD_CHECK                    [10:10]          get_AUTONEG_LINK_GOOD_CHECK
''                                                             set_AUTONEG_LINK_GOOD_CHECK
''                                                             read_AUTONEG_LINK_GOOD_CHECK
''                                                             write_AUTONEG_LINK_GOOD_CHECK
''---------------------------------------------------------------------------------
'' CONFIGURATION_FAULT                        [9:9]            get_CONFIGURATION_FAULT
''                                                             set_CONFIGURATION_FAULT
''                                                             read_CONFIGURATION_FAULT
''                                                             write_CONFIGURATION_FAULT
''---------------------------------------------------------------------------------
'' MASTER_SLAVE                               [8:8]            get_MASTER_SLAVE
''                                                             set_MASTER_SLAVE
''                                                             read_MASTER_SLAVE
''                                                             write_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' ASMCS1                                     [7:4]            get_ASMCS1
''                                                             set_ASMCS1
''                                                             read_ASMCS1
''                                                             write_ASMCS1
''---------------------------------------------------------------------------------
'' HIGHEST_COMMON_DENOMINATOR                 [3:0]            get_HIGHEST_COMMON_DENOMINATOR
''                                                             set_HIGHEST_COMMON_DENOMINATOR
''                                                             read_HIGHEST_COMMON_DENOMINATOR
''                                                             write_HIGHEST_COMMON_DENOMINATOR
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg2
    Private write_MR_AUTONEG_COMPLETE_value
    Private read_MR_AUTONEG_COMPLETE_value
    Private flag_MR_AUTONEG_COMPLETE
    Private write_AUTONEG_WIRESPEED_COUNT_value
    Private read_AUTONEG_WIRESPEED_COUNT_value
    Private flag_AUTONEG_WIRESPEED_COUNT
    Private write_AUTONEG_WIRESPEED_DOWNGRADE_value
    Private read_AUTONEG_WIRESPEED_DOWNGRADE_value
    Private flag_AUTONEG_WIRESPEED_DOWNGRADE
    Private write_AUTONEG_LINK_GOOD_CHECK_value
    Private read_AUTONEG_LINK_GOOD_CHECK_value
    Private flag_AUTONEG_LINK_GOOD_CHECK
    Private write_CONFIGURATION_FAULT_value
    Private read_CONFIGURATION_FAULT_value
    Private flag_CONFIGURATION_FAULT
    Private write_MASTER_SLAVE_value
    Private read_MASTER_SLAVE_value
    Private flag_MASTER_SLAVE
    Private write_ASMCS1_value
    Private read_ASMCS1_value
    Private flag_ASMCS1
    Private write_HIGHEST_COMMON_DENOMINATOR_value
    Private read_HIGHEST_COMMON_DENOMINATOR_value
    Private flag_HIGHEST_COMMON_DENOMINATOR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MR_AUTONEG_COMPLETE
        get_MR_AUTONEG_COMPLETE = read_MR_AUTONEG_COMPLETE_value
    End Property

    Property Let set_MR_AUTONEG_COMPLETE(aData)
        write_MR_AUTONEG_COMPLETE_value = aData
        flag_MR_AUTONEG_COMPLETE        = &H1
    End Property

    Property Get read_MR_AUTONEG_COMPLETE
        read
        read_MR_AUTONEG_COMPLETE = read_MR_AUTONEG_COMPLETE_value
    End Property

    Property Let write_MR_AUTONEG_COMPLETE(aData)
        set_MR_AUTONEG_COMPLETE = aData
        write
    End Property

    Property Get get_AUTONEG_WIRESPEED_COUNT
        get_AUTONEG_WIRESPEED_COUNT = read_AUTONEG_WIRESPEED_COUNT_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_COUNT(aData)
        write_AUTONEG_WIRESPEED_COUNT_value = aData
        flag_AUTONEG_WIRESPEED_COUNT        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_COUNT
        read
        read_AUTONEG_WIRESPEED_COUNT = read_AUTONEG_WIRESPEED_COUNT_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_COUNT(aData)
        set_AUTONEG_WIRESPEED_COUNT = aData
        write
    End Property

    Property Get get_AUTONEG_WIRESPEED_DOWNGRADE
        get_AUTONEG_WIRESPEED_DOWNGRADE = read_AUTONEG_WIRESPEED_DOWNGRADE_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_DOWNGRADE(aData)
        write_AUTONEG_WIRESPEED_DOWNGRADE_value = aData
        flag_AUTONEG_WIRESPEED_DOWNGRADE        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_DOWNGRADE
        read
        read_AUTONEG_WIRESPEED_DOWNGRADE = read_AUTONEG_WIRESPEED_DOWNGRADE_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_DOWNGRADE(aData)
        set_AUTONEG_WIRESPEED_DOWNGRADE = aData
        write
    End Property

    Property Get get_AUTONEG_LINK_GOOD_CHECK
        get_AUTONEG_LINK_GOOD_CHECK = read_AUTONEG_LINK_GOOD_CHECK_value
    End Property

    Property Let set_AUTONEG_LINK_GOOD_CHECK(aData)
        write_AUTONEG_LINK_GOOD_CHECK_value = aData
        flag_AUTONEG_LINK_GOOD_CHECK        = &H1
    End Property

    Property Get read_AUTONEG_LINK_GOOD_CHECK
        read
        read_AUTONEG_LINK_GOOD_CHECK = read_AUTONEG_LINK_GOOD_CHECK_value
    End Property

    Property Let write_AUTONEG_LINK_GOOD_CHECK(aData)
        set_AUTONEG_LINK_GOOD_CHECK = aData
        write
    End Property

    Property Get get_CONFIGURATION_FAULT
        get_CONFIGURATION_FAULT = read_CONFIGURATION_FAULT_value
    End Property

    Property Let set_CONFIGURATION_FAULT(aData)
        write_CONFIGURATION_FAULT_value = aData
        flag_CONFIGURATION_FAULT        = &H1
    End Property

    Property Get read_CONFIGURATION_FAULT
        read
        read_CONFIGURATION_FAULT = read_CONFIGURATION_FAULT_value
    End Property

    Property Let write_CONFIGURATION_FAULT(aData)
        set_CONFIGURATION_FAULT = aData
        write
    End Property

    Property Get get_MASTER_SLAVE
        get_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let set_MASTER_SLAVE(aData)
        write_MASTER_SLAVE_value = aData
        flag_MASTER_SLAVE        = &H1
    End Property

    Property Get read_MASTER_SLAVE
        read
        read_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let write_MASTER_SLAVE(aData)
        set_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_ASMCS1
        get_ASMCS1 = read_ASMCS1_value
    End Property

    Property Let set_ASMCS1(aData)
        write_ASMCS1_value = aData
        flag_ASMCS1        = &H1
    End Property

    Property Get read_ASMCS1
        read
        read_ASMCS1 = read_ASMCS1_value
    End Property

    Property Let write_ASMCS1(aData)
        set_ASMCS1 = aData
        write
    End Property

    Property Get get_HIGHEST_COMMON_DENOMINATOR
        get_HIGHEST_COMMON_DENOMINATOR = read_HIGHEST_COMMON_DENOMINATOR_value
    End Property

    Property Let set_HIGHEST_COMMON_DENOMINATOR(aData)
        write_HIGHEST_COMMON_DENOMINATOR_value = aData
        flag_HIGHEST_COMMON_DENOMINATOR        = &H1
    End Property

    Property Get read_HIGHEST_COMMON_DENOMINATOR
        read
        read_HIGHEST_COMMON_DENOMINATOR = read_HIGHEST_COMMON_DENOMINATOR_value
    End Property

    Property Let write_HIGHEST_COMMON_DENOMINATOR(aData)
        set_HIGHEST_COMMON_DENOMINATOR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MR_AUTONEG_COMPLETE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_WIRESPEED_COUNT_value = rightShift(data_low, 12) and &H7
        read_AUTONEG_WIRESPEED_DOWNGRADE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_LINK_GOOD_CHECK_value = rightShift(data_low, 10) and &H1
        read_CONFIGURATION_FAULT_value = rightShift(data_low, 9) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 8) and &H1
        read_ASMCS1_value = rightShift(data_low, 4) and &Hf
        HIGHEST_COMMON_DENOMINATOR_mask = &Hf
        if data_low > LONG_MAX then
            if HIGHEST_COMMON_DENOMINATOR_mask = mask then
                read_HIGHEST_COMMON_DENOMINATOR_value = data_low
            else
                read_HIGHEST_COMMON_DENOMINATOR_value = (data_low - H8000_0000) and HIGHEST_COMMON_DENOMINATOR_mask
            end If
        else
            read_HIGHEST_COMMON_DENOMINATOR_value = data_low and HIGHEST_COMMON_DENOMINATOR_mask
        end If

    End Sub

    Sub write
        If flag_MR_AUTONEG_COMPLETE = &H0 or flag_AUTONEG_WIRESPEED_COUNT = &H0 or flag_AUTONEG_WIRESPEED_DOWNGRADE = &H0 or flag_AUTONEG_LINK_GOOD_CHECK = &H0 or flag_CONFIGURATION_FAULT = &H0 or flag_MASTER_SLAVE = &H0 or flag_ASMCS1 = &H0 or flag_HIGHEST_COMMON_DENOMINATOR = &H0 Then read
        If flag_MR_AUTONEG_COMPLETE = &H0 Then write_MR_AUTONEG_COMPLETE_value = get_MR_AUTONEG_COMPLETE
        If flag_AUTONEG_WIRESPEED_COUNT = &H0 Then write_AUTONEG_WIRESPEED_COUNT_value = get_AUTONEG_WIRESPEED_COUNT
        If flag_AUTONEG_WIRESPEED_DOWNGRADE = &H0 Then write_AUTONEG_WIRESPEED_DOWNGRADE_value = get_AUTONEG_WIRESPEED_DOWNGRADE
        If flag_AUTONEG_LINK_GOOD_CHECK = &H0 Then write_AUTONEG_LINK_GOOD_CHECK_value = get_AUTONEG_LINK_GOOD_CHECK
        If flag_CONFIGURATION_FAULT = &H0 Then write_CONFIGURATION_FAULT_value = get_CONFIGURATION_FAULT
        If flag_MASTER_SLAVE = &H0 Then write_MASTER_SLAVE_value = get_MASTER_SLAVE
        If flag_ASMCS1 = &H0 Then write_ASMCS1_value = get_ASMCS1
        If flag_HIGHEST_COMMON_DENOMINATOR = &H0 Then write_HIGHEST_COMMON_DENOMINATOR_value = get_HIGHEST_COMMON_DENOMINATOR

        regValue = leftShift((write_MR_AUTONEG_COMPLETE_value and &H1), 15) + leftShift((write_AUTONEG_WIRESPEED_COUNT_value and &H7), 12) + leftShift((write_AUTONEG_WIRESPEED_DOWNGRADE_value and &H1), 11) + leftShift((write_AUTONEG_LINK_GOOD_CHECK_value and &H1), 10) + leftShift((write_CONFIGURATION_FAULT_value and &H1), 9) + leftShift((write_MASTER_SLAVE_value and &H1), 8) + leftShift((write_ASMCS1_value and &Hf), 4) + leftShift((write_HIGHEST_COMMON_DENOMINATOR_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MR_AUTONEG_COMPLETE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_WIRESPEED_COUNT_value = rightShift(data_low, 12) and &H7
        read_AUTONEG_WIRESPEED_DOWNGRADE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_LINK_GOOD_CHECK_value = rightShift(data_low, 10) and &H1
        read_CONFIGURATION_FAULT_value = rightShift(data_low, 9) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 8) and &H1
        read_ASMCS1_value = rightShift(data_low, 4) and &Hf
        HIGHEST_COMMON_DENOMINATOR_mask = &Hf
        if data_low > LONG_MAX then
            if HIGHEST_COMMON_DENOMINATOR_mask = mask then
                read_HIGHEST_COMMON_DENOMINATOR_value = data_low
            else
                read_HIGHEST_COMMON_DENOMINATOR_value = (data_low - H8000_0000) and HIGHEST_COMMON_DENOMINATOR_mask
            end If
        else
            read_HIGHEST_COMMON_DENOMINATOR_value = data_low and HIGHEST_COMMON_DENOMINATOR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MR_AUTONEG_COMPLETE_value = &H0
        flag_MR_AUTONEG_COMPLETE        = &H0
        write_AUTONEG_WIRESPEED_COUNT_value = &H0
        flag_AUTONEG_WIRESPEED_COUNT        = &H0
        write_AUTONEG_WIRESPEED_DOWNGRADE_value = &H0
        flag_AUTONEG_WIRESPEED_DOWNGRADE        = &H0
        write_AUTONEG_LINK_GOOD_CHECK_value = &H0
        flag_AUTONEG_LINK_GOOD_CHECK        = &H0
        write_CONFIGURATION_FAULT_value = &H0
        flag_CONFIGURATION_FAULT        = &H0
        write_MASTER_SLAVE_value = &H0
        flag_MASTER_SLAVE        = &H0
        write_ASMCS1_value = &H0
        flag_ASMCS1        = &H0
        write_HIGHEST_COMMON_DENOMINATOR_value = &H0
        flag_HIGHEST_COMMON_DENOMINATOR        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DETECT_LEGACY_100T1                        [15:15]          get_DETECT_LEGACY_100T1
''                                                             set_DETECT_LEGACY_100T1
''                                                             read_DETECT_LEGACY_100T1
''                                                             write_DETECT_LEGACY_100T1
''---------------------------------------------------------------------------------
'' DETECT_TRANSITION                          [14:14]          get_DETECT_TRANSITION
''                                                             set_DETECT_TRANSITION
''                                                             read_DETECT_TRANSITION
''                                                             write_DETECT_TRANSITION
''---------------------------------------------------------------------------------
'' DETECT_MV_END                              [13:13]          get_DETECT_MV_END
''                                                             set_DETECT_MV_END
''                                                             read_DETECT_MV_END
''                                                             write_DETECT_MV_END
''---------------------------------------------------------------------------------
'' DETECT_MV_START                            [12:12]          get_DETECT_MV_START
''                                                             set_DETECT_MV_START
''                                                             read_DETECT_MV_START
''                                                             write_DETECT_MV_START
''---------------------------------------------------------------------------------
'' DETECT_POLARITY                            [11:11]          get_DETECT_POLARITY
''                                                             set_DETECT_POLARITY
''                                                             read_DETECT_POLARITY
''                                                             write_DETECT_POLARITY
''---------------------------------------------------------------------------------
'' RX_STATE_MACHINE_CURRENT_STATE             [10:8]           get_RX_STATE_MACHINE_CURRENT_STATE
''                                                             set_RX_STATE_MACHINE_CURRENT_STATE
''                                                             read_RX_STATE_MACHINE_CURRENT_STATE
''                                                             write_RX_STATE_MACHINE_CURRENT_STATE
''---------------------------------------------------------------------------------
'' LP_AUTONEG_ABLE                            [7:7]            get_LP_AUTONEG_ABLE
''                                                             set_LP_AUTONEG_ABLE
''                                                             read_LP_AUTONEG_ABLE
''                                                             write_LP_AUTONEG_ABLE
''---------------------------------------------------------------------------------
'' TX_STATE_MACHINE_CURRENT_STATE             [6:4]            get_TX_STATE_MACHINE_CURRENT_STATE
''                                                             set_TX_STATE_MACHINE_CURRENT_STATE
''                                                             read_TX_STATE_MACHINE_CURRENT_STATE
''                                                             write_TX_STATE_MACHINE_CURRENT_STATE
''---------------------------------------------------------------------------------
'' HSMCS                                      [3:0]            get_HSMCS
''                                                             set_HSMCS
''                                                             read_HSMCS
''                                                             write_HSMCS
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg3
    Private write_DETECT_LEGACY_100T1_value
    Private read_DETECT_LEGACY_100T1_value
    Private flag_DETECT_LEGACY_100T1
    Private write_DETECT_TRANSITION_value
    Private read_DETECT_TRANSITION_value
    Private flag_DETECT_TRANSITION
    Private write_DETECT_MV_END_value
    Private read_DETECT_MV_END_value
    Private flag_DETECT_MV_END
    Private write_DETECT_MV_START_value
    Private read_DETECT_MV_START_value
    Private flag_DETECT_MV_START
    Private write_DETECT_POLARITY_value
    Private read_DETECT_POLARITY_value
    Private flag_DETECT_POLARITY
    Private write_RX_STATE_MACHINE_CURRENT_STATE_value
    Private read_RX_STATE_MACHINE_CURRENT_STATE_value
    Private flag_RX_STATE_MACHINE_CURRENT_STATE
    Private write_LP_AUTONEG_ABLE_value
    Private read_LP_AUTONEG_ABLE_value
    Private flag_LP_AUTONEG_ABLE
    Private write_TX_STATE_MACHINE_CURRENT_STATE_value
    Private read_TX_STATE_MACHINE_CURRENT_STATE_value
    Private flag_TX_STATE_MACHINE_CURRENT_STATE
    Private write_HSMCS_value
    Private read_HSMCS_value
    Private flag_HSMCS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10106
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DETECT_LEGACY_100T1
        get_DETECT_LEGACY_100T1 = read_DETECT_LEGACY_100T1_value
    End Property

    Property Let set_DETECT_LEGACY_100T1(aData)
        write_DETECT_LEGACY_100T1_value = aData
        flag_DETECT_LEGACY_100T1        = &H1
    End Property

    Property Get read_DETECT_LEGACY_100T1
        read
        read_DETECT_LEGACY_100T1 = read_DETECT_LEGACY_100T1_value
    End Property

    Property Let write_DETECT_LEGACY_100T1(aData)
        set_DETECT_LEGACY_100T1 = aData
        write
    End Property

    Property Get get_DETECT_TRANSITION
        get_DETECT_TRANSITION = read_DETECT_TRANSITION_value
    End Property

    Property Let set_DETECT_TRANSITION(aData)
        write_DETECT_TRANSITION_value = aData
        flag_DETECT_TRANSITION        = &H1
    End Property

    Property Get read_DETECT_TRANSITION
        read
        read_DETECT_TRANSITION = read_DETECT_TRANSITION_value
    End Property

    Property Let write_DETECT_TRANSITION(aData)
        set_DETECT_TRANSITION = aData
        write
    End Property

    Property Get get_DETECT_MV_END
        get_DETECT_MV_END = read_DETECT_MV_END_value
    End Property

    Property Let set_DETECT_MV_END(aData)
        write_DETECT_MV_END_value = aData
        flag_DETECT_MV_END        = &H1
    End Property

    Property Get read_DETECT_MV_END
        read
        read_DETECT_MV_END = read_DETECT_MV_END_value
    End Property

    Property Let write_DETECT_MV_END(aData)
        set_DETECT_MV_END = aData
        write
    End Property

    Property Get get_DETECT_MV_START
        get_DETECT_MV_START = read_DETECT_MV_START_value
    End Property

    Property Let set_DETECT_MV_START(aData)
        write_DETECT_MV_START_value = aData
        flag_DETECT_MV_START        = &H1
    End Property

    Property Get read_DETECT_MV_START
        read
        read_DETECT_MV_START = read_DETECT_MV_START_value
    End Property

    Property Let write_DETECT_MV_START(aData)
        set_DETECT_MV_START = aData
        write
    End Property

    Property Get get_DETECT_POLARITY
        get_DETECT_POLARITY = read_DETECT_POLARITY_value
    End Property

    Property Let set_DETECT_POLARITY(aData)
        write_DETECT_POLARITY_value = aData
        flag_DETECT_POLARITY        = &H1
    End Property

    Property Get read_DETECT_POLARITY
        read
        read_DETECT_POLARITY = read_DETECT_POLARITY_value
    End Property

    Property Let write_DETECT_POLARITY(aData)
        set_DETECT_POLARITY = aData
        write
    End Property

    Property Get get_RX_STATE_MACHINE_CURRENT_STATE
        get_RX_STATE_MACHINE_CURRENT_STATE = read_RX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let set_RX_STATE_MACHINE_CURRENT_STATE(aData)
        write_RX_STATE_MACHINE_CURRENT_STATE_value = aData
        flag_RX_STATE_MACHINE_CURRENT_STATE        = &H1
    End Property

    Property Get read_RX_STATE_MACHINE_CURRENT_STATE
        read
        read_RX_STATE_MACHINE_CURRENT_STATE = read_RX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let write_RX_STATE_MACHINE_CURRENT_STATE(aData)
        set_RX_STATE_MACHINE_CURRENT_STATE = aData
        write
    End Property

    Property Get get_LP_AUTONEG_ABLE
        get_LP_AUTONEG_ABLE = read_LP_AUTONEG_ABLE_value
    End Property

    Property Let set_LP_AUTONEG_ABLE(aData)
        write_LP_AUTONEG_ABLE_value = aData
        flag_LP_AUTONEG_ABLE        = &H1
    End Property

    Property Get read_LP_AUTONEG_ABLE
        read
        read_LP_AUTONEG_ABLE = read_LP_AUTONEG_ABLE_value
    End Property

    Property Let write_LP_AUTONEG_ABLE(aData)
        set_LP_AUTONEG_ABLE = aData
        write
    End Property

    Property Get get_TX_STATE_MACHINE_CURRENT_STATE
        get_TX_STATE_MACHINE_CURRENT_STATE = read_TX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let set_TX_STATE_MACHINE_CURRENT_STATE(aData)
        write_TX_STATE_MACHINE_CURRENT_STATE_value = aData
        flag_TX_STATE_MACHINE_CURRENT_STATE        = &H1
    End Property

    Property Get read_TX_STATE_MACHINE_CURRENT_STATE
        read
        read_TX_STATE_MACHINE_CURRENT_STATE = read_TX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let write_TX_STATE_MACHINE_CURRENT_STATE(aData)
        set_TX_STATE_MACHINE_CURRENT_STATE = aData
        write
    End Property

    Property Get get_HSMCS
        get_HSMCS = read_HSMCS_value
    End Property

    Property Let set_HSMCS(aData)
        write_HSMCS_value = aData
        flag_HSMCS        = &H1
    End Property

    Property Get read_HSMCS
        read
        read_HSMCS = read_HSMCS_value
    End Property

    Property Let write_HSMCS(aData)
        set_HSMCS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DETECT_LEGACY_100T1_value = rightShift(data_low, 15) and &H1
        read_DETECT_TRANSITION_value = rightShift(data_low, 14) and &H1
        read_DETECT_MV_END_value = rightShift(data_low, 13) and &H1
        read_DETECT_MV_START_value = rightShift(data_low, 12) and &H1
        read_DETECT_POLARITY_value = rightShift(data_low, 11) and &H1
        read_RX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 8) and &H7
        read_LP_AUTONEG_ABLE_value = rightShift(data_low, 7) and &H1
        read_TX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 4) and &H7
        HSMCS_mask = &Hf
        if data_low > LONG_MAX then
            if HSMCS_mask = mask then
                read_HSMCS_value = data_low
            else
                read_HSMCS_value = (data_low - H8000_0000) and HSMCS_mask
            end If
        else
            read_HSMCS_value = data_low and HSMCS_mask
        end If

    End Sub

    Sub write
        If flag_DETECT_LEGACY_100T1 = &H0 or flag_DETECT_TRANSITION = &H0 or flag_DETECT_MV_END = &H0 or flag_DETECT_MV_START = &H0 or flag_DETECT_POLARITY = &H0 or flag_RX_STATE_MACHINE_CURRENT_STATE = &H0 or flag_LP_AUTONEG_ABLE = &H0 or flag_TX_STATE_MACHINE_CURRENT_STATE = &H0 or flag_HSMCS = &H0 Then read
        If flag_DETECT_LEGACY_100T1 = &H0 Then write_DETECT_LEGACY_100T1_value = get_DETECT_LEGACY_100T1
        If flag_DETECT_TRANSITION = &H0 Then write_DETECT_TRANSITION_value = get_DETECT_TRANSITION
        If flag_DETECT_MV_END = &H0 Then write_DETECT_MV_END_value = get_DETECT_MV_END
        If flag_DETECT_MV_START = &H0 Then write_DETECT_MV_START_value = get_DETECT_MV_START
        If flag_DETECT_POLARITY = &H0 Then write_DETECT_POLARITY_value = get_DETECT_POLARITY
        If flag_RX_STATE_MACHINE_CURRENT_STATE = &H0 Then write_RX_STATE_MACHINE_CURRENT_STATE_value = get_RX_STATE_MACHINE_CURRENT_STATE
        If flag_LP_AUTONEG_ABLE = &H0 Then write_LP_AUTONEG_ABLE_value = get_LP_AUTONEG_ABLE
        If flag_TX_STATE_MACHINE_CURRENT_STATE = &H0 Then write_TX_STATE_MACHINE_CURRENT_STATE_value = get_TX_STATE_MACHINE_CURRENT_STATE
        If flag_HSMCS = &H0 Then write_HSMCS_value = get_HSMCS

        regValue = leftShift((write_DETECT_LEGACY_100T1_value and &H1), 15) + leftShift((write_DETECT_TRANSITION_value and &H1), 14) + leftShift((write_DETECT_MV_END_value and &H1), 13) + leftShift((write_DETECT_MV_START_value and &H1), 12) + leftShift((write_DETECT_POLARITY_value and &H1), 11) + leftShift((write_RX_STATE_MACHINE_CURRENT_STATE_value and &H7), 8) + leftShift((write_LP_AUTONEG_ABLE_value and &H1), 7) + leftShift((write_TX_STATE_MACHINE_CURRENT_STATE_value and &H7), 4) + leftShift((write_HSMCS_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DETECT_LEGACY_100T1_value = rightShift(data_low, 15) and &H1
        read_DETECT_TRANSITION_value = rightShift(data_low, 14) and &H1
        read_DETECT_MV_END_value = rightShift(data_low, 13) and &H1
        read_DETECT_MV_START_value = rightShift(data_low, 12) and &H1
        read_DETECT_POLARITY_value = rightShift(data_low, 11) and &H1
        read_RX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 8) and &H7
        read_LP_AUTONEG_ABLE_value = rightShift(data_low, 7) and &H1
        read_TX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 4) and &H7
        HSMCS_mask = &Hf
        if data_low > LONG_MAX then
            if HSMCS_mask = mask then
                read_HSMCS_value = data_low
            else
                read_HSMCS_value = (data_low - H8000_0000) and HSMCS_mask
            end If
        else
            read_HSMCS_value = data_low and HSMCS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DETECT_LEGACY_100T1_value = &H0
        flag_DETECT_LEGACY_100T1        = &H0
        write_DETECT_TRANSITION_value = &H0
        flag_DETECT_TRANSITION        = &H0
        write_DETECT_MV_END_value = &H0
        flag_DETECT_MV_END        = &H0
        write_DETECT_MV_START_value = &H0
        flag_DETECT_MV_START        = &H0
        write_DETECT_POLARITY_value = &H0
        flag_DETECT_POLARITY        = &H0
        write_RX_STATE_MACHINE_CURRENT_STATE_value = &H0
        flag_RX_STATE_MACHINE_CURRENT_STATE        = &H0
        write_LP_AUTONEG_ABLE_value = &H0
        flag_LP_AUTONEG_ABLE        = &H0
        write_TX_STATE_MACHINE_CURRENT_STATE_value = &H0
        flag_TX_STATE_MACHINE_CURRENT_STATE        = &H0
        write_HSMCS_value = &H0
        flag_HSMCS        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ATMDM                                      [15:15]          get_ATMDM
''                                                             set_ATMDM
''                                                             read_ATMDM
''                                                             write_ATMDM
''---------------------------------------------------------------------------------
'' L1001DMET                                  [14:14]          get_L1001DMET
''                                                             set_L1001DMET
''                                                             read_L1001DMET
''                                                             write_L1001DMET
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_MS_VAL                 [13:13]          get_LEGACY_100T1_DETECT_MS_VAL
''                                                             set_LEGACY_100T1_DETECT_MS_VAL
''                                                             read_LEGACY_100T1_DETECT_MS_VAL
''                                                             write_LEGACY_100T1_DETECT_MS_VAL
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECTOR_VALUE                [12:12]          get_LEGACY_100T1_DETECTOR_VALUE
''                                                             set_LEGACY_100T1_DETECTOR_VALUE
''                                                             read_LEGACY_100T1_DETECTOR_VALUE
''                                                             write_LEGACY_100T1_DETECTOR_VALUE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_ENABLE                 [11:11]          get_LEGACY_100T1_DETECT_ENABLE
''                                                             set_LEGACY_100T1_DETECT_ENABLE
''                                                             read_LEGACY_100T1_DETECT_ENABLE
''                                                             write_LEGACY_100T1_DETECT_ENABLE
''---------------------------------------------------------------------------------
'' AUTONEG_HPF_POLE_SEL                       [10:9]           get_AUTONEG_HPF_POLE_SEL
''                                                             set_AUTONEG_HPF_POLE_SEL
''                                                             read_AUTONEG_HPF_POLE_SEL
''                                                             write_AUTONEG_HPF_POLE_SEL
''---------------------------------------------------------------------------------
'' L1001TMET                                  [8:8]            get_L1001TMET
''                                                             set_L1001TMET
''                                                             read_L1001TMET
''                                                             write_L1001TMET
''---------------------------------------------------------------------------------
'' LEGACY_100T1_TIMER_MS_VAL                  [7:7]            get_LEGACY_100T1_TIMER_MS_VAL
''                                                             set_LEGACY_100T1_TIMER_MS_VAL
''                                                             read_LEGACY_100T1_TIMER_MS_VAL
''                                                             write_LEGACY_100T1_TIMER_MS_VAL
''---------------------------------------------------------------------------------
'' LEGACY_100T1_TIMER_ENABLE                  [6:6]            get_LEGACY_100T1_TIMER_ENABLE
''                                                             set_LEGACY_100T1_TIMER_ENABLE
''                                                             read_LEGACY_100T1_TIMER_ENABLE
''                                                             write_LEGACY_100T1_TIMER_ENABLE
''---------------------------------------------------------------------------------
'' DETECT_MV_END_COEFFICIENT                  [5:3]            get_DETECT_MV_END_COEFFICIENT
''                                                             set_DETECT_MV_END_COEFFICIENT
''                                                             read_DETECT_MV_END_COEFFICIENT
''                                                             write_DETECT_MV_END_COEFFICIENT
''---------------------------------------------------------------------------------
'' DMTC                                       [2:0]            get_DMTC
''                                                             set_DMTC
''                                                             read_DMTC
''                                                             write_DMTC
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg4
    Private write_ATMDM_value
    Private read_ATMDM_value
    Private flag_ATMDM
    Private write_L1001DMET_value
    Private read_L1001DMET_value
    Private flag_L1001DMET
    Private write_LEGACY_100T1_DETECT_MS_VAL_value
    Private read_LEGACY_100T1_DETECT_MS_VAL_value
    Private flag_LEGACY_100T1_DETECT_MS_VAL
    Private write_LEGACY_100T1_DETECTOR_VALUE_value
    Private read_LEGACY_100T1_DETECTOR_VALUE_value
    Private flag_LEGACY_100T1_DETECTOR_VALUE
    Private write_LEGACY_100T1_DETECT_ENABLE_value
    Private read_LEGACY_100T1_DETECT_ENABLE_value
    Private flag_LEGACY_100T1_DETECT_ENABLE
    Private write_AUTONEG_HPF_POLE_SEL_value
    Private read_AUTONEG_HPF_POLE_SEL_value
    Private flag_AUTONEG_HPF_POLE_SEL
    Private write_L1001TMET_value
    Private read_L1001TMET_value
    Private flag_L1001TMET
    Private write_LEGACY_100T1_TIMER_MS_VAL_value
    Private read_LEGACY_100T1_TIMER_MS_VAL_value
    Private flag_LEGACY_100T1_TIMER_MS_VAL
    Private write_LEGACY_100T1_TIMER_ENABLE_value
    Private read_LEGACY_100T1_TIMER_ENABLE_value
    Private flag_LEGACY_100T1_TIMER_ENABLE
    Private write_DETECT_MV_END_COEFFICIENT_value
    Private read_DETECT_MV_END_COEFFICIENT_value
    Private flag_DETECT_MV_END_COEFFICIENT
    Private write_DMTC_value
    Private read_DMTC_value
    Private flag_DMTC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ATMDM
        get_ATMDM = read_ATMDM_value
    End Property

    Property Let set_ATMDM(aData)
        write_ATMDM_value = aData
        flag_ATMDM        = &H1
    End Property

    Property Get read_ATMDM
        read
        read_ATMDM = read_ATMDM_value
    End Property

    Property Let write_ATMDM(aData)
        set_ATMDM = aData
        write
    End Property

    Property Get get_L1001DMET
        get_L1001DMET = read_L1001DMET_value
    End Property

    Property Let set_L1001DMET(aData)
        write_L1001DMET_value = aData
        flag_L1001DMET        = &H1
    End Property

    Property Get read_L1001DMET
        read
        read_L1001DMET = read_L1001DMET_value
    End Property

    Property Let write_L1001DMET(aData)
        set_L1001DMET = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_MS_VAL
        get_LEGACY_100T1_DETECT_MS_VAL = read_LEGACY_100T1_DETECT_MS_VAL_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_MS_VAL(aData)
        write_LEGACY_100T1_DETECT_MS_VAL_value = aData
        flag_LEGACY_100T1_DETECT_MS_VAL        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_MS_VAL
        read
        read_LEGACY_100T1_DETECT_MS_VAL = read_LEGACY_100T1_DETECT_MS_VAL_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_MS_VAL(aData)
        set_LEGACY_100T1_DETECT_MS_VAL = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECTOR_VALUE
        get_LEGACY_100T1_DETECTOR_VALUE = read_LEGACY_100T1_DETECTOR_VALUE_value
    End Property

    Property Let set_LEGACY_100T1_DETECTOR_VALUE(aData)
        write_LEGACY_100T1_DETECTOR_VALUE_value = aData
        flag_LEGACY_100T1_DETECTOR_VALUE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECTOR_VALUE
        read
        read_LEGACY_100T1_DETECTOR_VALUE = read_LEGACY_100T1_DETECTOR_VALUE_value
    End Property

    Property Let write_LEGACY_100T1_DETECTOR_VALUE(aData)
        set_LEGACY_100T1_DETECTOR_VALUE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_ENABLE
        get_LEGACY_100T1_DETECT_ENABLE = read_LEGACY_100T1_DETECT_ENABLE_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_ENABLE(aData)
        write_LEGACY_100T1_DETECT_ENABLE_value = aData
        flag_LEGACY_100T1_DETECT_ENABLE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_ENABLE
        read
        read_LEGACY_100T1_DETECT_ENABLE = read_LEGACY_100T1_DETECT_ENABLE_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_ENABLE(aData)
        set_LEGACY_100T1_DETECT_ENABLE = aData
        write
    End Property

    Property Get get_AUTONEG_HPF_POLE_SEL
        get_AUTONEG_HPF_POLE_SEL = read_AUTONEG_HPF_POLE_SEL_value
    End Property

    Property Let set_AUTONEG_HPF_POLE_SEL(aData)
        write_AUTONEG_HPF_POLE_SEL_value = aData
        flag_AUTONEG_HPF_POLE_SEL        = &H1
    End Property

    Property Get read_AUTONEG_HPF_POLE_SEL
        read
        read_AUTONEG_HPF_POLE_SEL = read_AUTONEG_HPF_POLE_SEL_value
    End Property

    Property Let write_AUTONEG_HPF_POLE_SEL(aData)
        set_AUTONEG_HPF_POLE_SEL = aData
        write
    End Property

    Property Get get_L1001TMET
        get_L1001TMET = read_L1001TMET_value
    End Property

    Property Let set_L1001TMET(aData)
        write_L1001TMET_value = aData
        flag_L1001TMET        = &H1
    End Property

    Property Get read_L1001TMET
        read
        read_L1001TMET = read_L1001TMET_value
    End Property

    Property Let write_L1001TMET(aData)
        set_L1001TMET = aData
        write
    End Property

    Property Get get_LEGACY_100T1_TIMER_MS_VAL
        get_LEGACY_100T1_TIMER_MS_VAL = read_LEGACY_100T1_TIMER_MS_VAL_value
    End Property

    Property Let set_LEGACY_100T1_TIMER_MS_VAL(aData)
        write_LEGACY_100T1_TIMER_MS_VAL_value = aData
        flag_LEGACY_100T1_TIMER_MS_VAL        = &H1
    End Property

    Property Get read_LEGACY_100T1_TIMER_MS_VAL
        read
        read_LEGACY_100T1_TIMER_MS_VAL = read_LEGACY_100T1_TIMER_MS_VAL_value
    End Property

    Property Let write_LEGACY_100T1_TIMER_MS_VAL(aData)
        set_LEGACY_100T1_TIMER_MS_VAL = aData
        write
    End Property

    Property Get get_LEGACY_100T1_TIMER_ENABLE
        get_LEGACY_100T1_TIMER_ENABLE = read_LEGACY_100T1_TIMER_ENABLE_value
    End Property

    Property Let set_LEGACY_100T1_TIMER_ENABLE(aData)
        write_LEGACY_100T1_TIMER_ENABLE_value = aData
        flag_LEGACY_100T1_TIMER_ENABLE        = &H1
    End Property

    Property Get read_LEGACY_100T1_TIMER_ENABLE
        read
        read_LEGACY_100T1_TIMER_ENABLE = read_LEGACY_100T1_TIMER_ENABLE_value
    End Property

    Property Let write_LEGACY_100T1_TIMER_ENABLE(aData)
        set_LEGACY_100T1_TIMER_ENABLE = aData
        write
    End Property

    Property Get get_DETECT_MV_END_COEFFICIENT
        get_DETECT_MV_END_COEFFICIENT = read_DETECT_MV_END_COEFFICIENT_value
    End Property

    Property Let set_DETECT_MV_END_COEFFICIENT(aData)
        write_DETECT_MV_END_COEFFICIENT_value = aData
        flag_DETECT_MV_END_COEFFICIENT        = &H1
    End Property

    Property Get read_DETECT_MV_END_COEFFICIENT
        read
        read_DETECT_MV_END_COEFFICIENT = read_DETECT_MV_END_COEFFICIENT_value
    End Property

    Property Let write_DETECT_MV_END_COEFFICIENT(aData)
        set_DETECT_MV_END_COEFFICIENT = aData
        write
    End Property

    Property Get get_DMTC
        get_DMTC = read_DMTC_value
    End Property

    Property Let set_DMTC(aData)
        write_DMTC_value = aData
        flag_DMTC        = &H1
    End Property

    Property Get read_DMTC
        read
        read_DMTC = read_DMTC_value
    End Property

    Property Let write_DMTC(aData)
        set_DMTC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ATMDM_value = rightShift(data_low, 15) and &H1
        read_L1001DMET_value = rightShift(data_low, 14) and &H1
        read_LEGACY_100T1_DETECT_MS_VAL_value = rightShift(data_low, 13) and &H1
        read_LEGACY_100T1_DETECTOR_VALUE_value = rightShift(data_low, 12) and &H1
        read_LEGACY_100T1_DETECT_ENABLE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_HPF_POLE_SEL_value = rightShift(data_low, 9) and &H3
        read_L1001TMET_value = rightShift(data_low, 8) and &H1
        read_LEGACY_100T1_TIMER_MS_VAL_value = rightShift(data_low, 7) and &H1
        read_LEGACY_100T1_TIMER_ENABLE_value = rightShift(data_low, 6) and &H1
        read_DETECT_MV_END_COEFFICIENT_value = rightShift(data_low, 3) and &H7
        DMTC_mask = &H7
        if data_low > LONG_MAX then
            if DMTC_mask = mask then
                read_DMTC_value = data_low
            else
                read_DMTC_value = (data_low - H8000_0000) and DMTC_mask
            end If
        else
            read_DMTC_value = data_low and DMTC_mask
        end If

    End Sub

    Sub write
        If flag_ATMDM = &H0 or flag_L1001DMET = &H0 or flag_LEGACY_100T1_DETECT_MS_VAL = &H0 or flag_LEGACY_100T1_DETECTOR_VALUE = &H0 or flag_LEGACY_100T1_DETECT_ENABLE = &H0 or flag_AUTONEG_HPF_POLE_SEL = &H0 or flag_L1001TMET = &H0 or flag_LEGACY_100T1_TIMER_MS_VAL = &H0 or flag_LEGACY_100T1_TIMER_ENABLE = &H0 or flag_DETECT_MV_END_COEFFICIENT = &H0 or flag_DMTC = &H0 Then read
        If flag_ATMDM = &H0 Then write_ATMDM_value = get_ATMDM
        If flag_L1001DMET = &H0 Then write_L1001DMET_value = get_L1001DMET
        If flag_LEGACY_100T1_DETECT_MS_VAL = &H0 Then write_LEGACY_100T1_DETECT_MS_VAL_value = get_LEGACY_100T1_DETECT_MS_VAL
        If flag_LEGACY_100T1_DETECTOR_VALUE = &H0 Then write_LEGACY_100T1_DETECTOR_VALUE_value = get_LEGACY_100T1_DETECTOR_VALUE
        If flag_LEGACY_100T1_DETECT_ENABLE = &H0 Then write_LEGACY_100T1_DETECT_ENABLE_value = get_LEGACY_100T1_DETECT_ENABLE
        If flag_AUTONEG_HPF_POLE_SEL = &H0 Then write_AUTONEG_HPF_POLE_SEL_value = get_AUTONEG_HPF_POLE_SEL
        If flag_L1001TMET = &H0 Then write_L1001TMET_value = get_L1001TMET
        If flag_LEGACY_100T1_TIMER_MS_VAL = &H0 Then write_LEGACY_100T1_TIMER_MS_VAL_value = get_LEGACY_100T1_TIMER_MS_VAL
        If flag_LEGACY_100T1_TIMER_ENABLE = &H0 Then write_LEGACY_100T1_TIMER_ENABLE_value = get_LEGACY_100T1_TIMER_ENABLE
        If flag_DETECT_MV_END_COEFFICIENT = &H0 Then write_DETECT_MV_END_COEFFICIENT_value = get_DETECT_MV_END_COEFFICIENT
        If flag_DMTC = &H0 Then write_DMTC_value = get_DMTC

        regValue = leftShift((write_ATMDM_value and &H1), 15) + leftShift((write_L1001DMET_value and &H1), 14) + leftShift((write_LEGACY_100T1_DETECT_MS_VAL_value and &H1), 13) + leftShift((write_LEGACY_100T1_DETECTOR_VALUE_value and &H1), 12) + leftShift((write_LEGACY_100T1_DETECT_ENABLE_value and &H1), 11) + leftShift((write_AUTONEG_HPF_POLE_SEL_value and &H3), 9) + leftShift((write_L1001TMET_value and &H1), 8) + leftShift((write_LEGACY_100T1_TIMER_MS_VAL_value and &H1), 7) + leftShift((write_LEGACY_100T1_TIMER_ENABLE_value and &H1), 6) + leftShift((write_DETECT_MV_END_COEFFICIENT_value and &H7), 3) + leftShift((write_DMTC_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ATMDM_value = rightShift(data_low, 15) and &H1
        read_L1001DMET_value = rightShift(data_low, 14) and &H1
        read_LEGACY_100T1_DETECT_MS_VAL_value = rightShift(data_low, 13) and &H1
        read_LEGACY_100T1_DETECTOR_VALUE_value = rightShift(data_low, 12) and &H1
        read_LEGACY_100T1_DETECT_ENABLE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_HPF_POLE_SEL_value = rightShift(data_low, 9) and &H3
        read_L1001TMET_value = rightShift(data_low, 8) and &H1
        read_LEGACY_100T1_TIMER_MS_VAL_value = rightShift(data_low, 7) and &H1
        read_LEGACY_100T1_TIMER_ENABLE_value = rightShift(data_low, 6) and &H1
        read_DETECT_MV_END_COEFFICIENT_value = rightShift(data_low, 3) and &H7
        DMTC_mask = &H7
        if data_low > LONG_MAX then
            if DMTC_mask = mask then
                read_DMTC_value = data_low
            else
                read_DMTC_value = (data_low - H8000_0000) and DMTC_mask
            end If
        else
            read_DMTC_value = data_low and DMTC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ATMDM_value = &H0
        flag_ATMDM        = &H0
        write_L1001DMET_value = &H0
        flag_L1001DMET        = &H0
        write_LEGACY_100T1_DETECT_MS_VAL_value = &H0
        flag_LEGACY_100T1_DETECT_MS_VAL        = &H0
        write_LEGACY_100T1_DETECTOR_VALUE_value = &H0
        flag_LEGACY_100T1_DETECTOR_VALUE        = &H0
        write_LEGACY_100T1_DETECT_ENABLE_value = &H0
        flag_LEGACY_100T1_DETECT_ENABLE        = &H0
        write_AUTONEG_HPF_POLE_SEL_value = &H0
        flag_AUTONEG_HPF_POLE_SEL        = &H0
        write_L1001TMET_value = &H0
        flag_L1001TMET        = &H0
        write_LEGACY_100T1_TIMER_MS_VAL_value = &H0
        flag_LEGACY_100T1_TIMER_MS_VAL        = &H0
        write_LEGACY_100T1_TIMER_ENABLE_value = &H0
        flag_LEGACY_100T1_TIMER_ENABLE        = &H0
        write_DETECT_MV_END_COEFFICIENT_value = &H0
        flag_DETECT_MV_END_COEFFICIENT        = &H0
        write_DMTC_value = &H0
        flag_DMTC        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' L1001DTV                                   [15:5]           get_L1001DTV
''                                                             set_L1001DTV
''                                                             read_L1001DTV
''                                                             write_L1001DTV
''---------------------------------------------------------------------------------
'' DETECT_MV_START_COEFFICIENT                [4:0]            get_DETECT_MV_START_COEFFICIENT
''                                                             set_DETECT_MV_START_COEFFICIENT
''                                                             read_DETECT_MV_START_COEFFICIENT
''                                                             write_DETECT_MV_START_COEFFICIENT
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg5
    Private write_L1001DTV_value
    Private read_L1001DTV_value
    Private flag_L1001DTV
    Private write_DETECT_MV_START_COEFFICIENT_value
    Private read_DETECT_MV_START_COEFFICIENT_value
    Private flag_DETECT_MV_START_COEFFICIENT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1010a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_L1001DTV
        get_L1001DTV = read_L1001DTV_value
    End Property

    Property Let set_L1001DTV(aData)
        write_L1001DTV_value = aData
        flag_L1001DTV        = &H1
    End Property

    Property Get read_L1001DTV
        read
        read_L1001DTV = read_L1001DTV_value
    End Property

    Property Let write_L1001DTV(aData)
        set_L1001DTV = aData
        write
    End Property

    Property Get get_DETECT_MV_START_COEFFICIENT
        get_DETECT_MV_START_COEFFICIENT = read_DETECT_MV_START_COEFFICIENT_value
    End Property

    Property Let set_DETECT_MV_START_COEFFICIENT(aData)
        write_DETECT_MV_START_COEFFICIENT_value = aData
        flag_DETECT_MV_START_COEFFICIENT        = &H1
    End Property

    Property Get read_DETECT_MV_START_COEFFICIENT
        read
        read_DETECT_MV_START_COEFFICIENT = read_DETECT_MV_START_COEFFICIENT_value
    End Property

    Property Let write_DETECT_MV_START_COEFFICIENT(aData)
        set_DETECT_MV_START_COEFFICIENT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_L1001DTV_value = rightShift(data_low, 5) and &H7ff
        DETECT_MV_START_COEFFICIENT_mask = &H1f
        if data_low > LONG_MAX then
            if DETECT_MV_START_COEFFICIENT_mask = mask then
                read_DETECT_MV_START_COEFFICIENT_value = data_low
            else
                read_DETECT_MV_START_COEFFICIENT_value = (data_low - H8000_0000) and DETECT_MV_START_COEFFICIENT_mask
            end If
        else
            read_DETECT_MV_START_COEFFICIENT_value = data_low and DETECT_MV_START_COEFFICIENT_mask
        end If

    End Sub

    Sub write
        If flag_L1001DTV = &H0 or flag_DETECT_MV_START_COEFFICIENT = &H0 Then read
        If flag_L1001DTV = &H0 Then write_L1001DTV_value = get_L1001DTV
        If flag_DETECT_MV_START_COEFFICIENT = &H0 Then write_DETECT_MV_START_COEFFICIENT_value = get_DETECT_MV_START_COEFFICIENT

        regValue = leftShift((write_L1001DTV_value and &H7ff), 5) + leftShift((write_DETECT_MV_START_COEFFICIENT_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_L1001DTV_value = rightShift(data_low, 5) and &H7ff
        DETECT_MV_START_COEFFICIENT_mask = &H1f
        if data_low > LONG_MAX then
            if DETECT_MV_START_COEFFICIENT_mask = mask then
                read_DETECT_MV_START_COEFFICIENT_value = data_low
            else
                read_DETECT_MV_START_COEFFICIENT_value = (data_low - H8000_0000) and DETECT_MV_START_COEFFICIENT_mask
            end If
        else
            read_DETECT_MV_START_COEFFICIENT_value = data_low and DETECT_MV_START_COEFFICIENT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_L1001DTV_value = &H0
        flag_L1001DTV        = &H0
        write_DETECT_MV_START_COEFFICIENT_value = &H0
        flag_DETECT_MV_START_COEFFICIENT        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DISABLE_SUM_ABS_PREV_CHECK                 [15:15]          get_DISABLE_SUM_ABS_PREV_CHECK
''                                                             set_DISABLE_SUM_ABS_PREV_CHECK
''                                                             read_DISABLE_SUM_ABS_PREV_CHECK
''                                                             write_DISABLE_SUM_ABS_PREV_CHECK
''---------------------------------------------------------------------------------
'' MDMST                                      [14:0]           get_MDMST
''                                                             set_MDMST
''                                                             read_MDMST
''                                                             write_MDMST
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg6
    Private write_DISABLE_SUM_ABS_PREV_CHECK_value
    Private read_DISABLE_SUM_ABS_PREV_CHECK_value
    Private flag_DISABLE_SUM_ABS_PREV_CHECK
    Private write_MDMST_value
    Private read_MDMST_value
    Private flag_MDMST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1010c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DISABLE_SUM_ABS_PREV_CHECK
        get_DISABLE_SUM_ABS_PREV_CHECK = read_DISABLE_SUM_ABS_PREV_CHECK_value
    End Property

    Property Let set_DISABLE_SUM_ABS_PREV_CHECK(aData)
        write_DISABLE_SUM_ABS_PREV_CHECK_value = aData
        flag_DISABLE_SUM_ABS_PREV_CHECK        = &H1
    End Property

    Property Get read_DISABLE_SUM_ABS_PREV_CHECK
        read
        read_DISABLE_SUM_ABS_PREV_CHECK = read_DISABLE_SUM_ABS_PREV_CHECK_value
    End Property

    Property Let write_DISABLE_SUM_ABS_PREV_CHECK(aData)
        set_DISABLE_SUM_ABS_PREV_CHECK = aData
        write
    End Property

    Property Get get_MDMST
        get_MDMST = read_MDMST_value
    End Property

    Property Let set_MDMST(aData)
        write_MDMST_value = aData
        flag_MDMST        = &H1
    End Property

    Property Get read_MDMST
        read
        read_MDMST = read_MDMST_value
    End Property

    Property Let write_MDMST(aData)
        set_MDMST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DISABLE_SUM_ABS_PREV_CHECK_value = rightShift(data_low, 15) and &H1
        MDMST_mask = &H7fff
        if data_low > LONG_MAX then
            if MDMST_mask = mask then
                read_MDMST_value = data_low
            else
                read_MDMST_value = (data_low - H8000_0000) and MDMST_mask
            end If
        else
            read_MDMST_value = data_low and MDMST_mask
        end If

    End Sub

    Sub write
        If flag_DISABLE_SUM_ABS_PREV_CHECK = &H0 or flag_MDMST = &H0 Then read
        If flag_DISABLE_SUM_ABS_PREV_CHECK = &H0 Then write_DISABLE_SUM_ABS_PREV_CHECK_value = get_DISABLE_SUM_ABS_PREV_CHECK
        If flag_MDMST = &H0 Then write_MDMST_value = get_MDMST

        regValue = leftShift((write_DISABLE_SUM_ABS_PREV_CHECK_value and &H1), 15) + leftShift((write_MDMST_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DISABLE_SUM_ABS_PREV_CHECK_value = rightShift(data_low, 15) and &H1
        MDMST_mask = &H7fff
        if data_low > LONG_MAX then
            if MDMST_mask = mask then
                read_MDMST_value = data_low
            else
                read_MDMST_value = (data_low - H8000_0000) and MDMST_mask
            end If
        else
            read_MDMST_value = data_low and MDMST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DISABLE_SUM_ABS_PREV_CHECK_value = &H0
        flag_DISABLE_SUM_ABS_PREV_CHECK        = &H0
        write_MDMST_value = &H0
        flag_MDMST        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DMSMT                                      [15:10]          get_DMSMT
''                                                             set_DMSMT
''                                                             read_DMSMT
''                                                             write_DMSMT
''---------------------------------------------------------------------------------
'' MDMTT                                      [9:0]            get_MDMTT
''                                                             set_MDMTT
''                                                             read_MDMTT
''                                                             write_MDMTT
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg7
    Private write_DMSMT_value
    Private read_DMSMT_value
    Private flag_DMSMT
    Private write_MDMTT_value
    Private read_MDMTT_value
    Private flag_MDMTT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1010e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DMSMT
        get_DMSMT = read_DMSMT_value
    End Property

    Property Let set_DMSMT(aData)
        write_DMSMT_value = aData
        flag_DMSMT        = &H1
    End Property

    Property Get read_DMSMT
        read
        read_DMSMT = read_DMSMT_value
    End Property

    Property Let write_DMSMT(aData)
        set_DMSMT = aData
        write
    End Property

    Property Get get_MDMTT
        get_MDMTT = read_MDMTT_value
    End Property

    Property Let set_MDMTT(aData)
        write_MDMTT_value = aData
        flag_MDMTT        = &H1
    End Property

    Property Get read_MDMTT
        read
        read_MDMTT = read_MDMTT_value
    End Property

    Property Let write_MDMTT(aData)
        set_MDMTT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DMSMT_value = rightShift(data_low, 10) and &H3f
        MDMTT_mask = &H3ff
        if data_low > LONG_MAX then
            if MDMTT_mask = mask then
                read_MDMTT_value = data_low
            else
                read_MDMTT_value = (data_low - H8000_0000) and MDMTT_mask
            end If
        else
            read_MDMTT_value = data_low and MDMTT_mask
        end If

    End Sub

    Sub write
        If flag_DMSMT = &H0 or flag_MDMTT = &H0 Then read
        If flag_DMSMT = &H0 Then write_DMSMT_value = get_DMSMT
        If flag_MDMTT = &H0 Then write_MDMTT_value = get_MDMTT

        regValue = leftShift((write_DMSMT_value and &H3f), 10) + leftShift((write_MDMTT_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DMSMT_value = rightShift(data_low, 10) and &H3f
        MDMTT_mask = &H3ff
        if data_low > LONG_MAX then
            if MDMTT_mask = mask then
                read_MDMTT_value = data_low
            else
                read_MDMTT_value = (data_low - H8000_0000) and MDMTT_mask
            end If
        else
            read_MDMTT_value = data_low and MDMTT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DMSMT_value = &H0
        flag_DMSMT        = &H0
        write_MDMTT_value = &H0
        flag_MDMTT        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_PGA_VALUE                          [15:10]          get_AUTONEG_PGA_VALUE
''                                                             set_AUTONEG_PGA_VALUE
''                                                             read_AUTONEG_PGA_VALUE
''                                                             write_AUTONEG_PGA_VALUE
''---------------------------------------------------------------------------------
'' MANUAL_DETECT_MV_END_THRESHOLD             [9:0]            get_MANUAL_DETECT_MV_END_THRESHOLD
''                                                             set_MANUAL_DETECT_MV_END_THRESHOLD
''                                                             read_MANUAL_DETECT_MV_END_THRESHOLD
''                                                             write_MANUAL_DETECT_MV_END_THRESHOLD
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg8
    Private write_AUTONEG_PGA_VALUE_value
    Private read_AUTONEG_PGA_VALUE_value
    Private flag_AUTONEG_PGA_VALUE
    Private write_MANUAL_DETECT_MV_END_THRESHOLD_value
    Private read_MANUAL_DETECT_MV_END_THRESHOLD_value
    Private flag_MANUAL_DETECT_MV_END_THRESHOLD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AUTONEG_PGA_VALUE
        get_AUTONEG_PGA_VALUE = read_AUTONEG_PGA_VALUE_value
    End Property

    Property Let set_AUTONEG_PGA_VALUE(aData)
        write_AUTONEG_PGA_VALUE_value = aData
        flag_AUTONEG_PGA_VALUE        = &H1
    End Property

    Property Get read_AUTONEG_PGA_VALUE
        read
        read_AUTONEG_PGA_VALUE = read_AUTONEG_PGA_VALUE_value
    End Property

    Property Let write_AUTONEG_PGA_VALUE(aData)
        set_AUTONEG_PGA_VALUE = aData
        write
    End Property

    Property Get get_MANUAL_DETECT_MV_END_THRESHOLD
        get_MANUAL_DETECT_MV_END_THRESHOLD = read_MANUAL_DETECT_MV_END_THRESHOLD_value
    End Property

    Property Let set_MANUAL_DETECT_MV_END_THRESHOLD(aData)
        write_MANUAL_DETECT_MV_END_THRESHOLD_value = aData
        flag_MANUAL_DETECT_MV_END_THRESHOLD        = &H1
    End Property

    Property Get read_MANUAL_DETECT_MV_END_THRESHOLD
        read
        read_MANUAL_DETECT_MV_END_THRESHOLD = read_MANUAL_DETECT_MV_END_THRESHOLD_value
    End Property

    Property Let write_MANUAL_DETECT_MV_END_THRESHOLD(aData)
        set_MANUAL_DETECT_MV_END_THRESHOLD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PGA_VALUE_value = rightShift(data_low, 10) and &H3f
        MANUAL_DETECT_MV_END_THRESHOLD_mask = &H3ff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_END_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_END_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low and MANUAL_DETECT_MV_END_THRESHOLD_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_PGA_VALUE = &H0 or flag_MANUAL_DETECT_MV_END_THRESHOLD = &H0 Then read
        If flag_AUTONEG_PGA_VALUE = &H0 Then write_AUTONEG_PGA_VALUE_value = get_AUTONEG_PGA_VALUE
        If flag_MANUAL_DETECT_MV_END_THRESHOLD = &H0 Then write_MANUAL_DETECT_MV_END_THRESHOLD_value = get_MANUAL_DETECT_MV_END_THRESHOLD

        regValue = leftShift((write_AUTONEG_PGA_VALUE_value and &H3f), 10) + leftShift((write_MANUAL_DETECT_MV_END_THRESHOLD_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PGA_VALUE_value = rightShift(data_low, 10) and &H3f
        MANUAL_DETECT_MV_END_THRESHOLD_mask = &H3ff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_END_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_END_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low and MANUAL_DETECT_MV_END_THRESHOLD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_PGA_VALUE_value = &H0
        flag_AUTONEG_PGA_VALUE        = &H0
        write_MANUAL_DETECT_MV_END_THRESHOLD_value = &H0
        flag_MANUAL_DETECT_MV_END_THRESHOLD        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_test_reg9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_BITS_TEST_REG9                       [15:1]           get_SPARE_BITS_TEST_REG9
''                                                             set_SPARE_BITS_TEST_REG9
''                                                             read_SPARE_BITS_TEST_REG9
''                                                             write_SPARE_BITS_TEST_REG9
''---------------------------------------------------------------------------------
'' TC10_RESOLUTION                            [0:0]            get_TC10_RESOLUTION
''                                                             set_TC10_RESOLUTION
''                                                             read_TC10_RESOLUTION
''                                                             write_TC10_RESOLUTION
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_test_reg9
    Private write_SPARE_BITS_TEST_REG9_value
    Private read_SPARE_BITS_TEST_REG9_value
    Private flag_SPARE_BITS_TEST_REG9
    Private write_TC10_RESOLUTION_value
    Private read_TC10_RESOLUTION_value
    Private flag_TC10_RESOLUTION

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10112
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_BITS_TEST_REG9
        get_SPARE_BITS_TEST_REG9 = read_SPARE_BITS_TEST_REG9_value
    End Property

    Property Let set_SPARE_BITS_TEST_REG9(aData)
        write_SPARE_BITS_TEST_REG9_value = aData
        flag_SPARE_BITS_TEST_REG9        = &H1
    End Property

    Property Get read_SPARE_BITS_TEST_REG9
        read
        read_SPARE_BITS_TEST_REG9 = read_SPARE_BITS_TEST_REG9_value
    End Property

    Property Let write_SPARE_BITS_TEST_REG9(aData)
        set_SPARE_BITS_TEST_REG9 = aData
        write
    End Property

    Property Get get_TC10_RESOLUTION
        get_TC10_RESOLUTION = read_TC10_RESOLUTION_value
    End Property

    Property Let set_TC10_RESOLUTION(aData)
        write_TC10_RESOLUTION_value = aData
        flag_TC10_RESOLUTION        = &H1
    End Property

    Property Get read_TC10_RESOLUTION
        read
        read_TC10_RESOLUTION = read_TC10_RESOLUTION_value
    End Property

    Property Let write_TC10_RESOLUTION(aData)
        set_TC10_RESOLUTION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_BITS_TEST_REG9_value = rightShift(data_low, 1) and &H7fff
        TC10_RESOLUTION_mask = &H1
        if data_low > LONG_MAX then
            if TC10_RESOLUTION_mask = mask then
                read_TC10_RESOLUTION_value = data_low
            else
                read_TC10_RESOLUTION_value = (data_low - H8000_0000) and TC10_RESOLUTION_mask
            end If
        else
            read_TC10_RESOLUTION_value = data_low and TC10_RESOLUTION_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_BITS_TEST_REG9 = &H0 or flag_TC10_RESOLUTION = &H0 Then read
        If flag_SPARE_BITS_TEST_REG9 = &H0 Then write_SPARE_BITS_TEST_REG9_value = get_SPARE_BITS_TEST_REG9
        If flag_TC10_RESOLUTION = &H0 Then write_TC10_RESOLUTION_value = get_TC10_RESOLUTION

        regValue = leftShift((write_SPARE_BITS_TEST_REG9_value and &H7fff), 1) + leftShift((write_TC10_RESOLUTION_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_BITS_TEST_REG9_value = rightShift(data_low, 1) and &H7fff
        TC10_RESOLUTION_mask = &H1
        if data_low > LONG_MAX then
            if TC10_RESOLUTION_mask = mask then
                read_TC10_RESOLUTION_value = data_low
            else
                read_TC10_RESOLUTION_value = (data_low - H8000_0000) and TC10_RESOLUTION_mask
            end If
        else
            read_TC10_RESOLUTION_value = data_low and TC10_RESOLUTION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_BITS_TEST_REG9_value = &H0
        flag_SPARE_BITS_TEST_REG9        = &H0
        write_TC10_RESOLUTION_value = &H0
        flag_TC10_RESOLUTION        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_interrupt_status_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AISRSB1512                                 [15:12]          get_AISRSB1512
''                                                             set_AISRSB1512
''                                                             read_AISRSB1512
''                                                             write_AISRSB1512
''---------------------------------------------------------------------------------
'' AWDIS                                      [11:11]          get_AWDIS
''                                                             set_AWDIS
''                                                             read_AWDIS
''                                                             write_AWDIS
''---------------------------------------------------------------------------------
'' ALGCIS                                     [10:10]          get_ALGCIS
''                                                             set_ALGCIS
''                                                             read_ALGCIS
''                                                             write_ALGCIS
''---------------------------------------------------------------------------------
'' MARIS                                      [9:9]            get_MARIS
''                                                             set_MARIS
''                                                             read_MARIS
''                                                             write_MARIS
''---------------------------------------------------------------------------------
'' AISRSB8                                    [8:8]            get_AISRSB8
''                                                             set_AISRSB8
''                                                             read_AISRSB8
''                                                             write_AISRSB8
''---------------------------------------------------------------------------------
'' CFIS                                       [7:7]            get_CFIS
''                                                             set_CFIS
''                                                             read_CFIS
''                                                             write_CFIS
''---------------------------------------------------------------------------------
'' MR_PAGE_RX_INTERRUPT_STATUS                [6:6]            get_MR_PAGE_RX_INTERRUPT_STATUS
''                                                             set_MR_PAGE_RX_INTERRUPT_STATUS
''                                                             read_MR_PAGE_RX_INTERRUPT_STATUS
''                                                             write_MR_PAGE_RX_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' MACIS                                      [5:5]            get_MACIS
''                                                             set_MACIS
''                                                             read_MACIS
''                                                             write_MACIS
''---------------------------------------------------------------------------------
'' REMOTE_FAULT_INTERRUPT_STATUS              [4:4]            get_REMOTE_FAULT_INTERRUPT_STATUS
''                                                             set_REMOTE_FAULT_INTERRUPT_STATUS
''                                                             read_REMOTE_FAULT_INTERRUPT_STATUS
''                                                             write_REMOTE_FAULT_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' AISRSB3                                    [3:3]            get_AISRSB3
''                                                             set_AISRSB3
''                                                             read_AISRSB3
''                                                             write_AISRSB3
''---------------------------------------------------------------------------------
'' AISRSB2                                    [2:2]            get_AISRSB2
''                                                             set_AISRSB2
''                                                             read_AISRSB2
''                                                             write_AISRSB2
''---------------------------------------------------------------------------------
'' RLSUIS                                     [1:1]            get_RLSUIS
''                                                             set_RLSUIS
''                                                             read_RLSUIS
''                                                             write_RLSUIS
''---------------------------------------------------------------------------------
'' RLSDIS                                     [0:0]            get_RLSDIS
''                                                             set_RLSDIS
''                                                             read_RLSDIS
''                                                             write_RLSDIS
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_interrupt_status_reg
    Private write_AISRSB1512_value
    Private read_AISRSB1512_value
    Private flag_AISRSB1512
    Private write_AWDIS_value
    Private read_AWDIS_value
    Private flag_AWDIS
    Private write_ALGCIS_value
    Private read_ALGCIS_value
    Private flag_ALGCIS
    Private write_MARIS_value
    Private read_MARIS_value
    Private flag_MARIS
    Private write_AISRSB8_value
    Private read_AISRSB8_value
    Private flag_AISRSB8
    Private write_CFIS_value
    Private read_CFIS_value
    Private flag_CFIS
    Private write_MR_PAGE_RX_INTERRUPT_STATUS_value
    Private read_MR_PAGE_RX_INTERRUPT_STATUS_value
    Private flag_MR_PAGE_RX_INTERRUPT_STATUS
    Private write_MACIS_value
    Private read_MACIS_value
    Private flag_MACIS
    Private write_REMOTE_FAULT_INTERRUPT_STATUS_value
    Private read_REMOTE_FAULT_INTERRUPT_STATUS_value
    Private flag_REMOTE_FAULT_INTERRUPT_STATUS
    Private write_AISRSB3_value
    Private read_AISRSB3_value
    Private flag_AISRSB3
    Private write_AISRSB2_value
    Private read_AISRSB2_value
    Private flag_AISRSB2
    Private write_RLSUIS_value
    Private read_RLSUIS_value
    Private flag_RLSUIS
    Private write_RLSDIS_value
    Private read_RLSDIS_value
    Private flag_RLSDIS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AISRSB1512
        get_AISRSB1512 = read_AISRSB1512_value
    End Property

    Property Let set_AISRSB1512(aData)
        write_AISRSB1512_value = aData
        flag_AISRSB1512        = &H1
    End Property

    Property Get read_AISRSB1512
        read
        read_AISRSB1512 = read_AISRSB1512_value
    End Property

    Property Let write_AISRSB1512(aData)
        set_AISRSB1512 = aData
        write
    End Property

    Property Get get_AWDIS
        get_AWDIS = read_AWDIS_value
    End Property

    Property Let set_AWDIS(aData)
        write_AWDIS_value = aData
        flag_AWDIS        = &H1
    End Property

    Property Get read_AWDIS
        read
        read_AWDIS = read_AWDIS_value
    End Property

    Property Let write_AWDIS(aData)
        set_AWDIS = aData
        write
    End Property

    Property Get get_ALGCIS
        get_ALGCIS = read_ALGCIS_value
    End Property

    Property Let set_ALGCIS(aData)
        write_ALGCIS_value = aData
        flag_ALGCIS        = &H1
    End Property

    Property Get read_ALGCIS
        read
        read_ALGCIS = read_ALGCIS_value
    End Property

    Property Let write_ALGCIS(aData)
        set_ALGCIS = aData
        write
    End Property

    Property Get get_MARIS
        get_MARIS = read_MARIS_value
    End Property

    Property Let set_MARIS(aData)
        write_MARIS_value = aData
        flag_MARIS        = &H1
    End Property

    Property Get read_MARIS
        read
        read_MARIS = read_MARIS_value
    End Property

    Property Let write_MARIS(aData)
        set_MARIS = aData
        write
    End Property

    Property Get get_AISRSB8
        get_AISRSB8 = read_AISRSB8_value
    End Property

    Property Let set_AISRSB8(aData)
        write_AISRSB8_value = aData
        flag_AISRSB8        = &H1
    End Property

    Property Get read_AISRSB8
        read
        read_AISRSB8 = read_AISRSB8_value
    End Property

    Property Let write_AISRSB8(aData)
        set_AISRSB8 = aData
        write
    End Property

    Property Get get_CFIS
        get_CFIS = read_CFIS_value
    End Property

    Property Let set_CFIS(aData)
        write_CFIS_value = aData
        flag_CFIS        = &H1
    End Property

    Property Get read_CFIS
        read
        read_CFIS = read_CFIS_value
    End Property

    Property Let write_CFIS(aData)
        set_CFIS = aData
        write
    End Property

    Property Get get_MR_PAGE_RX_INTERRUPT_STATUS
        get_MR_PAGE_RX_INTERRUPT_STATUS = read_MR_PAGE_RX_INTERRUPT_STATUS_value
    End Property

    Property Let set_MR_PAGE_RX_INTERRUPT_STATUS(aData)
        write_MR_PAGE_RX_INTERRUPT_STATUS_value = aData
        flag_MR_PAGE_RX_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_MR_PAGE_RX_INTERRUPT_STATUS
        read
        read_MR_PAGE_RX_INTERRUPT_STATUS = read_MR_PAGE_RX_INTERRUPT_STATUS_value
    End Property

    Property Let write_MR_PAGE_RX_INTERRUPT_STATUS(aData)
        set_MR_PAGE_RX_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_MACIS
        get_MACIS = read_MACIS_value
    End Property

    Property Let set_MACIS(aData)
        write_MACIS_value = aData
        flag_MACIS        = &H1
    End Property

    Property Get read_MACIS
        read
        read_MACIS = read_MACIS_value
    End Property

    Property Let write_MACIS(aData)
        set_MACIS = aData
        write
    End Property

    Property Get get_REMOTE_FAULT_INTERRUPT_STATUS
        get_REMOTE_FAULT_INTERRUPT_STATUS = read_REMOTE_FAULT_INTERRUPT_STATUS_value
    End Property

    Property Let set_REMOTE_FAULT_INTERRUPT_STATUS(aData)
        write_REMOTE_FAULT_INTERRUPT_STATUS_value = aData
        flag_REMOTE_FAULT_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_REMOTE_FAULT_INTERRUPT_STATUS
        read
        read_REMOTE_FAULT_INTERRUPT_STATUS = read_REMOTE_FAULT_INTERRUPT_STATUS_value
    End Property

    Property Let write_REMOTE_FAULT_INTERRUPT_STATUS(aData)
        set_REMOTE_FAULT_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_AISRSB3
        get_AISRSB3 = read_AISRSB3_value
    End Property

    Property Let set_AISRSB3(aData)
        write_AISRSB3_value = aData
        flag_AISRSB3        = &H1
    End Property

    Property Get read_AISRSB3
        read
        read_AISRSB3 = read_AISRSB3_value
    End Property

    Property Let write_AISRSB3(aData)
        set_AISRSB3 = aData
        write
    End Property

    Property Get get_AISRSB2
        get_AISRSB2 = read_AISRSB2_value
    End Property

    Property Let set_AISRSB2(aData)
        write_AISRSB2_value = aData
        flag_AISRSB2        = &H1
    End Property

    Property Get read_AISRSB2
        read
        read_AISRSB2 = read_AISRSB2_value
    End Property

    Property Let write_AISRSB2(aData)
        set_AISRSB2 = aData
        write
    End Property

    Property Get get_RLSUIS
        get_RLSUIS = read_RLSUIS_value
    End Property

    Property Let set_RLSUIS(aData)
        write_RLSUIS_value = aData
        flag_RLSUIS        = &H1
    End Property

    Property Get read_RLSUIS
        read
        read_RLSUIS = read_RLSUIS_value
    End Property

    Property Let write_RLSUIS(aData)
        set_RLSUIS = aData
        write
    End Property

    Property Get get_RLSDIS
        get_RLSDIS = read_RLSDIS_value
    End Property

    Property Let set_RLSDIS(aData)
        write_RLSDIS_value = aData
        flag_RLSDIS        = &H1
    End Property

    Property Get read_RLSDIS
        read
        read_RLSDIS = read_RLSDIS_value
    End Property

    Property Let write_RLSDIS(aData)
        set_RLSDIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AISRSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIS_value = rightShift(data_low, 11) and &H1
        read_ALGCIS_value = rightShift(data_low, 10) and &H1
        read_MARIS_value = rightShift(data_low, 9) and &H1
        read_AISRSB8_value = rightShift(data_low, 8) and &H1
        read_CFIS_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_STATUS_value = rightShift(data_low, 6) and &H1
        read_MACIS_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_STATUS_value = rightShift(data_low, 4) and &H1
        read_AISRSB3_value = rightShift(data_low, 3) and &H1
        read_AISRSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIS_value = rightShift(data_low, 1) and &H1
        RLSDIS_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIS_mask = mask then
                read_RLSDIS_value = data_low
            else
                read_RLSDIS_value = (data_low - H8000_0000) and RLSDIS_mask
            end If
        else
            read_RLSDIS_value = data_low and RLSDIS_mask
        end If

    End Sub

    Sub write
        If flag_AISRSB1512 = &H0 or flag_AWDIS = &H0 or flag_ALGCIS = &H0 or flag_MARIS = &H0 or flag_AISRSB8 = &H0 or flag_CFIS = &H0 or flag_MR_PAGE_RX_INTERRUPT_STATUS = &H0 or flag_MACIS = &H0 or flag_REMOTE_FAULT_INTERRUPT_STATUS = &H0 or flag_AISRSB3 = &H0 or flag_AISRSB2 = &H0 or flag_RLSUIS = &H0 or flag_RLSDIS = &H0 Then read
        If flag_AISRSB1512 = &H0 Then write_AISRSB1512_value = get_AISRSB1512
        If flag_AWDIS = &H0 Then write_AWDIS_value = get_AWDIS
        If flag_ALGCIS = &H0 Then write_ALGCIS_value = get_ALGCIS
        If flag_MARIS = &H0 Then write_MARIS_value = get_MARIS
        If flag_AISRSB8 = &H0 Then write_AISRSB8_value = get_AISRSB8
        If flag_CFIS = &H0 Then write_CFIS_value = get_CFIS
        If flag_MR_PAGE_RX_INTERRUPT_STATUS = &H0 Then write_MR_PAGE_RX_INTERRUPT_STATUS_value = get_MR_PAGE_RX_INTERRUPT_STATUS
        If flag_MACIS = &H0 Then write_MACIS_value = get_MACIS
        If flag_REMOTE_FAULT_INTERRUPT_STATUS = &H0 Then write_REMOTE_FAULT_INTERRUPT_STATUS_value = get_REMOTE_FAULT_INTERRUPT_STATUS
        If flag_AISRSB3 = &H0 Then write_AISRSB3_value = get_AISRSB3
        If flag_AISRSB2 = &H0 Then write_AISRSB2_value = get_AISRSB2
        If flag_RLSUIS = &H0 Then write_RLSUIS_value = get_RLSUIS
        If flag_RLSDIS = &H0 Then write_RLSDIS_value = get_RLSDIS

        regValue = leftShift((write_AISRSB1512_value and &Hf), 12) + leftShift((write_AWDIS_value and &H1), 11) + leftShift((write_ALGCIS_value and &H1), 10) + leftShift((write_MARIS_value and &H1), 9) + leftShift((write_AISRSB8_value and &H1), 8) + leftShift((write_CFIS_value and &H1), 7) + leftShift((write_MR_PAGE_RX_INTERRUPT_STATUS_value and &H1), 6) + leftShift((write_MACIS_value and &H1), 5) + leftShift((write_REMOTE_FAULT_INTERRUPT_STATUS_value and &H1), 4) + leftShift((write_AISRSB3_value and &H1), 3) + leftShift((write_AISRSB2_value and &H1), 2) + leftShift((write_RLSUIS_value and &H1), 1) + leftShift((write_RLSDIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AISRSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIS_value = rightShift(data_low, 11) and &H1
        read_ALGCIS_value = rightShift(data_low, 10) and &H1
        read_MARIS_value = rightShift(data_low, 9) and &H1
        read_AISRSB8_value = rightShift(data_low, 8) and &H1
        read_CFIS_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_STATUS_value = rightShift(data_low, 6) and &H1
        read_MACIS_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_STATUS_value = rightShift(data_low, 4) and &H1
        read_AISRSB3_value = rightShift(data_low, 3) and &H1
        read_AISRSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIS_value = rightShift(data_low, 1) and &H1
        RLSDIS_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIS_mask = mask then
                read_RLSDIS_value = data_low
            else
                read_RLSDIS_value = (data_low - H8000_0000) and RLSDIS_mask
            end If
        else
            read_RLSDIS_value = data_low and RLSDIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AISRSB1512_value = &H0
        flag_AISRSB1512        = &H0
        write_AWDIS_value = &H0
        flag_AWDIS        = &H0
        write_ALGCIS_value = &H0
        flag_ALGCIS        = &H0
        write_MARIS_value = &H0
        flag_MARIS        = &H0
        write_AISRSB8_value = &H0
        flag_AISRSB8        = &H0
        write_CFIS_value = &H0
        flag_CFIS        = &H0
        write_MR_PAGE_RX_INTERRUPT_STATUS_value = &H0
        flag_MR_PAGE_RX_INTERRUPT_STATUS        = &H0
        write_MACIS_value = &H0
        flag_MACIS        = &H0
        write_REMOTE_FAULT_INTERRUPT_STATUS_value = &H0
        flag_REMOTE_FAULT_INTERRUPT_STATUS        = &H0
        write_AISRSB3_value = &H0
        flag_AISRSB3        = &H0
        write_AISRSB2_value = &H0
        flag_AISRSB2        = &H0
        write_RLSUIS_value = &H0
        flag_RLSUIS        = &H0
        write_RLSDIS_value = &H0
        flag_RLSDIS        = &H0
    End Sub
End Class


'' @REGISTER : AUTONEG_IEEE_autoneg_interrupt_enable_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AIERSB1512                                 [15:12]          get_AIERSB1512
''                                                             set_AIERSB1512
''                                                             read_AIERSB1512
''                                                             write_AIERSB1512
''---------------------------------------------------------------------------------
'' AWDIE                                      [11:11]          get_AWDIE
''                                                             set_AWDIE
''                                                             read_AWDIE
''                                                             write_AWDIE
''---------------------------------------------------------------------------------
'' ALGCIE                                     [10:10]          get_ALGCIE
''                                                             set_ALGCIE
''                                                             read_ALGCIE
''                                                             write_ALGCIE
''---------------------------------------------------------------------------------
'' MARIE                                      [9:9]            get_MARIE
''                                                             set_MARIE
''                                                             read_MARIE
''                                                             write_MARIE
''---------------------------------------------------------------------------------
'' AIERSB8                                    [8:8]            get_AIERSB8
''                                                             set_AIERSB8
''                                                             read_AIERSB8
''                                                             write_AIERSB8
''---------------------------------------------------------------------------------
'' CFIE                                       [7:7]            get_CFIE
''                                                             set_CFIE
''                                                             read_CFIE
''                                                             write_CFIE
''---------------------------------------------------------------------------------
'' MR_PAGE_RX_INTERRUPT_ENABLE                [6:6]            get_MR_PAGE_RX_INTERRUPT_ENABLE
''                                                             set_MR_PAGE_RX_INTERRUPT_ENABLE
''                                                             read_MR_PAGE_RX_INTERRUPT_ENABLE
''                                                             write_MR_PAGE_RX_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' MACIE                                      [5:5]            get_MACIE
''                                                             set_MACIE
''                                                             read_MACIE
''                                                             write_MACIE
''---------------------------------------------------------------------------------
'' REMOTE_FAULT_INTERRUPT_ENABLE              [4:4]            get_REMOTE_FAULT_INTERRUPT_ENABLE
''                                                             set_REMOTE_FAULT_INTERRUPT_ENABLE
''                                                             read_REMOTE_FAULT_INTERRUPT_ENABLE
''                                                             write_REMOTE_FAULT_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' AIERSB3                                    [3:3]            get_AIERSB3
''                                                             set_AIERSB3
''                                                             read_AIERSB3
''                                                             write_AIERSB3
''---------------------------------------------------------------------------------
'' AIERSB2                                    [2:2]            get_AIERSB2
''                                                             set_AIERSB2
''                                                             read_AIERSB2
''                                                             write_AIERSB2
''---------------------------------------------------------------------------------
'' RLSUIE                                     [1:1]            get_RLSUIE
''                                                             set_RLSUIE
''                                                             read_RLSUIE
''                                                             write_RLSUIE
''---------------------------------------------------------------------------------
'' RLSDIE                                     [0:0]            get_RLSDIE
''                                                             set_RLSDIE
''                                                             read_RLSDIE
''                                                             write_RLSDIE
''---------------------------------------------------------------------------------
Class REGISTER_AUTONEG_IEEE_autoneg_interrupt_enable_reg
    Private write_AIERSB1512_value
    Private read_AIERSB1512_value
    Private flag_AIERSB1512
    Private write_AWDIE_value
    Private read_AWDIE_value
    Private flag_AWDIE
    Private write_ALGCIE_value
    Private read_ALGCIE_value
    Private flag_ALGCIE
    Private write_MARIE_value
    Private read_MARIE_value
    Private flag_MARIE
    Private write_AIERSB8_value
    Private read_AIERSB8_value
    Private flag_AIERSB8
    Private write_CFIE_value
    Private read_CFIE_value
    Private flag_CFIE
    Private write_MR_PAGE_RX_INTERRUPT_ENABLE_value
    Private read_MR_PAGE_RX_INTERRUPT_ENABLE_value
    Private flag_MR_PAGE_RX_INTERRUPT_ENABLE
    Private write_MACIE_value
    Private read_MACIE_value
    Private flag_MACIE
    Private write_REMOTE_FAULT_INTERRUPT_ENABLE_value
    Private read_REMOTE_FAULT_INTERRUPT_ENABLE_value
    Private flag_REMOTE_FAULT_INTERRUPT_ENABLE
    Private write_AIERSB3_value
    Private read_AIERSB3_value
    Private flag_AIERSB3
    Private write_AIERSB2_value
    Private read_AIERSB2_value
    Private flag_AIERSB2
    Private write_RLSUIE_value
    Private read_RLSUIE_value
    Private flag_RLSUIE
    Private write_RLSDIE_value
    Private read_RLSDIE_value
    Private flag_RLSDIE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10122
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AIERSB1512
        get_AIERSB1512 = read_AIERSB1512_value
    End Property

    Property Let set_AIERSB1512(aData)
        write_AIERSB1512_value = aData
        flag_AIERSB1512        = &H1
    End Property

    Property Get read_AIERSB1512
        read
        read_AIERSB1512 = read_AIERSB1512_value
    End Property

    Property Let write_AIERSB1512(aData)
        set_AIERSB1512 = aData
        write
    End Property

    Property Get get_AWDIE
        get_AWDIE = read_AWDIE_value
    End Property

    Property Let set_AWDIE(aData)
        write_AWDIE_value = aData
        flag_AWDIE        = &H1
    End Property

    Property Get read_AWDIE
        read
        read_AWDIE = read_AWDIE_value
    End Property

    Property Let write_AWDIE(aData)
        set_AWDIE = aData
        write
    End Property

    Property Get get_ALGCIE
        get_ALGCIE = read_ALGCIE_value
    End Property

    Property Let set_ALGCIE(aData)
        write_ALGCIE_value = aData
        flag_ALGCIE        = &H1
    End Property

    Property Get read_ALGCIE
        read
        read_ALGCIE = read_ALGCIE_value
    End Property

    Property Let write_ALGCIE(aData)
        set_ALGCIE = aData
        write
    End Property

    Property Get get_MARIE
        get_MARIE = read_MARIE_value
    End Property

    Property Let set_MARIE(aData)
        write_MARIE_value = aData
        flag_MARIE        = &H1
    End Property

    Property Get read_MARIE
        read
        read_MARIE = read_MARIE_value
    End Property

    Property Let write_MARIE(aData)
        set_MARIE = aData
        write
    End Property

    Property Get get_AIERSB8
        get_AIERSB8 = read_AIERSB8_value
    End Property

    Property Let set_AIERSB8(aData)
        write_AIERSB8_value = aData
        flag_AIERSB8        = &H1
    End Property

    Property Get read_AIERSB8
        read
        read_AIERSB8 = read_AIERSB8_value
    End Property

    Property Let write_AIERSB8(aData)
        set_AIERSB8 = aData
        write
    End Property

    Property Get get_CFIE
        get_CFIE = read_CFIE_value
    End Property

    Property Let set_CFIE(aData)
        write_CFIE_value = aData
        flag_CFIE        = &H1
    End Property

    Property Get read_CFIE
        read
        read_CFIE = read_CFIE_value
    End Property

    Property Let write_CFIE(aData)
        set_CFIE = aData
        write
    End Property

    Property Get get_MR_PAGE_RX_INTERRUPT_ENABLE
        get_MR_PAGE_RX_INTERRUPT_ENABLE = read_MR_PAGE_RX_INTERRUPT_ENABLE_value
    End Property

    Property Let set_MR_PAGE_RX_INTERRUPT_ENABLE(aData)
        write_MR_PAGE_RX_INTERRUPT_ENABLE_value = aData
        flag_MR_PAGE_RX_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_MR_PAGE_RX_INTERRUPT_ENABLE
        read
        read_MR_PAGE_RX_INTERRUPT_ENABLE = read_MR_PAGE_RX_INTERRUPT_ENABLE_value
    End Property

    Property Let write_MR_PAGE_RX_INTERRUPT_ENABLE(aData)
        set_MR_PAGE_RX_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_MACIE
        get_MACIE = read_MACIE_value
    End Property

    Property Let set_MACIE(aData)
        write_MACIE_value = aData
        flag_MACIE        = &H1
    End Property

    Property Get read_MACIE
        read
        read_MACIE = read_MACIE_value
    End Property

    Property Let write_MACIE(aData)
        set_MACIE = aData
        write
    End Property

    Property Get get_REMOTE_FAULT_INTERRUPT_ENABLE
        get_REMOTE_FAULT_INTERRUPT_ENABLE = read_REMOTE_FAULT_INTERRUPT_ENABLE_value
    End Property

    Property Let set_REMOTE_FAULT_INTERRUPT_ENABLE(aData)
        write_REMOTE_FAULT_INTERRUPT_ENABLE_value = aData
        flag_REMOTE_FAULT_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_REMOTE_FAULT_INTERRUPT_ENABLE
        read
        read_REMOTE_FAULT_INTERRUPT_ENABLE = read_REMOTE_FAULT_INTERRUPT_ENABLE_value
    End Property

    Property Let write_REMOTE_FAULT_INTERRUPT_ENABLE(aData)
        set_REMOTE_FAULT_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_AIERSB3
        get_AIERSB3 = read_AIERSB3_value
    End Property

    Property Let set_AIERSB3(aData)
        write_AIERSB3_value = aData
        flag_AIERSB3        = &H1
    End Property

    Property Get read_AIERSB3
        read
        read_AIERSB3 = read_AIERSB3_value
    End Property

    Property Let write_AIERSB3(aData)
        set_AIERSB3 = aData
        write
    End Property

    Property Get get_AIERSB2
        get_AIERSB2 = read_AIERSB2_value
    End Property

    Property Let set_AIERSB2(aData)
        write_AIERSB2_value = aData
        flag_AIERSB2        = &H1
    End Property

    Property Get read_AIERSB2
        read
        read_AIERSB2 = read_AIERSB2_value
    End Property

    Property Let write_AIERSB2(aData)
        set_AIERSB2 = aData
        write
    End Property

    Property Get get_RLSUIE
        get_RLSUIE = read_RLSUIE_value
    End Property

    Property Let set_RLSUIE(aData)
        write_RLSUIE_value = aData
        flag_RLSUIE        = &H1
    End Property

    Property Get read_RLSUIE
        read
        read_RLSUIE = read_RLSUIE_value
    End Property

    Property Let write_RLSUIE(aData)
        set_RLSUIE = aData
        write
    End Property

    Property Get get_RLSDIE
        get_RLSDIE = read_RLSDIE_value
    End Property

    Property Let set_RLSDIE(aData)
        write_RLSDIE_value = aData
        flag_RLSDIE        = &H1
    End Property

    Property Get read_RLSDIE
        read
        read_RLSDIE = read_RLSDIE_value
    End Property

    Property Let write_RLSDIE(aData)
        set_RLSDIE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AIERSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIE_value = rightShift(data_low, 11) and &H1
        read_ALGCIE_value = rightShift(data_low, 10) and &H1
        read_MARIE_value = rightShift(data_low, 9) and &H1
        read_AIERSB8_value = rightShift(data_low, 8) and &H1
        read_CFIE_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_ENABLE_value = rightShift(data_low, 6) and &H1
        read_MACIE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_ENABLE_value = rightShift(data_low, 4) and &H1
        read_AIERSB3_value = rightShift(data_low, 3) and &H1
        read_AIERSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIE_value = rightShift(data_low, 1) and &H1
        RLSDIE_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIE_mask = mask then
                read_RLSDIE_value = data_low
            else
                read_RLSDIE_value = (data_low - H8000_0000) and RLSDIE_mask
            end If
        else
            read_RLSDIE_value = data_low and RLSDIE_mask
        end If

    End Sub

    Sub write
        If flag_AIERSB1512 = &H0 or flag_AWDIE = &H0 or flag_ALGCIE = &H0 or flag_MARIE = &H0 or flag_AIERSB8 = &H0 or flag_CFIE = &H0 or flag_MR_PAGE_RX_INTERRUPT_ENABLE = &H0 or flag_MACIE = &H0 or flag_REMOTE_FAULT_INTERRUPT_ENABLE = &H0 or flag_AIERSB3 = &H0 or flag_AIERSB2 = &H0 or flag_RLSUIE = &H0 or flag_RLSDIE = &H0 Then read
        If flag_AIERSB1512 = &H0 Then write_AIERSB1512_value = get_AIERSB1512
        If flag_AWDIE = &H0 Then write_AWDIE_value = get_AWDIE
        If flag_ALGCIE = &H0 Then write_ALGCIE_value = get_ALGCIE
        If flag_MARIE = &H0 Then write_MARIE_value = get_MARIE
        If flag_AIERSB8 = &H0 Then write_AIERSB8_value = get_AIERSB8
        If flag_CFIE = &H0 Then write_CFIE_value = get_CFIE
        If flag_MR_PAGE_RX_INTERRUPT_ENABLE = &H0 Then write_MR_PAGE_RX_INTERRUPT_ENABLE_value = get_MR_PAGE_RX_INTERRUPT_ENABLE
        If flag_MACIE = &H0 Then write_MACIE_value = get_MACIE
        If flag_REMOTE_FAULT_INTERRUPT_ENABLE = &H0 Then write_REMOTE_FAULT_INTERRUPT_ENABLE_value = get_REMOTE_FAULT_INTERRUPT_ENABLE
        If flag_AIERSB3 = &H0 Then write_AIERSB3_value = get_AIERSB3
        If flag_AIERSB2 = &H0 Then write_AIERSB2_value = get_AIERSB2
        If flag_RLSUIE = &H0 Then write_RLSUIE_value = get_RLSUIE
        If flag_RLSDIE = &H0 Then write_RLSDIE_value = get_RLSDIE

        regValue = leftShift((write_AIERSB1512_value and &Hf), 12) + leftShift((write_AWDIE_value and &H1), 11) + leftShift((write_ALGCIE_value and &H1), 10) + leftShift((write_MARIE_value and &H1), 9) + leftShift((write_AIERSB8_value and &H1), 8) + leftShift((write_CFIE_value and &H1), 7) + leftShift((write_MR_PAGE_RX_INTERRUPT_ENABLE_value and &H1), 6) + leftShift((write_MACIE_value and &H1), 5) + leftShift((write_REMOTE_FAULT_INTERRUPT_ENABLE_value and &H1), 4) + leftShift((write_AIERSB3_value and &H1), 3) + leftShift((write_AIERSB2_value and &H1), 2) + leftShift((write_RLSUIE_value and &H1), 1) + leftShift((write_RLSDIE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AIERSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIE_value = rightShift(data_low, 11) and &H1
        read_ALGCIE_value = rightShift(data_low, 10) and &H1
        read_MARIE_value = rightShift(data_low, 9) and &H1
        read_AIERSB8_value = rightShift(data_low, 8) and &H1
        read_CFIE_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_ENABLE_value = rightShift(data_low, 6) and &H1
        read_MACIE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_ENABLE_value = rightShift(data_low, 4) and &H1
        read_AIERSB3_value = rightShift(data_low, 3) and &H1
        read_AIERSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIE_value = rightShift(data_low, 1) and &H1
        RLSDIE_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIE_mask = mask then
                read_RLSDIE_value = data_low
            else
                read_RLSDIE_value = (data_low - H8000_0000) and RLSDIE_mask
            end If
        else
            read_RLSDIE_value = data_low and RLSDIE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AIERSB1512_value = &H0
        flag_AIERSB1512        = &H0
        write_AWDIE_value = &H0
        flag_AWDIE        = &H0
        write_ALGCIE_value = &H0
        flag_ALGCIE        = &H0
        write_MARIE_value = &H0
        flag_MARIE        = &H0
        write_AIERSB8_value = &H0
        flag_AIERSB8        = &H0
        write_CFIE_value = &H0
        flag_CFIE        = &H0
        write_MR_PAGE_RX_INTERRUPT_ENABLE_value = &H0
        flag_MR_PAGE_RX_INTERRUPT_ENABLE        = &H0
        write_MACIE_value = &H0
        flag_MACIE        = &H0
        write_REMOTE_FAULT_INTERRUPT_ENABLE_value = &H0
        flag_REMOTE_FAULT_INTERRUPT_ENABLE        = &H0
        write_AIERSB3_value = &H0
        flag_AIERSB3        = &H0
        write_AIERSB2_value = &H0
        flag_AIERSB2        = &H0
        write_RLSUIE_value = &H0
        flag_RLSUIE        = &H0
        write_RLSDIE_value = &H0
        flag_RLSDIE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class AUTONEG_IEEE_INSTANCE

    Public teng_an_stat
    Public autoneg_baset1_an_control
    Public autoneg_baset1_an_status
    Public baset1_an_advertisement_reg0
    Public baset1_an_advertisement_reg1
    Public baset1_an_advertisement_reg2
    Public baset1_an_lp_base_page_ability_reg0
    Public baset1_an_lp_base_page_ability_reg1
    Public baset1_an_lp_base_page_ability_reg2
    Public baset1_an_next_page_transmit_reg0
    Public baset1_an_next_page_transmit_reg1
    Public baset1_an_next_page_transmit_reg2
    Public baset1_an_lp_next_page_ability_reg0
    Public baset1_an_lp_next_page_ability_reg1
    Public baset1_an_lp_next_page_ability_reg2
    Public autoneg_test_reg0
    Public autoneg_test_reg1
    Public autoneg_test_reg2
    Public autoneg_test_reg3
    Public autoneg_test_reg4
    Public autoneg_test_reg5
    Public autoneg_test_reg6
    Public autoneg_test_reg7
    Public autoneg_test_reg8
    Public autoneg_test_reg9
    Public autoneg_interrupt_status_reg
    Public autoneg_interrupt_enable_reg


    Public default function Init(aBaseAddr)
        Set teng_an_stat = (New REGISTER_AUTONEG_IEEE_teng_an_stat)(aBaseAddr, 16)
        Set autoneg_baset1_an_control = (New REGISTER_AUTONEG_IEEE_autoneg_baset1_an_control)(aBaseAddr, 16)
        Set autoneg_baset1_an_status = (New REGISTER_AUTONEG_IEEE_autoneg_baset1_an_status)(aBaseAddr, 16)
        Set baset1_an_advertisement_reg0 = (New REGISTER_AUTONEG_IEEE_baset1_an_advertisement_reg0)(aBaseAddr, 16)
        Set baset1_an_advertisement_reg1 = (New REGISTER_AUTONEG_IEEE_baset1_an_advertisement_reg1)(aBaseAddr, 16)
        Set baset1_an_advertisement_reg2 = (New REGISTER_AUTONEG_IEEE_baset1_an_advertisement_reg2)(aBaseAddr, 16)
        Set baset1_an_lp_base_page_ability_reg0 = (New REGISTER_AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg0)(aBaseAddr, 16)
        Set baset1_an_lp_base_page_ability_reg1 = (New REGISTER_AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg1)(aBaseAddr, 16)
        Set baset1_an_lp_base_page_ability_reg2 = (New REGISTER_AUTONEG_IEEE_baset1_an_lp_base_page_ability_reg2)(aBaseAddr, 16)
        Set baset1_an_next_page_transmit_reg0 = (New REGISTER_AUTONEG_IEEE_baset1_an_next_page_transmit_reg0)(aBaseAddr, 16)
        Set baset1_an_next_page_transmit_reg1 = (New REGISTER_AUTONEG_IEEE_baset1_an_next_page_transmit_reg1)(aBaseAddr, 16)
        Set baset1_an_next_page_transmit_reg2 = (New REGISTER_AUTONEG_IEEE_baset1_an_next_page_transmit_reg2)(aBaseAddr, 16)
        Set baset1_an_lp_next_page_ability_reg0 = (New REGISTER_AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg0)(aBaseAddr, 16)
        Set baset1_an_lp_next_page_ability_reg1 = (New REGISTER_AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg1)(aBaseAddr, 16)
        Set baset1_an_lp_next_page_ability_reg2 = (New REGISTER_AUTONEG_IEEE_baset1_an_lp_next_page_ability_reg2)(aBaseAddr, 16)
        Set autoneg_test_reg0 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg0)(aBaseAddr, 16)
        Set autoneg_test_reg1 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg1)(aBaseAddr, 16)
        Set autoneg_test_reg2 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg2)(aBaseAddr, 16)
        Set autoneg_test_reg3 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg3)(aBaseAddr, 16)
        Set autoneg_test_reg4 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg4)(aBaseAddr, 16)
        Set autoneg_test_reg5 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg5)(aBaseAddr, 16)
        Set autoneg_test_reg6 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg6)(aBaseAddr, 16)
        Set autoneg_test_reg7 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg7)(aBaseAddr, 16)
        Set autoneg_test_reg8 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg8)(aBaseAddr, 16)
        Set autoneg_test_reg9 = (New REGISTER_AUTONEG_IEEE_autoneg_test_reg9)(aBaseAddr, 16)
        Set autoneg_interrupt_status_reg = (New REGISTER_AUTONEG_IEEE_autoneg_interrupt_status_reg)(aBaseAddr, 16)
        Set autoneg_interrupt_enable_reg = (New REGISTER_AUTONEG_IEEE_autoneg_interrupt_enable_reg)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AUTONEG_IEEE = CreateObject("System.Collections.ArrayList")
AUTONEG_IEEE.Add ((New AUTONEG_IEEE_INSTANCE)(&H490e0000))


