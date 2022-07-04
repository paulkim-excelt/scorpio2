

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


'' @REGISTER : ACD_expc0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RUN_IMMEDIATE                              [15:15]          get_RUN_IMMEDIATE
''                                                             set_RUN_IMMEDIATE
''                                                             read_RUN_IMMEDIATE
''                                                             write_RUN_IMMEDIATE
''---------------------------------------------------------------------------------
'' RUN_AT_AUTONEG                             [14:14]          get_RUN_AT_AUTONEG
''                                                             set_RUN_AT_AUTONEG
''                                                             read_RUN_AT_AUTONEG
''                                                             write_RUN_AT_AUTONEG
''---------------------------------------------------------------------------------
'' INTER_PAIR_SHORT_DIS                       [13:13]          get_INTER_PAIR_SHORT_DIS
''                                                             set_INTER_PAIR_SHORT_DIS
''                                                             read_INTER_PAIR_SHORT_DIS
''                                                             write_INTER_PAIR_SHORT_DIS
''---------------------------------------------------------------------------------
'' BREAK_LINK                                 [12:12]          get_BREAK_LINK
''                                                             set_BREAK_LINK
''                                                             read_BREAK_LINK
''                                                             write_BREAK_LINK
''---------------------------------------------------------------------------------
'' CABLE_DIAG_STATUS                          [11:11]          get_CABLE_DIAG_STATUS
''                                                             set_CABLE_DIAG_STATUS
''                                                             read_CABLE_DIAG_STATUS
''                                                             write_CABLE_DIAG_STATUS
''---------------------------------------------------------------------------------
'' CABLE_LEN_UNIT                             [10:10]          get_CABLE_LEN_UNIT
''                                                             set_CABLE_LEN_UNIT
''                                                             read_CABLE_LEN_UNIT
''                                                             write_CABLE_LEN_UNIT
''---------------------------------------------------------------------------------
'' FAST_TIMER_ENABLE                          [8:8]            get_FAST_TIMER_ENABLE
''                                                             set_FAST_TIMER_ENABLE
''                                                             read_FAST_TIMER_ENABLE
''                                                             write_FAST_TIMER_ENABLE
''---------------------------------------------------------------------------------
'' INTRPT_ENABLE                              [7:7]            get_INTRPT_ENABLE
''                                                             set_INTRPT_ENABLE
''                                                             read_INTRPT_ENABLE
''                                                             write_INTRPT_ENABLE
''---------------------------------------------------------------------------------
'' STOP_PLL_CLK                               [6:6]            get_STOP_PLL_CLK
''                                                             set_STOP_PLL_CLK
''                                                             read_STOP_PLL_CLK
''                                                             write_STOP_PLL_CLK
''---------------------------------------------------------------------------------
'' TEST_ACD_DC_OFFSET                         [4:4]            get_TEST_ACD_DC_OFFSET
''                                                             set_TEST_ACD_DC_OFFSET
''                                                             read_TEST_ACD_DC_OFFSET
''                                                             write_TEST_ACD_DC_OFFSET
''---------------------------------------------------------------------------------
'' INVALID_RESULT                             [3:3]            get_INVALID_RESULT
''                                                             set_INVALID_RESULT
''                                                             read_INVALID_RESULT
''                                                             write_INVALID_RESULT
''---------------------------------------------------------------------------------
'' CABLE_DIAG_EXE                             [2:2]            get_CABLE_DIAG_EXE
''                                                             set_CABLE_DIAG_EXE
''                                                             read_CABLE_DIAG_EXE
''                                                             write_CABLE_DIAG_EXE
''---------------------------------------------------------------------------------
'' AUTO_RUN_FOR_BROKEN_ANG                    [1:1]            get_AUTO_RUN_FOR_BROKEN_ANG
''                                                             set_AUTO_RUN_FOR_BROKEN_ANG
''                                                             read_AUTO_RUN_FOR_BROKEN_ANG
''                                                             write_AUTO_RUN_FOR_BROKEN_ANG
''---------------------------------------------------------------------------------
'' CABLE_TYPE                                 [0:0]            get_CABLE_TYPE
''                                                             set_CABLE_TYPE
''                                                             read_CABLE_TYPE
''                                                             write_CABLE_TYPE
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc0
    Private write_RUN_IMMEDIATE_value
    Private read_RUN_IMMEDIATE_value
    Private flag_RUN_IMMEDIATE
    Private write_RUN_AT_AUTONEG_value
    Private read_RUN_AT_AUTONEG_value
    Private flag_RUN_AT_AUTONEG
    Private write_INTER_PAIR_SHORT_DIS_value
    Private read_INTER_PAIR_SHORT_DIS_value
    Private flag_INTER_PAIR_SHORT_DIS
    Private write_BREAK_LINK_value
    Private read_BREAK_LINK_value
    Private flag_BREAK_LINK
    Private write_CABLE_DIAG_STATUS_value
    Private read_CABLE_DIAG_STATUS_value
    Private flag_CABLE_DIAG_STATUS
    Private write_CABLE_LEN_UNIT_value
    Private read_CABLE_LEN_UNIT_value
    Private flag_CABLE_LEN_UNIT
    Private write_FAST_TIMER_ENABLE_value
    Private read_FAST_TIMER_ENABLE_value
    Private flag_FAST_TIMER_ENABLE
    Private write_INTRPT_ENABLE_value
    Private read_INTRPT_ENABLE_value
    Private flag_INTRPT_ENABLE
    Private write_STOP_PLL_CLK_value
    Private read_STOP_PLL_CLK_value
    Private flag_STOP_PLL_CLK
    Private write_TEST_ACD_DC_OFFSET_value
    Private read_TEST_ACD_DC_OFFSET_value
    Private flag_TEST_ACD_DC_OFFSET
    Private write_INVALID_RESULT_value
    Private read_INVALID_RESULT_value
    Private flag_INVALID_RESULT
    Private write_CABLE_DIAG_EXE_value
    Private read_CABLE_DIAG_EXE_value
    Private flag_CABLE_DIAG_EXE
    Private write_AUTO_RUN_FOR_BROKEN_ANG_value
    Private read_AUTO_RUN_FOR_BROKEN_ANG_value
    Private flag_AUTO_RUN_FOR_BROKEN_ANG
    Private write_CABLE_TYPE_value
    Private read_CABLE_TYPE_value
    Private flag_CABLE_TYPE

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

    Property Get get_RUN_IMMEDIATE
        get_RUN_IMMEDIATE = read_RUN_IMMEDIATE_value
    End Property

    Property Let set_RUN_IMMEDIATE(aData)
        write_RUN_IMMEDIATE_value = aData
        flag_RUN_IMMEDIATE        = &H1
    End Property

    Property Get read_RUN_IMMEDIATE
        read
        read_RUN_IMMEDIATE = read_RUN_IMMEDIATE_value
    End Property

    Property Let write_RUN_IMMEDIATE(aData)
        set_RUN_IMMEDIATE = aData
        write
    End Property

    Property Get get_RUN_AT_AUTONEG
        get_RUN_AT_AUTONEG = read_RUN_AT_AUTONEG_value
    End Property

    Property Let set_RUN_AT_AUTONEG(aData)
        write_RUN_AT_AUTONEG_value = aData
        flag_RUN_AT_AUTONEG        = &H1
    End Property

    Property Get read_RUN_AT_AUTONEG
        read
        read_RUN_AT_AUTONEG = read_RUN_AT_AUTONEG_value
    End Property

    Property Let write_RUN_AT_AUTONEG(aData)
        set_RUN_AT_AUTONEG = aData
        write
    End Property

    Property Get get_INTER_PAIR_SHORT_DIS
        get_INTER_PAIR_SHORT_DIS = read_INTER_PAIR_SHORT_DIS_value
    End Property

    Property Let set_INTER_PAIR_SHORT_DIS(aData)
        write_INTER_PAIR_SHORT_DIS_value = aData
        flag_INTER_PAIR_SHORT_DIS        = &H1
    End Property

    Property Get read_INTER_PAIR_SHORT_DIS
        read
        read_INTER_PAIR_SHORT_DIS = read_INTER_PAIR_SHORT_DIS_value
    End Property

    Property Let write_INTER_PAIR_SHORT_DIS(aData)
        set_INTER_PAIR_SHORT_DIS = aData
        write
    End Property

    Property Get get_BREAK_LINK
        get_BREAK_LINK = read_BREAK_LINK_value
    End Property

    Property Let set_BREAK_LINK(aData)
        write_BREAK_LINK_value = aData
        flag_BREAK_LINK        = &H1
    End Property

    Property Get read_BREAK_LINK
        read
        read_BREAK_LINK = read_BREAK_LINK_value
    End Property

    Property Let write_BREAK_LINK(aData)
        set_BREAK_LINK = aData
        write
    End Property

    Property Get get_CABLE_DIAG_STATUS
        get_CABLE_DIAG_STATUS = read_CABLE_DIAG_STATUS_value
    End Property

    Property Let set_CABLE_DIAG_STATUS(aData)
        write_CABLE_DIAG_STATUS_value = aData
        flag_CABLE_DIAG_STATUS        = &H1
    End Property

    Property Get read_CABLE_DIAG_STATUS
        read
        read_CABLE_DIAG_STATUS = read_CABLE_DIAG_STATUS_value
    End Property

    Property Let write_CABLE_DIAG_STATUS(aData)
        set_CABLE_DIAG_STATUS = aData
        write
    End Property

    Property Get get_CABLE_LEN_UNIT
        get_CABLE_LEN_UNIT = read_CABLE_LEN_UNIT_value
    End Property

    Property Let set_CABLE_LEN_UNIT(aData)
        write_CABLE_LEN_UNIT_value = aData
        flag_CABLE_LEN_UNIT        = &H1
    End Property

    Property Get read_CABLE_LEN_UNIT
        read
        read_CABLE_LEN_UNIT = read_CABLE_LEN_UNIT_value
    End Property

    Property Let write_CABLE_LEN_UNIT(aData)
        set_CABLE_LEN_UNIT = aData
        write
    End Property

    Property Get get_FAST_TIMER_ENABLE
        get_FAST_TIMER_ENABLE = read_FAST_TIMER_ENABLE_value
    End Property

    Property Let set_FAST_TIMER_ENABLE(aData)
        write_FAST_TIMER_ENABLE_value = aData
        flag_FAST_TIMER_ENABLE        = &H1
    End Property

    Property Get read_FAST_TIMER_ENABLE
        read
        read_FAST_TIMER_ENABLE = read_FAST_TIMER_ENABLE_value
    End Property

    Property Let write_FAST_TIMER_ENABLE(aData)
        set_FAST_TIMER_ENABLE = aData
        write
    End Property

    Property Get get_INTRPT_ENABLE
        get_INTRPT_ENABLE = read_INTRPT_ENABLE_value
    End Property

    Property Let set_INTRPT_ENABLE(aData)
        write_INTRPT_ENABLE_value = aData
        flag_INTRPT_ENABLE        = &H1
    End Property

    Property Get read_INTRPT_ENABLE
        read
        read_INTRPT_ENABLE = read_INTRPT_ENABLE_value
    End Property

    Property Let write_INTRPT_ENABLE(aData)
        set_INTRPT_ENABLE = aData
        write
    End Property

    Property Get get_STOP_PLL_CLK
        get_STOP_PLL_CLK = read_STOP_PLL_CLK_value
    End Property

    Property Let set_STOP_PLL_CLK(aData)
        write_STOP_PLL_CLK_value = aData
        flag_STOP_PLL_CLK        = &H1
    End Property

    Property Get read_STOP_PLL_CLK
        read
        read_STOP_PLL_CLK = read_STOP_PLL_CLK_value
    End Property

    Property Let write_STOP_PLL_CLK(aData)
        set_STOP_PLL_CLK = aData
        write
    End Property

    Property Get get_TEST_ACD_DC_OFFSET
        get_TEST_ACD_DC_OFFSET = read_TEST_ACD_DC_OFFSET_value
    End Property

    Property Let set_TEST_ACD_DC_OFFSET(aData)
        write_TEST_ACD_DC_OFFSET_value = aData
        flag_TEST_ACD_DC_OFFSET        = &H1
    End Property

    Property Get read_TEST_ACD_DC_OFFSET
        read
        read_TEST_ACD_DC_OFFSET = read_TEST_ACD_DC_OFFSET_value
    End Property

    Property Let write_TEST_ACD_DC_OFFSET(aData)
        set_TEST_ACD_DC_OFFSET = aData
        write
    End Property

    Property Get get_INVALID_RESULT
        get_INVALID_RESULT = read_INVALID_RESULT_value
    End Property

    Property Let set_INVALID_RESULT(aData)
        write_INVALID_RESULT_value = aData
        flag_INVALID_RESULT        = &H1
    End Property

    Property Get read_INVALID_RESULT
        read
        read_INVALID_RESULT = read_INVALID_RESULT_value
    End Property

    Property Let write_INVALID_RESULT(aData)
        set_INVALID_RESULT = aData
        write
    End Property

    Property Get get_CABLE_DIAG_EXE
        get_CABLE_DIAG_EXE = read_CABLE_DIAG_EXE_value
    End Property

    Property Let set_CABLE_DIAG_EXE(aData)
        write_CABLE_DIAG_EXE_value = aData
        flag_CABLE_DIAG_EXE        = &H1
    End Property

    Property Get read_CABLE_DIAG_EXE
        read
        read_CABLE_DIAG_EXE = read_CABLE_DIAG_EXE_value
    End Property

    Property Let write_CABLE_DIAG_EXE(aData)
        set_CABLE_DIAG_EXE = aData
        write
    End Property

    Property Get get_AUTO_RUN_FOR_BROKEN_ANG
        get_AUTO_RUN_FOR_BROKEN_ANG = read_AUTO_RUN_FOR_BROKEN_ANG_value
    End Property

    Property Let set_AUTO_RUN_FOR_BROKEN_ANG(aData)
        write_AUTO_RUN_FOR_BROKEN_ANG_value = aData
        flag_AUTO_RUN_FOR_BROKEN_ANG        = &H1
    End Property

    Property Get read_AUTO_RUN_FOR_BROKEN_ANG
        read
        read_AUTO_RUN_FOR_BROKEN_ANG = read_AUTO_RUN_FOR_BROKEN_ANG_value
    End Property

    Property Let write_AUTO_RUN_FOR_BROKEN_ANG(aData)
        set_AUTO_RUN_FOR_BROKEN_ANG = aData
        write
    End Property

    Property Get get_CABLE_TYPE
        get_CABLE_TYPE = read_CABLE_TYPE_value
    End Property

    Property Let set_CABLE_TYPE(aData)
        write_CABLE_TYPE_value = aData
        flag_CABLE_TYPE        = &H1
    End Property

    Property Get read_CABLE_TYPE
        read
        read_CABLE_TYPE = read_CABLE_TYPE_value
    End Property

    Property Let write_CABLE_TYPE(aData)
        set_CABLE_TYPE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RUN_IMMEDIATE_value = rightShift(data_low, 15) and &H1
        read_RUN_AT_AUTONEG_value = rightShift(data_low, 14) and &H1
        read_INTER_PAIR_SHORT_DIS_value = rightShift(data_low, 13) and &H1
        read_BREAK_LINK_value = rightShift(data_low, 12) and &H1
        read_CABLE_DIAG_STATUS_value = rightShift(data_low, 11) and &H1
        read_CABLE_LEN_UNIT_value = rightShift(data_low, 10) and &H1
        read_FAST_TIMER_ENABLE_value = rightShift(data_low, 8) and &H1
        read_INTRPT_ENABLE_value = rightShift(data_low, 7) and &H1
        read_STOP_PLL_CLK_value = rightShift(data_low, 6) and &H1
        read_TEST_ACD_DC_OFFSET_value = rightShift(data_low, 4) and &H1
        read_INVALID_RESULT_value = rightShift(data_low, 3) and &H1
        read_CABLE_DIAG_EXE_value = rightShift(data_low, 2) and &H1
        read_AUTO_RUN_FOR_BROKEN_ANG_value = rightShift(data_low, 1) and &H1
        CABLE_TYPE_mask = &H1
        if data_low > LONG_MAX then
            if CABLE_TYPE_mask = mask then
                read_CABLE_TYPE_value = data_low
            else
                read_CABLE_TYPE_value = (data_low - H8000_0000) and CABLE_TYPE_mask
            end If
        else
            read_CABLE_TYPE_value = data_low and CABLE_TYPE_mask
        end If

    End Sub

    Sub write
        If flag_RUN_IMMEDIATE = &H0 or flag_RUN_AT_AUTONEG = &H0 or flag_INTER_PAIR_SHORT_DIS = &H0 or flag_BREAK_LINK = &H0 or flag_CABLE_DIAG_STATUS = &H0 or flag_CABLE_LEN_UNIT = &H0 or flag_FAST_TIMER_ENABLE = &H0 or flag_INTRPT_ENABLE = &H0 or flag_STOP_PLL_CLK = &H0 or flag_TEST_ACD_DC_OFFSET = &H0 or flag_INVALID_RESULT = &H0 or flag_CABLE_DIAG_EXE = &H0 or flag_AUTO_RUN_FOR_BROKEN_ANG = &H0 or flag_CABLE_TYPE = &H0 Then read
        If flag_RUN_IMMEDIATE = &H0 Then write_RUN_IMMEDIATE_value = get_RUN_IMMEDIATE
        If flag_RUN_AT_AUTONEG = &H0 Then write_RUN_AT_AUTONEG_value = get_RUN_AT_AUTONEG
        If flag_INTER_PAIR_SHORT_DIS = &H0 Then write_INTER_PAIR_SHORT_DIS_value = get_INTER_PAIR_SHORT_DIS
        If flag_BREAK_LINK = &H0 Then write_BREAK_LINK_value = get_BREAK_LINK
        If flag_CABLE_DIAG_STATUS = &H0 Then write_CABLE_DIAG_STATUS_value = get_CABLE_DIAG_STATUS
        If flag_CABLE_LEN_UNIT = &H0 Then write_CABLE_LEN_UNIT_value = get_CABLE_LEN_UNIT
        If flag_FAST_TIMER_ENABLE = &H0 Then write_FAST_TIMER_ENABLE_value = get_FAST_TIMER_ENABLE
        If flag_INTRPT_ENABLE = &H0 Then write_INTRPT_ENABLE_value = get_INTRPT_ENABLE
        If flag_STOP_PLL_CLK = &H0 Then write_STOP_PLL_CLK_value = get_STOP_PLL_CLK
        If flag_TEST_ACD_DC_OFFSET = &H0 Then write_TEST_ACD_DC_OFFSET_value = get_TEST_ACD_DC_OFFSET
        If flag_INVALID_RESULT = &H0 Then write_INVALID_RESULT_value = get_INVALID_RESULT
        If flag_CABLE_DIAG_EXE = &H0 Then write_CABLE_DIAG_EXE_value = get_CABLE_DIAG_EXE
        If flag_AUTO_RUN_FOR_BROKEN_ANG = &H0 Then write_AUTO_RUN_FOR_BROKEN_ANG_value = get_AUTO_RUN_FOR_BROKEN_ANG
        If flag_CABLE_TYPE = &H0 Then write_CABLE_TYPE_value = get_CABLE_TYPE

        regValue = leftShift((write_RUN_IMMEDIATE_value and &H1), 15) + leftShift((write_RUN_AT_AUTONEG_value and &H1), 14) + leftShift((write_INTER_PAIR_SHORT_DIS_value and &H1), 13) + leftShift((write_BREAK_LINK_value and &H1), 12) + leftShift((write_CABLE_DIAG_STATUS_value and &H1), 11) + leftShift((write_CABLE_LEN_UNIT_value and &H1), 10) + leftShift((write_FAST_TIMER_ENABLE_value and &H1), 8) + leftShift((write_INTRPT_ENABLE_value and &H1), 7) + leftShift((write_STOP_PLL_CLK_value and &H1), 6) + leftShift((write_TEST_ACD_DC_OFFSET_value and &H1), 4) + leftShift((write_INVALID_RESULT_value and &H1), 3) + leftShift((write_CABLE_DIAG_EXE_value and &H1), 2) + leftShift((write_AUTO_RUN_FOR_BROKEN_ANG_value and &H1), 1) + leftShift((write_CABLE_TYPE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RUN_IMMEDIATE_value = rightShift(data_low, 15) and &H1
        read_RUN_AT_AUTONEG_value = rightShift(data_low, 14) and &H1
        read_INTER_PAIR_SHORT_DIS_value = rightShift(data_low, 13) and &H1
        read_BREAK_LINK_value = rightShift(data_low, 12) and &H1
        read_CABLE_DIAG_STATUS_value = rightShift(data_low, 11) and &H1
        read_CABLE_LEN_UNIT_value = rightShift(data_low, 10) and &H1
        read_FAST_TIMER_ENABLE_value = rightShift(data_low, 8) and &H1
        read_INTRPT_ENABLE_value = rightShift(data_low, 7) and &H1
        read_STOP_PLL_CLK_value = rightShift(data_low, 6) and &H1
        read_TEST_ACD_DC_OFFSET_value = rightShift(data_low, 4) and &H1
        read_INVALID_RESULT_value = rightShift(data_low, 3) and &H1
        read_CABLE_DIAG_EXE_value = rightShift(data_low, 2) and &H1
        read_AUTO_RUN_FOR_BROKEN_ANG_value = rightShift(data_low, 1) and &H1
        CABLE_TYPE_mask = &H1
        if data_low > LONG_MAX then
            if CABLE_TYPE_mask = mask then
                read_CABLE_TYPE_value = data_low
            else
                read_CABLE_TYPE_value = (data_low - H8000_0000) and CABLE_TYPE_mask
            end If
        else
            read_CABLE_TYPE_value = data_low and CABLE_TYPE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RUN_IMMEDIATE_value = &H0
        flag_RUN_IMMEDIATE        = &H0
        write_RUN_AT_AUTONEG_value = &H0
        flag_RUN_AT_AUTONEG        = &H0
        write_INTER_PAIR_SHORT_DIS_value = &H0
        flag_INTER_PAIR_SHORT_DIS        = &H0
        write_BREAK_LINK_value = &H0
        flag_BREAK_LINK        = &H0
        write_CABLE_DIAG_STATUS_value = &H0
        flag_CABLE_DIAG_STATUS        = &H0
        write_CABLE_LEN_UNIT_value = &H0
        flag_CABLE_LEN_UNIT        = &H0
        write_FAST_TIMER_ENABLE_value = &H0
        flag_FAST_TIMER_ENABLE        = &H0
        write_INTRPT_ENABLE_value = &H0
        flag_INTRPT_ENABLE        = &H0
        write_STOP_PLL_CLK_value = &H0
        flag_STOP_PLL_CLK        = &H0
        write_TEST_ACD_DC_OFFSET_value = &H0
        flag_TEST_ACD_DC_OFFSET        = &H0
        write_INVALID_RESULT_value = &H0
        flag_INVALID_RESULT        = &H0
        write_CABLE_DIAG_EXE_value = &H0
        flag_CABLE_DIAG_EXE        = &H0
        write_AUTO_RUN_FOR_BROKEN_ANG_value = &H0
        flag_AUTO_RUN_FOR_BROKEN_ANG        = &H0
        write_CABLE_TYPE_value = &H0
        flag_CABLE_TYPE        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PA_CD_CODE                                 [15:12]          get_PA_CD_CODE
''                                                             set_PA_CD_CODE
''                                                             read_PA_CD_CODE
''                                                             write_PA_CD_CODE
''---------------------------------------------------------------------------------
'' PB_CD_CODE                                 [11:8]           get_PB_CD_CODE
''                                                             set_PB_CD_CODE
''                                                             read_PB_CD_CODE
''                                                             write_PB_CD_CODE
''---------------------------------------------------------------------------------
'' PC_CD_CODE                                 [7:4]            get_PC_CD_CODE
''                                                             set_PC_CD_CODE
''                                                             read_PC_CD_CODE
''                                                             write_PC_CD_CODE
''---------------------------------------------------------------------------------
'' PD_CD_CODE                                 [3:0]            get_PD_CD_CODE
''                                                             set_PD_CD_CODE
''                                                             read_PD_CD_CODE
''                                                             write_PD_CD_CODE
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc1
    Private write_PA_CD_CODE_value
    Private read_PA_CD_CODE_value
    Private flag_PA_CD_CODE
    Private write_PB_CD_CODE_value
    Private read_PB_CD_CODE_value
    Private flag_PB_CD_CODE
    Private write_PC_CD_CODE_value
    Private read_PC_CD_CODE_value
    Private flag_PC_CD_CODE
    Private write_PD_CD_CODE_value
    Private read_PD_CD_CODE_value
    Private flag_PD_CD_CODE

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

    Property Get get_PA_CD_CODE
        get_PA_CD_CODE = read_PA_CD_CODE_value
    End Property

    Property Let set_PA_CD_CODE(aData)
        write_PA_CD_CODE_value = aData
        flag_PA_CD_CODE        = &H1
    End Property

    Property Get read_PA_CD_CODE
        read
        read_PA_CD_CODE = read_PA_CD_CODE_value
    End Property

    Property Let write_PA_CD_CODE(aData)
        set_PA_CD_CODE = aData
        write
    End Property

    Property Get get_PB_CD_CODE
        get_PB_CD_CODE = read_PB_CD_CODE_value
    End Property

    Property Let set_PB_CD_CODE(aData)
        write_PB_CD_CODE_value = aData
        flag_PB_CD_CODE        = &H1
    End Property

    Property Get read_PB_CD_CODE
        read
        read_PB_CD_CODE = read_PB_CD_CODE_value
    End Property

    Property Let write_PB_CD_CODE(aData)
        set_PB_CD_CODE = aData
        write
    End Property

    Property Get get_PC_CD_CODE
        get_PC_CD_CODE = read_PC_CD_CODE_value
    End Property

    Property Let set_PC_CD_CODE(aData)
        write_PC_CD_CODE_value = aData
        flag_PC_CD_CODE        = &H1
    End Property

    Property Get read_PC_CD_CODE
        read
        read_PC_CD_CODE = read_PC_CD_CODE_value
    End Property

    Property Let write_PC_CD_CODE(aData)
        set_PC_CD_CODE = aData
        write
    End Property

    Property Get get_PD_CD_CODE
        get_PD_CD_CODE = read_PD_CD_CODE_value
    End Property

    Property Let set_PD_CD_CODE(aData)
        write_PD_CD_CODE_value = aData
        flag_PD_CD_CODE        = &H1
    End Property

    Property Get read_PD_CD_CODE
        read
        read_PD_CD_CODE = read_PD_CD_CODE_value
    End Property

    Property Let write_PD_CD_CODE(aData)
        set_PD_CD_CODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PA_CD_CODE_value = rightShift(data_low, 12) and &Hf
        read_PB_CD_CODE_value = rightShift(data_low, 8) and &Hf
        read_PC_CD_CODE_value = rightShift(data_low, 4) and &Hf
        PD_CD_CODE_mask = &Hf
        if data_low > LONG_MAX then
            if PD_CD_CODE_mask = mask then
                read_PD_CD_CODE_value = data_low
            else
                read_PD_CD_CODE_value = (data_low - H8000_0000) and PD_CD_CODE_mask
            end If
        else
            read_PD_CD_CODE_value = data_low and PD_CD_CODE_mask
        end If

    End Sub

    Sub write
        If flag_PA_CD_CODE = &H0 or flag_PB_CD_CODE = &H0 or flag_PC_CD_CODE = &H0 or flag_PD_CD_CODE = &H0 Then read
        If flag_PA_CD_CODE = &H0 Then write_PA_CD_CODE_value = get_PA_CD_CODE
        If flag_PB_CD_CODE = &H0 Then write_PB_CD_CODE_value = get_PB_CD_CODE
        If flag_PC_CD_CODE = &H0 Then write_PC_CD_CODE_value = get_PC_CD_CODE
        If flag_PD_CD_CODE = &H0 Then write_PD_CD_CODE_value = get_PD_CD_CODE

        regValue = leftShift((write_PA_CD_CODE_value and &Hf), 12) + leftShift((write_PB_CD_CODE_value and &Hf), 8) + leftShift((write_PC_CD_CODE_value and &Hf), 4) + leftShift((write_PD_CD_CODE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PA_CD_CODE_value = rightShift(data_low, 12) and &Hf
        read_PB_CD_CODE_value = rightShift(data_low, 8) and &Hf
        read_PC_CD_CODE_value = rightShift(data_low, 4) and &Hf
        PD_CD_CODE_mask = &Hf
        if data_low > LONG_MAX then
            if PD_CD_CODE_mask = mask then
                read_PD_CD_CODE_value = data_low
            else
                read_PD_CD_CODE_value = (data_low - H8000_0000) and PD_CD_CODE_mask
            end If
        else
            read_PD_CD_CODE_value = data_low and PD_CD_CODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PA_CD_CODE_value = &H0
        flag_PA_CD_CODE        = &H0
        write_PB_CD_CODE_value = &H0
        flag_PB_CD_CODE        = &H0
        write_PC_CD_CODE_value = &H0
        flag_PC_CD_CODE        = &H0
        write_PD_CD_CODE_value = &H0
        flag_PD_CD_CODE        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LENGTH_INDICATION                          [15:0]           get_LENGTH_INDICATION
''                                                             set_LENGTH_INDICATION
''                                                             read_LENGTH_INDICATION
''                                                             write_LENGTH_INDICATION
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc2
    Private write_LENGTH_INDICATION_value
    Private read_LENGTH_INDICATION_value
    Private flag_LENGTH_INDICATION

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

    Property Get get_LENGTH_INDICATION
        get_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let set_LENGTH_INDICATION(aData)
        write_LENGTH_INDICATION_value = aData
        flag_LENGTH_INDICATION        = &H1
    End Property

    Property Get read_LENGTH_INDICATION
        read
        read_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let write_LENGTH_INDICATION(aData)
        set_LENGTH_INDICATION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

    End Sub

    Sub write
        If flag_LENGTH_INDICATION = &H0 Then read
        If flag_LENGTH_INDICATION = &H0 Then write_LENGTH_INDICATION_value = get_LENGTH_INDICATION

        regValue = leftShift((write_LENGTH_INDICATION_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LENGTH_INDICATION_value = &H0
        flag_LENGTH_INDICATION        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LENGTH_INDICATION                          [15:0]           get_LENGTH_INDICATION
''                                                             set_LENGTH_INDICATION
''                                                             read_LENGTH_INDICATION
''                                                             write_LENGTH_INDICATION
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc3
    Private write_LENGTH_INDICATION_value
    Private read_LENGTH_INDICATION_value
    Private flag_LENGTH_INDICATION

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

    Property Get get_LENGTH_INDICATION
        get_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let set_LENGTH_INDICATION(aData)
        write_LENGTH_INDICATION_value = aData
        flag_LENGTH_INDICATION        = &H1
    End Property

    Property Get read_LENGTH_INDICATION
        read
        read_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let write_LENGTH_INDICATION(aData)
        set_LENGTH_INDICATION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

    End Sub

    Sub write
        If flag_LENGTH_INDICATION = &H0 Then read
        If flag_LENGTH_INDICATION = &H0 Then write_LENGTH_INDICATION_value = get_LENGTH_INDICATION

        regValue = leftShift((write_LENGTH_INDICATION_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LENGTH_INDICATION_value = &H0
        flag_LENGTH_INDICATION        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LENGTH_INDICATION                          [15:0]           get_LENGTH_INDICATION
''                                                             set_LENGTH_INDICATION
''                                                             read_LENGTH_INDICATION
''                                                             write_LENGTH_INDICATION
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc4
    Private write_LENGTH_INDICATION_value
    Private read_LENGTH_INDICATION_value
    Private flag_LENGTH_INDICATION

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

    Property Get get_LENGTH_INDICATION
        get_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let set_LENGTH_INDICATION(aData)
        write_LENGTH_INDICATION_value = aData
        flag_LENGTH_INDICATION        = &H1
    End Property

    Property Get read_LENGTH_INDICATION
        read
        read_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let write_LENGTH_INDICATION(aData)
        set_LENGTH_INDICATION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

    End Sub

    Sub write
        If flag_LENGTH_INDICATION = &H0 Then read
        If flag_LENGTH_INDICATION = &H0 Then write_LENGTH_INDICATION_value = get_LENGTH_INDICATION

        regValue = leftShift((write_LENGTH_INDICATION_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LENGTH_INDICATION_value = &H0
        flag_LENGTH_INDICATION        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LENGTH_INDICATION                          [15:0]           get_LENGTH_INDICATION
''                                                             set_LENGTH_INDICATION
''                                                             read_LENGTH_INDICATION
''                                                             write_LENGTH_INDICATION
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc5
    Private write_LENGTH_INDICATION_value
    Private read_LENGTH_INDICATION_value
    Private flag_LENGTH_INDICATION

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

    Property Get get_LENGTH_INDICATION
        get_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let set_LENGTH_INDICATION(aData)
        write_LENGTH_INDICATION_value = aData
        flag_LENGTH_INDICATION        = &H1
    End Property

    Property Get read_LENGTH_INDICATION
        read
        read_LENGTH_INDICATION = read_LENGTH_INDICATION_value
    End Property

    Property Let write_LENGTH_INDICATION(aData)
        set_LENGTH_INDICATION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

    End Sub

    Sub write
        If flag_LENGTH_INDICATION = &H0 Then read
        If flag_LENGTH_INDICATION = &H0 Then write_LENGTH_INDICATION_value = get_LENGTH_INDICATION

        regValue = leftShift((write_LENGTH_INDICATION_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LENGTH_INDICATION_mask = &Hffff
        if data_low > LONG_MAX then
            if LENGTH_INDICATION_mask = mask then
                read_LENGTH_INDICATION_value = data_low
            else
                read_LENGTH_INDICATION_value = (data_low - H8000_0000) and LENGTH_INDICATION_mask
            end If
        else
            read_LENGTH_INDICATION_value = data_low and LENGTH_INDICATION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LENGTH_INDICATION_value = &H0
        flag_LENGTH_INDICATION        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' F_COUNT_0                                  [15:0]           get_F_COUNT_0
''                                                             set_F_COUNT_0
''                                                             read_F_COUNT_0
''                                                             write_F_COUNT_0
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc6
    Private write_F_COUNT_0_value
    Private read_F_COUNT_0_value
    Private flag_F_COUNT_0

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

    Property Get get_F_COUNT_0
        get_F_COUNT_0 = read_F_COUNT_0_value
    End Property

    Property Let set_F_COUNT_0(aData)
        write_F_COUNT_0_value = aData
        flag_F_COUNT_0        = &H1
    End Property

    Property Get read_F_COUNT_0
        read
        read_F_COUNT_0 = read_F_COUNT_0_value
    End Property

    Property Let write_F_COUNT_0(aData)
        set_F_COUNT_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        F_COUNT_0_mask = &Hffff
        if data_low > LONG_MAX then
            if F_COUNT_0_mask = mask then
                read_F_COUNT_0_value = data_low
            else
                read_F_COUNT_0_value = (data_low - H8000_0000) and F_COUNT_0_mask
            end If
        else
            read_F_COUNT_0_value = data_low and F_COUNT_0_mask
        end If

    End Sub

    Sub write
        If flag_F_COUNT_0 = &H0 Then read
        If flag_F_COUNT_0 = &H0 Then write_F_COUNT_0_value = get_F_COUNT_0

        regValue = leftShift((write_F_COUNT_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        F_COUNT_0_mask = &Hffff
        if data_low > LONG_MAX then
            if F_COUNT_0_mask = mask then
                read_F_COUNT_0_value = data_low
            else
                read_F_COUNT_0_value = (data_low - H8000_0000) and F_COUNT_0_mask
            end If
        else
            read_F_COUNT_0_value = data_low and F_COUNT_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_F_COUNT_0_value = &H0
        flag_F_COUNT_0        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc7
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc8
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expc9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expc9
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expca
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expca
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expcb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expcb
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expcc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expcc
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expcd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expcd
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expce
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expce
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expcf
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expcf
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

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

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe0
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe1
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe2
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe3
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe4
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe5
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe6
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe7
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe8
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expe9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expe9
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expea
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expea
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expeb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expeb
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expec
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expec
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_exped
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_exped
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expee
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expee
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class


'' @REGISTER : ACD_expef
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNDEFINED                                  [15:0]           get_UNDEFINED
''                                                             set_UNDEFINED
''                                                             read_UNDEFINED
''                                                             write_UNDEFINED
''---------------------------------------------------------------------------------
Class REGISTER_ACD_expef
    Private write_UNDEFINED_value
    Private read_UNDEFINED_value
    Private flag_UNDEFINED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNDEFINED
        get_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let set_UNDEFINED(aData)
        write_UNDEFINED_value = aData
        flag_UNDEFINED        = &H1
    End Property

    Property Get read_UNDEFINED
        read
        read_UNDEFINED = read_UNDEFINED_value
    End Property

    Property Let write_UNDEFINED(aData)
        set_UNDEFINED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

    End Sub

    Sub write
        If flag_UNDEFINED = &H0 Then read
        If flag_UNDEFINED = &H0 Then write_UNDEFINED_value = get_UNDEFINED

        regValue = leftShift((write_UNDEFINED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNDEFINED_mask = &Hffff
        if data_low > LONG_MAX then
            if UNDEFINED_mask = mask then
                read_UNDEFINED_value = data_low
            else
                read_UNDEFINED_value = (data_low - H8000_0000) and UNDEFINED_mask
            end If
        else
            read_UNDEFINED_value = data_low and UNDEFINED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNDEFINED_value = &H0
        flag_UNDEFINED        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class ACD_INSTANCE

    Public expc0
    Public expc1
    Public expc2
    Public expc3
    Public expc4
    Public expc5
    Public expc6
    Public expc7
    Public expc8
    Public expc9
    Public expca
    Public expcb
    Public expcc
    Public expcd
    Public expce
    Public expcf
    Public expe0
    Public expe1
    Public expe2
    Public expe3
    Public expe4
    Public expe5
    Public expe6
    Public expe7
    Public expe8
    Public expe9
    Public expea
    Public expeb
    Public expec
    Public exped
    Public expee
    Public expef


    Public default function Init(aBaseAddr)
        Set expc0 = (New REGISTER_ACD_expc0)(aBaseAddr, 16)
        Set expc1 = (New REGISTER_ACD_expc1)(aBaseAddr, 16)
        Set expc2 = (New REGISTER_ACD_expc2)(aBaseAddr, 16)
        Set expc3 = (New REGISTER_ACD_expc3)(aBaseAddr, 16)
        Set expc4 = (New REGISTER_ACD_expc4)(aBaseAddr, 16)
        Set expc5 = (New REGISTER_ACD_expc5)(aBaseAddr, 16)
        Set expc6 = (New REGISTER_ACD_expc6)(aBaseAddr, 16)
        Set expc7 = (New REGISTER_ACD_expc7)(aBaseAddr, 16)
        Set expc8 = (New REGISTER_ACD_expc8)(aBaseAddr, 16)
        Set expc9 = (New REGISTER_ACD_expc9)(aBaseAddr, 16)
        Set expca = (New REGISTER_ACD_expca)(aBaseAddr, 16)
        Set expcb = (New REGISTER_ACD_expcb)(aBaseAddr, 16)
        Set expcc = (New REGISTER_ACD_expcc)(aBaseAddr, 16)
        Set expcd = (New REGISTER_ACD_expcd)(aBaseAddr, 16)
        Set expce = (New REGISTER_ACD_expce)(aBaseAddr, 16)
        Set expcf = (New REGISTER_ACD_expcf)(aBaseAddr, 16)
        Set expe0 = (New REGISTER_ACD_expe0)(aBaseAddr, 16)
        Set expe1 = (New REGISTER_ACD_expe1)(aBaseAddr, 16)
        Set expe2 = (New REGISTER_ACD_expe2)(aBaseAddr, 16)
        Set expe3 = (New REGISTER_ACD_expe3)(aBaseAddr, 16)
        Set expe4 = (New REGISTER_ACD_expe4)(aBaseAddr, 16)
        Set expe5 = (New REGISTER_ACD_expe5)(aBaseAddr, 16)
        Set expe6 = (New REGISTER_ACD_expe6)(aBaseAddr, 16)
        Set expe7 = (New REGISTER_ACD_expe7)(aBaseAddr, 16)
        Set expe8 = (New REGISTER_ACD_expe8)(aBaseAddr, 16)
        Set expe9 = (New REGISTER_ACD_expe9)(aBaseAddr, 16)
        Set expea = (New REGISTER_ACD_expea)(aBaseAddr, 16)
        Set expeb = (New REGISTER_ACD_expeb)(aBaseAddr, 16)
        Set expec = (New REGISTER_ACD_expec)(aBaseAddr, 16)
        Set exped = (New REGISTER_ACD_exped)(aBaseAddr, 16)
        Set expee = (New REGISTER_ACD_expee)(aBaseAddr, 16)
        Set expef = (New REGISTER_ACD_expef)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set ACD = CreateObject("System.Collections.ArrayList")
ACD.Add ((New ACD_INSTANCE)(&H49034540))
ACD.Add ((New ACD_INSTANCE)(&H4a4f2540))
ACD.Add ((New ACD_INSTANCE)(&H494f2540))
ACD.Add ((New ACD_INSTANCE)(&H498f2540))
ACD.Add ((New ACD_INSTANCE)(&H49cf2540))
ACD.Add ((New ACD_INSTANCE)(&H4a0f2540))


