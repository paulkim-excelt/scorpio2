

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


'' @REGISTER : T1_CORE_pattern_gen_control_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_ERR                                     [15:15]          get_TX_ERR
''                                                             set_TX_ERR
''                                                             read_TX_ERR
''                                                             write_TX_ERR
''---------------------------------------------------------------------------------
'' SKIP_CRC                                   [14:14]          get_SKIP_CRC
''                                                             set_SKIP_CRC
''                                                             read_SKIP_CRC
''                                                             write_SKIP_CRC
''---------------------------------------------------------------------------------
'' IPG_SEL                                    [13:11]          get_IPG_SEL
''                                                             set_IPG_SEL
''                                                             read_IPG_SEL
''                                                             write_IPG_SEL
''---------------------------------------------------------------------------------
'' STOP_MODE                                  [3:3]            get_STOP_MODE
''                                                             set_STOP_MODE
''                                                             read_STOP_MODE
''                                                             write_STOP_MODE
''---------------------------------------------------------------------------------
'' RUN_PAT_GEN                                [2:2]            get_RUN_PAT_GEN
''                                                             set_RUN_PAT_GEN
''                                                             read_RUN_PAT_GEN
''                                                             write_RUN_PAT_GEN
''---------------------------------------------------------------------------------
'' SELECT_PATGEN_DATA                         [1:0]            get_SELECT_PATGEN_DATA
''                                                             set_SELECT_PATGEN_DATA
''                                                             read_SELECT_PATGEN_DATA
''                                                             write_SELECT_PATGEN_DATA
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pattern_gen_control_a
    Private write_TX_ERR_value
    Private read_TX_ERR_value
    Private flag_TX_ERR
    Private write_SKIP_CRC_value
    Private read_SKIP_CRC_value
    Private flag_SKIP_CRC
    Private write_IPG_SEL_value
    Private read_IPG_SEL_value
    Private flag_IPG_SEL
    Private write_STOP_MODE_value
    Private read_STOP_MODE_value
    Private flag_STOP_MODE
    Private write_RUN_PAT_GEN_value
    Private read_RUN_PAT_GEN_value
    Private flag_RUN_PAT_GEN
    Private write_SELECT_PATGEN_DATA_value
    Private read_SELECT_PATGEN_DATA_value
    Private flag_SELECT_PATGEN_DATA

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

    Property Get get_TX_ERR
        get_TX_ERR = read_TX_ERR_value
    End Property

    Property Let set_TX_ERR(aData)
        write_TX_ERR_value = aData
        flag_TX_ERR        = &H1
    End Property

    Property Get read_TX_ERR
        read
        read_TX_ERR = read_TX_ERR_value
    End Property

    Property Let write_TX_ERR(aData)
        set_TX_ERR = aData
        write
    End Property

    Property Get get_SKIP_CRC
        get_SKIP_CRC = read_SKIP_CRC_value
    End Property

    Property Let set_SKIP_CRC(aData)
        write_SKIP_CRC_value = aData
        flag_SKIP_CRC        = &H1
    End Property

    Property Get read_SKIP_CRC
        read
        read_SKIP_CRC = read_SKIP_CRC_value
    End Property

    Property Let write_SKIP_CRC(aData)
        set_SKIP_CRC = aData
        write
    End Property

    Property Get get_IPG_SEL
        get_IPG_SEL = read_IPG_SEL_value
    End Property

    Property Let set_IPG_SEL(aData)
        write_IPG_SEL_value = aData
        flag_IPG_SEL        = &H1
    End Property

    Property Get read_IPG_SEL
        read
        read_IPG_SEL = read_IPG_SEL_value
    End Property

    Property Let write_IPG_SEL(aData)
        set_IPG_SEL = aData
        write
    End Property

    Property Get get_STOP_MODE
        get_STOP_MODE = read_STOP_MODE_value
    End Property

    Property Let set_STOP_MODE(aData)
        write_STOP_MODE_value = aData
        flag_STOP_MODE        = &H1
    End Property

    Property Get read_STOP_MODE
        read
        read_STOP_MODE = read_STOP_MODE_value
    End Property

    Property Let write_STOP_MODE(aData)
        set_STOP_MODE = aData
        write
    End Property

    Property Get get_RUN_PAT_GEN
        get_RUN_PAT_GEN = read_RUN_PAT_GEN_value
    End Property

    Property Let set_RUN_PAT_GEN(aData)
        write_RUN_PAT_GEN_value = aData
        flag_RUN_PAT_GEN        = &H1
    End Property

    Property Get read_RUN_PAT_GEN
        read
        read_RUN_PAT_GEN = read_RUN_PAT_GEN_value
    End Property

    Property Let write_RUN_PAT_GEN(aData)
        set_RUN_PAT_GEN = aData
        write
    End Property

    Property Get get_SELECT_PATGEN_DATA
        get_SELECT_PATGEN_DATA = read_SELECT_PATGEN_DATA_value
    End Property

    Property Let set_SELECT_PATGEN_DATA(aData)
        write_SELECT_PATGEN_DATA_value = aData
        flag_SELECT_PATGEN_DATA        = &H1
    End Property

    Property Get read_SELECT_PATGEN_DATA
        read
        read_SELECT_PATGEN_DATA = read_SELECT_PATGEN_DATA_value
    End Property

    Property Let write_SELECT_PATGEN_DATA(aData)
        set_SELECT_PATGEN_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_ERR_value = rightShift(data_low, 15) and &H1
        read_SKIP_CRC_value = rightShift(data_low, 14) and &H1
        read_IPG_SEL_value = rightShift(data_low, 11) and &H7
        read_STOP_MODE_value = rightShift(data_low, 3) and &H1
        read_RUN_PAT_GEN_value = rightShift(data_low, 2) and &H1
        SELECT_PATGEN_DATA_mask = &H3
        if data_low > LONG_MAX then
            if SELECT_PATGEN_DATA_mask = mask then
                read_SELECT_PATGEN_DATA_value = data_low
            else
                read_SELECT_PATGEN_DATA_value = (data_low - H8000_0000) and SELECT_PATGEN_DATA_mask
            end If
        else
            read_SELECT_PATGEN_DATA_value = data_low and SELECT_PATGEN_DATA_mask
        end If

    End Sub

    Sub write
        If flag_TX_ERR = &H0 or flag_SKIP_CRC = &H0 or flag_IPG_SEL = &H0 or flag_STOP_MODE = &H0 or flag_RUN_PAT_GEN = &H0 or flag_SELECT_PATGEN_DATA = &H0 Then read
        If flag_TX_ERR = &H0 Then write_TX_ERR_value = get_TX_ERR
        If flag_SKIP_CRC = &H0 Then write_SKIP_CRC_value = get_SKIP_CRC
        If flag_IPG_SEL = &H0 Then write_IPG_SEL_value = get_IPG_SEL
        If flag_STOP_MODE = &H0 Then write_STOP_MODE_value = get_STOP_MODE
        If flag_RUN_PAT_GEN = &H0 Then write_RUN_PAT_GEN_value = get_RUN_PAT_GEN
        If flag_SELECT_PATGEN_DATA = &H0 Then write_SELECT_PATGEN_DATA_value = get_SELECT_PATGEN_DATA

        regValue = leftShift((write_TX_ERR_value and &H1), 15) + leftShift((write_SKIP_CRC_value and &H1), 14) + leftShift((write_IPG_SEL_value and &H7), 11) + leftShift((write_STOP_MODE_value and &H1), 3) + leftShift((write_RUN_PAT_GEN_value and &H1), 2) + leftShift((write_SELECT_PATGEN_DATA_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_ERR_value = rightShift(data_low, 15) and &H1
        read_SKIP_CRC_value = rightShift(data_low, 14) and &H1
        read_IPG_SEL_value = rightShift(data_low, 11) and &H7
        read_STOP_MODE_value = rightShift(data_low, 3) and &H1
        read_RUN_PAT_GEN_value = rightShift(data_low, 2) and &H1
        SELECT_PATGEN_DATA_mask = &H3
        if data_low > LONG_MAX then
            if SELECT_PATGEN_DATA_mask = mask then
                read_SELECT_PATGEN_DATA_value = data_low
            else
                read_SELECT_PATGEN_DATA_value = (data_low - H8000_0000) and SELECT_PATGEN_DATA_mask
            end If
        else
            read_SELECT_PATGEN_DATA_value = data_low and SELECT_PATGEN_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_ERR_value = &H0
        flag_TX_ERR        = &H0
        write_SKIP_CRC_value = &H0
        flag_SKIP_CRC        = &H0
        write_IPG_SEL_value = &H0
        flag_IPG_SEL        = &H0
        write_STOP_MODE_value = &H0
        flag_STOP_MODE        = &H0
        write_RUN_PAT_GEN_value = &H0
        flag_RUN_PAT_GEN        = &H0
        write_SELECT_PATGEN_DATA_value = &H0
        flag_SELECT_PATGEN_DATA        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_pattern_gen_control_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SELECT_CRC_CHECKER                         [9:8]            get_SELECT_CRC_CHECKER
''                                                             set_SELECT_CRC_CHECKER
''                                                             read_SELECT_CRC_CHECKER
''                                                             write_SELECT_CRC_CHECKER
''---------------------------------------------------------------------------------
'' GENERATE_RANDOM_PKT_SIZE                   [2:2]            get_GENERATE_RANDOM_PKT_SIZE
''                                                             set_GENERATE_RANDOM_PKT_SIZE
''                                                             read_GENERATE_RANDOM_PKT_SIZE
''                                                             write_GENERATE_RANDOM_PKT_SIZE
''---------------------------------------------------------------------------------
'' CARRIER_EXTENSION                          [1:1]            get_CARRIER_EXTENSION
''                                                             set_CARRIER_EXTENSION
''                                                             read_CARRIER_EXTENSION
''                                                             write_CARRIER_EXTENSION
''---------------------------------------------------------------------------------
'' GENERATE_RANDOM_DATA                       [0:0]            get_GENERATE_RANDOM_DATA
''                                                             set_GENERATE_RANDOM_DATA
''                                                             read_GENERATE_RANDOM_DATA
''                                                             write_GENERATE_RANDOM_DATA
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pattern_gen_control_b
    Private write_SELECT_CRC_CHECKER_value
    Private read_SELECT_CRC_CHECKER_value
    Private flag_SELECT_CRC_CHECKER
    Private write_GENERATE_RANDOM_PKT_SIZE_value
    Private read_GENERATE_RANDOM_PKT_SIZE_value
    Private flag_GENERATE_RANDOM_PKT_SIZE
    Private write_CARRIER_EXTENSION_value
    Private read_CARRIER_EXTENSION_value
    Private flag_CARRIER_EXTENSION
    Private write_GENERATE_RANDOM_DATA_value
    Private read_GENERATE_RANDOM_DATA_value
    Private flag_GENERATE_RANDOM_DATA

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

    Property Get get_SELECT_CRC_CHECKER
        get_SELECT_CRC_CHECKER = read_SELECT_CRC_CHECKER_value
    End Property

    Property Let set_SELECT_CRC_CHECKER(aData)
        write_SELECT_CRC_CHECKER_value = aData
        flag_SELECT_CRC_CHECKER        = &H1
    End Property

    Property Get read_SELECT_CRC_CHECKER
        read
        read_SELECT_CRC_CHECKER = read_SELECT_CRC_CHECKER_value
    End Property

    Property Let write_SELECT_CRC_CHECKER(aData)
        set_SELECT_CRC_CHECKER = aData
        write
    End Property

    Property Get get_GENERATE_RANDOM_PKT_SIZE
        get_GENERATE_RANDOM_PKT_SIZE = read_GENERATE_RANDOM_PKT_SIZE_value
    End Property

    Property Let set_GENERATE_RANDOM_PKT_SIZE(aData)
        write_GENERATE_RANDOM_PKT_SIZE_value = aData
        flag_GENERATE_RANDOM_PKT_SIZE        = &H1
    End Property

    Property Get read_GENERATE_RANDOM_PKT_SIZE
        read
        read_GENERATE_RANDOM_PKT_SIZE = read_GENERATE_RANDOM_PKT_SIZE_value
    End Property

    Property Let write_GENERATE_RANDOM_PKT_SIZE(aData)
        set_GENERATE_RANDOM_PKT_SIZE = aData
        write
    End Property

    Property Get get_CARRIER_EXTENSION
        get_CARRIER_EXTENSION = read_CARRIER_EXTENSION_value
    End Property

    Property Let set_CARRIER_EXTENSION(aData)
        write_CARRIER_EXTENSION_value = aData
        flag_CARRIER_EXTENSION        = &H1
    End Property

    Property Get read_CARRIER_EXTENSION
        read
        read_CARRIER_EXTENSION = read_CARRIER_EXTENSION_value
    End Property

    Property Let write_CARRIER_EXTENSION(aData)
        set_CARRIER_EXTENSION = aData
        write
    End Property

    Property Get get_GENERATE_RANDOM_DATA
        get_GENERATE_RANDOM_DATA = read_GENERATE_RANDOM_DATA_value
    End Property

    Property Let set_GENERATE_RANDOM_DATA(aData)
        write_GENERATE_RANDOM_DATA_value = aData
        flag_GENERATE_RANDOM_DATA        = &H1
    End Property

    Property Get read_GENERATE_RANDOM_DATA
        read
        read_GENERATE_RANDOM_DATA = read_GENERATE_RANDOM_DATA_value
    End Property

    Property Let write_GENERATE_RANDOM_DATA(aData)
        set_GENERATE_RANDOM_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SELECT_CRC_CHECKER_value = rightShift(data_low, 8) and &H3
        read_GENERATE_RANDOM_PKT_SIZE_value = rightShift(data_low, 2) and &H1
        read_CARRIER_EXTENSION_value = rightShift(data_low, 1) and &H1
        GENERATE_RANDOM_DATA_mask = &H1
        if data_low > LONG_MAX then
            if GENERATE_RANDOM_DATA_mask = mask then
                read_GENERATE_RANDOM_DATA_value = data_low
            else
                read_GENERATE_RANDOM_DATA_value = (data_low - H8000_0000) and GENERATE_RANDOM_DATA_mask
            end If
        else
            read_GENERATE_RANDOM_DATA_value = data_low and GENERATE_RANDOM_DATA_mask
        end If

    End Sub

    Sub write
        If flag_SELECT_CRC_CHECKER = &H0 or flag_GENERATE_RANDOM_PKT_SIZE = &H0 or flag_CARRIER_EXTENSION = &H0 or flag_GENERATE_RANDOM_DATA = &H0 Then read
        If flag_SELECT_CRC_CHECKER = &H0 Then write_SELECT_CRC_CHECKER_value = get_SELECT_CRC_CHECKER
        If flag_GENERATE_RANDOM_PKT_SIZE = &H0 Then write_GENERATE_RANDOM_PKT_SIZE_value = get_GENERATE_RANDOM_PKT_SIZE
        If flag_CARRIER_EXTENSION = &H0 Then write_CARRIER_EXTENSION_value = get_CARRIER_EXTENSION
        If flag_GENERATE_RANDOM_DATA = &H0 Then write_GENERATE_RANDOM_DATA_value = get_GENERATE_RANDOM_DATA

        regValue = leftShift((write_SELECT_CRC_CHECKER_value and &H3), 8) + leftShift((write_GENERATE_RANDOM_PKT_SIZE_value and &H1), 2) + leftShift((write_CARRIER_EXTENSION_value and &H1), 1) + leftShift((write_GENERATE_RANDOM_DATA_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SELECT_CRC_CHECKER_value = rightShift(data_low, 8) and &H3
        read_GENERATE_RANDOM_PKT_SIZE_value = rightShift(data_low, 2) and &H1
        read_CARRIER_EXTENSION_value = rightShift(data_low, 1) and &H1
        GENERATE_RANDOM_DATA_mask = &H1
        if data_low > LONG_MAX then
            if GENERATE_RANDOM_DATA_mask = mask then
                read_GENERATE_RANDOM_DATA_value = data_low
            else
                read_GENERATE_RANDOM_DATA_value = (data_low - H8000_0000) and GENERATE_RANDOM_DATA_mask
            end If
        else
            read_GENERATE_RANDOM_DATA_value = data_low and GENERATE_RANDOM_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SELECT_CRC_CHECKER_value = &H0
        flag_SELECT_CRC_CHECKER        = &H0
        write_GENERATE_RANDOM_PKT_SIZE_value = &H0
        flag_GENERATE_RANDOM_PKT_SIZE        = &H0
        write_CARRIER_EXTENSION_value = &H0
        flag_CARRIER_EXTENSION        = &H0
        write_GENERATE_RANDOM_DATA_value = &H0
        flag_GENERATE_RANDOM_DATA        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_pattern_gen_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PAT_GEN_ACTIVE                             [3:3]            get_PAT_GEN_ACTIVE
''                                                             set_PAT_GEN_ACTIVE
''                                                             read_PAT_GEN_ACTIVE
''                                                             write_PAT_GEN_ACTIVE
''---------------------------------------------------------------------------------
'' PAT_GEN_FSM                                [2:0]            get_PAT_GEN_FSM
''                                                             set_PAT_GEN_FSM
''                                                             read_PAT_GEN_FSM
''                                                             write_PAT_GEN_FSM
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pattern_gen_status
    Private write_PAT_GEN_ACTIVE_value
    Private read_PAT_GEN_ACTIVE_value
    Private flag_PAT_GEN_ACTIVE
    Private write_PAT_GEN_FSM_value
    Private read_PAT_GEN_FSM_value
    Private flag_PAT_GEN_FSM

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

    Property Get get_PAT_GEN_ACTIVE
        get_PAT_GEN_ACTIVE = read_PAT_GEN_ACTIVE_value
    End Property

    Property Let set_PAT_GEN_ACTIVE(aData)
        write_PAT_GEN_ACTIVE_value = aData
        flag_PAT_GEN_ACTIVE        = &H1
    End Property

    Property Get read_PAT_GEN_ACTIVE
        read
        read_PAT_GEN_ACTIVE = read_PAT_GEN_ACTIVE_value
    End Property

    Property Let write_PAT_GEN_ACTIVE(aData)
        set_PAT_GEN_ACTIVE = aData
        write
    End Property

    Property Get get_PAT_GEN_FSM
        get_PAT_GEN_FSM = read_PAT_GEN_FSM_value
    End Property

    Property Let set_PAT_GEN_FSM(aData)
        write_PAT_GEN_FSM_value = aData
        flag_PAT_GEN_FSM        = &H1
    End Property

    Property Get read_PAT_GEN_FSM
        read
        read_PAT_GEN_FSM = read_PAT_GEN_FSM_value
    End Property

    Property Let write_PAT_GEN_FSM(aData)
        set_PAT_GEN_FSM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAT_GEN_ACTIVE_value = rightShift(data_low, 3) and &H1
        PAT_GEN_FSM_mask = &H7
        if data_low > LONG_MAX then
            if PAT_GEN_FSM_mask = mask then
                read_PAT_GEN_FSM_value = data_low
            else
                read_PAT_GEN_FSM_value = (data_low - H8000_0000) and PAT_GEN_FSM_mask
            end If
        else
            read_PAT_GEN_FSM_value = data_low and PAT_GEN_FSM_mask
        end If

    End Sub

    Sub write
        If flag_PAT_GEN_ACTIVE = &H0 or flag_PAT_GEN_FSM = &H0 Then read
        If flag_PAT_GEN_ACTIVE = &H0 Then write_PAT_GEN_ACTIVE_value = get_PAT_GEN_ACTIVE
        If flag_PAT_GEN_FSM = &H0 Then write_PAT_GEN_FSM_value = get_PAT_GEN_FSM

        regValue = leftShift((write_PAT_GEN_ACTIVE_value and &H1), 3) + leftShift((write_PAT_GEN_FSM_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAT_GEN_ACTIVE_value = rightShift(data_low, 3) and &H1
        PAT_GEN_FSM_mask = &H7
        if data_low > LONG_MAX then
            if PAT_GEN_FSM_mask = mask then
                read_PAT_GEN_FSM_value = data_low
            else
                read_PAT_GEN_FSM_value = (data_low - H8000_0000) and PAT_GEN_FSM_mask
            end If
        else
            read_PAT_GEN_FSM_value = data_low and PAT_GEN_FSM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PAT_GEN_ACTIVE_value = &H0
        flag_PAT_GEN_ACTIVE        = &H0
        write_PAT_GEN_FSM_value = &H0
        flag_PAT_GEN_FSM        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_crc_error_counter
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CRC_ERROR_COUNT                            [15:0]           get_CRC_ERROR_COUNT
''                                                             set_CRC_ERROR_COUNT
''                                                             read_CRC_ERROR_COUNT
''                                                             write_CRC_ERROR_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_crc_error_counter
    Private write_CRC_ERROR_COUNT_value
    Private read_CRC_ERROR_COUNT_value
    Private flag_CRC_ERROR_COUNT

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

    Property Get get_CRC_ERROR_COUNT
        get_CRC_ERROR_COUNT = read_CRC_ERROR_COUNT_value
    End Property

    Property Let set_CRC_ERROR_COUNT(aData)
        write_CRC_ERROR_COUNT_value = aData
        flag_CRC_ERROR_COUNT        = &H1
    End Property

    Property Get read_CRC_ERROR_COUNT
        read
        read_CRC_ERROR_COUNT = read_CRC_ERROR_COUNT_value
    End Property

    Property Let write_CRC_ERROR_COUNT(aData)
        set_CRC_ERROR_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CRC_ERROR_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if CRC_ERROR_COUNT_mask = mask then
                read_CRC_ERROR_COUNT_value = data_low
            else
                read_CRC_ERROR_COUNT_value = (data_low - H8000_0000) and CRC_ERROR_COUNT_mask
            end If
        else
            read_CRC_ERROR_COUNT_value = data_low and CRC_ERROR_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CRC_ERROR_COUNT = &H0 Then read
        If flag_CRC_ERROR_COUNT = &H0 Then write_CRC_ERROR_COUNT_value = get_CRC_ERROR_COUNT

        regValue = leftShift((write_CRC_ERROR_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CRC_ERROR_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if CRC_ERROR_COUNT_mask = mask then
                read_CRC_ERROR_COUNT_value = data_low
            else
                read_CRC_ERROR_COUNT_value = (data_low - H8000_0000) and CRC_ERROR_COUNT_mask
            end If
        else
            read_CRC_ERROR_COUNT_value = data_low and CRC_ERROR_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CRC_ERROR_COUNT_value = &H0
        flag_CRC_ERROR_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_packet_counter
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PACKET_COUNT                               [15:0]           get_PACKET_COUNT
''                                                             set_PACKET_COUNT
''                                                             read_PACKET_COUNT
''                                                             write_PACKET_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_packet_counter
    Private write_PACKET_COUNT_value
    Private read_PACKET_COUNT_value
    Private flag_PACKET_COUNT

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

    Property Get get_PACKET_COUNT
        get_PACKET_COUNT = read_PACKET_COUNT_value
    End Property

    Property Let set_PACKET_COUNT(aData)
        write_PACKET_COUNT_value = aData
        flag_PACKET_COUNT        = &H1
    End Property

    Property Get read_PACKET_COUNT
        read
        read_PACKET_COUNT = read_PACKET_COUNT_value
    End Property

    Property Let write_PACKET_COUNT(aData)
        set_PACKET_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PACKET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if PACKET_COUNT_mask = mask then
                read_PACKET_COUNT_value = data_low
            else
                read_PACKET_COUNT_value = (data_low - H8000_0000) and PACKET_COUNT_mask
            end If
        else
            read_PACKET_COUNT_value = data_low and PACKET_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_PACKET_COUNT = &H0 Then read
        If flag_PACKET_COUNT = &H0 Then write_PACKET_COUNT_value = get_PACKET_COUNT

        regValue = leftShift((write_PACKET_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PACKET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if PACKET_COUNT_mask = mask then
                read_PACKET_COUNT_value = data_low
            else
                read_PACKET_COUNT_value = (data_low - H8000_0000) and PACKET_COUNT_mask
            end If
        else
            read_PACKET_COUNT_value = data_low and PACKET_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PACKET_COUNT_value = &H0
        flag_PACKET_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_rx_clock_override_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CLKOFF_RXC_CLOCK                           [15:15]          get_CLKOFF_RXC_CLOCK
''                                                             set_CLKOFF_RXC_CLOCK
''                                                             read_CLKOFF_RXC_CLOCK
''                                                             write_CLKOFF_RXC_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_GPCS_RX_CLOCK                       [14:14]          get_CLKOFF_GPCS_RX_CLOCK
''                                                             set_CLKOFF_GPCS_RX_CLOCK
''                                                             read_CLKOFF_GPCS_RX_CLOCK
''                                                             write_CLKOFF_GPCS_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_125_25MHZ_RX_CLOCK                  [13:13]          get_CLKOFF_125_25MHZ_RX_CLOCK
''                                                             set_CLKOFF_125_25MHZ_RX_CLOCK
''                                                             read_CLKOFF_125_25MHZ_RX_CLOCK
''                                                             write_CLKOFF_125_25MHZ_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_250_50MHZ_RX_CLOCK                  [12:12]          get_CLKOFF_250_50MHZ_RX_CLOCK
''                                                             set_CLKOFF_250_50MHZ_RX_CLOCK
''                                                             read_CLKOFF_250_50MHZ_RX_CLOCK
''                                                             write_CLKOFF_250_50MHZ_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_PCS_RX_CLOCK                        [11:11]          get_CLKOFF_PCS_RX_CLOCK
''                                                             set_CLKOFF_PCS_RX_CLOCK
''                                                             read_CLKOFF_PCS_RX_CLOCK
''                                                             write_CLKOFF_PCS_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_FECRXFIFO_RX_CLOCK                  [10:10]          get_CLKOFF_FECRXFIFO_RX_CLOCK
''                                                             set_CLKOFF_FECRXFIFO_RX_CLOCK
''                                                             read_CLKOFF_FECRXFIFO_RX_CLOCK
''                                                             write_CLKOFF_FECRXFIFO_RX_CLOCK
''---------------------------------------------------------------------------------
'' NOT_USED                                   [9:6]            get_NOT_USED
''                                                             set_NOT_USED
''                                                             read_NOT_USED
''                                                             write_NOT_USED
''---------------------------------------------------------------------------------
'' CLKOFF_DSP_RX_CLOCK                        [5:5]            get_CLKOFF_DSP_RX_CLOCK
''                                                             set_CLKOFF_DSP_RX_CLOCK
''                                                             read_CLKOFF_DSP_RX_CLOCK
''                                                             write_CLKOFF_DSP_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_RX_INTFC_RX_CLOCK                   [4:4]            get_CLKOFF_RX_INTFC_RX_CLOCK
''                                                             set_CLKOFF_RX_INTFC_RX_CLOCK
''                                                             read_CLKOFF_RX_INTFC_RX_CLOCK
''                                                             write_CLKOFF_RX_INTFC_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_ADCCAL_RX_CLOCK                     [3:3]            get_CLKOFF_ADCCAL_RX_CLOCK
''                                                             set_CLKOFF_ADCCAL_RX_CLOCK
''                                                             read_CLKOFF_ADCCAL_RX_CLOCK
''                                                             write_CLKOFF_ADCCAL_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_ACD_RX_CLOCK                        [2:2]            get_CLKOFF_ACD_RX_CLOCK
''                                                             set_CLKOFF_ACD_RX_CLOCK
''                                                             read_CLKOFF_ACD_RX_CLOCK
''                                                             write_CLKOFF_ACD_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC2_RX_CLOCK                       [1:1]            get_CLKOFF_TPC2_RX_CLOCK
''                                                             set_CLKOFF_TPC2_RX_CLOCK
''                                                             read_CLKOFF_TPC2_RX_CLOCK
''                                                             write_CLKOFF_TPC2_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC1_RX_CLOCK                       [0:0]            get_CLKOFF_TPC1_RX_CLOCK
''                                                             set_CLKOFF_TPC1_RX_CLOCK
''                                                             read_CLKOFF_TPC1_RX_CLOCK
''                                                             write_CLKOFF_TPC1_RX_CLOCK
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_rx_clock_override_enable
    Private write_CLKOFF_RXC_CLOCK_value
    Private read_CLKOFF_RXC_CLOCK_value
    Private flag_CLKOFF_RXC_CLOCK
    Private write_CLKOFF_GPCS_RX_CLOCK_value
    Private read_CLKOFF_GPCS_RX_CLOCK_value
    Private flag_CLKOFF_GPCS_RX_CLOCK
    Private write_CLKOFF_125_25MHZ_RX_CLOCK_value
    Private read_CLKOFF_125_25MHZ_RX_CLOCK_value
    Private flag_CLKOFF_125_25MHZ_RX_CLOCK
    Private write_CLKOFF_250_50MHZ_RX_CLOCK_value
    Private read_CLKOFF_250_50MHZ_RX_CLOCK_value
    Private flag_CLKOFF_250_50MHZ_RX_CLOCK
    Private write_CLKOFF_PCS_RX_CLOCK_value
    Private read_CLKOFF_PCS_RX_CLOCK_value
    Private flag_CLKOFF_PCS_RX_CLOCK
    Private write_CLKOFF_FECRXFIFO_RX_CLOCK_value
    Private read_CLKOFF_FECRXFIFO_RX_CLOCK_value
    Private flag_CLKOFF_FECRXFIFO_RX_CLOCK
    Private write_NOT_USED_value
    Private read_NOT_USED_value
    Private flag_NOT_USED
    Private write_CLKOFF_DSP_RX_CLOCK_value
    Private read_CLKOFF_DSP_RX_CLOCK_value
    Private flag_CLKOFF_DSP_RX_CLOCK
    Private write_CLKOFF_RX_INTFC_RX_CLOCK_value
    Private read_CLKOFF_RX_INTFC_RX_CLOCK_value
    Private flag_CLKOFF_RX_INTFC_RX_CLOCK
    Private write_CLKOFF_ADCCAL_RX_CLOCK_value
    Private read_CLKOFF_ADCCAL_RX_CLOCK_value
    Private flag_CLKOFF_ADCCAL_RX_CLOCK
    Private write_CLKOFF_ACD_RX_CLOCK_value
    Private read_CLKOFF_ACD_RX_CLOCK_value
    Private flag_CLKOFF_ACD_RX_CLOCK
    Private write_CLKOFF_TPC2_RX_CLOCK_value
    Private read_CLKOFF_TPC2_RX_CLOCK_value
    Private flag_CLKOFF_TPC2_RX_CLOCK
    Private write_CLKOFF_TPC1_RX_CLOCK_value
    Private read_CLKOFF_TPC1_RX_CLOCK_value
    Private flag_CLKOFF_TPC1_RX_CLOCK

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

    Property Get get_CLKOFF_RXC_CLOCK
        get_CLKOFF_RXC_CLOCK = read_CLKOFF_RXC_CLOCK_value
    End Property

    Property Let set_CLKOFF_RXC_CLOCK(aData)
        write_CLKOFF_RXC_CLOCK_value = aData
        flag_CLKOFF_RXC_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_RXC_CLOCK
        read
        read_CLKOFF_RXC_CLOCK = read_CLKOFF_RXC_CLOCK_value
    End Property

    Property Let write_CLKOFF_RXC_CLOCK(aData)
        set_CLKOFF_RXC_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_GPCS_RX_CLOCK
        get_CLKOFF_GPCS_RX_CLOCK = read_CLKOFF_GPCS_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_GPCS_RX_CLOCK(aData)
        write_CLKOFF_GPCS_RX_CLOCK_value = aData
        flag_CLKOFF_GPCS_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_GPCS_RX_CLOCK
        read
        read_CLKOFF_GPCS_RX_CLOCK = read_CLKOFF_GPCS_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_GPCS_RX_CLOCK(aData)
        set_CLKOFF_GPCS_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_125_25MHZ_RX_CLOCK
        get_CLKOFF_125_25MHZ_RX_CLOCK = read_CLKOFF_125_25MHZ_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_125_25MHZ_RX_CLOCK(aData)
        write_CLKOFF_125_25MHZ_RX_CLOCK_value = aData
        flag_CLKOFF_125_25MHZ_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_125_25MHZ_RX_CLOCK
        read
        read_CLKOFF_125_25MHZ_RX_CLOCK = read_CLKOFF_125_25MHZ_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_125_25MHZ_RX_CLOCK(aData)
        set_CLKOFF_125_25MHZ_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_250_50MHZ_RX_CLOCK
        get_CLKOFF_250_50MHZ_RX_CLOCK = read_CLKOFF_250_50MHZ_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_250_50MHZ_RX_CLOCK(aData)
        write_CLKOFF_250_50MHZ_RX_CLOCK_value = aData
        flag_CLKOFF_250_50MHZ_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_250_50MHZ_RX_CLOCK
        read
        read_CLKOFF_250_50MHZ_RX_CLOCK = read_CLKOFF_250_50MHZ_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_250_50MHZ_RX_CLOCK(aData)
        set_CLKOFF_250_50MHZ_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_PCS_RX_CLOCK
        get_CLKOFF_PCS_RX_CLOCK = read_CLKOFF_PCS_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_PCS_RX_CLOCK(aData)
        write_CLKOFF_PCS_RX_CLOCK_value = aData
        flag_CLKOFF_PCS_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_PCS_RX_CLOCK
        read
        read_CLKOFF_PCS_RX_CLOCK = read_CLKOFF_PCS_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_PCS_RX_CLOCK(aData)
        set_CLKOFF_PCS_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_FECRXFIFO_RX_CLOCK
        get_CLKOFF_FECRXFIFO_RX_CLOCK = read_CLKOFF_FECRXFIFO_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_FECRXFIFO_RX_CLOCK(aData)
        write_CLKOFF_FECRXFIFO_RX_CLOCK_value = aData
        flag_CLKOFF_FECRXFIFO_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_FECRXFIFO_RX_CLOCK
        read
        read_CLKOFF_FECRXFIFO_RX_CLOCK = read_CLKOFF_FECRXFIFO_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_FECRXFIFO_RX_CLOCK(aData)
        set_CLKOFF_FECRXFIFO_RX_CLOCK = aData
        write
    End Property

    Property Get get_NOT_USED
        get_NOT_USED = read_NOT_USED_value
    End Property

    Property Let set_NOT_USED(aData)
        write_NOT_USED_value = aData
        flag_NOT_USED        = &H1
    End Property

    Property Get read_NOT_USED
        read
        read_NOT_USED = read_NOT_USED_value
    End Property

    Property Let write_NOT_USED(aData)
        set_NOT_USED = aData
        write
    End Property

    Property Get get_CLKOFF_DSP_RX_CLOCK
        get_CLKOFF_DSP_RX_CLOCK = read_CLKOFF_DSP_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_DSP_RX_CLOCK(aData)
        write_CLKOFF_DSP_RX_CLOCK_value = aData
        flag_CLKOFF_DSP_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_DSP_RX_CLOCK
        read
        read_CLKOFF_DSP_RX_CLOCK = read_CLKOFF_DSP_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_DSP_RX_CLOCK(aData)
        set_CLKOFF_DSP_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_RX_INTFC_RX_CLOCK
        get_CLKOFF_RX_INTFC_RX_CLOCK = read_CLKOFF_RX_INTFC_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_RX_INTFC_RX_CLOCK(aData)
        write_CLKOFF_RX_INTFC_RX_CLOCK_value = aData
        flag_CLKOFF_RX_INTFC_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_RX_INTFC_RX_CLOCK
        read
        read_CLKOFF_RX_INTFC_RX_CLOCK = read_CLKOFF_RX_INTFC_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_RX_INTFC_RX_CLOCK(aData)
        set_CLKOFF_RX_INTFC_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_ADCCAL_RX_CLOCK
        get_CLKOFF_ADCCAL_RX_CLOCK = read_CLKOFF_ADCCAL_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_ADCCAL_RX_CLOCK(aData)
        write_CLKOFF_ADCCAL_RX_CLOCK_value = aData
        flag_CLKOFF_ADCCAL_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_ADCCAL_RX_CLOCK
        read
        read_CLKOFF_ADCCAL_RX_CLOCK = read_CLKOFF_ADCCAL_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_ADCCAL_RX_CLOCK(aData)
        set_CLKOFF_ADCCAL_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_ACD_RX_CLOCK
        get_CLKOFF_ACD_RX_CLOCK = read_CLKOFF_ACD_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_ACD_RX_CLOCK(aData)
        write_CLKOFF_ACD_RX_CLOCK_value = aData
        flag_CLKOFF_ACD_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_ACD_RX_CLOCK
        read
        read_CLKOFF_ACD_RX_CLOCK = read_CLKOFF_ACD_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_ACD_RX_CLOCK(aData)
        set_CLKOFF_ACD_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC2_RX_CLOCK
        get_CLKOFF_TPC2_RX_CLOCK = read_CLKOFF_TPC2_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC2_RX_CLOCK(aData)
        write_CLKOFF_TPC2_RX_CLOCK_value = aData
        flag_CLKOFF_TPC2_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC2_RX_CLOCK
        read
        read_CLKOFF_TPC2_RX_CLOCK = read_CLKOFF_TPC2_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC2_RX_CLOCK(aData)
        set_CLKOFF_TPC2_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC1_RX_CLOCK
        get_CLKOFF_TPC1_RX_CLOCK = read_CLKOFF_TPC1_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC1_RX_CLOCK(aData)
        write_CLKOFF_TPC1_RX_CLOCK_value = aData
        flag_CLKOFF_TPC1_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC1_RX_CLOCK
        read
        read_CLKOFF_TPC1_RX_CLOCK = read_CLKOFF_TPC1_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC1_RX_CLOCK(aData)
        set_CLKOFF_TPC1_RX_CLOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CLKOFF_RXC_CLOCK_value = rightShift(data_low, 15) and &H1
        read_CLKOFF_GPCS_RX_CLOCK_value = rightShift(data_low, 14) and &H1
        read_CLKOFF_125_25MHZ_RX_CLOCK_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_250_50MHZ_RX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_PCS_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_CLKOFF_FECRXFIFO_RX_CLOCK_value = rightShift(data_low, 10) and &H1
        read_NOT_USED_value = rightShift(data_low, 6) and &Hf
        read_CLKOFF_DSP_RX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_RX_INTFC_RX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_CLKOFF_ADCCAL_RX_CLOCK_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_ACD_RX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_CLKOFF_TPC2_RX_CLOCK_value = rightShift(data_low, 1) and &H1
        CLKOFF_TPC1_RX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_TPC1_RX_CLOCK_mask = mask then
                read_CLKOFF_TPC1_RX_CLOCK_value = data_low
            else
                read_CLKOFF_TPC1_RX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_TPC1_RX_CLOCK_mask
            end If
        else
            read_CLKOFF_TPC1_RX_CLOCK_value = data_low and CLKOFF_TPC1_RX_CLOCK_mask
        end If

    End Sub

    Sub write
        If flag_CLKOFF_RXC_CLOCK = &H0 or flag_CLKOFF_GPCS_RX_CLOCK = &H0 or flag_CLKOFF_125_25MHZ_RX_CLOCK = &H0 or flag_CLKOFF_250_50MHZ_RX_CLOCK = &H0 or flag_CLKOFF_PCS_RX_CLOCK = &H0 or flag_CLKOFF_FECRXFIFO_RX_CLOCK = &H0 or flag_NOT_USED = &H0 or flag_CLKOFF_DSP_RX_CLOCK = &H0 or flag_CLKOFF_RX_INTFC_RX_CLOCK = &H0 or flag_CLKOFF_ADCCAL_RX_CLOCK = &H0 or flag_CLKOFF_ACD_RX_CLOCK = &H0 or flag_CLKOFF_TPC2_RX_CLOCK = &H0 or flag_CLKOFF_TPC1_RX_CLOCK = &H0 Then read
        If flag_CLKOFF_RXC_CLOCK = &H0 Then write_CLKOFF_RXC_CLOCK_value = get_CLKOFF_RXC_CLOCK
        If flag_CLKOFF_GPCS_RX_CLOCK = &H0 Then write_CLKOFF_GPCS_RX_CLOCK_value = get_CLKOFF_GPCS_RX_CLOCK
        If flag_CLKOFF_125_25MHZ_RX_CLOCK = &H0 Then write_CLKOFF_125_25MHZ_RX_CLOCK_value = get_CLKOFF_125_25MHZ_RX_CLOCK
        If flag_CLKOFF_250_50MHZ_RX_CLOCK = &H0 Then write_CLKOFF_250_50MHZ_RX_CLOCK_value = get_CLKOFF_250_50MHZ_RX_CLOCK
        If flag_CLKOFF_PCS_RX_CLOCK = &H0 Then write_CLKOFF_PCS_RX_CLOCK_value = get_CLKOFF_PCS_RX_CLOCK
        If flag_CLKOFF_FECRXFIFO_RX_CLOCK = &H0 Then write_CLKOFF_FECRXFIFO_RX_CLOCK_value = get_CLKOFF_FECRXFIFO_RX_CLOCK
        If flag_NOT_USED = &H0 Then write_NOT_USED_value = get_NOT_USED
        If flag_CLKOFF_DSP_RX_CLOCK = &H0 Then write_CLKOFF_DSP_RX_CLOCK_value = get_CLKOFF_DSP_RX_CLOCK
        If flag_CLKOFF_RX_INTFC_RX_CLOCK = &H0 Then write_CLKOFF_RX_INTFC_RX_CLOCK_value = get_CLKOFF_RX_INTFC_RX_CLOCK
        If flag_CLKOFF_ADCCAL_RX_CLOCK = &H0 Then write_CLKOFF_ADCCAL_RX_CLOCK_value = get_CLKOFF_ADCCAL_RX_CLOCK
        If flag_CLKOFF_ACD_RX_CLOCK = &H0 Then write_CLKOFF_ACD_RX_CLOCK_value = get_CLKOFF_ACD_RX_CLOCK
        If flag_CLKOFF_TPC2_RX_CLOCK = &H0 Then write_CLKOFF_TPC2_RX_CLOCK_value = get_CLKOFF_TPC2_RX_CLOCK
        If flag_CLKOFF_TPC1_RX_CLOCK = &H0 Then write_CLKOFF_TPC1_RX_CLOCK_value = get_CLKOFF_TPC1_RX_CLOCK

        regValue = leftShift((write_CLKOFF_RXC_CLOCK_value and &H1), 15) + leftShift((write_CLKOFF_GPCS_RX_CLOCK_value and &H1), 14) + leftShift((write_CLKOFF_125_25MHZ_RX_CLOCK_value and &H1), 13) + leftShift((write_CLKOFF_250_50MHZ_RX_CLOCK_value and &H1), 12) + leftShift((write_CLKOFF_PCS_RX_CLOCK_value and &H1), 11) + leftShift((write_CLKOFF_FECRXFIFO_RX_CLOCK_value and &H1), 10) + leftShift((write_NOT_USED_value and &Hf), 6) + leftShift((write_CLKOFF_DSP_RX_CLOCK_value and &H1), 5) + leftShift((write_CLKOFF_RX_INTFC_RX_CLOCK_value and &H1), 4) + leftShift((write_CLKOFF_ADCCAL_RX_CLOCK_value and &H1), 3) + leftShift((write_CLKOFF_ACD_RX_CLOCK_value and &H1), 2) + leftShift((write_CLKOFF_TPC2_RX_CLOCK_value and &H1), 1) + leftShift((write_CLKOFF_TPC1_RX_CLOCK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CLKOFF_RXC_CLOCK_value = rightShift(data_low, 15) and &H1
        read_CLKOFF_GPCS_RX_CLOCK_value = rightShift(data_low, 14) and &H1
        read_CLKOFF_125_25MHZ_RX_CLOCK_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_250_50MHZ_RX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_PCS_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_CLKOFF_FECRXFIFO_RX_CLOCK_value = rightShift(data_low, 10) and &H1
        read_NOT_USED_value = rightShift(data_low, 6) and &Hf
        read_CLKOFF_DSP_RX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_RX_INTFC_RX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_CLKOFF_ADCCAL_RX_CLOCK_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_ACD_RX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_CLKOFF_TPC2_RX_CLOCK_value = rightShift(data_low, 1) and &H1
        CLKOFF_TPC1_RX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_TPC1_RX_CLOCK_mask = mask then
                read_CLKOFF_TPC1_RX_CLOCK_value = data_low
            else
                read_CLKOFF_TPC1_RX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_TPC1_RX_CLOCK_mask
            end If
        else
            read_CLKOFF_TPC1_RX_CLOCK_value = data_low and CLKOFF_TPC1_RX_CLOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CLKOFF_RXC_CLOCK_value = &H0
        flag_CLKOFF_RXC_CLOCK        = &H0
        write_CLKOFF_GPCS_RX_CLOCK_value = &H0
        flag_CLKOFF_GPCS_RX_CLOCK        = &H0
        write_CLKOFF_125_25MHZ_RX_CLOCK_value = &H0
        flag_CLKOFF_125_25MHZ_RX_CLOCK        = &H0
        write_CLKOFF_250_50MHZ_RX_CLOCK_value = &H0
        flag_CLKOFF_250_50MHZ_RX_CLOCK        = &H0
        write_CLKOFF_PCS_RX_CLOCK_value = &H0
        flag_CLKOFF_PCS_RX_CLOCK        = &H0
        write_CLKOFF_FECRXFIFO_RX_CLOCK_value = &H0
        flag_CLKOFF_FECRXFIFO_RX_CLOCK        = &H0
        write_NOT_USED_value = &H0
        flag_NOT_USED        = &H0
        write_CLKOFF_DSP_RX_CLOCK_value = &H0
        flag_CLKOFF_DSP_RX_CLOCK        = &H0
        write_CLKOFF_RX_INTFC_RX_CLOCK_value = &H0
        flag_CLKOFF_RX_INTFC_RX_CLOCK        = &H0
        write_CLKOFF_ADCCAL_RX_CLOCK_value = &H0
        flag_CLKOFF_ADCCAL_RX_CLOCK        = &H0
        write_CLKOFF_ACD_RX_CLOCK_value = &H0
        flag_CLKOFF_ACD_RX_CLOCK        = &H0
        write_CLKOFF_TPC2_RX_CLOCK_value = &H0
        flag_CLKOFF_TPC2_RX_CLOCK        = &H0
        write_CLKOFF_TPC1_RX_CLOCK_value = &H0
        flag_CLKOFF_TPC1_RX_CLOCK        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_rx_clock_override_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CLKOFF_RXC_CLOCK                           [15:15]          get_CLKOFF_RXC_CLOCK
''                                                             set_CLKOFF_RXC_CLOCK
''                                                             read_CLKOFF_RXC_CLOCK
''                                                             write_CLKOFF_RXC_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_GPCS_RX_CLOCK                       [14:14]          get_CLKOFF_GPCS_RX_CLOCK
''                                                             set_CLKOFF_GPCS_RX_CLOCK
''                                                             read_CLKOFF_GPCS_RX_CLOCK
''                                                             write_CLKOFF_GPCS_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_125_25MHZ_RX_CLOCK                  [13:13]          get_CLKOFF_125_25MHZ_RX_CLOCK
''                                                             set_CLKOFF_125_25MHZ_RX_CLOCK
''                                                             read_CLKOFF_125_25MHZ_RX_CLOCK
''                                                             write_CLKOFF_125_25MHZ_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_250_50MHZ_RX_CLOCK                  [12:12]          get_CLKOFF_250_50MHZ_RX_CLOCK
''                                                             set_CLKOFF_250_50MHZ_RX_CLOCK
''                                                             read_CLKOFF_250_50MHZ_RX_CLOCK
''                                                             write_CLKOFF_250_50MHZ_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_PCS_RX_CLOCK                        [11:11]          get_CLKOFF_PCS_RX_CLOCK
''                                                             set_CLKOFF_PCS_RX_CLOCK
''                                                             read_CLKOFF_PCS_RX_CLOCK
''                                                             write_CLKOFF_PCS_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_FECRXFIFO_RX_CLOCK                  [10:10]          get_CLKOFF_FECRXFIFO_RX_CLOCK
''                                                             set_CLKOFF_FECRXFIFO_RX_CLOCK
''                                                             read_CLKOFF_FECRXFIFO_RX_CLOCK
''                                                             write_CLKOFF_FECRXFIFO_RX_CLOCK
''---------------------------------------------------------------------------------
'' NOT_USED                                   [9:6]            get_NOT_USED
''                                                             set_NOT_USED
''                                                             read_NOT_USED
''                                                             write_NOT_USED
''---------------------------------------------------------------------------------
'' CLKOFF_DSP_RX_CLOCK                        [5:5]            get_CLKOFF_DSP_RX_CLOCK
''                                                             set_CLKOFF_DSP_RX_CLOCK
''                                                             read_CLKOFF_DSP_RX_CLOCK
''                                                             write_CLKOFF_DSP_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_RX_INTFC_RX_CLOCK                   [4:4]            get_CLKOFF_RX_INTFC_RX_CLOCK
''                                                             set_CLKOFF_RX_INTFC_RX_CLOCK
''                                                             read_CLKOFF_RX_INTFC_RX_CLOCK
''                                                             write_CLKOFF_RX_INTFC_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_ADCCAL_RX_CLOCK                     [3:3]            get_CLKOFF_ADCCAL_RX_CLOCK
''                                                             set_CLKOFF_ADCCAL_RX_CLOCK
''                                                             read_CLKOFF_ADCCAL_RX_CLOCK
''                                                             write_CLKOFF_ADCCAL_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_ACD_RX_CLOCK                        [2:2]            get_CLKOFF_ACD_RX_CLOCK
''                                                             set_CLKOFF_ACD_RX_CLOCK
''                                                             read_CLKOFF_ACD_RX_CLOCK
''                                                             write_CLKOFF_ACD_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC2_RX_CLOCK                       [1:1]            get_CLKOFF_TPC2_RX_CLOCK
''                                                             set_CLKOFF_TPC2_RX_CLOCK
''                                                             read_CLKOFF_TPC2_RX_CLOCK
''                                                             write_CLKOFF_TPC2_RX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC1_RX_CLOCK                       [0:0]            get_CLKOFF_TPC1_RX_CLOCK
''                                                             set_CLKOFF_TPC1_RX_CLOCK
''                                                             read_CLKOFF_TPC1_RX_CLOCK
''                                                             write_CLKOFF_TPC1_RX_CLOCK
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_rx_clock_override_value
    Private write_CLKOFF_RXC_CLOCK_value
    Private read_CLKOFF_RXC_CLOCK_value
    Private flag_CLKOFF_RXC_CLOCK
    Private write_CLKOFF_GPCS_RX_CLOCK_value
    Private read_CLKOFF_GPCS_RX_CLOCK_value
    Private flag_CLKOFF_GPCS_RX_CLOCK
    Private write_CLKOFF_125_25MHZ_RX_CLOCK_value
    Private read_CLKOFF_125_25MHZ_RX_CLOCK_value
    Private flag_CLKOFF_125_25MHZ_RX_CLOCK
    Private write_CLKOFF_250_50MHZ_RX_CLOCK_value
    Private read_CLKOFF_250_50MHZ_RX_CLOCK_value
    Private flag_CLKOFF_250_50MHZ_RX_CLOCK
    Private write_CLKOFF_PCS_RX_CLOCK_value
    Private read_CLKOFF_PCS_RX_CLOCK_value
    Private flag_CLKOFF_PCS_RX_CLOCK
    Private write_CLKOFF_FECRXFIFO_RX_CLOCK_value
    Private read_CLKOFF_FECRXFIFO_RX_CLOCK_value
    Private flag_CLKOFF_FECRXFIFO_RX_CLOCK
    Private write_NOT_USED_value
    Private read_NOT_USED_value
    Private flag_NOT_USED
    Private write_CLKOFF_DSP_RX_CLOCK_value
    Private read_CLKOFF_DSP_RX_CLOCK_value
    Private flag_CLKOFF_DSP_RX_CLOCK
    Private write_CLKOFF_RX_INTFC_RX_CLOCK_value
    Private read_CLKOFF_RX_INTFC_RX_CLOCK_value
    Private flag_CLKOFF_RX_INTFC_RX_CLOCK
    Private write_CLKOFF_ADCCAL_RX_CLOCK_value
    Private read_CLKOFF_ADCCAL_RX_CLOCK_value
    Private flag_CLKOFF_ADCCAL_RX_CLOCK
    Private write_CLKOFF_ACD_RX_CLOCK_value
    Private read_CLKOFF_ACD_RX_CLOCK_value
    Private flag_CLKOFF_ACD_RX_CLOCK
    Private write_CLKOFF_TPC2_RX_CLOCK_value
    Private read_CLKOFF_TPC2_RX_CLOCK_value
    Private flag_CLKOFF_TPC2_RX_CLOCK
    Private write_CLKOFF_TPC1_RX_CLOCK_value
    Private read_CLKOFF_TPC1_RX_CLOCK_value
    Private flag_CLKOFF_TPC1_RX_CLOCK

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

    Property Get get_CLKOFF_RXC_CLOCK
        get_CLKOFF_RXC_CLOCK = read_CLKOFF_RXC_CLOCK_value
    End Property

    Property Let set_CLKOFF_RXC_CLOCK(aData)
        write_CLKOFF_RXC_CLOCK_value = aData
        flag_CLKOFF_RXC_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_RXC_CLOCK
        read
        read_CLKOFF_RXC_CLOCK = read_CLKOFF_RXC_CLOCK_value
    End Property

    Property Let write_CLKOFF_RXC_CLOCK(aData)
        set_CLKOFF_RXC_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_GPCS_RX_CLOCK
        get_CLKOFF_GPCS_RX_CLOCK = read_CLKOFF_GPCS_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_GPCS_RX_CLOCK(aData)
        write_CLKOFF_GPCS_RX_CLOCK_value = aData
        flag_CLKOFF_GPCS_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_GPCS_RX_CLOCK
        read
        read_CLKOFF_GPCS_RX_CLOCK = read_CLKOFF_GPCS_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_GPCS_RX_CLOCK(aData)
        set_CLKOFF_GPCS_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_125_25MHZ_RX_CLOCK
        get_CLKOFF_125_25MHZ_RX_CLOCK = read_CLKOFF_125_25MHZ_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_125_25MHZ_RX_CLOCK(aData)
        write_CLKOFF_125_25MHZ_RX_CLOCK_value = aData
        flag_CLKOFF_125_25MHZ_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_125_25MHZ_RX_CLOCK
        read
        read_CLKOFF_125_25MHZ_RX_CLOCK = read_CLKOFF_125_25MHZ_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_125_25MHZ_RX_CLOCK(aData)
        set_CLKOFF_125_25MHZ_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_250_50MHZ_RX_CLOCK
        get_CLKOFF_250_50MHZ_RX_CLOCK = read_CLKOFF_250_50MHZ_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_250_50MHZ_RX_CLOCK(aData)
        write_CLKOFF_250_50MHZ_RX_CLOCK_value = aData
        flag_CLKOFF_250_50MHZ_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_250_50MHZ_RX_CLOCK
        read
        read_CLKOFF_250_50MHZ_RX_CLOCK = read_CLKOFF_250_50MHZ_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_250_50MHZ_RX_CLOCK(aData)
        set_CLKOFF_250_50MHZ_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_PCS_RX_CLOCK
        get_CLKOFF_PCS_RX_CLOCK = read_CLKOFF_PCS_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_PCS_RX_CLOCK(aData)
        write_CLKOFF_PCS_RX_CLOCK_value = aData
        flag_CLKOFF_PCS_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_PCS_RX_CLOCK
        read
        read_CLKOFF_PCS_RX_CLOCK = read_CLKOFF_PCS_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_PCS_RX_CLOCK(aData)
        set_CLKOFF_PCS_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_FECRXFIFO_RX_CLOCK
        get_CLKOFF_FECRXFIFO_RX_CLOCK = read_CLKOFF_FECRXFIFO_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_FECRXFIFO_RX_CLOCK(aData)
        write_CLKOFF_FECRXFIFO_RX_CLOCK_value = aData
        flag_CLKOFF_FECRXFIFO_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_FECRXFIFO_RX_CLOCK
        read
        read_CLKOFF_FECRXFIFO_RX_CLOCK = read_CLKOFF_FECRXFIFO_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_FECRXFIFO_RX_CLOCK(aData)
        set_CLKOFF_FECRXFIFO_RX_CLOCK = aData
        write
    End Property

    Property Get get_NOT_USED
        get_NOT_USED = read_NOT_USED_value
    End Property

    Property Let set_NOT_USED(aData)
        write_NOT_USED_value = aData
        flag_NOT_USED        = &H1
    End Property

    Property Get read_NOT_USED
        read
        read_NOT_USED = read_NOT_USED_value
    End Property

    Property Let write_NOT_USED(aData)
        set_NOT_USED = aData
        write
    End Property

    Property Get get_CLKOFF_DSP_RX_CLOCK
        get_CLKOFF_DSP_RX_CLOCK = read_CLKOFF_DSP_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_DSP_RX_CLOCK(aData)
        write_CLKOFF_DSP_RX_CLOCK_value = aData
        flag_CLKOFF_DSP_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_DSP_RX_CLOCK
        read
        read_CLKOFF_DSP_RX_CLOCK = read_CLKOFF_DSP_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_DSP_RX_CLOCK(aData)
        set_CLKOFF_DSP_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_RX_INTFC_RX_CLOCK
        get_CLKOFF_RX_INTFC_RX_CLOCK = read_CLKOFF_RX_INTFC_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_RX_INTFC_RX_CLOCK(aData)
        write_CLKOFF_RX_INTFC_RX_CLOCK_value = aData
        flag_CLKOFF_RX_INTFC_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_RX_INTFC_RX_CLOCK
        read
        read_CLKOFF_RX_INTFC_RX_CLOCK = read_CLKOFF_RX_INTFC_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_RX_INTFC_RX_CLOCK(aData)
        set_CLKOFF_RX_INTFC_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_ADCCAL_RX_CLOCK
        get_CLKOFF_ADCCAL_RX_CLOCK = read_CLKOFF_ADCCAL_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_ADCCAL_RX_CLOCK(aData)
        write_CLKOFF_ADCCAL_RX_CLOCK_value = aData
        flag_CLKOFF_ADCCAL_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_ADCCAL_RX_CLOCK
        read
        read_CLKOFF_ADCCAL_RX_CLOCK = read_CLKOFF_ADCCAL_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_ADCCAL_RX_CLOCK(aData)
        set_CLKOFF_ADCCAL_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_ACD_RX_CLOCK
        get_CLKOFF_ACD_RX_CLOCK = read_CLKOFF_ACD_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_ACD_RX_CLOCK(aData)
        write_CLKOFF_ACD_RX_CLOCK_value = aData
        flag_CLKOFF_ACD_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_ACD_RX_CLOCK
        read
        read_CLKOFF_ACD_RX_CLOCK = read_CLKOFF_ACD_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_ACD_RX_CLOCK(aData)
        set_CLKOFF_ACD_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC2_RX_CLOCK
        get_CLKOFF_TPC2_RX_CLOCK = read_CLKOFF_TPC2_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC2_RX_CLOCK(aData)
        write_CLKOFF_TPC2_RX_CLOCK_value = aData
        flag_CLKOFF_TPC2_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC2_RX_CLOCK
        read
        read_CLKOFF_TPC2_RX_CLOCK = read_CLKOFF_TPC2_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC2_RX_CLOCK(aData)
        set_CLKOFF_TPC2_RX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC1_RX_CLOCK
        get_CLKOFF_TPC1_RX_CLOCK = read_CLKOFF_TPC1_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC1_RX_CLOCK(aData)
        write_CLKOFF_TPC1_RX_CLOCK_value = aData
        flag_CLKOFF_TPC1_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC1_RX_CLOCK
        read
        read_CLKOFF_TPC1_RX_CLOCK = read_CLKOFF_TPC1_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC1_RX_CLOCK(aData)
        set_CLKOFF_TPC1_RX_CLOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CLKOFF_RXC_CLOCK_value = rightShift(data_low, 15) and &H1
        read_CLKOFF_GPCS_RX_CLOCK_value = rightShift(data_low, 14) and &H1
        read_CLKOFF_125_25MHZ_RX_CLOCK_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_250_50MHZ_RX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_PCS_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_CLKOFF_FECRXFIFO_RX_CLOCK_value = rightShift(data_low, 10) and &H1
        read_NOT_USED_value = rightShift(data_low, 6) and &Hf
        read_CLKOFF_DSP_RX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_RX_INTFC_RX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_CLKOFF_ADCCAL_RX_CLOCK_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_ACD_RX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_CLKOFF_TPC2_RX_CLOCK_value = rightShift(data_low, 1) and &H1
        CLKOFF_TPC1_RX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_TPC1_RX_CLOCK_mask = mask then
                read_CLKOFF_TPC1_RX_CLOCK_value = data_low
            else
                read_CLKOFF_TPC1_RX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_TPC1_RX_CLOCK_mask
            end If
        else
            read_CLKOFF_TPC1_RX_CLOCK_value = data_low and CLKOFF_TPC1_RX_CLOCK_mask
        end If

    End Sub

    Sub write
        If flag_CLKOFF_RXC_CLOCK = &H0 or flag_CLKOFF_GPCS_RX_CLOCK = &H0 or flag_CLKOFF_125_25MHZ_RX_CLOCK = &H0 or flag_CLKOFF_250_50MHZ_RX_CLOCK = &H0 or flag_CLKOFF_PCS_RX_CLOCK = &H0 or flag_CLKOFF_FECRXFIFO_RX_CLOCK = &H0 or flag_NOT_USED = &H0 or flag_CLKOFF_DSP_RX_CLOCK = &H0 or flag_CLKOFF_RX_INTFC_RX_CLOCK = &H0 or flag_CLKOFF_ADCCAL_RX_CLOCK = &H0 or flag_CLKOFF_ACD_RX_CLOCK = &H0 or flag_CLKOFF_TPC2_RX_CLOCK = &H0 or flag_CLKOFF_TPC1_RX_CLOCK = &H0 Then read
        If flag_CLKOFF_RXC_CLOCK = &H0 Then write_CLKOFF_RXC_CLOCK_value = get_CLKOFF_RXC_CLOCK
        If flag_CLKOFF_GPCS_RX_CLOCK = &H0 Then write_CLKOFF_GPCS_RX_CLOCK_value = get_CLKOFF_GPCS_RX_CLOCK
        If flag_CLKOFF_125_25MHZ_RX_CLOCK = &H0 Then write_CLKOFF_125_25MHZ_RX_CLOCK_value = get_CLKOFF_125_25MHZ_RX_CLOCK
        If flag_CLKOFF_250_50MHZ_RX_CLOCK = &H0 Then write_CLKOFF_250_50MHZ_RX_CLOCK_value = get_CLKOFF_250_50MHZ_RX_CLOCK
        If flag_CLKOFF_PCS_RX_CLOCK = &H0 Then write_CLKOFF_PCS_RX_CLOCK_value = get_CLKOFF_PCS_RX_CLOCK
        If flag_CLKOFF_FECRXFIFO_RX_CLOCK = &H0 Then write_CLKOFF_FECRXFIFO_RX_CLOCK_value = get_CLKOFF_FECRXFIFO_RX_CLOCK
        If flag_NOT_USED = &H0 Then write_NOT_USED_value = get_NOT_USED
        If flag_CLKOFF_DSP_RX_CLOCK = &H0 Then write_CLKOFF_DSP_RX_CLOCK_value = get_CLKOFF_DSP_RX_CLOCK
        If flag_CLKOFF_RX_INTFC_RX_CLOCK = &H0 Then write_CLKOFF_RX_INTFC_RX_CLOCK_value = get_CLKOFF_RX_INTFC_RX_CLOCK
        If flag_CLKOFF_ADCCAL_RX_CLOCK = &H0 Then write_CLKOFF_ADCCAL_RX_CLOCK_value = get_CLKOFF_ADCCAL_RX_CLOCK
        If flag_CLKOFF_ACD_RX_CLOCK = &H0 Then write_CLKOFF_ACD_RX_CLOCK_value = get_CLKOFF_ACD_RX_CLOCK
        If flag_CLKOFF_TPC2_RX_CLOCK = &H0 Then write_CLKOFF_TPC2_RX_CLOCK_value = get_CLKOFF_TPC2_RX_CLOCK
        If flag_CLKOFF_TPC1_RX_CLOCK = &H0 Then write_CLKOFF_TPC1_RX_CLOCK_value = get_CLKOFF_TPC1_RX_CLOCK

        regValue = leftShift((write_CLKOFF_RXC_CLOCK_value and &H1), 15) + leftShift((write_CLKOFF_GPCS_RX_CLOCK_value and &H1), 14) + leftShift((write_CLKOFF_125_25MHZ_RX_CLOCK_value and &H1), 13) + leftShift((write_CLKOFF_250_50MHZ_RX_CLOCK_value and &H1), 12) + leftShift((write_CLKOFF_PCS_RX_CLOCK_value and &H1), 11) + leftShift((write_CLKOFF_FECRXFIFO_RX_CLOCK_value and &H1), 10) + leftShift((write_NOT_USED_value and &Hf), 6) + leftShift((write_CLKOFF_DSP_RX_CLOCK_value and &H1), 5) + leftShift((write_CLKOFF_RX_INTFC_RX_CLOCK_value and &H1), 4) + leftShift((write_CLKOFF_ADCCAL_RX_CLOCK_value and &H1), 3) + leftShift((write_CLKOFF_ACD_RX_CLOCK_value and &H1), 2) + leftShift((write_CLKOFF_TPC2_RX_CLOCK_value and &H1), 1) + leftShift((write_CLKOFF_TPC1_RX_CLOCK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CLKOFF_RXC_CLOCK_value = rightShift(data_low, 15) and &H1
        read_CLKOFF_GPCS_RX_CLOCK_value = rightShift(data_low, 14) and &H1
        read_CLKOFF_125_25MHZ_RX_CLOCK_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_250_50MHZ_RX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_PCS_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_CLKOFF_FECRXFIFO_RX_CLOCK_value = rightShift(data_low, 10) and &H1
        read_NOT_USED_value = rightShift(data_low, 6) and &Hf
        read_CLKOFF_DSP_RX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_RX_INTFC_RX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_CLKOFF_ADCCAL_RX_CLOCK_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_ACD_RX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_CLKOFF_TPC2_RX_CLOCK_value = rightShift(data_low, 1) and &H1
        CLKOFF_TPC1_RX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_TPC1_RX_CLOCK_mask = mask then
                read_CLKOFF_TPC1_RX_CLOCK_value = data_low
            else
                read_CLKOFF_TPC1_RX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_TPC1_RX_CLOCK_mask
            end If
        else
            read_CLKOFF_TPC1_RX_CLOCK_value = data_low and CLKOFF_TPC1_RX_CLOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CLKOFF_RXC_CLOCK_value = &H0
        flag_CLKOFF_RXC_CLOCK        = &H0
        write_CLKOFF_GPCS_RX_CLOCK_value = &H0
        flag_CLKOFF_GPCS_RX_CLOCK        = &H0
        write_CLKOFF_125_25MHZ_RX_CLOCK_value = &H0
        flag_CLKOFF_125_25MHZ_RX_CLOCK        = &H0
        write_CLKOFF_250_50MHZ_RX_CLOCK_value = &H0
        flag_CLKOFF_250_50MHZ_RX_CLOCK        = &H0
        write_CLKOFF_PCS_RX_CLOCK_value = &H0
        flag_CLKOFF_PCS_RX_CLOCK        = &H0
        write_CLKOFF_FECRXFIFO_RX_CLOCK_value = &H0
        flag_CLKOFF_FECRXFIFO_RX_CLOCK        = &H0
        write_NOT_USED_value = &H0
        flag_NOT_USED        = &H0
        write_CLKOFF_DSP_RX_CLOCK_value = &H0
        flag_CLKOFF_DSP_RX_CLOCK        = &H0
        write_CLKOFF_RX_INTFC_RX_CLOCK_value = &H0
        flag_CLKOFF_RX_INTFC_RX_CLOCK        = &H0
        write_CLKOFF_ADCCAL_RX_CLOCK_value = &H0
        flag_CLKOFF_ADCCAL_RX_CLOCK        = &H0
        write_CLKOFF_ACD_RX_CLOCK_value = &H0
        flag_CLKOFF_ACD_RX_CLOCK        = &H0
        write_CLKOFF_TPC2_RX_CLOCK_value = &H0
        flag_CLKOFF_TPC2_RX_CLOCK        = &H0
        write_CLKOFF_TPC1_RX_CLOCK_value = &H0
        flag_CLKOFF_TPC1_RX_CLOCK        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_clock_gen_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CLOCK_GEN_STATUS_BITS                      [15:0]           get_CLOCK_GEN_STATUS_BITS
''                                                             set_CLOCK_GEN_STATUS_BITS
''                                                             read_CLOCK_GEN_STATUS_BITS
''                                                             write_CLOCK_GEN_STATUS_BITS
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_clock_gen_status
    Private write_CLOCK_GEN_STATUS_BITS_value
    Private read_CLOCK_GEN_STATUS_BITS_value
    Private flag_CLOCK_GEN_STATUS_BITS

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

    Property Get get_CLOCK_GEN_STATUS_BITS
        get_CLOCK_GEN_STATUS_BITS = read_CLOCK_GEN_STATUS_BITS_value
    End Property

    Property Let set_CLOCK_GEN_STATUS_BITS(aData)
        write_CLOCK_GEN_STATUS_BITS_value = aData
        flag_CLOCK_GEN_STATUS_BITS        = &H1
    End Property

    Property Get read_CLOCK_GEN_STATUS_BITS
        read
        read_CLOCK_GEN_STATUS_BITS = read_CLOCK_GEN_STATUS_BITS_value
    End Property

    Property Let write_CLOCK_GEN_STATUS_BITS(aData)
        set_CLOCK_GEN_STATUS_BITS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CLOCK_GEN_STATUS_BITS_mask = &Hffff
        if data_low > LONG_MAX then
            if CLOCK_GEN_STATUS_BITS_mask = mask then
                read_CLOCK_GEN_STATUS_BITS_value = data_low
            else
                read_CLOCK_GEN_STATUS_BITS_value = (data_low - H8000_0000) and CLOCK_GEN_STATUS_BITS_mask
            end If
        else
            read_CLOCK_GEN_STATUS_BITS_value = data_low and CLOCK_GEN_STATUS_BITS_mask
        end If

    End Sub

    Sub write
        If flag_CLOCK_GEN_STATUS_BITS = &H0 Then read
        If flag_CLOCK_GEN_STATUS_BITS = &H0 Then write_CLOCK_GEN_STATUS_BITS_value = get_CLOCK_GEN_STATUS_BITS

        regValue = leftShift((write_CLOCK_GEN_STATUS_BITS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CLOCK_GEN_STATUS_BITS_mask = &Hffff
        if data_low > LONG_MAX then
            if CLOCK_GEN_STATUS_BITS_mask = mask then
                read_CLOCK_GEN_STATUS_BITS_value = data_low
            else
                read_CLOCK_GEN_STATUS_BITS_value = (data_low - H8000_0000) and CLOCK_GEN_STATUS_BITS_mask
            end If
        else
            read_CLOCK_GEN_STATUS_BITS_value = data_low and CLOCK_GEN_STATUS_BITS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CLOCK_GEN_STATUS_BITS_value = &H0
        flag_CLOCK_GEN_STATUS_BITS        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_core_intr_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_COMPLETE                           [15:15]          get_AUTONEG_COMPLETE
''                                                             set_AUTONEG_COMPLETE
''                                                             read_AUTONEG_COMPLETE
''                                                             write_AUTONEG_COMPLETE
''---------------------------------------------------------------------------------
'' AUTONEG_PAGE_RECEIVED                      [14:14]          get_AUTONEG_PAGE_RECEIVED
''                                                             set_AUTONEG_PAGE_RECEIVED
''                                                             read_AUTONEG_PAGE_RECEIVED
''                                                             write_AUTONEG_PAGE_RECEIVED
''---------------------------------------------------------------------------------
'' AUTONEG_RESTARTED                          [13:13]          get_AUTONEG_RESTARTED
''                                                             set_AUTONEG_RESTARTED
''                                                             read_AUTONEG_RESTARTED
''                                                             write_AUTONEG_RESTARTED
''---------------------------------------------------------------------------------
'' FREEZE_DONE                                [2:2]            get_FREEZE_DONE
''                                                             set_FREEZE_DONE
''                                                             read_FREEZE_DONE
''                                                             write_FREEZE_DONE
''---------------------------------------------------------------------------------
'' CRC_ERROR_DETECTED                         [1:1]            get_CRC_ERROR_DETECTED
''                                                             set_CRC_ERROR_DETECTED
''                                                             read_CRC_ERROR_DETECTED
''                                                             write_CRC_ERROR_DETECTED
''---------------------------------------------------------------------------------
'' PATTERN_GEN_STOPPED                        [0:0]            get_PATTERN_GEN_STOPPED
''                                                             set_PATTERN_GEN_STOPPED
''                                                             read_PATTERN_GEN_STOPPED
''                                                             write_PATTERN_GEN_STOPPED
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_core_intr_status
    Private write_AUTONEG_COMPLETE_value
    Private read_AUTONEG_COMPLETE_value
    Private flag_AUTONEG_COMPLETE
    Private write_AUTONEG_PAGE_RECEIVED_value
    Private read_AUTONEG_PAGE_RECEIVED_value
    Private flag_AUTONEG_PAGE_RECEIVED
    Private write_AUTONEG_RESTARTED_value
    Private read_AUTONEG_RESTARTED_value
    Private flag_AUTONEG_RESTARTED
    Private write_FREEZE_DONE_value
    Private read_FREEZE_DONE_value
    Private flag_FREEZE_DONE
    Private write_CRC_ERROR_DETECTED_value
    Private read_CRC_ERROR_DETECTED_value
    Private flag_CRC_ERROR_DETECTED
    Private write_PATTERN_GEN_STOPPED_value
    Private read_PATTERN_GEN_STOPPED_value
    Private flag_PATTERN_GEN_STOPPED

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

    Property Get get_AUTONEG_PAGE_RECEIVED
        get_AUTONEG_PAGE_RECEIVED = read_AUTONEG_PAGE_RECEIVED_value
    End Property

    Property Let set_AUTONEG_PAGE_RECEIVED(aData)
        write_AUTONEG_PAGE_RECEIVED_value = aData
        flag_AUTONEG_PAGE_RECEIVED        = &H1
    End Property

    Property Get read_AUTONEG_PAGE_RECEIVED
        read
        read_AUTONEG_PAGE_RECEIVED = read_AUTONEG_PAGE_RECEIVED_value
    End Property

    Property Let write_AUTONEG_PAGE_RECEIVED(aData)
        set_AUTONEG_PAGE_RECEIVED = aData
        write
    End Property

    Property Get get_AUTONEG_RESTARTED
        get_AUTONEG_RESTARTED = read_AUTONEG_RESTARTED_value
    End Property

    Property Let set_AUTONEG_RESTARTED(aData)
        write_AUTONEG_RESTARTED_value = aData
        flag_AUTONEG_RESTARTED        = &H1
    End Property

    Property Get read_AUTONEG_RESTARTED
        read
        read_AUTONEG_RESTARTED = read_AUTONEG_RESTARTED_value
    End Property

    Property Let write_AUTONEG_RESTARTED(aData)
        set_AUTONEG_RESTARTED = aData
        write
    End Property

    Property Get get_FREEZE_DONE
        get_FREEZE_DONE = read_FREEZE_DONE_value
    End Property

    Property Let set_FREEZE_DONE(aData)
        write_FREEZE_DONE_value = aData
        flag_FREEZE_DONE        = &H1
    End Property

    Property Get read_FREEZE_DONE
        read
        read_FREEZE_DONE = read_FREEZE_DONE_value
    End Property

    Property Let write_FREEZE_DONE(aData)
        set_FREEZE_DONE = aData
        write
    End Property

    Property Get get_CRC_ERROR_DETECTED
        get_CRC_ERROR_DETECTED = read_CRC_ERROR_DETECTED_value
    End Property

    Property Let set_CRC_ERROR_DETECTED(aData)
        write_CRC_ERROR_DETECTED_value = aData
        flag_CRC_ERROR_DETECTED        = &H1
    End Property

    Property Get read_CRC_ERROR_DETECTED
        read
        read_CRC_ERROR_DETECTED = read_CRC_ERROR_DETECTED_value
    End Property

    Property Let write_CRC_ERROR_DETECTED(aData)
        set_CRC_ERROR_DETECTED = aData
        write
    End Property

    Property Get get_PATTERN_GEN_STOPPED
        get_PATTERN_GEN_STOPPED = read_PATTERN_GEN_STOPPED_value
    End Property

    Property Let set_PATTERN_GEN_STOPPED(aData)
        write_PATTERN_GEN_STOPPED_value = aData
        flag_PATTERN_GEN_STOPPED        = &H1
    End Property

    Property Get read_PATTERN_GEN_STOPPED
        read
        read_PATTERN_GEN_STOPPED = read_PATTERN_GEN_STOPPED_value
    End Property

    Property Let write_PATTERN_GEN_STOPPED(aData)
        set_PATTERN_GEN_STOPPED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_COMPLETE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_PAGE_RECEIVED_value = rightShift(data_low, 14) and &H1
        read_AUTONEG_RESTARTED_value = rightShift(data_low, 13) and &H1
        read_FREEZE_DONE_value = rightShift(data_low, 2) and &H1
        read_CRC_ERROR_DETECTED_value = rightShift(data_low, 1) and &H1
        PATTERN_GEN_STOPPED_mask = &H1
        if data_low > LONG_MAX then
            if PATTERN_GEN_STOPPED_mask = mask then
                read_PATTERN_GEN_STOPPED_value = data_low
            else
                read_PATTERN_GEN_STOPPED_value = (data_low - H8000_0000) and PATTERN_GEN_STOPPED_mask
            end If
        else
            read_PATTERN_GEN_STOPPED_value = data_low and PATTERN_GEN_STOPPED_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_COMPLETE = &H0 or flag_AUTONEG_PAGE_RECEIVED = &H0 or flag_AUTONEG_RESTARTED = &H0 or flag_FREEZE_DONE = &H0 or flag_CRC_ERROR_DETECTED = &H0 or flag_PATTERN_GEN_STOPPED = &H0 Then read
        If flag_AUTONEG_COMPLETE = &H0 Then write_AUTONEG_COMPLETE_value = get_AUTONEG_COMPLETE
        If flag_AUTONEG_PAGE_RECEIVED = &H0 Then write_AUTONEG_PAGE_RECEIVED_value = get_AUTONEG_PAGE_RECEIVED
        If flag_AUTONEG_RESTARTED = &H0 Then write_AUTONEG_RESTARTED_value = get_AUTONEG_RESTARTED
        If flag_FREEZE_DONE = &H0 Then write_FREEZE_DONE_value = get_FREEZE_DONE
        If flag_CRC_ERROR_DETECTED = &H0 Then write_CRC_ERROR_DETECTED_value = get_CRC_ERROR_DETECTED
        If flag_PATTERN_GEN_STOPPED = &H0 Then write_PATTERN_GEN_STOPPED_value = get_PATTERN_GEN_STOPPED

        regValue = leftShift((write_AUTONEG_COMPLETE_value and &H1), 15) + leftShift((write_AUTONEG_PAGE_RECEIVED_value and &H1), 14) + leftShift((write_AUTONEG_RESTARTED_value and &H1), 13) + leftShift((write_FREEZE_DONE_value and &H1), 2) + leftShift((write_CRC_ERROR_DETECTED_value and &H1), 1) + leftShift((write_PATTERN_GEN_STOPPED_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_COMPLETE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_PAGE_RECEIVED_value = rightShift(data_low, 14) and &H1
        read_AUTONEG_RESTARTED_value = rightShift(data_low, 13) and &H1
        read_FREEZE_DONE_value = rightShift(data_low, 2) and &H1
        read_CRC_ERROR_DETECTED_value = rightShift(data_low, 1) and &H1
        PATTERN_GEN_STOPPED_mask = &H1
        if data_low > LONG_MAX then
            if PATTERN_GEN_STOPPED_mask = mask then
                read_PATTERN_GEN_STOPPED_value = data_low
            else
                read_PATTERN_GEN_STOPPED_value = (data_low - H8000_0000) and PATTERN_GEN_STOPPED_mask
            end If
        else
            read_PATTERN_GEN_STOPPED_value = data_low and PATTERN_GEN_STOPPED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_COMPLETE_value = &H0
        flag_AUTONEG_COMPLETE        = &H0
        write_AUTONEG_PAGE_RECEIVED_value = &H0
        flag_AUTONEG_PAGE_RECEIVED        = &H0
        write_AUTONEG_RESTARTED_value = &H0
        flag_AUTONEG_RESTARTED        = &H0
        write_FREEZE_DONE_value = &H0
        flag_FREEZE_DONE        = &H0
        write_CRC_ERROR_DETECTED_value = &H0
        flag_CRC_ERROR_DETECTED        = &H0
        write_PATTERN_GEN_STOPPED_value = &H0
        flag_PATTERN_GEN_STOPPED        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_core_intr_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CORE_INTR_ENABLE                           [15:0]           get_CORE_INTR_ENABLE
''                                                             set_CORE_INTR_ENABLE
''                                                             read_CORE_INTR_ENABLE
''                                                             write_CORE_INTR_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_core_intr_enable
    Private write_CORE_INTR_ENABLE_value
    Private read_CORE_INTR_ENABLE_value
    Private flag_CORE_INTR_ENABLE

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

    Property Get get_CORE_INTR_ENABLE
        get_CORE_INTR_ENABLE = read_CORE_INTR_ENABLE_value
    End Property

    Property Let set_CORE_INTR_ENABLE(aData)
        write_CORE_INTR_ENABLE_value = aData
        flag_CORE_INTR_ENABLE        = &H1
    End Property

    Property Get read_CORE_INTR_ENABLE
        read
        read_CORE_INTR_ENABLE = read_CORE_INTR_ENABLE_value
    End Property

    Property Let write_CORE_INTR_ENABLE(aData)
        set_CORE_INTR_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CORE_INTR_ENABLE_mask = &Hffff
        if data_low > LONG_MAX then
            if CORE_INTR_ENABLE_mask = mask then
                read_CORE_INTR_ENABLE_value = data_low
            else
                read_CORE_INTR_ENABLE_value = (data_low - H8000_0000) and CORE_INTR_ENABLE_mask
            end If
        else
            read_CORE_INTR_ENABLE_value = data_low and CORE_INTR_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_CORE_INTR_ENABLE = &H0 Then read
        If flag_CORE_INTR_ENABLE = &H0 Then write_CORE_INTR_ENABLE_value = get_CORE_INTR_ENABLE

        regValue = leftShift((write_CORE_INTR_ENABLE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CORE_INTR_ENABLE_mask = &Hffff
        if data_low > LONG_MAX then
            if CORE_INTR_ENABLE_mask = mask then
                read_CORE_INTR_ENABLE_value = data_low
            else
                read_CORE_INTR_ENABLE_value = (data_low - H8000_0000) and CORE_INTR_ENABLE_mask
            end If
        else
            read_CORE_INTR_ENABLE_value = data_low and CORE_INTR_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CORE_INTR_ENABLE_value = &H0
        flag_CORE_INTR_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_tx_clock_override_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RC_OSC_EN_OVERRIDE_ENABLE                  [15:15]          get_RC_OSC_EN_OVERRIDE_ENABLE
''                                                             set_RC_OSC_EN_OVERRIDE_ENABLE
''                                                             read_RC_OSC_EN_OVERRIDE_ENABLE
''                                                             write_RC_OSC_EN_OVERRIDE_ENABLE
''---------------------------------------------------------------------------------
'' RC_OSC_IN_OVERRIDE_ENABLE                  [14:14]          get_RC_OSC_IN_OVERRIDE_ENABLE
''                                                             set_RC_OSC_IN_OVERRIDE_ENABLE
''                                                             read_RC_OSC_IN_OVERRIDE_ENABLE
''                                                             write_RC_OSC_IN_OVERRIDE_ENABLE
''---------------------------------------------------------------------------------
'' RC_OSC_SEL                                 [13:13]          get_RC_OSC_SEL
''                                                             set_RC_OSC_SEL
''                                                             read_RC_OSC_SEL
''                                                             write_RC_OSC_SEL
''---------------------------------------------------------------------------------
'' CLKOFF_TPC_TX_CLOCK                        [12:12]          get_CLKOFF_TPC_TX_CLOCK
''                                                             set_CLKOFF_TPC_TX_CLOCK
''                                                             read_CLKOFF_TPC_TX_CLOCK
''                                                             write_CLKOFF_TPC_TX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC_RX_CLOCK                        [11:11]          get_CLKOFF_TPC_RX_CLOCK
''                                                             set_CLKOFF_TPC_RX_CLOCK
''                                                             read_CLKOFF_TPC_RX_CLOCK
''                                                             write_CLKOFF_TPC_RX_CLOCK
''---------------------------------------------------------------------------------
'' spare                                      [10:10]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' CLKOFF_CRC_CHECK_CLOCK                     [9:9]            get_CLKOFF_CRC_CHECK_CLOCK
''                                                             set_CLKOFF_CRC_CHECK_CLOCK
''                                                             read_CLKOFF_CRC_CHECK_CLOCK
''                                                             write_CLKOFF_CRC_CHECK_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_PATGEN_CLOCK                        [8:8]            get_CLKOFF_PATGEN_CLOCK
''                                                             set_CLKOFF_PATGEN_CLOCK
''                                                             read_CLKOFF_PATGEN_CLOCK
''                                                             write_CLKOFF_PATGEN_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_GPCS_TX_CLOCK                       [7:7]            get_CLKOFF_GPCS_TX_CLOCK
''                                                             set_CLKOFF_GPCS_TX_CLOCK
''                                                             read_CLKOFF_GPCS_TX_CLOCK
''                                                             write_CLKOFF_GPCS_TX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TX_CLOCK_125_25                     [6:6]            get_CLKOFF_TX_CLOCK_125_25
''                                                             set_CLKOFF_TX_CLOCK_125_25
''                                                             read_CLKOFF_TX_CLOCK_125_25
''                                                             write_CLKOFF_TX_CLOCK_125_25
''---------------------------------------------------------------------------------
'' CLKOFF_FECTX_TX_CLOCK                      [5:5]            get_CLKOFF_FECTX_TX_CLOCK
''                                                             set_CLKOFF_FECTX_TX_CLOCK
''                                                             read_CLKOFF_FECTX_TX_CLOCK
''                                                             write_CLKOFF_FECTX_TX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_PCS_TX_CLOCK                        [4:4]            get_CLKOFF_PCS_TX_CLOCK
''                                                             set_CLKOFF_PCS_TX_CLOCK
''                                                             read_CLKOFF_PCS_TX_CLOCK
''                                                             write_CLKOFF_PCS_TX_CLOCK
''---------------------------------------------------------------------------------
'' NOT_USED                                   [3:3]            get_NOT_USED
''                                                             set_NOT_USED
''                                                             read_NOT_USED
''                                                             write_NOT_USED
''---------------------------------------------------------------------------------
'' CLKOFF_SCR_TX_CLOCK                        [2:2]            get_CLKOFF_SCR_TX_CLOCK
''                                                             set_CLKOFF_SCR_TX_CLOCK
''                                                             read_CLKOFF_SCR_TX_CLOCK
''                                                             write_CLKOFF_SCR_TX_CLOCK
''---------------------------------------------------------------------------------
'' NOT_USED1                                  [1:1]            get_NOT_USED1
''                                                             set_NOT_USED1
''                                                             read_NOT_USED1
''                                                             write_NOT_USED1
''---------------------------------------------------------------------------------
'' CLKOFF_ACD_TX_CLOCK                        [0:0]            get_CLKOFF_ACD_TX_CLOCK
''                                                             set_CLKOFF_ACD_TX_CLOCK
''                                                             read_CLKOFF_ACD_TX_CLOCK
''                                                             write_CLKOFF_ACD_TX_CLOCK
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_tx_clock_override_enable
    Private write_RC_OSC_EN_OVERRIDE_ENABLE_value
    Private read_RC_OSC_EN_OVERRIDE_ENABLE_value
    Private flag_RC_OSC_EN_OVERRIDE_ENABLE
    Private write_RC_OSC_IN_OVERRIDE_ENABLE_value
    Private read_RC_OSC_IN_OVERRIDE_ENABLE_value
    Private flag_RC_OSC_IN_OVERRIDE_ENABLE
    Private write_RC_OSC_SEL_value
    Private read_RC_OSC_SEL_value
    Private flag_RC_OSC_SEL
    Private write_CLKOFF_TPC_TX_CLOCK_value
    Private read_CLKOFF_TPC_TX_CLOCK_value
    Private flag_CLKOFF_TPC_TX_CLOCK
    Private write_CLKOFF_TPC_RX_CLOCK_value
    Private read_CLKOFF_TPC_RX_CLOCK_value
    Private flag_CLKOFF_TPC_RX_CLOCK
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_CLKOFF_CRC_CHECK_CLOCK_value
    Private read_CLKOFF_CRC_CHECK_CLOCK_value
    Private flag_CLKOFF_CRC_CHECK_CLOCK
    Private write_CLKOFF_PATGEN_CLOCK_value
    Private read_CLKOFF_PATGEN_CLOCK_value
    Private flag_CLKOFF_PATGEN_CLOCK
    Private write_CLKOFF_GPCS_TX_CLOCK_value
    Private read_CLKOFF_GPCS_TX_CLOCK_value
    Private flag_CLKOFF_GPCS_TX_CLOCK
    Private write_CLKOFF_TX_CLOCK_125_25_value
    Private read_CLKOFF_TX_CLOCK_125_25_value
    Private flag_CLKOFF_TX_CLOCK_125_25
    Private write_CLKOFF_FECTX_TX_CLOCK_value
    Private read_CLKOFF_FECTX_TX_CLOCK_value
    Private flag_CLKOFF_FECTX_TX_CLOCK
    Private write_CLKOFF_PCS_TX_CLOCK_value
    Private read_CLKOFF_PCS_TX_CLOCK_value
    Private flag_CLKOFF_PCS_TX_CLOCK
    Private write_NOT_USED_value
    Private read_NOT_USED_value
    Private flag_NOT_USED
    Private write_CLKOFF_SCR_TX_CLOCK_value
    Private read_CLKOFF_SCR_TX_CLOCK_value
    Private flag_CLKOFF_SCR_TX_CLOCK
    Private write_NOT_USED1_value
    Private read_NOT_USED1_value
    Private flag_NOT_USED1
    Private write_CLKOFF_ACD_TX_CLOCK_value
    Private read_CLKOFF_ACD_TX_CLOCK_value
    Private flag_CLKOFF_ACD_TX_CLOCK

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

    Property Get get_RC_OSC_EN_OVERRIDE_ENABLE
        get_RC_OSC_EN_OVERRIDE_ENABLE = read_RC_OSC_EN_OVERRIDE_ENABLE_value
    End Property

    Property Let set_RC_OSC_EN_OVERRIDE_ENABLE(aData)
        write_RC_OSC_EN_OVERRIDE_ENABLE_value = aData
        flag_RC_OSC_EN_OVERRIDE_ENABLE        = &H1
    End Property

    Property Get read_RC_OSC_EN_OVERRIDE_ENABLE
        read
        read_RC_OSC_EN_OVERRIDE_ENABLE = read_RC_OSC_EN_OVERRIDE_ENABLE_value
    End Property

    Property Let write_RC_OSC_EN_OVERRIDE_ENABLE(aData)
        set_RC_OSC_EN_OVERRIDE_ENABLE = aData
        write
    End Property

    Property Get get_RC_OSC_IN_OVERRIDE_ENABLE
        get_RC_OSC_IN_OVERRIDE_ENABLE = read_RC_OSC_IN_OVERRIDE_ENABLE_value
    End Property

    Property Let set_RC_OSC_IN_OVERRIDE_ENABLE(aData)
        write_RC_OSC_IN_OVERRIDE_ENABLE_value = aData
        flag_RC_OSC_IN_OVERRIDE_ENABLE        = &H1
    End Property

    Property Get read_RC_OSC_IN_OVERRIDE_ENABLE
        read
        read_RC_OSC_IN_OVERRIDE_ENABLE = read_RC_OSC_IN_OVERRIDE_ENABLE_value
    End Property

    Property Let write_RC_OSC_IN_OVERRIDE_ENABLE(aData)
        set_RC_OSC_IN_OVERRIDE_ENABLE = aData
        write
    End Property

    Property Get get_RC_OSC_SEL
        get_RC_OSC_SEL = read_RC_OSC_SEL_value
    End Property

    Property Let set_RC_OSC_SEL(aData)
        write_RC_OSC_SEL_value = aData
        flag_RC_OSC_SEL        = &H1
    End Property

    Property Get read_RC_OSC_SEL
        read
        read_RC_OSC_SEL = read_RC_OSC_SEL_value
    End Property

    Property Let write_RC_OSC_SEL(aData)
        set_RC_OSC_SEL = aData
        write
    End Property

    Property Get get_CLKOFF_TPC_TX_CLOCK
        get_CLKOFF_TPC_TX_CLOCK = read_CLKOFF_TPC_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC_TX_CLOCK(aData)
        write_CLKOFF_TPC_TX_CLOCK_value = aData
        flag_CLKOFF_TPC_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC_TX_CLOCK
        read
        read_CLKOFF_TPC_TX_CLOCK = read_CLKOFF_TPC_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC_TX_CLOCK(aData)
        set_CLKOFF_TPC_TX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC_RX_CLOCK
        get_CLKOFF_TPC_RX_CLOCK = read_CLKOFF_TPC_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC_RX_CLOCK(aData)
        write_CLKOFF_TPC_RX_CLOCK_value = aData
        flag_CLKOFF_TPC_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC_RX_CLOCK
        read
        read_CLKOFF_TPC_RX_CLOCK = read_CLKOFF_TPC_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC_RX_CLOCK(aData)
        set_CLKOFF_TPC_RX_CLOCK = aData
        write
    End Property

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

    Property Get get_CLKOFF_CRC_CHECK_CLOCK
        get_CLKOFF_CRC_CHECK_CLOCK = read_CLKOFF_CRC_CHECK_CLOCK_value
    End Property

    Property Let set_CLKOFF_CRC_CHECK_CLOCK(aData)
        write_CLKOFF_CRC_CHECK_CLOCK_value = aData
        flag_CLKOFF_CRC_CHECK_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_CRC_CHECK_CLOCK
        read
        read_CLKOFF_CRC_CHECK_CLOCK = read_CLKOFF_CRC_CHECK_CLOCK_value
    End Property

    Property Let write_CLKOFF_CRC_CHECK_CLOCK(aData)
        set_CLKOFF_CRC_CHECK_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_PATGEN_CLOCK
        get_CLKOFF_PATGEN_CLOCK = read_CLKOFF_PATGEN_CLOCK_value
    End Property

    Property Let set_CLKOFF_PATGEN_CLOCK(aData)
        write_CLKOFF_PATGEN_CLOCK_value = aData
        flag_CLKOFF_PATGEN_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_PATGEN_CLOCK
        read
        read_CLKOFF_PATGEN_CLOCK = read_CLKOFF_PATGEN_CLOCK_value
    End Property

    Property Let write_CLKOFF_PATGEN_CLOCK(aData)
        set_CLKOFF_PATGEN_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_GPCS_TX_CLOCK
        get_CLKOFF_GPCS_TX_CLOCK = read_CLKOFF_GPCS_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_GPCS_TX_CLOCK(aData)
        write_CLKOFF_GPCS_TX_CLOCK_value = aData
        flag_CLKOFF_GPCS_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_GPCS_TX_CLOCK
        read
        read_CLKOFF_GPCS_TX_CLOCK = read_CLKOFF_GPCS_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_GPCS_TX_CLOCK(aData)
        set_CLKOFF_GPCS_TX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TX_CLOCK_125_25
        get_CLKOFF_TX_CLOCK_125_25 = read_CLKOFF_TX_CLOCK_125_25_value
    End Property

    Property Let set_CLKOFF_TX_CLOCK_125_25(aData)
        write_CLKOFF_TX_CLOCK_125_25_value = aData
        flag_CLKOFF_TX_CLOCK_125_25        = &H1
    End Property

    Property Get read_CLKOFF_TX_CLOCK_125_25
        read
        read_CLKOFF_TX_CLOCK_125_25 = read_CLKOFF_TX_CLOCK_125_25_value
    End Property

    Property Let write_CLKOFF_TX_CLOCK_125_25(aData)
        set_CLKOFF_TX_CLOCK_125_25 = aData
        write
    End Property

    Property Get get_CLKOFF_FECTX_TX_CLOCK
        get_CLKOFF_FECTX_TX_CLOCK = read_CLKOFF_FECTX_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_FECTX_TX_CLOCK(aData)
        write_CLKOFF_FECTX_TX_CLOCK_value = aData
        flag_CLKOFF_FECTX_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_FECTX_TX_CLOCK
        read
        read_CLKOFF_FECTX_TX_CLOCK = read_CLKOFF_FECTX_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_FECTX_TX_CLOCK(aData)
        set_CLKOFF_FECTX_TX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_PCS_TX_CLOCK
        get_CLKOFF_PCS_TX_CLOCK = read_CLKOFF_PCS_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_PCS_TX_CLOCK(aData)
        write_CLKOFF_PCS_TX_CLOCK_value = aData
        flag_CLKOFF_PCS_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_PCS_TX_CLOCK
        read
        read_CLKOFF_PCS_TX_CLOCK = read_CLKOFF_PCS_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_PCS_TX_CLOCK(aData)
        set_CLKOFF_PCS_TX_CLOCK = aData
        write
    End Property

    Property Get get_NOT_USED
        get_NOT_USED = read_NOT_USED_value
    End Property

    Property Let set_NOT_USED(aData)
        write_NOT_USED_value = aData
        flag_NOT_USED        = &H1
    End Property

    Property Get read_NOT_USED
        read
        read_NOT_USED = read_NOT_USED_value
    End Property

    Property Let write_NOT_USED(aData)
        set_NOT_USED = aData
        write
    End Property

    Property Get get_CLKOFF_SCR_TX_CLOCK
        get_CLKOFF_SCR_TX_CLOCK = read_CLKOFF_SCR_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_SCR_TX_CLOCK(aData)
        write_CLKOFF_SCR_TX_CLOCK_value = aData
        flag_CLKOFF_SCR_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_SCR_TX_CLOCK
        read
        read_CLKOFF_SCR_TX_CLOCK = read_CLKOFF_SCR_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_SCR_TX_CLOCK(aData)
        set_CLKOFF_SCR_TX_CLOCK = aData
        write
    End Property

    Property Get get_NOT_USED1
        get_NOT_USED1 = read_NOT_USED1_value
    End Property

    Property Let set_NOT_USED1(aData)
        write_NOT_USED1_value = aData
        flag_NOT_USED1        = &H1
    End Property

    Property Get read_NOT_USED1
        read
        read_NOT_USED1 = read_NOT_USED1_value
    End Property

    Property Let write_NOT_USED1(aData)
        set_NOT_USED1 = aData
        write
    End Property

    Property Get get_CLKOFF_ACD_TX_CLOCK
        get_CLKOFF_ACD_TX_CLOCK = read_CLKOFF_ACD_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_ACD_TX_CLOCK(aData)
        write_CLKOFF_ACD_TX_CLOCK_value = aData
        flag_CLKOFF_ACD_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_ACD_TX_CLOCK
        read
        read_CLKOFF_ACD_TX_CLOCK = read_CLKOFF_ACD_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_ACD_TX_CLOCK(aData)
        set_CLKOFF_ACD_TX_CLOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OSC_EN_OVERRIDE_ENABLE_value = rightShift(data_low, 15) and &H1
        read_RC_OSC_IN_OVERRIDE_ENABLE_value = rightShift(data_low, 14) and &H1
        read_RC_OSC_SEL_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_TPC_TX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_TPC_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_spare_value = rightShift(data_low, 10) and &H1
        read_CLKOFF_CRC_CHECK_CLOCK_value = rightShift(data_low, 9) and &H1
        read_CLKOFF_PATGEN_CLOCK_value = rightShift(data_low, 8) and &H1
        read_CLKOFF_GPCS_TX_CLOCK_value = rightShift(data_low, 7) and &H1
        read_CLKOFF_TX_CLOCK_125_25_value = rightShift(data_low, 6) and &H1
        read_CLKOFF_FECTX_TX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_PCS_TX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_NOT_USED_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_SCR_TX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_NOT_USED1_value = rightShift(data_low, 1) and &H1
        CLKOFF_ACD_TX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_ACD_TX_CLOCK_mask = mask then
                read_CLKOFF_ACD_TX_CLOCK_value = data_low
            else
                read_CLKOFF_ACD_TX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_ACD_TX_CLOCK_mask
            end If
        else
            read_CLKOFF_ACD_TX_CLOCK_value = data_low and CLKOFF_ACD_TX_CLOCK_mask
        end If

    End Sub

    Sub write
        If flag_RC_OSC_EN_OVERRIDE_ENABLE = &H0 or flag_RC_OSC_IN_OVERRIDE_ENABLE = &H0 or flag_RC_OSC_SEL = &H0 or flag_CLKOFF_TPC_TX_CLOCK = &H0 or flag_CLKOFF_TPC_RX_CLOCK = &H0 or flag_spare = &H0 or flag_CLKOFF_CRC_CHECK_CLOCK = &H0 or flag_CLKOFF_PATGEN_CLOCK = &H0 or flag_CLKOFF_GPCS_TX_CLOCK = &H0 or flag_CLKOFF_TX_CLOCK_125_25 = &H0 or flag_CLKOFF_FECTX_TX_CLOCK = &H0 or flag_CLKOFF_PCS_TX_CLOCK = &H0 or flag_NOT_USED = &H0 or flag_CLKOFF_SCR_TX_CLOCK = &H0 or flag_NOT_USED1 = &H0 or flag_CLKOFF_ACD_TX_CLOCK = &H0 Then read
        If flag_RC_OSC_EN_OVERRIDE_ENABLE = &H0 Then write_RC_OSC_EN_OVERRIDE_ENABLE_value = get_RC_OSC_EN_OVERRIDE_ENABLE
        If flag_RC_OSC_IN_OVERRIDE_ENABLE = &H0 Then write_RC_OSC_IN_OVERRIDE_ENABLE_value = get_RC_OSC_IN_OVERRIDE_ENABLE
        If flag_RC_OSC_SEL = &H0 Then write_RC_OSC_SEL_value = get_RC_OSC_SEL
        If flag_CLKOFF_TPC_TX_CLOCK = &H0 Then write_CLKOFF_TPC_TX_CLOCK_value = get_CLKOFF_TPC_TX_CLOCK
        If flag_CLKOFF_TPC_RX_CLOCK = &H0 Then write_CLKOFF_TPC_RX_CLOCK_value = get_CLKOFF_TPC_RX_CLOCK
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_CLKOFF_CRC_CHECK_CLOCK = &H0 Then write_CLKOFF_CRC_CHECK_CLOCK_value = get_CLKOFF_CRC_CHECK_CLOCK
        If flag_CLKOFF_PATGEN_CLOCK = &H0 Then write_CLKOFF_PATGEN_CLOCK_value = get_CLKOFF_PATGEN_CLOCK
        If flag_CLKOFF_GPCS_TX_CLOCK = &H0 Then write_CLKOFF_GPCS_TX_CLOCK_value = get_CLKOFF_GPCS_TX_CLOCK
        If flag_CLKOFF_TX_CLOCK_125_25 = &H0 Then write_CLKOFF_TX_CLOCK_125_25_value = get_CLKOFF_TX_CLOCK_125_25
        If flag_CLKOFF_FECTX_TX_CLOCK = &H0 Then write_CLKOFF_FECTX_TX_CLOCK_value = get_CLKOFF_FECTX_TX_CLOCK
        If flag_CLKOFF_PCS_TX_CLOCK = &H0 Then write_CLKOFF_PCS_TX_CLOCK_value = get_CLKOFF_PCS_TX_CLOCK
        If flag_NOT_USED = &H0 Then write_NOT_USED_value = get_NOT_USED
        If flag_CLKOFF_SCR_TX_CLOCK = &H0 Then write_CLKOFF_SCR_TX_CLOCK_value = get_CLKOFF_SCR_TX_CLOCK
        If flag_NOT_USED1 = &H0 Then write_NOT_USED1_value = get_NOT_USED1
        If flag_CLKOFF_ACD_TX_CLOCK = &H0 Then write_CLKOFF_ACD_TX_CLOCK_value = get_CLKOFF_ACD_TX_CLOCK

        regValue = leftShift((write_RC_OSC_EN_OVERRIDE_ENABLE_value and &H1), 15) + leftShift((write_RC_OSC_IN_OVERRIDE_ENABLE_value and &H1), 14) + leftShift((write_RC_OSC_SEL_value and &H1), 13) + leftShift((write_CLKOFF_TPC_TX_CLOCK_value and &H1), 12) + leftShift((write_CLKOFF_TPC_RX_CLOCK_value and &H1), 11) + leftShift((write_spare_value and &H1), 10) + leftShift((write_CLKOFF_CRC_CHECK_CLOCK_value and &H1), 9) + leftShift((write_CLKOFF_PATGEN_CLOCK_value and &H1), 8) + leftShift((write_CLKOFF_GPCS_TX_CLOCK_value and &H1), 7) + leftShift((write_CLKOFF_TX_CLOCK_125_25_value and &H1), 6) + leftShift((write_CLKOFF_FECTX_TX_CLOCK_value and &H1), 5) + leftShift((write_CLKOFF_PCS_TX_CLOCK_value and &H1), 4) + leftShift((write_NOT_USED_value and &H1), 3) + leftShift((write_CLKOFF_SCR_TX_CLOCK_value and &H1), 2) + leftShift((write_NOT_USED1_value and &H1), 1) + leftShift((write_CLKOFF_ACD_TX_CLOCK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OSC_EN_OVERRIDE_ENABLE_value = rightShift(data_low, 15) and &H1
        read_RC_OSC_IN_OVERRIDE_ENABLE_value = rightShift(data_low, 14) and &H1
        read_RC_OSC_SEL_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_TPC_TX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_TPC_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_spare_value = rightShift(data_low, 10) and &H1
        read_CLKOFF_CRC_CHECK_CLOCK_value = rightShift(data_low, 9) and &H1
        read_CLKOFF_PATGEN_CLOCK_value = rightShift(data_low, 8) and &H1
        read_CLKOFF_GPCS_TX_CLOCK_value = rightShift(data_low, 7) and &H1
        read_CLKOFF_TX_CLOCK_125_25_value = rightShift(data_low, 6) and &H1
        read_CLKOFF_FECTX_TX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_PCS_TX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_NOT_USED_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_SCR_TX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_NOT_USED1_value = rightShift(data_low, 1) and &H1
        CLKOFF_ACD_TX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_ACD_TX_CLOCK_mask = mask then
                read_CLKOFF_ACD_TX_CLOCK_value = data_low
            else
                read_CLKOFF_ACD_TX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_ACD_TX_CLOCK_mask
            end If
        else
            read_CLKOFF_ACD_TX_CLOCK_value = data_low and CLKOFF_ACD_TX_CLOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RC_OSC_EN_OVERRIDE_ENABLE_value = &H0
        flag_RC_OSC_EN_OVERRIDE_ENABLE        = &H0
        write_RC_OSC_IN_OVERRIDE_ENABLE_value = &H0
        flag_RC_OSC_IN_OVERRIDE_ENABLE        = &H0
        write_RC_OSC_SEL_value = &H0
        flag_RC_OSC_SEL        = &H0
        write_CLKOFF_TPC_TX_CLOCK_value = &H0
        flag_CLKOFF_TPC_TX_CLOCK        = &H0
        write_CLKOFF_TPC_RX_CLOCK_value = &H0
        flag_CLKOFF_TPC_RX_CLOCK        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
        write_CLKOFF_CRC_CHECK_CLOCK_value = &H0
        flag_CLKOFF_CRC_CHECK_CLOCK        = &H0
        write_CLKOFF_PATGEN_CLOCK_value = &H0
        flag_CLKOFF_PATGEN_CLOCK        = &H0
        write_CLKOFF_GPCS_TX_CLOCK_value = &H0
        flag_CLKOFF_GPCS_TX_CLOCK        = &H0
        write_CLKOFF_TX_CLOCK_125_25_value = &H0
        flag_CLKOFF_TX_CLOCK_125_25        = &H0
        write_CLKOFF_FECTX_TX_CLOCK_value = &H0
        flag_CLKOFF_FECTX_TX_CLOCK        = &H0
        write_CLKOFF_PCS_TX_CLOCK_value = &H0
        flag_CLKOFF_PCS_TX_CLOCK        = &H0
        write_NOT_USED_value = &H0
        flag_NOT_USED        = &H0
        write_CLKOFF_SCR_TX_CLOCK_value = &H0
        flag_CLKOFF_SCR_TX_CLOCK        = &H0
        write_NOT_USED1_value = &H0
        flag_NOT_USED1        = &H0
        write_CLKOFF_ACD_TX_CLOCK_value = &H0
        flag_CLKOFF_ACD_TX_CLOCK        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_tx_clock_override_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RC_OSC_EN_OVERRIDE_VALUE                   [15:15]          get_RC_OSC_EN_OVERRIDE_VALUE
''                                                             set_RC_OSC_EN_OVERRIDE_VALUE
''                                                             read_RC_OSC_EN_OVERRIDE_VALUE
''                                                             write_RC_OSC_EN_OVERRIDE_VALUE
''---------------------------------------------------------------------------------
'' RC_OSC_IN_OVERRIDE_VALUE                   [14:14]          get_RC_OSC_IN_OVERRIDE_VALUE
''                                                             set_RC_OSC_IN_OVERRIDE_VALUE
''                                                             read_RC_OSC_IN_OVERRIDE_VALUE
''                                                             write_RC_OSC_IN_OVERRIDE_VALUE
''---------------------------------------------------------------------------------
'' DISABLE_DSP_RDB_CLOCK                      [13:13]          get_DISABLE_DSP_RDB_CLOCK
''                                                             set_DISABLE_DSP_RDB_CLOCK
''                                                             read_DISABLE_DSP_RDB_CLOCK
''                                                             write_DISABLE_DSP_RDB_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC_TX_CLOCK                        [12:12]          get_CLKOFF_TPC_TX_CLOCK
''                                                             set_CLKOFF_TPC_TX_CLOCK
''                                                             read_CLKOFF_TPC_TX_CLOCK
''                                                             write_CLKOFF_TPC_TX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TPC_RX_CLOCK                        [11:11]          get_CLKOFF_TPC_RX_CLOCK
''                                                             set_CLKOFF_TPC_RX_CLOCK
''                                                             read_CLKOFF_TPC_RX_CLOCK
''                                                             write_CLKOFF_TPC_RX_CLOCK
''---------------------------------------------------------------------------------
'' spare                                      [10:10]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' CLKOFF_CRC_CHECK_CLOCK                     [9:9]            get_CLKOFF_CRC_CHECK_CLOCK
''                                                             set_CLKOFF_CRC_CHECK_CLOCK
''                                                             read_CLKOFF_CRC_CHECK_CLOCK
''                                                             write_CLKOFF_CRC_CHECK_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_PATGEN_CLOCK                        [8:8]            get_CLKOFF_PATGEN_CLOCK
''                                                             set_CLKOFF_PATGEN_CLOCK
''                                                             read_CLKOFF_PATGEN_CLOCK
''                                                             write_CLKOFF_PATGEN_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_GPCS_TX_CLOCK                       [7:7]            get_CLKOFF_GPCS_TX_CLOCK
''                                                             set_CLKOFF_GPCS_TX_CLOCK
''                                                             read_CLKOFF_GPCS_TX_CLOCK
''                                                             write_CLKOFF_GPCS_TX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_TX_CLOCK_125_25                     [6:6]            get_CLKOFF_TX_CLOCK_125_25
''                                                             set_CLKOFF_TX_CLOCK_125_25
''                                                             read_CLKOFF_TX_CLOCK_125_25
''                                                             write_CLKOFF_TX_CLOCK_125_25
''---------------------------------------------------------------------------------
'' CLKOFF_FECTX_TX_CLOCK                      [5:5]            get_CLKOFF_FECTX_TX_CLOCK
''                                                             set_CLKOFF_FECTX_TX_CLOCK
''                                                             read_CLKOFF_FECTX_TX_CLOCK
''                                                             write_CLKOFF_FECTX_TX_CLOCK
''---------------------------------------------------------------------------------
'' CLKOFF_PCS_TX_CLOCK                        [4:4]            get_CLKOFF_PCS_TX_CLOCK
''                                                             set_CLKOFF_PCS_TX_CLOCK
''                                                             read_CLKOFF_PCS_TX_CLOCK
''                                                             write_CLKOFF_PCS_TX_CLOCK
''---------------------------------------------------------------------------------
'' NOT_USED                                   [3:3]            get_NOT_USED
''                                                             set_NOT_USED
''                                                             read_NOT_USED
''                                                             write_NOT_USED
''---------------------------------------------------------------------------------
'' CLKOFF_SCR_TX_CLOCK                        [2:2]            get_CLKOFF_SCR_TX_CLOCK
''                                                             set_CLKOFF_SCR_TX_CLOCK
''                                                             read_CLKOFF_SCR_TX_CLOCK
''                                                             write_CLKOFF_SCR_TX_CLOCK
''---------------------------------------------------------------------------------
'' NOT_USED1                                  [1:1]            get_NOT_USED1
''                                                             set_NOT_USED1
''                                                             read_NOT_USED1
''                                                             write_NOT_USED1
''---------------------------------------------------------------------------------
'' CLKOFF_ACD_TX_CLOCK                        [0:0]            get_CLKOFF_ACD_TX_CLOCK
''                                                             set_CLKOFF_ACD_TX_CLOCK
''                                                             read_CLKOFF_ACD_TX_CLOCK
''                                                             write_CLKOFF_ACD_TX_CLOCK
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_tx_clock_override_value
    Private write_RC_OSC_EN_OVERRIDE_VALUE_value
    Private read_RC_OSC_EN_OVERRIDE_VALUE_value
    Private flag_RC_OSC_EN_OVERRIDE_VALUE
    Private write_RC_OSC_IN_OVERRIDE_VALUE_value
    Private read_RC_OSC_IN_OVERRIDE_VALUE_value
    Private flag_RC_OSC_IN_OVERRIDE_VALUE
    Private write_DISABLE_DSP_RDB_CLOCK_value
    Private read_DISABLE_DSP_RDB_CLOCK_value
    Private flag_DISABLE_DSP_RDB_CLOCK
    Private write_CLKOFF_TPC_TX_CLOCK_value
    Private read_CLKOFF_TPC_TX_CLOCK_value
    Private flag_CLKOFF_TPC_TX_CLOCK
    Private write_CLKOFF_TPC_RX_CLOCK_value
    Private read_CLKOFF_TPC_RX_CLOCK_value
    Private flag_CLKOFF_TPC_RX_CLOCK
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_CLKOFF_CRC_CHECK_CLOCK_value
    Private read_CLKOFF_CRC_CHECK_CLOCK_value
    Private flag_CLKOFF_CRC_CHECK_CLOCK
    Private write_CLKOFF_PATGEN_CLOCK_value
    Private read_CLKOFF_PATGEN_CLOCK_value
    Private flag_CLKOFF_PATGEN_CLOCK
    Private write_CLKOFF_GPCS_TX_CLOCK_value
    Private read_CLKOFF_GPCS_TX_CLOCK_value
    Private flag_CLKOFF_GPCS_TX_CLOCK
    Private write_CLKOFF_TX_CLOCK_125_25_value
    Private read_CLKOFF_TX_CLOCK_125_25_value
    Private flag_CLKOFF_TX_CLOCK_125_25
    Private write_CLKOFF_FECTX_TX_CLOCK_value
    Private read_CLKOFF_FECTX_TX_CLOCK_value
    Private flag_CLKOFF_FECTX_TX_CLOCK
    Private write_CLKOFF_PCS_TX_CLOCK_value
    Private read_CLKOFF_PCS_TX_CLOCK_value
    Private flag_CLKOFF_PCS_TX_CLOCK
    Private write_NOT_USED_value
    Private read_NOT_USED_value
    Private flag_NOT_USED
    Private write_CLKOFF_SCR_TX_CLOCK_value
    Private read_CLKOFF_SCR_TX_CLOCK_value
    Private flag_CLKOFF_SCR_TX_CLOCK
    Private write_NOT_USED1_value
    Private read_NOT_USED1_value
    Private flag_NOT_USED1
    Private write_CLKOFF_ACD_TX_CLOCK_value
    Private read_CLKOFF_ACD_TX_CLOCK_value
    Private flag_CLKOFF_ACD_TX_CLOCK

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

    Property Get get_RC_OSC_EN_OVERRIDE_VALUE
        get_RC_OSC_EN_OVERRIDE_VALUE = read_RC_OSC_EN_OVERRIDE_VALUE_value
    End Property

    Property Let set_RC_OSC_EN_OVERRIDE_VALUE(aData)
        write_RC_OSC_EN_OVERRIDE_VALUE_value = aData
        flag_RC_OSC_EN_OVERRIDE_VALUE        = &H1
    End Property

    Property Get read_RC_OSC_EN_OVERRIDE_VALUE
        read
        read_RC_OSC_EN_OVERRIDE_VALUE = read_RC_OSC_EN_OVERRIDE_VALUE_value
    End Property

    Property Let write_RC_OSC_EN_OVERRIDE_VALUE(aData)
        set_RC_OSC_EN_OVERRIDE_VALUE = aData
        write
    End Property

    Property Get get_RC_OSC_IN_OVERRIDE_VALUE
        get_RC_OSC_IN_OVERRIDE_VALUE = read_RC_OSC_IN_OVERRIDE_VALUE_value
    End Property

    Property Let set_RC_OSC_IN_OVERRIDE_VALUE(aData)
        write_RC_OSC_IN_OVERRIDE_VALUE_value = aData
        flag_RC_OSC_IN_OVERRIDE_VALUE        = &H1
    End Property

    Property Get read_RC_OSC_IN_OVERRIDE_VALUE
        read
        read_RC_OSC_IN_OVERRIDE_VALUE = read_RC_OSC_IN_OVERRIDE_VALUE_value
    End Property

    Property Let write_RC_OSC_IN_OVERRIDE_VALUE(aData)
        set_RC_OSC_IN_OVERRIDE_VALUE = aData
        write
    End Property

    Property Get get_DISABLE_DSP_RDB_CLOCK
        get_DISABLE_DSP_RDB_CLOCK = read_DISABLE_DSP_RDB_CLOCK_value
    End Property

    Property Let set_DISABLE_DSP_RDB_CLOCK(aData)
        write_DISABLE_DSP_RDB_CLOCK_value = aData
        flag_DISABLE_DSP_RDB_CLOCK        = &H1
    End Property

    Property Get read_DISABLE_DSP_RDB_CLOCK
        read
        read_DISABLE_DSP_RDB_CLOCK = read_DISABLE_DSP_RDB_CLOCK_value
    End Property

    Property Let write_DISABLE_DSP_RDB_CLOCK(aData)
        set_DISABLE_DSP_RDB_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC_TX_CLOCK
        get_CLKOFF_TPC_TX_CLOCK = read_CLKOFF_TPC_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC_TX_CLOCK(aData)
        write_CLKOFF_TPC_TX_CLOCK_value = aData
        flag_CLKOFF_TPC_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC_TX_CLOCK
        read
        read_CLKOFF_TPC_TX_CLOCK = read_CLKOFF_TPC_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC_TX_CLOCK(aData)
        set_CLKOFF_TPC_TX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TPC_RX_CLOCK
        get_CLKOFF_TPC_RX_CLOCK = read_CLKOFF_TPC_RX_CLOCK_value
    End Property

    Property Let set_CLKOFF_TPC_RX_CLOCK(aData)
        write_CLKOFF_TPC_RX_CLOCK_value = aData
        flag_CLKOFF_TPC_RX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_TPC_RX_CLOCK
        read
        read_CLKOFF_TPC_RX_CLOCK = read_CLKOFF_TPC_RX_CLOCK_value
    End Property

    Property Let write_CLKOFF_TPC_RX_CLOCK(aData)
        set_CLKOFF_TPC_RX_CLOCK = aData
        write
    End Property

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

    Property Get get_CLKOFF_CRC_CHECK_CLOCK
        get_CLKOFF_CRC_CHECK_CLOCK = read_CLKOFF_CRC_CHECK_CLOCK_value
    End Property

    Property Let set_CLKOFF_CRC_CHECK_CLOCK(aData)
        write_CLKOFF_CRC_CHECK_CLOCK_value = aData
        flag_CLKOFF_CRC_CHECK_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_CRC_CHECK_CLOCK
        read
        read_CLKOFF_CRC_CHECK_CLOCK = read_CLKOFF_CRC_CHECK_CLOCK_value
    End Property

    Property Let write_CLKOFF_CRC_CHECK_CLOCK(aData)
        set_CLKOFF_CRC_CHECK_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_PATGEN_CLOCK
        get_CLKOFF_PATGEN_CLOCK = read_CLKOFF_PATGEN_CLOCK_value
    End Property

    Property Let set_CLKOFF_PATGEN_CLOCK(aData)
        write_CLKOFF_PATGEN_CLOCK_value = aData
        flag_CLKOFF_PATGEN_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_PATGEN_CLOCK
        read
        read_CLKOFF_PATGEN_CLOCK = read_CLKOFF_PATGEN_CLOCK_value
    End Property

    Property Let write_CLKOFF_PATGEN_CLOCK(aData)
        set_CLKOFF_PATGEN_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_GPCS_TX_CLOCK
        get_CLKOFF_GPCS_TX_CLOCK = read_CLKOFF_GPCS_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_GPCS_TX_CLOCK(aData)
        write_CLKOFF_GPCS_TX_CLOCK_value = aData
        flag_CLKOFF_GPCS_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_GPCS_TX_CLOCK
        read
        read_CLKOFF_GPCS_TX_CLOCK = read_CLKOFF_GPCS_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_GPCS_TX_CLOCK(aData)
        set_CLKOFF_GPCS_TX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_TX_CLOCK_125_25
        get_CLKOFF_TX_CLOCK_125_25 = read_CLKOFF_TX_CLOCK_125_25_value
    End Property

    Property Let set_CLKOFF_TX_CLOCK_125_25(aData)
        write_CLKOFF_TX_CLOCK_125_25_value = aData
        flag_CLKOFF_TX_CLOCK_125_25        = &H1
    End Property

    Property Get read_CLKOFF_TX_CLOCK_125_25
        read
        read_CLKOFF_TX_CLOCK_125_25 = read_CLKOFF_TX_CLOCK_125_25_value
    End Property

    Property Let write_CLKOFF_TX_CLOCK_125_25(aData)
        set_CLKOFF_TX_CLOCK_125_25 = aData
        write
    End Property

    Property Get get_CLKOFF_FECTX_TX_CLOCK
        get_CLKOFF_FECTX_TX_CLOCK = read_CLKOFF_FECTX_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_FECTX_TX_CLOCK(aData)
        write_CLKOFF_FECTX_TX_CLOCK_value = aData
        flag_CLKOFF_FECTX_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_FECTX_TX_CLOCK
        read
        read_CLKOFF_FECTX_TX_CLOCK = read_CLKOFF_FECTX_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_FECTX_TX_CLOCK(aData)
        set_CLKOFF_FECTX_TX_CLOCK = aData
        write
    End Property

    Property Get get_CLKOFF_PCS_TX_CLOCK
        get_CLKOFF_PCS_TX_CLOCK = read_CLKOFF_PCS_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_PCS_TX_CLOCK(aData)
        write_CLKOFF_PCS_TX_CLOCK_value = aData
        flag_CLKOFF_PCS_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_PCS_TX_CLOCK
        read
        read_CLKOFF_PCS_TX_CLOCK = read_CLKOFF_PCS_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_PCS_TX_CLOCK(aData)
        set_CLKOFF_PCS_TX_CLOCK = aData
        write
    End Property

    Property Get get_NOT_USED
        get_NOT_USED = read_NOT_USED_value
    End Property

    Property Let set_NOT_USED(aData)
        write_NOT_USED_value = aData
        flag_NOT_USED        = &H1
    End Property

    Property Get read_NOT_USED
        read
        read_NOT_USED = read_NOT_USED_value
    End Property

    Property Let write_NOT_USED(aData)
        set_NOT_USED = aData
        write
    End Property

    Property Get get_CLKOFF_SCR_TX_CLOCK
        get_CLKOFF_SCR_TX_CLOCK = read_CLKOFF_SCR_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_SCR_TX_CLOCK(aData)
        write_CLKOFF_SCR_TX_CLOCK_value = aData
        flag_CLKOFF_SCR_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_SCR_TX_CLOCK
        read
        read_CLKOFF_SCR_TX_CLOCK = read_CLKOFF_SCR_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_SCR_TX_CLOCK(aData)
        set_CLKOFF_SCR_TX_CLOCK = aData
        write
    End Property

    Property Get get_NOT_USED1
        get_NOT_USED1 = read_NOT_USED1_value
    End Property

    Property Let set_NOT_USED1(aData)
        write_NOT_USED1_value = aData
        flag_NOT_USED1        = &H1
    End Property

    Property Get read_NOT_USED1
        read
        read_NOT_USED1 = read_NOT_USED1_value
    End Property

    Property Let write_NOT_USED1(aData)
        set_NOT_USED1 = aData
        write
    End Property

    Property Get get_CLKOFF_ACD_TX_CLOCK
        get_CLKOFF_ACD_TX_CLOCK = read_CLKOFF_ACD_TX_CLOCK_value
    End Property

    Property Let set_CLKOFF_ACD_TX_CLOCK(aData)
        write_CLKOFF_ACD_TX_CLOCK_value = aData
        flag_CLKOFF_ACD_TX_CLOCK        = &H1
    End Property

    Property Get read_CLKOFF_ACD_TX_CLOCK
        read
        read_CLKOFF_ACD_TX_CLOCK = read_CLKOFF_ACD_TX_CLOCK_value
    End Property

    Property Let write_CLKOFF_ACD_TX_CLOCK(aData)
        set_CLKOFF_ACD_TX_CLOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OSC_EN_OVERRIDE_VALUE_value = rightShift(data_low, 15) and &H1
        read_RC_OSC_IN_OVERRIDE_VALUE_value = rightShift(data_low, 14) and &H1
        read_DISABLE_DSP_RDB_CLOCK_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_TPC_TX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_TPC_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_spare_value = rightShift(data_low, 10) and &H1
        read_CLKOFF_CRC_CHECK_CLOCK_value = rightShift(data_low, 9) and &H1
        read_CLKOFF_PATGEN_CLOCK_value = rightShift(data_low, 8) and &H1
        read_CLKOFF_GPCS_TX_CLOCK_value = rightShift(data_low, 7) and &H1
        read_CLKOFF_TX_CLOCK_125_25_value = rightShift(data_low, 6) and &H1
        read_CLKOFF_FECTX_TX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_PCS_TX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_NOT_USED_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_SCR_TX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_NOT_USED1_value = rightShift(data_low, 1) and &H1
        CLKOFF_ACD_TX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_ACD_TX_CLOCK_mask = mask then
                read_CLKOFF_ACD_TX_CLOCK_value = data_low
            else
                read_CLKOFF_ACD_TX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_ACD_TX_CLOCK_mask
            end If
        else
            read_CLKOFF_ACD_TX_CLOCK_value = data_low and CLKOFF_ACD_TX_CLOCK_mask
        end If

    End Sub

    Sub write
        If flag_RC_OSC_EN_OVERRIDE_VALUE = &H0 or flag_RC_OSC_IN_OVERRIDE_VALUE = &H0 or flag_DISABLE_DSP_RDB_CLOCK = &H0 or flag_CLKOFF_TPC_TX_CLOCK = &H0 or flag_CLKOFF_TPC_RX_CLOCK = &H0 or flag_spare = &H0 or flag_CLKOFF_CRC_CHECK_CLOCK = &H0 or flag_CLKOFF_PATGEN_CLOCK = &H0 or flag_CLKOFF_GPCS_TX_CLOCK = &H0 or flag_CLKOFF_TX_CLOCK_125_25 = &H0 or flag_CLKOFF_FECTX_TX_CLOCK = &H0 or flag_CLKOFF_PCS_TX_CLOCK = &H0 or flag_NOT_USED = &H0 or flag_CLKOFF_SCR_TX_CLOCK = &H0 or flag_NOT_USED1 = &H0 or flag_CLKOFF_ACD_TX_CLOCK = &H0 Then read
        If flag_RC_OSC_EN_OVERRIDE_VALUE = &H0 Then write_RC_OSC_EN_OVERRIDE_VALUE_value = get_RC_OSC_EN_OVERRIDE_VALUE
        If flag_RC_OSC_IN_OVERRIDE_VALUE = &H0 Then write_RC_OSC_IN_OVERRIDE_VALUE_value = get_RC_OSC_IN_OVERRIDE_VALUE
        If flag_DISABLE_DSP_RDB_CLOCK = &H0 Then write_DISABLE_DSP_RDB_CLOCK_value = get_DISABLE_DSP_RDB_CLOCK
        If flag_CLKOFF_TPC_TX_CLOCK = &H0 Then write_CLKOFF_TPC_TX_CLOCK_value = get_CLKOFF_TPC_TX_CLOCK
        If flag_CLKOFF_TPC_RX_CLOCK = &H0 Then write_CLKOFF_TPC_RX_CLOCK_value = get_CLKOFF_TPC_RX_CLOCK
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_CLKOFF_CRC_CHECK_CLOCK = &H0 Then write_CLKOFF_CRC_CHECK_CLOCK_value = get_CLKOFF_CRC_CHECK_CLOCK
        If flag_CLKOFF_PATGEN_CLOCK = &H0 Then write_CLKOFF_PATGEN_CLOCK_value = get_CLKOFF_PATGEN_CLOCK
        If flag_CLKOFF_GPCS_TX_CLOCK = &H0 Then write_CLKOFF_GPCS_TX_CLOCK_value = get_CLKOFF_GPCS_TX_CLOCK
        If flag_CLKOFF_TX_CLOCK_125_25 = &H0 Then write_CLKOFF_TX_CLOCK_125_25_value = get_CLKOFF_TX_CLOCK_125_25
        If flag_CLKOFF_FECTX_TX_CLOCK = &H0 Then write_CLKOFF_FECTX_TX_CLOCK_value = get_CLKOFF_FECTX_TX_CLOCK
        If flag_CLKOFF_PCS_TX_CLOCK = &H0 Then write_CLKOFF_PCS_TX_CLOCK_value = get_CLKOFF_PCS_TX_CLOCK
        If flag_NOT_USED = &H0 Then write_NOT_USED_value = get_NOT_USED
        If flag_CLKOFF_SCR_TX_CLOCK = &H0 Then write_CLKOFF_SCR_TX_CLOCK_value = get_CLKOFF_SCR_TX_CLOCK
        If flag_NOT_USED1 = &H0 Then write_NOT_USED1_value = get_NOT_USED1
        If flag_CLKOFF_ACD_TX_CLOCK = &H0 Then write_CLKOFF_ACD_TX_CLOCK_value = get_CLKOFF_ACD_TX_CLOCK

        regValue = leftShift((write_RC_OSC_EN_OVERRIDE_VALUE_value and &H1), 15) + leftShift((write_RC_OSC_IN_OVERRIDE_VALUE_value and &H1), 14) + leftShift((write_DISABLE_DSP_RDB_CLOCK_value and &H1), 13) + leftShift((write_CLKOFF_TPC_TX_CLOCK_value and &H1), 12) + leftShift((write_CLKOFF_TPC_RX_CLOCK_value and &H1), 11) + leftShift((write_spare_value and &H1), 10) + leftShift((write_CLKOFF_CRC_CHECK_CLOCK_value and &H1), 9) + leftShift((write_CLKOFF_PATGEN_CLOCK_value and &H1), 8) + leftShift((write_CLKOFF_GPCS_TX_CLOCK_value and &H1), 7) + leftShift((write_CLKOFF_TX_CLOCK_125_25_value and &H1), 6) + leftShift((write_CLKOFF_FECTX_TX_CLOCK_value and &H1), 5) + leftShift((write_CLKOFF_PCS_TX_CLOCK_value and &H1), 4) + leftShift((write_NOT_USED_value and &H1), 3) + leftShift((write_CLKOFF_SCR_TX_CLOCK_value and &H1), 2) + leftShift((write_NOT_USED1_value and &H1), 1) + leftShift((write_CLKOFF_ACD_TX_CLOCK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OSC_EN_OVERRIDE_VALUE_value = rightShift(data_low, 15) and &H1
        read_RC_OSC_IN_OVERRIDE_VALUE_value = rightShift(data_low, 14) and &H1
        read_DISABLE_DSP_RDB_CLOCK_value = rightShift(data_low, 13) and &H1
        read_CLKOFF_TPC_TX_CLOCK_value = rightShift(data_low, 12) and &H1
        read_CLKOFF_TPC_RX_CLOCK_value = rightShift(data_low, 11) and &H1
        read_spare_value = rightShift(data_low, 10) and &H1
        read_CLKOFF_CRC_CHECK_CLOCK_value = rightShift(data_low, 9) and &H1
        read_CLKOFF_PATGEN_CLOCK_value = rightShift(data_low, 8) and &H1
        read_CLKOFF_GPCS_TX_CLOCK_value = rightShift(data_low, 7) and &H1
        read_CLKOFF_TX_CLOCK_125_25_value = rightShift(data_low, 6) and &H1
        read_CLKOFF_FECTX_TX_CLOCK_value = rightShift(data_low, 5) and &H1
        read_CLKOFF_PCS_TX_CLOCK_value = rightShift(data_low, 4) and &H1
        read_NOT_USED_value = rightShift(data_low, 3) and &H1
        read_CLKOFF_SCR_TX_CLOCK_value = rightShift(data_low, 2) and &H1
        read_NOT_USED1_value = rightShift(data_low, 1) and &H1
        CLKOFF_ACD_TX_CLOCK_mask = &H1
        if data_low > LONG_MAX then
            if CLKOFF_ACD_TX_CLOCK_mask = mask then
                read_CLKOFF_ACD_TX_CLOCK_value = data_low
            else
                read_CLKOFF_ACD_TX_CLOCK_value = (data_low - H8000_0000) and CLKOFF_ACD_TX_CLOCK_mask
            end If
        else
            read_CLKOFF_ACD_TX_CLOCK_value = data_low and CLKOFF_ACD_TX_CLOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RC_OSC_EN_OVERRIDE_VALUE_value = &H0
        flag_RC_OSC_EN_OVERRIDE_VALUE        = &H0
        write_RC_OSC_IN_OVERRIDE_VALUE_value = &H0
        flag_RC_OSC_IN_OVERRIDE_VALUE        = &H0
        write_DISABLE_DSP_RDB_CLOCK_value = &H0
        flag_DISABLE_DSP_RDB_CLOCK        = &H0
        write_CLKOFF_TPC_TX_CLOCK_value = &H0
        flag_CLKOFF_TPC_TX_CLOCK        = &H0
        write_CLKOFF_TPC_RX_CLOCK_value = &H0
        flag_CLKOFF_TPC_RX_CLOCK        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
        write_CLKOFF_CRC_CHECK_CLOCK_value = &H0
        flag_CLKOFF_CRC_CHECK_CLOCK        = &H0
        write_CLKOFF_PATGEN_CLOCK_value = &H0
        flag_CLKOFF_PATGEN_CLOCK        = &H0
        write_CLKOFF_GPCS_TX_CLOCK_value = &H0
        flag_CLKOFF_GPCS_TX_CLOCK        = &H0
        write_CLKOFF_TX_CLOCK_125_25_value = &H0
        flag_CLKOFF_TX_CLOCK_125_25        = &H0
        write_CLKOFF_FECTX_TX_CLOCK_value = &H0
        flag_CLKOFF_FECTX_TX_CLOCK        = &H0
        write_CLKOFF_PCS_TX_CLOCK_value = &H0
        flag_CLKOFF_PCS_TX_CLOCK        = &H0
        write_NOT_USED_value = &H0
        flag_NOT_USED        = &H0
        write_CLKOFF_SCR_TX_CLOCK_value = &H0
        flag_CLKOFF_SCR_TX_CLOCK        = &H0
        write_NOT_USED1_value = &H0
        flag_NOT_USED1        = &H0
        write_CLKOFF_ACD_TX_CLOCK_value = &H0
        flag_CLKOFF_ACD_TX_CLOCK        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_clock_gen_status2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RC_OSC_IN_VALUE                            [15:15]          get_RC_OSC_IN_VALUE
''                                                             set_RC_OSC_IN_VALUE
''                                                             read_RC_OSC_IN_VALUE
''                                                             write_RC_OSC_IN_VALUE
''---------------------------------------------------------------------------------
'' CLOCK_GEN_STATUS_BITS                      [14:0]           get_CLOCK_GEN_STATUS_BITS
''                                                             set_CLOCK_GEN_STATUS_BITS
''                                                             read_CLOCK_GEN_STATUS_BITS
''                                                             write_CLOCK_GEN_STATUS_BITS
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_clock_gen_status2
    Private write_RC_OSC_IN_VALUE_value
    Private read_RC_OSC_IN_VALUE_value
    Private flag_RC_OSC_IN_VALUE
    Private write_CLOCK_GEN_STATUS_BITS_value
    Private read_CLOCK_GEN_STATUS_BITS_value
    Private flag_CLOCK_GEN_STATUS_BITS

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

    Property Get get_RC_OSC_IN_VALUE
        get_RC_OSC_IN_VALUE = read_RC_OSC_IN_VALUE_value
    End Property

    Property Let set_RC_OSC_IN_VALUE(aData)
        write_RC_OSC_IN_VALUE_value = aData
        flag_RC_OSC_IN_VALUE        = &H1
    End Property

    Property Get read_RC_OSC_IN_VALUE
        read
        read_RC_OSC_IN_VALUE = read_RC_OSC_IN_VALUE_value
    End Property

    Property Let write_RC_OSC_IN_VALUE(aData)
        set_RC_OSC_IN_VALUE = aData
        write
    End Property

    Property Get get_CLOCK_GEN_STATUS_BITS
        get_CLOCK_GEN_STATUS_BITS = read_CLOCK_GEN_STATUS_BITS_value
    End Property

    Property Let set_CLOCK_GEN_STATUS_BITS(aData)
        write_CLOCK_GEN_STATUS_BITS_value = aData
        flag_CLOCK_GEN_STATUS_BITS        = &H1
    End Property

    Property Get read_CLOCK_GEN_STATUS_BITS
        read
        read_CLOCK_GEN_STATUS_BITS = read_CLOCK_GEN_STATUS_BITS_value
    End Property

    Property Let write_CLOCK_GEN_STATUS_BITS(aData)
        set_CLOCK_GEN_STATUS_BITS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OSC_IN_VALUE_value = rightShift(data_low, 15) and &H1
        CLOCK_GEN_STATUS_BITS_mask = &H7fff
        if data_low > LONG_MAX then
            if CLOCK_GEN_STATUS_BITS_mask = mask then
                read_CLOCK_GEN_STATUS_BITS_value = data_low
            else
                read_CLOCK_GEN_STATUS_BITS_value = (data_low - H8000_0000) and CLOCK_GEN_STATUS_BITS_mask
            end If
        else
            read_CLOCK_GEN_STATUS_BITS_value = data_low and CLOCK_GEN_STATUS_BITS_mask
        end If

    End Sub

    Sub write
        If flag_RC_OSC_IN_VALUE = &H0 or flag_CLOCK_GEN_STATUS_BITS = &H0 Then read
        If flag_RC_OSC_IN_VALUE = &H0 Then write_RC_OSC_IN_VALUE_value = get_RC_OSC_IN_VALUE
        If flag_CLOCK_GEN_STATUS_BITS = &H0 Then write_CLOCK_GEN_STATUS_BITS_value = get_CLOCK_GEN_STATUS_BITS

        regValue = leftShift((write_RC_OSC_IN_VALUE_value and &H1), 15) + leftShift((write_CLOCK_GEN_STATUS_BITS_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OSC_IN_VALUE_value = rightShift(data_low, 15) and &H1
        CLOCK_GEN_STATUS_BITS_mask = &H7fff
        if data_low > LONG_MAX then
            if CLOCK_GEN_STATUS_BITS_mask = mask then
                read_CLOCK_GEN_STATUS_BITS_value = data_low
            else
                read_CLOCK_GEN_STATUS_BITS_value = (data_low - H8000_0000) and CLOCK_GEN_STATUS_BITS_mask
            end If
        else
            read_CLOCK_GEN_STATUS_BITS_value = data_low and CLOCK_GEN_STATUS_BITS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RC_OSC_IN_VALUE_value = &H0
        flag_RC_OSC_IN_VALUE        = &H0
        write_CLOCK_GEN_STATUS_BITS_value = &H0
        flag_CLOCK_GEN_STATUS_BITS        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_pattern_gen_control_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PATTERN_GEN_NUM_OF_PACKETS                 [15:0]           get_PATTERN_GEN_NUM_OF_PACKETS
''                                                             set_PATTERN_GEN_NUM_OF_PACKETS
''                                                             read_PATTERN_GEN_NUM_OF_PACKETS
''                                                             write_PATTERN_GEN_NUM_OF_PACKETS
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pattern_gen_control_c
    Private write_PATTERN_GEN_NUM_OF_PACKETS_value
    Private read_PATTERN_GEN_NUM_OF_PACKETS_value
    Private flag_PATTERN_GEN_NUM_OF_PACKETS

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

    Property Get get_PATTERN_GEN_NUM_OF_PACKETS
        get_PATTERN_GEN_NUM_OF_PACKETS = read_PATTERN_GEN_NUM_OF_PACKETS_value
    End Property

    Property Let set_PATTERN_GEN_NUM_OF_PACKETS(aData)
        write_PATTERN_GEN_NUM_OF_PACKETS_value = aData
        flag_PATTERN_GEN_NUM_OF_PACKETS        = &H1
    End Property

    Property Get read_PATTERN_GEN_NUM_OF_PACKETS
        read
        read_PATTERN_GEN_NUM_OF_PACKETS = read_PATTERN_GEN_NUM_OF_PACKETS_value
    End Property

    Property Let write_PATTERN_GEN_NUM_OF_PACKETS(aData)
        set_PATTERN_GEN_NUM_OF_PACKETS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PATTERN_GEN_NUM_OF_PACKETS_mask = &Hffff
        if data_low > LONG_MAX then
            if PATTERN_GEN_NUM_OF_PACKETS_mask = mask then
                read_PATTERN_GEN_NUM_OF_PACKETS_value = data_low
            else
                read_PATTERN_GEN_NUM_OF_PACKETS_value = (data_low - H8000_0000) and PATTERN_GEN_NUM_OF_PACKETS_mask
            end If
        else
            read_PATTERN_GEN_NUM_OF_PACKETS_value = data_low and PATTERN_GEN_NUM_OF_PACKETS_mask
        end If

    End Sub

    Sub write
        If flag_PATTERN_GEN_NUM_OF_PACKETS = &H0 Then read
        If flag_PATTERN_GEN_NUM_OF_PACKETS = &H0 Then write_PATTERN_GEN_NUM_OF_PACKETS_value = get_PATTERN_GEN_NUM_OF_PACKETS

        regValue = leftShift((write_PATTERN_GEN_NUM_OF_PACKETS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PATTERN_GEN_NUM_OF_PACKETS_mask = &Hffff
        if data_low > LONG_MAX then
            if PATTERN_GEN_NUM_OF_PACKETS_mask = mask then
                read_PATTERN_GEN_NUM_OF_PACKETS_value = data_low
            else
                read_PATTERN_GEN_NUM_OF_PACKETS_value = (data_low - H8000_0000) and PATTERN_GEN_NUM_OF_PACKETS_mask
            end If
        else
            read_PATTERN_GEN_NUM_OF_PACKETS_value = data_low and PATTERN_GEN_NUM_OF_PACKETS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PATTERN_GEN_NUM_OF_PACKETS_value = &H0
        flag_PATTERN_GEN_NUM_OF_PACKETS        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_pattern_gen_control_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PKT_SIZE                                   [15:0]           get_PKT_SIZE
''                                                             set_PKT_SIZE
''                                                             read_PKT_SIZE
''                                                             write_PKT_SIZE
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pattern_gen_control_d
    Private write_PKT_SIZE_value
    Private read_PKT_SIZE_value
    Private flag_PKT_SIZE

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

    Property Get get_PKT_SIZE
        get_PKT_SIZE = read_PKT_SIZE_value
    End Property

    Property Let set_PKT_SIZE(aData)
        write_PKT_SIZE_value = aData
        flag_PKT_SIZE        = &H1
    End Property

    Property Get read_PKT_SIZE
        read
        read_PKT_SIZE = read_PKT_SIZE_value
    End Property

    Property Let write_PKT_SIZE(aData)
        set_PKT_SIZE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKT_SIZE_mask = &Hffff
        if data_low > LONG_MAX then
            if PKT_SIZE_mask = mask then
                read_PKT_SIZE_value = data_low
            else
                read_PKT_SIZE_value = (data_low - H8000_0000) and PKT_SIZE_mask
            end If
        else
            read_PKT_SIZE_value = data_low and PKT_SIZE_mask
        end If

    End Sub

    Sub write
        If flag_PKT_SIZE = &H0 Then read
        If flag_PKT_SIZE = &H0 Then write_PKT_SIZE_value = get_PKT_SIZE

        regValue = leftShift((write_PKT_SIZE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKT_SIZE_mask = &Hffff
        if data_low > LONG_MAX then
            if PKT_SIZE_mask = mask then
                read_PKT_SIZE_value = data_low
            else
                read_PKT_SIZE_value = (data_low - H8000_0000) and PKT_SIZE_mask
            end If
        else
            read_PKT_SIZE_value = data_low and PKT_SIZE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PKT_SIZE_value = &H0
        flag_PKT_SIZE        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_miififo_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MIIFIFO_SFT_RESET                          [15:15]          get_MIIFIFO_SFT_RESET
''                                                             set_MIIFIFO_SFT_RESET
''                                                             read_MIIFIFO_SFT_RESET
''                                                             write_MIIFIFO_SFT_RESET
''---------------------------------------------------------------------------------
'' MIIFIFO_DISABLE_FIFO                       [14:14]          get_MIIFIFO_DISABLE_FIFO
''                                                             set_MIIFIFO_DISABLE_FIFO
''                                                             read_MIIFIFO_DISABLE_FIFO
''                                                             write_MIIFIFO_DISABLE_FIFO
''---------------------------------------------------------------------------------
'' MIIFIFO_LPI_FEATURE_ENABLE                 [13:13]          get_MIIFIFO_LPI_FEATURE_ENABLE
''                                                             set_MIIFIFO_LPI_FEATURE_ENABLE
''                                                             read_MIIFIFO_LPI_FEATURE_ENABLE
''                                                             write_MIIFIFO_LPI_FEATURE_ENABLE
''---------------------------------------------------------------------------------
'' MIIFIFO_MIN_IPG                            [11:8]           get_MIIFIFO_MIN_IPG
''                                                             set_MIIFIFO_MIN_IPG
''                                                             read_MIIFIFO_MIN_IPG
''                                                             write_MIIFIFO_MIN_IPG
''---------------------------------------------------------------------------------
'' MIIFIFO_WRBLOCK_OVR                        [7:4]            get_MIIFIFO_WRBLOCK_OVR
''                                                             set_MIIFIFO_WRBLOCK_OVR
''                                                             read_MIIFIFO_WRBLOCK_OVR
''                                                             write_MIIFIFO_WRBLOCK_OVR
''---------------------------------------------------------------------------------
'' MIIFIFO_WRBLOCK_MODE                       [3:3]            get_MIIFIFO_WRBLOCK_MODE
''                                                             set_MIIFIFO_WRBLOCK_MODE
''                                                             read_MIIFIFO_WRBLOCK_MODE
''                                                             write_MIIFIFO_WRBLOCK_MODE
''---------------------------------------------------------------------------------
'' MIIFIFO_ELASTICITY_MODE                    [1:0]            get_MIIFIFO_ELASTICITY_MODE
''                                                             set_MIIFIFO_ELASTICITY_MODE
''                                                             read_MIIFIFO_ELASTICITY_MODE
''                                                             write_MIIFIFO_ELASTICITY_MODE
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_miififo_control
    Private write_MIIFIFO_SFT_RESET_value
    Private read_MIIFIFO_SFT_RESET_value
    Private flag_MIIFIFO_SFT_RESET
    Private write_MIIFIFO_DISABLE_FIFO_value
    Private read_MIIFIFO_DISABLE_FIFO_value
    Private flag_MIIFIFO_DISABLE_FIFO
    Private write_MIIFIFO_LPI_FEATURE_ENABLE_value
    Private read_MIIFIFO_LPI_FEATURE_ENABLE_value
    Private flag_MIIFIFO_LPI_FEATURE_ENABLE
    Private write_MIIFIFO_MIN_IPG_value
    Private read_MIIFIFO_MIN_IPG_value
    Private flag_MIIFIFO_MIN_IPG
    Private write_MIIFIFO_WRBLOCK_OVR_value
    Private read_MIIFIFO_WRBLOCK_OVR_value
    Private flag_MIIFIFO_WRBLOCK_OVR
    Private write_MIIFIFO_WRBLOCK_MODE_value
    Private read_MIIFIFO_WRBLOCK_MODE_value
    Private flag_MIIFIFO_WRBLOCK_MODE
    Private write_MIIFIFO_ELASTICITY_MODE_value
    Private read_MIIFIFO_ELASTICITY_MODE_value
    Private flag_MIIFIFO_ELASTICITY_MODE

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

    Property Get get_MIIFIFO_SFT_RESET
        get_MIIFIFO_SFT_RESET = read_MIIFIFO_SFT_RESET_value
    End Property

    Property Let set_MIIFIFO_SFT_RESET(aData)
        write_MIIFIFO_SFT_RESET_value = aData
        flag_MIIFIFO_SFT_RESET        = &H1
    End Property

    Property Get read_MIIFIFO_SFT_RESET
        read
        read_MIIFIFO_SFT_RESET = read_MIIFIFO_SFT_RESET_value
    End Property

    Property Let write_MIIFIFO_SFT_RESET(aData)
        set_MIIFIFO_SFT_RESET = aData
        write
    End Property

    Property Get get_MIIFIFO_DISABLE_FIFO
        get_MIIFIFO_DISABLE_FIFO = read_MIIFIFO_DISABLE_FIFO_value
    End Property

    Property Let set_MIIFIFO_DISABLE_FIFO(aData)
        write_MIIFIFO_DISABLE_FIFO_value = aData
        flag_MIIFIFO_DISABLE_FIFO        = &H1
    End Property

    Property Get read_MIIFIFO_DISABLE_FIFO
        read
        read_MIIFIFO_DISABLE_FIFO = read_MIIFIFO_DISABLE_FIFO_value
    End Property

    Property Let write_MIIFIFO_DISABLE_FIFO(aData)
        set_MIIFIFO_DISABLE_FIFO = aData
        write
    End Property

    Property Get get_MIIFIFO_LPI_FEATURE_ENABLE
        get_MIIFIFO_LPI_FEATURE_ENABLE = read_MIIFIFO_LPI_FEATURE_ENABLE_value
    End Property

    Property Let set_MIIFIFO_LPI_FEATURE_ENABLE(aData)
        write_MIIFIFO_LPI_FEATURE_ENABLE_value = aData
        flag_MIIFIFO_LPI_FEATURE_ENABLE        = &H1
    End Property

    Property Get read_MIIFIFO_LPI_FEATURE_ENABLE
        read
        read_MIIFIFO_LPI_FEATURE_ENABLE = read_MIIFIFO_LPI_FEATURE_ENABLE_value
    End Property

    Property Let write_MIIFIFO_LPI_FEATURE_ENABLE(aData)
        set_MIIFIFO_LPI_FEATURE_ENABLE = aData
        write
    End Property

    Property Get get_MIIFIFO_MIN_IPG
        get_MIIFIFO_MIN_IPG = read_MIIFIFO_MIN_IPG_value
    End Property

    Property Let set_MIIFIFO_MIN_IPG(aData)
        write_MIIFIFO_MIN_IPG_value = aData
        flag_MIIFIFO_MIN_IPG        = &H1
    End Property

    Property Get read_MIIFIFO_MIN_IPG
        read
        read_MIIFIFO_MIN_IPG = read_MIIFIFO_MIN_IPG_value
    End Property

    Property Let write_MIIFIFO_MIN_IPG(aData)
        set_MIIFIFO_MIN_IPG = aData
        write
    End Property

    Property Get get_MIIFIFO_WRBLOCK_OVR
        get_MIIFIFO_WRBLOCK_OVR = read_MIIFIFO_WRBLOCK_OVR_value
    End Property

    Property Let set_MIIFIFO_WRBLOCK_OVR(aData)
        write_MIIFIFO_WRBLOCK_OVR_value = aData
        flag_MIIFIFO_WRBLOCK_OVR        = &H1
    End Property

    Property Get read_MIIFIFO_WRBLOCK_OVR
        read
        read_MIIFIFO_WRBLOCK_OVR = read_MIIFIFO_WRBLOCK_OVR_value
    End Property

    Property Let write_MIIFIFO_WRBLOCK_OVR(aData)
        set_MIIFIFO_WRBLOCK_OVR = aData
        write
    End Property

    Property Get get_MIIFIFO_WRBLOCK_MODE
        get_MIIFIFO_WRBLOCK_MODE = read_MIIFIFO_WRBLOCK_MODE_value
    End Property

    Property Let set_MIIFIFO_WRBLOCK_MODE(aData)
        write_MIIFIFO_WRBLOCK_MODE_value = aData
        flag_MIIFIFO_WRBLOCK_MODE        = &H1
    End Property

    Property Get read_MIIFIFO_WRBLOCK_MODE
        read
        read_MIIFIFO_WRBLOCK_MODE = read_MIIFIFO_WRBLOCK_MODE_value
    End Property

    Property Let write_MIIFIFO_WRBLOCK_MODE(aData)
        set_MIIFIFO_WRBLOCK_MODE = aData
        write
    End Property

    Property Get get_MIIFIFO_ELASTICITY_MODE
        get_MIIFIFO_ELASTICITY_MODE = read_MIIFIFO_ELASTICITY_MODE_value
    End Property

    Property Let set_MIIFIFO_ELASTICITY_MODE(aData)
        write_MIIFIFO_ELASTICITY_MODE_value = aData
        flag_MIIFIFO_ELASTICITY_MODE        = &H1
    End Property

    Property Get read_MIIFIFO_ELASTICITY_MODE
        read
        read_MIIFIFO_ELASTICITY_MODE = read_MIIFIFO_ELASTICITY_MODE_value
    End Property

    Property Let write_MIIFIFO_ELASTICITY_MODE(aData)
        set_MIIFIFO_ELASTICITY_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MIIFIFO_SFT_RESET_value = rightShift(data_low, 15) and &H1
        read_MIIFIFO_DISABLE_FIFO_value = rightShift(data_low, 14) and &H1
        read_MIIFIFO_LPI_FEATURE_ENABLE_value = rightShift(data_low, 13) and &H1
        read_MIIFIFO_MIN_IPG_value = rightShift(data_low, 8) and &Hf
        read_MIIFIFO_WRBLOCK_OVR_value = rightShift(data_low, 4) and &Hf
        read_MIIFIFO_WRBLOCK_MODE_value = rightShift(data_low, 3) and &H1
        MIIFIFO_ELASTICITY_MODE_mask = &H3
        if data_low > LONG_MAX then
            if MIIFIFO_ELASTICITY_MODE_mask = mask then
                read_MIIFIFO_ELASTICITY_MODE_value = data_low
            else
                read_MIIFIFO_ELASTICITY_MODE_value = (data_low - H8000_0000) and MIIFIFO_ELASTICITY_MODE_mask
            end If
        else
            read_MIIFIFO_ELASTICITY_MODE_value = data_low and MIIFIFO_ELASTICITY_MODE_mask
        end If

    End Sub

    Sub write
        If flag_MIIFIFO_SFT_RESET = &H0 or flag_MIIFIFO_DISABLE_FIFO = &H0 or flag_MIIFIFO_LPI_FEATURE_ENABLE = &H0 or flag_MIIFIFO_MIN_IPG = &H0 or flag_MIIFIFO_WRBLOCK_OVR = &H0 or flag_MIIFIFO_WRBLOCK_MODE = &H0 or flag_MIIFIFO_ELASTICITY_MODE = &H0 Then read
        If flag_MIIFIFO_SFT_RESET = &H0 Then write_MIIFIFO_SFT_RESET_value = get_MIIFIFO_SFT_RESET
        If flag_MIIFIFO_DISABLE_FIFO = &H0 Then write_MIIFIFO_DISABLE_FIFO_value = get_MIIFIFO_DISABLE_FIFO
        If flag_MIIFIFO_LPI_FEATURE_ENABLE = &H0 Then write_MIIFIFO_LPI_FEATURE_ENABLE_value = get_MIIFIFO_LPI_FEATURE_ENABLE
        If flag_MIIFIFO_MIN_IPG = &H0 Then write_MIIFIFO_MIN_IPG_value = get_MIIFIFO_MIN_IPG
        If flag_MIIFIFO_WRBLOCK_OVR = &H0 Then write_MIIFIFO_WRBLOCK_OVR_value = get_MIIFIFO_WRBLOCK_OVR
        If flag_MIIFIFO_WRBLOCK_MODE = &H0 Then write_MIIFIFO_WRBLOCK_MODE_value = get_MIIFIFO_WRBLOCK_MODE
        If flag_MIIFIFO_ELASTICITY_MODE = &H0 Then write_MIIFIFO_ELASTICITY_MODE_value = get_MIIFIFO_ELASTICITY_MODE

        regValue = leftShift((write_MIIFIFO_SFT_RESET_value and &H1), 15) + leftShift((write_MIIFIFO_DISABLE_FIFO_value and &H1), 14) + leftShift((write_MIIFIFO_LPI_FEATURE_ENABLE_value and &H1), 13) + leftShift((write_MIIFIFO_MIN_IPG_value and &Hf), 8) + leftShift((write_MIIFIFO_WRBLOCK_OVR_value and &Hf), 4) + leftShift((write_MIIFIFO_WRBLOCK_MODE_value and &H1), 3) + leftShift((write_MIIFIFO_ELASTICITY_MODE_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MIIFIFO_SFT_RESET_value = rightShift(data_low, 15) and &H1
        read_MIIFIFO_DISABLE_FIFO_value = rightShift(data_low, 14) and &H1
        read_MIIFIFO_LPI_FEATURE_ENABLE_value = rightShift(data_low, 13) and &H1
        read_MIIFIFO_MIN_IPG_value = rightShift(data_low, 8) and &Hf
        read_MIIFIFO_WRBLOCK_OVR_value = rightShift(data_low, 4) and &Hf
        read_MIIFIFO_WRBLOCK_MODE_value = rightShift(data_low, 3) and &H1
        MIIFIFO_ELASTICITY_MODE_mask = &H3
        if data_low > LONG_MAX then
            if MIIFIFO_ELASTICITY_MODE_mask = mask then
                read_MIIFIFO_ELASTICITY_MODE_value = data_low
            else
                read_MIIFIFO_ELASTICITY_MODE_value = (data_low - H8000_0000) and MIIFIFO_ELASTICITY_MODE_mask
            end If
        else
            read_MIIFIFO_ELASTICITY_MODE_value = data_low and MIIFIFO_ELASTICITY_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MIIFIFO_SFT_RESET_value = &H0
        flag_MIIFIFO_SFT_RESET        = &H0
        write_MIIFIFO_DISABLE_FIFO_value = &H0
        flag_MIIFIFO_DISABLE_FIFO        = &H0
        write_MIIFIFO_LPI_FEATURE_ENABLE_value = &H0
        flag_MIIFIFO_LPI_FEATURE_ENABLE        = &H0
        write_MIIFIFO_MIN_IPG_value = &H0
        flag_MIIFIFO_MIN_IPG        = &H0
        write_MIIFIFO_WRBLOCK_OVR_value = &H0
        flag_MIIFIFO_WRBLOCK_OVR        = &H0
        write_MIIFIFO_WRBLOCK_MODE_value = &H0
        flag_MIIFIFO_WRBLOCK_MODE        = &H0
        write_MIIFIFO_ELASTICITY_MODE_value = &H0
        flag_MIIFIFO_ELASTICITY_MODE        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_testability_reg_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHY_CONTROL_TUNING_PARAMETERS              [15:12]          get_PHY_CONTROL_TUNING_PARAMETERS
''                                                             set_PHY_CONTROL_TUNING_PARAMETERS
''                                                             read_PHY_CONTROL_TUNING_PARAMETERS
''                                                             write_PHY_CONTROL_TUNING_PARAMETERS
''---------------------------------------------------------------------------------
'' DSP_TUNING_PARAMETERS                      [11:8]           get_DSP_TUNING_PARAMETERS
''                                                             set_DSP_TUNING_PARAMETERS
''                                                             read_DSP_TUNING_PARAMETERS
''                                                             write_DSP_TUNING_PARAMETERS
''---------------------------------------------------------------------------------
'' FORCED_POLARITY_ENABLE                     [3:3]            get_FORCED_POLARITY_ENABLE
''                                                             set_FORCED_POLARITY_ENABLE
''                                                             read_FORCED_POLARITY_ENABLE
''                                                             write_FORCED_POLARITY_ENABLE
''---------------------------------------------------------------------------------
'' FORCED_POLARITY_VALUE                      [2:2]            get_FORCED_POLARITY_VALUE
''                                                             set_FORCED_POLARITY_VALUE
''                                                             read_FORCED_POLARITY_VALUE
''                                                             write_FORCED_POLARITY_VALUE
''---------------------------------------------------------------------------------
'' FORCED_MSE_OK                              [1:1]            get_FORCED_MSE_OK
''                                                             set_FORCED_MSE_OK
''                                                             read_FORCED_MSE_OK
''                                                             write_FORCED_MSE_OK
''---------------------------------------------------------------------------------
'' FORCED_ALIGNMENT                           [0:0]            get_FORCED_ALIGNMENT
''                                                             set_FORCED_ALIGNMENT
''                                                             read_FORCED_ALIGNMENT
''                                                             write_FORCED_ALIGNMENT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_testability_reg_a
    Private write_PHY_CONTROL_TUNING_PARAMETERS_value
    Private read_PHY_CONTROL_TUNING_PARAMETERS_value
    Private flag_PHY_CONTROL_TUNING_PARAMETERS
    Private write_DSP_TUNING_PARAMETERS_value
    Private read_DSP_TUNING_PARAMETERS_value
    Private flag_DSP_TUNING_PARAMETERS
    Private write_FORCED_POLARITY_ENABLE_value
    Private read_FORCED_POLARITY_ENABLE_value
    Private flag_FORCED_POLARITY_ENABLE
    Private write_FORCED_POLARITY_VALUE_value
    Private read_FORCED_POLARITY_VALUE_value
    Private flag_FORCED_POLARITY_VALUE
    Private write_FORCED_MSE_OK_value
    Private read_FORCED_MSE_OK_value
    Private flag_FORCED_MSE_OK
    Private write_FORCED_ALIGNMENT_value
    Private read_FORCED_ALIGNMENT_value
    Private flag_FORCED_ALIGNMENT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHY_CONTROL_TUNING_PARAMETERS
        get_PHY_CONTROL_TUNING_PARAMETERS = read_PHY_CONTROL_TUNING_PARAMETERS_value
    End Property

    Property Let set_PHY_CONTROL_TUNING_PARAMETERS(aData)
        write_PHY_CONTROL_TUNING_PARAMETERS_value = aData
        flag_PHY_CONTROL_TUNING_PARAMETERS        = &H1
    End Property

    Property Get read_PHY_CONTROL_TUNING_PARAMETERS
        read
        read_PHY_CONTROL_TUNING_PARAMETERS = read_PHY_CONTROL_TUNING_PARAMETERS_value
    End Property

    Property Let write_PHY_CONTROL_TUNING_PARAMETERS(aData)
        set_PHY_CONTROL_TUNING_PARAMETERS = aData
        write
    End Property

    Property Get get_DSP_TUNING_PARAMETERS
        get_DSP_TUNING_PARAMETERS = read_DSP_TUNING_PARAMETERS_value
    End Property

    Property Let set_DSP_TUNING_PARAMETERS(aData)
        write_DSP_TUNING_PARAMETERS_value = aData
        flag_DSP_TUNING_PARAMETERS        = &H1
    End Property

    Property Get read_DSP_TUNING_PARAMETERS
        read
        read_DSP_TUNING_PARAMETERS = read_DSP_TUNING_PARAMETERS_value
    End Property

    Property Let write_DSP_TUNING_PARAMETERS(aData)
        set_DSP_TUNING_PARAMETERS = aData
        write
    End Property

    Property Get get_FORCED_POLARITY_ENABLE
        get_FORCED_POLARITY_ENABLE = read_FORCED_POLARITY_ENABLE_value
    End Property

    Property Let set_FORCED_POLARITY_ENABLE(aData)
        write_FORCED_POLARITY_ENABLE_value = aData
        flag_FORCED_POLARITY_ENABLE        = &H1
    End Property

    Property Get read_FORCED_POLARITY_ENABLE
        read
        read_FORCED_POLARITY_ENABLE = read_FORCED_POLARITY_ENABLE_value
    End Property

    Property Let write_FORCED_POLARITY_ENABLE(aData)
        set_FORCED_POLARITY_ENABLE = aData
        write
    End Property

    Property Get get_FORCED_POLARITY_VALUE
        get_FORCED_POLARITY_VALUE = read_FORCED_POLARITY_VALUE_value
    End Property

    Property Let set_FORCED_POLARITY_VALUE(aData)
        write_FORCED_POLARITY_VALUE_value = aData
        flag_FORCED_POLARITY_VALUE        = &H1
    End Property

    Property Get read_FORCED_POLARITY_VALUE
        read
        read_FORCED_POLARITY_VALUE = read_FORCED_POLARITY_VALUE_value
    End Property

    Property Let write_FORCED_POLARITY_VALUE(aData)
        set_FORCED_POLARITY_VALUE = aData
        write
    End Property

    Property Get get_FORCED_MSE_OK
        get_FORCED_MSE_OK = read_FORCED_MSE_OK_value
    End Property

    Property Let set_FORCED_MSE_OK(aData)
        write_FORCED_MSE_OK_value = aData
        flag_FORCED_MSE_OK        = &H1
    End Property

    Property Get read_FORCED_MSE_OK
        read
        read_FORCED_MSE_OK = read_FORCED_MSE_OK_value
    End Property

    Property Let write_FORCED_MSE_OK(aData)
        set_FORCED_MSE_OK = aData
        write
    End Property

    Property Get get_FORCED_ALIGNMENT
        get_FORCED_ALIGNMENT = read_FORCED_ALIGNMENT_value
    End Property

    Property Let set_FORCED_ALIGNMENT(aData)
        write_FORCED_ALIGNMENT_value = aData
        flag_FORCED_ALIGNMENT        = &H1
    End Property

    Property Get read_FORCED_ALIGNMENT
        read
        read_FORCED_ALIGNMENT = read_FORCED_ALIGNMENT_value
    End Property

    Property Let write_FORCED_ALIGNMENT(aData)
        set_FORCED_ALIGNMENT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_CONTROL_TUNING_PARAMETERS_value = rightShift(data_low, 12) and &Hf
        read_DSP_TUNING_PARAMETERS_value = rightShift(data_low, 8) and &Hf
        read_FORCED_POLARITY_ENABLE_value = rightShift(data_low, 3) and &H1
        read_FORCED_POLARITY_VALUE_value = rightShift(data_low, 2) and &H1
        read_FORCED_MSE_OK_value = rightShift(data_low, 1) and &H1
        FORCED_ALIGNMENT_mask = &H1
        if data_low > LONG_MAX then
            if FORCED_ALIGNMENT_mask = mask then
                read_FORCED_ALIGNMENT_value = data_low
            else
                read_FORCED_ALIGNMENT_value = (data_low - H8000_0000) and FORCED_ALIGNMENT_mask
            end If
        else
            read_FORCED_ALIGNMENT_value = data_low and FORCED_ALIGNMENT_mask
        end If

    End Sub

    Sub write
        If flag_PHY_CONTROL_TUNING_PARAMETERS = &H0 or flag_DSP_TUNING_PARAMETERS = &H0 or flag_FORCED_POLARITY_ENABLE = &H0 or flag_FORCED_POLARITY_VALUE = &H0 or flag_FORCED_MSE_OK = &H0 or flag_FORCED_ALIGNMENT = &H0 Then read
        If flag_PHY_CONTROL_TUNING_PARAMETERS = &H0 Then write_PHY_CONTROL_TUNING_PARAMETERS_value = get_PHY_CONTROL_TUNING_PARAMETERS
        If flag_DSP_TUNING_PARAMETERS = &H0 Then write_DSP_TUNING_PARAMETERS_value = get_DSP_TUNING_PARAMETERS
        If flag_FORCED_POLARITY_ENABLE = &H0 Then write_FORCED_POLARITY_ENABLE_value = get_FORCED_POLARITY_ENABLE
        If flag_FORCED_POLARITY_VALUE = &H0 Then write_FORCED_POLARITY_VALUE_value = get_FORCED_POLARITY_VALUE
        If flag_FORCED_MSE_OK = &H0 Then write_FORCED_MSE_OK_value = get_FORCED_MSE_OK
        If flag_FORCED_ALIGNMENT = &H0 Then write_FORCED_ALIGNMENT_value = get_FORCED_ALIGNMENT

        regValue = leftShift((write_PHY_CONTROL_TUNING_PARAMETERS_value and &Hf), 12) + leftShift((write_DSP_TUNING_PARAMETERS_value and &Hf), 8) + leftShift((write_FORCED_POLARITY_ENABLE_value and &H1), 3) + leftShift((write_FORCED_POLARITY_VALUE_value and &H1), 2) + leftShift((write_FORCED_MSE_OK_value and &H1), 1) + leftShift((write_FORCED_ALIGNMENT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_CONTROL_TUNING_PARAMETERS_value = rightShift(data_low, 12) and &Hf
        read_DSP_TUNING_PARAMETERS_value = rightShift(data_low, 8) and &Hf
        read_FORCED_POLARITY_ENABLE_value = rightShift(data_low, 3) and &H1
        read_FORCED_POLARITY_VALUE_value = rightShift(data_low, 2) and &H1
        read_FORCED_MSE_OK_value = rightShift(data_low, 1) and &H1
        FORCED_ALIGNMENT_mask = &H1
        if data_low > LONG_MAX then
            if FORCED_ALIGNMENT_mask = mask then
                read_FORCED_ALIGNMENT_value = data_low
            else
                read_FORCED_ALIGNMENT_value = (data_low - H8000_0000) and FORCED_ALIGNMENT_mask
            end If
        else
            read_FORCED_ALIGNMENT_value = data_low and FORCED_ALIGNMENT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHY_CONTROL_TUNING_PARAMETERS_value = &H0
        flag_PHY_CONTROL_TUNING_PARAMETERS        = &H0
        write_DSP_TUNING_PARAMETERS_value = &H0
        flag_DSP_TUNING_PARAMETERS        = &H0
        write_FORCED_POLARITY_ENABLE_value = &H0
        flag_FORCED_POLARITY_ENABLE        = &H0
        write_FORCED_POLARITY_VALUE_value = &H0
        flag_FORCED_POLARITY_VALUE        = &H0
        write_FORCED_MSE_OK_value = &H0
        flag_FORCED_MSE_OK        = &H0
        write_FORCED_ALIGNMENT_value = &H0
        flag_FORCED_ALIGNMENT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_testability_reg_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHY_STATE                                  [15:8]           get_PHY_STATE
''                                                             set_PHY_STATE
''                                                             read_PHY_STATE
''                                                             write_PHY_STATE
''---------------------------------------------------------------------------------
'' SYNCHRONIZATION_DONE                       [6:6]            get_SYNCHRONIZATION_DONE
''                                                             set_SYNCHRONIZATION_DONE
''                                                             read_SYNCHRONIZATION_DONE
''                                                             write_SYNCHRONIZATION_DONE
''---------------------------------------------------------------------------------
'' ADC_OVERFLOW                               [5:5]            get_ADC_OVERFLOW
''                                                             set_ADC_OVERFLOW
''                                                             read_ADC_OVERFLOW
''                                                             write_ADC_OVERFLOW
''---------------------------------------------------------------------------------
'' ALIGNMENT_OK                               [4:4]            get_ALIGNMENT_OK
''                                                             set_ALIGNMENT_OK
''                                                             read_ALIGNMENT_OK
''                                                             write_ALIGNMENT_OK
''---------------------------------------------------------------------------------
'' CRC_ERROR                                  [3:3]            get_CRC_ERROR
''                                                             set_CRC_ERROR
''                                                             read_CRC_ERROR
''                                                             write_CRC_ERROR
''---------------------------------------------------------------------------------
'' RETRAIN                                    [2:2]            get_RETRAIN
''                                                             set_RETRAIN
''                                                             read_RETRAIN
''                                                             write_RETRAIN
''---------------------------------------------------------------------------------
'' REMOTE_RECEIVER_STATUS                     [1:1]            get_REMOTE_RECEIVER_STATUS
''                                                             set_REMOTE_RECEIVER_STATUS
''                                                             read_REMOTE_RECEIVER_STATUS
''                                                             write_REMOTE_RECEIVER_STATUS
''---------------------------------------------------------------------------------
'' LOCAL_RECEIVER_STATUS                      [0:0]            get_LOCAL_RECEIVER_STATUS
''                                                             set_LOCAL_RECEIVER_STATUS
''                                                             read_LOCAL_RECEIVER_STATUS
''                                                             write_LOCAL_RECEIVER_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_testability_reg_b
    Private write_PHY_STATE_value
    Private read_PHY_STATE_value
    Private flag_PHY_STATE
    Private write_SYNCHRONIZATION_DONE_value
    Private read_SYNCHRONIZATION_DONE_value
    Private flag_SYNCHRONIZATION_DONE
    Private write_ADC_OVERFLOW_value
    Private read_ADC_OVERFLOW_value
    Private flag_ADC_OVERFLOW
    Private write_ALIGNMENT_OK_value
    Private read_ALIGNMENT_OK_value
    Private flag_ALIGNMENT_OK
    Private write_CRC_ERROR_value
    Private read_CRC_ERROR_value
    Private flag_CRC_ERROR
    Private write_RETRAIN_value
    Private read_RETRAIN_value
    Private flag_RETRAIN
    Private write_REMOTE_RECEIVER_STATUS_value
    Private read_REMOTE_RECEIVER_STATUS_value
    Private flag_REMOTE_RECEIVER_STATUS
    Private write_LOCAL_RECEIVER_STATUS_value
    Private read_LOCAL_RECEIVER_STATUS_value
    Private flag_LOCAL_RECEIVER_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H82
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHY_STATE
        get_PHY_STATE = read_PHY_STATE_value
    End Property

    Property Let set_PHY_STATE(aData)
        write_PHY_STATE_value = aData
        flag_PHY_STATE        = &H1
    End Property

    Property Get read_PHY_STATE
        read
        read_PHY_STATE = read_PHY_STATE_value
    End Property

    Property Let write_PHY_STATE(aData)
        set_PHY_STATE = aData
        write
    End Property

    Property Get get_SYNCHRONIZATION_DONE
        get_SYNCHRONIZATION_DONE = read_SYNCHRONIZATION_DONE_value
    End Property

    Property Let set_SYNCHRONIZATION_DONE(aData)
        write_SYNCHRONIZATION_DONE_value = aData
        flag_SYNCHRONIZATION_DONE        = &H1
    End Property

    Property Get read_SYNCHRONIZATION_DONE
        read
        read_SYNCHRONIZATION_DONE = read_SYNCHRONIZATION_DONE_value
    End Property

    Property Let write_SYNCHRONIZATION_DONE(aData)
        set_SYNCHRONIZATION_DONE = aData
        write
    End Property

    Property Get get_ADC_OVERFLOW
        get_ADC_OVERFLOW = read_ADC_OVERFLOW_value
    End Property

    Property Let set_ADC_OVERFLOW(aData)
        write_ADC_OVERFLOW_value = aData
        flag_ADC_OVERFLOW        = &H1
    End Property

    Property Get read_ADC_OVERFLOW
        read
        read_ADC_OVERFLOW = read_ADC_OVERFLOW_value
    End Property

    Property Let write_ADC_OVERFLOW(aData)
        set_ADC_OVERFLOW = aData
        write
    End Property

    Property Get get_ALIGNMENT_OK
        get_ALIGNMENT_OK = read_ALIGNMENT_OK_value
    End Property

    Property Let set_ALIGNMENT_OK(aData)
        write_ALIGNMENT_OK_value = aData
        flag_ALIGNMENT_OK        = &H1
    End Property

    Property Get read_ALIGNMENT_OK
        read
        read_ALIGNMENT_OK = read_ALIGNMENT_OK_value
    End Property

    Property Let write_ALIGNMENT_OK(aData)
        set_ALIGNMENT_OK = aData
        write
    End Property

    Property Get get_CRC_ERROR
        get_CRC_ERROR = read_CRC_ERROR_value
    End Property

    Property Let set_CRC_ERROR(aData)
        write_CRC_ERROR_value = aData
        flag_CRC_ERROR        = &H1
    End Property

    Property Get read_CRC_ERROR
        read
        read_CRC_ERROR = read_CRC_ERROR_value
    End Property

    Property Let write_CRC_ERROR(aData)
        set_CRC_ERROR = aData
        write
    End Property

    Property Get get_RETRAIN
        get_RETRAIN = read_RETRAIN_value
    End Property

    Property Let set_RETRAIN(aData)
        write_RETRAIN_value = aData
        flag_RETRAIN        = &H1
    End Property

    Property Get read_RETRAIN
        read
        read_RETRAIN = read_RETRAIN_value
    End Property

    Property Let write_RETRAIN(aData)
        set_RETRAIN = aData
        write
    End Property

    Property Get get_REMOTE_RECEIVER_STATUS
        get_REMOTE_RECEIVER_STATUS = read_REMOTE_RECEIVER_STATUS_value
    End Property

    Property Let set_REMOTE_RECEIVER_STATUS(aData)
        write_REMOTE_RECEIVER_STATUS_value = aData
        flag_REMOTE_RECEIVER_STATUS        = &H1
    End Property

    Property Get read_REMOTE_RECEIVER_STATUS
        read
        read_REMOTE_RECEIVER_STATUS = read_REMOTE_RECEIVER_STATUS_value
    End Property

    Property Let write_REMOTE_RECEIVER_STATUS(aData)
        set_REMOTE_RECEIVER_STATUS = aData
        write
    End Property

    Property Get get_LOCAL_RECEIVER_STATUS
        get_LOCAL_RECEIVER_STATUS = read_LOCAL_RECEIVER_STATUS_value
    End Property

    Property Let set_LOCAL_RECEIVER_STATUS(aData)
        write_LOCAL_RECEIVER_STATUS_value = aData
        flag_LOCAL_RECEIVER_STATUS        = &H1
    End Property

    Property Get read_LOCAL_RECEIVER_STATUS
        read
        read_LOCAL_RECEIVER_STATUS = read_LOCAL_RECEIVER_STATUS_value
    End Property

    Property Let write_LOCAL_RECEIVER_STATUS(aData)
        set_LOCAL_RECEIVER_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_STATE_value = rightShift(data_low, 8) and &Hff
        read_SYNCHRONIZATION_DONE_value = rightShift(data_low, 6) and &H1
        read_ADC_OVERFLOW_value = rightShift(data_low, 5) and &H1
        read_ALIGNMENT_OK_value = rightShift(data_low, 4) and &H1
        read_CRC_ERROR_value = rightShift(data_low, 3) and &H1
        read_RETRAIN_value = rightShift(data_low, 2) and &H1
        read_REMOTE_RECEIVER_STATUS_value = rightShift(data_low, 1) and &H1
        LOCAL_RECEIVER_STATUS_mask = &H1
        if data_low > LONG_MAX then
            if LOCAL_RECEIVER_STATUS_mask = mask then
                read_LOCAL_RECEIVER_STATUS_value = data_low
            else
                read_LOCAL_RECEIVER_STATUS_value = (data_low - H8000_0000) and LOCAL_RECEIVER_STATUS_mask
            end If
        else
            read_LOCAL_RECEIVER_STATUS_value = data_low and LOCAL_RECEIVER_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_PHY_STATE = &H0 or flag_SYNCHRONIZATION_DONE = &H0 or flag_ADC_OVERFLOW = &H0 or flag_ALIGNMENT_OK = &H0 or flag_CRC_ERROR = &H0 or flag_RETRAIN = &H0 or flag_REMOTE_RECEIVER_STATUS = &H0 or flag_LOCAL_RECEIVER_STATUS = &H0 Then read
        If flag_PHY_STATE = &H0 Then write_PHY_STATE_value = get_PHY_STATE
        If flag_SYNCHRONIZATION_DONE = &H0 Then write_SYNCHRONIZATION_DONE_value = get_SYNCHRONIZATION_DONE
        If flag_ADC_OVERFLOW = &H0 Then write_ADC_OVERFLOW_value = get_ADC_OVERFLOW
        If flag_ALIGNMENT_OK = &H0 Then write_ALIGNMENT_OK_value = get_ALIGNMENT_OK
        If flag_CRC_ERROR = &H0 Then write_CRC_ERROR_value = get_CRC_ERROR
        If flag_RETRAIN = &H0 Then write_RETRAIN_value = get_RETRAIN
        If flag_REMOTE_RECEIVER_STATUS = &H0 Then write_REMOTE_RECEIVER_STATUS_value = get_REMOTE_RECEIVER_STATUS
        If flag_LOCAL_RECEIVER_STATUS = &H0 Then write_LOCAL_RECEIVER_STATUS_value = get_LOCAL_RECEIVER_STATUS

        regValue = leftShift((write_PHY_STATE_value and &Hff), 8) + leftShift((write_SYNCHRONIZATION_DONE_value and &H1), 6) + leftShift((write_ADC_OVERFLOW_value and &H1), 5) + leftShift((write_ALIGNMENT_OK_value and &H1), 4) + leftShift((write_CRC_ERROR_value and &H1), 3) + leftShift((write_RETRAIN_value and &H1), 2) + leftShift((write_REMOTE_RECEIVER_STATUS_value and &H1), 1) + leftShift((write_LOCAL_RECEIVER_STATUS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_STATE_value = rightShift(data_low, 8) and &Hff
        read_SYNCHRONIZATION_DONE_value = rightShift(data_low, 6) and &H1
        read_ADC_OVERFLOW_value = rightShift(data_low, 5) and &H1
        read_ALIGNMENT_OK_value = rightShift(data_low, 4) and &H1
        read_CRC_ERROR_value = rightShift(data_low, 3) and &H1
        read_RETRAIN_value = rightShift(data_low, 2) and &H1
        read_REMOTE_RECEIVER_STATUS_value = rightShift(data_low, 1) and &H1
        LOCAL_RECEIVER_STATUS_mask = &H1
        if data_low > LONG_MAX then
            if LOCAL_RECEIVER_STATUS_mask = mask then
                read_LOCAL_RECEIVER_STATUS_value = data_low
            else
                read_LOCAL_RECEIVER_STATUS_value = (data_low - H8000_0000) and LOCAL_RECEIVER_STATUS_mask
            end If
        else
            read_LOCAL_RECEIVER_STATUS_value = data_low and LOCAL_RECEIVER_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHY_STATE_value = &H0
        flag_PHY_STATE        = &H0
        write_SYNCHRONIZATION_DONE_value = &H0
        flag_SYNCHRONIZATION_DONE        = &H0
        write_ADC_OVERFLOW_value = &H0
        flag_ADC_OVERFLOW        = &H0
        write_ALIGNMENT_OK_value = &H0
        flag_ALIGNMENT_OK        = &H0
        write_CRC_ERROR_value = &H0
        flag_CRC_ERROR        = &H0
        write_RETRAIN_value = &H0
        flag_RETRAIN        = &H0
        write_REMOTE_RECEIVER_STATUS_value = &H0
        flag_REMOTE_RECEIVER_STATUS        = &H0
        write_LOCAL_RECEIVER_STATUS_value = &H0
        flag_LOCAL_RECEIVER_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_testability_reg_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' INTERNAL_LOOPBACK                          [14:14]          get_INTERNAL_LOOPBACK
''                                                             set_INTERNAL_LOOPBACK
''                                                             read_INTERNAL_LOOPBACK
''                                                             write_INTERNAL_LOOPBACK
''---------------------------------------------------------------------------------
'' AGC_FREEZE                                 [7:7]            get_AGC_FREEZE
''                                                             set_AGC_FREEZE
''                                                             read_AGC_FREEZE
''                                                             write_AGC_FREEZE
''---------------------------------------------------------------------------------
'' AGC_OVERRIDE_ENABLE                        [6:6]            get_AGC_OVERRIDE_ENABLE
''                                                             set_AGC_OVERRIDE_ENABLE
''                                                             read_AGC_OVERRIDE_ENABLE
''                                                             write_AGC_OVERRIDE_ENABLE
''---------------------------------------------------------------------------------
'' AGC_VALUE_OR_OVERRIDE_VALUE                [5:0]            get_AGC_VALUE_OR_OVERRIDE_VALUE
''                                                             set_AGC_VALUE_OR_OVERRIDE_VALUE
''                                                             read_AGC_VALUE_OR_OVERRIDE_VALUE
''                                                             write_AGC_VALUE_OR_OVERRIDE_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_testability_reg_c
    Private write_INTERNAL_LOOPBACK_value
    Private read_INTERNAL_LOOPBACK_value
    Private flag_INTERNAL_LOOPBACK
    Private write_AGC_FREEZE_value
    Private read_AGC_FREEZE_value
    Private flag_AGC_FREEZE
    Private write_AGC_OVERRIDE_ENABLE_value
    Private read_AGC_OVERRIDE_ENABLE_value
    Private flag_AGC_OVERRIDE_ENABLE
    Private write_AGC_VALUE_OR_OVERRIDE_VALUE_value
    Private read_AGC_VALUE_OR_OVERRIDE_VALUE_value
    Private flag_AGC_VALUE_OR_OVERRIDE_VALUE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_INTERNAL_LOOPBACK
        get_INTERNAL_LOOPBACK = read_INTERNAL_LOOPBACK_value
    End Property

    Property Let set_INTERNAL_LOOPBACK(aData)
        write_INTERNAL_LOOPBACK_value = aData
        flag_INTERNAL_LOOPBACK        = &H1
    End Property

    Property Get read_INTERNAL_LOOPBACK
        read
        read_INTERNAL_LOOPBACK = read_INTERNAL_LOOPBACK_value
    End Property

    Property Let write_INTERNAL_LOOPBACK(aData)
        set_INTERNAL_LOOPBACK = aData
        write
    End Property

    Property Get get_AGC_FREEZE
        get_AGC_FREEZE = read_AGC_FREEZE_value
    End Property

    Property Let set_AGC_FREEZE(aData)
        write_AGC_FREEZE_value = aData
        flag_AGC_FREEZE        = &H1
    End Property

    Property Get read_AGC_FREEZE
        read
        read_AGC_FREEZE = read_AGC_FREEZE_value
    End Property

    Property Let write_AGC_FREEZE(aData)
        set_AGC_FREEZE = aData
        write
    End Property

    Property Get get_AGC_OVERRIDE_ENABLE
        get_AGC_OVERRIDE_ENABLE = read_AGC_OVERRIDE_ENABLE_value
    End Property

    Property Let set_AGC_OVERRIDE_ENABLE(aData)
        write_AGC_OVERRIDE_ENABLE_value = aData
        flag_AGC_OVERRIDE_ENABLE        = &H1
    End Property

    Property Get read_AGC_OVERRIDE_ENABLE
        read
        read_AGC_OVERRIDE_ENABLE = read_AGC_OVERRIDE_ENABLE_value
    End Property

    Property Let write_AGC_OVERRIDE_ENABLE(aData)
        set_AGC_OVERRIDE_ENABLE = aData
        write
    End Property

    Property Get get_AGC_VALUE_OR_OVERRIDE_VALUE
        get_AGC_VALUE_OR_OVERRIDE_VALUE = read_AGC_VALUE_OR_OVERRIDE_VALUE_value
    End Property

    Property Let set_AGC_VALUE_OR_OVERRIDE_VALUE(aData)
        write_AGC_VALUE_OR_OVERRIDE_VALUE_value = aData
        flag_AGC_VALUE_OR_OVERRIDE_VALUE        = &H1
    End Property

    Property Get read_AGC_VALUE_OR_OVERRIDE_VALUE
        read
        read_AGC_VALUE_OR_OVERRIDE_VALUE = read_AGC_VALUE_OR_OVERRIDE_VALUE_value
    End Property

    Property Let write_AGC_VALUE_OR_OVERRIDE_VALUE(aData)
        set_AGC_VALUE_OR_OVERRIDE_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_INTERNAL_LOOPBACK_value = rightShift(data_low, 14) and &H1
        read_AGC_FREEZE_value = rightShift(data_low, 7) and &H1
        read_AGC_OVERRIDE_ENABLE_value = rightShift(data_low, 6) and &H1
        AGC_VALUE_OR_OVERRIDE_VALUE_mask = &H3f
        if data_low > LONG_MAX then
            if AGC_VALUE_OR_OVERRIDE_VALUE_mask = mask then
                read_AGC_VALUE_OR_OVERRIDE_VALUE_value = data_low
            else
                read_AGC_VALUE_OR_OVERRIDE_VALUE_value = (data_low - H8000_0000) and AGC_VALUE_OR_OVERRIDE_VALUE_mask
            end If
        else
            read_AGC_VALUE_OR_OVERRIDE_VALUE_value = data_low and AGC_VALUE_OR_OVERRIDE_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_INTERNAL_LOOPBACK = &H0 or flag_AGC_FREEZE = &H0 or flag_AGC_OVERRIDE_ENABLE = &H0 or flag_AGC_VALUE_OR_OVERRIDE_VALUE = &H0 Then read
        If flag_INTERNAL_LOOPBACK = &H0 Then write_INTERNAL_LOOPBACK_value = get_INTERNAL_LOOPBACK
        If flag_AGC_FREEZE = &H0 Then write_AGC_FREEZE_value = get_AGC_FREEZE
        If flag_AGC_OVERRIDE_ENABLE = &H0 Then write_AGC_OVERRIDE_ENABLE_value = get_AGC_OVERRIDE_ENABLE
        If flag_AGC_VALUE_OR_OVERRIDE_VALUE = &H0 Then write_AGC_VALUE_OR_OVERRIDE_VALUE_value = get_AGC_VALUE_OR_OVERRIDE_VALUE

        regValue = leftShift((write_INTERNAL_LOOPBACK_value and &H1), 14) + leftShift((write_AGC_FREEZE_value and &H1), 7) + leftShift((write_AGC_OVERRIDE_ENABLE_value and &H1), 6) + leftShift((write_AGC_VALUE_OR_OVERRIDE_VALUE_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_INTERNAL_LOOPBACK_value = rightShift(data_low, 14) and &H1
        read_AGC_FREEZE_value = rightShift(data_low, 7) and &H1
        read_AGC_OVERRIDE_ENABLE_value = rightShift(data_low, 6) and &H1
        AGC_VALUE_OR_OVERRIDE_VALUE_mask = &H3f
        if data_low > LONG_MAX then
            if AGC_VALUE_OR_OVERRIDE_VALUE_mask = mask then
                read_AGC_VALUE_OR_OVERRIDE_VALUE_value = data_low
            else
                read_AGC_VALUE_OR_OVERRIDE_VALUE_value = (data_low - H8000_0000) and AGC_VALUE_OR_OVERRIDE_VALUE_mask
            end If
        else
            read_AGC_VALUE_OR_OVERRIDE_VALUE_value = data_low and AGC_VALUE_OR_OVERRIDE_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_INTERNAL_LOOPBACK_value = &H0
        flag_INTERNAL_LOOPBACK        = &H0
        write_AGC_FREEZE_value = &H0
        flag_AGC_FREEZE        = &H0
        write_AGC_OVERRIDE_ENABLE_value = &H0
        flag_AGC_OVERRIDE_ENABLE        = &H0
        write_AGC_VALUE_OR_OVERRIDE_VALUE_value = &H0
        flag_AGC_VALUE_OR_OVERRIDE_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_number_of_corrected_packets
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NUMBER_OF_CORRECTED_RS_PACKETS             [15:0]           get_NUMBER_OF_CORRECTED_RS_PACKETS
''                                                             set_NUMBER_OF_CORRECTED_RS_PACKETS
''                                                             read_NUMBER_OF_CORRECTED_RS_PACKETS
''                                                             write_NUMBER_OF_CORRECTED_RS_PACKETS
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_number_of_corrected_packets
    Private write_NUMBER_OF_CORRECTED_RS_PACKETS_value
    Private read_NUMBER_OF_CORRECTED_RS_PACKETS_value
    Private flag_NUMBER_OF_CORRECTED_RS_PACKETS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H86
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NUMBER_OF_CORRECTED_RS_PACKETS
        get_NUMBER_OF_CORRECTED_RS_PACKETS = read_NUMBER_OF_CORRECTED_RS_PACKETS_value
    End Property

    Property Let set_NUMBER_OF_CORRECTED_RS_PACKETS(aData)
        write_NUMBER_OF_CORRECTED_RS_PACKETS_value = aData
        flag_NUMBER_OF_CORRECTED_RS_PACKETS        = &H1
    End Property

    Property Get read_NUMBER_OF_CORRECTED_RS_PACKETS
        read
        read_NUMBER_OF_CORRECTED_RS_PACKETS = read_NUMBER_OF_CORRECTED_RS_PACKETS_value
    End Property

    Property Let write_NUMBER_OF_CORRECTED_RS_PACKETS(aData)
        set_NUMBER_OF_CORRECTED_RS_PACKETS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NUMBER_OF_CORRECTED_RS_PACKETS_mask = &Hffff
        if data_low > LONG_MAX then
            if NUMBER_OF_CORRECTED_RS_PACKETS_mask = mask then
                read_NUMBER_OF_CORRECTED_RS_PACKETS_value = data_low
            else
                read_NUMBER_OF_CORRECTED_RS_PACKETS_value = (data_low - H8000_0000) and NUMBER_OF_CORRECTED_RS_PACKETS_mask
            end If
        else
            read_NUMBER_OF_CORRECTED_RS_PACKETS_value = data_low and NUMBER_OF_CORRECTED_RS_PACKETS_mask
        end If

    End Sub

    Sub write
        If flag_NUMBER_OF_CORRECTED_RS_PACKETS = &H0 Then read
        If flag_NUMBER_OF_CORRECTED_RS_PACKETS = &H0 Then write_NUMBER_OF_CORRECTED_RS_PACKETS_value = get_NUMBER_OF_CORRECTED_RS_PACKETS

        regValue = leftShift((write_NUMBER_OF_CORRECTED_RS_PACKETS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NUMBER_OF_CORRECTED_RS_PACKETS_mask = &Hffff
        if data_low > LONG_MAX then
            if NUMBER_OF_CORRECTED_RS_PACKETS_mask = mask then
                read_NUMBER_OF_CORRECTED_RS_PACKETS_value = data_low
            else
                read_NUMBER_OF_CORRECTED_RS_PACKETS_value = (data_low - H8000_0000) and NUMBER_OF_CORRECTED_RS_PACKETS_mask
            end If
        else
            read_NUMBER_OF_CORRECTED_RS_PACKETS_value = data_low and NUMBER_OF_CORRECTED_RS_PACKETS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NUMBER_OF_CORRECTED_RS_PACKETS_value = &H0
        flag_NUMBER_OF_CORRECTED_RS_PACKETS        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_freeze_counter_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_COUNTER_LSB                         [15:0]           get_FREEZE_COUNTER_LSB
''                                                             set_FREEZE_COUNTER_LSB
''                                                             read_FREEZE_COUNTER_LSB
''                                                             write_FREEZE_COUNTER_LSB
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_freeze_counter_lsb
    Private write_FREEZE_COUNTER_LSB_value
    Private read_FREEZE_COUNTER_LSB_value
    Private flag_FREEZE_COUNTER_LSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FREEZE_COUNTER_LSB
        get_FREEZE_COUNTER_LSB = read_FREEZE_COUNTER_LSB_value
    End Property

    Property Let set_FREEZE_COUNTER_LSB(aData)
        write_FREEZE_COUNTER_LSB_value = aData
        flag_FREEZE_COUNTER_LSB        = &H1
    End Property

    Property Get read_FREEZE_COUNTER_LSB
        read
        read_FREEZE_COUNTER_LSB = read_FREEZE_COUNTER_LSB_value
    End Property

    Property Let write_FREEZE_COUNTER_LSB(aData)
        set_FREEZE_COUNTER_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_LSB_mask = mask then
                read_FREEZE_COUNTER_LSB_value = data_low
            else
                read_FREEZE_COUNTER_LSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_LSB_mask
            end If
        else
            read_FREEZE_COUNTER_LSB_value = data_low and FREEZE_COUNTER_LSB_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_COUNTER_LSB = &H0 Then read
        If flag_FREEZE_COUNTER_LSB = &H0 Then write_FREEZE_COUNTER_LSB_value = get_FREEZE_COUNTER_LSB

        regValue = leftShift((write_FREEZE_COUNTER_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_LSB_mask = mask then
                read_FREEZE_COUNTER_LSB_value = data_low
            else
                read_FREEZE_COUNTER_LSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_LSB_mask
            end If
        else
            read_FREEZE_COUNTER_LSB_value = data_low and FREEZE_COUNTER_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_COUNTER_LSB_value = &H0
        flag_FREEZE_COUNTER_LSB        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_freeze_counter_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_COUNTER_MSB                         [15:0]           get_FREEZE_COUNTER_MSB
''                                                             set_FREEZE_COUNTER_MSB
''                                                             read_FREEZE_COUNTER_MSB
''                                                             write_FREEZE_COUNTER_MSB
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_freeze_counter_msb
    Private write_FREEZE_COUNTER_MSB_value
    Private read_FREEZE_COUNTER_MSB_value
    Private flag_FREEZE_COUNTER_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FREEZE_COUNTER_MSB
        get_FREEZE_COUNTER_MSB = read_FREEZE_COUNTER_MSB_value
    End Property

    Property Let set_FREEZE_COUNTER_MSB(aData)
        write_FREEZE_COUNTER_MSB_value = aData
        flag_FREEZE_COUNTER_MSB        = &H1
    End Property

    Property Get read_FREEZE_COUNTER_MSB
        read
        read_FREEZE_COUNTER_MSB = read_FREEZE_COUNTER_MSB_value
    End Property

    Property Let write_FREEZE_COUNTER_MSB(aData)
        set_FREEZE_COUNTER_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_MSB_mask = mask then
                read_FREEZE_COUNTER_MSB_value = data_low
            else
                read_FREEZE_COUNTER_MSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_MSB_mask
            end If
        else
            read_FREEZE_COUNTER_MSB_value = data_low and FREEZE_COUNTER_MSB_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_COUNTER_MSB = &H0 Then read
        If flag_FREEZE_COUNTER_MSB = &H0 Then write_FREEZE_COUNTER_MSB_value = get_FREEZE_COUNTER_MSB

        regValue = leftShift((write_FREEZE_COUNTER_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_MSB_mask = mask then
                read_FREEZE_COUNTER_MSB_value = data_low
            else
                read_FREEZE_COUNTER_MSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_MSB_mask
            end If
        else
            read_FREEZE_COUNTER_MSB_value = data_low and FREEZE_COUNTER_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_COUNTER_MSB_value = &H0
        flag_FREEZE_COUNTER_MSB        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_freeze_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_TYPE                                [2:0]            get_FREEZE_TYPE
''                                                             set_FREEZE_TYPE
''                                                             read_FREEZE_TYPE
''                                                             write_FREEZE_TYPE
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_freeze_type
    Private write_FREEZE_TYPE_value
    Private read_FREEZE_TYPE_value
    Private flag_FREEZE_TYPE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FREEZE_TYPE
        get_FREEZE_TYPE = read_FREEZE_TYPE_value
    End Property

    Property Let set_FREEZE_TYPE(aData)
        write_FREEZE_TYPE_value = aData
        flag_FREEZE_TYPE        = &H1
    End Property

    Property Get read_FREEZE_TYPE
        read
        read_FREEZE_TYPE = read_FREEZE_TYPE_value
    End Property

    Property Let write_FREEZE_TYPE(aData)
        set_FREEZE_TYPE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_TYPE_mask = &H7
        if data_low > LONG_MAX then
            if FREEZE_TYPE_mask = mask then
                read_FREEZE_TYPE_value = data_low
            else
                read_FREEZE_TYPE_value = (data_low - H8000_0000) and FREEZE_TYPE_mask
            end If
        else
            read_FREEZE_TYPE_value = data_low and FREEZE_TYPE_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_TYPE = &H0 Then read
        If flag_FREEZE_TYPE = &H0 Then write_FREEZE_TYPE_value = get_FREEZE_TYPE

        regValue = leftShift((write_FREEZE_TYPE_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_TYPE_mask = &H7
        if data_low > LONG_MAX then
            if FREEZE_TYPE_mask = mask then
                read_FREEZE_TYPE_value = data_low
            else
                read_FREEZE_TYPE_value = (data_low - H8000_0000) and FREEZE_TYPE_mask
            end If
        else
            read_FREEZE_TYPE_value = data_low and FREEZE_TYPE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_TYPE_value = &H0
        flag_FREEZE_TYPE        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_pcs_sop_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMESYNC_ENABLE                            [3:3]            get_TIMESYNC_ENABLE
''                                                             set_TIMESYNC_ENABLE
''                                                             read_TIMESYNC_ENABLE
''                                                             write_TIMESYNC_ENABLE
''---------------------------------------------------------------------------------
'' TX_SOP_SELECT                              [2:2]            get_TX_SOP_SELECT
''                                                             set_TX_SOP_SELECT
''                                                             read_TX_SOP_SELECT
''                                                             write_TX_SOP_SELECT
''---------------------------------------------------------------------------------
'' RX_SOP_SELECT                              [1:1]            get_RX_SOP_SELECT
''                                                             set_RX_SOP_SELECT
''                                                             read_RX_SOP_SELECT
''                                                             write_RX_SOP_SELECT
''---------------------------------------------------------------------------------
'' RXSOP_SFD_OPT                              [0:0]            get_RXSOP_SFD_OPT
''                                                             set_RXSOP_SFD_OPT
''                                                             read_RXSOP_SFD_OPT
''                                                             write_RXSOP_SFD_OPT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pcs_sop_control
    Private write_TIMESYNC_ENABLE_value
    Private read_TIMESYNC_ENABLE_value
    Private flag_TIMESYNC_ENABLE
    Private write_TX_SOP_SELECT_value
    Private read_TX_SOP_SELECT_value
    Private flag_TX_SOP_SELECT
    Private write_RX_SOP_SELECT_value
    Private read_RX_SOP_SELECT_value
    Private flag_RX_SOP_SELECT
    Private write_RXSOP_SFD_OPT_value
    Private read_RXSOP_SFD_OPT_value
    Private flag_RXSOP_SFD_OPT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TIMESYNC_ENABLE
        get_TIMESYNC_ENABLE = read_TIMESYNC_ENABLE_value
    End Property

    Property Let set_TIMESYNC_ENABLE(aData)
        write_TIMESYNC_ENABLE_value = aData
        flag_TIMESYNC_ENABLE        = &H1
    End Property

    Property Get read_TIMESYNC_ENABLE
        read
        read_TIMESYNC_ENABLE = read_TIMESYNC_ENABLE_value
    End Property

    Property Let write_TIMESYNC_ENABLE(aData)
        set_TIMESYNC_ENABLE = aData
        write
    End Property

    Property Get get_TX_SOP_SELECT
        get_TX_SOP_SELECT = read_TX_SOP_SELECT_value
    End Property

    Property Let set_TX_SOP_SELECT(aData)
        write_TX_SOP_SELECT_value = aData
        flag_TX_SOP_SELECT        = &H1
    End Property

    Property Get read_TX_SOP_SELECT
        read
        read_TX_SOP_SELECT = read_TX_SOP_SELECT_value
    End Property

    Property Let write_TX_SOP_SELECT(aData)
        set_TX_SOP_SELECT = aData
        write
    End Property

    Property Get get_RX_SOP_SELECT
        get_RX_SOP_SELECT = read_RX_SOP_SELECT_value
    End Property

    Property Let set_RX_SOP_SELECT(aData)
        write_RX_SOP_SELECT_value = aData
        flag_RX_SOP_SELECT        = &H1
    End Property

    Property Get read_RX_SOP_SELECT
        read
        read_RX_SOP_SELECT = read_RX_SOP_SELECT_value
    End Property

    Property Let write_RX_SOP_SELECT(aData)
        set_RX_SOP_SELECT = aData
        write
    End Property

    Property Get get_RXSOP_SFD_OPT
        get_RXSOP_SFD_OPT = read_RXSOP_SFD_OPT_value
    End Property

    Property Let set_RXSOP_SFD_OPT(aData)
        write_RXSOP_SFD_OPT_value = aData
        flag_RXSOP_SFD_OPT        = &H1
    End Property

    Property Get read_RXSOP_SFD_OPT
        read
        read_RXSOP_SFD_OPT = read_RXSOP_SFD_OPT_value
    End Property

    Property Let write_RXSOP_SFD_OPT(aData)
        set_RXSOP_SFD_OPT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TIMESYNC_ENABLE_value = rightShift(data_low, 3) and &H1
        read_TX_SOP_SELECT_value = rightShift(data_low, 2) and &H1
        read_RX_SOP_SELECT_value = rightShift(data_low, 1) and &H1
        RXSOP_SFD_OPT_mask = &H1
        if data_low > LONG_MAX then
            if RXSOP_SFD_OPT_mask = mask then
                read_RXSOP_SFD_OPT_value = data_low
            else
                read_RXSOP_SFD_OPT_value = (data_low - H8000_0000) and RXSOP_SFD_OPT_mask
            end If
        else
            read_RXSOP_SFD_OPT_value = data_low and RXSOP_SFD_OPT_mask
        end If

    End Sub

    Sub write
        If flag_TIMESYNC_ENABLE = &H0 or flag_TX_SOP_SELECT = &H0 or flag_RX_SOP_SELECT = &H0 or flag_RXSOP_SFD_OPT = &H0 Then read
        If flag_TIMESYNC_ENABLE = &H0 Then write_TIMESYNC_ENABLE_value = get_TIMESYNC_ENABLE
        If flag_TX_SOP_SELECT = &H0 Then write_TX_SOP_SELECT_value = get_TX_SOP_SELECT
        If flag_RX_SOP_SELECT = &H0 Then write_RX_SOP_SELECT_value = get_RX_SOP_SELECT
        If flag_RXSOP_SFD_OPT = &H0 Then write_RXSOP_SFD_OPT_value = get_RXSOP_SFD_OPT

        regValue = leftShift((write_TIMESYNC_ENABLE_value and &H1), 3) + leftShift((write_TX_SOP_SELECT_value and &H1), 2) + leftShift((write_RX_SOP_SELECT_value and &H1), 1) + leftShift((write_RXSOP_SFD_OPT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TIMESYNC_ENABLE_value = rightShift(data_low, 3) and &H1
        read_TX_SOP_SELECT_value = rightShift(data_low, 2) and &H1
        read_RX_SOP_SELECT_value = rightShift(data_low, 1) and &H1
        RXSOP_SFD_OPT_mask = &H1
        if data_low > LONG_MAX then
            if RXSOP_SFD_OPT_mask = mask then
                read_RXSOP_SFD_OPT_value = data_low
            else
                read_RXSOP_SFD_OPT_value = (data_low - H8000_0000) and RXSOP_SFD_OPT_mask
            end If
        else
            read_RXSOP_SFD_OPT_value = data_low and RXSOP_SFD_OPT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMESYNC_ENABLE_value = &H0
        flag_TIMESYNC_ENABLE        = &H0
        write_TX_SOP_SELECT_value = &H0
        flag_TX_SOP_SELECT        = &H0
        write_RX_SOP_SELECT_value = &H0
        flag_RX_SOP_SELECT        = &H0
        write_RXSOP_SFD_OPT_value = &H0
        flag_RXSOP_SFD_OPT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_pcs_sop_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' G_TSYNC_ERR_TX                             [1:1]            get_G_TSYNC_ERR_TX
''                                                             set_G_TSYNC_ERR_TX
''                                                             read_G_TSYNC_ERR_TX
''                                                             write_G_TSYNC_ERR_TX
''---------------------------------------------------------------------------------
'' G_TSYNC_ERR_RX                             [0:0]            get_G_TSYNC_ERR_RX
''                                                             set_G_TSYNC_ERR_RX
''                                                             read_G_TSYNC_ERR_RX
''                                                             write_G_TSYNC_ERR_RX
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_pcs_sop_status
    Private write_G_TSYNC_ERR_TX_value
    Private read_G_TSYNC_ERR_TX_value
    Private flag_G_TSYNC_ERR_TX
    Private write_G_TSYNC_ERR_RX_value
    Private read_G_TSYNC_ERR_RX_value
    Private flag_G_TSYNC_ERR_RX

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_G_TSYNC_ERR_TX
        get_G_TSYNC_ERR_TX = read_G_TSYNC_ERR_TX_value
    End Property

    Property Let set_G_TSYNC_ERR_TX(aData)
        write_G_TSYNC_ERR_TX_value = aData
        flag_G_TSYNC_ERR_TX        = &H1
    End Property

    Property Get read_G_TSYNC_ERR_TX
        read
        read_G_TSYNC_ERR_TX = read_G_TSYNC_ERR_TX_value
    End Property

    Property Let write_G_TSYNC_ERR_TX(aData)
        set_G_TSYNC_ERR_TX = aData
        write
    End Property

    Property Get get_G_TSYNC_ERR_RX
        get_G_TSYNC_ERR_RX = read_G_TSYNC_ERR_RX_value
    End Property

    Property Let set_G_TSYNC_ERR_RX(aData)
        write_G_TSYNC_ERR_RX_value = aData
        flag_G_TSYNC_ERR_RX        = &H1
    End Property

    Property Get read_G_TSYNC_ERR_RX
        read
        read_G_TSYNC_ERR_RX = read_G_TSYNC_ERR_RX_value
    End Property

    Property Let write_G_TSYNC_ERR_RX(aData)
        set_G_TSYNC_ERR_RX = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_G_TSYNC_ERR_TX_value = rightShift(data_low, 1) and &H1
        G_TSYNC_ERR_RX_mask = &H1
        if data_low > LONG_MAX then
            if G_TSYNC_ERR_RX_mask = mask then
                read_G_TSYNC_ERR_RX_value = data_low
            else
                read_G_TSYNC_ERR_RX_value = (data_low - H8000_0000) and G_TSYNC_ERR_RX_mask
            end If
        else
            read_G_TSYNC_ERR_RX_value = data_low and G_TSYNC_ERR_RX_mask
        end If

    End Sub

    Sub write
        If flag_G_TSYNC_ERR_TX = &H0 or flag_G_TSYNC_ERR_RX = &H0 Then read
        If flag_G_TSYNC_ERR_TX = &H0 Then write_G_TSYNC_ERR_TX_value = get_G_TSYNC_ERR_TX
        If flag_G_TSYNC_ERR_RX = &H0 Then write_G_TSYNC_ERR_RX_value = get_G_TSYNC_ERR_RX

        regValue = leftShift((write_G_TSYNC_ERR_TX_value and &H1), 1) + leftShift((write_G_TSYNC_ERR_RX_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_G_TSYNC_ERR_TX_value = rightShift(data_low, 1) and &H1
        G_TSYNC_ERR_RX_mask = &H1
        if data_low > LONG_MAX then
            if G_TSYNC_ERR_RX_mask = mask then
                read_G_TSYNC_ERR_RX_value = data_low
            else
                read_G_TSYNC_ERR_RX_value = (data_low - H8000_0000) and G_TSYNC_ERR_RX_mask
            end If
        else
            read_G_TSYNC_ERR_RX_value = data_low and G_TSYNC_ERR_RX_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_G_TSYNC_ERR_TX_value = &H0
        flag_G_TSYNC_ERR_TX        = &H0
        write_G_TSYNC_ERR_RX_value = &H0
        flag_G_TSYNC_ERR_RX        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_clock_gen_status3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CLOCK_GEN_STATUS_BITS                      [15:0]           get_CLOCK_GEN_STATUS_BITS
''                                                             set_CLOCK_GEN_STATUS_BITS
''                                                             read_CLOCK_GEN_STATUS_BITS
''                                                             write_CLOCK_GEN_STATUS_BITS
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_clock_gen_status3
    Private write_CLOCK_GEN_STATUS_BITS_value
    Private read_CLOCK_GEN_STATUS_BITS_value
    Private flag_CLOCK_GEN_STATUS_BITS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H92
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CLOCK_GEN_STATUS_BITS
        get_CLOCK_GEN_STATUS_BITS = read_CLOCK_GEN_STATUS_BITS_value
    End Property

    Property Let set_CLOCK_GEN_STATUS_BITS(aData)
        write_CLOCK_GEN_STATUS_BITS_value = aData
        flag_CLOCK_GEN_STATUS_BITS        = &H1
    End Property

    Property Get read_CLOCK_GEN_STATUS_BITS
        read
        read_CLOCK_GEN_STATUS_BITS = read_CLOCK_GEN_STATUS_BITS_value
    End Property

    Property Let write_CLOCK_GEN_STATUS_BITS(aData)
        set_CLOCK_GEN_STATUS_BITS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CLOCK_GEN_STATUS_BITS_mask = &Hffff
        if data_low > LONG_MAX then
            if CLOCK_GEN_STATUS_BITS_mask = mask then
                read_CLOCK_GEN_STATUS_BITS_value = data_low
            else
                read_CLOCK_GEN_STATUS_BITS_value = (data_low - H8000_0000) and CLOCK_GEN_STATUS_BITS_mask
            end If
        else
            read_CLOCK_GEN_STATUS_BITS_value = data_low and CLOCK_GEN_STATUS_BITS_mask
        end If

    End Sub

    Sub write
        If flag_CLOCK_GEN_STATUS_BITS = &H0 Then read
        If flag_CLOCK_GEN_STATUS_BITS = &H0 Then write_CLOCK_GEN_STATUS_BITS_value = get_CLOCK_GEN_STATUS_BITS

        regValue = leftShift((write_CLOCK_GEN_STATUS_BITS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CLOCK_GEN_STATUS_BITS_mask = &Hffff
        if data_low > LONG_MAX then
            if CLOCK_GEN_STATUS_BITS_mask = mask then
                read_CLOCK_GEN_STATUS_BITS_value = data_low
            else
                read_CLOCK_GEN_STATUS_BITS_value = (data_low - H8000_0000) and CLOCK_GEN_STATUS_BITS_mask
            end If
        else
            read_CLOCK_GEN_STATUS_BITS_value = data_low and CLOCK_GEN_STATUS_BITS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CLOCK_GEN_STATUS_BITS_value = &H0
        flag_CLOCK_GEN_STATUS_BITS        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_rxc_for_gtx_clk_for_burn_in_test
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PATGEN_GTX_CLK_SELECT                      [1:1]            get_PATGEN_GTX_CLK_SELECT
''                                                             set_PATGEN_GTX_CLK_SELECT
''                                                             read_PATGEN_GTX_CLK_SELECT
''                                                             write_PATGEN_GTX_CLK_SELECT
''---------------------------------------------------------------------------------
'' RFGCFBIT1                                  [0:0]            get_RFGCFBIT1
''                                                             set_RFGCFBIT1
''                                                             read_RFGCFBIT1
''                                                             write_RFGCFBIT1
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_rxc_for_gtx_clk_for_burn_in_test
    Private write_PATGEN_GTX_CLK_SELECT_value
    Private read_PATGEN_GTX_CLK_SELECT_value
    Private flag_PATGEN_GTX_CLK_SELECT
    Private write_RFGCFBIT1_value
    Private read_RFGCFBIT1_value
    Private flag_RFGCFBIT1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PATGEN_GTX_CLK_SELECT
        get_PATGEN_GTX_CLK_SELECT = read_PATGEN_GTX_CLK_SELECT_value
    End Property

    Property Let set_PATGEN_GTX_CLK_SELECT(aData)
        write_PATGEN_GTX_CLK_SELECT_value = aData
        flag_PATGEN_GTX_CLK_SELECT        = &H1
    End Property

    Property Get read_PATGEN_GTX_CLK_SELECT
        read
        read_PATGEN_GTX_CLK_SELECT = read_PATGEN_GTX_CLK_SELECT_value
    End Property

    Property Let write_PATGEN_GTX_CLK_SELECT(aData)
        set_PATGEN_GTX_CLK_SELECT = aData
        write
    End Property

    Property Get get_RFGCFBIT1
        get_RFGCFBIT1 = read_RFGCFBIT1_value
    End Property

    Property Let set_RFGCFBIT1(aData)
        write_RFGCFBIT1_value = aData
        flag_RFGCFBIT1        = &H1
    End Property

    Property Get read_RFGCFBIT1
        read
        read_RFGCFBIT1 = read_RFGCFBIT1_value
    End Property

    Property Let write_RFGCFBIT1(aData)
        set_RFGCFBIT1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PATGEN_GTX_CLK_SELECT_value = rightShift(data_low, 1) and &H1
        RFGCFBIT1_mask = &H1
        if data_low > LONG_MAX then
            if RFGCFBIT1_mask = mask then
                read_RFGCFBIT1_value = data_low
            else
                read_RFGCFBIT1_value = (data_low - H8000_0000) and RFGCFBIT1_mask
            end If
        else
            read_RFGCFBIT1_value = data_low and RFGCFBIT1_mask
        end If

    End Sub

    Sub write
        If flag_PATGEN_GTX_CLK_SELECT = &H0 or flag_RFGCFBIT1 = &H0 Then read
        If flag_PATGEN_GTX_CLK_SELECT = &H0 Then write_PATGEN_GTX_CLK_SELECT_value = get_PATGEN_GTX_CLK_SELECT
        If flag_RFGCFBIT1 = &H0 Then write_RFGCFBIT1_value = get_RFGCFBIT1

        regValue = leftShift((write_PATGEN_GTX_CLK_SELECT_value and &H1), 1) + leftShift((write_RFGCFBIT1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PATGEN_GTX_CLK_SELECT_value = rightShift(data_low, 1) and &H1
        RFGCFBIT1_mask = &H1
        if data_low > LONG_MAX then
            if RFGCFBIT1_mask = mask then
                read_RFGCFBIT1_value = data_low
            else
                read_RFGCFBIT1_value = (data_low - H8000_0000) and RFGCFBIT1_mask
            end If
        else
            read_RFGCFBIT1_value = data_low and RFGCFBIT1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PATGEN_GTX_CLK_SELECT_value = &H0
        flag_PATGEN_GTX_CLK_SELECT        = &H0
        write_RFGCFBIT1_value = &H0
        flag_RFGCFBIT1        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_hard_reset_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HARD_RESET_COUNT                           [15:0]           get_HARD_RESET_COUNT
''                                                             set_HARD_RESET_COUNT
''                                                             read_HARD_RESET_COUNT
''                                                             write_HARD_RESET_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_hard_reset_count
    Private write_HARD_RESET_COUNT_value
    Private read_HARD_RESET_COUNT_value
    Private flag_HARD_RESET_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H96
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_HARD_RESET_COUNT
        get_HARD_RESET_COUNT = read_HARD_RESET_COUNT_value
    End Property

    Property Let set_HARD_RESET_COUNT(aData)
        write_HARD_RESET_COUNT_value = aData
        flag_HARD_RESET_COUNT        = &H1
    End Property

    Property Get read_HARD_RESET_COUNT
        read
        read_HARD_RESET_COUNT = read_HARD_RESET_COUNT_value
    End Property

    Property Let write_HARD_RESET_COUNT(aData)
        set_HARD_RESET_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        HARD_RESET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if HARD_RESET_COUNT_mask = mask then
                read_HARD_RESET_COUNT_value = data_low
            else
                read_HARD_RESET_COUNT_value = (data_low - H8000_0000) and HARD_RESET_COUNT_mask
            end If
        else
            read_HARD_RESET_COUNT_value = data_low and HARD_RESET_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_HARD_RESET_COUNT = &H0 Then read
        If flag_HARD_RESET_COUNT = &H0 Then write_HARD_RESET_COUNT_value = get_HARD_RESET_COUNT

        regValue = leftShift((write_HARD_RESET_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        HARD_RESET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if HARD_RESET_COUNT_mask = mask then
                read_HARD_RESET_COUNT_value = data_low
            else
                read_HARD_RESET_COUNT_value = (data_low - H8000_0000) and HARD_RESET_COUNT_mask
            end If
        else
            read_HARD_RESET_COUNT_value = data_low and HARD_RESET_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HARD_RESET_COUNT_value = &H0
        flag_HARD_RESET_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_ieee_soft_reset_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IEEE_SOFT_RESET_COUNT                      [15:0]           get_IEEE_SOFT_RESET_COUNT
''                                                             set_IEEE_SOFT_RESET_COUNT
''                                                             read_IEEE_SOFT_RESET_COUNT
''                                                             write_IEEE_SOFT_RESET_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_ieee_soft_reset_count
    Private write_IEEE_SOFT_RESET_COUNT_value
    Private read_IEEE_SOFT_RESET_COUNT_value
    Private flag_IEEE_SOFT_RESET_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IEEE_SOFT_RESET_COUNT
        get_IEEE_SOFT_RESET_COUNT = read_IEEE_SOFT_RESET_COUNT_value
    End Property

    Property Let set_IEEE_SOFT_RESET_COUNT(aData)
        write_IEEE_SOFT_RESET_COUNT_value = aData
        flag_IEEE_SOFT_RESET_COUNT        = &H1
    End Property

    Property Get read_IEEE_SOFT_RESET_COUNT
        read
        read_IEEE_SOFT_RESET_COUNT = read_IEEE_SOFT_RESET_COUNT_value
    End Property

    Property Let write_IEEE_SOFT_RESET_COUNT(aData)
        set_IEEE_SOFT_RESET_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IEEE_SOFT_RESET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if IEEE_SOFT_RESET_COUNT_mask = mask then
                read_IEEE_SOFT_RESET_COUNT_value = data_low
            else
                read_IEEE_SOFT_RESET_COUNT_value = (data_low - H8000_0000) and IEEE_SOFT_RESET_COUNT_mask
            end If
        else
            read_IEEE_SOFT_RESET_COUNT_value = data_low and IEEE_SOFT_RESET_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_IEEE_SOFT_RESET_COUNT = &H0 Then read
        If flag_IEEE_SOFT_RESET_COUNT = &H0 Then write_IEEE_SOFT_RESET_COUNT_value = get_IEEE_SOFT_RESET_COUNT

        regValue = leftShift((write_IEEE_SOFT_RESET_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IEEE_SOFT_RESET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if IEEE_SOFT_RESET_COUNT_mask = mask then
                read_IEEE_SOFT_RESET_COUNT_value = data_low
            else
                read_IEEE_SOFT_RESET_COUNT_value = (data_low - H8000_0000) and IEEE_SOFT_RESET_COUNT_mask
            end If
        else
            read_IEEE_SOFT_RESET_COUNT_value = data_low and IEEE_SOFT_RESET_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IEEE_SOFT_RESET_COUNT_value = &H0
        flag_IEEE_SOFT_RESET_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_exp70_soft_reset_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EXP70_SOFT_RESET_COUNT                     [15:0]           get_EXP70_SOFT_RESET_COUNT
''                                                             set_EXP70_SOFT_RESET_COUNT
''                                                             read_EXP70_SOFT_RESET_COUNT
''                                                             write_EXP70_SOFT_RESET_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_exp70_soft_reset_count
    Private write_EXP70_SOFT_RESET_COUNT_value
    Private read_EXP70_SOFT_RESET_COUNT_value
    Private flag_EXP70_SOFT_RESET_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EXP70_SOFT_RESET_COUNT
        get_EXP70_SOFT_RESET_COUNT = read_EXP70_SOFT_RESET_COUNT_value
    End Property

    Property Let set_EXP70_SOFT_RESET_COUNT(aData)
        write_EXP70_SOFT_RESET_COUNT_value = aData
        flag_EXP70_SOFT_RESET_COUNT        = &H1
    End Property

    Property Get read_EXP70_SOFT_RESET_COUNT
        read
        read_EXP70_SOFT_RESET_COUNT = read_EXP70_SOFT_RESET_COUNT_value
    End Property

    Property Let write_EXP70_SOFT_RESET_COUNT(aData)
        set_EXP70_SOFT_RESET_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EXP70_SOFT_RESET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if EXP70_SOFT_RESET_COUNT_mask = mask then
                read_EXP70_SOFT_RESET_COUNT_value = data_low
            else
                read_EXP70_SOFT_RESET_COUNT_value = (data_low - H8000_0000) and EXP70_SOFT_RESET_COUNT_mask
            end If
        else
            read_EXP70_SOFT_RESET_COUNT_value = data_low and EXP70_SOFT_RESET_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_EXP70_SOFT_RESET_COUNT = &H0 Then read
        If flag_EXP70_SOFT_RESET_COUNT = &H0 Then write_EXP70_SOFT_RESET_COUNT_value = get_EXP70_SOFT_RESET_COUNT

        regValue = leftShift((write_EXP70_SOFT_RESET_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EXP70_SOFT_RESET_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if EXP70_SOFT_RESET_COUNT_mask = mask then
                read_EXP70_SOFT_RESET_COUNT_value = data_low
            else
                read_EXP70_SOFT_RESET_COUNT_value = (data_low - H8000_0000) and EXP70_SOFT_RESET_COUNT_mask
            end If
        else
            read_EXP70_SOFT_RESET_COUNT_value = data_low and EXP70_SOFT_RESET_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EXP70_SOFT_RESET_COUNT_value = &H0
        flag_EXP70_SOFT_RESET_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_safety_concept
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_DISABLE_OCCUR                           [1:1]            get_TX_DISABLE_OCCUR
''                                                             set_TX_DISABLE_OCCUR
''                                                             read_TX_DISABLE_OCCUR
''                                                             write_TX_DISABLE_OCCUR
''---------------------------------------------------------------------------------
'' SAFETY_CONCEPT_EN                          [0:0]            get_SAFETY_CONCEPT_EN
''                                                             set_SAFETY_CONCEPT_EN
''                                                             read_SAFETY_CONCEPT_EN
''                                                             write_SAFETY_CONCEPT_EN
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_safety_concept
    Private write_TX_DISABLE_OCCUR_value
    Private read_TX_DISABLE_OCCUR_value
    Private flag_TX_DISABLE_OCCUR
    Private write_SAFETY_CONCEPT_EN_value
    Private read_SAFETY_CONCEPT_EN_value
    Private flag_SAFETY_CONCEPT_EN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_DISABLE_OCCUR
        get_TX_DISABLE_OCCUR = read_TX_DISABLE_OCCUR_value
    End Property

    Property Let set_TX_DISABLE_OCCUR(aData)
        write_TX_DISABLE_OCCUR_value = aData
        flag_TX_DISABLE_OCCUR        = &H1
    End Property

    Property Get read_TX_DISABLE_OCCUR
        read
        read_TX_DISABLE_OCCUR = read_TX_DISABLE_OCCUR_value
    End Property

    Property Let write_TX_DISABLE_OCCUR(aData)
        set_TX_DISABLE_OCCUR = aData
        write
    End Property

    Property Get get_SAFETY_CONCEPT_EN
        get_SAFETY_CONCEPT_EN = read_SAFETY_CONCEPT_EN_value
    End Property

    Property Let set_SAFETY_CONCEPT_EN(aData)
        write_SAFETY_CONCEPT_EN_value = aData
        flag_SAFETY_CONCEPT_EN        = &H1
    End Property

    Property Get read_SAFETY_CONCEPT_EN
        read
        read_SAFETY_CONCEPT_EN = read_SAFETY_CONCEPT_EN_value
    End Property

    Property Let write_SAFETY_CONCEPT_EN(aData)
        set_SAFETY_CONCEPT_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_DISABLE_OCCUR_value = rightShift(data_low, 1) and &H1
        SAFETY_CONCEPT_EN_mask = &H1
        if data_low > LONG_MAX then
            if SAFETY_CONCEPT_EN_mask = mask then
                read_SAFETY_CONCEPT_EN_value = data_low
            else
                read_SAFETY_CONCEPT_EN_value = (data_low - H8000_0000) and SAFETY_CONCEPT_EN_mask
            end If
        else
            read_SAFETY_CONCEPT_EN_value = data_low and SAFETY_CONCEPT_EN_mask
        end If

    End Sub

    Sub write
        If flag_TX_DISABLE_OCCUR = &H0 or flag_SAFETY_CONCEPT_EN = &H0 Then read
        If flag_TX_DISABLE_OCCUR = &H0 Then write_TX_DISABLE_OCCUR_value = get_TX_DISABLE_OCCUR
        If flag_SAFETY_CONCEPT_EN = &H0 Then write_SAFETY_CONCEPT_EN_value = get_SAFETY_CONCEPT_EN

        regValue = leftShift((write_TX_DISABLE_OCCUR_value and &H1), 1) + leftShift((write_SAFETY_CONCEPT_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_DISABLE_OCCUR_value = rightShift(data_low, 1) and &H1
        SAFETY_CONCEPT_EN_mask = &H1
        if data_low > LONG_MAX then
            if SAFETY_CONCEPT_EN_mask = mask then
                read_SAFETY_CONCEPT_EN_value = data_low
            else
                read_SAFETY_CONCEPT_EN_value = (data_low - H8000_0000) and SAFETY_CONCEPT_EN_mask
            end If
        else
            read_SAFETY_CONCEPT_EN_value = data_low and SAFETY_CONCEPT_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_DISABLE_OCCUR_value = &H0
        flag_TX_DISABLE_OCCUR        = &H0
        write_SAFETY_CONCEPT_EN_value = &H0
        flag_SAFETY_CONCEPT_EN        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_psd_cntrl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BR_PSD_PIN_DISABLE                         [1:1]            get_BR_PSD_PIN_DISABLE
''                                                             set_BR_PSD_PIN_DISABLE
''                                                             read_BR_PSD_PIN_DISABLE
''                                                             write_BR_PSD_PIN_DISABLE
''---------------------------------------------------------------------------------
'' BR_PSD_OFF                                 [0:0]            get_BR_PSD_OFF
''                                                             set_BR_PSD_OFF
''                                                             read_BR_PSD_OFF
''                                                             write_BR_PSD_OFF
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_psd_cntrl_0
    Private write_BR_PSD_PIN_DISABLE_value
    Private read_BR_PSD_PIN_DISABLE_value
    Private flag_BR_PSD_PIN_DISABLE
    Private write_BR_PSD_OFF_value
    Private read_BR_PSD_OFF_value
    Private flag_BR_PSD_OFF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BR_PSD_PIN_DISABLE
        get_BR_PSD_PIN_DISABLE = read_BR_PSD_PIN_DISABLE_value
    End Property

    Property Let set_BR_PSD_PIN_DISABLE(aData)
        write_BR_PSD_PIN_DISABLE_value = aData
        flag_BR_PSD_PIN_DISABLE        = &H1
    End Property

    Property Get read_BR_PSD_PIN_DISABLE
        read
        read_BR_PSD_PIN_DISABLE = read_BR_PSD_PIN_DISABLE_value
    End Property

    Property Let write_BR_PSD_PIN_DISABLE(aData)
        set_BR_PSD_PIN_DISABLE = aData
        write
    End Property

    Property Get get_BR_PSD_OFF
        get_BR_PSD_OFF = read_BR_PSD_OFF_value
    End Property

    Property Let set_BR_PSD_OFF(aData)
        write_BR_PSD_OFF_value = aData
        flag_BR_PSD_OFF        = &H1
    End Property

    Property Get read_BR_PSD_OFF
        read
        read_BR_PSD_OFF = read_BR_PSD_OFF_value
    End Property

    Property Let write_BR_PSD_OFF(aData)
        set_BR_PSD_OFF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_PSD_PIN_DISABLE_value = rightShift(data_low, 1) and &H1
        BR_PSD_OFF_mask = &H1
        if data_low > LONG_MAX then
            if BR_PSD_OFF_mask = mask then
                read_BR_PSD_OFF_value = data_low
            else
                read_BR_PSD_OFF_value = (data_low - H8000_0000) and BR_PSD_OFF_mask
            end If
        else
            read_BR_PSD_OFF_value = data_low and BR_PSD_OFF_mask
        end If

    End Sub

    Sub write
        If flag_BR_PSD_PIN_DISABLE = &H0 or flag_BR_PSD_OFF = &H0 Then read
        If flag_BR_PSD_PIN_DISABLE = &H0 Then write_BR_PSD_PIN_DISABLE_value = get_BR_PSD_PIN_DISABLE
        If flag_BR_PSD_OFF = &H0 Then write_BR_PSD_OFF_value = get_BR_PSD_OFF

        regValue = leftShift((write_BR_PSD_PIN_DISABLE_value and &H1), 1) + leftShift((write_BR_PSD_OFF_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_PSD_PIN_DISABLE_value = rightShift(data_low, 1) and &H1
        BR_PSD_OFF_mask = &H1
        if data_low > LONG_MAX then
            if BR_PSD_OFF_mask = mask then
                read_BR_PSD_OFF_value = data_low
            else
                read_BR_PSD_OFF_value = (data_low - H8000_0000) and BR_PSD_OFF_mask
            end If
        else
            read_BR_PSD_OFF_value = data_low and BR_PSD_OFF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BR_PSD_PIN_DISABLE_value = &H0
        flag_BR_PSD_PIN_DISABLE        = &H0
        write_BR_PSD_OFF_value = &H0
        flag_BR_PSD_OFF        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_dsp_clk_counter_from_link_drop
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DSP_CLK_COUNTER_FROM_LINK_DROP             [7:0]            get_DSP_CLK_COUNTER_FROM_LINK_DROP
''                                                             set_DSP_CLK_COUNTER_FROM_LINK_DROP
''                                                             read_DSP_CLK_COUNTER_FROM_LINK_DROP
''                                                             write_DSP_CLK_COUNTER_FROM_LINK_DROP
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_dsp_clk_counter_from_link_drop
    Private write_DSP_CLK_COUNTER_FROM_LINK_DROP_value
    Private read_DSP_CLK_COUNTER_FROM_LINK_DROP_value
    Private flag_DSP_CLK_COUNTER_FROM_LINK_DROP

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DSP_CLK_COUNTER_FROM_LINK_DROP
        get_DSP_CLK_COUNTER_FROM_LINK_DROP = read_DSP_CLK_COUNTER_FROM_LINK_DROP_value
    End Property

    Property Let set_DSP_CLK_COUNTER_FROM_LINK_DROP(aData)
        write_DSP_CLK_COUNTER_FROM_LINK_DROP_value = aData
        flag_DSP_CLK_COUNTER_FROM_LINK_DROP        = &H1
    End Property

    Property Get read_DSP_CLK_COUNTER_FROM_LINK_DROP
        read
        read_DSP_CLK_COUNTER_FROM_LINK_DROP = read_DSP_CLK_COUNTER_FROM_LINK_DROP_value
    End Property

    Property Let write_DSP_CLK_COUNTER_FROM_LINK_DROP(aData)
        set_DSP_CLK_COUNTER_FROM_LINK_DROP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DSP_CLK_COUNTER_FROM_LINK_DROP_mask = &Hff
        if data_low > LONG_MAX then
            if DSP_CLK_COUNTER_FROM_LINK_DROP_mask = mask then
                read_DSP_CLK_COUNTER_FROM_LINK_DROP_value = data_low
            else
                read_DSP_CLK_COUNTER_FROM_LINK_DROP_value = (data_low - H8000_0000) and DSP_CLK_COUNTER_FROM_LINK_DROP_mask
            end If
        else
            read_DSP_CLK_COUNTER_FROM_LINK_DROP_value = data_low and DSP_CLK_COUNTER_FROM_LINK_DROP_mask
        end If

    End Sub

    Sub write
        If flag_DSP_CLK_COUNTER_FROM_LINK_DROP = &H0 Then read
        If flag_DSP_CLK_COUNTER_FROM_LINK_DROP = &H0 Then write_DSP_CLK_COUNTER_FROM_LINK_DROP_value = get_DSP_CLK_COUNTER_FROM_LINK_DROP

        regValue = leftShift((write_DSP_CLK_COUNTER_FROM_LINK_DROP_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DSP_CLK_COUNTER_FROM_LINK_DROP_mask = &Hff
        if data_low > LONG_MAX then
            if DSP_CLK_COUNTER_FROM_LINK_DROP_mask = mask then
                read_DSP_CLK_COUNTER_FROM_LINK_DROP_value = data_low
            else
                read_DSP_CLK_COUNTER_FROM_LINK_DROP_value = (data_low - H8000_0000) and DSP_CLK_COUNTER_FROM_LINK_DROP_mask
            end If
        else
            read_DSP_CLK_COUNTER_FROM_LINK_DROP_value = data_low and DSP_CLK_COUNTER_FROM_LINK_DROP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DSP_CLK_COUNTER_FROM_LINK_DROP_value = &H0
        flag_DSP_CLK_COUNTER_FROM_LINK_DROP        = &H0
    End Sub
End Class


'' @REGISTER : T1_CORE_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_END_ADDR                             [15:0]           get_SPARE_END_ADDR
''                                                             set_SPARE_END_ADDR
''                                                             read_SPARE_END_ADDR
''                                                             write_SPARE_END_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_T1_CORE_spare_end_addr
    Private write_SPARE_END_ADDR_value
    Private read_SPARE_END_ADDR_value
    Private flag_SPARE_END_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5fe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_END_ADDR
        get_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let set_SPARE_END_ADDR(aData)
        write_SPARE_END_ADDR_value = aData
        flag_SPARE_END_ADDR        = &H1
    End Property

    Property Get read_SPARE_END_ADDR
        read
        read_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let write_SPARE_END_ADDR(aData)
        set_SPARE_END_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_END_ADDR = &H0 Then read
        If flag_SPARE_END_ADDR = &H0 Then write_SPARE_END_ADDR_value = get_SPARE_END_ADDR

        regValue = leftShift((write_SPARE_END_ADDR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_END_ADDR_value = &H0
        flag_SPARE_END_ADDR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class T1_CORE_INSTANCE

    Public pattern_gen_control_a
    Public pattern_gen_control_b
    Public pattern_gen_status
    Public crc_error_counter
    Public packet_counter
    Public rx_clock_override_enable
    Public rx_clock_override_value
    Public clock_gen_status
    Public core_intr_status
    Public core_intr_enable
    Public tx_clock_override_enable
    Public tx_clock_override_value
    Public clock_gen_status2
    Public pattern_gen_control_c
    Public pattern_gen_control_d
    Public miififo_control
    Public testability_reg_a
    Public testability_reg_b
    Public testability_reg_c
    Public number_of_corrected_packets
    Public freeze_counter_lsb
    Public freeze_counter_msb
    Public freeze_type
    Public pcs_sop_control
    Public pcs_sop_status
    Public clock_gen_status3
    Public rxc_for_gtx_clk_for_burn_in_test
    Public hard_reset_count
    Public ieee_soft_reset_count
    Public exp70_soft_reset_count
    Public safety_concept
    Public psd_cntrl_0
    Public dsp_clk_counter_from_link_drop
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set pattern_gen_control_a = (New REGISTER_T1_CORE_pattern_gen_control_a)(aBaseAddr, 16)
        Set pattern_gen_control_b = (New REGISTER_T1_CORE_pattern_gen_control_b)(aBaseAddr, 16)
        Set pattern_gen_status = (New REGISTER_T1_CORE_pattern_gen_status)(aBaseAddr, 16)
        Set crc_error_counter = (New REGISTER_T1_CORE_crc_error_counter)(aBaseAddr, 16)
        Set packet_counter = (New REGISTER_T1_CORE_packet_counter)(aBaseAddr, 16)
        Set rx_clock_override_enable = (New REGISTER_T1_CORE_rx_clock_override_enable)(aBaseAddr, 16)
        Set rx_clock_override_value = (New REGISTER_T1_CORE_rx_clock_override_value)(aBaseAddr, 16)
        Set clock_gen_status = (New REGISTER_T1_CORE_clock_gen_status)(aBaseAddr, 16)
        Set core_intr_status = (New REGISTER_T1_CORE_core_intr_status)(aBaseAddr, 16)
        Set core_intr_enable = (New REGISTER_T1_CORE_core_intr_enable)(aBaseAddr, 16)
        Set tx_clock_override_enable = (New REGISTER_T1_CORE_tx_clock_override_enable)(aBaseAddr, 16)
        Set tx_clock_override_value = (New REGISTER_T1_CORE_tx_clock_override_value)(aBaseAddr, 16)
        Set clock_gen_status2 = (New REGISTER_T1_CORE_clock_gen_status2)(aBaseAddr, 16)
        Set pattern_gen_control_c = (New REGISTER_T1_CORE_pattern_gen_control_c)(aBaseAddr, 16)
        Set pattern_gen_control_d = (New REGISTER_T1_CORE_pattern_gen_control_d)(aBaseAddr, 16)
        Set miififo_control = (New REGISTER_T1_CORE_miififo_control)(aBaseAddr, 16)
        Set testability_reg_a = (New REGISTER_T1_CORE_testability_reg_a)(aBaseAddr, 16)
        Set testability_reg_b = (New REGISTER_T1_CORE_testability_reg_b)(aBaseAddr, 16)
        Set testability_reg_c = (New REGISTER_T1_CORE_testability_reg_c)(aBaseAddr, 16)
        Set number_of_corrected_packets = (New REGISTER_T1_CORE_number_of_corrected_packets)(aBaseAddr, 16)
        Set freeze_counter_lsb = (New REGISTER_T1_CORE_freeze_counter_lsb)(aBaseAddr, 16)
        Set freeze_counter_msb = (New REGISTER_T1_CORE_freeze_counter_msb)(aBaseAddr, 16)
        Set freeze_type = (New REGISTER_T1_CORE_freeze_type)(aBaseAddr, 16)
        Set pcs_sop_control = (New REGISTER_T1_CORE_pcs_sop_control)(aBaseAddr, 16)
        Set pcs_sop_status = (New REGISTER_T1_CORE_pcs_sop_status)(aBaseAddr, 16)
        Set clock_gen_status3 = (New REGISTER_T1_CORE_clock_gen_status3)(aBaseAddr, 16)
        Set rxc_for_gtx_clk_for_burn_in_test = (New REGISTER_T1_CORE_rxc_for_gtx_clk_for_burn_in_test)(aBaseAddr, 16)
        Set hard_reset_count = (New REGISTER_T1_CORE_hard_reset_count)(aBaseAddr, 16)
        Set ieee_soft_reset_count = (New REGISTER_T1_CORE_ieee_soft_reset_count)(aBaseAddr, 16)
        Set exp70_soft_reset_count = (New REGISTER_T1_CORE_exp70_soft_reset_count)(aBaseAddr, 16)
        Set safety_concept = (New REGISTER_T1_CORE_safety_concept)(aBaseAddr, 16)
        Set psd_cntrl_0 = (New REGISTER_T1_CORE_psd_cntrl_0)(aBaseAddr, 16)
        Set dsp_clk_counter_from_link_drop = (New REGISTER_T1_CORE_dsp_clk_counter_from_link_drop)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_T1_CORE_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set T1_CORE = CreateObject("System.Collections.ArrayList")
T1_CORE.Add ((New T1_CORE_INSTANCE)(&H49032000))


